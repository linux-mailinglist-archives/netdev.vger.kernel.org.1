Return-Path: <netdev+bounces-199162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FE5ADF3AE
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 19:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B003D4A0070
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 17:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6B22EE5E9;
	Wed, 18 Jun 2025 17:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ExCcmEt7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0410B2F1980
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 17:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750267620; cv=none; b=lO+uO61k82lcXunJmL6fEk0t5Z2CRE/vbg9vcuSq6MtjEQ3M7F8gDbDr2O9AF3nfEFiSmdKXnWeV9TywnmasB1bjRfQds3E3a6shCqCqtFxPwZO3wV1rnliFJdOkhuQVr2JgiHac+MjVIUszK2DwfZEVzITm+kzVumNxYZgJgi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750267620; c=relaxed/simple;
	bh=J+BqwMFmKcN19hQQ3aT9eKAwy1PnKrQMbSUnQLnRrRI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=saaTADJb442+TKJToANRG5td+LaP0kw61xwGkIInHGCpaqkQsS2yOYN81DecKc56YuV009k4i13rmG1Q3tnkHok6P9HKntW/nMmERY2vMhhHi2R7x8Kaat8ZNEL/bm/oNDdcS5sYx5+gNO7yHGI+xr85rOuVKTIXQE6zUH/0UU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ExCcmEt7; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-735a6faec9eso4276102a34.3
        for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 10:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750267618; x=1750872418; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6p/EuXGOB6YYcPGLEVBf9Y7M5MlRj/BCkj3EsNFJrV8=;
        b=ExCcmEt7QmOfyUwyLYxRx+HhgwPbPxK7N2c9ZLkfSM2IIUnZwY7ufRKHXkSS1DcozT
         +3sGB1Jg6oNi/hF3wDg9yfKRbl58x0MsSjffEWHv4klpvzZ5JzY7ceii/zUCj17Gq9l8
         j3cxwd0Js/sbmVGv6F/ilYk0zYCp//hxlV9bRVT8DdF3L15TffCZTk7YxxG7yWdjWqqv
         tsn3qTjO1l0kH0/rWL7vULt9cFARTaE23T+k/ZEevjM4kbHqN6/Uk3MLYx6U6VN4++aJ
         jXwudLUHrDBNirphbHihu39YTIFxmdge7TzUrAYsIY8Ro+3+6L8hb0GxAkrCdN13ldZK
         WCeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750267618; x=1750872418;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6p/EuXGOB6YYcPGLEVBf9Y7M5MlRj/BCkj3EsNFJrV8=;
        b=TR0vWiQjQtnTz1Z4+kgZAKmfYTnffamZxRIXl94fAeUP07PUc/MIsr2+WNQhBz+t5X
         ylfJ+wKwhdq7v9kXmSnoEUjzJNBXRRTwsop0/LN+xKDRIh+P6Vf1WnESQSUHOVYuZDim
         1Gg/FR1+LtjS1ncPsnLIAUCwu2QzgxRA0m03KD9+JEIZLBaE5uuQnPR8iRFrJ7FsC93s
         DbvEAJptJCkcW/D17NZGDqiAdUwl7sdToFrCN25PA5pQlMP1isKBk8mnI41/GcOOm+tF
         Lbe1mRW5m9tQx14Os5Gy2uKh1mR0gyNpAbLDo3OCcVy14GLoOfan6D3Pm/eRodNDHMKW
         TG2Q==
X-Forwarded-Encrypted: i=1; AJvYcCU/2AP0A1ToPUHEefMTMdzuTtyyYVzJB3eldnDAJ9ZBWK3mRrLoIn5XJfSuF+cQrJBDKIhCNyI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy88T8EybMf9BaWT1GkgGDj5teOIj8QyOSeQN/o2gpCGW5EagfI
	Nz5oV2Zu0aHATuZJjxWWTAnaIVwLWX/XxZxlSHmmfWeTl1nObnLxNPjDlthffNhu7h4=
X-Gm-Gg: ASbGncu8SbGtbickkJWoYuYhps0GGhc3Uh6I/5FPYsgncJW2XlBKhH8ovuiwbXPzNci
	JHOp5DOzlteikj+X4HVI3JaYRlToI3AXATG7fdx1Jtus9lWtxoCuJVu17DY+hruiirNnr5yfdiN
	rusD2WpWxPASF2Y861SnNFvoA1zZQRryzCwzW6EJ1GKooWZ7FRkLatRukstO5SHKE9d7wgwD7iy
	/ZMke1wBlGoMuocOVo5CC9hetN1lF86iMNUO4GiXDyohZAnd0Z7ubC2MLpHru/QRuNAhM1t05tp
	4pCl/25FygpyQ4lbS9ihyEHOe0VtPLCZKLx1JtkV2kMAP+xd6SjuO10TJhWDivlTUrcuyw==
X-Google-Smtp-Source: AGHT+IFP0GuBKlRwXw2OJNEzq9cywJo2wUE5iUpl+qcRNZHJ6Edt+/XzOGWu0ECCFUNYcg28rXeKvA==
X-Received: by 2002:a05:6830:6219:b0:735:b4ef:acaf with SMTP id 46e09a7af769-73a36405b46mr12502515a34.27.1750267618055;
        Wed, 18 Jun 2025 10:26:58 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:1b3b:c162:aefa:da1b])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73a284039bdsm2037108a34.22.2025.06.18.10.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 10:26:57 -0700 (PDT)
