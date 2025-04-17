Return-Path: <netdev+bounces-183832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E11D9A922CD
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 18:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FF9419E65EC
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 16:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05E12550B0;
	Thu, 17 Apr 2025 16:35:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE562550A1;
	Thu, 17 Apr 2025 16:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744907752; cv=none; b=U3ucS2dZsUItQgDiFoUOn5hiDzkIso5IswKpYAl7pfyPs96ok3onATw44R6MmBHl+rABYfi7W4NBYBPp1MEKgpR8Anx2djvwGjC2fei+79OPPvuwYcfc5nKkbjp3APVvrfTQ6u3LVdAnvKmJPznnTKKvCKRMBQVvp3DJLhvR0Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744907752; c=relaxed/simple;
	bh=j8NgfDVBZ3xm7T9dNfnlq+/9XlPch1LWFWAybD6N+8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PE46yzNrwjwmpCg+uGnrREk3o8P97x2cZyVqHnXLWHLoj0OIXorABMU/rCXyPNaUIixlbbsgQLR9OUSfu6bPh8gyPYhIvLDnPMKTGyONS2vXgiJ6+HudYTfaQ9pgUCDdS3BwaDcUpvuo90mkAoA6IonDH/VVxRW2/DdYCbz6k7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: T2GOjgSIT5y+sm2r0QYaaw==
X-CSE-MsgGUID: rdGwAmibRX2lhPESgFebwg==
X-IronPort-AV: E=McAfee;i="6700,10204,11406"; a="69002051"
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="69002051"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 09:35:50 -0700
X-CSE-ConnectionGUID: t5CP7hq3SvOTq90mwkL7sA==
X-CSE-MsgGUID: SknDViIwTD6hhswFmfgYBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="135813855"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 09:35:46 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1u5SDG-0000000DFpX-3Vqc;
	Thu, 17 Apr 2025 19:35:42 +0300
Date: Thu, 17 Apr 2025 19:35:42 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>, Hans de Goede <hdegoede@redhat.com>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Lee Jones <lee@kernel.org>, Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Schmidt <mschmidt@redhat.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 net-next 3/8] mfd: Add Microchip ZL3073x support
Message-ID: <aAEt3qoTDgZYXkZU@smile.fi.intel.com>
References: <20250416162144.670760-1-ivecera@redhat.com>
 <20250416162144.670760-4-ivecera@redhat.com>
 <8fc9856a-f2be-4e14-ac15-d2d42efa9d5d@lunn.ch>
 <CAAVpwAsw4-7n_iV=8aXp7=X82Mj7M-vGAc3f-fVbxxg0qgAQQA@mail.gmail.com>
 <894d4209-4933-49bf-ae4c-34d6a5b1c9f1@lunn.ch>
 <03afdbe9-8f55-4e87-bec4-a0e69b0e0d86@redhat.com>
 <eb4b9a30-0527-4fa0-b3eb-c886da31cc80@redhat.com>
 <aAEhb-6QV2m21pm2@smile.fi.intel.com>
 <514f9861-9d16-4c62-a7a0-5c9182a44927@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <514f9861-9d16-4c62-a7a0-5c9182a44927@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

+Cc: Hans, author of the below mentioned APIs.

On Thu, Apr 17, 2025 at 06:29:01PM +0200, Ivan Vecera wrote:
> On 17. 04. 25 5:42 odp., Andy Shevchenko wrote:
> > > > Would it be acceptable for you something like this:
> > V4L2 (or media subsystem) solve the problem by providing a common helpers for
> > reading and writing tons of different registers in cameras. See the commit
> > 613cbb91e9ce ("media: Add MIPI CCI register access helper functions").
> > 
> > Dunno if it helps here, though.
> 
> Bingo, this approach looks very good.
> 
> I can use unsigned int (32bit) to encode everything necessary:
> Bits  0..15 - register address (virtual range offset, page, offset)
> Bits 16..21 - size in bits (enough for max 48)
> Bits 22..26 - max items (32 values - enough for any indexed register)
> Bits 27..31 - stride between (up to 32 - enough per datasheet)
> 
> Only thing I don't like is that MIPI CCI API uses for calls u64 as value:
> 
> int cci_read(struct regmap *map, u32 reg, u64 *val, ...);
> 
> This forces a caller to use u64 for every register read. I rather to use
> 'void *val' the same way as regmap_read().

You may discuss with them why they choose that and how to make that code shared
more widely if needed.

-- 
With Best Regards,
Andy Shevchenko



