Return-Path: <netdev+bounces-54242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E398065B8
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 04:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2147B1C21117
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 03:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A0BD297;
	Wed,  6 Dec 2023 03:39:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62735D40;
	Tue,  5 Dec 2023 19:39:42 -0800 (PST)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-1fb14047fe7so225415fac.1;
        Tue, 05 Dec 2023 19:39:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701833981; x=1702438781;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zCP5mpTiBzaf8jFDFoZFCrSL9wo9gfFxiw2IS3GAr+8=;
        b=EBm3kE2CHb46ebn7SolwGGXxkiBFH/54MVACTX7vTgNcPFiFFIwO/E2iG2UZUcQfdt
         0oRrEoAA+iHW4PYVEJBGMRQk8DbXBpCCib62rxJBKHH+EfE9YYS/0o6YYfMlYKt6Bre2
         35o6rR7TXIPODEXx99c5qG6iXi895OSofRhMiv37OOVIYHcuICWHbvHad8W55hHaA6xv
         ArMltBW736zbjEgKFfjz9u1DW57us0SDxW6JH4p5SB99AGt5wcL7x4qi7i2upS6rnjsC
         sbaBcdzwA6UnFiNEoNYnNoLp9gyAwCA1Xwuyd1XsP4RsKtLUDU72JTNBjbMoPGikRcuu
         jLIg==
X-Gm-Message-State: AOJu0Ywstno1DnCz52/iJq8vp03d0yca65FLRQmGy/Zb4VTGcGIfR4Lz
	Gr8uIxnJicWdVAGqyCl3ng==
X-Google-Smtp-Source: AGHT+IE7s70cHQbbKsQE0BQI0Z4UASLK6+NWEiczcYe6y7LwvmpOenb1p+4+datAsAgiAHs9a5vYLg==
X-Received: by 2002:a05:6871:b10:b0:1fa:df5e:48be with SMTP id fq16-20020a0568710b1000b001fadf5e48bemr129989oab.15.1701833981515;
        Tue, 05 Dec 2023 19:39:41 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id js13-20020a056870bacd00b001fb2c8d6d05sm2097487oab.5.2023.12.05.19.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 19:39:40 -0800 (PST)
Received: (nullmailer pid 463134 invoked by uid 1000);
	Wed, 06 Dec 2023 03:39:36 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Eric Dumazet <edumazet@google.com>, Qingfang Deng <dqfext@gmail.com>, 
	Rob Herring <robh+dt@kernel.org>, Alexander Couzens <lynxis@fe80.eu>, 
	Russell King <linux@armlinux.org.uk>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Vinod Koul <vkoul@kernel.org>, 
	SkyLake Huang <SkyLake.Huang@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, linux-phy@lists.infradead.org, 
	Felix Fietkau <nbd@nbd.name>, Chunfeng Yun <chunfeng.yun@mediatek.com>, 
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org, 
	Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>, Sean Wang <sean.wang@mediatek.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
	linux-mediatek@lists.infradead.org, Philipp Zabel <p.zabel@pengutronix.de>, 
	John Crispin <john@phrozen.org>, Mark Lee <Mark-MC.Lee@mediatek.com>, devicetree@vger.kernel.org
In-Reply-To: <f57cc2bfadca35219707a0af507ad6e2e354e311.1701826319.git.daniel@makrotopia.org>
References: <cover.1701826319.git.daniel@makrotopia.org>
 <f57cc2bfadca35219707a0af507ad6e2e354e311.1701826319.git.daniel@makrotopia.org>
Message-Id: <170183397288.462976.3952343134089704927.robh@kernel.org>
Subject: Re: [RFC PATCH v2 1/8] dt-bindings: phy: mediatek,xfi-pextp: add
 new bindings
Date: Tue, 05 Dec 2023 21:39:36 -0600


On Wed, 06 Dec 2023 01:43:55 +0000, Daniel Golle wrote:
> Add bindings for the MediaTek PEXTP Ethernet SerDes PHY found in the
> MediaTek MT7988 SoC which can operate at various interfaces modes:
> 
>  * USXGMII
>  * 10GBase-R
>  * 5GBase-R
>  * 2500Base-X
>  * 1000Base-X
>  * Cisco SGMII (MAC side)
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  .../bindings/phy/mediatek,xfi-pextp.yaml      | 80 +++++++++++++++++++
>  1 file changed, 80 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/mediatek,xfi-pextp.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/phy/mediatek,xfi-pextp.yaml:33:16: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/phy/mediatek,xfi-pextp.yaml:34:16: [error] string value is redundantly quoted with any quotes (quoted-strings)

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/phy/mediatek,xfi-pextp.example.dts:18:18: fatal error: dt-bindings/clock/mediatek,mt7988-clk.h: No such file or directory
   18 |         #include <dt-bindings/clock/mediatek,mt7988-clk.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[2]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/phy/mediatek,xfi-pextp.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1424: dt_binding_check] Error 2
make: *** [Makefile:234: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/f57cc2bfadca35219707a0af507ad6e2e354e311.1701826319.git.daniel@makrotopia.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


