Return-Path: <netdev+bounces-273290-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCw+IiO+ymkb/wUAu9opvQ
	(envelope-from <netdev+bounces-273290-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 20:17:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2431035FA1E
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 20:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B65AD301A003
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 18:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E9E3DE454;
	Mon, 30 Mar 2026 18:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLSRAqpj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42053DDDB7
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 18:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774894562; cv=none; b=qi+rzO/OhVYMITZJt/WpFFyE1GJpYz7SwBMAbGYNSmmprGAGvwVBUfTl3VTRB4qjefv4azuOBGw2x4KS6tQRnpr0s9juSt6ffSvr52R8rL7fOoAWDiavYw+WofFF8hlmwmvZA1TXcX9Sobt2vHh4s0KrfNld9NwzPJVWaxFeHgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774894562; c=relaxed/simple;
	bh=w3laICLdUr/It025yULtMzfgTQBRcrqRCXageJtlNJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NFvgJZVymP8yUewF9+ENa98iUKwv/lQEOs1/1Vo2OJXQDwQuCtDp4KeC53DD4Vqnr2a7HdrAj/V6/+kYWg4HYRBz7+wlysiVEw8Y6hvFc4+nBBZqDIYD2qtdQ0/DoSKzzr3jwUjPAh++AmHSA02ynTbZl3EakHnO+Ik4z1T+n0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LLSRAqpj; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1271195d2a7so1484876c88.0
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 11:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774894561; x=1775499361; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZwQw96URI4tIsjOfhNQCUIMUJe4UuSRPr0npvZsSxqk=;
        b=LLSRAqpjVR5xcYGfPdaqmtpX3KmgWrg/lYgYMUXU+FA3Sqr6lW+3TIWVSICBPideM5
         OW8NhFUAmnlkt96ap+r4RdvufjPJfv35Eeo3GAwDLdGRslgdGzsax0cxAFkBs5fs/g2B
         i6R6f2aqUyOTRF9R84Ac6tNLoG5lEqOyo+Xwdk7HcjUXkUT+PneNDcIMmq96k+TnSGpk
         h57dCzDvaRJq4eO/Byl7C2f6/R+tMF7vH77fufg5HbdwmgAVt2OVzlhO+YpRYDkjGNAq
         QhAr1QIyPlL+j8/PXHMpmNMlGfjHkYrxQiiidOQnEhXTw8dXBvK8UBJWWlAhOxdZoBLw
         h5BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774894561; x=1775499361;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZwQw96URI4tIsjOfhNQCUIMUJe4UuSRPr0npvZsSxqk=;
        b=DXQnCbjciP8DFOJse8dJbJ7DSMqteP3F1X61RxrdemGmge7WacSO4C/JEFzdtvOby5
         tefDhTP1oYn7l1cwyLOMoxREWKb1bS7kWUEWRvBe1y4NCAD/QQU2LuNLRfOIqgMYEBfX
         56C64lHth5BYvlZOeJReE0xsu047Xinl2hQbacX9EbPdFoaImNiSRQOmyhg5zgS04aHl
         iXeVGJsfvvwD6rw1nHjMAdrLMJv9etFdYf/JikyInpKymwnIa5h3ai1XrmIl4FJU7OuC
         crnUXBa6++A4QeQGuPTmbZxzetMmsHLKgrK9ZM7Bt3Q+x0afs3mP4ZYQnS2IUov110LP
         /Lfw==
X-Forwarded-Encrypted: i=1; AJvYcCVDLk+o9nvn0pzfgTH43oSHFEMnaaIBPwFx1KSc/gzmiIn4kqbOrp8pKYvNLplDD08bTHIQy/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhY45B0h+aG8kW3taiLPsKjORTMamfIqGmzjzOt2+qCUmxOSOu
	JkzjklrFMzAZEsXIHICDfoy/uxpMWW1+3KRUY22tVJ8IfFzX109tx6K/
X-Gm-Gg: ATEYQzxttpQWaQLP1dNHd49TB6xr6DBiclswnjkUQEQBj2UWb+sYSdQeLv2EmZzo/vx
	0y00p+3ntPQ9LH2ae3Q24henk8uk7LVXtFuYzAkA+7AIfAccZyM0fQQmbJm0qOP5mm7S+RmwRQn
	2TPjkzmdr3tn/tSLZlioedR1Ye4Zpb0ML6Qmo8nQuhmXGlci8u3oJN3nJ9lqnoi1sTYTMec1Yu5
	iykaKZWCMcp8tfHbiJP8CKBiLCW1LKEZfdQ45ZXc5AdiWmxSjqNGV4phXhG3b0nsGLtrN1hnZWv
	rA0JJIIB7SyqhMQfryLdn442rG7z2mZ79c/qWNA9iHrDBX+eQUNpwuWo6amwvv4VsEiLrZYZkyq
	KXQTk6lDNftD4KXBZVs2dIxpNqPOP12BbR4HABrxhJgikzzPdOa15I+kumaW87Gv0cjHra/sebT
	wpYp+txmZY0LVhidWOSUOAfLkcqi6R9b2DFWydEyUbnMkWwHUfJIygHbZ0jmjWdt2c6dn5idWHh
	A==
X-Received: by 2002:a05:7022:6182:b0:123:2c98:f65d with SMTP id a92af1059eb24-12ab286cd31mr8629558c88.13.1774894560790;
        Mon, 30 Mar 2026 11:16:00 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1151:15:c56:221b:35d5:85f? ([2620:10d:c090:500::1:79e])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ab97efb42sm12090342c88.7.2026.03.30.11.15.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2026 11:16:00 -0700 (PDT)
Message-ID: <c79a7b7e-9e1c-4b3b-8ef0-2d4144dccc25@gmail.com>
Date: Mon, 30 Mar 2026 11:15:59 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 4/6] net: bcmgenet: add XDP_TX support
To: Nicolai Buchwitz <nb@tipi-net.de>, netdev@vger.kernel.org
Cc: Doug Berger <opendmb@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20260319115402.353509-1-nb@tipi-net.de>
 <20260319115402.353509-5-nb@tipi-net.de>
Content-Language: en-US
From: Mohsin Bashir <mohsin.bashr@gmail.com>
In-Reply-To: <20260319115402.353509-5-nb@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273290-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,fomichev.me,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2431035FA1E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> +static bool
> +bcmgenet_xdp_xmit_frame(struct bcmgenet_priv *priv,
> +			struct xdp_frame *xdpf, bool dma_map)
> +{
> +	struct bcmgenet_tx_ring *ring = &priv->tx_rings[DESC_INDEX];
> +	struct device *kdev = &priv->pdev->dev;
> +	struct enet_cb *tx_cb_ptr;
> +	dma_addr_t mapping;
> +	unsigned int dma_len;
> +	u32 len_stat;
> +
> +	spin_lock(&ring->lock);
> +

So we acquire lock on per-packet basis on the XDP_TX path? Do you think 
we can batch this?




