Return-Path: <netdev+bounces-207093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 692C3B05ABB
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 15:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C105E1AA6246
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 13:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFF31F0E26;
	Tue, 15 Jul 2025 13:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sbo9ettj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114182566
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 13:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752584551; cv=none; b=RiZDaZyyyS9qUei2F9yIR2msf37HchxQeUGLhyW4rjtysloDlOBUWNxBSOdUymFFWfXzZLSo3khUSTGn5uXPn/eofih6k0aAyjbVK9dwOJtQVjI3RvjlxMVc1/oleWEWLzeFbTlgfJ4/I85M+YS7ObUk1/3Bzqr/5z/+mNhLZSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752584551; c=relaxed/simple;
	bh=6qfx1AFvVvUSMbmXqpWZAUM1XcuqC/9zxs9mjQcS4EU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iHf3iyNRNDHtYgbYh5AFRwtgrowMhv7VBM5YYaEFL4pxNBPj0CYnguRF/7KfbTksu4Bdt3VMyPykUpuAcj3v41mXCr9CdSUAC92DM4ZztDjRUSvKcGyUfd2+iz4fILFTCL7o1YmjhfevaOecsOmsu282ymCeVaKLyfaVWwsTZtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sbo9ettj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752584549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p7tWYD4tx+fg2lnHVa/1g7HWDf3N37jy+j/78STt+1w=;
	b=Sbo9ettjMNmNXmQnTZVc/leuYjNxH/rzxUSaThJ4HL8ryvyi4WhH6LGd36PHVNVw4dJvxF
	kGGPEDWDths/AabGbNjaWhevYorUvF7/2Sk58+vmD9y7I6/+xrkky67QDdjbSCInqxEEoF
	7ZDpx1AKuKQHbQgN3/zNVW6KCLSVH4o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-xpdEkpdGNAufPTLrAD66Dg-1; Tue, 15 Jul 2025 09:02:27 -0400
X-MC-Unique: xpdEkpdGNAufPTLrAD66Dg-1
X-Mimecast-MFC-AGG-ID: xpdEkpdGNAufPTLrAD66Dg_1752584546
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-455ea9cb0beso31867605e9.0
        for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 06:02:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752584546; x=1753189346;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p7tWYD4tx+fg2lnHVa/1g7HWDf3N37jy+j/78STt+1w=;
        b=tIOQhL7g0kGvFfL9p69FVnQ9dUZ0ZJUAW3H5Ba2jsrRnfxo6ObV183pH+X16kL8D4s
         DbZbiRR820Xr3c1kyfq3u8xpbMhwu5DgGtEfggUvWBdse4EUSImeJHJvFOxff65CPtw1
         lP4MMPC0m2C67wRuOgbDhdYLJT0om4hL4wcuqkMVZ7hyZVplBE8AzjTgeIX5WDayjorH
         Im5pyXftq98lf/Ls1CLNYRNg/Zs8GVXdm4ykZ2aHEXwAScmL2f2qpHcsy19jGxh9cYXc
         SJTnIAbZYg+EhWohZGglEeBeyJKrA3viYB2bS2ZZi4ZnslZFH/T4Kb/q5H+A1RhHSVq3
         qxsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVSwrTaJvbn5o6Y+T4+W4xzAwL4Yrbk+bIM7gOAQPnmgn7BRmcbNdxMuxP26i9q8Ha4YZKoFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN/8zclHJq9A0IJm7gt8K8fdHptmxQ2e6VfTRB2gp2v5814n2d
	GaZqqbxzzI/cfaNJgrs7KZs7SEAbGDHnhGm5FSU88KwIx9Iraq17LfNkd4DBTNwb0cM6/vL+cR/
	q2Lib9ppu+46TfEcGqZEOl1OwCXbYXqbKfZJTmD2lPk0LByMEsx0REOu/bA==
