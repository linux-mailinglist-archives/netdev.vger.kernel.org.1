Return-Path: <netdev+bounces-153467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA3E9F826E
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 18:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 244AA1686A5
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 17:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B3C1A4F09;
	Thu, 19 Dec 2024 17:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gr9rIELV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7862C194080
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 17:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734630393; cv=none; b=PtyrdSubgRVz6k30M3cDy8EBQUrzLo9zrWwrXGdNizbbaxkbjhxjtvGFt5XDF8yVXa2GYdhhkALQOkB8R0+wgyizw9slNqhKSSTKrBU7W7gXjAayk+p37nbohNxfZswqpsYGpeRfKcitbHyKEK2p4+lH/E5dipm4jAGOcXPlSsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734630393; c=relaxed/simple;
	bh=BCP8gaFD6SZ2E4Ysr3jdnZJ2rc9GjsGL857nvq/ElSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jB+DLudZ1bA7o5BIeOmPX7+UmYBSP3NoAoT3HbLGPcz4+WKf4Axx14oAU5I5ZSKh/yFt2pNZglyiqEZQB8JDL1g2aHdlVo7E9hhkm85rZiSBlB/16KCDnmGmtrZqNKNXwUpy8alUArmmDBIT66T/+yQhAm2cNENjufN413GrdAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gr9rIELV; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-38636875da4so44135f8f.2
        for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 09:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734630390; x=1735235190; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0h3OGW45nCC/iBI62vQFWWwCcpgO3yq0UN6Y2CSO6A8=;
        b=gr9rIELVCAILRBuRruTVCzPzGsF7fnuZwC80aHqsV2Xp7bp9Ha0dywcdBUaKDTev1Y
         2hkNlQTScm5HZSx0fzxXzNo3MNTndq1A9pKz90nCIqkP3FUwsMk0vEBi7Rup2K1qH62i
         aLmHym5MQKafIxzaJQcAPi+ZIPJf/jZ3eezNuoOieCb8D40z60RMuAATvOeTc1uNJc13
         3wpXeeUeN1JtoBNdl75A0GNT9UCWUw2Q5LnHWHD7MTmNXutNnzgcS3eQ9bmAfvnHLNBr
         TSBXZMOOx7sK2tR9zN7Gk29bker/OIqhEF7Q7d0Lil2s4o0t6XEJYd4Ws5bI2eB7CBhD
         2Jdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734630390; x=1735235190;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0h3OGW45nCC/iBI62vQFWWwCcpgO3yq0UN6Y2CSO6A8=;
        b=j9PTtye5Vvv1HftBh4KsQarAmDyeLFocd7z8fkIVd1sPvx3h6DsNkqJy1CEdB++jLJ
         LitICtdJYFjnp/6wwNV8xJ1580gs/pLXZoKelqAl5C/MUTSRwt4AqIVQCyVX6kc93PYr
         KBP2MNalcsb+VkGweMsAoU5t8rRsiZ6Tp1JzOOkjImOwPiovXJooylaa8H9nn8m3JclE
         0B5fWbdEuTN3UdG+3G9sC4UEkWbvFGmnw9UXRkceKfX0eZqJL609+o9g2pRdS+dbSrm8
         KhqI3/9KpwTGhCsw4T8YivweSyYQSy4gCi7VYyTtYh5/6ukwg8YAM38m3Mohst+o6qhZ
         ZFdA==
X-Gm-Message-State: AOJu0YxADuZnU6ltNTiY1XtZRv+uh0Z0IJmIBGryW0jho9kMEbzU7/CE
	FiE3BuJEZ5c7fdmup7UMOn2NU5Mb8UqAHwgklfxchdQRqaRTNw4y
X-Gm-Gg: ASbGncsGGD17q22A7x2pvlYTAryemJb91cVkBcFWzx5s6Pb7uIpI86Cx8riKJxkgGMp
	trbgMw+tOoYYC7QZGvo3LZRjROiPeBDkQntEBWRblgnG3g044FE0UbAJ41SjIq9ZAqT5GfDMngS
	Mn4DhCqotjYxatSRI0eGBX6/tgPRriza+HPGBTpy5yrsS8NhSppZCUA0wz5mDxGjLogOpCgPpJR
	FF4AFQRoJaKZWWpQQk/wNss1y8ItJm6cyF+CPwtBOtP
X-Google-Smtp-Source: AGHT+IGykJArObfM+n4nshWSpWUY9I37uG3IHO2ZLcZHJZWmaEqiIBjza73xGjKzV029WEgzusOfuA==
X-Received: by 2002:a5d:5f53:0:b0:385:edd4:1242 with SMTP id ffacd0b85a97d-388e4d8ad9bmr2925071f8f.10.1734630389534;
        Thu, 19 Dec 2024 09:46:29 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8287adsm2028560f8f.16.2024.12.19.09.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 09:46:28 -0800 (PST)
Date: Thu, 19 Dec 2024 19:46:26 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net-next] net: dsa: honor "max-speed" for implicit PHYs
 on user ports
Message-ID: <20241219174626.6ga354quln36v4de@skbuf>
References: <20241219173805.503900-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219173805.503900-1-alexander.sverdlin@siemens.com>

On Thu, Dec 19, 2024 at 06:38:01PM +0100, A. Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> If the PHYs on user ports are not specified explicitly, but a common
> user_mii_bus is being registered and scanned there is no way to limit
> Auto Negotiation options currently. If a gigabit switch is deployed in a
> way that the ports cannot support gigabit rates (4-wire PCB/magnetics,
> for instance), there is no way to limit ports' AN not to advertise gigabit
> options. Some PHYs take considerably longer time to AutoNegotiate in such
> cases.
> 
> Provide a way to limit AN advertisement options by examining "max-speed"
> property in the DT node of the corresponding user port and call
> phy_set_max_speed() right before attaching the PHY to he port netdevice.
> 
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> ---

The user_mii_bus mechanism is redundant when we have device tree
available (as opposed to probing on platform data), let's not make it
even more redundant. Why don't you just declare the MDIO bus in the
device tree, with the PHYs on it, and place max-speed there?

