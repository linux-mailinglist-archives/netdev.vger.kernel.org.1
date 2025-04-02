Return-Path: <netdev+bounces-178755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2C5A78BD4
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 12:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5396716D797
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 10:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BA620764C;
	Wed,  2 Apr 2025 10:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kl1qgTr7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C532A20AF8B
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 10:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743589178; cv=none; b=tRAMt90smenJh50/Kwi/sDz7rrqRpMqCmtxV/upBl3oDzlHH16Hj3k7i6bcQ/HrM65VV8Ue/41ovk4dY8729upJYFhnuM0APmFQQ/Vkmr9tcx+IKjjNio6BiHogpMmKSwULOm/lcSxXaizTLdE7S6N9bD/XnlMMtlWC64dcHk7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743589178; c=relaxed/simple;
	bh=dvJMwLbwFVMQZpDVKrUB+iz1LXat635DkIXWK3+FC5Q=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=eswL0NhnA7UVA+1O6q9ltvIy6AkGNfgWmv0m8EVNhG8ECyu/EU4XuGNP4PJQafi9y7j9ATrro3RdNBlfVzGTKXDVJGe70frnojgDzQIcdNZ+eASd/QFFelZ+CM9voV880+GzSz9eavXJgiBj1M5AQwn4qwFerRlHBqQHKHQsJ6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kl1qgTr7; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-39c14016868so2976200f8f.1
        for <netdev@vger.kernel.org>; Wed, 02 Apr 2025 03:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743589175; x=1744193975; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iho1z0XmSQ3LPrO4EtMA18RmpaJPbaZrie1ah864QeQ=;
        b=kl1qgTr7PBv1NRMRuEHFhUgZtDBkiX2odQUFXpQFrc7CpIuaog+r6o1UpZnRt1DBQU
         vU97WS3l4qv/3407hLEcE9YNT/hM0v/XomQwN0QJgoFj3Nd5zffnQvJyeOGjrIDSnwqd
         4YdLV98dmRjNCewm7BCmi9BS/OCzR5mVbCk6aIsm8uuOK4mGUfndZWzBHhsAUKC9ZAOE
         Id5EzRhdgeqGDAGkFvqeZ9aCwJQTyLwXQQE4zSwdw+VaAM2NRFXPr1lOcB65EizI0etz
         dlT9jpDBlAhyQ9K0fN9gueCK8YMrRoZH/SLu2H74EVpLKj2I6WKdyZTC0rVcuDKFuz9y
         wDjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743589175; x=1744193975;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iho1z0XmSQ3LPrO4EtMA18RmpaJPbaZrie1ah864QeQ=;
        b=MxeosgZ7Eo+7K8vsyY22aAHelYJvNkCox5hBeJwFhtLLS+Luih5qdyi9tDSGEPfrdG
         IlQmWlDmgES3D5XaRoYEd05jTgeT7bdHDDP/4MN+G/e+pWAEBLBs5h729R7R1vJg95oh
         +SHGUuIGvom0MAun2PwjIyum4DwnWFmQyppxH1RcIlB/6eaLR3QpM2wq8NotqhXO6if4
         jZPkOtuBsobxOzjgkd/gKoM9NlOH+raela+KeYwdklbl3fZqaAVl1nLAqaKawi2vxIVW
         hLx5maXcu+3UsMVPAe5J7t6KdeS5RJKFi57evrr++3QaWSDLYmkzxaAZBJjuFi/tC+kj
         Mf+A==
X-Forwarded-Encrypted: i=1; AJvYcCWOSGeUpMIE8oTZXaOLcbs80NYX5qBqPCt0QECSXd391/oWgOEhEfosH63aABzBXB8CjPyG7TA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQaAcw6vosOMyUdlHfaiyluKQFeuTiFWy4AMoCjgx0ELpim/Ir
	gk1gQiPq6rWo/tZzNWymUCTdPICGdYvPHI/HbQe6ZEiqZcV4wglO
X-Gm-Gg: ASbGncve66CUv7aJrmrK4rw4pFrF3cfKDqQEspOnjWjXoaEbH24D5V4Ji3xEfZREXfL
	1idvoNo7QMkERty5AezSI31m6JFSf+fKs6La7fgQf5iAkbVKMrwhGaDBupcQDv6f3VBi0dhKdIF
	Edn41hSWDyvbK7SdqQV4E4KKdMDKn3Q7p5BPKkI1q0nKlj4pkVTyY2XANkzxA6o6Vq8watg593T
	eNQvR005k1gjgUwS7+r3Zb8Nqo2kwAl43tC/2NLXFuCCsQEdbWsbM6gJkEidzLDohKku/EdW8K2
	+Hhx9BuJAx1fkOlGu1Qr+dDqhsBmwdoIvVXZgraX6i7o6Ik7qRKFg5WeYg==
X-Google-Smtp-Source: AGHT+IGzdddktPzSiZlf4AYKEN/aCkfEegem3dmo7j2amCG9tYuTKkvjVAPzvNanahpiOdyFr199mQ==
X-Received: by 2002:a05:6000:2b06:b0:399:6d26:7752 with SMTP id ffacd0b85a97d-39c12117ad8mr9369089f8f.38.1743589175010;
        Wed, 02 Apr 2025 03:19:35 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:15dc:40df:e712:c569])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b7a4318sm16239661f8f.87.2025.04.02.03.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 03:19:34 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  yuyanghuang@google.com,  jacob.e.keller@intel.com
Subject: Re: [PATCH net v2 2/3] netlink: specs: rt_addr: fix get multi
 command name
In-Reply-To: <20250402010300.2399363-3-kuba@kernel.org> (Jakub Kicinski's
	message of "Tue, 1 Apr 2025 18:02:59 -0700")
Date: Wed, 02 Apr 2025 11:15:26 +0100
Message-ID: <m2y0wihnsx.fsf@gmail.com>
References: <20250402010300.2399363-1-kuba@kernel.org>
	<20250402010300.2399363-3-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> Command names should match C defines, codegens may depend on it.
>
> Fixes: 4f280376e531 ("selftests/net: Add selftest for IPv4 RTM_GETMULTICAST support")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  Documentation/netlink/specs/rt_addr.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/netlink/specs/rt_addr.yaml b/Documentation/netlink/specs/rt_addr.yaml
> index 3bc9b6f9087e..1650dc3f091a 100644
> --- a/Documentation/netlink/specs/rt_addr.yaml
> +++ b/Documentation/netlink/specs/rt_addr.yaml
> @@ -169,7 +169,7 @@ protonum: 0
>            value: 20
>            attributes: *ifaddr-all
>      -
> -      name: getmaddrs
> +      name: getmulticast
>        doc: Get / dump IPv4/IPv6 multicast addresses.
>        attribute-set: addr-attrs
>        fixed-header: ifaddrmsg

The op name is referenced in tools/testing/selftests/net/rtnetlink.py so
it needs to change as well:

     addresses = rtnl.getmaddrs({"ifa-family": socket.AF_INET}, dump=True)

