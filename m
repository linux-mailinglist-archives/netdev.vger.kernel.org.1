Return-Path: <netdev+bounces-148154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E00919E095F
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 18:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80B95BC1838
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 16:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6B11DC182;
	Mon,  2 Dec 2024 16:29:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B0619D074;
	Mon,  2 Dec 2024 16:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733156990; cv=none; b=NBjFmGaYEbwM5phBAXiGabiBJ+HHYZAbpfZrra9RhsTYUar949vrAizpx8rN4y0ur0LWL1bxFQlKI6FHUPA4PmeAWcGUPxRaWRdoe2BCtCGeG8FXPjmJiuDwbLDfPuC967v49q49Os/Z2QfpQ85Ghng7RvjAYxq1cpSrSsl0fek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733156990; c=relaxed/simple;
	bh=XYJsquWNmSpUB2okblQHuPEOP3n+A8frI5H8LF1CKBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KtA3KGJJ6Z2PTxSnE72+FDI14PrpmEbz/JpC4ZFsiPKxlj/90DYCNNQm5u+UEBk70Eh0TrO6Pu3h9Rf8pkRYu4n4vAL0QX2ylcVbfcWnkV2qBUh2VBNJNE5ImGVWsGsnKz5i2db3blJAodIJybAzSvxS1EKkB/peUPqvAkDOynw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-215770613dbso12053345ad.2;
        Mon, 02 Dec 2024 08:29:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733156986; x=1733761786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Xzkel8yEQQdpw9g7WGcFI/6FuRCFry/U9gT0oMBS9c=;
        b=dhBoeWeMNj3PUtacbWM6CwlSE0Fx0Nsc234LWNRkbjeXZgLLuP6rV/ApYpbxn9OBDz
         9T1xAvIeVwJ9xB+gLvbdqNsx6itmi60imQDvOU4ysepGO98nQH/UFKBx+Mpb38bcsgRL
         eIq/Nxh0q1eILgIJ/mql+lc7aJN8XdtcO1FvqlvE5OjpT6QpYqJ3cITZ51FK0YLRHL2o
         qb09lznJ0+UrMp9UM2npYh5jluCe16wiSYXu+AsSeqKwam0W6m0Jl1J5P3iai/pkArwu
         zVsUf+PELZe0+5F9xhNRT9hxGFzwIp93+mxE7YFHDQAUisKaFR5EqyhwXh0H4TOJiCYB
         j89A==
X-Forwarded-Encrypted: i=1; AJvYcCU/mUXDP5X3Zjpli4PDqwwjHd1iMkHZ+kn1v8LFae0DtilTs2LG8my7yuuGF0n6jspnQ8GJLNsnBaM=@vger.kernel.org, AJvYcCVMHM71OjOysnJryI6MTXAe5irTwxwKXH3SilJcFOKIM3WJlIZKG87kWdUJ6TpI2gPw1c9FHVprcjYZ+SnX@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj7Pl8WwjF+u10fJoMCIfuxzZwJyaH3ZoiFjIKr5FpgIxnVUaN
	DwK5dOKxZ7so2mabTRhWAlnxLTT528veSr3flJVoVOBMjSZw/mICKEO426c=
X-Gm-Gg: ASbGncsRq56XzpK/MFVavzzKZRq5IUdcwRDg49BqivN2KuabNP5SK3NZD3HLQlOfM4V
	KxvK4+CRmMDZPw9Yqf/gdJOPOppguSU+65KEK7+pxRFrWu/gpgoob6cT9fTcRs0MXuP7u1iubOs
	zCJ9l33/H779Fd2z64Pr0tV6GxQ95Bro8cVRGSH3H6XdkhrcrMDfQfkCN5muC3+4Tg82PM2DGok
	obFhtIjS0P+NmI414YfdG6uzbMSCCqSSaEOSvyWDFZRD19njw==
X-Google-Smtp-Source: AGHT+IF8kQaOT+Cj5CFt5pC4jDccMC3gi4A5PRBsIqe7cSmIWSeaT+qv42giEshMU3DoVXLv74x5/w==
X-Received: by 2002:a17:902:fc4c:b0:215:7446:2151 with SMTP id d9443c01a7336-21574462361mr126169775ad.4.1733156985715;
        Mon, 02 Dec 2024 08:29:45 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215219ac0e2sm79070505ad.232.2024.12.02.08.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 08:29:45 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	horms@kernel.org,
	donald.hunter@gmail.com,
	corbet@lwn.net,
	andrew+netdev@lunn.ch,
	kory.maincent@bootlin.com,
	sdf@fomichev.me,
	nicolas.dichtel@6wind.com
Subject: [PATCH net-next v3 6/8] ethtool: separate definitions that are gonna be generated
Date: Mon,  2 Dec 2024 08:29:34 -0800
Message-ID: <20241202162936.3778016-7-sdf@fomichev.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241202162936.3778016-1-sdf@fomichev.me>
References: <20241202162936.3778016-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reshuffle definitions that are gonna be generated into
ethtool_netlink_generated.h and match ynl spec order.
This should make it easier to compare the output of the ynl-gen-c
to the existing uapi header. No functional changes.

Things that are still remaining to be manually defined:
- ETHTOOL_FLAG_ALL - probably no good way to add to spec?
- some of the cable test bits (not sure whether it's possible to move to
  spec)
- some of the stats definitions (no way currently to move to spec)

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 MAINTAINERS                                   |   2 +-
 include/uapi/linux/ethtool_netlink.h          | 893 +----------------
 .../uapi/linux/ethtool_netlink_generated.h    | 899 ++++++++++++++++++
 3 files changed, 901 insertions(+), 893 deletions(-)
 create mode 100644 include/uapi/linux/ethtool_netlink_generated.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 0456a33ef657..d0f70c76396f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16206,7 +16206,7 @@ F:	include/linux/inetdevice.h
 F:	include/linux/netdev*
 F:	include/linux/platform_data/wiznet.h
 F:	include/uapi/linux/cn_proc.h
-F:	include/uapi/linux/ethtool_netlink.h
+F:	include/uapi/linux/ethtool_netlink*
 F:	include/uapi/linux/if_*
 F:	include/uapi/linux/net_shaper.h
 F:	include/uapi/linux/netdev*
diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
index 283305f6b063..9c909ce733a5 100644
--- a/include/uapi/linux/ethtool_netlink.h
+++ b/include/uapi/linux/ethtool_netlink.h
@@ -10,545 +10,12 @@
 #define _UAPI_LINUX_ETHTOOL_NETLINK_H_
 
 #include <linux/ethtool.h>
-
-/* message types - userspace to kernel */
-enum {
-	ETHTOOL_MSG_USER_NONE,
-	ETHTOOL_MSG_STRSET_GET,
-	ETHTOOL_MSG_LINKINFO_GET,
-	ETHTOOL_MSG_LINKINFO_SET,
-	ETHTOOL_MSG_LINKMODES_GET,
-	ETHTOOL_MSG_LINKMODES_SET,
-	ETHTOOL_MSG_LINKSTATE_GET,
-	ETHTOOL_MSG_DEBUG_GET,
-	ETHTOOL_MSG_DEBUG_SET,
-	ETHTOOL_MSG_WOL_GET,
-	ETHTOOL_MSG_WOL_SET,
-	ETHTOOL_MSG_FEATURES_GET,
-	ETHTOOL_MSG_FEATURES_SET,
-	ETHTOOL_MSG_PRIVFLAGS_GET,
-	ETHTOOL_MSG_PRIVFLAGS_SET,
-	ETHTOOL_MSG_RINGS_GET,
-	ETHTOOL_MSG_RINGS_SET,
-	ETHTOOL_MSG_CHANNELS_GET,
-	ETHTOOL_MSG_CHANNELS_SET,
-	ETHTOOL_MSG_COALESCE_GET,
-	ETHTOOL_MSG_COALESCE_SET,
-	ETHTOOL_MSG_PAUSE_GET,
-	ETHTOOL_MSG_PAUSE_SET,
-	ETHTOOL_MSG_EEE_GET,
-	ETHTOOL_MSG_EEE_SET,
-	ETHTOOL_MSG_TSINFO_GET,
-	ETHTOOL_MSG_CABLE_TEST_ACT,
-	ETHTOOL_MSG_CABLE_TEST_TDR_ACT,
-	ETHTOOL_MSG_TUNNEL_INFO_GET,
-	ETHTOOL_MSG_FEC_GET,
-	ETHTOOL_MSG_FEC_SET,
-	ETHTOOL_MSG_MODULE_EEPROM_GET,
-	ETHTOOL_MSG_STATS_GET,
-	ETHTOOL_MSG_PHC_VCLOCKS_GET,
-	ETHTOOL_MSG_MODULE_GET,
-	ETHTOOL_MSG_MODULE_SET,
-	ETHTOOL_MSG_PSE_GET,
-	ETHTOOL_MSG_PSE_SET,
-	ETHTOOL_MSG_RSS_GET,
-	ETHTOOL_MSG_PLCA_GET_CFG,
-	ETHTOOL_MSG_PLCA_SET_CFG,
-	ETHTOOL_MSG_PLCA_GET_STATUS,
-	ETHTOOL_MSG_MM_GET,
-	ETHTOOL_MSG_MM_SET,
-	ETHTOOL_MSG_MODULE_FW_FLASH_ACT,
-	ETHTOOL_MSG_PHY_GET,
-
-	/* add new constants above here */
-	__ETHTOOL_MSG_USER_CNT,
-	ETHTOOL_MSG_USER_MAX = __ETHTOOL_MSG_USER_CNT - 1
-};
-
-/* message types - kernel to userspace */
-enum {
-	ETHTOOL_MSG_KERNEL_NONE,
-	ETHTOOL_MSG_STRSET_GET_REPLY,
-	ETHTOOL_MSG_LINKINFO_GET_REPLY,
-	ETHTOOL_MSG_LINKINFO_NTF,
-	ETHTOOL_MSG_LINKMODES_GET_REPLY,
-	ETHTOOL_MSG_LINKMODES_NTF,
-	ETHTOOL_MSG_LINKSTATE_GET_REPLY,
-	ETHTOOL_MSG_DEBUG_GET_REPLY,
-	ETHTOOL_MSG_DEBUG_NTF,
-	ETHTOOL_MSG_WOL_GET_REPLY,
-	ETHTOOL_MSG_WOL_NTF,
-	ETHTOOL_MSG_FEATURES_GET_REPLY,
-	ETHTOOL_MSG_FEATURES_SET_REPLY,
-	ETHTOOL_MSG_FEATURES_NTF,
-	ETHTOOL_MSG_PRIVFLAGS_GET_REPLY,
-	ETHTOOL_MSG_PRIVFLAGS_NTF,
-	ETHTOOL_MSG_RINGS_GET_REPLY,
-	ETHTOOL_MSG_RINGS_NTF,
-	ETHTOOL_MSG_CHANNELS_GET_REPLY,
-	ETHTOOL_MSG_CHANNELS_NTF,
-	ETHTOOL_MSG_COALESCE_GET_REPLY,
-	ETHTOOL_MSG_COALESCE_NTF,
-	ETHTOOL_MSG_PAUSE_GET_REPLY,
-	ETHTOOL_MSG_PAUSE_NTF,
-	ETHTOOL_MSG_EEE_GET_REPLY,
-	ETHTOOL_MSG_EEE_NTF,
-	ETHTOOL_MSG_TSINFO_GET_REPLY,
-	ETHTOOL_MSG_CABLE_TEST_NTF,
-	ETHTOOL_MSG_CABLE_TEST_TDR_NTF,
-	ETHTOOL_MSG_TUNNEL_INFO_GET_REPLY,
-	ETHTOOL_MSG_FEC_GET_REPLY,
-	ETHTOOL_MSG_FEC_NTF,
-	ETHTOOL_MSG_MODULE_EEPROM_GET_REPLY,
-	ETHTOOL_MSG_STATS_GET_REPLY,
-	ETHTOOL_MSG_PHC_VCLOCKS_GET_REPLY,
-	ETHTOOL_MSG_MODULE_GET_REPLY,
-	ETHTOOL_MSG_MODULE_NTF,
-	ETHTOOL_MSG_PSE_GET_REPLY,
-	ETHTOOL_MSG_RSS_GET_REPLY,
-	ETHTOOL_MSG_PLCA_GET_CFG_REPLY,
-	ETHTOOL_MSG_PLCA_GET_STATUS_REPLY,
-	ETHTOOL_MSG_PLCA_NTF,
-	ETHTOOL_MSG_MM_GET_REPLY,
-	ETHTOOL_MSG_MM_NTF,
-	ETHTOOL_MSG_MODULE_FW_FLASH_NTF,
-	ETHTOOL_MSG_PHY_GET_REPLY,
-	ETHTOOL_MSG_PHY_NTF,
-
-	/* add new constants above here */
-	__ETHTOOL_MSG_KERNEL_CNT,
-	ETHTOOL_MSG_KERNEL_MAX = __ETHTOOL_MSG_KERNEL_CNT - 1
-};
-
-/* request header */
-
-enum ethtool_header_flags {
-	ETHTOOL_FLAG_COMPACT_BITSETS	= 1 << 0,	/* use compact bitsets in reply */
-	ETHTOOL_FLAG_OMIT_REPLY		= 1 << 1,	/* provide optional reply for SET or ACT requests */
-	ETHTOOL_FLAG_STATS		= 1 << 2,	/* request statistics, if supported by the driver */
-};
+#include <linux/ethtool_netlink_generated.h>
 
 #define ETHTOOL_FLAG_ALL (ETHTOOL_FLAG_COMPACT_BITSETS | \
 			  ETHTOOL_FLAG_OMIT_REPLY | \
 			  ETHTOOL_FLAG_STATS)
 
