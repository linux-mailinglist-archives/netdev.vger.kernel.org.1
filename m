Return-Path: <netdev+bounces-248050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C63D02819
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 12:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 41AEE300DDBE
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 11:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337613A7837;
	Thu,  8 Jan 2026 11:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cSWFWXmH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dTXMHFJU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3AD3A641F
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 11:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767871748; cv=none; b=Mm7oOkVcOEnUQqEkb5fhQhPk0Cm2+kHuna4EUJ0LqejkXHbOWz8u1MBoH0oz9GFFjQ/sBYrfwRhezUsXh6QidsqhztLc/D/Q6k6YKSmSegXJTiwfAYk/l3eYJW5PgsGqydHayHbCb0sIzO2ur+ST1txOpQ3LgMlcHsaybmQ5LqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767871748; c=relaxed/simple;
	bh=dJYi/b8U+Ys1LYlY9+h/mleeGks1F1L2iNDhWnfN3uM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lCl6e7+OQ1ejs6irtereEABtKA8b0eLe95UPxPLV+QFgaLf1wK6Alc3EebJEc1bJvgXKBzLV9lFElZlAG7KL/dLwrkbNBis/tJ5MUDzdZLMZviH9LsbCefIkSjSokBiB8dEEbL1r307hnWUVMyRbQQ9vDOJLy9TWyUBnwXVsTJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cSWFWXmH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dTXMHFJU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767871744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D+a8/HgrrA9LGdGkGtxw3sexeM0b0Vs24vRvPS8jCcE=;
	b=cSWFWXmHychaMJiFdeP3nBpv77HeZyCP/hQ6XFqwSO+3QXJE3RoBeFfvn9W+FKE7PhPSw5
	gHz/5hcifxU8O4QqXbX2GIADz9QRvwzed9QqtWl8LjOTNlJ1rkcfkuiwrKulgySIbdON8p
	Tql+aONYDC7lRe7I0CHoyE0JyXlNuyk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-Jxpib0VpOLaUNfA_8O_Rrw-1; Thu, 08 Jan 2026 06:29:03 -0500
X-MC-Unique: Jxpib0VpOLaUNfA_8O_Rrw-1
X-Mimecast-MFC-AGG-ID: Jxpib0VpOLaUNfA_8O_Rrw_1767871742
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-477c49f273fso31397835e9.3
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 03:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767871742; x=1768476542; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D+a8/HgrrA9LGdGkGtxw3sexeM0b0Vs24vRvPS8jCcE=;
        b=dTXMHFJUqGb3Kc7ICyKyxoM5yhIEY9WZCtate5SghyqD1JIatYaYfaVykcjYk+qo3U
         I5NmqXTC9x4/03aTJxd/yacrXnw/iaXVlO2G4gzh7nUSirbxArOl4gzpEZA01Z5g2cm7
         /XNEhx6Tce20gAAIfCIKepUVylv1xk/HgOPofe4syGgETxnGmAfrzh/YAGacQt7rmI7R
         Oqxnx3NHs83GNOciKRfGlhHYAYWcA52dmXRJg3eC2VBFHIc/hogrVlXyR/3XtjtZElgS
         PzjXBdpSFr24Xqrz3oWp8LI3HVWL/4PiMPwNs1mkd8uhH76ktMx/pO2LDtHc+ge5KUXQ
         Bc/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767871742; x=1768476542;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D+a8/HgrrA9LGdGkGtxw3sexeM0b0Vs24vRvPS8jCcE=;
        b=WWocmO/FJl6rXa76gVbf+c6ymCTBr3MTAnLK0CwSY29q/P1uIk9WW/SJ7gBFa01gk8
         1db4D2SCTtGwXiUrh59FF+yodJ6XT9NL+zyFe1iTF9OiD747DKYrZb2PNsZIMeqZRuxv
         zWa+bKN4jbPEzx4SiJNEDWlNQGYZXXMnNp0HsiCzBOR3vynNRI9w3F88DKb/E+9Kt601
         qafzRn+RtQ5l8dYHDG6ht2xE9FgXhWNL9/DHn4OXCnySCcqOHK0273M3O1UZSiZR16Rh
         W0vk4xFC8KbyY2Utq1+5gY7elgGNOSEvl0em5NiwBocWdWZELDlqqzBVZzyFuDdkU1u2
         Hkdw==
X-Forwarded-Encrypted: i=1; AJvYcCXrW/nDe3v7QDJP6GnqQqKXda73x2rcKdehz6LLEAAcyvcdUWW7hWuA5+Ih7ysfYW8VfhszRtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQzhjpGqAGVY+XudsK1EULySoW3c5vzCle5bwHNv7uHyvG7lHX
	vdEUCvtlS5J9x4AF+J1h0+iXMbnavkLqoArg8eQ6rQWbTaLojkzsEs99v6sx3f6dt5Dvf2pbUcb
	b6OfN1tJqReE9jZUTdqneJSP9dnrJ/0/axivJ0smWOSslCufZfumi+fSj0w==
