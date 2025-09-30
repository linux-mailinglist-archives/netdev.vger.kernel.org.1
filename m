Return-Path: <netdev+bounces-227329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE67EBACA27
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 13:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83BDC164522
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 11:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4317C21D590;
	Tue, 30 Sep 2025 11:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R5Nye9Xu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AF81F1932
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 11:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759230486; cv=none; b=JMt94sUAmXuRhecsvkwlECQISgeug2nYcTcVSElFyhKBZZBqfZ5oVQNOKP90LVawEgWE3HcFiA0UX8mtYKW48nB+B3nT2GsRVcPe2sLdGd+KcEBDEyiNUy1EGFtuZAJFZJ/XYf+jHpMuX54uGg4U6uiDHjI4dxNU2X7WGj93ZXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759230486; c=relaxed/simple;
	bh=7eVuMR2uCHwAMvZTWITi7zXqx6R2MONZnM3UePRS2qc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fsD4N8PoT7QqvBGDR8Z05OLA2JsgzAQpxwKD2fHz9sk+xjsYU0nDHfENu5uwf62PCo9A1/UEPOYbZO0aD4zNS3bHS1WhSvoXl8bzScnFCbCPFc48wSVodccKKzjDwSZRzBVKJT+L6mr6Mr1uB3IT5lDm9/w9BL7m23EgdbjRPlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R5Nye9Xu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759230483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FfPcBPeiA6B4ouOuexFejWK64dOaFigAn8muMWhU3dQ=;
	b=R5Nye9XuM2sEtKtHP/xdxt9eSc62T7WFeKop+BrfPI56JpJLdPU7Z+GzNHpME983vkFCQm
	CF9EPO8rE/dGedB9giZekuRuGSmr2/FO5Y5QCVBBeahJJAUEIVGiMe5sQQ8BY4b4ZYjL/S
	K0zxXSWvdG8HLQSH/BzoBBjG2UV3qcI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-2SDdANyNN_qNlSiLIErn9Q-1; Tue, 30 Sep 2025 07:08:02 -0400
X-MC-Unique: 2SDdANyNN_qNlSiLIErn9Q-1
X-Mimecast-MFC-AGG-ID: 2SDdANyNN_qNlSiLIErn9Q_1759230481
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46e46486972so12850325e9.0
        for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 04:08:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759230481; x=1759835281;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FfPcBPeiA6B4ouOuexFejWK64dOaFigAn8muMWhU3dQ=;
        b=WgxMnOgfh+lHGA7rsXzhPqtIHuZhIk/jD5FYAFTLsly3jAUz36xAOexKFbFKyYTcW+
         4ktAO5z3aA3CLn7DIYdkO9wMcpdvGUyN1nHTW3WEayxN6N7tOfxUS1kGIrIVjfwy4gvC
         cD9uEB2pOiUKocfeFV5OK7YAt2uqN1ZwiBTvoL/ucY6o+glQ6y6UsgcSH6iSplpPpg+o
         jW5kiQs/+VouJDu62/leCUN5edCQI7je7+pvkFh2YhCyQfeG26amuZGfyySn+FW9gS8N
         2MnDPG/uDnXvCBGvyvlTBW+iwsmd0QbRfQYrsHbnik6Spm7IRX9WYntmJ55XnGUrhaS6
         AwFQ==
X-Gm-Message-State: AOJu0Yx1S9v0GblTdrJF11KFEh2xJPYTFECOAAd4uzkRga3GERIunwz0
	CblIYrH1AkEB984t8uOg5Fw5QrU3OLYzwANqseBjYaVi8919VsR3AnZ/krIimz2RrujSRf/w9eE
	hR9felu85Xn5cFCsUt09aRmk4SYqpz3KqbF9N1Hcl/nVPbu1kdCvC0TcipsAXHOk2bw==
X-Gm-Gg: ASbGnctiq5SacRnHCR1mBOQN0uipLWilwmtzAUspslr0/YJ3ScKA+3NIq3LvKLtioCM
	3YHqT68emanBCaOEVEOk2YIuMfNDEFn9w/OufPq5+YFPcHCKqpC8a6WAFkCokm1vIsRfBUgt0fr
	2SE7bV2hdHKOVMvLOq7Av6XZou2fHl5LkhM7fVwSXXU/Y7U27hVUihfvOmh/4IhE86gQj1Tbn/T
	0I8M7X4tcUm8eoPTH6nnhKcirJID+japuO9Vy3wtqSbVGrTitCZ4y/hRffp39VeObYX7nQvYCV1
	E6xnX8b0rOEANNZXarAOgelbC2TCE0YzCdRzc9y5sxDAiWXe6SU86hCSCX92RldiNR6IWLb0mXH
	jZqYK7rDOs+eiACc/OA==
X-Received: by 2002:a05:600c:8416:b0:46e:440f:144b with SMTP id 5b1f17b1804b1-46e440f1681mr106148115e9.14.1759230480814;
        Tue, 30 Sep 2025 04:08:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtp2PNPVi0ALjvuUKoPRLDELJ7rf4PAGV+onh7dq2Ietz1gwVjsUfUi7sNW36nUdpmYhddmA==
X-Received: by 2002:a05:600c:8416:b0:46e:440f:144b with SMTP id 5b1f17b1804b1-46e440f1681mr106147925e9.14.1759230480426;
        Tue, 30 Sep 2025 04:08:00 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fac4a5e41sm23693038f8f.0.2025.09.30.04.07.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 04:07:59 -0700 (PDT)
Message-ID: <157578d3-c06f-4621-b707-ca4208d18807@redhat.com>
Date: Tue, 30 Sep 2025 13:07:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/3] dt-bindings: net: airoha: npu: Add AN7583
 support
To: Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20250927-airoha-npu-7583-v2-0-e12fac5cce1f@kernel.org>
 <20250927-airoha-npu-7583-v2-1-e12fac5cce1f@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250927-airoha-npu-7583-v2-1-e12fac5cce1f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/27/25 4:03 PM, Lorenzo Bianconi wrote:
> Introduce AN7583 NPU support to Airoha EN7581 NPU device-tree bindings.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml b/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml
> index c7644e6586d329d8ec2f0a0d8d8e4f4490429dcc..59c57f58116b568092446e6cfb7b6bd3f4f47b82 100644
> --- a/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml
> +++ b/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml
> @@ -18,6 +18,7 @@ properties:
>    compatible:
>      enum:
>        - airoha,en7581-npu
> +      - airoha,an7583-npu
>  
>    reg:
>      maxItems: 1
> 

This needs ack from the DT maintainer and we are finalizing the net-next
PR right now. Let's defer this series to the next cycle, thanks!

Paolo


