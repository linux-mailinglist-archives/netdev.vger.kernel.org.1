Return-Path: <netdev+bounces-105240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B20A9103AB
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 14:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31D3A282306
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 12:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A1E1AC243;
	Thu, 20 Jun 2024 12:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ihl6J/oF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522AD1A8C02;
	Thu, 20 Jun 2024 12:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718885208; cv=none; b=H2jQUVWyTwAp46Gq+m986kxQf1QqnFaqKFeIzBDTpxWqWtzu+/xw00Dxh5dR+cv/9XLlFgZyRkw/c+cxAsXIiwiGE5ZGdufUfTvCZFXGO4mq8yNiF5E2iYhVx882lOffg0ZP2ZlpN3FfCJqqGqLNSiMnRRyx1owBXIpuLOp+h0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718885208; c=relaxed/simple;
	bh=a5xdK0JRPyJDye1/3r1T9m7F3uYxAPruhNrFzDhoaWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fbkKb1xIheHKLHbfV6L0vyF3sSIDzgJp0dEtjL+FI6XJBmNk0xquTebsEii9sXmO2HmQpK5aZ6o+LrMFTc/kkViY9057E+Ue/ReTEh76NthmdS2YU5x7whKES0PCeoPa4oU3zOw/jdLmsUrsOer7EZ4FuvgYD40GpYQtd4beJBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ihl6J/oF; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57d1782679fso921432a12.0;
        Thu, 20 Jun 2024 05:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718885204; x=1719490004; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a5xdK0JRPyJDye1/3r1T9m7F3uYxAPruhNrFzDhoaWA=;
        b=ihl6J/oFF6dLrx6UxqPXwTw3W6ylGIaiPkwh/PzH65QI9e85hDQHUKJD9WcnTUlWKS
         o/tRPDLPwkPyhfBF2LN3zCHujjqIqaEdTdKzPQgYA2vsVqqZF+qNl3LYB9tdw0G9+bL5
         MXgG6LvACI/1yFgx+ViYoU4WyDxxsA0AlF3hpvDhYg5U/PNqZHDutblI2L6naqxpsZok
         5H+vYbju0Kg5KTiehLO5I1VwVsTe4E3Pz0aJaqTcOT+h+rxHAo5KQirsqXAFPT2ohaS/
         YLTuigtfEkKYtgpqGd8WqVFEpGoYrWYqa1YF/M6Enf4NKIOLJvfdVfGbDT3toUzI+lBE
         g5PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718885204; x=1719490004;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a5xdK0JRPyJDye1/3r1T9m7F3uYxAPruhNrFzDhoaWA=;
        b=w+TQO/UNQFC7ZSSvA4iB0gDq4vi4A4bl4TnZglPmO03CkFLb29FUaqte8Crqcgpfs2
         jmO9jFK5nndGNXnRsrsdc/Rvm7wKU7jPkPVPu0ynUA1v970HnRyEJFmIgrJFYhmSDq1G
         e6Qr/iJ5TR8vypDNivTUOACcBdyG3J/SIzQtOh7iwP7cNMX/NLn68O2CzjTRqNSNNveY
         WEFg44Pm5wgTvng3uTvy747/jqOHsIUBWTSUr/BWkuwVEHUiuzB9pt5mgJ7hNnmD25r1
         4f95B+Ozo4hRwBxfHsi4GTqOfq0GWa1Vfz/nONMIDecWzB5yK1uqTTLaSJRvcLdSGi5c
         i8VA==
X-Forwarded-Encrypted: i=1; AJvYcCV5F78ofWtib6a3arIXD4KKqjQQ99dAyRK5SiSLio0h8Qbb9vFNEi3eBmX7OgMylBiYtn7bdt5KeBF6xAfXR5666S87e8lRuq/qqrgXCfdZBqEpxs/4dWPRguHVQgBslbFbqvFv
X-Gm-Message-State: AOJu0Yxj8xWMx8vjU390v25isMqYS3aCQA2dX3crwzyJGT7CXOG1oeem
	Rswoy0tg3HtmKinmvUu7KAaWN3RTmqX6oKXe/dX5CEezE604kXk6
X-Google-Smtp-Source: AGHT+IGCnmWLe2uBXVUqMKg8aNOlpJuUDO24AhQ+OGHnDlQDlzPSh+dd57MqbVJ0IlofdSox5ozYcQ==
X-Received: by 2002:a50:d613:0:b0:579:e7c5:1001 with SMTP id 4fb4d7f45d1cf-57d07e6f4ecmr2867294a12.23.1718885204220;
        Thu, 20 Jun 2024 05:06:44 -0700 (PDT)
Received: from skbuf ([188.25.55.166])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb72da156sm9552286a12.22.2024.06.20.05.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 05:06:43 -0700 (PDT)
Date: Thu, 20 Jun 2024 15:06:41 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Lukasz Majewski <lukma@denx.de>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Oleksij Rempel <o.rempel@pengutronix.de>, Tristram.Ha@microchip.com,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Simon Horman <horms@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	Casper Andersson <casper.casan@gmail.com>,
	linux-kernel@vger.kernel.org,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v2 net-next] net: dsa: Allow only up to two HSR HW
 offloaded ports for KSZ9477
Message-ID: <20240620120641.jr2m4zpnzzjqeycq@skbuf>
References: <20240619134248.1228443-1-lukma@denx.de>
 <20240619134248.1228443-1-lukma@denx.de>
 <20240619144243.cp6ceembrxs27tfc@skbuf>
 <20240619171057.766c657b@wsk>
 <20240619154814.dvjcry7ahvtznfxb@skbuf>
 <20240619155928.wmivi4lckjq54t3w@skbuf>
 <20240620095920.6035022d@wsk>
 <20240620090210.drop6jwh7e5qw556@skbuf>
 <20240620140044.07191e24@wsk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620140044.07191e24@wsk>

On Thu, Jun 20, 2024 at 02:00:44PM +0200, Lukasz Majewski wrote:
> In general I do understand your concerns - however, as I've stated this
> patch fixes oddity of the KSZ9477. I can test it with it.

> To keep it short: I do see your point, but I believe that it is out of
> the scope for this particular patch.

So that's it? Can't test with anything other than KSZ9477 => don't care
about anything else, and will ignore review feedback, even if the static
analysis of the code plausibly points to a more widespread issue?

As the author of commit 5055cccfc2d1 ("net: hsr: Provide RedBox support
(HSR-SAN)"), who do you think should be responsible of taking care that
it plays well with existing offloading drivers?

