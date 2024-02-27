Return-Path: <netdev+bounces-75378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA649869A68
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 16:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C596B23201
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 15:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB739145B15;
	Tue, 27 Feb 2024 15:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="F5WsoJYQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA5313B79F
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 15:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709047880; cv=none; b=pYYB4kpbrHNuYxUnwiJ6BBJz15odkDQN8XCElyq2wZOFt3XxkUbMcKp3WzcwrXldIizZYwhU14hBs9nWzgB3oFMN0Azr9/AqNDx4fiK3SnNBUyZjqW6bHfCmdeG3qT6mZE+pBAvKAoDaXO45ijseiOy7+Ig0qLBifP1c8QJ7LLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709047880; c=relaxed/simple;
	bh=/M8wynPJ9hWR3NdkG8xbaATbFhESmsZqG6LLBAZyUR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gE98VwtB3GvnZeIPYveNWeailgbwI/u23jg7KiudX/y6WF4NuUf6ivM2SbYalFkoQ/feJZuhF85Ev9VvEw/3EHWRZ6UyyXnYAw/IldL/9exe8uyT0AcMM72mUqSJvXTk/L0BVije6B5mbFRuoMRsxhmkMuSMjTF9mmew5p517J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=F5WsoJYQ; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-608959cfcbfso46048317b3.3
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 07:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1709047876; x=1709652676; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gRYaqYRi+3F/3uHRenTFC45AylG9BESTewFZhEha2sQ=;
        b=F5WsoJYQK5AH1MPqbbHIYhug+7Pyz8L8FB/wfVealauGGoMB4M3llImhTkTWnvVcxM
         l8idYkOFGQscDsEQs48Udv8mvGdWY8AoNujzuLPeiXcAgF57cUCpOGi73N85Nof+OfhX
         6+xC9vtN0d1vuLSiOzGbV+Be5oQ3NKu4Z7G9jOOLjfPPIciCMiUqDRY5kLKDij8NTt4V
         izxpyv4lZbmUBhnl9/hhfiAOKwK6HRgObsHN1t4wOip2alc5illGJmIfFJSvnQii2g68
         yS59Yg3QclVDh/samMgr6c0guF3+4YrXKszk74VFaQdWacwyMKxYwCaoY54UduJ/IUpM
         oPzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709047876; x=1709652676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gRYaqYRi+3F/3uHRenTFC45AylG9BESTewFZhEha2sQ=;
        b=S5cIQmWEkmn7vh9GGhqm5BdLRQ0unDQ/Au4Pp8BRZQFQg3i1CNkYyRs1OxehO08apB
         j+NxbBCwE6pkAlA57Ke4l+8WTV/ysIubGY6mCHX89+xZxWS0O6YHFCoSU/8wP28yBkxe
         y5GzvcjEE++Du3m5NCZxj6VbyFePHmzO8jPt/Wv5yJyMUCCwp46VQzcVZFvjEEbPMQ5o
         sETZ85+kSaxs7NFknwzf0oGguyW7K8C8jn9RQQlBal2pYW6THf7SHyruubauldeK7AXC
         fYgPcvD0QO1KIIYHp1n08VE+byZ2KqINi5/DdmMaWVQvFneV6CsYMRlrSi1KptU2+tX3
         pOwg==
X-Forwarded-Encrypted: i=1; AJvYcCU7NN8H3VlVgQ+Ie71MebqX4yKucVuMKgFOX1zCmgRvI6m2zi9CUSiUQrRU+doHBAXaDkeCz48XvhHM3R4B7ZAN9EjeDPTA
X-Gm-Message-State: AOJu0YyHK17K+SlKT7VE3OcSt7GXj+fIykqUATnxie45lhzlf+Y5bWaF
	PgOLCRNBgAqgR8xNVQWx4a5XG8lEIZb44rU5m+Kb8Lt9npIl5C8EAMNohapmfBSebTCcnPhcCk1
	UzCKBvanx7ZuWetSLdfwSNUjgDsSswULHtzi1
X-Google-Smtp-Source: AGHT+IGy0eQ3YNLVWVgjeMOPTQb/2KqLY7USqqeVSG+fxHnakfCslc6a0iEyqlZgE+HoAi+0hU5T2r0o/4IueD1WwyU=
X-Received: by 2002:a81:9107:0:b0:608:bc79:1af5 with SMTP id
 i7-20020a819107000000b00608bc791af5mr2680393ywg.18.1709047876681; Tue, 27 Feb
 2024 07:31:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227-feature_poe-v5-0-28f0aa48246d@bootlin.com>
In-Reply-To: <20240227-feature_poe-v5-0-28f0aa48246d@bootlin.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 27 Feb 2024 10:31:05 -0500
Message-ID: <CAM0EoM=Q3hdXSHNADKX=erJQJWT4Jz0XeAD8kMYHv_VGagvPQA@mail.gmail.com>
Subject: Re: [PATCH net-next v5 00/17] net: Add support for Power over
 Ethernet (PoE)
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, Mark Brown <broonie@kernel.org>, 
	Frank Rowand <frowand.list@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	devicetree@vger.kernel.org, Dent Project <dentproject@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 9:43=E2=80=AFAM Kory Maincent <kory.maincent@bootli=
n.com> wrote:
>
> This patch series aims at adding support for PoE (Power over Ethernet),
> based on the already existing support for PoDL (Power over Data Line)
> implementation. In addition, it adds support for two specific PoE
> controller, the Microchip PD692x0 and the TI TPS23881.
>
> This patch series is sponsored by Dent Project
> <dentproject@linuxfoundation.org>.

