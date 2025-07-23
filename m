Return-Path: <netdev+bounces-209280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83479B0EE32
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 11:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B6B93AD782
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 09:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC9B285CAE;
	Wed, 23 Jul 2025 09:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mi1v1D3l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DBB283C9F
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 09:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753262212; cv=none; b=LeYm4VaiBymGMV3FTUvOsB9GI5KrS798o1T1y22/EYzaCOPc4qlF0C+ocClhoRFcogN6zyIcA/mcZPBFT9G2mR1wn62ctUx4xDJJWKDd6yRo0fPDQ91/V7jdFQbYTWL+hUywGsJcexutqrFpk8GJSlyYhsMkEMod/YOPz/pSE84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753262212; c=relaxed/simple;
	bh=2QMmQf65+PWK5gkwv8LjmFzuU2vNhhdLuT3fw+fAxeU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=eCh5JOArw05NT2HW+K+bhdFTkgWm7Ha6w0VYhs/zbtr3cP28DqHepnqr/ejemeahi4UOcJiRXfsRQgBohF5xM9Wg9Ldo2PbqQYB4Ezs8do1vHzPPUhffG8GVBkYhByzVpTnLllxBCMe/UzRnQVui9wWeQvGkeIu+8CVjSNurmbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mi1v1D3l; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-451d41e1ad1so45454985e9.1
        for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 02:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753262209; x=1753867009; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5efHS5a+/j045tcIeR+kJD8kn2I1ifc4qiuFdPMBKHc=;
        b=Mi1v1D3lP25WhVaL5koSLCReSL3mhZvWGsyvQ4U60JFZGvq6A8OD/NhHIbtKpjzidI
         DeWXlb774MFATZB0hFcy5pxG+EAW6UY9cIgVjQhuzX0K/sW3yfqRZ9G9vHS7qdMLTvK/
         xWiECSNAa2qevOZHM57LdqGn9H6wiFncc+HCUtDxWe+7bZuip4RLp9ok6NBqcUxrongn
         c/Wv+13JX+Norj48c7Qw7X5uFdlB1WJ+4RK/2E+J95sDVEZNyuEPoxFDLMyqAh3zWeQA
         cgcGY5ljNnwZn91K5eLW1NPhCGYC8eMA71T4RklRcaiRPGmtrsGGuXRMzt2kN3+iKw66
         KSDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753262209; x=1753867009;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5efHS5a+/j045tcIeR+kJD8kn2I1ifc4qiuFdPMBKHc=;
        b=XLMxpUMv2WXyNM2MyoqADTVWrGp0dQxpo8xM5Kt+sucGstt63yk6x8sDRkjx3SMLHo
         xixxZctCtpm288hqd2HTp7vjIYtCAEfq9WJDDBMYEzspDCPKYD9Vld2yTSnbHDKVXnEk
         bbhJYeouxv6PZAnDfFjpNYBmHjP0XH0OrAnq9amhl/W3GnFseGLWlBh0fU8r5jdpYoRF
         Rx9T0XZEZ4Aa+vqvqAK9pxJ5ski26YKmM+xE6oPCmtsyEYuHdpitBMD5PWv6sSMHOVGg
         FlSYdoATdcdeJj7LHZWnWvOmQ168fOAnekFhItVHyfoUV2e5970oSUxhx1x21YdBAuxu
         Ky6A==
X-Forwarded-Encrypted: i=1; AJvYcCXCZdPUr1LbvPLBDNaokFQI0FuwTD1TLcocpfN6iwbXhkNwQby3l8ha7rlE2HiUhJ9ploHHCLY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYRnfYVnbfzQhWtSlUVvkAJLwP0IRkXq6VsslNkjVNp+4MV+el
	8cEgTuFnWXfFif3gY2wVmsqeBORQ2r9Cn68lXM0PH7uA2nmsaMm8vDvBQBze4A==
