Return-Path: <netdev+bounces-221168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C72B4AAE2
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 12:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30047346E95
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 10:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9067431B122;
	Tue,  9 Sep 2025 10:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OPN0j63z"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F503191B4
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 10:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757414696; cv=none; b=o7AdfbJLBn+w/lh7WygCUf9WwL8VU/rQo1eu91TIdCOibTmX6InZoWPWNt3VOG5r6JoRDENVp8necxZ3NpCfLq6TFJFnVgh1c7zLaqbUFt6hMdrcSxAQ5ZeWiDlGCJTFeTJPQx9rPktxnRoPnGb7JrmkojOpii69y2Ro+BT9c/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757414696; c=relaxed/simple;
	bh=E9sQQC+oJzKvjx5QP4k5TB8Hx52KcvkCmfJrpdRcU4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VbSYdxgMvdfjxKogViod0sekTe7jsxL7e7dASHkpLuKqJr8Pm36aYrR3+M5WE+TVsvvExng4SUoe+ALnLerfyl2LZb3A9ias2XAv1c91dLCH22B1VElzXHzAsnGQWU/Hv794owJ4iCz6J6pJAhg4QO8Eal+ER4WN/Qj8JNZ2Q+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OPN0j63z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757414693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qd5lahvMq5oZ4/GMZX4FLRiRyB/MiUEuNG5RMyK7tAI=;
	b=OPN0j63zzHbHWWr/oYH6XspeSbizXqOWwByq7XOg11cojy7GYlus79XjewEs37I7p+aV7b
	lW2F1q2WWsChribHi7jD4LMuU1jNlJwV1j0Rl3PlEOzjdMvv37JA7pE8joHaAnUbd5BzQ2
	2IE3GBecdUPE150VQNVw5RMNFQmkaEU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-tvjgj6JxNpSTgdnxf8sDFg-1; Tue, 09 Sep 2025 06:44:52 -0400
X-MC-Unique: tvjgj6JxNpSTgdnxf8sDFg-1
X-Mimecast-MFC-AGG-ID: tvjgj6JxNpSTgdnxf8sDFg_1757414691
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45ceeae0513so30955745e9.0
        for <netdev@vger.kernel.org>; Tue, 09 Sep 2025 03:44:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757414691; x=1758019491;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qd5lahvMq5oZ4/GMZX4FLRiRyB/MiUEuNG5RMyK7tAI=;
        b=VEp0vMEn4b9LpVbKjuWAZ3h1cz3/V3IrmIoQWkSqNuarHX2QrytbCdshzWz9Jwd+Zu
         AwWp05H0vTSUty6EbPJjnNuNiomAd1XYYHJvyIiBsel0vSH2KnXp9vDKjP9oS/x54L7R
         c6OSJk5olZuVIA+XVBM0tA3WtqtGnsci+Z6bhaXj4sCl7/aoDM9jlum2LOt5tCpkddcw
         sKAD6JadmLYcRvtuT90izVEg8In5yjcsSTcBithLDepGTFe+bgwkHQp7oReywQDPdiT1
         B3fnSqU8sXF3Bsndgr2vGQb90qto5jaNAyzsLnA8XoVyYfVoG8MdsGwSFXHHSNTxxqwp
         YEcw==
X-Gm-Message-State: AOJu0YyAgpM4D43cH6yXX6fhbX9a/JTu9A5B2tdDmmCi5T+5FfQ0hzt9
	iwlNPn+jRTDXxlwvSDFcsRbaZJWT7RSnURsVNkBwhmEAEiND5CjjMPKsC4azHS1GR6G7WsvICeB
	SR7U7JpLIWAkzpWrZYqQn9nxwU64ZsxFc9Zku5t8kzZvTjXwhjYPrYDjkPEOvc5QGDQ==
X-Gm-Gg: ASbGncvZmScWRnsBwHc1RxuKB4RqVc8g5Hs87g99pnqO2bMe+VE+BPxp3EQx8L4AUdN
	FMDDE8Uw5v3CUpS+xsn9kbSf9j5k6EYTrHt2ubz4SED2CvyLyux+E/A3LxnaL0clX5kgTT2+Ddg
	5p1mh+VRSa5xlkCXu3hAp4pe7kPlDDAmsJmaEK3Fcdi437dExylArEiBVK2y0y+vazDBtWGVLBU
	M8y2E29uWGzBowGTutayMh+42VOXFkP5fRGvesSUJ/KQpfJnKlgC6A2m8lXJUmHChEKCWmuAHQL
	Nld9Km1gS7bJ6NkfS+pR9/3h9jfup8mF9aRWDDK/rvRzW9NZdNXT3N8IqovgVQHm/OpNYDRt4Hx
	B5esAxbBPTcU=
X-Received: by 2002:a05:600c:474a:b0:45b:7d77:b592 with SMTP id 5b1f17b1804b1-45dddea4cccmr109318095e9.12.1757414691040;
        Tue, 09 Sep 2025 03:44:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEYwr8VajBjqME0t0QTI7pIg/zbnkramgkYYoZ5e0kigVe3ZeHNoGD1nwIIULzlEMTmQxN4Q==
X-Received: by 2002:a05:600c:474a:b0:45b:7d77:b592 with SMTP id 5b1f17b1804b1-45dddea4cccmr109317825e9.12.1757414690440;
        Tue, 09 Sep 2025 03:44:50 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dd60b381csm185191125e9.17.2025.09.09.03.44.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 03:44:49 -0700 (PDT)
Message-ID: <c1cc283e-563c-41c8-a06c-360e1f272900@redhat.com>
Date: Tue, 9 Sep 2025 12:44:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/2 next] microchip: lan865x: Allow to fetch MAC from
 NVMEM
To: Stefan Wahren <wahrenst@gmx.net>,
 Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
References: <20250904100916.126571-1-wahrenst@gmx.net>
 <20250904100916.126571-3-wahrenst@gmx.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250904100916.126571-3-wahrenst@gmx.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/4/25 12:09 PM, Stefan Wahren wrote:
> A lot of modern SoC have the ability to store MAC addresses in
> their NVMEM. The generic function device_get_ethdev_address()
> doesn't provide this feature. So try to fetch the MAC from
> NVMEM if the generic function fails.
> 
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>

For future memory, please don't mix RFC and non RFC tag in the same series.

Also the correct tag for features change is 'net-next'.

Thanks,

Paolo


