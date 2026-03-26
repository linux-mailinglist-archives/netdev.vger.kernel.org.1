Return-Path: <netdev+bounces-272161-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLJUNGlrxWl1+AQAu9opvQ
	(envelope-from <netdev+bounces-272161-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 18:22:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4621F339182
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 18:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BCA7C302447C
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 17:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84AE7342177;
	Thu, 26 Mar 2026 17:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Znylvj5P";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dxItS10F"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9DC383C7D
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 17:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774545619; cv=none; b=Ej+OIo02hi1UbfW8KNhJWluRNfh+i61bn2dZmHP7Cg+nLgl4cryI+MrbaYeBFZb16WY2A6QaAIAvLPi8Kcvz/wgKci07idDNeQYMEARAhgmTtV374pg2TyyegOZiYQvBQCBhknIx2ceWRD/W6IT9sj/Ah8hjvD9zqx17VWYCmIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774545619; c=relaxed/simple;
	bh=gBM9UZ79pVI/XsfVcJ4cNZouZvLoOVOeU7DLOTD8WO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Jxki0W7xs+I0kv5hrsD8FguNxVYZqLgOZtAQMOd83VH4IrvG18qxL64+7kP/m++YVfkyqSLZOxHun8tQOlOIzGwAAEvH0CPRXbgwmtIYMa1eVdvIAokKfnYOHi504TDogTAJ+E28xxeDNwADUgpv8cuV5wQXspH0kNn15p+zx+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Znylvj5P; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dxItS10F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774545616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IQbXc6Nx5DuqMWqXvo+PJJuItcBdEyCvSXgl+nvd2bs=;
	b=Znylvj5PjLsJMQ/W7ggKmCO7iqSJZa/QBofP+DCEk3HZpNzIoXWZXgFxQK45zqVR/44vrT
	KadxW7ADl+ZNFrd/ue1VQ7Ue0pPnGGN21T8dX5hreXtgRK9hMO4Nfb2IOgLdsrSveMBN3+
	z59OSSHubhLFacRhLLlPX4s6SZEt1JE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-0VvzabMWOU6lmfwKEOh3uA-1; Thu, 26 Mar 2026 13:20:15 -0400
X-MC-Unique: 0VvzabMWOU6lmfwKEOh3uA-1
X-Mimecast-MFC-AGG-ID: 0VvzabMWOU6lmfwKEOh3uA_1774545614
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-487219e0800so7256635e9.2
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 10:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774545614; x=1775150414; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IQbXc6Nx5DuqMWqXvo+PJJuItcBdEyCvSXgl+nvd2bs=;
        b=dxItS10FZGeMH17fBvn4qWObwc1pzk9DBXrnSFqVGjrxtHNQ7Rf0HgrLCXASWMNKXt
         wSv5dtONayw/qKrALceca2Pvaa1oDhGJuhfaad4RzxCusmLd+96li869oiYwgl2/ZJih
         GzwBMtH3wX53wIbqyr9QRBYyWjNlRG8H/lLbpfVZbgFYGuxkqT4voKWs8PXj6wv5aJoy
         DIK/6lKWyTq0Szpn/7/VYnPIslExguOl8mmpmKon9rgtDo/T+mLtPqt9AC7cJc/p1KHd
         nsZ8pkMldGf+ipe5D8bPg5DAnYiTpqhLKGwbgE1atGYxqzSDsG84QDwa5a6BOemBBg/O
         yqpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774545614; x=1775150414;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IQbXc6Nx5DuqMWqXvo+PJJuItcBdEyCvSXgl+nvd2bs=;
        b=JfUjC7PSWhkkreqmQqpWHHjmUdtscfRbFx44F9TMIqx+9XDxYOlvHJeZsKlT2HbVOj
         hgl0fz1hBGKGO/MWK7wtFct1sL+1NYctvvfl2cMaolhF1jHnssSiFPspBde90RwEgMXT
         p/jUey9+FrXjrhydyqfW6EHdUSGZXyJ0Zc9L1oB71O5A9OT9tKiWU9jxgySuIz5PrsVw
         LO8W9/ChhingHWU6RwlraD5/voEb9CfBFsv6AMb7hPbWeWt+sAIJHrNafMY7TJha31lx
         gek7u7ojtL3Yy0u7Q7qf7+hTIhxyLcFkvVdcvxZQE7f8BILkWk667sw3UuvHhQX0m35t
         VkXw==
X-Forwarded-Encrypted: i=1; AJvYcCXIV9zJlDwyFziMmGeBMB+4+svtyqNymgc+nnLQj4wvDXJ+UdJaSYRs+k+IlitGdelKh06iRAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPbamGfM8EB7mOLo+/ms0+yYUzdr8ypf30dDVnNo4oBkJcwbVy
	Pjv+J8zjxwJoDp/0VY9SCx+T32nqB153jw1Fk+vWxhDWwnBvz5omw4azsybC3mHqhyKQmWTnffZ
	Up5dFmVuzqqLtrpcN9Udwy9phBP67r9MsI/YptyEBcjfCuphpbXaFArPtkFfmu7OY+w==
X-Gm-Gg: ATEYQzyqJMtPh3tBwSbGN/KIjBnn1oMBin/pirydMdXekKH5zQSvNgMZi7qo4prSGpK
	m5dwUSs5K9Ah+lP0AFOwOZNJ82qaQoYVg7qQDbG2IMOaPjF6oWf5E9GdLtLhc1SCx6Gw9itTxGp
	zAjXl/IoMI4s07LuVzW3Ha4Bug+esG/OFbVSCq8KdZIN8W4WKlV4SoInORtNBiocXa3JsEtf5rk
	d5/wbyaKjX9LQ3fMjluQLx7zhIhVyd5REVdMj2wQHR+UEjlp+Lpg+JbSQtIYc9FMLqetqWZAOLA
	m+yF29w71Ewv88L+vL4miqcfHj5IW1Kqvy5UEWKs4uKqCjxDSX4b6L784d7dCOSKQcEeDzt5Tv8
	cf5NUKLmwt8FPgkXwf8/swwzQ/MuC6gSf6h6YAe6sC0SrpFAyzAJqvzuu
X-Received: by 2002:a05:600c:4685:b0:47d:8479:78d5 with SMTP id 5b1f17b1804b1-48715fc38e8mr133758845e9.7.1774545613787;
        Thu, 26 Mar 2026 10:20:13 -0700 (PDT)
X-Received: by 2002:a05:600c:4685:b0:47d:8479:78d5 with SMTP id 5b1f17b1804b1-48715fc38e8mr133758095e9.7.1774545613194;
        Thu, 26 Mar 2026 10:20:13 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.153.60])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722cb10fcsm41184135e9.14.2026.03.26.10.20.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 10:20:12 -0700 (PDT)
