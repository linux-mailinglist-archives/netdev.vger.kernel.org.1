Return-Path: <netdev+bounces-159203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7885A14C43
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 10:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35DA1188B3FB
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 09:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22F11FA8E8;
	Fri, 17 Jan 2025 09:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PWzA/b6y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023D01F7910
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 09:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737106729; cv=none; b=DPlVkrcMRPhmTRWFw9G8Bfy+Hmdcis0hoQSrYpIFJ3uemWvt7kp2OgYEfLrCRECXOMROEE0lIINFNyAM5AtOrW5UY3Db/8oHkh4vUY6jwloF7XxzPE9xUjAdR7DKkKSITYpe0vL7qIFBAmul+gpwTVQZxqb79QrCAaTPU0OO3EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737106729; c=relaxed/simple;
	bh=7PIDeEtvr9uPdcgHVL0bACn5nZLTvKQ8toqwIsMpJu8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fNXIBBnteqJXcyU7k4FfWluhu9dbw42rgX4PfOAlwWwGHyPNtqV0iZqu/t8AWVTvH/V9DHT0YMR3UoTLhN30GUSlQpK5q11V9SWuP2GvOiNhPQYoFoo/tpeHSPGyYH29Q+gOseUSCCdkuzYsXsIG6wWpD06yUYT4fY+2gXL0F7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PWzA/b6y; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-385e1fcb0e1so944932f8f.2
        for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 01:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737106725; x=1737711525; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aVa2rnxV4FahyPJ4tYXvs8063pmYzJqVqaz+tJmn1sU=;
        b=PWzA/b6y1lZ69sZaTvI+Z8mh83kP2vCuyoq+Rs4bBteRPJKMLdkojew3DMQpwBgYgl
         QAPcXg3m1lf/agfhS9LgDnpHhgUgluHvzT6OKZtpYLg56zn1665iXiEgaIZXgfrKwVrd
         SnHmmq52fJ4vssbnuG4BPKdhoixi/JrgUSU3StT/hTJQV6XC8wG1jpHqw6XcbZRZsgYR
         IUsCze1zwYIQD1h7Eln/C9HY5RZwBSdFhCaAuUyXndTlbsyqn4PO/OCxRzJ8gvDfew5T
         C/8avyxfmQUzOrrqRV5RaFrVYVMoBi+J2BCug9/S9PH6cfr2pkQIMAEKISxc8cO8rwOs
         STmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737106725; x=1737711525;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aVa2rnxV4FahyPJ4tYXvs8063pmYzJqVqaz+tJmn1sU=;
        b=waSSciilba5CnPM0NX7+XGG29fl94SF05S8lXi69sCRRUtSAYhCg6OlzRpmU9/bpjd
         zpwOiVtN+gQsApR11wyy2ppZwLKU351kft5TaeKqQhZwUF5AqSbFwn1FCl/YgQTBQZa+
         7bQVOAnfwUCsYWqHkHF2766Cd+WiVm0iW/xE+xJsMvvu+4MI6vrHP+xLmO3PrItxnatD
         bY9hYVUXEgm/XjBWPoReaWn7WwCUprn9yQdO8P42E2aNKbjDblGjROKOuyO0oQ6eKSil
         m4hghKHgmzKjKtGAlzqBGkxRWheS6jcBzv4NP61Ras5R06+QqjpSXnJllrEJ0EoExx6Q
         SODQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuC6ZzsxEuCkn/Nr/ZZrD0vN6Bxc337CitZMlz4LmMlmAciH4MpUBJBZ/ikdZzBioKZ5InfOg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfglt3UGsHnIgIN+0jyxZTauOq8I5PmWcyMq8BLJqImPDaXoPM
	Zs8KTs+OxeTjqLTi6Rcu1hmJwENzK8bhxoiymQwtiQD6RDbwztGqAgl0hSqtqb0=
X-Gm-Gg: ASbGnctvvQ8pVOm+uEXw6dwXgV5l87gjGv5EbD7DpA/WpstYn4HyNiAwbYqwhmxSLLA
	oqA0nvy9P/VG4eeedJc7qiWFELg3WMfpIHVGQzC0MMhhFkbCijbmm1QYJ7whe09l3rdXhSBerch
	Fwx0xfKFA6gZCEktmW0HGa3Skii0O1pLZE2D35AoiSUGmdF3FtsnF1rxAzJlwASYImda3BFFnhy
	sy9bTtNtA/R1urXSAslc546eitRJt1zWKqzk/SSgsjl771+zyRMkON9wfb3uA==
X-Google-Smtp-Source: AGHT+IFfhDofhNGp6rNLJ+2OR7B+O+RY4aExqQfShuso+2vT/89CUvI075Q+efQl6cI00ww6Mcwsgw==
X-Received: by 2002:a5d:58ef:0:b0:386:4277:6cf1 with SMTP id ffacd0b85a97d-38bf57b380bmr1503817f8f.39.1737106725381;
        Fri, 17 Jan 2025 01:38:45 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf327556dsm2024569f8f.71.2025.01.17.01.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 01:38:44 -0800 (PST)
Date: Fri, 17 Jan 2025 12:38:41 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Christophe Ricard <christophe.ricard@gmail.com>,
	Samuel Ortiz <sameo@linux.intel.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] NFC: nci: Add bounds checking in nci_hci_create_pipe()
Message-ID: <bcf5453b-7204-4297-9c20-4d8c7dacf586@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "pipe" variable is a u8 which comes from the network.  If it's more
than 127, then it results in memory corruption in the caller,
nci_hci_connect_gate().

Cc: stable@vger.kernel.org
Fixes: a1b0b9415817 ("NFC: nci: Create pipe on specific gate in nci_hci_connect_gate")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 net/nfc/nci/hci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/nfc/nci/hci.c b/net/nfc/nci/hci.c
index de175318a3a0..082ab66f120b 100644
--- a/net/nfc/nci/hci.c
+++ b/net/nfc/nci/hci.c
@@ -542,6 +542,8 @@ static u8 nci_hci_create_pipe(struct nci_dev *ndev, u8 dest_host,
 
 	pr_debug("pipe created=%d\n", pipe);
 
+	if (pipe >= NCI_HCI_MAX_PIPES)
+		pipe = NCI_HCI_INVALID_PIPE;
 	return pipe;
 }
 
-- 
2.45.2


