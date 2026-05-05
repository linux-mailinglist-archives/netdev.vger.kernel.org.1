Return-Path: <netdev+bounces-284548-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KosEbQ3+mnHKwMAu9opvQ
	(envelope-from <netdev+bounces-284548-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 20:32:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB7C4D2B6B
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 20:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A4A33109A2B
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 18:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0CD4ADD97;
	Tue,  5 May 2026 18:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vym9843Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4223C4A341C
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 18:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778005648; cv=none; b=YShV2aWqkWxqNx2dOfGehEFzWaSx3tJ90aYO6G9ThRtkjjALzqRSRjIJ2uyWZTW7XOvICIu5WpHmduniGDvGKxA5lisiwmrrk0kW8RYEfoWaFZHiSrbcoDUOjRu1jawk9Wp2RZGefWznenxd+E6M1ClXz2sGxSYTTUXocZcpgfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778005648; c=relaxed/simple;
	bh=24jMbiGXKtINRJ89onrqgntIbdG758ocW05MGZvP3j4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=QkxDTQbYz+pVCFTO2PwiQDTgbJeoLEBbEh6K/J/ksErwoNKhkOqNtwUN8HAXt4Sji8qR4D7DGt6aJ1nm3QH37ih8SYu5OD1M5ZU6CAerv9Xy5ocuvFh7ObT+AFZwUDZXvIalDoiP64sw86QwEMcd/+HxjCpCzAuwaofgIQsLvT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vym9843Z; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48896199cbaso48871095e9.1
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 11:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778005645; x=1778610445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=p3booFeTa28qe7i7voEaW3UHK1wmjwWoETKgGZqVBKM=;
        b=Vym9843Z00lQYV1Yhi0udbgUuWWwjpR5k0pX8QteA8dXODJf8AU9F7hyvYeCaCqCF3
         SZZ8R38lrZ0nCFd9nD9Ec8CvsGakblRxW2n0tVHrsSBVPh3UIXd8NoqHFq/LZljJIs2F
         YSMlmOzUOdjWgNAWh2uisCMkEOTG89MN2phm6z7lGPpxVuj5kreA9BrBtnK/djRbSWSV
         aTUDnCSho4IreUJJPSyAdVbWw3VHN0p2aTXQs/O1oHdXJxxjBCdH9R4fNokUSmiclCLu
         VVciNNCWtogZ0f3UXKiPSgep4d+YpB04vHRzEH0b7aRDJwUG3fst7EiDVHTu8zcBR/Ie
         Mr4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778005645; x=1778610445;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p3booFeTa28qe7i7voEaW3UHK1wmjwWoETKgGZqVBKM=;
        b=la0umN8aNapCYVjky59ieqCDQ77SOQJN7YFAWFjWtuAXulnh6AqUdybAw7qhE79h1E
         KfuRrAg+oc9ePg8Q8Fn3kRIztgSbBv4GgBTy5OZbEiSpNzgFcmufa/I7ofPJt3Ymz7Zs
         ZQYd3RvkRIsMXCdoc8oivq3hzxfXf4Iv/ki7sbj0h8wyq2FUQa+ZKVB9sUSrxX+qr04s
         mAthcu8lRxtkuVo48NHw//zaD1PAUp9Ki0smrDPYeuZUBbnYEUkHVKhjUD4u02Ih5Mxy
         XWzY9xPVa3EQQZrlFqbiQ4OrCJ0c36aG34/8NS1/2RTLcbSnHCGKbr3XIzhSpNf7XSOv
         QbkA==
X-Forwarded-Encrypted: i=1; AFNElJ+oaQR5lt0NH04C7SOlOhHboPWcDCrfDnz5fSsmCUZW9zIDBJLhIC/yy5KpW9N0sNS7QrLpA1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEnE3vLjotNP7+wabj0VPzUSGw8kjTYC04Lmi1RjDWUA9kwFfX
	Yshe/owr6mCT4vAmVTWoXneoaTWTaMGxCxvhxP38zOwBwIJ9LlCUIE7F
X-Gm-Gg: AeBDietrRHuQxOq+cSIJ5WuzbfNcKekhUd1gCDKVQaacBdVIEH9ALf3OajA7GJsIPwI
	yH4wcgiDVE3fUB5f5f0Px223fa68iPCt2tMCdRvkC39kBCMVaDQj8H2id78orJiSi/HzOZmH3N7
	9WeFMJitZdE6u9JdfyAbAnar3ZIdZCZ5KDVZKbKQYcxkPZa5z6i/XMm3FRfiFcD0o1bWL17BeVi
	6KpbD81yMdd0Iar4Q2IrkSkIGdgDlLXqMXz50I3mpGlYscu+hdbGU+XhXhrrBAcodAZJooX9/cy
	RDilsGgpZJz0YVFfU8h8hggcHdz4h11ZTr9restcRlLDayqs/IbDSHYZItNkGcoPZ0iMC7rGWE4
	EdMTJk9PoT0dKKPk0sJJaOJ2kwNSWat1GbdSl0eW2jn9D1sBorCjnOW4Ji3AbTAHKVjIEs0xwVV
	pflOih8k7QYrDTLJMscbLkNvQl0e1AcgrlL8Vsvzo/cUMriXBkHIb7fiUzxo2rgSNQagARETw2n
	TgVAk8=
X-Received: by 2002:a05:600c:c494:b0:48a:592c:e632 with SMTP id 5b1f17b1804b1-48e51f42760mr5237455e9.16.1778005644350;
        Tue, 05 May 2026 11:27:24 -0700 (PDT)
Received: from Ansuel-XPS24 (host-82-59-227-65.retail.telecomitalia.it. [82.59.227.65])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-48a820c865esm408208245e9.5.2026.05.05.11.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 11:27:23 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	llvm@lists.linux.dev
Subject: [net-next RFC PATCH v5 00/10] net: pcs: Introduce support for fwnode PCS
Date: Tue,  5 May 2026 20:27:01 +0200
Message-ID: <20260505182713.27644-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8DB7C4D2B6B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-284548-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,pengutronix.de,makrotopia.org,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ansuelsmth@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt,lkml];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

