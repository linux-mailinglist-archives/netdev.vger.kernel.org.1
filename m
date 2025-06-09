Return-Path: <netdev+bounces-195818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA98AD2590
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 20:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7DA816DFB7
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 18:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D1621CC79;
	Mon,  9 Jun 2025 18:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HwWu2FKH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B25027718;
	Mon,  9 Jun 2025 18:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749493511; cv=none; b=a3vTrhk7c4aRjVFxJ1xXS3b+j+5v85D8zJbdrX3UqXXDNcrZpO9sohJysqTmHdbPpjlRiaTGwuF/XhHCpKSWyOeuFUVUzmJUGranQiCKcwcokJRPbciFvmVsCXDlLhkSvtpBIlKe/2Xt9grUyWUImw/f3K/7sllnsD6LpptXByY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749493511; c=relaxed/simple;
	bh=4DkztlDi1UNKjvC8sNIo+PdaedvC1flGUNrquVWOQ70=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DnOjZUUwdO1i7zu2xw3hbnk9eKY6Z7vSPJhIRT4waW2FGflkqo1UjQ+EjtNF6owj+ydLm+L0KH5Ph+k/i711hWNXj0Qn1CpydT65lSrO8VukvnsYKfch+IC2l8AgEKsWQSi81iwf+BEyFD8U1FwOkw8B3mqvqKEFcCll+30fsao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HwWu2FKH; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4a42c40a04aso4137241cf.1;
        Mon, 09 Jun 2025 11:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749493509; x=1750098309; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=14XQS0XBZACKYALkCZYiuHCbPa67r7U2WahK9NJpgLw=;
        b=HwWu2FKH4B0wBw5sNnojg1fo3WSOS2vO06ypHY71+/l8h6ogKXvsM3bEB64IvOWQZv
         9ppjdoZd3fw1WlWvqVInKuKR1jmlM2XoAcDZJuR29OIohY3ln/4ydeHswYhmZ/0dUu6n
         ba2fwFibA7Lm+Ayf9Y/yvWF6P/7xEjDMfXXsPAy7zeOdypuDidxtTWd0tGObBkButnOQ
         lNaweYBKfC0boJv9hcptgjqVs6600HiMiW+Oxj8hdo2/iJ6Jk5OnsrKhWVxhD+wVNYoF
         L9SXYypCa3WRnTY3cjHQuylhiVikAR0n244IsU3QNXr2fk7WskTyJ6GGl9EAoKjzM/pW
         UgaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749493509; x=1750098309;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=14XQS0XBZACKYALkCZYiuHCbPa67r7U2WahK9NJpgLw=;
        b=Q8cY0inyEkNEFCFldulBJmrf0RUjhZVIP/6B8c4naPJwece+gto5E3e42dtVn/Gbm3
         9i0cqPPgYwOdrcQjayJDmvrhGk9sRubKEoOgORqnFD8ZhAS+z/HkFFXm3pXJOpPeOezV
         zViqoevPGBfxa5OVC1xyPyjrF0D20i7cHtEGDILyfyQgcIV6ZVtFX5cF3HvJF1kFSwkj
         +jm47XVYxkO5iDySJcVlieSasxhIPxkLTL5K+lizqrcL7JVmb/62E9DJzMYBU0Tiytrg
         XSjSkusNFXgAHM4oaqg3NK5VofnDs709MHDyFX5sIi/2PIXjOkaOTcDjhmQkwPdPJS2p
         sZCA==
X-Forwarded-Encrypted: i=1; AJvYcCVNjePUp7shbanrip+4zcmDjyL90qk4itoiL2DvCKorJNIKkgd1QIR+Fb1kkhviPm7AVs8Y3JVzC5VADVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHzAX8pXspYk3pLAmG024GSiQFmf7o67SqrCx7uk/vOWaACWei
	PSBwTxZ87IQgWyMgKhcN9ZsAPMGS0kyasUZznppUVSu6twuH+JbWwWlV
