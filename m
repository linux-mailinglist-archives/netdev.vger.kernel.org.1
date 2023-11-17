Return-Path: <netdev+bounces-48860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D09A7EFC46
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 00:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06B6C2813A6
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 23:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F904655D;
	Fri, 17 Nov 2023 23:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AheL0cf9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7BD92
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 15:52:21 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3b6d80daae8so1601831b6e.2
        for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 15:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700265140; x=1700869940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XO+RtB5+4CPVSq8mDbYHacZ7TI5pN7J/rd1VbsZMhts=;
        b=AheL0cf9LJAC61qM5xpNC7Md3Ub3exazz42jl1em90k0ivwHlh/j3A9IJYlUTB+HfU
         WqfDDkZyFLDcHDD0yZMWN6nu4xx1IPBjOiEIAOC139eLDfwm9u6w3Lpe5fgy4Qe728+4
         pkThb448kv4X7jf+l34AFV1fkgJYLkpncdk6oQknb0nvOe7QzJeG20qkLJtprUOkjXP3
         KdcPX90jrJZn5n5V1OZPuBsseguTwiSC04TMeMkZxVVWWY7dqC/tQ7fPhbPpoJNnfkH4
         +NklF4Z56XrHmjPjIe8k9v7E51wr5J+Igi9IYEJSwenRkl8RN8/twIRJ95reh4JIGMhd
         ALcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700265140; x=1700869940;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XO+RtB5+4CPVSq8mDbYHacZ7TI5pN7J/rd1VbsZMhts=;
        b=Ukx6hPqoygN675uuikXWHlYuVSmJssonHNS2RgtgrE2/Wh0Af9O7XHqgmF3YUZLITK
         9Gm7rUwvPCao2BoAeedkem8gzmYRsFOrXHvAaU+njS+hpRuds4pt/TYwL9/wxKA/87X+
         G+LYTk6cCU6SfMUNMo8x84T3jW7VMWvnFVvovSYaOm7kVu59rwWXgIyGKzcyyHIGdnR/
         sNRsiLvg9YxjQugm1oBpVwTXP4gSJmws/AlJQXNSFb65KBaDIdgjlKXvbFDfs7UlfCcU
         TQnTyzmRY4rVzcICCoFuYj9aBDbqfWfm3blqWKMFRhrXxNQoPs7+obpNx+doy2w6ZQaR
         enTA==
X-Gm-Message-State: AOJu0YwsyHwbgA4nsEY6qtCnT1yzpvzzcZMqV9eIXk/ZckJPAe5tPjdy
	KaAVVESivEk7pc2swxp3ss+GMbzvC3xjJw==
X-Google-Smtp-Source: AGHT+IEdU6ds/NeVlE/67d3UUhXhTPXTJT9k5XFdcGMRMR3/gratOpZC037rq76ZjB3vF3FCHYmaMQ==
X-Received: by 2002:a05:6808:1986:b0:3a7:500a:a491 with SMTP id bj6-20020a056808198600b003a7500aa491mr1172848oib.28.1700265140118;
        Fri, 17 Nov 2023 15:52:20 -0800 (PST)
Received: from tresc054937.tre-sc.gov.br ([187.94.103.218])
        by smtp.gmail.com with ESMTPSA id b23-20020a056a0002d700b0066a4e561beesm2001993pft.173.2023.11.17.15.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 15:52:19 -0800 (PST)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
To: netdev@vger.kernel.org
Cc: linus.walleij@linaro.org,
	alsi@bang-olufsen.dk,
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	arinc.unal@arinc9.com
Subject: [net-next 0/2] net: dsa: realtek: Introduce realtek_common, load variants on demand 
Date: Fri, 17 Nov 2023 20:49:59 -0300
Message-ID: <20231117235140.1178-1-luizluca@gmail.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current driver comprises two interface modules (SMI and MDIO) and
two family/variant modules (RTL8365MB and RTL8366RB). While the
interface modules are independent and can be loaded only when necessary,
the symbols from variant modules are utilized by interface modules. This
requires loading all enabled variants simultaneously or disabling them
at build time. This approach, although simple, does not scale well,
particularly with the addition of more switch variants (e.g., RTL8366B),
resulting in loaded but unused modules.

This patch series refactors the Realtek DSA switch code by introducing a
common module shared by all existing interfaces (SMI or MDIO) and switch
variant modules (RTL8365MB and RTL8366RB). The common module primarily
contains parts of the probe code common to both interfaces, with the
possibility of incorporating more bits from variants in the future.

The relationship between interfaces and variant modules is also
modified. Variant modules now register themselves in realtek_common
using the compatible string as the key, which is also added as the
module alias. When an interface module probes a device, it utilizes the
matching string to both request the module, loading it if necessary, and
obtain the required variant reference.

Tested with a RTL8367S (RTL8365MB) using MDIO interface and a RTL8366RB
(RTL8366) with SMI interface.

Regards,

Luiz

--

Changelog:

RFC->v1
- Drop the reset-controller patches. It will be submitted in a different
  series.
- Renamed 'var' to 'variant'
- Used 'compatible' as MODULE_ALIAS; avoided static module names in
  macros
- Dropped tmp variable in realtek_variant_get()
- realtek_variant_get() now exclusively uses the compatible string
- Removed clk_delay, cmd_{read,write) from realtek_priv as they are
  already in realtek_variant
- Moved mdc/mdio from realtek_common_probe() to realtek_smi_probe()
- Moved module_realtek_variant() macro to realtek-common.h
- module_realtek_variant() now also generates MODULE_ALIAS()
- Avoided repeating error code with dev_err_probe()
- Removed unused realtek_variant.info
- Used realtek_common_(un)lock() in chip variant modules



