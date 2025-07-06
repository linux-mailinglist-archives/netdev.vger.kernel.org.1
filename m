Return-Path: <netdev+bounces-204433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5FAAFA67B
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 18:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3E441898721
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 16:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1891D6194;
	Sun,  6 Jul 2025 16:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VrrsemLp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AF32CCC8
	for <netdev@vger.kernel.org>; Sun,  6 Jul 2025 16:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751819032; cv=none; b=o//X6TISEJBQ3+ltYMLVCpwY+Mtt2WI0FppmM3GyTzJy+MpfwEzeNmg0J6r4X6xtWw4iMKbNtCMKq+C9h7B7DGPP3AXe5vpLbyoOXKbtGrq2/SknAtIcjLZYyDZPDbhq+NFvGLuhU9BE+fPgM+vS+jbevWPy9zC4189ox7xDoZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751819032; c=relaxed/simple;
	bh=LH+hxta4W0Ya7FGiY8aCINbEFpc/qKczsFvP80lF73g=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=bG8Q1hlIEVTkBM2BtyJNkhZdR6mE8oZKvbG5aC/rc2qBMYml7DLKOz/MiEu8CceiErf31V/3X+hF9sXwPW+fpyRC3HpCnOLRE7mjqsDjVW6tezCJK26qD26W2IICA12MNOueuQ5iCW3eEn/knU1TUhVhouXqDJ+OVio9+BrzP8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VrrsemLp; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e81826d5b72so1935483276.3
        for <netdev@vger.kernel.org>; Sun, 06 Jul 2025 09:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751819030; x=1752423830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bHQn3gu5m154FOrJUwww0HO5BYJel/ZENjVGxq7z4kc=;
        b=VrrsemLptdoDUZVEAvVsWGSyAd13LzlB+H3DcQppYxa+vCp0fA5Aj54BfvsNc3iw+U
         le4w9Sq6cSFX+xzhzvNrRHDrOa/yw6TCUf499AU/h9V8IBaRMfLwQkvj0ou7Eeau/m2F
         9IRvFU/9vrJVwMoz2ZMg9YOB0coQ5UegK9XL+Ouv6dPcZx6BEiIkVxo4LGfOuHe1c49Q
         tW4i2SGPX+/KaIOsSkLmXhfIGomiGibA33KqAnCLydV7y7k8F4UwJ/3FY4L4bWgrli4D
         ZrwYMuBTkeBUWABWWaSqLyzU6H5FNH8Mzx8AG6Onliy0cZWFkT4VxxidROj9a/oHNI1c
         RKTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751819030; x=1752423830;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bHQn3gu5m154FOrJUwww0HO5BYJel/ZENjVGxq7z4kc=;
        b=ZiALZ1hOQh1hCKctEjDXoKARvkNHTU+nbEaXh3T3QOVYPep3hPFp/ZVh2STjqEvyNL
         0NoPispceyReePlnrvYxUEvl8rIsrdxep3xNpr3hdFypAK+Ni05y4Kcc/OTqHKMEXtKh
         T1XDrf4bECuRsy2I3rO5Jm0PDXdngUugOeQ7C2y9/j8BuzBR4qUWBQOG4m6UqNNaov2Q
         IJfA0aJa4c/dAxtoe09eDLMT2ZbroJVpXI9jGmyBpocsxmOfpY1dDfrK0eH2Q472y5/K
         9JUWkROm2D9qqZuOCYZBL0u50ToOAar4kNnlClMHdqxP0NrZGJNn6EVVLRngJeCzSsaN
         fxow==
X-Forwarded-Encrypted: i=1; AJvYcCWl6xAjpSK50rgTsjyPo45EjUrRdcanOBW1ZWN0d0Z72eCIPXDYD04cL6JfP9pppBlhg5u0rjI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrWE7TVve2LGJZ8uOvdL0RnBURWWDFQG6wtQ8GoSlzAQy9DJIq
	O07mRzztpepk8G0w1Gv30tDw3dLp0+rK3+S+7x0re8QoUoeEsVYu6DCJ
X-Gm-Gg: ASbGncsg98gjx6GFAhtsHaI+oNzLlI/enDfsoOIbR7PKK91C31RrhEZYoliQxepw3IN
	IqTHfKU30ENTAKIxVdem44RPTRvkrnQUnSJ0M2fRO/tRIa8Suc0SKKHl6e778sRI/6O9rC3pe0k
	r/v9kEg7L+5DvttIg/DqstGt/iOHKl55mg5q1oxiWUWSnRNlKVp0GxB+o3vIjJQStjZek9KZmF4
	9sjAPEG00Nyie6DGz9xXjHhi/SU9aVTouUxCpkE4UQx3gRuR7GlBYVKB2L957I9ksyFSjovk78Z
	aZWvTHP3wSDSlNIP/iGjqbilUhDT11oPLAEl/0b7xGBZFNrvBpU4pBXMvi3sLAAvcrytIhAoW9D
	Q3x9eabDBxQey6Bgi4o49p3S8fG8kLYzBqlhnBVA=
X-Google-Smtp-Source: AGHT+IEjJGMIsjg3OpdmIKQr/DvIs01+v4Pn3SUPS8uUGCi9EFrhIUbh1XYIAx0SCmCB0Wb+Xvzz+g==
X-Received: by 2002:a05:690c:a608:b0:714:3e9:dd3 with SMTP id 00721157ae682-7176c9e56e3mr42425827b3.6.1751819030094;
        Sun, 06 Jul 2025 09:23:50 -0700 (PDT)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e899c440855sm2056628276.33.2025.07.06.09.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 09:23:49 -0700 (PDT)
Date: Sun, 06 Jul 2025 12:23:48 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Daniel Zahka <daniel.zahka@gmail.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Saeed Mahameed <saeedm@nvidia.com>, 
 Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, 
 Boris Pismenny <borisp@nvidia.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, 
 David Ahern <dsahern@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, 
 Patrisious Haddad <phaddad@nvidia.com>, 
 Raed Salem <raeds@nvidia.com>, 
 Jianbo Liu <jianbol@nvidia.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>, 
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 netdev@vger.kernel.org
Message-ID: <686aa314e5e6b_3ad0f32949f@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250702171326.3265825-8-daniel.zahka@gmail.com>
References: <20250702171326.3265825-1-daniel.zahka@gmail.com>
 <20250702171326.3265825-8-daniel.zahka@gmail.com>
Subject: Re: [PATCH v3 07/19] net: tcp: allow tcp_timewait_sock to validate
 skbs before handing to device
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Daniel Zahka wrote:
> Provide a callback to validate skb's originating from tcp timewait
> socks before passing to the device layer. Full socks have a
> sk_validate_xmit_skb member for checking that a device is capable of
> performing offloads required for transmitting an skb. With psp, tcp
> timewait socks will inherit the crypto state from their corresponding
> full socks. Any ACKs or RSTs that originate from a tcp timewait sock
> carrying psp state should be psp encapsulated.
> 
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

