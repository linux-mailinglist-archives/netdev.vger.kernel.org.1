Return-Path: <netdev+bounces-106972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4EF79184EA
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 16:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04DDF1C22D34
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 14:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C549186294;
	Wed, 26 Jun 2024 14:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CS8pNosi"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E8A186284
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 14:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719413607; cv=none; b=Uap3Y/VXsxd/X5O80eVACX/v3dy60KeaGn8EKB8n/sZMIrhyJ/sK0xKHp72sDfMaqzvzlq0LYdY0Ns/+aRgZLBBfCEyuJmQDgdWZEMfpXLGc5YTYRgopMIWfWvkiZc/6LCC9lfCn412aG7ddbBuITyu2LFcIbfIWDJIvZUWwqX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719413607; c=relaxed/simple;
	bh=hyNxaFzPXWFBRg+/6WUFhFSPBWdIIx4INvH/NCiLLHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fXXoh0RSFCibVMX2iBpdw11J8SkifX0kJfPM95hmSUmxnhwJ3McmzRV7YnT3BWAQtTqfN1AQZwsDThLUvHiJnqE16V/3w3YG05DFujb6YXUl9C8l0lpsYrBoyFxL0zxloI+2C5XWHF9WpId8lDDlcgSegaKW/Eo/SC0lPKYeFiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CS8pNosi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719413605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YrKnBGUsXzxltAg01s3o4kyy9jXBJCa6pgwUhoUuJvY=;
	b=CS8pNosi9HfpSuGDfzi6FQpH5mXveSzm2vc77oM+nT6tSg6ceZ/uQmcxCtsS/3MXMK15jT
	xbYOSBaX8X8zkGy9c8pG3IyHsv5zJ6tpLY3t34n/AGLYI/uukiWHpi2TDIFQ3KMfgxjmWF
	hwglgWMPphcwRbyewQtm7hRgD0pnX5U=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-ahusZ7wRNXeTMyZW5trFkw-1; Wed, 26 Jun 2024 10:53:24 -0400
X-MC-Unique: ahusZ7wRNXeTMyZW5trFkw-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-79cca22db8aso127250985a.0
        for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 07:53:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719413600; x=1720018400;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YrKnBGUsXzxltAg01s3o4kyy9jXBJCa6pgwUhoUuJvY=;
        b=ASxHVWaijS2eH8n8r/gBOFy66Ew53sAsx536GeWUPJrUlnRuxmbnGr+SOnIFtzuYkC
         gX8IyzJO+Ifw4jC/0sLDEEFhuOF1QDk3kQ+r8sqRcgMHU2LNXlLU5r1V92Pny29rYzqD
         vVvVa7exYcaoca1O0l2lqshhOxZ5t0leHSbxzKBuy3OvT14puW1xvRb2hP+1QBzSQ5L4
         6cikLigsA6DrFvbInc1s7eibO6IpqQXfIKFEaA5Sp7hqI2hIyzqSdmvNYYQKJKNpsdE1
         jncUkbWfkwHDjirVsAPKKTPdThehMaVeppCzh2++1w20fnyhD+keWyUkZ7zut3BF0qiH
         bsLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXw1W1UGTBQc+oEQEeh2KMCcWs3IoapTKgFKos+7/EB8jwzdNU+S06hcJ9RhkcMZQ95Jn4WAonkeIVJqJ826w7RKIlMCAZ7
X-Gm-Message-State: AOJu0Yyn+L9EEGG3ZK1dwS5k4ZKa2aTH7IT4ZiSKqlf3FOcuMDQFLjna
	Nce1cvxfWRUijipGuinD+v6nuQiS3P+PrGO+y+u9vle1B3ueS5dELWVTLM9da4BXx3iIQQVYfXN
	CiurSkwvQyeOATHbEM69j+xYUTF2kXUYt+hnPmcUM7bmXja/qsDhBHA==
X-Received: by 2002:a05:620a:1998:b0:79d:5414:68d2 with SMTP id af79cd13be357-79d54146b12mr159311285a.44.1719413599687;
        Wed, 26 Jun 2024 07:53:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7rWL9/p+Lnv9AbO8zaoMmKP9NuiF/Sz5Kmi1mA7Vt5rgp/9627GpolyqUJFKWM3RKg3m/gg==
X-Received: by 2002:a05:620a:1998:b0:79d:5414:68d2 with SMTP id af79cd13be357-79d54146b12mr159308585a.44.1719413599165;
        Wed, 26 Jun 2024 07:53:19 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::f])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79bce89a5d5sm505133885a.19.2024.06.26.07.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 07:53:18 -0700 (PDT)
Date: Wed, 26 Jun 2024 09:53:16 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: Sagar Cheluvegowda <quic_scheluve@quicinc.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bhupesh Sharma <bhupesh.sharma@linaro.org>, kernel@quicinc.com, 
	Andrew Lunn <andrew@lunn.ch>, linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: net: qcom: ethernet: Add
 interconnect properties
Message-ID: <q2ou73goc2pgrmx7xul4z7zrqo4zylh3nd2ldxw5vnz2z4fnkf@axbse4awc6lf>
References: <20240625-icc_bw_voting_from_ethqos-v2-0-eaa7cf9060f0@quicinc.com>
 <20240625-icc_bw_voting_from_ethqos-v2-1-eaa7cf9060f0@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625-icc_bw_voting_from_ethqos-v2-1-eaa7cf9060f0@quicinc.com>

On Tue, Jun 25, 2024 at 04:49:28PM GMT, Sagar Cheluvegowda wrote:
> Add documentation for the interconnect and interconnect-names
> properties required when voting for AHB and AXI buses.
> 
> Suggested-by: Andrew Halaney <ahalaney@redhat.com>
> Signed-off-by: Sagar Cheluvegowda <quic_scheluve@quicinc.com>
> ---
>  Documentation/devicetree/bindings/net/qcom,ethqos.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/qcom,ethqos.yaml b/Documentation/devicetree/bindings/net/qcom,ethqos.yaml
> index 6672327358bc..b7e2644bfb18 100644
> --- a/Documentation/devicetree/bindings/net/qcom,ethqos.yaml
> +++ b/Documentation/devicetree/bindings/net/qcom,ethqos.yaml
> @@ -63,6 +63,14 @@ properties:
>  

Does it make sense to make these changes in snps,dwmac.yaml since you're
trying to do this generically for stmmac? I don't poke bindings super
often so might be a silly question, the inheritance of snps,dwmac.yaml
into the various platform specific bindings (qcom,ethqos.yaml) would
then let you define it once in the snps,dwmac.yaml right?

>    dma-coherent: true
>  
> +  interconnects:
> +    maxItems: 2
> +
> +  interconnect-names:
> +    items:
> +      - const: axi
> +      - const: ahb

Sorry to bikeshed, and with Krzysztof's review on this already its
probably unnecessary, but would names like cpu-mac and mac-mem be
more generic / appropriate? I see that sort of convention a lot in the
other bindings, and to me those read really well and are understandable.


