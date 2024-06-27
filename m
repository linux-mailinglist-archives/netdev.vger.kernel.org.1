Return-Path: <netdev+bounces-107169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82BC991A28C
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 11:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38B0D1F22064
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 09:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9435D13A259;
	Thu, 27 Jun 2024 09:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7ZKJcbv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72B1137757
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 09:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719480156; cv=none; b=sfrCmJHd4U4mX9JWVa1lPpVmtzH0xNyppav/GyfhdXazk16K9zSLNPwf0DbAH3AJ5JEvRGX7LKoIvzVaJIui8Xg8vaUBUQcy9bxZss08H5Fbgq/7g0qUfjZ2/AY0H6U0BDyywO/zUvtdb2TyYT4zEVYY7E4nbICgG+GHAS+gxaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719480156; c=relaxed/simple;
	bh=k1fV7ozA2OdL5jv0597m4P56iLOYwbExWgfVSK+pvvQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=aaZdLPmGU5JG5YBG7AWxw3kRjdLbwAMeacl5fx4ce5e6VFFvi96UlZRWquwiU61o3Vd5nwcNvD/fdJISPggwhhyeslidf8Ba3RpJeCBRgsaribffK36hTlVpno3RM2EpCuR1qNLMa78LC1toBYQxZQLP7HQuuOS5Ar0Y9+NAAAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F7ZKJcbv; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3626c29d3f0so4065509f8f.1
        for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 02:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719480153; x=1720084953; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PUsy0kuvKcuJOtOmhMNiZpynSvLvzuefuLi4AD8hzEg=;
        b=F7ZKJcbvjuIZ+rAmPIFw0OLOyKd/0SwVV9X60VVdyge1VLND0r8Txfq54JLPeP9wHQ
         fqoO35kqYJuy2ufQjLBVKeMqq4pUj2qCxoARxLOoGwsWGOPIWfBezCLcmBPWNJ1pjDgr
         K9/rnwszYvuihjXXC0kZ6AXnH8SracbnHzgA2jKBqgvdRpEUFhVTt8siHYAuuiVvJOt8
         he3jsjgObZNLo/PlpVOHFpN9UJzdNwGcv8DDDXeEvvd0joDfw8QcYKodkdVJd9qvAUPT
         V5LUud/nxH2n7dWKNKUNHWWlaU+/YSJbLq9Fq/5K7jMupzdcjeQV6txKoVurJRTuu2JI
         KkvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719480153; x=1720084953;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PUsy0kuvKcuJOtOmhMNiZpynSvLvzuefuLi4AD8hzEg=;
        b=o10PG8F9XX7tNMxsG0nAjFbO1z8+/13w1sxPGYVGZLsS1dus+UP0lvXFPgAh3PqS4L
         kbDKN1s460g6zHkbXkDGOzcqvuEEpDOrEVDL7FI4+abZaDIjzqeg0ZuBq+sPvu6aX5oZ
         RI2yw9AWmAgLzHlo68Ve4nalgtAMjPSUiu+xijxXQq7uLbHwZQy5230aEXruMrzOGLRr
         t/T9u+y1lWcCd1AkfsNaLOn5w27ldbCHrC6vAA+r4HJXiMDOHEHHO8iwKndN68xMX8Wr
         AH1KKCgc0tM0rhzVHqNDBBRCDGJ4vxWm2XvQ6ZhXbCDOsiczsZQ/PGEL8khu+epoXXkl
         cuBw==
X-Forwarded-Encrypted: i=1; AJvYcCWZlUNO5mWHyx8jQZ87IIgkexBPahcbujpZLLxvpQrQKWmeP5GysIDaQQAsDuwNJ8sbttnyyMs9OTmTcbpBFR69DxqgRnGc
X-Gm-Message-State: AOJu0YwSfQ5yu/IxuZzngcKP8AaQPywO4cIDsdzQwlklgLFEKqvifpUb
	jF6+RqgCGIxGbA6UWG5wZlcZn48cTORv+7bT8A+B4r/Hlbak5fVrNEUGSQ==
X-Google-Smtp-Source: AGHT+IGpz0+S/XwanhT9xh+T+1ApY0/tJveptdPQQHNcTOuSR0vAYH8IxPUS5Th2WeB+cFapiYmpVA==
X-Received: by 2002:a5d:448c:0:b0:364:aafb:5fd7 with SMTP id ffacd0b85a97d-366e95d2968mr8366911f8f.45.1719480153100;
        Thu, 27 Jun 2024 02:22:33 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:546e:2dab:3aba:3182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36743699b19sm1226785f8f.73.2024.06.27.02.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 02:22:32 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  jiri@resnulli.us
Subject: Re: [PATCH net-next] tools: ynl: use display hints for formatting
 of scalar attrs
In-Reply-To: <20240626201234.2572964-1-kuba@kernel.org> (Jakub Kicinski's
	message of "Wed, 26 Jun 2024 13:12:34 -0700")
Date: Thu, 27 Jun 2024 10:22:20 +0100
Message-ID: <m2jziad9kj.fsf@gmail.com>
References: <20240626201234.2572964-1-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> Use display hints for formatting scalar attrs. This is specifically
> useful for formatting IPv4 addresses carried typically as u32.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

I don't know how scalars got missed out :shrug:

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

Thanks!

> ---
> CC: donald.hunter@gmail.com
> CC: jiri@resnulli.us
> ---
>  tools/net/ynl/lib/ynl.py | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
> index 35e666928119..d42c1d605969 100644
> --- a/tools/net/ynl/lib/ynl.py
> +++ b/tools/net/ynl/lib/ynl.py
> @@ -743,6 +743,8 @@ genl_family_name_to_id = None
>                  decoded = attr.as_scalar(attr_spec['type'], attr_spec.byte_order)
>                  if 'enum' in attr_spec:
>                      decoded = self._decode_enum(decoded, attr_spec)
> +                elif attr_spec.display_hint:
> +                    decoded = self._formatted_string(decoded, attr_spec.display_hint)
>              elif attr_spec["type"] == 'indexed-array':
>                  decoded = self._decode_array_attr(attr, attr_spec)
>              elif attr_spec["type"] == 'bitfield32':

