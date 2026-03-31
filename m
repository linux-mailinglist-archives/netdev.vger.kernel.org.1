Return-Path: <netdev+bounces-273568-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJ/LFMymy2nJJwYAu9opvQ
	(envelope-from <netdev+bounces-273568-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 12:49:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B1018368516
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 12:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 066D7300F963
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 10:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72F53A9636;
	Tue, 31 Mar 2026 10:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RcWIFQnO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB763A784E
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 10:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774953815; cv=none; b=HsnsjsZxQC0y2rdIXiN3FKNGK24RXWuKhkhW0lxDallsK3GXuHP8IYmyv/9n7K1Y3WyUKHIaaQ5L0qyg/KCcLsxWBTFiV5aFwcaDaqZN2LnelK4WpxefK8UAiHYssfq8Px893TfB5zo/PdMLGRrgZsVq0EI3miCxSGdy9Hl1lSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774953815; c=relaxed/simple;
	bh=dIF9LGfHPVm5F3OXITYoZI5TV/lax4njs89oIShXWwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oA0Jh9QMd6aEY+5VLO4bL8By2nw1kib/RHgK4KR/aPUr3VfyH2rHWb/LvOO1Ltac6QiuTXL6zpFjKA2iusow4CJ0Iujq0qu8Dxh5b64a8Xl1cBw4hx3JGTSjGbC/v7qJkxsCKvLQVHgOx2uAGH65a+cvseFxyZZMTeHPsagyitk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RcWIFQnO; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-829afe24fb5so3835019b3a.0
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 03:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774953814; x=1775558614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I1a10m3pLXA3wRfYM8rz+VnsqAqaaOO8EqeoT5jwSGY=;
        b=RcWIFQnOP8msHEYlG74DnQtpblJFJcTwg8gT03SOKyYeCuIk/bn4W28iRPhmhpXQjf
         bu9BK+vNPa8gObsYPAzOoOyj8WDpNLITghIC2RgH/JO2OnEYyMnH9BwlQXXcUEveB14D
         AC1EIrmuXUJeSRz/GDJcjkzKlQRs6GBx/Xigz5XoVTKSyURPxuT5Z5Ua/GrPqu3X39/f
         m1PSS9YldbBiiD6KDXAFJQNIe/xWYf7srJ04ANtA33nprBFgYLIFy0ZFaCD/BpQpa7Yd
         /QcSDXL9DYfpMbwZQQ4Cg5t8W28YtvfocIteCf1LiNQSEb8AE9MHLlp8AZHTDaLQrIoi
         gWpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774953814; x=1775558614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I1a10m3pLXA3wRfYM8rz+VnsqAqaaOO8EqeoT5jwSGY=;
        b=bw+dSj/XKOGXS5npSS8bsumeAAVh1VBKm8Hnplj6dqU+3ZwLih3ucjNrTkYgpMFGtp
         BtTvsySdsJr3WkvVZyPnNd7KdY8co6vzUKlr7S/l6SAQIOB24RGZ95B+yRok3AKZTXGw
         fX8b0A6TW4xSBw0yLOaaEBjWut3azbh1aMFPBXc9tUkWWHwKFOP91FA+gzcs7ig86sLk
         AuVW3BkOV+U3BLcp9WEBfG86+OH0ek0swXNVvJnv1uO8140M4o0eOWdWiKGQQbx3gpZh
         URnW8yt6YilnTZzLj3U3IXxIVVAXM1Cy+Gb0SCSUcjrQflJuTISGQ7C000tRS1CO2ohP
         IdPA==
X-Forwarded-Encrypted: i=1; AJvYcCU7dgn9y21TgQe5MI0f/GDCTMiY6s+A1E4+TBizj37VeIo6UjR+9TbDWeEVxhixPmt0d8vKbjc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJXoEZOy3SLdlyIVIt4I/Kozi+gURvay83M8cWEaMtwPmyKXGt
	1nc5HNTSujBF1qgRfR9xsXq0tXxskP4agBZj47MN0OiZ2S5u3cmxTMPs
X-Gm-Gg: ATEYQzxZLyVjpy4Jn/lvEmcZHHaasNBtQjTgJxTlwr8Gcq+q7oOnJNZgsjSTrrbIoMI
	OzH3E+6iPtwCsyrIaFBVHE0ypHneo8fi9/X1fJjkmRSdcQ8anKi+ZuX3QwfT3V9FvAPSmts7ruC
	q3pIctCa2DZMSlHuY1mHbzk8ef9h978ZPa3hAM2YlgVkm62hshG52PkjQO1B4/XpDNSd27cHcSC
	274vmBVcSqF2+NgwGxss4t7yHp30ehfEv8gshYPkviPrKqkvcxbQhbg+zUjkMZAOPkE6gWEG/i0
	yeebfC9z/1Bhwpyw3qapRsbDUj6w9yVLFu3Es6CVRXW2+aDFpu2iOwAOgcTr0LsTn+21EwNW0ql
	4ecjaTrDHsWp9FCyQOBk0Ym39e4E71QEA1i8Ag+TMsiGQsJ6982JpU/gbtUAiNF8E9Q0i1K/o/k
	LWFQJoOShw4CsMzMW0LlSO2heMdbKV3xlJhh3Z1K315AMNcNapSWRd01shAqOa7qGYaaQjfSwWv
	troqm038kKa5BXZxNV7O+XoNhgRtS/KjKOc9DCkldfaN8va678WQ4zUIw==
X-Received: by 2002:a05:6a00:2da9:b0:829:7553:afbe with SMTP id d2e1a72fcca58-82c96086c7fmr14819397b3a.57.1774953813791;
        Tue, 31 Mar 2026 03:43:33 -0700 (PDT)
Received: from ip-10-1-46-91.ap-northeast-1.compute.internal (ec2-176-32-72-196.ap-northeast-1.compute.amazonaws.com. [176.32.72.196])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca85fc72asm9996026b3a.48.2026.03.31.03.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 03:43:33 -0700 (PDT)
From: Daiki Harada <daiky0325@gmail.com>
To: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Daiki Harada <daiky0325@gmail.com>,
	Kohei Enju <kohei@enjuk.jp>
Subject: [PATCH iwl-next v1 1/2] igb: use napi_schedule_irqoff() instead of napi_schedule()
Date: Tue, 31 Mar 2026 10:39:19 +0000
Message-ID: <20260331103924.36422-2-daiky0325@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331103924.36422-1-daiky0325@gmail.com>
References: <20260331103924.36422-1-daiky0325@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,enjuk.jp];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-273568-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daiky0325@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[enjuk.jp:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B1018368516
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Replace napi_schedule() with napi_schedule_irqoff() 
in the interrupt handler path in igb driver

Tested on QEMU with igb NIC emulation (-nic user,model=igb)

Suggested-by: Kohei Enju <kohei@enjuk.jp>
Signed-off-by: Daiki Harada <daiky0325@gmail.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index ee99fd8fd513..d7a6ae938cc5 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -7158,7 +7158,7 @@ static irqreturn_t igb_msix_ring(int irq, void *data)
 	/* Write the ITR value calculated from the previous interrupt. */
 	igb_write_itr(q_vector);
 
-	napi_schedule(&q_vector->napi);
+	napi_schedule_irqoff(&q_vector->napi);
 
 	return IRQ_HANDLED;
 }
@@ -8199,7 +8199,7 @@ static irqreturn_t igb_intr_msi(int irq, void *data)
 	if (icr & E1000_ICR_TS)
 		igb_tsync_interrupt(adapter);
 
-	napi_schedule(&q_vector->napi);
+	napi_schedule_irqoff(&q_vector->napi);
 
 	return IRQ_HANDLED;
 }
@@ -8245,7 +8245,7 @@ static irqreturn_t igb_intr(int irq, void *data)
 	if (icr & E1000_ICR_TS)
 		igb_tsync_interrupt(adapter);
 
-	napi_schedule(&q_vector->napi);
+	napi_schedule_irqoff(&q_vector->napi);
 
 	return IRQ_HANDLED;
 }
-- 
2.53.0


