Return-Path: <netdev+bounces-253425-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACJYIZNId2ledwEAu9opvQ
	(envelope-from <netdev+bounces-253425-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 11:57:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E9587615
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 11:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5BD17302A57A
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 10:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E168F32F747;
	Mon, 26 Jan 2026 10:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="LMLl0CdU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01413314CB
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 10:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769424786; cv=none; b=OU0xdVqNJfAnsLMGjC/2UGIM5fmtqcNxYFAoB0slXwmdrK2sgk0DFG5O7wZiWZA9Hey7g34w+5saDC8W5z8moZWYJDw7vR/YEBIoXud1FUpJ0Gmygv8oi7Vw000D97MQ05WcpdSIZLtpqazWUvrFtJpt39CWoYronFwBPmX5GCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769424786; c=relaxed/simple;
	bh=wi91apMevgorcUoNdYgJdCJWvTz1n03aU7FKUWmZnAI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Hms4YFFeGyZ5m79AOQdj/pS8vLwaLlJBJq95O2oYi+/QjLULrnXHXmYHU3+7CB4eQMLNSzrU0DbfV8rbfE8kwp3ekNS89yVDdenXuEZeftrWb7l14aiKhUIFa+eAfmlekM75s8fn7KMBE8WAoP22fRV/FmUIX1n+ENyJrcsCJkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=LMLl0CdU; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b8871718b05so414433566b.2
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 02:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1769424783; x=1770029583; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=7HQyMiysYGwMm5ScyZuRYthPeCj1mNuauMhUi+x7J5g=;
        b=LMLl0CdUhJ43KTJp9v0VbiAarCY6oEIqZZ7jGGOZTBcXw1st3dVaauwSKXKrr2EdBn
         9SdDC3EkaSzdIi7/Y+mfMU2R9jxZmt03ate7/fn+rzq8L1RQvXDyzgSYFQb6UTQ6n3ZV
         LUsWxBW6OUNaWfKDqUs5h3JIXbNM7ppsb23vDL9snkCsnYZdknYPcvOzUtWKp2DQM7lL
         gpdwUN/cku23XlvwSiUZVCL/0mzYzKEBwgLQQUKeCg2fqPUa7gbJFwAm1pWrdbRmS47I
         jQDNbiX/DxZa4b2DlysJl6cpVdDnRLWEXiDFf3Y2DUjQc830fM7w8AnFxGOHK0jxsHlU
         Cm4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769424783; x=1770029583;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7HQyMiysYGwMm5ScyZuRYthPeCj1mNuauMhUi+x7J5g=;
        b=EL4vPg7tDqqWshtwzM5ncG4w7rMV54uIJEZ4z7et6z50q58mKbEDc9euPSGZleXXgx
         51aUT2UkbHhkuPg8CP2hwEfB+un5sRB4AH+3z9AucjcIu191E11uvNlCHhf5aBQWDqTC
         4ZPENvOjL39NlzuIxFMe6sPphnG4Vob4sPRN6nFqEDuo74IAxLSOYQ2x/WtOmIFW0MHR
         vhOYvU+Cu9tC4ykPprYnIKl803aFCMxBeGgEKg9UKKDJPJiufWzTevwyRgEYn96wYXTH
         xVX3E+R/FYVuuu/Z805P0+cTup3IVXsxF0mmPFEeJjgZOpESaRW0qNgaR4wEWC2lEf05
         69yA==
X-Forwarded-Encrypted: i=1; AJvYcCXcfQzpDdR5RxV+zQBpPJOPQR3zdkQSmSL+hjeHESg7hlQhg2KfOmQBA5kC04tHu67gX4bgLxc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQgvdUoDyBI8oA5I2JegVeTjjS1b8YL23lyWpQHIkGcbZXROv4
	i296+sKJesbRnsjxDYDhcm2a34YBUbDGayW4wPecC1/xykbHUgxE5cBWle7fIBJTQig=
X-Gm-Gg: AZuq6aKyn2ivYkAVbZASzBAvWoRkBYzewBq/tsxiIwHN+RySgJnUOCUZ0l8otkrSVmc
	gdB7dCY0VbtE2jNgPWJRXutFyVQfNnGGZsXbG46yb7ZDkf4Fz8XqA54e6cyUozw3LjG6ugfmL4p
	ga/4KRyCC+HHpT8S8oxIXDjhX9b4WOine41LqE/sxYKIrOWgSBHgWxJhkCPuTzK3FJ0Y5YjAsqu
	ckRBCjUNUxEW3/eypTa6Qzk8r7xcquqFwU8su16gq0AlsHacHehn3pGLBUnbQ3hMW+G/JJI0MLu
	jCnKbCoV0EAYjF4Z3M7VPeBlBdvEDtKpb31va+cPPnZXdy3JfySTmWpKD9YfHS/Lo6h6Q9eshNL
	2verpGoUCivYywKVnYogNxUKMz59dfjlADF77xwejr8trxJoeUmatFEsxHV1sXOEreFBEsdiO8c
	OZvTo=
X-Received: by 2002:a17:907:3cc2:b0:b86:f194:9eec with SMTP id a640c23a62f3a-b8d20b4f26emr305487166b.18.1769424782815;
        Mon, 26 Jan 2026 02:53:02 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:b1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b885b6ff080sm587357766b.38.2026.01.26.02.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 02:53:02 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org,  John Fastabend <john.fastabend@gmail.com>,  "David
 S. Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,
  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  Simon Horman <horms@kernel.org>,  Neal Cardwell <ncardwell@google.com>,
  Kuniyuki Iwashima <kuniyu@google.com>,  David Ahern <dsahern@kernel.org>,
  Andrii Nakryiko <andrii@kernel.org>,  Eduard Zingerman
 <eddyz87@gmail.com>,  Alexei Starovoitov <ast@kernel.org>,  Daniel
 Borkmann <daniel@iogearbox.net>,  Martin KaFai Lau <martin.lau@linux.dev>,
  Song Liu <song@kernel.org>,  Yonghong Song <yonghong.song@linux.dev>,  KP
 Singh <kpsingh@kernel.org>,  Stanislav Fomichev <sdf@fomichev.me>,  Hao
 Luo <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Shuah Khan
 <shuah@kernel.org>,  Michal Luczaj <mhal@rbox.co>,  Cong Wang
 <cong.wang@bytedance.com>,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v9 2/3] bpf, sockmap: Fix FIONREAD for sockmap