Message-ID: <b33bb10d-630a-4591-a91e-136ade1e970d@redhat.com>
Date: Thu, 26 Mar 2026 18:20:11 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v5 09/12] net: bnxt: Add SW GSO completion and teardown
 support
To: Joe Damato <joe@dama.to>, netdev@vger.kernel.org,
 Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 horms@kernel.org, linux-kernel@vger.kernel.org, leon@kernel.org
References: <20260323183844.3146982-1-joe@dama.to>
 <20260323183844.3146982-10-joe@dama.to>
 <ab1f764b-de03-48f5-a781-356495257d25@redhat.com>
 <acVmr9gxjm6mJ0IJ@devvm20253.cco0.facebook.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <acVmr9gxjm6mJ0IJ@devvm20253.cco0.facebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272161-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dama.to:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,broadcom.com:email]
X-Rspamd-Queue-Id: 4621F339182
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/26/26 6:02 PM, Joe Damato wrote:
> On Thu, Mar 26, 2026 at 01:39:17PM +0100, Paolo Abeni wrote:
>> On 3/23/26 7:38 PM, Joe Damato wrote:
>>> Update __bnxt_tx_int and bnxt_free_one_tx_ring_skbs to handle SW GSO
>>> segments:
>>>
>>> - MID segments: adjust tx_pkts/tx_bytes accounting and skip skb free
>>>   (the skb is shared across all segments and freed only once)
>>>
>>> - LAST segments: if the DMA IOVA path was used, use dma_iova_destroy to
>>>   tear down the contiguous mapping. On the fallback path, payload DMA
>>>   unmapping is handled by the existing per-BD dma_unmap_len walk.
>>>
>>> Both MID and LAST completions advance tx_inline_cons to release the
>>> segment's inline header slot back to the ring.
>>>
>>> is_sw_gso is initialized to zero, so the new code paths are not run.
>>>
>>> Suggested-by: Jakub Kicinski <kuba@kernel.org>
>>> Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
>>> Signed-off-by: Joe Damato <joe@dama.to>
>>> ---
>>>  v5:
>>>    - Added Pavan's Reviewed-by. No functional changes.
>>>
>>>  v3:
>>>    - completion paths updated to use DMA IOVA APIs to teardown mappings.
>>>
>>>  rfcv2:
>>>    - Update the shared header buffer consumer on TX completion.
>>>
>>>  drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 82 +++++++++++++++++--
>>>  .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 19 ++++-
>>>  2 files changed, 91 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>>> index 2759a4e2b148..40a16f96feba 100644
>>> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>>> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>>> @@ -74,6 +74,8 @@
>>>  #include "bnxt_debugfs.h"
>>>  #include "bnxt_coredump.h"
>>>  #include "bnxt_hwmon.h"
>>> +#include "bnxt_gso.h"
>>> +#include <net/tso.h>
>>>  
>>>  #define BNXT_TX_TIMEOUT		(5 * HZ)
>>>  #define BNXT_DEF_MSG_ENABLE	(NETIF_MSG_DRV | NETIF_MSG_HW | \
>>> @@ -817,12 +819,13 @@ static bool __bnxt_tx_int(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
>>>  	bool rc = false;
>>>  
>>>  	while (RING_TX(bp, cons) != hw_cons) {
>>> -		struct bnxt_sw_tx_bd *tx_buf;
>>> +		struct bnxt_sw_tx_bd *tx_buf, *head_buf;
>>>  		struct sk_buff *skb;
>>>  		bool is_ts_pkt;
>>>  		int j, last;
>>>  
>>>  		tx_buf = &txr->tx_buf_ring[RING_TX(bp, cons)];
>>> +		head_buf = tx_buf;
>>>  		skb = tx_buf->skb;
>>>  
>>>  		if (unlikely(!skb)) {
>>> @@ -869,6 +872,23 @@ static bool __bnxt_tx_int(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
>>>  							    DMA_TO_DEVICE, 0);
>>>  			}
>>>  		}
>>> +
>>> +		if (unlikely(head_buf->is_sw_gso)) {
>>> +			txr->tx_inline_cons++;
>>> +			if (head_buf->is_sw_gso == BNXT_SW_GSO_LAST) {
>>> +				if (dma_use_iova(&head_buf->iova_state))
>>
>> I'm likely lost, but AFAICS the previous patch/bnxt_sw_udp_gso_xmit()
>> initialize head_buf->iova_state only when
>> `dma_use_iova(&head_buf->iova_state) == true`. I.e. in fallback scenario
>> the previous iova_state is maintained.
> 
> Note that calling dma_iova_try_alloc zeroes the state before returning whether
> the IOVA DMA API can be used or not and I call that uncoditionally (see
> below).
> 
>> Additionally AFAICS dma_iova_destroy does not clear `head_buf->iova_state`.
> 
> That's my understanding, too, that dma_iova_destroy doesn't clear the state.
>  
>> It looks like that 2 consecutive skb hitting the same slot use a
>> different dma mapping strategy (fallback vs iova) bat things will
>> happen?!? should the previous patch always initializing
>> head_buf->iova_state?
> 
> AFAICT, to switch the IOMMU domain would require unbind the device, changing
> the IOMMU type, and re-binding the device... which would destroy all the rings
> in the process and thus this wouldn't happen.
> 
> The only way I could potentially imagine this happening would be in extreme
> IOVA pressure (maybe?):
>   - packet A in slot N, dma_iova_try_alloc suceeds -> head_buf->iova_state
>     copied
>   - completion the packet occurs, dma_iova_destroy is called,
>     head_buf->iova_state is not cleared
>   - packet B in slot N, dma_iova_try_alloc fails due to IOVA pressure...
>     head_buf->iova_state is stale
> 
> I'm pretty skeptical that this is a realistic case, TBH.
> 
> That said and since it seems my v5 got CR, I can send a v6 with this slight
> change to address the case you've mentioned above.
> 
> I'll send in a couple hours unless I hear otherwise:
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
> index 9c30ee063ef5..7c198847a771 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
> @@ -142,8 +142,12 @@ netdev_tx_t bnxt_sw_udp_gso_xmit(struct bnxt *bp,
> 
>                 tx_buf->is_sw_gso = last ? BNXT_SW_GSO_LAST : BNXT_SW_GSO_MID;
> 
> -               /* Store IOVA state on the last segment for completion */
> -               if (last && tso_dma_map_use_iova(&map)) {
> +               /* Store IOVA state on the last segment for completion.
> +                * Always copy so that a stale iova_state from a prior
> +                * occupant of this ring slot cannot be misread by
> +                * dma_use_iova() in the completion path.
> +                */
> +               if (last) {
>                         tx_buf->iova_state = map.iova_state;
>                         tx_buf->iova_total_len = map.total_len;
>                 }
> 

Since tso_dma_map_use_iova(&map) is the likely option, I tend to think
that the above change is worthy even if the problem I feared about is
extremely unlikely if possible at all: the code is IMHO easier to
follow, and FWIW does not overoptimize an unlikely scenario.

/P


