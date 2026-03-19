Return-Path: <netdev+bounces-269414-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBBbFxDgu2lXpQIAu9opvQ
	(envelope-from <netdev+bounces-269414-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 12:37:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA53F2CA676
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 12:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 281A7305091F
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 11:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7027937DEA4;
	Thu, 19 Mar 2026 11:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gk3SD3mi"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C3936AB65
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 11:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773920062; cv=none; b=NpxysOhlEKyMp/Hi18B8enLkUIUJvhCzYxDO/E/8QuCof2NxuJSCwr5DUNlkmuhrrEgUxBvUr/wQPUwHTXoBi8F6H7A3AwbnZkHEcOYYFWz2UYqvlt3ZXHXJ5ICqrC3DEPjJ1h4Ks3WXiLQd3sQFsLk0j4SaPtsVNAoJmv/WGlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773920062; c=relaxed/simple;
	bh=N4V6O7v6+NOusH8T23yd6RyOzSXb38t0SZHiUng8fMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u0XWYDBcYARbDQ+n2pRfk4RXJDkEUwvOLPrrw8qLUf5WGWrckHVUD1pRUo89+MrAR58RYwiSr6FJ+v086d6EO7/jOUPjk79ohepdg1FqiKgsGMomq3qlAxMl0cTFCJ7y4Sn+hKgJtmCoweQIV4+gs1JJIMpcFebn83gcfwDZVz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gk3SD3mi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773920057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hvMqf6RcaKEJ/snxe8wRtappywsF9h/T3bbk0A+hQeQ=;
	b=gk3SD3mibjmslJmbFnrcWgEc3GT9jSUmSBS+3sIKmrCurG8I+BVNAdwaqUiT8mcxFovys7
	tR/VnfmAGODN5+78u9bmNaknyLwdwHkYUFKfRU7XmuaywK+2by2LiZLx68JIrOyGmKPbkG
	ux4uM/cmwehaw8xvbjbuHy+FTnK+PM8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-aQoaHtfuOCOEsOoKnnTRIQ-1; Thu,
 19 Mar 2026 07:34:12 -0400
X-MC-Unique: aQoaHtfuOCOEsOoKnnTRIQ-1
X-Mimecast-MFC-AGG-ID: aQoaHtfuOCOEsOoKnnTRIQ_1773920051
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8DAAD18005BA;
	Thu, 19 Mar 2026 11:34:10 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.182])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5058D180075B;
	Thu, 19 Mar 2026 11:34:07 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: liu.xiang@zlingsmart.com
Cc: netdev@vger.kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	kuba@kernel.org,
	andrew+netdev@lunn.ch
Subject: Re: net: stmmac: avoid repeated devm_gpiod_get_optional in mdio reset on resume
Date: Thu, 19 Mar 2026 12:34:04 +0100
Message-ID: <20260319113404.189479-1-pabeni@redhat.com>
In-Reply-To: <20260317085143.140376-1-liu.xiang@zlingsmart.com>
References: <20260317085143.140376-1-liu.xiang@zlingsmart.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_NONE(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-269414-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.874];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: DA53F2CA676
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: stmmac: avoid repeated devm_gpiod_get_optional in mdio reset on resume

This commit prevents repeated calls to devm_gpiod_get_optional() during
system resume by moving the reset GPIO descriptor to struct stmmac_priv
and only fetching it once on the first call.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> index 7a66edba8f66..a97ec8d18b40 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> @@ -381,6 +381,8 @@ struct stmmac_priv {
>  	struct bpf_prog *xdp_prog;
>
>  	struct devlink *devlink;
> +
> +	struct gpio_desc *reset_gpio;
>  };
>
>  enum stmmac_state {
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
> index afe98ff5bdcb..da1b256bbb6e 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
> @@ -386,15 +386,15 @@ int stmmac_mdio_reset(struct mii_bus *bus)
>
>  #ifdef CONFIG_OF
>  	if (priv->device->of_node) {
> -		struct gpio_desc *reset_gpio;
>  		u32 delays[3] = { 0, 0, 0 };
>
> -		reset_gpio = devm_gpiod_get_optional(priv->device,
> -						     "snps,reset",
> -						     GPIOD_OUT_LOW);
> -		if (IS_ERR(reset_gpio))
> -			return PTR_ERR(reset_gpio);
> -
> +		if (!priv->reset_gpio) {
                    ^^^^^^^^^^^^^^^

What happens if devm_gpiod_get_optional() fails and stores ERR_PTR in
priv->reset_gpio on the first call?

On subsequent resumes, this check evaluates to false since ERR_PTR is
not NULL, so the allocation block gets skipped. The code then passes
ERR_PTR to gpiod_set_value_cansleep() which returns errors that are
silently ignored, causing the MDIO reset sequence to be skipped.

First resume (acquisition fails):

    stmmac_mdio_reset() {
        if (!priv->reset_gpio) {  // true, priv->reset_gpio is NULL
            priv->reset_gpio = devm_gpiod_get_optional(...);
            if (IS_ERR(priv->reset_gpio))
                return PTR_ERR(priv->reset_gpio);  // returns error
        }
        // priv->reset_gpio now contains ERR_PTR(-errno)
    }

Second resume (reset silently skipped):

    stmmac_mdio_reset() {
        if (!priv->reset_gpio) {  // false, ERR_PTR is not NULL
            // skipped
        }
        gpiod_set_value_cansleep(priv->reset_gpio, 1);  // ERR_PTR passed
        gpiod_set_value_cansleep(priv->reset_gpio, 0);  // ERR_PTR passed
        return 0;  // success despite reset being skipped
    }

Should this use IS_ERR_OR_NULL() instead, or set priv->reset_gpio to
NULL on error?

> +			priv->reset_gpio = devm_gpiod_get_optional(priv->device,
> +								   "snps,reset",
> +							 GPIOD_OUT_LOW);
> +			if (IS_ERR(priv->reset_gpio))
> +				return PTR_ERR(priv->reset_gpio);
> +		}
>  		device_property_read_u32_array(priv->device,
>  					       "snps,reset-delays-us",
>  					       delays, ARRAY_SIZE(delays));
> @@ -402,11 +402,11 @@ int stmmac_mdio_reset(struct mii_bus *bus)
>  		if (delays[0])
>  			msleep(DIV_ROUND_UP(delays[0], 1000));
>
> -		gpiod_set_value_cansleep(reset_gpio, 1);
> +		gpiod_set_value_cansleep(priv->reset_gpio, 1);
>  		if (delays[1])
>  			msleep(DIV_ROUND_UP(delays[1], 1000));
>
> -		gpiod_set_value_cansleep(reset_gpio, 0);
> +		gpiod_set_value_cansleep(priv->reset_gpio, 0);
>  		if (delays[2])
>  			msleep(DIV_ROUND_UP(delays[2], 1000));
>  	}