X-Gm-Gg: ASbGncvsL2+DnMUKgLJlWypCqocLhrCDXJkymTZurldxvpDWXVLGmRGTA2yUHnji2+k
	jq70HsXX/z3ZZQtxyKe4EdpZaRZrfBuCnrI/SL784j9uMn8I8vG8Q06t3YryGzVcLFCRUl5cf1h
	nB39SQlrby8gVhkbPOP/PuoDUvTJzIHLKxrkKdY+/5+4on1a1jMWHfD3fuuGIpAp8Comwqc2IUU
	u3ch2hUXj5K0ScITEJCJQ6Wi6Lb5w30VBc9n8LvadGI5aaZSHx4FuL1hsT0nxdylVYbrjmiFjBl
	pOEoRXIbivw0a4GvuRxNrum2tD1i4ofbBaR+vEambGNQPfsH6v2yPmUXQYeyKQwUwH7hE8R+xtq
	7j8iAF0GYpog=
X-Received: by 2002:a05:600c:a08:b0:43c:f8fe:dd82 with SMTP id 5b1f17b1804b1-454f4255c7amr153327755e9.18.1752584545995;
        Tue, 15 Jul 2025 06:02:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQmEKYWF5RFQOcNA8dAn6VORUEh2xGxKp+QojOuV5+23NJaOdrjj/10cvaoZSjormmd2ur7A==
X-Received: by 2002:a05:600c:a08:b0:43c:f8fe:dd82 with SMTP id 5b1f17b1804b1-454f4255c7amr153325695e9.18.1752584543813;
        Tue, 15 Jul 2025 06:02:23 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562b18f8absm5076125e9.36.2025.07.15.06.02.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 06:02:22 -0700 (PDT)
Message-ID: <e6801550-fb58-4a94-9405-b14e13c0e936@redhat.com>
Date: Tue, 15 Jul 2025 15:02:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/5] dpll: zl3073x: Implement phase offset
 monitor feature
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Prathosh Satish <Prathosh.Satish@microchip.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
 Michal Schmidt <mschmidt@redhat.com>, Petr Oros <poros@redhat.com>
References: <20250710153848.928531-1-ivecera@redhat.com>
 <20250710153848.928531-4-ivecera@redhat.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250710153848.928531-4-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/10/25 5:38 PM, Ivan Vecera wrote:
> @@ -536,8 +539,38 @@ zl3073x_dpll_input_pin_phase_offset_get(const struct dpll_pin *dpll_pin,
>  		return 0;
>  	}
>  
> -	/* Report the latest measured phase offset for the connected ref */
> -	*phase_offset = pin->phase_offset * DPLL_PHASE_OFFSET_DIVIDER;
> +	ref_phase = pin->phase_offset;
> +
> +	/* The DPLL being locked to a higher freq than the current ref
> +	 * the phase offset is modded to the period of the signal
> +	 * the dpll is locked to.
> +	 */
> +	if (ZL3073X_DPLL_REF_IS_VALID(conn_ref) && conn_ref != ref) {
> +		u32 conn_freq, ref_freq;
> +
> +		/* Get frequency of connected ref */
> +		rc = zl3073x_dpll_input_ref_frequency_get(zldpll, conn_ref,
> +							  &conn_freq);
> +		if (rc)
> +			return rc;
> +
> +		/* Get frequency of given ref */
> +		rc = zl3073x_dpll_input_ref_frequency_get(zldpll, ref,
> +							  &ref_freq);
> +		if (rc)
> +			return rc;
> +
> +		if (conn_freq > ref_freq) {
> +			s64 conn_period;
> +			int div_factor;
> +
> +			conn_period = div_s64(PSEC_PER_SEC, conn_freq);
> +			div_factor = div64_s64(ref_phase, conn_period);
> +			ref_phase -= conn_period * div_factor;

It's not obvious to me that the above div64_s64() will yield a 32b value
for every possible arguments/configuration. Possibly a comment would
help (or just use s64 for div_factor).

/P