In-Reply-To: <20260124113314.113584-3-jiayuan.chen@linux.dev> (Jiayuan Chen's
	message of "Sat, 24 Jan 2026 19:32:44 +0800")
References: <20260124113314.113584-1-jiayuan.chen@linux.dev>
	<20260124113314.113584-3-jiayuan.chen@linux.dev>
Date: Mon, 26 Jan 2026 11:53:01 +0100
Message-ID: <87zf60sl0y.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,linux.dev,fomichev.me,rbox.co,bytedance.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-253425-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[28];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cloudflare.com:email,cloudflare.com:dkim,cloudflare.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Queue-Id: F2E9587615
X-Rspamd-Action: no action

On Sat, Jan 24, 2026 at 07:32 PM +08, Jiayuan Chen wrote:
> A socket using sockmap has its own independent receive queue: ingress_msg.
> This queue may contain data from its own protocol stack or from other
> sockets.
>
> Therefore, for sockmap, relying solely on copied_seq and rcv_nxt to
> calculate FIONREAD is not enough.
>
> This patch adds a new msg_tot_len field in the psock structure to record
> the data length in ingress_msg. Additionally, we implement new ioctl
> interfaces for TCP and UDP to intercept FIONREAD operations.
>
> Note that we intentionally do not include sk_receive_queue data in the
> FIONREAD result. Data in sk_receive_queue has not yet been processed by
> the BPF verdict program, and may be redirected to other sockets or
> dropped. Including it would create semantic ambiguity since this data
> may never be readable by the user.
>
> Unix and VSOCK sockets have similar issues, but fixing them is outside
> the scope of this patch as it would require more intrusive changes.
>
> Previous work by John Fastabend made some efforts towards FIONREAD support:
> commit e5c6de5fa025 ("bpf, sockmap: Incorrectly handling copied_seq")
> Although the current patch is based on the previous work by John Fastabend,
> it is acceptable for our Fixes tag to point to the same commit.
>
>                                                       FD1:read()
>                                                       --  FD1->copied_seq++
>                                                           |  [read data]
>                                                           |
>                                    [enqueue data]         v
>                   [sockmap]     -> ingress to self ->  ingress_msg queue
> FD1 native stack  ------>                                 ^
> -- FD1->rcv_nxt++               -> redirect to other      | [enqueue data]
>                                        |                  |
>                                        |             ingress to FD1
>                                        v                  ^
>                                       ...                 |  [sockmap]
>                                                      FD2 native stack
>
> Fixes: 04919bed948dc ("tcp: Introduce tcp_read_skb()")
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---

Thanks, Jiayuan!

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

