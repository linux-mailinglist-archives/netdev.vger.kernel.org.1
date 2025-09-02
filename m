Return-Path: <netdev+bounces-219302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F5FB40EFA
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 23:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0284F7A40AA
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 21:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49312E8B92;
	Tue,  2 Sep 2025 21:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="GrTzWTrx"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com [34.218.115.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D7026980F
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 21:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.218.115.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756847101; cv=none; b=SH5tk+AMwWY6OhejrfXMRG2XWng0zvlOjIEyWk5M305VZRqBa0qVRJV6V4T4ZnaDLIWSUWq3oV/PmQShNv/FccPBVEzHHmos81P0bnwbbScoLVSJrHkyPCIkQ7MiYQGVP5X/AOCyJJqHD0uBVXYP1GvrC5wdd97boPULuPqDQKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756847101; c=relaxed/simple;
	bh=73mGA6MwWSFcRp9ZnTEqPNG8zfkpD63X5c3+H7TkHa0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sf7gGCDLnozHbyAKM9S3ZMhMxzZoRR+Htyv0ZuFiK5awH6UkDsqej6RQM2z4WJy75It9rbfnzaUhJLw1ADGn5bdKET6O/xYeiROy7e6zL1kmNMiMIrHIr5UwJ+02zQp8qzC9VPLaxPAT5WAlfzHFTJJXruA1XDO0ez9wgm6/+Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=GrTzWTrx; arc=none smtp.client-ip=34.218.115.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1756847100; x=1788383100;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t6gogj4w+fcwjbSwyJUS+/tCtWH+SJm0jaH6FwbZ8xU=;
  b=GrTzWTrxOSiuFpqbS8bPlczJ/gfOBDBzRUW0xCiL70y7NM/ToSIYaGuE
   CTAuSM9brENq1dOU7CcL63MPWcG3yqYaGEGjcKWzXX5wHYBmzAIV88oeC
   IxJOBSUZnryH3GR8dKxNB7TwIRYrNHkVybqkYZ0gCLyRf4mEWLGivnb6a
   Y5lll/bk0rX8rD3dd6/1Mo9pYTJo5BcuhW3Qau3rnozQmly4yr9p7z/3o
   +YEEoBgNne4s11wvyAA42TPJdYWEjaR/GCvTZPX6xD5VsHeWvjIPBIIkX
   fiH8GHVrBOvXZJN6ObS7k3pvpoKIeCTOrW2zJX0YwIplz1YJyvNP7S/uu
   Q==;
X-CSE-ConnectionGUID: gh3NnqEDTBuRUoWXR+8YyA==
X-CSE-MsgGUID: lMpGXdmkQ+GXS9JmCUVtPA==
X-IronPort-AV: E=Sophos;i="6.18,233,1751241600"; 
   d="scan'208";a="2133182"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 21:04:58 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:4775]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.28.48:2525] with esmtp (Farcaster)
 id 2cbdf29a-5857-4e82-8e43-7d620c440c32; Tue, 2 Sep 2025 21:04:57 +0000 (UTC)
X-Farcaster-Flow-ID: 2cbdf29a-5857-4e82-8e43-7d620c440c32
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Tue, 2 Sep 2025 21:04:56 +0000
Received: from b0be8375a521.amazon.com (10.37.244.11) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Tue, 2 Sep 2025 21:04:54 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <aleksandr.loktionov@intel.com>
CC: <andrew+netdev@lunn.ch>, <anthony.l.nguyen@intel.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <enjuk@amazon.com>,
	<intel-wired-lan@lists.osuosl.org>, <kohei.enju@gmail.com>,
	<kuba@kernel.org>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<przemyslaw.kitszel@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v3] ixgbe: preserve RSS indirection table across admin down/up
Date: Wed, 3 Sep 2025 06:04:42 +0900
Message-ID: <20250902210447.77961-1-enjuk@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <IA3PR11MB8986AD639F3395B5BFCC2C38E506A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <IA3PR11MB8986AD639F3395B5BFCC2C38E506A@IA3PR11MB8986.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWB001.ant.amazon.com (10.13.138.82) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Tue, 2 Sep 2025 13:25:56 +0000, Loktionov, Aleksandr wrote:

> [...]
>> -
>> -	for (i = 0, j = 0; i < reta_entries; i++, j++) {
>> -		if (j == rss_i)
>> -			j = 0;
>> +	/* Update redirection table in memory on first init, queue
>> count change,
>> +	 * or reta entries change, otherwise preserve user
>> configurations. Then
>> +	 * always write to hardware.
>> +	 */
>> +	if (adapter->last_rss_indices != rss_i ||
>> +	    adapter->last_reta_entries != reta_entries) {
>> +		for (i = 0; i < reta_entries; i++)
>> +			adapter->rss_indir_tbl[i] = i % rss_i;
>Are you sure rss_i never ever can be a 0?
>This is the only thing I'm worrying about.

Oops, you're exactly right. Good catch!

I see the original code assigns 0 to rss_indir_tbl[i] when rss_i is 0,
like:
  adapter->rss_indir_tbl[i] = 0;

To handle this with keeping the behavior when rss_i == 0, I'm
considering
Option 1:
  adapter->rss_indir_tbl[i] = rss_i ? i % rss_i : 0;

Option 2:
  if (rss_i)
      for (i = 0; i < reta_entries; i++)
          adapter->rss_indir_tbl[i] = i % rss_i;
  else
      memset(adapter->rss_indir_tbl, 0, reta_entries);

Since this is not in the data path, the overhead of checking rss_i in
each iteration might be acceptable. Therefore I'd like to adopt the
option 1 for simplicity.

Do you have any preference or other suggestions?

