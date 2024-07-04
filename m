Return-Path: <netdev+bounces-109294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3FC1927C43
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 19:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1392280E40
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 17:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF14E49651;
	Thu,  4 Jul 2024 17:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qew1tsvS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B2B4964A;
	Thu,  4 Jul 2024 17:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720114188; cv=none; b=TNrIeCiZJYjXE5ZaDHE4ly8f72jX/vqoQtnFuABCI/SXlDHwZpP+25xkKkTjFNmGnhupYe7IqXnDLu+kQ0IbnEMEzJ/EzXxftDTKRv5yoHMGyRSJhZmAKaXujpvdgT5p8r/sQKiZJDPB7mogST2TGW75CJubC3h7pegfgJu1YEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720114188; c=relaxed/simple;
	bh=kaN3N0MIwqNSx0hi3vzzqJ/FoE01l/AEDHEIYSWfiWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qkbib/Af4+nt6gpXwjOvIirpXYbN4iiEs+RcpoBI8jkdPVk33RJfPMOf9QasVWmxfI9MOXhCmO5AYwiMzZNKLp79iiM0rznVdxthDuUBcXR/ucuWBW585PK1kTkbL9VHVkH7I/9rbLA6GeYnQw0adkeLKNnbhjrvpsRAAstvDN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qew1tsvS; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-367963ea053so661691f8f.2;
        Thu, 04 Jul 2024 10:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720114185; x=1720718985; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fsiK+KmSYV8z6SFjkI4mN7mIXblChvysTAUcYs9wVCg=;
        b=Qew1tsvSlZqwDyBbWXLrujvHKRTUb6qcB/FWvBT1B/zkYeM0qNIorXX3MsgpCWIg0F
         dxzS76IuqGxLqULQtq4uYXj7D+pP8vuA7Wb/seyNAKh3Yts9Q1DZUMYq7kW5Hel9sNf+
         EeWPxsrSyyuGQCRKpV1N70isdXANjxpfgMHv75ZCs6TPFYuISYs9+C1bG9/c9i5mvd+J
         irbZkRSheDZQq9SDFREYAEfR7jzcDGBXXTqx+9UwF5X8JDALj3tINZ51VE5MzGr5BMua
         ssvi4gUR+4o8Kz24jcEEsRFbN96HbXJpo/wwpW05veIygApSgmSfOBsvMUp8BCSmHSBl
         ye3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720114185; x=1720718985;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fsiK+KmSYV8z6SFjkI4mN7mIXblChvysTAUcYs9wVCg=;
        b=nWJulcIZ50uHNqDVvMMcNvoksgPD49I4rybIGVmjmpcMkfMRzThHSZFOXc5dnM81Mk
         qmjeWLchwmrFB7lGUe0BN8BjWt4xl5swtvjFL6TRjWG/yK60rHB6ruoH9QQ2EmeNjZNW
         KKwWXeGnq8wVcJ65rPZPQAkgv0gjHE3rlioZFCBEZ4wUTX9K7Pe1D37j7vvaRWe3eQGC
         wTBReNbpPNi+MU4TV+1nLwxxmz4U1qN0qQK8lkVE0C5iMY779+28aLuqXIrWO48qLpO1
         hz9tPMBuZVYqpXPh+Oc5J4RV2YrPCdvuzkVW+JB70O1fFGjX2U9cHWwF6eQalNIRexjS
         JktA==
X-Forwarded-Encrypted: i=1; AJvYcCWztPAVsC03PhyuJV20iR878VYG7j7HsbkzfnoeJleVrfbkUNEPNL92SRyqYQD/Gj4csbJqb7+b6bT7GBB8/etuNrPd6kPzLoO2y86r8c4r5U5hhWaX8dYWTRLrNvIMsCDjjEIf
X-Gm-Message-State: AOJu0YzmOuXP3kf7xoFOg3S+IPFswjqQM08tnQz1P/uhlnrNvt65qJGN
	uM8V3u40qUKPERdzbu6ljqeWAc8SFRBMWQHl1+ZcqN0vz0z7FBi1
X-Google-Smtp-Source: AGHT+IF0HwPl+iKjLbIAWd1rFNmtIUCz9ZJZ5KCuwbq23zL6zdlXsKGiTxnvWrakSjR3/q3zvZvAEQ==
X-Received: by 2002:adf:ebd2:0:b0:367:8f98:c501 with SMTP id ffacd0b85a97d-3679dd318a4mr1932828f8f.38.1720114185363;
        Thu, 04 Jul 2024 10:29:45 -0700 (PDT)
Received: from skbuf ([188.25.110.57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367a40a6d4bsm686553f8f.51.2024.07.04.10.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 10:29:44 -0700 (PDT)
Date: Thu, 4 Jul 2024 20:29:42 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Christian Eggers <ceggers@arri.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Juergen Beisert <jbe@pengutronix.de>, Stefan Roese <sr@denx.de>,
	Juergen Borleis <kernel@pengutronix.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] dsa: lan9303: Fix mapping between DSA port
 number and PHY address
Message-ID: <20240704172942.lngit56pv4xewlc3@skbuf>
References: <20240703145718.19951-1-ceggers@arri.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703145718.19951-1-ceggers@arri.de>

On Wed, Jul 03, 2024 at 04:57:17PM +0200, Christian Eggers wrote:
> The 'phy' parameter supplied to lan9303_phy_read/_write was sometimes a
> DSA port number and sometimes a PHY address. This isn't a problem as
> long as they are equal.  But if the external phy_addr_sel_strap pin is
> wired to 'high', the PHY addresses change from 0-1-2 to 1-2-3 (CPU,
> slave0, slave1).  In this case, lan9303_phy_read/_write must translate
> between DSA port numbers and the corresponding PHY address.
> 
> Fixes: a1292595e006 ("net: dsa: add new DSA switch driver for the SMSC-LAN9303")
> Signed-off-by: Christian Eggers <ceggers@arri.de>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

