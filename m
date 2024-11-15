Return-Path: <netdev+bounces-145406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BCD9CF655
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 21:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22B14B366CE
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 20:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D7F1E32DB;
	Fri, 15 Nov 2024 20:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IOsDsKku"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B181E2847;
	Fri, 15 Nov 2024 20:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731703392; cv=none; b=ZhNPVr07S3L20vtHjIpr0ALkg5IWqHNfNAhq6oQjTw97t2XVC6/E/5SScBEQxS6Wcd2PlMu70vAREqMVRFUW0I9tWl/91drNtBRPdxL6lNm8WUOy6wBSMfDYuYSNKWkvPDLIIEQgXg8n9AGVDB0JUrx4zJU0lx1+mHIYgBiyRQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731703392; c=relaxed/simple;
	bh=L/nAji/np5Nj6xf7xzKtv5APFH3Nk1mvKh//Dch+LcI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=doGlFqBsL2ztZGjUekXpaslZZ6A9gowccu63edOO0zW8b5ZidHSljpTm7J0sgoWytRgFg4qS+8fHYczS1bfr+mdmSWx7Kr0mgoa5WJMIoM/49vs3/ch4VKenKwbQqnqaglGoBAzhc9jfdaTYcpvhdu8Ron/BBzeQOaQxJOo7Ruc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IOsDsKku; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE64EC4AF0C;
	Fri, 15 Nov 2024 20:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731703391;
	bh=L/nAji/np5Nj6xf7xzKtv5APFH3Nk1mvKh//Dch+LcI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IOsDsKkuZ+ZyjsSoSsCn+85NzTnmSMnmohrt00YCpzx4TRL4vuazPXQDpKah0KOXb
	 /fqEAcU+0Ce7z82qnrykHwLvwlDmDtqRgBopZPK98Krx672Zwi8sZXr0UseASrIraB
	 o32U+ipKCAmIsM9qe/so6Oo117VqbhuHmyhhNj50uCsOtN0Mtg+ZW7XCA8khzuCBS5
	 pf7prAFf7gL5Df4Qt7N9g9ZVNDswpvDc4JZybPAPNauJGCCFj/1W0FnT6ITU9aO3II
	 3SmWI8+ucoQ0yjVogdneZNdWNWwAUizlWLBd/eI2guOj4wAMt3keNF36FBwYhdWlhI
	 MYLhiU9ktzOaQ==
From: Kees Cook <kees@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>,
	"Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Christian Benvenuti <benve@cisco.com>,
	Satish Kharat <satishkh@cisco.com>,
	Manish Chopra <manishc@marvell.com>,
	Simon Horman <horms@kernel.org>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Takeru Hayasaka <hayatake396@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 3/3] UAPI: ethtool: Avoid flex-array in struct ethtool_link_settings
Date: Fri, 15 Nov 2024 12:43:05 -0800
Message-Id: <20241115204308.3821419-3-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241115204115.work.686-kees@kernel.org>
References: <20241115204115.work.686-kees@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2442; i=kees@kernel.org; h=from:subject; bh=L/nAji/np5Nj6xf7xzKtv5APFH3Nk1mvKh//Dch+LcI=; b=owGbwMvMwCVmps19z/KJym7G02pJDOnmmyLLWeIEXxh2FPs/3pJ5xlSy/cH/+nD+vuwjP2acn vV9zwzTjlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgIl8OMzwv0LhZLfx5y1aZana Uw7Xrnn0qNHML3P/3bo1+RaHrqxbJsPIsLFC5cDyritFW38Hc1SeuVE77Xr1IY2NcaJ+W3kXT/5 7hQcA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

struct ethtool_link_settings tends to be used as a header for other
structures that have trailing bytes[1], but has a trailing flexible array
itself. Using this overlapped with other structures leads to ambiguous
object sizing in the compiler, so we want to avoid such situations (which
have caused real bugs in the past). Detecting this can be done with
-Wflex-array-member-not-at-end, which will need to be enabled globally.

Using a tagged struct_group() to create a new ethtool_link_settings_hdr
structure isn't possible as it seems we cannot use the tagged variant of
struct_group() due to syntax issues from C++'s perspective (even within
"extern C")[2]. Instead, we can just leave the offending member defined
in UAPI and remove it from the kernel's view of the structure, as Linux
doesn't actually use this member at all. There is also no change in
size since it was already a flexible array that didn't contribute to
size returned by any use of sizeof().

Reported-by: Jakub Kicinski <kuba@kernel.org>
Closes: https://lore.kernel.org/lkml/20241109100213.262a2fa0@kernel.org/ [2]
Link: https://lore.kernel.org/lkml/0bc2809fe2a6c11dd4c8a9a10d9bd65cccdb559b.1730238285.git.gustavoars@kernel.org/ [1]
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>
---
 include/uapi/linux/ethtool.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index c405ed63acfa..7e1b3820f91f 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -2526,12 +2526,19 @@ struct ethtool_link_settings {
 	__u8	master_slave_state;
 	__u8	rate_matching;
 	__u32	reserved[7];
+#ifndef __KERNEL__
+	/* Linux builds with -Wflex-array-member-not-at-end but does
+	 * not use the "link_mode_masks" member. Leave it defined for
+	 * userspace for now, and when userspace wants to start using
+	 * -Wfamnae, we'll need a new solution.
+	 */
 	__u32	link_mode_masks[];
 	/* layout of link_mode_masks fields:
 	 * __u32 map_supported[link_mode_masks_nwords];
 	 * __u32 map_advertising[link_mode_masks_nwords];
 	 * __u32 map_lp_advertising[link_mode_masks_nwords];
 	 */
+#endif
 };
 
 /**
-- 
2.34.1


