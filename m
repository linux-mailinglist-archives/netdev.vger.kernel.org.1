Return-Path: <netdev+bounces-208813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD5BB0D3B9
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 09:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12CA116A697
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 07:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A332E54A6;
	Tue, 22 Jul 2025 07:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="HqdsA6lu"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039672E49A8
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 07:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753169859; cv=none; b=Ovo8k90SUSiLknK5Jc0rWHafuKASi+mxG3PYjRZn7AsqvZhjUhOjm5tTpjqqqyIrlcUpmeEHjoAwIngpn8AnpG+b7ErMrVjoOTuco4c/zwo2CnX6rl9Rg2YLR6TDmrwYXuOrSMtghgEEMrxX/xf9ezZxVCmmXB2X0UoY7zPkBR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753169859; c=relaxed/simple;
	bh=Mse6PLszhO3cdngmicTOnCA0f5skvbJPHBfXnrnGxpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g9BNECHTkfCEx78fb8XwYRMFEWTgxRLHxU5TEXF/YVKm5YY7rVeGxx80kHYvpBE2olnYcMkI4vCE4L3y50bR9m9totGjm1duO3XG3zGeNx5LoyKaF7ZF8TEuhThuaRcW18O9G/BqfgQBraHqVVla5YPNV3f67Rn2DA835kjVUsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=HqdsA6lu; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1753169797;
	bh=Ln6z5UMdHfy09BVb3ISvR9kteELxlxv1r4Jb0WU5wac=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=HqdsA6lurvDL0BN2pocw0QqQp9+aGe9jikD27j0oyb4hk3oU8jfBKUI2UATKWcgVw
	 0joLp5ZvfAoYKmtHvd9MsqX2YthMCEHV6g/xHDyBVBTcH3hgS/nLk8UBOj9E1Y5ixK
	 70uoqWAcPf3R6uGe7zIOn+1TcwKgpQTMuzjbvWj8=
X-QQ-mid: zesmtpip2t1753169738t55bf3778
X-QQ-Originating-IP: KSjByG7dJMLO7TG5I1iv5PR6js3yTNO4FTwwtL4j6qI=
Received: from avenger-e500 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 22 Jul 2025 15:35:33 +0800 (CST)
X-QQ-SSF: 0002000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10523341223142092495
EX-QQ-RecipientCnt: 64
From: WangYuli <wangyuli@uniontech.com>
To: wangyuli@uniontech.com
Cc: airlied@gmail.com,
	akpm@linux-foundation.org,
	alison.schofield@intel.com,
	andrew+netdev@lunn.ch,
	andriy.shevchenko@linux.intel.com,
	arend.vanspriel@broadcom.com,
	bp@alien8.de,
	brcm80211-dev-list.pdl@broadcom.com,
	brcm80211@lists.linux.dev,
	colin.i.king@gmail.com,
	cvam0000@gmail.com,
	dan.j.williams@intel.com,
	dave.hansen@linux.intel.com,
	dave.jiang@intel.com,
	dave@stgolabs.net,
	davem@davemloft.net,
	dri-devel@lists.freedesktop.org,
	edumazet@google.com,
	gregkh@linuxfoundation.org,
	guanwentao@uniontech.com,
	hpa@zytor.com,
	ilpo.jarvinen@linux.intel.com,
	intel-xe@lists.freedesktop.org,
	ira.weiny@intel.com,
	j@jannau.net,
	jeff.johnson@oss.qualcomm.com,
	jgross@suse.com,
	jirislaby@kernel.org,
	johannes.berg@intel.com,
	jonathan.cameron@huawei.com,
	kuba@kernel.org,
	kvalo@kernel.org,
	kvm@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux@treblig.org,
	lucas.demarchi@intel.com,
	marcin.s.wojtas@gmail.com,
	ming.li@zohomail.com,
	mingo@kernel.org,
	mingo@redhat.com,
	netdev@vger.kernel.org,
	niecheng1@uniontech.com,
	oleksandr_tyshchenko@epam.com,
	pabeni@redhat.com,
	pbonzini@redhat.com,
	quic_ramess@quicinc.com,
	ragazenta@gmail.com,
	rodrigo.vivi@intel.com,
	seanjc@google.com,
	shenlichuan@vivo.com,
	simona@ffwll.ch,
	sstabellini@kernel.org,
	tglx@linutronix.de,
	thomas.hellstrom@linux.intel.com,
	vishal.l.verma@intel.com,
	wangyuli@deepin.org,
	x86@kernel.org,
	xen-devel@lists.xenproject.org,
	yujiaoliang@vivo.com,
	zhanjun@uniontech.com
