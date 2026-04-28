Return-Path: <netdev+bounces-282019-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJ1nJ2Pu8GkvbQEAu9opvQ
	(envelope-from <netdev+bounces-282019-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 19:29:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DBF489F7C
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 19:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF39F3003E8D
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 17:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4555D331A7E;
	Tue, 28 Apr 2026 17:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R2IgLQxS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9E3330D23;
	Tue, 28 Apr 2026 17:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777397080; cv=none; b=NsQZ74yoA8wKi+AS4j05l7FWmEUVw/PXeg65fCYcbDOCtpeDk+DSmm74Z2wste0a4V0IsPy3l2pb166Cn96/079rYXrVt7Dx83zQxFX5wr1v399LzCKPpFa+Xo/RgF1LxGYWBd/C/pg4ke/3T23UEoT+gvfXd+LiYr/ElnGOCcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777397080; c=relaxed/simple;
	bh=Ks+zy8T12Y6GZ3FyFHq88+2s6itPF5th9+YzVmFMPwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fYcyrl1Ywuvm0D7KWqTK8AjI/SQPwd6quWgrzvw+nIhNlGTar4cUP2oXrAb9HNhzk9yy3LWXNzIDsVWrMcY9b5tVhKWFnwyz+2yi3nfv3dcRtZ3lwWquPnLjYv1Z3OD3boVOg5e8udWLQ5phCEJYL5U1Q3NhU5Y2s+QTf5OdDVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R2IgLQxS; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777397079; x=1808933079;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ks+zy8T12Y6GZ3FyFHq88+2s6itPF5th9+YzVmFMPwo=;
  b=R2IgLQxSfHSMOetaOaavA3GFn4ASvAy6m1/dhfb0zUqc4t2VRDBt5UEV
   Pv0d6mvf+2ptWhOEpJVFsFfxWbIcndxxmS/Nf/vRbtfuiKKDp2f+FYAMN
   7ERHOpJ4pC60+v57+o0Qvsmp2gQI2KuobvowXj0oCASlKjcHwuiCz3EUh
   ArD90Nq30hlZrpKQ23DsSZcS1PzkR0/XpfuJbITM+yfyVxZdt71nyKKbj
   QUffEnsm4fqd2wC9nNPKvQdBxipaGOW8os3i5vu9e+/UhjWjH2H/waEEH
   BpCZ3pAOuNsQnusaSQiFrIFrsSKaOHGz3zYCSOqipmftSYKNnXJC8pNWa
   A==;
X-CSE-ConnectionGUID: uNC1CH1MTNWXkM1yM1HR6Q==
X-CSE-MsgGUID: ELZld8VHSg2N4c/KvTyc8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="78230536"
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="78230536"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 10:24:38 -0700
X-CSE-ConnectionGUID: yh4CqZhkQu2gGGaQsgX3aw==
X-CSE-MsgGUID: whgKWaQlQJuBDL0j66PmVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="272157200"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa001.jf.intel.com with ESMTP; 28 Apr 2026 10:24:35 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 375A595; Tue, 28 Apr 2026 19:24:34 +0200 (CEST)
Date: Tue, 28 Apr 2026 19:24:34 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: linux-usb@vger.kernel.org, Yehezkel Bernat <YehezkelShB@gmail.com>,
	Lukas Wunner <lukas@wunner.de>,
	Andreas Noever <andreas.noever@gmail.com>,
	Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH 9/9] thunderbolt: Add support for USB4STREAM
Message-ID: <20260428172434.GV557136@black.igk.intel.com>
References: <20260428072209.3084930-1-mika.westerberg@linux.intel.com>
 <20260428072209.3084930-10-mika.westerberg@linux.intel.com>
 <ef5411f4-0e4c-4ac1-8ae0-0d557fc0ebd2@lunn.ch>
 <20260428151311.GU557136@black.igk.intel.com>
 <e38bb396-748f-435d-9d17-5e7799edcc64@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e38bb396-748f-435d-9d17-5e7799edcc64@lunn.ch>
X-Rspamd-Queue-Id: 02DBF489F7C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282019-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,wunner.de,linux.intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mika.westerberg@linux.intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,black.igk.intel.com:mid]

On Tue, Apr 28, 2026 at 06:45:34PM +0200, Andrew Lunn wrote:
> > > Is this mutually exclusive to networking, on a device?
> > 
> > No - they can co-exist.
> 
> Do they have there own rings? So that ethtool -C on the netdev will
> not conflict with your configfs setting of the interrupt coalescing
> for the stream?

Yes they use their own rings.

