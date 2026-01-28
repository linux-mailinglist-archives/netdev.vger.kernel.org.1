Return-Path: <netdev+bounces-254241-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GWfH04Demku1gEAu9opvQ
	(envelope-from <netdev+bounces-254241-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 13:38:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C33F9A1593
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 13:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2040B3055E7C
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 12:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A2734F468;
	Wed, 28 Jan 2026 12:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/cCCv2F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE92634EF1E
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 12:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769603750; cv=none; b=gkV/uOKbGT++EDnbEbhaUFru/Xdvkgsof0eCg/xK2Y/6OKyewk/HNu/8JSnay8Smc0vrdEqHJMFtRNIgAoxkTdNjRMcIlg+xvjY5+wBgyFS8up0gWNyr/WWHxAbuqEY5LB/n4YbROQfIL1ycmzqwMxYb1oxfQmQWvMjwhcJnC/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769603750; c=relaxed/simple;
	bh=2hB3mxmxd1PJsgoUfw0PYv8ForcxzI42wf0pNXzt5JQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hjzfq3C6UZQX3jchZ8JAWcWAuNxkKVhBcxBUk48BsTCrNhROslXRSR814Pszkw9DznL+tPfYtpCkCvmZsUHajnBLM3q/YHfByXQdv8cRkNmyympiPCeAq3k2XOA/FQ7mpifSWDD3bmB7ICFeXnecG0AKH8NEAJt91gJxvXgu2P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E/cCCv2F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC8BC116C6;
	Wed, 28 Jan 2026 12:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769603750;
	bh=2hB3mxmxd1PJsgoUfw0PYv8ForcxzI42wf0pNXzt5JQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E/cCCv2F7IVATYMpVDys0ekpoa90PuotWl79Y5+Nkd2vdQY1Qjgg2AKdUbkqDFzqR
	 eAZx+jd82qWzoGzRde4dt49gJJBd/O96OUiqMrRIASu5w/oSLbC5ckic3dOgcA3FYk
	 1QyfW/F5siqVLktTHUaEUP/olmaV0rZxOtEyRLoZhbV78M8wnq028i9htqRLqaaycC
	 nSYYIqP9Pk6uwCEgNX1ZatKXNRIAFLh909fm8o0V1ZSQZAzfzRwm/tg1hnhC9cSZHY
	 4/lEqMrsa4oscEmkoVrlJP8cuSmzoE9cjsMbhx/GufKLM8WXLr504p9EQ1Cy4DjJwm
	 ka8oPv5OGkW5g==
Date: Wed, 28 Jan 2026 14:35:46 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Ilan Tayari <ilant@mellanox.com>,
	Guy Shapiro <guysh@mellanox.com>,
	Yossi Kuperman <yossiku@mellanox.com>,
	Network Development <netdev@vger.kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: Re: [PATCH net] xfrm: always flush state and policy upon
 NETDEV_DOWN/NETDEV_UNREGISTER events
Message-ID: <20260128123546.GC40916@unreal>
References: <1de734e2-1da6-4b5c-8e03-66af7f88d074@I-love.SAKURA.ne.jp>
 <20260128102404.GC12149@unreal>
 <83d06aca-4437-4d61-9c99-ac19b797a243@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83d06aca-4437-4d61-9c99-ac19b797a243@I-love.SAKURA.ne.jp>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254241-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C33F9A1593
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 07:44:02PM +0900, Tetsuo Handa wrote:
> On 2026/01/28 19:24, Leon Romanovsky wrote:
> > I think this can work, but IMHO the more robust approach is to ensure that all
> > states and policies are removed when the NETIF_F_HW_ESP feature bit is cleared.
> 
> The transaction will become complicated, for dev->features manipulation
> function can fail.

Line above returning NOTIFY_OK, check that NETIF_F_HW_ESP is cleared,
and remove everything.

> 
> > 
> > Would it be possible to handle this in NETDEV_FEAT_CHANGE?
> > 
> 
> Is there a guarantee that xfrm_dev_event(NETDEV_FEAT_CHANGE) is called
> regardless of other callback functions, for it can return NOTIFY_BAD ?

I don't know.

Thanks

> 
> 

