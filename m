Return-Path: <netdev+bounces-226363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5B2B9F919
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 15:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FB313AA179
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 13:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1731F542A;
	Thu, 25 Sep 2025 13:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kfMZnx4P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E180A1A83F9
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 13:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758806900; cv=none; b=lMKf5O3WT/5FF54PHKUMIG/9v3AV6MTcJIG+YvqSvFLCO0JhPfssNyXrZmKwyRYUdBFqai67FZP1p0ba+x10a7SMuxit+3HXJ4ElH2KNHYVbLj2WS2RwUp8cWtN9yUbEMfLceJgjqr0pN9ZzPici2zF41OxJNtwZFQLyw7stBFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758806900; c=relaxed/simple;
	bh=flAw5KKjXu42FlukgIcjdTtfBFEAB68+Z4z5lvAgfpE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lz+vs/4Eea+T1TBuxSuI2wtd3oHMKNthqzEvg0ULCE96KAeMfmjxwqvUY4ToG7f2fu/v4qFDX0VduuNrbh71ZzMP1rKtStIoiYX0XX2L6P/jIgVngDIqPEyCcYU9ngLcXLJXd2LiyFlgaikJWlzGufjA7poZF+IqCEQutNxJxCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kfMZnx4P; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46e34bd8eb2so7436955e9.3
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 06:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758806897; x=1759411697; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LhZs0QbdJYRw6FSQz/b2p4quCXTn98S2BMBiWzLFh48=;
        b=kfMZnx4P99A4TvCSgt8C9naZK1lYcSYm8N3ZkFkGs9Nfi7o+r4PYy8N8/syHwh7h+z
         Qi8xFpGiqi0YcSRnUUmKFFBqxaNKdwxN6/fSTqXgaMyq3OxmQXlYb21BvHVD/hcc62al
         VZJwglDUcBq5LsgXRTt8U/4BY6dj7Mo5CYc9reOHSoPZDIvXeISQHW5rgwssPdM0l4ys
         U6N6hGPSxY1S/KaPDJCmq+88MvT8oVsjOUpMf4BRKAXau6dnI/qI9alfL7nNJD3+Kifw
         I5/Tb0NOfa0SOI2BEKkG3ttfD2tAKXAXbZfL2dKLmwH24hiwLIexeLWtQoD1QAPMkFVF
         Hfug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758806897; x=1759411697;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LhZs0QbdJYRw6FSQz/b2p4quCXTn98S2BMBiWzLFh48=;
        b=iM9L+5Nwwh9E9wwIpztmn+IpleqV/1ES3ruVTDsxj+PVszGehk7r8B0QFVpopR5SsV
         YigXI3v8vsAHu07vI1q+b0XHsMznhCSYIZNIxftxfxqnfzZDAinSy0Od6K78DCji8cq/
         F/AVxGX/h4Cz0s5ZE8+6te+AkNxsA21CCfpwHxINu8y9mr6hqPSCRJB5LTG1TYBlrySl
         SOnN7WPWNPhTpg72/CHUanuO18jeIcpjGE8u1farraJXJuL8y0A6AMSknpSVwfB2BFoO
         TroC62DypW1uUCtmw2Wf06D1qPc2G88ZmsnTaF8msp3JWpjo593F4VwJ862KSKsEAQFK
         LSkw==
X-Forwarded-Encrypted: i=1; AJvYcCU1EURr3f4n71kaM+cZxOEHYqZosYRJF2ZgEshQUaK5Fhl5pae46z0lCba7kj7V7uKsnAb9pPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGVHf8cNrlpjIj7+fBW/fLc4EYUK53HSviG+xRV/pB6q3SuAl/
	7uFLB6tQEgbgaT2nrtXIy1IZ84Fp7eMgXYSRSZm/e+53drIIbtEvk6tYLXjq9zQFOwQ=
X-Gm-Gg: ASbGncvDz7oVE5uDVO/Zk0jRq+WkXK4dIpd95tLmmnwPA6zOn+5tree87rrBmjvmntb
	zqSREvhhySwqHyxT8swcVncelFNDE0o9NyjDW7Q2px4+Rx0rV2OTUKP5DTWZDOosvIS1u2ugYTu
	yqdMsOPKZLxZ/0Jal5M8HcCvQ+BL0UUfyzGfJ0f41FfByiiELqIjdLsVz3xSDYShHf6j8xbDKfk
	y2CdN4wywfoEW8WDfq16vpqDa/hqO/8zoTpkShQ0sjtySsPLQs9ODEScPrhhihmQ+aGIwpzwHHi
	l/25ruAA9iFp/+sBTkVUhUcc4VXpt+qRA/K9Z4bvTyqBfA2CSVfY0vtUWJIWITSMH6hxz72VGz2
	UwADyzW+JgBQYpwilHPdIUdzlIFwP
X-Google-Smtp-Source: AGHT+IE8huo9gSXYF3zbdT3uLvSy0gSrDiXlprLcEpyFX1ppWGNriITL3c4SgFMXRwSFCbcgfglmbg==
X-Received: by 2002:a5d:64e8:0:b0:3ff:17ac:a34b with SMTP id ffacd0b85a97d-40e499acbf7mr3135758f8f.42.1758806897199;
        Thu, 25 Sep 2025 06:28:17 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-40fc7e2c6b3sm3257259f8f.54.2025.09.25.06.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 06:28:16 -0700 (PDT)
Date: Thu, 25 Sep 2025 16:28:13 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: Prathosh Satish <Prathosh.Satish@microchip.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH v2 net-next] dpll: zl3073x: Fix double free in
 zl3073x_devlink_flash_update()
Message-ID: <aNVDbcIQq4RmU_fl@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The zl3073x_devlink_flash_prepare() function calls zl3073x_fw_free() and
the caller, zl3073x_devlink_flash_update(), also calls that same free
function so it leads to a double free.  Delete the extra free.

Fixes: a1e891fe4ae8 ("dpll: zl3073x: Implement devlink flash callback")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Ivan Vecera <ivecera@redhat.com>
---
v2: Fix the commit message.  Words in wrong order == nonsense.

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

