Return-Path: <netdev+bounces-176771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0305A6C11C
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 18:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EF2448537E
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 17:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC73522DF9E;
	Fri, 21 Mar 2025 17:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J5soJO3v"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1998322D4DE
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 17:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742577426; cv=none; b=k3ddyJ8vKyIrEuEtwuT0nLQAufl9RC3i5QjKgrft6EaZnViZavYsausNe6AyjO3NxWLWl8dcSZFOx89Nz2NbFZuNTCzmvZjI0czRqh65/VkFKmHp+cPdeIFgsHCWniGI3nMFiKFNHpYnakrH7DMbvNBaDwPcxgPj7+A29JWFBaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742577426; c=relaxed/simple;
	bh=2mQXVEiglxnvhG0YGsI1ou5cefHZz5IvLqzdNs+qKf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rL10wFAqQfcSPw6RaP8ufnwL0Y0OyyCGOv+CBaZhnOk8qmdUG5WG+n+En4qn+su8ESOF1oW8Fhq6TC2IEmt3mboIVRYvT5uGIxtFFyXm9lzuukMCaHFI2yVITYwtEaraTkLK8w1hkjRrIPF44NF1+okQOnZveg219A7g+l5YXt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J5soJO3v; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742577422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qcgxnom0V5XwmRW76kyBHQnpXZAEiNHsg3i1sgD87/0=;
	b=J5soJO3vrPmZlbm2+7QogC4c7G3l7Smx5Dguu61V3FyUIaUO7l3Aad1ddijc4wK1HGzXzW
	rKiTwF8tAhpVErtS/p/cQYdB+HUGyCiaUAgUBu00/Qb5+Q7gE/oImQDePpy3hkwjQkknDx
	9qR/44GEOVcffhAhi/e2J0LxH1J9cRk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-KvT6lye3Mtmq8VFW9DGIRw-1; Fri, 21 Mar 2025 13:17:01 -0400
X-MC-Unique: KvT6lye3Mtmq8VFW9DGIRw-1
X-Mimecast-MFC-AGG-ID: KvT6lye3Mtmq8VFW9DGIRw_1742577420
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43cfda30a3cso13210815e9.3
        for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 10:17:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742577420; x=1743182220;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qcgxnom0V5XwmRW76kyBHQnpXZAEiNHsg3i1sgD87/0=;
        b=ram8p2l4G3wHcndUkYW0RswXMmTKoQmxiinYGnTxe/l8bZuz6CfR6cidIJBLr2ixgK
         8lEIIjK2ahLjwAuKHSNmOwQYZ2tlhOx4REYPUOvvdezLfoBfqX+CrLQ0XlCAnlc54jie
         uCW3KkilNkoET0Ncfxqp+cN8d/G/MSEKX8uXn8o+LY6vmSjTCqMIw8AoDuii4rcs9Cgn
         MAHlf/durzEeyiSc1KZkVfx9p5C70iuwXqskwsrUF75pCOJbwhwn9U9M1TJsbLsOw6By
         N4qTj7pfUasjUpQudwAr1URjajxAMIP0Np4iS3UaIwjQXO/RD53QxWl9Hr0CGuxSU59I
         Mx6w==
X-Gm-Message-State: AOJu0Yz0g8vnu8q3k7tulQoPdcgisUyG5Fs6nLXOoiG/Sdcb7axnM8ie
	NeWL12LyKrrWEB3oG4Ui0CJKoiGELXlkwNWy9K6nJZmMD5VyvOaUYUhLz7VDJ8+NDEYklsM44EB
	P769QhjugY4JQAzbpK1ZyGHK+G0S5XbOw2wtKrCTtbMShVU0uOZsfwA==
X-Gm-Gg: ASbGnctakz3euegxl56QeIcNQajYRmV3DIMGWcgvbwgS8jYqlqSZUYLamCBBHzsF+Xx
	8qOnQn3XEElAPmmrUwfkyqbFQbvCOHcj6TAOL4c8fuAOCEs+fNCjDfuUNaxvX1ieXoidpwBUfdI
	C78nLO2AlvnhTbYZt/RukPamOyvyyq0oztSCXg6ihvce2dErgLPzEfi3g+DEF7luiln5x01tRYO
	KE5fJrVyeRu6vPmZDyr/78pJ8vaG7AgKtwrvPo71IFYWW8OKt12F/lbIoQq+2N21Ij7k5UvdU1K
	iHvnGIPD4mDM/eV+qY2O8fstKHETQk1PojA6oCZuuZwgMg==
X-Received: by 2002:a05:600c:1ca4:b0:43d:b3:fb1 with SMTP id 5b1f17b1804b1-43d50a3c12amr27977465e9.27.1742577420392;
        Fri, 21 Mar 2025 10:17:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXmuDzXPqTSEThikrCZrsZoY+pLPxk8KYhCByOBwIW1g4iOELgFv0n6PNkldha1e1yTwkn9Q==
X-Received: by 2002:a05:600c:1ca4:b0:43d:b3:fb1 with SMTP id 5b1f17b1804b1-43d50a3c12amr27977295e9.27.1742577419975;
        Fri, 21 Mar 2025 10:16:59 -0700 (PDT)
Received: from [192.168.88.253] (146-241-77-210.dyn.eolo.it. [146.241.77.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fd18580sm32045205e9.16.2025.03.21.10.16.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 10:16:58 -0700 (PDT)
Message-ID: <1eb2967b-248c-47a2-a959-699b13074d61@redhat.com>
Date: Fri, 21 Mar 2025 18:16:57 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] r8169: enable RTL8168H/RTL8168EP/RTL8168FP
 ASPM support
To: ChunHao Lin <hau@realtek.com>, hkallweit1@gmail.com,
 nic_swsd@realtek.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250314075013.3391-1-hau@realtek.com>
 <20250314075013.3391-2-hau@realtek.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250314075013.3391-2-hau@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/14/25 8:50 AM, ChunHao Lin wrote:
> This patch will enable RTL8168H/RTL8168EP/RTL8168FP ASPM support on
> the platforms that have tested with ASPM enabled.
> 
> Signed-off-by: ChunHao Lin <hau@realtek.com>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index b18daeeda40d..3c663fca07d3 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -5398,7 +5398,7 @@ static void rtl_init_mac_address(struct rtl8169_private *tp)
>  /* register is set if system vendor successfully tested ASPM 1.2 */
>  static bool rtl_aspm_is_safe(struct rtl8169_private *tp)
>  {
> -	if (tp->mac_version >= RTL_GIGA_MAC_VER_61 &&
> +	if (tp->mac_version >= RTL_GIGA_MAC_VER_46 &&
>  	    r8168_mac_ocp_read(tp, 0xc0b2) & 0xf)
>  		return true;
>  

FTR 2 copies of this patch and the cover letter landed on the ML
confusing patchwork. Please avoid duplicate messages in future submissions.

Thanks,

Paolo


