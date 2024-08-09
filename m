Return-Path: <netdev+bounces-117073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CD794C8D1
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 05:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E3531F21C99
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 03:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B34381D9;
	Fri,  9 Aug 2024 03:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gl7CnKEu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E76D381BA
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 03:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723173522; cv=none; b=lp8ZMxoxIRqTv9auboX1RFdsOXGnV4qZCqNXrK9nzWq8Ah9W1IDVTBMsHAu2MQqjh06cpvxAOV4ypoIddKs2RMl7UN72xjXDOWGCZvZiGbzsL/HReg311nIs14qDTooWbyWMx5bFW0gG1ul1AOPJ8uuu4HNQS0bnlTSr06JsIHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723173522; c=relaxed/simple;
	bh=pSOWwb/NcdhwdHCZvWze8Cm/jHPpakBJe+i9qVQm+qw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UoBT0ykOT3PoQIvXRqRpaJxCEHacIMpKCI18p+SgMjscQ5pLTFmDjEWMQnT/g93nx7oNuxXfnbw+Pl1ArxSznulQMPDuutyNYbFUttG3+n/FHac9aAkNS3IB37OuPoVj/+f9mman85mQPZtsTzg4LdlYUHqrrqJKf9yvjMnhuCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gl7CnKEu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 473D8C4AF0D;
	Fri,  9 Aug 2024 03:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723173521;
	bh=pSOWwb/NcdhwdHCZvWze8Cm/jHPpakBJe+i9qVQm+qw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gl7CnKEu0npktITDblu/UaD2Jy0R1X14keUssz+g3S2gQMvnWdqKeOxfdXBwekUjh
	 rXNnwabeiEnzqMhkvso1e2BQvKi8bTUxsGoxjPg3f1Ee4VfXJNvKztfaCz74iuG8C0
	 ZTLjWa+692Azg6DzJcYX7djitqfGqc/CmiLCq8DsLz2T3Yi80sD8GWJWJAXOOaP9Yk
	 l4Tayc5hxxic6LABF+IF8Pf2xBMoJvdt5QV/fjxaKbc7p/BGxrGza1+LxQfpilSCGy
	 Tim6RjvaLvKP8R2usw6JSGubZSrBtoPzM5t8PZAmuteH5QF+TS07Nm0Xot7xXv2UJg
	 JWmIT43NLkZxA==
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
Subject: [PATCH net-next v4 11/12] netlink: specs: decode indirection table as u32 array
Date: Thu,  8 Aug 2024 20:18:26 -0700
Message-ID: <20240809031827.2373341-12-kuba@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240809031827.2373341-1-kuba@kernel.org>
References: <20240809031827.2373341-1-kuba@kernel.org>
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
2.46.0


