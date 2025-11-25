Return-Path: <netdev+bounces-241417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C131C83A32
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 08:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CDA9434CCDE
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 07:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626632FDC52;
	Tue, 25 Nov 2025 07:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Pct80v2/"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024D62F5A01;
	Tue, 25 Nov 2025 07:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764054599; cv=none; b=HHZw0Et+bUeQcZsO7aR60hSWYs6RtnabHnGZw6RJBbtZt0Sc73LIlcLcRj1Bp4mYoH9ciT8EHrlCft7HpJuo1jMFvWqJT07v3NWDJjStVV8ArHooM6VcpT2JFJp/pjA/mMKAxaZ+mRnX/nj45BW/udxOE/SxgXtaTxmhtDXeexM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764054599; c=relaxed/simple;
	bh=s8P59zXuy14o309lpEFgCRBkO784gA2VDx7qLTUv3TI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AD0obM7g2bsuuO4gYUMkGnUkcsxI0CWaqEd88FYVVLXvYYYjSW5lu2ZFXZttSWZvovvnSUyJIP6hIHnc8st5G21nO1HzgOaOQOCvPCuTARDmaDWl70ot26FkVKqz6cN0U6T2qCpEe53x/Xt7b9ZRMOOvVW4U6r9zDu/bNWBDM5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Pct80v2/; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=o/
	AnhP+3UrPwUxpLmFskeSydEQLDsE3a18Ktlz7rPZg=; b=Pct80v2/P6OXQlsxXb
	fkyUe2tHbBxZxmAOVlHTjMOv9NU3P7Z42ss9CgKo4bXCrzfXCSt8KPvU7c5kenVm
	xkEHffYEj5cA2hmhrlhrCdPEFaMP4I0FeyJbKzchjwj+xInPHCHCKnI6tUjzASur
	DB+Dl1lsZpdS7om8smNznbeko=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wDX9t4OViVpQblmCg--.6567S2;
	Tue, 25 Nov 2025 15:09:04 +0800 (CST)
From: Slark Xiao <slark_xiao@163.com>
To: loic.poulain@oss.qualcomm.com,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	mani@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Slark Xiao <slark_xiao@163.com>
Subject: [PATCH net v2] net: wwan: mhi: Keep modem name match with Foxconn T99W640
Date: Tue, 25 Nov 2025 15:09:00 +0800
Message-Id: <20251125070900.33324-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDX9t4OViVpQblmCg--.6567S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XFyUuFyUtrWDtr1xXr4ktFb_yoWDKrXE9F
	1kWFnrJ3yjgFyYkwn7GF43ZFyftw18XF1vvF1Sv398JF9rXry5WF4FvFWxX39F9wnrJF9r
	uw4DZF1Fy34xKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRKeOJUUUUUU==
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbCwBE9oWklVhFwFQAA3j

Correct it since M.2 device T99W640 has updated from T99W515.
We need to align it with MHI side otherwise this modem can't
get the network.

Fixes: ae5a34264354 ("bus: mhi: host: pci_generic: Fix the modem name of Foxconn T99W640")
Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
v2: correct changes based on net base. Remove extra Fixes contents
---
 drivers/net/wwan/mhi_wwan_mbim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wwan/mhi_wwan_mbim.c b/drivers/net/wwan/mhi_wwan_mbim.c
index c814fbd756a1..f8bc9a39bfa3 100644
--- a/drivers/net/wwan/mhi_wwan_mbim.c
+++ b/drivers/net/wwan/mhi_wwan_mbim.c
@@ -98,7 +98,7 @@ static struct mhi_mbim_link *mhi_mbim_get_link_rcu(struct mhi_mbim_context *mbim
 static int mhi_mbim_get_link_mux_id(struct mhi_controller *cntrl)
 {
 	if (strcmp(cntrl->name, "foxconn-dw5934e") == 0 ||
-	    strcmp(cntrl->name, "foxconn-t99w515") == 0)
+	    strcmp(cntrl->name, "foxconn-t99w640") == 0)
 		return WDS_BIND_MUX_DATA_PORT_MUX_ID;
 
 	return 0;
-- 
2.25.1


