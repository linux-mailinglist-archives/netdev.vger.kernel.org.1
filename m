Return-Path: <netdev+bounces-139305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F569B1634
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 10:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C3511C2136B
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 08:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDF81C6F73;
	Sat, 26 Oct 2024 08:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dVj2WHM7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEED217F3F
	for <netdev@vger.kernel.org>; Sat, 26 Oct 2024 08:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729929857; cv=none; b=J+Sy5nAKXRDzHdzZEBphWkCHPybZ14YGd/wrBiIz1hcHQjkmPWRpraDH39tHMzZoUR2iSoZBWsPLCeBanmPp7cRS1NZ51CYkgUa6OqU+dpSLzIwYFKNKcB6VD7U2oKddYzAkmXUJQcEw0E5DwLHu9c7Ym7ah/+5aRh1CCVO7Ms0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729929857; c=relaxed/simple;
	bh=7DAM3QTQfqt4ZqsjC1sViPiWw7XtXvpBR1s9SbVm6iQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=XaNiBHM7kZDq1UUkivGwyTi2qP6H5iRc4UthW3rdDexnDwRVF//oROXt7WWHkWuU/9C68iOfPXGoO5FWMMnQpRE/DR/1iLbhpVCaO5Q3JpYqNuuT7iAXVolh3bq/cad1xSu1HNYY4RyOQ6dP0aDhhVeC8XYvta1P98Kj3ipoobM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dVj2WHM7; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37d538fe5f2so1961211f8f.2
        for <netdev@vger.kernel.org>; Sat, 26 Oct 2024 01:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729929852; x=1730534652; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q9IP5Ks08Nx+8LsSEs3sWLm5/UYKOm82d+7qFjkOfBU=;
        b=dVj2WHM7H0tWEM1jQFBSQkSEW9B/Ly+qSGzsWTBBAJAZBL7ODVLZgkaTXlC7XfTeJK
         diF6HO4EF5c/GBAXJ1/veMI2g4lYtbi/yYkuFdiaSQTdfILdYCh9jtWOUVXF3YLXtVxo
         fF6mwVNFAkdNiyVOcdqgQtD1WZeHeK7kwpQwnb6n4nCdB6IZg+6KHAd6KBZmphD9J0j/
         AE5ia2u29jDxV0kXM+08BvvWO1B9orzwwDom+muorphWr/2I4LuXW6L1PZzTvvaIEx5+
         tWSFyVI0VEk4nOK8pNKVEvT5a8UhHqEdcLAvmpC38U99qPrSTpw/3mHbu02BwCfEVqu4
         YNRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729929852; x=1730534652;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q9IP5Ks08Nx+8LsSEs3sWLm5/UYKOm82d+7qFjkOfBU=;
        b=PjiWDpA2gZZc8WqX3fmtb5h3/V34bU73DPekvW4wlNnZUl6GhiEuEsrF+HjNZh1sZS
         kr0AOfHie8P0tX2z98lYpBAFBA+NYuxcvsZunYhE3nTtIS20gGgSU3iE95S89bfkzcBq
         Xd2hde/vFZdokOAg477Vgm2s1pomKu28FnoTVdklBf1t65v4qN4WKWB+lXbURqOd8Ijx
         7MDxsd9itZxS2maZAkdJEhcS3Geh/MUD9krdhKsp0zWsb++iZxdBTsGye+YjMdDWJ11f
         grKXzPW1oE53EpWC1jq/n/Ydpm+8iVhYu5tnT80AGasYFiwNgx4sHLB41Ifi9D25MqtF
         w8eQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNCy62l1REcnbGnZgXKcpDAdP3ELszeYN71Hh9E9uUCipkydkoPTto74iFiOy1ChAvxPUpzcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuLaE1mMatMf1GNeqRkpzjYbZ80iQ+6X54/PlquF923y2+04iN
	pU+ObQ5mX16ZBCLPfPdVgvKBuirZmW5UZ//cenI00qC9BL/8eQmvAilILJjzIfI=
X-Google-Smtp-Source: AGHT+IFBtZYIqFDauCbN9jhSI1Fy+ciwsZmKin1yR+P7ykifdTlGgXbI8GS95lLbS0DDPAHQJO/nog==
X-Received: by 2002:adf:fe02:0:b0:368:3731:1613 with SMTP id ffacd0b85a97d-38061141c4cmr1389246f8f.13.1729929851968;
        Sat, 26 Oct 2024 01:04:11 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b70bd8sm3626473f8f.87.2024.10.26.01.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 01:04:11 -0700 (PDT)
