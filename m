Return-Path: <netdev+bounces-215546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B86B2F28D
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 10:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7F2B1888D15
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 08:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB7E2C11C5;
	Thu, 21 Aug 2025 08:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d21+CVNW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94E32BE632
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 08:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755765454; cv=none; b=a56FFh95/UwvRU8OqQQuGMAB7a6uL4jlqbhGEE0HrAfsnc5F0pdTUfIoiMVfuBJYhtglLRSsWUEoHay7AGyPk43GSj9uPe0zKOh7emswKngJHwX5tv8WtYpE9v0RXI2gAazQP1yn356QXRj/lvNp+hTqOIFee7Imsnp0eradvxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755765454; c=relaxed/simple;
	bh=JgRgDYpNHETv7narYbvqfLs6QlA4PD1MYCamiDt4VCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KI8TNFBnpnXzo+GtwsNqEvlqmKVKf5VQ8wKwowCCpDkCTtYYpz98gDRKpuzTGN+/dmfiSVouDArFq27TWaWY23rRygsgaSgUID2khuNcoIvmLN43GZOuDLtcvxs6QH3eNRfmIzNjrQG99nN/a9yePMIOmQs5jRdcBf5/Agc/J+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d21+CVNW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755765451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Z/jl4NhLbXD2Dij5yPc3+gGoxGWFr3ANr1k9GO/WQw=;
	b=d21+CVNWgYj+5Zh738LSyp52Qq9nChRnI7ajhtq7TK+FYoeSL7QAvY5VcYklVTKzNTNNRG
	zXziqiSz/ukHusg5uEYF/LoEZDgHPlEYiLdqoiZSh2ddTGOJBXQWpp1OhURtRdHglnzjun
	6C6+D1zhyIH2HnGKBy6HBXlkpQEXArk=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-9-x732j0MmuCFIZwjKonSQ-1; Thu, 21 Aug 2025 04:37:29 -0400
X-MC-Unique: 9-x732j0MmuCFIZwjKonSQ-1
X-Mimecast-MFC-AGG-ID: 9-x732j0MmuCFIZwjKonSQ_1755765449
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b109ab1e1dso33974961cf.1
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 01:37:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755765449; x=1756370249;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Z/jl4NhLbXD2Dij5yPc3+gGoxGWFr3ANr1k9GO/WQw=;
        b=Xb5RrMTSd6izSLZ67//2+WmTfDVqiMRQS1CJsEo8tuudLyDPbgjZY6XO6JS7qxUQ8Q
         jH+6G4yZNYCTFIoMccJdWyi3eJHNw/UicnaLJICGUgwvzqbzG9NErLnJpHZSKbgica+Z
         bpS1LwUcPP0NjMPky9WrcGpjCOblRjbADiuS9FYyg6LaONWc4TlhIUjeSnGdpJ9kLYmc
         fgo2MiXs2W9UTocFCHJx3euRlvTRSE8qU/2AmMeLPuvI7GyUxa6x8nZZ87W83q36oTKt
         kUubPsL7odnO3mrGCZ6vY58CNaAhEr4vkh8lwNmXPiI17724OWSvzFgzv+Gwy2GaVuuo
         AgTA==
X-Forwarded-Encrypted: i=1; AJvYcCUlZejy3q7Sog+4H2O4DNd9P/VFFNBOWBW4vCfETI9WWRe/i4OhXeokKxOA3Y/BImPyWwpXpVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPdVuqu8zp7ws5C6WoWYRspeVn9BQJvCBnzTGzeBwbgPKt3L6W
	MP9Icnbjft3bZ7HZzZOiZBTSioYFRAQH5ttDJ7iIP84kfLhr1ijydlnoJ5dAGKN1RHNDjc9Xn2I
	vSKrqYcLQRWKiFOmLhfnyDYTM8+/WmyKoUO92p2TprRIXvGz2T/j7GIFU9Fn2NilkrA==
X-Gm-Gg: ASbGnctgjmfqm5nRvXhQYFdwG29CP+vL6UYB5jJyEHr34Sos7BRnIqrMAPtaLKj7sih
	uDB6SbQKgQO3br/aZCRoDTJSEubb7qM7eSjTAK1CTJPYKuIzVcVzSn5eZWr3Nwl0BYgajdhAITL
	2xVMkjcX0njjlMREwQWA3RMrf7HhgRq44Vj1zFvUbaDgFpZFPfhJp/gaYK/6ORQsuOvnjr0k8XF
	oPmOTfDwnnoTTQsX79Tq8qf+Uf9ma2pUNmLV5ErEF/aADLtBCUMx7WjZMNx46BcoaMRb6dw2GT5
	i0V03hudRBJsDSNbfHPaGqnwxZK1NnZjZxcmaRT+J/YLLr4170ZOou7O+BWb9UFesHkJAyUf1qL
	0IgoE9DMtNBU=
X-Received: by 2002:ac8:5f84:0:b0:4b2:8ac4:f079 with SMTP id d75a77b69052e-4b29ffbf332mr15472861cf.75.1755765448952;
        Thu, 21 Aug 2025 01:37:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHa7HLEniIEeVkau0Y7KiByuf3qR340mDfBeXhw9Feg3OiLXP4Ua8HjnDawfSR9+z1zBUadDQ==
X-Received: by 2002:ac8:5f84:0:b0:4b2:8ac4:f079 with SMTP id d75a77b69052e-4b29ffbf332mr15472731cf.75.1755765448579;
        Thu, 21 Aug 2025 01:37:28 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11dc19033sm97984061cf.6.2025.08.21.01.37.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 01:37:28 -0700 (PDT)
Message-ID: <c263ea0a-adb3-4c91-81b8-cb5b283c5806@redhat.com>
Date: Thu, 21 Aug 2025 10:37:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL][mlx5-next 0/4] Cached vhca id and adjacent function
 vports
To: Saeed Mahameed <saeed@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leonro@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Parav Pandit <parav@nvidia.com>
References: <20250815194901.298689-1-saeed@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250815194901.298689-1-saeed@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/15/25 9:48 PM, Saeed Mahameed wrote:
> From: Saeed Mahameed <saeedm@nvidia.com>
> 
> Hi Jakub, Jason,
> 
> This pull request introduces a preparation patchset for caching vhca_id 
> and needed HW bits for the upcoming netdev/eswitch series to support
> adjacent function vports.
> 
> For more information please see tag log below.

This has a conflict vs net-next, could you please double check the
conflict resolution?

Thanks,

Paolo


