Return-Path: <netdev+bounces-155402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA6CA02346
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 11:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C215F18854C4
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 10:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014251DB520;
	Mon,  6 Jan 2025 10:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r5ZArGrc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269CE1D517B
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 10:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736160124; cv=none; b=LibMswN9uVIt05mOK1AyCrm9NS4gumyi0oaGHcwELQA59J1Nq40hvyB5Wbaq23yCPf+sLlngb57mfSauYHJDBUU6WbcwKjvFSTD1v09G+i6EPORj+GIoFr7fdLScL02Z1OdWFUNmgP7gdMS5kBiNjrfQLbYGgyh2Jy85Uzbiw8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736160124; c=relaxed/simple;
	bh=O4jMmvxObEHgIUe6Et9nnMEU82aa+Erw7nSLDuYzBec=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=QiO1BCXQez4rHY/tBPeZuYWp+l2OtEYgP9u3RQ9QIRdVYJFw7mFYag1SLnbt6DE4LsZzCutOnT3a0/a6cifFPLbe6IM+9SDkInmHa/yxzr3ofk7MMB4+Xsseesph1oetQ/7v7Tp9gmzx6cSpjzkV9sM6G8jG/0S6oy1QLZ4v13A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r5ZArGrc; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43622267b2eso149257165e9.0
        for <netdev@vger.kernel.org>; Mon, 06 Jan 2025 02:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736160121; x=1736764921; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yiXs66jKfa7Mc5GaX6CeH3zxabRcvrngKVx2PovGglk=;
        b=r5ZArGrcpoIgmT1FPOFalH9MwRoiwUPRyXOmnDtbr+xNUn9OGIe18T3P/ZJ/6t3hfU
         unDRO5npToPFQ52qZojmIvhPJpLtLB21OkGOUGu66pFK6JmQUUD3QbE1HUDwsDFvL0oH
         x8a2d2qaMavXh7n7BhOcInvyo4ZkDDI9ETPXqqR7LEUydIc59w9PAS0MQ7JbflBkyRMw
         TVIys0dedFLsp2rCBU8fX8xN4vxWPaQxx4wuIZrr6P0NoaAUEzREA67ddhV7ZRTrbp9E
         4oHjXRu5WioRp7z/WSjTllxGEOiw5pbLwnK5eVqm5YlpbQUf2XjVvX0PYqCUzT1NkplD
         rBfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736160121; x=1736764921;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yiXs66jKfa7Mc5GaX6CeH3zxabRcvrngKVx2PovGglk=;
        b=MUm5JwzzByHnFvb4H5j1cD34uwDmiN+GZ5yHM1mII3TDrEHO1ZeYM3IyMrMMYmp9in
         yA/NiINpcHXaaeV5spz/4rnJD5htQIqOWQvzXxk7K/CWojPoosC+ADezEOLwFSNUZzve
         PY3lqct9SoIN6xzHwRf8LjJwGIAG4q/VJD+Y/YE2YuxCE3m+xgodl3R8f3v656le8vpM
         IbrcVPSolxZ72AonRsDNpQ3O/rQHz/0ny94Ztfa5GlAt4Ub9XI71mGwORHZI26Kh85IA
         EP/mXByL2S7mYBXT+odFcP7abdrU8Uu8aoD0E5BNuRJe5V051o/WI12tNgK/7VQ1JorC
         Cvxw==
X-Forwarded-Encrypted: i=1; AJvYcCW/89Pk2/QTOkfbgPAduYI8LYi7nzbL4g37AwxlDrG0VTM2oBjrd44oTuoyHcxBJSi5Zbpuhd4=@vger.kernel.org
X-Gm-Message-State: AOJu0YztpFROGCUMYi8R3W1PUoGd5XU7bZJ/1NezcAWdM49//ulVgFYc
	NsPcQm3KrGN1r160Qop4AmramLpwOe5svWPVLtTvJU+nIFlA0TdFvkUu/x9VfvI=
X-Gm-Gg: ASbGncshDG67Mb50b1aDeLEPS2BgjWTnwxC8769uybpDmyAeN8KYd51eJjBLDVkJ9Fz
	fdx6YhOxTYzl1tti6y8ErGUKw9zl8+FtD1qNuAei6kh0O3uqZ6TeaX8nOrcdU7CSf1xK6BapCqN
	e/8ziiP64rTop15OyXKevlIPYWUteRypByNcIW6k+pRGohqmMcS7KADoFrk4kYxoyPFx141h7Cg
	ygAY9HAwmKNsETlI8slEIzKbvyaCDWXaHLk73E1400bUfltTzluKtEWqkV4zw==