X-Gm-Gg: ASbGnctTWBdlC76WENnqg5HrzNMUBX6dR4DQ6BqBfcRv1ojNMC1fM2vAO7PLY39qBbK
	943wSsmBKdx7rBq9GS4w6QLU9aAXgxVTZ9hIWsdNfJsV8aMgqjjjG889WycIYdQmWhxSvK/vn+z
	J6U4Aa9dkLdneSAK/Z/mqC2M2eJE3Pyml8gv33LNVpDS9XDZB3xwg5W5u8hMXi0DhqOXXEQN416
	lmlTG28cUd2dxygJFYtzbnTpJUIvvKVO3eKF+Ti7s+Qa/5RA5B/NLIimgzajT0gz/IMmStsySpE
	kwjFYy3SVEKPzm/LVFAAAvFh9sXXH9nr9JsGuMR98hhMuy9XZpGIDRw=
X-Google-Smtp-Source: AGHT+IGa1nqbrTKr83Evut9BiPTX252PXv/6X8BGyhlP7UQZT4G241QVKYBpK5WIPPrTd1ucQK1X5g==
X-Received: by 2002:ac8:570e:0:b0:4a4:3cac:2c7a with SMTP id d75a77b69052e-4a6690acf56mr73423911cf.11.1749493508697;
        Mon, 09 Jun 2025 11:25:08 -0700 (PDT)
Received: from localhost ([2a03:2880:20ff:2::])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a61116be2dsm59387521cf.29.2025.06.09.11.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 11:25:07 -0700 (PDT)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Mon, 09 Jun 2025 11:24:20 -0700
Subject: [PATCH net] netconsole: fix appending sysdata when sysdata_fields
 == SYSDATA_RELEASE
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250609-netconsole-fix-v1-1-17543611ae31@gmail.com>
X-B4-Tracking: v=1; b=H4sIANMmR2gC/x2MUQqAIBAFrxL7nWCWUl0l+ohcayE03IhAuntLn
 /OYNwUYMyHDWBXIeBNTigJNXcG6L3FDRV4YjDZWOz2oiNeaIqcDVaBH2c5ZNMH3oW9BTmdGmf/
 gBOLC/L4fpA4xRWUAAAA=
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gustavo Luiz Duarte <gustavold@gmail.com>
X-Mailer: b4 0.13.0

Before appending sysdata, prepare_extradata() checks if any feature is
enabled in sysdata_fields (and exits early if none is enabled).

When SYSDATA_RELEASE was introduced, we missed adding it to the list of
features being checked against sysdata_fields in prepare_extradata().
The result was that, if only SYSDATA_RELEASE is enabled in
sysdata_fields, we incorreclty exit early and fail to append the
release.

Instead of checking specific bits in sysdata_fields, check if
sysdata_fields has ALL bit zeroed and exit early if true. This fixes
case when only SYSDATA_RELEASE enabled and makes the code more general /
less error prone in future feature implementation.

Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
---
 drivers/net/netconsole.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 4289ccd3e41b..176935a8645f 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1252,7 +1252,6 @@ static int sysdata_append_release(struct netconsole_target *nt, int offset)
  */
 static int prepare_extradata(struct netconsole_target *nt)
 {
-	u32 fields = SYSDATA_CPU_NR | SYSDATA_TASKNAME;
 	int extradata_len;
 
 	/* userdata was appended when configfs write helper was called
@@ -1260,7 +1259,7 @@ static int prepare_extradata(struct netconsole_target *nt)
 	 */
 	extradata_len = nt->userdata_length;
 
-	if (!(nt->sysdata_fields & fields))
+	if (!nt->sysdata_fields)
 		goto out;
 
 	if (nt->sysdata_fields & SYSDATA_CPU_NR)

---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250609-netconsole-fix-5465e2fd8f83

Best regards,
-- 
Gustavo Luiz Duarte <gustavold@gmail.com>


