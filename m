Return-Path: <netdev+bounces-275946-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKY+Cpri1Gn0yQcAu9opvQ
	(envelope-from <netdev+bounces-275946-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 12:55:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B813AD534
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 12:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3696C30F75D6
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 10:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36BA3A7859;
	Tue,  7 Apr 2026 10:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jpb4PSu1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WIHk8h5z"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2722C39D6F9
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 10:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775558937; cv=none; b=AWpPygLxpA4rQq9Zwaun5+FE4+cXcFAvfOuofWaF7dXxbcTXBuxpVkE4TPnIQ4fyWnsqOPWJFiZiJwzYMreY+eOBKuA381SXZhW15mGByXkblOw/Pu2xBa7VZQs6ku0WdO80v2EQBQPq4cApZ+MxK1Mvqc7l6djJCZt6ouGNP90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775558937; c=relaxed/simple;
	bh=Ytn6pR4N3uMVNtXoQo8Gr27tjtQpaIHKh+ULAxWMXXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NXhgOTE7QgKcNHACCrHqXgEpi1dtk5Akrz5yQpgzL2ym6M3GrEYqee2mAyu1IGhL2WITUStrCLgep76SYOqb3TJtXXpzZ8mIPSN+BzraRJO09Omf93Yj3d36Ob5HBfs6uhHfeowOiuNZ5AgAsNi/XpDpjDsdKZKvZy5kyT1tOSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jpb4PSu1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WIHk8h5z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775558934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fwuWWKD1gpIC79YNQto4eiR0rGIBiL3Ai2I/8/jRRlE=;
	b=Jpb4PSu1WPp/82wKHS1A5pLSXCUK2cVZjNd0VKqy/Szrd3Kq9ZQ7MruLu8E1Vg0OhagsWN
	a+0W6402TOADyWes7lTZdlq16TdHimkWlRpIDYOPFZEPTxUDbk41vkco+wL8bIWp2tpu+2
	Dp5hYubL1e8wYqRMftQKXz7zZURZyFU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-yOsK0nTKNdirX3nPZIDQTQ-1; Tue, 07 Apr 2026 06:48:53 -0400
X-MC-Unique: yOsK0nTKNdirX3nPZIDQTQ-1
X-Mimecast-MFC-AGG-ID: yOsK0nTKNdirX3nPZIDQTQ_1775558932
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43b96365ea8so6224539f8f.2
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 03:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775558932; x=1776163732; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fwuWWKD1gpIC79YNQto4eiR0rGIBiL3Ai2I/8/jRRlE=;
        b=WIHk8h5zpmAfvLzEZvB7xge8JA75yeaXjpxNn5ILvi5TUdctjYSHDbW1KLPZuFZeS6
         fOn7VN4rNJwZFIlt7kO9MGpirIMXv9+zEnZXY5YvU6og5ln86KaPU9PhVVkiEUBhKrGa
         tvNyLxfr9+TbyOlbmVW+P/cFxSend14gY8IiH2EOelDxK468xHwgBqI0XF6L8hCFO2tI
         yrMR+rxdism5cEwm9Xft+Px4qhFMSCIx+W3Y+PBuWbCIx4wxmTvrToDECwGQJAg34P/o
         O21RSip3ded6sDeBfuJ6OF7egyZRYY3cuksSk7I//K5uffRAxocLlnW0yDeUDDxyar91
         u7yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775558932; x=1776163732;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fwuWWKD1gpIC79YNQto4eiR0rGIBiL3Ai2I/8/jRRlE=;
        b=qzDqMDsGpCKiRlQQ9DAMpe5DmffAXnSqToD54HU0xJ4NnH/ilxIkTe6sol7RlVZPS6
         4CadHnBD3GdHLDv9UmjygP3S1LGrSqNuODPQ/ry5N7tbIXjX3ML66WD6bGqFPWdwG27h
         zNn3rBTbZhjKVb/Bxb9AvuQ//7r4fdt7vX7a8EyhKmPurqdBxdh/Ka0QMyDqSmUPfogU
         wYzZem8Z3uM3vj7EqtUUTtz1nkP9ahlwkzVjvCh1jCzS2yBv2h9Lna4+3GNfI1YV0ITv
         3PM5T47SVy4qdc+S1lhn+6yaoTZrqFx3ZpE8GdKY7GO197HkHu9fbRAGB6dbQSCMjyQ7
         p2nQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIdC11BuSEbPD+gKbKT6UYPcO1zVj2UXce61dzLm2j6+3z7jsSxsfMFHSZutEU4KIqjIlGffA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyRTzJlbQFfs+VxWr2tEGLWlAQnnehf0uugcTX2OTZw7NsLWyj
	970S5V04xvAxMiO1b8ET3iZiXmLqgIIeo9951ag74WddkFkKtMXt3Wpq9KD5TcGZG+U8mNWGQyR
	zhv5YTrwUNH1tMw1xD1s+yg0FQ5d5BKrTP0tEVQs+neTaSyhnziq97s7souktg1ADIA==
X-Gm-Gg: AeBDieuJMjmuBYbFBAz3y8NHS/T0j/NmgNN9uHAFpnpo9ner/bkJYMUWw9521NJ+raj
	U5RhrHLpIdJi2hDGM2JGqmLH2recUiEf6sStlFkqzzP9ebvv2oRQFPRP0nXIEfk92vdrxT+qHuk
	XyxDEi7aCXvTwG8Rc9bYeFwPA/I4ooDGutxPN8wWkvGqjSqhFa7AK4EgCBNHFsVfrwVA08iG+yW
	jXuGm3wh9sI8PS0Thfbq+CcE4nDtgd6oizqIiFhGYjD/4iIYeakltzSepnzLP+HMlmb+hSfD+LI
	YJm1lBxXlq175Ae5ifW2HzP4C9r6mVCYcB8xiW5i5oJ+oObVIa2ocltg260wmYycpM2IRZJ1QBk
	LSqCM2hU/naODBZxupQ6awryyP3egAdyg59VQLtCqMzfaIKaC0Fqfd1FH3w==
X-Received: by 2002:a05:600c:4743:b0:487:219e:42d with SMTP id 5b1f17b1804b1-4889970642emr229188235e9.11.1775558931654;
        Tue, 07 Apr 2026 03:48:51 -0700 (PDT)
X-Received: by 2002:a05:600c:4743:b0:487:219e:42d with SMTP id 5b1f17b1804b1-4889970642emr229187935e9.11.1775558931166;
        Tue, 07 Apr 2026 03:48:51 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.153.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48895e19c10sm348616065e9.8.2026.04.07.03.48.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2026 03:48:50 -0700 (PDT)
Message-ID: <ea5ba55d-c212-402a-a977-93c442610d17@redhat.com>
Date: Tue, 7 Apr 2026 12:48:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net] amd-xgbe: synchronize KR training with device
 operations
