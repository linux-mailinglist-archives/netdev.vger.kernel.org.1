Return-Path: <netdev+bounces-112804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4385C93B4F4
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 18:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C49621F21AFD
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 16:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E909415ECCA;
	Wed, 24 Jul 2024 16:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="uEaY0P7x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF71A15B554
	for <netdev@vger.kernel.org>; Wed, 24 Jul 2024 16:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721838361; cv=none; b=PEHa/dGLo8P60rGHohC9ujwu7dGTZyTKvG8v5gHalZB10KtX2IkVpT8wwwZamWEW0gM4kp2J5rmAn+f9RUcmT0s9rVSHKwpCO0vZTvSjpWs75gt4oe80w996I9LMkcQoSkesdlZEHCF39wMeyhxc+DGAqWu1JJ72eLsoujM7LUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721838361; c=relaxed/simple;
	bh=AOGywo1iikFtBJXxpD5YsZIJ95hrAtPqukdcsVWqRio=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h4hAampvsuRhpzqFClQJxOG0JN6XIpriRqvTCTgMzwKhM+cG1r8cVc1rkxegH2/9jqMdtd8UoOXUHogL7W9Ct/wnzOBl8Q14cKHEyqNcjlQ6MenzSumIUZzGB0v/ei3M49ejw+xOAlHozhrGExts7Mx0VEjtP0S50+XPOHK+hDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=uEaY0P7x; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2cd5d6b2581so1244a91.2
        for <netdev@vger.kernel.org>; Wed, 24 Jul 2024 09:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1721838358; x=1722443158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=47rZGXNA+VPEE0h3H688PSCY3FqtCg4+Z4f3yZO4MI8=;
        b=uEaY0P7xKtxJv/2X5WVnb0r4cJo6uzU5SP2RS1RC5gJDKUjzYnzwcCROyUhdYpemlN
         MHoLdgRA78Ouewg6F09kaWLVllomyAE0lYzHMSM9GfN1JxZFfIKF5/JV/BmxkaUItF9w
         LWReSf5RfH8ZBSedO/xX/23U5SkdypbA3sXd1FPKDjz73Mrc7FMNQFzr33iobtbMOTdy
         tP4w4OWQ2qtq4jex34B4KlkCCXhuSC22pk72qZZaoL4adJoTtAXmsXcZJMuzIInAKx3i
         cwrmldhYINE+XEXfQhqWCLlrc40PD8ZpYAZEbxySh4YgYaOeOjanozPKCI1Hv+x+Uxea
         HD2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721838358; x=1722443158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=47rZGXNA+VPEE0h3H688PSCY3FqtCg4+Z4f3yZO4MI8=;
        b=bb2yjhCw+luUUarOOYBTJgRRcpvMXENhfc021O7YEUcrVFtGMzpvurcixdAdcajvSM
         +vzBhVUywXrLfhApdZDtuD8tJRiW9aJ8DJV+DeM44ZsSSKNswCcJQ3mOm+b9pjonDtTv
         oHhUJxac7ROnyWw/lCyMWXVfQ/9N4JzTwx3IlOElQAyz2mmsvXKzfkNfAEAX3uI+cFHt
         ZKf729TZqeYBW+fI5k3EjNQdNULgbn0Zyv4LLCh+2+t/KlLZprp/povXi2aLKTZ1shIQ
         GaAQqvk0rwXkFSHTt4wU+3yfGbgnwkiTHBupAWAc47Z8JEXS4faaJd0xZMnj/4/ay5Sr
         x9Lg==
X-Forwarded-Encrypted: i=1; AJvYcCU3yKqZLlHOoQIFLFNOOThSqCm0OijrtVvDNs7+t24RqOzVSExORu5wpJgiZD8SzQ7X2f4CfxqkLmwFddievdefVaW2v4u0
X-Gm-Message-State: AOJu0YxSKGA1VM1bQmS7u44BlU0EhMaJLzf474/DKKNuMRy5nBTBxI3P
	hqo/AJ45sB8nh96oJmsDEX1Rlw8SfuTekOF/16XvrEJU+1GlkTXQbr7D6mJ3SEA=
X-Google-Smtp-Source: AGHT+IG37fSFaVfTdXtnEFGMTuetughKI1Zmm7Q9idfHFeWury0GvTkEpAx1HaZz6lMROu30tv4oTg==
X-Received: by 2002:a17:90b:388d:b0:2c9:7616:dec7 with SMTP id 98e67ed59e1d1-2cf23770687mr13999a91.6.1721838357984;
        Wed, 24 Jul 2024 09:25:57 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cdb746f9a0sm1858462a91.38.2024.07.24.09.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 09:25:57 -0700 (PDT)
