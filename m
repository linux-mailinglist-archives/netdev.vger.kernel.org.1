Return-Path: <netdev+bounces-74359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6BE86103D
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 12:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03E301F22EF2
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 11:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D568692E0;
	Fri, 23 Feb 2024 11:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E9J6PLby"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBB6651BD
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 11:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708687298; cv=none; b=rru9wVyiiBui1Y0u8lZQk6o9M4ixlf/i/A8hqjnFo8of7jYnl9PQGSkWziZn7xG4tt/0Ckfbz+w0d0MRCSccLshDABIypPgnYfMRmcdL/pcM/+4ARDg6VK4MXaxSVnQFC6D/KTdp7h7itUo1XSSUsF7OBt7r4bSF/6aWXKXuX7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708687298; c=relaxed/simple;
	bh=MGjiNoY5/PZus3tHurBrNW463HaZZAyrMoHg2GAQPfI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=fImKH4Maz86+ito3f/Fj4v0WCYJNkYygdKH5rANW4uMkS7YUAb6+gcWPOPmGTkc2tSJkjkhcijtlC0r+o9rt/HAu5QZgB8+MARw/up3JpY0SS9NQ2uv4zFVMWqf6AU/McQyOWzNfJqNsa5bHUVYBaTujwEMWixZP77mgxFWacyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E9J6PLby; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-412698ac6f9so1579065e9.0
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 03:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708687295; x=1709292095; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PIi3EjXiGTvmOHi052KsOnRzwJ+f4mQvPVKEwEMfxSE=;
        b=E9J6PLbyxU3SxXfRiqmCejtk3OnxuI7XzLmH1SuDvADEkcyTgoWsA1hhH+i6r0KZGV
         YGELgLEmLtUjmxqy38hZben9gmtqYwF3+O8te3zqpDxIWi5ANHYloZCIhYHsPTn2YXet
         491EH8a7kxzBd8CyZHes89oaU+cStUgNpBKtu6GHSrOrVMtlpzs+kD20TkBynZuNOsSp
         Pvg7fSGXmJ4pFKNgogc5HxbKQaWp60FbCmC64Gs6HAJa9Il6Gn8n3Qo5pJJ4sK096Ffu
         dOxVkNdCPyYUTwuknGscLjnara4Z7FGdLP8mC59wFdlSVkVVi8c11YqHVGIPa24phvbC
         TP8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708687295; x=1709292095;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PIi3EjXiGTvmOHi052KsOnRzwJ+f4mQvPVKEwEMfxSE=;
        b=uNtQ0vYvLYcHnooYJTLb10Izkmmbg4hqIvA/U/20u3tqmiJMpSUDEaQ32cc08ZxtSv
         HnphWflzakplyiNRU3+sEzoeODSh2RHGmyW2r00Wi48KP+B5z7kthOiSUPCWaWJWcK4K
         eCw8S0vhdD7dGn89ctUlrGzxCukNiL6BBWbg1jPRi8KaH+RZPGcllWO4IFTz1dia4uYt
         EMzuz9oRaUASPIgynSktVFzB6fDfml054xGRAIUusnWgxN+J6WVAL12E7PXXzmFBkzi5
         QC210W77OcTR7sENiwy5wmtia2RpFCisHnxh+r/66i2hQH1uhX1+Yg/KDK8JiF63XjYx
         OjeA==
X-Forwarded-Encrypted: i=1; AJvYcCU8FiQ85cLlGZCtvGzXtb5dltgqlpqWRefNSKyKXHIjq/ytMrt5bM3HBLrsnj2zV+to9tYBklH6PvRjwv5ZAe/DQM2Ow89q
X-Gm-Message-State: AOJu0YxC8jAHOTHzuhQ5PTwkStyYXjJcqHOTXI+dg3yf8sndEkAmf1Je
	Ye3LgWw7kkbZaf03JI4j6jxYWFvQzxkHipl2E3YA9Z7T1Y9cl83m1OZhIomB2v8=
X-Google-Smtp-Source: AGHT+IG4bZr5EDo019kifBFU9QxI2IvQOaqdQNrKdAU6Y2UFtTCbZamMDyhboFxCGoxcWL3sjymYGw==
X-Received: by 2002:adf:da41:0:b0:33d:7e9:9543 with SMTP id r1-20020adfda41000000b0033d07e99543mr1358279wrl.32.1708687294766;
        Fri, 23 Feb 2024 03:21:34 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id b8-20020a5d4b88000000b0033cfc035940sm2426016wrt.34.2024.02.23.03.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 03:21:34 -0800 (PST)
Date: Fri, 23 Feb 2024 14:21:30 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Joe Damato <jdamato@fastly.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	Joe Damato <jdamato@fastly.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH net-next 1/2] netdev-genl: Add ifname for queue and NAPI
 APIs
Message-ID: <5f3777e9-c056-4765-9d43-9338a11c1703@moroto.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1708531057-67392-2-git-send-email-jdamato@fastly.com>

