Return-Path: <netdev+bounces-276409-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAeEJ/gj1mklBQgAu9opvQ
	(envelope-from <netdev+bounces-276409-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 11:46:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4303BA15E
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 11:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BCE5303814B
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 09:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB9B39B97E;
	Wed,  8 Apr 2026 09:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cFjExFyb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE9437C10F
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 09:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775641504; cv=none; b=fjkkA/oiM0X/kUWBsYgOsKdHpA6qkYWIUEVuULN3NwdzsxFDc3AfuKkCa3jq+YsMwqxuL0DLn59b6mxcvS7zvfIXOo7CI3X8aTiKPYpFRwOLrnaxKN2PvJF6YfY2DY+21OyIIdTUv9k1j7GlZ3mDZ0TecEoi8Ra0+8wCP+TXWDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775641504; c=relaxed/simple;
	bh=aNK3lGJ+ReU4yjyIXzHgC40nAWHOrbkqOzEc2PfZIag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WQoBtqj3ou2J/qR853ggxULDu3u5R49a8G62CRprEtG0SeN58r6I1NYkZMy7FGEJHdg8MtzSRNCmNIuw/QrZwbgVPGZIXQhJ007O/gT2OPJ1xIEmzZ38bI1U/PojtIin/Fg1nQDPzYf6+LYbzQc2rP0j1evNdnzSLTtO9/XlIOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cFjExFyb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775641502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fVByUgcVRV9cDGwBxu0qdLtCN/YmZ0vWbRv6xHT9zUI=;
	b=cFjExFybkOOpaPsS2MRQUu7Y6rQIsn8eokjw9BqzuBGpnmRJpojYc2AmeQ8/QeDVjG+c5F
	bKOJeT6yA0/zwAHUsRZ5bRGH0obM/IE0kbTCUpbbLI2og3BRFne0I4gWpshvRQ7Fp/r2xO
	deHMLZ9HNZgbYizA2z5qDCh2lftIDY0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-QqfLZcIANHqLSnK_0ttR4A-1; Wed,
 08 Apr 2026 05:44:59 -0400
X-MC-Unique: QqfLZcIANHqLSnK_0ttR4A-1
X-Mimecast-MFC-AGG-ID: QqfLZcIANHqLSnK_0ttR4A_1775641496
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DD409195608D;
	Wed,  8 Apr 2026 09:44:55 +0000 (UTC)
Received: from [10.44.48.188] (unknown [10.44.48.188])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A85A3300019F;
	Wed,  8 Apr 2026 09:44:49 +0000 (UTC)
Message-ID: <dce8bcba-5806-4d8a-a678-c816b292fb87@redhat.com>
Date: Wed, 8 Apr 2026 11:44:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 4/8] dpll: zl3073x: allow SyncE_Ref pin state
 change
To: Grzegorz Nitka <grzegorz.nitka@intel.com>, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 poros@redhat.com, richardcochran@gmail.com, andrew+netdev@lunn.ch,
 przemyslaw.kitszel@intel.com, anthony.l.nguyen@intel.com,
 Prathosh.Satish@microchip.com, jiri@resnulli.us,
 arkadiusz.kubalewski@intel.com, vadim.fedorenko@linux.dev,
 donald.hunter@gmail.com, horms@kernel.org, pabeni@redhat.com,
 kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
References: <20260402230626.3826719-1-grzegorz.nitka@intel.com>
 <20260402230626.3826719-5-grzegorz.nitka@intel.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20260402230626.3826719-5-grzegorz.nitka@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276409-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.osuosl.org,redhat.com,gmail.com,lunn.ch,intel.com,microchip.com,resnulli.us,linux.dev,kernel.org,davemloft.net,google.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0A4303BA15E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/3/26 1:06 AM, Grzegorz Nitka wrote:
> The SyncE_Ref pin may operate as either an active or inactive reference
> depending on board design and system configuration. Some platforms need
> to disable the SyncE reference dynamically (e.g., when selecting a
> different recovered clock input). The hardware supports toggling this
> pin, therefore advertise the STATE_CAN_CHANGE capability.
> 
> Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> ---
>   drivers/dpll/zl3073x/prop.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/dpll/zl3073x/prop.c b/drivers/dpll/zl3073x/prop.c
> index ac9d41d0f978..acd7061a741a 100644
> --- a/drivers/dpll/zl3073x/prop.c
> +++ b/drivers/dpll/zl3073x/prop.c
> @@ -215,6 +215,15 @@ struct zl3073x_pin_props *zl3073x_pin_props_get(struct zl3073x_dev *zldev,
>   
>   		props->dpll_props.type = DPLL_PIN_TYPE_GNSS;
>   
> +	       /*
> +		* The SyncE_Ref pin supports enabling/disabling dynamically.
> +		* Some platforms may choose to expose this through firmware
> +		* configuration later. For now, advertise this capability
> +		* universally since the hardware allows state toggling.
> +		*/
> +		props->dpll_props.capabilities |=
> +			DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;
> +
>   		/* The output pin phase adjustment granularity equals half of
>   		 * the synth frequency count.
>   		 */
Reviewed-by: Ivan Vecera <ivecera@redhat.com>


