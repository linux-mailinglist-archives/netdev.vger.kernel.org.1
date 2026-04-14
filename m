Return-Path: <netdev+bounces-278568-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJmlJpmT3mnZFwAAu9opvQ
	(envelope-from <netdev+bounces-278568-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 21:20:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF903FDFD1
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 21:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DDB503088BA0
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 19:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15372DCBF4;
	Tue, 14 Apr 2026 19:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VkXUI/g3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="h0u6ubxO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681A2282F25
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 19:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776194206; cv=none; b=tVxRcLYn4+AXHEpahcRMPzSrm0zHLzp1g52dcLvT6zNndKIQO9NdhTq9ifMOgiBcdPXnucQkeM+NNtCZDFB5aeNdIedpLz5vuiP2KnVB2v4QTCWxzbVGvU/8NJqHt7PBLcdiTEPxX62Rd0Tt/GWcnHnqnhBcIWa4/JeoOBbrx98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776194206; c=relaxed/simple;
	bh=Kae0NE+YEJhUab058VBKfamPJWyW4Acc1sAaLV1mvK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rm/uYUAAq/QfzfL7TD+ve0Bq8F15qtBLdsyi14pzti0aNJUsoFvngXVsl4AizoDjdLd+MQSjFNIp86qfVHUh3vVtVwPtdiUgb8SxU3IAuxDdLBpYFMqFhkUE8494SdjXBS1FHsHjWhDZ6lTDr28rmh3srqLLzBdn/n+f6MBCYjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VkXUI/g3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=h0u6ubxO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776194203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OTjtecZ1iSoz/j8YichwBmmBonCgsoUrO3OWetqEhiA=;
	b=VkXUI/g3loQQhli1XAfsiBcPhnQp2D8gazeJm1BeE7LV0CmO3h2XYmys1NHsUzUbdmPQuM
	+K6a1nDIAOK70lYigaHfmycOpHY/qjl4HptgUpa458wIHvrSyDRphExyTZiQgoBuoHk7MX
	fztJBky3cuYkx0lIqX2MIb38iNlvAYc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-sQFYKgF4Nc2CBMcvQBtuMw-1; Tue, 14 Apr 2026 15:16:41 -0400
X-MC-Unique: sQFYKgF4Nc2CBMcvQBtuMw-1
X-Mimecast-MFC-AGG-ID: sQFYKgF4Nc2CBMcvQBtuMw_1776194201
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43d05004501so403554f8f.3
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 12:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776194201; x=1776799001; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OTjtecZ1iSoz/j8YichwBmmBonCgsoUrO3OWetqEhiA=;
        b=h0u6ubxONkBkpDvSL5lt0dhYd7ubTWAp7fKiqQzPMMNkoX1Wt1KY+7edzEG8/VDOTt
         LzzC2kY+T95sBfKHtFIDtYtShgnGajw7HX62R/PiLpNPwIYJyfqokXQc6BOYgannPfut
         +45x6afia1Pjxk8QJSoBjcxcjfJm19r++cDaMCEk2x5rOTkCpUO66qZEQPQXFNI0LN22
         qbnxb8OZtzS+W5yQY6epS8hfayrU6NSIJFB12pH/DLCQY7cRdVKKnqEWHmR9OrV7/VuW
         HvJWkTJUbkKN/hZSMB1tkoOpwZK6RA6Z1mtd7QwOQO/eQ9HWMPU8zTdSe6bO6XePo7EA
         13RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776194201; x=1776799001;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OTjtecZ1iSoz/j8YichwBmmBonCgsoUrO3OWetqEhiA=;
        b=gtMGRiMgswrEaAjDYaGtiIMjFfa8mY/A+VSgPO/s/pmDvGFiVR4XWIuC90a9ydeoyb
         ZMdZLTLlTg5Vaw4AHN8J6HTBou1bSwSjImwRcKMU74BFxtK2oORdXj/K+LDcN6/CeA7J
         8ttQpCAzuRD22xJNn4C9/x3OQQNi7nPaI5c80pF6XvanG0zLIQXaD8uFOwce39iFGk8X
         VBT7scRnffgTQGQHTSw6UNkrNq9CIG+MyyRJ2umGlatAT19wbUBpkOb1K/CW8fHEnbrm
         JEPZF9WXFRnf43UzMLOc3++e18YHT+AS5pP53nJpFTJb6XvtkxCK8Rnm+FtcVaVvq4CY
         XCBg==
X-Forwarded-Encrypted: i=1; AFNElJ8Pi8B2bnGeygmXPYxFxPADIt4tPy/seAEGD6CoCC4Kr7f01my/T2WVXFBAFd1CWZi6i3iVEks=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl2Hlb79p7/K9xRVY0l0D8k5NkFRoHEbEaQn6rOBq5N0JpR3uR
	JqF+XyQvitsZwh3QsaVpqpTjfKHUesesnflhrlWPUOq6KBOk+0tRK8uFbIfTQ/Esc5jaWICIWiX
	yKKiH/jF8j0kksYAQvPoAh0hAHfnK2I6rRJOF1qXHWePqMrgf76kxTYPznQ==
X-Gm-Gg: AeBDietfwZFzdLumsIuJj0uEkvplU8g0C9zZB5RT1ZUBzRSQyFMzFGRxGyjybkLmVdz
	59OBRgFKPfNRA5FHAosntd7K2OYY179qkfA7lWzk9tt7oGQ33fEmAEjh1/ug4jQlmuLtq0m1N4q
	V0lJuwmX8crsFRhsXNWOWr5dGNSQHGdPmq4OnuFOhyti4skEKUDDaCofdUv9qNsmfem8HVIYk0+
	0vbdHr52/4ydk+rVHGK2tm3cb1AcMzvtsFz9ZgwV05KpHE50NdqaSJFzruDaUz/FXzEUXZ9K6IQ
	IIOhf58LvbIk7Tr5sF0YtKhC7W2BZo3IXtyVIHDbH/rjT7plFLQaR9K6iyD8qaY7Jq8yTT/EzR2
	TbyY4jiOf5kTJUnyYMofPp2itS89/eG+Q9vPj8rm1x+Id9+w=
X-Received: by 2002:a05:600c:4689:b0:485:358b:e7ee with SMTP id 5b1f17b1804b1-488d6655c82mr155399275e9.0.1776194200594;
        Tue, 14 Apr 2026 12:16:40 -0700 (PDT)
X-Received: by 2002:a05:600c:4689:b0:485:358b:e7ee with SMTP id 5b1f17b1804b1-488d6655c82mr155399085e9.0.1776194200138;
        Tue, 14 Apr 2026 12:16:40 -0700 (PDT)
Received: from [192.168.1.77] (109-81-81-198.rct.o2.cz. [109.81.81.198])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d73b44b3esm27090422f8f.13.2026.04.14.12.16.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 12:16:39 -0700 (PDT)
Message-ID: <68b5cc9d-81d2-4ff5-9d3e-a6d6746dcb3e@redhat.com>
Date: Tue, 14 Apr 2026 21:16:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v5] ice: fix missing dpll notifications for SW
 pins
