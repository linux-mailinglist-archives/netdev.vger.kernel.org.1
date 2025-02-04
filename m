Return-Path: <netdev+bounces-162354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F31B0A269FD
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 03:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5A9D7A2D0D
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 02:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45435139CFF;
	Tue,  4 Feb 2025 02:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WewVQh0k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C6C25A655;
	Tue,  4 Feb 2025 02:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738635058; cv=none; b=V7v4X7098McPmdMMhIN19R9iFi2cvaFgkkcNDtt4l2eOx1QhADxIKAVD5QuYAbbQRZ5y4FdYxJMYc0jh/3mD4HFedwSQB73LBD+wukDjSoCmv4FHL4lU1OhTv60mI6d6MG/ROi77JXGxzbuuch73oW4tS3/z3VeK889UIqv87Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738635058; c=relaxed/simple;
	bh=VFV1QQ4KPl9eM8E5rpXdw31ZGHL5nyodW9NTHy1BxmE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oaizuQCnW2VwndJh70A4h7kg7WYWk1MFEgF3GGMH4rproEHEPRjuLIRxto8luhN+tEKHQfOjjhx8vwSK+4eGj26mfx9T1fXgiucUZS+y1nL/12o6rUz8SFbSHpExeINySmYtWfXFNrjO6msvvmS0ztdJwGnyp1tR0sh4B8Hcsm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WewVQh0k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0202C4CEE0;
	Tue,  4 Feb 2025 02:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738635057;
	bh=VFV1QQ4KPl9eM8E5rpXdw31ZGHL5nyodW9NTHy1BxmE=;
	h=Date:From:To:Cc:Subject:From;
	b=WewVQh0k/PbrjnRCy9yvluBSyzvZRVIz1Vwa6P0++DTlxSWNXocMDu3vt2ZCo9EHz
	 xI1MKwMvpX8RkxVq7oM1VVO09H7xAQcRbkcnOjJJz31z+guDVmo9msTQ/x1fgEufYj
	 Y6lVpi7IUK9sohXNEJ3LK1I0RUUkS2VqSOlr+OitDgy8tLnVatwip0yn6am3sXkudf
	 6o7v8pR/rvy2m5Bq6uyunRQ2/tj4E/3+nF1ch3rwrjS487pS+rmIyTwzJLMt/neXaX
	 It6ZinkrDu/1u7adXMpMLlDRXrkCH+I8rNkJ3GsJ8T2Voek5mbrsX+ID8nxFNwwvT4
	 ImpptK0l4mxNw==
Date: Tue, 4 Feb 2025 12:40:49 +1030
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Igor Russkikh <irusskikh@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2][next] net: atlantic: Avoid -Wflex-array-member-not-at-end
 warnings
Message-ID: <Z6F3KZVfnAZ2FoJm@kspp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

Remove unused flexible-array member `buf` and, with this, fix the following
warnings:
drivers/net/ethernet/aquantia/atlantic/aq_hw.h:197:36: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/ethernet/aquantia/atlantic/hw_atl/../aq_hw.h:197:36: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Suggested-by: Igor Russkikh <irusskikh@marvell.com>
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v2:
 - Remove unused flex-array member. (Igor)

v1:
 - Link: https://lore.kernel.org/linux-hardening/ZrDwoVKH8d6TdVxn@cute/

 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.h b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.h
index f5901f8e3907..f6b990b7f5b4 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.h
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.h
@@ -226,7 +226,6 @@ struct __packed offload_info {
 	struct offload_port_info ports;
 	struct offload_ka_info kas;
 	struct offload_rr_info rrs;
-	u8 buf[];
 };
 
 struct __packed hw_atl_utils_fw_rpc {
-- 
2.43.0


