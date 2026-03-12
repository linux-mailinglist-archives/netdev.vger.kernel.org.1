Return-Path: <netdev+bounces-267234-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDqwNrNTs2l8VAAAu9opvQ
	(envelope-from <netdev+bounces-267234-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 01:00:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E5127B627
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 01:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 08706301BD4F
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 00:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDDF320C490;
	Fri, 13 Mar 2026 00:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GrtCVVKc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCDA23EAB4
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 00:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773360046; cv=none; b=FVE2rF0wIx4MM9dqip07qSTx9S+aKUu8VQwTqmI5cjiqF2XvLVmI2Kbgj5W6+0f/mpJFhFhWFoVrG5wU6hvOgAJNTnLaYLz4nPMttdeZ2JLIJbIZXuKIyhAetcdBDQVSdfSDreAc3X1rdmU5xpSOGBmhP1RdxEOJMVu6tyfh/A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773360046; c=relaxed/simple;
	bh=unpDN0xSFAqZ7nYTSSNREqnY5W0AVi5GlC1hx8dlYz8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J+Kq18++EqvBSRZcc9RxOGbymxVBGU/4blQKPF1zE0qnSUZoHQPklYJcOa/Qx3HGYx8Wfcu3NsH1EVGyvYKLpWz2wJHQQ6bVR02whRUNQDONDGaAiaosRWY95gkk7n0ZrEkzjMee5CvGmsSkAXh7mTXrAO2fl2O6K5sp5MiL47Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GrtCVVKc; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4853aec185aso13974475e9.1
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 17:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773360044; x=1773964844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AyEWphJeNnvkPez3fZUAj2xNcAS8g8xQPq60zu8rPdc=;
        b=GrtCVVKctQjp4izWByIE1F8s/PkFOBazUIbH1vh9k6gqf82lIpl0n/xRqqESjMp1yx
         Od45g93ByURWI760PRyjkod9nd5MSQur4LJf2x0ORaAAmdM1GbWjkfgU1kYSvAGVVVPQ
         lLxjJMPTyCQZ2T45ESymWc3NmEsQgIGm/2VdbJEhnpq0SpMJDTzhw5LnPABs8DpS9x3m
         dqWkK9JLYjHrUXU/9ZiZ4f8ozfkXgM63WulPJ27ECqGCUJ0nhCLeSfdE6QUSBSlCx6xF
         wMddfWEXj5q+pSKEeRrpRhX9yqyOGmIyySVwI34vuGn/UA/cTowJn5Eou5orOYKef+ss
         7RNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773360044; x=1773964844;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AyEWphJeNnvkPez3fZUAj2xNcAS8g8xQPq60zu8rPdc=;
        b=gsyBtQoDxVhwIdIuSzZaSEXDTi8IandhgpjCiYaE5FOrBcerv1aNHPLnaPQ/iS+yPu
         xqKes/1+1ZFYa0kOOkX4H86Io5kwhmr7q3OFQCmFOVPrjr3ZyB5S4+/1vJY9AEluar2R
         MiRRiwYe/qNiNjMMC2vpN/ATNudkf8mLwq3TJom9szrmffeVbuHDbHyTQ0j8xiO535oo
         FsbEn9agBX5AE3VYMYUXVP6iW1DrltXqx8b/B6qZY0Aa/9bHLfP66i1cHEsqXxVElVp+
         oErD2uxn9mM+Ue7mMYdQpkVso8Tqx+kNYnlaejwO4NSE+95FrH/6u+v9HaDXjHdSoPuc
         xNzA==
X-Forwarded-Encrypted: i=1; AJvYcCXVqUmFdB6LOAn3JOJOM+2+zuN6Eg5ystq2Y0aFGKSWhKPiKr5AoZ3y1W/qhsxtmO8j/jZ5F1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YymojC3LLp5Ez3/sTpABO7GzL2O3bv8gc52J0N6MuIkCC5436W5
	A1smvM2QRkcdwanIo3HcwGgVcc/c1YeXN7yI/rMztIvTPH9stKcNY84N
X-Gm-Gg: ATEYQzz/CuKKoQYVwpaV2PnulMZMaod1DcBSrOgneyczd/pLzw793K0T38h0czDj3eA
	xwhR/xCmgUu6ThUQADdn26SrWvsXxgknOH94zXz/0P7BgZgCKpm1oIi2OfB+1LuxxC55Gvpb0Pa
	rO7NaYaxSWRFQEyluS8iqBnCVGuHigQkdEFJS46Tu0VUge8F3r+CLqJkyRg3+KyIJ+4q5I+lZn+
	fvhwCe++oDjZE6ohmrzKdg6xZ9TZRWe3V//TQzmGUD9qRd5MVAAOsBNPyDjh1eacnQKcGwttpHE
	8KA61UuLnQXku3zsPC+3O8I0bR6/yKMWTi8k726NJU47KZpxaxJcnJ3QEggZik+AJJTlSBCEqnq
	cJ90MHKlwIaFbSAcButwKdo/NjHcBZ67+vIfeLE6iB0EVKSeVPD3fVoySgm3AUHguxlkkrzhzJK
	P6nuyyBFOb3P0lWV6rzrJVVQ==
X-Received: by 2002:a05:600c:354b:b0:480:2521:4d92 with SMTP id 5b1f17b1804b1-485567071a0mr18402125e9.24.1773360043742;
        Thu, 12 Mar 2026 17:00:43 -0700 (PDT)
Received: from localhost ([87.254.0.141])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe21b631sm14641861f8f.27.2026.03.12.17.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 17:00:42 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Fan Gong <gongfan1@huawei.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] hinic3: Fix spelling mistake "capbility" -> "capability"
Date: Thu, 12 Mar 2026 23:59:22 +0000
Message-ID: <20260312235922.3442120-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267234-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[coliniking@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: E7E5127B627
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

There is a spelling mistake in a dev_dbg message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.c b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.c
index 2dfa4fb39627..c5dd53a8fa96 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.c
@@ -44,7 +44,7 @@ static void hinic3_parse_l2nic_res_cap(struct hinic3_hwdev *hwdev,
 				   HINIC3_CFG_MAX_QP);
 	nic_svc_cap->default_num_queues = dev_cap->nic_default_num_queues;
 
-	dev_dbg(hwdev->dev, "L2nic resource capbility, max_sqs: 0x%x, max_rqs: 0x%x\n",
+	dev_dbg(hwdev->dev, "L2nic resource capability, max_sqs: 0x%x, max_rqs: 0x%x\n",
 		nic_svc_cap->max_sqs, nic_svc_cap->max_rqs);
 }
 
-- 
2.53.0