To: Petr Oros <poros@redhat.com>, netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
References: <20260409102501.1447628-1-poros@redhat.com>
Content-Language: en-US
From: Michal Schmidt <mschmidt@redhat.com>
In-Reply-To: <20260409102501.1447628-1-poros@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278568-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mschmidt@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ECF903FDFD1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/9/26 12:25, Petr Oros wrote:
> ---
>   drivers/net/ethernet/intel/ice/ice_dpll.c | 74 +++++++++++++++++++----
>   1 file changed, 63 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
> index 3f8cd5b8298b57..d817f17dcf1951 100644
> --- a/drivers/net/ethernet/intel/ice/ice_dpll.c
> +++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
> @@ -1154,6 +1154,30 @@ ice_dpll_input_state_get(const struct dpll_pin *pin, void *pin_priv,
>   				      extack, ICE_DPLL_PIN_TYPE_INPUT);
>   }
>   
> +/**
> + * ice_dpll_sw_pin_notify_peer - notify the paired SW pin after a state change
> + * @d: pointer to dplls struct
> + * @changed: the SW pin that was explicitly changed (already notified by dpll core)
> + *
> + * SMA and U.FL pins share physical signal paths in pairs (SMA1/U.FL1 and
> + * SMA2/U.FL2).  When one pin's routing changes via the PCA9575 GPIO
> + * expander, the paired pin's state may also change.  Send a change
> + * notification for the peer pin so userspace consumers monitoring the
> + * peer via dpll netlink learn about the update.
> + *
> + * Context: Can be called under pf->dplls.lock, dpll_pin_change_ntf() is safe.
> + */
> +static void ice_dpll_sw_pin_notify_peer(struct ice_dplls *d,
> +					struct ice_dpll_pin *changed)
> +{
> +	struct ice_dpll_pin *peer;
> +
> +	peer = (changed >= d->sma && changed < d->sma + ICE_DPLL_PIN_SW_NUM) ?
> +		&d->ufl[changed->idx] : &d->sma[changed->idx];
> +	if (peer->pin)
> +		dpll_pin_change_ntf(peer->pin);
> +}
> +
>   /**
>    * ice_dpll_sma_direction_set - set direction of SMA pin
>    * @p: pointer to a pin
> @@ -1233,6 +1257,8 @@ static int ice_dpll_sma_direction_set(struct ice_dpll_pin *p,
>   			ret = ice_dpll_pin_state_update(p->pf, target,
>   							type, extack);
>   	}
> +	if (!ret)
> +		ice_dpll_sw_pin_notify_peer(d, p);
>   
>   	return ret;
>   }

ice_dpll_sma_direction_set() runs to process a DPLL_CMD_PIN_SET command 
from userspace. It runs with dpll_lock held - taken in dpll_pin_pre_doit().
ice_dpll_sw_pin_notify_peer() -> dpll_pin_change_ntf() will take 
dpll_lock again and deadlock.

Michal


