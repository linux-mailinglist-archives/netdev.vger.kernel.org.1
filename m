Return-Path: <netdev+bounces-65824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B59A783BE08
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 10:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40408B32FCD
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 09:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CDA1CA80;
	Thu, 25 Jan 2024 09:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VrBgbijP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4D41BF2F
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 09:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706176376; cv=none; b=dU2EfxpLp2EWRjmHEj1cCU10N/vZsWo1w4onDoOtBWofjfrANOJW1XDsmdI5Ga49AIFO8GQuYmBY8TBjOPn9EzIdsOwnS9xmv4h7+bE167MsNYQ8zjni6Fd0cqJ9ugbH87GVmaIIOI/hOPvFkS8eVv3kHJroHZlKDXeyl4mh4uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706176376; c=relaxed/simple;
	bh=XatOHzq29LsC83znhYX78FEz2oNmHm7UJXjjb9haMQM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EfjQPl2ChSBHZVcH/BhkcI37Q/vFpGKqORn2YgkVfDabEP+iDVsXCenCdWJ30eOxwWXmbKnnSFx4+QyS3f2+NYt8FEJkJJhFPGgxvEJLRRNFvdX6xeubEWmwdJNZ2X/03Dyg2IAj3yA/sKhwnvxlljBEi9PbyouxKDgk3qGQDQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VrBgbijP; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6da6b0eb2d4so3923781b3a.1
        for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 01:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706176373; x=1706781173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8NO/Zc4uKraRuME+gHTfVr/GjjhDqS6UPAwJbWwu/3s=;
        b=VrBgbijP/5MAQDib7gL96LnQ3b7I4AEn12KKUjTeXvVObvXFGicU2eZeIkcxsiRbi2
         ZlBrp/5Pz9x8WFB1OoVxzlUs0jyTmj06YPlPrVYGHic6mEZOQMLa1ccGEgkazfccU2Wt
         Aka7bOrR0eSYBUpP/u8jLvAjuqCrXiUeXQNSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706176373; x=1706781173;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8NO/Zc4uKraRuME+gHTfVr/GjjhDqS6UPAwJbWwu/3s=;
        b=sypDw7/d4I6KoDbQ19zRYU5qM2+qdeu87MF9PkF4b6cpcxF/nlDwp1zs4Tk3TSp8qX
         kvCYh+ogo20Com9VHHoVRjBVyjjsuNR8uN7RTe2CdXqJgC4Wdnxw71RnXAr4yYn2aYOI
         6nJgWZ3mEa08so4Df4XE4tYz0bp6dqVCIHxNbXmh4HOfThYB7xCY9OP8TOxuhcICIBib
         i64/nexg7TO3z2ivCP7hFiM3I2DUOf1nEk8IZyFNgkz/lNxYsmyZYE8WpD/mpl5mFnTd
         GbH2bzQ3eLVW5ulamc3lGKoaj+Wf/eEY40WYXwKXPwQXM5oEGrt9CfwmMmAGkEsj0KBw
         BgMw==
X-Gm-Message-State: AOJu0YzfMFiM4Dm4lGwhUEwXGUUlX1Kse6X106pkzU3cwUkJqyEPUhwL
	+y579ufqp7hj+GKLAu1YEDtILj75I05H+DUJxTSbDlWeIkdPn93hktlC8LUyZw==
X-Google-Smtp-Source: AGHT+IFz5roRh966c3riGPD3IUjKL6oQhDWhSIiqYZQ6AAZe7dRuh8xja37v3AWjFcAW8gI3Ezje+g==
X-Received: by 2002:a05:6a00:1955:b0:6dd:c1b4:5e61 with SMTP id s21-20020a056a00195500b006ddc1b45e61mr366982pfk.69.1706176373418;
        Thu, 25 Jan 2024 01:52:53 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:7fb6:ed02:1c59:9f9c])
        by smtp.gmail.com with ESMTPSA id gu15-20020a056a004e4f00b006dd8a4bbbc7sm3228275pfb.101.2024.01.25.01.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 01:52:53 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	Sean Wang <sean.wang@mediatek.com>,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] bluetooth: mt7921s: Add binding and fixup existing dts
Date: Thu, 25 Jan 2024 17:52:36 +0800
Message-ID: <20240125095240.2308340-1-wenst@chromium.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi everyone,

This short series adds a binding document for the MT7921S SDIO Bluetooth
controller. The MT7921S is a SDIO-based WiFi/Bluetooth combo. WiFi and
Bluetooth are separate SDIO functions. The chip has extra per-subsystem
reset lines that can reset only WiFi or Bluetooth cores.

Patch 1 documents the SDIO function and the reset line, based on
existing device tree and driver usage. I listed Sean Wang, the original
driver author and maintainer, as the maintainer of the binding.

Patch 2 fixes up the sole existing usage of the compatible string by
making it a proper SDIO function node.

Please take a look. Not sure which tree patch 1 should be merged
through? I suppose with proper acks it could go through the soc/mediatek
tree together with patch 2.


Regards
ChenYu


Chen-Yu Tsai (2):
  dt-bindings: net: bluetooth: Add MediaTek MT7921S SDIO Bluetooth
  arm64: dts: mediatek: mt8183-pico6: Fix bluetooth node

 .../bluetooth/mediatek,mt7921s-bluetooth.yaml | 49 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 .../mediatek/mt8183-kukui-jacuzzi-pico6.dts   |  3 +-
 3 files changed, 52 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7921s-bluetooth.yaml

-- 
2.43.0.429.g432eaa2c6b-goog


