Return-Path: <netdev+bounces-219311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F38F0B40F33
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 23:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF5E117B45B
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 21:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970D126C385;
	Tue,  2 Sep 2025 21:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="k+xME/i5"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.13.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7AB26980F
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 21:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.13.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756847814; cv=none; b=c0hTbnxF56w895f6TQBeLdceOjiXe6DMKQ+gX2q+w/ndzWE9IQ0Qyd+b4/buqZNxV0dYiVfwTFAPluKibxvkXPLF6YEOP1fyHv1K6usvj54LJb7kz4PE9zc4EqVa/HMlxDzLn6i5rECwyQHbfhPlhPvfTDvvUgMsS2mZEUwH7DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756847814; c=relaxed/simple;
	bh=+/E9mth86gm390fQbsX4t8LOzHdMC2rqEHjLi6DTZrI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YGABbG8mJkTRsp4urc4NiXjb2f0EHoJBoe/sVpodF9be23hC0aMPx5lSmOtlZmPa003j/bovW7mstHI4ARVw2L4amJq5fAVgZRXR8EgxVf8COKXn6Z6/GKXCD/BwiqwDo0iJaGd6ITQn48bXEmDhq3KETvdzOkq7tsg2s+Xcpts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=k+xME/i5; arc=none smtp.client-ip=52.13.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1756847812; x=1788383812;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EfyEBkR+gvRPfwnPvyneq20sNdtyH4J+bGD9qod/GG4=;
  b=k+xME/i55DX414TqaURnZki4hzgxxQeVUuVYdFX24kVjnZGYQAVwrEfn
   G12w9IsQB/KKA7T9tcqFW/5KEo6mRWLdB0H2/oFRhbd1FD7xoNq9beKTz
   Ix4iATRcprBvseY4fVk3CTR3SjmblXRZ2A9FS6vwaREKurlkP/QPhZ1bI
   LT0GZ+hM8QaECJq9VzT/70YjQYgfp7kEaxsemGDsIiu2TjT6mnl5Bp/bZ
   eDKL2DKsineHJa5yJYwGWKsVaB0D75R6B5XxK7HJteF9aWyyxvVKfC78M
   KHKDh24KHS/i/7563bwI+W/A4qJlGI7tEyZM2mEBCaBP9zts65poTQdXt
   Q==;
X-CSE-ConnectionGUID: jFFlNh1pS++I9zet7HJ2FQ==
X-CSE-MsgGUID: gdsx5nXcSFGBV9jzl+xSYg==
X-IronPort-AV: E=Sophos;i="6.18,233,1751241600"; 
   d="scan'208";a="2250860"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 21:16:50 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:37188]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.88:2525] with esmtp (Farcaster)
 id 2d6dc524-f91c-4acd-be1b-9e11261f00e8; Tue, 2 Sep 2025 21:16:50 +0000 (UTC)
X-Farcaster-Flow-ID: 2d6dc524-f91c-4acd-be1b-9e11261f00e8
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Tue, 2 Sep 2025 21:16:50 +0000
Received: from b0be8375a521.amazon.com (10.37.245.8) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Tue, 2 Sep 2025 21:16:48 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <enjuk@amazon.com>
CC: <aleksandr.loktionov@intel.com>, <andrew+netdev@lunn.ch>,
	<anthony.l.nguyen@intel.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<intel-wired-lan@lists.osuosl.org>, <kohei.enju@gmail.com>,
	<kuba@kernel.org>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<przemyslaw.kitszel@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v3] ixgbe: preserve RSS indirection table across admin down/up
Date: Wed, 3 Sep 2025 06:16:39 +0900
Message-ID: <20250902211640.85359-1-enjuk@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250902210447.77961-2-enjuk@amazon.com>
References: <20250902210447.77961-2-enjuk@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWA001.ant.amazon.com (10.13.139.83) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Wed, 3 Sep 2025 06:04:43 +0900, Kohei Enju wrote:

>On Tue, 2 Sep 2025 13:25:56 +0000, Loktionov, Aleksandr wrote:
>
>> [...]
>>> -
>>> -	for (i = 0, j = 0; i < reta_entries; i++, j++) {
>>> -		if (j == rss_i)
>>> -			j = 0;
>>> +	/* Update redirection table in memory on first init, queue
>>> count change,
>>> +	 * or reta entries change, otherwise preserve user
>>> configurations. Then
>>> +	 * always write to hardware.
>>> +	 */
>>> +	if (adapter->last_rss_indices != rss_i ||
>>> +	    adapter->last_reta_entries != reta_entries) {
>>> +		for (i = 0; i < reta_entries; i++)
>>> +			adapter->rss_indir_tbl[i] = i % rss_i;
>>Are you sure rss_i never ever can be a 0?
>>This is the only thing I'm worrying about.
>
>Oops, you're exactly right. Good catch!
>
>I see the original code assigns 0 to rss_indir_tbl[i] when rss_i is 0,
>like:
>  adapter->rss_indir_tbl[i] = 0;

Ahh, that's not true, my brain was not working... Sorry for messing up.
Anyway, in a situation where rss_i == 0, we should handle it somehow to
avoid zero-divisor.

>
>To handle this with keeping the behavior when rss_i == 0, I'm
>considering
>Option 1:
>  adapter->rss_indir_tbl[i] = rss_i ? i % rss_i : 0;
>
>Option 2:
>  if (rss_i)
>      for (i = 0; i < reta_entries; i++)
>          adapter->rss_indir_tbl[i] = i % rss_i;
>  else
>      memset(adapter->rss_indir_tbl, 0, reta_entries);
>
>Since this is not in the data path, the overhead of checking rss_i in
>each iteration might be acceptable. Therefore I'd like to adopt the
>option 1 for simplicity.
>
>Do you have any preference or other suggestions?