Date: Wed, 18 Jun 2025 20:26:56 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 12/13] net: mctp: add gateway routing support
Message-ID: <c336c490-e002-48a8-bda7-b095ebde4c33@suswa.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611-dev-forwarding-v1-12-6b69b1feb37f@codeconstruct.com.au>

Hi Jeremy,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Jeremy-Kerr/net-mctp-don-t-use-source-cb-data-when-forwarding-ensure-pkt_type-is-set/20250611-143319
base:   0097c4195b1d0ca57d15979626c769c74747b5a0
patch link:    https://lore.kernel.org/r/20250611-dev-forwarding-v1-12-6b69b1feb37f%40codeconstruct.com.au
patch subject: [PATCH net-next 12/13] net: mctp: add gateway routing support
config: csky-randconfig-r073-20250612 (https://download.01.org/0day-ci/archive/20250613/202506131515.a5tCsTj0-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 14.3.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202506131515.a5tCsTj0-lkp@intel.com/

New smatch warnings:
net/mctp/route.c:1381 mctp_route_nlparse_common() error: uninitialized symbol 'gateway'.

vim +/gateway +1381 net/mctp/route.c

33d33bef994e518 Jeremy Kerr   2025-06-11  1350  static int mctp_route_nlparse_common(struct net *net, struct nlmsghdr *nlh,
06d2f4c583a7d89 Matt Johnston 2021-07-29  1351  				     struct netlink_ext_ack *extack,
06d2f4c583a7d89 Matt Johnston 2021-07-29  1352  				     struct nlattr **tb, struct rtmsg **rtm,
33d33bef994e518 Jeremy Kerr   2025-06-11  1353  				     struct mctp_dev **mdev,
75626016e50cb9a Jeremy Kerr   2025-06-11  1354  				     struct mctp_fq_addr *gatewayp,
33d33bef994e518 Jeremy Kerr   2025-06-11  1355  				     mctp_eid_t *daddr_start)
06d2f4c583a7d89 Matt Johnston 2021-07-29  1356  {
75626016e50cb9a Jeremy Kerr   2025-06-11  1357  	struct mctp_fq_addr *gateway;
75626016e50cb9a Jeremy Kerr   2025-06-11  1358  	unsigned int ifindex = 0;
06d2f4c583a7d89 Matt Johnston 2021-07-29  1359  	struct net_device *dev;
06d2f4c583a7d89 Matt Johnston 2021-07-29  1360  	int rc;
06d2f4c583a7d89 Matt Johnston 2021-07-29  1361  
06d2f4c583a7d89 Matt Johnston 2021-07-29  1362  	rc = nlmsg_parse(nlh, sizeof(struct rtmsg), tb, RTA_MAX,
06d2f4c583a7d89 Matt Johnston 2021-07-29  1363  			 rta_mctp_policy, extack);
06d2f4c583a7d89 Matt Johnston 2021-07-29  1364  	if (rc < 0) {
06d2f4c583a7d89 Matt Johnston 2021-07-29  1365  		NL_SET_ERR_MSG(extack, "incorrect format");
06d2f4c583a7d89 Matt Johnston 2021-07-29  1366  		return rc;
06d2f4c583a7d89 Matt Johnston 2021-07-29  1367  	}
06d2f4c583a7d89 Matt Johnston 2021-07-29  1368  
06d2f4c583a7d89 Matt Johnston 2021-07-29  1369  	if (!tb[RTA_DST]) {
06d2f4c583a7d89 Matt Johnston 2021-07-29  1370  		NL_SET_ERR_MSG(extack, "dst EID missing");
06d2f4c583a7d89 Matt Johnston 2021-07-29  1371  		return -EINVAL;
06d2f4c583a7d89 Matt Johnston 2021-07-29  1372  	}
06d2f4c583a7d89 Matt Johnston 2021-07-29  1373  	*daddr_start = nla_get_u8(tb[RTA_DST]);
06d2f4c583a7d89 Matt Johnston 2021-07-29  1374  
75626016e50cb9a Jeremy Kerr   2025-06-11  1375  	if (tb[RTA_OIF])
06d2f4c583a7d89 Matt Johnston 2021-07-29  1376  		ifindex = nla_get_u32(tb[RTA_OIF]);
06d2f4c583a7d89 Matt Johnston 2021-07-29  1377  
75626016e50cb9a Jeremy Kerr   2025-06-11  1378  	if (tb[RTA_GATEWAY])
75626016e50cb9a Jeremy Kerr   2025-06-11  1379  		gateway = nla_data(tb[RTA_GATEWAY]);

Unitialized on else path

06d2f4c583a7d89 Matt Johnston 2021-07-29  1380  
75626016e50cb9a Jeremy Kerr   2025-06-11 @1381  	if (ifindex && gateway) {
                                                                       ^^^^^^^
warning.

75626016e50cb9a Jeremy Kerr   2025-06-11  1382  		NL_SET_ERR_MSG(extack,
75626016e50cb9a Jeremy Kerr   2025-06-11  1383  			       "cannot specify both ifindex and gateway");
33d33bef994e518 Jeremy Kerr   2025-06-11  1384  		return -EINVAL;

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


