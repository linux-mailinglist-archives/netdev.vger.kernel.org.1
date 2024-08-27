Return-Path: <netdev+bounces-122152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B847E9602D7
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 09:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78E9D282F9C
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 07:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2233E19DF5B;
	Tue, 27 Aug 2024 07:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HvTgU0Ly"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3744919D889
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 07:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724742924; cv=none; b=eTLcZnTWvsWyjgqYzgXNNsOjtCVznfUkcJ08o8brnCB3GSByCBP2OzqGgSFJnTW1trJ40ZZqCKeXB7qruaWOzW0PhdAxANInEhilp9zuyAXQWaLg49xz792WMs7m7mskY0l5nBmvKyNaoKIExi8aM/VXp2TkhJErd+elqx1i+ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724742924; c=relaxed/simple;
	bh=GATKt/XkKN3IESOSKx5+0+Is1SPwRFUpOdXN4Yd65DM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gP2YzTvQhIVvkxtx4I+ed4FuN0Y4ojxAXNeq9xtvyJ8aXJsjNTpOd8sdxNHaCuOe5yBgmRVu2A8mSRtSzp4mAO4assecLZxjuIW44HeLSVxsvqhhfNuk4/8I0BnPBJoMz3dmHvE1MnOg5/LawbKuY+t58RfGN5eLn7faEj5KinQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HvTgU0Ly; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724742922; x=1756278922;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GATKt/XkKN3IESOSKx5+0+Is1SPwRFUpOdXN4Yd65DM=;
  b=HvTgU0LyA0aXyLdYsRzlkvd/3x7cJL1gRbIlZXV6QZpdKbka4gczkX99
   XTpCYkmzkxGd1GKhxTWSg3gn3BS5+VEjw+fKfWYRbwkkjvcspMC8L4t9K
   mRvaBGjrZ83wCc44G/stjSi0lOAuO2/dCTCvvhXt9TsBitOGjcokIrv94
   /pVKBD5Ma8m1/KLQxzu05ZCRXj1K4e0p+pOflryXsUlbbAnGm3geGB2/+
   n9Rn4PAsKdsXqvrGTT2TtfEPw1Z7X1aUMC9ntZ678FBtrkLoyXFyKNTxh
   +MJfe3CpsRG+XcBHI59nSO76wag2gp9/wzBvcSMbzgvfjOvzHe3y6nqlE
   A==;
X-CSE-ConnectionGUID: IxCHm209Rnmbgx6rRLfpZw==
X-CSE-MsgGUID: 0FSbveQoT2y6xOoFgauMdw==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="40672419"
X-IronPort-AV: E=Sophos;i="6.10,179,1719903600"; 
   d="scan'208";a="40672419"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 00:15:22 -0700
X-CSE-ConnectionGUID: 5+mc5MSzQMmAX6RuIwbegA==
X-CSE-MsgGUID: nQdBOF8vRwSshzw28xyNqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,179,1719903600"; 
   d="scan'208";a="67648269"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 00:15:19 -0700
Date: Tue, 27 Aug 2024 09:13:22 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jacek Wierzbicki <jacek.wierzbicki@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: Re: [PATCH net-next 4/8] ice: stop intermixing AQ commands/responses
 debug dumps
Message-ID: <Zs18kiU9gxJRgA3v@mev-dev.igk.intel.com>
References: <20240826224655.133847-1-anthony.l.nguyen@intel.com>
 <20240826224655.133847-5-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826224655.133847-5-anthony.l.nguyen@intel.com>

On Mon, Aug 26, 2024 at 03:46:44PM -0700, Tony Nguyen wrote:
> From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> 
> The ice_debug_cq() function is called to generate a debug log of control
> queue messages both sent and received. It currently does this over a
> potential total of 6 different printk invocations.
> 
> The main logic prints over 4 calls to ice_debug():
> 
>  1. The metadata including opcode, flags, datalength and return value.
>  2. The cookie in the descriptor.
>  3. The parameter values.
>  4. The address for the databuffer.
> 
> In addition, if the descriptor has a data buffer, it can be logged with two
> additional prints:
> 
>  5. A message indicating the start of the data buffer.
>  6. The actual data buffer, printed using print_hex_dump_debug.
> 
> This can lead to trouble in the event that two different PFs are logging
> messages. The messages become intermixed and it may not be possible to
> determine which part of the output belongs to which control queue message.
> 
> To fix this, it needs to be possible to unambiguously determine which
> messages belong together. This is trivial for the messages that comprise
> the main printing. Combine them together into a single invocation of
> ice_debug().
> 
> The message containing a hex-dump of the data buffer is a bit more
> complicated. This is printed separately as part of print_hex_dump_debug.
> This function takes a prefix, which is currently always set to
> KBUILD_MODNAME. Extend this prefix to include the buffer address for the
> databuffer, which is printed as part of the main print, and which is
> guaranteed to be unique for each buffer.
> 
> Refactor the ice_debug_array(), introducing an ice_debug_array_w_prefix().
> Build the prefix by combining KBUILD_MODNAME with the databuffer address
> using snprintf().
> 
> These changes make it possible to unambiguously determine what data belongs
> to what control queue message.
> 
> Reported-by: Jacek Wierzbicki <jacek.wierzbicki@intel.com>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_controlq.c | 23 +++++++++---------
>  drivers/net/ethernet/intel/ice/ice_osdep.h    | 24 +++++++++++--------
>  2 files changed, 26 insertions(+), 21 deletions(-)
> 
[...]

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Thanks

