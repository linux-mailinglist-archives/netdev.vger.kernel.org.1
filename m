Return-Path: <netdev+bounces-213681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E128B2644A
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 13:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A3D418961BA
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 11:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B992EAB6E;
	Thu, 14 Aug 2025 11:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTjqtKhq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C736323A9BB
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 11:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755170995; cv=none; b=gGhz3VBAX1Iy1j0VpVmXmBfeFYA7k9x+0e+26XRlzZOxTQgLeC5n1k5vKl59YjT9bXg70wV7nsY1ZiMz8DflOCjRAQXvHZ9B17szlwcaWKOLOit7Nafq+m662Xvy69Z3XiaaQswnUadBlr27xjsLVNxsKWivE9ih5ZfhAAjTBX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755170995; c=relaxed/simple;
	bh=7AX/ChsKyEEdhYk6TbBhaVj6oFf+iaERmNwYi0w3eV0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=puJpUgrSz5/HkqerAS51kVMW729Tyc+YDl9TX5+dxn8m9F3ciNJhGamMbhWHtEM3QgcMTrVKff/VtzUTtLc8egnBdeaUYAYpC6HNInuz9YAoIeLVaoKxq32GTUQ/EEvZhlaai5xBNWxXqktYaOdr1tYTP3VmyrESWvDH1iZVS8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZTjqtKhq; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-24456ce0b96so10170575ad.0
        for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 04:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755170993; x=1755775793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SJXss9HQmOUB2ohnaYiuS/JNiiPTjigUVeHUSVyHw+w=;
        b=ZTjqtKhqTaYd0Czm6sePjn9gnOypDwUG6zhYEQfvhLA18kDY2OOnNsbIUBejb0pLeU
         0J4UVU4rhXMnzPfQbSu85il3LV7bc4773xCJ6UgKofZE7Ja843ZRi2uQNdaRQsc/dxiI
         lCMXD6H0Kf7KHikrotKmht+hB7XMnGTxeL2etJ73KwUBJdwmOO/VgnDo0xkNE2LWUGFN
         rdvs0Mb6mmhKbcLqlU4o1tTh2DhmFKS1nJJDoZ59yC/YnqhqKDOHis+LvvgYejixmitm
         XtvkFJoMKj1XJsWb+pH8IW2dQlACNLOUhP1xrLBnYLJqAte9zPqXFmtWguMMISzarQ51
         6eKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755170993; x=1755775793;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SJXss9HQmOUB2ohnaYiuS/JNiiPTjigUVeHUSVyHw+w=;
        b=ZOCALKdU6rp+WDRQGOJ4PZt5dx/aGHruD97kaDwiaRKtd3ehlRvvfvY6LHVjAFq5ZL
         gTkNpeFmTmYKU/sb5BdwZIXkWvpaP9ZaFhmJEHQc8q2Tto6iv3ID/EefATDBT5lmxYK5
         gpmjjcThLdj6yEFjtqVzvjXHiGSVkNiAjINAzoUHIvYjmtB75Z9DV9W84I4CmdFaqdfG
         4OhlnBgIy2V+br2Hh3YCb/SbpsamyUfvX/68EKVzAes3O+29LQvlU+pjZcYuxTseU4B3
         5iEGBDShUkSn4nfMWQQvhdqmMyP6S3MjJVN057tN1ew8GJ3QCg+wYYCc/nE9/Vq0pfbD
         I0OA==
X-Gm-Message-State: AOJu0Yz+RMB1wtRcXt8U6s4j/0YyZvg93HvDghPFVjErkJfTS12vQaEA
	jPlkD887BVSiHXN3iWwglH773lmcuI3cXleSPPt/K/cUHUmCHALGC86r
X-Gm-Gg: ASbGncuVcJjy7hMb35zceZqNlkahxQ91o7nlWYtySHY9VupBZiOHo2/W5m5iR3QPM++
	lAabkvQROTYN4dJ+j/630jDSlqHXJItqNhMSarEEDJgO6UZqn21ZESpC5qQsHjHlXmfmIsYjbcy
	KrTpYmrbslnH21qseY0axsyIqIximJA3QS0X3SUX1aMbgctoBnhbPnbJlOUuCuWFKyjb6lUIpXN
	EdDM469nUM73aVYQHraWLJCjHw1h+NUo+MkutoeJ7jVuh6Dx65hpXcTa+ykcJAY9x/X4wbhcXK8
	d31r2FENQVlvx7gJNO1Dn98WmpSlukXjgdA9VVcCSH/5OaJbGIXVZGOTlLfOtTMdv8COngLOJYb
	iIqnmCsR2kg6nJ9QB2r8ht31ycrTIxoQLKP84O/igcfWglg==
X-Google-Smtp-Source: AGHT+IG4XtoKRFDIAtg9fO5pckcsxD6ho9q5dRyZqsvvaLTtokNqvQFt946Y0BrFB+q+p4qbb4SZHw==
X-Received: by 2002:a17:902:d54f:b0:235:f091:11e5 with SMTP id d9443c01a7336-2445c4ae1a1mr28623725ad.10.1755170993016;
        Thu, 14 Aug 2025 04:29:53 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:f50d:900e:961:a245])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8975c89sm348159475ad.96.2025.08.14.04.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 04:29:52 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: krzk@kernel.org
Cc: netdev@vger.kernel.org,
	Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] [neard] README: Fix the text for the --disable-nfctype4 option
Date: Thu, 14 Aug 2025 08:28:57 -0300
Message-Id: <20250814112857.1523547-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The --disable-nfctype4 option disables the support for type 4 NFC tags.

Fix it accordingly.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 README | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/README b/README
index 509363bccac3..b2967a787508 100644
--- a/README
+++ b/README
@@ -41,7 +41,7 @@ disabled with the following configuration options:
 
 	--disable-nfctype4
 
-		Disable support for type 1 NFC tags.
+		Disable support for type 4 NFC tags.
 
 	--disable-nfctype5
 
-- 
2.34.1


