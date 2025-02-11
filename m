Return-Path: <netdev+bounces-165226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E838AA31190
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 17:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A29293A41AD
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 16:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95C2255E25;
	Tue, 11 Feb 2025 16:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXQ8MtrC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68404255E32
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 16:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739291579; cv=none; b=esT9Oep9JW7n+WG7kbklKpcBsOacxorbSIV2aGMDtxVAMpNiEQWUrtuoKb4LimTazZ1woVTWrsDF0NQqf5QWaIAjCqz4NL1xSvPPDvs8IpWzGYL/7bQhLkl1HFYvoQN6GSWelEOkqGnrCbA5IOizKvS6QuIj7AOeIh6rdjbCRM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739291579; c=relaxed/simple;
	bh=e85HWHgoBQOm4j1abf5gLl/lX/2Ykg2xZnhWLvM8Vdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OsOkf1Z2wjLa2ULkrxqm5j8QJVprr1F95fuSszuqB8cynYzDxKCxUUURL8eamgHKI+2zCBOBFUyViZFSve8rERRcGidHyZzT8j4m13Q7220lmdVDPMCv3TCQxw8jU/R+wQzHUIst/0F8ZNM6mdgrIp2t2CIVe8rTVZTIQjIh9KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QXQ8MtrC; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21f6a47d617so57557935ad.2
        for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 08:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739291578; x=1739896378; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A5/z+2AkX14OVBfSBzvANjsGUw8qqOk+bTDpMOl03dA=;
        b=QXQ8MtrCzGWB2wV1+gPeUG6iK7J9oLE78yzWX3/n5Aao5y8PrmdSZqpZJVzpY8+wu9
         ZvFZJJu75BNlNggotwJcIVAx+zfFr/lF5fO4DIRzvRVhucqtqCX5k+C6U98qhkhngSTp
         m5VgkisNti/W0SqU3f1y8TlhmOAiH/ML7U0perQdJb9DpDEEj1yf1Kt2mRjT+ohrKAUM
         o/zYI43eA9XCABv8jZsE68WXrvo9OKD3fJm4AF5L9tBrBWXj6AeanYIAxRAa1F07UEEh
         b25nTaQhLRqNdcnvzlsi+vpJdqBNa1K2DkhQCaeJfG/J19js8jrc2gkIjylyBB3AojbH
         8UhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739291578; x=1739896378;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A5/z+2AkX14OVBfSBzvANjsGUw8qqOk+bTDpMOl03dA=;
        b=jNIRJRogom2bDjT7uk/ESuf6NO4reABW+bq59Kht63hK8Pkmucg/C0jbqjqcevskEq
         q5V5XTJ/IwoDx7nd9Aer6+iqML8HDtAC805Pg9qZaAyq3EFsIBH/efl6GpjYYPmOkoZc
         e4ppnZnSK1Hiy62j3hnZSalDB+LkXL1pMbYoJDQLaMAvscU09upEC7hJBnkb96Q9D+jH
         BBe2BlOEv9Vy/ZBREEYGG+AUjKBnObVEyj0JuM5kVUshCYVBZw+djkP6vfEoEeyWFSY6
         pbnB7iZ/XS9KGf6pHSYQBN3IRck1gYS6k+zJWPXyhErRlZkW6Ue+00Qwq47xlpswl1p2
         NOAg==
X-Forwarded-Encrypted: i=1; AJvYcCXLTGJu7xu7faAU4BC5Ynlfb0Nyp9GciAxe6OU0Fwib3AikmZMSROx2vm1PzYBkLNBIf6J+72Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOgNKdSHdS8fcy4/V0scJiDjsSAlwMEPnj/swBVi5JJ7AGHSSV
	OlAi6ohs3orL0EU1sHLokqafULbniCO37I0SI3hQh5F3jbwE38k=
X-Gm-Gg: ASbGncurKKvE9QovnX6cJb4Xi5uJbACp0VjPYKIAHFbmxJBRUFi1eXlsi3G2MsX9TST
	Z6Zr7/qwmVbZtA50hVsTeDYZQob4SaD6Df1MNoSJHsVtDaMY9g1+IiI7C3ln7vRpJoX5K16SXpX
	GSadSBzFf53hOCB3fHj/lCXgYR5S4Th+9zB0TnnBbEejICW5VzkhUJeou1lSmcdr2408RKl7YoF
	A/Q5hu/fTGbyuedbY3m8KvNQ1JrMyf1CYUvaGKLKgPK9dWO1bzwwttjhF/MtrIU7vMIYQFLTrGt
	0CEorcpfnjvzIlY=
X-Google-Smtp-Source: AGHT+IFat0G7HhNeYeKUsWDr3KgwrFNW75mw6kVWT17FjiObx98gq2CIoJqz/DfNT9Aw37wUcqQYYw==
X-Received: by 2002:a05:6a21:b8b:b0:1d9:3957:8a14 with SMTP id adf61e73a8af0-1ee03a21cfemr31578020637.1.1739291576165;
        Tue, 11 Feb 2025 08:32:56 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73048a9d7aesm9591487b3a.33.2025.02.11.08.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 08:32:55 -0800 (PST)
Date: Tue, 11 Feb 2025 08:32:54 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: kernel test robot <lkp@intel.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	oe-kbuild-all@lists.linux.dev, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>
Subject: Re: [PATCH net-next 04/11] net: hold netdev instance lock during
 rtnetlink operations
Message-ID: <Z6t7tlSr8W9SznXO@mini-arch>
References: <20250210192043.439074-5-sdf@fomichev.me>
 <202502112254.DdkYlmMx-lkp@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202502112254.DdkYlmMx-lkp@intel.com>

On 02/11, kernel test robot wrote:
> Hi Stanislav,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on net-next/main]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Stanislav-Fomichev/net-hold-netdev-instance-lock-during-ndo_open-ndo_stop/20250211-032336
> base:   net-next/main
> patch link:    https://lore.kernel.org/r/20250210192043.439074-5-sdf%40fomichev.me
> patch subject: [PATCH net-next 04/11] net: hold netdev instance lock during rtnetlink operations
> config: arc-randconfig-001-20250211 (https://download.01.org/0day-ci/archive/20250211/202502112254.DdkYlmMx-lkp@intel.com/config)
> compiler: arceb-elf-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250211/202502112254.DdkYlmMx-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202502112254.DdkYlmMx-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    net/core/dev.c: In function 'dev_set_mtu':
>    net/core/dev.c:9320:15: error: implicit declaration of function 'netdev_set_mtu_ext_locked'; did you mean 'netdev_ops_assert_locked'? [-Werror=implicit-function-declaration]
>     9320 |         err = netdev_set_mtu_ext_locked(dev, new_mtu, &extack);
>          |               ^~~~~~~~~~~~~~~~~~~~~~~~~
>          |               netdev_ops_assert_locked
>    net/core/dev.c: At top level:

Looks like my rebase error, will fix it in v2. Should hopefully not
affect the review overall..

