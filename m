Return-Path: <netdev+bounces-225572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFCA6B95969
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 13:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB9B019C218B
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 11:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA4D3218A1;
	Tue, 23 Sep 2025 11:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wssa56PB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF9230DD00
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 11:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758625990; cv=none; b=fev/2E8V+AohlYuTnBHct2DvjzFJshToh04m/Nr3lkhXW1qlgqR8APp9VyXv6yob0JSwlZCgzJDl5yelQDyv2u3ZzncXibiS57SI9KRmbovBlysNmaJDgTksCplVmFJ5rwgpmLQo5JtVeRSMs89TbOg5ecQ0R5eSr5xkUqtBfGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758625990; c=relaxed/simple;
	bh=Xu3aFhrso3x/XEZB/pUFkQq50ed8XXakXxPeuUqgUyg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HIcWkTK0zHtYMIn0Cd38Vt0evPpKDjyAx50L2wk+hm+55w6fJfrNXjj12QFlfFTDAGq5SJdnA0pjiA6E//wYMpX2BH96wQpHoSr7uDbHsLHS2D7JK+9VKzcdaOjLVjTyghcIu4CaF/GRe7OUWVdiRhROjwNVQXQupPQXjaq/5ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wssa56PB; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45ed646b656so47623195e9.3
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 04:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758625985; x=1759230785; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kPfB6vZFAN1UWmkMopxYEPmOWLUUuC+tX7ts8FDpK5M=;
        b=wssa56PB25qRd4yA0y3AsSRitOAHTtIyTAqQoQ8NdRHDjov5CO9rTtzl5gAUKP/J+Y
         90IrEzZTGDXrVfM3ABzhnBt5Uj0rbAP8OKLlMjo7PAErA46zUblb0dK4jaBpzZhRM4Oc
         mV1mFiwyPL0Y+zSXRrPSkY9leP7nQivXgAEJJNYR7F8qjwAdfdMVuGEt3sI7Ahzotjn7
         fB4NSJX7NobcMe6cUs4kwrXTBV1PH2Y9UNu9zT+6NxkjYMD6XFqzLt414bZ3EG9GkPeW
         IIVhCkT1XdctQGnPBLBTghoACjRP4bISDUyJLLddwPbaBdczlpqeDMA8xSLIruGZJmzK
         RJYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758625985; x=1759230785;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kPfB6vZFAN1UWmkMopxYEPmOWLUUuC+tX7ts8FDpK5M=;
        b=nRSjV3JVWIUyjLO2mzxsN0YTvmMN78WGMozF9q7vHOrgJDuE76WiKYXQx+ngA8aosD
         k5kp4Ina6GkQfXQuP6Vs8A6HQZZuGl5qlwcem2p3L5FgyZZTEGraXKHrlH95QkOaabiU
         FRjbyXMKuCvqprFT9nDv9Yk+1TASBa99UaoyEwh+i+TOfbS+7W/xCHW3VE8243YNNCRj
         r9V743lrr9PlM9OiBsDm3QOogcHQbZGwUsvLaiy1UeXOLV78uKNJN5Bw8R3Y44dWvyoH
         JhJdkXLqrPaElvBPzidXrKmUUFRH6OCqkw76D14ev8RbUJdSby9Tnl8DizwyGLo3rmNd
         zigQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWE8Td2n2ZbugSpiUbg16RpMnDDODZIiEhnumapNmp+avVUqQ2M+j8tJIsx/oIJLnxPebaTsE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb1iQ5fNhvp8AeemQ36L89OjYYbTtPyx4jzYhGiq5jHSFPAsGU
	gK897SulCn5LyTvDsxEj575UJX3g55PDofQo8+tDGY5k5wkx2rrXD+5kyESiCIiEUPg=
X-Gm-Gg: ASbGnctBqAb+q2DLiagquU3arUn+FUW/lBqEpgLUibnT0WeVXPgmZ8+VsExOHshoz80
	kILy32htQy5C4H607l1YwyuPxoa4h6wXlpwWXVxnsdPI7t2Y2h53bYxoTj4DVsi7Sht+qtdL7vJ
	drZzACxbhsihSXNFzqmgOIdcVEFVNpoeJMLx7+zUg56dvwVyJdphx8ECs/jIrqKj2jZTgZbGcEM
	PZ+j1Nlv0X9LPtEOEeKcSDrnGVzwczkv2LviAQ9o8vJ0cLqkShYNqGDLHVoUd2qioNcUIAl/F/2
	n545AYLoW6kD82c/HzfAtR0EhEoeBMm3CEbuSIdfhWtc0aKiEqJsk6/ilXWwAWRzxCz5CkQuSDs
	8F4+Rua4Lw25CEohvn/64o2KtxvR3ta0nM42rnC0=
X-Google-Smtp-Source: AGHT+IGkTADoNqcmQjP+QOFZr6eMBbrG7pkg/2yNv5pLWE/18q+4r2nqJqLF9iBKY05vapp9F1P7rw==
X-Received: by 2002:a05:600c:3103:b0:45d:d68c:2a36 with SMTP id 5b1f17b1804b1-46e1dac2d45mr21237175e9.27.1758625985079;
        Tue, 23 Sep 2025 04:13:05 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46e1daa4a4fsm14991665e9.1.2025.09.23.04.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 04:13:04 -0700 (PDT)
Date: Tue, 23 Sep 2025 14:13:01 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: Prathosh Satish <Prathosh.Satish@microchip.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH net-next] dpll: zl3073x: Fix double free in
 zl3073x_devlink_flash_update()
Message-ID: <aNKAvXzRqk_27k7E@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The zl3073x_devlink_flash_prepare() function calls zl3073x_fw_free()
and the caller also calls zl3073x_devlink_flash_update() so it leads
to a double free.  Delete the extra free.

Fixes: a1e891fe4ae8 ("dpll: zl3073x: Implement devlink flash callback")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/dpll/zl3073x/devlink.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dpll/zl3073x/devlink.c b/drivers/dpll/zl3073x/devlink.c
index f55d5309d4f9..ccc22332b346 100644
--- a/drivers/dpll/zl3073x/devlink.c
+++ b/drivers/dpll/zl3073x/devlink.c
@@ -167,7 +167,6 @@ zl3073x_devlink_flash_prepare(struct zl3073x_dev *zldev,
 		zl3073x_devlink_flash_notify(zldev,
 					     "Utility is missing in firmware",
 					     NULL, 0, 0);
-		zl3073x_fw_free(zlfw);
 		return -ENOEXEC;
 	}
 
-- 
2.51.0


