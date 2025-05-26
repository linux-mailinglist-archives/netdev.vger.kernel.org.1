Return-Path: <netdev+bounces-193472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC018AC4299
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 17:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E370C3AFBDD
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 15:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971D21EEA47;
	Mon, 26 May 2025 15:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BxCdjg/Q"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59ED288DB
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 15:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748274773; cv=none; b=KmLuuYrCn4ByPykRdvGocn+rLEnkv3cfAsGWGkqCBbUM8NSAw0ENYNDkXtiuAkB7J2vGUCqZuVHTbun1goFLf2jnQI88PdNSsuEj7H5hTdZ/87lqZli3IRIhCfV2OIW44c8Xmm4txxxWsZcEnTC/Ehaeh18KU5AotGy9jfqwVJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748274773; c=relaxed/simple;
	bh=hXQlU5hDPSnSpoYT/2MeCIti0XwhSV/H2gkqPtjUpzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZcLjU0fE8Wru5FY+blTed0amEu2IRxRAXXJ8g1c/m2YSMLyVlQ9Yk4XNr/645hli3nByyfDMvvcD0YnoPoQ8iUOy7gPeBxIKFc+lCADzb3amyqZ5XpK65XHkNHbValboZ+yG4lNdK/U9XxuDGEEUWUDDwAbLd2+nfOW5uKHN6GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BxCdjg/Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748274770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=57n9cWKD1CqPT5vf0zkaz18Pi54slgnNrO8KdNPh3/M=;
	b=BxCdjg/QKiqJ9dEbPp45MRS+XtAz+4o36oBigdSHo/O56cQCipkGFZEAnh7ConFfnYSpBb
	h2hrCXdEI6iFmlrZlOcWsvzW5GMex61rjYCbb0zH4RlesHQ9LmVf68xQPYEQWZqth4ea+s
	TN6BkTPWsqKkLx98OQ6ZfHYj/82wwRQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-nT3uG27sNwyPwOE1BzlJuA-1; Mon, 26 May 2025 11:52:49 -0400
X-MC-Unique: nT3uG27sNwyPwOE1BzlJuA-1
X-Mimecast-MFC-AGG-ID: nT3uG27sNwyPwOE1BzlJuA_1748274768
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43d4d15058dso17671025e9.0
        for <netdev@vger.kernel.org>; Mon, 26 May 2025 08:52:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748274768; x=1748879568;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=57n9cWKD1CqPT5vf0zkaz18Pi54slgnNrO8KdNPh3/M=;
        b=pNOzjE3g+1A9rmJjyIvFgyUdzaWznJC3NvStfwp1Gw40WsenBbNMEHRhPme3MVfY33
         ki6JMJqXuUCfgsuhsO6jYc2CxNMYY+vMYpZ4cI5WBLsdCpfcwxFvKaDpaASMrMGGkJiO
         xsAgLcQy2foT2B7dRLfGsktjkLlux7Qb8r8lIbRwACY5b/Ozoqacef9E35YRmy2QEPA3
         patLkAB93vS865IEF0Dq0EIneisTxGNcq6GUKAo258eNC5aCq4Pm1AVdz8MJiBRngewD
         cdPm/gqgjxdPJtC19R8XV+FpwO2fKKxH3AjlmiMIbr9d6VwEmCKhn+etJgsSW4rd201z
         2kSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHu5ebhmqc/9qNwyMU0Lv4bnbK9tMLzJsvUeA/dpe+UE0v7P2dU8vIsPVeCShmFD9QAG6FqiI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5rnk0zcwNp1YFctB9mATzIPtv/wtf/PM7h8f7ZVkx4/zFsATr
	oDtYvnMow55MvTlh6MYt3cqiWCR7RBxX3gfHZm6Q29S8g3viKahbRvSZcea3mHQiiNOkMAsJwF3
	VDC50ZyURt2gi4lawN/gV79JcEfYIkzq0Cy3orBLzpO6Z+YHovUiZQpQ9tw==
X-Gm-Gg: ASbGncvrLqSP1HYtU6823Ggd8fP/FA5Xb7gDz313zZ5N9MM5IdFSZ0V1fuYAEQkTmUA
	4qqn5zCdsI0YcJLzG4m9AwMhU99zS+jSa28WzpvezzFDavkh41yNCFe5cWAlClzoNo22zKKc+L3
	Cx01D10Cl2ZVdKtxtPgwKWwfQEZiLXNaMevECsQuZGcGI2dMo7pA3rowxVtVdY0YG+5pgYwrMyJ
	W3d9N6lD7nQRAB3RhddReH0rJLVqt/iq7D9X3+zMZ0l0QtthfTnvZ5wRa8cKUwGCrsMuTwJRTzx
	7EviAlL+oabvw6hF9qM=