Sorry, couldnt resist because it sounded like a commercial;-> And
likely i am out of touch. I am all for giving credit but does it have
to be explicitly called out as "this patch is sponsored by X"?

cheers,
jamal


> In detail:
> - Patch 1 to 13 prepare net to support PoE devices.
> - Patch 14 and 15 add PD692x0 PoE PSE controller driver and its binding.
> - Patch 16 and 17 add TI TPS23881 PSE controller driver and its binding.
>
> Changes in v5:
> - Fix bindings nit.
> - Add supported-polarity parameter to bindings.
> - Fix yamllint binding errors.
> - Remove the nested lock brought by the use of regulator framework.
> - Link to v4: https://lore.kernel.org/r/20240215-feature_poe-v4-0-35bb4c2=
3266c@bootlin.com
>
> Changes in v4:
> - Replaced sponsored-by tag by a simple sentence.
> - Fix pse_pi node bindings.
> - Add pse pi documentation written by Oleksij.
> - Link to v3: https://lore.kernel.org/r/20240208-feature_poe-v3-0-531d267=
4469e@bootlin.com
>
> Changes in v3:
> - Add patches to add Oleksij and myself to PSE MAINTAINERS.
> - Add patches to add pse devlink.
> - Add TI TPS23881 PSE controller driver with its binding.
> - Replace pse_get_types helper by pse_has_podl and pse_has_c33
> - Changed the PSE core bindings.
> - Add a setup_pi_matrix callback.
> - Register regulator for each PSE PI (Power Interface).
> - Changed the PD692x0 bindings.
> - Updated PD692x0 drivers to new bindings and PSE PI description.
> - Updated PD692x0 drivers according to the reviews and made fixes.
> - Link to v2: https://lore.kernel.org/r/20231201-feature_poe-v2-0-56d8cac=
607fa@bootlin.com
>
> Changes in v2:
> - Extract "firmware_loader: Expand Firmware upload error codes patches" t=
o
>   send it alone and get it merge in an immutable branch.
> - Add "c33" prefix for PoE variables and enums.
> - Enhance few comments.
> - Add PSE Documentation.
> - Make several changes in pd692x0 driver, mainly for readibility.
> - Link to v1: https://lore.kernel.org/r/20231116-feature_poe-v1-0-be48044=
bf249@bootlin.com
>
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
> Kory Maincent (17):
>       MAINTAINERS: net: Add Oleksij to pse-pd maintainers
>       of: property: Add fw_devlink support for pse parent
>       net: pse-pd: Rectify and adapt the naming of admin_cotrol member of=
 struct pse_control_config
>       ethtool: Expand Ethernet Power Equipment with c33 (PoE) alongside P=
oDL
>       net: pse-pd: Introduce PSE types enumeration
>       net: ethtool: pse-pd: Expand pse commands with the PSE PoE interfac=
e
>       netlink: specs: Modify pse attribute prefix
>       netlink: specs: Expand the pse netlink command with PoE interface
>       MAINTAINERS: Add myself to pse networking maintainer
>       net: pse-pd: Add support for PSE PIs
>       dt-bindings: net: pse-pd: Add another way of describing several PSE=
 PIs
>       net: pse-pd: Add support for setup_pi_matrix callback
>       net: pse-pd: Use regulator framework within PSE framework
>       dt-bindings: net: pse-pd: Add bindings for PD692x0 PSE controller
>       net: pse-pd: Add PD692x0 PSE controller driver
>       dt-bindings: net: pse-pd: Add bindings for TPS23881 PSE controller
>       net: pse-pd: Add TI TPS23881 PSE controller driver
>
>  .../bindings/net/pse-pd/microchip,pd692x0.yaml     |  158 +++
>  .../bindings/net/pse-pd/pse-controller.yaml        |  100 +-
>  .../bindings/net/pse-pd/ti,tps23881.yaml           |   93 ++
>  Documentation/netlink/specs/ethtool.yaml           |   33 +-
>  Documentation/networking/ethtool-netlink.rst       |   20 +
>  Documentation/networking/index.rst                 |    1 +
>  Documentation/networking/pse-pd/index.rst          |   10 +
>  Documentation/networking/pse-pd/introduction.rst   |   73 ++
>  Documentation/networking/pse-pd/pse-pi.rst         |  302 +++++
>  MAINTAINERS                                        |    8 +
>  drivers/net/mdio/fwnode_mdio.c                     |   29 +-
>  drivers/net/pse-pd/Kconfig                         |   20 +
>  drivers/net/pse-pd/Makefile                        |    2 +
>  drivers/net/pse-pd/pd692x0.c                       | 1223 ++++++++++++++=
++++++
>  drivers/net/pse-pd/pse_core.c                      |  429 ++++++-
>  drivers/net/pse-pd/pse_regulator.c                 |   49 +-
>  drivers/net/pse-pd/tps23881.c                      |  818 +++++++++++++
>  drivers/of/property.c                              |    2 +
>  include/linux/pse-pd/pse.h                         |   86 +-
>  include/uapi/linux/ethtool.h                       |   55 +
>  include/uapi/linux/ethtool_netlink.h               |    3 +
>  net/ethtool/pse-pd.c                               |   60 +-
>  22 files changed, 3451 insertions(+), 123 deletions(-)
> ---
> base-commit: f308eae1e1cdacca3cef65c7f4f691dfcb0c8976
> change-id: 20231024-feature_poe-139490e73403
>
> Best regards,
> --
> K=C3=B6ry Maincent, Bootlin
> Embedded Linux and kernel engineering
> https://bootlin.com
>
>

