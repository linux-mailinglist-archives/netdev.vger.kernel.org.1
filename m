Return-Path: <netdev+bounces-190804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5BADAB8E76
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 20:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCD33A01765
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 18:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E2B258CDC;
	Thu, 15 May 2025 18:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="md5Rt4ES"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE741EA7F9;
	Thu, 15 May 2025 18:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747332343; cv=none; b=VwYTt1ktSxzNH6oCji2jz0nq5KVJi6hz4GO+a6PBsl1PPqgV4FFmVPEFlPSDzg7PJSK3DhOL57G9sWHrLikN7rxELdLCq10aBkxJduuo0EgMvIRH3xbtZM30c1TQ0EAFIfZvOL238aOJUi1tX3vvR7YefrZKOp691mylVgjrAQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747332343; c=relaxed/simple;
	bh=qoH6LccZOlhTi7y76NH6szhTMUifU4ew3xvC7+xhRr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mTZhbnvDHTH1+vtexn8ZhIe4DP13k1eHlXUXfdfZmjPCXCFQfrnoH3Km+wZY6+LuiUlDwUrOrLUNANSZDoo5XezoXBW62VwDw5N7frUK4wJYkqUQ2cBaAyYNZpnlLg0Pbtu2RBQFIVwB0RcB42dzLCm57eJXfPFn9WKoNeyeiIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=md5Rt4ES; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cf848528aso10337395e9.2;
        Thu, 15 May 2025 11:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747332340; x=1747937140; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4THNUf1uXf81C9jvxSlBYnSoxyqZaGOpOTb4vLyxUPk=;
        b=md5Rt4ESPXCzQaEyuulZMmaCn0Xg+ILgR+/BUsbE5SDuNkwp9H0V3HijYIyIQG6qRU
         572aTNiTDMO1jqdbdQJghDO/Z38ihXnVIp60juLj+JMxnSFKcwQGrPlmm0qa3qfic/2w
         Nhl8FhBNi/tOOn3SzKMgcJW6jK2M+wcEE1Ml0SWQ/sWE90YJaYgJFtalptHHxIg7mUd/
         BoANLeHAH+crySHgrPc7kWofbPGDYXHyQdC15JehTP1iTKmt39S8y/qwVUFB++qMZ7np
         EKAsXOCAZHAzQKJQZiKsnS7rM1kMiyloowWKxZFPOvV7+uWtMlwWy2spFKfJQ/rSSS3Z
         ixqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747332340; x=1747937140;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4THNUf1uXf81C9jvxSlBYnSoxyqZaGOpOTb4vLyxUPk=;
        b=ZgqEOk+9HvewUBL8rlSX0y5A2P1VRQmpJEg8ijOohD+wYomBk08lumodUjdDx+9tXp
         oIQmTh91LTneCMcAP6WcYS0F7BmK/WMPmBc+//KNKpmIuSb36DZivClUl9wsJ6inrlHM
         nazHAB/iLWPbyBALQ8tygPau+SixQ2Xssq4CFP5cW3YzuuGmoDmOvM8CQcrfHQZwKQEe
         upLBSCaK9so0WdvF8WdZLhKPhaVg1PS+eMLLt8zkATYJA1UVbD9k9qq5/VEJYoIWKz37
         Pdcq117c7kPkk9HGGOgdxoGnTz4jQk8Q2ZQSpMd+0P3bMqu4Y33aDU1xwdodOgIrydrl
         FZ1A==
X-Forwarded-Encrypted: i=1; AJvYcCViGskOvtc/pFl2PujVSujvaqe1SIdo1fXdh7VvKTy6GuJjyCrziBhm+GzGekTxQ+qokhHTzSsRgXPaRYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZGDJ6+ZAoWla2er3mpBEvb01wr7jXgzV9maZcsrF4mEKlINVU
	thJp3W2V8xyi33ihFZYAqtGeVthdITiI7wCBPqa9QTUtnBBRKcbYmEDN
X-Gm-Gg: ASbGncvq1UpZrPY/b3gKyN1CsVLyVRNwWC2FqjgNeJfxFAC+0JMjYXa95ihiyWrvaKR
	AN/qnqAulJgc42SPJ9zy8gG1xDuHkkhAeOYXgkk9taxRxqVLij/17/UPvHdZfImrNfyd0jX+BY/
	NG/VbKlfb8Mj3Uk+QvKniqKhTvJftPkRbDBSVE0LwYZ+9BNCneXHkrMuRReh1ZdE2/BfIwQivkz
	EWz5dm70JBbxZsSrV6YJtyxUIhRLTYgTY4R2dRRFroHrchuk3/XNPY5KLKwSFu2bHsXE+cLKcoR
	c2UAHum7pOeJ8wBveOpQfwijnOMJPhClykjphmGSgx6O3wY85IiqXdYduQT69iXjq8bg1SXRu6Q
	yiye45wkATGr/Vqen07NIEwquhYPremcHTv5A/dnBykg/0E9p3yUEQj1O5V7m+wjsnFBolxTInf
	2zZRKzvJrtaw==
X-Google-Smtp-Source: AGHT+IEAMZI0gYj6jUL1XNnD21cZordm0Cbrsc9of7B1lYW2lChuusSGJbdvOqSY1ZAdEKpZBYJs0w==
X-Received: by 2002:a05:6000:4285:b0:3a0:b990:ab72 with SMTP id ffacd0b85a97d-3a35c847d18mr690722f8f.42.1747332339783;
        Thu, 15 May 2025 11:05:39 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f4a:2300:ec36:b14d:f12:70b? (p200300ea8f4a2300ec36b14d0f12070b.dip0.t-ipconnect.de. [2003:ea:8f4a:2300:ec36:b14d:f12:70b])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a35ca4d1easm231079f8f.5.2025.05.15.11.05.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 May 2025 11:05:39 -0700 (PDT)
Message-ID: <9714d7a5-196d-4f7f-ab01-dcbbf883f064@gmail.com>
Date: Thu, 15 May 2025 20:06:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] r8169: add support for RTL8127A
To: ChunHao Lin <hau@realtek.com>, nic_swsd@realtek.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250515095303.3138-1-hau@realtek.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20250515095303.3138-1-hau@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15.05.2025 11:53, ChunHao Lin wrote:
> This adds support for 10Gbs chip RTL8127A.
> 
> Signed-off-by: ChunHao Lin <hau@realtek.com>
> ---
> v1 -> v2: update phy parameters
> 
>  drivers/net/ethernet/realtek/r8169.h          |   1 +
>  drivers/net/ethernet/realtek/r8169_main.c     |  29 ++-
>  .../net/ethernet/realtek/r8169_phy_config.c   | 166 ++++++++++++++++++
>  3 files changed, 193 insertions(+), 3 deletions(-)
> 

Reviewed-by: Heiner Kallweit <hkallweit1@gmail.com>

