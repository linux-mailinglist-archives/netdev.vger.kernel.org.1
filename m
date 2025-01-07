Return-Path: <netdev+bounces-155967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B050A0467F
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 17:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83401161068
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 16:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A358248D;
	Tue,  7 Jan 2025 16:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dFJvlZgn"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBE01E570D;
	Tue,  7 Jan 2025 16:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736267754; cv=none; b=bdBDr35PTjGKjDge4ufekGg0Fsguo9zxpmLPtdx2raINN7qZVaYE563NnkaSnwUs86jKNF3tiVyKnAX5OHlIgke4UOx4KaaBUkWcaS+HHi3SQCQ1i6XgA2paSVLrfvyuPupZdVnua3ajI8TP2liTALpiZXdpUqk/fFhCT6JoL+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736267754; c=relaxed/simple;
	bh=77BwJhWtOJ6X+HLHj3f9qNzITxOyj3LeX/ee6U+UPO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sTpxSB9WVFl7R1L9jGJXy9OLTgbi6hqibgoMsBRxs1eZGrVnDh1Kaqscur5t7IVkuvAM8kX7qmjD6UwC7YnYLZW/mj6d1pJnB0Ob0NO966isTKE/RIne9A16sPnq8T816dY7NSKeUzcKDcubdjvj62Etq3WdjFxonKJvQ3jS2es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dFJvlZgn; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736267751; x=1767803751;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=77BwJhWtOJ6X+HLHj3f9qNzITxOyj3LeX/ee6U+UPO4=;
  b=dFJvlZgnSGglB6Kb6wg6eYxmqbESNucxf/tZUSj2dSoUx9FjEHUuy9qG
   qdz6a+/lRivBWLCLqbdDYPOAWdLBgkebvFmauDrZx0AbzkvlM1Co9JW4v
   AT17w2dhrZ+u0OH0iCvErF6CsnpKK8OS0jKURSQPeiP1sd5Rpazz2fxs0
   npPJkmJtYxNFIAqm00X1QEBxYtdmYx0LcvNbZ/6nQRsfynJ4y8iRcyJmD
   QsPlc6GIZtdQxt7G+Z+Ti6C7DGozMg7+zFqK2vKQe0Ld/BKLrYWt7bryo
   FIQPmVFfVEdEKX+YRTS7apDvCWEpyyaw8JZbwySwk4BQ9++4KFseBwDjx
   g==;
X-CSE-ConnectionGUID: xYrNW8aZR6mp+oypF68e9Q==
X-CSE-MsgGUID: pYN/yWffSGurFsHM9jSzZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11308"; a="47875481"
X-IronPort-AV: E=Sophos;i="6.12,296,1728975600"; 
   d="scan'208";a="47875481"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 08:35:50 -0800
X-CSE-ConnectionGUID: LrKCd00mTUas9mCAeAwcyQ==
X-CSE-MsgGUID: Qz/jHP6kRvq14+UFLkF0bA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="107909020"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.110.187])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 08:35:49 -0800
Date: Tue, 7 Jan 2025 08:35:48 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
	dan.j.williams@intel.com, martin.habets@xilinx.com,
	edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com,
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v8 01/27] cxl: add type2 device basic support
Message-ID: <Z31X5IvFAX5jI8vW@aschofie-mobl2.lan>
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
 <20241216161042.42108-2-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216161042.42108-2-alejandro.lucero-palau@amd.com>

On Mon, Dec 16, 2024 at 04:10:16PM +0000, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Differentiate CXL memory expanders (type 3) from CXL device accelerators
> (type 2) with a new function for initializing cxl_dev_state.
> 
> Create accessors to cxl_dev_state to be used by accel drivers.
> 
> Based on previous work by Dan Williams [1]
>
> Link: [1] https://lore.kernel.org/linux-cxl/168592160379.1948938.12863272903570476312.stgit@dwillia2-xfh.jf.intel.com/

Dan introduced some cxl-test support in [1]. What are your thoughts
on including that in this set?

I haven't revisited the circular dependency this patch introduces in
my cxl-test environment. At the moment, I cannot run the cxl test suite
for regression purposes. Can you?

Alison


