Return-Path: <netdev+bounces-259898-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IL1nCwRXm2lHyQMAu9opvQ
	(envelope-from <netdev+bounces-259898-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 20:20:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9921702AD
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 20:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2F67300E391
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 19:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6BC35A925;
	Sun, 22 Feb 2026 19:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="ZZg0ucmK"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com [34.218.115.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038E8350A0F
	for <netdev@vger.kernel.org>; Sun, 22 Feb 2026 19:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.218.115.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771788033; cv=none; b=JQPtuy7N3euoBaVrL54zY0gVk/c9N4KT3tJPXrAN2+QytuDwItHE8zT8em0lEeP/DySiV9eVsWFAor+KHr0jKKmYfg7Odqul3r1orTAP6uvwrlR1NK4IENFDyFWecbCG3dz4F4UBLcsOUZEjHuKv552cDjbbKJFarjmbeCgr41I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771788033; c=relaxed/simple;
	bh=6veznJnw41SdRLT/r5xh9HQI0Ih7fKTSv/0BiN/OYn4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ulthfOUnGR1/l8QYX2LS//2/pK0IOIfqVsATD3Wqg0YMsgndgBzeaBhl/iwoI5IyUYgyurzy+/+PXkETGMdNd70wZIduhcNrarly8EUnU5SnMAe3CJMRiR3P9Ssy2a+3TKk4NqzDi/eHya2nqCcj05NI6s82ADPMpS0A3yNWyoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=ZZg0ucmK; arc=none smtp.client-ip=34.218.115.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1771788032; x=1803324032;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7AXFH+vuOnnn9PkWkiJdfT8gFe6PP/Z9KQnHfrVnI7M=;
  b=ZZg0ucmKT2toaqeYe8fWhVBGA4AJuvtwPCY0T/GgMXBctonwpdJYXdmo
   f/gppIQNKFy4lPM0sHPUNgRpdm5odXUfH3+zq9xl3qzn6tr1SRvWuDW8y
   9uv/npl3/Vdje+zdPDJlr3ma+UDt/vKEDuYJ1mQiTOSsMO0M/ACrQ/cOS
   I8J6RL9HTwE5zE4ONJI+P7PEzFajdVE7F9d6Ga0GoD/mb+RoyaLx6TEq2
   JxdOLYQQkq/u1tE7g5J6Od4Pum+UgPP9hhClkpBLLpcB+pNptmA3ExQTc
   98QxGi1MEeo+MogU60UeOyxslCBNNPOhfVv5N8bHx1G+Zs7AoYtCU6+DY
   A==;
X-CSE-ConnectionGUID: VxIbJwiBS5Sm4s1MW9hdmg==
X-CSE-MsgGUID: be32y7KeSjadlkwIrYuphQ==
X-IronPort-AV: E=Sophos;i="6.21,305,1763424000"; 
   d="scan'208";a="13362928"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2026 19:20:29 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:27511]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.38.188:2525] with esmtp (Farcaster)
 id a94a9f8d-db01-4698-8020-45b8dd150707; Sun, 22 Feb 2026 19:20:29 +0000 (UTC)
X-Farcaster-Flow-ID: a94a9f8d-db01-4698-8020-45b8dd150707
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Sun, 22 Feb 2026 19:20:29 +0000
Received: from b0be8375a521.amazon.com (10.37.245.8) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Sun, 22 Feb 2026 19:20:25 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <dsahern@kernel.org>
CC: <aleksandr.loktionov@intel.com>, <andrew+netdev@lunn.ch>,
	<anthony.l.nguyen@intel.com>, <daniel.zahka@gmail.com>,
	<davem@davemloft.net>, <david.m.ertman@intel.com>, <edumazet@google.com>,
	<intel-wired-lan@lists.osuosl.org>, <kuba@kernel.org>,
	<michal.swiatkowski@linux.intel.com>, <mustafa.ismail@intel.com>,
	<netdev@vger.kernel.org>, <nikolay@nvidia.com>, <pabeni@redhat.com>,
	<paul.greenwalt@intel.com>, <przemyslaw.kitszel@intel.com>,
	<shiraz.saleem@intel.com>, <tatyana.e.nikolova@intel.com>
Subject: Re: [PATCH net] drivers: net: ice: fix devlink parameters get without irdma
Date: Mon, 23 Feb 2026 04:20:11 +0900
Message-ID: <20260222192011.1147-1-enjuk@amazon.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <56e04cb1-e205-4076-8236-1f172a75793d@kernel.org>
References: <56e04cb1-e205-4076-8236-1f172a75793d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWC004.ant.amazon.com (10.13.139.206) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259898-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,gmail.com,davemloft.net,google.com,lists.osuosl.org,kernel.org,linux.intel.com,vger.kernel.org,nvidia.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[enjuk@amazon.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[amazon.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7D9921702AD
X-Rspamd-Action: no action

On Sun, 22 Feb 2026 11:27:30 -0700, David Ahern wrote:

> On 2/13/26 1:48 AM, Nikolay Aleksandrov wrote:
> > If CONFIG_IRDMA isn't enabled but there are ice NICs in the system, the
> > driver will prevent full devlink dev param show dump because its rdma get
> > callbacks return ENODEV and stop the dump. For example:
> >  $ devlink dev param show
> >  pci/0000:82:00.0:
> >    name msix_vec_per_pf_max type generic
> >      values:
> >        cmode driverinit value 2
> >    name msix_vec_per_pf_min type generic
> >      values:
> >        cmode driverinit value 2
> >  kernel answers: No such device
> > 
> > Returning EOPNOTSUPP allows the dump to continue so we can see all devices'
> > devlink parameters.
> > 
> > Fixes: c24a65b6a27c ("iidc/ice/irdma: Update IDC to support multiple consumers")
> > Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
> > ---
> >  drivers/net/ethernet/intel/ice/devlink/devlink.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> 
> This patch was marked as awaiting upstream; I wanted to confirm it is in
> Intel's queue or was the expectation for netdev maintainer's to pick it up?

I see it's in Intel's queue.

https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git/log/?h=dev-queue

