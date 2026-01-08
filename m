Return-Path: <netdev+bounces-248058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 733DCD03E77
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 16:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F1136300899B
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 15:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489384984B4;
	Thu,  8 Jan 2026 12:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="CsU3Bc/m"
X-Original-To: netdev@vger.kernel.org
Received: from iad-out-012.esa.us-east-1.outbound.mail-perimeter.amazon.com (iad-out-012.esa.us-east-1.outbound.mail-perimeter.amazon.com [34.197.10.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3205149848F
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 12:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.197.10.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767873867; cv=none; b=XDcewd/Ww3hRY68+fkR3wespuEPtnQllxZSLa8obK50N9xMvlfKs2Ar5H3VczqFp6D7tY9wEZUPj1+bi3+4B6CIWiRfC0YBR2JJGIkk6yFv4w2SWz2K7nQ1r58ZIzyxn4BBDVXoIi3cE76/nzCYq3qJjK5oetE4UKIqpbc6LHkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767873867; c=relaxed/simple;
	bh=i0xcOAhzDQaCuhh/+O/fpHFZNrkQuiTWto0UGqAXzfw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UX4LEO50SKyJ6Z51GasKgOFb/yDdY0iFktyP9shhx+teTKt6oqCoWDm4LVr9fmkOkZje0dDugy33r1Emq5+sb5kOW1Wp6Fn8hLPnfrizWARmBJBD7m6wJwwMeLXbAqCGwgnfUqDBBB7hXTpXd5T3kGLI5Wv+2lx/RuVjACJymz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=CsU3Bc/m; arc=none smtp.client-ip=34.197.10.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1767873863; x=1799409863;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JYW49MvEg/hKYNjcSEtm/n9oUxDHwTAeo5+QHLIEc/8=;
  b=CsU3Bc/mVC+IrT+PANaxQckROSkSOWShpM05z52Tw6LLHeZAVjH2A8m2
   Y4u1Qer+ypdaS9g1Ho3E7OGaEiKeS+hOnmkIsE67nGIFECGCm4Iaftgk/
   5O1tWR9PEKKy+Rl25RimnuG+uw+RRfi+MEzbp4CgWpbTmlFLV2bHbIzkn
   g+lyLOjOv0ileL+qvFYMyUwKpvL4G+hvRzK/Zxv5A72er7HIBYBG+wM40
   RHGIe0lIwJaUP9B/SJqvkHC3erLPnkj9AbHrIrm7/ZkjbKfju6/uhjd5A
   DYWtQPLAaNmwgWYQoJJd74A6EepvfvXfDIWOtmufBjS5WdbB0xGgTT2c3
   g==;
X-CSE-ConnectionGUID: nI6yRKgjS/SlP4nD3NJ6XQ==
X-CSE-MsgGUID: wy8+cW/gS1eKV6Nn3jDSvg==
X-IronPort-AV: E=Sophos;i="6.21,210,1763424000"; 
   d="scan'208";a="9372761"
Received: from ip-10-4-7-229.ec2.internal (HELO smtpout.naws.us-east-1.prod.farcaster.email.amazon.dev) ([10.4.7.229])
  by internal-iad-out-012.esa.us-east-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 12:04:18 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:16936]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.44.170:2525] with esmtp (Farcaster)
 id e9329683-61cc-461e-9b20-53594e5e9dee; Thu, 8 Jan 2026 12:04:18 +0000 (UTC)
X-Farcaster-Flow-ID: e9329683-61cc-461e-9b20-53594e5e9dee
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Thu, 8 Jan 2026 12:04:18 +0000
Received: from b0be8375a521 (10.37.244.11) by EX19D001UWA001.ant.amazon.com
 (10.13.138.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35; Thu, 8 Jan 2026
 12:04:16 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <aleksandr.loktionov@intel.com>
CC: <andrew+netdev@lunn.ch>, <anthony.l.nguyen@intel.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <enjuk@amazon.com>,
	<intel-wired-lan@lists.osuosl.org>, <kuba@kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<przemyslaw.kitszel@intel.com>, <takkozu@amazon.com>
Subject: Re: RE: [Intel-wired-lan] [PATCH iwl-next v2 3/3] igb: allow configuring RSS key via ethtool set_rxfh
Date: Thu, 8 Jan 2026 21:03:58 +0900
Message-ID: <20260108120400.75859-1-enjuk@amazon.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <IA3PR11MB8986D6E9C30B7FFBCEF64394E585A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <IA3PR11MB8986D6E9C30B7FFBCEF64394E585A@IA3PR11MB8986.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWA001.ant.amazon.com (10.13.139.124) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Thu, 8 Jan 2026 07:29:19 +0000, Loktionov, Aleksandr wrote:

>> 
>> -	igb_write_rss_indir_tbl(adapter);
>> +	if (rxfh->key) {
>> +		adapter->has_user_rss_key = true;
>> +		memcpy(adapter->rss_key, rxfh->key, sizeof(adapter-
>> >rss_key));
>> +		igb_write_rss_key(adapter);
>It leads to race between ethtool RSS update and concurrent resets.
>Because igb_setup_mrqc() (called during resets) also calls igb_write_rss_key(adapter).
>Non-fatal but breaks RSS configuration guarantees.

At my first glance, rtnl lock serializes those operation, so it
doesn't seem to be racy as long as they are under the rtnl lock.

As far as I skimmed the codes, functions such as igb_open()/
igb_up()/igb_reset_task(), which finally call igb_write_rss_key() are
serialized by rtnl lock or serializes igb_write_rss_key() call by
locking rtnl.

Please let me know if I'm missing something and it's truly racy.

>
>I think ethtool can/should wait of reset/watchdog task to finish. 
>I'm against adding locks, and just my personal opinion, it's better to implement igb_rss_key_update_task() in addition to reset and watchdog tasks to be used both in reset and ethtool path.
>
>What do you think?

