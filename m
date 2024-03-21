Return-Path: <netdev+bounces-81123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFC8886007
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 18:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 664CF282419
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 17:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA6D12CD8A;
	Thu, 21 Mar 2024 17:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vZrOFnam"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29888592D
	for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 17:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711043284; cv=none; b=jitWjRVNfOB1dtPOkZ5az0tfVbLu/nCJGTGwrCLQEpmJ+eXb0agh42n6Bl5cmGX0R/XZirs7eheffxAI5xJgOaejEgCpM2PcAdkDXnrTqurNRphExDGNyN0SdqjJNVMNRwZXvQjhtfOl94yZ9KmX6oh43I5TicVfut79B6Ey+js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711043284; c=relaxed/simple;
	bh=O+Af9kym1NkobnQrECieIq6cEV6FPsvxxJSg1+NLtsA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vB1Pxzmc3+FiI23YjNTUfsmVhQoJG063XxyF80R2YLx2Vgr3bqMiKiKa496Crfu7U4UPBcWJh2DUpL75RULZ1kTUBkcB5BRE19pd+SW/SSu/auXEbWbVtgJ84rEn6+Ec5orecqCFQB3M+Ch25hVeDOKJM+q580ZpvhlZiVBFLKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vZrOFnam; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56bb5b9ab89so1511a12.1
        for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 10:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711043281; x=1711648081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ulL31+7TLEa1USxhPrvoRDQYnq2BRkS4H57usirjYLM=;
        b=vZrOFnamyFWGFi8uBxMNSOnxoxhwJK3N3U2x1apP8kO84PSDmPVcYVslosLLslt4ny
         XEl9XRK3OZO+1qpHjeJGfrnfoZxc5ONM8K+mM8we6sMzjX0G5AtRRaCWVidmgylAStoj
         /VF0oTwAeoUec86BL+Tfeh8kBf4GZkUAczTr4AHzPaEJpWt10vwqiH0DLPcftKqE/saf
         5Q1rnw+QJuuo74JUG6msa9lhlUPvKCdqAgIq1f0pNVIpKcuWCiy96RVS9taa4YBlDkCO
         dCA2WK5OuhjX0+5w2vl0QhKCz4T6dEuoBFo+uVzwsdkRN0iLMcVgaD9xJZpCAd8/PFDc
         xkBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711043281; x=1711648081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ulL31+7TLEa1USxhPrvoRDQYnq2BRkS4H57usirjYLM=;
        b=j1t3DkFWuR1/4z3Sn+q3jL8If0ctJAcLCwTiMfvLQosHILZS/dO1bDzxn/2hOg/A9H
         /qhoScSrTHgpk8G0Ccwy1ZdgWjJtRYPt2mCgbY/RBPOv4Ixu0xI6uYpceOaCcY9eiw0P
         wMXqcV4GsV+bwL2moQtNXRCY8QlSAn4cfTUD8GqsC1Xc78kR4qv6DjQlO0IzTPMat3nK
         rprwCX0/60pXbj8bLuWuZIav79wo3uVMdle4wH6jZuZ0encJitrAlEL8CbjdMLkg6Sr+
         2upvNSPHpKUhOVglQ51FaEnuTIiVz0fR1U9ToUruMdMHIOLsA+MhAS0tPO8BSeqqYgBZ
         wGSw==
X-Gm-Message-State: AOJu0Yz8H1Bf8DAa7rKmCPp878ZsXB2oz+bULVQdN3PiMyWdJDFONXj3
	duDV7FXVvZKhgHZSAkTV+jfQTWKiN9WIvg80FOfRYnvnMmPH//H9zrjWldFc7aRrovpjHdZn2Ri
	sZuiPrvnH+RBYUxeyI0yQNFzlNuyMGj2Vbo28
X-Google-Smtp-Source: AGHT+IH2uzgFK10nhsaC3tLlChgyxaqwJD5genmrgampsUyD90LhRxqpiZqQpl5GUTiV9JiFCt0oXwiuG+fJ3/gXHsk=
X-Received: by 2002:aa7:d703:0:b0:56b:826e:d77d with SMTP id
 t3-20020aa7d703000000b0056b826ed77dmr184395edq.3.1711043280733; Thu, 21 Mar
 2024 10:48:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321173042.2151756-1-idosch@nvidia.com>
In-Reply-To: <20240321173042.2151756-1-idosch@nvidia.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 21 Mar 2024 18:47:47 +0100
Message-ID: <CANn89iLZ2NoNCVTEa0pn510S1rW=eJu2z+ihSV6PzE2awWG7Pg@mail.gmail.com>
Subject: Re: [PATCH net] ipv6: Fix address dump when IPv6 is disabled on an interface
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, gal@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 6:31=E2=80=AFPM Ido Schimmel <idosch@nvidia.com> wr=
ote:
>
> Cited commit started returning an error when user space requests to dump
> the interface's IPv6 addresses and IPv6 is disabled on the interface.
> Restore the previous behavior and do not return an error.
>
> Before cited commit:
>
>  # ip address show dev dummy1
>  2: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state UN=
KNOWN group default qlen 1000
>      link/ether 1a:52:02:5a:c2:6e brd ff:ff:ff:ff:ff:ff
>      inet6 fe80::1852:2ff:fe5a:c26e/64 scope link proto kernel_ll
>         valid_lft forever preferred_lft forever
>  # ip link set dev dummy1 mtu 1000
>  # ip address show dev dummy1
>  2: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1000 qdisc noqueue state UN=
KNOWN group default qlen 1000
>      link/ether 1a:52:02:5a:c2:6e brd ff:ff:ff:ff:ff:ff
>
> After cited commit:
>
>  # ip address show dev dummy1
>  2: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state UN=
KNOWN group default qlen 1000
>      link/ether 1e:9b:94:00:ac:e8 brd ff:ff:ff:ff:ff:ff
>      inet6 fe80::1c9b:94ff:fe00:ace8/64 scope link proto kernel_ll
>         valid_lft forever preferred_lft forever
>  # ip link set dev dummy1 mtu 1000
>  # ip address show dev dummy1
>  RTNETLINK answers: No such device
>  Dump terminated
>
> With this patch:
>
>  # ip address show dev dummy1
>  2: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state UN=
KNOWN group default qlen 1000
>      link/ether 42:35:fc:53:66:cf brd ff:ff:ff:ff:ff:ff
>      inet6 fe80::4035:fcff:fe53:66cf/64 scope link proto kernel_ll
>         valid_lft forever preferred_lft forever
>  # ip link set dev dummy1 mtu 1000
>  # ip address show dev dummy1
>  2: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1000 qdisc noqueue state UN=
KNOWN group default qlen 1000
>      link/ether 42:35:fc:53:66:cf brd ff:ff:ff:ff:ff:ff
>
> Fixes: 9cc4cc329d30 ("ipv6: use xa_array iterator to implement inet6_dump=
_addr()")
> Reported-by: Gal Pressman <gal@nvidia.com>
> Closes: https://lore.kernel.org/netdev/7e261328-42eb-411d-b1b4-ad884eeaae=
4d@linux.dev/
> Tested-by: Gal Pressman <gal@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
> A similar change was done for IPv4 in commit cdb2f80f1c10 ("inet: use
> xa_array iterator to implement inet_dump_ifaddr()"), but I'm not aware
> of a way to disable IPv4 other than unregistering the interface, so I
> don't see a reason to change the IPv4 code.
> ---

Thanks for the fix.

Reviewed-by: Eric Dumazet <edumazet@google.com>

