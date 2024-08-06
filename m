Return-Path: <netdev+bounces-116229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2835B94985F
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 21:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5AA91F22887
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 19:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE35615B137;
	Tue,  6 Aug 2024 19:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TBzOYIb4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA00A15B12B
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 19:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722972826; cv=none; b=XTV9OiV1ZdnhBMN0gAUVzfbAO3O2Y97EKdJ04TrYgMvyE692bZgWZ7WIGBxVKAMSjItsvup7LISm72ezmfGom7bzANkqY0T08gzsOcworH/RxgjjRfM2p7B7eXjLqXvlDpATUwwlM3mJK/8K3AoKcETDUCkN7JwYDumbbHeMBmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722972826; c=relaxed/simple;
	bh=dI7gId/L8B6nMeZZXK6onHZD2A995y4+iTbvKlETJAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q9SOhK4x0wdrc+s66djjiOSR6vkew4WS9RGbkVH/OJcbAGAv2fMXJD4h5dGUHF0KWdex4rNZKqxvmaQ6AtVjiOyz9qJGdeiMh5NHaGlDnJMwBCdfIInhM3/MZDn/zrKoj2sasFRxS47y0PwAZGJx+7AHUMhUNgaN/2nd9EzZJKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TBzOYIb4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94925C4AF10;
	Tue,  6 Aug 2024 19:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722972826;
	bh=dI7gId/L8B6nMeZZXK6onHZD2A995y4+iTbvKlETJAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TBzOYIb4FPzcmKhm/wM1Ht1gO6lltrmH8Ltj4Jq4HPXNel9RMxEEUh3k3QXVOkQCR
	 xEXDQCLUMHti601Lwy/icvafoa1hyvPT6hPsB/mNOogUeznTLdeXyhjQOWt48dXuJd
	 W8stZpJM/bWKOg2ssfxfiaPaiA0vqZiX9svHV6UzxF4lpx3S8xCgKyKKa3rIM0Ar1u
	 BSWwqnBqZ0c/Bw2lZ895Q9FceBUsP4dGK6il/HpX6089a6fUTnX4hhgsqQek03gYHD
	 A2hzqNHqyVZI4zRtpyJDY6reu6YVJaCkRnXTJ9MBZVcYecFWv/UiS0NNB5soOKXVzg
	 ubdQ/bOuXxaCg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	michael.chan@broadcom.com,
	shuah@kernel.org,
	ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com,
	ahmed.zaki@intel.com,
	andrew@lunn.ch,
	willemb@google.com,
	pavan.chebbi@broadcom.com,
	petrm@nvidia.com,
	gal@nvidia.com,
	jdamato@fastly.com,
	donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 11/12] netlink: specs: decode indirection table as u32 array
Date: Tue,  6 Aug 2024 12:33:16 -0700
Message-ID: <20240806193317.1491822-12-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240806193317.1491822-1-kuba@kernel.org>
References: <20240806193317.1491822-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Indirection table is dumped as a raw u32 array, decode it.
It's tempting to decode hash key, too, but it is an actual
bitstream, so leave it be for now.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/ethtool.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 4c2334c213b0..1bbeaba5c644 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -1022,6 +1022,7 @@ doc: Partial family for Ethtool Netlink.
       -
         name: indir
         type: binary
+        sub-type: u32
       -
         name: hkey
         type: binary
-- 
2.45.2


