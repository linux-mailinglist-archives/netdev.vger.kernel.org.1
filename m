Return-Path: <netdev+bounces-278340-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHnPMxb83WkRmAkAu9opvQ
	(envelope-from <netdev+bounces-278340-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 10:34:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 546003F7621
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 10:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 59F82300FF8C
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 08:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DED53B27C5;
	Tue, 14 Apr 2026 08:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UwSNwesH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF0D3A9D84
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 08:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776155453; cv=none; b=XGb+mh9xDeeJxX3kYJDTAClB+neVahXtUfp0sWeJZlROeVBPDq+wa49+bXHMAUEPLRsWEoE0bgrUu6ilZlMp08sRLZnGvIJ9COBeDvJJPpncg8V53RjcysR+dCx/814BARiIX3/RxKIHoZu6zs+SqMWdgFbyCIDXdCLLgb3ri8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776155453; c=relaxed/simple;
	bh=45nVOe46ULoulb4X/fCACO1TPDIW2gj4n1adNrS4+KI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l2LMh8II+DYOGXUmF3BYHNrguZKHGw2/KV+D49oyInkTnyMeyxIhu9xBr/rXDeHLFNqEzDM0hDpXHEtOot/5cn+l/2X580TwrqSkY4qtnlyLOfspleylkesGHHpYJQnME1kBLp+bHe/Pa5jyAasKBuzApJYZyQPibywxkHzhBBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UwSNwesH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776155450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DigNPQlaEMr+fYZbjylCUqlUkj2+OF9+JpKPFIeOgh0=;
	b=UwSNwesHhIk6jQ35ggCDqCgi/kZznaBZRYSRYba3dksQsUluD3Ex6tBSWZ12Nkt/1s/sUB
	PtIadhZTjWSoBHhj2PslWZHv6e4iROHfaa+Nz1rbanLiKecTtvKdgtpIvMz1+eoNX4Aldh
	m49r/CCiXWFxnEp5076cf/ETT2Y8ekQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-9yk3hmX1Pz2SUi4zHch4vw-1; Tue,
 14 Apr 2026 04:30:47 -0400
X-MC-Unique: 9yk3hmX1Pz2SUi4zHch4vw-1
X-Mimecast-MFC-AGG-ID: 9yk3hmX1Pz2SUi4zHch4vw_1776155446
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0BF5419560A7;
	Tue, 14 Apr 2026 08:30:46 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.49.51])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1FBA919560AB;
	Tue, 14 Apr 2026 08:30:42 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: lorenzo@kernel.org
Cc: edumazet@google.com,
	kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	pabeni@redhat.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [net-next] net: airoha: Wait for TX to complete in airoha_dev_stop()
Date: Tue, 14 Apr 2026 10:29:49 +0200
Message-ID: <20260414082949.104611-1-pabeni@redhat.com>
In-Reply-To: <20260411-airoha-fix-ndo_stop-v1-1-caddaa181739@kernel.org>
References: <20260411-airoha-fix-ndo_stop-v1-1-caddaa181739@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_NONE(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-278340-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.997];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 546003F7621
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: airoha: Wait for TX to complete in airoha_dev_stop()

Wait for TX to complete in airoha_dev_stop routine before stopping the
TX DMA and run airoha_qdma_cleanup_tx_queue routine. Moreover,
start/stop TX/RX NAPIs in ndo_open()/ndo_stop() callbacks in order to be
sure the TX NAPIs have completed before stopping the TX DMA engine in
airoha_dev_stop routine.

> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
> index 8e4b043af4bc..9e40c8f375c1 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c

[ ... ]

> @@ -1684,18 +1686,26 @@ static int airoha_dev_stop(struct net_device *dev)
>  	struct airoha_qdma *qdma = port->qdma;
>  	int i, err;
>
> -	netif_tx_disable(dev);
>  	err = airoha_set_vip_for_gdm_port(port, false);
>  	if (err)
>  		return err;
>
> -	for (i = 0; i < ARRAY_SIZE(qdma->q_tx); i++)
> -		netdev_tx_reset_subqueue(dev, i);
> -
>  	airoha_set_gdm_port_fwd_cfg(qdma->eth, REG_GDM_FWD_CFG(port->id),
>  				    FE_PSE_PORT_DROP);
>
> +	netif_tx_disable(dev);
>  	if (atomic_dec_and_test(&qdma->users)) {
> +		u32 val;
> +
> +		/* Wait for TX to complete */
> +		err = read_poll_timeout(airoha_qdma_rr, val,
> +					!(val & GLOBAL_CFG_TX_DMA_BUSY_MASK),
> +					USEC_PER_MSEC, 100 * USEC_PER_MSEC,
> +					false, qdma, REG_QDMA_GLOBAL_CFG);
> +		if (err)
> +			return err;
>                   ^^^^^^^^^^

Can this leave the device in an inconsistent state? When read_poll_timeout()
fails (TX DMA busy for more than 100ms), airoha_dev_stop() returns an error
immediately. However, atomic_dec_and_test(&qdma->users) has already
decremented qdma->users to 0, but airoha_qdma_stop_napi() was never called,
so all NAPIs remain enabled.

The networking core (__dev_close_many in net/core/dev.c) ignores the
ndo_stop return value and marks the device as down regardless. When the
device is later brought up again, airoha_dev_open() sees atomic_fetch_inc()
return 0 (old value) and calls airoha_qdma_start_napi() -> napi_enable(),
which hits BUG_ON(!test_bit(NAPI_STATE_SCHED, &val)) in napi_enable_locked()
because the NAPI was never disabled.

The early return also skips the netdev_tx_reset_subqueue() calls at the end
of the function.

Should the code either continue with cleanup on timeout (don't return), or
ensure NAPI and DMA state are properly cleaned up before returning?

> +
> +		airoha_qdma_stop_napi(qdma);
>  		airoha_qdma_clear(qdma, REG_QDMA_GLOBAL_CFG,
>  				  GLOBAL_CFG_TX_DMA_EN_MASK |
>  				  GLOBAL_CFG_RX_DMA_EN_MASK);

[ ... ]