X-Gm-Gg: AY/fxX6IN/CqvXtWZXCF6Kb0ZEauaAd+vcNaonrTd96UFkPeH/EFW1l3Y5i6fZADk3A
	5Yo7ioSYmB8/PTmuP0P9pk51/Ubp8zYTsd2U3yWDD6cXpc0/w2C5Tw9b6lekYCJFcAE2hEq5Mji
	e78PkYaX+2RndMnBDCSyxa92ZtzVwAQ0CC2HlOWu6w9aFNA8rUmBiMU5smNWi1U+5BVS34cv2Gx
	kvCpwBc/fV152a9jDVOIfPZx5ChVxKEAGzWWri5R9iQB/QT1rDXZ3/qpVKqLagetGe2lagXj+XP
	DnNpL5NlX3jF6JZuTJqecEtal9DCBm+HYV6vkZjGIPuuC/K6hHILgJV15O2TRnYUFQFAD3otSn3
	vt0oEeSRezUtKLA==
X-Received: by 2002:a05:600c:8119:b0:477:b0b9:3129 with SMTP id 5b1f17b1804b1-47d84b0a8dfmr65473505e9.3.1767871742162;
        Thu, 08 Jan 2026 03:29:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEgaAftp+naANwBwxcdTWbs47iqT+WgXibibJoopIEFumDXskHupti0hYSDGlBzsi6bm2o4vA==
X-Received: by 2002:a05:600c:8119:b0:477:b0b9:3129 with SMTP id 5b1f17b1804b1-47d84b0a8dfmr65473285e9.3.1767871741741;
        Thu, 08 Jan 2026 03:29:01 -0800 (PST)
Received: from [192.168.88.32] ([212.105.149.145])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d8662c09bsm38373035e9.2.2026.01.08.03.28.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 03:29:01 -0800 (PST)
Message-ID: <a1341a4b-3ad0-43dd-adff-66d7d90be471@redhat.com>
Date: Thu, 8 Jan 2026 12:28:59 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 3/3] net: ti: icssm-prueth: Add support for
 ICSSM RSTP switch
To: Parvathi Pudi <parvathi@couthit.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 danishanwar@ti.com, rogerq@kernel.org, pmohan@couthit.com,
 basharath@couthit.com, afd@ti.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, alok.a.tiwari@oracle.com,
 horms@kernel.org, pratheesh@ti.com, j-rameshbabu@ti.com, vigneshr@ti.com,
 praneeth@ti.com, srk@ti.com, rogerq@ti.com, krishna@couthit.com,
 mohan@couthit.com
References: <20260105122549.1808390-1-parvathi@couthit.com>
 <20260105122549.1808390-4-parvathi@couthit.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260105122549.1808390-4-parvathi@couthit.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/5/26 1:23 PM, Parvathi Pudi wrote:
> +static int icssm_prueth_ndev_port_link(struct net_device *ndev,
> +				       struct net_device *br_ndev)
> +{
> +	struct prueth_emac *emac = netdev_priv(ndev);
> +	struct prueth *prueth = emac->prueth;
> +	unsigned long flags;
> +	int ret = 0;
> +
> +	dev_dbg(prueth->dev, "%s: br_mbrs=0x%x %s\n",
> +		__func__, prueth->br_members, ndev->name);
> +
> +	spin_lock_irqsave(&emac->addr_lock, flags);
> +
> +	if (!prueth->br_members) {
> +		prueth->hw_bridge_dev = br_ndev;
> +	} else {
> +		/* This is adding the port to a second bridge,
> +		 * this is unsupported
> +		 */
> +		if (prueth->hw_bridge_dev != br_ndev) {
> +			spin_unlock_irqrestore(&emac->addr_lock, flags);
> +			return -EOPNOTSUPP;
> +		}
> +	}
> +
> +	prueth->br_members |= BIT(emac->port_id);
> +
> +	ret = icssm_prueth_port_offload_fwd_mark_update(prueth);

More AI generated feedback here that still looks valid to me:

"""
ndo_stop() can sleep (e.g., via rproc_shutdown()). This function appears
to be called while holding a spinlock via the call chain:

  icssm_prueth_ndev_port_link()
    -> spin_lock_irqsave(&emac->addr_lock)
      -> icssm_prueth_port_offload_fwd_mark_update()
        -> icssm_prueth_change_mode()
          -> ndo_stop() / ndo_open()

Is this intentional? The ndo_open() path also calls
icssm_prueth_sw_init_fdb_table() which does kmalloc(GFP_KERNEL) and
rproc_boot(), both of which may sleep.
"""

There are other similar cases; for the full report see:

https://netdev-ai.bots.linux.dev/ai-review.html?id=ce23f731-f25b-4082-a5d0-c1261ab829ed

/P


