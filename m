Return-Path: <netdev+bounces-299937-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hHGbFW2ZMWqKnwUAu9opvQ
	(envelope-from <netdev+bounces-299937-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 20:43:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C223F69465E
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 20:43:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=d1jtgSB9;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299937-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299937-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 545BE3058091
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 18:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6012F47A0CD;
	Tue, 16 Jun 2026 18:40:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AE147CC63
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 18:40:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781635223; cv=none; b=lyqtYio9B7LgqVWb1fqJRdpCgwxRPgpLh42RDguV91/qX0Zk2WVWPX5WmwNSjDjofTNYue5E9q4n8C5Ifgo0wd+P3xFh31KhZLb52t+LhfdLy94KGMuXfTqKqgKp66/5f6KVGU3sbe+JbK6OWhcq8FjcwR462leHk1ihlH8a+a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781635223; c=relaxed/simple;
	bh=gvUO7RCQqgqX488rYJC0Dl5rmAiiSJamx6e3T6ZMGyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qy60r9anBJro8EmAtAZIZLOfN7VkDYceEfqmiz5/UNNGDol7LlEGJKNhg+SY5V606qceC3Dsu7vaf2ZbucBJdziOILuyWRtplt/Yc3s8x8VYeWtstoQU9NwC1lzqDnSeWhZXzun2wrUkeJtO9DJSSpT8ZyTu1hSxAqBOGS1p7xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d1jtgSB9; arc=none smtp.client-ip=209.85.214.180
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2c6afcc99a5so806165ad.0
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 11:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781635221; x=1782240021; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Hu5lbQqts//sz1A7GSfyJ8y1LToroYIqrwlHCW84PFk=;
        b=d1jtgSB9SilmHnKrwxzwKW1GvEKRan/tHGWDCI3ej3idAesVszb06ez7fPb43Wp953
         w6mPI/RxtxsZ19qZc84/IFGy8B3F4Tgf0fq4mB4noui0KFXxzDgN9VxLqD96SAubTjf0
         UWrmLbsqeEmdc3CcVcwGXgUtsv+WU79FPqBjgk8UT2AHnOXd5wrh+yuy7axnIM076bwA
         oqg1V00/l9pR5H2UCgRr7Wi84HP9i/z6NnSqzErcJnuMOP2t2TePZ1dvKXFBS2BgNCFG
         scXahtgZDNbo/Yr43mpNzjuy0LyEoxr7+RH3N2sT+e01Xn9iAFEwRA0MU7lCojb8ReIF
         9sVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781635221; x=1782240021;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hu5lbQqts//sz1A7GSfyJ8y1LToroYIqrwlHCW84PFk=;
        b=PC6o7R3b3pYh1zy86ZfWjR1B/9zxnZuPS7g0rRLT4wfKZu5090MO/fCkLj79nCd6U9
         2DMKwmxXULIVP/d3NiGZE8ZYg43cBWJJgB/5oEaVrS1yHefuVd8WAuy1DRKwfQ8cueiN
         lGUUVcH7Ri5gf4Mhw5Vi9D0ozClcCPPcuOIQON6JKWbDVqvrq4QOtkaILDt9C7Xg/VAU
         Om/UGXBu2RSmaHxSoaQiUG10bOiBlhHBr/BWWxbLU30Gk3+1NsC58HwupfMivwKy5O94
         7i3A9OaRsZL8xWV+MsdgWGG2stnjfowvun3alTg8tFA2Q17v4mYO7XhGtyfyXUKgBoKU
         c2fQ==
X-Forwarded-Encrypted: i=1; AFNElJ9xrM+jCgy6BcjnayYys9YNX09e9mjZNH8SSdS2O1wtCP2ydhMItV65U4nDFgYCNjxxyTJvspQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3tA7hhdrEBuNXHz1z1DdpLD2OyJ4QrMEEbIe7IKpyHtYF0WlV
	iCfVqQEzLYj89zFRxohOJN+hdPuz3LGIu8YiWjO9ujiYczr2pWbm8N6l
X-Gm-Gg: Acq92OEWrWeopYz4u2kZEQvQIGyqikrjHTkIkvM9j53RUJuO6spQLCe3f8I2yKnOhuS
	l5HDRfMpPN7ll3YK/LKsUPvkTILzaOzpnKn1b1uzQN6agqQhJ9Cx3ulWsNi9ebcbzDVTiQxBbQj
	cUVyu3EF+xW2z2E/YqFWeC/VouBXCAAOgEzvBwOlCkY4aLtnjuStVl3y/LF3sQ17pbTPOi9gGkI
	50gStbQQvoeuNa6kCU3pICGUsW0ehHDTe5PMlG210WDvFeVEorqZwMnMVK6O4WjXJuGLtq/SMzN
	ySPPogf3BfUin9wN6Y+OVQSyHOhRoAgkbDnrRL8K3K0tEqKCG1Q41uRJAd+lZVcogiImRr6FWF2
	0vUKX6zsBvnPtiMlFO/mGzGBYIMdGnTGxWgB+ayrpdSK3r2zFagYTwNuavbAaBCSLL1ipnMMZs2
	xIB9IJl+7r4L2snAnWmlIPePtgjdqMLTcSuIdSUS2WYNk3M1N32HHGjgpuCw0=
X-Received: by 2002:a17:903:38c4:b0:2bf:367b:f46f with SMTP id d9443c01a7336-2c699bc3108mr42450625ad.30.1781635221384;
        Tue, 16 Jun 2026 11:40:21 -0700 (PDT)
Received: from cps-manycore-1 ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c432c8ca31sm138912205ad.55.2026.06.16.11.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 11:40:20 -0700 (PDT)
Date: Tue, 16 Jun 2026 18:40:09 +0000
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: John Fastabend <john.fastabend@gmail.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eric Dumazet <edumazet@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf] bpf, sockmap: fix lock inversion between stab->lock
 and sk_callback_lock
