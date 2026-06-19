Return-Path: <netdev+bounces-300765-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VNNgGdG6NWq73gYAu9opvQ
	(envelope-from <netdev+bounces-300765-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 23:55:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DA56A7D4B
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 23:55:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=P5qtjfBr;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300765-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300765-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6195430055F3
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 21:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732763B14BF;
	Fri, 19 Jun 2026 21:55:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B84B3644CF
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 21:55:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781906122; cv=none; b=QZDs+hgd3VwsLmUXihVulhjblBzES9GZD/fDvC/LLAmMb8Rm1k64q1XlVyl4CFzQb3ToodS5D6QAqru2yd9ZJsKAzylN4krhO6s0VymECh/3sKJDYw6izAbuqL1EXuaCRpzkdqAbLL3OvzMrwQbcpdwDaLeZYflPIHTdF1cyPgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781906122; c=relaxed/simple;
	bh=1TBT000VZsjsrh2eGBT6mjiiO1fTUs34DeS+O0xeYrQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=jubo+eKIeGte60OGQ0fxhBcfpJURGvCcykFyUG714n1pdqyxvchnWS7atnSh4MP1PHCRtw6KMyCqDpwOwT4MQdme2DFZo5gG2OJ1ZlolW+7u72SVEPh4hufWsYQeEB3UPi/3tm53+RvEycKBRTX8dP3qOyrZ4aFvi9QVAGFewe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P5qtjfBr; arc=none smtp.client-ip=209.85.210.50
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7e6cfdc92bfso898702a34.2
        for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 14:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781906120; x=1782510920; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1D3cBmNu4YFH8WjCxOSV1D9t43oN1k/1HHsWttX0H6M=;
        b=P5qtjfBrJEYGa3WsF0ZfelJ6Urg50+QFj39AUSfTWfUoGuCBRxJsMtGMJZRmet4ODK
         a066sxrmhNEl71PCuV6g2koK5CQmLxW2KwFs3No9k2LpJi8Eo1SITjwb0I/iSVMDymCL
         PLToqUI5rpF2lzlLakExkaMXbUNoLQxTice5RMRsU73OIf0IpYU+IXmXOaWY/m0i3SB0
         qvrWch4r+0/wNgbHSXDv9koe4DjjF8YaeMJwwEGerXTryRhB6D3Z5WGlPLKbz9hceqPM
         bj/pMbA2roCYPN0EgM6Gj+xkCrVc8iVBYIN6xfoyj75dzGj/Qh80fjwki9ftaS2wNVsy
         FrrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781906120; x=1782510920;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1D3cBmNu4YFH8WjCxOSV1D9t43oN1k/1HHsWttX0H6M=;
        b=gxBjVx6XQe3vYIaaJT4IGnL5Q2BI7IFvK8viXfNH8ND6nW4SNG2xYA9iCfc3itiIwj
         pGuS/433f/IcrprFRNX5xw2Pf3lyS65MPzTp6cEvXzKXeHaXBiI8yyXg8f+EjhrUGQYa
         JWAxh+B1eoQNHPIdXU7PLJbZxjGWzwWHNmj6vfc0qqXaPwwS9ehnCmsM3VA4frRSt728
         mqNzaiyna/bx3eTuz7AFl0vTxDDZo5BRdmFFkTkt8EC+gxc+Wuww7xazbDWPJUP4R5h2
         aMMagerkCvEZpsVcOryIdn/Y3tG+PPJpV20DkrGYBwBpdN4yViATvbWODYcq1mILffP4
         hTfw==
X-Forwarded-Encrypted: i=1; AFNElJ/tKcWGwjzabZpre948Lp7UuonW7x+I6XDLJAUZ2TU15i14aVy8dXQfKHgeHx14jJbmK1+QHwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE53M7z/+PWQwCFvIsuAzSKs5xTjUV3tUm8EryyRdNFGVg+maq
	/MtAbMQu7FDEdDu3v3JIayqjgpXP8DLW69xkXyrB4tHhUOuebfw783twSqGBhQ==
X-Gm-Gg: AfdE7cnw3s0CJaX1h303XCZKCwAKnlkiKQNS0+FKxyxmhhpSzM8KCZDl19weyyZRV72
	aNBKHtW1rYEjvx56k8UwB0ortWGSJhUFw72R3112mwEj71rVkCsBkrI9bRLaO6SlCoxYx4zfNRX
	C37NI3lWco01BIlQCV+8SoDvQ0yE6XG6gAT3exYRU33JFcKVEw5oGu6NxGNcfvNNWrVyjsvUwzW
	baFSCTKj0Zqq/zvFcnnEo5xdILpyHDdyD4G+Bmv/jfUREgvoxO7oE3PFrJtgfcO2kYtlTnmn6VX
	nCmnN6sT/vrPPbc1OBoQOkssv8QAYtGkfL6F4f0tt//+p7qA/RP2mazmk4lbhEeBz0JVGHAlajd
	tzQufvZaf5TBID1YJsH7LdGsSvJsDtX0QKSOtZ2E/lfedkV3gkAVvy9hDwfsIA9niXyPPXOj0bJ
	k4BNwVg2ZtaxcwDNmy/wLQDO8/gFU6YV7L9yMauWk8cRP6kjLeDZ1iP8SiDDOQZuLBd3i3jsuNj
	Bd2VOY=
X-Received: by 2002:a05:6830:620b:b0:7e6:cec2:a4a5 with SMTP id 46e09a7af769-7e92d8aec54mr4035312a34.20.1781906120073;
        Fri, 19 Jun 2026 14:55:20 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:47::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e94424ca09sm293111a34.16.2026.06.19.14.55.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2026 14:55:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 19 Jun 2026 14:55:18 -0700
Message-Id: <DJDD01YMA1GE.3G7B4LE5H780G@gmail.com>
To: "John Fastabend" <john.fastabend@gmail.com>, "Sechang Lim"
 <rhkrqnwk98@gmail.com>
Cc: "Jiayuan Chen" <jiayuan.chen@linux.dev>, "Jakub Sitnicki"
 <jakub@cloudflare.com>, "Alexei Starovoitov" <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Eric Dumazet" <edumazet@google.com>,
 "Kuniyuki Iwashima" <kuniyu@google.com>, "Paolo Abeni" <pabeni@redhat.com>,
 "Willem de Bruijn" <willemb@google.com>, "David S . Miller"
 <davem@davemloft.net>, "Jakub Kicinski" <kuba@kernel.org>, "Simon Horman"
 <horms@kernel.org>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf] bpf, sockmap: fix lock inversion between stab->lock
 and sk_callback_lock
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
X-Mailer: aerc
References: <20260616091153.2966617-1-rhkrqnwk98@gmail.com>
 <575a878e-6d37-4337-a821-4883d3dd3a63@linux.dev>
 <jxrrwhfd5igwnlo6v5y3l3grqhqqpiedfnsqzg62cmwxwaa7xd@qzthhuahjm5f>
 <ajLR9CRn6O27Ound@john-p8>
