Return-Path: <netdev+bounces-300219-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Q0NZNAbUMmrL5wUAu9opvQ
	(envelope-from <netdev+bounces-300219-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 19:06:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A17069B930
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 19:06:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Xwyo2Y0Q;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300219-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300219-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 305C3300D6BF
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 17:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9F040B6F9;
	Wed, 17 Jun 2026 17:00:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB1C2D73A0
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 16:59:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781715600; cv=none; b=thRgR2GC609KGGnhhdNfdlyVrQNHwLmZUjRTaUn6P026B4Ws8QKzOQjcN/H5ean6TszMAGla+6NdBFfdIyVJAcFsEqAYOADQhV4w0X3cTIZylmy1zDLMhzyjIPVoPXI2raZHKKWh0JpKM679a0NSiju5i+cj/pxJM+XMMuV/7yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781715600; c=relaxed/simple;
	bh=DfUYYXsYVolkJOBGDsoGOjjsVrZ/w3lSidfgtX590a8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PMHiovhISYWR70Z05rpEwabKhE/y7mU03rMQfSRg5EdDDrFBURF01jeve6peVjHQKandkZ2vWw/e/EmllukTcVx5nqqVuPODDMWPN3KiU7JywcaC0XyxLMJG+Pi7eAM3DEO9+D2bnYH3ZWD27r2sYnoPHZOIN38sy+EgIHeaKmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xwyo2Y0Q; arc=none smtp.client-ip=209.85.214.176
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2c40397e746so192265ad.3
        for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 09:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781715595; x=1782320395; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ogqM/2AGOpqB9kKy+zSsCvIh6NVF0zsFKZ/hRLV4TB8=;
        b=Xwyo2Y0QSZCzv5rsHBEzxkhgMOR2t/M/S9tpMHe/j29o6SZy7DT+cUD4kTo5IJI8sH
         LI+wNfdn4iP1Xu/fPPAS4TxGOdbLGluJXKiHNPa5Ah6XTUiEjNq4mbURsLg9hVDcYuj3
         dNBz9fDCuAe8uKuqtD9o0+rGY7rgGgiFzqzrjkeeAFUXr+3sJzx/80Uvaeo9XOPcTptS
         zVVHh3rrjsB4HNnJTWCmt+B5r4cgCg1pIZceVrykSQJu9oWGNZfZZOSmlxonmE193bqV
         JOhia3gCSL9B5UTPTXBlqDn6RJzO+XdRkBn81EcPdjkJaqW8inmD7TUfI65pLW4G+Aus
         u8nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781715595; x=1782320395;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ogqM/2AGOpqB9kKy+zSsCvIh6NVF0zsFKZ/hRLV4TB8=;
        b=bXeQ0UB5JHtH1o5g9948/ehrhkVH1nZ3iyb9rTekqiZcBScogYTuYjmu3MB/3ilXSc
         z17ycUfD9T9n39LmRaXzkqqzwrcIbKT47SEWtfNPlTYWdaWI9bZ9JYA4UwMs48olfBLu
         dv8kwJiO0C4nNQPMCuIagvSbA54eZxbqGjkEAiJ1MgyeqwRb2QIHVOaqspkcJOfaa4eF
         KY4xkE82vOaLWPqo3CUjy4KLPBl1dOvstFgbwRQe5BEdzhVGCAFs+tCzi7EzbkNXgeCH
         lMXkw/U1u3DPDSofk4hdHZ4T0vYwIhKVBxX+Fjo1EJGvR4p2QJV1BY0q63FGUUXI1zqd
         GZrw==
X-Forwarded-Encrypted: i=1; AFNElJ9tZvFbaIi87ZUHCdXIpyAromclt2g4F2h+s30GlqUIlWMGTlT940iBUOnnrYtpDp3p/uZeR2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGcjM5vAscOZDuJaGk3BAS8uOmR9PUtxj9AaXyWexWrH85RuSG
	+BCYjkIVR1aE16eeGNOE1AFuWis4hDp7QekOvTvfuKjs2s62Fsj4YsKe
X-Gm-Gg: AfdE7ckluj3Bg0CNIIanViLbVZHdzRm5PVutXnWtlNvCAm4P0BOJ0G6dro0rUfS4AaS
	dyyonTVZSMcbmWYlGyyM6bKukge5C44ZoIG9SYfzxbMaRrSurfnpieDU5oQSHYc35cmr5iSP7ye
	rNmEy4UC+iA+kjlmcT02PeI1rN0cES8Y42EPimoX0FALlXdppieYSm5bgynC7zJgYi97O3Rm2E+
	TKg5eKL94MAQj/XmUkE9+PFRuqa/DUu1oIJKJUeBpPfDMcHouB3e4GnF1ifMoVa5DDiLRlQ1aLX
	Lq61jabnus6bFUHj2qNFnnmjM/pF8CF/mZ8ZNfNk/peZs7ID6jsNY0NfZHlpI0qmKvlHnttSoUZ
	CUmRn8GR0+3B+7vXeN3SKs8JJdXSSUYl7iXjEUg33qBwNz5BaeP57T0iwfuAI1QEdQuFk5hI1Dg
	nFMV/YaS3yNXs9In2S5Zqv
X-Received: by 2002:a17:903:1987:b0:2bf:1e37:a2ff with SMTP id d9443c01a7336-2c6bbc9d303mr45282205ad.0.1781715595387;
        Wed, 17 Jun 2026 09:59:55 -0700 (PDT)
Received: from john-p8 ([98.97.43.63])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c432c8c1f9sm173853505ad.59.2026.06.17.09.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 09:59:54 -0700 (PDT)
Date: Wed, 17 Jun 2026 09:59:52 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Sechang Lim <rhkrqnwk98@gmail.com>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, 
	Jakub Sitnicki <jakub@cloudflare.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eric Dumazet <edumazet@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf] bpf, sockmap: fix lock inversion between stab->lock
 and sk_callback_lock
