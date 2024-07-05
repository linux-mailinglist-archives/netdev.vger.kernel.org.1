Return-Path: <netdev+bounces-109548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EE3928C14
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 18:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FB1D1F23B44
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 16:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C01D16C842;
	Fri,  5 Jul 2024 16:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uifOKsaL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BB313A88B
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 16:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720195599; cv=none; b=f0okL7MaVEz5nHeojq3awb6rrPbT+yfj4I6cZ3m1nNTpaY6/KUFZgqvz9nWrm2fPWFWy2uZxwdtqHBAuE7dRtxwMLyCNYyTdDhHopfe7ky7KQCcpmtaViJBG8z7lv51Jic39Nkzzw1IJiP5cf6LaE+MosUomtXzXJ6pzT2KmzlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720195599; c=relaxed/simple;
	bh=MUtMqDYA7ac9pgES8Nt5+8H2VArbDQdIgvLCHeo7tmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HBBH3BnftHdLpF2uBo4DsYpMA8/pIeYubILasXq0lQD7C+fs2LhjJIWp24/KR7+hkU/dQAYDfZ9xCSs0i2RL0PFKW6u0BOPx5hkEcqNOIBIIVR0UdEBQVyafDQMllTjr3a9JeWI9dhVQtfIqyImCXXP1zEoxEyWC3Ay6MJ58RoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uifOKsaL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90570C116B1;
	Fri,  5 Jul 2024 16:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720195599;
	bh=MUtMqDYA7ac9pgES8Nt5+8H2VArbDQdIgvLCHeo7tmI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uifOKsaLmXyHuZv4Iy3Zn56qXvAM3u9xsMCySgHLXjgMaBrb6odu3Foj9miubl0fZ
	 70uF9hSyC1DAl8SGaE4jCDscMWO8GxDrqvf9pBVPHGCSiX8Qhl9ZdD62mdciEHKMBZ
	 BTAOAdENdWeFMj5x+7JOw+xtca7GKTVcyAH4g1tz8hdySfPBWDSpm24dlqaePC+YDO
	 KkjbYb60luoN+c91mq39yrOw0K68HN5y50/cMwahtXUUcZvcwvsvo3Z5Fq9wrmCiTK
	 YPZGYq+5TkY/JsD7v/abEk5GRqa0bnXAwq9VHLdm+WKVvRyDIbQbMYkqTqMDtcQluM
	 Ee+fMQf5Q5m4g==
Date: Fri, 5 Jul 2024 17:06:35 +0100
From: Simon Horman <horms@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Michael Chan <michael.chan@broadcom.com>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 1/3] bnxt_en: check for fw_ver_str truncation
Message-ID: <20240705160635.GA1480790@kernel.org>
References: <20240705-bnxt-str-v1-0-bafc769ed89e@kernel.org>
 <20240705-bnxt-str-v1-1-bafc769ed89e@kernel.org>
 <f708ca1f-6121-495a-a2af-bc725c04392f@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f708ca1f-6121-495a-a2af-bc725c04392f@intel.com>

On Fri, Jul 05, 2024 at 02:37:58PM +0200, Przemek Kitszel wrote:
> On 7/5/24 13:26, Simon Horman wrote:
> > Given the sizes of the buffers involved, it is theoretically
> > possible for fw_ver_str to be truncated. Detect this and
> > stop ethtool initialisation if this occurs.
> > 
> > Flagged by gcc-14:
> > 
> >    .../bnxt_ethtool.c: In function 'bnxt_ethtool_init':
> >    drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c:4144:32: warning: '%s' directive output may be truncated writing up to 31 bytes into a region of size 26 [-Wformat-truncation=]
> >     4144 |                          "/pkg %s", buf);
> >          |                                ^~   ~~~
> 
> gcc is right, and you are right that we don't want such warnings
> but I believe that the current flow is fine (copy as much as possible,
> then proceed)
> 
> >    In function 'bnxt_get_pkgver',
> >        inlined from 'bnxt_ethtool_init' at .../bnxt_ethtool.c:5056:3:
> >    .../bnxt_ethtool.c:4143:17: note: 'snprintf' output between 6 and 37 bytes into a destination of size 31
> >     4143 |                 snprintf(bp->fw_ver_str + len, FW_VER_STR_LEN - len - 1,
> >          |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >     4144 |                          "/pkg %s", buf);
> >          |                          ~~~~~~~~~~~~~~~
> > 
> > Compile tested only.
> > 
> > Signed-off-by: Simon Horman <horms@kernel.org>
> > ---
> > It appears to me that size is underestimated by 1 byte -
> > it should be FW_VER_STR_LEN - offset rather than FW_VER_STR_LEN - offset - 1,
> > because the size argument to snprintf should include the space for the
> > trailing '\0'. But I have not changed that as it is separate from
> > the issue this patch addresses.
> 
> you are addressing "bad size" for copying strings around, I will just
> fix that part too

Right, I was thinking of handling that separately.

> > ---
> >   drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 23 ++++++++++++++++-------
> >   1 file changed, 16 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> > index bf157f6cc042..5ccc3cc4ba7d 100644
> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> > @@ -4132,17 +4132,23 @@ int bnxt_get_pkginfo(struct net_device *dev, char *ver, int size)
> >   	return rc;
> >   }
> > -static void bnxt_get_pkgver(struct net_device *dev)
> > +static int bnxt_get_pkgver(struct net_device *dev)
> >   {
> >   	struct bnxt *bp = netdev_priv(dev);
> >   	char buf[FW_VER_STR_LEN];
> > -	int len;
> >   	if (!bnxt_get_pkginfo(dev, buf, sizeof(buf))) {
> > -		len = strlen(bp->fw_ver_str);
> > -		snprintf(bp->fw_ver_str + len, FW_VER_STR_LEN - len - 1,
> > -			 "/pkg %s", buf);
> > +		int offset, size, rc;
> > +
> > +		offset = strlen(bp->fw_ver_str);
> > +		size = FW_VER_STR_LEN - offset - 1;
> > +
> > +		rc = snprintf(bp->fw_ver_str + offset, size, "/pkg %s", buf);
> > +		if (rc >= size)
> > +			return -E2BIG;
> 
> On error I would just replace last few bytes with "(...)" or "...", or
> even "~". Other option is to enlarge bp->fw_ver_str, but I have not
> looked there.
> 
> >   	}
> > +
> > +	return 0;
> >   }
> >   static int bnxt_get_eeprom(struct net_device *dev,
> > @@ -5052,8 +5058,11 @@ void bnxt_ethtool_init(struct bnxt *bp)
> >   	struct net_device *dev = bp->dev;
> >   	int i, rc;
> > -	if (!(bp->fw_cap & BNXT_FW_CAP_PKG_VER))
> > -		bnxt_get_pkgver(dev);
> > +	if (!(bp->fw_cap & BNXT_FW_CAP_PKG_VER)) {
> > +		rc = bnxt_get_pkgver(dev);
> > +		if (rc)
> > +			return;
> 
> and here you are changing the flow, I would like to still init the
> rest of the bnxt' ethtool stuff despite one informative string
> being turncated

Thanks, I'm fine with your suggestion.
But I'll wait to see if there is feedback from others, especially Broadcom.

> > +	}
> >   	bp->num_tests = 0;
> >   	if (bp->hwrm_spec_code < 0x10704 || !BNXT_PF(bp))
> > 
> 

