Return-Path: <netdev+bounces-107476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA2C91B252
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 00:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76446283382
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 22:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC891A2579;
	Thu, 27 Jun 2024 22:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6FrE/mG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C052013B780;
	Thu, 27 Jun 2024 22:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719527905; cv=none; b=QR/wOODKR30rlyHIYVUHyZhLPldEYcKtEAIAc2o0JA1Gy256DNJEJpY2P4n+wTw8kmmrcMcTTk4UnO0INAz+u7hvemHtVB3SDzKHDA0ihcW5WH5hJFi93qfecxG/2uKbk9bVCpoQU2AaKM83Vk0vzmaWria49Bbej6rgHlZEbp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719527905; c=relaxed/simple;
	bh=OVlHOjDi8IxYwlmSj6mY1k2g3Dy4cEx5R7hbNn46bvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C5mJgGjBWSkw78wvD8d3MMD1dBMn67LGZs3vlquDAvO77sOaC85EV+fx31Ego3xqM+In2yhxeZD9xS2PlqYb2FDRQtS3EC8zCkxzpyR5DZGtRnI2kAqyuQHEMgYdNsc8pfUEObk7TOPUBMrqCiOBF6Y2H+eRBPDAbxsKtGVpAWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m6FrE/mG; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42562a984d3so14637515e9.3;
        Thu, 27 Jun 2024 15:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719527902; x=1720132702; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OVlHOjDi8IxYwlmSj6mY1k2g3Dy4cEx5R7hbNn46bvI=;
        b=m6FrE/mG9vr23nMzrQ+Z0m03QcG2uiht9J+6/dYOTLkEZjNeExhr2ANv/gH62JtrDF
         WsVv/IdQ2+duT3mNf5mulvXSOzdf4IjJTSogisS8vxEXGgYDxePRYSmuviHNPgg1pH6s
         aslnscWP15cLCeR3nWksRmB2E80OfNSWQahgXG/0sGPawgr188k5QyfCZSlDmEaiVGbU
         bizjDAiEDQHeu2GG38bCwNyqfG13kUI3tK5aXtv3DfxuMg/WMC3hiU2whMh1V9KDBKZm
         gwiIt+HZHL1LOWNgRVxwnAZmJYOPxyxCBxU2nZlOkrLEVUaAXdQlU3xdz7v9TEXXkbB6
         JylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719527902; x=1720132702;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OVlHOjDi8IxYwlmSj6mY1k2g3Dy4cEx5R7hbNn46bvI=;
        b=IRWSMpOK2Jle87w/QFg6oU6SMl+VSbCxUgnvuLSc5lkoGxn9tECZ0vProHGGZMmNjh
         sVA8D1vHmEOOblKQTkuDzkjJ6JlLkQVd/RLCqcCjoEdOoFHPaO2vZcqeydXXlDK98iLY
         hEnYnUh13jyUyQxG5lDshq0FxtmycGijrJcwXJPGDcjuUIucLfWf79OZJOxLU7WO0tAY
         WEMqnsuDkCGWxs/5vMiidpaaaKhD6PkeaOTwACvqHQS1Rc4ZwwaDzUitrHiyl/Y4X58o
         n5wDwGmwHMSgugFGZTsmuy41NtoxH2QSfKJPTDDFZyvFdOdVxCNAINg8/7YeV8Ou4aO1
         hX3w==
X-Forwarded-Encrypted: i=1; AJvYcCU6X69m/T65R0mqLsvCBAMPVz2N4tXyq8Gz4wShkti5t9ki2OOBbn3kESBqdr7h0ouYY3Niq9itBukpFn9h3RT/Lf41Ms9u6NYH6Ezr4sRj8A1hGl0aSUFcPiPPtNkmDj8+16XF
X-Gm-Message-State: AOJu0YyD4sN6gYCOz80pnPgJFCW27V03rKsjCYHdUepfes0Zm9x/r6Aa
	FZwbSJCHX6mowINqIukxo1FvqpC6C1JxtSUSMOhYBq7A+DLc/jHy
X-Google-Smtp-Source: AGHT+IFPTIYH9nTGg6vGR8CzP5K3MyKYcesOle5yeCgFIlRjpbu4WOIbxE07Gx7RM7blR5Q+rKXbxQ==
X-Received: by 2002:a7b:c3d8:0:b0:424:a4ab:444f with SMTP id 5b1f17b1804b1-424a4ab464cmr59072855e9.33.1719527901950;
        Thu, 27 Jun 2024 15:38:21 -0700 (PDT)
Received: from skbuf ([79.115.210.53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af5b66csm9671115e9.18.2024.06.27.15.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 15:38:21 -0700 (PDT)
Date: Fri, 28 Jun 2024 01:38:18 +0300
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
Subject: Re: [PATCH net-next v1 3/3] net: dsa: microchip: lan937x: disable
 VPHY output
Message-ID: <20240627223818.655p2c34dp6ynxnq@skbuf>
References: <20240627123911.227480-1-o.rempel@pengutronix.de>
 <20240627123911.227480-4-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627123911.227480-4-o.rempel@pengutronix.de>

On Thu, Jun 27, 2024 at 02:39:11PM +0200, Oleksij Rempel wrote:
> The VPHY is a compatibility functionality to be able to attach network
> drivers without fixed-link support to the switch, which generally
> should not be needed with linux network drivers.

Sorry, I don't have much to base my judgement upon. I did search for the
"VPHY" string and found it to be accessed in the dev_ops->r_phy() and
dev_ops->w_phy() implementations, suggesting that it is more than just
that? These methods are used for accessing the registers of the embedded
PHYs for user ports. I don't see what is the connection with RGMII on
the CPU port.

