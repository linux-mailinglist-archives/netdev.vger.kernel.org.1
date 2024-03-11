Return-Path: <netdev+bounces-79149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3008187801F
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 13:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3EED1F22FF2
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 12:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3EC3BB55;
	Mon, 11 Mar 2024 12:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pR9xddsE"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727253D541;
	Mon, 11 Mar 2024 12:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710161026; cv=none; b=Nsn6j/MmsJJEeMwPxnEccJFUk2UHULgDpXQ8mJxhJcRwvVhHKb0387DViEBZi2boUuCMKz+obXQIOkqgHw3H0YTrYfzY2Q8q6BldmmXDmJcKwhpUjC4kP5qeG+xlvtYsrIDHxTmfC7djUiD6TTXhxgmzxnfUpku+EyB/2DF4LNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710161026; c=relaxed/simple;
	bh=l3XxywG8Cph4XjI3vmwj8Au25JbGx2DDWeWBRs+Lg0A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pAOZKz3FmrNVuFjC/Wwt8CAaWbPRYgjHRJowm/4Om7bEUHrKZuDlSM8fUCZFbZpW/JxtkTemKtjWd608o9XQpMuchCzTiL7gl2N4ugNxnLBMeTWVw8MR7/zChQMoSdz9a/sov9XcIV0LgFGaT6lTVYguYtdVNJkxWPI1tLmBJdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pR9xddsE; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6180E20007;
	Mon, 11 Mar 2024 12:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710161021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3WdRllC+4lLlADIaPY8taan0DZL+h6QiAMhVTksEvUA=;
	b=pR9xddsEaAhrWr7HX2foEtMafnRuunLnZwstY9CJNFHHVV+AIqluUEE0zo9Vl2XptMnPbh
	fYUQbrDmbvr0ZHC/kyl8SSYwymz1w+BvH1wXZfyljihIRaGeIm7T0CDZongzNz/sBn+SRH
	fmcRwS6Z/lYxVHcNZsq/QE7Cv9mNEg1XsTg3+x3bSNr2nm5sTraSBHRyHGV5zG1tz2S2O+
	kbW/H6OsQF5JeMQ0A7bbjKanWp+FGTNc5FzqOy4mRICJqndht4LC56Y5bA+7QmrxhxcyRN
	inJXTMulNRZ8rzCynhSaJ9qzKxq2M13RYfJLjONqZNIqyTo9RrN3XhbLx+t05A==
Date: Mon, 11 Mar 2024 13:43:38 +0100
From: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Cc: ahmed.zaki@intel.com, aleksander.lobakin@intel.com,
 alexandre.torgue@foss.st.com, andrew@lunn.ch, corbet@lwn.net,
 davem@davemloft.net, dtatulea@nvidia.com, edumazet@google.com,
 gal@nvidia.com, hkallweit1@gmail.com, jacob.e.keller@intel.com,
 jiri@resnulli.us, joabreu@synopsys.com, justinstitt@google.com,
 kuba@kernel.org, leon@kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, liuhangbin@gmail.com,
 maxime.chevallier@bootlin.com, netdev@vger.kernel.org, pabeni@redhat.com,
 paul.greenwalt@intel.com, przemyslaw.kitszel@intel.com,
 rdunlap@infradead.org, richardcochran@gmail.com, saeed@kernel.org,
 tariqt@nvidia.com, vadim.fedorenko@linux.dev, vladimir.oltean@nxp.com,
 wojciech.drewek@intel.com
Subject: Re: [PATCH RFC v2 5/6] tools: ynl: ethtool.py: Make tool invokable
 from any CWD
Message-ID: <20240311134338.1dadbf7e@kmaincent-XPS-13-7390>
In-Reply-To: <20240309084440.299358-6-rrameshbabu@nvidia.com>
References: <20240223192658.45893-1-rrameshbabu@nvidia.com>
	<20240309084440.299358-1-rrameshbabu@nvidia.com>
	<20240309084440.299358-6-rrameshbabu@nvidia.com>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

On Sat,  9 Mar 2024 00:44:39 -0800
Rahul Rameshbabu <rrameshbabu@nvidia.com> wrote:

> ethtool.py depends on yml files in a specific location of the linux kernel
> tree. Using relative lookup for those files means that ethtool.py would
> need to be run under tools/net/ynl/. Lookup needed yml files without
> depending on the current working directory that ethtool.py is invoked fro=
m.
>=20
> Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>

You should send this patch standalone as it has no relevance to the series
subject.

--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

