Return-Path: <netdev+bounces-93382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F15E8BB715
	for <lists+netdev@lfdr.de>; Sat,  4 May 2024 00:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE764281C69
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 22:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470075B68F;
	Fri,  3 May 2024 22:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RdQFRiGH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230F4290F
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 22:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714775536; cv=none; b=ffhnkPix6mD9IRIb15cHB2TDXUQdW7/H/o8050M9QS+fRLUn1NhZBfRTHf6TNn2vkuhdUlEOKaU54bfNUuWzB4CG5vCmV7F+IwusjuSxlmeljihYI2a57BYvtfIdTjLBKX8lvCRr4oX7ZQ5ONdx91/7Ck4MZ/b+qiMz8TaZZng0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714775536; c=relaxed/simple;
	bh=lE3vKvtUQlV4EkBiZx7UU4ylXKUg4iOGE/M5E8INPUw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tuXG7R771v2Hn941it4NqNlVoWS4nRMK3ZxMI+UGjtzNqP45fNtmp/Fy4hGq+EeVBaid108OAFiF2FOAvUJY0HXAPE9M3wY23QsP4I7HghiX/Th1+19/vHv5r+txTJwjgl4O5Lhoxg08nR54LNKu6cR8blDFNkNaQQ8jTADP7kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RdQFRiGH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A89F1C116B1;
	Fri,  3 May 2024 22:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714775535;
	bh=lE3vKvtUQlV4EkBiZx7UU4ylXKUg4iOGE/M5E8INPUw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RdQFRiGH/RXS4jQcj3FK9BXa2VBCwWL9RwYw+iHD7SPaIOZDrAvDQfrxy05eAbSv+
	 Nx+C/n2Az9WMqFw7OVgiIcTXojSea59E0zh91udm4vRX95+qOe2xZ6AeAbVCKGrxMq
	 A+jQmPrc/P+SQBdKkTaQe8cQTQWirareAZGb2xfAsOiKLmGgLAQZFZgOpKfTMX2nMs
	 9MI4EOiKKVA7LRoASf6TAOgh9GdR/H8RMGyI8sm32b00elmHoHiaNqtUW6wEiOuZ86
	 2jeKFqRqnNmHZOH9uii5bgaM5g5h5KRwj5A74Cs8PkmrpyEGUmdawUqSaD7DnrBG+m
	 gL0zt4dbbnKOw==
Date: Fri, 3 May 2024 15:32:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tom Parkin <tparkin@katalix.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next] l2tp: fix ICMP error handling for UDP-encap
 sockets
Message-ID: <20240503153214.3432d313@kernel.org>
In-Reply-To: <20240430140343.389543-1-tparkin@katalix.com>
References: <20240430140343.389543-1-tparkin@katalix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Apr 2024 15:03:43 +0100 Tom Parkin wrote:
> Subject: [PATCH net-next] l2tp: fix ICMP error handling for UDP-encap sockets

Seems like we should target it at net? Description indicates it's 
a clear regression.

> +static void l2tp_udp_encap_err_recv(struct sock *sk, struct sk_buff *skb, int err,
> +				    __be16 port, u32 info, u8 *payload)
> +{
> +	struct l2tp_tunnel *tunnel = l2tp_sk_to_tunnel(sk);
> +
> +	if (!tunnel || tunnel->fd < 0)
> +		return;

not: the !tunnel can't happen, right?

> +	sk->sk_err = err;
> +	sk_error_report(sk);
> +
> +	if (ip_hdr(skb)->version == IPVERSION) {
> +		if (inet_test_bit(RECVERR, sk))
> +			return ip_icmp_error(sk, skb, err, port, info, payload);
> +	}
> +#if IS_ENABLED(CONFIG_IPV6)
> +	else
> +		if (inet6_test_bit(RECVERR6, sk))
> +			return ipv6_icmp_error(sk, skb, err, port, info, payload);
> +#endif

nit: mismatch on the braces here, this would be more usual:

+	if (ip_hdr(skb)->version == IPVERSION) {
+		if (inet_test_bit(RECVERR, sk))
+			return ip_icmp_error(sk, skb, err, port, info, payload);
+#if IS_ENABLED(CONFIG_IPV6)
+	} else {
+		if (inet6_test_bit(RECVERR6, sk))
+			return ipv6_icmp_error(sk, skb, err, port, info, payload);
+#endif
+	}

+}

