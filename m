Return-Path: <netdev+bounces-110330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA0592BECC
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 17:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCA981C21AB6
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 15:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93EF719CCEF;
	Tue,  9 Jul 2024 15:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ft/++sUM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A97015C9;
	Tue,  9 Jul 2024 15:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720540327; cv=none; b=Rpw5a7Nm5wLxMySvzthhwotHNPdoH3UmTqDA9ySo+WP8t3YfblRUGiIuC6NkGNS+aJ6luurXo9LdF9Z/SseuX7DVYk7UFuPcExAZjRpioHGWIR+nGVNIuXunlvxfID+5i7cb/Coihech2N3rn1Gk2W2BFuB5W0QnlYbdMUiXMjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720540327; c=relaxed/simple;
	bh=PezZkk89/XVZldgPdH43PX9xhp3+ZRAaKkQqpa+Q9VY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=feo9fQiGqYijZE4ekulPkXk4OxBqqnf/VAvPedbSrOAvYAB8M3HuoJvNwQAZ8Vz4v14qdgZVtk+41mV+fn/K7f5LqkpricdQSwipZSyXxNQe2vrgzQvtjiXGdtD1lPrnLsRyn4WP82X9zeWlfM9Q6MHXBO2we22up25rJ0kD9DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ft/++sUM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BB90C4AF07;
	Tue,  9 Jul 2024 15:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720540327;
	bh=PezZkk89/XVZldgPdH43PX9xhp3+ZRAaKkQqpa+Q9VY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ft/++sUMgRk/zE5Ct8La4GzHH0t9d/O5CNCvqSR3KmVj679Uxb7tb5r9D0TUaNgNR
	 2Ce5R+Htivyp7lX0LFW1LwSD+0fi7Dns/4eGK6brxXKwsafPlf1YCf+agGTxJOwVwx
	 Mu7GOcYm1tXX7FC+vDKXargibhH4qkRBjPOojAuAutn4u+5iiAsCtxroyg5CD12O9L
	 y0MHxByXRN8lkzchYO0TVvvLQJGV23NaTigSyaOCoxqStrtAquHLM8lfHqq1wwcy58
	 z1KZOCydKSysKhuCTvoO8emLxtRpvLdpF+WZWVzpNUec6loC7KdZ2jfc18YT/OVq8c
	 tFMNHaUe3mPbw==
Date: Tue, 9 Jul 2024 08:52:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>,
 thomas.petazzoni@bootlin.com, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] net: ethtool: pse-pd: Fix possible null-deref
Message-ID: <20240709085205.0fa41f8f@kernel.org>
In-Reply-To: <20240709164305.695e5612@kmaincent-XPS-13-7390>
References: <20240709131201.166421-1-kory.maincent@bootlin.com>
	<20240709071846.7b113db7@kernel.org>
	<20240709164305.695e5612@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 9 Jul 2024 16:43:05 +0200 Kory Maincent wrote:
> > Normal ethtool flow is to first fill in the data with a ->get() then
> > modify what user wants to change.
> > 
> > Either we need:
> >  - an explanation in the commit message how this keeps old config; or
> >  - a ->get() to keep the previous values; or
> >  - just reject setting one value but not the other in
> >    ethnl_set_pse_validate() (assuming it never worked, anyway).  
> 
> In fact it is the contrary we can't set both value at the same time because a
> PSE port can't be a PoE and a PoDL power interface at the same time.

In that case maybe we should have an inverse condition in validate, too?
Something like:

	if ((pse_has_podl(phydev->psec) &&
	     GENL_REQ_ATTR_CHECK(info, ETHTOOL_A_PODL_PSE_ADMIN_CONTROL)) ||
	    (pse_has_c33(phydev->psec) &&
	     GENL_REQ_ATTR_CHECK(info, ETHTOOL_A_C33_PSE_ADMIN_CONTROL)))
		return -EINVAL;

GENL_REQ_ATTR_CHECK will set the extack for us.

