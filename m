Return-Path: <netdev+bounces-182698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E304A89BC8
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 13:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 235B7189DAB6
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 11:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBD52918C2;
	Tue, 15 Apr 2025 11:16:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4755428DF1B;
	Tue, 15 Apr 2025 11:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744715774; cv=none; b=Sp4SAno9W6h6U4+JIR+JIFdYVy4T63/o16o5NZ4RzVirBeRPcMciidXZAxSc9XMCWxpF/QfZlQQLANL2Ou7oOrJJEkQ6nBXx/JoBotBoKaORlOD1cbXfXkWyr3gVNd28PYBXqxcw77Itud+pRiMP8iZUyCNafqrJhSxqKkremU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744715774; c=relaxed/simple;
	bh=5iKPeLfe+KY5VI1Go+puKIveebGuCrXULEoSoppAAIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FYveb85lrdWoxxkPmHtBwUKWMmK9zAqNbRqE9Vn/ZS52JGPaHe8KdPK4i/FaNffhdtb5xZ5GZC/x4xO9fnynMgid91K8vyESZ484S1rRfw6zbDzrwS+NH62zB8f/DCGXxkN/SmLMZVLZGOjpEgtq2+CXl6Spf2KCkMVsI1WmPHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: erN71jLsQoCJoidjnryWNg==
X-CSE-MsgGUID: heaZCdngR82ZXCX/vbalkg==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="56879500"
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="56879500"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 04:16:12 -0700
X-CSE-ConnectionGUID: Uv3FJW/xQTWIk681BM9g/Q==
X-CSE-MsgGUID: AWh8EXZsRZCTQ934IwhDZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="130050741"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 04:16:07 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1u4eGp-0000000CWgt-3qMi;
	Tue, 15 Apr 2025 14:16:03 +0300
Date: Tue, 15 Apr 2025 14:16:03 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Krzysztof Kozlowski <krzk@kernel.org>,
	netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Lee Jones <lee@kernel.org>, Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Schmidt <mschmidt@redhat.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 07/14] mfd: zl3073x: Add components versions register
 defs
Message-ID: <Z_4_8wnetwpoWuwG@smile.fi.intel.com>
References: <20250409144250.206590-1-ivecera@redhat.com>
 <20250409144250.206590-8-ivecera@redhat.com>
 <df6a57df-8916-4af2-9eee-10921f90ff93@kernel.org>
 <c0ef6dad-ce7e-401c-9ae1-42105fcbf9c4@redhat.com>
 <098b0477-3367-4f96-906b-520fcd95befb@lunn.ch>
 <003bfece-7487-4c65-b4f1-2de59207bd5d@redhat.com>
 <8c5fb149-af25-4713-a9c8-f49b516edbff@lunn.ch>
 <9de10e97-d0fa-4dee-b98a-e4b2a3f7019c@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9de10e97-d0fa-4dee-b98a-e4b2a3f7019c@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 15, 2025 at 12:01:43PM +0200, Ivan Vecera wrote:
> On 10. 04. 25 11:54 odp., Andrew Lunn wrote:

...

> > So a small number of registers in the regmap need special locking. It
> > was not clear to me what exactly those locking requirements are,
> > because they don't appear to be described.
> > 
> > But when i look at the code above, the scoped guard gives the
> > impression that i have to read id, revision, fw_vr and cfg_ver all in
> > one go without any other reads/writes happening. I strongly suspect
> > that impression is wrong. The question then becomes, how can i tell
> > apart reads/writes which do need to be made as one group, form others
> > which can be arbitrarily ordered with other read/writes.
> > 
> > What i suggest you do is try to work out how to push the locking down
> > as low as possible. Make the lock cover only what it needs to cover.
> > 
> > Probably for 95% of the registers, the regmap lock is sufficient.
> > 
> > Just throwing out ideas, i've no idea if they are good or not. Create
> > two regmaps onto your i2c device, covering different register
> > ranges. The 'normal' one uses standard regmap locking, the second
> > 'special' one has locking disabled. You additionally provide your own
> > lock functions to the 'normal' one, so you have access to the
> > lock. When you need to access the mailboxes, take the lock, so you
> > know the 'normal' regmap cannot access anything, and then use the
> > 'special' regmap to do what you need to do. A structure like this
> > should help explain what the special steps are for those special
> > registers, while not scattering wrong ideas about what the locking
> > scheme actually is all over the code.
> 
> Hi Andrew,
> the idea looks interesting but there are some caveats and disadvantages.
> I thought about it but the idea with two regmaps (one for simple registers
> and one for mailboxes) where the simple one uses implicit locking and
> mailbox one has locking disabled with explicit locking requirement. There
> are two main problems:
> 
> 1) Regmap cache has to be disabled as it cannot be shared between multiple
> regmaps... so also page selector cannot be cached.
> 
> 2) You cannot mix access to mailbox registers and to simple registers. This
> means that mailbox accesses have to be wrapped e.g. inside scoped_guard()
> 
> The first problem is really pain as I would like to extend later the driver
> with proper caching (page selector for now).
> The second one brings only confusions for a developer how to properly access
> different types of registers.
> 
> I think the best approach would be to use just single regmap for all
> registers with implicit locking enabled and have extra mailbox mutex to
> protect mailbox registers and ensure atomic operations with them.
> This will allow to use regmap cache and also intermixing mailbox and simple
> registers' accesses won't be an issue.
> 
> @Andy Shevchenko, wdym about it?

Sounds like a good plan to me, but I'm not in the exact area of this driver's
interest, so others may have better suggestions.

-- 
With Best Regards,
Andy Shevchenko



