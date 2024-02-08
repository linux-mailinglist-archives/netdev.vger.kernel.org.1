Return-Path: <netdev+bounces-70121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA5A84DC0B
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 09:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57C11289DAF
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 08:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6446A8B6;
	Thu,  8 Feb 2024 08:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="csxk+bd6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D296692E6
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 08:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707382264; cv=none; b=WBqMecTke5JS0f7e5SpaUOGu5ueeTXUonVycWtnne0U7Yow7L+lOR4pQRiL/yx66bhPQDqrysTKRRhdrGLJye0Z8wUaX/aodxfQBIuawjVIFlAEuUvK8fJDFKxBcQASo6aewBS/syeS8tr7ORmiEJAc9tkGoPgOxy4vX4zRaPsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707382264; c=relaxed/simple;
	bh=7QZVCM+4Qz/KJoVHYq5ufx0w1n9m1drmdBnIdjI+ri8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dK091EE5sOsYoLSkGT+81LkZ8brL3rrf9aWQ7205EGfa2GFEzrUVCbx4GmYj/hytPVowwTTeggpHDSJ9R6QM6OhlU4dCoq0HkHiLiHH8KAjE8Sfm7J+1TUPG2SIdhQ1cxA2RIpbJR6khWVkD8i1gzNIDNF/MZAUhEiePpVrmEMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=csxk+bd6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707382261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0pp5+yA9x1/gF39Oadzq9Xuf1rHNKA+D7ZvahMSpMYg=;
	b=csxk+bd6YTmXgWqYi4JKhXrPELXQz6HHfBmHd0pKigAWJY/6UywS38N98NnN1L0um1tyJm
	Y2WG272/PMBCmxRxnYj9p9SD1NTqsCv5/2R6TlN5UmazSiXr80uAUyiX+pRMGIu3i7ssIt
	CshuINptbdbM7po5/5/UUcbSnuMowiI=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-YlRtaHwDPUuZeYkyQHW3lQ-1; Thu, 08 Feb 2024 03:50:59 -0500
X-MC-Unique: YlRtaHwDPUuZeYkyQHW3lQ-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2d0af6e4540so6175531fa.0
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 00:50:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707382258; x=1707987058;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0pp5+yA9x1/gF39Oadzq9Xuf1rHNKA+D7ZvahMSpMYg=;
        b=nNk2nUO5gO7i/DubJFRbXjtLqrbcp9NBVIVB1gl3hG2xUXPq18pW3HSgEKw0N1dyga
         H6JSYDq1/dTmAKl3UV8nYucqlrRHhgt3nsmL9Jfs825bzT5AQo0QzlYQQTtsZM/Vzk2O
         Qf/Osvgvj7IqysD1olJMZh5/slqNC0FtsWoI5KAyjYzhShnafTOtqKLPbec55h/8bN0i
         HkmNKOMWWaBNAHdE0y9NdRMtCgt4j7yNCPnxqtwfei87b/uziowvhKjmbkOBthIg2VEU
         z9mbogM5AIqAgi6c3pJWFcKa1mnGMKTsTPHtkBnRMxOzBcOKJj2dW1RJLm0imJrvRlA6
         AohA==
X-Gm-Message-State: AOJu0Yy3lV3iY2TPhH0hcxEExQHffKsNatTtpF/s68Fg8PESho8KY6mR
	cldYZplbTp/P/xQ4ZRd88B6yUgOnIMsWSPlRB8C71xonDoZdgOwtMu/Jw/StHwM51ZbebAM7yDJ
	cIXZsHL9N5JkvSxIMG2mq3mpO1vo/to6hYfVClUyjkXpodd5YDYeHmA==
X-Received: by 2002:a2e:a315:0:b0:2cd:fb0e:1f68 with SMTP id l21-20020a2ea315000000b002cdfb0e1f68mr5535364lje.5.1707382258345;
        Thu, 08 Feb 2024 00:50:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmNAP1Y0RAOw3TDUgJIwsHL2IMqC/u00qeUJtFmR21pA8Q/sNvgtKeVDntmBNBvzUL3rtUNg==
