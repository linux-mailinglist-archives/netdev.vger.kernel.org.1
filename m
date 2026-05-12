Return-Path: <netdev+bounces-287150-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBTzArEpA2qw1AEAu9opvQ
	(envelope-from <netdev+bounces-287150-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 15:22:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF51521145
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 15:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2EB37308AC97
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 13:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1EA3ABD8B;
	Tue, 12 May 2026 13:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tik147On"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D787F3ABD8F
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 13:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778591718; cv=none; b=qHx27FHoj8FgmshWy6Jz7PDjZpeXMsqkYmxGHWj6WgrQulGpF0Ch7eDQwlKfRjhQX7UoxmHpvwBoBfUVVh/DnlzgSLf9g/jKD1AobV9W+GOiHGphHNJXXZMWY2NmLYn4daNwaUCUhCCWIT9/Ix7gy2iOTmtRXZA1SpvuINYLW18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778591718; c=relaxed/simple;
	bh=LNzoUU/2QmhkFyXEGhah7Q+IjNKnmapBS3zKbsjg6Dk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Em3+bERcrj+fE7CBabaGrDqdEWH2qXQwA7jcmvjb2JcA9O+JermlQobROVrUVLwa8zPM4Dw4kKg45j3c+VD5XI0sN3T3muJOcgKbnxeWxNEezjaJ9lDnYGtdNCpi5n5cX7uMxZSu2jYsBK1klZoR9GK3R706bL4F/zXsptFmgLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tik147On; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778591715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=595qiilA325bhyPMHLeNox7kYeTKtRQEqpL9CIDA3mg=;
	b=Tik147OnBxgDRzoMJtZBpwTIYjNpn69nZLCac0DHwcwNzC/8bV2C0TwXY/WhX9PMX/t0vz
	XocoBFxypKe7JZmtxhZJcbqcGH1Z4nu/nyu7eBGY6LGe1wqcRJBT9OVsxpun1m3W0BOtTN
	cwg1hC1F4APAb8UEUoHSoDcPZdCiI+w=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-346-n8ZHX2AlO1GxdJbh-Uw_vg-1; Tue,
 12 May 2026 09:15:08 -0400
X-MC-Unique: n8ZHX2AlO1GxdJbh-Uw_vg-1
X-Mimecast-MFC-AGG-ID: n8ZHX2AlO1GxdJbh-Uw_vg_1778591707
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A365D18005B4;
	Tue, 12 May 2026 13:15:06 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.48.142])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 36B89180034E;
	Tue, 12 May 2026 13:15:02 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: linusw@kernel.org
Cc: eitschman@nebelreich.de,
	ulli.kroll@googlemail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mirq-linux@rere.qmqm.pl,
	netdev@vger.kernel.org
Subject: Re: [PATCH net 4/4] net: ethernet: cortina: Fix budget accounting
Date: Tue, 12 May 2026 15:14:56 +0200
Message-ID: <20260512131456.189452-1-pabeni@redhat.com>
In-Reply-To: <20260509-gemini-ethernet-fixes-v1-4-6c5d20ddc35b@kernel.org>
References: <20260509-gemini-ethernet-fixes-v1-4-6c5d20ddc35b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Queue-Id: 9BF51521145
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_NONE(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[nebelreich.de,googlemail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,rere.qmqm.pl,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-287150-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.995];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Action: no action

From: AI Reviewer <ai@example.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
net: ethernet: cortina: Fix budget accounting

This patch changes gmac_rx() to return the number of packets received
rather than the remaining budget, and updates the napi_complete_done()
call in gmac_napi_poll() to pass the new value.

Link: https://sashiko.dev/#/patchset/20260505-gemini-ethernet-fix-v2-1-997c31d06079%40kernel.org

> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
> index 4c762229ce42..5839e00aa649 100644
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c
> @@ -1545,7 +1546,8 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
>  			napi_gro_frags(&port->napi);
>  			skb = NULL;
>  			frag_nr = 0;
> -			--budget;
> +			budget--;
> +			received++;
>  		}
>  		continue;
>
> @@ -1565,7 +1567,7 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
>  	port->rx_skb = skb;
>  	port->rx_frag_nr = frag_nr;
>  	writew(r, ptr_reg);
> -	return budget;
> +	return received;
>  }

[High]
With the return value's meaning inverted, does the second consumer of
gmac_rx()'s return value in gmac_napi_poll() still compute what it used
to?

drivers/net/ethernet/cortina/gemini.c:gmac_napi_poll() {
    ...
    received = gmac_rx(napi->dev, budget);
    if (received < budget) {
        napi_gro_flush(napi, false);
        napi_complete_done(napi, received);
        gmac_enable_rx_irq(napi->dev, 1);
        ++port->rx_napi_exits;
    }

    port->freeq_refill += (budget - received);
    ...
}

Before this patch, gmac_rx() returned the remaining budget, so
(budget - received) evaluated to the number of packets received, i.e.
the number of freeq pages consumed.

After this patch, received already holds the number of packets
received, so (budget - received) now evaluates to the unused budget,
which is the opposite quantity.

Does this invert the freeq_refill accounting?

On an idle/light-load poll where received is 0, freeq_refill would now
be incremented by the full budget every poll, causing geth_fill_freeq()
to be invoked much more often than before.

On a saturated poll where received is close to budget, freeq_refill
would barely grow, which is precisely the case where refilling matters
most (and also the case where the napi_complete_done() early-exit
branch above is skipped).

Would updating this consumer in the same patch, for example:

    port->freeq_refill += received;

restore the original behavior?

> 
>  static int gmac_napi_poll(struct napi_struct *napi, int budget)
-- 
This is an AI-generated review.


