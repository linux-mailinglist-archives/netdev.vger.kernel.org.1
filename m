Return-Path: <netdev+bounces-70528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 590A984F642
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 14:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 140BE283488
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 13:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A816A4D12D;
	Fri,  9 Feb 2024 13:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="AQ7YGHZq"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286714D121
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 13:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707486989; cv=none; b=pYOt1ns6AVk3nudvs28L/SCxXtk21i02mHRQV4GETiZKC/6TpsOQI8M6dbaodv4ySgiznPILdUZnXsd/9zupz9SMECL7UDnN5peqmvZoamIiyFSSQyPTlDEawpMg8sGsikAw/BqocfZaePu8VNOc8C/gQPMRl3mRn+7tQVmS2Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707486989; c=relaxed/simple;
	bh=VfVdbYyd/Ceh9Fm5AvItMRPq5sEEQqzLe8Kxwt9YZAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UyRdjTcZEQ3dZEC/Zzper//DPEEsR+d2bLSo51aOBgXjmlMvJcOkozj7WzFlgCjQ1NyA7K67mdTIfslUxm8XRdXFb9DeX4p3D32+btTh0MNAq2oN8WgilYzFEkYkzb/eNCn7Ptk2kkR2mXSHuq/qw5wf2VX739dLKWxmuYPD6ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=AQ7YGHZq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=LdjPBqqx+l7Hei9m607O4Gxxqi+u3lAbgpeE3BzQjT8=; b=AQ
	7YGHZq424ccXia721k49zXR81w2wourtEeQG9KgH9woze6kraN1fQZRiIswMYI13D6ih4iJ2U/r0f
	Q1ksH7gSpMDzk9XGIMbNpaEroH8bXkC7hBMG6sCM/kUDkYYf3vZltbsQ5frgBaAqXys3JuY6Odamr
	/tQQTOv27zyGMHg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rYRMk-007O7o-9i; Fri, 09 Feb 2024 14:56:30 +0100
Date: Fri, 9 Feb 2024 14:56:30 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?B?Q3Pza+Fz?= Bence <csokas.bence@prolan.hu>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Denis Kirjanov <dkirjanov@suse.de>
Subject: Re: [PATCH net-next v3] net: fec: Refactor: #define magic constants
Message-ID: <655a090c-fc37-4596-a77c-bc55a5ccbd68@lunn.ch>
References: <20240209100132.8649-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240209100132.8649-1-csokas.bence@prolan.hu>

On Fri, Feb 09, 2024 at 11:01:33AM +0100, Csókás Bence wrote:
> Add defines for bits of ECR, RCR control registers, TX watermark etc.

Another guideline which we have for networking. Wait for at least 24
hours before posting a new version. I just wasted time reviewing an
old version.

Please make sure you address all the comments on the older version.


    Andrew

---
pw-bot: cr

