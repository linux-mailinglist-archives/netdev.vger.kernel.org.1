Return-Path: <netdev+bounces-162514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A8FA2726C
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 14:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E88B3A1273
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 13:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617E02144AD;
	Tue,  4 Feb 2025 12:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R16HgHoE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAC92147E9
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 12:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738673357; cv=none; b=Fm8XD/JG0Lk9mZ2sjnbneoSH+yOHoeA/QVxhGdkH82hapLupqeADAcdifgeArElrrIgu/Bn6QCQlgdHNq6Cs4akvjRjZoWzW2UpZxAFMsau6pv6qbVb15IVasVFk6wqhuHPDfTwEDwOaYywaFQYX8rABjuEyEsqcEHEuSsh8vRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738673357; c=relaxed/simple;
	bh=cNZfIxuQ/dUvTtp2PRA1hmfgdBp/4Ud3DXpSe0sO8bc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nkVjgtxceZ0epZSSOStsAKmWdD8+3OpsJhxiJXSs040B0M9dBvGVyuihrSvuYXjh7fY1uMasPReROq7jTmR3pon5jKqHd6dVdU0/ciYbRhgl+We7zxw6+FhTKae7IQqhf2ZNEb4ZJgzoCXjADP7ZLyYmUBa1yF7YSuaajaNfQfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R16HgHoE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738673354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rIuA9Q5BQ/UpmDYfeLSwx+viepR7qfZ4WtCV90bBlSc=;
	b=R16HgHoE/QSaL+g+P97O3hhPE63WQBxZ6I/TKfJu3mKZbcAh5beVQ2Q09OrYZd/JS26owm
	sC7thx1etekZFFR8y0/qsAXOahEk0gd34aTvZHy8crgtsRvG1VK8y28HInfO+jhsIFhgAU
	fiqOkgdzPExWAwXJcUAOpJCo+csTWU4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-qloXx6g6NkihKimtVu0gEw-1; Tue, 04 Feb 2025 07:49:12 -0500
X-MC-Unique: qloXx6g6NkihKimtVu0gEw-1
X-Mimecast-MFC-AGG-ID: qloXx6g6NkihKimtVu0gEw
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43646b453bcso27543345e9.3
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 04:49:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738673351; x=1739278151;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rIuA9Q5BQ/UpmDYfeLSwx+viepR7qfZ4WtCV90bBlSc=;
        b=eugoT8DhSgGnt5D1cxwh97BzfpAjEUw1HQ7sbnVtIEUC+Rk9YsfRw/7Tpf0qSnOvIe
         ewyrVjfctH9hXHlzUXRbeP0HucFIlQuRHPslbfyj0SaDUEK2xfTFrViG+vGhiY649tMm
         2fZKDBEXHL8t4Awttyrib05sLD/Z1WDiOcp32g0OTb4MuprnPBzHMqGUIzVcG75BaL8t
         Q0skXLLtAMymxUTGQW/EheGSWU/AkC3WKOz2dgunwloE4+mxA2TjpX1L/c4jdOVkqErb
         HvecoWAm3Cfo4DVZIDUTkJB0/4NRSnarMteNJNb4ouQ5ljk34SwEtjcYVGTjK6ydDk/b
         Rr4A==
X-Forwarded-Encrypted: i=1; AJvYcCX/+SME5kyCxIdY0MfoGZHQF77GvjzU8L32tGYwixoCPmewJD8CdR3g+AO2yHk153JI61DZJrw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg/dPu3rQ4jTlaCYYmh4TiXBa+f7BtnMekR7FLKefGDUaYt/pT
	QUdbI/lR96nkcbv4SUUy8yZOw74CmFOM+tbYG+oDsmvxAhcR2eVbWTIltMricwSessP5/kEwvwR
	BNE6j029+816HpqK2brxEOaTJELAjTyVEYmNDZsB41DwqfO5oYWRi1w==
X-Gm-Gg: ASbGnctFHYtFXeEIsp0T+At/3raNg7lf8RVUQQ0DQCtm/WW1UW45Sdu+1gTMSgiXmqF
	YCuRxpOO/WK1GVs1ueEHXv1+lMDPCGb45dzXoaXdTlshmmvqcv9BrV0A1ijg7BbpeqReULx8SvU
	q8eUryTX+bMq2P0Zja89EDdfr8cFL99SgfBQ/8LUpjHuSXbIhh9dbErJxF7+VWBPZ3tIV1eJiDF
	xF9ndv1z8bPbaZbhVd5ofGzj53iKJvNZFOUljb48g5208FwTkGAazVfeh5fXNWy1ndFTpeatr/S
	g2i3hNMFtGwVPoS1cfFZKRBBB26mk9dNAwk=
X-Received: by 2002:a05:6000:2c3:b0:38a:888c:679c with SMTP id ffacd0b85a97d-38c520a309dmr20532541f8f.42.1738673351621;
        Tue, 04 Feb 2025 04:49:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE6xpNQiWyRW+ZhOlhYrT1cq0US5fsl5QXt/aCRXY13IU8xcC8D3t5iqncxRBJpXzewx2tkTA==
X-Received: by 2002:a05:6000:2c3:b0:38a:888c:679c with SMTP id ffacd0b85a97d-38c520a309dmr20532519f8f.42.1738673351240;
        Tue, 04 Feb 2025 04:49:11 -0800 (PST)
Received: from [192.168.88.253] (146-241-41-201.dyn.eolo.it. [146.241.41.201])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38daf27bbf5sm1088684f8f.48.2025.02.04.04.49.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 04:49:10 -0800 (PST)
Message-ID: <c03313e5-c6cc-4484-aa2c-8612ba7cfa23@redhat.com>
Date: Tue, 4 Feb 2025 13:49:09 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] bonding: delete always true device check
To: Leon Romanovsky <leon@kernel.org>, Jay Vosburgh <jv@jvosburgh.net>
Cc: Leon Romanovsky <leonro@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Hangbin Liu <liuhangbin@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>
References: <0b2f8f5f09701bb43bbd83b94bfe5cb506b57adc.1738587150.git.leon@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <0b2f8f5f09701bb43bbd83b94bfe5cb506b57adc.1738587150.git.leon@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/3/25 1:59 PM, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> XFRM API makes sure that xs->xso.dev is valid in all XFRM offload
> callbacks. There is no need to check it again.
> 
> Fixes: 1ddec5d0eec4 ("bonding: add common function to check ipsec device")
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Acked-by: Paolo Abeni <pabeni@redhat.com>


