Return-Path: <netdev+bounces-216690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E15EB34F56
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 00:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEF5C1892D54
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 22:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CA02C159C;
	Mon, 25 Aug 2025 22:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5Mq7LlN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E938D2C17A3
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 22:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756162570; cv=none; b=sEvHmzzl03yNMYeYaOKsV1nD1/i3Of9g6uf9nOQM6Y0echfOsGbRAFkBgMbon/lmRiNcyxGyLpEUe+8h3MlBU+VoTDNnzX2K8nJ3f716eAYXM8518+risI4KG3OBe7/SIeHiM+k+tuXppPcXqPrCr8DzE6mEL9l6klDh5RicC4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756162570; c=relaxed/simple;
	bh=jWZ7XtizWgiD2zafAB5ADiLXmZI+6Hcpecl9/5WZXrQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aRxVCM9JCcgwZ5Y6YvbIe+w7w/1ebEDuYfNxPFHa0wxLhKdY0+ZXvzru2L9L5sJX3xmsGhhZ8/ihgrgwKACAYT1WUdjOGnIjtHJTT5J9zBjbm70hd/YPJwizLZut04uzjDtlIjHRc3t3eokzCqGcfERp9wbrEDBQ8RPOpZzPgxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J5Mq7LlN; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-24646202152so35604995ad.0
        for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 15:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756162568; x=1756767368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sM9Xyu7WHRa17NffQIei68nhoWgoNc/3QpCcsZW1UMM=;
        b=J5Mq7LlNjJrR2HNIdOgdWKfIaqDuD9/Xmas3uHIzbIRDy25Z0qdzVP9lATv3E8BUQm
         iF4AKCW1QGxRQIrbBYjVa8TRBSQZUkSjWZhXQwLFTTxa/GP+OA/jPvgNES1oZFNdbcoF
         gYWjb7A9Pj9e0Vi6ewEAnb37hgbRToLUOoDbhNUJ9NqnqOx0/ErcMoV7B87tHbIRjOEt
         a1tC792tYBA08O+kQcssAcgRArHadrOb472lYx6nATdN3S87e0i3pytSLZ58+LydvTVw
         2NxDOrwbcuRS+opWWPlZgmQYiin8uQ4QUw4w5RlajcTc96POuzE9xuG7zBeooL0jSjlW
         QJ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756162568; x=1756767368;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sM9Xyu7WHRa17NffQIei68nhoWgoNc/3QpCcsZW1UMM=;
        b=qtK7+a/WaaJrSmFLcEF3oEc1M/ZNKdzwyecQ7ZxqxZS2wquLdTXelxpRSF52mb/2Fn
         uivLtBxWmRqAe+MlmG6bkBUix3QaqRUt0EPVNtf5adlreGaglMTzN4snpYbHzYniXeSc
         A6Us3JBBUKpgc/eu4Brfr9vSCpiyVNr/5SDwyqjtz8IUBdSV6c1zIcxxo0u2SQd+oUFd
         CwwS60aya12ITQxk06OBNDoKMuu8wVKesC3/ENiMPAAhee+M7zVl56Q/CNn8f7df3BGx
         8aYgdMVasoSuKl5vj1/4lJEB0I+vkA7jTqw9SVSo6PVHWAFD7Pk1le+0dDFVjeclHhVj
         QiJw==
X-Forwarded-Encrypted: i=1; AJvYcCVO/+h+7BKE/WMi4dEaiQh4n7+54q9HhGppu1eCqg/IAbwYhYfGCBkCoMxyEvfMMYd70u4M5MA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys5HrJwUQwMxR2/47TgDI1H2VZCHv9qa+NvuHE6Dm7RWyl1R85
	1C+YUpfPbopkyFum6XwGauXmqlDp52PHHxKCW2n2xLEMUMmxL/1NU4ZC
