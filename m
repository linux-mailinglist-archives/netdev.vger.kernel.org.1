Return-Path: <netdev+bounces-142585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 034EA9BFA97
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 01:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEED81F22368
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 00:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF9E623;
	Thu,  7 Nov 2024 00:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YZa8ml9A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BBB621
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 00:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730938491; cv=none; b=ZGRCpE1S6WzcxotVAg5WK+yXtYwmsIBXelz4q+We8Yt/PV5PI0a7dOUZG2xuMcTNzIXko4p6+j8vuby3dWW3RsFfxE1Fh1pK3ZY4cdTaI2Zo6XzwjL/MgEhmG8YCsc7L3KR46q0kVv79dBubBpPxCtw8rjnIHfdrKQ58ncLRHRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730938491; c=relaxed/simple;
	bh=V7C0dcgo9F8F1VAly95w8HsKvpU8d0aZy5AFcToRj3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r7/Vl2rYk4/pv2ldc/dRzMTCnUg4ZMTz6Oo7JYpx3tY6ALU+DOrXIEiY8kooX126UjcYg+HpSYNwVaRKID3XCxZR7jZBQpvjWpOSFH1LPD9G1MDdwDCYxMCfRdcJ5JVXFK9RtVmgtBqsTsQk/1uX5qJFgeOR7IQCqKDfRwkEkxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YZa8ml9A; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9a16b310f5so53069866b.0
        for <netdev@vger.kernel.org>; Wed, 06 Nov 2024 16:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730938488; x=1731543288; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V7C0dcgo9F8F1VAly95w8HsKvpU8d0aZy5AFcToRj3U=;
        b=YZa8ml9ABC/BY45SFAlKt987cjpH0BVWe36rX4hRdS8t5mD4EaWZpt/GwDZcWTmHex
         zckYVR1MCmaUDmG38/LmGxDOoHBmwxDR0H3E9g9erxQfj/4bU2b/tXjQj40fgcf0/LE8
         Cv1+Hk/qBfGI1Ik373LS6jcP11rbs0KOvIx0Ynof7DNAR1xVw4Xckm/izGYTqAjr3aNO
         knd3t/h1ToKofZ8kTS0bEcNvOt2/6eqWJupQkdvrhjbjdxiVmgBYBiNCf7LxG+qtp0h+
         iqywtWdsijHHgVN6JgdxByAOyzF+LscOEzp8QVzL2lQgC1b6+HN7I9/ml+HA++qBgso5
         ommg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730938488; x=1731543288;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V7C0dcgo9F8F1VAly95w8HsKvpU8d0aZy5AFcToRj3U=;
        b=UeBz7vvMgg4jKP2tl0/pEEU+5CUGPzoaGKKy59pqHhKPhWP0/B6lIBO0n8aYHE+hcD
         6iBudTrTDpTGzq082ZEmZhbAZHrGiEq2OgLVcylkwDS5WK4ABNyYfx2Ns7iAHGuDAeNK
         TTnQp4WvIfDdixRWw2OfIk7LACKUnJHXt2vnZmg/8HaPAnz9e6u4T8+bCQQGFnL9mIw2
         S8gr3p9wssx97is4I4C/6LJD10GFF3jhNiYibhWdc5hKE7f6ItR6VkwDB2JiXn5l+ATG
         emE+NqPfALV2iZS+DosgxktQaLDbPCWZ9vR6KlIwJewoXPtWog3n3u/PigstIPLx1Aw8
         EwLw==
X-Forwarded-Encrypted: i=1; AJvYcCUAdYAEmHguv5lZGWwZQRLkQZwh59PwPvISALbnbn5SurnOnQg4LBOri+SjllrW6RlaE8FCIp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWKvW4+jpy2j02MuS9T1y4i4lUYb1Bl1J+Lf7rrY3Gjud73dx6
	8brQZzY5A3IFMEQBcgbuR3wjDpbDvdk3Vu8XGgkv7bbIyb1dUnaGgFiW6HVIc4S1fpHxuAIfg83
	JR/J1+eNaXqRqRYn/husNq2LOvLHffCp+5Vls
X-Google-Smtp-Source: AGHT+IHeWY+j+4IZS+y+ddUBGpYT28Xx3mfnOKoE6BeVWjrGt4kNwOOi3HEBPJUQENtA/Hc13QskZd65ujIsFmrRItM=
X-Received: by 2002:a17:907:7e8f:b0:a9a:183a:b84e with SMTP id
 a640c23a62f3a-a9e50b928acmr2475297466b.40.1730938487683; Wed, 06 Nov 2024
 16:14:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104233251.3387719-1-wangfe@google.com> <20241105073248.GC311159@unreal>
 <CADsK2K9seSq=OYXsgrqUGHKp+YJy5cDR1vqDCVBmF3-AV3obcg@mail.gmail.com>
 <20241106121724.GB5006@unreal> <Zytx9xmqgHQ7eMPa@moon.secunet.de>
In-Reply-To: <Zytx9xmqgHQ7eMPa@moon.secunet.de>
From: Feng Wang <wangfe@google.com>
Date: Wed, 6 Nov 2024 16:14:36 -0800
Message-ID: <CADsK2K9mgZ=GSQQaNq_nBWCvGP41GQfwu2F0xUw48KWcCEaPEQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] xfrm: add SA information to the offloaded packet
To: antony.antony@secunet.com
Cc: Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org, steffen.klassert@secunet.com
Content-Type: text/plain; charset="UTF-8"

Antony brought out an important function xfrm_lookup_with_ifid(), this
function returns the next dst_entry.

The xfrm_lookup_with_ifid() function utilizes xfrm_sk_policy_lookup()
to find a matching policy based on the given if_id. The if_id checking
is handled in it.
Once the policy is found, xfrm_resolve_and_create_bundle() determines
the correct Security Association (SA) and associates it with the
destination entry (dst->xfrm).
This SA information is then passed directly to the driver. Since the
kernel has already performed the necessary if_id checks for policy,
there's no need for the driver to duplicate this effort.

