Return-Path: <netdev+bounces-91125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9288B17B2
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 02:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FE5C286981
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 00:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C7536E;
	Thu, 25 Apr 2024 00:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SbbABz5L"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0619718D
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 00:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714003567; cv=none; b=RCdeOnYFcGCYG9A4L6iKX2m4ylCtvBnC3VcZEF3ukUybWs78cn39XvcDroRm/fur6gMN1YITF/mLLDKVmDsB/PNjMRZtWb9BLXMfbiElUE978Ekwto5kqlMCwFcje22YyzA0VCpI1aDsyOjzpK7dsReFifPR5oom+Md/V1auYeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714003567; c=relaxed/simple;
	bh=ZMJttUgpiTRRlwWUHCP4ks5oVHhmAM5wLTfN/UD/W0c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZJde/IehF3bAQzAT5P3i2NKsQSgj4ZzEDNbf8jPwIV3q9xfFzDwPJiC6aHH9/V/DhNNyu8RBOqq1//HNY02Dd32CFjXsabGnDxq40NO9/qV8E5a3C11Bm4MkJNfJaVHNDVtuXgpBUpfGu5ETCTfqP71Tr4ntrZP97Xc2iVho3Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SbbABz5L; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714003566; x=1745539566;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=ZMJttUgpiTRRlwWUHCP4ks5oVHhmAM5wLTfN/UD/W0c=;
  b=SbbABz5LmRKZWRNQ7hGqlkgyDD/LwLpkV0ZaXrWWaPqHLhUsSP2RhHXi
   lKYJkfrqjLMQRxD0TxLGW2QGSooHtZ5waJxnw9S5WUzbAgAq9sqbfGv/Q
   9Tf97TxWZyvnRvzf50OvLAR5dx+DGYi58mMl66xWupXm7a99txZek+CdK
   EKmsndo4/k3iPhWy9LgwTjoaNxj7ZlDXb2ROmvC3qalesseAo8uOVmnwu
   DIo/oR/X+pT0zkQxacRsvNa332s/WfEdWutcnE2iDvo/Gbt5An7GZDzH2
   SZmuX9ouxJVCcFvqEsenrYsukoADpL517tFhWwsRNB7aiaN7zqTADZ3aW
   Q==;
X-CSE-ConnectionGUID: vykYEknKRcOZ6kvz72SaaA==
X-CSE-MsgGUID: LIjkrs+VSsu5tp0nMhUzSQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="21087135"
X-IronPort-AV: E=Sophos;i="6.07,227,1708416000"; 
   d="scan'208";a="21087135"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 17:06:05 -0700
X-CSE-ConnectionGUID: uqinV3YNRRy49oLmFbxb7Q==
X-CSE-MsgGUID: Jz4t50uZSVuM8BA5pHh9XQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,227,1708416000"; 
   d="scan'208";a="29671636"
Received: from unknown (HELO vcostago-mobl3) ([10.124.220.153])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 17:06:04 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Andrew Lunn <andrew@lunn.ch>, Corinna Vinschen <vinschen@redhat.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH] igc: fix a log entry using uninitialized netdev
In-Reply-To: <033cce07-fe8f-42e6-8c27-7afee87fe13c@lunn.ch>
References: <20240423102455.901469-1-vinschen@redhat.com>
 <033cce07-fe8f-42e6-8c27-7afee87fe13c@lunn.ch>
Date: Wed, 24 Apr 2024 17:06:04 -0700
Message-ID: <8734raxq4z.fsf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andrew Lunn <andrew@lunn.ch> writes:

> On Tue, Apr 23, 2024 at 12:24:54PM +0200, Corinna Vinschen wrote:
>> During successful probe, igc logs this:
>> 
>> [    5.133667] igc 0000:01:00.0 (unnamed net_device) (uninitialized): PHC added
>>                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> The reason is that igc_ptp_init() is called very early, even before
>> register_netdev() has been called. So the netdev_info() call works
>> on a partially uninitialized netdev.
>> 
>> Fix this by calling igc_ptp_init() after register_netdev(), right
>> after the media autosense check, just as in igb.  Add a comment,
>> just as in igb.
>
> The network stack can start sending and receiving packet before
> register_netdev() returns. This is typical of NFS root for example. Is
> there anything in igc_ptp_init() which could cause such packet
> transfers to explode?
>

There might be a very narrow window (probably impossible?), what I can
see is:

1. the netdevice is exposed to userspace;
2. userspace does the SIOCSHWTSTAMP ioctl() to enable TX timestamps;
3. userspace sends a packet that is going to be timestamped;

if this happens before igc_ptp_init() is called, adapter->ptp_tx_lock is
going to be uninitialized, and (3) is going to crash.

If there's anything that makes this impossible/extremely unlikely, the
patch looks good:

Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>


Cheers,
-- 
Vinicius