X-Gm-Gg: ASbGncvS/QUrGWE7/CHHKvjJEkxDr1AHZCeGBSBiJMhyAT3Gdz1Xr93BSSjwo1AlxHq
	0GxVwGsT1mWuPq+rJ3OhF3fSxaqQ2bbyCvK6nNT1HXZJB/5VTEAC6J9zo4l7gNEFhWV+57qIJx7
	kM6bNGpxiA+2QVJl2vWXqNaqT4fW03H4yH6U5r8mKbbFSQrxdsJxObKlFyqIplAY9uKWaTBHNFb
	OxBU/mn0lrPSh0eyH3mJ9YAVj9kfq53+YqLHTPPWQNVOUB17SClCwJF9tu3MUBgHEsvuuQy0DwS
	jKf1zzTBONsYuGfl/HscmtHkNGRhKdoG3xZVllOkirBX1TGdSuBmY6YBBQyLQi++SFClJxiWFe9
	Xnj0WYkoW2cLvQrdYl9zIJEjytYghuO+Oz6GofGSLsOzv5xYUrZw=
X-Google-Smtp-Source: AGHT+IEL+R3HIAqF0IOJyotOvzE2U6NiJHe9YsdgWN72TTRseWMVceGWJeUiB+eVnj6l2zXMr8aZtg==
X-Received: by 2002:a17:903:943:b0:242:fb32:a51b with SMTP id d9443c01a7336-2462ee5b26fmr197409335ad.19.1756162568005;
        Mon, 25 Aug 2025 15:56:08 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([98.97.40.123])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687cc38asm78470445ad.67.2025.08.25.15.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 15:56:07 -0700 (PDT)
Subject: [net PATCH 1/2] fbnic: Fixup rtnl_lock and devl_lock handling related
 to mailbox code
From: Alexander Duyck <alexander.duyck@gmail.com>
To: AlexanderDuyck@gmail.com, netdev@vger.kernel.org
Cc: kuba@kernel.org, kernel-team@meta.com, andrew+netdev@lunn.ch,
 pabeni@redhat.com, davem@davemloft.net
Date: Mon, 25 Aug 2025 15:56:06 -0700
Message-ID: 
 <175616256667.1963577.5543500806256052549.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <175616242563.1963577.7257712519613275567.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <175616242563.1963577.7257712519613275567.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Alexander Duyck <alexanderduyck@fb.com>

The exception handling path for the __fbnic_pm_resume function had a bug in
that it was taking the devlink lock and then exiting to exception handling
instead of waiting until after it released the lock to do so. In order to
handle that I am swapping the placement of the unlock and the exception
handling jump to label so that we don't trigger a deadlock by holding the
lock longer than we need to.

In addition this change applies the same ordering to the rtnl_lock/unlock
calls in the same function as it should make the code easier to follow if
it adheres to a consistent pattern.

Fixes: 82534f446daa ("eth: fbnic: Add devlink dev flash support")
Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
index b70e4cadb37b..a7784deea88f 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
@@ -443,11 +443,10 @@ static int __fbnic_pm_resume(struct device *dev)
 
 	/* Re-enable mailbox */
 	err = fbnic_fw_request_mbx(fbd);
+	devl_unlock(priv_to_devlink(fbd));
 	if (err)
 		goto err_free_irqs;
 
-	devl_unlock(priv_to_devlink(fbd));
-
 	/* Only send log history if log buffer is empty to prevent duplicate
 	 * log entries.
 	 */
@@ -464,20 +463,20 @@ static int __fbnic_pm_resume(struct device *dev)
 
 	rtnl_lock();
 
-	if (netif_running(netdev)) {
+	if (netif_running(netdev))
 		err = __fbnic_open(fbn);
-		if (err)
-			goto err_free_mbx;
-	}
 
 	rtnl_unlock();
+	if (err)
+		goto err_free_mbx;
 
 	return 0;
 err_free_mbx:
 	fbnic_fw_log_disable(fbd);
 
-	rtnl_unlock();
+	devl_lock(priv_to_devlink(fbd));
 	fbnic_fw_free_mbx(fbd);
+	devl_unlock(priv_to_devlink(fbd));
 err_free_irqs:
 	fbnic_free_irqs(fbd);
 err_invalidate_uc_addr:



