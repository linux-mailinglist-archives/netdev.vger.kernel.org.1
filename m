Return-Path: <netdev+bounces-117379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B9194DAF8
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 07:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 839F41C20E71
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 05:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909F413D624;
	Sat, 10 Aug 2024 05:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKexde97"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D92813D619
	for <netdev@vger.kernel.org>; Sat, 10 Aug 2024 05:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723268493; cv=none; b=gKfEnK5N934c8iZiKDzhXQ9RvVMNBSP/ZN/QfpGFp9vB4hYR1XDYQp4vsulPojDiiqXVsAuakiHoNtHM+0t9OX9aGjldnBD7IyCOsyyFP6SsSDErSWzyP9mkV5gliQCJUWYnScqAgP6Yq1C4ICw+rSVFtxj8psUsaZhiYXUsXRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723268493; c=relaxed/simple;
	bh=pSOWwb/NcdhwdHCZvWze8Cm/jHPpakBJe+i9qVQm+qw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NKYvAal3XW/DRbGPMwsS7QEJgWv3Egdytnj5AAsQz7buXvvnO2njocW6IqczAC+v6QYI3ksSpHOWzwrbQGhCmQtM4hKVIc0CB4Z7tVTQ03tkXrpjaoF/24vIs+VDnDy9clWZYtdm9X8yU2LVg4Xqm0RVXehESqn9jU2BZ5A/xMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fKexde97; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C4B6C4AF13;
	Sat, 10 Aug 2024 05:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723268492;
	bh=pSOWwb/NcdhwdHCZvWze8Cm/jHPpakBJe+i9qVQm+qw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fKexde97Ia3eXlYv78UJmIdvMgeC3jsbpgbOQJFq17ZJyDVsPz1upvsUn2A8AiABQ
	 p85i07aIu/v3GIs6t4uxPn1NY+B4ureJItr8cVhkpbahl2msZcZKrNPrWBlr2707vM
	 DvXc+i+Tt1cgnk7TuWtYvHSRwxD1g3NeND0Zu/wOORwEeOIQwk952v5GmtIiCNbME/
	 aggFykP32sz1pzTV/dz1vg6WPjpNfMg8QnmM9M0avJVyaW7nzVhljIf1eWK9SxKqzB
	 4k+KSU+N8gEV2S/NgJX1Au42963Y/IFtcXMVj4n+bvrwvMY+geneGHcBWnjVHBr0Px
	 NoBXzQcVNrErA==
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
Subject: [PATCH net-next v5 11/12] netlink: specs: decode indirection table as u32 array
Date: Fri,  9 Aug 2024 22:37:27 -0700
Message-ID: <20240810053728.2757709-12-kuba@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240810053728.2757709-1-kuba@kernel.org>
References: <20240810053728.2757709-1-kuba@kernel.org>
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


