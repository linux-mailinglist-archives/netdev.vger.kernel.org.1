Return-Path: <netdev+bounces-250455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F04BFD2C7F1
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 07:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6B9133009694
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 06:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053EE34C121;
	Fri, 16 Jan 2026 06:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="VzMF19gn"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818583346AD
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 06:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.12.53.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768544663; cv=none; b=o/GWc9p6CrugyLBV2pwTSOfbtAjKFree8tiV65UQHFiHGfGotxpc1UDGWp3BRJq+0vF876I8T5nQLkd922vkQU8n3YeKFLC0HV2O3OZRFlBvTcFY0Hdcs2J/FxRXo2nFbkZgQ52MD5cnnV69u8cLaPW3PyuOXyKxWDOxVmKGwBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768544663; c=relaxed/simple;
	bh=FPqutsrZ8kCZoA41/6ojy/mwwIeQcOcxPC3KEd/lSKw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tjp8tAAd/eng3u6z8CqUJ+ip08HcdRHplnGjHzHgu68o5EI2ZuaeJWGXpu/uzk35Y7Ys2t9oO+83idB9FpgPHLiO1p3kCUB9DBCY1SGKlyo7/wlhNF37o+eDu42Mm+w2+dWdMm7ysAo2lYNVErK+72Rej6fpFmkGHvWP6K8qa4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=VzMF19gn; arc=none smtp.client-ip=52.12.53.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1768544662; x=1800080662;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wpt1kM1YRs4xIHdqwfPIt9Yi6xvFOdnSBe+yiJjWAQE=;
  b=VzMF19gnhX6sr64DyvRY+0PZOyCNghTG1xwOMWtPmp99O3nLm2FgjQ1o
   A0a+fN6jh96wjOZyzrYtORZEYRaie58sabeuYMvdzjGEd4E/ACyExVfwh
   NZt/ZJcvoRfH878DqiYSSh0reKONC0JFud0wkLSwkpoR6ru/qva0UUYTW
   WRoIDjhFTXE5RMIo+2i0MJe/ps+J01TZ9DUqNQdYgAFEz6MJXQLmlhpE2
   CtjuSvodM316YcyPWKd9CPshlRPvipHIwzVLr3lkSmiJHrTopbR5Bp2d1
   wD866xG14cL+kXVxHyf8WDBCiXDiJxiKjHELnuFpjK6fj+2FfPAAPhxl6
   A==;
X-CSE-ConnectionGUID: UDn9gg2ZT/KAZBdf0H8yRQ==
X-CSE-MsgGUID: c5a4pxpJT9ak3+S++Pv2Pw==
X-IronPort-AV: E=Sophos;i="6.21,230,1763424000"; 
   d="scan'208";a="10849593"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 06:24:20 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:9315]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.27.220:2525] with esmtp (Farcaster)
 id 6875cfc2-26af-4f0a-b7d8-12d6d4c1f805; Fri, 16 Jan 2026 06:24:19 +0000 (UTC)
X-Farcaster-Flow-ID: 6875cfc2-26af-4f0a-b7d8-12d6d4c1f805
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Fri, 16 Jan 2026 06:24:19 +0000
Received: from 603e5f7bc1fe.amazon.com (10.37.245.10) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Fri, 16 Jan 2026 06:24:17 +0000
From: Takashi Kozu <takkozu@amazon.com>
To: <aleksandr.loktionov@intel.com>
CC: <andrew+netdev@lunn.ch>, <anthony.l.nguyen@intel.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <enjuk@amazon.com>,
	<intel-wired-lan@lists.osuosl.org>, <kuba@kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<przemyslaw.kitszel@intel.com>, <takkozu@amazon.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2 3/3] igb: allow configuring RSS key via ethtool set_rxfh
Date: Fri, 16 Jan 2026 15:24:11 +0900
Message-ID: <20260116062410.80174-2-takkozu@amazon.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <IA3PR11MB898612B0CDA9C5A5448733EEE585A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <IA3PR11MB898612B0CDA9C5A5448733EEE585A@IA3PR11MB8986.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWA003.ant.amazon.com (10.13.139.44) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

