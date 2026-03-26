Return-Path: <netdev+bounces-272030-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CO8QNCApxWkU7QQAu9opvQ
	(envelope-from <netdev+bounces-272030-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 13:40:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5241335568
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 13:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4D90F3002B50
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 12:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2233909AC;
	Thu, 26 Mar 2026 12:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KX2Ug8U1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HE2Yw2lF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB6A39099B
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 12:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774528765; cv=none; b=dX3Gnz4Q1cqmetxe49rqR5S+BsbnDlIDlFpdP1XQOnzsOpMirNeBAsw8/BeGGbhvn9sZYPZYMBlO6LQIP3wAhv6EanP9OO+runFFaDnjxJ9GBC9832cbyTWHHh/JyZE5P5VCHQ9hiLwShO+d7VrRwrT3z9RJMnRsXORTW1ax2bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774528765; c=relaxed/simple;
	bh=RcU9/GS8zJAxmHavnBfE/AP4urHRAOMtnr+XmobMn9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ajL/60qbTW2cEWIS+7vVR8vvcGvUm09Q68QkkmE8xc4kgZG+NHVUpkQmUoDzUggW43IsFfWCXQcph73BKcahIxgl4oxfxfp9dcA6fpA4o4tKQiS1G1xPBAejy21TsmmFooeJxqlEKKQ6qaJ0NyXc+zdJ1fxlKy+fIn6ItWLnlXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KX2Ug8U1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HE2Yw2lF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774528762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T6EOhsmRzNJ+L+cyJXDlSVgfS8SFJx6ambkc2N7ApTA=;
	b=KX2Ug8U1ygNToTVwwXZfrAbYWhrXd5y7esF/gtLLRTc2Rk9Xhs2Gjx8/h3StRoeFMUPNOT
	hdt0w6Y8X4UkGTbNtpCD/IabY0SpAUN4VwNzC0dO41XoeqXHVjF3UCW6J5iqwbOWBX+kSi
	qorUZa/I75CmXyX1B2XxXmNlOzrakGk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-lXUJZuF4OYKjqqYsIqCJuQ-1; Thu, 26 Mar 2026 08:39:21 -0400
X-MC-Unique: lXUJZuF4OYKjqqYsIqCJuQ-1
X-Mimecast-MFC-AGG-ID: lXUJZuF4OYKjqqYsIqCJuQ_1774528760
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-487018c8244so6645325e9.3
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 05:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774528760; x=1775133560; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T6EOhsmRzNJ+L+cyJXDlSVgfS8SFJx6ambkc2N7ApTA=;
        b=HE2Yw2lFZR9Onf+MPKWRgpiFrkvk8qMrAHwSd1y0kRAqBAdTW+9NldUEzODSxeQiQu
         eMgey6zgGvm9M/HDOaEu2D9kRSbuCx6VlPFwdbOT7mVcGdKYe9I/wN4IrIKBQIHN7xEU
         ECkfKxgZFBm75HjA+3TowLoQ6+n1uiRSire4vXEndfe5sGKgw5D2xgbwqLoNDWX5Jcgc
         UhRZxR/IBKJrm+ul223zCi5+6yXDbMee+fuU7gYg/C4x5Ng/5kZ7NgMbHbu+AJOySOTO
         oi3LxtzMqgQnwDNwQjhvE9wF+5aj0CC0x96AoFXPEQSAjwe6Bz0Ankf2r4FuDHBD/BIp
         wHCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774528760; x=1775133560;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T6EOhsmRzNJ+L+cyJXDlSVgfS8SFJx6ambkc2N7ApTA=;
        b=Tn9+Dxo5eQ5kn8M5GsgIc6lKKVq7Z6/t6HQiSB1g5gDK3oERKwi0cK0Vuq4BXl0K26
         xkh7djYZGGzstMDp81s+kWf0DXbNaQBenmE6OK8eWB5W6q1d+/6OfGS/bB5Ou+Jt4seA
         rxpHnp5JwbAi2dVeY/iS2g/SFJtqmHwE0vuFg3HHFRqY7ZymuQlWQwGp/y9/9EcBwHhy
         7Ix7UcECQIfuna/NuqkdDXbofx4VETTrPTH/Wywk2zIKfEHACKRmhxlqwOrslmAg+Ce5
         rX3cP5HmX59ghXVAH5RVqGjHdrPOxiOMw/acaKwTVsW8XvBYboVgsOOoD5u95W7fGeqI
         nYSw==
X-Forwarded-Encrypted: i=1; AJvYcCVjeQmA4VIjuBPTQBYPLnkZo0iedojJXLvqyuCMlpnvMnEc3IpBqO0nkHwslEcGsdeKpUi0zwI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIyimR0Ss6xvtR8Olm8LYSgWSrgxy9k9Vrm4HoE8e5gmhNFdg9
	+NrdquJMx9APhRMs2DeG8fho+s3Ug6Gfno0+mlOZhSZ4LBjJDOyKaboIG0KVLiYq556ugrm4S2p
	d8aEzElYfhJvq6k22QMWRenm/M9LwGOfTz1NNGyTryFlXyqAkhDIGe13Mhg==
X-Gm-Gg: ATEYQzxvGwpT5awjKuoEb2ZsmlM4j7ukI/92iw9vvfHfV0z3+SE26q+nari6Kb63ven
	SpmFmdRoDG51nYZ2rzcpfjkPivk1dcI8Gr7lCEJBz8Hl7I5RG9RonfrOxqGkSxR9nwXtjDRf6y2
	YwTXhRksU5NCU0MHX75s772ENCC3bd/lpZCVl45AALOtU6tE9yowE7Qrvr+xIkJ05uJYTCd64aA
	Em1jIwk12JvVTfe18zwHW7m9AW7bSazh2odJAmnq1CD7/m+hlUfn8px3MB2MlCKVUyjWCrJ2ZJF
	b6Ha95986ortZjW9TPJ3mxKRUd1vAWIZDxR0wZHscYOb962q/r+mBfx4kJps14PQKgxWfG+Rg9J
	biNAYuAiatNSP8OvMVTw1I3xj3ujteYdc7KLNBHnlSoE9ewXAwRsoCxtE
X-Received: by 2002:a05:600c:3b12:b0:47e:e2eb:bc22 with SMTP id 5b1f17b1804b1-48715fc3677mr109998015e9.5.1774528759902;
        Thu, 26 Mar 2026 05:39:19 -0700 (PDT)
X-Received: by 2002:a05:600c:3b12:b0:47e:e2eb:bc22 with SMTP id 5b1f17b1804b1-48715fc3677mr109997525e9.5.1774528759400;
        Thu, 26 Mar 2026 05:39:19 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.153.60])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4871fbd6bd2sm20338915e9.3.2026.03.26.05.39.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 05:39:18 -0700 (PDT)
