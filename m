Return-Path: <netdev+bounces-207068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FC4B05845
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 13:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A3921A61093
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 11:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5B3226CF1;
	Tue, 15 Jul 2025 11:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VxhJcCGB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5A4241114
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 11:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752577221; cv=none; b=nCx1tb7MuKrZvg/BI0S4gOHZFNKP3lcJ0Of8nC0tPjJ3lXGQj4KMboY9FBiePROoWqhaS9PuuOBJg7p+BsdXddu7n1jamVaZgk0HMpS33gi2NW0+i2uh63zp7GkilCnKgghuBRlIf7f8uoVyKtk2cy78tNTr2ZKIZ0KTJPPjCls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752577221; c=relaxed/simple;
	bh=VWAyEjhzHfZnqcZyzvhGGhaLq9uUeL69FOpazGDX8lQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iJfF241ZBnZZEaOrwHfjakFnGCaSKjk2hPBzJeSCoks2AVaXVhXuk6fuwNDd8Pa4Nyqdr6YOQLtPTvajgC3eZxJ+iZYpAP49UJFAL7QoQcs6mC55/fWGzQlnZ9KwD25Bi3r1N9Mikleb9wPhtT2oQGRBdW0OJDpD0UxFjvhOxCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VxhJcCGB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752577218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UDYromUN4X7oqrVyCqPutBBMeduCEyx9kb+TcCXFA9w=;
	b=VxhJcCGBpeYTt0XKP1gNSHODZJW1CNCNLL0zT6qdRtG7iIPy61Q/p71ADNvCgkKWWsO/nk
	y0iz/0bIOXK4PPmhjRAJdz50BSYy+vgY/WoSUfRm883TlqP6/nmbWgy8Oxo3hoJkxWU+1X
	sQ8RLWXNwwAwUIE/gOIYBBQj+Xqm6SM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-rSzbYb8rPVKvX53YnXUX6Q-1; Tue, 15 Jul 2025 07:00:16 -0400
X-MC-Unique: rSzbYb8rPVKvX53YnXUX6Q-1
X-Mimecast-MFC-AGG-ID: rSzbYb8rPVKvX53YnXUX6Q_1752577216
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-451ac1b43c4so29542795e9.0
        for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 04:00:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752577215; x=1753182015;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UDYromUN4X7oqrVyCqPutBBMeduCEyx9kb+TcCXFA9w=;
        b=vTUyu7lK6JJ4KUDLoPfMPEQZeQYJL6/+2FCK4LsO0jZ8ok6q91utjxghVZ0eQg9vy2
         8OWSdvO6LTVXhnPGXnRbx3cFuTe8x01MrUpA2bRt+wy7I1rXsFPSj3ynXCMa2FjGKfOI
         KUWLYkoRAL0fX+OkI4H10auNtApO3j0jwT7X8htd9vw0byRXZYhklT2c/RYMERUamwr6
         TehG8USMYSr+08QTZLD4l/hDrHCAqI09CqYsbDxfjeyrmi0rO4EuVX/cgvXyDvq8/K+f
         2mglmqx/Qo0WABLYhglQqZT4WVpjuQKoCUhuaGPy/agGsmRef0fN6CmQnDAVMuEcNC7/
         DEsw==
X-Gm-Message-State: AOJu0YxHJ00XGoF7WgdO7AJIMLeMZaObTcQ7Ph2cJKfvD3pmMZ6hAbht
	asK78VDAgah9tFY0s5TPZLizb0Zl/06qb2F630QiJfdhMt07oHWdiNZVRoCt3muFFtzhciRLS7f
	3UU06E11NxiE5ZR4Q9LtzTQeDFAGJUsZ+gQxS796UtjJNF1yjAz/6kq9YFA==
X-Gm-Gg: ASbGncv60bUyq1C3SIaFizfqInF+SDA5/28CravtTuak8f0JjyIoTXr2RAaOVH0GB0L
	nYQiryhXgw8jxjVtbehlDLOMZjhda75M4YdCjkcyb3Vn1EP8SfudFVde/L4KnFpf0SwmtpDQJJL
	Mhb/0qgmEEwuk6xNmFpWpWzU/cITUQKT52Z9dg7m+eYKawdsQLC1NqBc/PxU5niQwfUaB5SHHys
	zWBHVirZsq3waq/iF07GKgo5xpMh1WQEBDIUVdDZqMNDfQ7AWoWCkHTOed8Px1jHMmuLcRD4b6v
	u70F6IKmz6MjG1ihkkIHVqEhYUmmD+Z7Y7mjLiblN7/ZJOyrZzI4ZiFMuuXEnrMYYnJay4ML51H
	7H26VO8APNtU=
X-Received: by 2002:a05:600c:6085:b0:456:1b8b:b8ab with SMTP id 5b1f17b1804b1-4561b8bbb3bmr77641355e9.30.1752577215397;
        Tue, 15 Jul 2025 04:00:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvLBXQE4ArALHQLB4NkFBGD4rJKckvmXpQwHHB8XEVhqM7Eox/KFB5OvuAq4wE1jUZVKgQ0w==
X-Received: by 2002:a05:600c:6085:b0:456:1b8b:b8ab with SMTP id 5b1f17b1804b1-4561b8bbb3bmr77640895e9.30.1752577214894;
        Tue, 15 Jul 2025 04:00:14 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-456101b616csm86882545e9.4.2025.07.15.04.00.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 04:00:14 -0700 (PDT)
Message-ID: <bfa4949f-8b20-4660-a67e-a06a07fe4e3c@redhat.com>
Date: Tue, 15 Jul 2025 13:00:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] net: renesas: rswitch: add offloading for L2
 switching
To: Michael Dege <michael.dege@renesas.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
 Paul Barker <paul@pbarker.dev>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Nikita Yushchenko <nikita.yoush@cogentembedded.com>
References: <20250710-add_l2_switching-v3-0-c0a328327b43@renesas.com>
 <20250710-add_l2_switching-v3-3-c0a328327b43@renesas.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250710-add_l2_switching-v3-3-c0a328327b43@renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/10/25 2:31 PM, Michael Dege wrote:
> This commit adds hardware offloading for L2 switching on R-Car S4.
> 
> On S4 brdev is limited to one per-device (not per port). Reasoning
> is that hw L2 forwarding support lacks any sort of source port based
> filtering, which makes it unusable to offload more than one bridge
> device. Either you allow hardware to forward destination MAC to a
> port, or you have to send it to CPU. You can't make it forward only
> if src and dst ports are in the same brdev.
> 
> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> Signed-off-by: Michael Dege <michael.dege@renesas.com>

Minor nit: you should specify the target tree in the subj prefix (in
this case 'net-next').

[...]
> +static void rswitch_update_l2_hw_learning(struct rswitch_private *priv)
> +{
> +	bool learning_needed;
> +	struct rswitch_device *rdev;
> +
> +	rswitch_for_all_ports(priv, rdev) {
> +		if (rdev_for_l2_offload(rdev))
> +			learning_needed = rdev->learning_requested;
> +		else
> +			learning_needed = false;
> +
> +		if (!rdev->learning_offloaded && learning_needed) {
> +			rswitch_modify(priv->addr, FWPC0(rdev->port),
> +				       0,
> +				       FWPC0_MACSSA | FWPC0_MACHLA | FWPC0_MACHMA);
> +
> +			rdev->learning_offloaded = true;
> +			netdev_info(rdev->ndev, "starting hw learning\n");
> +		}
> +
> +		if (rdev->learning_offloaded && !learning_needed) {
> +			rswitch_modify(priv->addr, FWPC0(rdev->port),
> +				       FWPC0_MACSSA | FWPC0_MACHLA | FWPC0_MACHMA,
> +				       0);
> +
> +			rdev->learning_offloaded = false;
> +			netdev_info(rdev->ndev, "stopping hw learning\n");

You could factor out the above 3 statements is a separare helper
receving the new 'leraning_offloaded' status and save some code duplication.

> +		}
> +	}
> +}
> +
> +static void rswitch_update_l2_hw_forwarding(struct rswitch_private *priv)
> +{
> +	struct rswitch_device *rdev;
> +	unsigned int fwd_mask;
> +
> +	/* calculate fwd_mask with zeroes in bits corresponding to ports that
> +	 * shall participate in hardware forwarding
> +	 */
> +	fwd_mask = GENMASK(RSWITCH_NUM_AGENTS - 1, 0);
> +
> +	rswitch_for_all_ports(priv, rdev) {
> +		if (rdev_for_l2_offload(rdev) && rdev->forwarding_requested)
> +			fwd_mask &= ~BIT(rdev->port);
> +	}
> +
> +	rswitch_for_all_ports(priv, rdev) {
> +		if (rdev_for_l2_offload(rdev) && rdev->forwarding_requested) {
> +			/* Update allowed offload destinations even for ports
> +			 * with L2 offload enabled earlier.
> +			 *
> +			 * Do not allow L2 forwarding to self for hw port.
> +			 */
> +			iowrite32(FIELD_PREP(FWCP2_LTWFW_MASK, fwd_mask | BIT(rdev->port)),
> +				  priv->addr + FWPC2(rdev->port));
> +
> +			if (!rdev->forwarding_offloaded) {
> +				rswitch_modify(priv->addr, FWPC0(rdev->port),
> +					       0,
> +					       FWPC0_MACDSA);
> +
> +				rdev->forwarding_offloaded = true;
> +				netdev_info(rdev->ndev,
> +					    "starting hw forwarding\n");
> +			}
> +		} else if (rdev->forwarding_offloaded) {
> +			iowrite32(FIELD_PREP(FWCP2_LTWFW_MASK, fwd_mask | BIT(rdev->port)),
> +				  priv->addr + FWPC2(rdev->port));
> +
> +			rswitch_modify(priv->addr, FWPC0(rdev->port),
> +				       FWPC0_MACDSA,
> +				       0);
> +
> +			rdev->forwarding_offloaded = false;
> +			netdev_info(rdev->ndev, "stopping hw forwarding\n");

Similar thing above.

> +		}
> +	}
> +}
> +
> +void rswitch_update_l2_offload(struct rswitch_private *priv)
> +{
> +	rswitch_update_l2_hw_learning(priv);
> +	rswitch_update_l2_hw_forwarding(priv);
> +}
> +
> +static void rswitch_update_offload_brdev(struct rswitch_private *priv,
> +					 bool force_update_l2_offload)

Apparently always called with force_update_l2_offload == false, if so
you should drop such argument...

> +{
> +	struct net_device *offload_brdev = NULL;
> +	struct rswitch_device *rdev, *rdev2;
> +
> +	rswitch_for_all_ports(priv, rdev) {
> +		if (!rdev->brdev)
> +			continue;
> +		rswitch_for_all_ports(priv, rdev2) {
> +			if (rdev2 == rdev)
> +				break;
> +			if (rdev2->brdev == rdev->brdev) {
> +				offload_brdev = rdev->brdev;
> +				break;
> +			}
> +		}
> +		if (offload_brdev)
> +			break;
> +	}
> +
> +	if (offload_brdev == priv->offload_brdev && !force_update_l2_offload)
> +		return;
> +
> +	if (offload_brdev == priv->offload_brdev)

... otherwise (this function can be called with force_update_l2_offload
==  true) we can reach here with priv->offload_brdev and/or
offload_brdev == NULL and the following statement will cause a NULL ptr
dereference.

/P


