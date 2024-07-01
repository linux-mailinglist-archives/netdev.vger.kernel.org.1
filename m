Return-Path: <netdev+bounces-108195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E58291E524
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 18:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A8F71C21966
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 16:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9738616D9A8;
	Mon,  1 Jul 2024 16:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m9dNU21d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19352562E;
	Mon,  1 Jul 2024 16:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719850829; cv=none; b=SGtrHWaNHA6zOTkxl1uk+kPz59DQq+LAwMOwTA6LjIxU1We8AW2ZYWy9vT5CvPmRd6SzIt6xJgkQF9qcGEzEdoJ0qNSg8hEiW7vnMtHdbwQXSQhCfpcBYGduSVhbh310UqWLxtTvtqvV+sEaAX9GOjm70pt9YkrzRozWnuj6y/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719850829; c=relaxed/simple;
	bh=S/R++AII8ngzfbDb/nf4lzodY4Ba0LHHOcECk2RofcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oRWcxXryuZtLWD7Z2svR0PKPWmELiDXr7cPW0J4Lk+VbH2WxrVR+B98JXrq6rb8qAf+NVUxxybOvHIckyNB5O4B3kdoG77i9qrZBnV0IAjDHmXwIRcd9yV3rgoZyi4/GA6+kr0doxqk7JCvHa+pXu2XDEAQmE1wLOb5kgLK+WOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m9dNU21d; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-424ad991c1cso29045305e9.1;
        Mon, 01 Jul 2024 09:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719850826; x=1720455626; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=03jaIfR4+AftPCw/Pzy2wkf+Ou4Nu8sFqElvN3nSwrY=;
        b=m9dNU21dCQNYGniFseZa8yYNqWrIXfxBx14g+dMcWGtlNjDSvDcO24tnh+zyRWngky
         LxLR1sxfrPQriL2Q7Hihj/TtGT69630p4tzmp5v/HPsTT/43shbEt/ZYTRhgn8L6Q5/d
         Q1D5ZbFmnpVL3kPkil8QwdavhVneyKIQdTRMGBbvxIDXrFfzv4CdSFFtZtsvaHOcxh97
         ByZxSTd2TjuMMRNsIcgnJcfywHcf/s+sMyrR7yyrIcoeMi9dNu080gAUVkpllT1ioGOD
         y1NohkINfppevzlw4O8F1TPYg2iIcjOzskuHGmqjohJoouuf82Zi9AIlp+gW9tAqF1aS
         /zpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719850826; x=1720455626;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=03jaIfR4+AftPCw/Pzy2wkf+Ou4Nu8sFqElvN3nSwrY=;
        b=QJaiv9cBnxCCa9gUoMVQyN3Moi0RUHFNwz6RD+l+b8RGlZoC/tycerGTyXaRy2Rg/P
         XE2X15Cd9H3Kb4QzrHnl/IhrXiT1HQZlTHAg536Gx6EY/YUZRpUbtwAx3pnbnKEcaIS4
         hSJMCYqJsxXNMTibg1tqlfeTzWroFon42+I/FdwxuFQDjvXpGwvNvJ92S24v8JnS0QX9
         X7KrWL4K/FBRLDx75GPEbce2h6Rr1LWoTqY0GV+x5Tc90BFSVEUFLnGz42K4iukRo09f
         PEot5yL71pbXKU174HNTd7g20v28eyVkPZSr0j+Zgx2xkNNvaDnVP4cWdYirIYLOl0Gg
         xvQw==
X-Forwarded-Encrypted: i=1; AJvYcCX2wzdCa7OpeMLnJBa6LAXoT/pKpEWm5otoRQcC3t74j735ETmZNB2KC8ItEiQierd/myczujS3YWvcI60r0x9qiB861HRc2EJy8KNb5Tk8i4tIztUp4R9gK6pY1XfC4TAb32dE
X-Gm-Message-State: AOJu0Ywn3gE+dSRMbG+kVlThhtgKmMexGePFizO4yoGlyBSkUUjlORm6
	lPQ+UogeQgFwlD7lbR4oh1bewEcxIX/0T61r58XoYm457G7ZYE2JS9r1p9ss
X-Google-Smtp-Source: AGHT+IH6HsIv+xupGThc6vN8ICcknpwdIRRfg2z4PazeZTqVnToq94EqT/Qhlaw06xo5adp3r+fSvQ==
X-Received: by 2002:a05:600c:2318:b0:425:6a52:eaa5 with SMTP id 5b1f17b1804b1-4257a02d3a0mr42234275e9.41.1719850825819;
        Mon, 01 Jul 2024 09:20:25 -0700 (PDT)
Received: from skbuf ([79.115.210.53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b09a94csm159928295e9.33.2024.07.01.09.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 09:20:24 -0700 (PDT)
Date: Mon, 1 Jul 2024 19:20:22 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Lucas Stach <l.stach@pengutronix.de>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next v2 2/3] net: dsa: microchip: lan937x: disable
 in-band status support for RGMII interfaces
Message-ID: <20240701162022.yqf4c6dblz2wjyzy@skbuf>
References: <20240701085343.3042567-1-o.rempel@pengutronix.de>
 <20240701085343.3042567-2-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701085343.3042567-2-o.rempel@pengutronix.de>

On Mon, Jul 01, 2024 at 10:53:42AM +0200, Oleksij Rempel wrote:
> From: Lucas Stach <l.stach@pengutronix.de>
> 
> This driver do not support in-band mode and in case of CPU<->Switch
> link, this mode is not working any way. So, disable it otherwise ingress
> path of the switch MAC will stay disabled.
> 
> Note: lan9372 manual do not document 0xN301 BIT(2) for the RGMII mode
> and recommend[1] to disable in-band link status update for the RGMII RX
> path by clearing 0xN302 BIT(0). But, 0xN301 BIT(2) seems to work too, so
> keep it unified with other KSZ switches.
> 
> [1] https://microchip.my.site.com/s/article/LAN937X-The-required-configuration-for-the-external-MAC-port-to-operate-at-RGMII-to-RGMII-1Gbps-link-speed
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
> changes v2:
> - use ksz_set_xmii() instead of LAN937X specific code
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

