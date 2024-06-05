Return-Path: <netdev+bounces-100815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5E38FC1DC
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 04:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E87D1C21C3E
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 02:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1442BD0D;
	Wed,  5 Jun 2024 02:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZOdfwik"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79E261FC9
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 02:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717554788; cv=none; b=eqTE7f17vnT+P9WhPDzoWA+l8AloO+YOOq0QYnhuZqTebZrHGTUI2q//zo/acpZ4Bz68Y+4vMoHACrDdmURXMVZjk9Ybgsx2YdItexXMxc0WOpnZuzzYuMwXFKYilG6NG0ObT+digAHQ5AwfkMjxMxAVVd439A+4NDXVGQQlu8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717554788; c=relaxed/simple;
	bh=9s/9LJsK4hT5nr29jLoJ3tVdsG56EvsiyfmIF8VgVsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AuEx41ZI8DJcozZFwq0Zwpk/7BwUwUf0CFA8KrikRKeT2/E1sf0LDIPhM2r7r58XXT0VfRWq8EbIFaOZnA9jMJPqquKS0Mj+tT/PDLxeKal63JgrtZZEk7YVyyyug4hCH+Eig8VRhZRaONLzYLWxPRV0jjBnraYmsa7dY/13y2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MZOdfwik; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-24c9f892aeaso3527870fac.2
        for <netdev@vger.kernel.org>; Tue, 04 Jun 2024 19:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717554786; x=1718159586; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8YUUmOfrL2jxB4pmXxgge8J7Nh2PUi/26FejX3kUiHQ=;
        b=MZOdfwikxvLV98/U2JmmvllXWjY1DXpdHUBWgy7Tr6HPWHo3WNxd2mrTs6gsyk9nCd
         sgxMq+tzeCzIzer6H1SoLyQs0vtwL3LlxAFlVxIAs/PR86ozff9FjydJ6X9ESYhdXhIB
         mBZweBaSaOqY5PficHZKt9FTQx3ehTZr4Gnb2H/ssVTNA8AYyZmIHWMk9IP2JtoPSpnm
         +MmnY0S7VqlhI9Y+tmFqjiEu7acmND0+Kl4z/XRDj1y/ma2Ga6l5Tax4Ifa8KwYxzqeQ
         S7CxMuQfrp9rQxhVeApICc7U0053XhB4tZRqTp3fwe5CEZZYFwD0doLU91TN0WS8ABam
         NKvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717554786; x=1718159586;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8YUUmOfrL2jxB4pmXxgge8J7Nh2PUi/26FejX3kUiHQ=;
        b=W5yN5juGPSEQQeHkNZD1fs0wW1RyyBlgJdXyY2Ogtc0JoKHdefwyzjhXu33jCZ1Tcv
         NU5gJuhBfA4l1eVCBV1Qzx6tixmy389+7J3VuR/xmFGOKjijeTGo8vOYM+CnD9wiNSrh
         wqvSLkxNsfd6N/irLYln2qUG9NPW89n8FDk88OJD20vnpTzOxqrD60XSnCdtMWCr3Vkm
         IK3foUYqKb9xPh0oilen8ydY2gojQTCZghE8XZtfcuzdaJmVznVSai7MfLtMXpbNe4gn
         iPygcEZ79Jmow1bHnxS3qBIzap/9f7UgOxTLW4qDlS2IiAvjGhu49/6RGphkFDSHQQ8s
         zO7A==
X-Gm-Message-State: AOJu0Ywwg2x/iQALGXp3LwRujVUiZiwJFvDI3WpmGBUvzWVy96VBE0g3
	QhKykIpQJjSi96pJJ3zsnn3IOpfRsloSKKDTQmaH3JKWUhn5Bhw6
X-Google-Smtp-Source: AGHT+IEX9kZsAOHjrWXYU/8t4c55C0xEKSCaphUkcNEP2lFvx3vfP19IQ9MYOxLXtayJpqsdbm+y+A==
X-Received: by 2002:a05:6870:b24e:b0:24f:e5c9:a5ec with SMTP id 586e51a60fabf-25121c81680mr1664843fac.10.1717554785674;
        Tue, 04 Jun 2024 19:33:05 -0700 (PDT)
Received: from Laptop-X1 ([2409:8a02:782b:80e0:aaca:87fa:f402:cc0f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-702423da7b9sm8014108b3a.58.2024.06.04.19.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 19:33:05 -0700 (PDT)
Date: Wed, 5 Jun 2024 10:32:57 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: wujianguo <wujianguo@chinatelecom.cn>
Cc: netdev@vger.kernel.org, kuba@kernel.org, edumazet@google.com,
	contact@proelbtn.com, pablo@netfilter.org, dsahern@kernel.org,
	pabeni@redhat.com, wujianguo106@163.com
Subject: Re: [PATCH net v2 2/3] selftests: add selftest for the SRv6 End.DX4
 behavior with netfilter
Message-ID: <Zl_OWcrrEipnN_VP@Laptop-X1>
References: <20240604144949.22729-1-wujianguo@chinatelecom.cn>
 <20240604144949.22729-3-wujianguo@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604144949.22729-3-wujianguo@chinatelecom.cn>

Hi,
On Tue, Jun 04, 2024 at 10:49:48PM +0800, wujianguo wrote:
> From: Jianguo Wu <wujianguo@chinatelecom.cn>
> 
> this selftest is designed for evaluating the SRv6 End.DX4 behavior
> used with netfilter(rpfilter), in this example, for implementing
> IPv4 L3 VPN use cases.
> 
> Signed-off-by: Jianguo Wu <wujianguo@chinatelecom.cn>

When run your test via vng, I got

sysctl: cannot stat /proc/sys/net/netfilter/nf_hooks_lwtunnel: No such file or directory
Warning: Extension rpfilter revision 0 not supported, missing kernel module?
iptables v1.8.9 (nf_tables):  RULE_APPEND failed (No such file or directory): rule in chain PREROUTING

Looks we are missing some config in selftest net/config.

> ---
>  tools/testing/selftests/net/Makefile               |   1 +
>  .../selftests/net/srv6_end_dx4_netfilter_test.sh   | 335 +++++++++++++++++++++
>  2 files changed, 336 insertions(+)
>  create mode 100644 tools/testing/selftests/net/srv6_end_dx4_netfilter_test.sh

The file mode is 644. Although kselftest install will fix the mode.
It would be good if you can set it to 755 directly.

Thanks
Hangbin

