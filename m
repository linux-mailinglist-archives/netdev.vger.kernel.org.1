Return-Path: <netdev+bounces-151079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 753979ECBC9
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 13:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2BB91676C8
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 12:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF692210F0;
	Wed, 11 Dec 2024 12:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T+Tva0gn"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8C12210E7
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 12:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733919324; cv=none; b=G3e822bMLdKgkQtOjBALw9Sv899RH49Grs/dEOlyhjq+4tTjrnj5I0o6nO1SYoOQN0q7a9PKfQWgcZN1/6lt0XOoSjPDMZBJQRDZkK7c720eUHlUavd6AG8ajV6pmK7DsobB9sIPkAQxL18hhaF3ktNckOdMICBuIhdyElP3HRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733919324; c=relaxed/simple;
	bh=locpQUNjVQ3jou0lwGopIGFTac8u7H06gk9qV1Yj+JE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hbuyPKDOuQ4bR8eppYK3fID1x/FelCnbSRedBrQPeoGxxrjl1ba4vi/bFoQ/Kjbfj6kAl4uUKCvttP9ptqQkZYBGAD2SxezjCX0Dt+q8SEaAH2ayFVua3cwO7vqEd+vQ3Ss8g2jgyMYSBUu4r5wwGIM/4qiiHjymHXk0Q33VspU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T+Tva0gn; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733919323; x=1765455323;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=locpQUNjVQ3jou0lwGopIGFTac8u7H06gk9qV1Yj+JE=;
  b=T+Tva0gncMSDLgYDWx7B9edq3tnIA9vkm4p4Cknii8d1OKLjD0lpTQFx
   +qYqgWNn5GBVjhUO+BrUZWw4fnSoqlwwL1Us1tTDKqxGufm0GPdy8MwVb
   /eH6wzY0I0O62+Nphk7oGECgOSzDXzzptTeJd6Nyyu6RTib7DMjxII0R7
   ldzTZXjPbq9+HdLnXsv+xINSI6J6ycmP9qOibUScS8YkBazKI22Ym6a0J
   24ooLNnn9ZKF0M3HFMYoeI09BBGXWDcwW7TniAvMP029F/0LBNI9thiWh
   l0O2RqmCuhY8VbfcLsalTfPdeuOSTwFI5tX4qABbxjjpx5xPmDk+qIfai
   g==;
X-CSE-ConnectionGUID: HOOOcrwtTSWFTVRsHDpaXg==
X-CSE-MsgGUID: 35/cPxL5QkaZrrGwN9lAYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="45308430"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="45308430"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 04:15:22 -0800
X-CSE-ConnectionGUID: FcsnI6AJSMeDfa7OhXsNkw==
X-CSE-MsgGUID: fs3OAwktTIO/c4be729g6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="99871971"
Received: from mszapar-mobl1.ger.corp.intel.com (HELO [10.245.84.66]) ([10.245.84.66])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 04:15:19 -0800
Message-ID: <b3b23f47-96d0-4cdc-a6fd-f7dd58a5d3c6@linux.intel.com>
Date: Wed, 11 Dec 2024 13:15:06 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/1] Proposal for new devlink command to enforce firmware
 security
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, horms@kernel.org,
 jiri@resnulli.us, stephen@networkplumber.org, anthony.l.nguyen@intel.com,
 jacob.e.keller@intel.com, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org
References: <20241209131450.137317-2-martyna.szapar-mudlaw@linux.intel.com>
 <20241209153600.27bd07e1@kernel.org>
Content-Language: en-US
From: "Szapar-Mudlaw, Martyna" <martyna.szapar-mudlaw@linux.intel.com>
In-Reply-To: <20241209153600.27bd07e1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/10/2024 12:36 AM, Jakub Kicinski wrote:
> On Mon,  9 Dec 2024 14:14:50 +0100 Martyna Szapar-Mudlaw wrote:
>> Proposed design
>>
>> New command, `devlink dev lock-firmware` (or `devlink dev guard-firmware`),
>> will be added to devlink API. Implementation in devlink will be simple
>> and generic, with no predefined operations, offering flexibility for drivers
>> to define the firmware locking mechanism appropriate to the hardware's
>> capabilities and security requirements. Running this command will allow
>> ice driver to ensure firmware with lower security value downgrades are
>> prevented.
>>
>> Add also changes to Intel ice driver to display security values
>> via devlink dev info command running and set minimum. Also implement
>> lock-firmware devlink op callback in ice driver to update firmware
>> minimum security revision value.
> 
> devlink doesn't have a suitable security model. I don't think we should
> be adding hacks since we're not security experts and standards like SPDM
> exist.
> 
> I understand that customers ask for this but "security" is not a
> checkbox, the whole certificate and version management is necessary.
> 

Hi Jakub,

Thank you for your response. Apologies if any of earlier wording was 
unclear or poorly chosen.

While this feature is needed for security reasons, its implementation in 
the kernel isn't directly tied to kernel/driver security.

The E810 Ethernet controller firmware provides a certain level of 
security, which includes a mechanism to prevent firmware downgrades (to 
past, less secure versions). However, it is the driver that needs to 
initiate this mechanism. After "locking/fusing/freezing/guarding" (open 
to name suggestions) the current firmware version, upgrades would still 
be possible. The card itself handles firmware validation, including 
verifying signatures and ensuring that only properly signed and accepted 
firmware can be installed. Thus the firmware can only be upgraded to a 
validated version that the card has approved.

This patch does not aim to introduce a new security mechanism, rather, 
it enables users to utilize the controller's existing functionality. 
This feature is to provide users with a devlink interface to inform the 
device that the currently loaded firmware can become the new minimal 
version for the card. Users have specifically requested the ability to 
make this step an independent part of their firmware update process.
Leaving in-tree users without this capability exposes them to the risk 
of downgrades to older, released by Intel, but potentially compromised 
fw versions, and prevents the intended security protections of the 
device from being utilized.
On the other hand always enforcing this mechanism during firmware 
update, could lead to poor customer experiences due to unintended 
firmware behavior in specific workflows and is not accepted by Intel 
customers.

Devlink tool was proposed for this purpose, as it is designed for 
administrative/root-level tasks such as this. Perhaps it would be more 
appropriate to integrate the proposed implementation as a subcommand 
(attribute) under the devlink flash API, which was the second considered 
option, rather than keeping it as a separate devlink command?

Thank you and best regards,
Martyna

