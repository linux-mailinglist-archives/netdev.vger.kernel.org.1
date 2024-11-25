Return-Path: <netdev+bounces-147218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 075669D83F4
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 12:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B59A168D04
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 11:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16F21922D3;
	Mon, 25 Nov 2024 11:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dqZUGAlR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4DA15383D
	for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 11:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732532416; cv=none; b=S/nPkfkTKR5AC91Ed8Iqp2mhgl2LhSWAay+lc8K9n4mDnZaMp0wsYGDstEDplXbAhu+YIwz9pBTuIQqmyAH+EFhHgTWWGfVXZUN3Ejw6dAXH4POt4vnFgn8BJwg3doj/wm0y/SLaJJur5RRVNIAB3tOV7Ml4NpA4SbbqVfPy+i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732532416; c=relaxed/simple;
	bh=3d6UyV6U+9wQgJBtBnwExDF3o1uhmm9VscgFbOGYwg8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MihMiVYaz95f+9o6aH2pRTjkR8rPwriiXaBpyD3VN8IkQz8QB6WlVns6vPGVXhgi9eCrm1e4DmZldgtMXo89Ttd320LudGukI/QvTYc66NEG4lB/3t5r80IvB+ABNWwwiBqRDGWeQF0E8TFNQcRxMzw5JPUYPfWX+dl2BaFOqmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dqZUGAlR; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ea1c453f0eso3381001a91.1
        for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 03:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1732532414; x=1733137214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=96MYJ9KaXB4pjcRmFCY5IfRMfIhiUGPcMDlrjury5qo=;
        b=dqZUGAlRbYKvTi695nIRKxRxhCH/LhL+AG6JjwQAWm3rRgB0s8KBZ2Qk57/XODM+Zd
         N7PVw+59jfEV/dKchD2A9BOQF9O1XypM9kEfEtNGikA63C0iU6R0GUroifO89i6/3jzm
         7xSA8mhyLQMZMsYwqLSLfPgcTncqNlnXF7KY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732532414; x=1733137214;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=96MYJ9KaXB4pjcRmFCY5IfRMfIhiUGPcMDlrjury5qo=;
        b=nMq536bll4r4Jh4UufleCz6pOnJBb50iHcRCBjbBvGH38Div6zEPpi5pZoBs76/OL5
         b6MrgTfAHky9t4pRez/ytmrbZzDCZyg4Ot5uI1gtU2lg43sgGbIMfARKsO2gBlpajh+7
         VhnAWdvxQNPIrjAD3OwfOUXYq1mfKoe6AhiLBlVALtMgmVF1V98AJxnlq+BP/mQDhkzV
         0QOgu9EqvYc2+h4CwtefZ4aZrI2XhTjmMB3zup2UCgZVzVRDI6AfY7lLzdU9piFsqW8t
         V30LY8i+4H12lSAwVcEgOphWujlt7LqkOmWxPqNp6TKj6uVF4IFK63PjqB7UEkyE3jc2
         EKLw==
X-Forwarded-Encrypted: i=1; AJvYcCXuHflna5rntSx6oiRlaVBasS6Mxh9XlEV8bOMw5rJ4UgsS4YT9URJ7/gtKOIzuDkx4tB3oQag=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJSKJ+67IE1cJqfhg0v9p6SsoC516UwoVAXA4Xjbt/tJtBPrVY
	3Oi3goiee5N+AbeiH3TzSz8qw8/hmUMkl22PNhMJ2V5kqhmWKvQLpyJGOiIfe6bribbHjRg1lRs
	=
X-Gm-Gg: ASbGncvGmUrsQ4D4ny0j36b1PpT+uejQj5H2pTGOpgYpA/Y06x6U6MV46/7tes80+om
	ebypetU9vSUwk5CXxi29x+n8wN4Dz0mQAdfAoWTb1EqtRrY8K02FvI/6ZEGzn3PNHCuCmVrNHnR
	C3uvqgz0NvZQ/VnJjJen2DADLquZSYjppA/I09yAq3b8WRHeHFoPYagUA2jw8UftV6N/NljhDjM
	YJPd406jTREV8UeBZx0rfO2p/bRnT+kOUXODCuiX9qTPhBuuiEk2v4+u6V9MoUStwP+JkNEZz5x
	aqo=
X-Google-Smtp-Source: AGHT+IGOFYLZpRNxLdZHD1TVQKl4mUNs8aee25A9C8cycK7Rs+PtYbJTRnxLEvS3pDQwf57usVWQww==
X-Received: by 2002:a17:90b:180f:b0:2ea:696d:7341 with SMTP id 98e67ed59e1d1-2eb0e527de1mr13709469a91.22.1732532414441;
        Mon, 25 Nov 2024 03:00:14 -0800 (PST)
Received: from photon-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ead04fbcd7sm9972779a91.53.2024.11.25.03.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 03:00:13 -0800 (PST)
From: Ajay Kaher <ajay.kaher@broadcom.com>
To: richardcochran@gmail.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	nick.shi@broadcom.com,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	florian.fainelli@broadcom.com
Subject: [PATCH]  ptp: Add error handling for adjfine callback in ptp_clock_adjtime
Date: Mon, 25 Nov 2024 10:59:54 +0000
Message-Id: <20241125105954.1509971-1-ajay.kaher@broadcom.com>
X-Mailer: git-send-email 2.39.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ptp_clock_adjtime sets ptp->dialed_frequency even when adjfine
callback returns an error. This causes subsequent reads to return
an incorrect value.

Fix this by adding error check before ptp->dialed_frequency is set.

Fixes: 39a8cbd9ca05 ("ptp: remember the adjusted frequency")
Signed-off-by: Ajay Kaher <ajay.kaher@broadcom.com>
---
 drivers/ptp/ptp_clock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index c56cd0f..77a36e7 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -150,7 +150,8 @@ static int ptp_clock_adjtime(struct posix_clock *pc, struct __kernel_timex *tx)
 		if (ppb > ops->max_adj || ppb < -ops->max_adj)
 			return -ERANGE;
 		err = ops->adjfine(ops, tx->freq);
-		ptp->dialed_frequency = tx->freq;
+		if (!err)
+			ptp->dialed_frequency = tx->freq;
 	} else if (tx->modes & ADJ_OFFSET) {
 		if (ops->adjphase) {
 			s32 max_phase_adj = ops->getmaxphase(ops);
-- 
2.39.4


