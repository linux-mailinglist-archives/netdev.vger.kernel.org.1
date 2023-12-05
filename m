Return-Path: <netdev+bounces-53905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D798052D0
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 12:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 959032815AC
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 11:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8836979C;
	Tue,  5 Dec 2023 11:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQu4q2yL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8572134;
	Tue,  5 Dec 2023 03:28:00 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50bf7bc38c0so2455868e87.2;
        Tue, 05 Dec 2023 03:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701775678; x=1702380478; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/v7mvN9deEkGkoO3uLhdgRvmngCCOUew4NWi2nI998Y=;
        b=fQu4q2yL3XukflwhZ5VcRL/lOS5sePv6kFbOW4t4FdNWwqe1aRT5DH458J10CshIAE
         pwFZvaBtm9ev2MbS7q9LKQeHtVy8BsYnsS9Cb6DmYtHqaiZZ/u/+9QXA/Zbb7Ja7JbFh
         3mgXwMZ5NAC2/O3dPIxX+9v0Fi4cuExcqSg44JMEMuosArNuoOOPJX6dDUpEW0ry0SYO
         nvquXwBDM5F/oQmyd9HmuSoZW5M5HVzX4u6ZdP/fQim2hIOGqY2ZlnRkreEogXsVgvdj
         XUjV7QlvPHR78USWexP89poyD4AVagFwhaA24N1V7+v0ARrC9oEIUemVEH5SrYe+ny8R
         +tNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701775678; x=1702380478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/v7mvN9deEkGkoO3uLhdgRvmngCCOUew4NWi2nI998Y=;
        b=snFGANytkuAgvq8Pls+Z9PzAABwljRSN0y9evuBmr1QD/xFzm7czpQGv0o7D8fL1e+
         ULNagKtBufeaIq4/orqkSEEcO651Aat0ZhBkl2JxIzLx1P/lU3W+GfuwqOcASC7O0l5m
         ehzmtK5xrDuo+8uw26QyFh35Qi0eXvRrYTn4aXj8vGLbYGPkTn6v/c2rj/H7ptc6zt8X
         PpnrVWWkTGhQ9mS4OT1w+B2DiFJJue6P8hdnLbRtvkc807nhplBNNExWU/OhWdz/QaIG
         YWLit7XvQN6zvZXbfMg40GZnhy9QN6hPSOOcueaDxxL9pBPowEvIkyPlcrMQF33JYj3t
         qU+g==
X-Gm-Message-State: AOJu0YxIst/HGgHDT5WhGbg7We2T92tMOnhfYeG/+hBvfTtcFRgYyHXa
	VLrRVyI+lDwjPpQV+NbeLv4=
X-Google-Smtp-Source: AGHT+IFe2lA1Mf/Iiur7xxZp+MD/kz1MnNPCSfxB6taRVzZdr7Y41r+BOmqbXfAuO7Wa25P9mapKFw==
X-Received: by 2002:a05:6512:239e:b0:50b:c30b:813a with SMTP id c30-20020a056512239e00b0050bc30b813amr4383751lfv.53.1701775678111;
        Tue, 05 Dec 2023 03:27:58 -0800 (PST)
Received: from skbuf ([188.27.185.68])
        by smtp.gmail.com with ESMTPSA id cf6-20020a170906b2c600b00a1937153bddsm5951892ejb.20.2023.12.05.03.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 03:27:57 -0800 (PST)
Date: Tue, 5 Dec 2023 13:27:55 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	openbmc@lists.ozlabs.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 05/16] net: pcs: xpcs: Move native device ID
 macro to linux/pcs/pcs-xpcs.h
Message-ID: <20231205112755.3am2mazwireflpkq@skbuf>
References: <20231205103559.9605-1-fancer.lancer@gmail.com>
 <20231205103559.9605-1-fancer.lancer@gmail.com>
 <20231205103559.9605-6-fancer.lancer@gmail.com>
 <20231205103559.9605-6-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205103559.9605-6-fancer.lancer@gmail.com>
 <20231205103559.9605-6-fancer.lancer@gmail.com>

On Tue, Dec 05, 2023 at 01:35:26PM +0300, Serge Semin wrote:
> In addition to that having all supported DW XPCS device IDs defined in
> a sinle place will improve the code maintainability and readability.

single

