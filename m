Return-Path: <netdev+bounces-110950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EF992F1B3
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 00:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAC361C22237
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 22:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D9C19F485;
	Thu, 11 Jul 2024 22:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uzhMC9Ja"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E68F16D4E8
	for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 22:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720735641; cv=none; b=FnTH5+PSz32rW333NwncPWMpCtA5YWIis6ewHnfaEqa1NwW0DIVJiEysQmsshTBNBGz2++3WpkxbIOOs72LfekLPL8DUbHfQ3TYXSUonx5FCrGGcWnJz80sDj4Ql+snOp4ILy2i3JVjneZkV0sPbd5TUaSDNSxrdne422tky+mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720735641; c=relaxed/simple;
	bh=rFN3QtDXK3m8eiud+YpEXtD0npPICxW3GRAEhZhDVzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SLjBmRtb+F8quDu+G46AWmMkevKnajdSNRS7AltI5cIhcXRCSPMpXZgyf9Pp3o02mvSpXderGs04KtCbEema/AJlM7W44pouCHAoHSUMj7ZgHpFba035/fzuHw62gIdNYgBVLEbIEKark1kB+ufD395PobmA9m0RREbJ5g+Lrj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uzhMC9Ja; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63EABC32782;
	Thu, 11 Jul 2024 22:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720735640;
	bh=rFN3QtDXK3m8eiud+YpEXtD0npPICxW3GRAEhZhDVzY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uzhMC9JaOiewIIqCCWDiDPVNr9AcpiBm5rIZlloS5RukkJiFi1cgtlCGrxETd7Kw6
	 pNApFoQLwyrW75DkCJHkqB40/AG99hxAWGoHAJlDJFjnrloJTaiUjV81ccqpKx7TRJ
	 +xOeLt6rFLbRCcgJOIQwtjnB2sqGM93dqc5hY7NAkn2bECRhlbGecG4Bn1yLzNnb5B
	 yhh7nVxDTQSrEnhxYHr/QiFkCPhtkLE9cGUu5OUYUVBw83qYLmrT8F1rq7XnKGQ/Gu
	 jTnQnWy4ROZeE0xZ+6fXuiXN3iMtAxogdL65LdYAPYa7Z6hXnLJkooLyzQm2S/cY6t
	 ZV7sfbq0V7msQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	ecree.xilinx@gmail.com,
	michael.chan@broadcom.com,
	horms@kernel.org,
	pavan.chebbi@broadcom.com,
	przemyslaw.kitszel@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 01/11] net: ethtool: let drivers remove lost RSS contexts
Date: Thu, 11 Jul 2024 15:07:03 -0700
Message-ID: <20240711220713.283778-2-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240711220713.283778-1-kuba@kernel.org>
References: <20240711220713.283778-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RSS contexts may get lost from a device, in various extreme circumstances.
Specifically if the firmware leaks resources and resets, or crashes and
either recovers in partially working state or the crash causes a
different FW version to run - creating the context again may fail.

Drivers should do their absolute best to prevent this from happening.
When it does, however, telling user that a context exists, when it can't
possibly be used any more is counter productive. Add a helper for
drivers to discard contexts. Print an error, in the future netlink
notification will also be sent.

More robust approaches were proposed, like keeping the contexts
but marking them as "dead" (but possibly resurrected by next reset).
That may be better but it's unclear at this stage whether the
effort is worth the benefits.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
--
I'm keeping this patch as is, since this is the simplest solution,
and nobody has strong opinions.

v2:
 - move to common.c to avoid build problems when ethtool-nl isn't enabled
 - add a note about the counter proposal in the commit message
---
 include/linux/ethtool.h |  2 ++
 net/ethtool/common.c    | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index e213b5508da6..89da0254ccd4 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -210,6 +210,8 @@ static inline size_t ethtool_rxfh_context_size(u32 indir_size, u32 key_size,
 	return struct_size_t(struct ethtool_rxfh_context, data, flex_len);
 }
 
+void ethtool_rxfh_context_lost(struct net_device *dev, u32 context_id);
+
 /* declare a link mode bitmap */
 #define __ETHTOOL_DECLARE_LINK_MODE_MASK(name)		\
 	DECLARE_BITMAP(name, __ETHTOOL_LINK_MODE_MASK_NBITS)
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 7bda9600efcf..67d06cd002a5 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -741,3 +741,17 @@ ethtool_forced_speed_maps_init(struct ethtool_forced_speed_map *maps, u32 size)
 	}
 }
 EXPORT_SYMBOL_GPL(ethtool_forced_speed_maps_init);
+
+void ethtool_rxfh_context_lost(struct net_device *dev, u32 context_id)
+{
+	struct ethtool_rxfh_context *ctx;
+
+	WARN_ONCE(!rtnl_is_locked() &&
+		  !lockdep_is_held_type(&dev->ethtool->rss_lock, -1),
+		  "RSS context lock assertion failed\n");
+
+	netdev_err(dev, "device error, RSS context %d lost\n", context_id);
+	ctx = xa_erase(&dev->ethtool->rss_ctx, context_id);
+	kfree(ctx);
+}
+EXPORT_SYMBOL(ethtool_rxfh_context_lost);
-- 
2.45.2


