Return-Path: <netdev+bounces-50436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 231F17F5CEE
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 11:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCC7B1F20EF3
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 10:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC8B224F2;
	Thu, 23 Nov 2023 10:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WHIU/lqr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85A5D48
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 02:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700736782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IXLK87Gcm11x8erF5WfjVLPG8Viyp7jopv776YPzK/A=;
	b=WHIU/lqrDN2uFO5p8VJrsvGmoJssalBrowd3SDpGfmqXHvIKiJtkf6G3BrnoF6A77iHXVJ
	7lWuQ04qJWBKsExSr29BfXOjWROftee4X96HP5cRvCQlO0cPi0d/5PcjuzPWMZts7Np7qP
	hGPMmOxfqeE9bjLDJtNlb1oYyuj59MU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-S0R4WoTlNAW2IiqvrewWYQ-1; Thu, 23 Nov 2023 05:53:01 -0500
X-MC-Unique: S0R4WoTlNAW2IiqvrewWYQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a043b44aec3so12989766b.0
        for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 02:53:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700736780; x=1701341580;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IXLK87Gcm11x8erF5WfjVLPG8Viyp7jopv776YPzK/A=;
        b=Fjb4yl1QtSkhQvuTA40fbkNzMLbT/mQLAwGyasUZDZofun2xhci71sEn5SGzXtZDAr
         uqep5Q/4BNv4zOp4+Ju0o3Wp79/6nFwIX3qBFgeTA/ubsx55WBWq8ZoOrG9M6gVhglgn
         2eYrk5Av7jFaN1j4MtcJpKmGfrMMgBn/4Y9gTTy/fTGL/wPe+WqenLOAO6VgzkQI9J0m
         Nwwte3MfL5PJ4UU0wAPbYQMliXGQ5MVgFDXSDE6XjLh9JGQZ+1CvG2ievR6IdGbVRs/o
         T/zKp1npyd3xOQdRT7lvN+UUmQVlRhJL2V2B5SG9CChM9JXjIhUR7n1jqRX5kfaryc0g
         GpCw==
X-Gm-Message-State: AOJu0YxqYW/ecThCoUVvYBTK9p2+F+2n0/7hCqBul/+Mfu+Dopa/20Zp
	QZ1okzsCoLwzSjbFJEyVgmakkC77xYcjms7qQAS/TgxeM6mpBZVfyKxJLmOSropmlNSluX+C118
	ybs4EA2YLmKO10meC
X-Received: by 2002:a05:6402:2903:b0:542:1ba5:68a4 with SMTP id ee3-20020a056402290300b005421ba568a4mr3475973edb.1.1700736779876;
        Thu, 23 Nov 2023 02:52:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IERO/BGFULCn5Fi994nJ7tXuKoWwNihWZNkcH2ht0W/yvXlyDrzAOT0VxqvY3IMW2y+Rxph7A==
X-Received: by 2002:a05:6402:2903:b0:542:1ba5:68a4 with SMTP id ee3-20020a056402290300b005421ba568a4mr3475958edb.1.1700736779528;
        Thu, 23 Nov 2023 02:52:59 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-241-213.dyn.eolo.it. [146.241.241.213])
        by smtp.gmail.com with ESMTPSA id k7-20020aa7c047000000b0053de19620b9sm511862edo.2.2023.11.23.02.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 02:52:59 -0800 (PST)
Message-ID: <35045f6ef6a5b274063186c065a8215088b94cd5.camel@redhat.com>
Subject: Re: [PATCH net-next v1 3/3] net: dsa: microchip: Fix PHY loopback
 configuration for KSZ8794 and KSZ8873
From: Paolo Abeni <pabeni@redhat.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, "David S. Miller"
 <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>, Eric Dumazet
 <edumazet@google.com>, Florian Fainelli <f.fainelli@gmail.com>, Jakub
 Kicinski <kuba@kernel.org>, Vladimir Oltean <olteanv@gmail.com>, Woojung
 Huh <woojung.huh@microchip.com>, Arun Ramadoss <arun.ramadoss@microchip.com>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org,  UNGLinuxDriver@microchip.com
Date: Thu, 23 Nov 2023 11:52:57 +0100
In-Reply-To: <20231121152426.4188456-3-o.rempel@pengutronix.de>
References: <20231121152426.4188456-1-o.rempel@pengutronix.de>
	 <20231121152426.4188456-3-o.rempel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

On Tue, 2023-11-21 at 16:24 +0100, Oleksij Rempel wrote:
> Correct the PHY loopback bit handling in the ksz8_w_phy_bmcr and
> ksz8_r_phy_bmcr functions for KSZ8794 and KSZ8873 variants in the ksz8795
> driver. Previously, the code erroneously used Bit 7 of port register 0xD
> for both chip variants, which is actually for LED configuration. This
> update ensures the correct registers and bits are used for the PHY
> loopback feature:
>=20
> - For KSZ8794: Use 0xF / Bit 7.
> - For KSZ8873: Use 0xD / Bit 0.
>=20
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

This looks like a bugfix, so possibly worth a Fixes tag? Given the
dependency on the previous refactor, I think we can take it via net-
next.

@Andrew, Florian, Vladimir: do you have any specific preference here?

Thanks!

Paolo


