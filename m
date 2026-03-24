Return-Path: <netdev+bounces-271105-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iG/2DKOkwmm3fQQAu9opvQ
	(envelope-from <netdev+bounces-271105-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 15:50:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 911A830A756
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 15:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8CA8314F0CE
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 14:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7A13FE365;
	Tue, 24 Mar 2026 14:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FhM4G5Xa"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D057C3FEB33
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 14:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774363457; cv=none; b=nh61wxAUwBb2ZiI8bKOILMg3wUPoLoxDLVHXWrgWsErgLHwg2OcGACipyFgRm2l/H7rbi+9z5CmBe7aMJHp0qlkN1Zfw6FgDNpUW9cIg8CHgvO2ytnxRqcqWVIXVVyNWvdwOY5vhA6o1qNr+L4RwTceLOha2F7Gl68dZTrHF6+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774363457; c=relaxed/simple;
	bh=ae3v3r2qUaqAeaArkFvjx8+4Pe69+eKurCDVIu99QmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RBt9fVzi7jelxuJ7D8BVWaxW4G+tAdvfEV0TnFdAMspPhvXWL33kP/CqfOg1sBnt9SwYAPBR6n1YmBMdNbuL5gK/qYG3SYTvf2GljvNMI561/PZF1kuHWd6qVyvL8Fn95MIspDnNR5D+hknHAgi8z/mzY0tSfusUoEzUR4qgTss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FhM4G5Xa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774363453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AY2OomX3AbtADrQzR4TpX6QwVYqqT/TeFLNbjWcZfIk=;
	b=FhM4G5XaUXjpfqNMeBUnjb4Hmuw7tyyAtQb06y7yodntmjkJxWaYJfWlAtz/Eh+Q7ZVT0j
	d7ThzPZ3SpTsTvFh2QT5TyNQD78iHm9qceTeIjiZX2b91lhcrPYfdxMaloBqyA/q5NK/Pn
	yP+S5GzEa4fIzxnXfL+MhwmnXca0fd0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-V1H145coOTewGgl4eWMwSw-1; Tue,
 24 Mar 2026 10:44:10 -0400
X-MC-Unique: V1H145coOTewGgl4eWMwSw-1
X-Mimecast-MFC-AGG-ID: V1H145coOTewGgl4eWMwSw_1774363447
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CA6B6180060D;
	Tue, 24 Mar 2026 14:44:06 +0000 (UTC)
Received: from [10.43.2.199] (unknown [10.43.2.199])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C7360180075D;
	Tue, 24 Mar 2026 14:43:57 +0000 (UTC)
Message-ID: <95f100a5-ee80-4944-81b4-1f5edf0ca8cf@redhat.com>
Date: Tue, 24 Mar 2026 15:43:55 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 4/8] dpll: zl3073x: allow SyncE_Ref pin state
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
References: <20260321222627.1193603-1-grzegorz.nitka@intel.com>
 <20260321222627.1193603-5-grzegorz.nitka@intel.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20260321222627.1193603-5-grzegorz.nitka@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271105-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.osuosl.org,redhat.com,gmail.com,lunn.ch,intel.com,microchip.com,resnulli.us,linux.dev,kernel.org,davemloft.net,google.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 911A830A756
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/21/26 11:26 PM, Grzegorz Nitka wrote:
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

I'm wondering about the purpose of this flag, or rather the need to set
it manually from the driver. Surely, the existence of the
state_on_dpll_set() or state_on_pin_set() callback clearly indicates
this capability.

Wouldn't it be simpler for the core to set it directly based on this?

Ivan


