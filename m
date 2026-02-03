Return-Path: <netdev+bounces-256277-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEmxHczrgWkFMAMAu9opvQ
	(envelope-from <netdev+bounces-256277-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 13:36:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C515FD9156
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 13:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A38F63038500
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 12:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59E733C53F;
	Tue,  3 Feb 2026 12:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="JvlHXk2u"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.245.243.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B957A3218DD
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 12:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.245.243.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770121925; cv=none; b=uLyQehLJoAvjF1Z7ULQPCzm5xsk16KTinwDdDuJqQlwtp0fAM4dhPTZg+6ASQ7GA+HeVW3VuWaVoGMqFpvtuOND5wrAc+VZAf92sRuxywPPCIHjXsCY2OFeU9jzb2ovong1Dcy3oq5AuA6yYTrh2BY3Xndb48F1swF0qgmKsbtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770121925; c=relaxed/simple;
	bh=la6c6rMnlkGUrU1jddUnUIgHhotHUjpybhZoP6Grrgw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HR0zSC6SAAVYR02+tJNUfuMzNSGJmEMqMZAD1XO5S9dtNybUB1zy55tW0g9lfLTbw0iNOP+8NuA0khHTDCw5IGNFjr5mmf3NfrEaGy6e5jP3O4BXCqTUb1GdEYlD++bLTWDVMGAvZNRFuMm4JYRR74gvvDMhbkxqlY68aOto5ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=JvlHXk2u; arc=none smtp.client-ip=44.245.243.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1770121924; x=1801657924;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YK+bZeD1IngcPgHtfql6I8NxnQg7t/nPSsV5E5pb1xA=;
  b=JvlHXk2ujp2FO5ckBREDGjRrBqUEJPdMnYv5ko6jsxtFBT63SEY973S8
   M7K2Xuiqmtlxah0NvPHMDyuVzpufc36skbXVGy2XfCBnUBh5/Sylfoctp
   vRRQnyedBmzjFh3Kh9gNGOPGdJ3XkSTQdBc021vFIrsu8ZPLf/t+eo+rQ
   fp3pCPspWb2Ny2CRFVjCaYA96FipOODWaSxEDS9JJQhv0e0vTe3OmcYmX
   3iTmlqjF5vDhJ2cZdJx2wQy6k2TQyeYxr1D0lniya4A1Puh0ihibc/uhz
   /WCtpjIc9SHofL6CL2o5jdArViQUth/YUZkQNOxgZvzKQebQHXrGXWFNW
   w==;
X-CSE-ConnectionGUID: ijPDJUUnTpihbynFQV8Ucw==
X-CSE-MsgGUID: OjHxnn3nRYGjAN+BswH95w==
X-IronPort-AV: E=Sophos;i="6.21,270,1763424000"; 
   d="scan'208";a="11722026"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 12:31:46 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:12976]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.0.123:2525] with esmtp (Farcaster)
 id cbe99331-cf46-4e56-8c05-78cc3949b188; Tue, 3 Feb 2026 12:31:46 +0000 (UTC)
X-Farcaster-Flow-ID: cbe99331-cf46-4e56-8c05-78cc3949b188
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Tue, 3 Feb 2026 12:31:46 +0000
Received: from 603e5f7bc1fe.amazon.com (10.37.245.7) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Tue, 3 Feb 2026 12:31:44 +0000
From: Takashi Kozu <takkozu@amazon.com>
To: <horms@kernel.org>
CC: <aleksandr.loktionov@intel.com>, <andrew+netdev@lunn.ch>,
	<anthony.l.nguyen@intel.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<enjuk@amazon.com>, <intel-wired-lan@lists.osuosl.org>, <kuba@kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <piotr.kwapulinski@intel.com>,
	<pmenzel@molgen.mpg.de>, <przemyslaw.kitszel@intel.com>, <takkozu@amazon.com>
Subject: Re: [Intel-wired-lan] [iwl-next, v5, 3/3] igb: allow configuring RSS key via ethtool set_rxfh
Date: Tue, 3 Feb 2026 21:31:37 +0900
Message-ID: <20260203123136.25423-2-takkozu@amazon.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260202102520.1844644-1-horms@kernel.org>
References: <20260202102520.1844644-1-horms@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWB004.ant.amazon.com (10.13.139.164) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-256277-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[davemloft.net:email,osuosl.org:email,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mpg.de:email,linux.dev:url];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[takkozu@amazon.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[amazon.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C515FD9156
X-Rspamd-Action: no action

> From: Simon Horman <horms@kernel.org>
> To: takkozu@amazon.com
> Cc: Simon Horman <horms@kernel.org>,
> anthony.l.nguyen@intel.com, andrew+netdev@lunn.ch,
> davem@davemloft.net, aleksandr.loktionov@intel.com,
> przemyslaw.kitszel@intel.com, kuba@kernel.org,
> netdev@vger.kernel.org, enjuk@amazon.com, pabeni@redhat.com,
> intel-wired-lan@lists.osuosl.org, edumazet@google.com,
> piotr.kwapulinski@intel.com, pmenzel@molgen.mpg.de
> Subject: Re: [iwl-next,v5,3/3] igb: allow configuring RSS key via ethtool set_rxfh
> Date: Mon, 2 Feb 2026 10:25:20 +0000 [thread overview]
> Message-ID: <20260202102520.1844644-1-horms@kernel.org> (raw)
> In-Reply-To: <20260127085410.79645-8-takkozu@amazon.com>
> 
> This is an AI-generated review of your patch. The human sending this
> email says "I'm releasing this report for completeness. And while I
> do think it is correct. I don't think it needs to block progress"
> 
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> igb: allow configuring RSS key via ethtool set_rxfh
> 
> This patch adds support for configuring the RSS key via ethtool's
> set_rxfh interface. The change accepts a userspace-provided RSS key,
> stores it in the adapter structure, and writes it to hardware registers.
> 
> > Change igc_set_rxfh() to accept and save a userspace-provided
> > RSS key.
> 
> This isn't a code bug, but the commit message references "igc_set_rxfh()"
> when the function being modified is actually igb_set_rxfh() in
> drivers/net/ethernet/intel/igb/igb_ethtool.c. This typo was noted by
> Aleksandr Loktionov in the v1 review:
> https://lore.kernel.org/intel-wired-lan/IA3PR11MB89860A16782937C7E8C2E2DEE5A7A@IA3PR11MB8986.namprd11.prod.outlook.com/
> 
> Should this be corrected to igb_set_rxfh() to match the actual code?

Thank you for pointing out.
I'll fix it and send it as v6.

