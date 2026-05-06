Return-Path: <netdev+bounces-284711-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBHPBxze+mk2TgMAu9opvQ
	(envelope-from <netdev+bounces-284711-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 08:22:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D684D68C1
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 08:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0C6C6302DE0E
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 06:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DE73016E0;
	Wed,  6 May 2026 06:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lSrXbCAj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7423D2FE042;
	Wed,  6 May 2026 06:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778048530; cv=none; b=WBJceMf5fFlLxO0HD3Q7eXfXn4ri2WtbwCGSXMyETe+mQS6a4C5btw4hU/AGCXdiYipKhLL6DnjjvI10VPma6D/0AwZSQlgVA/YTcT2DVcsSE5UOlnyXJGjkQO/ZadMHhL/JSX72eprid/VVnFAfBFYvwQfmTXVBVBPuzXtBKvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778048530; c=relaxed/simple;
	bh=tO/P59QFbb2wY0arYKYcGmAulgqF0HwsaPPCzm3PclY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pr2OUG6Ef22yZOmBL1Onee97lz2ldJZZE+gfZYepwZIcxF6AH8cap2m+G1XpFwoqOgJ4Te568piVXJxwXlm8rfgyOOMAugthQy3ZqXM7oPfWN6bgv7L+AZRW3Us1SNivFbhtJ3R8uNAhvliR2ffPjY5y80z2jM76/pvDQ3a2VHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lSrXbCAj; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778048529; x=1809584529;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tO/P59QFbb2wY0arYKYcGmAulgqF0HwsaPPCzm3PclY=;
  b=lSrXbCAjY30iTzOl1gf+KQYlbb+V8UzwyWXAfOKqbjcY+rKuEQHY4PHI
   guRyB6UQNk+B9IuphYJamRa3w2DPIT1oqX2QbDc+ltm4B/meo37ASXldn
   65duPB7nkeLd4+vlcfQiw8TOBMFxnWBo8Unr1TURFskIVAgezoA9C3V40
   K73v6hFGZIop4qFjXnZgGbyTzk4mn716OuivF+WrqURgD4glFgCFOl/0L
   3PBu7TbjcehrobUG6mQBEakU0T48YcqnEPL2FvL+4iKYxiIgpRsZNwV6r
   fQSqrQ9G85P20pjD4hQIOCmxFdAUvv5wP8cqqb3hzNl0uuVhc0KJYGwc7
   g==;
X-CSE-ConnectionGUID: zhxc+G6ISbKHiHRdI4/HPA==
X-CSE-MsgGUID: oXQRMCgET1qgBkpwxbEMxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="78993989"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="78993989"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 23:22:05 -0700
X-CSE-ConnectionGUID: a80tDqs4S5eL7ELXQ5SBGA==
X-CSE-MsgGUID: 1usHIHH7QRm7nYQgNoAu2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="235179657"
Received: from mohdfai2-mobl.gar.corp.intel.com (HELO [10.247.37.237]) ([10.247.37.237])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 23:22:02 -0700
Message-ID: <63b186e0-046d-496e-8ae4-d68cd5eb5817@linux.intel.com>
Date: Wed, 6 May 2026 14:21:59 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v4 0/3] igc: add support for forcing link speed
 without autonegotiation
To: David Laight <david.laight.linux@gmail.com>,
 KhaiWenTan <khai.wen.tan@linux.intel.com>
Cc: anthony.l.nguyen@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, faizal.abdul.rahim@intel.com,
 hong.aun.looi@intel.com, khai.wen.tan@intel.com
References: <20260428060009.311393-1-khai.wen.tan@linux.intel.com>
 <20260430154105.505739ac@pumpkin>
Content-Language: en-US
From: "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
In-Reply-To: <20260430154105.505739ac@pumpkin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 88D684D68C1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284711-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,linux.intel.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[faizal.abdul.rahim@linux.intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,linux.intel.com:mid]



On 30/4/2026 10:41 pm, David Laight wrote:
> On Tue, 28 Apr 2026 14:00:06 +0800
> KhaiWenTan <khai.wen.tan@linux.intel.com> wrote:
> 
>> From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
>>
>> This series adds support for forcing 10/100 Mb/s link speed via ethtool
>> when autonegotiation is disabled on the igc driver.
> 
> I'll ask 'why' ?
> 
> In particular forcing half/full duplex has always been a very good way
> of 'breaking' a network connection.
> 
> It really is much better to restrict the advertised link modes and let
> the autodetect/autonegotiation logic in the phy/mac do its job.
> 
> About the only think I can think of is to force 10M HDX when connected
> to a remote system that supports 10M/100M HDX.
> In that case you need to send out single link test pulses, not the
> burst used to identify 100M HDX, or the pattern encoded on the burst
> used by autonegotiation.
> But you need to got back to the mid 1990s to find such systems.
> Anything that supports FDX will do autonegotiation.
> 
> 	David
> 

There's a use case requested:

Profinet Certification tool reports that forcing a link speed without
auto-negotiation is not working.
Forcing the link speed is a critical feature for the industrial automation
"fast-start" use case. When there is a connection lost, the system must
come back up as fast as possible. In PROFINET, that means to force the
speed and rejoin the controller loops. Without supporting forcing the speed
to 100M in Foxville, the certification tool would not be able to certify
the availability of this feature.

I'm hoping this context is enough to justify the need?

