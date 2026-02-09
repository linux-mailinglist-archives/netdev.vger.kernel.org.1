Return-Path: <netdev+bounces-257931-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIskJRC/iWneBQUAu9opvQ
	(envelope-from <netdev+bounces-257931-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 12:03:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EA45610E7F0
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 12:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64BEB3002A1A
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 11:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D183830BBA0;
	Mon,  9 Feb 2026 11:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mboxify.com header.i=@mboxify.com header.b="SMsTHVEW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-108-mta41.mxroute.com (mail-108-mta41.mxroute.com [136.175.108.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED9A1DE3A4
	for <netdev@vger.kernel.org>; Mon,  9 Feb 2026 11:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770635021; cv=none; b=NmUArS+0UDsqxaEMN9ljBZ+WbzykHDCBJZPLGnRDTpyVXzH3gC1yFsgJZ+z7Ga1aVPm4TwtIcZH72eHzpzRB7q3TkFJ4zZlVsMTszWgOecPP4pAy3scTwBSVQ/11u4yzEmaoL3NZNWlJz5BqSA05smT1zjIn/Wjj6jIPTMfd2o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770635021; c=relaxed/simple;
	bh=ure2+j+S5lx77ssLbz1uN1ALWbylTJ3fn7KOlZRCdAE=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=JSGDRHhp+qtESeFt/UwmY+RERicirgRedZylKUGcoFBNg8pDjz8PcDio3llltNeEuIrGwo9e/wIC31vUtLxHKRiCkAE7iXBq0af5RlaA3Xb8lxN/Ls9Y02v3HMJjVyHoCPO/PmfoDgkce5GJ5XWPa1eCDTnghiFI+SmJ3IJiuRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mboxify.com; spf=pass smtp.mailfrom=mboxify.com; dkim=pass (2048-bit key) header.d=mboxify.com header.i=@mboxify.com header.b=SMsTHVEW; arc=none smtp.client-ip=136.175.108.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mboxify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mboxify.com
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta41.mxroute.com (ZoneMTA) with ESMTPSA id 19c420d8dfd0009140.00f
 for <netdev@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Mon, 09 Feb 2026 10:58:30 +0000
X-Zone-Loop: eef1f9c0e1bb95e23f8da0d610cf2028b152302fe429
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mboxify.com
	; s=x; h=Content-Transfer-Encoding:Content-Type:Message-ID:References:
	In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=8wWtV/FDdg057Du4fTFiHPH5ELD4xyTSm8F4aHtqXMs=; b=SMsTHVEWlZZB5FdPO1ihgnxddx
	/GcHq+phKCRBaLVTMUJB2c8p7at+fpJMauWpouzsjnNk59z7pRRZ3PKXXBXBsg+gVTQ2MNKxjiYNv
	sijCXYcQzub7VXOsExmYGoZVdRV8HxKe7gzy7GwOpuo2ZEZSAIT3rcjxw/si5k8bG3YUxHtYEU9wD
	/iqnbtjh6FUESAyAzAiOcJSZg8QU31PAe8KFuLct2jjXwCBsq6l3G30dtJCtclECnW2PCGaMVrnna
	rC3DO0Z2w772PzOVZhmmkRzbmwwtcLQF20wXpVOH7pzMqUKpV4tXaHAZzMRk0+KHAjsEJDb2zY5S5
	QAo2wTCg==;
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 09 Feb 2026 18:58:28 +0800
From: Bo Sun <bo@mboxify.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: kuba@kernel.org, pabeni@redhat.com, gakula@marvell.com,
 sgoutham@marvell.com, sbhatta@marvell.com, hkelam@marvell.com,
 horms@kernel.org, bbhushan2@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, sumang@marvell.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 2/2] octeontx2-af: CGX: replace kfree() with
 rvu_free_bitmap()
In-Reply-To: <68fb4b7c-0747-4e2f-bc52-ab2b3554abd0@linux.dev>
References: <20260206130925.1087588-1-bo@mboxify.com>
 <20260206130925.1087588-3-bo@mboxify.com>
 <68fb4b7c-0747-4e2f-bc52-ab2b3554abd0@linux.dev>
Message-ID: <95dd319cf45cc5336bd66551157faa68@mboxify.com>
X-Sender: bo@mboxify.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Id: bo@mboxify.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.04 / 15.00];
	DMARC_POLICY_REJECT(2.00)[mboxify.com : SPF not aligned (strict),reject];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[mboxify.com:s=x];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257931-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[mboxify.com:-];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bo@mboxify.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.881];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mboxify.com:mid,mboxify.com:email]
X-Rspamd-Queue-Id: EA45610E7F0
X-Rspamd-Action: no action

On 2026-02-07 20:19, Vadim Fedorenko wrote:
> On 06/02/2026 13:09, Bo Sun wrote:
>> mac_to_index_bmap is allocated with rvu_alloc_bitmap(), so free it
>> with rvu_free_bitmap() instead of open-coding kfree(.bmap) to keep
>> the alloc/free API pairing consistent.
>> 
>> Signed-off-by: Bo Sun <bo@mboxify.com>
>> ---
>>   drivers/net/ethernet/marvell/octeontx2/af/cgx.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c 
>> b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
>> index fd4792e432bf..29f5def796ba 100644
>> --- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
>> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
>> @@ -1822,7 +1822,7 @@ static int cgx_lmac_exit(struct cgx *cgx)
>>   			continue;
>>   		cgx->mac_ops->mac_pause_frm_config(cgx, lmac->lmac_id, false);
>>   		cgx_configure_interrupt(cgx, lmac, lmac->lmac_id, true);
>> -		kfree(lmac->mac_to_index_bmap.bmap);
>> +		rvu_free_bitmap(&lmac->mac_to_index_bmap);
>>   		rvu_free_bitmap(&lmac->rx_fc_pfvf_bmap);
>>   		rvu_free_bitmap(&lmac->tx_fc_pfvf_bmap);
>>   		kfree(lmac->name);
> 
> The code LGTM, but as Jakub metioned in v1, the cleanup should be
> a separate patch targeting net-next.
> 
> On respin you can add:
> Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

Thanks. Will send the respin targeting net-next once it reopens.