Message-ID: <jxrrwhfd5igwnlo6v5y3l3grqhqqpiedfnsqzg62cmwxwaa7xd@qzthhuahjm5f>
References: <20260616091153.2966617-1-rhkrqnwk98@gmail.com>
 <575a878e-6d37-4337-a821-4883d3dd3a63@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <575a878e-6d37-4337-a821-4883d3dd3a63@linux.dev>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299937-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[rhkrqnwk98@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:jiayuan.chen@linux.dev,m:john.fastabend@gmail.com,m:jakub@cloudflare.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:edumazet@google.com,m:kuniyu@google.com,m:pabeni@redhat.com,m:willemb@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:horms@kernel.org,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,cloudflare.com,kernel.org,iogearbox.net,google.com,redhat.com,davemloft.net,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rhkrqnwk98@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,qzthhuahjm5f:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C223F69465E

On Tue, Jun 16, 2026 at 06:17:48PM +0800, Jiayuan Chen wrote:
>
>On 6/16/26 5:11 PM, Sechang Lim wrote:
>>sock_map_update_common() and __sock_map_delete() hold stab->lock and call
>>sock_map_unref() -> sock_map_del_link() under it. sock_map_del_link() takes
>>sk_callback_lock for write to stop the strparser and verdict, giving the
>>lock order stab->lock -> sk_callback_lock.
>>
>>The opposite order comes from an SK_SKB stream parser. On RX,
>>sk_psock_strp_data_ready() holds sk_callback_lock for read while running
>>the parser. The verdict redirects the skb to egress, where a sched_cls
>
>
>The commit message is wrong. A verdict does not redirect to egress
>synchronously — sk_psock_skb_redirect() only queues the skb and
>schedule_delayed_work()s sk_psock_backlog, so egress runs in workqueue
>context, not under sk_callback_lock.
>

Thanks, you're right. it's the inline ACK, not the redirect. Sorry for
the misleading changelog, I'll fix it in v2.

>
>>program calls bpf_map_delete_elem() on a sockmap, which takes stab->lock:
>>
>>   WARNING: possible circular locking dependency detected
>>   7.1.0-rc6 Not tainted
>>   ------------------------------------------------------
>>   syz.9.8824 is trying to acquire lock:
>>   (&stab->lock){+.-.}-{3:3}, at: __sock_map_delete net/core/sock_map.c:421
>>   but task is already holding lock:
>>   (clock-AF_INET){++.-}-{3:3}, at: sk_psock_strp_data_ready net/core/skmsg.c:1173
>>
>>   -> #1 (clock-AF_INET){++.-}-{3:3}:
>>          _raw_write_lock_bh
>>          sock_map_del_link net/core/sock_map.c:167
>>          sock_map_unref net/core/sock_map.c:184
>>          sock_map_update_common net/core/sock_map.c:509
>>          sock_map_update_elem_sys net/core/sock_map.c:588
>>          map_update_elem kernel/bpf/syscall.c:1805
>>
>>   -> #0 (&stab->lock){+.-.}-{3:3}:
>>          _raw_spin_lock_bh
>>          __sock_map_delete net/core/sock_map.c:421
>>          sock_map_delete_elem net/core/sock_map.c:452
>>          bpf_prog_06044d24140080b6
>>          tcx_run net/core/dev.c:4451
>>          sch_handle_egress net/core/dev.c:4541
>>          __dev_queue_xmit net/core/dev.c:4808
>>          ...
>>          tcp_bpf_strp_read_sock net/ipv4/tcp_bpf.c:701
>
>
>I guess it is an ACK. What is the actual purpose of a sched_cls 
>program calling
>
>sockmap delete on the TX path of an ACK? If there is no real use case 
>for it, this is
>
>just broken BPF usage, not a kernel bug worth this change.
>
>

I don't have a real use case for that exact program. But the verifier
allows sockmap delete from tc, and it deadlocks when the strparser's
socket is concurrently removed from the same map. The fix only moves
sock_map_unref() out from under stab->lock.

Best,
Sechang

