Return-Path: <netdev+bounces-220549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E03A8B468A1
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 05:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E8BEE4E16DF
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 03:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F9D2236E0;
	Sat,  6 Sep 2025 03:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="AE7+ldgK"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2A823183B
	for <netdev@vger.kernel.org>; Sat,  6 Sep 2025 03:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.34.181.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757128961; cv=none; b=YHi743eCL3SGXOoILviHOO5lLRyI3y5+qp8WsQnfXKdmyfCzNVRRPn/R740w73K8/fSGn5KvM1ZALH3y+5Zre0IhvWq77sWFttM12QdT9d6THIK3BBb+3q4IK+2OXbqa4QhFwhrG36Ic3qLrGIeS/F5Et7UQFZOgyvdFrbO/bcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757128961; c=relaxed/simple;
	bh=/+HuGkG4EeM8AZdyYMueLiWIbz5Yy3t3R4R0Ml7kA8w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n45FC9E6Bbplb+4dWnjNAcNy1aIptC9lJvzzG+SspE1PQAjUM8gtXWo5JLH/4bfXHwEXFWmHL86TG5+3ESuotSH7v37bC720S65jx3J14cxPo6TTQAA9XCIKSRXm66cjlkKQTjAOpOzAdxH+cVYjBwOk7jWdiDEwke1yZUDMBq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=AE7+ldgK; arc=none smtp.client-ip=52.34.181.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1757128959; x=1788664959;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WFiwQBuEFLRzvFYakvxehxisdtpPVJ3Yu0vsvxE7VWY=;
  b=AE7+ldgKfap9TgU5+yefLnkn+8l7HYB/axRzSPz6lvTDY/L5aZ/sC8LS
   A4KPJejcp/2fulkaW9DIZOv5U7bAetixygx7yGkw4uKlK2MB/tovACc2J
   IcxLwjYiw39bA9Kfw7Zp0cJCXcb4E0BdDqgRicsLpQRxIWaPkUYlZjtzF
   jNGvOtlbNFUMU0MGtazZy1Kd3Rz0vmqjq/AzJiJmtP7u7IgZM2MEfTgeV
   Rkfoqbn7CXO8TtvrkFEhNnuW2FKg6oW/Hv/VtrYCvQs+hZo+lI17k67Et
   xxGPGOLuZAN+s2gc5FP2tYSLvqLxWNwuODus8Swjchgusq8ZYBxMYtt6p
   g==;
X-CSE-ConnectionGUID: xce/0uWASHCfQ80TmCuaGA==
X-CSE-MsgGUID: hKoG/w8bTwWG8xw3m6FZFQ==
X-IronPort-AV: E=Sophos;i="6.18,243,1751241600"; 
   d="scan'208";a="2522341"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2025 03:22:37 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:32517]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.88:2525] with esmtp (Farcaster)
 id 98718cf9-7bbf-492b-9e28-101270607342; Sat, 6 Sep 2025 03:22:37 +0000 (UTC)
X-Farcaster-Flow-ID: 98718cf9-7bbf-492b-9e28-101270607342
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Sat, 6 Sep 2025 03:22:37 +0000
Received: from b0be8375a521.amazon.com (10.37.244.8) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Sat, 6 Sep 2025 03:22:35 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <aleksandr.loktionov@intel.com>
CC: <andrew+netdev@lunn.ch>, <anthony.l.nguyen@intel.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <enjuk@amazon.com>,
	<intel-wired-lan@lists.osuosl.org>, <kohei.enju@gmail.com>,
	<kuba@kernel.org>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<przemyslaw.kitszel@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v3] ixgbe: preserve RSS indirection table across admin down/up
Date: Sat, 6 Sep 2025 12:22:24 +0900
Message-ID: <20250906032227.70729-1-enjuk@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <IA3PR11MB8986B31F209249FFC30F0A35E501A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <IA3PR11MB8986B31F209249FFC30F0A35E501A@IA3PR11MB8986.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA001.ant.amazon.com (10.13.139.88) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Wed, 3 Sep 2025 06:21:05 +0000, Loktionov, Aleksandr wrote:

> [...]
>> On Wed, 3 Sep 2025 06:04:43 +0900, Kohei Enju wrote:
>> 
>> >On Tue, 2 Sep 2025 13:25:56 +0000, Loktionov, Aleksandr wrote:
>> >
>> >> [...]
>> >>> -
>> >>> -	for (i = 0, j = 0; i < reta_entries; i++, j++) {
>> >>> -		if (j == rss_i)
>> >>> -			j = 0;
>> >>> +	/* Update redirection table in memory on first init, queue
>> >>> count change,
>> >>> +	 * or reta entries change, otherwise preserve user
>> >>> configurations. Then
>> >>> +	 * always write to hardware.
>> >>> +	 */
>> >>> +	if (adapter->last_rss_indices != rss_i ||
>> >>> +	    adapter->last_reta_entries != reta_entries) {
>> >>> +		for (i = 0; i < reta_entries; i++)
>> >>> +			adapter->rss_indir_tbl[i] = i % rss_i;
>> >>Are you sure rss_i never ever can be a 0?
>> >>This is the only thing I'm worrying about.
>> >
>> >Oops, you're exactly right. Good catch!
>> >
>> >I see the original code assigns 0 to rss_indir_tbl[i] when rss_i is
>> 0,
>> >like:
>> >  adapter->rss_indir_tbl[i] = 0;
>> 
>> Ahh, that's not true, my brain was not working... Sorry for messing
>> up.
>> Anyway, in a situation where rss_i == 0, we should handle it somehow
>> to avoid zero-divisor.
>> 
>> >
>> >To handle this with keeping the behavior when rss_i == 0, I'm
>> >considering Option 1:
>> >  adapter->rss_indir_tbl[i] = rss_i ? i % rss_i : 0;
>> >
>> >Option 2:
>> >  if (rss_i)
>> >      for (i = 0; i < reta_entries; i++)
>> >          adapter->rss_indir_tbl[i] = i % rss_i;
>> >  else
>> >      memset(adapter->rss_indir_tbl, 0, reta_entries);
>> >
>> >Since this is not in the data path, the overhead of checking rss_i in
>> >each iteration might be acceptable. Therefore I'd like to adopt the
>> >option 1 for simplicity.
>> >
>> >Do you have any preference or other suggestions?
>
>I lean toward option 2, as the explicit if (rss_i) guard makes the logic clearer and easier to follow.
>
>Handling the simplified case first with:
>if (unlikely(!rss_i))
>    memset(adapter->rss_indir_tbl, 0, reta_entries);
>else
>    for (i = 0; i < reta_entries; i++)
>        adapter->rss_indir_tbl[i] = i % rss_i;
>
>Improves readability and separates the edge case from the main logic.
>
>While it's possible to use a ternary expression like adapter->rss_indir_tbl[i] = rss_i ? i % rss_i : 0;,
>I find the conditional block more maintainable, especially if this logic evolves later.

Okay, I got it.

>
>Regarding unlikely(), unless there's profiling data showing a performance benefit,
>I'd avoid it here - this isn't in the fast path, and clarity should take precedence.

Yes, I agree on that this isn't in the fast path therefore unlikely is
not always necessary.

Thank you again for reviewing and suggesting!

>With the best regards Alex

