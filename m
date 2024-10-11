Return-Path: <netdev+bounces-134658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BD599AB6C
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 20:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DD8128483E
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 18:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67771D1739;
	Fri, 11 Oct 2024 18:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="NmSiXLfZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557A11D048C
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 18:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728672371; cv=none; b=aHAL+WMO2YPIAk74TqGaJXDJIUP1cBBoAlI2FV/MU4C9FmJ9jh6fblS5FQXtMxnZO6NG6f35k5klT+JWeMm5w4duN22QPhjPH6PwNOPtGCL4vvOrphajzSBmJ+9/4khaGpO63LwGso3eBYtwnLBxxkOfIbo4+WSuvOrdXyabK1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728672371; c=relaxed/simple;
	bh=Ay+s0guDrHAq8MnuDnxM0ZdAsgqJCoes87n91IKUUZY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aGSBKFG55u9KX5jJXGK02l+hxwC32z2E4sreLIhy/1WybHvO6AuEAp5a8XKBIeo5bpuJcinK4BOEhG+ab0shBnxBYkYzCzpx28K9AnY5R9OjUNrMAN380dlGEX2Ge1HCuh5x3Id9Vw+pyEtCa+jQjz56vSdhdvB82A8/N/3Ap+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=NmSiXLfZ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20cb47387ceso4585435ad.1
        for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 11:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1728672369; x=1729277169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dn2sSEQQaNvDLDNmmYALnWN9i1EK+aNS4wMNnm/Kh+Q=;
        b=NmSiXLfZeNa1txwLYlXh7WYgk7as8D1IKm1A+Yp2I1q1Xc3Y7jGMSfzjKJKiQ0CThg
         nTPr3/O/ZBLadBtVWq/GB/zDqddRwobx0SfmUP6GBD0KmUiOYJwQbAHp1IKRg/SFF1Bc
         /nRD2XaCHmzSOPydRtZ/ca/TllAqP8gmMWnCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728672369; x=1729277169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dn2sSEQQaNvDLDNmmYALnWN9i1EK+aNS4wMNnm/Kh+Q=;
        b=As+SD15cBJMkmssDC3RLmOw8uKjFuaGzIeLecCaQjkUW8Ic0162o5/HpJfAXpGjziO
         x84g+4YIiCsNbA9ygtgIsZnWXL5/DwC52VkEREp3eCC7cdAaJsIntyBNltJYFn98BfOp
         8WMt00SMMrTQZpvangXU2tOIiQ+tKuHnO/T1A44uZtnzJZqVy2yZHPyX+6eQr8P4+ndo
         kdpeSZ3783rXvvWQiiUD+0WidMORsS+GBdYTbI8qpIt4DiS4znoB9TK5+9sppAp4QFVc
         NylyO0cKAj8JxzOt+45Xz9+LiMgGcRtUjNxRbLipec23La7S9rf+y2dCu7cpexVs2pyP
         XLYA==
X-Gm-Message-State: AOJu0YzmmAENDadYuTLfA204c1uGn5ZMlVcYQg+Yco9r4XI/VJjaTR7N
	Yavg7y9eRL8EeABUHS4mFa8n2Ulel0+AffrZPJJB/9e26acWuynuywuOZVzTEpzfmPznK7GXEOs
	PgGpd9X0D7L/nnwf2RCCbGs3sOubizphcN3hcjpNHMiTn45g9v8yeT7dblVn+iBmFGnYQ02wWH1
	OJqKWzq+xgc31/KaNQIc54eqWaM+hj5u6uQMI=
X-Google-Smtp-Source: AGHT+IFmnoI7zdMShGQdX0K5KPw1Wu5OvLwhLQCL8LnCffu2Y9WFXd0TLNvEcwdmpwS926sN5ZEeUQ==
X-Received: by 2002:a17:90b:2246:b0:2e2:da81:40ca with SMTP id 98e67ed59e1d1-2e2f0a4d957mr4649758a91.2.1728672369296;
        Fri, 11 Oct 2024 11:46:09 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e30d848e1csm687625a91.42.2024.10.11.11.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 11:46:08 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	skhawaja@google.com,
	sdf@fomichev.me,
	bjorn@rivosinc.com,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	willemdebruijn.kernel@gmail.com,
	edumazet@google.com,
	Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Michael Chan <michael.chan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [net-next v6 7/9] bnxt: Add support for persistent NAPI config
Date: Fri, 11 Oct 2024 18:45:02 +0000
Message-Id: <20241011184527.16393-8-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241011184527.16393-1-jdamato@fastly.com>
References: <20241011184527.16393-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use netif_napi_add_config to assign persistent per-NAPI config when
initializing NAPIs.

Signed-off-by: Joe Damato <jdamato@fastly.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 6e422e24750a..f5da2dace982 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -10986,7 +10986,8 @@ static void bnxt_init_napi(struct bnxt *bp)
 		cp_nr_rings--;
 	for (i = 0; i < cp_nr_rings; i++) {
 		bnapi = bp->bnapi[i];
-		netif_napi_add(bp->dev, &bnapi->napi, poll_fn);
+		netif_napi_add_config(bp->dev, &bnapi->napi, poll_fn,
+				      bnapi->index);
 	}
 	if (BNXT_CHIP_TYPE_NITRO_A0(bp)) {
 		bnapi = bp->bnapi[cp_nr_rings];
-- 
2.25.1


