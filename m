Return-Path: <netdev+bounces-90486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C87F8AE3E2
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 13:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE1051C21F40
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 11:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA42A7E118;
	Tue, 23 Apr 2024 11:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="JvzNUggf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D01260279
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 11:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713871685; cv=none; b=acjqfmObwv/oIzm6Kffc5Z1khjbXMODBRgtpLYi3ahxk5vBbApq5r1EPQx7BV2W2ZA7XVXLuIEOfXVQ+HHY+8mCOC60sebqirkhxfYyPNAhGtwK7lL8kxBFyidN4DkvYponiu6hNlVNvoKiTe6HNnuc/h7GzgEH7W3gqq7rIb+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713871685; c=relaxed/simple;
	bh=R3iqpIOIoK1o7CTPRk4sNfkHZGRMhCyVjxP5dycHP0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lCIX8hdrBfD0DmRn6AtUjxNHMPTneBOuuvVNbjjrh1Vs0Z+sAINT2gotycU4cEu6/CH/z057ntkwlgVr2nRxy3+/ty8C8KZ00BNbaCgD713YtiXKFGkMUxvssO7HUJr/8HCHrQjHRuUU4YsqGmmIdA98S3PF/gNKXx/ff58V95M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=JvzNUggf; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41a4f291f80so16952535e9.1
        for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 04:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713871682; x=1714476482; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R3iqpIOIoK1o7CTPRk4sNfkHZGRMhCyVjxP5dycHP0s=;
        b=JvzNUggfIkiFCUl/ONvEAAeT+VihZJFvjTNSW4pyc7hu/IEpJb7N27oXVSNUP5niKe
         KAzwU7xwn959rCz/LhbIkp5BJncRG8wzkGPlqc2yslmMahJ2xVcAU5uFL1bISncDTKET
         +5dzOqNjpvs3YDUowjIWsD5Ok8pw3Ocyx+HamkLHa/974XdD4iNsxJ/klzbuSPzM1UIo
         tD8wVOPvxYzFFErLwfrwDdmb3F8jb2VvREbgRcY5jJgo5h0PC0jRjxvAtoTLHyRFEXWg
         Kek2zusHX9YL/pStsBtmh+yYcaIKiGrObxmFAaZYEfWkFGOhfnNsvH2s14lj+yhwqZhB
         2BNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713871682; x=1714476482;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R3iqpIOIoK1o7CTPRk4sNfkHZGRMhCyVjxP5dycHP0s=;
        b=RiuRmmqeFTMqSfwipMu/NNaUDJsZrTtvdCrFYHOyssKh4JMaC7wXLeveUBVU9Mrj+g
         oentx8gL/YrOfsT2+065Kh4GKvCka7yDuFm0Ms+xcucQPIrhUz3qLnUddnbWI1CtVpaD
         0RA1CyHu2fcVqRkYC8EIZm6kc1Q5ByAMzGjoYlJNsCBjccUDTfjiYcu+Go876z0SI9ay
         3uPJZsrrCiKpZeNUUTWPLzrWXLbeYXzFIofx2aVJrrw3Y73p6t+fddttNoDlzlv12Xxe
         ae8j5yEkqgVGqGU/FzoZKZAcW+ASooxRmi3EwyGtSo7pbCRFKxWXO2I9jGDMOjhj3y7Z
         oFiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbphGZCEtvr2V3dTlKH70B3eWNMOT2V82mzZxZlBOVQUzegspOleSX5/PqiAAILA3qwstyKNJZc9nf4JYdKM7INoEQYMWr
X-Gm-Message-State: AOJu0YzAO7aUekVVXoQU4RENZHaJAScWK4wRhU3blUoXNWl9EOhozV8/
	pdmxUIOlXErVNM44E7o52zoETq4CQOWBJjS/ugrplSoA2r+nA08cOe5ZT5QiKu0=
X-Google-Smtp-Source: AGHT+IFxR+UxcEUSmm6y7PvB/0CvHSOafoe3TVmFX4MNJjWWeZEWNgqz70/4mF1IDjDPrmnI234YEA==
X-Received: by 2002:a05:600c:1988:b0:415:4b4b:1e28 with SMTP id t8-20020a05600c198800b004154b4b1e28mr10779016wmq.20.1713871682525;
        Tue, 23 Apr 2024 04:28:02 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id y18-20020a5d4ad2000000b0034a0d3c0715sm14117203wrs.50.2024.04.23.04.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 04:28:01 -0700 (PDT)
Date: Tue, 23 Apr 2024 13:28:00 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kyle Swenson <kyle.swenson@est.tech>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH net-next v3 0/3] net: pse-pd: Fixes for few small issues
Message-ID: <ZiebQLdu9dOh1v-T@nanopsycho>
References: <20240423-fix_poe-v3-0-e50f32f5fa59@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423-fix_poe-v3-0-e50f32f5fa59@bootlin.com>

Tue, Apr 23, 2024 at 11:21:09AM CEST, kory.maincent@bootlin.com wrote:
>From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
>
>This patch series fix few issues in PSE net subsystem like Regulator
>dependency, PSE regulator type and kernel Documentation.
>
>Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

set-
Reviewed-by: Jiri Pirko <jiri@nvidia.com>

