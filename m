Return-Path: <netdev+bounces-51067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB77A7F8E1A
	for <lists+netdev@lfdr.de>; Sat, 25 Nov 2023 20:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9608B2814A0
	for <lists+netdev@lfdr.de>; Sat, 25 Nov 2023 19:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1E82FC4E;
	Sat, 25 Nov 2023 19:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0MOXw5h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4577E11F;
	Sat, 25 Nov 2023 11:41:05 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6cb90b33c1dso750113b3a.0;
        Sat, 25 Nov 2023 11:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700941265; x=1701546065; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iy7SwsPVaJEnyI1tWMjP5+ui6BxrU7dGAsXEUl2jjh4=;
        b=Z0MOXw5hqh110la6jUCgkZXLc2upmNKJL29epsvDeeZhSlVYgWOkKbIZVCtFtxxe5x
         JQtjs6DI6s2BKqP+Xss9ea3zhl/16o0ESBCEUb9TgSSlExKDvyQi0gGc4baWE2wPBGRu
         7Dvb01fpmWZPoV6iNUk6BoKxkyaSt9ReBOXyd6SPALK1IrL5EnDEPUHiwKieA8PNpFfV
         FkEnQNGSCkkFuN/4dw9FzqbM02iWZFYmVIlkv0eJQVdWIL2TU0wR8P1R/YycvMkLz4HK
         KGqbbfltJR9nm4irsHLCjJ9zLhTJMShjVFsRlI9tP6nHulPQdNiGuIS/kcjHO8SB3HTm
         Kjpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700941265; x=1701546065;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iy7SwsPVaJEnyI1tWMjP5+ui6BxrU7dGAsXEUl2jjh4=;
        b=L4PRwqzrj2SGHGR6mGbnP6REwRuRsevLdrLS7qG9ooqL8bK6VBCbu8wQkvjiWLkpoY
         9QJVLbNSTTOyHar+oALkZ59V0bGlFcED253irHfkO9+24R83PC09uYNevYBujEtjgikP
         4ES0v2+tjwHgY9PouWJ0hqTVwar4Nh9IsREMp+yPkUOIDvQCuT37nf2vNA/eV1LbCWjg
         aH3lEInwGVG7d1M3/OgIZJhwPIBw+e4Z/WA2ZHgTMazawKlHr0lPkAi/ydMYeXVj9rFh
         TWa3y4RXUCwLdvp52sursMYIsKf9AFmNQwjVESCFE7SK0+m/FTnEtwI2vHUBmv0aDSBM
         tunQ==
X-Gm-Message-State: AOJu0Yw9r3UOwdnQfkn4zLiLr/eVPZTB9kAmqpsJsjzpcci5l+xKAfSJ
	HqEjrqqekmnmRBCpOQdVJYA=
X-Google-Smtp-Source: AGHT+IHqLYq/7MAMxpJAq4o0IMFeED9ZEY/RDkKtbgJCkiYH7uGM24csKtIAm+7hgiKzYoJDEaka9g==
X-Received: by 2002:a05:6a00:2d86:b0:6c4:dbb5:a340 with SMTP id fb6-20020a056a002d8600b006c4dbb5a340mr9012454pfb.3.1700941264598;
        Sat, 25 Nov 2023 11:41:04 -0800 (PST)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id h5-20020a056a00218500b006cbafd6996csm4643172pfi.123.2023.11.25.11.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Nov 2023 11:41:04 -0800 (PST)
Date: Sat, 25 Nov 2023 11:41:00 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: Willem de Bruijn <willemb@google.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
	Jay Vosburgh <j.vosburgh@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Mahesh Bandewar <maheshb@google.com>
Subject: Re: [PATCH net-next v7 15/16] net: ethtool: ts: Let the active time
 stamping layer be selectable
Message-ID: <ZWJNzNjqudncm1mr@hoboy.vegasvil.org>
References: <20231121094354.635ee8cd@kernel.org>
 <20231122144453.5eb0382f@kmaincent-XPS-13-7390>
 <20231122140850.li2mvf6tpo3f2fhh@skbuf>
 <20231122143618.cqyb45po7bon2xzg@skbuf>
 <20231122085459.1601141e@kernel.org>
 <20231122165955.tujcadked5bgqjet@skbuf>
 <20231122095525.1438eaa3@kernel.org>
 <CA+FuTSe+SOFciGf+d+e=Co22yZ56gGGkJ0WBbvfT-2P0+Ug8DQ@mail.gmail.com>
 <20231124172754.tneftor7uobrul5f@skbuf>
 <CA+FuTSc7aEokNcY2sJeDZQe3_iV9ARC_1hov=9-wTzdMAkcayA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+FuTSc7aEokNcY2sJeDZQe3_iV9ARC_1hov=9-wTzdMAkcayA@mail.gmail.com>

On Fri, Nov 24, 2023 at 02:45:46PM -0500, Willem de Bruijn wrote:

> Expanding the skb infra and cmsg might be follow-on work.

Yes, and would I suggest limiting the scope of the present series just
to allow changing the global, device-level time stamping layer
administratively.

Trying to support multiple time stamps from different layers is a much
larger development project, and it will require new kernel/user
interfaces.

(Of course it would be grand if the series is forward looking to the
day when time stamp reporting expands beyond the current hw/sw cmsg.)

Thanks,
Richard



