Return-Path: <netdev+bounces-79166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EC187816C
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 15:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C39521F23FD1
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 14:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D063405CF;
	Mon, 11 Mar 2024 14:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="NlZYhheI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5633FE3F
	for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 14:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710166354; cv=none; b=i5upWbZWcIvHdu1zFhR7dmqJMiBVWR0cl3tlErfbbyiwSndCbNV+bvYOTUIRaO2qukdzNerkjd8CRwHbHGa6pXaEOTPo1iS/nzEpNGoVA2wcijnn6KwHe+rM/1i5j32XuIDJHf98gpG3laJbeSJuQPOG4g84uU+5NB306tBgq+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710166354; c=relaxed/simple;
	bh=VBIdS/UlQSzStdPHLVSkmkdiD3oLzRYhAHd84C/7QNo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=etIUNw/GYD7RIo2Kum3aJpB8i3ga8QrSgIallH/+FgNF66Dzvn6sk7FKMYF7WvztUiBLEco3BWiREOfTA5ZRcvOlZhhoQxK9eca1mux1uUQpacxU9EkVD4gR83m+xI5tC9ZAziZvAp9pGVeUzO+UKvyTq9yq79YHGDypLWz0A2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=NlZYhheI; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a44d084bfe1so371417966b.1
        for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 07:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech.se; s=google; t=1710166349; x=1710771149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ps8i6xtkxMp0Zvly/37wcJc+RtBvwNAObQIyBi27L+U=;
        b=NlZYhheIcItqCE5HdjVhxv7b2o/oSIpG0btc6yzkfIQjyPabpBFP52x9l6EslbMqh6
         YtXrxnVBOO14Re9MFjOMc04b9+N50R8WPO8HOWM8UICfShN0y/eKIDohJWw8xnA7tk27
         LGiilzMVphENAhZLAyCC0MKg6IrDDLswDDpdvWZ9xxIIqw4IXffSMj8kZD+T6O88qdAi
         ytly3Xiy8+B73n9WRBojMBD7+yplubm6xgENxm7ubBt6+e4EgQSqxhOuioXQxSz88+wy
         FnVK5nuDBfI9E+7cjzFtPFFCp7D3U8j3Xvg5ewtOeQuIu/COQn3wKQwxA+rwfnGRcIph
         PFsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710166349; x=1710771149;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ps8i6xtkxMp0Zvly/37wcJc+RtBvwNAObQIyBi27L+U=;
        b=As8SUVxQQjfKeJwXfc2EG2A7qowa1Bs0vbftFWLIRbo65mrMQaxc1ZmIaczfeCszJQ
         E5Hx+LJPP0HnHQLlSDAlye6pwAQHyQ21BnKjq/GBjFzh7GUVi4AlvlppYbZDs1DCzazb
         XY/Isd90NceOnq+h5uwjbRD11uK410hSJRnJ5HoXjKIm9xS3Kv7yE9jaj1dkot9wb7Oq
         Wc12+Y/Y2Gh0Y7aBSoSy0MH3+X3Ihj504HQJkWRNGzspZbGkoEsWnd015xgXFTAUVQKW
         MWQ1XPsQqrppHKiP42ZNxbgMoeXLPKzTNidkyq5H4PZGrWWSAvFNH18F2+YMzEzFKiWl
         qbZg==
X-Forwarded-Encrypted: i=1; AJvYcCWQX17qWzwJW6wcZfA3dO2oGrg5DnjdNELujh/dHOIRqqgZViWuWLsEGFC3653KS3S0Yg/maP20pznywslCswlAq/BCZdhu
X-Gm-Message-State: AOJu0YyvRdiDUXt/wFKlJOP9Q+16ZfWw+Bxn3VZnDc2dYlJOj6Mo1FRL
	LaffrfqIzpKa9GH2mP9wMUzFoXOSlpHNfzay/OwWJCg6GMRmOu6v0/DUQHmB0l7YKaHQd+Lx47J
	j
X-Google-Smtp-Source: AGHT+IFqioQX9gpTIxeYolk9thiVfgab//cOM4gCkN1/ka/pcpcihbNEdsPgh/+kEYespOs7HBdoqA==
X-Received: by 2002:a17:907:c28c:b0:a45:373:cff with SMTP id tk12-20020a170907c28c00b00a4503730cffmr4257652ejc.68.1710166349036;
        Mon, 11 Mar 2024 07:12:29 -0700 (PDT)
Received: from sleipner.berto.se (p4fcc8c6a.dip0.t-ipconnect.de. [79.204.140.106])
        by smtp.googlemail.com with ESMTPSA id kn11-20020a170906aa4b00b00a45efdfdd1esm2863154ejb.40.2024.03.11.07.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 07:12:28 -0700 (PDT)
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: Sergey Shtylyov <s.shtylyov@omp.ru>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: [net-next,v3 0/2] ravb: Support describing the MDIO bus
Date: Mon, 11 Mar 2024 15:11:04 +0100
Message-ID: <20240311141106.3200743-1-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

This series adds support to the binding and driver of the Renesas
Ethernet AVB to described the MDIO bus. Currently the driver uses the OF
node of the device itself when registering the MDIO bus. This forces any
MDIO bus properties the MDIO core should react on to be set on the
device OF node. This is confusing and non of the MDIO bus properties are
described in the Ethernet AVB bindings.

Patch 1/2 extends the bindings with an optional mdio child-node to the
device that can be used to contain the MDIO bus settings. While patch
2/2 changes the driver to use this node (if present) when registering
the MDIO bus.

If the new optional mdio child-node is not present the driver fallback
to the old behavior and uses the device OF node like before. This change
is fully backward compatible with existing usage of the bindings.

For changelog see individual patches.

Niklas Söderlund (2):
  dt-bindings: net: renesas,etheravb: Add optional MDIO bus node
  ravb: Add support for an optional MDIO mode

 .../devicetree/bindings/net/renesas,etheravb.yaml        | 8 ++++++++
 drivers/net/ethernet/renesas/ravb_main.c                 | 9 ++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

-- 
2.44.0