-enum {
-	ETHTOOL_A_HEADER_UNSPEC,
-	ETHTOOL_A_HEADER_DEV_INDEX,		/* u32 */
-	ETHTOOL_A_HEADER_DEV_NAME,		/* string */
-	ETHTOOL_A_HEADER_FLAGS,			/* u32 - ETHTOOL_FLAG_* */
-	ETHTOOL_A_HEADER_PHY_INDEX,		/* u32 */
-
-	/* add new constants above here */
-	__ETHTOOL_A_HEADER_CNT,
-	ETHTOOL_A_HEADER_MAX = __ETHTOOL_A_HEADER_CNT - 1
-};
-
-/* bit sets */
-
-enum {
-	ETHTOOL_A_BITSET_BIT_UNSPEC,
-	ETHTOOL_A_BITSET_BIT_INDEX,		/* u32 */
-	ETHTOOL_A_BITSET_BIT_NAME,		/* string */
-	ETHTOOL_A_BITSET_BIT_VALUE,		/* flag */
-
-	/* add new constants above here */
-	__ETHTOOL_A_BITSET_BIT_CNT,
-	ETHTOOL_A_BITSET_BIT_MAX = __ETHTOOL_A_BITSET_BIT_CNT - 1
-};
-
-enum {
-	ETHTOOL_A_BITSET_BITS_UNSPEC,
-	ETHTOOL_A_BITSET_BITS_BIT,		/* nest - _A_BITSET_BIT_* */
-
-	/* add new constants above here */
-	__ETHTOOL_A_BITSET_BITS_CNT,
-	ETHTOOL_A_BITSET_BITS_MAX = __ETHTOOL_A_BITSET_BITS_CNT - 1
-};
-
-enum {
-	ETHTOOL_A_BITSET_UNSPEC,
-	ETHTOOL_A_BITSET_NOMASK,		/* flag */
-	ETHTOOL_A_BITSET_SIZE,			/* u32 */
-	ETHTOOL_A_BITSET_BITS,			/* nest - _A_BITSET_BITS_* */
-	ETHTOOL_A_BITSET_VALUE,			/* binary */
-	ETHTOOL_A_BITSET_MASK,			/* binary */
-
-	/* add new constants above here */
-	__ETHTOOL_A_BITSET_CNT,
-	ETHTOOL_A_BITSET_MAX = __ETHTOOL_A_BITSET_CNT - 1
-};
-
-/* string sets */
-
-enum {
-	ETHTOOL_A_STRING_UNSPEC,
-	ETHTOOL_A_STRING_INDEX,			/* u32 */
-	ETHTOOL_A_STRING_VALUE,			/* string */
-
-	/* add new constants above here */
-	__ETHTOOL_A_STRING_CNT,
-	ETHTOOL_A_STRING_MAX = __ETHTOOL_A_STRING_CNT - 1
-};
-
-enum {
-	ETHTOOL_A_STRINGS_UNSPEC,
-	ETHTOOL_A_STRINGS_STRING,		/* nest - _A_STRINGS_* */
-
-	/* add new constants above here */
-	__ETHTOOL_A_STRINGS_CNT,
-	ETHTOOL_A_STRINGS_MAX = __ETHTOOL_A_STRINGS_CNT - 1
-};
-
-enum {
-	ETHTOOL_A_STRINGSET_UNSPEC,
-	ETHTOOL_A_STRINGSET_ID,			/* u32 */
-	ETHTOOL_A_STRINGSET_COUNT,		/* u32 */
-	ETHTOOL_A_STRINGSET_STRINGS,		/* nest - _A_STRINGS_* */
-
-	/* add new constants above here */
-	__ETHTOOL_A_STRINGSET_CNT,
-	ETHTOOL_A_STRINGSET_MAX = __ETHTOOL_A_STRINGSET_CNT - 1
-};
-
-enum {
-	ETHTOOL_A_STRINGSETS_UNSPEC,
-	ETHTOOL_A_STRINGSETS_STRINGSET,		/* nest - _A_STRINGSET_* */
-
-	/* add new constants above here */
-	__ETHTOOL_A_STRINGSETS_CNT,
-	ETHTOOL_A_STRINGSETS_MAX = __ETHTOOL_A_STRINGSETS_CNT - 1
-};
-
-/* STRSET */
-
-enum {
-	ETHTOOL_A_STRSET_UNSPEC,
-	ETHTOOL_A_STRSET_HEADER,		/* nest - _A_HEADER_* */
-	ETHTOOL_A_STRSET_STRINGSETS,		/* nest - _A_STRINGSETS_* */
-	ETHTOOL_A_STRSET_COUNTS_ONLY,		/* flag */
-
-	/* add new constants above here */
-	__ETHTOOL_A_STRSET_CNT,
-	ETHTOOL_A_STRSET_MAX = __ETHTOOL_A_STRSET_CNT - 1
-};
-
-/* LINKINFO */
-
-enum {
-	ETHTOOL_A_LINKINFO_UNSPEC,
-	ETHTOOL_A_LINKINFO_HEADER,		/* nest - _A_HEADER_* */
-	ETHTOOL_A_LINKINFO_PORT,		/* u8 */
-	ETHTOOL_A_LINKINFO_PHYADDR,		/* u8 */
-	ETHTOOL_A_LINKINFO_TP_MDIX,		/* u8 */
-	ETHTOOL_A_LINKINFO_TP_MDIX_CTRL,	/* u8 */
-	ETHTOOL_A_LINKINFO_TRANSCEIVER,		/* u8 */
-
-	/* add new constants above here */
-	__ETHTOOL_A_LINKINFO_CNT,
-	ETHTOOL_A_LINKINFO_MAX = __ETHTOOL_A_LINKINFO_CNT - 1
-};
-
-/* LINKMODES */
-
-enum {
-	ETHTOOL_A_LINKMODES_UNSPEC,
-	ETHTOOL_A_LINKMODES_HEADER,		/* nest - _A_HEADER_* */
-	ETHTOOL_A_LINKMODES_AUTONEG,		/* u8 */
-	ETHTOOL_A_LINKMODES_OURS,		/* bitset */
-	ETHTOOL_A_LINKMODES_PEER,		/* bitset */
-	ETHTOOL_A_LINKMODES_SPEED,		/* u32 */
-	ETHTOOL_A_LINKMODES_DUPLEX,		/* u8 */
-	ETHTOOL_A_LINKMODES_MASTER_SLAVE_CFG,	/* u8 */
-	ETHTOOL_A_LINKMODES_MASTER_SLAVE_STATE,	/* u8 */
-	ETHTOOL_A_LINKMODES_LANES,		/* u32 */
-	ETHTOOL_A_LINKMODES_RATE_MATCHING,	/* u8 */
-
-	/* add new constants above here */
-	__ETHTOOL_A_LINKMODES_CNT,
-	ETHTOOL_A_LINKMODES_MAX = __ETHTOOL_A_LINKMODES_CNT - 1
-};
-
-/* LINKSTATE */
-
-enum {
-	ETHTOOL_A_LINKSTATE_UNSPEC,
-	ETHTOOL_A_LINKSTATE_HEADER,		/* nest - _A_HEADER_* */
-	ETHTOOL_A_LINKSTATE_LINK,		/* u8 */
-	ETHTOOL_A_LINKSTATE_SQI,		/* u32 */
-	ETHTOOL_A_LINKSTATE_SQI_MAX,		/* u32 */
-	ETHTOOL_A_LINKSTATE_EXT_STATE,		/* u8 */
-	ETHTOOL_A_LINKSTATE_EXT_SUBSTATE,	/* u8 */
-	ETHTOOL_A_LINKSTATE_EXT_DOWN_CNT,	/* u32 */
-
-	/* add new constants above here */
-	__ETHTOOL_A_LINKSTATE_CNT,
-	ETHTOOL_A_LINKSTATE_MAX = __ETHTOOL_A_LINKSTATE_CNT - 1
-};
-
-/* DEBUG */
-
-enum {
-	ETHTOOL_A_DEBUG_UNSPEC,
-	ETHTOOL_A_DEBUG_HEADER,			/* nest - _A_HEADER_* */
-	ETHTOOL_A_DEBUG_MSGMASK,		/* bitset */
-
-	/* add new constants above here */
-	__ETHTOOL_A_DEBUG_CNT,
-	ETHTOOL_A_DEBUG_MAX = __ETHTOOL_A_DEBUG_CNT - 1
-};
-
-/* WOL */
-
-enum {
-	ETHTOOL_A_WOL_UNSPEC,
-	ETHTOOL_A_WOL_HEADER,			/* nest - _A_HEADER_* */
-	ETHTOOL_A_WOL_MODES,			/* bitset */
-	ETHTOOL_A_WOL_SOPASS,			/* binary */
-
-	/* add new constants above here */
-	__ETHTOOL_A_WOL_CNT,
-	ETHTOOL_A_WOL_MAX = __ETHTOOL_A_WOL_CNT - 1
-};
-
-/* FEATURES */
-
-enum {
-	ETHTOOL_A_FEATURES_UNSPEC,
-	ETHTOOL_A_FEATURES_HEADER,			/* nest - _A_HEADER_* */
-	ETHTOOL_A_FEATURES_HW,				/* bitset */
-	ETHTOOL_A_FEATURES_WANTED,			/* bitset */
-	ETHTOOL_A_FEATURES_ACTIVE,			/* bitset */
-	ETHTOOL_A_FEATURES_NOCHANGE,			/* bitset */
-
-	/* add new constants above here */
-	__ETHTOOL_A_FEATURES_CNT,
-	ETHTOOL_A_FEATURES_MAX = __ETHTOOL_A_FEATURES_CNT - 1
-};
-
-/* PRIVFLAGS */
-
-enum {
-	ETHTOOL_A_PRIVFLAGS_UNSPEC,
-	ETHTOOL_A_PRIVFLAGS_HEADER,			/* nest - _A_HEADER_* */
-	ETHTOOL_A_PRIVFLAGS_FLAGS,			/* bitset */
-
-	/* add new constants above here */
-	__ETHTOOL_A_PRIVFLAGS_CNT,
-	ETHTOOL_A_PRIVFLAGS_MAX = __ETHTOOL_A_PRIVFLAGS_CNT - 1
-};
-
-/* RINGS */
-
-enum {
-	ETHTOOL_TCP_DATA_SPLIT_UNKNOWN = 0,
-	ETHTOOL_TCP_DATA_SPLIT_DISABLED,
-	ETHTOOL_TCP_DATA_SPLIT_ENABLED,
-};
-
-enum {
-	ETHTOOL_A_RINGS_UNSPEC,
-	ETHTOOL_A_RINGS_HEADER,				/* nest - _A_HEADER_* */
-	ETHTOOL_A_RINGS_RX_MAX,				/* u32 */
-	ETHTOOL_A_RINGS_RX_MINI_MAX,			/* u32 */
-	ETHTOOL_A_RINGS_RX_JUMBO_MAX,			/* u32 */
-	ETHTOOL_A_RINGS_TX_MAX,				/* u32 */
-	ETHTOOL_A_RINGS_RX,				/* u32 */
-	ETHTOOL_A_RINGS_RX_MINI,			/* u32 */
-	ETHTOOL_A_RINGS_RX_JUMBO,			/* u32 */
-	ETHTOOL_A_RINGS_TX,				/* u32 */
-	ETHTOOL_A_RINGS_RX_BUF_LEN,                     /* u32 */
-	ETHTOOL_A_RINGS_TCP_DATA_SPLIT,			/* u8 */
-	ETHTOOL_A_RINGS_CQE_SIZE,			/* u32 */
-	ETHTOOL_A_RINGS_TX_PUSH,			/* u8 */
-	ETHTOOL_A_RINGS_RX_PUSH,			/* u8 */
-	ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN,		/* u32 */
-	ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN_MAX,		/* u32 */
-
-	/* add new constants above here */
-	__ETHTOOL_A_RINGS_CNT,
-	ETHTOOL_A_RINGS_MAX = (__ETHTOOL_A_RINGS_CNT - 1)
-};
-
-/* CHANNELS */
-
-enum {
-	ETHTOOL_A_CHANNELS_UNSPEC,
-	ETHTOOL_A_CHANNELS_HEADER,			/* nest - _A_HEADER_* */
-	ETHTOOL_A_CHANNELS_RX_MAX,			/* u32 */
-	ETHTOOL_A_CHANNELS_TX_MAX,			/* u32 */
-	ETHTOOL_A_CHANNELS_OTHER_MAX,			/* u32 */
-	ETHTOOL_A_CHANNELS_COMBINED_MAX,		/* u32 */
-	ETHTOOL_A_CHANNELS_RX_COUNT,			/* u32 */
-	ETHTOOL_A_CHANNELS_TX_COUNT,			/* u32 */
-	ETHTOOL_A_CHANNELS_OTHER_COUNT,			/* u32 */
-	ETHTOOL_A_CHANNELS_COMBINED_COUNT,		/* u32 */
-
-	/* add new constants above here */
-	__ETHTOOL_A_CHANNELS_CNT,
-	ETHTOOL_A_CHANNELS_MAX = (__ETHTOOL_A_CHANNELS_CNT - 1)
-};
-
-/* COALESCE */
-
-enum {
-	ETHTOOL_A_COALESCE_UNSPEC,
-	ETHTOOL_A_COALESCE_HEADER,			/* nest - _A_HEADER_* */
-	ETHTOOL_A_COALESCE_RX_USECS,			/* u32 */
-	ETHTOOL_A_COALESCE_RX_MAX_FRAMES,		/* u32 */
-	ETHTOOL_A_COALESCE_RX_USECS_IRQ,		/* u32 */
-	ETHTOOL_A_COALESCE_RX_MAX_FRAMES_IRQ,		/* u32 */
-	ETHTOOL_A_COALESCE_TX_USECS,			/* u32 */
-	ETHTOOL_A_COALESCE_TX_MAX_FRAMES,		/* u32 */
-	ETHTOOL_A_COALESCE_TX_USECS_IRQ,		/* u32 */
-	ETHTOOL_A_COALESCE_TX_MAX_FRAMES_IRQ,		/* u32 */
-	ETHTOOL_A_COALESCE_STATS_BLOCK_USECS,		/* u32 */
-	ETHTOOL_A_COALESCE_USE_ADAPTIVE_RX,		/* u8 */
-	ETHTOOL_A_COALESCE_USE_ADAPTIVE_TX,		/* u8 */
-	ETHTOOL_A_COALESCE_PKT_RATE_LOW,		/* u32 */
-	ETHTOOL_A_COALESCE_RX_USECS_LOW,		/* u32 */
-	ETHTOOL_A_COALESCE_RX_MAX_FRAMES_LOW,		/* u32 */
-	ETHTOOL_A_COALESCE_TX_USECS_LOW,		/* u32 */
-	ETHTOOL_A_COALESCE_TX_MAX_FRAMES_LOW,		/* u32 */
-	ETHTOOL_A_COALESCE_PKT_RATE_HIGH,		/* u32 */
-	ETHTOOL_A_COALESCE_RX_USECS_HIGH,		/* u32 */
-	ETHTOOL_A_COALESCE_RX_MAX_FRAMES_HIGH,		/* u32 */
-	ETHTOOL_A_COALESCE_TX_USECS_HIGH,		/* u32 */
-	ETHTOOL_A_COALESCE_TX_MAX_FRAMES_HIGH,		/* u32 */
-	ETHTOOL_A_COALESCE_RATE_SAMPLE_INTERVAL,	/* u32 */
-	ETHTOOL_A_COALESCE_USE_CQE_MODE_TX,		/* u8 */
-	ETHTOOL_A_COALESCE_USE_CQE_MODE_RX,		/* u8 */
-	ETHTOOL_A_COALESCE_TX_AGGR_MAX_BYTES,		/* u32 */
-	ETHTOOL_A_COALESCE_TX_AGGR_MAX_FRAMES,		/* u32 */
-	ETHTOOL_A_COALESCE_TX_AGGR_TIME_USECS,		/* u32 */
-	/* nest - _A_PROFILE_IRQ_MODERATION */
-	ETHTOOL_A_COALESCE_RX_PROFILE,
-	/* nest - _A_PROFILE_IRQ_MODERATION */
-	ETHTOOL_A_COALESCE_TX_PROFILE,
-
-	/* add new constants above here */
-	__ETHTOOL_A_COALESCE_CNT,
-	ETHTOOL_A_COALESCE_MAX = (__ETHTOOL_A_COALESCE_CNT - 1)
-};
-
-enum {
-	ETHTOOL_A_PROFILE_UNSPEC,
-	/* nest, _A_IRQ_MODERATION_* */
-	ETHTOOL_A_PROFILE_IRQ_MODERATION,
-	__ETHTOOL_A_PROFILE_CNT,
-	ETHTOOL_A_PROFILE_MAX = (__ETHTOOL_A_PROFILE_CNT - 1)
-};
-
-enum {
-	ETHTOOL_A_IRQ_MODERATION_UNSPEC,
-	ETHTOOL_A_IRQ_MODERATION_USEC,			/* u32 */
-	ETHTOOL_A_IRQ_MODERATION_PKTS,			/* u32 */
-	ETHTOOL_A_IRQ_MODERATION_COMPS,			/* u32 */
-
-	__ETHTOOL_A_IRQ_MODERATION_CNT,
-	ETHTOOL_A_IRQ_MODERATION_MAX = (__ETHTOOL_A_IRQ_MODERATION_CNT - 1)
-};
-
-/* PAUSE */
-
-enum {
-	ETHTOOL_A_PAUSE_UNSPEC,
-	ETHTOOL_A_PAUSE_HEADER,				/* nest - _A_HEADER_* */
-	ETHTOOL_A_PAUSE_AUTONEG,			/* u8 */
-	ETHTOOL_A_PAUSE_RX,				/* u8 */
-	ETHTOOL_A_PAUSE_TX,				/* u8 */
-	ETHTOOL_A_PAUSE_STATS,				/* nest - _PAUSE_STAT_* */
-	ETHTOOL_A_PAUSE_STATS_SRC,			/* u32 */
-
-	/* add new constants above here */
-	__ETHTOOL_A_PAUSE_CNT,
-	ETHTOOL_A_PAUSE_MAX = (__ETHTOOL_A_PAUSE_CNT - 1)
-};
-
-enum {
-	ETHTOOL_A_PAUSE_STAT_UNSPEC,
-	ETHTOOL_A_PAUSE_STAT_PAD,
-
-	ETHTOOL_A_PAUSE_STAT_TX_FRAMES,
-	ETHTOOL_A_PAUSE_STAT_RX_FRAMES,
-
-	/* add new constants above here
-	 * adjust ETHTOOL_PAUSE_STAT_CNT if adding non-stats!
-	 */
-	__ETHTOOL_A_PAUSE_STAT_CNT,
-	ETHTOOL_A_PAUSE_STAT_MAX = (__ETHTOOL_A_PAUSE_STAT_CNT - 1)
-};
-
-/* EEE */
-
-enum {
-	ETHTOOL_A_EEE_UNSPEC,
-	ETHTOOL_A_EEE_HEADER,				/* nest - _A_HEADER_* */
-	ETHTOOL_A_EEE_MODES_OURS,			/* bitset */
-	ETHTOOL_A_EEE_MODES_PEER,			/* bitset */
-	ETHTOOL_A_EEE_ACTIVE,				/* u8 */
-	ETHTOOL_A_EEE_ENABLED,				/* u8 */
-	ETHTOOL_A_EEE_TX_LPI_ENABLED,			/* u8 */
-	ETHTOOL_A_EEE_TX_LPI_TIMER,			/* u32 */
-
-	/* add new constants above here */
-	__ETHTOOL_A_EEE_CNT,
-	ETHTOOL_A_EEE_MAX = (__ETHTOOL_A_EEE_CNT - 1)
-};
-
-/* TSINFO */
-
-enum {
-	ETHTOOL_A_TSINFO_UNSPEC,
-	ETHTOOL_A_TSINFO_HEADER,			/* nest - _A_HEADER_* */
-	ETHTOOL_A_TSINFO_TIMESTAMPING,			/* bitset */
-	ETHTOOL_A_TSINFO_TX_TYPES,			/* bitset */
-	ETHTOOL_A_TSINFO_RX_FILTERS,			/* bitset */
-	ETHTOOL_A_TSINFO_PHC_INDEX,			/* u32 */
-	ETHTOOL_A_TSINFO_STATS,				/* nest - _A_TSINFO_STAT */
-
-	/* add new constants above here */
-	__ETHTOOL_A_TSINFO_CNT,
-	ETHTOOL_A_TSINFO_MAX = (__ETHTOOL_A_TSINFO_CNT - 1)
-};
-
-enum {
-	ETHTOOL_A_TS_STAT_UNSPEC,
-
-	ETHTOOL_A_TS_STAT_TX_PKTS,			/* uint */
-	ETHTOOL_A_TS_STAT_TX_LOST,			/* uint */
-	ETHTOOL_A_TS_STAT_TX_ERR,			/* uint */
-
-	/* add new constants above here */
-	__ETHTOOL_A_TS_STAT_CNT,
-	ETHTOOL_A_TS_STAT_MAX = (__ETHTOOL_A_TS_STAT_CNT - 1)
-
-};
-
-/* PHC VCLOCKS */
-
-enum {
-	ETHTOOL_A_PHC_VCLOCKS_UNSPEC,
-	ETHTOOL_A_PHC_VCLOCKS_HEADER,			/* nest - _A_HEADER_* */
-	ETHTOOL_A_PHC_VCLOCKS_NUM,			/* u32 */
-	ETHTOOL_A_PHC_VCLOCKS_INDEX,			/* array, s32 */
-
-	/* add new constants above here */
-	__ETHTOOL_A_PHC_VCLOCKS_CNT,
-	ETHTOOL_A_PHC_VCLOCKS_MAX = (__ETHTOOL_A_PHC_VCLOCKS_CNT - 1)
-};
-
-/* CABLE TEST */
-
-enum {
-	ETHTOOL_A_CABLE_TEST_UNSPEC,
-	ETHTOOL_A_CABLE_TEST_HEADER,		/* nest - _A_HEADER_* */
-
-	/* add new constants above here */
-	__ETHTOOL_A_CABLE_TEST_CNT,
-	ETHTOOL_A_CABLE_TEST_MAX = __ETHTOOL_A_CABLE_TEST_CNT - 1
-};
-
 /* CABLE TEST NOTIFY */
 enum {
 	ETHTOOL_A_CABLE_RESULT_CODE_UNSPEC,
@@ -582,74 +49,12 @@ enum {
 	ETHTOOL_A_CABLE_INF_SRC_ALCD,
 };
 
-enum {
-	ETHTOOL_A_CABLE_RESULT_UNSPEC,
-	ETHTOOL_A_CABLE_RESULT_PAIR,		/* u8 ETHTOOL_A_CABLE_PAIR_ */
-	ETHTOOL_A_CABLE_RESULT_CODE,		/* u8 ETHTOOL_A_CABLE_RESULT_CODE_ */
-	ETHTOOL_A_CABLE_RESULT_SRC,		/* u32 ETHTOOL_A_CABLE_INF_SRC_ */
-
-	__ETHTOOL_A_CABLE_RESULT_CNT,
-	ETHTOOL_A_CABLE_RESULT_MAX = (__ETHTOOL_A_CABLE_RESULT_CNT - 1)
-};
-
-enum {
-	ETHTOOL_A_CABLE_FAULT_LENGTH_UNSPEC,
-	ETHTOOL_A_CABLE_FAULT_LENGTH_PAIR,	/* u8 ETHTOOL_A_CABLE_PAIR_ */
-	ETHTOOL_A_CABLE_FAULT_LENGTH_CM,	/* u32 */
-	ETHTOOL_A_CABLE_FAULT_LENGTH_SRC,	/* u32 ETHTOOL_A_CABLE_INF_SRC_ */
-
-	__ETHTOOL_A_CABLE_FAULT_LENGTH_CNT,
-	ETHTOOL_A_CABLE_FAULT_LENGTH_MAX = (__ETHTOOL_A_CABLE_FAULT_LENGTH_CNT - 1)
-};
-
 enum {
 	ETHTOOL_A_CABLE_TEST_NTF_STATUS_UNSPEC,
 	ETHTOOL_A_CABLE_TEST_NTF_STATUS_STARTED,
 	ETHTOOL_A_CABLE_TEST_NTF_STATUS_COMPLETED
 };
 
-enum {
-	ETHTOOL_A_CABLE_NEST_UNSPEC,
-	ETHTOOL_A_CABLE_NEST_RESULT,		/* nest - ETHTOOL_A_CABLE_RESULT_ */
-	ETHTOOL_A_CABLE_NEST_FAULT_LENGTH,	/* nest - ETHTOOL_A_CABLE_FAULT_LENGTH_ */
-	__ETHTOOL_A_CABLE_NEST_CNT,
-	ETHTOOL_A_CABLE_NEST_MAX = (__ETHTOOL_A_CABLE_NEST_CNT - 1)
-};
-
-enum {
-	ETHTOOL_A_CABLE_TEST_NTF_UNSPEC,
-	ETHTOOL_A_CABLE_TEST_NTF_HEADER,	/* nest - ETHTOOL_A_HEADER_* */
-	ETHTOOL_A_CABLE_TEST_NTF_STATUS,	/* u8 - _STARTED/_COMPLETE */
-	ETHTOOL_A_CABLE_TEST_NTF_NEST,		/* nest - of results: */
-
-	__ETHTOOL_A_CABLE_TEST_NTF_CNT,
-	ETHTOOL_A_CABLE_TEST_NTF_MAX = (__ETHTOOL_A_CABLE_TEST_NTF_CNT - 1)
-};
-
-/* CABLE TEST TDR */
-
-enum {
-	ETHTOOL_A_CABLE_TEST_TDR_CFG_UNSPEC,
-	ETHTOOL_A_CABLE_TEST_TDR_CFG_FIRST,		/* u32 */
-	ETHTOOL_A_CABLE_TEST_TDR_CFG_LAST,		/* u32 */
-	ETHTOOL_A_CABLE_TEST_TDR_CFG_STEP,		/* u32 */
-	ETHTOOL_A_CABLE_TEST_TDR_CFG_PAIR,		/* u8 */
-
-	/* add new constants above here */
-	__ETHTOOL_A_CABLE_TEST_TDR_CFG_CNT,
-	ETHTOOL_A_CABLE_TEST_TDR_CFG_MAX = __ETHTOOL_A_CABLE_TEST_TDR_CFG_CNT - 1
-};
-
-enum {
-	ETHTOOL_A_CABLE_TEST_TDR_UNSPEC,
-	ETHTOOL_A_CABLE_TEST_TDR_HEADER,	/* nest - _A_HEADER_* */
-	ETHTOOL_A_CABLE_TEST_TDR_CFG,		/* nest - *_TDR_CFG_* */
-
-	/* add new constants above here */
-	__ETHTOOL_A_CABLE_TEST_TDR_CNT,
-	ETHTOOL_A_CABLE_TEST_TDR_MAX = __ETHTOOL_A_CABLE_TEST_TDR_CNT - 1
-};
-
 /* CABLE TEST TDR NOTIFY */
 
 enum {
@@ -689,132 +94,6 @@ enum {
 	ETHTOOL_A_CABLE_TDR_NEST_MAX = (__ETHTOOL_A_CABLE_TDR_NEST_CNT - 1)
 };
 
-enum {
-	ETHTOOL_A_CABLE_TEST_TDR_NTF_UNSPEC,
-	ETHTOOL_A_CABLE_TEST_TDR_NTF_HEADER,	/* nest - ETHTOOL_A_HEADER_* */
-	ETHTOOL_A_CABLE_TEST_TDR_NTF_STATUS,	/* u8 - _STARTED/_COMPLETE */
-	ETHTOOL_A_CABLE_TEST_TDR_NTF_NEST,	/* nest - of results: */
-
-	/* add new constants above here */
-	__ETHTOOL_A_CABLE_TEST_TDR_NTF_CNT,
-	ETHTOOL_A_CABLE_TEST_TDR_NTF_MAX = __ETHTOOL_A_CABLE_TEST_TDR_NTF_CNT - 1
-};
-
-/* TUNNEL INFO */
-
-enum {
-	ETHTOOL_UDP_TUNNEL_TYPE_VXLAN,
-	ETHTOOL_UDP_TUNNEL_TYPE_GENEVE,
-	ETHTOOL_UDP_TUNNEL_TYPE_VXLAN_GPE,
-
-	__ETHTOOL_UDP_TUNNEL_TYPE_CNT
-};
-
-enum {
-	ETHTOOL_A_TUNNEL_UDP_ENTRY_UNSPEC,
-
-	ETHTOOL_A_TUNNEL_UDP_ENTRY_PORT,		/* be16 */
-	ETHTOOL_A_TUNNEL_UDP_ENTRY_TYPE,		/* u32 */
-
-	/* add new constants above here */
-	__ETHTOOL_A_TUNNEL_UDP_ENTRY_CNT,
-	ETHTOOL_A_TUNNEL_UDP_ENTRY_MAX = (__ETHTOOL_A_TUNNEL_UDP_ENTRY_CNT - 1)
-};
-
-enum {
-	ETHTOOL_A_TUNNEL_UDP_TABLE_UNSPEC,
-
-	ETHTOOL_A_TUNNEL_UDP_TABLE_SIZE,		/* u32 */
-	ETHTOOL_A_TUNNEL_UDP_TABLE_TYPES,		/* bitset */
-	ETHTOOL_A_TUNNEL_UDP_TABLE_ENTRY,		/* nest - _UDP_ENTRY_* */
-
-	/* add new constants above here */
-	__ETHTOOL_A_TUNNEL_UDP_TABLE_CNT,
-	ETHTOOL_A_TUNNEL_UDP_TABLE_MAX = (__ETHTOOL_A_TUNNEL_UDP_TABLE_CNT - 1)
-};
-
-enum {
-	ETHTOOL_A_TUNNEL_UDP_UNSPEC,
-
-	ETHTOOL_A_TUNNEL_UDP_TABLE,			/* nest - _UDP_TABLE_* */
-
-	/* add new constants above here */
-	__ETHTOOL_A_TUNNEL_UDP_CNT,
-	ETHTOOL_A_TUNNEL_UDP_MAX = (__ETHTOOL_A_TUNNEL_UDP_CNT - 1)
-};
-
-enum {
-	ETHTOOL_A_TUNNEL_INFO_UNSPEC,
-	ETHTOOL_A_TUNNEL_INFO_HEADER,			/* nest - _A_HEADER_* */
-
-	ETHTOOL_A_TUNNEL_INFO_UDP_PORTS,		/* nest - _UDP_TABLE */
-
-	/* add new constants above here */
-	__ETHTOOL_A_TUNNEL_INFO_CNT,
-	ETHTOOL_A_TUNNEL_INFO_MAX = (__ETHTOOL_A_TUNNEL_INFO_CNT - 1)
-};
-
-/* FEC */
-
-enum {
-	ETHTOOL_A_FEC_UNSPEC,
-	ETHTOOL_A_FEC_HEADER,				/* nest - _A_HEADER_* */
-	ETHTOOL_A_FEC_MODES,				/* bitset */
-	ETHTOOL_A_FEC_AUTO,				/* u8 */
-	ETHTOOL_A_FEC_ACTIVE,				/* u32 */
-	ETHTOOL_A_FEC_STATS,				/* nest - _A_FEC_STAT */
-
-	__ETHTOOL_A_FEC_CNT,
-	ETHTOOL_A_FEC_MAX = (__ETHTOOL_A_FEC_CNT - 1)
-};
-
-enum {
-	ETHTOOL_A_FEC_STAT_UNSPEC,
-	ETHTOOL_A_FEC_STAT_PAD,
-
-	ETHTOOL_A_FEC_STAT_CORRECTED,			/* array, u64 */
-	ETHTOOL_A_FEC_STAT_UNCORR,			/* array, u64 */
-	ETHTOOL_A_FEC_STAT_CORR_BITS,			/* array, u64 */
-
-	/* add new constants above here */
-	__ETHTOOL_A_FEC_STAT_CNT,
-	ETHTOOL_A_FEC_STAT_MAX = (__ETHTOOL_A_FEC_STAT_CNT - 1)
-};
-
-/* MODULE EEPROM */
-
-enum {
-	ETHTOOL_A_MODULE_EEPROM_UNSPEC,
-	ETHTOOL_A_MODULE_EEPROM_HEADER,			/* nest - _A_HEADER_* */
-
-	ETHTOOL_A_MODULE_EEPROM_OFFSET,			/* u32 */
-	ETHTOOL_A_MODULE_EEPROM_LENGTH,			/* u32 */
-	ETHTOOL_A_MODULE_EEPROM_PAGE,			/* u8 */
-	ETHTOOL_A_MODULE_EEPROM_BANK,			/* u8 */
-	ETHTOOL_A_MODULE_EEPROM_I2C_ADDRESS,		/* u8 */
-	ETHTOOL_A_MODULE_EEPROM_DATA,			/* binary */
-
-	__ETHTOOL_A_MODULE_EEPROM_CNT,
-	ETHTOOL_A_MODULE_EEPROM_MAX = (__ETHTOOL_A_MODULE_EEPROM_CNT - 1)
-};
-
-/* STATS */
-
-enum {
-	ETHTOOL_A_STATS_UNSPEC,
-	ETHTOOL_A_STATS_PAD,
-	ETHTOOL_A_STATS_HEADER,			/* nest - _A_HEADER_* */
-	ETHTOOL_A_STATS_GROUPS,			/* bitset */
-
-	ETHTOOL_A_STATS_GRP,			/* nest - _A_STATS_GRP_* */
-
-	ETHTOOL_A_STATS_SRC,			/* u32 */
-
-	/* add new constants above here */
-	__ETHTOOL_A_STATS_CNT,
-	ETHTOOL_A_STATS_MAX = (__ETHTOOL_A_STATS_CNT - 1)
-};
-
 enum {
 	ETHTOOL_STATS_ETH_PHY,
 	ETHTOOL_STATS_ETH_MAC,
@@ -825,27 +104,6 @@ enum {
 	__ETHTOOL_STATS_CNT
 };
 
-enum {
-	ETHTOOL_A_STATS_GRP_UNSPEC,
-	ETHTOOL_A_STATS_GRP_PAD,
-
-	ETHTOOL_A_STATS_GRP_ID,			/* u32 */
-	ETHTOOL_A_STATS_GRP_SS_ID,		/* u32 */
-
-	ETHTOOL_A_STATS_GRP_STAT,		/* nest */
-
-	ETHTOOL_A_STATS_GRP_HIST_RX,		/* nest */
-	ETHTOOL_A_STATS_GRP_HIST_TX,		/* nest */
-
-	ETHTOOL_A_STATS_GRP_HIST_BKT_LOW,	/* u32 */
-	ETHTOOL_A_STATS_GRP_HIST_BKT_HI,	/* u32 */
-	ETHTOOL_A_STATS_GRP_HIST_VAL,		/* u64 */
-
-	/* add new constants above here */
-	__ETHTOOL_A_STATS_GRP_CNT,
-	ETHTOOL_A_STATS_GRP_MAX = (__ETHTOOL_A_STATS_GRP_CNT - 1)
-};
-
 enum {
 	/* 30.3.2.1.5 aSymbolErrorDuringCarrier */
 	ETHTOOL_A_STATS_ETH_PHY_5_SYM_ERR,
@@ -935,155 +193,6 @@ enum {
 	ETHTOOL_A_STATS_RMON_MAX = (__ETHTOOL_A_STATS_RMON_CNT - 1)
 };
 
-/* MODULE */
-
-enum {
-	ETHTOOL_A_MODULE_UNSPEC,
-	ETHTOOL_A_MODULE_HEADER,		/* nest - _A_HEADER_* */
-	ETHTOOL_A_MODULE_POWER_MODE_POLICY,	/* u8 */
-	ETHTOOL_A_MODULE_POWER_MODE,		/* u8 */
-
-	/* add new constants above here */
-	__ETHTOOL_A_MODULE_CNT,
-	ETHTOOL_A_MODULE_MAX = (__ETHTOOL_A_MODULE_CNT - 1)
-};
-
-/* Power Sourcing Equipment */
-enum {
-	ETHTOOL_A_C33_PSE_PW_LIMIT_UNSPEC,
-	ETHTOOL_A_C33_PSE_PW_LIMIT_MIN,	/* u32 */
-	ETHTOOL_A_C33_PSE_PW_LIMIT_MAX,	/* u32 */
-};
-
-enum {
-	ETHTOOL_A_PSE_UNSPEC,
-	ETHTOOL_A_PSE_HEADER,			/* nest - _A_HEADER_* */
-	ETHTOOL_A_PODL_PSE_ADMIN_STATE,		/* u32 */
-	ETHTOOL_A_PODL_PSE_ADMIN_CONTROL,	/* u32 */
-	ETHTOOL_A_PODL_PSE_PW_D_STATUS,		/* u32 */
-	ETHTOOL_A_C33_PSE_ADMIN_STATE,		/* u32 */
-	ETHTOOL_A_C33_PSE_ADMIN_CONTROL,	/* u32 */
-	ETHTOOL_A_C33_PSE_PW_D_STATUS,		/* u32 */
-	ETHTOOL_A_C33_PSE_PW_CLASS,		/* u32 */
-	ETHTOOL_A_C33_PSE_ACTUAL_PW,		/* u32 */
-	ETHTOOL_A_C33_PSE_EXT_STATE,		/* u32 */
-	ETHTOOL_A_C33_PSE_EXT_SUBSTATE,		/* u32 */
-	ETHTOOL_A_C33_PSE_AVAIL_PW_LIMIT,	/* u32 */
-	ETHTOOL_A_C33_PSE_PW_LIMIT_RANGES,	/* nest - _C33_PSE_PW_LIMIT_* */
-
-	/* add new constants above here */
-	__ETHTOOL_A_PSE_CNT,
-	ETHTOOL_A_PSE_MAX = (__ETHTOOL_A_PSE_CNT - 1)
-};
-
-enum {
-	ETHTOOL_A_RSS_UNSPEC,
-	ETHTOOL_A_RSS_HEADER,
-	ETHTOOL_A_RSS_CONTEXT,		/* u32 */
-	ETHTOOL_A_RSS_HFUNC,		/* u32 */
-	ETHTOOL_A_RSS_INDIR,		/* binary */
-	ETHTOOL_A_RSS_HKEY,		/* binary */
-	ETHTOOL_A_RSS_INPUT_XFRM,	/* u32 */
-	ETHTOOL_A_RSS_START_CONTEXT,	/* u32 */
-
-	__ETHTOOL_A_RSS_CNT,
-	ETHTOOL_A_RSS_MAX = (__ETHTOOL_A_RSS_CNT - 1),
-};
-
-/* PLCA */
-
-enum {
-	ETHTOOL_A_PLCA_UNSPEC,
-	ETHTOOL_A_PLCA_HEADER,			/* nest - _A_HEADER_* */
-	ETHTOOL_A_PLCA_VERSION,			/* u16 */
-	ETHTOOL_A_PLCA_ENABLED,			/* u8  */
-	ETHTOOL_A_PLCA_STATUS,			/* u8  */
-	ETHTOOL_A_PLCA_NODE_CNT,		/* u32 */
-	ETHTOOL_A_PLCA_NODE_ID,			/* u32 */
-	ETHTOOL_A_PLCA_TO_TMR,			/* u32 */
-	ETHTOOL_A_PLCA_BURST_CNT,		/* u32 */
-	ETHTOOL_A_PLCA_BURST_TMR,		/* u32 */
-
-	/* add new constants above here */
-	__ETHTOOL_A_PLCA_CNT,
-	ETHTOOL_A_PLCA_MAX = (__ETHTOOL_A_PLCA_CNT - 1)
-};
-
-/* MAC Merge (802.3) */
-
-enum {
-	ETHTOOL_A_MM_STAT_UNSPEC,
-	ETHTOOL_A_MM_STAT_PAD,
-
-	/* aMACMergeFrameAssErrorCount */
-	ETHTOOL_A_MM_STAT_REASSEMBLY_ERRORS,	/* u64 */
-	/* aMACMergeFrameSmdErrorCount */
-	ETHTOOL_A_MM_STAT_SMD_ERRORS,		/* u64 */
-	/* aMACMergeFrameAssOkCount */
-	ETHTOOL_A_MM_STAT_REASSEMBLY_OK,	/* u64 */
-	/* aMACMergeFragCountRx */
-	ETHTOOL_A_MM_STAT_RX_FRAG_COUNT,	/* u64 */
-	/* aMACMergeFragCountTx */
-	ETHTOOL_A_MM_STAT_TX_FRAG_COUNT,	/* u64 */
-	/* aMACMergeHoldCount */
-	ETHTOOL_A_MM_STAT_HOLD_COUNT,		/* u64 */
-
-	/* add new constants above here */
-	__ETHTOOL_A_MM_STAT_CNT,
-	ETHTOOL_A_MM_STAT_MAX = (__ETHTOOL_A_MM_STAT_CNT - 1)
-};
-
-enum {
-	ETHTOOL_A_MM_UNSPEC,
-	ETHTOOL_A_MM_HEADER,			/* nest - _A_HEADER_* */
-	ETHTOOL_A_MM_PMAC_ENABLED,		/* u8 */
-	ETHTOOL_A_MM_TX_ENABLED,		/* u8 */
-	ETHTOOL_A_MM_TX_ACTIVE,			/* u8 */
-	ETHTOOL_A_MM_TX_MIN_FRAG_SIZE,		/* u32 */
-	ETHTOOL_A_MM_RX_MIN_FRAG_SIZE,		/* u32 */
-	ETHTOOL_A_MM_VERIFY_ENABLED,		/* u8 */
-	ETHTOOL_A_MM_VERIFY_STATUS,		/* u8 */
-	ETHTOOL_A_MM_VERIFY_TIME,		/* u32 */
-	ETHTOOL_A_MM_MAX_VERIFY_TIME,		/* u32 */
-	ETHTOOL_A_MM_STATS,			/* nest - _A_MM_STAT_* */
-
-	/* add new constants above here */
-	__ETHTOOL_A_MM_CNT,
-	ETHTOOL_A_MM_MAX = (__ETHTOOL_A_MM_CNT - 1)
-};
-
-/* MODULE_FW_FLASH */
-
-enum {
-	ETHTOOL_A_MODULE_FW_FLASH_UNSPEC,
-	ETHTOOL_A_MODULE_FW_FLASH_HEADER,		/* nest - _A_HEADER_* */
-	ETHTOOL_A_MODULE_FW_FLASH_FILE_NAME,		/* string */
-	ETHTOOL_A_MODULE_FW_FLASH_PASSWORD,		/* u32 */
-	ETHTOOL_A_MODULE_FW_FLASH_STATUS,		/* u32 */
-	ETHTOOL_A_MODULE_FW_FLASH_STATUS_MSG,		/* string */
-	ETHTOOL_A_MODULE_FW_FLASH_DONE,			/* uint */
-	ETHTOOL_A_MODULE_FW_FLASH_TOTAL,		/* uint */
-
-	/* add new constants above here */
-	__ETHTOOL_A_MODULE_FW_FLASH_CNT,
-	ETHTOOL_A_MODULE_FW_FLASH_MAX = (__ETHTOOL_A_MODULE_FW_FLASH_CNT - 1)
-};
-
-enum {
-	ETHTOOL_A_PHY_UNSPEC,
-	ETHTOOL_A_PHY_HEADER,			/* nest - _A_HEADER_* */
-	ETHTOOL_A_PHY_INDEX,			/* u32 */
-	ETHTOOL_A_PHY_DRVNAME,			/* string */
-	ETHTOOL_A_PHY_NAME,			/* string */
-	ETHTOOL_A_PHY_UPSTREAM_TYPE,		/* u32 */
-	ETHTOOL_A_PHY_UPSTREAM_INDEX,		/* u32 */
-	ETHTOOL_A_PHY_UPSTREAM_SFP_NAME,	/* string */
-	ETHTOOL_A_PHY_DOWNSTREAM_SFP_NAME,	/* string */
-
-	/* add new constants above here */
-	__ETHTOOL_A_PHY_CNT,
-	ETHTOOL_A_PHY_MAX = (__ETHTOOL_A_PHY_CNT - 1)
-};
 
 /* generic netlink info */
 #define ETHTOOL_GENL_NAME "ethtool"
diff --git a/include/uapi/linux/ethtool_netlink_generated.h b/include/uapi/linux/ethtool_netlink_generated.h
new file mode 100644
index 000000000000..4b4bf17d1a88
--- /dev/null
+++ b/include/uapi/linux/ethtool_netlink_generated.h
@@ -0,0 +1,899 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+#ifndef _UAPI_LINUX_ETHTOOL_NETLINK_GENERATED_H
+#define _UAPI_LINUX_ETHTOOL_NETLINK_GENERATED_H
+
+/* TUNNEL INFO */
+
+enum {
+	ETHTOOL_UDP_TUNNEL_TYPE_VXLAN,
+	ETHTOOL_UDP_TUNNEL_TYPE_GENEVE,
+	ETHTOOL_UDP_TUNNEL_TYPE_VXLAN_GPE,
+
+	__ETHTOOL_UDP_TUNNEL_TYPE_CNT
+};
+
+/* request header */
+
+enum ethtool_header_flags {
+	ETHTOOL_FLAG_COMPACT_BITSETS	= 1 << 0,	/* use compact bitsets in reply */
+	ETHTOOL_FLAG_OMIT_REPLY		= 1 << 1,	/* provide optional reply for SET or ACT requests */
+	ETHTOOL_FLAG_STATS		= 1 << 2,	/* request statistics, if supported by the driver */
+};
+
+enum {
+	ETHTOOL_TCP_DATA_SPLIT_UNKNOWN = 0,
+	ETHTOOL_TCP_DATA_SPLIT_DISABLED,
+	ETHTOOL_TCP_DATA_SPLIT_ENABLED,
+};
+
+enum {
+	ETHTOOL_A_HEADER_UNSPEC,
+	ETHTOOL_A_HEADER_DEV_INDEX,		/* u32 */
+	ETHTOOL_A_HEADER_DEV_NAME,		/* string */
+	ETHTOOL_A_HEADER_FLAGS,			/* u32 - ETHTOOL_FLAG_* */
+	ETHTOOL_A_HEADER_PHY_INDEX,		/* u32 */
+
+	/* add new constants above here */
+	__ETHTOOL_A_HEADER_CNT,
+	ETHTOOL_A_HEADER_MAX = __ETHTOOL_A_HEADER_CNT - 1
+};
+
+/* bit sets */
+
+enum {
+	ETHTOOL_A_BITSET_BIT_UNSPEC,
+	ETHTOOL_A_BITSET_BIT_INDEX,		/* u32 */
+	ETHTOOL_A_BITSET_BIT_NAME,		/* string */
+	ETHTOOL_A_BITSET_BIT_VALUE,		/* flag */
+
+	/* add new constants above here */
+	__ETHTOOL_A_BITSET_BIT_CNT,
+	ETHTOOL_A_BITSET_BIT_MAX = __ETHTOOL_A_BITSET_BIT_CNT - 1
+};
+
+enum {
+	ETHTOOL_A_BITSET_BITS_UNSPEC,
+	ETHTOOL_A_BITSET_BITS_BIT,		/* nest - _A_BITSET_BIT_* */
+
+	/* add new constants above here */
+	__ETHTOOL_A_BITSET_BITS_CNT,
+	ETHTOOL_A_BITSET_BITS_MAX = __ETHTOOL_A_BITSET_BITS_CNT - 1
+};
+
+enum {
+	ETHTOOL_A_BITSET_UNSPEC,
+	ETHTOOL_A_BITSET_NOMASK,		/* flag */
+	ETHTOOL_A_BITSET_SIZE,			/* u32 */
+	ETHTOOL_A_BITSET_BITS,			/* nest - _A_BITSET_BITS_* */
+	ETHTOOL_A_BITSET_VALUE,			/* binary */
+	ETHTOOL_A_BITSET_MASK,			/* binary */
+
+	/* add new constants above here */
+	__ETHTOOL_A_BITSET_CNT,
+	ETHTOOL_A_BITSET_MAX = __ETHTOOL_A_BITSET_CNT - 1
+};
+
+/* string sets */
+
+enum {
+	ETHTOOL_A_STRING_UNSPEC,
+	ETHTOOL_A_STRING_INDEX,			/* u32 */
+	ETHTOOL_A_STRING_VALUE,			/* string */
+
+	/* add new constants above here */
+	__ETHTOOL_A_STRING_CNT,
+	ETHTOOL_A_STRING_MAX = __ETHTOOL_A_STRING_CNT - 1
+};
+
+enum {
+	ETHTOOL_A_STRINGS_UNSPEC,
+	ETHTOOL_A_STRINGS_STRING,		/* nest - _A_STRINGS_* */
+
+	/* add new constants above here */
+	__ETHTOOL_A_STRINGS_CNT,
+	ETHTOOL_A_STRINGS_MAX = __ETHTOOL_A_STRINGS_CNT - 1
+};
+
+enum {
+	ETHTOOL_A_STRINGSET_UNSPEC,
+	ETHTOOL_A_STRINGSET_ID,			/* u32 */
+	ETHTOOL_A_STRINGSET_COUNT,		/* u32 */
+	ETHTOOL_A_STRINGSET_STRINGS,		/* nest - _A_STRINGS_* */
+
+	/* add new constants above here */
+	__ETHTOOL_A_STRINGSET_CNT,
+	ETHTOOL_A_STRINGSET_MAX = __ETHTOOL_A_STRINGSET_CNT - 1
+};
+
+enum {
+	ETHTOOL_A_STRINGSETS_UNSPEC,
+	ETHTOOL_A_STRINGSETS_STRINGSET,		/* nest - _A_STRINGSET_* */
+
+	/* add new constants above here */
+	__ETHTOOL_A_STRINGSETS_CNT,
+	ETHTOOL_A_STRINGSETS_MAX = __ETHTOOL_A_STRINGSETS_CNT - 1
+};
+
+/* STRSET */
+
+enum {
+	ETHTOOL_A_STRSET_UNSPEC,
+	ETHTOOL_A_STRSET_HEADER,		/* nest - _A_HEADER_* */
+	ETHTOOL_A_STRSET_STRINGSETS,		/* nest - _A_STRINGSETS_* */
+	ETHTOOL_A_STRSET_COUNTS_ONLY,		/* flag */
+
+	/* add new constants above here */
+	__ETHTOOL_A_STRSET_CNT,
+	ETHTOOL_A_STRSET_MAX = __ETHTOOL_A_STRSET_CNT - 1
+};
+
+/* PRIVFLAGS */
+
+enum {
+	ETHTOOL_A_PRIVFLAGS_UNSPEC,
+	ETHTOOL_A_PRIVFLAGS_HEADER,			/* nest - _A_HEADER_* */
+	ETHTOOL_A_PRIVFLAGS_FLAGS,			/* bitset */
+
+	/* add new constants above here */
+	__ETHTOOL_A_PRIVFLAGS_CNT,
+	ETHTOOL_A_PRIVFLAGS_MAX = __ETHTOOL_A_PRIVFLAGS_CNT - 1
+};
+
+/* RINGS */
+
+enum {
+	ETHTOOL_A_RINGS_UNSPEC,
+	ETHTOOL_A_RINGS_HEADER,				/* nest - _A_HEADER_* */
+	ETHTOOL_A_RINGS_RX_MAX,				/* u32 */
+	ETHTOOL_A_RINGS_RX_MINI_MAX,			/* u32 */
+	ETHTOOL_A_RINGS_RX_JUMBO_MAX,			/* u32 */
+	ETHTOOL_A_RINGS_TX_MAX,				/* u32 */
+	ETHTOOL_A_RINGS_RX,				/* u32 */
+	ETHTOOL_A_RINGS_RX_MINI,			/* u32 */
+	ETHTOOL_A_RINGS_RX_JUMBO,			/* u32 */
+	ETHTOOL_A_RINGS_TX,				/* u32 */
+	ETHTOOL_A_RINGS_RX_BUF_LEN,                     /* u32 */
+	ETHTOOL_A_RINGS_TCP_DATA_SPLIT,			/* u8 */
+	ETHTOOL_A_RINGS_CQE_SIZE,			/* u32 */
+	ETHTOOL_A_RINGS_TX_PUSH,			/* u8 */
+	ETHTOOL_A_RINGS_RX_PUSH,			/* u8 */
+	ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN,		/* u32 */
+	ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN_MAX,		/* u32 */
+
+	/* add new constants above here */
+	__ETHTOOL_A_RINGS_CNT,
+	ETHTOOL_A_RINGS_MAX = (__ETHTOOL_A_RINGS_CNT - 1)
+};
+
+/* MAC Merge (802.3) */
+
+enum {
+	ETHTOOL_A_MM_STAT_UNSPEC,
+	ETHTOOL_A_MM_STAT_PAD,
+
+	/* aMACMergeFrameAssErrorCount */
+	ETHTOOL_A_MM_STAT_REASSEMBLY_ERRORS,	/* u64 */
+	/* aMACMergeFrameSmdErrorCount */
+	ETHTOOL_A_MM_STAT_SMD_ERRORS,		/* u64 */
+	/* aMACMergeFrameAssOkCount */
+	ETHTOOL_A_MM_STAT_REASSEMBLY_OK,	/* u64 */
+	/* aMACMergeFragCountRx */
+	ETHTOOL_A_MM_STAT_RX_FRAG_COUNT,	/* u64 */
+	/* aMACMergeFragCountTx */
+	ETHTOOL_A_MM_STAT_TX_FRAG_COUNT,	/* u64 */
+	/* aMACMergeHoldCount */
+	ETHTOOL_A_MM_STAT_HOLD_COUNT,		/* u64 */
+
+	/* add new constants above here */
+	__ETHTOOL_A_MM_STAT_CNT,
+	ETHTOOL_A_MM_STAT_MAX = (__ETHTOOL_A_MM_STAT_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_MM_UNSPEC,
+	ETHTOOL_A_MM_HEADER,			/* nest - _A_HEADER_* */
+	ETHTOOL_A_MM_PMAC_ENABLED,		/* u8 */
+	ETHTOOL_A_MM_TX_ENABLED,		/* u8 */
+	ETHTOOL_A_MM_TX_ACTIVE,			/* u8 */
+	ETHTOOL_A_MM_TX_MIN_FRAG_SIZE,		/* u32 */
+	ETHTOOL_A_MM_RX_MIN_FRAG_SIZE,		/* u32 */
+	ETHTOOL_A_MM_VERIFY_ENABLED,		/* u8 */
+	ETHTOOL_A_MM_VERIFY_STATUS,		/* u8 */
+	ETHTOOL_A_MM_VERIFY_TIME,		/* u32 */
+	ETHTOOL_A_MM_MAX_VERIFY_TIME,		/* u32 */
+	ETHTOOL_A_MM_STATS,			/* nest - _A_MM_STAT_* */
+
+	/* add new constants above here */
+	__ETHTOOL_A_MM_CNT,
+	ETHTOOL_A_MM_MAX = (__ETHTOOL_A_MM_CNT - 1)
+};
+
+/* LINKINFO */
+
+enum {
+	ETHTOOL_A_LINKINFO_UNSPEC,
+	ETHTOOL_A_LINKINFO_HEADER,		/* nest - _A_HEADER_* */
+	ETHTOOL_A_LINKINFO_PORT,		/* u8 */
+	ETHTOOL_A_LINKINFO_PHYADDR,		/* u8 */
+	ETHTOOL_A_LINKINFO_TP_MDIX,		/* u8 */
+	ETHTOOL_A_LINKINFO_TP_MDIX_CTRL,	/* u8 */
+	ETHTOOL_A_LINKINFO_TRANSCEIVER,		/* u8 */
+
+	/* add new constants above here */
+	__ETHTOOL_A_LINKINFO_CNT,
+	ETHTOOL_A_LINKINFO_MAX = __ETHTOOL_A_LINKINFO_CNT - 1
+};
+
+/* LINKMODES */
+
+enum {
+	ETHTOOL_A_LINKMODES_UNSPEC,
+	ETHTOOL_A_LINKMODES_HEADER,		/* nest - _A_HEADER_* */
+	ETHTOOL_A_LINKMODES_AUTONEG,		/* u8 */
+	ETHTOOL_A_LINKMODES_OURS,		/* bitset */
+	ETHTOOL_A_LINKMODES_PEER,		/* bitset */
+	ETHTOOL_A_LINKMODES_SPEED,		/* u32 */
+	ETHTOOL_A_LINKMODES_DUPLEX,		/* u8 */
+	ETHTOOL_A_LINKMODES_MASTER_SLAVE_CFG,	/* u8 */
+	ETHTOOL_A_LINKMODES_MASTER_SLAVE_STATE,	/* u8 */
+	ETHTOOL_A_LINKMODES_LANES,		/* u32 */
+	ETHTOOL_A_LINKMODES_RATE_MATCHING,	/* u8 */
+
+	/* add new constants above here */
+	__ETHTOOL_A_LINKMODES_CNT,
+	ETHTOOL_A_LINKMODES_MAX = __ETHTOOL_A_LINKMODES_CNT - 1
+};
+
+/* LINKSTATE */
+
+enum {
+	ETHTOOL_A_LINKSTATE_UNSPEC,
+	ETHTOOL_A_LINKSTATE_HEADER,		/* nest - _A_HEADER_* */
+	ETHTOOL_A_LINKSTATE_LINK,		/* u8 */
+	ETHTOOL_A_LINKSTATE_SQI,		/* u32 */
+	ETHTOOL_A_LINKSTATE_SQI_MAX,		/* u32 */
+	ETHTOOL_A_LINKSTATE_EXT_STATE,		/* u8 */
+	ETHTOOL_A_LINKSTATE_EXT_SUBSTATE,	/* u8 */
+	ETHTOOL_A_LINKSTATE_EXT_DOWN_CNT,	/* u32 */
+
+	/* add new constants above here */
+	__ETHTOOL_A_LINKSTATE_CNT,
+	ETHTOOL_A_LINKSTATE_MAX = __ETHTOOL_A_LINKSTATE_CNT - 1
+};
+
+/* DEBUG */
+
+enum {
+	ETHTOOL_A_DEBUG_UNSPEC,
+	ETHTOOL_A_DEBUG_HEADER,			/* nest - _A_HEADER_* */
+	ETHTOOL_A_DEBUG_MSGMASK,		/* bitset */
+
+	/* add new constants above here */
+	__ETHTOOL_A_DEBUG_CNT,
+	ETHTOOL_A_DEBUG_MAX = __ETHTOOL_A_DEBUG_CNT - 1
+};
+
+/* WOL */
+
+enum {
+	ETHTOOL_A_WOL_UNSPEC,
+	ETHTOOL_A_WOL_HEADER,			/* nest - _A_HEADER_* */
+	ETHTOOL_A_WOL_MODES,			/* bitset */
+	ETHTOOL_A_WOL_SOPASS,			/* binary */
+
+	/* add new constants above here */
+	__ETHTOOL_A_WOL_CNT,
+	ETHTOOL_A_WOL_MAX = __ETHTOOL_A_WOL_CNT - 1
+};
+
+/* FEATURES */
+
+enum {
+	ETHTOOL_A_FEATURES_UNSPEC,
+	ETHTOOL_A_FEATURES_HEADER,			/* nest - _A_HEADER_* */
+	ETHTOOL_A_FEATURES_HW,				/* bitset */
+	ETHTOOL_A_FEATURES_WANTED,			/* bitset */
+	ETHTOOL_A_FEATURES_ACTIVE,			/* bitset */
+	ETHTOOL_A_FEATURES_NOCHANGE,			/* bitset */
+
+	/* add new constants above here */
+	__ETHTOOL_A_FEATURES_CNT,
+	ETHTOOL_A_FEATURES_MAX = __ETHTOOL_A_FEATURES_CNT - 1
+};
+
+/* CHANNELS */
+
+enum {
+	ETHTOOL_A_CHANNELS_UNSPEC,
+	ETHTOOL_A_CHANNELS_HEADER,			/* nest - _A_HEADER_* */
+	ETHTOOL_A_CHANNELS_RX_MAX,			/* u32 */
+	ETHTOOL_A_CHANNELS_TX_MAX,			/* u32 */
+	ETHTOOL_A_CHANNELS_OTHER_MAX,			/* u32 */
+	ETHTOOL_A_CHANNELS_COMBINED_MAX,		/* u32 */
+	ETHTOOL_A_CHANNELS_RX_COUNT,			/* u32 */
+	ETHTOOL_A_CHANNELS_TX_COUNT,			/* u32 */
+	ETHTOOL_A_CHANNELS_OTHER_COUNT,			/* u32 */
+	ETHTOOL_A_CHANNELS_COMBINED_COUNT,		/* u32 */
+
+	/* add new constants above here */
+	__ETHTOOL_A_CHANNELS_CNT,
+	ETHTOOL_A_CHANNELS_MAX = (__ETHTOOL_A_CHANNELS_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_IRQ_MODERATION_UNSPEC,
+	ETHTOOL_A_IRQ_MODERATION_USEC,			/* u32 */
+	ETHTOOL_A_IRQ_MODERATION_PKTS,			/* u32 */
+	ETHTOOL_A_IRQ_MODERATION_COMPS,			/* u32 */
+
+	__ETHTOOL_A_IRQ_MODERATION_CNT,
+	ETHTOOL_A_IRQ_MODERATION_MAX = (__ETHTOOL_A_IRQ_MODERATION_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_PROFILE_UNSPEC,
+	/* nest, _A_IRQ_MODERATION_* */
+	ETHTOOL_A_PROFILE_IRQ_MODERATION,
+	__ETHTOOL_A_PROFILE_CNT,
+	ETHTOOL_A_PROFILE_MAX = (__ETHTOOL_A_PROFILE_CNT - 1)
+};
+
+/* COALESCE */
+
+enum {
+	ETHTOOL_A_COALESCE_UNSPEC,
+	ETHTOOL_A_COALESCE_HEADER,			/* nest - _A_HEADER_* */
+	ETHTOOL_A_COALESCE_RX_USECS,			/* u32 */
+	ETHTOOL_A_COALESCE_RX_MAX_FRAMES,		/* u32 */
+	ETHTOOL_A_COALESCE_RX_USECS_IRQ,		/* u32 */
+	ETHTOOL_A_COALESCE_RX_MAX_FRAMES_IRQ,		/* u32 */
+	ETHTOOL_A_COALESCE_TX_USECS,			/* u32 */
+	ETHTOOL_A_COALESCE_TX_MAX_FRAMES,		/* u32 */
+	ETHTOOL_A_COALESCE_TX_USECS_IRQ,		/* u32 */
+	ETHTOOL_A_COALESCE_TX_MAX_FRAMES_IRQ,		/* u32 */
+	ETHTOOL_A_COALESCE_STATS_BLOCK_USECS,		/* u32 */
+	ETHTOOL_A_COALESCE_USE_ADAPTIVE_RX,		/* u8 */
+	ETHTOOL_A_COALESCE_USE_ADAPTIVE_TX,		/* u8 */
+	ETHTOOL_A_COALESCE_PKT_RATE_LOW,		/* u32 */
+	ETHTOOL_A_COALESCE_RX_USECS_LOW,		/* u32 */
+	ETHTOOL_A_COALESCE_RX_MAX_FRAMES_LOW,		/* u32 */
+	ETHTOOL_A_COALESCE_TX_USECS_LOW,		/* u32 */
+	ETHTOOL_A_COALESCE_TX_MAX_FRAMES_LOW,		/* u32 */
+	ETHTOOL_A_COALESCE_PKT_RATE_HIGH,		/* u32 */
+	ETHTOOL_A_COALESCE_RX_USECS_HIGH,		/* u32 */
+	ETHTOOL_A_COALESCE_RX_MAX_FRAMES_HIGH,		/* u32 */
+	ETHTOOL_A_COALESCE_TX_USECS_HIGH,		/* u32 */
+	ETHTOOL_A_COALESCE_TX_MAX_FRAMES_HIGH,		/* u32 */
+	ETHTOOL_A_COALESCE_RATE_SAMPLE_INTERVAL,	/* u32 */
+	ETHTOOL_A_COALESCE_USE_CQE_MODE_TX,		/* u8 */
+	ETHTOOL_A_COALESCE_USE_CQE_MODE_RX,		/* u8 */
+	ETHTOOL_A_COALESCE_TX_AGGR_MAX_BYTES,		/* u32 */
+	ETHTOOL_A_COALESCE_TX_AGGR_MAX_FRAMES,		/* u32 */
+	ETHTOOL_A_COALESCE_TX_AGGR_TIME_USECS,		/* u32 */
+	/* nest - _A_PROFILE_IRQ_MODERATION */
+	ETHTOOL_A_COALESCE_RX_PROFILE,
+	/* nest - _A_PROFILE_IRQ_MODERATION */
+	ETHTOOL_A_COALESCE_TX_PROFILE,
+
+	/* add new constants above here */
+	__ETHTOOL_A_COALESCE_CNT,
+	ETHTOOL_A_COALESCE_MAX = (__ETHTOOL_A_COALESCE_CNT - 1)
+};
+
+/* PAUSE */
+
+enum {
+	ETHTOOL_A_PAUSE_STAT_UNSPEC,
+	ETHTOOL_A_PAUSE_STAT_PAD,
+
+	ETHTOOL_A_PAUSE_STAT_TX_FRAMES,
+	ETHTOOL_A_PAUSE_STAT_RX_FRAMES,
+
+	/* add new constants above here
+	 * adjust ETHTOOL_PAUSE_STAT_CNT if adding non-stats!
+	 */
+	__ETHTOOL_A_PAUSE_STAT_CNT,
+	ETHTOOL_A_PAUSE_STAT_MAX = (__ETHTOOL_A_PAUSE_STAT_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_PAUSE_UNSPEC,
+	ETHTOOL_A_PAUSE_HEADER,				/* nest - _A_HEADER_* */
+	ETHTOOL_A_PAUSE_AUTONEG,			/* u8 */
+	ETHTOOL_A_PAUSE_RX,				/* u8 */
+	ETHTOOL_A_PAUSE_TX,				/* u8 */
+	ETHTOOL_A_PAUSE_STATS,				/* nest - _PAUSE_STAT_* */
+	ETHTOOL_A_PAUSE_STATS_SRC,			/* u32 */
+
+	/* add new constants above here */
+	__ETHTOOL_A_PAUSE_CNT,
+	ETHTOOL_A_PAUSE_MAX = (__ETHTOOL_A_PAUSE_CNT - 1)
+};
+
+/* EEE */
+
+enum {
+	ETHTOOL_A_EEE_UNSPEC,
+	ETHTOOL_A_EEE_HEADER,				/* nest - _A_HEADER_* */
+	ETHTOOL_A_EEE_MODES_OURS,			/* bitset */
+	ETHTOOL_A_EEE_MODES_PEER,			/* bitset */
+	ETHTOOL_A_EEE_ACTIVE,				/* u8 */
+	ETHTOOL_A_EEE_ENABLED,				/* u8 */
+	ETHTOOL_A_EEE_TX_LPI_ENABLED,			/* u8 */
+	ETHTOOL_A_EEE_TX_LPI_TIMER,			/* u32 */
+
+	/* add new constants above here */
+	__ETHTOOL_A_EEE_CNT,
+	ETHTOOL_A_EEE_MAX = (__ETHTOOL_A_EEE_CNT - 1)
+};
+
+/* TSINFO */
+
+enum {
+	ETHTOOL_A_TS_STAT_UNSPEC,
+
+	ETHTOOL_A_TS_STAT_TX_PKTS,			/* uint */
+	ETHTOOL_A_TS_STAT_TX_LOST,			/* uint */
+	ETHTOOL_A_TS_STAT_TX_ERR,			/* uint */
+
+	/* add new constants above here */
+	__ETHTOOL_A_TS_STAT_CNT,
+	ETHTOOL_A_TS_STAT_MAX = (__ETHTOOL_A_TS_STAT_CNT - 1)
+
+};
+
+enum {
+	ETHTOOL_A_TSINFO_UNSPEC,
+	ETHTOOL_A_TSINFO_HEADER,			/* nest - _A_HEADER_* */
+	ETHTOOL_A_TSINFO_TIMESTAMPING,			/* bitset */
+	ETHTOOL_A_TSINFO_TX_TYPES,			/* bitset */
+	ETHTOOL_A_TSINFO_RX_FILTERS,			/* bitset */
+	ETHTOOL_A_TSINFO_PHC_INDEX,			/* u32 */
+	ETHTOOL_A_TSINFO_STATS,				/* nest - _A_TSINFO_STAT */
+
+	/* add new constants above here */
+	__ETHTOOL_A_TSINFO_CNT,
+	ETHTOOL_A_TSINFO_MAX = (__ETHTOOL_A_TSINFO_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_CABLE_RESULT_UNSPEC,
+	ETHTOOL_A_CABLE_RESULT_PAIR,		/* u8 ETHTOOL_A_CABLE_PAIR_ */
+	ETHTOOL_A_CABLE_RESULT_CODE,		/* u8 ETHTOOL_A_CABLE_RESULT_CODE_ */
+	ETHTOOL_A_CABLE_RESULT_SRC,		/* u32 ETHTOOL_A_CABLE_INF_SRC_ */
+
+	__ETHTOOL_A_CABLE_RESULT_CNT,
+	ETHTOOL_A_CABLE_RESULT_MAX = (__ETHTOOL_A_CABLE_RESULT_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_CABLE_FAULT_LENGTH_UNSPEC,
+	ETHTOOL_A_CABLE_FAULT_LENGTH_PAIR,	/* u8 ETHTOOL_A_CABLE_PAIR_ */
+	ETHTOOL_A_CABLE_FAULT_LENGTH_CM,	/* u32 */
+	ETHTOOL_A_CABLE_FAULT_LENGTH_SRC,	/* u32 ETHTOOL_A_CABLE_INF_SRC_ */
+
+	__ETHTOOL_A_CABLE_FAULT_LENGTH_CNT,
+	ETHTOOL_A_CABLE_FAULT_LENGTH_MAX = (__ETHTOOL_A_CABLE_FAULT_LENGTH_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_CABLE_NEST_UNSPEC,
+	ETHTOOL_A_CABLE_NEST_RESULT,		/* nest - ETHTOOL_A_CABLE_RESULT_ */
+	ETHTOOL_A_CABLE_NEST_FAULT_LENGTH,	/* nest - ETHTOOL_A_CABLE_FAULT_LENGTH_ */
+	__ETHTOOL_A_CABLE_NEST_CNT,
+	ETHTOOL_A_CABLE_NEST_MAX = (__ETHTOOL_A_CABLE_NEST_CNT - 1)
+};
+
+/* CABLE TEST */
+
+enum {
+	ETHTOOL_A_CABLE_TEST_UNSPEC,
+	ETHTOOL_A_CABLE_TEST_HEADER,		/* nest - _A_HEADER_* */
+
+	/* add new constants above here */
+	__ETHTOOL_A_CABLE_TEST_CNT,
+	ETHTOOL_A_CABLE_TEST_MAX = __ETHTOOL_A_CABLE_TEST_CNT - 1
+};
+
+enum {
+	ETHTOOL_A_CABLE_TEST_NTF_UNSPEC,
+	ETHTOOL_A_CABLE_TEST_NTF_HEADER,	/* nest - ETHTOOL_A_HEADER_* */
+	ETHTOOL_A_CABLE_TEST_NTF_STATUS,	/* u8 - _STARTED/_COMPLETE */
+	ETHTOOL_A_CABLE_TEST_NTF_NEST,		/* nest - of results: */
+
+	__ETHTOOL_A_CABLE_TEST_NTF_CNT,
+	ETHTOOL_A_CABLE_TEST_NTF_MAX = (__ETHTOOL_A_CABLE_TEST_NTF_CNT - 1)
+};
+
+/* CABLE TEST TDR */
+
+enum {
+	ETHTOOL_A_CABLE_TEST_TDR_CFG_UNSPEC,
+	ETHTOOL_A_CABLE_TEST_TDR_CFG_FIRST,		/* u32 */
+	ETHTOOL_A_CABLE_TEST_TDR_CFG_LAST,		/* u32 */
+	ETHTOOL_A_CABLE_TEST_TDR_CFG_STEP,		/* u32 */
+	ETHTOOL_A_CABLE_TEST_TDR_CFG_PAIR,		/* u8 */
+
+	/* add new constants above here */
+	__ETHTOOL_A_CABLE_TEST_TDR_CFG_CNT,
+	ETHTOOL_A_CABLE_TEST_TDR_CFG_MAX = __ETHTOOL_A_CABLE_TEST_TDR_CFG_CNT - 1
+};
+
+enum {
+	ETHTOOL_A_CABLE_TEST_TDR_NTF_UNSPEC,
+	ETHTOOL_A_CABLE_TEST_TDR_NTF_HEADER,	/* nest - ETHTOOL_A_HEADER_* */
+	ETHTOOL_A_CABLE_TEST_TDR_NTF_STATUS,	/* u8 - _STARTED/_COMPLETE */
+	ETHTOOL_A_CABLE_TEST_TDR_NTF_NEST,	/* nest - of results: */
+
+	/* add new constants above here */
+	__ETHTOOL_A_CABLE_TEST_TDR_NTF_CNT,
+	ETHTOOL_A_CABLE_TEST_TDR_NTF_MAX = __ETHTOOL_A_CABLE_TEST_TDR_NTF_CNT - 1
+};
+
+enum {
+	ETHTOOL_A_CABLE_TEST_TDR_UNSPEC,
+	ETHTOOL_A_CABLE_TEST_TDR_HEADER,	/* nest - _A_HEADER_* */
+	ETHTOOL_A_CABLE_TEST_TDR_CFG,		/* nest - *_TDR_CFG_* */
+
+	/* add new constants above here */
+	__ETHTOOL_A_CABLE_TEST_TDR_CNT,
+	ETHTOOL_A_CABLE_TEST_TDR_MAX = __ETHTOOL_A_CABLE_TEST_TDR_CNT - 1
+};
+
+enum {
+	ETHTOOL_A_TUNNEL_UDP_ENTRY_UNSPEC,
+
+	ETHTOOL_A_TUNNEL_UDP_ENTRY_PORT,		/* be16 */
+	ETHTOOL_A_TUNNEL_UDP_ENTRY_TYPE,		/* u32 */
+
+	/* add new constants above here */
+	__ETHTOOL_A_TUNNEL_UDP_ENTRY_CNT,
+	ETHTOOL_A_TUNNEL_UDP_ENTRY_MAX = (__ETHTOOL_A_TUNNEL_UDP_ENTRY_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_TUNNEL_UDP_TABLE_UNSPEC,
+
+	ETHTOOL_A_TUNNEL_UDP_TABLE_SIZE,		/* u32 */
+	ETHTOOL_A_TUNNEL_UDP_TABLE_TYPES,		/* bitset */
+	ETHTOOL_A_TUNNEL_UDP_TABLE_ENTRY,		/* nest - _UDP_ENTRY_* */
+
+	/* add new constants above here */
+	__ETHTOOL_A_TUNNEL_UDP_TABLE_CNT,
+	ETHTOOL_A_TUNNEL_UDP_TABLE_MAX = (__ETHTOOL_A_TUNNEL_UDP_TABLE_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_TUNNEL_UDP_UNSPEC,
+
+	ETHTOOL_A_TUNNEL_UDP_TABLE,			/* nest - _UDP_TABLE_* */
+
+	/* add new constants above here */
+	__ETHTOOL_A_TUNNEL_UDP_CNT,
+	ETHTOOL_A_TUNNEL_UDP_MAX = (__ETHTOOL_A_TUNNEL_UDP_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_TUNNEL_INFO_UNSPEC,
+	ETHTOOL_A_TUNNEL_INFO_HEADER,			/* nest - _A_HEADER_* */
+
+	ETHTOOL_A_TUNNEL_INFO_UDP_PORTS,		/* nest - _UDP_TABLE */
+
+	/* add new constants above here */
+	__ETHTOOL_A_TUNNEL_INFO_CNT,
+	ETHTOOL_A_TUNNEL_INFO_MAX = (__ETHTOOL_A_TUNNEL_INFO_CNT - 1)
+};
+
+/* FEC */
+
+enum {
+	ETHTOOL_A_FEC_STAT_UNSPEC,
+	ETHTOOL_A_FEC_STAT_PAD,
+
+	ETHTOOL_A_FEC_STAT_CORRECTED,			/* array, u64 */
+	ETHTOOL_A_FEC_STAT_UNCORR,			/* array, u64 */
+	ETHTOOL_A_FEC_STAT_CORR_BITS,			/* array, u64 */
+
+	/* add new constants above here */
+	__ETHTOOL_A_FEC_STAT_CNT,
+	ETHTOOL_A_FEC_STAT_MAX = (__ETHTOOL_A_FEC_STAT_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_FEC_UNSPEC,
+	ETHTOOL_A_FEC_HEADER,				/* nest - _A_HEADER_* */
+	ETHTOOL_A_FEC_MODES,				/* bitset */
+	ETHTOOL_A_FEC_AUTO,				/* u8 */
+	ETHTOOL_A_FEC_ACTIVE,				/* u32 */
+	ETHTOOL_A_FEC_STATS,				/* nest - _A_FEC_STAT */
+
+	__ETHTOOL_A_FEC_CNT,
+	ETHTOOL_A_FEC_MAX = (__ETHTOOL_A_FEC_CNT - 1)
+};
+
+/* MODULE EEPROM */
+
+enum {
+	ETHTOOL_A_MODULE_EEPROM_UNSPEC,
+	ETHTOOL_A_MODULE_EEPROM_HEADER,			/* nest - _A_HEADER_* */
+
+	ETHTOOL_A_MODULE_EEPROM_OFFSET,			/* u32 */
+	ETHTOOL_A_MODULE_EEPROM_LENGTH,			/* u32 */
+	ETHTOOL_A_MODULE_EEPROM_PAGE,			/* u8 */
+	ETHTOOL_A_MODULE_EEPROM_BANK,			/* u8 */
+	ETHTOOL_A_MODULE_EEPROM_I2C_ADDRESS,		/* u8 */
+	ETHTOOL_A_MODULE_EEPROM_DATA,			/* binary */
+
+	__ETHTOOL_A_MODULE_EEPROM_CNT,
+	ETHTOOL_A_MODULE_EEPROM_MAX = (__ETHTOOL_A_MODULE_EEPROM_CNT - 1)
+};
+
+
+enum {
+	ETHTOOL_A_STATS_GRP_UNSPEC,
+	ETHTOOL_A_STATS_GRP_PAD,
+
+	ETHTOOL_A_STATS_GRP_ID,			/* u32 */
+	ETHTOOL_A_STATS_GRP_SS_ID,		/* u32 */
+
+	ETHTOOL_A_STATS_GRP_STAT,		/* nest */
+
+	ETHTOOL_A_STATS_GRP_HIST_RX,		/* nest */
+	ETHTOOL_A_STATS_GRP_HIST_TX,		/* nest */
+
+	ETHTOOL_A_STATS_GRP_HIST_BKT_LOW,	/* u32 */
+	ETHTOOL_A_STATS_GRP_HIST_BKT_HI,	/* u32 */
+	ETHTOOL_A_STATS_GRP_HIST_VAL,		/* u64 */
+
+	/* add new constants above here */
+	__ETHTOOL_A_STATS_GRP_CNT,
+	ETHTOOL_A_STATS_GRP_MAX = (__ETHTOOL_A_STATS_GRP_CNT - 1)
+};
+
+/* STATS */
+
+enum {
+	ETHTOOL_A_STATS_UNSPEC,
+	ETHTOOL_A_STATS_PAD,
+	ETHTOOL_A_STATS_HEADER,			/* nest - _A_HEADER_* */
+	ETHTOOL_A_STATS_GROUPS,			/* bitset */
+
+	ETHTOOL_A_STATS_GRP,			/* nest - _A_STATS_GRP_* */
+
+	ETHTOOL_A_STATS_SRC,			/* u32 */
+
+	/* add new constants above here */
+	__ETHTOOL_A_STATS_CNT,
+	ETHTOOL_A_STATS_MAX = (__ETHTOOL_A_STATS_CNT - 1)
+};
+
+/* PHC VCLOCKS */
+
+enum {
+	ETHTOOL_A_PHC_VCLOCKS_UNSPEC,
+	ETHTOOL_A_PHC_VCLOCKS_HEADER,			/* nest - _A_HEADER_* */
+	ETHTOOL_A_PHC_VCLOCKS_NUM,			/* u32 */
+	ETHTOOL_A_PHC_VCLOCKS_INDEX,			/* array, s32 */
+
+	/* add new constants above here */
+	__ETHTOOL_A_PHC_VCLOCKS_CNT,
+	ETHTOOL_A_PHC_VCLOCKS_MAX = (__ETHTOOL_A_PHC_VCLOCKS_CNT - 1)
+};
+
+/* MODULE */
+
+enum {
+	ETHTOOL_A_MODULE_UNSPEC,
+	ETHTOOL_A_MODULE_HEADER,		/* nest - _A_HEADER_* */
+	ETHTOOL_A_MODULE_POWER_MODE_POLICY,	/* u8 */
+	ETHTOOL_A_MODULE_POWER_MODE,		/* u8 */
+
+	/* add new constants above here */
+	__ETHTOOL_A_MODULE_CNT,
+	ETHTOOL_A_MODULE_MAX = (__ETHTOOL_A_MODULE_CNT - 1)
+};
+
+/* Power Sourcing Equipment */
+enum {
+	ETHTOOL_A_C33_PSE_PW_LIMIT_UNSPEC,
+	ETHTOOL_A_C33_PSE_PW_LIMIT_MIN,	/* u32 */
+	ETHTOOL_A_C33_PSE_PW_LIMIT_MAX,	/* u32 */
+};
+
+enum {
+	ETHTOOL_A_PSE_UNSPEC,
+	ETHTOOL_A_PSE_HEADER,			/* nest - _A_HEADER_* */
+	ETHTOOL_A_PODL_PSE_ADMIN_STATE,		/* u32 */
+	ETHTOOL_A_PODL_PSE_ADMIN_CONTROL,	/* u32 */
+	ETHTOOL_A_PODL_PSE_PW_D_STATUS,		/* u32 */
+	ETHTOOL_A_C33_PSE_ADMIN_STATE,		/* u32 */
+	ETHTOOL_A_C33_PSE_ADMIN_CONTROL,	/* u32 */
+	ETHTOOL_A_C33_PSE_PW_D_STATUS,		/* u32 */
+	ETHTOOL_A_C33_PSE_PW_CLASS,		/* u32 */
+	ETHTOOL_A_C33_PSE_ACTUAL_PW,		/* u32 */
+	ETHTOOL_A_C33_PSE_EXT_STATE,		/* u32 */
+	ETHTOOL_A_C33_PSE_EXT_SUBSTATE,		/* u32 */
+	ETHTOOL_A_C33_PSE_AVAIL_PW_LIMIT,	/* u32 */
+	ETHTOOL_A_C33_PSE_PW_LIMIT_RANGES,	/* nest - _C33_PSE_PW_LIMIT_* */
+
+	/* add new constants above here */
+	__ETHTOOL_A_PSE_CNT,
+	ETHTOOL_A_PSE_MAX = (__ETHTOOL_A_PSE_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_RSS_UNSPEC,
+	ETHTOOL_A_RSS_HEADER,
+	ETHTOOL_A_RSS_CONTEXT,		/* u32 */
+	ETHTOOL_A_RSS_HFUNC,		/* u32 */
+	ETHTOOL_A_RSS_INDIR,		/* binary */
+	ETHTOOL_A_RSS_HKEY,		/* binary */
+	ETHTOOL_A_RSS_INPUT_XFRM,	/* u32 */
+	ETHTOOL_A_RSS_START_CONTEXT,	/* u32 */
+
+	__ETHTOOL_A_RSS_CNT,
+	ETHTOOL_A_RSS_MAX = (__ETHTOOL_A_RSS_CNT - 1),
+};
+
+/* PLCA */
+
+enum {
+	ETHTOOL_A_PLCA_UNSPEC,
+	ETHTOOL_A_PLCA_HEADER,			/* nest - _A_HEADER_* */
+	ETHTOOL_A_PLCA_VERSION,			/* u16 */
+	ETHTOOL_A_PLCA_ENABLED,			/* u8  */
+	ETHTOOL_A_PLCA_STATUS,			/* u8  */
+	ETHTOOL_A_PLCA_NODE_CNT,		/* u32 */
+	ETHTOOL_A_PLCA_NODE_ID,			/* u32 */
+	ETHTOOL_A_PLCA_TO_TMR,			/* u32 */
+	ETHTOOL_A_PLCA_BURST_CNT,		/* u32 */
+	ETHTOOL_A_PLCA_BURST_TMR,		/* u32 */
+
+	/* add new constants above here */
+	__ETHTOOL_A_PLCA_CNT,
+	ETHTOOL_A_PLCA_MAX = (__ETHTOOL_A_PLCA_CNT - 1)
+};
+
+/* MODULE_FW_FLASH */
+
+enum {
+	ETHTOOL_A_MODULE_FW_FLASH_UNSPEC,
+	ETHTOOL_A_MODULE_FW_FLASH_HEADER,		/* nest - _A_HEADER_* */
+	ETHTOOL_A_MODULE_FW_FLASH_FILE_NAME,		/* string */
+	ETHTOOL_A_MODULE_FW_FLASH_PASSWORD,		/* u32 */
+	ETHTOOL_A_MODULE_FW_FLASH_STATUS,		/* u32 */
+	ETHTOOL_A_MODULE_FW_FLASH_STATUS_MSG,		/* string */
+	ETHTOOL_A_MODULE_FW_FLASH_DONE,			/* uint */
+	ETHTOOL_A_MODULE_FW_FLASH_TOTAL,		/* uint */
+
+	/* add new constants above here */
+	__ETHTOOL_A_MODULE_FW_FLASH_CNT,
+	ETHTOOL_A_MODULE_FW_FLASH_MAX = (__ETHTOOL_A_MODULE_FW_FLASH_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_PHY_UNSPEC,
+	ETHTOOL_A_PHY_HEADER,			/* nest - _A_HEADER_* */
+	ETHTOOL_A_PHY_INDEX,			/* u32 */
+	ETHTOOL_A_PHY_DRVNAME,			/* string */
+	ETHTOOL_A_PHY_NAME,			/* string */
+	ETHTOOL_A_PHY_UPSTREAM_TYPE,		/* u32 */
+	ETHTOOL_A_PHY_UPSTREAM_INDEX,		/* u32 */
+	ETHTOOL_A_PHY_UPSTREAM_SFP_NAME,	/* string */
+	ETHTOOL_A_PHY_DOWNSTREAM_SFP_NAME,	/* string */
+
+	/* add new constants above here */
+	__ETHTOOL_A_PHY_CNT,
+	ETHTOOL_A_PHY_MAX = (__ETHTOOL_A_PHY_CNT - 1)
+};
+
+/* message types - userspace to kernel */
+enum {
+	ETHTOOL_MSG_USER_NONE,
+	ETHTOOL_MSG_STRSET_GET,
+	ETHTOOL_MSG_LINKINFO_GET,
+	ETHTOOL_MSG_LINKINFO_SET,
+	ETHTOOL_MSG_LINKMODES_GET,
+	ETHTOOL_MSG_LINKMODES_SET,
+	ETHTOOL_MSG_LINKSTATE_GET,
+	ETHTOOL_MSG_DEBUG_GET,
+	ETHTOOL_MSG_DEBUG_SET,
+	ETHTOOL_MSG_WOL_GET,
+	ETHTOOL_MSG_WOL_SET,
+	ETHTOOL_MSG_FEATURES_GET,
+	ETHTOOL_MSG_FEATURES_SET,
+	ETHTOOL_MSG_PRIVFLAGS_GET,
+	ETHTOOL_MSG_PRIVFLAGS_SET,
+	ETHTOOL_MSG_RINGS_GET,
+	ETHTOOL_MSG_RINGS_SET,
+	ETHTOOL_MSG_CHANNELS_GET,
+	ETHTOOL_MSG_CHANNELS_SET,
+	ETHTOOL_MSG_COALESCE_GET,
+	ETHTOOL_MSG_COALESCE_SET,
+	ETHTOOL_MSG_PAUSE_GET,
+	ETHTOOL_MSG_PAUSE_SET,
+	ETHTOOL_MSG_EEE_GET,
+	ETHTOOL_MSG_EEE_SET,
+	ETHTOOL_MSG_TSINFO_GET,
+	ETHTOOL_MSG_CABLE_TEST_ACT,
+	ETHTOOL_MSG_CABLE_TEST_TDR_ACT,
+	ETHTOOL_MSG_TUNNEL_INFO_GET,
+	ETHTOOL_MSG_FEC_GET,
+	ETHTOOL_MSG_FEC_SET,
+	ETHTOOL_MSG_MODULE_EEPROM_GET,
+	ETHTOOL_MSG_STATS_GET,
+	ETHTOOL_MSG_PHC_VCLOCKS_GET,
+	ETHTOOL_MSG_MODULE_GET,
+	ETHTOOL_MSG_MODULE_SET,
+	ETHTOOL_MSG_PSE_GET,
+	ETHTOOL_MSG_PSE_SET,
+	ETHTOOL_MSG_RSS_GET,
+	ETHTOOL_MSG_PLCA_GET_CFG,
+	ETHTOOL_MSG_PLCA_SET_CFG,
+	ETHTOOL_MSG_PLCA_GET_STATUS,
+	ETHTOOL_MSG_MM_GET,
+	ETHTOOL_MSG_MM_SET,
+	ETHTOOL_MSG_MODULE_FW_FLASH_ACT,
+	ETHTOOL_MSG_PHY_GET,
+
+	/* add new constants above here */
+	__ETHTOOL_MSG_USER_CNT,
+	ETHTOOL_MSG_USER_MAX = __ETHTOOL_MSG_USER_CNT - 1
+};
+
+/* message types - kernel to userspace */
+enum {
+	ETHTOOL_MSG_KERNEL_NONE,
+	ETHTOOL_MSG_STRSET_GET_REPLY,
+	ETHTOOL_MSG_LINKINFO_GET_REPLY,
+	ETHTOOL_MSG_LINKINFO_NTF,
+	ETHTOOL_MSG_LINKMODES_GET_REPLY,
+	ETHTOOL_MSG_LINKMODES_NTF,
+	ETHTOOL_MSG_LINKSTATE_GET_REPLY,
+	ETHTOOL_MSG_DEBUG_GET_REPLY,
+	ETHTOOL_MSG_DEBUG_NTF,
+	ETHTOOL_MSG_WOL_GET_REPLY,
+	ETHTOOL_MSG_WOL_NTF,
+	ETHTOOL_MSG_FEATURES_GET_REPLY,
+	ETHTOOL_MSG_FEATURES_SET_REPLY,
+	ETHTOOL_MSG_FEATURES_NTF,
+	ETHTOOL_MSG_PRIVFLAGS_GET_REPLY,
+	ETHTOOL_MSG_PRIVFLAGS_NTF,
+	ETHTOOL_MSG_RINGS_GET_REPLY,
+	ETHTOOL_MSG_RINGS_NTF,
+	ETHTOOL_MSG_CHANNELS_GET_REPLY,
+	ETHTOOL_MSG_CHANNELS_NTF,
+	ETHTOOL_MSG_COALESCE_GET_REPLY,
+	ETHTOOL_MSG_COALESCE_NTF,
+	ETHTOOL_MSG_PAUSE_GET_REPLY,
+	ETHTOOL_MSG_PAUSE_NTF,
+	ETHTOOL_MSG_EEE_GET_REPLY,
+	ETHTOOL_MSG_EEE_NTF,
+	ETHTOOL_MSG_TSINFO_GET_REPLY,
+	ETHTOOL_MSG_CABLE_TEST_NTF,
+	ETHTOOL_MSG_CABLE_TEST_TDR_NTF,
+	ETHTOOL_MSG_TUNNEL_INFO_GET_REPLY,
+	ETHTOOL_MSG_FEC_GET_REPLY,
+	ETHTOOL_MSG_FEC_NTF,
+	ETHTOOL_MSG_MODULE_EEPROM_GET_REPLY,
+	ETHTOOL_MSG_STATS_GET_REPLY,
+	ETHTOOL_MSG_PHC_VCLOCKS_GET_REPLY,
+	ETHTOOL_MSG_MODULE_GET_REPLY,
+	ETHTOOL_MSG_MODULE_NTF,
+	ETHTOOL_MSG_PSE_GET_REPLY,
+	ETHTOOL_MSG_RSS_GET_REPLY,
+	ETHTOOL_MSG_PLCA_GET_CFG_REPLY,
+	ETHTOOL_MSG_PLCA_GET_STATUS_REPLY,
+	ETHTOOL_MSG_PLCA_NTF,
+	ETHTOOL_MSG_MM_GET_REPLY,
+	ETHTOOL_MSG_MM_NTF,
+	ETHTOOL_MSG_MODULE_FW_FLASH_NTF,
+	ETHTOOL_MSG_PHY_GET_REPLY,
+	ETHTOOL_MSG_PHY_NTF,
+
+	/* add new constants above here */
+	__ETHTOOL_MSG_KERNEL_CNT,
+	ETHTOOL_MSG_KERNEL_MAX = __ETHTOOL_MSG_KERNEL_CNT - 1
+};
+
+#endif /* _UAPI_LINUX_ETHTOOL_NETLINK_GENERATED_H */
-- 
2.47.0


