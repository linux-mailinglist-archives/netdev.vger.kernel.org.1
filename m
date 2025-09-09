Return-Path: <netdev+bounces-221267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7808CB4FF6D
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 16:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F2D17AA79D
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 14:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5188D350D45;
	Tue,  9 Sep 2025 14:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Scnpnm3X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8861B334733;
	Tue,  9 Sep 2025 14:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757428212; cv=none; b=TRaQ18frQnvJk80s+xdUk4Qiq0dihhGr8sSVYZO10Dt22iE0pGOSIQ063sB8UxOGSadJYY/ngSIE9qjUyuOS56tMHfj5jITGX3RkU0z367uB/toj0xEs6K9DLLBXYumtrhKCwBRuT/nBFhkk+/w2326q0RTDMw7cKdbXShF5Wts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757428212; c=relaxed/simple;
	bh=zSKE0r4dBm07k5h6P8o0obztxBa+v5VK7BzP5HDhd5c=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=BDXn6TDuPcDc+e+GKTY/UBOVzR8V+dePySXplVyWdZvTF7kUNxlHITd8V4xZkwTT3FNpB437aQdrGKiyD6qwTBfBJ5l8VffwKDiOvlKhjmYHOxc1mMU5w4UrT6N39RO4t6v7++cNFdnCNKermTJBjcnfX8pmzZ16hihzmYVi1LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Scnpnm3X; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45de6415102so20264505e9.1;
        Tue, 09 Sep 2025 07:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757428209; x=1758033009; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ex9qzZ1mjA/DhvzyArS8c+WGxpkWftFnoXjJCl2i/Zc=;
        b=Scnpnm3X5OYYqGvpdkl+RWwftvmsuX4CxEIhNj3z4WZRDdQIzj+s8xzsma0Hkfg86z
         mgdksDmScoAvI8beb/mrd7C849+IijH+Xavxg5wJPHbdE9VoFeKLclDH5Yavxn8++Fje
         U+QQ+NV7G4xIpY9Jx+x8X83hUko58mTYB0JLXP7GYgfyQzO5aAC9BMueJ12LmxukTJMq
         tZ8HB5Db1WvpsWX4dO7lEkodib6DYSby9IZJiYq+c0I73ppPC0/lQya0yt5JByzyWdRM
         j0JSfFMoOvSPwnghREtdWhWEfpQOpvxU+qXcq2sAyqb3rQT9jGxgl+MJri5nIOFlQkr1
         nyYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757428209; x=1758033009;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ex9qzZ1mjA/DhvzyArS8c+WGxpkWftFnoXjJCl2i/Zc=;
        b=l9sNwstszd6i2VirXSbc+NGSx7teBvpVitQvcRIbWi8Q0J5Y2DHF23jMLhVA7OUfyg
         pGbSo8sdrFIAOaWmp10c17tG55S9+BybM0fF6UEkjZUbZTSv/j31tUmk2rsSQ6MZVs/d
         f7CNovUMzzOpQNnNrgE1wy+VMGnLnJdSN8h6sB/MeQ6eTtfHJmzeOtIlGAmP2GRF1gSG
         M+e3Vr83PWOyrVlGySZ2n2FNI2ESqU55Zq5JApGlu/9WaVYExBdVJ/Yu2EHRpK3PZP5K
         HNbzPcvwEO27PuJCyj0BCaaTKbcqtUBLyQU0CMZK50e5CB7c4BBjR9/A2W/Bs7MEc5nq
         SazQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeEsfmLw3Ju+912Kp6cm2zjQgviAc4n5xUcD0T14mnw5UIDi9A7uN2+AS966PrU63YrMRczQdI+5rpTGs=@vger.kernel.org, AJvYcCXkJa0CdyjSebjtPmSargrsopeK0zf597sAJt9X8ynhKdVCiPgSqwlJxic6xdG2XOLtp4RA4sno@vger.kernel.org
X-Gm-Message-State: AOJu0YwvP09qgM/KIkwSsuD9x4VNuIIikNoF26qwamWVSIl/wejVWhDk
	6V0EfPgSnJ5v/Laz9F1Ihd2qsumNW3tqgbd4PlTz+z09A8spxCDWpLIu
X-Gm-Gg: ASbGncsOb52PQZz6iQqD8ZDTfdalUmVPUL+StIMjHrhvqHIdxJ0nWm5C0+33RWyXQZg
	pxpmPoW5wBLUePRBYP+YsUOWFXmCiKw0Zk+wLdOau/L6bZRIIhjYRbIZFk9EAdT0AKRVlbNiCMe
	sUPiInzPkfmH7W4l2u9b9q+HjzpxEmZNq0vei2xhlRe3hIc2lfsLOv/wr8504ZQlrU7oo4Gspku
	YumWCOGczu5lBQhiJ2peuu3XgeTcViH8CWL1fkgtsseHwRrvL6j0atbmkqLL3RpKRNjTi5NZh6t
	hLxH/XpdyCnuGtmbLsxub882ePqTu3tF9FKPDYarCbz8zvxCc1VZtMDY4l2H7h115pggxqe9Byo
	6sSiS7jYxwBXyyk1XaY2Y/MsqeHwbqEcSeg==
