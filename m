Return-Path: <netdev+bounces-115216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C424945735
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 06:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B5CA285EBF
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 04:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA935208B6;
	Fri,  2 Aug 2024 04:56:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2C61CA85
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 04:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722574574; cv=none; b=kki3nifPJXjg5ll40kIAGvjZc4cyfT6PAi7m5BooG/4ALvgBFhfjjTxvDF85A0FV+hysqvQzdn1Jh2VG77HjmBxAL/umMe7hp0bsfrFVnKXU7xIRbxwaOd/EYCFmwh2Lo0YYxBxrY8OpG7KC4AQk52viVxkYFI3KmMBs0Ubbg8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722574574; c=relaxed/simple;
	bh=SGisuWt7Q31zGCLfAPnz2umzfcXWfzg3Ub77i4gLdZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NNKinRYZtuYETjtALepM5xBGUAmuVC0FtZoR+b77YLZ7PIgic4FRNLFuz4kml66swb56j6EMkZdObP3SG+k5/piUNuV1vJH3l3thqw+dgkHlgxNDbY5216R0+FcVJ5h264OQ9/2KpiGGSpRdF+YBO65N1XE71XGKVo5A/IIyizQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sZkKj-0003y9-Es; Fri, 02 Aug 2024 06:56:05 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sZkKi-003vYP-JE; Fri, 02 Aug 2024 06:56:04 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sZkKi-00Enm6-1a;
	Fri, 02 Aug 2024 06:56:04 +0200
Date: Fri, 2 Aug 2024 06:56:04 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Pieter <vtpieter@gmail.com>
Cc: Simon Horman <horms@kernel.org>, devicetree@vger.kernel.org,
	woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
	netdev@vger.kernel.org,
	Pieter Van Trappen <pieter.van.trappen@cern.ch>
Subject: Re: [PATCH net-next v2 2/5] net: dsa: microchip: move KSZ9477 WoL
 functions to ksz_common
Message-ID: <Zqxm5NK8JARcgDFE@pengutronix.de>
References: <20240731103403.407818-1-vtpieter@gmail.com>
 <20240731103403.407818-3-vtpieter@gmail.com>
 <20240731201038.GT1967603@kernel.org>
 <CAHvy4ApG3XhOmvn-0kT-Uvdd8yir_O72zSrFLA+CHKhm+z6XEg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHvy4ApG3XhOmvn-0kT-Uvdd8yir_O72zSrFLA+CHKhm+z6XEg@mail.gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hi Pieter,

On Thu, Aug 01, 2024 at 08:45:03AM +0200, Pieter wrote:
> Le mer. 31 juil. 2024 à 22:10, Simon Horman <horms@kernel.org> a écrit :
> >
> > On Wed, Jul 31, 2024 at 12:34:00PM +0200, vtpieter@gmail.com wrote:
> > > From: Pieter Van Trappen <pieter.van.trappen@cern.ch>
> > >
> > > Move KSZ9477 WoL functions to ksz_common, in preparation for adding
> > > KSZ87xx family support.
> > >
> > > Signed-off-by: Pieter Van Trappen <pieter.van.trappen@cern.ch>
> >
> > Hi Pieter,
> >
> > This is not a full review, and I suggest waiting for feedback from others.
> >
> > However, I think this patch-set needs to be re-arranged a little,
> > perhaps by bringing forward some of the header file changes
> > in the following patch forward, either into this patch
> > or a new patch before it.
> 
> Hi Simon, thanks indeed I missed this! It seems difficult to respect both
> patch requirements [1] for this case:
>  * One significant exception is when moving code from one file to another --
>    in this case you should not modify the moved code at all in the same patch
>    which moves it.
> * When dividing your change into a series of patches, take special care to
>   ensure that the kernel builds and runs properly after each patch in
> the series.
> 
> I can make it compile but by moving the code, the KSZ9477 WoL part obviously
> won't run properly anymore. Any suggestion how to tackle this?
> 
> [1] : https://docs.kernel.org/process/submitting-patches.html

I see two options:
1. Add some minimal changes in the header files and describe the changes
in commit message.
2. Do code refactoring which is done in patch 3, before code is moved
around.

In any case, every step should compile.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

