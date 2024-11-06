Return-Path: <netdev+bounces-142339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E056B9BE57A
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 12:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F59E285AEA
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 11:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A5F1DE3AC;
	Wed,  6 Nov 2024 11:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlSG3EDq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C27B646;
	Wed,  6 Nov 2024 11:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730892328; cv=none; b=uIQSzNf/kNcDgn+OdSATz7BpR2YLiGKY466dmECi4UcXDpSPZWt/r++Ia+CDTtlMfqZ5qHVqUOqpHZjs9egF643Mmt0YxY0y1ri+Lx/OS3gRLOcdg/hU79KfAS3PenLlpkNgh3ifB0AnHCHKhn4A8AKuMlevmkN8ppU43QqOu64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730892328; c=relaxed/simple;
	bh=GVMNZrKHnqKRvmphZXkLgY/ueAMpsUn34Uncn1P0ILM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xf3TWr0CXVrYMtK2wP0OVqhyt5M98nv4HMNSfu/Bh7glBHULarKaYzehJYTD4s021456iJPlcNbWaG7GFl4QHUb/xw41IVEtFuV/DbAuxsDO7k6qMeJGy6nL9Kx5wbaRvQ8Bca1tAHc8t42a8CbXT3w7i/8DqLmY12dvmR7lsWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nlSG3EDq; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37d43a9bc03so4559174f8f.2;
        Wed, 06 Nov 2024 03:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730892325; x=1731497125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=91I/y3wjbBNWvrHPr3/8/6Qvv/qZ19kFsf+7A0QbbUc=;
        b=nlSG3EDqZBArmIyqz2cXFxv+/ov26gtqHGiHRDp8vZ9MIqKfRJjSQvve9kVECISmEx
         ayR9WjmbdbhB0husNg/mDi+hEjexCNGOtNg9bc1cqdf4DWmK9Pjdz0OBtLaKCwJKjdVW
         UfLmSQEmb8bvqdQxKM5uKqzVhknNLvSIfBo0SaE/Pw9ksR7EcauF6tcSS5h/pafEM+cG
         8OFThoTaoAz6GslemVyy4lGMxTfeUGnLt9zyWKFZ6nXRhrWao3y+lATio77O4gUjTgpl
         sTY8sdudSjw+uB9sXcZn/0uHhHicc1S0pBZRJPc2EPoitD1uEkktTc3LP/IAqfkuhzTL
         aMfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730892325; x=1731497125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=91I/y3wjbBNWvrHPr3/8/6Qvv/qZ19kFsf+7A0QbbUc=;
        b=HjqM9X90hn1gX7u+GAKgGcoNEYhTgOWgTQbMZcCmJM9T7Tib9K83IyUQZsKEKacvr2
         2cPaeCeNupXL/LgnPbHRi5E9dPL2jPb8fOP8yEKaHBP7TYdsb36aaFtT/M6QRyZZjwrt
         QAfy6hxvJMMuHmJSCd3LcQZdCxUi2XQaTCyLiN5XwcUEse78xqyk+coPeNF9eEIZJjL8
         g1r9/KRcwun8WYRM28FOQlhkwpgyEZ3GZoXcxBwerKzYK8VG7p2/KwsHwBQJTHZv+WqY
         CeEMLbNTM9A97N7pO2euvrb4BmdgujyUZiZbYBxbymBJNpsI9FoXOenDa/jgMo0fIi6T
         Kt9A==
X-Forwarded-Encrypted: i=1; AJvYcCU8ygEJR+B0lbtVV7Eg7l16kmvjluAMh+qBvigeWzDYxNNwj4JcMLwCrKFfISKd6m4NfG8I/p9LqtjaNc78FSs=@vger.kernel.org, AJvYcCWNp9TIbYUqaNjkVWM4A2hG9p33flXT7GIEygDuen3PuQkW3WM7R9pv6la88ewgXdahOAGr2ZtfHmxCKrRD@vger.kernel.org
X-Gm-Message-State: AOJu0YzyUo2zWu0dOAiay8fz7nyVNWaeyQnlpnd0Q+rg+5wa49swccIa
	hgO4fQKm1KnRWO6cGNl/YWNnqdnHqqOQTxElsSYtLSI/XnxgtPOy
