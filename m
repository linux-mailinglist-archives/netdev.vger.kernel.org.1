Return-Path: <netdev+bounces-284785-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4EbLHBgb+2mtWgMAu9opvQ
	(envelope-from <netdev+bounces-284785-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 12:42:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C264D96BF
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 12:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8C622300AC37
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 10:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35D7421882;
	Wed,  6 May 2026 10:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rexbytes.com header.i=@rexbytes.com header.b="jCnImI8D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAE437F8D6
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 10:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778064149; cv=none; b=EtCu64g/QaIOiaItTUmBnQUILiq3E9KqPbtkC5YEwW2S4snRZI2u1xngAV34Jm7dXROKC/66wyhUr07PJEado9uxbgjL6/AvTKuy16WHYfnfUwKAFmCmp+u5ex9RgemREangCEPuNtdI1CVqH5eM5S0wVz4i1aK3AUuiwgqffoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778064149; c=relaxed/simple;
	bh=KT3RztIZzygqyt2MqwyzEPofAWPYcv55sw/QXmU1OgE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TWIMf9GkSVxMLwPyjtwYk/XzOL2MVEeIsXzps2kNUGzP/mwuK405F8Z6DSyfWiow8MU6P694ukPIN+Jw8xL6x3Bs3JupvfH4eVUT99/Njm+2BW3QZLhK5b7BK0yQdEEHuvj/cyvGZyz8VkcUmbtxctMW1Z50AmcaaJQ0Pj9Y4mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rexbytes.com; spf=pass smtp.mailfrom=clientuser.net; dkim=pass (2048-bit key) header.d=rexbytes.com header.i=@rexbytes.com header.b=jCnImI8D; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rexbytes.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clientuser.net
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6763cc8775cso1347361a12.0
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 03:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rexbytes.com; s=google; t=1778064146; x=1778668946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jias4nxgB3eyNmqda1jfxvOxgCX6OydtclPwJD7WctA=;
        b=jCnImI8DseuecP/By/pPx0jzEaxHqhkEK+jL1OgrnoFBsCGlFHcVEgUqp107rLgorM
         zF1GBRcmP/H/Urv7dBzkcS8S2bDAS2rvDAN/R8CA8zIV1gPu9oeNCZ6ouazxo7nRyOrU
         PqUhaoOWJipV8awore9KvEtRtCXC6gM8m1a8420qLa8jPvhnvDTQA7dwM0oAqgnixGnw
         /GyP4LsIiYIB/FvbPQmfntclvrx8h/o7Q2UGaW0G8hCbA9vxw+By3gyoSkqk1ouBFvDQ
         oVjLGiGV238lQsQ6fsarJ566CZHeTfjVcMgB5KyM0xDE0MqBvQvZDiYJSiSQtj8MppNw
         zXZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778064146; x=1778668946;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jias4nxgB3eyNmqda1jfxvOxgCX6OydtclPwJD7WctA=;
        b=LwoY+88tGpmA5UTGih5EP9W0M48EDHBgspD3UqqsMsare+xSNR1mtZ9FQHR0rqmyWB
         KoFD9gtP4F35zin33WW0JoVlXg7FsAGbfc3lot7ssnXu4c/Hqzea2ZKIEKs1fH0rQPnI
         t0jWYfNKaQfhEhJrxUARAx6WRa8IfTRUtREi4Tcnok8zfyvzTleddBWXSWXvd4alp73U
         YljpbtPhlF4vaMt9r37Y+/u3ppJGir6mrEX2xedpImlivwXkcoCQIeEiN0TvUw5hu8nN
         5OcSo8xks3UD1zKDjsKcI4exKuuiqzanae6KaHTjL9VCSEtfY6aEUEEa2MgI/qsCUESB
         iMaA==
X-Gm-Message-State: AOJu0Yxmh+4vCycjd1eKgdhog5i3qPDFYQXMhQE4IesKL4GNJOEQhcMp
	fBlTv3vPY3rmnYHK89Ot/s1lw9JSou7bo3YwBsGx1KTwboLi6hGjti82LeiTd8FlxDo=
X-Gm-Gg: AeBDievKgk+5yZ41ixAozwx2QysDFexSrnfR349xjDvRKLZRCutZgMJD607WP/B7iN9
	GVpkWFJ06sGx1M6yXuDOCukinYMC09AD86xDiAaqkf72JnNieRXHGv+8eAkF8EBZa7u6ucpBA2Y
	RuQCDTqMB0rk67/Z1BeyED6Fv+slRz2p9YsviIzGoKqvLwXRRjUHx1dN9AukSPMCcwaotWw0SUr
	J6Pl66oZxwtJhUDQagF+50M3YPhiJciLMNO47aobdrada6v9fHCxaZ+IuakcqAt3qn0x4VKhk+F
	zzrIFmj4dQcFKyU1xvjAEbD7G0XgvV1PApMrhHN4evI8Ko1kb8xY2VTct/tWfIAkZVe88btCQbz
	pPAZKWie+b3dLDDZnM/9lWP5cm32sHkpM+uNkcttQNytSSLroQ1AAEODtYedACKyrnejLgsp1jc
	OvlLScoeo/hB+1V76svgpSimV2J64q9OCNtqaob+uAyFA4YimUaUdSmWnPRd01l5GaQkWNu3MAt
	d7de58HhD3CNtw8LZa6IxY22YE5
X-Received: by 2002:a17:907:c80c:b0:bc1:1808:7fe1 with SMTP id a640c23a62f3a-bc54c457536mr143692766b.21.1778064145139;
        Wed, 06 May 2026 03:42:25 -0700 (PDT)
Received: from localhost.localdomain (83-87-100-220.cable.dynamic.v4.ziggo.nl. [83.87.100.220])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bc55e6ec72bsm70210666b.35.2026.05.06.03.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 03:42:24 -0700 (PDT)
From: Rex Bytes <goodboy@rexbytes.com>
To: Igor Russkikh <irusskikh@marvell.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] net: atlantic: preserve PCI wake-from-D3 on shutdown when WOL enabled
Date: Wed,  6 May 2026 12:42:11 +0200
Message-ID: <20260506104211.2442-1-goodboy@rexbytes.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 30C264D96BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[rexbytes.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[rexbytes.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284785-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[rexbytes.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[goodboy@rexbytes.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

The shutdown handler aq_pci_shutdown() unconditionally calls
pci_wake_from_d3(pdev, false), clearing the PCI PME_En bit even when
wake-on-LAN has been configured. While aq_nic_shutdown() correctly
programs the NIC firmware via aq_nic_set_power() to listen for magic
packets, the PCI subsystem will not propagate the resulting PME wake
event from D3, so the system never wakes after poweroff.

WOL from suspend (S3) is unaffected because aq_suspend_common() does
not touch pci_wake_from_d3() and relies on the PM core's wake
configuration via device_may_wakeup().

This affects all atlantic-supported NICs (AQC107/108/111/112/113);
users have reported that WOL works if the atlantic driver is never
loaded, but breaks once it has run its shutdown path.

Pass the configured WOL state to pci_wake_from_d3() instead of a
literal false, so the PCI PME_En bit is preserved when the user has
armed WOL via ethtool.

Fixes: 90869ddfefeb ("net: aquantia: Implement pci shutdown callback")
Cc: stable@vger.kernel.org
Signed-off-by: Rex Bytes <goodboy@rexbytes.com>
---
 drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c b/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c
index baa5f8cc31f2..775cbbc1aa42 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c
@@ -374,7 +374,7 @@ static void aq_pci_shutdown(struct pci_dev *pdev)
 	pci_disable_device(pdev);
 
 	if (system_state == SYSTEM_POWER_OFF) {
-		pci_wake_from_d3(pdev, false);
+		pci_wake_from_d3(pdev, self->aq_hw->aq_nic_cfg->wol);
 		pci_set_power_state(pdev, PCI_D3hot);
 	}
 }
-- 
2.43.0


