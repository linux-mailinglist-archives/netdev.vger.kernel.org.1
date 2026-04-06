Return-Path: <netdev+bounces-275699-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDMjHCX802k8owcAu9opvQ
	(envelope-from <netdev+bounces-275699-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 20:32:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E2C3A6437
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 20:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E68E302AD3F
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 18:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A25539151E;
	Mon,  6 Apr 2026 18:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwPbgu0a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB373033CB
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 18:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775500207; cv=none; b=WGnCj7uTdxrXvSxZK3yN9SntUXFlc+IgaeRToOXxdMnH4FA8KzS0bgyFNgMfLzuF8oZyKIKLPLi5fxDCY1mCDo4CDZh9b4nMIvptdi316ecREe1PFH1kzSmf1bpg9CBoicQrpFCclYfkZ5FePymIuCTlwpnZagUqYxNZntfjqUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775500207; c=relaxed/simple;
	bh=R7qHEZ/9Bq21Rdmb/TF54ONdmEnRuMmMnmx9ViDFNmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RLdAqbdO6Z5EZiehKcGGmXXPt60Xr84gSvW50PLKt15wtfSz8Q1ZfkacspHgbJPzSh5ySTEiE0ONCcLj7nLdyvi1spiwgBUm3Gi1ZIdd1omvcbg2g8rLN3cWVHHg8+EknenJz9yTfGejllg52Wgnuuct1OjUsPgFsfC7yY81QBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kwPbgu0a; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12732e6a123so1410736c88.1
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 11:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775500206; x=1776105006; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z00Q2KW1Ko1Gia8kQnTxVHl+69B80uqs2zLH3vLC4e0=;
        b=kwPbgu0axSzEOWdkjeYz/xwaKbnAaFL9yE9GDcxW++InAyflGzKgbGuykG6H3BP7mZ
         LJJjLAwYKfRTQG3fS/dCZzJYMFYELmj3/z0EVQYQOizpw3DlaQWTJWTLk7C3OuSNXOXl
         UsR1P5LnqNknhR/es1LREwOy/WOfcQPaSsqhVYOhjT5YjWE4HMB0MthrsZlBhfT/6iYA
         y8Z5z5nMCKKXSbksg5RGWpIFk+h+u4PEqJSRJEFEZWbPU/C4zvJ1zHNXHx6f11kIvffc
         vQSkAR9e/uldnNTtjuyNkej79qGQk+ufJsBiuooWJO7g2WamlU1l0H7Nwz/fuhahW9e1
         A96A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775500206; x=1776105006;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z00Q2KW1Ko1Gia8kQnTxVHl+69B80uqs2zLH3vLC4e0=;
        b=Ia48e/Cks2xTTizJV5DcpR/+t8pXuAcdluPWnPDwNdBYr7OZSWyya3fzDkINV7Da5G
         zaIQpHyrRETzi5nXtueT9pBEyVTNVZ/fMW9+dXoomi20NGNOQF2eb+rbQnan+jOM5jG/
         AA6pFLa8HhNn1gQJrKxDQAl0CuKCCk4O3BGEJEGvRxfRiadTCl1wvPbrbSq7lM4ADuY5
         qi1u/rKi0luVm3swJjmLSkiarPM5/zppIl43nJSy076eVzNQALp9an3s9SoLkLp7v8XA
         Os39QelgQfOSmMgZYJu0QcAvNoMTQvW3F3YBZ0ZwP55lo+AgCe+cW3eilMyCkfNGcqjF
         r86w==
X-Forwarded-Encrypted: i=1; AJvYcCUYpgORC7GT10z1N7VJx8ClALs51R0EeccgZpJwBIi/+F7hUIA2U2k+QgzQ++SjYuubPV43SV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVzy6FE+YhJFijIxjHFxBn/jz3MZXXSECvHRZK2sifX0R+Ms7A
	uDY6XEDj1gIB3HhZeFb4GCW1YX8vPbEdY8uZNGhddxfC3RnXqDrdJk3j
X-Gm-Gg: AeBDiesWiaBYoinVLtUL92zmawd/+yraLRAq0OpRx7LBJeMa8YNq9BlK+dfSqHQ1N/8
	3iNjQ5lpGXJaziJTaoFG/BCt9SG5JKr65nIiM4QCDafkTrCrVUx6QpZSskws74ve7BqV6YP+4/M
	+EQ6iP9etFnvAHnEYdZBPQqBoLLB6nZ68z4g5SjNu7zsn3/2pWkcM8cOZc/eZjaEIGN5K/pV4mR
	tEVW8/NO1ElDmehw6wjXSUJDGfAk9s8tHrczit2kFjo30BXEjvOufnzHmktIkbDlL3D/ONNXhtb
	tRc7YJPzS3/HKD6CWVd36zu/N/9F5kA8NuaMJ9CA6Bcvsij0FObEyBcD/sJPx5A3kQY1rnO1lP5
	esMTgIg1oFxlEkx98+pZhV+k71L/zTRwY/guhKA2R2ecuDFdNuQlGeg8WfJJ7iPdWoxugNLu/2i
	tRHl83DF+IMdcfVZeIvm2mGswhY7CEIZZrz7N/g3K1klv5XZ6EfpFzY8AFa2+krunWvDcplSz3
X-Received: by 2002:a05:7300:2153:b0:2c7:287:6740 with SMTP id 5a478bee46e88-2cbfc45b1cemr6829669eec.28.1775500205581;
        Mon, 06 Apr 2026 11:30:05 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1151:15:c56:221b:35d5:85f? ([2620:10d:c090:500::5ae7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca7c20b195sm13283913eec.16.2026.04.06.11.30.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2026 11:30:05 -0700 (PDT)
Message-ID: <6796586f-18ce-49d1-99d9-c3c5df72bcf3@gmail.com>
Date: Mon, 6 Apr 2026 11:30:02 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 7/7] net: bcmgenet: reject MTU changes
 incompatible with XDP
To: Nicolai Buchwitz <nb@tipi-net.de>, netdev@vger.kernel.org
Cc: Justin Chen <justin.chen@broadcom.com>, Simon Horman <horms@kernel.org>,
 Doug Berger <opendmb@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20260406083536.839517-1-nb@tipi-net.de>
 <20260406083536.839517-8-nb@tipi-net.de>
Content-Language: en-US
From: Mohsin Bashir <mohsin.bashr@gmail.com>
In-Reply-To: <20260406083536.839517-8-nb@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275699-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[broadcom.com,kernel.org,gmail.com,lunn.ch,google.com,redhat.com,davemloft.net,iogearbox.net,fomichev.me,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mohsinbashr@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:email]
X-Rspamd-Queue-Id: E0E2C3A6437
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

>   
> +static int bcmgenet_change_mtu(struct net_device *dev, int new_mtu)
> +{
> +	struct bcmgenet_priv *priv = netdev_priv(dev);
> +
> +	if (priv->xdp_prog && new_mtu > PAGE_SIZE - GENET_RX_HEADROOM -
> +	    SKB_DATA_ALIGN(sizeof(struct skb_shared_info))) {
> +		netdev_warn(dev, "MTU too large for single-page XDP buffer\n");
> +		return -EINVAL;
> +	}
> +
> +	WRITE_ONCE(dev->mtu, new_mtu);
> +	return 0;
> +}
> +
>   static const struct net_device_ops bcmgenet_netdev_ops = {
>   	.ndo_open		= bcmgenet_open,
>   	.ndo_stop		= bcmgenet_close,
> @@ -4102,6 +4116,7 @@ static const struct net_device_ops bcmgenet_netdev_ops = {
>   	.ndo_eth_ioctl		= phy_do_ioctl_running,
>   	.ndo_set_features	= bcmgenet_set_features,
>   	.ndo_get_stats64	= bcmgenet_get_stats64,
> +	.ndo_change_mtu		= bcmgenet_change_mtu,
>   	.ndo_change_carrier	= bcmgenet_change_carrier,
>   	.ndo_bpf		= bcmgenet_xdp,
>   	.ndo_xdp_xmit		= bcmgenet_xdp_xmit,

Reviewed-by: Mohsin Bashir <hmohsin@meta.com>

