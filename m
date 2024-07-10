Return-Path: <netdev+bounces-110575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7C292D35F
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 15:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEA011C209B8
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 13:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A6E192495;
	Wed, 10 Jul 2024 13:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHZLOrhi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475F918FC6F
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 13:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720619465; cv=none; b=uZd+WlVhj+/dMF0hyK3K1C8lpqI+7oN2IT+nWpyGAKCB2R4igOVUFrN7gycVX+F292hgBcg8mA5m/CMpYmWOTx04De1RWMDhwZRluyPnBwvNX00NI3SjxhcRhjHZQyLk4jAn7gSfp3uiW4BcTdR+LExxOkoYak50AuXoKq82IlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720619465; c=relaxed/simple;
	bh=iILkPPepP8T7L6A3RE9AG96AbvTOtU9/uMSRrHzWwTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XGK6glDysZFrJ79+3kVg6nVxEXUvkTavJRD4z6cmb7p9fbeOS98O0hJZwKEeNMZ6I6aNNl5WhBDQ/03Q6UpfTnvSN6HmZrR3BiC/HTAgJ08e4iNF1a61sDE8ZDHYf3eujdqldVX3fGAXc7Z2kY0yDgunCL8mWJ/Yjupiuiwb9mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PHZLOrhi; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4266ea6a488so21742115e9.1
        for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 06:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720619462; x=1721224262; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PETC0Jem+LfEFjzFI+xldXy700gS3dLQQLwCqMFVEj8=;
        b=PHZLOrhicM2dPHcLr0QzK3Z9y9L9k23MNP+rnZDvlrpa4Y6KBh1A3OxB1JHEdlnoXa
         fH/2Ge53smbCd62uUME2HOmN88EmJtHZGo34V28I7QWJ3rwvE7PwTm+1uWe/Ja9y1ByQ
         eL6qxdcGDusgAArpxMqitufyeqiHTmLDfAs4Cc9uzlrUGIzMoTsVuQMygmIuI7odD6mW
         Bulqz28FfUCq1Azy96j/twX2sAAWT6CNAuDQ7wSDjY2+Vy5vxsO3uyyrrlvAUoPFRp0W
         4ow1MwjWh4u4xB2mM/G09KgDG4q7OZ2xvUJYwgqswZ6lrrJKizhYeOQalCjC5Ufo2X1T
         29Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720619462; x=1721224262;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PETC0Jem+LfEFjzFI+xldXy700gS3dLQQLwCqMFVEj8=;
        b=FYE9AUpWGwMF38G8YlKPNQHHyBw+fXr0ruSjMTrjDfTnnZNgnd8FTfWODkN1xShd7A
         Wdqip2gnDd1co6mmIqahrPQiVZq2VHujtQasQe8/p1rFJ3q1yKIqzOTW8k+TdlGH/QxT
         +nZX42PlXS8kTxE4lPGO6uyA7fyzyxEHH6/zs9Sgfbr5KB3Sd6PzqOHQX7ZNf535bsGS
         QCPrJnSIbDvxqufMrMq0YSnkqkaGsqoyW2ZU/P0fza0938sENhp8LIuCYPRYApMSxCjm
         r9wcMT91ZDz/UdPSZcUcfKUaESrEza8+hoic4cxT1Dn1oCGSpKKSTlBqJqC44vI5MNC8
         Cm5w==
X-Gm-Message-State: AOJu0YxEhTIayhOhGMqH2vEP1F+LclpE7rtJYUV9TzXIN+5vFFrfloAt
	F7ARna62dIi2gDR5RmNbeN9Kad32BD/RcDKCcX0FeGAjihX/KhrK9x204tge
X-Google-Smtp-Source: AGHT+IGpGG0yxdOdNRU7gLc/bqTLZpsdVU47mEGb0zKui4YggL+9EYBVk9a5KjxSv2mvPSt36q6rHA==
X-Received: by 2002:a05:600c:6b0c:b0:426:673a:2904 with SMTP id 5b1f17b1804b1-426708f1e11mr46575235e9.36.1720619462290;
        Wed, 10 Jul 2024 06:51:02 -0700 (PDT)
Received: from skbuf ([84.232.196.157])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266a38f5a5sm119795495e9.43.2024.07.10.06.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 06:51:01 -0700 (PDT)
Date: Wed, 10 Jul 2024 16:50:59 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: netdev@vger.kernel.org, kernel@pengutronix.de,
	David Jander <david@protonic.nl>
Subject: Re: Issue with SJA1105QELY on STM32MP151CAA3T over RGMII Interface
Message-ID: <20240710135059.jwtfofi3r3zdfsd6@skbuf>
References: <cover.1720512888.git.0x1207@gmail.com>
 <d142b909d0600b67b9ceadc767c4177be216f5bd.1720512888.git.0x1207@gmail.com>
 <b313d570-e3f3-479f-a469-ba2759313ea4@lunn.ch>
 <20240709171018.7tifdirqjhq6cohy@skbuf>
 <Zo6NIINGn53fIa5M@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zo6NIINGn53fIa5M@pengutronix.de>

Hi Oleksij,

On Wed, Jul 10, 2024 at 03:31:12PM +0200, Oleksij Rempel wrote:
> Hi Vladimir,
> 
> I hope this email finds you well.
> 
> I'm reaching out because I'm having an issue with the SJA1105QELY switch
> connected to an STM32MP151CAA3T over an RGMII interface. About 1 in
> every 10 starts, the SJA1105 fails to receive frames from the CPU.
> Specifically, the p04_n_rxfrm counters stay at 0, and all RX error
> counters are zero too, indicating that the port doesn't seem to see any
> frames at all.
> 
> I can reproduce this issue even without rebooting, just by using the
> unbind/bind sequence:
> 
> ```sh
> echo spi0.0 > /sys/bus/spi/drivers/sja1105/unbind
> echo spi0.0 > /sys/bus/spi/drivers/sja1105/bind
> ip l s dev t10 up
> sleep 1
> ethtool -t t10
> ```
> 
> Running the ethtool self-test is the most reliable way to reproduce the
> problem early without additional software.
> 
> I've checked the RX_CTL and RX_CLK lines of the SJA1105 port 4 with an
> oscilloscope, and both look correct and identical in both working and
> non-working cases.
> 
> Interestingly, the external RGMII switch ports are working fine. I can
> bridge them and push frames in all directions without issues.
> Transferring frames from the switch to the CPU works fine as well, which
> makes me suspect that the problem is isolated to the reception of frames
> on the CPU RGMII interface.
> 
> Is it possible there's some RGMII-specific race condition during the
> initialization stage? The bootloader implementation of the SJA1105 on same HW
> seems to work fine too, so this seems to be a Linux kernel-specific issue.
> 
> Any insights or suggestions you might have would be greatly appreciated!
> 
> Thanks a lot for your help.

The symptoms sound awfully similar to a situation described in NXP
document AH1704, chapter 6.1.13.3. I can't disclose anything from its
contents here, since it is not a public document, requiring, AFAIK,
sign-in.

But there have been workarounds implemented in other drivers for this
particular issue, used as DSA masters for this switch. For example
commit 4fa6c976158b ("net: stmmac: dwmac-imx: pause the TXC clock in
fixed-link"). If you get access to the NXP document, maybe you can
confirm that the circumstances leading to the issue are the same, and
you are able to implement a similar workaround for this NIC (also stmmac
driver, I believe?!).

Hope this helps.

