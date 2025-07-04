Return-Path: <netdev+bounces-204120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED03AF8F2E
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 11:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 898195858D7
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 09:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100A728D8F3;
	Fri,  4 Jul 2025 09:52:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC982E974C
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 09:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751622736; cv=none; b=rtkN0Bl6BUrD0NslT9s+7tNVWxqq2gqC6JsICnEceF+8eim88HJNQrqRO8nxnVwBNgKwPIq/HxepYbAq+lluJ6XnmyRNnBDiVtx3B19EoNERYnnMtd3I6+hCH/FGvjFqyve0Ep0YalsvxDtCVLQnSJwd1+3TP1YpCShPOOzc1Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751622736; c=relaxed/simple;
	bh=bGBZRVNvn20ljGWqnan9JFfmDSpk7ft4e0v/0WFNrok=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q9iT89zqR2K2Thl0PMzAgER+m6yAwyAHRNI349jw1UqACKKqe+i+7K8jtslRlhKQRBUHDNL9usEwLrwUFq/YmxFWN5godP/NjnaHOgZe0RJfxEC0WqP6wKgEtcbgnigP5CYiEbB1R9Hs6oR7n/bwk5T/1RyqMPq8aF0p/XXOskU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: zesmtpsz1t1751622667ta78f9de0
X-QQ-Originating-IP: PCPB8T8SU6IxrzoIrXJXM7xHgW4m2RfgVC1tsQC4ZHo=
Received: from localhost.localdomain ( [156.146.53.122])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 04 Jul 2025 17:51:00 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11872626369487512020
EX-QQ-RecipientCnt: 10
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: michal.swiatkowski@linux.intel.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	duanqiangwen@net-swift.com,
	linglingzhang@trustnetic.com,
	jiawenwu@trustnetic.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next v3 12/12] net: ngbevf: add link update flow
Date: Fri,  4 Jul 2025 17:49:23 +0800
Message-Id: <20250704094923.652-13-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20250704094923.652-1-mengyuanlou@net-swift.com>
References: <20250704094923.652-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:net-swift.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: Nkc2PsekgugWrQu3DfjmZovQOkXKVxVjtMysyWhfHkSk5iHdoO14KFgz
	56bs2zcoP4vPuI1BjhNIC3LipkhPDV5Dt9lQO+SYeVNEOApR7uoQUFntq9uPtwDNMaeyHQW
	SLLqoHnBDCf6Mza+OwsCmbtr9F6I1AB7DvsDHkP3MfrAJcoyj69plvtau9PDP5b7uv44YdO
	R+IBVH9bUphEeX9JGyadGeh6C+Tc9M7NTKNIEvoHHPoSzVo8ygaag6/ZDcSb0KOFlJZoLdr
	1Vat3JldIY+iioMc96xatranSDoCuHL7iuC0CZTQS6dsGMtfGctBcgBCwSsfHf3MeAsu01z
	SrNfHsd1fApihfhFd0AZHKvyGDfDp3yPR9h9L9ckTUp0UBB0qrQkc9nxJGdxTL9nUiWAU7u
	ev3PAYWWjb9p+1XcpTpjlGDvPSP9RPmDsPmuRhbrsPda7nz0pYPHho1XUdfa2LUewXFDNEK
	6jCv3tIExDyuR1AOcGYP+t7HxGtuUBM+SBpkoK2k+/IVqvaCRxGkT4puSv709m4KH4vK/48
	NZANRvY5JBiS3PP3L2e2ZGqJm0YoOvEPwvxeMukKlgA8mm5Nh39szK3fPxKio3Io1TerRCh
	3iS0Zc8D6RJv0jQVWe1GnJ/yx8IJwGlOM99Z+aXFahc7Ck7jK0Mu/gP6L21qLuuTqsuBZBq
	KkwDuljvaagIL6Jp8mQL2rqzXidwFuKdu03c5VpJSkgX4ibQ8Zsp4OEVj6yPpgqLeR5P72l
	qD2k/Ez+yKGg1jWWIRdY4a2U5eJhb5k94Oi/LCmhyVivjrObgnyVey5gyDRxzmbINHdlDHJ
	dz6X+0/zn8VF9AQz07d6t39FA5AJyh3OyuZwCY3Q2mhzjBsfTVZhC+/cz47HykMM4uFnIMV
	PqvWd/Whr+dATDjEjz6/4EidC2R+xKjdFw04VAA9/ROQnnIZpjwpLAWCdch4laAEol9M+LA
	NjGzj3Qycq0x1JUvSiFxWGN8mbpPBk5aaj5jCtN8VimwrgZLvRtYHXiQM1GF3vsgIzUlIq9
	QY6zNKAtQPVjZYdHhFZBZQpfs8caUiRZ5P4KMSq0HOmvCa8oylN4Tqqb7Vlskn8tUFfEdMG
	QAflrVeJlEl9JiC9sl5WvOjWU5EXFc/JKDjC/bBkHKEbHmr1voH2ogOIZAjPN+8OA==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

Add link update flow to wangxun 1G virtual functions.
Get link status from pf in mbox, and if it is failed then
check the vx_status, because vx_status switching is too slow.

Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
 drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c b/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c
index a629b645d3a1..c1246ab5239c 100644
--- a/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c
+++ b/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c
@@ -197,6 +197,7 @@ static int ngbevf_probe(struct pci_dev *pdev,
 	eth_hw_addr_set(netdev, wx->mac.perm_addr);
 	ether_addr_copy(netdev->perm_addr, wx->mac.addr);
 
+	wxvf_init_service(wx);
 	err = wx_init_interrupt_scheme(wx);
 	if (err)
 		goto err_free_sw_init;
@@ -213,6 +214,8 @@ static int ngbevf_probe(struct pci_dev *pdev,
 err_register:
 	wx_clear_interrupt_scheme(wx);
 err_free_sw_init:
+	timer_delete_sync(&wx->service_timer);
+	cancel_work_sync(&wx->service_task);
 	kfree(wx->vfinfo);
 	kfree(wx->rss_key);
 	kfree(wx->mac_table);
-- 
2.30.1


