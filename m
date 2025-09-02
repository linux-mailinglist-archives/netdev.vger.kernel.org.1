Return-Path: <netdev+bounces-219303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85921B40EFB
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 23:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29D7F1A84988
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 21:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78254345757;
	Tue,  2 Sep 2025 21:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="nyBeGVuk"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.35.192.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C712E7BDF
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 21:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.35.192.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756847102; cv=none; b=u4B8V36hn+YvQEIOKZ0v4buICIkvGs7UENBzkLKNiw6KLfAMp5qFtY4m4TCDbFOewEtMboWuktv5bVwE6PCcXxclF6M1PGlg0TZLnag02DELtoMBpO1oZl70NgWMlmbf7ZvLtEFAeuuhzHM28S1j6RVSutyDCPqhsh/HqrUCJLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756847102; c=relaxed/simple;
	bh=73mGA6MwWSFcRp9ZnTEqPNG8zfkpD63X5c3+H7TkHa0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dtXi1letJ2mpiS/CEcpnDm8PQXTsZWii8XilrlsgfE3CINXArpaGgh2+CfBhzXtCHSB70eXPK6uzrTvF0oFGWXJ82TrEvUY1WyMJC5bUgfI5chnW/0j63pGLQPIn5oylportsLYc9Nci3EEIr8+6tHEZhx8qbfUmnfW1wEP/BlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=nyBeGVuk; arc=none smtp.client-ip=52.35.192.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1756847100; x=1788383100;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t6gogj4w+fcwjbSwyJUS+/tCtWH+SJm0jaH6FwbZ8xU=;
  b=nyBeGVukwzK0LnCnsQ9GCSkLbOX20pgq+z5/xtERvEGVL23CfCKiZ/9B
   cyqRXTWeB4Rwt74bJuhZGKfxwms1mUMDyIht5luFLAymor+YLmN1+V0LC
   aO8CKLvjE2vfwQU3bVNkLFAF/81JEmYGeMdKHvm0k7UK2q/1d0AkB32Cy
   Gvjao+SrlFkc0/PihntqY2ZEBcRgFkZLJ5a7eVNDbJA4yQDhgrKa0pKkf
   DA0QmsaCdeupcf2kfeZBX6xF3o78etmmgg5TTlHVHudLQDhsicjFpQIKY
   9UWpoeT3eyKWteUk+v4oUJnCSU39HCa4t5tz2PYteyrbQFPXZuiFaNlRD
   w==;
X-CSE-ConnectionGUID: SJMIe03nRMqEd+/BuHJhqw==
X-CSE-MsgGUID: jwh2zAgMRuuLbzyoUfcqqQ==
X-IronPort-AV: E=Sophos;i="6.18,233,1751241600"; 
   d="scan'208";a="2134466"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 21:04:58 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:48973]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.88:2525] with esmtp (Farcaster)
 id 0072c26e-a3f7-4feb-a4b7-8b96bf14c20c; Tue, 2 Sep 2025 21:04:58 +0000 (UTC)
X-Farcaster-Flow-ID: 0072c26e-a3f7-4feb-a4b7-8b96bf14c20c
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Tue, 2 Sep 2025 21:04:58 +0000
Received: from b0be8375a521.amazon.com (10.37.244.11) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Tue, 2 Sep 2025 21:04:56 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <aleksandr.loktionov@intel.com>
CC: <andrew+netdev@lunn.ch>, <anthony.l.nguyen@intel.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <enjuk@amazon.com>,
	<intel-wired-lan@lists.osuosl.org>, <kohei.enju@gmail.com>,
	<kuba@kernel.org>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<przemyslaw.kitszel@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v3] ixgbe: preserve RSS indirection table across admin down/up
Date: Wed, 3 Sep 2025 06:04:43 +0900
Message-ID: <20250902210447.77961-2-enjuk@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250902210447.77961-1-enjuk@amazon.com>
References: <IA3PR11MB8986AD639F3395B5BFCC2C38E506A@IA3PR11MB8986.namprd11.prod.outlook.com>
 <20250902210447.77961-1-enjuk@amazon.com>
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

