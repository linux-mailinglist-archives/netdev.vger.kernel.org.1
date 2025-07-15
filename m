Return-Path: <netdev+bounces-207134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D89B05EA0
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 15:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93B7C5014C1
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 13:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B3D2E5B17;
	Tue, 15 Jul 2025 13:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="FuSGLnLw"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8BB26F44C
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 13:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752586959; cv=none; b=jsjzgBL/hGP+I5iiJwjdjWu7bNnP5WN6UFIUteOelgMCYzy6enk5ISuz2/5S/G6C06BZPwrBZxwV4YGdN3DjEBIbW4eJ6KiIECkUHD8iKpG6j0rlPD7I8hbSw0rUZE8UWdKX+jkf+NbQDJ9qWios5U5uHROGHcHSyLVpZKwAolU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752586959; c=relaxed/simple;
	bh=7dSG76ruHEHqbRjXtpbZP2fQrkMNdrnwG4/ymtpfEKY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ETMBz9s5I/QlDwE70/kqnmViuokeLkZ10Hbd3XjLd2Y/ax7DBSH5OgpDsq0qY+lsY+zDT9PuhpXZluWbtSNA3TIB44sAFkKWAFSPuBA7bCDsJv7ES8sFU6OJQUrsRs4Ol/CPGR7TzagmbvZSbGVw+KYTlPALNFkU/l+moUtKH1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=FuSGLnLw; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1752586877;
	bh=DYh+6PDIK8SljIBmyMHrXvBMyc6UvyjoLxtRvLKcLYw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=FuSGLnLwCgAHTPyGVASWNIky64prQYBGC23iLTwJaxSXF2msqdPe5oYgoHClHMjNJ
	 5jf6pn/sdZvM2ROoK0aOG8bcnlxOzGOhJhgJVveAYgoF3H4us4KUN8Hiz2cHR4q8Yp
	 EkZeBNRjaS9QdvY/QRZfUBTVHqYWXKOCZC3PZvZ8=
X-QQ-mid: zesmtpip4t1752586865t2a0dea2e
X-QQ-Originating-IP: vd1RqZ1Qgxy/7VfOTmQ9xNBTBKWDttmC7/G/8c4FLA8=
Received: from avenger-e500 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 15 Jul 2025 21:41:00 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 13011556839216271353
EX-QQ-RecipientCnt: 63
From: WangYuli <wangyuli@uniontech.com>
To: seanjc@google.com,
	pbonzini@redhat.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	lucas.demarchi@intel.com,
	thomas.hellstrom@linux.intel.com,
	rodrigo.vivi@intel.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	marcin.s.wojtas@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	arend.vanspriel@broadcom.com,
	ilpo.jarvinen@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	jgross@suse.com,
	sstabellini@kernel.org,
	oleksandr_tyshchenko@epam.com,
	akpm@linux-foundation.org
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wangyuli@uniontech.com,
	ming.li@zohomail.com,
	linux-cxl@vger.kernel.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	netdev@vger.kernel.org,
	kvalo@kernel.org,
	johannes.berg@intel.com,
	quic_ramess@quicinc.com,
	ragazenta@gmail.com,
	jeff.johnson@oss.qualcomm.com,
	mingo@kernel.org,
	j@jannau.net,
	linux@treblig.org,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-serial@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	shenlichuan@vivo.com,
	yujiaoliang@vivo.com,
	colin.i.king@gmail.com,
	cvam0000@gmail.com,
	zhanjun@uniontech.com,
	niecheng1@uniontech.com,
	guanwentao@uniontech.com
