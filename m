Return-Path: <netdev+bounces-267252-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4N/3Bh5js2lcVgAAu9opvQ
	(envelope-from <netdev+bounces-267252-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 02:06:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6FF27C2AA
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 02:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91D1630F4A30
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 01:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9BA286410;
	Fri, 13 Mar 2026 01:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PMPP2EuX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC05E2571B8
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 01:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773363857; cv=none; b=bnsNFVk505KZd40icX418uGvnfVLTNXEqFvJalSIkQQvRk887IRIDjSOrb5djZAYwiopoTrgmCKqV5qXKiCUHRvsHMJJJHYOGS063/llAtur++jrrAZpoQIgvDlouIoGPIWViCgTLVxGFTE2FrdmnsXUWYF5B84id5pUTQECsB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773363857; c=relaxed/simple;
	bh=TFLKTcSbAY+YGO1CvMB8s2NoY8AR9gmoCY2cHMTj9iM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PFUcuXrRtyZLCDGUbtwxzl0zyQkWk/9eVcyG12UDXTV9sooZ5EfuabgcbNAF2mkwjJJKsDUx9R7Pr0aQWfg4ZsZk/TJDLxgSJgw9WDiq3nkJhrAOnPnrMSQeQEoZfxaGQFk+t43xGzTAiKxzbnXCeqGWGziu6OLwL025LqDeH70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PMPP2EuX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14ABCC4CEF7;
	Fri, 13 Mar 2026 01:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773363856;
	bh=TFLKTcSbAY+YGO1CvMB8s2NoY8AR9gmoCY2cHMTj9iM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PMPP2EuXpflqp3hZCfWW4ZFUNXi9wvKoYC/Iva5obBVFGgll6ZZkeBdUSHgl5NjdB
	 Dl0jexFaZuUrORMGHEZrh9Wu8jpPQPrj6RbWGHEyG9TfipD2zOJTBqEFYat6bkM0r1
	 HmDYfASuv5+oznYwN0TBHIIwobKfU3UnbTb/Sh+fak+rwyWkJqE1bpGk698iq/MGVX
	 XOK/xfdS2eN55qNUP6+a6oHm+pIdbz3fh7OKQCpIBKwkod7i9wPBlXXBp5Wb1G/Bee
	 74MBEXe4qv7gsqJYcCZuQqhH90t8nl3Np0uVWfyrgFV0xESjVVEnG/3NMQnlYHW5Rt
	 4xGgEpaz3ED/A==
Date: Thu, 12 Mar 2026 18:04:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Florian Westphal <fw@strlen.de>, Kuniyuki Iwashima
 <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v3 net-next 07/15] udp: Remove partial csum code in RX.
Message-ID: <20260312180415.1e44a111@kernel.org>
In-Reply-To: <20260311052020.1213705-8-kuniyu@google.com>
References: <20260311052020.1213705-1-kuniyu@google.com>
	<20260311052020.1213705-8-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,kernel.org,davemloft.net,redhat.com,strlen.de,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-267252-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6E6FF27C2AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 11 Mar 2026 05:19:54 +0000 Kuniyuki Iwashima wrote:
> UDP-Lite supports the partial checksum and the coverage is
> stored in the position of the length field of struct udphdr.
> 
> In RX paths, udp4_csum_init() / udp6_csum_init() save the value
> in UDP_SKB_CB(skb)->cscov and set UDP_SKB_CB(skb)->partial_cov
> to 1 if the coverage is not full.
> 
> The subsequent processing diverges depending on the value,
> but such paths are now dead.
> 
> Also, these functions have some code guarded for UDP:
> 
>   * udp_unicast_rcv_skb / udp6_unicast_rcv_skb
>   * __udp4_lib_rcv() and __udp6_lib_rcv().
> 
> Let's remove the partial csum code and the unnecessary
> guard for UDP-Lite in RX.

Hi Willem, this lost your ack due to a bug fix, could you re-review?