Date: Sat, 26 Oct 2024 11:04:07 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Li Li <dualli@chromium.org>,
	dualli@google.com, corbet@lwn.net, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	donald.hunter@gmail.com, gregkh@linuxfoundation.org,
	arve@android.com, tkjos@android.com, maco@android.com,
	joel@joelfernandes.org, brauner@kernel.org, cmllamas@google.com,
	surenb@google.com, arnd@arndb.de, masahiroy@kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	netdev@vger.kernel.org, hridya@google.com, smoreland@google.com
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, kernel-team@android.com
Subject: Re: [PATCH v3 1/1] report binder txn errors via generic netlink
Message-ID: <3673df95-81d5-4d71-9b1b-9b233cfb77c0@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021182821.1259487-3-dualli@chromium.org>

Hi Li,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Li-Li/report-binder-txn-errors-via-generic-netlink/20241022-032903
base:   staging/staging-testing
patch link:    https://lore.kernel.org/r/20241021182821.1259487-3-dualli%40chromium.org
patch subject: [PATCH v3 1/1] report binder txn errors via generic netlink
config: x86_64-randconfig-161-20241024 (https://download.01.org/0day-ci/archive/20241026/202410260847.NDByoPQo-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202410260847.NDByoPQo-lkp@intel.com/

New smatch warnings:
drivers/android/binder.c:7204 init_binder_device() warn: '&binder_device->miscdev' from misc_register() not released on lines: 7204.

vim +7204 drivers/android/binder.c

ac4812c5ffbb88 Martijn Coenen    2017-02-03  7173  static int __init init_binder_device(const char *name)
ac4812c5ffbb88 Martijn Coenen    2017-02-03  7174  {
ac4812c5ffbb88 Martijn Coenen    2017-02-03  7175  	int ret;
ac4812c5ffbb88 Martijn Coenen    2017-02-03  7176  	struct binder_device *binder_device;
ac4812c5ffbb88 Martijn Coenen    2017-02-03  7177  
ac4812c5ffbb88 Martijn Coenen    2017-02-03  7178  	binder_device = kzalloc(sizeof(*binder_device), GFP_KERNEL);
ac4812c5ffbb88 Martijn Coenen    2017-02-03  7179  	if (!binder_device)
ac4812c5ffbb88 Martijn Coenen    2017-02-03  7180  		return -ENOMEM;
ac4812c5ffbb88 Martijn Coenen    2017-02-03  7181  
ac4812c5ffbb88 Martijn Coenen    2017-02-03  7182  	binder_device->miscdev.fops = &binder_fops;
ac4812c5ffbb88 Martijn Coenen    2017-02-03  7183  	binder_device->miscdev.minor = MISC_DYNAMIC_MINOR;
ac4812c5ffbb88 Martijn Coenen    2017-02-03  7184  	binder_device->miscdev.name = name;
ac4812c5ffbb88 Martijn Coenen    2017-02-03  7185  
f0fe2c0f050d31 Christian Brauner 2020-03-03  7186  	refcount_set(&binder_device->ref, 1);
ac4812c5ffbb88 Martijn Coenen    2017-02-03  7187  	binder_device->context.binder_context_mgr_uid = INVALID_UID;
ac4812c5ffbb88 Martijn Coenen    2017-02-03  7188  	binder_device->context.name = name;
c44b1231ff1170 Todd Kjos         2017-06-29  7189  	mutex_init(&binder_device->context.context_mgr_node_lock);
ac4812c5ffbb88 Martijn Coenen    2017-02-03  7190  
ac4812c5ffbb88 Martijn Coenen    2017-02-03  7191  	ret = misc_register(&binder_device->miscdev);
ac4812c5ffbb88 Martijn Coenen    2017-02-03  7192  	if (ret < 0) {
ac4812c5ffbb88 Martijn Coenen    2017-02-03  7193  		kfree(binder_device);
ac4812c5ffbb88 Martijn Coenen    2017-02-03  7194  		return ret;
ac4812c5ffbb88 Martijn Coenen    2017-02-03  7195  	}
ac4812c5ffbb88 Martijn Coenen    2017-02-03  7196  
ac4812c5ffbb88 Martijn Coenen    2017-02-03  7197  	hlist_add_head(&binder_device->hlist, &binder_devices);
ac4812c5ffbb88 Martijn Coenen    2017-02-03  7198  
39854ac9458c74 Li Li             2024-10-21  7199  	binder_device->context.report_seq = (atomic_t)ATOMIC_INIT(0);
39854ac9458c74 Li Li             2024-10-21  7200  	ret = binder_genl_init(&binder_device->context.genl_family, name);
39854ac9458c74 Li Li             2024-10-21  7201  	if (ret < 0)

Needs a misc_unregister() as well to prevent a use after free.

39854ac9458c74 Li Li             2024-10-21  7202  		kfree(binder_device);
39854ac9458c74 Li Li             2024-10-21  7203  
ac4812c5ffbb88 Martijn Coenen    2017-02-03 @7204  	return ret;
ac4812c5ffbb88 Martijn Coenen    2017-02-03  7205  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


