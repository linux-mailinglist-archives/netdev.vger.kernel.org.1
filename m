Return-Path: <netdev+bounces-76538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A74A86E11C
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 13:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22B9D288BA0
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 12:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40729A3D;
	Fri,  1 Mar 2024 12:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b="tbFR8c0j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4992C10F5
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 12:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709296411; cv=none; b=CUWfcpy0vUOP5t8dksksyQLsOjxBGWGSN7qrr2xNsdpZCXpLkN2PDK1E3QUNzmU0jkq09MRTNFbC4Dl4X75m8noRHqLHrOxmSDgggCirW99sFEk4/D83ZTCaD/eX+7f2FufTAbdznxPxVKXkQF1T4ednYzCn249Wmka2JepMdz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709296411; c=relaxed/simple;
	bh=FeUwJNvZLqN+PAfhgJW29KpmVoFmadZsne5JXGJE3H4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Gbn5JgDiztchEEF/cFzd6Wrw/1GoSGTLU0axBTx5SeBgSd8AoR5MI0ZwtqrUrpMbTZtblbsLH0VqnQpvwvIjNThCoBmMi7B9MPm+1/mpmabJbQc3a4Ww7pipsrTthWozcDyiYKEuKn0FuxASmYqCbHXZrcBIZi78iRnuAInyadI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b=tbFR8c0j; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33dcad9e3a2so1157743f8f.3
        for <netdev@vger.kernel.org>; Fri, 01 Mar 2024 04:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1709296406; x=1709901206; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IUcm996RZ4SgzjYF372yvBWMKSI/r3D08qTtqD5lahI=;
        b=tbFR8c0jnl4TD/k2HPvZs0uSScAV0KRInqAx1GcK9B9PVBoUrOaFYIMgQQjk3MTYLH
         D+I/IjH8id1h8kBTtzANdlohvYMTADMaDmoqMqRxGJrcxXm/hhgdlHtbyz0O4p4ndYD0
         DolJ2z4KtV58R7pDGW/ITqdK2TOjMR0kgPsZcBXCQEgxyh0U37ZfgLTHjMJYBiNQlqT8
         62Q8p8Ynle2fv4pju6Cdob0kYXysqL9JDXBl/QFTjCM/7TiqYYgnKq1bhMNtG/79yDH9
         Ql3mWbrSXNLd1ArI2OUVUDdCY11JHjURhQ+pzYjR6PU0lEoA32u0lj4M4KKH0qYJLvhx
         Ze/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709296406; x=1709901206;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IUcm996RZ4SgzjYF372yvBWMKSI/r3D08qTtqD5lahI=;
        b=Wdcj0pbeSnUuQLOHPa/EKT75KdzTzhAF1UjP3U5ofbmPOmRoRLFI/8OmNxGdjX3FQ1
         gzpBHhz6fePyziaAGN//C0ao4K3OcUz4iNCUhf3Gx38lZkrqvM5G3ds1bra2rFOZgX72
         fVKA9CLLJW3I5KUxCsag37XX1qHuyeHfuzoOnZV9WH3DEuo0qygCt5X7hhx4rmFfQsE6
         C58sC8r8B0O0TDFrSEkEhvfSwb6jVgdUKkUtQq9koMQNWHF83714DCk859h3Yo0Y1vZ3
         h8+ULqKn6zFgWsmgHPlAscmWbpPXZwbaTbBjFV+Xyk4PX85qelJnKcAUcO71chugdZq2
         piPA==
X-Gm-Message-State: AOJu0YzYBqkxU3XHUgFFrbGIOb6Q7AFFHiZD7iqxJZynsx4YRVWtytKu
	d9R3lXENxSqK0WJcpelIfWITidf8UpI7XM2sKLXI6A0VZCaRp3Xv/vt9W5ibQGZ7pSMIfdbd1Ix
	3
X-Google-Smtp-Source: AGHT+IERmGk0MtznexxFI0Fd7PubHmvANWGUV2G2dW9kPHnARk3U21jYehlUucQdcqvnFbMF5yQp8Q==
X-Received: by 2002:a5d:4144:0:b0:33d:d2bc:bf41 with SMTP id c4-20020a5d4144000000b0033dd2bcbf41mr1249619wrq.31.1709296406082;
        Fri, 01 Mar 2024 04:33:26 -0800 (PST)
Received: from grappa.linbit (62-99-137-214.static.upcbusiness.at. [62.99.137.214])
        by smtp.gmail.com with ESMTPSA id e13-20020a5d594d000000b0033e12b2e567sm3709597wri.35.2024.03.01.04.33.25
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 04:33:25 -0800 (PST)
Date: Fri, 1 Mar 2024 13:33:24 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: netdev@vger.kernel.org
Subject: [PATCH] ss: fix output of MD5 signature keys configured on TCP
 sockets
Message-ID: <ZeHLFNX7f5x1M10/@grappa.linbit>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

da9cc6ab introduced printing of MD5 signature keys when found.
But when changing printf() to out() calls with 90351722,
the implicit printf call in print_escape_buf() was overlooked.
That results in a funny output in the first line:
"<all-your-tcp-signature-keys-concatenated>State"
and ambiguity as to which of those bytes belong to which socket.

Add a static void out_escape_buf() immediately before we use it.

da9cc6ab (ss: print MD5 signature keys configured on TCP sockets, 2017-10-06)
90351722 (ss: Replace printf() calls for "main" output by calls to helper, 2017-12-12)

Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 misc/ss.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/misc/ss.c b/misc/ss.c
index 5296cabe..fb560a55 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -24,6 +24,7 @@
 #include <stdbool.h>
 #include <limits.h>
 #include <stdarg.h>
+#include <ctype.h>
 
 #include "ss_util.h"
 #include "utils.h"
@@ -2891,6 +2892,20 @@ static void print_skmeminfo(struct rtattr *tb[], int attrtype)
 	out(")");
 }
 
+/* like lib/utils.c print_escape_buf(), but use out(), not printf()! */
+static void out_escape_buf(const __u8 *buf, size_t len, const char *escape)
+{
+	size_t i;
+
+	for (i = 0; i < len; ++i) {
+		if (isprint(buf[i]) && buf[i] != '\\' &&
+		    !strchr(escape, buf[i]))
+			out("%c", buf[i]);
+		else
+			out("\\%03o", buf[i]);
+	}
+}
+
 static void print_md5sig(struct tcp_diag_md5sig *sig)
 {
 	out("%s/%d=",
@@ -2898,7 +2913,7 @@ static void print_md5sig(struct tcp_diag_md5sig *sig)
 			sig->tcpm_family == AF_INET6 ? 16 : 4,
 			&sig->tcpm_addr),
 	    sig->tcpm_prefixlen);
-	print_escape_buf(sig->tcpm_key, sig->tcpm_keylen, " ,");
+	out_escape_buf(sig->tcpm_key, sig->tcpm_keylen, " ,");
 }
 
 static void tcp_tls_version(struct rtattr *attr)
-- 
2.34.1


