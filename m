Return-Path: <netdev+bounces-51919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B88C87FCAEB
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 00:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A319283015
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 23:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0B35B5BE;
	Tue, 28 Nov 2023 23:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BP3r3WIb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9ED0197
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 15:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701214645; x=1732750645;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=EGEixHtQb1+ZHIfzVRxJRAfvWyXmF6jAq+s8NNkM3sU=;
  b=BP3r3WIb5eOeAiFgiFkaLqMPhZZt17xdRXen0PZLsmJCvAi8dkv0oRvm
   j2uhHOCMSvvLlhrIeMtW7w/7uOPg4twp2UlQ4No9s0HQflwlSo8xjZ0rv
   cqjRxG1OTHf/n9I0brJQcIu1VceJzqWfnzc3UWJ/XmCrZ8Xb9oP36N2fz
   fBO/5aJCW/CciFE0Ub42hEPGySmZNH//vrN6emUprh6VB+qD+Av3R2sXv
   CpmECrPMc3WdE2h3IewWXH5J4/a480JHeqKzYjS14FxWvW3USRCFjqZBn
   i9ec2oPs1UmZuPu8rUvfTKI3QS93FTN4B7DynD2kdwvhmoMDYFaP0X74h
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="479250764"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="479250764"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 15:37:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="10253019"
Received: from ticela-or-268.amr.corp.intel.com (HELO vcostago-mobl3) ([10.212.190.61])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 15:37:25 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Kurt Kanzenbach <kurt@linutronix.de>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, Kurt Kanzenbach <kurt@linutronix.de>
Subject: Re: [PATCH net-next 0/5] igc: ethtool: Check VLAN TCI mask
In-Reply-To: <20231128074849.16863-1-kurt@linutronix.de>
References: <20231128074849.16863-1-kurt@linutronix.de>
Date: Tue, 28 Nov 2023 15:37:24 -0800
Message-ID: <87bkbdsb4b.fsf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kurt Kanzenbach <kurt@linutronix.de> writes:

> Hi,
>
> currently it is possible to configure receive queue assignment using the VLAN
> TCI field with arbitrary masks. However, the hardware only supports steering
> either by full TCI or the priority (PCP) field. In case a wrong mask is given by
> the user the driver will silently convert it into a PCP filter which is not
> desired. Therefore, add a check for it.
>
> Patches #1 to #4 are minor things found along the way.
>

Some very minor things: patches 2,3 and 4 have extra long lines in their
commit messages that checkpatch.pl doesn't seem to like.

Patches 4 and 5 read more like fixes to me. I think they could be
proposed to -net, as they contain fixes to user visible issues. Do you
think that makes sense?

As for the code, feel free to add my Ack to the series:

Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>


Cheers,
-- 
Vinicius

