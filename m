Return-Path: <netdev+bounces-274173-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNprNlhJzWn4bQYAu9opvQ
	(envelope-from <netdev+bounces-274173-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 18:35:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F71F37DF6A
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 18:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36DD0300F503
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 16:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB08A31E838;
	Wed,  1 Apr 2026 16:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BNE45O+3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9D03644D5
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 16:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775060462; cv=none; b=Cm8Rh6iJvMq0PchmAE3jg5kjhHhXVSqcvX2qvjP/3FIPCBQShdcyccCcuKvUrecDulgl/rr4tkGC8jqJaHhV29RMJfGCycwQBhAccSLDBmuxDOmsGJmoHyMr/qrqH5XjRYHX21GLg8MOFXswBkh1IxEl1XKfGxuFxPGVJOtHfNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775060462; c=relaxed/simple;
	bh=vqf1PiQgIrSLvLOIqCuthN86/GGCYXPRBreHnHltp80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=REbcPzipV86HYS1Okxeup1fQKXMZlcXKhXwYE0PZiY0JcVFG0XEpCzyQswGX/IOZrfqC2aQWx+zOfYK3B8XGS1Nz+D5+nvDXJQpWC88Rn6HEFBdJ+kluiR0JSsBqCXu/HXswYBIfS7eUtcFM/F1RZhU3wGrHjxKJhCqSh/BnzNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BNE45O+3; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2c160cb021cso7419164eec.1
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 09:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775060460; x=1775665260; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6brUS/+KN+QlXTcwRDDuVwUelenxIPcKdQxQmBulR1c=;
        b=BNE45O+3NVsAQGgQj1RNyaCUlBChtmDeBTLHeVtYINkc/ccArh4lb3w+uEBU5yahai
         UNh+Ndpqd9XuNVjqnqwdaq0xc3owzEU237n17YEGADTta8CUXIn4orZYlC/VrSxGpAOc
         Eh7dFf533GJO+rWiGiSInXk+Rvhn0y+ff4K/agx0KF4vqXSGo69d3Ygbv4O1AWDlZsMw
         GmTCjdKykQ7jVnwmcHACAXfMCThmI0Uc2wk1chAaWtIxoOnK2+oqHf1EwEl/7LxUjKyF
         W69NDNTHjl8nO5VW2zh4JPFrs3uOmeVM3ecRgox7fv3HLKiqQ/f5YGhEG+9a53YqUjuJ
         uBHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775060460; x=1775665260;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6brUS/+KN+QlXTcwRDDuVwUelenxIPcKdQxQmBulR1c=;
        b=HjoYfEv/wf61sH0BFKS41c51nXEQjCv/21ZUmUrN5k/+SnT6G0FFhfm7QfbJ/jTkgm
         ruCZQjq0JsVWLPCu7mogVv+4qNbRfCYk10seMthwmLR4DXXfbeI2juX6EvlsiOIdjcsS
         Ppd0/sM7B80r566K4zvU7ZQIajU6pqE3Ave09jPXPosN1s0qMXhF1TwhbICNuEvQA5z1
         7yMxSkOy4nj3WhxqFWlTdkSWhOYxwrrQn3EIkpDMorKlYQGNPuyEEXlMyPEG21Tc1krO
         qwxhFipLIF+ab/gHfMVptTVXkPI8YYFAAxCOTq3tr3/UMcwAmkreiLbWA+BMZVUuUrr1
         F6hw==
X-Forwarded-Encrypted: i=1; AJvYcCUshtP5dg0F+00+TkCAnIc47gmD+AkRj5gR8ic5H/paG0Sn6t+5NZ2RY/UI8nge4PQ8g7slKz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNbCObf/4bp7mntMfSXPlfC3GhBX2taHAiNIaIQGZozdcMuRZt
	mtS9MV4exw4IoaTmk3iItCMpktm8sCuCtuqL1/FPaH7QFLo9p+v0rCE=
X-Gm-Gg: ATEYQzx30YBg6jsBQIBYsOEkWkmGEW2gEM2UdZSUkEXyLqPPKwRAHTbwKL0sebVcPwH
	WGickeonihhhkdSprYIm3KhokBYfYg/QJ1PAjpOM17I8puHbF9zol7Re+MaxMSdbzrC/6LWNUym
	oxH8lSrfHS3JxoniGXfaHeQM1250tYhvilYLjqDK2V08qSKAyIC4cBsTr8yesWPX93b/uY07hBd
	DgoSIcvA+Co215/VkFyovbGcOKuTcBi7fvEFXmZeuV1xLwC532Jf0jeN+Pj5oW0iC0yAugEPtHc
	x6O2Mez6H6OYqGWIS1/5beEBS0kOqS4iHoMHBRqDqpskE7mt3BECYtUkRMd2payZuOPV0IsAM/+
	G80jjdCv1KW7lO4KUtUymNVCakfGg6ECKlgjxnYvxnYSbYUYcA2SLOeSS6MXEP86A+gJZdBNjqP
	HL4FaABp8XjpS2AHGEzzUNatxw2kohROMuV1Szi1jvPP8M3SUa06PptipLJGx73GP+4IEL0GcEZ
	g2tEsoWJCs6cUu59g==
X-Received: by 2002:a05:7301:4090:b0:2c1:b26:8424 with SMTP id 5a478bee46e88-2c933d8e814mr2313816eec.33.1775060459420;
        Wed, 01 Apr 2026 09:20:59 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca792f3f54sm144003eec.7.2026.04.01.09.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 09:20:59 -0700 (PDT)
Date: Wed, 1 Apr 2026 09:20:58 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
	Guillaume Nault <gnault@redhat.com>,
	David Woodhouse <dwmw@amazon.co.uk>, Kees Cook <kees@kernel.org>,
	Alexei Lazar <alazar@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Paul Moore <paul@paul-moore.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	oss-drivers@corigine.com, bridge@lists.linux.dev,
	bpf@vger.kernel.org, linux-wireless@vger.kernel.org,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	torvalds@linux-foundation.org, jon.maddog.hall@gmail.com
Subject: Re: [PATCH 6/6] net: Warn when processes listen on AF_INET sockets
Message-ID: <ac1F6hIHcoZo-soO@mini-arch>
Mail-Followup-To: Stanislav Fomichev <stfomichev@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
	Guillaume Nault <gnault@redhat.com>,
	David Woodhouse <dwmw@amazon.co.uk>, Kees Cook <kees@kernel.org>,
	Alexei Lazar <alazar@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Paul Moore <paul@paul-moore.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	oss-drivers@corigine.com, bridge@lists.linux.dev,
	bpf@vger.kernel.org, linux-wireless@vger.kernel.org,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	torvalds@linux-foundation.org, jon.maddog.hall@gmail.com
References: <20260401074509.1897527-1-dwmw2@infradead.org>
 <20260401074509.1897527-7-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260401074509.1897527-7-dwmw2@infradead.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,blackwall.org,linux.dev,iogearbox.net,gmail.com,fomichev.me,sipsolutions.net,netfilter.org,strlen.de,nwl.cc,amazon.co.uk,paul-moore.com,vger.kernel.org,corigine.com,lists.linux.dev,linux-foundation.org];
	TAGGED_FROM(0.00)[bounces-274173-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stfomichev@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[50];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 3F71F37DF6A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 04/01, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> There is no need to listen on AF_INET sockets; a modern application can
> listen on IPv6 (without IPV6_V6ONLY) and will accept connections from
> the 20th century via IPv4-mapped addresses (::ffff:x.x.x.x) on the IPv6
> socket.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>  net/ipv4/af_inet.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> index dc358faa1647..3838782a8437 100644
> --- a/net/ipv4/af_inet.c
> +++ b/net/ipv4/af_inet.c
> @@ -240,6 +240,9 @@ int inet_listen(struct socket *sock, int backlog)
>  	struct sock *sk = sock->sk;
>  	int err = -EINVAL;
>  
> +	pr_warn_once("process '%s' (pid %d) is listening on an AF_INET socket. Consider using AF_INET6 with IPV6_V6ONLY=0 instead.\n",
> +		     current->comm, task_pid_nr(current));
> +
>  	lock_sock(sk);
>  
>  	if (sock->state != SS_UNCONNECTED || sock->type != SOCK_STREAM)
> -- 
> 2.51.0
> 

Does this also need to look at the proto? inet6_stream_ops seem to be
using inet_listen as well.

const struct proto_ops inet6_stream_ops = {
        .family            = PF_INET6,
        .owner             = THIS_MODULE,
        .release           = inet6_release,
        .bind              = inet6_bind,
        .connect           = inet_stream_connect,       /* ok           */
        .socketpair        = sock_no_socketpair,        /* a do nothing */
        .accept            = inet_accept,               /* ok           */
        .getname           = inet6_getname,
        .poll              = tcp_poll,                  /* ok           */
        .ioctl             = inet6_ioctl,               /* must change  */
        .gettstamp         = sock_gettstamp,
        .listen            = inet_listen,               /* ok           */