Hi Joe,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Joe-Damato/netdev-genl-Add-ifname-for-queue-and-NAPI-APIs/20240222-000134
base:   net-next/main
patch link:    https://lore.kernel.org/r/1708531057-67392-2-git-send-email-jdamato%40fastly.com
patch subject: [PATCH net-next 1/2] netdev-genl: Add ifname for queue and NAPI APIs
config: i386-randconfig-141-20240222 (https://download.01.org/0day-ci/archive/20240223/202402231851.2NeORqwi-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202402231851.2NeORqwi-lkp@intel.com/

New smatch warnings:
net/core/netdev-genl.c:388 netdev_nl_queue_get_doit() error: uninitialized symbol 'ifname'.

vim +/ifname +388 net/core/netdev-genl.c

bc877956272f05 Amritha Nambiar 2023-12-01  371  int netdev_nl_queue_get_doit(struct sk_buff *skb, struct genl_info *info)
bc877956272f05 Amritha Nambiar 2023-12-01  372  {
6b6171db7fc8f7 Amritha Nambiar 2023-12-01  373  	u32 q_id, q_type, ifindex;
6b6171db7fc8f7 Amritha Nambiar 2023-12-01  374  	struct net_device *netdev;
6b6171db7fc8f7 Amritha Nambiar 2023-12-01  375  	struct sk_buff *rsp;
f340b224321fa6 Joe Damato      2024-02-21  376  	char *ifname;
6b6171db7fc8f7 Amritha Nambiar 2023-12-01  377  	int err;
6b6171db7fc8f7 Amritha Nambiar 2023-12-01  378  
6b6171db7fc8f7 Amritha Nambiar 2023-12-01  379  	if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_ID) ||
6b6171db7fc8f7 Amritha Nambiar 2023-12-01  380  	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_TYPE) ||
f340b224321fa6 Joe Damato      2024-02-21  381  	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_IFINDEX) ||
f340b224321fa6 Joe Damato      2024-02-21  382  	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_IFNAME))
6b6171db7fc8f7 Amritha Nambiar 2023-12-01  383  		return -EINVAL;
6b6171db7fc8f7 Amritha Nambiar 2023-12-01  384  
6b6171db7fc8f7 Amritha Nambiar 2023-12-01  385  	q_id = nla_get_u32(info->attrs[NETDEV_A_QUEUE_ID]);
6b6171db7fc8f7 Amritha Nambiar 2023-12-01  386  	q_type = nla_get_u32(info->attrs[NETDEV_A_QUEUE_TYPE]);
6b6171db7fc8f7 Amritha Nambiar 2023-12-01  387  	ifindex = nla_get_u32(info->attrs[NETDEV_A_QUEUE_IFINDEX]);
f340b224321fa6 Joe Damato      2024-02-21 @388  	nla_strscpy(ifname, info->attrs[NETDEV_A_QUEUE_IFNAME], IFNAMSIZ);
                                                                    ^^^^^^
missing initialization

6b6171db7fc8f7 Amritha Nambiar 2023-12-01  389  
6b6171db7fc8f7 Amritha Nambiar 2023-12-01  390  	rsp = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
6b6171db7fc8f7 Amritha Nambiar 2023-12-01  391  	if (!rsp)
6b6171db7fc8f7 Amritha Nambiar 2023-12-01  392  		return -ENOMEM;
6b6171db7fc8f7 Amritha Nambiar 2023-12-01  393  
6b6171db7fc8f7 Amritha Nambiar 2023-12-01  394  	rtnl_lock();
6b6171db7fc8f7 Amritha Nambiar 2023-12-01  395  
6b6171db7fc8f7 Amritha Nambiar 2023-12-01  396  	netdev = __dev_get_by_index(genl_info_net(info), ifindex);
f340b224321fa6 Joe Damato      2024-02-21  397  
f340b224321fa6 Joe Damato      2024-02-21  398  	if (strcmp(netdev->name, ifname)) {
f340b224321fa6 Joe Damato      2024-02-21  399  		err = -ENODEV;
f340b224321fa6 Joe Damato      2024-02-21  400  	} else {
6b6171db7fc8f7 Amritha Nambiar 2023-12-01  401  		if (netdev)
6b6171db7fc8f7 Amritha Nambiar 2023-12-01  402  			err = netdev_nl_queue_fill(rsp, netdev, q_id, q_type, info);
6b6171db7fc8f7 Amritha Nambiar 2023-12-01  403  		else
6b6171db7fc8f7 Amritha Nambiar 2023-12-01  404  			err = -ENODEV;
f340b224321fa6 Joe Damato      2024-02-21  405  	}
6b6171db7fc8f7 Amritha Nambiar 2023-12-01  406  
6b6171db7fc8f7 Amritha Nambiar 2023-12-01  407  	rtnl_unlock();
6b6171db7fc8f7 Amritha Nambiar 2023-12-01  408  
6b6171db7fc8f7 Amritha Nambiar 2023-12-01  409  	if (err)
6b6171db7fc8f7 Amritha Nambiar 2023-12-01  410  		goto err_free_msg;
6b6171db7fc8f7 Amritha Nambiar 2023-12-01  411  
6b6171db7fc8f7 Amritha Nambiar 2023-12-01  412  	return genlmsg_reply(rsp, info);
6b6171db7fc8f7 Amritha Nambiar 2023-12-01  413  
6b6171db7fc8f7 Amritha Nambiar 2023-12-01  414  err_free_msg:
6b6171db7fc8f7 Amritha Nambiar 2023-12-01  415  	nlmsg_free(rsp);
6b6171db7fc8f7 Amritha Nambiar 2023-12-01  416  	return err;
6b6171db7fc8f7 Amritha Nambiar 2023-12-01  417  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


