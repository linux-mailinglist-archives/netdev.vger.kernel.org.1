Return-Path: <netdev+bounces-191163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6877AABA4C7
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 22:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBC9117D441
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 20:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903C427FB2D;
	Fri, 16 May 2025 20:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5vqTzwY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD58C42AA3
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 20:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747428019; cv=none; b=mks7z43bMeu46WGplsSaRaZARaeyUGOBWrHOwy0GjsN0PacgAyOW5e8Cbhs+3MmOSGDqeSfpBQmUFj8NJsIWjZyaLCnbhFBN5+baBmTuNoq9vTDopoqp5KCD9ciqhQRXkG+W/pBezeufPu0mftos4Iz5PH11AcNA6O0XyCjnSYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747428019; c=relaxed/simple;
	bh=fP8E9v3zJ+APJASBeiAwRmZRScRfbVU7Qi3sCSrOeSI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=QBgTG2vG29pLh0G/fhnAoiFjsUsoyaBlxAb10OhImAFmr55amYqnjqfZFWjWBYnkZLNhWossTTZtZybpibznlHpln6JTyH1+H/VEFc5nQb2guZNzVzqSdXncJ7HCT0u4n0bSqgRquyPU6FTAbre5yoZW7szVxt12PQJH7ZYPINA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L5vqTzwY; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-54b166fa41bso3385115e87.0
        for <netdev@vger.kernel.org>; Fri, 16 May 2025 13:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747428015; x=1748032815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yxLxKPAkFRNTV46MhihIDPqFiSaNfOKTtn1tMu7HPrY=;
        b=L5vqTzwYvbyH/VbV6KHFnRdshC52W2CId4/UNbGaqVGdbqJar0eLECnfOQ7OoO4nRx
         1qZjmsVfPuGpdHidNubmmD/3aPudda6lDohE7+CqXJD+9ko0TczicoD2u73TWaCKxeJK
         Dw9toACnJHdrKlIuqri4bCXl2YT9v8mqZT7uAD7Y+J0L2gAdBAPWOkqSF9dTNXlG73Kf
         n58hFsSD4tg6R/pc4KNSDNvmscUuCPNZv+kM5M9hnaRnbtmlBcVtmj2polHcSvrQegw0
         Jf613KPYwvbx5L/Ny6uftEaPeP74Z42awQiRedCJ9CUihnNUy1j71m5+i6pHz+oiJG4+
         vHeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747428015; x=1748032815;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yxLxKPAkFRNTV46MhihIDPqFiSaNfOKTtn1tMu7HPrY=;
        b=E8ZgAcIVlJM2uzBnLN/LU+3WL4D8z4w3xucTvIuV5rYZ0LfJx4CrWZaOC7/v65aCF4
         aXN81ntaLytqxkV2aw4t+eMJ5pOAJphtrHHUU9DMOcHEGRB+NDGl7GvSN8G/PEYam9EM
         VFYpzxock7E2MgGz2T8icS0A0PBV/d6j8SJNMxMWke7hkxHLSNxhYbY0qTTuXTqyqFnL
         CZvjXsluvrvBvWW66+aYVl+jonYA1pZ9xHY78T1454AmtjPdH9u50u6l9zK9NfeMu29v
         0qJ445RrmrdjGaj7EO1bJxB0tJAFfc5evyAtlOvJXy2hqWT3qRS8IAm7O3OcaLzeFHwA
         rKsQ==
X-Gm-Message-State: AOJu0Yx9jvpt3jdbRv5qTCAAfJzm5jJx80cJnOdjiE1LEvKhdFj3JrTv
	++HyrHI1BHyRVcqOPsGBA5c5BNnzMEBdE1fagt2xq0dONuE8S94FtRix4jszcL/Z
X-Gm-Gg: ASbGncvYjXbPB3eHwCSj5j4iIotfIGUGGQQfATWHRMISrj43hz5l2lFTwJDRXgzoCvv
	eVfQw/vGswMV75lT6czhqOsfPDET1oqQI+4TfgFk65skyD/eOxkf/aD4CgHHc6Y+tcxCFwAQh9L
	vy/Auol8aXEmhYjeeCOHZFgHBDcv8BboS+dHvIiG+9qRF88RLmokIEzTGvZQt3ydX/HjoZ3TFWO
	1xREtsjTxuqTPYNfyaLKQ7A3ai/agW4Q2+YNHFIucKQTxMAzuCpOq8JuVFeHtcnG2mrHmqL8J5U
	DvMNom03w8Xqn35iSqLscwN2d8a/QY3VYqwznWVI4mdkM+Rb6oNAKEfHg+/sjFJlGsYbzAXZBUn
	po5+p4sKTI3vOPFxCwg==
X-Google-Smtp-Source: AGHT+IELQ3GN/2FQdV1B+qSCBIf8PFgUT3NP1U/fNkvfMlu91emjvWM544En7o2/S0DaJI5uhMg3XA==
X-Received: by 2002:a05:6512:620b:b0:54f:c6b0:5138 with SMTP id 2adb3069b0e04-550e71950f2mr1327097e87.1.1747428014304;
        Fri, 16 May 2025 13:40:14 -0700 (PDT)
Received: from anton-desktop.. (109-252-120-31.nat.spd-mgts.ru. [109.252.120.31])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3280ca53e2esm4231121fa.89.2025.05.16.13.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 13:40:13 -0700 (PDT)
From: ant.v.moryakov@gmail.com
To: mkubecek@suse.cz
Cc: netdev@vger.kernel.org,
	AntonMoryakov <ant.v.moryakov@gmail.com>
Subject: [PATCH ethtool] json_print: add NULL check before jsonw_string_field() in print_string()
Date: Fri, 16 May 2025 23:40:05 +0300
Message-Id: <20250516204005.260753-1-ant.v.moryakov@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: AntonMoryakov <ant.v.moryakov@gmail.com>

Static analyzer (Svace) reported a potential null pointer dereference
in print_string(). Specifically, when both 'key' and 'value' are NULL,
the function falls through to jsonw_string_field(_jw, key, value),
which dereferences both pointers.

Although comments suggest this case is unlikely, it is safer to
explicitly guard against it. This patch adds a check to ensure
both key and value are non-NULL before passing to jsonw_string_field().

This resolves:
DEREF_AFTER_NULL: json_print.c:142

Found by Svace static analysis tool.

Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>

---
 json_print.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/json_print.c b/json_print.c
index 4f62767..76e654b 100644
--- a/json_print.c
+++ b/json_print.c
@@ -138,13 +138,15 @@ void print_string(enum output_type type,
 			jsonw_name(_jw, key);
 		else if (!key && value)
 			jsonw_string(_jw, value);
-		else
+		else if (key && value)
 			jsonw_string_field(_jw, key, value);
 	} else if (_IS_FP_CONTEXT(type)) {
-		fprintf(stdout, fmt, value);
+		if (value)  // защита fprintf
+			fprintf(stdout, fmt, value);
 	}
 }
 
+
 /*
  * value's type is bool. When using this function in FP context you can't pass
  * a value to it, you will need to use "is_json_context()" to have different
-- 
2.34.1


