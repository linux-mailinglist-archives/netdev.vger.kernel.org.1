Return-Path: <netdev+bounces-208438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CD2B0B6C3
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 17:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BAD63B9A23
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 15:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5795919F49E;
	Sun, 20 Jul 2025 15:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NsaQtY6w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E44DF49
	for <netdev@vger.kernel.org>; Sun, 20 Jul 2025 15:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753025979; cv=none; b=ZMgREKOTthm2fD3aRtgPsCtsOIsxp3w+nv1al5QfWp3Y2aQ2Iq1YYIR0B6VjYGi4WkkNXiTXx7OA/wckbijpNgX9zJd0P1SNEthOx08+dudO7sRQjyaB5DD6iUdOSo10s7o5QO1jiAp7Q+tDyoN2bOZi0gC+PpkWh7VZ5oo/jrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753025979; c=relaxed/simple;
	bh=PYb+M+AksKNQHP729f6FopbgNFyw/05zMVDy63hWwGs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N7UvXgBq8ApaTNcgJATpX1wTMlIL2dnCBaVprfrkbS0VichOa0FO9KoNdXkrnWzhGU2CTTmt27MRAe/VfIAt44JTIF6Zvl2W1LdkPpYbbY1ZqaCKLY+oqfadvjBKBzjvOKr5Nqc70Nfumen97WJf2UBC2f403f852Hjwd7vXJ2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NsaQtY6w; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-553d771435fso3627500e87.3
        for <netdev@vger.kernel.org>; Sun, 20 Jul 2025 08:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753025974; x=1753630774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f+L2KZ58RlB7ZEmz0WOhCz4/VhaxtvmwbN2+7ulIHOc=;
        b=NsaQtY6w55fPqrDpugTcuPfRw1BZHI90h/yZUDQmQQPJH0EIPA65NbBhHT46UH2xLR
         B3PSZVFy8B8sDp4VzGwZuH5NQ39tiXaS0Q3qlbohE+C6VchmC61HBVnvYBeZDXmNJY7O
         HuZsvpiIBxx5Fpuiy8WFMVrDtEq4tFiMQRHj/Qq9/PPAAycgXizZ2wdaeqd45wX/H2pL
         2fq1Y9V0P4W/LEe+rlECKP6zMMq0iAA5BW9SXaYYMPFddb3nHSV/29HarnMvK/fvnf48
         pP6NJNiXDf4GFU7sJMyGvN+/4I2TACAAA6Fgm6ee1akN9nQrddSwS2sbgeasFOjrq4vo
         /Isg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753025974; x=1753630774;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f+L2KZ58RlB7ZEmz0WOhCz4/VhaxtvmwbN2+7ulIHOc=;
        b=PPd7HeOP1f+3p2wfgmHsOsbdcTmbTxKgNQJvcpHk8v9GJKOHlI5QdIk5vq5No8RojU
         2Opm1WAgVyNhUQGYJ0607U1j+tjEQ+SgXTCsgJdpwMTyodogU3gV3c5LEBMkvOcesrLz
         5LIUSWeISPxZNZLfMmguJESCr5RTZQAMRPPYoGBvjA+Ux02W5si2B8A0UCrt/8h1HPz/
         V4AIBoRtn3sGbcFmPqORiwveNSUP4orK4/1PoENVSAkNqrbBPO3T6QsnpO0yC3AFUZd6
         HemApZdlYRSgC3ueIeFMN+OW9XdOP6yc1/Yl+XYGW/+T5H1lRk/0KZKXLyCZZr0+XAD7
         2R9A==
X-Gm-Message-State: AOJu0YxqjfxC2uzUxQOf8HW98M/cxk9KSTnq/AUbhtdPlPGwTbsg7MlG
	9kZJuPtg2GC3Piue4BraOKaNypGk/624AjqXGLC0uMuAuO0xqgBg4H0Ms3i6YXm6wtI=
X-Gm-Gg: ASbGnctTKCc52CbNPFV+/vaA3Mu2BrR84Hz3GcFbADafNz06c7sJBlNgsMgPPyBOyqg
	f7H1wyFTfYlBJbTsbKofIcVMbvWD/c7J5bKVE5BkbDFYVwDvvW3GRrbZCjlINP9xyxzjXXxKcEg
	aYZoWjLcw6Z6yQOg+GgurOKVawpeZ8G/d2UHFA60rcW8mFwkzR3g1KTDmcuF34jG08lw3sk4Hfe
	fLhS7thfC2ARxEtAfSZQ875yPlMI8EmJxjUHbijFNPJV0Yokn3sLaSjbVGMdb74z597U/xZ64gL
	8qOyU58OiVz8lFeT0H6Gq95qyxiUgDWK/tkGt6tFpCJ0qMklsau+cgDEQorhG64TWTjxDbRevUl
	mR5FostXqcBlywbrlrDK70x4eqS+LFG9b5znkxrSTqQ7Rkkr51X7j3Qdj5QdZBgTiIU7iN6nTjg
	XZENq4Uos=
X-Google-Smtp-Source: AGHT+IGN9UgcWQ1OMmszzju9hhT5A338NB3uhxTU8/a9oxXCN0+w7nawsr773Z2CIfXGh7E6tl43rw==
X-Received: by 2002:ac2:4ec3:0:b0:553:cfa8:dd38 with SMTP id 2adb3069b0e04-55a2338ad70mr4115368e87.36.1753025973979;
        Sun, 20 Jul 2025 08:39:33 -0700 (PDT)
Received: from lnb0tqzjk.rasu.local (109-252-120-31.nat.spd-mgts.ru. [109.252.120.31])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a35b5a7dfsm975919e87.227.2025.07.20.08.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 08:39:32 -0700 (PDT)
From: Anton Moryakov <ant.v.moryakov@gmail.com>
To: netdev@vger.kernel.org
Cc: Anton Moryakov <ant.v.moryakov@gmail.com>
Subject: [PATCH V2 iproute2-next] ip: ipmaddr.c: Fix possible integer underflow in read_igmp()
Date: Sun, 20 Jul 2025 18:38:43 +0300
Message-Id: <20250720153843.62145-1-ant.v.moryakov@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Static analyzer pointed out a potential error:

	Possible integer underflow: left operand is tainted. An integer underflow 
	may occur due to arithmetic operation (unsigned subtraction) between variable 
	'len' and value '1', when 'len' is tainted { [0, 18446744073709551615] }

The fix adds a check for 'len == 0' before accessing the last character of
the name, and skips the current line in such cases to avoid the underflow.

Reported-by: SVACE static analyzer
Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>
---
 ip/ipmaddr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/ip/ipmaddr.c b/ip/ipmaddr.c
index 2418b303..2feb916a 100644
--- a/ip/ipmaddr.c
+++ b/ip/ipmaddr.c
@@ -150,6 +150,8 @@ static void read_igmp(struct ma_info **result_p)
 
 			sscanf(buf, "%d%s", &m.index, m.name);
 			len = strlen(m.name);
+			if (len == 0)
+				continue;
 			if (m.name[len - 1] == ':')
 				m.name[len - 1] = '\0';
 			continue;
-- 
2.39.2