Date: Wed, 24 Jul 2024 09:25:55 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: <jiang.kun2@zte.com.cn>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <corbet@lwn.net>, <dsahern@kernel.org>,
 <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <fan.yu9@zte.com.cn>,
 <xu.xin16@zte.com.cn>, <zhang.yunkai@zte.com.cn>, <tu.qiang35@zte.com.cn>,
 <he.peilin@zte.com.cn>, <yang.yang29@zte.com.cn>
Subject: Re: [PATCH] net: Provide sysctl to tune local port range to IANA  
 specification
Message-ID: <20240724092555.3ecc2538@hermes.local>
In-Reply-To: <202407241403542217WOxM8U3ABv-nWZT068xe@zte.com.cn>
References: <202407241403542217WOxM8U3ABv-nWZT068xe@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Jul 2024 14:03:54 +0800 (CST)
<jiang.kun2@zte.com.cn> wrote:

> From: Fan Yu <fan.yu9@zte.com.cn>
> 
> The Importance of Following IANA Standards
> ========================================
> IANA specifies User ports as 1024-49151, and it just so happens
> that my application uses port 33060 (reserved for MySQL Database Extended),
> which conflicts with the Linux default dynamic port range (32768-60999)[1].
> 
> In fact, IANA assigns numbers in port range from 32768 to 49151,
> which is uniformly accepted by the industry. To do this,
> it is necessary for the kernel to follow the IANA specification.
> 
> Drawbacks of existing implementations
> ========================================
> In past discussions, follow the IANA specification by modifying the
> system defaults has been discouraged, which would greatly affect
> existing users[2].
> 
> Theoretically, this can be done by tuning net.ipv4.local_port_range,
> but there are inconveniences such as:
> (1) For cloud-native scenarios, each container is expected to follow
> the IANA specification uniformly, so it is necessary to do sysctl
> configuration in each container individually, which increases the user's
> resource management costs.
> (2) For new applications, since sysctl(net.ipv4.local_port_range) is
> isolated across namespaces, the container cannot inherit the host's value,
> so after startup, it remains at the kernel default value of 32768-60999,
> which reduces the ease of use of the system.
> 
> Solution
> ========================================
> In order to maintain compatibility, we provide a sysctl interface in
> host namespace, which makes it easy to tune local port range to
> IANA specification.
> 
> When ip_local_port_range_use_iana=1, the local port range of all network
> namespaces is tuned to IANA specification (49152-60999), and IANA
> specification is also used for newly created network namespaces. Therefore,
> each container does not need to do sysctl settings separately, which
> improves the convenience of configuration.
> When ip_local_port_range_use_iana=0, the local port range of all network
> namespaces are tuned to the original kernel defaults (32768-60999).
> For example:
> 	# cat /proc/sys/net/ipv4/ip_local_port_range 
> 	32768   60999
> 	# echo 1 > /proc/sys/net/ipv4/ip_local_port_range_use_iana
> 	# cat /proc/sys/net/ipv4/ip_local_port_range 
> 	49152   60999
> 
> 	# unshare -n
> 	# cat /proc/sys/net/ipv4/ip_local_port_range 
> 	49152   60999
> 
> Notes
> ========================================
> The lower value(49152), consistent with IANA dynamic port lower limit.
> The upper limit value(60999), which differs from the IANA dynamic upper
> limit due to the fact that Linux will use 61000-65535 as masquarading/NAT,
> but this does not conflict with the IANA specification[3].
> 
> Note that following the above specification reduces the number of ephemeral
> ports by half, increasing the risk of port exhaustion[2].
> 
> [1]:https://www.iana.org/assignments/service-names-port-numbers/service-names-port-numbers.txt
> [2]:https://lore.kernel.org/all/bf42f6fd-cd06-02d6-d7b6-233a0602c437@gmail.com/
> [3]:https://lore.kernel.org/all/20070512210830.514c7709@the-village.bc.nu/
> 
> Co-developed-by: Kun Jiang <jiang.kun2@zte.com.cn>
> Signed-off-by: Fan Yu <fan.yu9@zte.com.cn>
> Signed-off-by: Kun Jiang <jiang.kun2@zte.com.cn>
> Reviewed-by: xu xin <xu.xin16@zte.com.cn>
> Reviewed-by: Yunkai Zhang <zhang.yunkai@zte.com.cn>
> Reviewed-by: Qiang Tu <tu.qiang35@zte.com.cn>
> Reviewed-by: Peilin He<he.peilin@zte.com.cn>
> Cc: Yang Yang <yang.yang29@zte.com.cn>
> ---

Yet another NAK

Rather than buggy and verbose new sysctl, why not just allow setting
the port range you want through existing sysctls?

You can configure this through existing sysctl files and startup in your distro.