X-Received: by 2002:a5d:5f8b:0:b0:3a3:655e:d472 with SMTP id ffacd0b85a97d-3a4cb488fb3mr7642316f8f.47.1748274768013;
        Mon, 26 May 2025 08:52:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEN47fpn/T9Jm4PX1FQ06RT0WlTdpeLRXSdg6wNV/5dj7HRkCajk3clqE6YsnVlmQapeIsINA==
X-Received: by 2002:a5d:5f8b:0:b0:3a3:655e:d472 with SMTP id ffacd0b85a97d-3a4cb488fb3mr7642272f8f.47.1748274767604;
        Mon, 26 May 2025 08:52:47 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2728:e810::f39? ([2a0d:3344:2728:e810::f39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f6f062fcsm236444555e9.15.2025.05.26.08.52.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 May 2025 08:52:46 -0700 (PDT)
Message-ID: <91021167-6061-437b-9798-70f059698fc5@redhat.com>
Date: Mon, 26 May 2025 17:52:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 net-next 0/8] PHC support in ENA driver
To: David Arinzon <darinzon@amazon.com>, David Miller <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 "Woodhouse, David" <dwmw@amazon.com>, "Machulsky, Zorik" <zorik@amazon.com>,
 "Matushevsky, Alexander" <matua@amazon.com>, Saeed Bshara
 <saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>,
 "Liguori, Anthony" <aliguori@amazon.com>, "Bshara, Nafea"
 <nafea@amazon.com>, "Schmeilin, Evgeny" <evgenys@amazon.com>,
 "Belgazal, Netanel" <netanel@amazon.com>, "Saidi, Ali"
 <alisaidi@amazon.com>, "Herrenschmidt, Benjamin" <benh@amazon.com>,
 "Kiyanovski, Arthur" <akiyano@amazon.com>, "Dagan, Noam"
 <ndagan@amazon.com>, "Bernstein, Amit" <amitbern@amazon.com>,
 "Agroskin, Shay" <shayagr@amazon.com>,
 "Ostrovsky, Evgeny" <evostrov@amazon.com>, "Tabachnik, Ofir"
 <ofirt@amazon.com>, "Machnikowski, Maciek" <maciek@machnikowski.net>,
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, Gal Pressman <gal@nvidia.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, Andrew Lunn <andrew@lunn.ch>,
 Leon Romanovsky <leon@kernel.org>, Jiri Pirko <jiri@resnulli.us>
References: <20250526060919.214-1-darinzon@amazon.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250526060919.214-1-darinzon@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/26/25 8:09 AM, David Arinzon wrote:
> Changes in v11
> - Change PHC enablement devlink parameter to be generic instead of device specific
> 
> Changes in v10 (https://lore.kernel.org/netdev/20250522134839.1336-1-darinzon@amazon.com/):
> - Remove error checks for debugfs calls
> 
> Changes in v9 (https://lore.kernel.org/netdev/20250521114254.369-1-darinzon@amazon.com/):
> - Use devlink instead of sysfs for PHC enablement
> - Use debugfs instead of sysfs for PHC stats
> - Add PHC error flags and break down phc_err into two errors
> - Various style changes
> 
> Changes in v8 (https://lore.kernel.org/netdev/20250304190504.3743-1-darinzon@amazon.com/):
> - Create a sysfs entry for each PHC stat
> 
> Changes in v7 (https://lore.kernel.org/netdev/20250218183948.757-1-darinzon@amazon.com/):
> - Move PHC stats to sysfs
> - Add information about PHC enablement
> - Remove unrelated style changes
> 
> Changes in v6 (https://lore.kernel.org/netdev/20250206141538.549-1-darinzon@amazon.com/):
> - Remove PHC error bound
> 
> Changes in v5 (https://lore.kernel.org/netdev/20250122102040.752-1-darinzon@amazon.com/):
> - Add PHC error bound
> - Add PHC enablement and error bound retrieval through sysfs
> 
> Changes in v4 (https://lore.kernel.org/netdev/20241114095930.200-1-darinzon@amazon.com/):
> - Minor documentation change (resolution instead of accuracy)
> 
> Changes in v3 (https://lore.kernel.org/netdev/20241103113140.275-1-darinzon@amazon.com/):
> - Resolve a compilation error
> 
> Changes in v2 (https://lore.kernel.org/netdev/20241031085245.18146-1-darinzon@amazon.com/):
> - CCd PTP maintainer
> - Fixed style issues
> - Fixed documentation warning
> 
> v1 (https://lore.kernel.org/netdev/20241021052011.591-1-darinzon@amazon.com/)
> 
> This patchset adds the support for PHC (PTP Hardware Clock)
> in the ENA driver. The documentation part of the patchset
> includes additional information, including statistics,
> utilization and invocation examples through the testptp
> utility.

## Form letter - net-next-closed

The merge window for v6.16 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations. We are
currently accepting bug fixes only.

Please repost when net-next reopens after June 8th.

RFC patches sent for review only are obviously welcome at any time.