X-Google-Smtp-Source: AGHT+IF+BajsbEorQUT96QOOZ7pdB5zvo3TNqjISc8k04NVfiqyVN0QicXWJNeNcuiC8p5fMg2piJg==
X-Received: by 2002:a05:6000:4027:b0:37d:4ebe:164a with SMTP id ffacd0b85a97d-381c7ac7704mr17052032f8f.50.1730892324575;
        Wed, 06 Nov 2024 03:25:24 -0800 (PST)
Received: from void.void ([31.210.177.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10d40casm18816533f8f.27.2024.11.06.03.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 03:25:24 -0800 (PST)
From: Andrew Kreimer <algonell@gmail.com>
To: Karsten Keil <isdn@linux-pingi.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Simon Horman <horms@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Andrew Kreimer <algonell@gmail.com>
Subject: [PATCH net-next v2] mISDN: Fix typos
Date: Wed,  6 Nov 2024 13:24:20 +0200
Message-ID: <20241106112513.9559-1-algonell@gmail.com>
X-Mailer: git-send-email 2.47.0.229.g8f8d6eee53
In-Reply-To: <20241102134856.11322-1-algonell@gmail.com>
References: <20241102134856.11322-1-algonell@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos:
  - syncronized -> synchronized
  - interfacs -> interface
  - otherwhise -> otherwise
  - ony -> only
  - busses -> buses
  - maxinum -> maximum

Via codespell.

Reported-by: Simon Horman <horms@kernel.org>
Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
v1:
  - Fix typos in printk messages.
  - https://lore.kernel.org/netdev/20241102134856.11322-1-algonell@gmail.com/

v2:
  - Address all non-false-positive suggestions, including comments.
  - The syncronized ==> synchronized suggestions for struct hfc_multi were skipped.

 drivers/isdn/hardware/mISDN/hfcmulti.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/isdn/hardware/mISDN/hfcmulti.c b/drivers/isdn/hardware/mISDN/hfcmulti.c
index e5a483fd9ad8..45ff0e198f8f 100644
--- a/drivers/isdn/hardware/mISDN/hfcmulti.c
+++ b/drivers/isdn/hardware/mISDN/hfcmulti.c
@@ -25,8 +25,8 @@
  *	Bit 8     = 0x00100 = uLaw (instead of aLaw)
  *	Bit 9     = 0x00200 = Disable DTMF detect on all B-channels via hardware
  *	Bit 10    = spare
- *	Bit 11    = 0x00800 = Force PCM bus into slave mode. (otherwhise auto)
- * or   Bit 12    = 0x01000 = Force PCM bus into master mode. (otherwhise auto)
+ *	Bit 11    = 0x00800 = Force PCM bus into slave mode. (otherwise auto)
+ * or   Bit 12    = 0x01000 = Force PCM bus into master mode. (otherwise auto)
  *	Bit 13	  = spare
  *	Bit 14    = 0x04000 = Use external ram (128K)
  *	Bit 15    = 0x08000 = Use external ram (512K)
@@ -41,7 +41,7 @@
  * port: (optional or required for all ports on all installed cards)
  *	HFC-4S/HFC-8S only bits:
  *	Bit 0	  = 0x001 = Use master clock for this S/T interface
- *			    (ony once per chip).
+ *			    (only once per chip).
  *	Bit 1     = 0x002 = transmitter line setup (non capacitive mode)
  *			    Don't use this unless you know what you are doing!
  *	Bit 2     = 0x004 = Disable E-channel. (No E-channel processing)
@@ -82,7 +82,7 @@
  *	By default (0), the PCM bus id is 100 for the card that is PCM master.
  *	If multiple cards are PCM master (because they are not interconnected),
  *	each card with PCM master will have increasing PCM id.
- *	All PCM busses with the same ID are expected to be connected and have
+ *	All PCM buses with the same ID are expected to be connected and have
  *	common time slots slots.
  *	Only one chip of the PCM bus must be master, the others slave.
  *	-1 means no support of PCM bus not even.
@@ -930,7 +930,7 @@ hfcmulti_resync(struct hfc_multi *locked, struct hfc_multi *newmaster, int rm)
 	if (newmaster) {
 		hc = newmaster;
 		if (debug & DEBUG_HFCMULTI_PLXSD)
-			printk(KERN_DEBUG "id=%d (0x%p) = syncronized with "
+			printk(KERN_DEBUG "id=%d (0x%p) = synchronized with "
 			       "interface.\n", hc->id, hc);
 		/* Enable new sync master */
 		plx_acc_32 = hc->plx_membase + PLX_GPIOC;
@@ -949,7 +949,7 @@ hfcmulti_resync(struct hfc_multi *locked, struct hfc_multi *newmaster, int rm)
 			hc = pcmmaster;
 			if (debug & DEBUG_HFCMULTI_PLXSD)
 				printk(KERN_DEBUG
-				       "id=%d (0x%p) = PCM master syncronized "
+				       "id=%d (0x%p) = PCM master synchronized "
 				       "with QUARTZ\n", hc->id, hc);
 			if (hc->ctype == HFC_TYPE_E1) {
 				/* Use the crystal clock for the PCM
@@ -2001,7 +2001,7 @@ hfcmulti_tx(struct hfc_multi *hc, int ch)
 	if (Zspace <= 0)
 		Zspace += hc->Zlen;
 	Zspace -= 4; /* keep not too full, so pointers will not overrun */
-	/* fill transparent data only to maxinum transparent load (minus 4) */
+	/* fill transparent data only to maximum transparent load (minus 4) */
 	if (bch && test_bit(FLG_TRANSPARENT, &bch->Flags))
 		Zspace = Zspace - hc->Zlen + hc->max_trans;
 	if (Zspace <= 0) /* no space of 4 bytes */
@@ -4672,7 +4672,7 @@ init_e1_port_hw(struct hfc_multi *hc, struct hm_map *m)
 			if (debug & DEBUG_HFCMULTI_INIT)
 				printk(KERN_DEBUG
 				       "%s: PORT set optical "
-				       "interfacs: card(%d) "
+				       "interface: card(%d) "
 				       "port(%d)\n",
 				       __func__,
 				       HFC_cnt + 1, 1);

Interdiff against v1:
  diff --git a/drivers/isdn/hardware/mISDN/hfcmulti.c b/drivers/isdn/hardware/mISDN/hfcmulti.c
  index f3af73ea34ae..45ff0e198f8f 100644
  --- a/drivers/isdn/hardware/mISDN/hfcmulti.c
  +++ b/drivers/isdn/hardware/mISDN/hfcmulti.c
  @@ -25,8 +25,8 @@
    *	Bit 8     = 0x00100 = uLaw (instead of aLaw)
    *	Bit 9     = 0x00200 = Disable DTMF detect on all B-channels via hardware
    *	Bit 10    = spare
  - *	Bit 11    = 0x00800 = Force PCM bus into slave mode. (otherwhise auto)
  - * or   Bit 12    = 0x01000 = Force PCM bus into master mode. (otherwhise auto)
  + *	Bit 11    = 0x00800 = Force PCM bus into slave mode. (otherwise auto)
  + * or   Bit 12    = 0x01000 = Force PCM bus into master mode. (otherwise auto)
    *	Bit 13	  = spare
    *	Bit 14    = 0x04000 = Use external ram (128K)
    *	Bit 15    = 0x08000 = Use external ram (512K)
  @@ -41,7 +41,7 @@
    * port: (optional or required for all ports on all installed cards)
    *	HFC-4S/HFC-8S only bits:
    *	Bit 0	  = 0x001 = Use master clock for this S/T interface
  - *			    (ony once per chip).
  + *			    (only once per chip).
    *	Bit 1     = 0x002 = transmitter line setup (non capacitive mode)
    *			    Don't use this unless you know what you are doing!
    *	Bit 2     = 0x004 = Disable E-channel. (No E-channel processing)
  @@ -82,7 +82,7 @@
    *	By default (0), the PCM bus id is 100 for the card that is PCM master.
    *	If multiple cards are PCM master (because they are not interconnected),
    *	each card with PCM master will have increasing PCM id.
  - *	All PCM busses with the same ID are expected to be connected and have
  + *	All PCM buses with the same ID are expected to be connected and have
    *	common time slots slots.
    *	Only one chip of the PCM bus must be master, the others slave.
    *	-1 means no support of PCM bus not even.
  @@ -2001,7 +2001,7 @@ hfcmulti_tx(struct hfc_multi *hc, int ch)
   	if (Zspace <= 0)
   		Zspace += hc->Zlen;
   	Zspace -= 4; /* keep not too full, so pointers will not overrun */
  -	/* fill transparent data only to maxinum transparent load (minus 4) */
  +	/* fill transparent data only to maximum transparent load (minus 4) */
   	if (bch && test_bit(FLG_TRANSPARENT, &bch->Flags))
   		Zspace = Zspace - hc->Zlen + hc->max_trans;
   	if (Zspace <= 0) /* no space of 4 bytes */

Range-diff against v1:
1:  e27df5ca2655 ! 1:  69784b0d548a mISDN: Fix typos
    @@ Commit message
         mISDN: Fix typos
     
         Fix typos:
    -      - syncronized -> synchronized.
    -      - interfacs -> interface.
    +      - syncronized -> synchronized
    +      - interfacs -> interface
    +      - otherwhise -> otherwise
    +      - ony -> only
    +      - busses -> buses
    +      - maxinum -> maximum
     
    +    Via codespell.
    +
    +    Reported-by: Simon Horman <horms@kernel.org>
         Signed-off-by: Andrew Kreimer <algonell@gmail.com>
     
      ## drivers/isdn/hardware/mISDN/hfcmulti.c ##
    +@@
    +  *	Bit 8     = 0x00100 = uLaw (instead of aLaw)
    +  *	Bit 9     = 0x00200 = Disable DTMF detect on all B-channels via hardware
    +  *	Bit 10    = spare
    +- *	Bit 11    = 0x00800 = Force PCM bus into slave mode. (otherwhise auto)
    +- * or   Bit 12    = 0x01000 = Force PCM bus into master mode. (otherwhise auto)
    ++ *	Bit 11    = 0x00800 = Force PCM bus into slave mode. (otherwise auto)
    ++ * or   Bit 12    = 0x01000 = Force PCM bus into master mode. (otherwise auto)
    +  *	Bit 13	  = spare
    +  *	Bit 14    = 0x04000 = Use external ram (128K)
    +  *	Bit 15    = 0x08000 = Use external ram (512K)
    +@@
    +  * port: (optional or required for all ports on all installed cards)
    +  *	HFC-4S/HFC-8S only bits:
    +  *	Bit 0	  = 0x001 = Use master clock for this S/T interface
    +- *			    (ony once per chip).
    ++ *			    (only once per chip).
    +  *	Bit 1     = 0x002 = transmitter line setup (non capacitive mode)
    +  *			    Don't use this unless you know what you are doing!
    +  *	Bit 2     = 0x004 = Disable E-channel. (No E-channel processing)
    +@@
    +  *	By default (0), the PCM bus id is 100 for the card that is PCM master.
    +  *	If multiple cards are PCM master (because they are not interconnected),
    +  *	each card with PCM master will have increasing PCM id.
    +- *	All PCM busses with the same ID are expected to be connected and have
    ++ *	All PCM buses with the same ID are expected to be connected and have
    +  *	common time slots slots.
    +  *	Only one chip of the PCM bus must be master, the others slave.
    +  *	-1 means no support of PCM bus not even.
     @@ drivers/isdn/hardware/mISDN/hfcmulti.c: hfcmulti_resync(struct hfc_multi *locked, struct hfc_multi *newmaster, int rm)
      	if (newmaster) {
      		hc = newmaster;
    @@ drivers/isdn/hardware/mISDN/hfcmulti.c: hfcmulti_resync(struct hfc_multi *locked
      				       "with QUARTZ\n", hc->id, hc);
      			if (hc->ctype == HFC_TYPE_E1) {
      				/* Use the crystal clock for the PCM
    +@@ drivers/isdn/hardware/mISDN/hfcmulti.c: hfcmulti_tx(struct hfc_multi *hc, int ch)
    + 	if (Zspace <= 0)
    + 		Zspace += hc->Zlen;
    + 	Zspace -= 4; /* keep not too full, so pointers will not overrun */
    +-	/* fill transparent data only to maxinum transparent load (minus 4) */
    ++	/* fill transparent data only to maximum transparent load (minus 4) */
    + 	if (bch && test_bit(FLG_TRANSPARENT, &bch->Flags))
    + 		Zspace = Zspace - hc->Zlen + hc->max_trans;
    + 	if (Zspace <= 0) /* no space of 4 bytes */
     @@ drivers/isdn/hardware/mISDN/hfcmulti.c: init_e1_port_hw(struct hfc_multi *hc, struct hm_map *m)
      			if (debug & DEBUG_HFCMULTI_INIT)
      				printk(KERN_DEBUG
-- 
2.47.0.229.g8f8d6eee53