X-Gm-Gg: ASbGncvCQMfa85c9m5BWUi2BbaWyhHL48S9kJwjUE4avYwafEBUnHal/PATC7w4C6+8
	Q06HqG5IIIW9AuVYFHZSioxSxLngArszulOwfWNFevPoZriAl3RKx6mH4wBmTwPbycmH7AEPlHX
	LVRuUwpLkKA+g+tT+nfT9UPw7UIedCln3DEes34eJKr9jO7tHwyQurcily+6Tw/vErpbfJLu16A
	q4E/ZW+AklCmyx9OJItF96suPTYWv2oCbls+iu8dITEIt1jc3X9x7mVFPYLDqqMxHduC7KQNgko
	BhQlTuXMUGBfDSPefFugn9KSelhvyp7sL3T+1N+qzt086LQuIw61QgFAp7hOxt4Jc9tTojHA+Ma
	YPhtmdWN/knMXcBHaBFxuRVFZqLUbX9yAvg==
X-Google-Smtp-Source: AGHT+IFaG+HglliG4VCPIZT8OVwT2HhOcjygmy/kKNfACLlU1kwYZrZlCtPtSOSOnEY/F93Y+u/7Xw==
X-Received: by 2002:a5d:5887:0:b0:3a5:8cdd:c174 with SMTP id ffacd0b85a97d-3b768e9f1c3mr1906876f8f.26.1753262208910;
        Wed, 23 Jul 2025 02:16:48 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:b8c1:6477:3a30:7fe])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca5c632sm15933250f8f.80.2025.07.23.02.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 02:16:48 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  almasrymina@google.com,  sdf@fomichev.me
Subject: Re: [PATCH net-next 3/5] tools: ynl-gen: print alloc helper for
 multi-val attrs
In-Reply-To: <20250722161927.3489203-4-kuba@kernel.org>
Date: Wed, 23 Jul 2025 10:07:11 +0100
Message-ID: <m2ldof9sxs.fsf@gmail.com>
References: <20250722161927.3489203-1-kuba@kernel.org>
	<20250722161927.3489203-4-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> In general YNL provides allocation and free helpers for types.
> For pure nested structs which are used as multi-attr (and therefore
> have to be allocated dynamically) we already print a free helper
> as it's needed by free of the containing struct.
>
> Add printing of the alloc helper for consistency. The helper
> takes the number of entries to allocate as an argument, e.g.:
>
>   static inline struct netdev_queue_id *netdev_queue_id_alloc(unsigned int n)
>   {
> 	return calloc(n, sizeof(struct netdev_queue_id));
>   }
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/net/ynl/pyynl/ynl_gen_c.py | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
> index dc78542e6c88..0394b786aa93 100755
> --- a/tools/net/ynl/pyynl/ynl_gen_c.py
> +++ b/tools/net/ynl/pyynl/ynl_gen_c.py
> @@ -2472,11 +2472,22 @@ _C_KW = {
>      return 'obj'
>  
>  
> -def print_alloc_wrapper(ri, direction):
> +def print_alloc_wrapper(ri, direction, struct=None):
>      name = op_prefix(ri, direction)
> -    ri.cw.write_func_prot(f'static inline struct {name} *', f"{name}_alloc", [f"void"])
> +    struct_name = name
> +    if ri.type_name_conflict:
> +        struct_name += '_'
> +
> +    arg = ["void"]

Minor nit: maybe should be args since it is a list, or change it to
arg = "void" and listify in the write_func_prot() call.

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

> +    cnt = "1"
> +    if struct and struct.in_multi_val:
> +        arg = ["unsigned int n"]
> +        cnt = "n"
> +
> +    ri.cw.write_func_prot(f'static inline struct {struct_name} *',
> +                          f"{name}_alloc", arg)
>      ri.cw.block_start()
> -    ri.cw.p(f'return calloc(1, sizeof(struct {name}));')
> +    ri.cw.p(f'return calloc({cnt}, sizeof(struct {struct_name}));')
>      ri.cw.block_end()
>  
>  
> @@ -2547,6 +2558,8 @@ _C_KW = {
>      _print_type(ri, "", struct)
>  
>      if struct.request and struct.in_multi_val:
> +        print_alloc_wrapper(ri, "", struct)
> +        ri.cw.nl()
>          free_rsp_nested_prototype(ri)
>          ri.cw.nl()

