Return-Path: <netdev+bounces-190710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EABB2AB8557
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 13:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA1DC7B4FC7
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 11:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA44298C08;
	Thu, 15 May 2025 11:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a4OV6jXo"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0206120FA81
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 11:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747309908; cv=none; b=fbzVx4tEesfWQNtHHd2UgbJ46Br/vDxfCF7xI6AQxwTFuYC0zMIuYcFBkpAoTOsfZXGxHXrEyJEZoggp4mX5tbO2P7WN4WAOISGU+HSOUZmV06Pt8bDyE6UmRCd87lIjP+xlxbXo0QtUsWnMKg8RMkRah2GqZvkzag3EVL50eQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747309908; c=relaxed/simple;
	bh=dAGgG8yyiAOY8HZUMAE4/N5xgfwh4+9Wjt3QcwMtdTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nbXDPxQ4nVf79U9TbHlc6zpXXDUyrpP6LkMjRdjoO84nJLLp5eo8t2k81+2rEQljZhTv/wmBgmT6D1Y7Nr9c2gj5j1gQ2UrIGxCXImME4aEt82fvcL9FG7AffVeTT54IBSfmzF7UovqZ/yzrhZBePE84s20s+dDEDIS3QQ0IC1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a4OV6jXo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747309905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8mvKOz//up2sPARV6VPRBQteHxfVgFtg2q1br9Ju/3o=;
	b=a4OV6jXoI1VVMbp3pxoqEd+90SnVdegs2O0CEAqU7ANdaubgb/mqLxbGrxAZC1tz9P2eXZ
	LPtYaQo3ijp+Ae+tWHNPwE685WHQf7edt4lyDYHYbY2sfwScXy9rR4v8h1e8CGQZIwi7fB
	X32PBdGusxdOp+WHoCAGaR399EI/0bo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-8CuDXkFCNeqC27AOw3Pifg-1; Thu, 15 May 2025 07:51:44 -0400
X-MC-Unique: 8CuDXkFCNeqC27AOw3Pifg-1
X-Mimecast-MFC-AGG-ID: 8CuDXkFCNeqC27AOw3Pifg_1747309903
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a0bcaf5f45so385351f8f.1
        for <netdev@vger.kernel.org>; Thu, 15 May 2025 04:51:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747309903; x=1747914703;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8mvKOz//up2sPARV6VPRBQteHxfVgFtg2q1br9Ju/3o=;
        b=FjjABCRLHP0VFZTwFBFUxPeTfjkJJEpmLSfKj6XeKDaqqdgZYLza+KbrCanBDtxPjI
         ruq9V/LqyfQ7N2KNtwqTRnEuc7DZqoiJa27hvZTtTWTvYjMHKchtTey/+0nc2nnoBSHb
         MKREh13zK7WnUOLfK9S8sIKAAqFC+ePWx0kTOcK9TN4e2OCwF+He9UsoAZpN6eC4SBHp
         1qMpi6ODt1PnX0a1GqHAncmR/Ry6HCxADXra/H+VoRmWQsN7XReEu3cLXlRGQYlrykwE
         MOywBBeAsKqbBUaFcQd+ugbdz5SmrWVg+6Jn/HOBMLm8ikSpA0aWRpwLCwpzLR9KUMmx
         dgyQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4YnEAf/JrUXKwbbRv5Bp9+9eiTkpKAfcWAJuhV60yTbs+ciKKNDFdoKeSnSsE3wn01ZIfypM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9hYJ9pTLlFsnVE3tj+uJyq1Vr5rXyWrGFcrpnM2ZWK1Y/J71d
	AqxEWgTGRmHEgGyQlykSmtX0aMqdqA9qE43FUlhZAIwUyrbXTihf74UO8Z7GPmBmVB2q4Hjc2wm
	srMQ+Apy764M89cmXafR+1egmOb+QeMPkPifc60K9DvSlAyOyZ7KBdQ==
X-Gm-Gg: ASbGncvd87R/ckRmY6jlZI9v0RAGGzbBEZ8B3awP/JDF0BVaIYKI1/ZV+sp7Jf59Lwj
	ZYxIbKwYVUWAS2DRaUnvU+fp87lGn94Z3+y8EIgY2apf73SIHHAJIXo4aRxZnudP/nrE2mUURhf
	cPHzCm/N7qpLzszLeAynQTxnanlCD9GdLIzBQWrCQwr3kD3zHbIXYVrCOWcF2Svp1JAZPTJu6MD
	8+DXrCFh4a138dljBF4uPuUmv1uCy1XMDGId7tNQpTwIQ54TULD4gnD/MmR9MZ2qaRZNUO1iRo9
	z55rY/ZYoUmRF5ZJR50C/YpKANsbKwt/M7SGms+b5AqDrjW9hBa2HkeuDIk=
X-Received: by 2002:a5d:64c8:0:b0:3a0:b733:f255 with SMTP id ffacd0b85a97d-3a3537480demr2229877f8f.25.1747309903386;
        Thu, 15 May 2025 04:51:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeJPO3okWHQzPk/Kq//Y4tisgvsrwh048orz2HvG3kmOZOLmvph3DCI1mcOIyLN7SeobjP7g==
X-Received: by 2002:a5d:64c8:0:b0:3a0:b733:f255 with SMTP id ffacd0b85a97d-3a3537480demr2229854f8f.25.1747309903019;
        Thu, 15 May 2025 04:51:43 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2440:8010:8dec:ae04:7daa:497f? ([2a0d:3344:2440:8010:8dec:ae04:7daa:497f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f57ddd2dsm22484374f8f.9.2025.05.15.04.51.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 May 2025 04:51:42 -0700 (PDT)
Message-ID: <c6eed9e0-8f44-4ffb-b316-d65e0b5a192a@redhat.com>
Date: Thu, 15 May 2025 13:51:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] net: Add support for providing the PTP
 hardware source in tsinfo
To: Kory Maincent <kory.maincent@bootlin.com>, Andrew Lunn <andrew@lunn.ch>,
 Jakub Kicinski <kuba@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Xing <kernelxing@tencent.com>,
 Richard Cochran <richardcochran@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 "Russell King (Oracle)" <linux@armlinux.org.uk>
References: <20250513-feature_ptp_source-v3-1-84888cc50b32@bootlin.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250513-feature_ptp_source-v3-1-84888cc50b32@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/13/25 1:40 PM, Kory Maincent wrote:
> diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
> index c650cd3dcb80bc93c5039dc8ba2c5c18793ff987..881e483f32e18f77c009f278bd2d2029c30af352 100644
> --- a/Documentation/netlink/specs/ethtool.yaml
> +++ b/Documentation/netlink/specs/ethtool.yaml
> @@ -98,6 +98,23 @@ definitions:
>      name: tcp-data-split
>      type: enum
>      entries: [ unknown, disabled, enabled ]
> +  -
> +    name: hwtstamp-source
> +    enum-name: hwtstamp-source
> +    name-prefix: hwtstamp-source-
> +    type: enum
> +    entries:

This causes a kdoc warning in the generated hdr, lacking the short
description for the enum:

include/uapi/linux/ethtool_netlink_generated.h:42: warning: missing
initial short description on line:
 * enum hwtstamp_source

Please add a:
    doc: <>

section.

Thanks,

Paolo


