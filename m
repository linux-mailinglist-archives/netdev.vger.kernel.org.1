Return-Path: <netdev+bounces-286011-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SIlHMohg/mnCpwAAu9opvQ
	(envelope-from <netdev+bounces-286011-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 00:15:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 335764FC400
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 00:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7BFAB300983C
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 22:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E2138D6A9;
	Fri,  8 May 2026 22:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPo7RvLt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E34313534
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 22:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778278527; cv=none; b=XI4DMOH5X29en5JVeCvZpzYXO2LWc7KZyOzMj6RpaZDv1YYeEBTXGr4oh80+aZMO8T1/gkywrydwM4KmQahCcsXnu9moFJRreG/YBl91vtL0DY4+QHYWPt5nKjj3p6Izw3Yp1D0/IFrd6n2tvB4b2dY3CJxYKq2NvCoKOuEecCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778278527; c=relaxed/simple;
	bh=XnWDCjAfiInsPzvjgVP8ogFNBW3b+qDY5JB//KinUU4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a7hERdnzzMSsW3e51YkuzyJHvpopCGImBytDt6cNVOOZCbPT0QUULys/q84ruV8LTgR24Yg8oXgQYbmGPKhhdIG/k1NalVytZvxjOgWPj70jKY88eNhlCQuU2P4H8tuJmKxaSFAgBBaO23M81Wfbmd8iwf4fa7vWy6sF2/Lkex4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPo7RvLt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 121CEC2BCB0;
	Fri,  8 May 2026 22:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778278524;
	bh=XnWDCjAfiInsPzvjgVP8ogFNBW3b+qDY5JB//KinUU4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mPo7RvLt5x0o6lxuVNpqtUKIkzF8biG44K+pBP0rzRqzwCQRrZJpnbLSKF8ekOGgP
	 1NIt7PLieJBK7uOc0kbA9LwxqwxuoBb2/Tjm8/oztil9Ft5+AFAsTjcKPI8P0sUt6o
	 0X+VIRLtiwsbebp+Y4C8CQ5RgOdN+b7vlv+k2T0HPe3zltaic+ODtLZJKt9z/BuWPq
	 AEtbujhTbb3o4HLkxgcdk5yJ4qG4vpd6PO+VthicMqx67s4g4i5ozZsbBl62FOf+cB
	 lKviLu7FfR7EOAFcQf3y/Wwj3KqbC0ttYQ4Tq1FMk67V06a3C1c0Gk8x8QcKW6rO66
	 WmIPYqK7lG8jw==
Date: Fri, 8 May 2026 15:15:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, Simon Horman
 <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, David Ahern
 <dsahern@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 1/3] net: constify sk_skb_reason_drop() sock
 parameter
Message-ID: <20260508151523.609cadaa@kernel.org>
In-Reply-To: <20260507084305.2506115-2-edumazet@google.com>
References: <20260507084305.2506115-1-edumazet@google.com>
	<20260507084305.2506115-2-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 335764FC400
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,google.com,kernel.org,nvidia.com,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-286011-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Thu,  7 May 2026 08:43:03 +0000 Eric Dumazet wrote:
>  	TP_PROTO(struct sk_buff *skb, void *location,
> -		 enum skb_drop_reason reason, struct sock *rx_sk),
> +		 enum skb_drop_reason reason, const struct sock *rx_sk),

build says drop_monitor registers for this tracepoint from within 
the kernel, and needs adjusting.