Message-ID: <ajLR9CRn6O27Ound@john-p8>
References: <20260616091153.2966617-1-rhkrqnwk98@gmail.com>
 <575a878e-6d37-4337-a821-4883d3dd3a63@linux.dev>
 <jxrrwhfd5igwnlo6v5y3l3grqhqqpiedfnsqzg62cmwxwaa7xd@qzthhuahjm5f>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <jxrrwhfd5igwnlo6v5y3l3grqhqqpiedfnsqzg62cmwxwaa7xd@qzthhuahjm5f>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rhkrqnwk98@gmail.com,m:jiayuan.chen@linux.dev,m:jakub@cloudflare.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:edumazet@google.com,m:kuniyu@google.com,m:pabeni@redhat.com,m:willemb@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:horms@kernel.org,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[johnfastabend@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-300219-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johnfastabend@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2A17069B930

On Tue, Jun 16, 2026 at 06:40:09PM +0000, Sechang Lim wrote:
>On Tue, Jun 16, 2026 at 06:17:48PM +0800, Jiayuan Chen wrote:
>>
>>On 6/16/26 5:11 PM, Sechang Lim wrote:
>>>sock_map_update_common() and __sock_map_delete() hold stab->lock and call
>>>sock_map_unref() -> sock_map_del_link() under it. sock_map_del_link() takes
>>>sk_callback_lock for write to stop the strparser and verdict, giving the
>>>lock order stab->lock -> sk_callback_lock.
>>>
>>>The opposite order comes from an SK_SKB stream parser. On RX,
>>>sk_psock_strp_data_ready() holds sk_callback_lock for read while running
>>>the parser. The verdict redirects the skb to egress, where a sched_cls
>>
>>
>>The commit message is wrong. A verdict does not redirect to egress
>>synchronously — sk_psock_skb_redirect() only queues the skb and
>>schedule_delayed_work()s sk_psock_backlog, so egress runs in workqueue
>>context, not under sk_callback_lock.
>>
>
>Thanks, you're right. it's the inline ACK, not the redirect. Sorry for
>the misleading changelog, I'll fix it in v2.
>
>>
>>>program calls bpf_map_delete_elem() on a sockmap, which takes stab->lock:
>>>
>>>  WARNING: possible circular locking dependency detected
>>>  7.1.0-rc6 Not tainted
>>>  ------------------------------------------------------
>>>  syz.9.8824 is trying to acquire lock:
>>>  (&stab->lock){+.-.}-{3:3}, at: __sock_map_delete net/core/sock_map.c:421
>>>  but task is already holding lock:
>>>  (clock-AF_INET){++.-}-{3:3}, at: sk_psock_strp_data_ready net/core/skmsg.c:1173
>>>
>>>  -> #1 (clock-AF_INET){++.-}-{3:3}:
>>>         _raw_write_lock_bh
>>>         sock_map_del_link net/core/sock_map.c:167
>>>         sock_map_unref net/core/sock_map.c:184
>>>         sock_map_update_common net/core/sock_map.c:509
>>>         sock_map_update_elem_sys net/core/sock_map.c:588
>>>         map_update_elem kernel/bpf/syscall.c:1805
>>>
>>>  -> #0 (&stab->lock){+.-.}-{3:3}:
>>>         _raw_spin_lock_bh
>>>         __sock_map_delete net/core/sock_map.c:421
>>>         sock_map_delete_elem net/core/sock_map.c:452
>>>         bpf_prog_06044d24140080b6
>>>         tcx_run net/core/dev.c:4451
>>>         sch_handle_egress net/core/dev.c:4541
>>>         __dev_queue_xmit net/core/dev.c:4808
>>>         ...
>>>         tcp_bpf_strp_read_sock net/ipv4/tcp_bpf.c:701
>>
>>
>>I guess it is an ACK. What is the actual purpose of a sched_cls 
>>program calling
>>
>>sockmap delete on the TX path of an ACK? If there is no real use 
>>case for it, this is
>>
>>just broken BPF usage, not a kernel bug worth this change.
>>
>>
>
>I don't have a real use case for that exact program. But the verifier
>allows sockmap delete from tc, and it deadlocks when the strparser's
>socket is concurrently removed from the same map. The fix only moves
>sock_map_unref() out from under stab->lock.
>
>Best,
>Sechang

The bot also thinks it found another locking issue. I'm not sure
supporting 'tc' is really needed here. sockmap is much more easy
to reason about from socket layer. What about just blocking sockmap
manipulations from these prog types.

My current thinking on sockmap at the moment is its has sprawled
across so many layers the locking is overly tricky to reason about.

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d9bdc3b32c05..5e08d3e03453 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8567,11 +8567,7 @@ static bool may_update_sockmap(struct bpf_verifier_env *env, int func_id)
                         return true;
                 break;
         case BPF_PROG_TYPE_SOCKET_FILTER:
-       case BPF_PROG_TYPE_SCHED_CLS:
-       case BPF_PROG_TYPE_SCHED_ACT:
-       case BPF_PROG_TYPE_XDP:
         case BPF_PROG_TYPE_SK_REUSEPORT:
-       case BPF_PROG_TYPE_FLOW_DISSECTOR:
         case BPF_PROG_TYPE_SK_LOOKUP:
                 return true;
	default:

