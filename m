Return-Path: <netdev+bounces-260655-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEVfBgsRnmlVTQQAu9opvQ
	(envelope-from <netdev+bounces-260655-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 21:58:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CEFC18C8C5
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 21:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69F1B304A6F8
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 20:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7EF733B962;
	Tue, 24 Feb 2026 20:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hqZQaiyS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF1E32E6BD
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 20:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771966711; cv=none; b=TBqyb7bqeApcGWQHTevXWJ9UVWgX53wt8mNPtaU+uPTHEXAFvgZxuh6rxRAlVB52DVHR7vhcWSyTQbQ5XNjQQLY6cciMe+1niYMCxclRaqTDHcz3Cs7/8YYJ9Sno4FnDUoJjcSKJcGV0zmk6cuLPfk/6QhFO49ocEZll4JoGLzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771966711; c=relaxed/simple;
	bh=VA5rVSPR9+Osq8pR6EXZHHm0V9koZ4u9rZmMC5kdpYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QfLdMMK1lXgTdV+BlTj0HEuuuM3iY4LAXf4+4o3stfRdHU9V2YrIu8J8/MSAoKWCjr0KGNlPEBAflhTs/K+hSO4PNKltHHJ3z5pYV9GDvIHyj2KNfCMkryFCgGlRhWx1DzHTiNQ1uhHGKj2Ej1d8rqAsWr3FBjWpj3hKM4c3X7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hqZQaiyS; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-506362ac5f7so56681001cf.1
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 12:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771966709; x=1772571509; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1aMb6u1oz4Gh6N0UdiPhO84Q7vikCxPpeKU5vf/v2vo=;
        b=hqZQaiySLsw4PJId7Qnbi37hLS6wVrM670LeoTBbZph19vNy6A5kisE7c1FpEIbzFX
         LPcjUCsJVqxFxpZHsDSKmR4PeZm1VB9sUyH8Nw955/ifFrgtD0AEGWDYk4O9acFQUedO
         q2OKc7/dcIQbVGQTu16uu8I1as+cTVC75pcj36XH5rjhbtS8CJQzjFkdN1ct8PinPTQY
         pUJetq4t/y7B+DDIqUbN9GDDT4jpZQvFjWh5r4hRhZMZ404ipmjwCDf4dDD+uIxVzIfz
         MiOZnVJu7Ce2vi6KEDNHk4n08X6J3SMzd6iip4Bb0JrnQqCO0SlF/VpAKZtwkse86gba
         1fPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771966709; x=1772571509;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1aMb6u1oz4Gh6N0UdiPhO84Q7vikCxPpeKU5vf/v2vo=;
        b=ndQS3AWCY3Q9Weg8tA4LoKuPlzMKpaVbTuhMkfuI6/YdIkEHh4NW7QCFCRONd94RaD
         +qN53bOBaEfu44HEhGXn0oIfePtKxwmjs+GPk8JD+3MMM09nWJwswI/NQII9qgLqpzXm
         ECJxEblvwY/LdbIxK0O4/Coc/vB4iX4LRQqmQCe+3fvEmf58+xBS1kuXMiQBj3L+OSMv
         LD2Mcut945386O+iDq1FxE7ZVdQb9A2HCJaOZITDOROy8v2t/jA4A6JPRwXaXyyEaY8t
         ikWmVv34Z/nyh6dwoYxwzYNoFQgvsWH9Ns2tjHIXtJOnNjYxwj80DtxWMyithPtq4tg0
         sc6w==
X-Gm-Message-State: AOJu0YwVbIKtAdIjLrkSmvgPz4MWaz1LWnq3wryjLQ5lyajpvsrhy/Bi
	YAm9e/NAoquzAJ24CnJfzlb3s6jU6OIL4ycC6U0Hdo5m6ksaVWxSLVEq
X-Gm-Gg: ATEYQzwjl+uB8B1MUPIUjNuJN+PKQSvfNX/Wf5rfwD38XjPPNfOEri4N3imQvfB9p8O
	Rgvo6mhesOizNW9MVSnarYXI9gEN6qDrswbRKh7aA1jHrzAeez8o2Mi91u09cZxZwxsqwGIxlXk
	vOTSAvR1IFRBELv/+QLbyW/vQflsESOok0HHSvlmNZJT0BI7WdDHCQOnkV5ue5EZ7fFFgA9Fkov
	2YlmkeSax5YiMlxu8A3i7eypl3D6u7410Q1WwzpWKj5fHA2IbHbNXJf/NTJmPpd8ylAxYiQfEUV
	JsvzsldujN2uMZsp2hEp9nzbGj4rZT7GlT1MqJG8z3Hs3H2EGSLZ4XV7T0sb9j31A5JsWPhutmU
	1F/NKWYQ4fHe9RR/YVN3VxT8zU3cx5FAQ99VA3Pac9tB5PH+2zi42xzTKxUrbmGUHatN1SnpKu7
	i4SFRo1kMGgg+HHRLTROwPMup+b6rEIpDn73Yl+Cvaj7sZFCNGHCbE0RjkB8KnYWFV
X-Received: by 2002:a05:622a:1101:b0:4f1:83e4:6f55 with SMTP id d75a77b69052e-5073a23ce49mr1511121cf.16.1771966709265;
        Tue, 24 Feb 2026 12:58:29 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1145:4:dc8:6621:56d8:b426? ([2620:10d:c091:500::1:63f7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d510ab5sm106352601cf.4.2026.02.24.12.58.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Feb 2026 12:58:28 -0800 (PST)
Message-ID: <0a850f65-be67-4a66-941f-17d8440e987b@gmail.com>
Date: Tue, 24 Feb 2026 15:58:27 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next, v2 1/2] psp: Support for transmit on logical device
 when the underlying transport device supports PSP.
To: Kiran Kella <kiran.kella@broadcom.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, willemb@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 jayakrishnan.udayavarma@broadcom.com, ajit.khaparde@broadcom.com,
 akhilesh.samineni@broadcom.com
References: <20260223191154.2800616-1-kiran.kella@broadcom.com>
 <20260223191154.2800616-2-kiran.kella@broadcom.com>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <20260223191154.2800616-2-kiran.kella@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260655-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielzahka@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:email]
X-Rspamd-Queue-Id: 7CEFC18C8C5
X-Rspamd-Action: no action



On 2/23/26 2:11 PM, Kiran Kella wrote:
> This is achieved by propagating the psp_dev from the lower device
> to the upper devices in the device stack via a netdevice notifier.
> The lowest device owns the psp_dev pointer while the upper devices
> just borrow the pointer. When the lower device is unlinked, the
> borrowed pointer is cleared in the upper device.
> Assumption being that psp_dev is set on the lowest device before
> any upper devices are stacked on that lowest device.
>
> Signed-off-by: Kiran Kella <kiran.kella@broadcom.com>
> Reviewed-by: Ajit Kumar Khaparde <ajit.khaparde@broadcom.com>
> Reviewed-by: Akhilesh Samineni <akhilesh.samineni@broadcom.com>
> ---
>   net/psp/psp_main.c | 109 ++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 108 insertions(+), 1 deletion(-)
>
> diff --git a/net/psp/psp_main.c b/net/psp/psp_main.c
> index a8534124f626..fac785dcfa0f 100644
> --- a/net/psp/psp_main.c
> +++ b/net/psp/psp_main.c
> @@ -3,6 +3,7 @@
>   #include <linux/bitfield.h>
>   #include <linux/list.h>
>   #include <linux/netdevice.h>
> +#include <linux/rtnetlink.h>
>   #include <linux/xarray.h>
>   #include <net/net_namespace.h>
>   #include <net/psp.h>
> @@ -110,13 +111,45 @@ void psp_dev_free(struct psp_dev *psd)
>   	kfree_rcu(psd, rcu);
>   }
>   
> +/**
> + * psp_clear_upper_dev_psp_dev() - Clear borrowed psp_dev pointer on upper
> + *				   device
> + * @upper_dev:	Upper device that may have borrowed psp_dev pointer
> + * @priv:	netdev_nested_priv containing the psp_dev being unregistered
> + *
> + * Callback for netdev_walk_all_upper_dev_rcu() to clear borrowed psp_dev
> + * pointers on upper devices when the underlying psp_dev is being unregistered.
> + *
> + * Return: 0 to continue walking, non-zero to stop.
> + */
> +static int psp_clear_upper_dev_psp_dev(struct net_device *upper_dev,
> +				       struct netdev_nested_priv *priv)
> +{
> +	struct psp_dev *psd = priv->data;
> +	struct psp_dev *upper_psd;
> +
> +	upper_psd = rcu_dereference(upper_dev->psp_dev);
> +	if (upper_psd == psd)
> +		rcu_assign_pointer(upper_dev->psp_dev, NULL);
> +
> +	return 0;
> +}
> +
>   /**
>    * psp_dev_unregister() - unregister PSP device
>    * @psd:	PSP device structure
> + *
> + * Unregisters a PSP device and clears all borrowed psp_dev pointers on
> + * upper devices (e.g., VLAN subinterfaces) that reference this device.
> + * This prevents use-after-free if upper devices still have borrowed
> + * pointers when the psp_dev structure is freed.
>    */
>   void psp_dev_unregister(struct psp_dev *psd)
>   {
>   	struct psp_assoc *pas, *next;
> +	struct netdev_nested_priv priv = {
> +		.data = psd,
> +	};
>   
>   	mutex_lock(&psp_devs_lock);
>   	mutex_lock(&psd->lock);
> @@ -137,6 +170,12 @@ void psp_dev_unregister(struct psp_dev *psd)
>   
>   	rcu_assign_pointer(psd->main_netdev->psp_dev, NULL);
>   
> +	/* Clear borrowed psp_dev pointers on all upper devices */
> +	rcu_read_lock();
> +	netdev_walk_all_upper_dev_rcu(psd->main_netdev,
> +				      psp_clear_upper_dev_psp_dev, &priv);
> +	rcu_read_unlock();
> +
>   	psd->ops = NULL;
>   	psd->drv_priv = NULL;
>   
> @@ -313,11 +352,79 @@ int psp_dev_rcv(struct sk_buff *skb, u16 dev_id, u8 generation, bool strip_icv)
>   }
>   EXPORT_SYMBOL(psp_dev_rcv);
>   
> +/**
> + * psp_netdevice_event() - Handle netdevice events for PSP device propagation
> + * @nb:		notifier block
> + * @event:	netdevice event
> + * @ptr:	netdevice notifier info
> + *
> + * Propagates psp_dev pointer from lower devices to upper devices when
> + * upper devices are created (e.g., VLAN subinterfaces).
> + * Excluding from this logic, the upper devices that have multiple lower
> + * devices eg., bond devices.
> + *
> + * Return: NOTIFY_DONE
> + */
> +static int psp_netdevice_event(struct notifier_block *nb,
> +			       unsigned long event, void *ptr)
> +{
> +	struct netdev_notifier_changeupper_info *info;
> +	struct net_device *dev, *upper_dev;
> +	struct psp_dev *psd;
> +
> +	if (event != NETDEV_CHANGEUPPER)
> +		return NOTIFY_DONE;
> +
> +	info = ptr;
> +	dev = netdev_notifier_info_to_dev(ptr);
> +	upper_dev = info->upper_dev;
> +
> +	if (netif_is_lag_master(upper_dev))
> +		return NOTIFY_DONE;
> +
> +	if (info->linking) {
> +		/* Lower device is being linked to an upper device.
> +		 * Propagate psp_dev from the immediate lower device to the
> +		 * upper device. The immediate lower device would have already
> +		 * got the psp_dev pointer set in a previous notification (or
> +		 * owns it if it's the lowest device).
> +		 * Upper devices just borrow the pointer.
> +		 */
> +		psd = rtnl_dereference(dev->psp_dev);
> +		if (psd)
> +			rcu_assign_pointer(upper_dev->psp_dev, psd);
> +	} else {
> +		/* Lower device is being unlinked from an upper device.
> +		 * Clear the borrowed psp_dev pointer.
> +		 */
> +		psd = rtnl_dereference(upper_dev->psp_dev);
> +		if (psd)
> +			rcu_assign_pointer(upper_dev->psp_dev, NULL);
> +	}
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block psp_netdevice_notifier = {
> +	.notifier_call = psp_netdevice_event,
> +};
> +
>   static int __init psp_init(void)
>   {
> +	int err;
> +
>   	mutex_init(&psp_devs_lock);
>   
> -	return genl_register_family(&psp_nl_family);
> +	err = register_netdevice_notifier(&psp_netdevice_notifier);
> +	if (err)
> +		return err;
> +
> +	err = genl_register_family(&psp_nl_family);
> +	if (err) {
> +		unregister_netdevice_notifier(&psp_netdevice_notifier);
> +		return err;
> +	}
> +	return 0;
>   }
>   
>   subsys_initcall(psp_init);

The lack of support for netns is a bit of a gap for this feature. It may 
make sense to see if what was posted in 
https://lore.kernel.org/netdev/20260224002410.1553838-1-weibunny@fb.com/ 
is sufficient for your use case, as it handles cases where upper devices 
are in a different netns from psd->main_netdev.

