Return-Path: <netdev+bounces-203019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 997A4AF0234
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 19:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F006B48511A
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 17:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7130C27C172;
	Tue,  1 Jul 2025 17:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fQZ5pIPX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B836F1F4285
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 17:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751392447; cv=none; b=NkgqYSeP1SAHnTpNQgc/HsddKV0V6vAcAQcVpXGk6q92H3idCkSZErxyTzVn9qsvjJ4WJMR5XlfopJonUpxpG2sW2jCZarCJP4ruCks8jvgpzSGVj6KASROpfR9VcUgCLBKejAoy+TXFiZPjz44VzV1pViWg/qSNAM0Z0340UNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751392447; c=relaxed/simple;
	bh=He9gsV7YTu231JUZxvOiBPJ38zYLgw1XxhKCzprbpEg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TjaY1KJQcWIAjUIa1+SzIt4K27dwS+c70ovmTo3722W7r69rYGeeakloCT2Zc2+o3dbyyKXFsHVzT+O/ctM5bJwBvsogyh8x8bxuqiBeiR7dFiBskdh/0tcWxSR9zdMLRSy2z4kD9RJkN5HAocD9rWk28ilgI5xmn3yboZ+R7Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fQZ5pIPX; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2ef8df09ce9so1665906fac.1
        for <netdev@vger.kernel.org>; Tue, 01 Jul 2025 10:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751392445; x=1751997245; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OYtHhGcBXnPrt5Gayg4I/19Uc7rlvODk/gQ7jJJMq0o=;
        b=fQZ5pIPXg3JuhUfN3FbRUSYXRb2Tu1RGinM23ZxTwHAsBwSYroz/Q9f0ukc0SZ6Ia3
         YnjaN/0d10rGb7Io/DldoGeq/9t+DQgHGO8fH+XM4fGZP9tzaY2yjMPwiwcs0QaR+LYh
         tfGW3dWYAPfslVb7T/n9SOsNzqCnRAA8JT62xGpM7TOAT/shN9ghzEnZTy96xQueZqED
         zyKC5LTf9fQwz7+dKeA73P7NnaysJRV1rAv3nh8kTHezxlChFKjqK4ITMbqJjrBHPjd/
         Mw1h3DqBQWqlhsdRX+c3kMTf6ivljESKe2Ud6DINyYY7M8p7W9BQVMqpcyFIl3pawxRJ
         BFvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751392445; x=1751997245;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OYtHhGcBXnPrt5Gayg4I/19Uc7rlvODk/gQ7jJJMq0o=;
        b=J1b2DhJJghHseLyIWv6gwZmWvkrOz/gmDPytGprteX7RI0ztFtQN0TDhQ++a8FdL1N
         IUPxvIdMRErfRuNgOoijZxBn+MIjh5JCwLmFQejfUX0Q+5gPWdQOHqqyyQ2CzSGr4X3q
         JCsWOj0ccfnJx+v3cyag5KW8vqCPf/iC29myDDkTFUpJuKgJF6UKB1STaB/bbsZ6ZX/e
         RVjd99ms/VoLm5/rzKwX033EPsTVFRQj6+OCx4+O2wN+K6lkUif1JZzXcosht2E1oAs8
         14a9BbpNqrCoHJY7H/xL35LPLfEkT/eqZCvD/IiliXqSHuuenU6+dLNFGBAndR/LbeDH
         mJSQ==
X-Gm-Message-State: AOJu0YxxleJKCg9bd/OF9bgkevGMN4JE0VwFpuT+yWi0xA/xThHfYbcn
	M6BWUI6g9Ys1vyhPHuFBtpDDLyDlHLXTumf/hr9pE4NpJo/ID54eSjWBEsz6ryazxfugEqp6Kiu
	CPcByeIQ=
X-Gm-Gg: ASbGncsxoDV74nLC3pjD2vJBwYuVgypWPGkIKd8Ld82DgrH08Ln/Cnmp4QV/oNR0QNs
	Nrx+tQkfMKuXAG6KcWWBa2qTc0EXbp3kCcjF0JfF4W3qLjgdyr0uDzazVN9ycQJ6V6WL3TkWUSH
	Pm/e/8TzEPXJ+k5FlIRnD2iL1YB+kuMGxi23bhYbqgPD1ZA+WYKwnOQfswoQ/VTYP+G+kpuV7Qt
	lKPsodJTknnqrI1npp0P2/jGRq1RWor5omOLPZbwE+6PhIjKKgvXILA+6qPhccnUWPkn288Qp0/
	HJC7qJBI1lNkVJNcYX6U984KfCfxivD18Qoa9UUP+RsFiYeMnye8PU9bXMNkbSXCSPeP1w==
X-Google-Smtp-Source: AGHT+IG0PWAcgBcYFoaoywAe/ST8SzLPMnXqDoFEYwPJE3LQF3myJxw9WmazlBH7RLzcOBWssSNlgg==
X-Received: by 2002:a05:6870:3293:b0:2d4:ce45:6990 with SMTP id 586e51a60fabf-2efed43d837mr12277119fac.7.1751392444559;
        Tue, 01 Jul 2025 10:54:04 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:d663:8de8:cafb:14e3])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-2efd50fb14esm3393288fac.42.2025.07.01.10.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 10:54:03 -0700 (PDT)
Date: Tue, 1 Jul 2025 12:54:02 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: netdev@vger.kernel.org
Subject: [bug report] net: phy: Add support for Aeonsemi AS21xxx PHYs
Message-ID: <f3109da3-8227-4b8a-8ef8-5c3b5da8e324@sabinyo.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Christian Marangi,

Commit 830877d89edc ("net: phy: Add support for Aeonsemi AS21xxx
PHYs") from May 17, 2025 (linux-next), leads to the following Smatch
static checker warning:

	drivers/net/phy/as21xxx.c:561 aeon_ipc_sync_parity()
	error: uninitialized symbol 'ret_sts'.

drivers/net/phy/as21xxx.c
    538 static int aeon_ipc_sync_parity(struct phy_device *phydev,
    539                                 struct as21xxx_priv *priv)
    540 {
    541         u16 ret_sts;
    542         int ret;
    543 
    544         mutex_lock(&priv->ipc_lock);
    545 
    546         /* Send NOP with no parity */
    547         aeon_ipc_noop(phydev, priv, NULL);
    548 
    549         /* Reset packet parity */
    550         priv->parity_status = false;
    551 
    552         /* Send second NOP with no parity */
    553         ret = aeon_ipc_noop(phydev, priv, &ret_sts);
    554 
    555         mutex_unlock(&priv->ipc_lock);
    556 
    557         /* We expect to return -EINVAL */
    558         if (ret != -EINVAL)
    559                 return ret;

Treating -EINVAL as having a special meaning is really risky because lots
of other places return -EINVAL as well.  For example, here if
__phy_write_mmd() returns -EINVAL then "ret_sts" is not initialized.

    560 
--> 561         if ((ret_sts & AEON_IPC_STS_STATUS) != AEON_IPC_STS_STATUS_READY) {
    562                 phydev_err(phydev, "Invalid IPC status on sync parity: %x\n",
    563                            ret_sts);
    564                 return -EINVAL;
    565         }
    566 
    567         return 0;
    568 }

regards,
dan carpenter

