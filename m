Return-Path: <netdev+bounces-244497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C20FCB8FA1
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 15:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68716306E01C
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 14:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298762E8DE2;
	Fri, 12 Dec 2025 14:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dejHGpDF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74633239E81
	for <netdev@vger.kernel.org>; Fri, 12 Dec 2025 14:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765550242; cv=none; b=dmsJlrKaUXfxXmElsRdYppgQN3W4YInTVV24Z+KpGSaAFwBg1JiHnXSVNYMIEBZSuLrmwM9l4ye50+AIadV6PZKdE1JrA6IN4RQSvBYfvm6U3KgbntHpfATxgkMZ7vilYPprB2wOXDrcuawSgP0hHDy1RZ7TXCgjWtlK2auKtMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765550242; c=relaxed/simple;
	bh=BEuOR57ra8QxE8enSXRE/aXckFSpn5PIMtijn0uq8JI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lgvHrfw8Nvzv0jmSiFTKAHrEjHdM9YI6SCUHPJ4tSE/zJKgR7HxHpedehOCq/H4uf+4A0eLV8MmKrjdHAw2cQB3bCJI6NeeA7CYwKXND4bq66r2uk4jixix66RtIPmdIjEBA0B+9ajrgCLb6Y4gnmfpTOzCnOANiaaVUFrVixB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dejHGpDF; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47774d3536dso12528385e9.0
        for <netdev@vger.kernel.org>; Fri, 12 Dec 2025 06:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765550238; x=1766155038; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k0GBz8/j9DlWrMYbOr5c+NaYxYOwd63zY44waRkSHjE=;
        b=dejHGpDFxGTnJgujE6FBxWiOH3tabKYf4c99+xEXVLtWA+10GNfR8Ar+hxXr2wWwOk
         di7l5MbffXptUWGvpw8tZCkodqB4i5oiw/mvdwtJuc9iO6oDzeMwXC2fU9yowmFd4JMe
         LvQ0NPPq5lHLmjv13RWJ7r6/6VYi9zOOldW9sUAYJ3A0hBWBTVXRuLHnNLGmXqNHnlio
         wvEfQJCLhsz/ZF+ufzG1C3sQcaxeFEJa8rKSWa1abZeOIdZlRsh6fI6teMmgDG1+vUVG
         /0VS0wBGLc0UGoPS1cXpp3hXXvG1dLCstJrbDr9vGi3nrvGfK1vcNMWC9Eeuq/xzKC5X
         ecgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765550238; x=1766155038;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k0GBz8/j9DlWrMYbOr5c+NaYxYOwd63zY44waRkSHjE=;
        b=BbgqbRQ7T6OTnnprcJW5cZBi4EONbd7n8MS9/BX5yxCsCILnNGLuJigWZZxj0HyWAP
         /NZU960fDwu5xpMSOh03ShQmNd3i6E3/geTGJjqM2fkekTpPCXqX+aGz8GsSs++YfdGo
         bwg6ONVf3DlgpESHv9NG8DGP40igertMgUENYeljlvFQQS2boLpYvJ20dNJiYplDkspp
         x6ED6hYvA7dxbX/ZyarSn//iZbrTtb7g+iR5FYLoDyuiMsGDJx71hM6F3PoOnQ7bKcVM
         jxJ4MsvTxxfnK3c/vxW87XsUqBriMaYl1beKhnOKK+omjK4SV9/2DYRwsNAFM0u/NEp/
         pmAQ==
X-Gm-Message-State: AOJu0YxO9TPVc5I3p7JbgCZMXsS5CjMSf/7aJuLBtQ2nc9M9DmLyIgoz
	csxky/Rmg2MJukntFUvkAbDn6cQ5nitDLExJScEeaQI9cfWN+TvK6UMbkRyFUoVI
X-Gm-Gg: AY/fxX4OqWR79U9kUA9i0mgLu6wbbacW9gIzR8lmHWLcJlj6vwCLyojhZTROjsOoa4D
	jXb0nL6Vdez4voeBbogaPeAuS/2xOIxphCrrUKQnXPBSYWql1u51es1wQ+tSbRl726ROC1iI6iU
	ltNeX9fJ96sX+4ab84zaUz51Z7m4YqVP215RmJNHbNELPNHYpMJLvGakkz1eYv31ekHOYcoNlM0
	xbkhl20N/CVF5I6vuz+0X+8gcnH+dqo/n9+IiQmnGxuUTUU8IuPykcZmohf5vTGYUv62Bw1jEFZ
	V/KuT6CJM/9aplleWasMQSav1nyfJCYk6Yq6srvAq+YuhvP5+sebqeaJvgddFX5u1RWAvE0CM7a
	OfWD0E9V7Qu25g8UYEt+TnXNwMk3gm3VUg1pUemLSV2bPbblsSuFCmowghQACZKhKE/rN60JUAR
	gtT3/1KqJLfnkfkXetDt/IY6i2LInxA7kd0izpVzSTdrzVVoFniGTNdMZ1TLy9Z7YDwkLFm/vFw
	Q8rSbGYe0U2q8K6rTDZfw==
X-Google-Smtp-Source: AGHT+IEOSbUGrSFS0GuiJrOeO9rCZnGOFAyBgKfUXKIm0Ranzw4GNzZNoflyUP40GEp26hUsMN5Ubw==
X-Received: by 2002:a05:600c:64cf:b0:479:255f:8805 with SMTP id 5b1f17b1804b1-47a8f094212mr25922505e9.4.1765550237905;
        Fri, 12 Dec 2025 06:37:17 -0800 (PST)
Received: from Lord-Beerus.station (net-5-94-28-5.cust.vodafonedsl.it. [5.94.28.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a8f38a455sm34280515e9.1.2025.12.12.06.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 06:37:17 -0800 (PST)
Date: Fri, 12 Dec 2025 15:37:15 +0100
From: Stefano Radaelli <stefano.radaelli21@gmail.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>
Cc: Xu Liang <lxu@maxlinear.com>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: [RFC] net: phy: mxl-86110: Manage broadcast configuration
Message-ID: <aTwom4FdQDcTyIdL@Lord-Beerus.station>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi all,

I am working with the MaxLinear MxL86110 PHY and I noticed that the
current driver only disables broadcast access inside mxl86110_broadcast_cfg().

However, according to the datasheet (Register A005h –
RGMII In-Band Status and MDIO Configuration Register), the PHY actually
supports multiple broadcast configuration modes:

- EPA0 (bit 6): enable/disable responding to broadcasts sent to PHY
  address 0.
- EBA (bit 5): enable/disable responding to broadcasts sent to an
  alternate broadcast address defined in BA.
- BA (bits 4:0): configurable broadcast address (0–31).

Given this, I would like to expose these capabilities to users.

Before implementing anything, I would like to ask for guidance on the
preferred way to expose these PHY settings to users. Specifically, I’m
uncertain whether such configuration should be handled through device
tree properties, PHY tunables, or any other mechanism considered more
appropriate within phylib.

Is there a recommended or established approach for enabling
user-configurable broadcast behaviour in PHY drivers?

Any feedback would be greatly appreciated. Once the preferred direction
is clear, I will prepare and submit a proper patch.

Thanks,
Stefano Radaelli

