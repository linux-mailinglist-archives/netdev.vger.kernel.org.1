Return-Path: <netdev+bounces-94963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C18D48C11D2
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 17:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A4ED28229C
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 15:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587E815ECEB;
	Thu,  9 May 2024 15:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eYbr3Mkc"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9CA15E7E2
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 15:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715267806; cv=none; b=DlQyMNP+LmyoP30H2ECM7TjMEt4oVxWGSymJchpSa0f9AFyzfMvmCjGh7NlM71xKY4d7LvYa7PlKDtj7wRlHb2o5XNHAKL1dPxDGWi8ZJ2e2Z1XMH1XscPXCmaa6m6ywqVXZz2czPkoziOEQDuLNLn7hRELiXlflKTtIGI3lBY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715267806; c=relaxed/simple;
	bh=L/+rcGxm+gQ9tFIq5RvrMnW6BAN0V/gocBjUZWqZpEA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EF/W0ljAEUUNBfSIIHc6D8JKJzMA+MUw/RJAsE+Hy8cN/Rgd5ysX0YxclpF/TgnOLYbrY6HKEnEK77PqWb9Db73cE0xkV6MJmym2tgK1qmvgo8pjnRI+trB1Mrj+pzUqc+mX9hHjFHWKl/GNiGBbE+feYXIsFrRNLthvrb62fhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eYbr3Mkc; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715267802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XsyRonQU5aSmihkGsGlC3BY6fsU6bTwS783GSqN7ndI=;
	b=eYbr3MkcD0UbdpkBalyjXJXCTdmNrN+EEkcIrXfSgxYxZkiNQq/LnNofxBiuGxhuyr4ekG
	ruW+hy3rdLVh7j97zDCUQuO24qy3xZuwSycbakXbWWJ7f7PoycSZzJtU0kj8qcpt1Py5Tq
	KH2qrL3bPfi4s7MyFKST7uxPhcKJqhc=
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
To: Michael Chan <michael.chan@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	netdev@vger.kernel.org
Subject: [PATCH net] bnxt_en: silence clang build warning
Date: Thu,  9 May 2024 15:18:33 +0000
Message-ID: <20240509151833.12579-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Clang build brings a warning:

    ../drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c:133:12: warning:
    comparison of distinct pointer types ('typeof (tmo_us) *' (aka 'unsigned
    int *') and 'typeof (65535) *' (aka 'int *'))
    [-Wcompare-distinct-pointer-types]
      133 |                 tmo_us = min(tmo_us, BNXT_PTP_QTS_MAX_TMO_US);
          |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Fix it by specifying proper type for BNXT_PTP_QTS_MAX_TMO_US.

Fixes: 7de3c2218eed ("bnxt_en: Add a timeout parameter to bnxt_hwrm_port_ts_query()")
Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
index 6a2bba3f9e2d..2c3415c8fc03 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
@@ -24,7 +24,7 @@
 
 #define BNXT_PTP_DFLT_TX_TMO	1000 /* ms */
 #define BNXT_PTP_QTS_TIMEOUT	1000
-#define BNXT_PTP_QTS_MAX_TMO_US	65535
+#define BNXT_PTP_QTS_MAX_TMO_US	65535U
 #define BNXT_PTP_QTS_TX_ENABLES	(PORT_TS_QUERY_REQ_ENABLES_PTP_SEQ_ID |	\
 				 PORT_TS_QUERY_REQ_ENABLES_TS_REQ_TIMEOUT | \
 				 PORT_TS_QUERY_REQ_ENABLES_PTP_HDR_OFFSET)
-- 
2.43.0


