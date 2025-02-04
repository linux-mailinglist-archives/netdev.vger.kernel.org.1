Return-Path: <netdev+bounces-162753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD915A27DA7
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 22:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42D693A423B
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 21:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D3F21C9EC;
	Tue,  4 Feb 2025 21:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Dsh7OWyh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f101.google.com (mail-wr1-f101.google.com [209.85.221.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B8021B910
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 21:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738705312; cv=none; b=u9Jjun5VXvQ2GWXnb2s+MUxTXBL0T/h/GLaudLoRKx9F10QSbDJq58BqVUrtCfLIc18WwbApgYhMdv0NFwNc+78fdlEPsNsMTgVTMJodnbFTToRg5/3BBmta6FrguPvNofB5Qzo5MZs9h4x8HfVknzaqeS2I5QskevqNnQ35Lhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738705312; c=relaxed/simple;
	bh=FS08keFY1ozdicBUiUIN8Bu2H6mZ2iIkvJVfmRGOhvQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UWubk6wwgSm4HHYJgitEGcr8ZMYSbi0oVKeBn92dgzq89bUkzwxqNLDIv+g8KcQTEOtbHannqsaRHRgiMRL1asLsbCQ4wvDVlkicrW74dDUuNk1WZnzpTTfqrpfhQrvlExsvNKR1G0sPVWvE+3YZn99DCSPrt7Pzd6t+MFMhQFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Dsh7OWyh; arc=none smtp.client-ip=209.85.221.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-wr1-f101.google.com with SMTP id ffacd0b85a97d-38dae70f5d9so613498f8f.1
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 13:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1738705308; x=1739310108; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6kSjAEc3JpgYH0pfJk9yrLxuH6CjSL5l4ipCiBf9QiU=;
        b=Dsh7OWyhJkjgy3jaI4YUiT+Vt4TXogtOSZuWqg2OUPefc8+8CwDgDgBk4khSn5l2vm
         ybZfCN7Uu2pJFcUm+RnJGcnDzHVnS/NRnoCN5r9w/NeGQBEvu5EKMkJ4EPXLToMoJvJR
         s/5Xn+WWRUQxRNazuzyZMWyoCF5YK36njkh+BEfGVeU8DRg1BUKMLELMWZPVXG3MSMcj
         TFRggSg9VS/jldoCUxZuf6ueYVgXzJwRfc+e9XweBZljC02RT9EPbP6V9lbjjRi7xjh2
         GJNqLbeb5JurmJ1raHNV9fGnTpVrhgBPbmRNccYGmNArT5FBnlT/J2hWk00d98bYskpA
         VlLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738705308; x=1739310108;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6kSjAEc3JpgYH0pfJk9yrLxuH6CjSL5l4ipCiBf9QiU=;
        b=kGFG9iSC9FsuBmIFjkXXux2jw8brStbBb195V1ZnnBxR4zjRq8F8DgK+SYAvRHzWOY
         X7zWEdcbWIgHzcEKUUvahSoxOE96RVzCq18qFkHfteKUpIguQ2dckcB9hdxBPS9Of85a
         ldU3s30vlxuOsmIpZq9pm3SKghgwxZtN/Ja8NW02IZk6+MFai6CL+7eO7eHOudUECjT5
         DYvmDZEj6kqlFzxVpHPojU53Q/cps+IrbvfqDZ7PIsQuDTUrdviFgz5imaz8ybV9Xdrb
         wDcrgupNC7jjaDCnaPJf2n6w3fmMtdBr1brrtM5MSNhxLfE9QLD7S/6j+D3bwlsQP5zu
         PHsA==
X-Gm-Message-State: AOJu0Yygo9y+jMD+xrGpc57hVVpqZOV4SZRznAPQejGIIlryy8xofCH8
	kTQwz2G6xuNBmec/QhVjljpxxHPjsOvdvz6Pun/Kokb7UvBQbSpnmmPoA74p1CiCy+3mEoQDRMS
	HoL1VlT26eCVElAcSXIXecISU3wf3nOI5
X-Gm-Gg: ASbGnct++XrAridNn0+Bld7UxnmR+bX0JTDxm6W85wXVQhuzRQL8Dx2TzgQh5UFXqtB
	0NbPRYrDnaWJjzFxWZ8Kv4Pg36iOJd8pqO9HXby48880U7WQbhMKm/VbAmXH2f/iDT1clkYW3pv
	X5eLkPrQk4SZ4f4k93o+pepsoSIWvLz/G7QfMqPgsjP94owuLMrvSsbcop60ioH80CpurSTj4dO
	M4UJJs/Aro8+AP047ItR9FR9K3hBZqmBIWq8XCVY32mgiJbItmCgaKnzBpl96KT1bNERqqGsHxM
	GC0nAYKPca/KnZ8qEzmNpK0GSMrf1yTXhPy67Kc=
X-Google-Smtp-Source: AGHT+IHnFwgWjv8YV945kq/kC9C35yctrGUfuiPjRcl9fbEU9yyG5D3XeVSkJedIdI9xuStQxGPZrW7XyNqF
X-Received: by 2002:a5d:5849:0:b0:38d:b0fe:8c99 with SMTP id ffacd0b85a97d-38db49101c1mr230256f8f.48.1738705307565;
        Tue, 04 Feb 2025 13:41:47 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id ffacd0b85a97d-38c5c0d3560sm367622f8f.8.2025.02.04.13.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 13:41:47 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 0FE6A3401AB;
	Tue,  4 Feb 2025 14:41:46 -0700 (MST)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id F2E4CE435A1; Tue,  4 Feb 2025 14:41:45 -0700 (MST)
From: Uday Shankar <ushankar@purestorage.com>
Subject: [PATCH v2 0/2] netconsole: allow selection of egress interface via
 MAC address
Date: Tue, 04 Feb 2025 14:41:43 -0700
Message-Id: <20250204-netconsole-v2-0-5ef5eb5f6056@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJeJomcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDI1MDIwMT3bzUkuT8vOL8nFRdk2QzQ4NUozQLc8NkJaCGgqLUtMwKsGHRsbW
 1AIZgPeRcAAAA
X-Change-ID: 20250204-netconsole-4c610e2f871c
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, 
 Simon Horman <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 Johannes Berg <johannes@sipsolutions.net>, Jonathan Corbet <corbet@lwn.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-wireless@vger.kernel.org, linux-doc@vger.kernel.org, 
 Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

This series adds support for selecting a netconsole egress interface by
specifying the MAC address (in place of the interface name) in the
boot/module parameter.

Changes since v1 (https://lore.kernel.org/netdev/20241211021851.1442842-1-ushankar@purestorage.com/):
- Add a patch to define and use MAC_ADDR_LEN (Simon Horman)
- Remove ability to use MAC address to select egress interface via
  configfs (Breno Leitao)
- Misc style fixes (Simon Horman, Breno Leitao)

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
Uday Shankar (2):
      net, treewide: define and use MAC_ADDR_LEN
      netconsole: allow selection of egress interface via MAC address

 Documentation/networking/netconsole.rst |  6 +++-
 drivers/net/netconsole.c                |  2 +-
 drivers/nvmem/brcm_nvram.c              |  2 +-
 drivers/nvmem/layouts/u-boot-env.c      |  2 +-
 include/linux/if_ether.h                |  3 ++
 include/linux/netpoll.h                 |  6 ++++
 lib/net_utils.c                         |  4 +--
 net/core/netpoll.c                      | 51 +++++++++++++++++++++++++--------
 net/mac80211/debugfs_sta.c              |  5 ++--
 9 files changed, 60 insertions(+), 21 deletions(-)
---
base-commit: c2933b2befe25309f4c5cfbea0ca80909735fd76
change-id: 20250204-netconsole-4c610e2f871c

Best regards,
-- 
Uday Shankar <ushankar@purestorage.com>


