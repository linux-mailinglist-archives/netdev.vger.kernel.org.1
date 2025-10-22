Return-Path: <netdev+bounces-231830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FB2BFDD52
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 20:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0B0704E142D
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 18:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705E834EEF6;
	Wed, 22 Oct 2025 18:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="fynjAYfw"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E34934CFAF;
	Wed, 22 Oct 2025 18:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761157644; cv=none; b=td4/wbrRnEkwGH9eO99Kok758uVcJvj5sFI9degQ16ym69mdttTkP1/ftPMXtELavASWHY9fAJ1QKM5Fk1rl6XE/ubuL5Ud/iCfcw9Z702D0LKEggPzIajZ6PwpYdKXfZf4w0jlTVCCutcUH0+2NGIw2k0BDWgSUsLJpu59AHxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761157644; c=relaxed/simple;
	bh=Zf0585jW2MyZklmoRTnvbAPsZ6tICj1K3+6NGweVA7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hOTbuNW1rQ/J5CcQASbjKmsN+KCGbYofcSdoAz1Zm4YkOakC2jcodAHWZv0XcmyFfTkAN+ZPA7BKsi3hV8vb74fwxizTGGJYvxvcsg4GXs/MZ9KKewqK6Fddc5FqVthW6b3Ut+oFkgdqaNUpCf+YVrMuT5H2Lt7oQ2jo3s8sPrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=fynjAYfw; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1761157634;
	bh=Zf0585jW2MyZklmoRTnvbAPsZ6tICj1K3+6NGweVA7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fynjAYfwURZUXSoAG9DLJInORCJz7HXN9f3iIldVdfpmEqia1BRXcBu7eKjLA5vht
	 P17vqc5Lsk3QlcQTL6WIb+1gq1u8kuuskhmA2UR/Frxbk+bsfrVOCFMrvrqLUZWXEs
	 k2H3niK3Sd4xgTz3ZfAEbS5nzuQnbUcPlXqcZJYppM3j5Dksue3KdYZuV2ChJt9gev
	 SVnr4x5hBTTiFrSq3bG/A20CXSG1KPlP6S+B5DlliQ3Jtu60SHp8rMnpSSFs8B4Tnx
	 +fDegMSRQsMReif6mHLp5/F0SzqJ9oWixtvqUcjM3pYu+cs0M2y6UK02qbpQmMP72Z
	 faTyxrRcLgv6A==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id D92ED6010A;
	Wed, 22 Oct 2025 18:27:14 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id A4E9E2022FD; Wed, 22 Oct 2025 18:27:09 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Simon Horman <horms@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next 4/7] netlink: specs: nl80211: set ignore-index on indexed-arrays
Date: Wed, 22 Oct 2025 18:26:57 +0000
Message-ID: <20251022182701.250897-5-ast@fiberby.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022182701.250897-1-ast@fiberby.net>
References: <20251022182701.250897-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The indexes in nl80211 indexed-arrays have no special meaning,
they are just written with an iterator index, which refers to
the order in which they have been packed into the netlink message.

Thus this patch sets ignore-index on these attributes.

Most of these are only used for dumping kernel state, and are
never parsed by the kernel.

┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━┳━━━━━━━━┳━━━━━━━━┓
┃                                     ┃ out/ ┃ input/ ┃ ignore ┃
┃ Attribute                           ┃ dump ┃ parsed ┃ -index ┃
┡━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╇━━━━━━╇━━━━━━━━╇━━━━━━━━┩
│ NL80211_ATTR_SUPPORTED_COMMANDS     │ 1++  │ -      │ yes    │
│ NL80211_ATTR_INTERFACE_COMBINATIONS │ 1++  │ -      │ yes    │
│ NL80211_BAND_ATTR_FREQS             │ 0++  │ -      │ yes    │
│ NL80211_BAND_ATTR_RATES             │ 0++  │ -      │ yes    │
│ NL80211_BAND_ATTR_IFTYPE_DATA       │ 1++  │ -      │ yes    │
│ NL80211_FREQUENCY_ATTR_WMM          │ 0++  │ -      │ yes    │
│ NL80211_IFACE_COMB_LIMITS           │ 1++  │ -      │ yes    │
│ NL80211_SAR_ATTR_SPECS              │ 1++  │ yes(2) │ yes    │
└─────────────────────────────────────┴──────┴────────┴────────┘

Where:
  0++) incrementing index starting from 0
  1++) incrementing index starting from 1
  2)   NL80211_SAR_ATTR_SPECS is parsed in nl80211_set_sar_specs(),
       which doesn't use the index. Additionally it also has a
       NLA_POLICY_NESTED_ARRAY() policy, as defined in commit
       1501d13596b9 ("netlink: add nested array policy validation"),
       meaning that the index has no meaning, and can be disregarded.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 Documentation/netlink/specs/nl80211.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/netlink/specs/nl80211.yaml b/Documentation/netlink/specs/nl80211.yaml
index 802097128bdae..b93c612037e26 100644
--- a/Documentation/netlink/specs/nl80211.yaml
+++ b/Documentation/netlink/specs/nl80211.yaml
@@ -390,6 +390,7 @@ attribute-sets:
         name: supported-commands
         type: indexed-array
         sub-type: u32
+        ignore-index: true
         enum: commands
       -
         name: frame
@@ -608,6 +609,7 @@ attribute-sets:
         name: interface-combinations
         type: indexed-array
         sub-type: nest
+        ignore-index: true
         nested-attributes: if-combination-attributes
       -
         name: software-iftypes
@@ -1307,11 +1309,13 @@ attribute-sets:
         name: freqs
         type: indexed-array
         sub-type: nest
+        ignore-index: true
         nested-attributes: frequency-attrs
       -
         name: rates
         type: indexed-array
         sub-type: nest
+        ignore-index: true
         nested-attributes: bitrate-attrs
       -
         name: ht-mcs-set
@@ -1335,6 +1339,7 @@ attribute-sets:
         name: iftype-data
         type: indexed-array
         sub-type: nest
+        ignore-index: true
         nested-attributes: iftype-data-attrs
       -
         name: edmg-channels
@@ -1418,6 +1423,7 @@ attribute-sets:
         name: wmm
         type: indexed-array
         sub-type: nest
+        ignore-index: true
         nested-attributes: wmm-attrs
       -
         name: no-he
@@ -1474,6 +1480,7 @@ attribute-sets:
         name: limits
         type: indexed-array
         sub-type: nest
+        ignore-index: true
         nested-attributes: iface-limit-attributes
       -
         name: maxnum
@@ -1613,6 +1620,7 @@ attribute-sets:
         name: specs
         type: indexed-array
         sub-type: nest
+        ignore-index: true
         nested-attributes: sar-specs
   -
     name: sar-specs
-- 
2.51.0


