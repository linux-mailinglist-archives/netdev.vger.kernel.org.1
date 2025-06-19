Return-Path: <netdev+bounces-199602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2DAAE0EFB
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 23:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1CDB3A36A0
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 21:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839DB2459F9;
	Thu, 19 Jun 2025 21:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earthlink.net header.i=@earthlink.net header.b="EyTQbxuQ"
X-Original-To: netdev@vger.kernel.org
Received: from mta-201a.earthlink-vadesecure.net (mta-201b.earthlink-vadesecure.net [51.81.229.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995AB1E7C1C;
	Thu, 19 Jun 2025 21:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.81.229.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750368112; cv=none; b=BU5Krkr+zBZuXfpk5aFvJmSN1j6KB6bQNpkanU+2j0Sw2oMQIHLlUmY0OHT0kX+M9/40LigO+ZRJuGsuILrldM+aGOEm+kc+shxTrA//Zop9tRoD1+bJoJhtl0LPS6Q6X76vzGlbiKSeXJn+7IpVjDP9M1M/oosQjPzRkh19VHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750368112; c=relaxed/simple;
	bh=OCouZ563iybBnAa+5WrnH7Rsa1cCJeJzF5RAPNWT7ns=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GOJHvWH89d9hChP7P2nbsSlLocHUxb1sBDLXxvfxArEdPCeY7bna7PgksnrZ3pbZlgCaVLeK5OV2rJeqnerk1kh7U1nQ2I+/Ux9sjKdcpCG6UwOKpzKKBGT4A+GvmiTOguoepdUK829EzhtfNn5+8yaxHbsdQdF/2MOCvLnbXa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=onemain.com; spf=pass smtp.mailfrom=onemain.com; dkim=pass (2048-bit key) header.d=earthlink.net header.i=@earthlink.net header.b=EyTQbxuQ; arc=none smtp.client-ip=51.81.229.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=onemain.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onemain.com
Authentication-Results: earthlink-vadesecure.net;
 auth=pass smtp.auth=svnelson@teleport.com smtp.mailfrom=sln@onemain.com;
DKIM-Signature: v=1; a=rsa-sha256; bh=Zth3NOT6hBrmTViZaCMJcSRN9B5Sbk7W2dm4FX
 pSX3Q=; c=relaxed/relaxed; d=earthlink.net; h=from:reply-to:subject:
 date:to:cc:resent-date:resent-from:resent-to:resent-cc:in-reply-to:
 references:list-id:list-help:list-unsubscribe:list-unsubscribe-post:
 list-subscribe:list-post:list-owner:list-archive; q=dns/txt;
 s=dk12062016; t=1750367778; x=1750972578; b=EyTQbxuQmY3eG51sU9sYLBAZBg1
 DCWLCqJICc2xSpDKhI0NOmEHvoSKacKNwX6cqQ6KRWF+6B7lLgGWuM5l1YvyxUhEIRSgO+0
 M5Eb244yJj86/cMhM/hx/7x9mHgUBST7F7a1g3nYdDRnISTjr+pnh0DAQ+8v5CDG87xmdPN
 8/uaVCGuFdqlwGJM+OHe68oJOQoaPq5FqOUNEKOy74Sr9Qz8zSUinb43zsJOVBZKoqaB/2X
 xgLQa/2AVxJ9VTSMyxJTDtch0doIw9k5DSSGkPUmAxchmSuoVKPxxxXQ5c8MzRonSheWSP3
 pJDE3YV5DmO5zcwXRlKvVmwgGEXW0Yg==
Received: from poptart.. ([50.47.159.51])
 by vsel2nmtao01p.internal.vadesecure.com with ngmta
 id 71176d0c-184a8e382a193ae9; Thu, 19 Jun 2025 21:16:18 +0000
From: Shannon Nelson <sln@onemain.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Shannon Nelson <sln@onemain.com>
Subject: [PATCH net] CREDITS: Add entry for Shannon Nelson
Date: Thu, 19 Jun 2025 14:16:07 -0700
Message-Id: <20250619211607.1244217-1-sln@onemain.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm retiring and have already had my name removed from MAINTAINERS.
A couple of folks kindly suggested I should have an entry here.

Signed-off-by: Shannon Nelson <sln@onemain.com>
---
 CREDITS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/CREDITS b/CREDITS
index 45446ae322ec..c30b75f9a732 100644
--- a/CREDITS
+++ b/CREDITS
@@ -2981,6 +2981,11 @@ S: 521 Pleasant Valley Road
 S: Potsdam, New York 13676
 S: USA
 
+N: Shannon Nelson
+E: sln@onemain.com
+D: Worked on several network drivers including
+D: ixgbe, i40e, ionic, pds_core, pds_vdpa, pds_fwctl
+
 N: Dave Neuer
 E: dave.neuer@pobox.com
 D: Helped implement support for Compaq's H31xx series iPAQs
-- 
2.34.1


