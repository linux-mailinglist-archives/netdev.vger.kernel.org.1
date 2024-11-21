Return-Path: <netdev+bounces-146571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D3D9D4644
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 04:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7812F1F222CA
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 03:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE9112B169;
	Thu, 21 Nov 2024 03:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nvQDYInd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0F244C6F;
	Thu, 21 Nov 2024 03:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732160025; cv=none; b=Xq9fFL90duYiaOR2mMK67I3R2yN7WyzV8lkYgeZ6A1w7pew1VwcLjQ1peEn2AUDzC/OYeDyYlgU4qwZYolTVqQn/gWsiz15OYQ684Zjt4EEBpPcmC1fwP9zDJDrBKnFPT8zx3CuZclDZCmXADDoxMbbrNhRyVWpDqIuTFUOg7lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732160025; c=relaxed/simple;
	bh=4SlXWeYnu3vXAeYVo+2nF+CT25Fz/dsTeeC2kO0D/Yo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ktInY08jWK0hFuz4ficcSnFYWxLbHCMAjjaZtwTAvsfAtdcPpps7gLnQ9HN/vz/yMq8cax9Mhp+IbOy1ika1fUHYeytfWDgE+lVhdvQayG9kGJfOxfYXA/CuaO1faU6Je80X3VmqPT0dfqtjtnrcGyljx1rjRatSqoxk1dl3i10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nvQDYInd; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732160024; x=1763696024;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4SlXWeYnu3vXAeYVo+2nF+CT25Fz/dsTeeC2kO0D/Yo=;
  b=nvQDYIndQa6FWMqchYFqo+AWu43fAaQHZajNrurXLAl2oDQOzr1FKBhv
   b0CVEf9Q+MCSMdpEdkya60nyvNuHHXoOYK9MPsJRqjdNVWbg+J90q8Ok+
   x28D+UQbvI00XUCWAI3ELZoWXCf2hb/zrgfdAje6qq+p9iiranaB3ajBe
   YOvq2Fur14896O3ln7V6FJKB80H9wkEn0N2dEMWTCMbKXwTJaWfFkas6w
   ZDuVYTPR7uph/unMn0drCaMEU0DtVn+okZgHndGA/Wkk+8rRCTpWF5aEr
   XdnWzPs7HNVkVGU5lG+PJSkTPcUCkD+HIIeFmE4e0ZXsNT5OJa3BoNAS4
   A==;
X-CSE-ConnectionGUID: aAa+0BXkTymI9mwz2/HeNQ==
X-CSE-MsgGUID: qbqNN4sGSKOmwb8hy5LBFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11262"; a="31997884"
X-IronPort-AV: E=Sophos;i="6.12,171,1728975600"; 
   d="scan'208";a="31997884"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2024 19:33:43 -0800
X-CSE-ConnectionGUID: AsiVpzqvQK+AlcgHDW79JQ==
X-CSE-MsgGUID: 0d46H/TNQPevK3ykWpAUVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,171,1728975600"; 
   d="scan'208";a="90239515"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.109.177])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2024 19:33:43 -0800
Date: Wed, 20 Nov 2024 19:33:41 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
	dan.j.williams@intel.com, martin.habets@xilinx.com,
	edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com
Subject: Re: [PATCH v5 00/27] cxl: add type2 device basic support
Message-ID: <Zz6qFaLNs0XmdhMw@aschofie-mobl2.lan>
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>

On Mon, Nov 18, 2024 at 04:44:07PM +0000, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alejandro.lucero-palau@amd.com>
> 
> v5 changes:

Hi Alejandro -

What is the base commit for this set?  (I'm trying to apply it)

In future revs please include the base commit. I typically get it
by setting the upstream branch and then doing --base="auto" when
formatting the patches.

Thanks!
Alison

..snip

> 
> 