Subject: [PATCH v3 8/8] scripts/spelling.txt: Add notifer||notifier to spelling.txt
Date: Tue, 22 Jul 2025 15:34:31 +0800
Message-ID: <02153C05ED7B49B7+20250722073431.21983-8-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <576F0D85F6853074+20250722072734.19367-1-wangyuli@uniontech.com>
References: <576F0D85F6853074+20250722072734.19367-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OXn54RrYiVgPt6wHHMDe+3sEFskLKOlDwA/XqULvMirlJhQ67f0+5Xcg
	66xUX4R1fVuivdiCwoMLy1LtVaJ2pfpcpgYZnJ9p8uePjxO8LjbRgazy3zZG5Dp1i4OTJ0V
	154elbpcB6U1tv4cddVMuNypjPRfifqlZMNeSTiWOdZ2QWp5oATuKw474blUnzyx1NJ1xOc
	2xtw0th36LRyXIoN5+N3tK2eRoBzKPyRvebm91YdtGaDeJ2ADyJTA6bYVUsEyXOm/cmZSty
	itxqwbxdKzFQ1oopIXPG9Erl9/cIovCBel4QxWL0AvZoxBiBh0msFGnm05rJuFFF8wWG/UC
	uevQc6/SXVgsWUCuDVyIn6uKkEZNixVZ13GJBND5W/AcrAlaCjQ6zp8cx1XDLc8Qait5uBD
	0RNMzkx6/U1ms4RjEAfbYt9RoVXGquKrVGufUrumPDv6hlPXml2XXqH+hfP/Vg9pbonZW05
	e2TAHHutFJ+EonFZ9vVIqco6IoE20mbseT9fpYs5pKZnD92gyaV9LL9vwfJqpoQJAl291OP
	2NDvRM4W+8gUdu5Jidxz2O3WpzCnTNeLGwt7ZyQsuH+Jc/ofMGI1YJAukJSSXEQBxPdJbEL
	dKUnscmGn9ax4z8dTuTp00ULSPLTgoTK3SYsbM/3GXg7aJYsRXdCsZ8laQHK/EDrIWaYgoG
	FnM5mBeA1/U249j/CNqdR+FpFQo9PtzGYXePB5wRKzJIM4t/CvyMw0cG5zsc1eqCes2Kw7d
	M7MuLLVdK7qM4lZ+9hTxQNjM9mjtAlK7dvfJuJaiB6/3huk9KV1K4//XUe3tCS0EcT8KFsW
	UFFLn/odT33w1Qc7HAt88K61eqW7mI+8ekx42+lKk/txYLkizi4DXke4IUfEfIj3HbXBvJW
	yB8Q9V/eXVkP20FqMvjTDAjowUBYIzy0gRaRjYs21e1NMVWiwK14fW/Q5Gk3OAmah+tWFE9
	ZBdgecbfRFh79oiLfl1LnZXVcOfRuU9Qv3BZ44RGToriNhrAEInof2B0ovIqm8t1vwWVJtb
	XPfJlMF/+Q7a67bYfNZf92LTLxbQq2zpTfynjbyEV7DmQRMo1pPpzgcNraFy2puQ8X6732p
	IB2WMF+Yr2dZJNLTXUXgGGq3fSIMfxlgLL++nB3p2hxkCxT6Q5O+5w=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

This typo was not listed in scripts/spelling.txt, thus it was more
difficult to detect. Add it for convenience.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 scripts/spelling.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/spelling.txt b/scripts/spelling.txt
index c9a6df5be281..d824c4b17390 100644
--- a/scripts/spelling.txt
+++ b/scripts/spelling.txt
@@ -1099,6 +1099,7 @@ notication||notification
 notications||notifications
 notifcations||notifications
 notifed||notified
+notifer||notifier
 notity||notify
 notfify||notify
 nubmer||number
-- 
2.50.0


