Return-Path: <netdev+bounces-266519-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QACEGEYisWkOrQIAu9opvQ
	(envelope-from <netdev+bounces-266519-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 09:05:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C6C25E790
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 09:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8753A30514BE
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 08:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400FE3B6BF8;
	Wed, 11 Mar 2026 08:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PciefiXf"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBB831F9B7
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 08:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773216102; cv=none; b=Y9A9uyqT6HRF3oMUs8lB+PBc7FZs884MvVryS9WfgmRZL+YpNso3NhgUaqTG97G8wVzapxkipJ6vodolBwlmCiVzirRat6sjyF0pBCI51IvyEkN/2c9k10VGDiRJ75WPKTt1osROLwGG2gb+VyTpBSZATIqYuFpA8QTLm1YXhFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773216102; c=relaxed/simple;
	bh=zbpJ7hkdbm4ZGh4qt8gdPUqMBxrJaflCnD5tCL28uxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KQYnJij+5KBAqsvYnbFFy9HEleQiTrqfhqy3+tWV9mcfZ/rgkSpvpwTnrIizeNU7NEo3fDjEodbYc8rEIIutT873b1QE4YchGE48G3yKeToQYU2BIIR4M8RzOuCcGOztilCoUEFzYqS6ggxClWUoKFrm51JMwogCUtaLPNapJYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PciefiXf; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773216101; x=1804752101;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zbpJ7hkdbm4ZGh4qt8gdPUqMBxrJaflCnD5tCL28uxM=;
  b=PciefiXf/GAxGZ7idXyT/o5mtNEHviEcI6BA3RQT8Y/5MQN11xhH3s3Z
   oRXmsZSfym/Wsl2pon4WWrVD+197XfU4iyqbPq8nc7GCExbVCUO96rpOE
   E7/yE+ygkCF0BY8YgCFzQ+eFEfLHnq8HiJ+RYhF/LR3iFMJjHHcCvuAo0
   8NQScRWbdqUJMicbZovmw91E/P476woqRb7ZRKmjcw1bRNeMpDqG3Gge0
   CYak2e31D8x8blj0s+6bqQJjYBGJJ6G2HwYnfTlRuNjEwYIA9QeXavK76
   APaj6Bd6vXCA7HQPQIGsUPTJ7Euud5viGN20CEizWYGUI4pwXQ+nkZU6j
   w==;
X-CSE-ConnectionGUID: npy8egMRSfO8GFlONRb6kQ==
X-CSE-MsgGUID: aQL4lSeaSLadG2eT/RIFzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="78131347"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="78131347"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 01:01:40 -0700
X-CSE-ConnectionGUID: ErpfsMPtQWuRebz+UAoZVA==
X-CSE-MsgGUID: 5jpk3QSSSZuNDtXTWgTU9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="216666472"
Received: from mikolajn-mobl1.ger.corp.intel.com (HELO [10.94.252.226]) ([10.94.252.226])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 01:01:38 -0700
Message-ID: <b42c280d-f6b9-4fce-99f9-00ff65916585@linux.intel.com>
Date: Wed, 11 Mar 2026 09:01:34 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] i40e: PTP: set supported flags
 in ptp_clock_info
To: Przemyslaw Korba <przemyslaw.korba@intel.com>,
 intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com
References: <20260309141220.343224-1-przemyslaw.korba@intel.com>
Content-Language: pl, en-US
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20260309141220.343224-1-przemyslaw.korba@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A7C6C25E790
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-266519-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dawid.osuchowski@linux.intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,linux.intel.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 2026-03-09 3:11 PM, Przemyslaw Korba wrote:
> Since upstream commit d9f3e9ecc456 ("net: ptp: introduce
> .supported_perout_flags to ptp_clock_info") and commit 7c571ac57d9d ("net:
> ptp: introduce .supported_extts_flags to ptp_clock_info"), kernel core now
> requires that the driver set the .supported_perout_flags and
> .supported_extts_flags fields in PTP clock info. Otherwise, the additional
> flags will be rejected by the kernel automatically.
> 
> i40e does not support perout flags, so reject any request with perout
> flags.
> 
> Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>

Hey Przemek,

**Please don't circumvent our established process of going through 
internal review before posting to iwl**. You should send to our internal 
mailing list and get at least one Reviewed-by tag first, before posting 
to iwl. I think we make exceptions only when there is a strict time 
constraint and need to get the change out FAST (e.g. bug present in 
Tony's tree or netdev but not in Linus' tree yet). Reach out internally 
if you don't know the process and I can share the proper resources.

> ---
>   drivers/net/ethernet/intel/i40e/i40e_ptp.c | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> index 7bcea7d9720f..8d7958692235 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> @@ -601,10 +601,18 @@ static int i40e_ptp_feature_enable(struct ptp_clock_info *ptp,
>   	/* TODO: Implement flags handling for EXTTS and PEROUT */

Ignoring Simon's comment (not because it doesn't have merit, but because 
I don't know this part of the driver and the referenced patches), given 
you just seem to have implemented setting (or maybe handling) these 
flags in this commit, might be the time to remove this TODO comment? :)

-Dawid