Message-ID: <ab1f764b-de03-48f5-a781-356495257d25@redhat.com>
Date: Thu, 26 Mar 2026 13:39:17 +0100
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
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: horms@kernel.org, linux-kernel@vger.kernel.org, leon@kernel.org
References: <20260323183844.3146982-1-joe@dama.to>
 <20260323183844.3146982-10-joe@dama.to>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260323183844.3146982-10-joe@dama.to>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272030-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,broadcom.com:email,dama.to:email]
X-Rspamd-Queue-Id: D5241335568
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/23/26 7:38 PM, Joe Damato wrote:
> Update __bnxt_tx_int and bnxt_free_one_tx_ring_skbs to handle SW GSO
> segments:
> 
> - MID segments: adjust tx_pkts/tx_bytes accounting and skip skb free
>   (the skb is shared across all segments and freed only once)
> 
> - LAST segments: if the DMA IOVA path was used, use dma_iova_destroy to
>   tear down the contiguous mapping. On the fallback path, payload DMA
>   unmapping is handled by the existing per-BD dma_unmap_len walk.
> 
> Both MID and LAST completions advance tx_inline_cons to release the
> segment's inline header slot back to the ring.
> 
> is_sw_gso is initialized to zero, so the new code paths are not run.
> 
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> Signed-off-by: Joe Damato <joe@dama.to>
> ---
>  v5:
>    - Added Pavan's Reviewed-by. No functional changes.
> 
>  v3:
>    - completion paths updated to use DMA IOVA APIs to teardown mappings.
> 
>  rfcv2:
>    - Update the shared header buffer consumer on TX completion.
> 
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 82 +++++++++++++++++--
>  .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 19 ++++-
>  2 files changed, 91 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 2759a4e2b148..40a16f96feba 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -74,6 +74,8 @@
>  #include "bnxt_debugfs.h"
>  #include "bnxt_coredump.h"
>  #include "bnxt_hwmon.h"
> +#include "bnxt_gso.h"
> +#include <net/tso.h>
>  
>  #define BNXT_TX_TIMEOUT		(5 * HZ)
>  #define BNXT_DEF_MSG_ENABLE	(NETIF_MSG_DRV | NETIF_MSG_HW | \
> @@ -817,12 +819,13 @@ static bool __bnxt_tx_int(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
>  	bool rc = false;
>  
>  	while (RING_TX(bp, cons) != hw_cons) {
> -		struct bnxt_sw_tx_bd *tx_buf;
> +		struct bnxt_sw_tx_bd *tx_buf, *head_buf;
>  		struct sk_buff *skb;
>  		bool is_ts_pkt;
>  		int j, last;
>  
>  		tx_buf = &txr->tx_buf_ring[RING_TX(bp, cons)];
> +		head_buf = tx_buf;
>  		skb = tx_buf->skb;
>  
>  		if (unlikely(!skb)) {
> @@ -869,6 +872,23 @@ static bool __bnxt_tx_int(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
>  							    DMA_TO_DEVICE, 0);
>  			}
>  		}
> +
> +		if (unlikely(head_buf->is_sw_gso)) {
> +			txr->tx_inline_cons++;
> +			if (head_buf->is_sw_gso == BNXT_SW_GSO_LAST) {
> +				if (dma_use_iova(&head_buf->iova_state))

I'm likely lost, but AFAICS the previous patch/bnxt_sw_udp_gso_xmit()
initialize head_buf->iova_state only when
`dma_use_iova(&head_buf->iova_state) == true`. I.e. in fallback scenario
the previous iova_state is maintained.

Additionally AFAICS dma_iova_destroy does not clear `head_buf->iova_state`.

It looks like that 2 consecutive skb hitting the same slot use a
different dma mapping strategy (fallback vs iova) bat things will
happen?!? should the previous patch always initializing
head_buf->iova_state?

/P


