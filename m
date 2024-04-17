Return-Path: <netdev+bounces-88820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C93AA8A89DD
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 19:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84D3B281ABE
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 17:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D991487E4;
	Wed, 17 Apr 2024 17:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNuyDvVT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9451E129A7F
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 17:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713373654; cv=none; b=fTKJ3E/QCXMQ15ylQegqiVswN/kZ2Fb/xa+cuDmMVx3u+BjdcrqyYZdw+1ePbER+oYoMhEzzcl4/Ro2PevJDDUVefMdMKeRkJolSCIQF9GPvO2m5+eKRlpztvo2qocG41uVd9hv+OO6nN83G+pP/7qDk1wTv0omrTtmEvf0nIhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713373654; c=relaxed/simple;
	bh=oho/upbxRSYY6W6iVe29XuknjGrhjljnOCrTottKaow=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J0Bp3LGqrRaaw2QBfBf0xZrNE/c+HO6GkMMgY63+G29GQ52BGOiVP+SZyvHP3SQDEdzlVd+PvP1hK3+QxPpfNVsjsIzKdP6+xzurgUPVG7FVtJNkuyqN/5PhNFQ34jP4fDG3DIzePp2m/2mftlrZhltOkoZcs47yBCXYWBcbviA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PNuyDvVT; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5193363d255so2244957e87.3
        for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 10:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713373651; x=1713978451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9daNPukVY065h2lUFn590o+Qk3ggCL7Q+sBm415nUPI=;
        b=PNuyDvVTK7po43/Q651nk4pouZloDfIBk9rwDkcMTx6NEZw/wRec2JU+KeZ+U7hbcf
         l2FJmSZZKxKV8EwsJESlgkzg7icerKFnNhYL7E8i8x7sb398tA8/ongk3J9YHUrfrY8q
         foxmUqNFv3KUsextvfVHyGDsEOqFM4RY1bB57O5HM4qT0HTOBPiqFRDvS80NkUNlq1vo
         H/Z3MV6uXWDFXy0B5z5okRaos93SHxPWjvHC7hijr2KYwoDrNlszZI6uIdL688cvfiTk
         76EjwKw8QUN/RUMhgdMJt0qxHO80L3d1TA2BszQO9WwzMRc/GNbfjZbMK30hhSib4kPj
         pMJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713373651; x=1713978451;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9daNPukVY065h2lUFn590o+Qk3ggCL7Q+sBm415nUPI=;
        b=Ms/hEXWOO/QSW5+gCJm5hQwKJym/DiXl8tRTZ+YTo4uel3VhQws6tcHLNYYWl11s+o
         cDxe4urEEf4PANOVJxLQcyk19qV8SeehmKvgWBaBnysiiKtbSZTw76Gb+DTeB6sHmWSR
         KUs7QsO7CmyocVez36wJfPbe686+CwA5Ad+zRAMnSdDgIPklyfHmUNpO4GWfCRFIoBBm
         VCz4snxT/hqs2pbOIGKS+pJRxfa/JoSLTpZE7DcqPFCKhPrdT90mHZj3E1AIteusHqhy
         4MD5H5XuY3fDquNg8SLhDMGS9zeC9zQFMsaYHvg1XVIj+wJdtMA7CNmSebBJ3KOZ/Rqk
         1Z9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVo9x2TzbpsnzvtUQZ6G7WwmON48kGFQfBVP4Tfo8qyRUEC/cD6covvNijvBm5MbshFsNSZ5ay/O/p4mf4rezrbYof7+IHR
X-Gm-Message-State: AOJu0Yx5rvHiN6vyVv9km/FrsRg7LuAIvg7QHDJa7C3uI+wX+NJTsN4m
	fY0iIuvgOS+i4jtqebsCZQuyATh0DA6XtZkx2paPOxvQ0maQaK3b
X-Google-Smtp-Source: AGHT+IG84sYSXmvlXZlpLky2rj+fgz1IXVgXBHXnntJEYxyj+gEDh+WWnVFJmF5LH7eqxdZRNPaUig==
X-Received: by 2002:a19:640c:0:b0:516:cec0:1fc0 with SMTP id y12-20020a19640c000000b00516cec01fc0mr9953411lfb.63.1713373650331;
        Wed, 17 Apr 2024 10:07:30 -0700 (PDT)
Received: from mishin.sarov.local ([95.79.90.255])
        by smtp.gmail.com with ESMTPSA id u24-20020ac25198000000b0051593cfb556sm2006729lfi.239.2024.04.17.10.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 10:07:29 -0700 (PDT)
From: Maks Mishin <maks.mishinfz@gmail.com>
X-Google-Original-From: Maks Mishin <maks.mishinFZ@gmail.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Maks Mishin <maks.mishinFZ@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH] m_ife: Remove unused value
Date: Wed, 17 Apr 2024 20:07:22 +0300
Message-Id: <20240417170722.28084-1-maks.mishinFZ@gmail.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The variable `has_optional` do not used after set the value.

Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
---
 tc/m_ife.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/tc/m_ife.c b/tc/m_ife.c
index 162607ce..f8a5e427 100644
--- a/tc/m_ife.c
+++ b/tc/m_ife.c
@@ -219,7 +219,6 @@ static int print_ife(struct action_util *au, FILE *f, struct rtattr *arg)
 	__u32 mmark = 0;
 	__u16 mtcindex = 0;
 	__u32 mprio = 0;
-	int has_optional = 0;
 	SPRINT_BUF(b2);
 
 	print_string(PRINT_ANY, "kind", "%s ", "ife");
@@ -240,13 +239,9 @@ static int print_ife(struct action_util *au, FILE *f, struct rtattr *arg)
 
 	if (tb[TCA_IFE_TYPE]) {
 		ife_type = rta_getattr_u16(tb[TCA_IFE_TYPE]);
-		has_optional = 1;
 		print_0xhex(PRINT_ANY, "type", "type %#llX ", ife_type);
 	}
 
-	if (has_optional)
-		print_string(PRINT_FP, NULL, "%s\t", _SL_);
-
 	if (tb[TCA_IFE_METALST]) {
 		struct rtattr *metalist[IFE_META_MAX + 1];
 		int len = 0;
@@ -290,21 +285,17 @@ static int print_ife(struct action_util *au, FILE *f, struct rtattr *arg)
 
 	}
 
-	if (tb[TCA_IFE_DMAC]) {
-		has_optional = 1;
+	if (tb[TCA_IFE_DMAC])
 		print_string(PRINT_ANY, "dst", "dst %s ",
 			     ll_addr_n2a(RTA_DATA(tb[TCA_IFE_DMAC]),
 					 RTA_PAYLOAD(tb[TCA_IFE_DMAC]), 0, b2,
 					 sizeof(b2)));
-	}
 
-	if (tb[TCA_IFE_SMAC]) {
-		has_optional = 1;
+	if (tb[TCA_IFE_SMAC])
 		print_string(PRINT_ANY, "src", "src %s ",
 			     ll_addr_n2a(RTA_DATA(tb[TCA_IFE_SMAC]),
 					 RTA_PAYLOAD(tb[TCA_IFE_SMAC]), 0, b2,
 					 sizeof(b2)));
-	}
 
 	print_nl();
 	print_uint(PRINT_ANY, "index", "\t index %u", p->index);
-- 
2.30.2


