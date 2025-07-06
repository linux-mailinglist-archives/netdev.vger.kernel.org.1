Return-Path: <netdev+bounces-204428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8D7AFA637
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 17:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05C28178876
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 15:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F4C20B800;
	Sun,  6 Jul 2025 15:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="juDEntV1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E41F254878
	for <netdev@vger.kernel.org>; Sun,  6 Jul 2025 15:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751816435; cv=none; b=kKBLSt5WXdNd2wH0VxJWGnU2wWaQ2RxWjgJBglp6mOMEuEhjokpUDwOSqKpE3fkyq7nHSp88SI7tWItsM/9sQCAVbcqmq8Yp1GgqYBzEu849yqYcy27vJ3Y2iDl3sPtj3hMm+8viAnDNRQZG9cdRIbQHfZOU2ZiAIFcS7YS11Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751816435; c=relaxed/simple;
	bh=O/514BxAK/cylaA4ixlR2fqwEHzUpM2XqY37CsXHJtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WFMZQtqiXhyZODo/R53R+9MwpCAba73m3T0/65W9Oxa7O8JD0Q5Dh731VFeoDcSy9tMj8W1XTfSv+De6cqDPIK00Aspr8Oa7DvVhzREioGlLAP+JQy6py4PhXatKnyJ+nYwq8sJS9sN/cpMldSBhAoyZik/heJVvubkhVmGNugA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=juDEntV1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F257C4CEED;
	Sun,  6 Jul 2025 15:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751816435;
	bh=O/514BxAK/cylaA4ixlR2fqwEHzUpM2XqY37CsXHJtk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=juDEntV1RkE8OLArbpQWOdgggPFuMXIOGFUHjzqrl/4QYVpMv7Q3VCDDDgeh+K2Yf
	 0+4iqlCneW6h1dQ+E8AC8dcJNS3vsvQFqOUfZ92t2O9JAK8CI/1qj/HLKhosBWcE3c
	 fHgoihb8u8a3xePEnruZZCehyBLmx2UxBHaCFpFDC0y50EMy0ay0X6q2NULVKS+hWi
	 I2gW2QuMGAf7b29j81JBV5R5zluH5Z3jDxgu4fcdckLEFRYi/rwmDA+RqcLeWLUkeJ
	 InN2XUWrVxuKJd3Geff741Y3/CLB5km54iQmfZSaicGOVDVZYslP8Yc///En1TF1kw
	 9K8aWvuWFZ9UA==
From: Gary Guo <gary@kernel.org>
To: gnault@redhat.com
Cc: davem@davemloft.net,
	idosch@idosch.org,
	kuba@kernel.org,
	ling@moedove.com,
	netdev@vger.kernel.org,
	noc@moedove.com,
	pabeni@redhat.com,
	Gary Guo <gary@garyguo.net>
Subject: Re: [BUG] net: gre: IPv6 link-local multicast is silently dropped (Regression)
Date: Sun,  6 Jul 2025 16:40:30 +0100
Message-ID: <20250706154030.3010068-1-gary@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <aGUGBjVZZPBWcRlA@debian>
References: <aGUGBjVZZPBWcRlA@debian>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 2 Jul 2025 12:12:22 +0200, Guillaume Nault wrote:
> Aiden, can you confirm that the following patch fixes the issue on your
> side?

Not Aiden, but I get hit with the same regression after updating kernel on my
router from v6.12.28 to v6.12.35 today. Symptom for me is bird complaining
about "Socket error: Network is unreachable", and strace shows that it's sending
packets to ff02::1:6 and get hit with ENETUNREACH.

I can confirm that applying this patch on top of v6.12.35 fixes the issue for me.
I also took a look of the code, not a net expert, but this approach does look
like a proper fix to me.

Reviewed-by: Gary Guo <gary@garyguo.net>
Tested-by: Gary Guo <gary@garyguo.net>

> 
> ---- >8 ----
> 
> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index ba2ec7c870cc..870a0bd6c2ba 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
> @@ -3525,11 +3525,9 @@ static void addrconf_gre_config(struct net_device *dev)
>  
>  	ASSERT_RTNL();
>  
> -	idev = ipv6_find_idev(dev);
> -	if (IS_ERR(idev)) {
> -		pr_debug("%s: add_dev failed\n", __func__);
> +	idev = addrconf_add_dev(dev);
> +	if (IS_ERR(idev))
>  		return;
> -	}
>  
>  	/* Generate the IPv6 link-local address using addrconf_addr_gen(),
>  	 * unless we have an IPv4 GRE device not bound to an IP address and
> @@ -3543,9 +3541,6 @@ static void addrconf_gre_config(struct net_device *dev)
>  	}
>  
>  	add_v4_addrs(idev);
> -
> -	if (dev->flags & IFF_POINTOPOINT)
> -		addrconf_add_mroute(dev);
>  }
>  #endif