> -----Original Message-----
> From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
> To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
> Kohei Enju <enjuk@amazon.com>
> Cc: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
> "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
> "davem@davemloft.net" <davem@davemloft.net>,
> "edumazet@google.com" <edumazet@google.com>,
> "intel-wired-lan@lists.osuosl.org"
> <intel-wired-lan@lists.osuosl.org>,
> "kuba@kernel.org" <kuba@kernel.org>,
> "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
> "pabeni@redhat.com" <pabeni@redhat.com>,
> "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
> "takkozu@amazon.com" <takkozu@amazon.com>
> Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2 3/3] igb: allow configuring RSS key via ethtool set_rxfh
> Date: Thu, 8 Jan 2026 13:03:12 +0000 [thread overview]
> Message-ID: <IA3PR11MB898612B0CDA9C5A5448733EEE585A@IA3PR11MB8986.namprd11.prod.outlook.com> (raw)
> In-Reply-To: <IA3PR11MB89865D0189D37BB3393B57F5E585A@IA3PR11MB8986.namprd11.prod.outlook.com>
> 
> 
> 
> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> > Of Loktionov, Aleksandr
> > Sent: Thursday, January 8, 2026 1:28 PM
> > To: Kohei Enju <enjuk@amazon.com>
> > Cc: andrew+netdev@lunn.ch; Nguyen, Anthony L
> > <anthony.l.nguyen@intel.com>; davem@davemloft.net;
> > edumazet@google.com; intel-wired-lan@lists.osuosl.org;
> > kuba@kernel.org; netdev@vger.kernel.org; pabeni@redhat.com; Kitszel,
> > Przemyslaw <przemyslaw.kitszel@intel.com>; takkozu@amazon.com
> > Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2 3/3] igb: allow
> > configuring RSS key via ethtool set_rxfh
> >
> >
> >
> > > -----Original Message-----
> > > From: Kohei Enju <enjuk@amazon.com>
> > > Sent: Thursday, January 8, 2026 1:04 PM
> > > To: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> > > Cc: andrew+netdev@lunn.ch; Nguyen, Anthony L
> > > <anthony.l.nguyen@intel.com>; davem@davemloft.net;
> > > edumazet@google.com; enjuk@amazon.com; intel-wired-
> > > lan@lists.osuosl.org; kuba@kernel.org; netdev@vger.kernel.org;
> > > pabeni@redhat.com; Kitszel, Przemyslaw
> > <przemyslaw.kitszel@intel.com>;
> > > takkozu@amazon.com
> > > Subject: Re: RE: [Intel-wired-lan] [PATCH iwl-next v2 3/3] igb:
> > allow
> > > configuring RSS key via ethtool set_rxfh
> > >
> > > On Thu, 8 Jan 2026 07:29:19 +0000, Loktionov, Aleksandr wrote:
> > >
> > > >>
> > > >> - igb_write_rss_indir_tbl(adapter);
> > > >> + if (rxfh->key) {
> > > >> + adapter->has_user_rss_key = true;
> > > >> + memcpy(adapter->rss_key, rxfh->key, sizeof(adapter-
> > > >> >rss_key));
> > > >> + igb_write_rss_key(adapter);
> > > >It leads to race between ethtool RSS update and concurrent resets.
> > > >Because igb_setup_mrqc() (called during resets) also calls
> > > igb_write_rss_key(adapter).
> > > >Non-fatal but breaks RSS configuration guarantees.
> > >
> > > At my first glance, rtnl lock serializes those operation, so it
> > > doesn't seem to be racy as long as they are under the rtnl lock.
> > >
> > > As far as I skimmed the codes, functions such as igb_open()/
> > > igb_up()/igb_reset_task(), which finally call igb_write_rss_key()
> > are
> > > serialized by rtnl lock or serializes igb_write_rss_key() call by
> > > locking rtnl.
> > >
> > > Please let me know if I'm missing something and it's truly racy.
> > I think you're right, and I've missed that missing rtnl_lock was added
> > in upstream.
> >
> > Thank you for clarification
> > Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> >
> 
> Afterthought, I think it could be nice to place ASSERT_RTNL() to show it explicitly.
> What do you think about this idea?

Sorry for the late reply. 
I think it's a good idea. I will add ASSERT_RTNL().

