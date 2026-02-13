Return-Path: <netdev+bounces-258584-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iM+TBcPrjmkCGAEAu9opvQ
	(envelope-from <netdev+bounces-258584-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 10:15:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B30134585
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 10:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D7A6301B713
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 09:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E4734BA4B;
	Fri, 13 Feb 2026 09:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R/3bv5be"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EE034D390;
	Fri, 13 Feb 2026 09:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770974114; cv=none; b=tJK/+BCzE0lU1nmtqtuKkTPGp0VrLSBTireNO82m/8nIEg1IH5gqI+eAj3uGc1Mrj1Hgrq/TW0qbp2vqeChXO8ctx/GZ1b6CahERkdRm4bGRkfB8n6ED4Yr4F7z+ixV1ETyRWuRwu+TZ9OkGLahEpomM3zjPcyhokea3ajzjTIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770974114; c=relaxed/simple;
	bh=/pIuplh8SFOc8oTb32weFrdni83fxcjvjDU8Z3xFPJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jPg27IlLalZlLcf8GeQ8+1VAHIxwFsJREhMP3br6FVM6JvySEksVlAnbq+F5ivLkYaHHvgZIBDn/GEKjgmNUk3wzdIkOC0FREfNVVqzbGo2nA6w+dJ3x01wQ1QLu89qjlWtjMdqv56NF48n5Ahij0aUH7LfFGnU50DInC1l8+3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R/3bv5be; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770974113; x=1802510113;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/pIuplh8SFOc8oTb32weFrdni83fxcjvjDU8Z3xFPJU=;
  b=R/3bv5beFJ/RA09wwHYuyhvy70XhQ1y4ysrBoxjS8xT7zMW0kaY9AqaU
   +J8AMNge7+xwg5BWf9mPZkWJgni8SHw0pMmUMrE0hyv0CmiJ4gZCzpAMZ
   s8iGknfjYudGxIUkG7xe0nDBXxxWGIfjg8S/do1lbg+uBG4ZDxc6KAuus
   0J8w8+MskZBg7EveBTHrS7tAfOpnNsdRc0IChDfAkCwlLwkC0MgDM4T2v
   Xbi3+O4HRisWpDkO0kEbjorKaTYcLJ06kE98vvgxmI/2SG3yX81J+xkbC
   ZvYSISqHf2pGCc4X89in+SY2GaCBlzvvspPYPruRCFLmzVoojFtzubSvk
   Q==;
X-CSE-ConnectionGUID: znin74aKSRedeOxdbcIQJw==
X-CSE-MsgGUID: wdMSxzeZSCeidgUEFORzGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="97615126"
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; 
   d="scan'208";a="97615126"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2026 01:15:12 -0800
X-CSE-ConnectionGUID: OH9LAOpQRcurjb6pGRoQyg==
X-CSE-MsgGUID: e/cLSZzoTsutbJxI4EFLEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; 
   d="scan'208";a="212118474"
Received: from mszycik-mobl1.ger.corp.intel.com (HELO [10.246.18.23]) ([10.246.18.23])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2026 01:15:09 -0800
Message-ID: <adfbee71-f472-4218-bf67-2eb26a0802d4@linux.intel.com>
Date: Fri, 13 Feb 2026 10:15:06 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH v2] idpf: nullify pointers after they
 are freed
To: Li Li <boolli@google.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 David Decotigny <decot@google.com>, Anjali Singhai
 <anjali.singhai@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Brian Vazquez <brianvv@google.com>, emil.s.tantilov@intel.com
References: <20260123065806.3858623-1-boolli@google.com>
Content-Language: en-US
From: Marcin Szycik <marcin.szycik@linux.intel.com>
In-Reply-To: <20260123065806.3858623-1-boolli@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.intel.com:mid,intel.com:dkim];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marcin.szycik@linux.intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258584-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+]
X-Rspamd-Queue-Id: 77B30134585
X-Rspamd-Action: no action



On 23.01.2026 07:58, Li Li via Intel-wired-lan wrote:
> rss_data->rss_key needs to be nullified after it is freed.
> Checks like "if (!rss_data->rss_key)" in the code could fail
> if it is not nullified.
> 
> Tested: built and booted the kernel.
> 
> Fixes: 83f38f210b85 ("idpf: Fix RSS LUT NULL pointer crash on early ethtool operations")
> Signed-off-by: Li Li <boolli@google.com>

Please add iwl-net for fixes, i.e. [PATCH iwl-net v2] in title.

Marcin

> ---
> Changes in v2:
>  - Remove the line to nullify vport->q_vector_idxs as it is not
>    necessary.
> 
>  drivers/net/ethernet/intel/idpf/idpf_lib.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> index 131a8121839bd..f63ab58428d2e 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> @@ -1308,6 +1308,7 @@ static struct idpf_vport *idpf_vport_alloc(struct idpf_adapter *adapter,
>  
>  free_rss_key:
>  	kfree(rss_data->rss_key);
> +	rss_data->rss_key = NULL;
>  free_vector_idxs:
>  	kfree(vport->q_vector_idxs);
>  free_vport:


