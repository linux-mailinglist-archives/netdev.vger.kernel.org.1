Return-Path: <netdev+bounces-307386-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2L1FNk/wVWrGwQAAu9opvQ
	(envelope-from <netdev+bounces-307386-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 10:16:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3957D75244C
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 10:16:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=iv8uyQqL;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307386-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307386-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B548E3049FC3
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 08:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5134B3F6C2D;
	Tue, 14 Jul 2026 08:11:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13C23E1D04
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 08:11:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784016697; cv=none; b=ewny/YLu2L8u94ZWbDCaOYpp7YhVjmua7rv1PthF3N+/N29d1AXltwus59KAC9RTzPwQBOqeVr4dshp8HOvKqEGR0DbdhDyJXNOQm3Kj5bNGq1yvkdWy8JOAz42SxpX+DkDA0r57+CaAuUL4P7n1fT+gSd8m1x4M76/KYwkptnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784016697; c=relaxed/simple;
	bh=ycCZlW5s2czC+w8cDs2mDX1LS/uO/v2d8xosk/RQMnM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lefa445CzYt0bJWsBSM9mwHPhxbW5s401gP+J9tycue4fKozjZkbNZSz8HHvCELgko5VxdQj/OYTVTl7kBI5j3pJXxj5Xo/eguKR9jl5hBlB2RQUTD3ZGK9gIaKcnS5Mxiffn/JySL7aSqke+F1nUQda6wUPEo798KiecgEsteY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iv8uyQqL; arc=none smtp.client-ip=209.85.216.51
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3810c5d691bso3163608a91.1
        for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 01:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784016692; x=1784621492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=s8Ipgx3lctn3cg5R9rlDTJWZ0blL0+fnY2U9hYcXA5k=;
        b=iv8uyQqLWczAbYP0C1DTVJc8kATZmt6HEn8I6bd7A1jR/dgLnx/4peMJoGYAkQUENM
         X6nA3EEdBaq0d3jLmsKhahtKKTD9sV2Ut3qyb+nJBX5YSLwe593YqJeNvEDxQN85/fRJ
         aNsaZhUrn9q/TJYVKQPgPQh2lpVKCCtAoiGpy0uA+pVUEa2x5A4FtdGqRY02Ne6tM+3t
         /s1Hm0jGTKVMd45dLHIZn2UQyY5+A81j5m0T22ga66FLtbzttnIqk9viPphxvRUQlyWZ
         Kry9nG3eFx6ceXK10r7gMczgVkcb1awZa/Sk7eB7nOegcrcs2+4NxoOABcsQL20T57HS
         5ivw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784016692; x=1784621492;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s8Ipgx3lctn3cg5R9rlDTJWZ0blL0+fnY2U9hYcXA5k=;
        b=GFcp0DeTGF0JUetl3UazWmI2a9QBBR6RYzYLmET5r8zugSQDXf1nhR5CAzNHn15lw6
         VZTAgziGtOlRZGYKK4vt+96jNgwXrjiAbhJAGDJyWz084HLn31X/rS0X/fnl6cQUyJze
         hKErV8yWNaUjh3HGWeiWDjku7lz3nQhQH8zcTr8h/YJNx1zqshIn4SKdYiSIq0WGL+BU
         n2UHFek7173OmINyOOt6VnMraMp4KHcrU+Pnb0A8Tnz/n7Q7j3RXBdSdvoAw3cEGxy8r
         1WROWE5THWvZPt+Pj5Jk5F6NTgh9l7cgozJQEwLwcOcNviFYLnPKxudDUuO2+9vK41/2
         WmVg==
X-Forwarded-Encrypted: i=1; AHgh+RoTK1rcino4gh/HE9T+KC0yPVmaFn/swn3yWKXYR2Mpl6toddhPDY4XJCqkNf4fifASyGtFnaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwpNxTltyPPDHzQiwFsPXVuNIPW9mLjN37b109QIgVbbo99/Bi
	piyrzS7fr6xvPdWnGwkBGeCExwANogQJv9W7+0hefs0GuYV1uVkIqEY=
X-Gm-Gg: AfdE7cnfw3b5NvE9MP1uwub0jLZFl0e+mRD2O+qTF9dk7hVTD5Ryzl/x/qAFswYL20w
	OjG+MxV/GTC6FsZjZCm5UDar6sxKU6foE1Xjq7J2lVReahK2Kb3PVU4Dygr3eu+ev4JbnFJYYVd
	/uEf9TTAujhZn8zUn6fhCOJYiAeZdui5VRRKn4+GA8s/f/pjtJ3uBPilwOIjVVeWAYOdLazVaGi
	u7fX+9tpI2oyEez7Sd8/rkDZlFCLl9m5QCzM84ST+RgI6e3uSbDAX07ztaVh5kSjMlOf9L6pC0o
	F9dw1IoKFcg58IjOhgH66VrnqKlDECEDX7Vggw4RJFid3BmeFKCOX3l8CrxV/faqZ2hREQru+TQ
	MKC1Kx8eL5pGwHSdA0EDMPb9ybtik3Dj6zn2eA9SvoCBdZa6qFpNIrjy8cZ6MmeG2gKRs+2ZZm2
	nbR9e3wPttVcI4w1jcAhoOuMTN0xu3s5CEAY/RU1GAAkbAqzYPq4CK31uMCCfUZWCed/J5Cqy5k
	TcvAlGOrJ6HRVDft2PgatmP6yYX7+jHpxr1XnEAyR/6QXJiiA==
X-Received: by 2002:a17:90b:1a89:b0:36d:9e0b:3801 with SMTP id 98e67ed59e1d1-38e1add8ec6mr1362188a91.8.1784016692263;
        Tue, 14 Jul 2026 01:11:32 -0700 (PDT)
Received: from localhost.localdomain ([14.5.152.27])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38deea72fc3sm1427267a91.2.2026.07.14.01.11.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Jul 2026 01:11:31 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	intel-wired-lan@lists.osuosl.org
Cc: Milena Olech <milena.olech@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] idpf: disable PCIe PTM on device removal
Date: Tue, 14 Jul 2026 17:11:24 +0900
Message-Id: <20260714081124.90962-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307386-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[mhun512@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:intel-wired-lan@lists.osuosl.org,m:milena.olech@intel.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:mhun512@gmail.com,m:ae878000@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhun512@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3957D75244C

idpf_probe() enables PCIe Precision Time Measurement with
pci_enable_ptm(pdev, NULL), which programs the PTM control bits and sets
pdev->ptm_enabled when the bus/controller supports it.  The teardown path
in idpf_remove() releases the workqueues, vports, mutexes and the adapter
memory but never calls pci_disable_ptm(), so PTM is left enabled on the
device after the driver detaches.

This leaves the PCI core's software PTM state and the device's PTM control
bits set with no bound driver.  pcim_enable_device() only arranges for
pci_disable_device() on teardown and does not undo the PTM enable, so it
is not a substitute here.

Pair the enable with pci_disable_ptm(pdev) in idpf_remove(), matching the
igc and mlx5 drivers which already disable PTM on their remove paths.

Fixes: 8d5e12c5921c ("idpf: add initial PTP support")
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/net/ethernet/intel/idpf/idpf_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
index 0dd741dcfc..3d3471d3f7 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_main.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
@@ -159,6 +159,7 @@ static void idpf_remove(struct pci_dev *pdev)
 	mutex_destroy(&adapter->queue_lock);
 	mutex_destroy(&adapter->vc_buf_lock);
 
+	pci_disable_ptm(pdev);
 	pci_set_drvdata(pdev, NULL);
 	kfree(adapter);
 }
-- 
2.47.1


