Return-Path: <netdev+bounces-219504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D12B419E0
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 11:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D67D5627DF
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 09:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC2F2F1FC7;
	Wed,  3 Sep 2025 09:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VpMCmb1a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427E62F0C67;
	Wed,  3 Sep 2025 09:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756891559; cv=none; b=QL0/TM7boKvliBtUd+K00/R7NzOs9Qn/94ocmIdO3lyjT8K9ETzqT3hJZQB+CcOm7jjAlcG5Wdw219L8VPniItd+pOvt1soP1DdTEJ/grLD1G6Xt6s80HmoJaISIfgbYblQ0G499/BxW8LoVBJ+K6wYlOVIc7Qq/IDU4V9TtWRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756891559; c=relaxed/simple;
	bh=U+v5jH6AyaindDQc6AGwol0j3FYphD7c+3FZrE9ycmk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=TTvRAMUTISifdoEdcGLmc7QKw3r3JlaZAOcKKK2tr08km6aoRpmnzYz65uYmK4yKTBaWn+ggI+4myz+Tcbw37eU3vB1rI1xpYBIhoQe/TiYvoqFwT47m/B1ImxypSgooD1DXx5FbWovtvUwAoD6ytUoyMWD/VyE0MI3rEK9dx8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VpMCmb1a; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45cb6428c46so3347295e9.1;
        Wed, 03 Sep 2025 02:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756891556; x=1757496356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=U+v5jH6AyaindDQc6AGwol0j3FYphD7c+3FZrE9ycmk=;
        b=VpMCmb1aEuDv9dqCeIQvHzIcqAUjBmQWRhZeqyUeq7ifcaB5XkYIRHqoYtRkZQ76cH
         NKJO0a/Xw+gAmYOXOBJC8rqsPUftwI38UthGItL8Oep1arxUysnxqbOWg+dRtZ0UZ6iZ
         SY7z1/9syJcH6ec0wynuzjbBOKAgDK8xTTNYaUCcTXmchZIxUZpx5k50ulYYiUyHsn/n
         PlwnKF86k+iI9LVAMbAl18m73MbD2eJUaqVBIN+aOGkOLW/ogM6JWR3TtG2lfgeNVE/i
         JqJDwsztzkY31+bKcdA0fd5goWWyo2Xr/Xl8vyPA+RtfbInK1z4dNkMQp1j/D+JWjL1y
         YIDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756891556; x=1757496356;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U+v5jH6AyaindDQc6AGwol0j3FYphD7c+3FZrE9ycmk=;
        b=iAl5ci2tBIp+8Laa2TtgwOgJhdHJQuoyYkeR+biSHiFo7whfvLrDxqQcmJdX9DucSc
         qh9wIg0RNhGSCS4Y5UYDkSHxxleobNs3OY/Vbox2cAbjdUu0y28WJBAiQP5plKpu2L/m
         8HCybxmQg8MIjthSGe8FEc/bjLSDsEPopU2SFZx2GxT0TOZnYAImdSBN/rinkUs2QQay
         Ton4kp6Up3Bx1uB5/E69TGTk11hRc7ltffxA6ywU7SXBwH37FASI4CU2XNGKKvdnLUNo
         crlYGE7nAAsRhmyf+t7Kr5WNKnYOzvSz2TX78EB9wgfPQzl4RTVVMK+VZgskfuNNQNS5
         l03w==
X-Forwarded-Encrypted: i=1; AJvYcCUnVpUJa66xeeZeOp+nVKafkRw/DODOdDAMWPQytPP6U0WZiJH82zVBrATf01j57DD6Ypvr1nenWQexm+s=@vger.kernel.org, AJvYcCWlRtqwWxpYi6xP1ngv5CORNqTBjUcvlOvd5v8CpQnDu50QJsbpG9SdXKT+a0peEYWny1U2NoYc@vger.kernel.org
X-Gm-Message-State: AOJu0YygCdXCxfD9COaQHKjHSN7TViuaxOa8Ha261IJ1vkJ6Yn42Ti/B
	z0HYSH5KJb2haLyQJCsZOQPQObBEz16ULy3EvXwZ2OF+wOavZmunE1MV3NmNww88
X-Gm-Gg: ASbGncsyHCWkMvwWDV1K6sgRVCC5MJdXGH8lftsdGZFI4iQyTvD8sivUehyZVFqns6v
	YfnD91jlKWnmInNbTPHzU668zL1tEQnh/4zrRgSsiGreDV3E8xeiZQU1+B8kNJW/TboqrcEO7EH
	kv03b0g2aEJzknH1+2s4iwyjlz5x05q7BOe8oRqKnwFj0OYiscjCe02lkwkfAX6sNk7wpD+d1yC
	GUQKUgzSlz/5S6/8U22qcPp/LvKILlMJlJejoJeJb6sn3Ydu7avnVo+noMcwP8E89+TAbK1FHgz
	J4dxU1JGN1BMihFDp/bp0dXk/774YQR7jiVsBe1pcje2SlTucqhiZJAr7/k5uW+ZpcxgNRpXaQv
	VnJK7rT46H6kB8pny/4pqywO3daKJMqLHwPad8KB/
X-Google-Smtp-Source: AGHT+IHkRhdj2JIsa9WgkzYrLBB4WzmIICB1y+y2H3Ew0iWqnYwj6kwSQy5LuNDyUHpy5pHhniB76g==
X-Received: by 2002:a05:600c:46c8:b0:45b:7e6b:c235 with SMTP id 5b1f17b1804b1-45b85533095mr127570215e9.9.1756891556075;
        Wed, 03 Sep 2025 02:25:56 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:599c:af76:2d34:5ced])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e50e30asm232866805e9.24.2025.09.03.02.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 02:25:55 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: =?utf-8?Q?Asbj=C3=B8rn?= Sloth =?utf-8?Q?T=C3=B8nnesen?=
 <ast@fiberby.net>
Cc: "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,  Jacob Keller
 <jacob.e.keller@intel.com>,  "Matthieu Baerts (NGI0)"
 <matttbe@kernel.org>,  David Ahern <dsahern@kernel.org>,  Chuck Lever
 <chuck.lever@oracle.com>,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/3] netlink: specs: fou: change
 local-v6/peer-v6 check
In-Reply-To: <20250902154640.759815-2-ast@fiberby.net>
Date: Wed, 03 Sep 2025 09:32:34 +0100
Message-ID: <m25xe00wd9.fsf@gmail.com>
References: <20250902154640.759815-1-ast@fiberby.net>
	<20250902154640.759815-2-ast@fiberby.net>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net> writes:

> While updating the binary min-len implementation, I noticed that
> the only user, should AFAICT be using exact-len instead.
>
> In net/ipv4/fou_core.c FOU_ATTR_LOCAL_V6 and FOU_ATTR_PEER_V6
> are only used for singular IPv6 addresses, and there are AFAICT
> no known implementations trying to send more, it therefore
> appears safe to change it to an exact-len policy.
>
> This patch therefore changes the local-v6/peer-v6 attributes to
> use an exact-len check, instead of a min-len check.
>
> Signed-off-by: Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

