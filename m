Return-Path: <netdev+bounces-73778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2572C85E551
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 19:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EEBEB23090
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 18:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEDC88526A;
	Wed, 21 Feb 2024 18:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXMCKTOC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CE185624
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 18:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708539168; cv=none; b=kQIBIa3ChOPA8bhngGI2wtpEKyxKLD8ANxpJw75YZ1vyYboyXkxflBFeNJqCzRtn8U5it2sYgsbgDYaXwp0QzZGBSEHHReiMvkzsTIrRmJ8CTqyTt0VOnrr1QL1KqIJEyWNy7ZYIsDN3eCKVM6Ldkw6VR/swC5vA0EJu6Tzqu6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708539168; c=relaxed/simple;
	bh=VPCdnsAHajkHlAMrWSElv0cUXPvvQLoaw3tdrULCNF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S5R8KlN01LmXcAWsYXdT1Ve4d14vr+KsQt6fWFY1z/psKsZz+Afb0KwRweQs6M7QYY1URkC52ZkgmLBU0lAkv3I+SOHoZBGHIYd+VBuEFj6mT4AOpZ+YY7cani/eS1dbNuPJieuQzSrXgD2I4p8s63ImldKVymttWHEQQnC9F0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KXMCKTOC; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-21edca2a89dso1908201fac.3
        for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 10:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708539166; x=1709143966; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uTY/+91mQ0xlitmvktdv3wR7Rl1gcL+CJrBW6B6qj1k=;
        b=KXMCKTOCKFnamCkHcFYt+7h5nHv75YDQHQ9TzqGb6rOxZZlhN9TY3RrKr3lmcZaE45
         C7fpDVtqFUsVj1rYUk+s5x41Odg3cVbFAKMsvN29VwzxlTkgBkKJvY0AKZRebr0TOjmN
         3Go/TKsMRblOkCTYDoGMVlWGqVgPkCF04BGV/9WTlUenwazQYDe+rE0yTv/wfgau1bIa
         QvLKmeWAUe9nbdBWy5NsfPL1iwZF73lIA9IsJOzKg2Ee6IumgQKuudgRUu/BIeyMAtvh
         CvmcidQWSVTzJb+oKsOVEh/qY5aGfBniRgBE5rEhHpD4f9Qn/HbeuB48ZDNi05Go9jgS
         VxcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708539166; x=1709143966;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uTY/+91mQ0xlitmvktdv3wR7Rl1gcL+CJrBW6B6qj1k=;
        b=ce64U6xV5uTG5NuUsyWDV/pNrdlHwxwqrHRD5JaN132JtbzIy50OFgR6H02TqOP2Gp
         f6eajXygFHPM0WaGu7nbrLDKhmPpRFPxBVpcYSpsnEqMSJwvX8eGka7yZcGEHVr1mDHI
         HHJJtpzZALTRn+A/++LsEUiUHgxHDQmu46oR1xei0FaOAFb+SOuQwNm3PszHhiWhnJOP
         zWoT8wvlIh+5yCofl7v5qKbSax09Pk/YF4O1mMFYpv77Z+7OIMaBy+SvOeccgEcVPkG+
         XZ9sybdT6E/EQ0Av1RMczG2fbLAIE3xeRxGequTO3+URcwAVAB8tZuHvTROGFoRstD0G
         Zczg==
X-Gm-Message-State: AOJu0YynlNWQ0PuMQsS1f1LUCQyQ2fcHUqBTdykCieeG0Ce1iEgfP1bU
	KvCGAM7hR/qkJcAZMGuRCG1wZdNzklxsNipAX3g2VECE5EXT3GZ+8nf/pjCi+TPX9ZOMmgmGiYn
	qr8Dm+ZZXwEvLoxXO3OR1TIc9H/g=
X-Google-Smtp-Source: AGHT+IGwm2K7n1iJy8Lsz157a2mSZju+TYL6gfRMbvSXtRNFQwjvOKJ9gu+rUZg24zr9iJLuHJa2OpYq3+L6MqiKQkY=
X-Received: by 2002:a05:6870:f6a1:b0:21e:e949:22c3 with SMTP id
 el33-20020a056870f6a100b0021ee94922c3mr9423682oab.48.1708539166374; Wed, 21
 Feb 2024 10:12:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221155415.158174-1-jiri@resnulli.us> <20240221155415.158174-3-jiri@resnulli.us>
In-Reply-To: <20240221155415.158174-3-jiri@resnulli.us>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Wed, 21 Feb 2024 18:12:35 +0000
Message-ID: <CAD4GDZyfpU427kmj4YrW8KAr0HWOb=yqt6k6c-esX9q-VAv0CQ@mail.gmail.com>
Subject: Re: [patch net-next v2 2/3] tools: ynl: process all scalar types
 encoding in single elif statement
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, edumazet@google.com, jacob.e.keller@intel.com, 
	swarupkotikalapudi@gmail.com, sdf@google.com, lorenzo@kernel.org, 
	alessandromarcolini99@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Feb 2024 at 15:54, Jiri Pirko <jiri@resnulli.us> wrote:
>
> From: Jiri Pirko <jiri@nvidia.com>
>
> As a preparation to handle enums for scalar values, unify the processing
> of all scalar types in a single elif statement.

LGTM.

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> ---
>  tools/net/ynl/lib/ynl.py | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
> index 4a44840bab68..38244aff1ec7 100644
> --- a/tools/net/ynl/lib/ynl.py
> +++ b/tools/net/ynl/lib/ynl.py
> @@ -473,14 +473,14 @@ class YnlFamily(SpecFamily):
>                  attr_payload = self._encode_struct(attr.struct_name, value)
>              else:
>                  raise Exception(f'Unknown type for binary attribute, value: {value}')
> -        elif attr.is_auto_scalar:
> +        elif attr['type'] in NlAttr.type_formats or attr.is_auto_scalar:
>              scalar = int(value)
> -            real_type = attr["type"][0] + ('32' if scalar.bit_length() <= 32 else '64')
> -            format = NlAttr.get_format(real_type, attr.byte_order)
> -            attr_payload = format.pack(int(value))
> -        elif attr['type'] in NlAttr.type_formats:
> -            format = NlAttr.get_format(attr['type'], attr.byte_order)
> -            attr_payload = format.pack(int(value))
> +            if attr.is_auto_scalar:
> +                attr_type = attr["type"][0] + ('32' if scalar.bit_length() <= 32 else '64')
> +            else:
> +                attr_type = attr["type"]
> +            format = NlAttr.get_format(attr_type, attr.byte_order)
> +            attr_payload = format.pack(scalar)
>          elif attr['type'] in "bitfield32":
>              attr_payload = struct.pack("II", int(value["value"]), int(value["selector"]))
>          elif attr['type'] == 'sub-message':
> --
> 2.43.2
>