To: Raju Rangoju <Raju.Rangoju@amd.com>, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch, Thomas.Lendacky@amd.com,
 maxime.chevallier@bootlin.com
References: <20260403072157.1042806-1-Raju.Rangoju@amd.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260403072157.1042806-1-Raju.Rangoju@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275946-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B3B813AD534
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/3/26 9:21 AM, Raju Rangoju wrote:
> +static bool xgbe_kr_training_in_progress(struct xgbe_prv_data *pdata)
> +{
> +	struct xgbe_phy_data *phy_data = pdata->phy_data;
> +	unsigned long kr_start, kr_end;
> +
> +	/* Only wait for KR training in specific conditions:
> +	 *  - Inphi re-driver is present, OR
> +	 *  - Currently in KR mode with autoneg enabled
> +	 */
> +	if (!xgbe_phy_port_is_inphi(pdata) &&
> +	    !(phy_data->cur_mode == XGBE_MODE_KR &&
> +	      pdata->phy.autoneg == AUTONEG_ENABLE))
> +		return false;
> +
> +	/* If training hasn't completed, ensure it actually started */
> +	kr_start = READ_ONCE(pdata->kr_start_time);
> +	if (!kr_start)
> +		return false;

AFAICS kr_start_time is set to the current jiffies value at
initialization time and 0 is a valid - even if unlikely - jiffies value.
The above test is false-positive prone.

> +
> +	/* Training is complete - no need to wait */
> +	if (READ_ONCE(pdata->an_result) == XGBE_AN_COMPLETE)
> +		return false;
> +
> +	kr_end = kr_start +
> +		msecs_to_jiffies(XGBE_AN_MS_TIMEOUT + XGBE_KRTR_TIME);
> +
> +	/* If we're already past the training window, it's not "in progress" */
> +	if (time_after(jiffies, kr_end))
> +		return false;

Sashiko notes wrap-around (32 bits systems) will lead to wrong return value.

> +
> +	return true;
> +}
> +
> +static void xgbe_wait_for_kr_training_inprogress(struct xgbe_prv_data *pdata)
> +{
> +	unsigned long kr_end;
> +
> +	if (!xgbe_kr_training_in_progress(pdata))
> +		return;
> +
> +	/* Don't block the auto-negotiation state machine work item */
> +	if (current_work() == &pdata->an_work)
> +		return;
> +
> +	kr_end = READ_ONCE(pdata->kr_start_time) +
> +		msecs_to_jiffies(XGBE_AN_MS_TIMEOUT + XGBE_KRTR_TIME);
> +
> +	/* Poll until training completes or the training window expires */
> +	while (time_before(jiffies, kr_end)) {
> +		if (READ_ONCE(pdata->an_result) == XGBE_AN_COMPLETE)
> +			break;
> +
> +		usleep_range(10000, 11000);
> +	}
> +}
> +
>  static void xgbe_phy_perform_ratechange(struct xgbe_prv_data *pdata,
> -					enum xgbe_mb_cmd cmd, enum xgbe_mb_subcmd sub_cmd)
> +					enum xgbe_mb_cmd cmd,
> +					enum xgbe_mb_subcmd sub_cmd)
>  {
>  	unsigned int s0 = 0;
>  	unsigned int wait;
> @@ -2104,6 +2171,13 @@ static void xgbe_phy_perform_ratechange(struct xgbe_prv_data *pdata,
>  	/* Disable PLL re-initialization during FW command processing */
>  	xgbe_phy_pll_ctrl(pdata, false);
>  
> +	/* Serialize firmware mailbox access.
> +	 * Protects entire command sequence including busy check, PLL control,
> +	 * and command execution. Uses explicit lock/unlock for compatibility
> +	 * with goto-based cleanup (per cleanup.h guidelines).
> +	 */
> +	mutex_lock(&pdata->mailbox_lock);

The comment is confusing, due the the `xgbe_phy_pll_ctrl()` invocation
just before acquiring the lock.

> +
>  	/* Log if a previous command did not complete */
>  	if (XP_IOREAD_BITS(pdata, XP_DRIVER_INT_RO, STATUS)) {
>  		netif_dbg(pdata, link, pdata->netdev,
> @@ -2115,7 +2189,7 @@ static void xgbe_phy_perform_ratechange(struct xgbe_prv_data *pdata,
>  	XP_SET_BITS(s0, XP_DRIVER_SCRATCH_0, COMMAND, cmd);
>  	XP_SET_BITS(s0, XP_DRIVER_SCRATCH_0, SUB_COMMAND, sub_cmd);
>  
> -	/* Issue the command */
> +	/* Issue the firmware command */
>  	XP_IOWRITE(pdata, XP_DRIVER_SCRATCH_0, s0);
>  	XP_IOWRITE(pdata, XP_DRIVER_SCRATCH_1, 0);
>  	XP_IOWRITE_BITS(pdata, XP_DRIVER_INT_REQ, REQUEST, 1);
> @@ -2123,11 +2197,13 @@ static void xgbe_phy_perform_ratechange(struct xgbe_prv_data *pdata,
>  	/* Wait for command to complete */
>  	wait = XGBE_RATECHANGE_COUNT;
>  	while (wait--) {
> -		if (!XP_IOREAD_BITS(pdata, XP_DRIVER_INT_RO, STATUS))
> +		if (!XP_IOREAD_BITS(pdata, XP_DRIVER_INT_RO, STATUS)) {
> +			mutex_unlock(&pdata->mailbox_lock);
>  			goto do_rx_adaptation;
> -
> +		}
>  		usleep_range(1000, 2000);
>  	}
> +	mutex_unlock(&pdata->mailbox_lock);
>  
>  	netif_dbg(pdata, link, pdata->netdev,
>  		  "firmware mailbox command did not complete\n");

A `xgbe_phy_rx_reset()` invocation will happen here, outside the lock.
Can that race? will that corrupt the nic status?

/P


