Return-Path: <netdev+bounces-222566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85041B54D50
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 14:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EB711CC65C0
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 12:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47EF732ED41;
	Fri, 12 Sep 2025 12:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fm5p63t2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74842329F2F
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 12:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757678941; cv=none; b=SkyryOLhtEe9eNyzm3J2eswbDHiEtDJPWfDsswIJ7itG4bgthxfz7omXrr/wswPYQ4eOl+M7O24MHQxKTWGBpsPDsr/Vzojbz8aZptK2i3I8NaLItTrmIeNjUeBODXmfDGK6A+jdJSUBCBpm6z8UIGMNlKTzI+91TyTicxAUqL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757678941; c=relaxed/simple;
	bh=ZsDPHM1ssWGkUCApaTOQGhUhKwRqfUFyjo5Rw+9gVd0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=GwFUgMQl7eOodaouy3iWMorR4cDdoZcZpkWt7lp2cpKODPhUYiNEGdiv6j6O5Xhl/AnVxkL6/vuHYDaVO5ieQ02x0emEgS77ZJM6ZsfUtCR5Im+0fVrbEfP4WD+v/1GezPFhMQGth/wcWQeQM294RMzMk7M/U9Ai9vw4r3WASJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fm5p63t2; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45b9814efbcso18219495e9.0
        for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 05:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757678937; x=1758283737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AuxBhXYIf5asuisWxd1fF0vikMlauZb1ySpXLM4BDYU=;
        b=Fm5p63t2PJ4ezHqOdrc9AaEaiCNRZdhPRzWPS3ZN8o90x0YV9a+ASscXHBVI4aB19+
         cwKXlD7MuvcuWBG9CW0Q4GO+3LxBbhnDkM5h6lOXJ9YUkJe9SFkHLdO/d8RYbWCIYLra
         1iJPNmq3wQfc4KI7mLUeYbODfmXfTiJ4NnqI4a0pdtISllwA4V1zHJsneiNLBUuugICl
         KSWsjZNDyBPU9EPofr8Wyll3tFROnMy7MBedLAS0LiuSV6245z0MwAz0xXdHLtT172gK
         dKeOWGdFImuvjxlCDdYwLFBzI9Ad614hY+m0RNqvbjbeqS4lxoyvp4uBIIK4BVz+WV6j
         gpMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757678937; x=1758283737;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AuxBhXYIf5asuisWxd1fF0vikMlauZb1ySpXLM4BDYU=;
        b=Lw8UxbXOsfnDYozVJY4bpR5MANNWVKQ0zaDT+RPpjVpwXjmw0uBpesseAFSIkvMPwo
         FQkid6lXLeEILzOXWCE2XATpHFDELkWHT3TVdeETnncnyJJSCrwgWp7z3tmEhvQyMA5g
         RCwHDI0HY1uYK9cV2oyQKK/ujLCpO4ag56qeSfsn/MAc6jCKfgRyl4RcXFewCGUeeTpv
         25xKQoW4xiq0fzudP1vBP/2ElcWvTHmLfsp4ukClDrgT1ZxsgbCtf4w5gZSxR2gfFONZ
         mB2HPhN3x+I3IJBHAkrz3W5t4PCDTgNRx2nHEFJC2SdCMbvebGwLMHarAAssCj8VeRLp
         boVw==
X-Forwarded-Encrypted: i=1; AJvYcCVVUTZUCOXieaZNj8OOWHKp2d6TKYABpClLpOpmUqnu3jIa6mI5vfat6vKnyXFqX0Gu3tepDYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAIGj9TjV/hIUlGbi5BoD9eJ/MN6/4IPIg+3qik4h6+H0b0vPy
	SNmRg1JTwlSQAoXCT047heJF6fBHlPY1KdK/zBgieUn4OtC/OzXp8iwJ
X-Gm-Gg: ASbGncuA1U+LSUjzaDkOszuME+dL+xdK2V/h8DmNzUqY663NrWRZZ5WyppTII/PPk1M
	x8UFBV8OpQd80sa6JAu7oobT3qJKB/sQ4hZP/kWKi8MtGfTnPosIuo7B931IsEVmB36ha6UG17F
	0Bfq4lzYI5aiAqAIi3p4g4THWknFiWxoEO8ctLR5UTzq4GQ0bbZWfC4UBU3+vtNsqaeaqpBnnuZ
	Dpg/2C7DrEOv/jwIHEB0WXkQLL/neK4SeK0t/NIzHElL/m6+IwWR0IA55TwE8xY9QP18DP1/ozz
	XJr/O2srdTsUOWpOFlFWKcreF4QFkAEBki3CKdgdCpfYuInu6/xVcgazLZuKzobkAZhQJPPXYeK
	K7c+5X4r0IW1SUNIbKSMKO9W7maDJaRBL8g==
X-Google-Smtp-Source: AGHT+IHXNEYZ8zt4iDcGj+Ej24DzoTie67SzfFJOypYfKefxWkzvz2zcFJy+fpJUKaaXWFGXQhh7ow==
X-Received: by 2002:a5d:64e6:0:b0:3d3:6525:e320 with SMTP id ffacd0b85a97d-3e765a23893mr2442300f8f.29.1757678936577;
        Fri, 12 Sep 2025 05:08:56 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:18f9:fa9:c12a:ac60])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7d369ea3bsm616186f8f.0.2025.09.12.05.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 05:08:56 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: =?utf-8?Q?Asbj=C3=B8rn?= Sloth =?utf-8?Q?T=C3=B8nnesen?=
 <ast@fiberby.net>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,  "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Simon
 Horman <horms@kernel.org>,  Jacob Keller <jacob.e.keller@intel.com>,
  Sabrina Dubroca <sd@queasysnail.net>,  wireguard@lists.zx2c4.com,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 12/13] tools: ynl: decode hex input
In-Reply-To: <20250911200508.79341-13-ast@fiberby.net>
Date: Fri, 12 Sep 2025 13:01:48 +0100
Message-ID: <m2o6rfubf7.fsf@gmail.com>
References: <20250911200508.79341-1-ast@fiberby.net>
	<20250911200508.79341-13-ast@fiberby.net>
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

> This patch adds support for decoding hex input, so
> that binary attributes can be read through --json.
>
> Example (using future wireguard.yaml):
>  $ sudo ./tools/net/ynl/pyynl/cli.py --family wireguard \
>    --do set-device --json '{"ifindex":3,
>      "private-key":"2a ae 6c 35 c9 4f cf <... to 32 bytes>"}'
>
> In order to somewhat mirror what is done in _formatted_string(),
> then for non-binary attributes attempt to convert it to an int.
>
> Signed-off-by: Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

