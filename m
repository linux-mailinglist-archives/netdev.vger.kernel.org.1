Return-Path: <netdev+bounces-254891-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LgHLgeve2lOHwIAu9opvQ
	(envelope-from <netdev+bounces-254891-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 20:03:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 222FBB3C4D
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 20:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CAB8230136B8
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 19:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF9C2F7AB0;
	Thu, 29 Jan 2026 19:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BH4gOlPe"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF07231836
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 19:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769713412; cv=none; b=j/xudG6R0RorVEpApmLsHq2khaaeHgPxPPv5wWMoVmAFJRon62Qn7hrzevKPkz0kh7kiDPEZXAsniuHVfvPYE73UaBKkvyAS4lo2cX7BEjP5RVlsc+VTcyP3eBJMA1tYnpHaitGe0LR1gGuI2+Vq1ubwi6ngcZ2DQiqJqEi1Qzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769713412; c=relaxed/simple;
	bh=6LkseC6LC7ALnvlzx5abUYnyWpRhz8Mb/gjC8+HkUPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TwUxWTRBDjUuYuY3FEHqKHxyb+45hL1drtLElxwykGIERt+AaJ1CxX/AGL0OQRBmgyRtXbLlGvRYMuY3BkbaHhsyrxnVWHg6+g6jR9xvavMztygcVvKnftPaxTb1NMHBEoen9pCezcjt2T6wcRCaI9xh0o4wcc5v9HHhLKRdGbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BH4gOlPe; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a2d4c3a6-9ea8-4d43-aacc-c27bab4eda95@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769713409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A6kTyM3GeRdLGQZI7pzMmWc5l+zbSMFzRj+5AluvRlk=;
	b=BH4gOlPeEIUSOMSfF0ZSaktXankCYoXjWR7kR3Gq6q9oZjue6jSZMrhFWclFii4eZOq3m0
	oi3CzQtLh8F/cyGX8WAYu0RQHwCvsQbjq+Hzg5+qu5JCtrWgv1DBe1qRWvE8AbFA/fTDaf
	0BnQjqlZbHiZoj6EFANNY2sJLEGWfUA=
Date: Thu, 29 Jan 2026 19:03:23 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] iavf: fix PTP use-after-free during reset
To: Petr Oros <poros@redhat.com>, netdev@vger.kernel.org
Cc: ivecera@redhat.com, mschmidt@redhat.com,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Jacob Keller <jacob.e.keller@intel.com>, Simon Horman <horms@kernel.org>,
 Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
References: <20260129095723.7269-1-poros@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260129095723.7269-1-poros@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254891-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,intel.com,lunn.ch,davemloft.net,google.com,kernel.org,gmail.com,lists.osuosl.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vadim.fedorenko@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:dkim,linux.dev:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 222FBB3C4D
X-Rspamd-Action: no action

On 29/01/2026 09:57, Petr Oros wrote:
> Commit 7c01dbfc8a1c5f ("iavf: periodically cache PHC time") introduced a
> worker to cache PHC time, but failed to stop it during reset or disable.
> 
> This creates a race condition where `iavf_reset_task()` or
> `iavf_disable_vf()` free adapter resources (AQ) while the worker is still
> running. If the worker triggers `iavf_queue_ptp_cmd()` during teardown, it
> accesses freed memory/locks, leading to a crash.
> 
> Fix this by calling `iavf_ptp_release()` before tearing down the adapter.
> This ensures `ptp_clock_unregister()` synchronously cancels the worker and
> cleans up the chardev before the backing resources are destroyed.
> 
> Fixes: 7c01dbfc8a1c5f ("iavf: periodically cache PHC time")
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
>   drivers/net/ethernet/intel/iavf/iavf_main.c | 4 ++++
>   1 file changed, 4 insertions(+)

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

