Return-Path: <netdev+bounces-225010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22805B8D16D
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 23:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBB24465EF4
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 21:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6DD27A44A;
	Sat, 20 Sep 2025 21:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FC9E2UVA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE7723D289
	for <netdev@vger.kernel.org>; Sat, 20 Sep 2025 21:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758402719; cv=none; b=E2jnJaZELseW21zUZ6BF2BKPihKkaWbvoc+APow9ZVoAkRzvkxjDF5I6W1T2/Hg7cM/xwHpZmgUgLXw8/W/8XaPb2IxcHUzSroy6AQ8ZvYIfAqfmzXKwBI1vurgmtURJTpNTDboK/1aHZ/MTVhKShAvZT3DjRC80uNTdtt7LG4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758402719; c=relaxed/simple;
	bh=gxS8bRNlOeUb6wnz+ve1XYInjBNXFeibavaYZ6SxHBk=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=SK3tq2nifmguLL5AxDiKKIbeoOvx/ifjeNxT+nLNlRVFAB9aiiwOBcVKfe1ePtyAaAmLJ4EbDWxV7fTScO8NcnHJndhR4IBeyLFuupiDsEfx0riJ7cT5ekD0qL7Y9t+W/c9ZxrxQc936sPT/ArNKRI/BTB4QmhiYf/MsmREPPMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FC9E2UVA; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-46130fc5326so22542105e9.2
        for <netdev@vger.kernel.org>; Sat, 20 Sep 2025 14:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758402716; x=1759007516; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yler5Tz7DNyU3m+9ma3597QPyLZU5h7XDUDXp9i8qfQ=;
        b=FC9E2UVARVA+I/XQMNpOg2nOPODtMHVjuofkRJj7ZUJVB/+zrEDK9K9aSuFWAbzcqA
         qo3aLAnwHD6+f2fnDQhaRku8WkKVSt/8zTPx82seHGHyM0XJEB7TUARFUkL+9wQAP7a7
         0Q+B66GOM7JZxq6V1LZL6TuooFOFupB1QwreanwlQbh5XtG4a7uPdmhaLCKVsgLmPJ32
         NDOxuM1Zg0JguNstM+fEXEnexSliv+Brg4LpNvCIcbbVmRPY6pAx2IA4ICWKYv6ixGGt
         1F82X5ZIl9x96Y16Sh83qs+7hKRlnDsH6yOhQ1qpnudeHpb/VP9vf1SynYy3KbE+qpNm
         YQSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758402716; x=1759007516;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yler5Tz7DNyU3m+9ma3597QPyLZU5h7XDUDXp9i8qfQ=;
        b=xJMJl6LfZoViCwa9K0DuIQbBpbdXHXc8B1IPim3ktU1UYnWhdEd+4qI4rg1iapHOx3
         bgNtTnXopsS9tU1/cdReHz7SDR1LphG3bchO/HTsWOBEuZ+FEFR5A+mer4PM/63VavEv
         RAQQFwDy/X0PyeDH6XhWVAjgvIdiowZoBhXwz4tHl+StQ6zn3Ct1KSarBP7UrwkdKXZz
         N0vHIEMbs0N4NEgTpkbbDXFl1FSwZZr0uxkAMSG9Y0VJaK8Ksz/KuPrv/ufGbNyZ6aEV
         hkxTW5iVDkW1bp1HXJgGLTl/tylVHD0nqLIn+2RFrPmnlk+d1de0m9AsFIp0kMkz0MBi
         Io5g==
X-Gm-Message-State: AOJu0YzK9sOSB/9HB3yGBJj3YuOMfb0paTX4Vvmb438i1vKBFfVYVNMu
	/9QEj2PkKbB8CpAmF/lXECmqAlI+uXmrjXxiU7hSbivI3c1fGCHrSVY5
X-Gm-Gg: ASbGnctnZZMEyfZmpL/w739dhuV8vIG79NpdTXR/9s8+K6RVNeKejXtViAFIIfd91l0
	LjT8TjoV+qZIfVMzs5dMK0dYscdCfnEQAac01wRKI55VCGDTgcsLUAYXCZ8hwZYEkEAt9GJETZG
	/meuAlm49tTkxX8AGXAnqjCqGk/NFOd5Fz/qwaHavmstD0edZDbsFw3kSmnozz46DQBxH0nVV+e
	Gl6PVglOwu0FW7VAXSBCUQPA1xPRRW6tpbU3DqgHyMj5F743/UOhLF2HiPN7R4Y4/12sh7Tt2hB
	tv6NpQSOo4b9xzPQFMC5k6GfjxbdnhgXptyerq6uqf9JvBsPI0ehOGcsHpqLsDlbqq+MA1lvxur
	hlrI48Lcl+sOZCJKqZKwdmVHfxu3SCUhzvyCI92qanHQ5EL2dIJ8JzYjQTb5YviLwn+V5RopBeE
	gVGGiw6MtXmHhReAvkx8CmmmQ+WIvUBn005qwi/E8w+TE4dnWkJp5CXFPhbKsyzcjsIhH6yQ==
X-Google-Smtp-Source: AGHT+IGSuMC50NGLKoTP3tnb86rLNr1nM4dhskUQ7hZaU+CYhXlKZtqDjZx165kRAtKAOElBSArpVQ==
X-Received: by 2002:a05:600c:4593:b0:459:d5d1:d602 with SMTP id 5b1f17b1804b1-467e75ea97dmr74282065e9.3.1758402715958;
        Sat, 20 Sep 2025 14:11:55 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f30:a300:65ae:147:ed4c:62d8? (p200300ea8f30a30065ae0147ed4c62d8.dip0.t-ipconnect.de. [2003:ea:8f30:a300:65ae:147:ed4c:62d8])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45f325a32f6sm106988985e9.2.2025.09.20.14.11.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Sep 2025 14:11:55 -0700 (PDT)
Message-ID: <164ff1c6-2cf9-4e30-80fb-da4cc7165dc8@gmail.com>
Date: Sat, 20 Sep 2025 23:11:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] net: phy: move config symbol MDIO_BUS to
 drivers/net/phy/Kconfig
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Config symbol MDIO_BUS isn't used in drivers/net/mdio. It's only used
in drivers/net/phy. So move it there.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/mdio/Kconfig | 5 -----
 drivers/net/phy/Kconfig  | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/mdio/Kconfig b/drivers/net/mdio/Kconfig
index e1e32b687..443803789 100644
--- a/drivers/net/mdio/Kconfig
+++ b/drivers/net/mdio/Kconfig
@@ -3,11 +3,6 @@
 # MDIO Layer Configuration
 #
 
-config MDIO_BUS
-	tristate "MDIO bus consumer layer"
-	help
-	  MDIO bus consumer layer
-
 if PHYLIB
 
 config FWNODE_MDIO
diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index ca05166ae..98700d069 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -3,6 +3,11 @@
 # PHY Layer Configuration
 #
 
+config MDIO_BUS
+	tristate "MDIO bus consumer layer"
+	help
+	  MDIO bus consumer layer
+
 config PHYLINK
 	tristate
 	select PHYLIB
-- 
2.51.0


