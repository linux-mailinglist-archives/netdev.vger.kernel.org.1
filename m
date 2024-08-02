Return-Path: <netdev+bounces-115164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B367945539
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 02:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C2B71C20841
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 00:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F5E18AED;
	Fri,  2 Aug 2024 00:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jj3IOX9c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0196E1BF2B
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 00:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722557895; cv=none; b=PrfTOg8pB6PgmwQgqenn48wNsRvsnpoYuHmlAhJRToPjVENmrAC2/VK3O8HUvPgiQ3daz0eCpe2i2mp9++Ugi4vXuH28NLfZEo9uwrTpeoXMN5jViCz344xv0J8T4taJomG5gCM9/y5ldLxcPshTAK0fNuLKfKZS5gXds4as06s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722557895; c=relaxed/simple;
	bh=dI7gId/L8B6nMeZZXK6onHZD2A995y4+iTbvKlETJAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PR4Rsh/rJv20ZI94B+xiTouOSSRT2tW2a2IwHytNxMWzucT2cXxDv3aCppWVXCrYZIRbPN9ATj23coB+Hjs/Hg5SkWANALp5JSxzasPgyADLa8vH0JNCTyYmlVA7Oqn9tLOdwKalWbjfjFcvlcLxXeUi5tnXExFfKVU9/Wp/snI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jj3IOX9c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C77AC4AF11;
	Fri,  2 Aug 2024 00:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722557894;
	bh=dI7gId/L8B6nMeZZXK6onHZD2A995y4+iTbvKlETJAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jj3IOX9c9Hya+1IkqM2GD1XYlWNV1eBnis0lyhs7tauogsfAMoOFI1+TiaodXUWhG
	 Io3bM8sbt46j5WEsEEGtTYa+fUDQYxOLQ7HthHLmuN7nNx9j7l5l4TC0yntva2j0Wa
	 6xxyib2VVT924eS7pAuOYE2Ard0Xex+fXS5e2A7CexpNzjpDSWQYBRgzSkQyI4qwPl
	 n/OEl6oGSwJw2URto2pK12MRfmKvz08Ee4HmjCawx/aTaPRwj7RgfEhA1FvkNuN7id
	 Vi+3B9RNa7frnGwGuvOlyJB1q71S3H+ki7JVNM+aAzGNULdiqeIoPQEz/qWIdut5UL
	 L/xOXdX9f7CJw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	dxu@dxuuu.xyz,
	ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com,
	donald.hunter@gmail.com,
	gal.pressman@linux.dev,
	tariqt@nvidia.com,
	willemdebruijn.kernel@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 11/12] netlink: specs: decode indirection table as u32 array
Date: Thu,  1 Aug 2024 17:18:00 -0700
Message-ID: <20240802001801.565176-12-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240802001801.565176-1-kuba@kernel.org>
References: <20240802001801.565176-1-kuba@kernel.org>
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


