Return-Path: <netdev+bounces-51668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E6A7FB9EF
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 13:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33A9BB217CB
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 12:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C394F8B0;
	Tue, 28 Nov 2023 12:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nolgIYQa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38C0182;
	Tue, 28 Nov 2023 04:11:04 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-332fd81fc8dso1702541f8f.3;
        Tue, 28 Nov 2023 04:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701173463; x=1701778263; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HJdSIDCxSEvtc8ZvR5XfMxZE4GiAmSPMLyCTMUELYDk=;
        b=nolgIYQavzigaMj4HTRgH5sV2sj2W0EdROUq791Qhu5yaAMriEq+gjqCcE9oWWPr/S
         nyVrtNjU+1O9JoYHRBzpNpfkcS6xeeboTT6H50lSFIwgr0W5MriWG+CU3+PzYmULPWHb
         sc+t/OoUO9OshZrlME0T5eH6AcyH8/splDDF8Flvz+IwX4QTI986QR5bzjRyb0Br3Tij
         0m+3psKYk/w8J928kIp+C/pMpiOBvtYIWpkoc+g2+ytrY0gSv71o+piZr3hgDY1Xhuvr
         6TnFfJUrWqZzEQ+ChAanHXHFNHYo05zVRt3T9oP3MxoBppkH0O7C0N63UevSq4Kkwb2n
         aYyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701173463; x=1701778263;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HJdSIDCxSEvtc8ZvR5XfMxZE4GiAmSPMLyCTMUELYDk=;
        b=xVc1hg/GAh3a/f9hOMTanRsR66yhOVc7epELMuon0WAM1sVYw0Jblhy0sDimi9XZvT
         gPVqCXhpQtbRCGpvA/2GCiBWlIPvn+D0+ZUgQ0ZhOQEoAD4GbLZFRa8q4aCdGc5zKnmM
         1EFwwwZ7NHES/KYK84qP1jidSJN0MTyMvBgvj8WqEj/0ito3V2Yuz0xrfyrs4T3ygTH4
         /mkEfnGvkTi5JJeq+v4+6m3CQ2q2MROJFW817Byr5+6jgUjVQTSbGLpN3bHaML4I0Vuq
         q5OUl3uyRo+H9avWPr20G+gDCcpwzeyfEaRaZpzxhJBtqIgCBS6A2ipCoDCyGXYwHwyI
         Sskw==
X-Gm-Message-State: AOJu0YyCtlDSgmAtoAOjQGOppJSr92wQ2WYCz88c5rhjUnr1XPCrbv6F
	vrYkeERdsToq+73oFpWiuwY=
X-Google-Smtp-Source: AGHT+IGcuds64zZU5GSlQaktzAPSJ0XvT5T6vmTEYD7+PSEklEmXzr/hUvLxM0lcVF7awEmMamWYQQ==
X-Received: by 2002:adf:a49b:0:b0:32d:9395:dec6 with SMTP id g27-20020adfa49b000000b0032d9395dec6mr9246805wrb.67.1701173462996;
        Tue, 28 Nov 2023 04:11:02 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id c11-20020a5d4f0b000000b00332e67d6564sm13472891wru.67.2023.11.28.04.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 04:11:02 -0800 (PST)
Message-ID: <6565d8d6.5d0a0220.5f8f1.b9d7@mx.google.com>
X-Google-Original-Message-ID: <ZWXY1O0fHIS4tBo-@Ansuel-xps.>
Date: Tue, 28 Nov 2023 13:11:00 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	David Epping <david.epping@missinglinkelectronics.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Harini Katakam <harini.katakam@amd.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v2 3/4] net: phy: restructure
 __phy_write/read_mmd to helper and phydev user
References: <20231126235141.17996-1-ansuelsmth@gmail.com>
 <20231126235141.17996-3-ansuelsmth@gmail.com>
 <d3747eda-7109-4d53-82fa-9df3f8d71f62@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3747eda-7109-4d53-82fa-9df3f8d71f62@lunn.ch>

On Tue, Nov 28, 2023 at 01:46:10AM +0100, Andrew Lunn wrote:
> On Mon, Nov 27, 2023 at 12:51:40AM +0100, Christian Marangi wrote:
> > Restructure phy_write_mmd and phy_read_mmd to implement generic helper
> > for direct mdiobus access for mmd and use these helper for phydev user.
> > 
> > This is needed in preparation of PHY package API that requires generic
> > access to the mdiobus and are deatched from phydev struct but instead
> > access them based on PHY package base_addr and offsets.
> 
> Why is this all going into the header file?
>

Was following the pattern done by phy_package_read/write.

Considering those API are not single function call... I wonder if those
should be moved in phy_core.c instead of static inline them in the
header.

What do you think?

-- 
	Ansuel

