Return-Path: <netdev+bounces-234545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85855C22D95
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 02:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2214F3B4346
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 01:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE18220F2A;
	Fri, 31 Oct 2025 01:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SOpUM/kd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FFF21D3CD
	for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 01:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761873199; cv=none; b=X7wQjFJybGyv/+RaR0faL426XmXHKgGHlJ4RBeHN+fKD0teYYYcbCuwx3JJvPCu8xPEE4VvuR6YcDaJWzMyHFLrFp8FTHjO7f26BB6F/Ur4zEDoTmN/BFYJviqiKKJRJcbjrI6EHjD6SULRjDuD2vdxqRti3wyvvTDUUpLqpJWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761873199; c=relaxed/simple;
	bh=fjZtsjYgI4WmHIvxEZxpKy09oNqUa9CmKk+7Z8/CHw0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ds+y2BibAusacyNSVXlw8tL8mBWUqEHy4PMl+SAaU5FU+hlSiTpT+qbZdcdTDj8kqbwXr8NMqsMovNp12KXgrk12jiEagohfeukjo7WMnnbFXdt83UVDo73BLmDMeZHKb3bKAY5kxfnZB5v+6GuDpuKvzURo3C5WUeXO382KhyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SOpUM/kd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F41DCC113D0;
	Fri, 31 Oct 2025 01:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761873199;
	bh=fjZtsjYgI4WmHIvxEZxpKy09oNqUa9CmKk+7Z8/CHw0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SOpUM/kdWzusHyaj5phlsUnUGeoPlknVJ0B3z6jCIIxZJKGXN9nh87P4t032sNy7G
	 KAdL7MDvjMzCYXaPI5fGZ8yVoTnzxSrE/OujdwDXUJ1vJ8h4wlUxeWxlTG+rO2vHys
	 bN+3q+fzEwfcJOOQ5Ctn4oMzKCfQyUhxiJJs038wJLOUPq+6i05yK/Rc3PSduXMO/T
	 kv2azQAeP9s+uvNk5v+6nAliG9LfvIa+arTyJzecI1/1sE7cdXBJjekmX+KjJo5nfq
	 3BndwjfCrgXTw5QeVxKvdBskKuk2kZBUWD/kGusC1BsXi723ubIGMIafLPJjdDmVOK
	 102f8HXx4YulQ==
Date: Thu, 30 Oct 2025 18:13:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH net-next] ti: netcp: convert to ndo_hwtstamp callbacks
Message-ID: <20251030181313.09ef4b60@kernel.org>
In-Reply-To: <20251030161824.0000568a@kmaincent-XPS-13-7390>
References: <20251029200922.590363-1-vadim.fedorenko@linux.dev>
	<20251030113007.1acc78b6@kmaincent-XPS-13-7390>
	<0a37246f-9dad-4977-b7e0-5fa73c69ee94@linux.dev>
	<20251030161824.0000568a@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Oct 2025 16:18:24 +0100 Kory Maincent wrote:
> > But I might be missing something obvious here, if someone is at least a
> > bit aware of this code and can shed some light and confirm that phydev
> > is correctly set and attached to actual netdev, I'm happy to remove this
> > ugly part.  
> 
> Yeah, this driver seems a bit ugly to me also but maybe we are missing
> something. 

Since this is a TI device it may be one of those two-port things they
have for HSR/PRP(?). It's a single netdev but it actually has two ports
and PHY to forward frames along the ring. Hence two "modules"? I could
be wrong.

In any case - in a large refactoring effort like removing the hwts
ioctl we should try to avoid non-obvious cleanups. Unless the code is
actively maintained and someone is offering to help or at least test.
We still have a few drivers and a bunch of PHY plumbing to go thru..

So I'd copy what the original code was doing, add the goto in
netcp_ndo_hwtstamp_set() after the first failure..

This:

+		err = module->hwtstamp_set(intf_modpriv->module_priv, config,
+					   extack);
+		if ((err < 0) && (err != -EOPNOTSUPP)) {
+			NL_SET_ERR_MSG_WEAK_MOD(extack,
+						"At least one module failed to setup HW timestamps");
+			ret = err;
+		}
+		if (err == 0)
+			ret = err;

will leave ret at 0 if _any_ configuration succeeded which is worse.
User needs to know about the failure. We could keep going in the loop.
But hiding errors is a no-no.

