Return-Path: <netdev+bounces-153318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C5A9F7992
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 11:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0028A1896442
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 10:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6E1222592;
	Thu, 19 Dec 2024 10:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cqs0R2Vk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3D770830;
	Thu, 19 Dec 2024 10:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734603982; cv=none; b=cfIvdE+mFJTMCd1gjKeGQB8RsiZ2WkZHzGmrMOnBfxj3KUw6kl33sNsEaxBamqBYqd5MTW+/LUHBMN864hht3mUCy5+5lV7jWBmddlU2iA0cArctvb+RmlZcRZxVmCr5Gnv4Qa35Hnh4pt77I0fkVsGrXcTd7D3+lldBYRDrhHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734603982; c=relaxed/simple;
	bh=JBaAXYC/613rjy8IrbYF33YHJ1MUW3pMGts5COhxsms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bUls55nky8U+knd6dzZsVWH/DtteZMeQufbWNje6qnYknrEt/D9sq2xcG2axvFiFovWHmj5BgEVxh9z4dSX4FTA9mbhfM9ZLUTNq4DDhgHILlM9RU7D+tBye1N+oV/HL1XuuEoRZAdse0eR/Ki0dqBO36j9w9VQbvnGxw17W2bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cqs0R2Vk; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734603981; x=1766139981;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JBaAXYC/613rjy8IrbYF33YHJ1MUW3pMGts5COhxsms=;
  b=Cqs0R2VkZrZOHu0ySLfdv2Ied/Oj5Cf47BUjYxueW0Eaytt8f48yH/Ju
   XTLA/iyaRT7UCFrpRFyXZjfYY0o124DMrUlgRR6clRmzuzM5NdmcW5bzE
   TkcFh9LWAUvR0rQwr8zUV3RgrRWy+nt1I2GsUFGDSMmI7lvYi2ZOXYV2i
   Vj/BG/FR0RT/OtXxFoG20EwN9vD5tQw13zC3McIzUp58zMUUjRrI1GQQA
   fuHywpLaUQ23Gx4yBLvSaMwu6l/jPPSGTDs4j+sgfB5usYvOvhpjyZzIG
   xTSIzavWkPRs+OZ6p7Wy4YoO7PkJIX3p/79iPKzY2egTZAORWNMvnnOKe
   g==;
X-CSE-ConnectionGUID: +XAVbfNjQey3x5jA7PVc9w==
X-CSE-MsgGUID: tPRuFMgdQJeuSapmBNxzWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="34431764"
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; 
   d="scan'208";a="34431764"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 02:26:18 -0800
X-CSE-ConnectionGUID: RN/UiJS3Qnuy4tBWpYcRcQ==
X-CSE-MsgGUID: VK4ZnmOXSQCK4dOvFPfp+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="98625801"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 02:26:14 -0800
Date: Thu, 19 Dec 2024 11:23:12 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jijie Shao <shaojijie@huawei.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, andrew+netdev@lunn.ch,
	horms@kernel.org, shenjian15@huawei.com, wangpeiyang1@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
	salil.mehta@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND V2 net 6/7] net: hns3: fixed hclge_fetch_pf_reg
 accesses bar space out of bounds issue
Message-ID: <Z2P0EJyn80msv6/M@mev-dev.igk.intel.com>
References: <20241217010839.1742227-1-shaojijie@huawei.com>
 <20241217010839.1742227-7-shaojijie@huawei.com>
 <Z2KV37WZL7cpPYKk@mev-dev.igk.intel.com>
 <f661b60c-c271-4778-b6c2-c4c9a6e68fc5@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f661b60c-c271-4778-b6c2-c4c9a6e68fc5@redhat.com>

On Thu, Dec 19, 2024 at 10:51:08AM +0100, Paolo Abeni wrote:
> On 12/18/24 10:29, Michal Swiatkowski wrote:
> >> @@ -533,10 +533,11 @@ static int hclge_fetch_pf_reg(struct hclge_dev *hdev, void *data,
> >>  	reg_num = ARRAY_SIZE(ring_reg_addr_list);
> >>  	for (j = 0; j < kinfo->num_tqps; j++) {
> > You can define struct hnae3_queue *tqp here to limit the scope
> > (same in VF case).
> 
> @Michal, please let me refer to prior feedback from Jakub:
> 
> https://lore.kernel.org/netdev/20241028163554.7dddff8b@kernel.org/
> 
> I also agree subjective stylistic feedback should be avoided unless the
> style issue is really gross - in such a case the feedback should not be
> subjective, so the original guidance still applies ;)
> 

Sure, I thought sometimes there were a feedback about scoping, but maybe
not from the maintainers. I will drop such comments next time, thanks
for letting me know.

Side note is that by "You can define" I meant if you want, if you feel
so, not you have to (sorry, not a native speaker).
But I understand that this unnecessary slow down the process when there
is no other (valid) changes to do, so I won't do that next time.

Thanks

> Thanks,
> 
> Paolo
> 