In-Reply-To: <ajLR9CRn6O27Ound@john-p8>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.15 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300765-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS(0.00)[m:john.fastabend@gmail.com,m:rhkrqnwk98@gmail.com,m:jiayuan.chen@linux.dev,m:jakub@cloudflare.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:edumazet@google.com,m:kuniyu@google.com,m:pabeni@redhat.com,m:willemb@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:horms@kernel.org,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 55DA56A7D4B

On Wed Jun 17, 2026 at 9:59 AM PDT, John Fastabend wrote:
>
> The bot also thinks it found another locking issue. I'm not sure
> supporting 'tc' is really needed here. sockmap is much more easy
> to reason about from socket layer. What about just blocking sockmap
> manipulations from these prog types.
>
> My current thinking on sockmap at the moment is its has sprawled
> across so many layers the locking is overly tricky to reason about.
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d9bdc3b32c05..5e08d3e03453 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -8567,11 +8567,7 @@ static bool may_update_sockmap(struct bpf_verifier=
_env *env, int func_id)
>                          return true;
>                  break;
>          case BPF_PROG_TYPE_SOCKET_FILTER:
> -       case BPF_PROG_TYPE_SCHED_CLS:
> -       case BPF_PROG_TYPE_SCHED_ACT:
> -       case BPF_PROG_TYPE_XDP:
>          case BPF_PROG_TYPE_SK_REUSEPORT:
> -       case BPF_PROG_TYPE_FLOW_DISSECTOR:
>          case BPF_PROG_TYPE_SK_LOOKUP:
>                  return true;

+1. Let's disable.

