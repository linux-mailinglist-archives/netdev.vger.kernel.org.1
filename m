Return-Path: <netdev+bounces-150888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9EC9EBF94
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 00:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB5C31673B2
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 23:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DE122C35D;
	Tue, 10 Dec 2024 23:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2m4GfAW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC59A22C352;
	Tue, 10 Dec 2024 23:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733874492; cv=none; b=t10wnUMdxAwF5lrweccM28fyaQBYPBi+tg3CmtHnhGiWTGs/XLdzPjF4hemzClQ72U0I9lossHosQcBbgGp2WS+LjMnx6RC9m3PM/h593cYNMas0TKK4bkjzkwtVkrfVyGUAr5fKsgCt4bf3svW+Z7szRorI/9ww6ZLprx4BCJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733874492; c=relaxed/simple;
	bh=hS77lKS+qrbWJBqTrtJwzE+mtelSylzhjNAlP86Biz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nRLbzQIR1tPTafX/gc8xWz9pG/5hY5dDkcPUjzi78lP8qxJ2+sLKFM5MQFrZ9SVcJHKJTgv6ufnFH2H7gxsS4gBCzatDCWjDQxCEkGyb6NKqOJRdczlGR9FqZ1mTdACM0La3n69R06tIhQLYlixEQmZ/EO6M0KzOgASq1iC6NPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P2m4GfAW; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-434e91ac3d4so2716975e9.0;
        Tue, 10 Dec 2024 15:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733874489; x=1734479289; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f8UnOGblbQirPOg8RONWJpR4qniXeIU9augpkXN+BVE=;
        b=P2m4GfAWKfhlGVNXuN101Kn66EhjOSguKFPnE0u4NzHJvCHN+RH4zEtW7S5CxmJU1Z
         LS9B8A8VrNTREbxWvWf1anZl9DTaFZvtF3nw1CZJrcUsIT96wuN3nuAljfDJlpXaLmmM
         BLSVNuYNNnVEWXAWBMRPb9+j7JW9p6ts0njwljuWiNztzfHGqdPsNW+MFGBgVqimz76n
         UHfCSDxXmbrIcAP0wdoqubLuQR3WFqCzUXgE8fFgUo41/jFj1S9payyIJTb8mSVG5JeH
         EHxMiHnmx4LBTWTuDpCLD+VBmuNwzNiTVh9HCKEfTj6ceSG5Ooz0sj/G6LsR1jSc2goC
         kEng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733874489; x=1734479289;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f8UnOGblbQirPOg8RONWJpR4qniXeIU9augpkXN+BVE=;
        b=UukBWDMleNeBYw68b5rleNIBhhuIBi+UideepK2IQhnasjhg8zazo96aVg2XYdY2zG
         Oal7rC9tj9iDPmjf74agHq3oxQR3MOYhrN0YCHraLPpIj9dK3R+RHp17v5Rj3ROIiilG
         xGr857LR/DppdT1gz9Lc+i4d850ODfFoyLr5gG1esZfTfx/vxhgT9lrgl+JRCs/vxs02
         mBpstphlCCQQQLgWDKk8LuGXFnBk+xC9l6zW6806A92CGyI8BlV655gscLug+cIAuwti
         CLxZLhQOgIcOF843O98dP5YQrHl6i8YxvncrNTToJHZ9/pczoSGfNNIFRd3i3rSLUNvl
         m1hg==
X-Forwarded-Encrypted: i=1; AJvYcCU2jNBgfrEaN+xqK4EgqelUlBEWUNOafeOLdiYkpc7y385PYmSaTUomv8pxOd6halHptT/3Ukr5IPL4@vger.kernel.org, AJvYcCUp0Xt+030wzGtTozQXFsSWfa7cGmW1lDdTdbgsIsp+y/Hw/x8R2Xv14d0I0mnlPGU+7lY0x7M+gm5TRd4t@vger.kernel.org, AJvYcCW0HKBmiD2YisjPgqwUMaxOTi46uovBUs6BdU0d5nSPaHTiO7MTCk6PzRtw5wIfoK02t4y6rznH@vger.kernel.org
X-Gm-Message-State: AOJu0Yz615epjPXT3anB0xY6Kioe0njCsN9jsYOxUw5+xiL4gEuplTQg
	NSivL+9dOViCsjbqtbBYzWExh5RHhOdeII4LPDKXACOE80Xui46Y
X-Gm-Gg: ASbGncvbCIhZr7VQlMJGAG34UQpPTvd1oGl0Is0pn3KXpOTkgPspDWm3F5vAo9+paVk
	33kkGc2e5r89aGKeUxpAs4pZCZzB5O1i24M3oB2Cw+/KuOFy1oef4x9+AGX9Vo8AyFZNYqRh0l/
	xLmw9NyBKhe6bmj/5RX1ZBWVsBrREUO1c3k8aBotcynbfFw0jZA3p6ETr8Z+WkityGfrN+ykG8n
	+CzoZR6J3V/WVJoED0bqhzodtZDHrg8/AnVuGEEDA==
X-Google-Smtp-Source: AGHT+IGVFyqOsHq8vJbKENcE96HqDNgEWPNEGfHZbGGsVdmVNjmlG8KgXuPni26CXmKkrEf6w3YBNQ==
X-Received: by 2002:a05:600c:35c9:b0:436:17f4:9b3d with SMTP id 5b1f17b1804b1-4361c434980mr1530815e9.4.1733874488791;
        Tue, 10 Dec 2024 15:48:08 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da0d69dfsm203458605e9.14.2024.12.10.15.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 15:48:07 -0800 (PST)
Date: Wed, 11 Dec 2024 01:48:03 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH v11 5/9] mfd: an8855: Add support for Airoha
 AN8855 Switch MFD
Message-ID: <20241210234803.pzm7fxrve4dastth@skbuf>
References: <20241209134459.27110-1-ansuelsmth@gmail.com>
 <20241209134459.27110-1-ansuelsmth@gmail.com>
 <20241209134459.27110-6-ansuelsmth@gmail.com>
 <20241209134459.27110-6-ansuelsmth@gmail.com>
 <20241210211529.osgzd54flq646bcr@skbuf>
 <6758c174.050a0220.52a35.06bc@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6758c174.050a0220.52a35.06bc@mx.google.com>

On Tue, Dec 10, 2024 at 11:32:17PM +0100, Christian Marangi wrote:
> Doesn't regmap add lots of overhead tho? Maybe I should really change
> the switch regmap to apply a save/restore logic?
> 
> With an implementation like that current_page is not needed anymore.
> And I feel additional read/write are ok for switch OP.
> 
> On mdio I can use the parent-mdio-bus property to get the bus directly
> without using MFD priv.
> 
> What do you think?

If performance is a relevant factor at all, it will be hard to measure it, other
than with synthetic tests (various mixes of switch and PHY register access).
Though since you mention it, it would be interesting to see a comparison of the
3 arbitration methods. This could probably be all done from the an8855_mfd_probe()
calling context: read a switch register and a PHY register 100K times and see how
long it took, then read 2 switch registers and a PHY register 100K times, then
3 switch registers.... At some point, we should start seeing the penalty of the
page restoration in Andrew's proposal, because that will be done after each switch
register read. Just curious to put it into perspective and see how soon it starts
to make a difference. And this test will also answer the regmap overhead issue.

