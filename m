Return-Path: <netdev+bounces-119738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9137F956CA6
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 16:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 473C71F22C01
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 14:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBB916CD36;
	Mon, 19 Aug 2024 14:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6GYpaSp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983C916132F;
	Mon, 19 Aug 2024 14:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724076344; cv=none; b=fp2Ly0mjclLdr4aZuS8j0ogAumdCxkwQcY4nFIfnZQyFGOGgbgcnbhAkPID3pqqKwutEzGBoommaYnmYbbaJrEjilxmXmK37HCkZKFcXOl82g0ds6BWD8uurbIQ4dR757Iu55F1Za47rq5K8XZfTdx+tizygxOD/a0PDRuUfQFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724076344; c=relaxed/simple;
	bh=poqFAvEVQlOfxjKE69lMYBnYNRvjlf6xrPmtNyUdR6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MEp6bDfWyxSFc9nC9dyCOKOgo1OCmyoQX+C8qa852U9HsjezfCob2ZycIhMff4jjK09kQlREplVzBJRur+WeOB4Kscalm2d6V0Dnif0ICi9RKF2cw4a2JEmzuoItA55RrTDupm7l0d+HIMpMJv98md7QokOch0oYIWWjg22awY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6GYpaSp; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-371b098e699so1602323f8f.2;
        Mon, 19 Aug 2024 07:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724076341; x=1724681141; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y5CFj9u1swLAXPzgS9iZSLjV+PqKpmKdc3h7rAvkj1s=;
        b=Y6GYpaSpy7zSmzxQ56RJ7p2MKMXiKssMtCJq2IOQwpkTTka2Ci4UXvFqsR3/wxQga8
         0PuNjincoKtDLpTcalqgYf5saQ+eBBwZ81UDE4PE7vhFxvIkWfHOxNjAh9XF//M2JXoJ
         YwmioX2Vie3rhrWzp+P0EjJ/oGphbUx+W4z2TZ0uM2M69muPU89ppKApquDgmHhDGLE0
         yUTdPqAbR66YqytGX2NiduR8M7dTH6eW3+xMLF0NxJ8uns+xtsQ1azq4G+Pf57nK5Sde
         z1PlCTO5SWzThn9dlvzj8duGbYLGMpMHyergxLDC5KK6p9u6zZJdx+P/MCJY5yzvVCIM
         cwHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724076341; x=1724681141;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y5CFj9u1swLAXPzgS9iZSLjV+PqKpmKdc3h7rAvkj1s=;
        b=CfQbgg1wl6eUDJ8I7rf5wDUxtA4r1Tl8FlpDKnYgw5BKoApw49fDPFP3ABqOIpORZw
         o/TQJ5CfF+6sK9Sem+y0evAnoPY+OLecffOJfJ4YfUlGjOe9zOqZovZRT/XZTDfOOWZQ
         69AHVOWIRy0XXRmPEHXmOoesbvblvxFUwT/SZHnb5MwaZamhNu0T7Qtv4lMrzN6SpXb8
         3U+hi14RDd4fc+fESwn7ZHDuIHBoYR9QxaSJr+ZkT+MJygblTJ4GY/1XnFmDOl3SbIyM
         XenbQPXuSXVAIWTG8UFEUav9m14TolIc0HIx5QCb03GjTo8fgtimhdnjPQ2HidFxBUwL
         O2cA==
X-Forwarded-Encrypted: i=1; AJvYcCWvbnvS9ujDHxzTjzXA1bTNeh1OBxz+H4448j79B/uCXB8Lzgxo7rlZ6PMxGhXkJpO5QPApWF7RGv18JDaw5NIWwUETlaJFo+BbbxhntSWnpNQiBKrzjQnCj98cHO9XvPu+jw24
X-Gm-Message-State: AOJu0YwmwetJQeIBh3Ak/hYHbjx1E9nE3V2U0atd3AZBtY/HS0wDhfxm
	XRYpr7OleFVaR+bDIYFTnn1jh97X4ab2N7arFcSVib1PQO2Ra7lO
X-Google-Smtp-Source: AGHT+IEcbNUMNuANUGAFzJxTVxhsLaTTLTkiGkaBSxdkd6xGargdqf/dmJRCsaSX7yrUke5PPEFUGA==
X-Received: by 2002:a5d:4e4e:0:b0:368:7943:8b1f with SMTP id ffacd0b85a97d-3719468f08amr8350841f8f.43.1724076340309;
        Mon, 19 Aug 2024 07:05:40 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838c66d7sm643445166b.39.2024.08.19.07.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 07:05:39 -0700 (PDT)
Date: Mon, 19 Aug 2024 17:05:36 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Pieter <vtpieter@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Pieter Van Trappen <pieter.van.trappen@cern.ch>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: dsa: microchip: add KSZ8
 change_tag_protocol support
Message-ID: <20240819140536.f33prrex2n3ifi7i@skbuf>
References: <20240819101238.1570176-1-vtpieter@gmail.com>
 <20240819101238.1570176-2-vtpieter@gmail.com>
 <20240819104112.gi2egnjbf3b67scu@skbuf>
 <CAHvy4ApydUb273oJRLLyfBKTNU1YHMBp261uRXJnLO05Hd0XKQ@mail.gmail.com>
 <90009327-df9d-4ed7-ac6c-be87065421ba@lunn.ch>
 <CAHvy4Aq0-9+Z9oCSSb=18GHduAfciAzritGb6yhNy1xvO8gNkg@mail.gmail.com>
 <9e5cc632-3058-46b2-8920-30c521eb1bbd@lunn.ch>
 <CAHvy4Aq=as=K48NZHt3Ek8Yg_AzyFdsmTe92b8SFobzUBM9JNA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHvy4Aq=as=K48NZHt3Ek8Yg_AzyFdsmTe92b8SFobzUBM9JNA@mail.gmail.com>

On Mon, Aug 19, 2024 at 03:43:42PM +0200, Pieter wrote:
> Right so I'm managing it but I don't care from which port the packets
> originate, so I could disable the tagging in my case.
> 
> My problem is that with tagging enabled, I cannot use the DSA conduit
> interface as a regular one to open sockets etc.

Open the socket on the bridge interface then?