This series introduce a most awaited feature that is correctly
provide PCS with fwnode without having to use specific export symbol
and additional handling of PCS in phylink.

At times there were 2 different implementation (this and the one
from Sean) but Sean agreed that this can be picked and used in favor
of his implementation as long as his case with race condition is
correctly handled.

---
First the PCS fwnode:

The concept is to implement a producer-consumer API similar to other
subsystem like clock or PHY.

That seems to be the best solution to the problem as PCS driver needs
to be detached from phylink and implement a simple way to provide a
PCS while maintaining support for probe defer or driver removal.

To keep the implementation simple, the PCS driver devs needs some
collaboration to correctly implement this. This is O.K. as helper
to correctly implement this are provided hence it's really a matter
of following a pattern to correct follow removal of a PCS driver.

A PCS provider have to implement and call fwnode_pcs_add_provider() in
probe function and define an xlate function to define how the PCS
should be provided based on the requested interface and phandle spec
defined in fwnode (based on the #pcs-cells)

fwnode_pcs_get() is provided to provide a specific PCS declared in
fwnode at index.

A simple xlate function is provided for simple single PCS
implementation, fwnode_pcs_simple_get.

A PCS provider on driver removal should first call
fwnode_pcs_del_provider() to delete itself as a provider and then
release the PCS from phylink with phylink_release_pcs() under rtnl
lock.

---
Second PCS handling in phylink:

We have the PCS problem for the only reason that in initial
implementation, we permitted way too much flexibility to MAC driver
and things started to deviate. At times we couldn't think SoC
would start to put PCS outside the MAC hence it was OK to assume
they would live in the same driver. With the introduction of
10g in more consumer devices, we are observing a rapid growth
of this pattern with multiple PCS external to MAC.

To put a stop on this, the only solution is to give back to phylink
control on PCS handling and enforce more robust supported interface
definition from both MAC and PCS side.

It's suggested to read patch 0003 of this series for more info, here
a brief explaination of the idea:

This series introduce handling of PCS in phylink and try to deprecate
.mac_select_pcs.

Phylink now might contain a linked list of available PCS and
those will be used for PCS selection on phylink_major_config.

MAC driver needs to define pcs_interfaces mask in phylink_config
for every interface that needs a dedicated PCS.

These PCS needs to be provided to phylink at phylink_create time
by setting the available_pcs and num_available_pcs in phylink_config.
A helper to parse PCS from fwnode is provided
fwnode_phylink_pcs_parse() that will fill a preallocated array of
PCS. (the same function can be used to get the number of PCS
defined in DT, more info in patch 0005)

phylink_create() will fill the internal PCS list with the passed
array of PCS. phylink_major_config and other user of .mac_select_pcs
are adapted to make use of this new PCS list.

The supported interface value is also moved internally to phylink
struct. This is to handle late removal and addition of PCS.
(the bonus effect to this is giving phylink a clear idea of what
is actually supported by the MAC and his constraint with PCS)

The supported interface mask in phylink is done by OR the
supported_interfaces in phylink_config with every PCS in PCS list.

PCS removal is supported by forcing a mac_config, refresh the
supported interfaces and run a phy_resolve().

PCS late addition is supported by introducing a global notifier
for PCS provider. If a phylink have the pcs_interfaces mask not
zero, it's registered to this notifier.

PCS provider will emit a global PCS add event to signal any
interface that a new PCS might be avialable.

The function will then check if the PCS is related to the MAC
fwnode and add it accordingly.

A user for this new implementation is provided as an Airoha PCS
driver. This was also tested downstream with the IPQ95xx QCOM SoC
and with the help of Daniel also on the various Mediatek MT7988
SoC with both SFP cage implementation and DSA attached.

Lots of tests were done with driver unbind/bind and with interface
up/down also by adding print to make sure major_config_fail gets
correctly triggered and reset once the PCS comes back.

The dedicated commits have longer description on the implementation
so it's suggested to also check there for additional info.

It's worth to mention that OpenWrt is currently using this on
Mediatek SoC and QCOM ipq807x/ipq60xx/ipq50xx and Airoha are
already ported in staging tree for testing.

---

Changes v5:
- Rebase on top of net-next
- Use the new force_major_config
- Reword some comments and commit description
- Return -ENODEV instead of -EPROBE_DEFER to perevent race condition
- Drop phy_interface_copy patch (Russell pushed an equivalent version)
Changes v4:
- Move patch 0002 phy_interface_copy to 0002 (fix bisectability
  problem)
- Address review from Lorenzo for Airoha ethernet driver
- Fix kdoc error with missing Return (actually missing : before Return)
- Fix UNMET dependency reported error for CONFIG_FWNODE_PCS
- Revert to pcs.c instead of core.c (due to name conflict with other kmod)
- Fix clang compilation error for Airoha PCS driver
- Add missing inline function to pcs.h function
Changes v3:
- Out of RFC
- Fix various spelling mistake
- Drop circular dependency patch
- Complete Airoha Ethernet phylink integration
- Introduce .pcs_link_down PCS OP
Changes v2:
- Switch to fwnode
- Implement PCS provider notifier
- Better split changes
- Move supported_interfaces to phylink
- Add circular dependency patch
- Rework handling with indirect addition/removal and
  trigger of phylink_resolve()

Christian Marangi (10):
  net: phylink: keep and use MAC supported_interfaces in phylink struct
  net: phylink: introduce internal phylink PCS handling
  net: phylink: add phylink_release_pcs() to externally release a PCS
  net: pcs: implement Firmware node support for PCS driver
  net: phylink: support late PCS provider attach
  dt-bindings: net: ethernet-controller: permit to define multiple PCS
  net: phylink: add .pcs_link_down PCS OP
  dt-bindings: net: pcs: Document support for Airoha Ethernet PCS
  net: pcs: airoha: add PCS driver for Airoha SoC
  net: airoha: add phylink support for GDM2/3/4

 .../bindings/net/ethernet-controller.yaml     |    2 -
 .../bindings/net/pcs/airoha,pcs.yaml          |  112 +
 drivers/net/ethernet/airoha/Kconfig           |    1 +
 drivers/net/ethernet/airoha/airoha_eth.c      |  144 +-
 drivers/net/ethernet/airoha/airoha_eth.h      |    3 +
 drivers/net/ethernet/airoha/airoha_regs.h     |   12 +
 drivers/net/pcs/Kconfig                       |   13 +
 drivers/net/pcs/Makefile                      |    2 +
 drivers/net/pcs/pcs-airoha.c                  | 2921 +++++++++++++++++
 drivers/net/pcs/pcs.c                         |  241 ++
 drivers/net/phy/phylink.c                     |  280 +-
 include/linux/pcs/pcs-provider.h              |   41 +
 include/linux/pcs/pcs.h                       |  104 +
 include/linux/phylink.h                       |   15 +
 14 files changed, 3862 insertions(+), 29 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/pcs/airoha,pcs.yaml
 create mode 100644 drivers/net/pcs/pcs-airoha.c
 create mode 100644 drivers/net/pcs/pcs.c
 create mode 100644 include/linux/pcs/pcs-provider.h
 create mode 100644 include/linux/pcs/pcs.h

-- 
2.53.0


