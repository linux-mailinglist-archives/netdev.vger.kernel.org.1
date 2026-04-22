Return-Path: <netdev+bounces-280427-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2C1SOfvM6GklQQIAu9opvQ
	(envelope-from <netdev+bounces-280427-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 15:28:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD04446BA1
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 15:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4ED85303880F
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 13:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E333EAC9E;
	Wed, 22 Apr 2026 13:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thingy.jp header.i=@thingy.jp header.b="XyMTgi10"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D62C3EB81E
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 13:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776864440; cv=none; b=nCPiTFmsLWU7e7H6QVhGUVh9ZjG7ktyB9FE+36cuWtJ+IInt6jIiroNtGUuKamiOHTYrQ0J9npBZ35dMYBPurSZ5seEMzXPG6AT7VOfxFGS/OSffGKe7luzWpdy6YRPGSfSAwzk8t6bnovCCZ792E56/QwspitvpfhFCI71F93o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776864440; c=relaxed/simple;
	bh=CNmV50fwWM2qTb/hOpmr0ep4rnwuMTOUpDhQuUCzzaI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Oku099x2W7cqmbGFJ8JhGKfgTFge5geNwXynyZHeK6CUpylEGXpK0pUtZ+nLCB1SzkmP42brdh4BRYfVTulDHDTUoE1WKzhd4Ty4Lvk1A5BcLzDkG8oORy57Qw2IE95BW01mQ+c4mzUQtK/GB0f/d6/3GLYFslvB1qza5LBtajE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thingy.jp; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=thingy.jp header.i=@thingy.jp header.b=XyMTgi10; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b0afa0210bso25303305ad.2
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 06:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thingy.jp; s=google; t=1776864437; x=1777469237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jDcTBG+hlhD51mSvRcMB9jaoIaf7As497aHU40CIgJU=;
        b=XyMTgi101dgrRbsAoVmGjSzfdqoZEZtd46wbhVU5xf2s8AUrD19aA2WtP/eLB//XPd
         ufi/gtA24nuqyyqAE2k1yI9LZ9rKXJEqdEegpFXxuR9AiA2ZVEds3wKYIyfGrDJaTYJb
         533m3mgCjQXKtr+ij6VsyJsSNPTnQbtPiKAZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776864437; x=1777469237;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jDcTBG+hlhD51mSvRcMB9jaoIaf7As497aHU40CIgJU=;
        b=okdPVuG6sNMi3sycKGb2RPpOVEJVlkZlDstyIAxxuV4SNWlOzs6VFMchEGN1sdsHvv
         H/GG5kVYwPXmKZH1i/LZVXbqks1pBV7pCCYykRy27lvmoMFyUJtR8vjq+r0Rp157fhuv
         UlCErlT71M283GsMxpGFG40sdom5JKOg4yf+Nl6q310EaSanQxOjI89F5z9uoqCZI+Gx
         4aHcAh2Rr3SOjNmmtOqG0/4e4HyhtX7JHuL3Pe/mVqAXJ5QiB9S9l73w/L93jt3xot95
         ypEXcpFuJLomF30k8W7++xZ6MX4LU8Vg+botdobgaMomW34pR0LJLp+C7IM26RVZ3XKL
         u2Qw==
X-Forwarded-Encrypted: i=1; AFNElJ8wv8MnSJFPnHxoMpvymnhT+9hQMPoRzsopU9zNcSNdslVD4e0KghEGKGaiAwy+H602Guw5BK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YypzkFQVd4ELwfzU7b7Yulf/whBovJ/TDINunpNUKk5l07oPtZg
	M9TDfc9AHU6+jAmprUfabjDtKh2D8t0893BMYz2hZo2odVivtJFYS2KEl4qXSti6cvk=
X-Gm-Gg: AeBDieuTEcFwRHiv0Kvn3hGwJnP9MN7tp8XRiG2uoKEx5ojlYN6Jy8GOtDSIEJWCm1W
	P8TMrXiRuhObysizJmrEZ8/H3JmKVksJPkse17ZpskbhboH3ZNgMKyTlvDIh/lPvEpyHFNBoV2V
	qVJDj+d2Q9l2PCrm19wQBtgB7nQZ2oqLXJm110XUsm/64L9qA4mEtnk4XWYDwVe4Pg6o4m/LkMT
	vXCVIJetNNefrSWGp7y0QtQ6eTjd57ZwiM5J9ZcbrEYZsZAhBT/j3ehoOJwtGfylXKLsg/lcppg
	nJbcUBs0QqbzYMa4t614RppLUDF/nQDycYd1qjjXzhLLNkgW8gZ1zyh3Cnjfkh8ZI9AGDb8AKTJ
	xIiIcb/87FXa/Xu+d+T3Nh6eDV5Rzs4vtodIzJCXGzIweTAWBtQdGoy8ncei8KwcOvs9t5qfhZo
	IkahC20XWFBEVdp2J7sRqstgtCUdplS70NauJTIMrMmwzw1VQwTbvH5x7YVCNp2M2Y6mkBpcOxV
	MIZo8oqj9LEUhlg8ONfcyA9
X-Received: by 2002:a17:902:7c0f:b0:2b0:663f:6b53 with SMTP id d9443c01a7336-2b5f9eb2b36mr169293385ad.13.1776864436549;
        Wed, 22 Apr 2026 06:27:16 -0700 (PDT)
Received: from kinako.work.home.arpa (p1329195-ipxg00a01sizuokaden.shizuoka.ocn.ne.jp. [114.145.5.195])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2b5faa34ea7sm165756005ad.34.2026.04.22.06.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 06:27:16 -0700 (PDT)
From: Daniel Palmer <daniel@thingy.jp>
To: andrew+netdev@lunn.ch
Cc: geert@linux-m68k.org,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-m68k@lists.linux-m68k.org,
	linux-scsi@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel Palmer <daniel@thingy.jp>
Subject: [PATCH] m68k: mvme147: Make me the maintainer
Date: Wed, 22 Apr 2026 22:27:10 +0900
Message-ID: <20260422132710.2855826-1-daniel@thingy.jp>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[thingy.jp:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-280427-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[thingy.jp];
	DKIM_TRACE(0.00)[thingy.jp:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@thingy.jp,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.983];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,thingy.jp:email,thingy.jp:dkim,thingy.jp:mid]
X-Rspamd-Queue-Id: 6CD04446BA1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I'm actively using mainline + patches on this board as a bootloader
for another VME board and as a terminal server using a multiport
serial board in the same VME backplane. I even have mainline u-boot
on real EPROMs.

Make me the maintainer of its ethernet, scsi and arch code so I get
an email before one or more of them get deleted.

Signed-off-by: Daniel Palmer <daniel@thingy.jp>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d25342ca8aa1..9949b5528bcf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15311,6 +15311,13 @@ S:	Maintained
 W:	http://www.tazenda.demon.co.uk/phil/linux-hp
 F:	arch/m68k/hp300/
 
+M68K ON MVME147
+M:	Daniel Palmer <daniel@thingy.jp>
+S:	Maintained
+F:	arch/m68k/mvme147/
+F:	drivers/net/ethernet/amd/mvme147.c
+F:	drivers/scsi/mvme147.*
+
 M88DS3103 MEDIA DRIVER
 L:	linux-media@vger.kernel.org
 S:	Orphan
-- 
2.53.0