X-Received: by 2002:a2e:a315:0:b0:2cd:fb0e:1f68 with SMTP id l21-20020a2ea315000000b002cdfb0e1f68mr5535350lje.5.1707382257995;
        Thu, 08 Feb 2024 00:50:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVis8dKgy7hTUMgbWW2teg/IoY6w03/yaKWpBt7wgLmWyQ0QqqYejrTVEXbeRAbSZ5QjE45Zepc1MXA/nulUM+Xk8Vx8s+Fe81TuCMq24u42An+LRfnQX3TMYrgkuTPwS9fQBx4aYo7b5R+ywsQGgg5lB9tyAS+eSH9fHYt9QkHeHd3vjQFyDLPnduHFNly9AiHrRYD9WwXb6NXsA==
Received: from gerbillo.redhat.com (146-241-238-112.dyn.eolo.it. [146.241.238.112])
        by smtp.gmail.com with ESMTPSA id 7-20020a05651c040700b002d08f3640b5sm425954lja.11.2024.02.08.00.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 00:50:57 -0800 (PST)
Message-ID: <b40f03126ec8380704d7ff1b7364a977196ef083.camel@redhat.com>
Subject: Re: [PATCH net 05/13] netfilter: ipset: Missing gc cancellations
 fixed
From: Paolo Abeni <pabeni@redhat.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, kuba@kernel.org, 
	edumazet@google.com, fw@strlen.de, netfilter-devel@vger.kernel.org
Date: Thu, 08 Feb 2024 09:50:55 +0100
In-Reply-To: <9fb4e908-832c-44ae-8049-f6e9092f9b10@leemhuis.info>
References: <20240207233726.331592-1-pablo@netfilter.org>
	 <20240207233726.331592-6-pablo@netfilter.org>
	 <9fb4e908-832c-44ae-8049-f6e9092f9b10@leemhuis.info>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

On Thu, 2024-02-08 at 06:48 +0100, Thorsten Leemhuis wrote:
> On 08.02.24 00:37, Pablo Neira Ayuso wrote:
> > From: Jozsef Kadlecsik <kadlec@netfilter.org>
> >=20
> > The patch fdb8e12cc2cc ("netfilter: ipset: fix performance regression
> > in swap operation") missed to add the calls to gc cancellations
> > at the error path of create operations and at module unload. Also,
> > because the half of the destroy operations now executed by a
> > function registered by call_rcu(), neither NFNL_SUBSYS_IPSET mutex
> > or rcu read lock is held and therefore the checking of them results
> > false warnings.
> >=20
> > Reported-by: syzbot+52bbc0ad036f6f0d4a25@syzkaller.appspotmail.com
> > Reported-by: Brad Spengler <spender@grsecurity.net>
> > Reported-by: =D0=A1=D1=82=D0=B0=D1=81 =D0=9D=D0=B8=D1=87=D0=B8=D0=BF=D0=
=BE=D1=80=D0=BE=D0=B2=D0=B8=D1=87 <stasn77@gmail.com>
> > Fixes: fdb8e12cc2cc ("netfilter: ipset: fix performance regression in s=
wap operation")
>=20
> FWIW, in case anyone cares: that afaics should be
>=20
>  Fixes: 97f7cf1cd80e ("netfilter: ipset: fix performance regression in sw=
ap operation")
>=20
> instead, as noted yesterday elsewhere[1].
>=20
> Ciao, Thorsten
>=20
> [1] https://lore.kernel.org/all/07cf1cf8-825e-47b9-9837-f91ae958dd6b@leem=
huis.info/

I think it would be better to update the commit message, to help stable
teams.=20

Unless you absolutely need series in today PR, could you please send
out a v2? Note that if v2 comes soon enough it can still land into the
mentioned PR.

Thanks,

Paolo


