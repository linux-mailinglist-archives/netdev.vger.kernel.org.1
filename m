Return-Path: <netdev+bounces-236872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 515A7C410D1
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 18:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10D203A4716
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 17:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F27334683;
	Fri,  7 Nov 2025 17:33:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from eidolon.nox.tf (eidolon.nox.tf [185.142.180.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DCB24DFF3
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 17:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762536816; cv=none; b=qDr4t8E884LYZ7879EaK03+mfWt1uUlHZkl6KsZgWvJFhdue1CGeuXNXBj9H+wvq9QZof5GTMOjjWhAGylH3JPDVs8UBgyvrWlKI9GjH6dPWu5CzJaYUJ4lFRfEiokhUApt4tQ9oZdkRxVhk1w8cviArFedSxxfbNc5c5UHVi6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762536816; c=relaxed/simple;
	bh=pVsTGEt3BLsaovZA47CerrPJ8u4bEnWkY7XJRrA6SzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ordb32Y3OZdQw5JoO9+UvN3Cnzd+2/zFnaJkOCHlUsGDpErE7zOL7c7JNLQHw74KZngdjiHcazCFV3+Hb42cWo9GPD+BcVa7cQhZIqOZqOeIFNd9tAQADFw5egv5IlxzwWsByiX4TQ/Xnp8aPJjfuqzEAYMFoRXFqBkqVX9agBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=diac24.net; spf=pass smtp.mailfrom=diac24.net; arc=none smtp.client-ip=185.142.180.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=diac24.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=diac24.net
Received: from equinox by eidolon.nox.tf with local (Exim 4.98.2)
	(envelope-from <equinox@diac24.net>)
	id 1vHQL4-00000003FjR-2Rx4;
	Fri, 07 Nov 2025 18:33:30 +0100
Date: Fri, 7 Nov 2025 18:33:30 +0100
From: David 'equinox' Lamparter <equinox@diac24.net>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, horms@kernel.org,
	dsahern@kernel.org, petrm@nvidia.com, willemb@google.com,
	daniel@iogearbox.net, fw@strlen.de, ishaangandhi@gmail.com,
	rbonica@juniper.net, tom@herbertland.com
Subject: Re: [PATCH net-next v2 1/3] ipv4: icmp: Add RFC 5837 support
Message-ID: <aQ4tamfiDiC1TomU@eidolon.nox.tf>
References: <20251027082232.232571-1-idosch@nvidia.com>
 <20251027082232.232571-2-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027082232.232571-2-idosch@nvidia.com>

On Mon, Oct 27, 2025 at 10:22:30AM +0200, Ido Schimmel wrote:
> +/* ICMP Extension Object Classes */
> +#define ICMP_EXT_OBJ_CLASS_IIO		2	/* RFC 5837 */
> +
> +/* Interface Information Object - RFC 5837 */
> +enum {
> +	ICMP_EXT_CTYPE_IIO_ROLE_IIF,
> +};

...

> +static __be32 icmp_ext_iio_addr4_find(const struct net_device *dev)
> +{
> +	struct in_device *in_dev;
> +	struct in_ifaddr *ifa;
> +
> +	in_dev = __in_dev_get_rcu(dev);
> +	if (!in_dev)
> +		return 0;
> +
> +	/* It is unclear from RFC 5837 which IP address should be chosen, but
> +	 * it makes sense to choose a global unicast address.
> +	 */
> +	in_dev_for_each_ifa_rcu(ifa, in_dev) {
> +		if (READ_ONCE(ifa->ifa_flags) & IFA_F_SECONDARY)
> +			continue;
> +		if (ifa->ifa_scope != RT_SCOPE_UNIVERSE ||
> +		    ipv4_is_multicast(ifa->ifa_address))
> +			continue;
> +		return ifa->ifa_address;

For 5837, this should be an address identifying the interface.  This
sets up a rather tricky situation if there's a /32 configured on the
interface in the context of unnumbered operation.  Arguably, in that
case class 5 (node info) should be used rather than class 2 (interface
info).  Class 5 also allows sticking an IPv6 address in an ICMPv4 reply.

I would argue the logic here should be an order of preference:

1. any global non-/32 address on the interface, in a class 2 object
2. any global /32 on the interface, in a class 5 object
3. any global IPv6 on the interface, in a class 5 object
4. any global address from any interface in the VRF, preferring
   loopback, in a class 5 object (addrsel logic, really)

[class 5 is draft-ietf-intarea-extended-icmp-nodeid]

+ analog for IPv6

(cf. my other mail in the thread)

Cheers,


-equi

