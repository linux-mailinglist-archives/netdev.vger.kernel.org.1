Return-Path: <netdev+bounces-131000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D023598C59F
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 20:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A5D6B20A69
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 18:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1E81CF2B5;
	Tue,  1 Oct 2024 18:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yu11TMZr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40ED61CF28E;
	Tue,  1 Oct 2024 18:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727808382; cv=none; b=uh3Ov/9AMbjqspk4JQu+fVELDZ4XgB6ucHk35O5uIGovrTRuQrJqW5aelCgfLtV0UKOSopxMrYttmfp1B6HBo3yUi/8GvoRshJkYEeyKeM9ha9tqT/F0ojnQ2Mi53wtKV7acslRsu+ayeSQJgrslmq5H+b//02tbEK5dKUTogqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727808382; c=relaxed/simple;
	bh=cobouo/f4vABqffd5D/CFzek6D3mMGa8a75lrC25gLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RE0S+jbK2KAvrIrDJIgT3hshzTuez0vMUOn4pPdCUpqZnZYaFc7t+f61bkmAK0l/DVudD0Z533eDDpJ2nWj2RkywA4vUtXrybzhECQcKKSCps4U5VKM2MEDXG0nb6Ad79kwv8hHzNEgtiS6OgxOKc5lGOZymNKsxIB0KuC7mf74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yu11TMZr; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20ba8d92af9so14017285ad.3;
        Tue, 01 Oct 2024 11:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727808380; x=1728413180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GMYvEJpJG6VhpCaLpa6hP67KqZAfsj8P0XkxYx3TmjE=;
        b=Yu11TMZrYDESNi0L+J3ktf6dLk4MAOxWMD9sCXeUmvPHywoUVgeU+K+aL898u6vaTN
         domJx2JRXegJktN4/ZDnwA1D5Cudcen13ImMgT/BNAEmPTJcQ+VzyZ0VpUPzMgikXodf
         HAWKkNxuYMLtSLr1AqWkzT55Xl5W6q6opxHIUea285eek3ZRfE6B2JQEhy5l+lvPdx4J
         zIJr5fkdzJsGSZZcxy4uzE2cvfiDxxxZbRIBegh7+NTBGeWGEkf2uUdGXkfBUgPmAY9A
         YfWbhO3TC22NckPKin9gSgygmTTHmLp1oPtXA5DPq26N8aeeSdjmjv9Sj/VeIhGIlYkR
         S1Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727808380; x=1728413180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GMYvEJpJG6VhpCaLpa6hP67KqZAfsj8P0XkxYx3TmjE=;
        b=lu03G3xtGaJLRCnNiM54eCRqgVZylvMnTmOLvsLGIIQfHfZCrFtrXYh9s4mUtmhZdJ
         ZOdSFCdosPo8s7Co0IMzFzUJ/4ugYVwaSFLf592a68PpPOFJBh+Wv5qkDxp3iBXWj5S4
         FKagffgl2KVtvBz6mUAhxDq5BvxZe3Ui7fnN7NruKpXDdPbv0YahYw5ZPl9anzUw630r
         p3WhvDZEj8fELdyTWNHophaNpC+bZ9qJKPACGh0v2nc4q2lzgciw9nJFIX0eT+Ydwi6d
         O+4isDpYLKt4wlFOsegIpaOwxtNYpfFMIC5k5Ndv081w+457BAfuh013bUuzmfL54pZA
         Fb/A==
X-Forwarded-Encrypted: i=1; AJvYcCXahMosujHrLo1JMH4fvrrLoVz1huBLC8+hoqPyvIF5WdWin8rIPOMlGy+9KINwTxakc4+qjNgCt9SfQls=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjS+Saa8JqEI9ISJaZicQfT4yFYXMOogaNma/utu+nuAgK9MVH
	vmIQpClT4v6rpjSSx+z53WfRyN9Xmj4BQEFhyMCK93XMmR5WFgJBXBPbo2UF
X-Google-Smtp-Source: AGHT+IGKcgOWQT8O7nCv7T1YnUMdYDiSmgOoUCE+kwvYH6sEih1BHjg6LbZtu+1g3tsHBbJzNos3YQ==
X-Received: by 2002:a17:902:ce88:b0:20b:4bc6:1132 with SMTP id d9443c01a7336-20bc5a8ec0fmr6081595ad.46.1727808380562;
        Tue, 01 Oct 2024 11:46:20 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e357absm72278965ad.190.2024.10.01.11.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 11:46:20 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	olek2@wp.pl,
	shannon.nelson@amd.com
Subject: [PATCHv2 net-next 08/10] net: lantiq_etop: use module_platform_driver_probe
Date: Tue,  1 Oct 2024 11:46:05 -0700
Message-ID: <20241001184607.193461-9-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241001184607.193461-1-rosenp@gmail.com>
References: <20241001184607.193461-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The explicit init and exit functions don't do anything special. Just use
the macro.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/lantiq_etop.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/lantiq_etop.c b/drivers/net/ethernet/lantiq_etop.c
index 3e9937c7371a..1458796c4e30 100644
--- a/drivers/net/ethernet/lantiq_etop.c
+++ b/drivers/net/ethernet/lantiq_etop.c
@@ -686,24 +686,7 @@ static struct platform_driver ltq_mii_driver = {
 	},
 };
 
-static int __init
-init_ltq_etop(void)
-{
-	int ret = platform_driver_probe(&ltq_mii_driver, ltq_etop_probe);
-
-	if (ret)
-		pr_err("ltq_etop: Error registering platform driver!");
-	return ret;
-}
-
-static void __exit
-exit_ltq_etop(void)
-{
-	platform_driver_unregister(&ltq_mii_driver);
-}
-
-module_init(init_ltq_etop);
-module_exit(exit_ltq_etop);
+module_platform_driver_probe(&ltq_mii_driver, ltq_etop_probe);
 
 MODULE_AUTHOR("John Crispin <blogic@openwrt.org>");
 MODULE_DESCRIPTION("Lantiq SoC ETOP");
-- 
2.46.2


