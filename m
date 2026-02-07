Return-Path: <netdev+bounces-257758-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLzFCtoth2kyUwQAu9opvQ
	(envelope-from <netdev+bounces-257758-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 13:19:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 41254105D88
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 13:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 974B13004D8A
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 12:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F37133E344;
	Sat,  7 Feb 2026 12:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SCwfFz5f"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC5C1F4181
	for <netdev@vger.kernel.org>; Sat,  7 Feb 2026 12:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770466771; cv=none; b=ireHC/TPMdCO8rIxBpnPiziO6fjkuJJEMgE4rkFp3YRjUmO1Ne2lNRS5P6kmlSHnB+soXDYo7jtJgYRX5Xvxu9UPAb1aOV4lZuOa/crNc/KvZPOnI9VTwvl6WIUchI/6bWtVfp5CwoNlTOSxGvOatATdFJ0K2gICJTNkgMxLl/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770466771; c=relaxed/simple;
	bh=QeYL53Ak2yFcYMpP/Jpj3GNpZ4BwuGAfpHotmU0PslI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DRoowODo26e9ZiXomfmqrZ/QQvk5ZoR9HNIxPhcWZa371v0uBWoiPNf+SR1N5Lhjwp0xrbqT9Q5lPwRuNaMFmGE3A5MMhHyzIejeFzQyvjemGMsmyPuFDJsLZWLrW7Dz8CncYOxSE/dVQpfYyXnjeZBPZ8ldPJw15BmA8ARrhlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SCwfFz5f; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <68fb4b7c-0747-4e2f-bc52-ab2b3554abd0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770466769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6yNB8KrLv+X4Xp438IC+Wvmk9yS8xXuVwescnw8Z0QQ=;
	b=SCwfFz5fliI5GJBc47KN6cQ6bn8mMyqtQLW3nVuMETkFWaxK35ndwFnOXMlWpTCzAtiHr3
	XN0SuSbMCYcuLTs/gtb6pjNpCGyaMuA2AoOIckWn+3k5qqSmwpIufjhYUFcIJaZAJIK9KU
	NeNEUnXOYTQRQbSTxfBiR5wofWOpCXU=
Date: Sat, 7 Feb 2026 12:19:07 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v2 2/2] octeontx2-af: CGX: replace kfree() with
 rvu_free_bitmap()
To: Bo Sun <bo@mboxify.com>, kuba@kernel.org, pabeni@redhat.com
Cc: gakula@marvell.com, sgoutham@marvell.com, sbhatta@marvell.com,
 hkelam@marvell.com, horms@kernel.org, bbhushan2@marvell.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 sumang@marvell.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260206130925.1087588-1-bo@mboxify.com>
 <20260206130925.1087588-3-bo@mboxify.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260206130925.1087588-3-bo@mboxify.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257758-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.970];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vadim.fedorenko@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mboxify.com:email,linux.dev:email,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: 41254105D88
X-Rspamd-Action: no action

On 06/02/2026 13:09, Bo Sun wrote:
> mac_to_index_bmap is allocated with rvu_alloc_bitmap(), so free it
> with rvu_free_bitmap() instead of open-coding kfree(.bmap) to keep
> the alloc/free API pairing consistent.
> 
> Signed-off-by: Bo Sun <bo@mboxify.com>
> ---
>   drivers/net/ethernet/marvell/octeontx2/af/cgx.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
> index fd4792e432bf..29f5def796ba 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
> @@ -1822,7 +1822,7 @@ static int cgx_lmac_exit(struct cgx *cgx)
>   			continue;
>   		cgx->mac_ops->mac_pause_frm_config(cgx, lmac->lmac_id, false);
>   		cgx_configure_interrupt(cgx, lmac, lmac->lmac_id, true);
> -		kfree(lmac->mac_to_index_bmap.bmap);
> +		rvu_free_bitmap(&lmac->mac_to_index_bmap);
>   		rvu_free_bitmap(&lmac->rx_fc_pfvf_bmap);
>   		rvu_free_bitmap(&lmac->tx_fc_pfvf_bmap);
>   		kfree(lmac->name);

The code LGTM, but as Jakub metioned in v1, the cleanup should be
a separate patch targeting net-next.

On respin you can add:
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