X-Google-Smtp-Source: AGHT+IGqDxb7wpLUVcPbCViO4PP7kh8r4pRgwBQupQTTJEmxvS5ynPjzCM3zyXmfjvVT77lInjJHEQ==
X-Received: by 2002:a05:600c:3acf:b0:45d:dd9c:4467 with SMTP id 5b1f17b1804b1-45dde86719fmr112427505e9.7.1757428208507;
        Tue, 09 Sep 2025 07:30:08 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:837:bf58:2f3c:aa2c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7521ca0e9sm3132523f8f.25.2025.09.09.07.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 07:30:08 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>,  Heiner Kallweit <hkallweit1@gmail.com>,
  "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  Rob Herring <robh@kernel.org>,  Krzysztof Kozlowski
 <krzk+dt@kernel.org>,  Florian Fainelli <f.fainelli@gmail.com>,  Maxime
 Chevallier <maxime.chevallier@bootlin.com>,  Kory Maincent
 <kory.maincent@bootlin.com>,  Lukasz Majewski <lukma@denx.de>,  Jonathan
 Corbet <corbet@lwn.net>,  Vadim Fedorenko <vadim.fedorenko@linux.dev>,
  Jiri Pirko <jiri@resnulli.us>,  Vladimir Oltean
 <vladimir.oltean@nxp.com>,  Alexei Starovoitov <ast@kernel.org>,  Daniel
 Borkmann <daniel@iogearbox.net>,  Jesper Dangaard Brouer
 <hawk@kernel.org>,  John Fastabend <john.fastabend@gmail.com>,
  kernel@pengutronix.de,  linux-kernel@vger.kernel.org,
  netdev@vger.kernel.org,  Russell King <linux@armlinux.org.uk>,
  Divya.Koppera@microchip.com,  Sabrina Dubroca <sd@queasysnail.net>,
  Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH net-next v4 2/3] net: ynl: add generated kdoc to UAPI
 headers
In-Reply-To: <20250909072212.3710365-3-o.rempel@pengutronix.de>
Date: Tue, 09 Sep 2025 15:20:13 +0100
Message-ID: <m2ms73k8rm.fsf@gmail.com>
References: <20250909072212.3710365-1-o.rempel@pengutronix.de>
	<20250909072212.3710365-3-o.rempel@pengutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Oleksij Rempel <o.rempel@pengutronix.de> writes:

> diff --git a/include/uapi/linux/if_team.h b/include/uapi/linux/if_team.h
> index a5c06243a435..22d68c0dad60 100644
> --- a/include/uapi/linux/if_team.h
> +++ b/include/uapi/linux/if_team.h
> @@ -12,6 +12,12 @@
>  #define TEAM_STRING_MAX_LEN			32
>  #define TEAM_GENL_CHANGE_EVENT_MC_GRP_NAME	"change_event"
>  
> +/*
> + * The team nested layout of get/set msg looks like [TEAM_ATTR_LIST_OPTION]
> + * [TEAM_ATTR_ITEM_OPTION] [TEAM_ATTR_OPTION_*], ... [TEAM_ATTR_ITEM_OPTION]
> + * [TEAM_ATTR_OPTION_*], ... ... [TEAM_ATTR_LIST_PORT] [TEAM_ATTR_ITEM_PORT]
> + * [TEAM_ATTR_PORT_*], ... [TEAM_ATTR_ITEM_PORT] [TEAM_ATTR_PORT_*], ... ...
> + */

That's a really unfortunate result of word wrapping the doc string from
team.yaml

I wonder if it's possible to recognise literal doc strings, with
embedded newlines and emit them line by line. That would require adding
the | symbol to the doc string in team.yaml, like this:

    doc: |
      The team nested layout of get/set msg looks like
          [TEAM_ATTR_LIST_OPTION]
              [TEAM_ATTR_ITEM_OPTION]
                  [TEAM_ATTR_OPTION_*], ...
              [TEAM_ATTR_ITEM_OPTION]
                  [TEAM_ATTR_OPTION_*], ...
              ...
          [TEAM_ATTR_LIST_PORT]
              [TEAM_ATTR_ITEM_PORT]
                  [TEAM_ATTR_PORT_*], ...
              [TEAM_ATTR_ITEM_PORT]
                  [TEAM_ATTR_PORT_*], ...
              ...

Sure, you might occasionally get some messy line wrapping but I think
that's better than flowing literal blocks of text.

>  enum {
>  	TEAM_ATTR_UNSPEC,
>  	TEAM_ATTR_TEAM_IFINDEX,
> @@ -30,6 +36,11 @@ enum {
>  	TEAM_ATTR_ITEM_OPTION_MAX = (__TEAM_ATTR_ITEM_OPTION_MAX - 1)
>  };
>  

