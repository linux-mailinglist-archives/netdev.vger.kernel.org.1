Return-Path: <netdev+bounces-140735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE7B9B7C27
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 14:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6FB228269B
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 13:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F6619F105;
	Thu, 31 Oct 2024 13:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WbFX9ihm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4B019E98E;
	Thu, 31 Oct 2024 13:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730382648; cv=none; b=L/343AnlHLuXm/V6rAYeLSrKQCQmMOGJ2VJ4ziMHi5d00IHdxe+0ID3GaLfk3Ac6vqo97CeZ92Lg5OAwyyI6eJdbEy0YumcNZCuPNcuCHngJz9YbdzFm+lZumIER06hDqAP4kbpsP+gZJzuc1zpJK5iZczS1litijsRJtFaCDps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730382648; c=relaxed/simple;
	bh=BMVTcutHhu+6ZQGryNtLyz86LcuO3vePR57Y+9HCDkE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=pTAsU7QBIAF0x3zHYaxfXBJHfr2QcYcH+7ED4kehjji8BtR9UbWpL67xrdmV4uOH6XfzhkZ8sJMuLwrzLOIfONncbG0t1YENE1ymyLev6HgchwBM9R2clDSMWhKhN4vTA9M+CLvrfnfThNURIftm2058pqy2eFPxuhV5o6hULEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WbFX9ihm; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43163667f0eso7973645e9.0;
        Thu, 31 Oct 2024 06:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730382644; x=1730987444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UVhYO33vVqCBdciqa+kZPbAFcZzbjS6IKLArecWVdrs=;
        b=WbFX9ihmlK8yiAvT/pYuAyDRPRFRC1Vn1hhSQ+/2yZh1mMinek6wj6CkYJsmiNpPCB
         lyYRdsVS2rkDW4odoZeSzgax/Xavkd49fVqTZji7vFSma+6gNPIkerkE8v07whI3Bkiz
         rT0RIKlTtXSrK+Uo1+rfbV/0givcwotI9GOMjeRqlV6QVJ5bCyXTWlujDPFFrXEea0Cw
         +4N6Unha+dGn7G5ubCja21M7maO9cTk9uATXjHEZQaGjFPqOrIi9nmQvevkKg39JieCK
         DmgevlhyWol3MFARJYWVnyJP3qopPXpHG0fgEQ0N58eRWBmDbgcqGtFxrow95Jcakcev
         45kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730382644; x=1730987444;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UVhYO33vVqCBdciqa+kZPbAFcZzbjS6IKLArecWVdrs=;
        b=MvO9VIa19J4KqKrR0wyc+KdhRduPd/DwnaapGLAL0blo6NLw5pxkI5AARofrb5YYfE
         ZUL2DE2BsO7pqoL4leC2KgUfMqZoAi/qfiQfznRLWGZOYceSICSca5PzPsK3SGKvZXnA
         Lu5jsrBWwMe0HfJ9sPxQrm09/MjU+Q9Ax7s5ZuH2AgUI3OWYlcI5SNLhCCYkTAkD2jIQ
         0KNQNTUONUS0oO4bT8oexIyUuaf0Eop2otUDTpGF2Zqa+/f5uLr+rhIaVFglJTdvhmR5
         Jv8B13fx4fNsx/v6JFET/cH8HtW9WlqcOcWDsfHr7PNMxVI54CcNwrjY7UWKLyQHIY/r
         54aA==
X-Forwarded-Encrypted: i=1; AJvYcCV/jdNIPOnZuqtv/FECU0OO0YtDcE/qdzo2Ut7UGlj+WY+rfoYUYM5daWjcqsySmdnjYI2s1s+5EpOQUFs=@vger.kernel.org, AJvYcCVL10qd3qevYqz1J+Uc2Ith0WOZFPIZ3xVuH8BKQNut82vF6/7yPCaV/sjIrisw2vt5HLpy8tuR@vger.kernel.org
X-Gm-Message-State: AOJu0YwXGYPOMENIosfduv3yalKPr0/+4hAUtuzAZZjFAUeql3Zd0P5n
	sE8B6lPJ+5qOLyScJBEGGLqJQqB0Vdo+Uef75P3JQz8TLY4B/ST+
X-Google-Smtp-Source: AGHT+IECcaSiBC7aXgNY1F0gkPYapD18wbQsdxVx/0i2rpGtbk3yjipiZw0BjGDrX5iSplBMT8GKtQ==
X-Received: by 2002:a7b:c5cc:0:b0:431:52a3:d9ea with SMTP id 5b1f17b1804b1-431aa80275cmr119037755e9.0.1730382644164;
        Thu, 31 Oct 2024 06:50:44 -0700 (PDT)
Received: from localhost ([194.120.133.65])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d5e8562sm27143775e9.23.2024.10.31.06.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 06:50:43 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Richard Cochran <richardcochran@gmail.com>,
	netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] ptp: fc3: remove redundant check on variable ret
Date: Thu, 31 Oct 2024 13:50:42 +0000
Message-Id: <20241031135042.3250614-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The check on ret has already been performed a few statements earlier
and ret has not been re-assigned and so the re-checking is redundant.
Clean up the code by removing the redundant check.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/ptp/ptp_fc3.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/ptp/ptp_fc3.c b/drivers/ptp/ptp_fc3.c
index e14e149b746e..879b82f03535 100644
--- a/drivers/ptp/ptp_fc3.c
+++ b/drivers/ptp/ptp_fc3.c
@@ -986,11 +986,6 @@ static int idtfc3_probe(struct platform_device *pdev)
 
 	mutex_unlock(idtfc3->lock);
 
-	if (err) {
-		ptp_clock_unregister(idtfc3->ptp_clock);
-		return err;
-	}
-
 	platform_set_drvdata(pdev, idtfc3);
 
 	return 0;
-- 
2.39.5


