Return-Path: <netdev+bounces-226289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF128B9EDF4
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 13:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABD13167C88
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 11:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C282F60CB;
	Thu, 25 Sep 2025 11:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aL3vqmII"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C520E2F6176
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 11:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758798786; cv=none; b=p5FEEMzyi8AjMuuSj0aPffiCK0uft+53rhCtXN6vkk17SVSlzd59kahP/vq8a4/BQoK/j00RyVz61YCW9GCWLtTx43YEn6NSAMtdj5egPK1OpZmUmX6Tn7vKDagQqesBPHmrs2YTnKobIgC7/9xaT0WHoV+QJ3HodzzqIDnJSzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758798786; c=relaxed/simple;
	bh=uFy63nnnx4ZnwOuArkqHjGXysS+NJF57ysEjyfutKfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BrR3xm6OiEvDEm3pdYI2PpQ2xmSI2CcfwIzWn9LqoelsDCeaXThqlGv85qOzzRd+AZ/GgKakQt1m36ybazUvlsgBroQXNpCCbz8fF3E2YsI6e7523mNUS6BmE96Wo9OJkrPqjRqzTWRkBi9hWi4efrBmk5DAU3HieVJmc2KR7t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aL3vqmII; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b0418f6fc27so133074966b.3
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 04:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758798783; x=1759403583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tYnr8HwbESiDTnsP/aj/o5hJ7k2kh5UyVUFi7J8nJUk=;
        b=aL3vqmIIE81vgJk5ZImfab+fmFVhbWHTTDtJnoZT/ErMRI6B0Waql4bSgHsbmz4xj2
         7ArlFHRkZ3zjxdrm6STLoS1G+1L5xaq202Kr20WA35bg8qI/5bwuiUtwwJsEcsDYqg38
         kMTns5nRmfRDxHbHY+zNUa7tGKY5wgRvqGRjqMGw+YeSOKc4xPpoQkMccu1w8BEi1COi
         8v8bpaTOhxAY3SGOlCgsYAHADpc8VI4p4TYSKFtxB7VeWTxE2tTiI/yolaVqWZ+R5vRK
         rAtRkmjB5qcscnA8OfN2M9kGKKYJVycTOjr8kYyywHQgVOp8sZ1romrq20PdD66Ukryl
         Ca9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758798783; x=1759403583;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tYnr8HwbESiDTnsP/aj/o5hJ7k2kh5UyVUFi7J8nJUk=;
        b=Wth7ILxtJoVE9rTFeqsNdMoUo1YOoYFiCf+dGs3KnsWILRGbULZKXV6Zhxt9yU4o+r
         VwfHAM1oMS8dTUaX5XASnm+iXjYGbfNOUMVrZbWSTa08yoxPLB8wXPzcA6/Fs97QvwdQ
         PjnicI4Fyah6/iS1ridKJdDTOPIvS8aw7keFxAdRnn6SgfW3p8MhAgbRUL/2QTEOaQ2n
         Dlpinxz4qmOHvLF+yI+/ZU9uz921IOlpFvkisCld48yt3/lyf26Dw6LJbDUf0DKhgcjJ
         AiYfxU73V4OPR3DuuByL8N5NcXMD0xXnWeJgP2aBdK8+Kpxot6RCQ5qA76K3sdWKHxYr
         xhHg==
X-Gm-Message-State: AOJu0YxH0BsZkwDSsegLKxKHuLNzZEWMEpCIBGm8ksvLP3DuY2u+2lIw
	9lCr0hm1TTE27YQyWv3rTdKVsdMrwFuwUtraLiwwhHzcZ75JHbbnz0DsgoFBVDYT
X-Gm-Gg: ASbGncsRF4DuRldhZIPYm4ZI2VHhf7zxuAhcKBjSvMsEifH3Lf4KHOnqvYRz1EBwTCd
	B6FDsGTG+5MqXqRjXKnb5oGki4GbT2yvkhDrUvu89PTHI6ZtKEQokiUYnQ9mrDL6HP+P0bwj3IF
	ZREi3kH2PhpdhnUrTQwhu01v+AUSrbXABSjSmx2bkmOo3R1tgSx/rouDcUyQrNKgmsK/1U/5N/g
	CgynhDPnX5Kip6SsH9T7ld4T4LZh6huXqAIikxYt7A//ujcyrIK8rcmLg0DzHbciqZegFRk7n3b
	LLOBRhsHdsfxVuAZ2pZimV2EjCcUIMFRWpPffc0sbAOzHHnCmlAQn7dwNpDFBR/Iahx5eRvz3SW
	iQLwDmiyJziHEoK7OP2xW0I4fyjnhpUFzvV00tlujLdtxWDc6b5rKahCjXUD/VRFiJv48pistAI
	yhYBS9NjEQbQLK1hA8
X-Google-Smtp-Source: AGHT+IGlNtfC7va6vHlIIgRl64TXlo8U2SXZvuVeC+DyV/7jO5RaGRrxOFF3y1xz/lUW/QBBHDH/2Q==
X-Received: by 2002:a17:907:720b:b0:b2c:fa32:51d4 with SMTP id a640c23a62f3a-b34b7209db4mr312152466b.3.1758798782631;
        Thu, 25 Sep 2025 04:13:02 -0700 (PDT)
Received: from lieuwe-clevo.vuw.leidenuniv.nl ([145.118.104.228])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3544fcde12sm145712266b.80.2025.09.25.04.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 04:13:02 -0700 (PDT)
From: Lieuwe Rooijakkers <lieuwerooijakkers@gmail.com>
To: netdev@vger.kernel.org
Cc: Lieuwe Rooijakkers <lieuwerooijakkers@gmail.com>
Subject: [PATCH iproute2-next] man8: tc: fix incorrect long FORMAT identifier for json
Date: Thu, 25 Sep 2025 13:12:41 +0200
Message-ID: <20250925111250.61576-1-lieuwerooijakkers@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Lieuwe Rooijakkers <lieuwerooijakkers@gmail.com>
---
This will fix the man page for the tc command, the FORMAT specificer had the long form for the JSON
format specified as -jjson instead of -json.

 man/man8/tc.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/man/man8/tc.8 b/man/man8/tc.8
index dce58af1..727a020a 100644
--- a/man/man8/tc.8
+++ b/man/man8/tc.8
@@ -136,7 +136,7 @@ tc \- show / manipulate traffic control settings
 \fB\-r\fR[\fIaw\fR] |
 \fB\-i\fR[\fIec\fR] |
 \fB\-g\fR[\fIraph\fR] |
-\fB\-j\fR[\fIjson\fR] |
+\fB\-j\fR[\fIson\fR] |
 \fB\-p\fR[\fIretty\fR] |
 \fB\-col\fR[\fIor\fR] }
 
-- 
2.51.0


