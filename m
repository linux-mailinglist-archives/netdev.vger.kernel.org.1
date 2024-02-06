Return-Path: <netdev+bounces-69477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 888E484B6D4
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 14:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 454D5286AFD
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 13:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF07130E30;
	Tue,  6 Feb 2024 13:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KAupdux4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA3A130AC6
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 13:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707227153; cv=none; b=Me85pEKSF1gyofEMXc0KjycrgbLw2eYZtA34Wxl3f7/cyDC/jpHSZk88dfobHKOIwczsCweo3eXIRfmNp22px44kunoz32dfWAuK2MrCd92eBnJOZyuJqCz/ZCimwWyujwoKUtzNZxKquTbgMb6lzZR7TqZ4DNiAw+L1hv0YMPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707227153; c=relaxed/simple;
	bh=Ze/BhStia6lOUFdS7wgZtk1dFbXwXQ3azKN9NDMJmnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KRmlbBcCad70lbzkwar0W9gONRPDbRaKckJBKAct0K7Rep/tOhUi0VJMPKcwUrjbms/tjPFI9vA0brpLuGYhul7kgN6o8FHYFZAR2yw6IwmgrlIvSM6MquUMTwj8/8Co0Th0/l0oelSNWXZlWRkQ+837bbjXY6JjqnslTGmx3TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KAupdux4; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707227152; x=1738763152;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Ze/BhStia6lOUFdS7wgZtk1dFbXwXQ3azKN9NDMJmnw=;
  b=KAupdux4NmGsQy9DWRZw8PjVl9UAlBIQSsAYmOiidYOPKi9c4eONSvb7
   eUogR5IjaVbulyNS/Eo4eEhGx9PPcXtOgg/zLOdUs+qmO8Ph02phI8sue
   wmtGfDuUuMZJZelTF/mtEUizy1Ed47siNM8GvVQsQ97Tb/p20YTl+RPbS
   pm8etEANUcTuXQYTuA9mtR6jai2dPVEg6/2RQqkdYd7LtFCwFcSuxGBaf
   YHag0jmlQZctJeifE5QKG1q+LK8nmtut6nRLGP8ReikJqQg7GbLPaDq41
   POUcZZwhB9Bt6PoOpz8AKmJfimW9wm/o3Q72/PVzNDh3iemYcaZZFibku
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="11333366"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="11333366"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 05:45:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="933463239"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="933463239"
Received: from unknown (HELO mev-dev) ([10.237.112.144])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 05:45:49 -0800
Date: Tue, 6 Feb 2024 14:45:41 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew.gospodarek@broadcom.com,
	pavan.chebbi@broadcom.com
Subject: Re: [PATCH net-next 02/13] bnxt_en: Add ethtool -N support for ether
 filters.
Message-ID: <ZcI4BdL6dHOeZiQJ@mev-dev>
References: <20240205223202.25341-1-michael.chan@broadcom.com>
 <20240205223202.25341-3-michael.chan@broadcom.com>
 <ZcHZ6JgacSpGmyDQ@mev-dev>
 <CACKFLi=cwJzA+igWnKNsGdVqY9OvBPao4aheKF_j7PWc1xF3vw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACKFLi=cwJzA+igWnKNsGdVqY9OvBPao4aheKF_j7PWc1xF3vw@mail.gmail.com>

On Tue, Feb 06, 2024 at 12:10:32AM -0800, Michael Chan wrote:
> On Mon, Feb 5, 2024 at 11:04 PM Michal Swiatkowski
> <michal.swiatkowski@linux.intel.com> wrote:
> >
> > On Mon, Feb 05, 2024 at 02:31:51PM -0800, Michael Chan wrote:
> > > +     spin_lock_bh(&bp->ntp_fltr_lock);
> > > +     fltr = __bnxt_lookup_l2_filter(bp, key, idx);
> > > +     if (fltr) {
> > > +             fltr = ERR_PTR(-EEXIST);
> > > +             goto l2_filter_exit;
> > > +     }
> > > +     fltr = kzalloc(sizeof(*fltr), GFP_ATOMIC);
> > > +     if (!fltr) {
> > > +             fltr = ERR_PTR(-ENOMEM);
> > > +             goto l2_filter_exit;
> > > +     }
> > > +     fltr->base.flags = flags;
> > > +     rc = bnxt_init_l2_filter(bp, fltr, key, idx);
> > > +     if (rc) {
> > > +             spin_unlock_bh(&bp->ntp_fltr_lock);
> > Why filter needs to be deleted without lock? If you can change the order
> > it looks more natural:
> >
> > +if (rc) {
> > +       fltr = ERR_PTR(rc);
> > +       goto l2_filter_del;
> > +}
> 
> Thanks for the review.  bnxt_del_l2_filter() will take the same lock
> inside the function if it goes ahead to delete the filter.  That's why
> the lock needs to be released first.

Got it, thanks.

