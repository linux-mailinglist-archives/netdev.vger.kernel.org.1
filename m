Return-Path: <netdev+bounces-217810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD392B39E22
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 15:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87F821BA416C
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 13:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B220B30FC3C;
	Thu, 28 Aug 2025 13:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CAA30fFK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07C130F55F
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 13:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756386347; cv=none; b=mLVsq9vHPJTT1a/s88zqrYwaL4lJlM5qcPFD4fJdAXegD7FE/6gVp0k0ctUK+NUkllmL3wHmdSnJwpncam6Gl4y6HBnNBl9PN8ZmbQeEoMXVQzLHUXd90jk1/LB6AXqA0u7dnW6IVDXqSFeNv4DEa2l0vJtxPVfr5pHgrUiiDzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756386347; c=relaxed/simple;
	bh=YV9zhY5PD8lGNt7FDHGMzwZAytTSWukyRNYOhlAOAMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PQ7s72Uaam6XtED6cOqkifSvbysTba3NEDD1BCQIHS76guaEEvEpWF8IYvIbbb/X/7R/tnUj3cDkXSxi2RzGsNRe/LppVKPgAtXMcj1GHe+MySVE/fFwWEAtYcIuCM4m7Osp39tRhrgRBp9RWlV7H73Y3VtwXphJ1BBcPPbtK/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CAA30fFK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756386344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=861GkdmB+NIwMtr2UAi3S0IDUthi2cqLKfhuV8qX7c0=;
	b=CAA30fFKo9bPGc562L06SMT7rpExg+Ta/KAbdHIXpOG+Mlg/g1HLwaf3HXlnr4Bftmk1jq
	luhcmLeH/ABOUJEj3UACuf3G1ovI/txB0zxS69gt4wAqGuR2LP4hKzhB6VTKeAolJlyXsZ
	pv0tZygD1Sur5pvEvHbv/3PtiUR1VmQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-qox0GSOsM3q_ODv3Zmytdg-1; Thu, 28 Aug 2025 09:05:42 -0400
X-MC-Unique: qox0GSOsM3q_ODv3Zmytdg-1
X-Mimecast-MFC-AGG-ID: qox0GSOsM3q_ODv3Zmytdg_1756386341
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45b7c4c738cso2284655e9.0
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 06:05:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756386341; x=1756991141;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=861GkdmB+NIwMtr2UAi3S0IDUthi2cqLKfhuV8qX7c0=;
        b=eu1miTGZ6RqBSIvRE07W4YwOa9EwfOorlpBpj662LefrLQQQa2PcHR1Ys9ks7vUm81
         em6FidhCNGA0B3Bq93X2fjp0gtLl8rd6w6RD6lWnJ7pMc8tucoyGzwPLXWSdGyAJQBJb
         4bkZESgKEMAaB8labuwdfb49lCC/0EDv0mT2+uxC/NMM06x0ugYe4ZZyUg5+naASdcdN
         OfRkWT/aofmPuFcUPlJ2s7Naqm6rkTG8B/+jx5U6/X2aRKw+DuCNdSIQCH1a6P0brTlf
         Q9U6LdyenU8eBr7+sLnB/TDNBLOWEKmlTHOXPnNap9ag6s8oR7npuQFXoe+y5mUTJ7yv
         lSiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhJVVaKh9cvgclRwGssEzwqdrPgfihRTySA1eDDsWGld3Jlua7TIOiQWDH6BdPdb9R9ydJnI0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+xbTsZZBS8vqHImwzfUi7Dcyn9RywU5QF/aphwR+whxNeExF2
	OlkaK5L7Hfas6kui5i0iE0hMTBu6q/g1jQbIifOOA093hqPhH2lgM2Ir1P1sA9u+8rVYBhrr/++
	78b3PqIC5bb65JvheytSAHAruxoWI2qHqZWTwd4wmNzy/uOVthBzhA5UYKw==
X-Gm-Gg: ASbGnct+4snQ4MexJ8pMtfEBKlKgzx2IEPAassw6VP0G4o2KaDmF0AHTMHrtEu1Tds8
	kjeHzWGPeJu8huErpPxn3W3HYaztY8yZHb7KY9Nmu/YwUpLVW+M6Dt63tSMlOQMFZPSEE/Y2tRi
	EjeHtPCCD2uRkI8tx5D1z48W1liOyQz0MRL+Y0RzzfLycRAhGJOK0jXaUVhmy4TFzLlecXmm9zd
	Nj+CwoqcJdqpuZ0vBiOp0+8SMjQYCiLHjtSW3l14Yr+UXNhcNYA/YnrgZ8faRwV3fI8ELASBshi
	xNJawK5BFYoiu0VAVgBM9cqS38zgYeeU+bYt6QSx8rqGuTM6I2kAbHE6ZgYMx06WUGk+dU3CSut
	BknRQY5xGlTo=
X-Received: by 2002:a05:600c:5493:b0:459:eeaf:d6c7 with SMTP id 5b1f17b1804b1-45b517c2e69mr181132325e9.26.1756386340726;
        Thu, 28 Aug 2025 06:05:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESD5cfz4wia2THU0g2lr6pD0o/ztQaWOm5Q0ecdtVEYA44uql7myhoP4Io/Nl/yebIzMXMIA==
X-Received: by 2002:a05:600c:5493:b0:459:eeaf:d6c7 with SMTP id 5b1f17b1804b1-45b517c2e69mr181131845e9.26.1756386340299;
        Thu, 28 Aug 2025 06:05:40 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b797dcad5sm34253745e9.18.2025.08.28.06.05.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 06:05:39 -0700 (PDT)
Message-ID: <28817d7f-986d-458e-9fa5-581566706008@redhat.com>
Date: Thu, 28 Aug 2025 15:05:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/6] net: dsa: lantiq_gswip: support
 model-specific mac_select_pcs()
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Hauke Mehrtens <hauke@hauke-m.de>,
 Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Andreas Schirm <andreas.schirm@siemens.com>,
 Lukas Stockmann <lukas.stockmann@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Peter Christen <peter.christen@siemens.com>,
 Avinash Jayaraman <ajayaraman@maxlinear.com>, Bing tao Xu
 <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
 Juraj Povazanec <jpovazanec@maxlinear.com>,
 "Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
 "Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
 "Livia M. Rosu" <lrosu@maxlinear.com>, John Crispin <john@phrozen.org>
References: <cover.1756228750.git.daniel@makrotopia.org>
 <1291bfe0609de9ce3b54d6c17ac13e39eff26144.1756228750.git.daniel@makrotopia.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <1291bfe0609de9ce3b54d6c17ac13e39eff26144.1756228750.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/27/25 1:05 AM, Daniel Golle wrote:
> Call mac_select_pcs() function if provided in struct gswip_hwinfo.
> The MaxLinear GSW1xx series got one port wired to a SerDes PCS and
> PHY which can do 1000Base-X, 2500Base-X and SGMII. Support for the
> SerDes port will be provided using phylink_pcs, so provide a
> convenient way for mac_select_pcs() to differ based on the hardware
> model.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
> v2: no changes

FTR, the above statement is misleading, as you actually addressed the
issue reported by the kbuild bot on v1 :)

/P


