Return-Path: <netdev+bounces-149654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 178729E6A88
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 10:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD23728A9A3
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 09:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB4C1E1041;
	Fri,  6 Dec 2024 09:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="vK0wUyZ/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAD01D9A48
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 09:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733477993; cv=none; b=LTceK7swebtP2EknwaImB2ql4heU95iqSMq8VyAOCAHjePiUaJ7C2NOhxB3+GTQqh2PriWPhB5NZ19jXerOVF0YmZreVDdiQ8A3FzD4H0bKM19IR0xnial8946a19DGmhLBDXyulBrn+s78pUuZB0+pDWH2cwOX4MTlRBqOTd4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733477993; c=relaxed/simple;
	bh=+nF+ddI27wsvWRc/RZMAK+gRvlrIJ5aPg99C7hPHGlw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SiZdBbpfitYcGedsDJSbu7rosAew4XPsbbqTUb44einmGMirWe1YmXpBlbpukAL+O2aKz/LZ5LmJAfF9xLMn1BWkStmZOAJK/hM7yWIKCj4XMDT85TgeRP35s6mXjzoQvmfcMbRAHEtCr2ov/wBm/3YkxC/Q6zfpNLajyLFcxW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=vK0wUyZ/; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9a977d6cc7so261590866b.3
        for <netdev@vger.kernel.org>; Fri, 06 Dec 2024 01:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1733477990; x=1734082790; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TP8vt0H2BIBBDentaDBje1xAF+qF4EfyJq9k0HN1xtM=;
        b=vK0wUyZ/wvVQm7611UbMWUz5pdc23e+Gt/XjPkdtOhTre+JgCvA7CQXfXTfGwWNdFN
         aFQ8V8hEhVLWyqpMMpwCTdcPI/TdvEq1nkq+YxZzrV1mzx4x1TTzOToaFaRhiBX8vFqI
         yKWjuhsbEcWlutAp7XzMgH4x0luil01Zy260bi1SKAQXfleUjtw9Jr/jzE85Btm9DlfA
         e1RLL06livgS34TFBYGrGAggET7Ue98F5lhUS4FIm2v0uYPfch1WHoeMndLpxsWx0EY1
         4l3vYpvI9ZHRkfgE1tkMdonJ3R/uA/I2HSkvGcr1Nw+CvcSsqYDDLO/dbNsm/ft2WRTu
         bVag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733477990; x=1734082790;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TP8vt0H2BIBBDentaDBje1xAF+qF4EfyJq9k0HN1xtM=;
        b=pjEnQGeOhzlju0lGwt+4LQyS7nxtRAY8VDeRuCDDCAF5r78+ISn32ihqMZ0KkKH/tB
         u5MDCI2nKXLF5GdYKR5cdM4d+i5Dap0M6ZHftxI8jIntm92R/ZGl66jQvYyvBNGMiqzy
         JUXKzig2t8ihtkF5PrIDe/R7cvLOoIpNpEbzzDUP65IuJ6t++DM9+QWvGotTpuGwBpX1
         uIcAaY5Z8K4hpnMzDcegwnYnxWy6JmxUaOb/nhH0hhHhYVlp4Efp/xJovN4WOsXFhDf6
         S1T8vr6biK7sWdu9Gk3lJrURsURSWRgplCH0i1axEKjicZWyW0Gmf4nprNcydVxtrHnk
         cEsA==
X-Forwarded-Encrypted: i=1; AJvYcCViSctnVLjJWdcM/kRKy6WisLeoxCfBefCh0Hqg+7mXOuT8IaNMlWUjBrmSiuOfsJsfHQ9xPGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUZefDTHwKTNHir5sPtrWP6qZBoYoVN/GZnUW/suPLgybRpUHr
	TrGNM7x7L0pTDmMCEdrFB+x9qawG8bntmpgZI4ceL3Zwktx1UoYJ8cYX5du26PU=
X-Gm-Gg: ASbGncu4mba/hJcxbwy+PG/4Ch7GBqLTXbPuTGsT/Uey7D+YaYXdLhYe4YafV6ktO4t
	HuENgCa7GT3qYIPUfyj7d91dDOxTQkyZQzZyjBDbtZILHBjoL4ZYtIoGuSVbyJ/hI1DCgjvYqpK
	52U280phTMXB9Y5p8noYTxQaW+lh18bMjD0qD6UMge0k3ZUAjrK9rDB5HBPuTYdXb9TkRqjgT4K
	VatzTXSRu9O59D4snJP3dpDsT6AqGAGCdhxCgR+iEEquwCVUacn
X-Google-Smtp-Source: AGHT+IHii2azJORUf+Rm8xI4LLlRFhSYCwn4Z8v3l/nCtdfYysAQ7queGR22iakP71u6fxIAm8wPPw==
X-Received: by 2002:a05:6402:280f:b0:5d0:ed92:cdf6 with SMTP id 4fb4d7f45d1cf-5d3be6b8145mr4493041a12.19.1733477990046;
        Fri, 06 Dec 2024 01:39:50 -0800 (PST)
Received: from [192.168.0.123] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625e4dbfesm212796466b.6.2024.12.06.01.39.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 01:39:49 -0800 (PST)
Message-ID: <154148cf-459b-4723-8dad-d73536611557@blackwall.org>
Date: Fri, 6 Dec 2024 11:39:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 03/11] vxlan: vxlan_rcv() callees: Drop the
 unparsed argument
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 mlxsw@nvidia.com, Menglong Dong <menglong8.dong@gmail.com>,
 Guillaume Nault <gnault@redhat.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Breno Leitao <leitao@debian.org>
References: <cover.1733412063.git.petrm@nvidia.com>
 <5ea651f4e06485ba1a84a8eb556a457c39f0dfd4.1733412063.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <5ea651f4e06485ba1a84a8eb556a457c39f0dfd4.1733412063.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/5/24 17:40, Petr Machata wrote:
> The functions vxlan_remcsum() and vxlan_parse_gbp_hdr() take both the SKB
> and the unparsed VXLAN header. Now that unparsed adjustment is handled
> directly by vxlan_rcv(), drop this argument, and have the function derive
> it from the SKB on its own.
> 
> vxlan_parse_gpe_proto() does not take SKB, so keep the header parameter.
> However const it so that it's clear that the intention is that it does not
> get changed.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> ---
> 
> Notes:
> CC: Menglong Dong <menglong8.dong@gmail.com>
> CC: Guillaume Nault <gnault@redhat.com>
> CC: Alexander Lobakin <aleksander.lobakin@intel.com>
> CC: Breno Leitao <leitao@debian.org>
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


