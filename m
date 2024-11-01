Return-Path: <netdev+bounces-140992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3099B8FF0
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 12:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E5BD282CF7
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 11:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC4D1714BC;
	Fri,  1 Nov 2024 11:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9Pz5WED"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B25166F16
	for <netdev@vger.kernel.org>; Fri,  1 Nov 2024 11:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730459166; cv=none; b=LTv7mptrQTsmsU9/nNJW5yk0+OiJJC9j9vWPQc+TN1UNqDQBuAy9JBkhxClkYuUc6Qanzpvsy7CVE/FNJ4CNFEDlwedJvJjy1qJUACy1REtYMRV4qV3l2w8UkKduDPMLdzcxZuo7RpdGZIZXKYpQP3RzxeVgUDkREt9J0X8OlSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730459166; c=relaxed/simple;
	bh=yPUb7r2ZS5jcg/tT8Dywot1IlWzoNuc0xmIyeqy0J3E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oB9cigWZ0eAKK00PROQQZIX1zYgk1WCUaYrRN+G9eg6OgzsJzedHQzIaAAVaeH69/Fv0KjNclfOCASsFSSWJrOVmJ4/0Q7Jl/Q6m6Y8tHet+Dni7YAnt262BnigUVlUonu8/VKvocXtdjF+Td1OmvfD9R2slco9kNEG/+sJsZtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h9Pz5WED; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53a097aa3daso1781653e87.1
        for <netdev@vger.kernel.org>; Fri, 01 Nov 2024 04:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730459162; x=1731063962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7hQyYW7v0sIC58MsRpBNiWuQFllkcDdCEwJ8wx46KLI=;
        b=h9Pz5WEDHN1PROxrxdt7Sv8x8wOBE33CkjChJ9UN5gK3bRG8GWUjWufTG6D5Yd7+n8
         HVBs72PdFHKaKDpbILBTPhXledO0+XAOhAR1oKj+mQRm1UIpoXBj5UbvPyfEsr1rfsIJ
         Jgiu5Z5VZtumsJyV7PNS8ugAYYN5fcAaiuoRXLPZ9XrclizJknHyLZGHlkd4hMH+jWEI
         tvqyKLb9pUIjL1496vxMbNw++QbuNNYIxlYp5Mg2GdThdo1GocqZu2aDIg/mQYFZTGoC
         HBi8FtyC+5VJdBZmuHd3WCeX9AAnxodBrGsCaxag6hS43PlBXiPhC9tkIo8nDyo5l4o2
         a+9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730459162; x=1731063962;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7hQyYW7v0sIC58MsRpBNiWuQFllkcDdCEwJ8wx46KLI=;
        b=XV8s7WUdz3mUToIeILKoBdNJtFiCOj44LNrBFQ/GKhH9w/rA/sDHpb4W/L1w6Lacwi
         w/FQitYiO0aBUmyJNjjNWmrObsoVtl5qZorSs2CWDrvfJ966LJAv7ZiCUGB3aValHhSz
         GsnuBVpTrbMrh7KPF59xPHhtpZR7ov4vawr2IuV9nhdLHRzZwHJh0bP4SR6drbM1csV3
         rsjPOii2cQ/xD+LEZD0DeLr+OIR/WeLb+igBo2KUH+hOA9QnbNjhseNHK2+YufeNqsGI
         avvT+ve5rYNIZW9Z/Mxb4iURxHuPNlaH6l71eCx092uHP5/OE31luyttJmXhQ3h763um
         QlnQ==
X-Gm-Message-State: AOJu0YyikK4TFPq+S/MBQlGt444YAiQ7x4C5dyRqY0OKWCkPRBEAqrjm
	5jWJgf4WYf650ASmjhcBR7dXUIHnTJe9zC+AcMq+cj34QFYxG3IC
X-Google-Smtp-Source: AGHT+IE2PVDRNCnfy55wO9wPCi0JJZjqTd41gIunuuKMiX+vr2YBkfMhuaQQtPWiiSpB3GUj4XeF+A==
X-Received: by 2002:a05:6512:2244:b0:535:6942:29ea with SMTP id 2adb3069b0e04-53d65de556dmr1533225e87.11.1730459161821;
        Fri, 01 Nov 2024 04:06:01 -0700 (PDT)
Received: from localhost.localdomain ([83.217.201.225])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bcce6d9sm515242e87.120.2024.11.01.04.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 04:06:00 -0700 (PDT)
From: Denis Kirjanov <kirjanov@gmail.com>
To: stephen@networkplumber.org,
	dsahern@kernel.org
Cc: netdev@vger.kernel.org,
	Denis Kirjanov <kirjanov@gmail.com>
Subject: [iproute2-next] ifstat: handle fclose errors
Date: Fri,  1 Nov 2024 14:05:39 +0300
Message-ID: <20241101110539.7046-1-kirjanov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fclose() can fail so print an error

Signed-off-by: Denis Kirjanov <kirjanov@gmail.com>
---
 misc/ifstat.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/misc/ifstat.c b/misc/ifstat.c
index faebe938..b0c1ef10 100644
--- a/misc/ifstat.c
+++ b/misc/ifstat.c
@@ -1003,7 +1003,8 @@ int main(int argc, char *argv[])
 			if ((tfp = fopen("/proc/uptime", "r")) != NULL) {
 				if (fscanf(tfp, "%ld", &uptime) != 1)
 					uptime = -1;
-				fclose(tfp);
+				if (fclose(tfp))
+					perror("ifstat: fclose");
 			}
 			if (uptime >= 0 && time(NULL) >= stb.st_mtime+uptime) {
 				fprintf(stderr, "ifstat: history is aged out, resetting\n");
@@ -1035,7 +1036,8 @@ int main(int argc, char *argv[])
 				fprintf(stderr, "ifstat: history is stale, ignoring it.\n");
 				hist_db = NULL;
 			}
-			fclose(sfp);
+			if (fclose(sfp))
+				perror("ifstat: fclose");
 		}
 	} else {
 		if (fd >= 0)
@@ -1064,7 +1066,8 @@ int main(int argc, char *argv[])
 
 		json_output = 0;
 		dump_raw_db(hist_fp, 1);
-		fclose(hist_fp);
+		if (fclose(hist_fp))
+			perror("ifstat: fclose");
 	}
 	exit(0);
 }
-- 
2.43.0


