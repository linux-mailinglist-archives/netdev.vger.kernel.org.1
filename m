Return-Path: <netdev+bounces-213227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF63B2426F
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 09:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8385A6838D0
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 07:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6351EDA1A;
	Wed, 13 Aug 2025 07:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N2f1tS/J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6A51D5CD4
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 07:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755069482; cv=none; b=a6nZjPN08al79MdEC+bcHqNtYv10Gg+NvM+EG8WtQSxuM9DIfhhUcu3w+GpuoQMVL04ZMVaHhLkL3yCUH0KK05KTIqAqiTzjd3EfM0rSHsxGX73j95vEHt1fX6SEcTvnX1dwm0y39si5AMhDnXvry9PjoazwuZbBf5J3zO1lYgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755069482; c=relaxed/simple;
	bh=2sXRAqwjoM+Xqtsq5ZhT++wVbMQMux3lH7BmZPn8+k8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MvOH17z30vNeDpVlpMYyjD4Y6HVcstJPjLGfhyW3bbw0Akd9Y8DgRUpLfDm4ozuspCIBFhseu4rCPVO6w6GIuzFP+x+4hODyQ1hM8m2uf1bu4GxwJ4gMs1tyggN+d/Ylr6yjZBJT2ZtqxMDqwgJGxIuWqosx6jZIpTOC0sKjMp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N2f1tS/J; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-31f74a64da9so6996910a91.2
        for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 00:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755069480; x=1755674280; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8SAZ5+tG3ZRuT5cOEF00oPZiYmB19G7qWc7d8sSB6JE=;
        b=N2f1tS/JFcHBA4lPbp4xNQyWo2XF7juRHy/cOMsPbPdLCzDaiIkd5qNw99xM8+fJVZ
         WOs8SazXE165VGq2mBvdMYLJlI2OVO5nmfTjsaVnNE1BiZ3PNI6Xlx6uQE8QokXcg6a0
         pHgiiCabewH2svopuJJbZW+KqU27bGsK0WdLV15o/OVuq2RupuJhb5tyFkCXbuxbvqEs
         EIelwEukLd3aDwj8bcbe5Q9BLujrRyX1xj6YVJjVA9jM4I7n77FapOaxcNjNzNLSxurV
         Fn1wQKrBdDpOePc//9fzOyAtzjO3m+PLhJNqREEIQhKeGCf/O0LyVou274MUqloXV8o0
         Yiag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755069480; x=1755674280;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8SAZ5+tG3ZRuT5cOEF00oPZiYmB19G7qWc7d8sSB6JE=;
        b=GavJpUYSIv9zaVBvWqTmSNqWrMPz3yH8jBl38hxAD24JPQYn31GK/GqV/5WBD5Ulf9
         cdP72PGJOQKbcmoRX3on3nBBPVxyntMek8TQ89JiTBewSe/yv6tYknl8d8l39RVGk8qL
         Hjq2rLItlpLcJ+djyBFZcB0m9pogIW3ySAro6me0Qtld47SyBx+6UraFw/ogE9xG8g0d
         r8A2eL83rIhxcIrvFFGHN5F45eQgX07ngde+wT+nrKpipgNoMwSlt7v8ByQQIkse7Lxw
         42Yp0FrY/AaZ7SR9SySx3Kn1l3cZofXzwr3nrp222eyUo0vI0Vz9oITJ8sF4+lAthoCa
         7UdA==
X-Forwarded-Encrypted: i=1; AJvYcCWqldmPPAVK9dhBOtBeRmfMxOntPLkI2SxDbHzQ2gR8frQlSIDrguydM9UP627QW2mSnKJzPWs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd0jl9vuNjDSJAxXGU+5Vn6WjyXJfD1XETvKUTH6fNVHS6FBPm
	07EsihTO5dOpgJbXQ/NudQp2x+i9MVqHOKFiWUziLJzAplt/AgU/gkzn+1g8GAP7BzH2tjJ6AMK
	eeop1bw==
X-Google-Smtp-Source: AGHT+IEJ0fKKIrP++t7YC+9G7QybvrW2+fKmbXma+52WKDstzK7i3e16edtefdY0M32sY4d2nyBFLatIbPo=
X-Received: from pjtd14.prod.google.com ([2002:a17:90b:4e:b0:31e:eff2:4575])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e18b:b0:31e:cb27:9de4
 with SMTP id 98e67ed59e1d1-321d0eb3171mr2884308a91.24.1755069479875; Wed, 13
 Aug 2025 00:17:59 -0700 (PDT)
Date: Wed, 13 Aug 2025 07:17:35 +0000
In-Reply-To: <20250813065737.112274-1-heminhong@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250813065737.112274-1-heminhong@kylinos.cn>
X-Mailer: git-send-email 2.51.0.rc0.205.g4a044479a3-goog
Message-ID: <20250813071758.123403-1-kuniyu@google.com>
Subject: Re: [PATCH net-next v2] ipv6: sr: validate HMAC algorithm ID in seg6_genl_sethmac
From: Kuniyuki Iwashima <kuniyu@google.com>
To: heminhong@kylinos.cn
Cc: dsahern@kernel.org, edumazet@google.com, idosch@idosch.org, 
	kuba@kernel.org, kuniyu@google.com, netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: heminhong <heminhong@kylinos.cn>
Date: Wed, 13 Aug 2025 14:57:37 +0800
> From: Minhong He <heminhong@kylinos.cn>
>=20
> The seg6_genl_sethmac() directly uses the algorithm ID provided by the
> userspace without verifying whether it is an HMAC algorithm supported
> by the system.
> If an unsupported HMAC algorithm ID is configured, packets using SRv6 HMA=
C
> will be dropped during encapsulation or decapsulation.
>=20
> Fixes: 4f4853dc1c9c ("ipv6: sr: implement API to control SR HMAC structur=
e")
>=20

nit: no newline here.

> Signed-off-by: Minhong He <heminhong@kylinos.cn>
> ---
>  include/net/seg6_hmac.h | 1 +
>  net/ipv6/seg6.c         | 5 +++++
>  net/ipv6/seg6_hmac.c    | 2 +-
>  3 files changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/net/seg6_hmac.h b/include/net/seg6_hmac.h
> index 24f733b3e3fe..c34e86c99de3 100644
> --- a/include/net/seg6_hmac.h
> +++ b/include/net/seg6_hmac.h
> @@ -49,6 +49,7 @@ extern int seg6_hmac_info_del(struct net *net, u32 key)=
;
>  extern int seg6_push_hmac(struct net *net, struct in6_addr *saddr,
>  			  struct ipv6_sr_hdr *srh);
>  extern bool seg6_hmac_validate_skb(struct sk_buff *skb);
> +extern struct seg6_hmac_algo *__hmac_get_algo(u8 alg_id);

nit: extern is old fashioned and should be unnecessary.

https://www.kernel.org/doc/html/latest/process/coding-style.html#function-p=
rototypes
---8<---
Do not use the extern keyword with function declarations as this
makes lines longer and isn=E2=80=99t strictly necessary.
---8<---


Also please follow this next time:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#resen=
ding-after-review
---8<---
The new version of patches should be posted as a separate thread,
not as a reply to the previous posting. Change log should include
a link to the previous posting
---8<---

