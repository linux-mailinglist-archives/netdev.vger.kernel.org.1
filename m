Return-Path: <netdev+bounces-88836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1CD8A8ACF
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 20:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 251AD282031
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 18:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E940F173328;
	Wed, 17 Apr 2024 18:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sbKord8I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30001173324
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 18:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713377330; cv=none; b=uu5smaXa6hoOGqPC3BeyxjP6RJNmMoMfL2EQZXFGK5CjunDsY7LoNuE9AR9uix9+YcVF3BhVxPsjtBCE4mLiJhUlp+1xdV44Ru7cuFCyVc/6c6d5sdn9avKQuVN4Mi8qvSyWVSVEZrgUWrIr7BBXorYJWyNoiDGEkx9tGVLiRu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713377330; c=relaxed/simple;
	bh=uJ5v1jt/3xrupY2eFoZwiWpvIRIEsIFpdqRkLLBC03s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Vya0GzdmBhVyQafdXAxp4mCUp5y0wCUOZ1ldfClyLL1NDmOwnyATM5arqxN44k5N8poAs8QKhppS1UFToWuQAdjg2x9C6FxO/aZkz7xJZI/o5LnZ/GwvxhB9kfzwLOtIl2Bzsto4pEbxRdJReLTESWy62xa8YmDx3HbHQ+H8NgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sbKord8I; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-570175e8e6fso6051165a12.3
        for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 11:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713377327; x=1713982127; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=smloynM7fJQsDmi6Ly/M7gsorOUchbbkFXvOhhW/pH8=;
        b=sbKord8II0+VtrEtikbY/lT5v4XUuLInpa5MJdtDLdIqbrxhsb2nt022U1U6HBdw39
         ji2Yr7OlqvAoTUNIf6rRSpkkyNoj2zgQcQhCzMjEaZvgo8cUEDP7RRfjpfF+hTdv20gl
         1013kKXKkAfSt0aYtxffhW4l2bmqcz0a7s9675zIUPJYtAsIKgDNzujlEt+2JP120a9f
         fSzdrD4yYIjeBk/C/CawIW9XyzCgAA4COTC7oLUO0NmAyt8VzFWDah8AMTpsNHoySTJ3
         /6C/KuAAOBjJBkdqGc9cf0+YjXFgWMvY+Y76MEONt2FGgCOIT0/yUhJTf+/6P0vcOV1s
         bWMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713377327; x=1713982127;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=smloynM7fJQsDmi6Ly/M7gsorOUchbbkFXvOhhW/pH8=;
        b=HTWUzXzyLi5/zXkAy8EU1DBjsDf1fWKviWVyeu8lNTuP22RR7+/nKxE1As/Uus9JhT
         JFlfgaAU27emi3ngYChsWjuYxIN0lcV6/ZNFb5Hl7w5Zk+AAnWIp7kbWnnmNO02XKeI2
         BALHdlCc2vfr5mgLjFRLJBuKg+5JYwsjVCWsddZGwqJs5UzmJF4YwQzE97vBRCM1tr6A
         ZYd8MkCnIpEMD40oxvujc1lL8C2DsyRgN+OC8uhsg/BdpRg7MnHuraL9yQqdTRhlQocQ
         plf4yU7rBm9lzQdTQwXYI1n5emimOYiZ2cPVoo7rcClB52yey0pVkbh+AlLv91T8QJi2
         kRwg==
X-Forwarded-Encrypted: i=1; AJvYcCWNOw/F7O33dyeR8vWor0WwYetIDkMogYiuhZ1E5r0bfHiYdj76s1EAD3UZmIs7YIVgjUBnBpX5vV4lInoPcLbhei2K+5ls
X-Gm-Message-State: AOJu0YyYUd4Lxsr8Zr8UOTfDf3sIoFDxs/xPVgKKvJVIvzfYEvki8LYd
	Ps02v8dmVVKocNGr/5PdYJvgJi6Vi/pMN0ys1/XcFOwDq3ffVmpfy7jqf1irlSw=
X-Google-Smtp-Source: AGHT+IGhJiNkCMkOyGk0LfZLLEky0z09T9gj2Uq8zgjLyWia0fsntM3spbqybvS4qSutvJ6D3xpwGw==
X-Received: by 2002:a17:906:3491:b0:a51:a06e:afd1 with SMTP id g17-20020a170906349100b00a51a06eafd1mr187751ejb.23.1713377327128;
        Wed, 17 Apr 2024 11:08:47 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id gs16-20020a170906f19000b00a4e48e52ecbsm598618ejb.198.2024.04.17.11.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 11:08:46 -0700 (PDT)
Date: Wed, 17 Apr 2024 21:08:41 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Geetha sowjanya <gakula@marvell.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com
Subject: Re: [net-next PATCH 5/9] octeontx2-af: Add packet path between
 representor and VF
Message-ID: <bd981ef9-f888-4cba-8fdb-46738198105a@moroto.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416050616.6056-6-gakula@marvell.com>

Hi Geetha,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Geetha-sowjanya/octeontx2-pf-Refactoring-RVU-driver/20240416-131052
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240416050616.6056-6-gakula%40marvell.com
patch subject: [net-next PATCH 5/9] octeontx2-af: Add packet path between representor and VF
config: alpha-randconfig-r081-20240417 (https://download.01.org/0day-ci/archive/20240417/202404172319.ys4PQfP0-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202404172319.ys4PQfP0-lkp@intel.com/

smatch warnings:
drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c:23 rvu_rep_get_vlan_id() warn: signedness bug returning '(-19)'

vim +23 drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c

5c25d7a685d906 Geetha sowjanya 2024-04-16  16  static u16 rvu_rep_get_vlan_id(struct rvu *rvu, u16 pcifunc)
                                                      ^^^
u16 type

5c25d7a685d906 Geetha sowjanya 2024-04-16  17  {
5c25d7a685d906 Geetha sowjanya 2024-04-16  18  	int id;
5c25d7a685d906 Geetha sowjanya 2024-04-16  19  
5c25d7a685d906 Geetha sowjanya 2024-04-16  20  	for (id = 0; id < rvu->rep_cnt; id++)
5c25d7a685d906 Geetha sowjanya 2024-04-16  21  		if (rvu->rep2pfvf_map[id] == pcifunc)
5c25d7a685d906 Geetha sowjanya 2024-04-16  22  			return id;
5c25d7a685d906 Geetha sowjanya 2024-04-16 @23  	return -ENODEV;
                                                ^^^^^^^^^^^^^^

5c25d7a685d906 Geetha sowjanya 2024-04-16  24  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


