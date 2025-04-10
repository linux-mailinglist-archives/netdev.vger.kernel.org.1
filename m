Return-Path: <netdev+bounces-181059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C80DA837BC
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 06:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3F781704B4
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 04:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F035A1C173F;
	Thu, 10 Apr 2025 04:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IeRFFuo/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4B55234;
	Thu, 10 Apr 2025 04:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744258584; cv=none; b=T8XdjMGB6qY3B18k4gVRmATWDDMiU+Nne5oQeM8a1sIAthFE5+ZARCUqrjWMWjJZF3N+nYWBE1mqInFOEoUQuXxSRUntK9/A1vo9deiyNcyiopWHdbEyP9tvIsWUnbnT1xuS+bbZyBK8YoVnsqbMKwnJUIzOeI9s6z/+IqiSjdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744258584; c=relaxed/simple;
	bh=eCqBNdrDzJ3x9QKNmY/h6+yCoYHsWVoQX1qTJ7S7hoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E2fSlkeCBsZEulLXSI2kS0se8uAmYYCZ2SkN33RmDBREJCZWOwlVPgis2NcUrwGs5vuaQ1nD3AN1bhEEufsDTUneulGttQ/vzW4GYVjykuLdE9IAQgQhQs+Gn5o4LLhfDzoNCnKZ2y6nyJEDch4Hpj6LOtUUsduVye11SIWUhfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IeRFFuo/; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-af19b9f4c8cso267547a12.2;
        Wed, 09 Apr 2025 21:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744258583; x=1744863383; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QlmynTgByf4Kwa5VfoEnK8EdQwb5yKMa+V4z66nhhcU=;
        b=IeRFFuo/oACl0vlTf3jejZ6ACTStrmU07nbxgMRJ6SBALKGMHFsjM81e4t+WLPKRy7
         kc7CEIZDRha79zxZSoEbQbKOWlGbkmZIBVCT+HqA9JN3ylN39ME+8gNEvGrWCHvXmhk1
         D/POxzpOwDqDVtPLiQy12m4o1W3Kgo/YxFmisqwMk8kxnX28jPmrLBN0Hoz0fQkPRwY/
         O6/e3xmTfAXZEHaXVUyZ1YrHtnD9BO8eO2OdBlzapy6FyshJTxGZy6cncwmeOu7U6rph
         JbxhbBDqAYorLnM29Lwf2IHGJ5v8Z2IN7W24dQxpOJiu2y8UfnUriXI57++uJ1Ktfv2D
         WVDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744258583; x=1744863383;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QlmynTgByf4Kwa5VfoEnK8EdQwb5yKMa+V4z66nhhcU=;
        b=u99vCc5FxISLUE3/hYuvmmHDpcjW3sFZeUPIS4v/UHO2YJ+5NjZAUDEgjJJv6z1GhG
         qp+7hYVd//RZTupsYWA/JIAY35ogkrQBgiahzwh2VqQUwwmc+xrkFeGYb7QWlcGP3TFs
         vACvNHMOQUCKA04EZ/VyG8WgDeCYOMsOcnEBr4aod+eBspcpIFYeDveFHL6IpTaFeoGB
         ylTqa3TTapoP6fTvA1kB1NtC8agb4sywFdSydv7z89BHWHmB6LfukawEdP/WQbrnvqdH
         8cJVngKy/umc2qbpCrjhccLJPuFcvcM8DjiO3uwOYUH/W0W/jBWWEXclZj1jfh3BFD9C
         Zs0g==
X-Forwarded-Encrypted: i=1; AJvYcCXOFxppcM/DrHLIPE7uugc5I62pyLLrFmxHEEK9Q7Nt8ZiYDeyYwk3qEAv4AKBd8mVn9yHD4KC/@vger.kernel.org, AJvYcCXy6DkV8XNQ1skUqhhdoPYAc+nrwNT8PgZJrbCxqY4WUf3m4KK2Ii8eWYu4KOVQQWBKKMHKLW/hJdFbXaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCA3soDpcRPHlGqgZoErht4+Dq7DdOMjs9RBGh9B8kWo7EUu01
	WvnheNKiEvDbgK0/HL2KTMRWndbStog5oq2gsf+8v7AJ4AHslA4J
X-Gm-Gg: ASbGncudvOaOfmbewHOe15BanlGbYCQOxrgDLmnXuhx5a5ySCDl6ZnVjQmsJQFF4uz2
	uny9pQlU3Lk3utX4PlYrDj4PxoURVjd31HSP8qVe21ctc7sJSjmvMyiGB0IFUv++ok3U9vc9jpD
	ahGeoTvOtog4TjeohO2Dmp5bzCxL24ek8QABt4Ck32o09I4XonxXlUkBBE6jcXlgc4rG3BUDQ5E
	VEOlMpvK9F+hd3oWrzLXsg+u9deCRj/vBBW668I3iPXwJViBYpKKvVUXacWm+dN2MRiD8Hrss4K
	R9ZaYmmnGaPrPnzMnyiEAm42xA1/DhqsyVK9QB5G1D7lS5NgHgJBQM+ts+hB
X-Google-Smtp-Source: AGHT+IFyjAQxZ/eBlALI7viUkwJoBudRUhuwEX5LYGJwRYb5anXvvc7BgZKTecl5Hqufy14LpTF3Fw==
X-Received: by 2002:a05:6a20:d70f:b0:1f6:6539:e026 with SMTP id adf61e73a8af0-2016ccc42d7mr1278051637.15.1744258582590;
        Wed, 09 Apr 2025 21:16:22 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b02a321f082sm2090380a12.68.2025.04.09.21.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 21:16:22 -0700 (PDT)
Date: Wed, 9 Apr 2025 21:16:19 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
	Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net: phy: Add Marvell PHY PTP support
Message-ID: <Z_dGE4ZwjTgLMTju@hoboy.vegasvil.org>
References: <Z_VdlGVJjdtQuIW0@shell.armlinux.org.uk>
 <20250409101808.43d5a17d@kmaincent-XPS-13-7390>
 <Z_YwxYZc7IHkTx_C@shell.armlinux.org.uk>
 <20250409104858.2758e68e@kmaincent-XPS-13-7390>
 <Z_ZlDLzvu_Y2JWM8@shell.armlinux.org.uk>
 <20250409143820.51078d31@kmaincent-XPS-13-7390>
 <Z_Z3lchknUpZS1UP@shell.armlinux.org.uk>
 <20250409180414.19e535e5@kmaincent-XPS-13-7390>
 <Z_avqyOX2bi44sO9@shell.armlinux.org.uk>
 <Z/b2yKMXNwjqTKy4@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z/b2yKMXNwjqTKy4@shell.armlinux.org.uk>

On Wed, Apr 09, 2025 at 11:38:00PM +0100, Russell King (Oracle) wrote:

> Right, got to the bottom of it at last. I hate linuxptp / ptp4l.

So don't use it.  Nobody is forcing you.

Thanks,
Richard

