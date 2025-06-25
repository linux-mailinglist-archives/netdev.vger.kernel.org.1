Return-Path: <netdev+bounces-201036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FE2AE7E84
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 12:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BD321889505
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 10:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6410129CB3C;
	Wed, 25 Jun 2025 10:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hCgOL0W9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10581F4CA9
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 10:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750845974; cv=none; b=oaZ+s9c8HnButyc/guuLqhvzVoKGCDt2CNKG5z0znqruNRy5ozOxbEwBD0OYEFB8WjqbxfsEI5G8u6qtcxKCe821PG37zuhai6CMVL2nqVfgXpjLAcvDx3Gzsfdk8nwAgStYOk5oWLswPyCVPFfwqaKzYLC6Qd+NyPBxfIsuLyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750845974; c=relaxed/simple;
	bh=OQRcpBRl3upKIgsEgOyNBVXYp6e7hk9YmVhCrgaJIJA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=m7BOBLHyeX/ble1PydspY1V0/MemJf1Iybh9Rj0b5SxO1N3xJ/wTHGVm4uMZlm3kF3k3Yzi92QaSH/R06oKpL/FKq4Mku7qB1rcX6vcfjqzlICxYXDQVJEt8im8bXfjCEgEG9vQYy9z4MwQBgd4DvnCaeKDKZ7MoWMni+D2p8JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hCgOL0W9; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4530921461aso11429465e9.0
        for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 03:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750845971; x=1751450771; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OQRcpBRl3upKIgsEgOyNBVXYp6e7hk9YmVhCrgaJIJA=;
        b=hCgOL0W9mz1DHCC5Yd0ZdQpArN3DjL8DHjj7iceZmhUJEexHbP+iYyBEw99Of8tobD
         hZvOzzw2W5KF7svz5U+wGt+toA1kFov9FX0uQDdvAix8i1UJsqxxVUH4kWAHSyL+AZnW
         3i770N4EzaBf032XR2Sf8Od5fcNmG0lRMAhPiauF53oY/YbQ8eUYb5DS2Tz27GjzoeOF
         Hq29ZkA8iNETvizlM6M6JzssgVAg4dg+oRHsQVYFe8DEwUCCyrUb8epUqFBbzHCATcc+
         RcpTruyq4oVZUHPSQf75WXNoFKmfw3SsCXQ3a1phGtT1/pFJTpxJpHxC++SNrqzDnYbq
         q3fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750845971; x=1751450771;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQRcpBRl3upKIgsEgOyNBVXYp6e7hk9YmVhCrgaJIJA=;
        b=hnkGK1/Gcmcth34xl6fgqCmr6VEC7cwGOYmhpiTVNO80EnzeANR+MmmKUH7ezR/W5W
         55Y6ebzBvC5oT/J3BrCP4cpF+KAp4+80zCB8CkULSc+pH3iyyZ/O1iPlLuDjB2ly8XM9
         36mc2cRSai8XsQ6r8D+hkNqXmb5lvMXH1lADpgvW1bVt8UrowF4mv2vtDKV9NBAAqBZt
         iw7QZHlRpNdiweFPKTwb2q+JZq2FO8mRlnjG0zLdbJcs7TYWDO9nvxpPTsCrNr0L8OuO
         a8+Op831T3oUw8fHiOwYY9m37hIhPO5O8bZAbnuXP2eGUyuVR9Rqpz/iNe1w84DbGEJc
         Ckrw==
X-Forwarded-Encrypted: i=1; AJvYcCXCbRLMcZk2zuXTpJIi5P01HfGMK2pS+lAYMGBxiv2PC2liLS7iZld9D4d3ptD0ToB7mx2VFfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQhMkYJow3/+nobCx/+8k9lxsw5ydYak9Y48VTEpJK4jdYvN60
	a3SbF1C+FSe7ww3lY+yDNL0aTnYGh4OC1dB5gfZDoCT8KpaISLvAaJKPQnSdff+a
X-Gm-Gg: ASbGncsBNx2OOI97vnGFFmorfA2ZCF0J1YDZgiANPsZa8Dh2eHFHKTDrzvkxVYTVkEu
	ugsdfLAEsSGBgFT8D3AM3XaTy6+ZOFrM5ovgZ706vmVqV+gJA+ztbKKX53sw/YDmskKI0SdQpPI
	+LBrn/LGw4XGs6u56hWWUNfT+TgIhFZ365biPkOZlByFpXR211l+0DR1ognbUkmyfuzkDBGb0Bf
	KjCG7qykLSY+S4IGTsZgFqzUWb1rnMVQBQ1y212t1yz3N5+O7Xhwn1M0pqsYGlAuqcdJ4/32jct
	Kg8qRmcxdSyzgVo/8I/b9dpfWmA6s2LPQVATnc25t2cUIVPmBvnfQCIhOICV4R85mAijimY2qCo
	=
X-Google-Smtp-Source: AGHT+IEHnMdoqBAgTNdWXtlNLE8ri3jXxbBeMJa5HDVBKVS5VPxzD0LxzcIjYV08BWpDQqS/+TLz+w==
X-Received: by 2002:a05:600c:1f91:b0:442:d5dd:5b4b with SMTP id 5b1f17b1804b1-45381af8535mr24100165e9.31.1750845970866;
        Wed, 25 Jun 2025 03:06:10 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:5882:5c8b:68ce:cd54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e80f279dsm4282810f8f.64.2025.06.25.03.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 03:06:10 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  jiri@resnulli.us,  kalesh-anakkur.purayil@broadcom.com,
  saeedm@nvidia.com,  jacob.e.keller@intel.com
Subject: Re: [PATCH net 05/10] netlink: specs: devlink: replace underscores
 with dashes in names
In-Reply-To: <20250624211002.3475021-6-kuba@kernel.org>
Date: Wed, 25 Jun 2025 10:52:23 +0100
Message-ID: <m27c10cfmw.fsf@gmail.com>
References: <20250624211002.3475021-1-kuba@kernel.org>
	<20250624211002.3475021-6-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> We're trying to add a strict regexp for the name format in the spec.
> Underscores will not be allowed, dashes should be used instead.
> This makes no difference to C (codegen, if used, replaces special
> chars in names) but it gives more uniform naming in Python.
>
> Fixes: 429ac6211494 ("devlink: define enum for attr types of dynamic attributes")
> Fixes: f2f9dd164db0 ("netlink: specs: devlink: add the remaining command to generate complete split_ops")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

