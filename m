Return-Path: <netdev+bounces-266522-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDgbKjkksWkOrQIAu9opvQ
	(envelope-from <netdev+bounces-266522-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 09:13:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EE125EC1C
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 09:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4507C330841C
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 08:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3381287247;
	Wed, 11 Mar 2026 08:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V5Vt3bQA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D79C1E98E3
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 08:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773216425; cv=none; b=qon3ToOCYDQDd7CXe1SUCeWs84uPqjBKO+Wg/1hoDG416AOWLDI2qJ18Upk/zjnTfkoWUHPU7sOoOVqcCc8tA1pto8QHGGZmo6ydFyQG4GUsOil3r+0O6oN7kd30B2zCPiHcTm+Tgq1E5cqpdjZKvS6MaaRSX6yEc/hQeVtIQJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773216425; c=relaxed/simple;
	bh=BGG9Bg7/RT2Mpno5T2cu2+Tw3wtXTUw6iRza8NOvjuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GfffWXfTugu/QPVgXH+IqR5Fm4NU3tIOCPoYV/y2Fxv8X4/r/6Fe6WTygHWnMowd/1637f+sIdumjcV45z98s42PX7zE59jRC7rsbutjVXxOXlAkirip9hq3HjnjlYx4Qw+iUiBjwyRQNIpyBmIyJWLvd7DHqcWZSUP5xUSnLwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V5Vt3bQA; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773216425; x=1804752425;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BGG9Bg7/RT2Mpno5T2cu2+Tw3wtXTUw6iRza8NOvjuU=;
  b=V5Vt3bQAehkxV/nYxMxS5vUFvTCU8LFa58s5K9vSfHZxoJ5aHihOT2RY
   ejBsWqXkUom9zT4dCWrd8YfFw51FpMvWihRY2mbwl4Uvw2ZooZ3uCxQbF
   Q7QSH82QmFx7gIe+fSqlleB+Gv7q5NosFE6/iFbdPv3JEQmVBO1UwywQZ
   DO/b3NqOwd+XCmdPMM0osXQ6WE9RW+zBjLs0LLbdT3VQa8svtlqp4GNLd
   syu2U92t+aaPZz8gC+jluTNW2+BZHjg4U+y9ZOVq/nU/FT1L5Lom0m2ap
   GdjA1Iq8NYZ4tEQWgdtPbc4dsG0b+W1SxZCc1kgzfovF2Wu26Lq+jUypw
   A==;
X-CSE-ConnectionGUID: 7hn7sspYSVO+U0X2IxnDmQ==
X-CSE-MsgGUID: zB19VEJyTH2etdX7ajE5tQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="78132161"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="78132161"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 01:07:05 -0700
X-CSE-ConnectionGUID: H2DSZ0kATH+1VvirJcfyWw==
X-CSE-MsgGUID: FqND9zNTRKu8IZxEKqH2oA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="216667246"
Received: from mikolajn-mobl1.ger.corp.intel.com (HELO [10.94.252.226]) ([10.94.252.226])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 01:07:02 -0700
Message-ID: <d8a70780-3490-473d-9641-fc015c7993cf@linux.intel.com>
Date: Wed, 11 Mar 2026 09:06:59 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] ice: fix posted write support
 for sideband queue operations
To: Przemyslaw Korba <przemyslaw.korba@intel.com>,
 intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com
References: <20260310110700.345904-1-przemyslaw.korba@intel.com>
Content-Language: pl, en-US
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20260310110700.345904-1-przemyslaw.korba@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: E2EE125EC1C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-266522-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dawid.osuchowski@linux.intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,intel.com:email,linux.intel.com:mid]
X-Rspamd-Action: no action

On 2026-03-10 12:06 PM, Przemyslaw Korba wrote:
> On E830, PTP time adjustment commands sent via
> SBQ don't generate completion responses, causing the driver to
> timeout waiting and return -EIO, when trying:
> 
> phc_ctl eth8 get adj 2 get
> dmesg: ice 0000:1a:00.0: PTP failed to adjust time, err -5
> 
> Add support for posted mode not to wait for completion response.
> 
> Fixes: 8f5ee3c477a8 ("ice: add support for sideband messages")
> Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>

Hey Przemek,

Similarly to what I posted in response to your patch "[PATCH iwl-next] 
i40e: PTP: set supported flags in ptp_clock_info", you are missing 
Reviewed-by tags from internal review. I see you did send for internal 
review but nobody actually provided an RB tag (at least not directly on 
the internal list).

-Dawid