Subject: [PATCH v2 0/8] treewide: Fix typo "notifer"
Date: Tue, 15 Jul 2025 21:40:50 +0800
Message-ID: <BD5C52D2838AEA48+20250715134050.539234-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NxNXR+75FT93Ufg59fDooSQLnlP92pEr/L2MDxkTpQb7looLmY8Zb46w
	GrZjt/VRk4Iix5jkre2vs+mSmYo9/sYI0P9LEeUCQJ1Qwe2Agv1KAfiBWLjQo/Dc5GFrjRU
	aeDP4vJkebtjmXV/ZV+RnKNqub2R/W5qshVBHruEJMUr9uErYTBJUChbuYhGf2hvODAlnhc
	cq8H1WYkpLgnx9S2pg9dxx7exKq4EaSlnTxTaZ4ZS8kwNdxSqdR5CfjR2jGGJL4uUiNDPN1
	Sv0N1tP9C2xczv0Jpy7me8F2lUlvhWbKbx0l3FWYtOQW3P2WG+zxEsjkf0vSE/5TP3BTAeB
	78EW0QhKGX5C2MaQf1KwyXbG69AOca3xBRsnRUj9hkZDFw/e99EzsUq3tfxUoFOdKIu5gy+
	sMZiJNGRDWELmfT7sabvBxqGLjo9LiBZxZ0D+oAzXuKImrNG0BKqVqoIiIwu32O1rcMy8Nx
	tWC0VtdFNvJOSR/WvluvFRJZaYFsbGdgQIPPkhFCE5M/ImU+Phys2VPxqKdfIcEk9IjyXRc
	n4oY8gNmGIlDqzYxsfOYMjViw5CM4TB0J9aQZPRNzN9fQhtvrT0WOA1A/jM8y/gPin/H8qz
	fpdmSQ6tH14h7SX+I7ogLQ9LGgWvQFZJVzoCdB96YovML+wn4q0ye1qfzkruvelLW+d3cuP
	AL3guu5nqAuTHa4OhVjjkVdaMieDbPUybeeBCsDkMkh0UCyY6omUP1bwtCeQkUwV2XdE2ii
	pZD4mVfO4AsqpkwGtdJzxjBc0KUtW2oU7g/OrmVQnFiU/G+XJeuN+xbXbpK7CuU2106Xryq
	SzJ+MPKCool6MekPIPa/UM1y6bl9trV9WC64eWuV7WwVF9pfhaeQbyddqn0j1u3TQeonX81
	TiSy+Y8NfGIXSir25rmj30f+ce1gqxZCPEQQUxz+JQjl7hk3Psp2lOS2lm4kaUbnSmjFyTs
	UrLS4gagGKH3UTnmi9ZNKvW1tEm9onpQWe2WoxzrXpOjaCU6ikjBpMXR4i4GGDPiULQVwvh
	ZfMya/sscRAEYibsODAnt2qhnUhmhVLcl48Oj37zhmTJ69BkPTkyqotEaGTNh3pPeeYG60F
	J1iar7VRGiGOmTJzHPME3Y=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

There are some spelling mistakes of 'notifer' in comments which
should be 'notifier'.

Fix them and add it to scripts/spelling.txt.

Link: https://lore.kernel.org/all/B3C019B63C93846F+20250715071245.398846-1-wangyuli@uniontech.com/

WangYuli (8):
  KVM: x86: Fix typo "notifer"
  cxl: mce: Fix typo "notifer"
  drm/xe: Fix typo "notifer"
  net: mvneta: Fix typo "notifer"
  wifi: brcmfmac: Fix typo "notifer"
  serial: 8250_dw: Fix typo "notifer"
  xen/xenbus: Fix typo "notifer"
  scripts/spelling.txt: Add notifer||notifier to spelling.txt

 arch/x86/kvm/i8254.c                                        | 4 ++--
 drivers/cxl/core/mce.h                                      | 2 +-
 drivers/gpu/drm/xe/xe_vm_types.h                            | 2 +-
 drivers/net/ethernet/marvell/mvneta.c                       | 2 +-
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 2 +-
 drivers/tty/serial/8250/8250_dw.c                           | 2 +-
 include/xen/xenbus.h                                        | 2 +-
 scripts/spelling.txt                                        | 1 +
 8 files changed, 9 insertions(+), 8 deletions(-)
---
Changelog:
 *v1->v2: Break patch v1 up into one-patch-per-subsystem.

-- 
2.50.0


