Return-Path: <netdev+bounces-183211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FCCA8B696
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 12:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42C233AAA4E
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 10:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52454238143;
	Wed, 16 Apr 2025 10:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tl7xdVnN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874A6245010
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 10:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744798685; cv=none; b=Vpcb/4CXCXe1pv02NvNx89S1QKfW5HYZrrl/W4FnuIzle0nL+z8JfBjqWi51GP4ZGxZ/MR3NhCi6J2vF5LyTb9xqxjlqCmFBIKHhD4q/Fy66x0U2KpUV8vDyjh2EMt8IV8mPb/gcFnOlOcRGOH2wC0A/2SUmB9qOuVfmWoaGOGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744798685; c=relaxed/simple;
	bh=+ODNfuxz5xcGA82sIZ2Mc3KYEAzYFjn6NkpJXRFPtJg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=vBd2uXnot6CdU6Vd0W+YJwbsa+3oZjp7RG1E98xWfYwdurjNJa+GE7nVrINY5HKviOcVpM3BoxrXyouYgo/TM7H7v5CedMQ7GBw7ejHNJS7TZX6jOfLUsCaCSYqDZChqkUQIwlt+QGLUEpXbV9S49ryUpSH611yQB9EZnR08sOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tl7xdVnN; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac28e66c0e1so982166966b.0
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 03:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744798681; x=1745403481; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L1c6ACKPrwguNsPGQ0EGoKoy7oniGj+K8vb4FoBoV2g=;
        b=Tl7xdVnNGPwIjMsgyzTOdtDWbDlF0WF5z1H6Oy2TYiNc4KeYao2OkTQaglAxwNrPgY
         v/CsEZzYQIjS/+Rfz/lY6bNgtKDmwOTgSV8Gdw3gURoWqO8yQb6GWMcQhTldLwiADpFj
         nBca/pv1WGBpE/nVBCPhlWngpChyAD/9iP8JbsKyzJweGUcLVxdv0xswxxoiyf/ys47O
         trI9n083m0eB51wMLh7bYGHrCyHEaNdYYf/HlPO2djiVeufnUuN3CZ8PuzDUU3RKLAh0
         eHvNaEWSwEtRv7drzJUUlBpR//JPN/lcWHCMwXZEhgqJMmEQy/K3MWx23oSY1lab6XX+
         HcmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744798681; x=1745403481;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L1c6ACKPrwguNsPGQ0EGoKoy7oniGj+K8vb4FoBoV2g=;
        b=rkJqobk9ZJHcGh1pQrDkmPVQ7pkCisvTWgqv5t8FhifkzqTLtdi/Vh8yoWLGX8mRQm
         XVLn/0c6tOlPB3kRmo7Nvl1A46WB3H80tmovkd24ZJbacpJ/8a+651ceG0GkQ/bO5Dxt
         Hg2GtxFcYpMck6CIvTnkUEaxfezraoQ8SnEPgElSphxZv/0ztgjpLtJrwKhqjaExtmo7
         clBpS6RAEh/JouG9tb5t78z4cwD+e4LjqCGGdHxFkdbAVkqmJ7J1FhN5RLM+n0EXF/HK
         nQ6oG2F++ICcKt9yeNXEi9cCcdmHFe0SzqujsioW4aWbCtYbgwofpdgA2iGOFR/ERYN1
         Nolg==
X-Forwarded-Encrypted: i=1; AJvYcCWlbmdD/mUHtifcEwWC+LzRvFyNoKmhfU+KDrA/h13SdTdY4zc5nF5698uE+K6f5AGG6lkE/8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGx3yJiVUlQ+YL4fAQUF0jnPb2U2nGALCkJEEdnUPkp1e7ozRp
	Lzn6stCITgkxriV+CKZB8aOnHZiMknCw85CtanVTdgsLd1GV9jbd
