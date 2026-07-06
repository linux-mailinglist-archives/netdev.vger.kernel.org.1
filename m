Return-Path: <netdev+bounces-305093-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ySHHBt/DS2qjZwEAu9opvQ
	(envelope-from <netdev+bounces-305093-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 17:03:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C975712579
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 17:03:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=chelsio.com (policy=reject);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305093-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305093-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8B3B63239605
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 14:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC363FF885;
	Mon,  6 Jul 2026 14:18:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stargate.chelsio.com (unknown [12.32.117.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07763FD943;
	Mon,  6 Jul 2026 14:18:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783347523; cv=none; b=V4G9OiSOdTa/QFDx4s6FTnd1FfdIIc/9jyitbZt3g04D4eq4v1Q6sn6IQilFBhbQsz87SI7KyWaHIDF5oFCH280GkbgYVV6PM0/bTkzBp2Bl23uCznZv7Kv1eEwgUAvpZpphUQ+2D28hyyJMDJp5/inO1+G4qZozjDiKFKuUEck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783347523; c=relaxed/simple;
	bh=vegbugGfTFiiLREO9lVZJ01BX9BJRAEFOBuuUJEOkuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+pd12wZk9g8xLzOvi2qaWsU2eq4Ycx7FZL4FWn4GJQhcz/KT6SEHvsPWvykfF0L9kWAOLwGqEsgjlHODQ3RbuchABOAJFznQ08wTH7V8L/mr007o27k5LuZk25VbbgGKA2J/0lguUibEHQqmw3FDFyULZ1/IBMHejx12OqCVmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com; spf=pass smtp.mailfrom=chelsio.com; arc=none smtp.client-ip=12.32.117.8
Received: from localhost (bharat.asicdesigners.com [10.193.191.64])
	by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 666EAJrK022975;
	Mon, 6 Jul 2026 07:10:20 -0700
Date: Mon, 6 Jul 2026 19:40:06 +0530
From: Potnuri Bharat Teja <bharat@chelsio.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: chelsio: cxgb4: Use str_plural() in
 mem_intr_handler()
Message-ID: <aku3PjxIvUxAqhed@chelsio.com>
References: <20260704121010.201016-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260704121010.201016-3-thorsten.blum@linux.dev>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.04 / 15.00];
	DMARC_POLICY_REJECT(2.00)[chelsio.com : SPF not aligned (relaxed), No valid DKIM,reject];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305093-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:thorsten.blum@linux.dev,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[bharat@chelsio.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bharat@chelsio.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:email,chelsio.com:from_mime,chelsio.com:email,chelsio.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6C975712579

On Saturday, July 07/04/26, 2026 at 17:40:11 +0530, Thorsten Blum wrote:
> Replace the manual ternary "s" pluralization with str_plural() to
> simplify the code.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---

Thank you.
Reviewed-by: Potnuri Bharat Teja <bharat@chelsio.com>

>  drivers/net/ethernet/chelsio/cxgb4/t4_hw.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
> index 6871127427fa..29d7b786e51e 100644
> --- a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
> +++ b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
> @@ -33,6 +33,7 @@
>   */
>  
>  #include <linux/delay.h>
> +#include <linux/string_choices.h>
>  #include "cxgb4.h"
>  #include "t4_regs.h"
>  #include "t4_values.h"
> @@ -4867,7 +4868,7 @@ static void mem_intr_handler(struct adapter *adapter, int idx)
>  		if (printk_ratelimit())
>  			dev_warn(adapter->pdev_dev,
>  				 "%u %s correctable ECC data error%s\n",
> -				 cnt, name[idx], cnt > 1 ? "s" : "");
> +				 cnt, name[idx], str_plural(cnt));
>  	}
>  	if (v & ECC_UE_INT_CAUSE_F)
>  		dev_alert(adapter->pdev_dev,