X-Google-Smtp-Source: AGHT+IFFbL3/UJS7YOsKC61qAsl6V0MH3eRyKaLo6PWURFKFeqg7gEQ4TfTlsT4jHqAfvgfc7t1paQ==
X-Received: by 2002:a05:600c:1c12:b0:431:58cd:b259 with SMTP id 5b1f17b1804b1-4366d356dfcmr520636765e9.31.1736160121445;
        Mon, 06 Jan 2025 02:42:01 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656af6cbbsm597654505e9.3.2025.01.06.02.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 02:42:00 -0800 (PST)
Date: Mon, 6 Jan 2025 13:41:58 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, alejandro.lucero-palau@amd.com,
	linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
	dan.j.williams@intel.com, martin.habets@xilinx.com,
	edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v8 06/27] cxl: add function for type2 cxl regs setup
Message-ID: <0fe103b3-76d5-47a0-900b-3769b9c59cee@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216161042.42108-7-alejandro.lucero-palau@amd.com>

Hi,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/alejandro-lucero-palau-amd-com/cxl-add-type2-device-basic-support/20241217-001923
base:   fac04efc5c793dccbd07e2d59af9f90b7fc0dca4
patch link:    https://lore.kernel.org/r/20241216161042.42108-7-alejandro.lucero-palau%40amd.com
patch subject: [PATCH v8 06/27] cxl: add function for type2 cxl regs setup
config: arm64-randconfig-r072-20241225 (https://download.01.org/0day-ci/archive/20241227/202412270320.Aydp9B4U-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202412270320.Aydp9B4U-lkp@intel.com/

smatch warnings:
drivers/cxl/core/pci.c:1134 cxl_pci_accel_setup_regs() warn: missing error code? 'rc'

vim +/rc +1134 drivers/cxl/core/pci.c

cfbd1d00295bff Alejandro Lucero 2024-12-16  1118  int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds)
cfbd1d00295bff Alejandro Lucero 2024-12-16  1119  {
cfbd1d00295bff Alejandro Lucero 2024-12-16  1120  	int rc;
cfbd1d00295bff Alejandro Lucero 2024-12-16  1121  
cfbd1d00295bff Alejandro Lucero 2024-12-16  1122  	rc = cxl_pci_setup_memdev_regs(pdev, cxlds);
cfbd1d00295bff Alejandro Lucero 2024-12-16  1123  	if (rc)
cfbd1d00295bff Alejandro Lucero 2024-12-16  1124  		return rc;
cfbd1d00295bff Alejandro Lucero 2024-12-16  1125  
cfbd1d00295bff Alejandro Lucero 2024-12-16  1126  	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
cfbd1d00295bff Alejandro Lucero 2024-12-16  1127  				&cxlds->reg_map, cxlds->capabilities);
cfbd1d00295bff Alejandro Lucero 2024-12-16  1128  	if (rc) {
cfbd1d00295bff Alejandro Lucero 2024-12-16  1129  		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
cfbd1d00295bff Alejandro Lucero 2024-12-16  1130  		return rc;
cfbd1d00295bff Alejandro Lucero 2024-12-16  1131  	}
cfbd1d00295bff Alejandro Lucero 2024-12-16  1132  
cfbd1d00295bff Alejandro Lucero 2024-12-16  1133  	if (!test_bit(CXL_CM_CAP_CAP_ID_RAS, cxlds->capabilities))
cfbd1d00295bff Alejandro Lucero 2024-12-16 @1134  		return rc;

This looks like it's supposed to be return -EPERM.

cfbd1d00295bff Alejandro Lucero 2024-12-16  1135  
cfbd1d00295bff Alejandro Lucero 2024-12-16  1136  	rc = cxl_map_component_regs(&cxlds->reg_map,
cfbd1d00295bff Alejandro Lucero 2024-12-16  1137  				    &cxlds->regs.component,
cfbd1d00295bff Alejandro Lucero 2024-12-16  1138  				    BIT(CXL_CM_CAP_CAP_ID_RAS));
cfbd1d00295bff Alejandro Lucero 2024-12-16  1139  	if (rc)
cfbd1d00295bff Alejandro Lucero 2024-12-16  1140  		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
cfbd1d00295bff Alejandro Lucero 2024-12-16  1141  
cfbd1d00295bff Alejandro Lucero 2024-12-16  1142  	return rc;
cfbd1d00295bff Alejandro Lucero 2024-12-16  1143  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


