Return-Path: <netdev+bounces-152517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E5B9F468F
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 09:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A76B188A8BC
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 08:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA5E1DE2D8;
	Tue, 17 Dec 2024 08:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aO3raycZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE5B1DE2BD
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 08:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734425661; cv=none; b=LDVwFEV1pGFtqvd5b3mONavuVhfiHSI20ix7WWZlU6IP2XviaLYBwXE7gd1ZE6d8QhZxBUfDoDhiiOroHsxBprGAS5uV/n/mXKTwhMDtqkPqfBClhKa0dDFUpYsSRRD4jQbY+OO9YLeyKfDj6RCEDUh/1cZ80JymgoTrLXUf4Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734425661; c=relaxed/simple;
	bh=IYpN1VVYlyC9PW1SyeSCibiTSUuzeqESTC578tdX7/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jcClW6EjQ218uDSbg29ANtKc/Zof7XApqpIsYs/Mn8A6kDUEQDAceG091QWr0Qu7qDAzp6eoPo4wMABs+O1RxRN7DRtoj0jP3Jh3bTNwn77ueTHEFGoOeylNBQCXuWbLiHXpUvlCsv1+mnrPibIl9SFHrQmHQN3yTn1wfZgzZik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aO3raycZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734425658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SsYhJqBXdWYaV/I7Ym1gevj9lOrxHxPlvWSxmyMp0Zo=;
	b=aO3raycZJkBCKJiro6y1q4wGPfNLNiIBZhmUGV/mFUkN5TUB1hapT72xId6Ev0xnhqaOMg
	pS5OAtTK6ObjO3jiViMDyqyblhcZeoyjWHFra/YE+Kev7zzf2PIJImORy99tUa+YNF7IXQ
	klbyNe1AkHs2zBs7yDsNk2l0DyhAx00=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-yML_Nqe-M7y8ovhEEeg-Qg-1; Tue, 17 Dec 2024 03:54:16 -0500
X-MC-Unique: yML_Nqe-M7y8ovhEEeg-Qg-1
X-Mimecast-MFC-AGG-ID: yML_Nqe-M7y8ovhEEeg-Qg
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6dcf01612f0so35090936d6.3
        for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 00:54:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734425656; x=1735030456;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SsYhJqBXdWYaV/I7Ym1gevj9lOrxHxPlvWSxmyMp0Zo=;
        b=gVU0kaexFX+SD4ES2GX6/NTfhC8+3JEqYMdKUeFmzLbn358laRKF6VDzvfhHQ0Ww7d
         vfrQg3TobXGgkyYNbLYTYEGc44jhzrBVmTWI9KN9tMn2o5Z8PgJgoVmTnJlpAlwjfHje
         ReueAAmY8yiRCHk8jgX2i4rX6SfrJUks/R6b+j9gX8jNyBA/qjC1HFlA6Csyw12OOI9G
         wYmJnO1blGHyzBrNnvEyjhnJGi2j5f/2ekTo3EtkJf9MhQ5J1Eqv+hW0Bt50leKskpCZ
         tXehJFY4Gw/E41TRTlm4hc+WNbni6mZ98XLBvceI8h2vhO0sXMbD1GTAn9j+01R/nPAD
         ImUg==
X-Forwarded-Encrypted: i=1; AJvYcCVIS6HZsH/nbOemkx6ACvqmykYfJTsf8Tw8IJvgG34M9cH/FoQ146f/D3HjH6vK7TPhAK44bhk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc68z8dOByK72xdAsOpyhWxpOqLMlHhoOqzKghPm2a/zq3HDge
	u8xkdZiXQkyq7Jo28Ft5Ah2NRaTJ8lnzEOnRspijFw6YF1WQR5VN/UbyL4V30EvRjUr94gi/Ww3
	o0mvZKCo0UBRS59cypxHRXuyGrOJlZLtxYzdeCp0JO091T8y+oH0Blg==
X-Gm-Gg: ASbGncsFmsr6Lr+hBaat5OGuEzeJ4vL+LjUlv1H3SdrUPe6Pu/Czfo+sISeQ5sZ4vfT
	AaIVvReaeZ0PmgM1kdiUM79iwNO9uX2P0+soxyUEGW48xHSArJRmnkqD+wERJeKy03P7K82A5sc
	Y4GQHJt90n48J9UzkxdyN+Y+iz2g8bmeNDq8FHNgnMxqxavIA7Vsn/mDQLRkfZRwbtRO9AsHkrr
	IW/S21nj3au0vAunZdqjPBbEPYRwK8tQ+QZUVpsZGyVbrWRa65/jvHkzup2o6XGw2rYv+CpWx/Q
	weVgEMjiKQ==
X-Received: by 2002:a05:6214:1d28:b0:6d8:e0a0:a949 with SMTP id 6a1803df08f44-6dc96873172mr243412026d6.32.1734425656447;
        Tue, 17 Dec 2024 00:54:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFcm8GyO90b1t5sO+KCBoWpLV+afNYkxyBXUbffk7IskhsQSen9pfMAJkBAXdbYUtYCj4WRZw==
X-Received: by 2002:a05:6214:1d28:b0:6d8:e0a0:a949 with SMTP id 6a1803df08f44-6dc96873172mr243411876d6.32.1734425656174;
        Tue, 17 Dec 2024 00:54:16 -0800 (PST)
Received: from [192.168.88.24] (146-241-69-227.dyn.eolo.it. [146.241.69.227])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dccd22f494sm36350226d6.18.2024.12.17.00.54.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 00:54:15 -0800 (PST)
Message-ID: <778db676-9719-4139-a9e3-8b64ffa87fd2@redhat.com>
Date: Tue, 17 Dec 2024 09:54:11 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] rust: net::phy fix module autoloading
To: FUJITA Tomonori <fujita.tomonori@gmail.com>, kuba@kernel.org
Cc: davem@davemloft.net, edumazet@google.com, rust-for-linux@vger.kernel.org,
 andrew@lunn.ch, hkallweit1@gmail.com, tmgross@umich.edu,
 aliceryhl@google.com, boqun.feng@gmail.com, gary@garyguo.net,
 bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@kernel.org,
 ojeda@kernel.org, alex.gaynor@gmail.com, netdev@vger.kernel.org
References: <20241212130015.238863-1-fujita.tomonori@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241212130015.238863-1-fujita.tomonori@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/12/24 14:00, FUJITA Tomonori wrote:
> The alias symbol name was renamed. Adjust module_phy_driver macro to
> create the proper symbol name to fix module autoloading.
> 
> Fixes: 054a9cd395a7 ("modpost: rename alias symbol for MODULE_DEVICE_TABLE()")
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

You should have retained the acked-by tag that Miguel provided on V1. No
need to repost, just for future memory.

@Jakub: I still can't reproduce the nipa (rust) build failures locally.

/P