X-Gm-Gg: ASbGncvz3cxFkRn9T1cf7wv6YdbINqafm8+6E3ymWUH7Aabnwm3Js4e1a1osEjmfqMi
	EQ4Hb2LrGRa47B/aocCRPZsFnOrsmdysdOHAgZ23kPtKoRPaeoTWwOO/2s4+4WypKWCcnK53Hxg
	qVs4SWlvOqVgEp9zqyprLaLaixQ9ali/plbgIzMAiqiK57SFgrGuZjE3PAO1IKaoinanHpErn1W
	Rd6XMDnlb+b3w6plWHg4vkMS2hwrZoRtFOEYYicRyUIjXYP9JMhMeHOD3RDsDf6RXDtIp+a6CG4
	Hg/0nB9f1gbeIS1U7pmdyCMmn5zFaeLJ8npopNnwk964Jm+Xi/RI8Bx0bA==
X-Google-Smtp-Source: AGHT+IGOATtIqGsDcZzvNwQXXvc1js9KYxnhvkmlYpa7eSwrHrDlQY5iYD/4pSzcfR/EjiUhMKiMgw==
X-Received: by 2002:a17:907:60cc:b0:ac3:48e4:f8bb with SMTP id a640c23a62f3a-acb42b6ba85mr98715666b.41.1744798681196;
        Wed, 16 Apr 2025 03:18:01 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:e94a:d61b:162d:e77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb3cd6351dsm99361566b.21.2025.04.16.03.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 03:18:00 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  daniel@iogearbox.net,  sdf@fomichev.me,  jacob.e.keller@intel.com
Subject: Re: [PATCH net 1/8] tools: ynl-gen: don't declare loop iterator in
 place
In-Reply-To: <20250414211851.602096-2-kuba@kernel.org> (Jakub Kicinski's
	message of "Mon, 14 Apr 2025 14:18:44 -0700")
Date: Wed, 16 Apr 2025 11:06:39 +0100
Message-ID: <m234e8mndc.fsf@gmail.com>
References: <20250414211851.602096-1-kuba@kernel.org>
	<20250414211851.602096-2-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> The codegen tries to follow the "old" C style and declare loop
> iterators at the start of the block / function. Only nested
> request handling breaks this style, so adjust it.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/net/ynl/pyynl/ynl_gen_c.py | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
>
> diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
> index a1427c537030..305f5696bc4f 100755
> --- a/tools/net/ynl/pyynl/ynl_gen_c.py
> +++ b/tools/net/ynl/pyynl/ynl_gen_c.py
> @@ -654,10 +654,10 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
>      def attr_put(self, ri, var):
>          if self.attr['type'] in scalars:
>              put_type = self.type
> -            ri.cw.p(f"for (unsigned int i = 0; i < {var}->n_{self.c_name}; i++)")
> +            ri.cw.p(f"for (i = 0; i < {var}->n_{self.c_name}; i++)")
>              ri.cw.p(f"ynl_attr_put_{put_type}(nlh, {self.enum_name}, {var}->{self.c_name}[i]);")
>          elif 'type' not in self.attr or self.attr['type'] == 'nest':
> -            ri.cw.p(f"for (unsigned int i = 0; i < {var}->n_{self.c_name}; i++)")
> +            ri.cw.p(f"for (i = 0; i < {var}->n_{self.c_name}; i++)")
>              self._attr_put_line(ri, var, f"{self.nested_render_name}_put(nlh, " +
>                                  f"{self.enum_name}, &{var}->{self.c_name}[i])")
>          else:
> @@ -1644,11 +1644,23 @@ _C_KW = {
>  
>  
>  def put_req_nested(ri, struct):
> +    local_vars = []
> +    init_lines = []
> +
> +    local_vars.append('struct nlattr *nest;')
> +    init_lines.append("nest = ynl_attr_nest_start(nlh, attr_type);")

Minor nit: the series uses += ['...'] elsewhere, is it worth being
consistent?

Either way,
Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

