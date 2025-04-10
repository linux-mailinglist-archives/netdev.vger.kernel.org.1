Return-Path: <netdev+bounces-181187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F352A84068
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 12:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D3933A2654
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 10:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52F326F456;
	Thu, 10 Apr 2025 10:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YHsjUffB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0606F214221
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 10:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744280012; cv=none; b=g9RsKu7r9ok9ZutwHbVdsOGq1bdW/dGxyyrm3hQ+hBBwUlg6SB60iDihPpWN6hcilAXNXMyHkmfGh0umepsyoSvMD1BY/QdMNhneotV8+MauGHjpfb0+ppI3Gv5Tg2XYv7x2zCt632FydAVkuxlQNq6LjctzDQF8XouTB8x0SZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744280012; c=relaxed/simple;
	bh=qh/7xE9jYBR4inD18WmEbysfc3J/qJwkwzl+oF//M1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dQCtj2Yv1CvvLmJrOrx6s4l5mXEbtAPUcO2t07If55GPrDoHuODrycjQrN6m+GBtRbB5KMYviOqMMKOkYWY4cQmyEP/QnXFGwL3Z6NfnXU9oThjQ5JMuw0xZiiwRb6E7ZQ5KBAR/B7XZFe6WuWcX0cqiE5HMBATMQ4jlIDs93v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YHsjUffB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744280009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tAj3B7bSym7Yqx6QsE5lN7rIaC1PVWG5uhNZZR05sFg=;
	b=YHsjUffBMZNAV8RuIawVj04vC6qZwIIxFZX1cMkVbr5CODDBpLemVjJEHmIM/aAIEJsMDM
	afnB8RTP6TLh7SsygTVNJn+gv6nLb/VNBW0P9IZbxQ6jdbj/XUeInZQbJiCwUuMJg43zX8
	HyZW48ksZi06/ixabkBRZMNx3WJ0DTg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-CiLMsbJAODW-Gow592RkIg-1; Thu, 10 Apr 2025 06:13:28 -0400
X-MC-Unique: CiLMsbJAODW-Gow592RkIg-1
X-Mimecast-MFC-AGG-ID: CiLMsbJAODW-Gow592RkIg_1744280008
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-39d917b105bso225783f8f.2
        for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 03:13:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744280007; x=1744884807;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tAj3B7bSym7Yqx6QsE5lN7rIaC1PVWG5uhNZZR05sFg=;
        b=NEriuMgprz1LlVVhIc1cHrvlvjsZyU1JqQXw97JdeOnZCW9/04mUOO0s6xVdq8a8YB
         YB8A+YYUfRnV/B7DTInllzOKJkpbMh2aOyr7U2AdZCKBG0/3UDHOq9grVYW6ZIQuc4Xg
         TlfbkWE4qfVyE2cU+CykHlH6GB0CX8iXs8EdElirrVw0LqkXB07JCoBfTBB2fkg1feka
         2EuMKETTMG45LuCVIsgm2ku4CRH4ph50We5evNh0qQAndahk4JT6PJgh6D79txHeiYl1
         1sgiZruBtYPddCT+zAr8EllfWZamk0F7ZB+Q4OOsUISXShEtlUDjCWYkVf3MMUVkeM3z
         C0Sw==
X-Forwarded-Encrypted: i=1; AJvYcCViRUCcGJT0atzW+NuHqfguErHMIHh1uDBO8e3QxhyqR7xhD5+s+oLmVjJ1BYpHSRE2demo6oQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5hcWlUZlpmqtl1fZqK/hGxukyxyyUSamAceLKCXvEvxSag4Sz
	boHwDaf5SG+QQdNt3tghYzKssCt8zDyV/sru31Cfwj//EGg7pQ+jaDITNiOgkICfW6/Hve8gte6
	4nwPvVUcD995dCVlpPQ7RhTf2n8b4MUnE3NTyx1VRGAZ3F7JftZxc13IUwWJBfA==
X-Gm-Gg: ASbGncuw5oO6XmvLSeJjZXCuuNMfsMLiVZ+Pv9O3oATAEAPIc0CusSnpIL/rXbG8jwb
	OjTo3GrxSzwzZT1kYB/J3cpKVgV8ySpUDmJ3irTTEkfi+I+ELPsY5U1ymv74G8OfZnvkCNdWtWq
	g7fLU9u/e9oUWlx4JjA0LFGLg42nCyzt1rqNH0p8tBTmxqSaCafX6UXfGP8t/4UNh0zO6Uei/Wa
	gnTRHTZtBt6sWk85SA6Dy7oY0qiBbymBEjOXxpFgr2BmuixlejMSxVmLiXodWc66Dr7VdtIQxn9
	Rlst1WCgbjpk9TQ66BrBry2/pX8uaBf0sJaPHWs=
X-Received: by 2002:a5d:64a9:0:b0:391:3124:f287 with SMTP id ffacd0b85a97d-39d8f468f02mr1790558f8f.16.1744280007224;
        Thu, 10 Apr 2025 03:13:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYLcdiyN9shBQ+Y4lQOAZoqQWzvY4suliOlRFEMF7YG/fiyWSdXmI5wAeNDgdJMuZY9mV8DQ==
X-Received: by 2002:a5d:64a9:0:b0:391:3124:f287 with SMTP id ffacd0b85a97d-39d8f468f02mr1790542f8f.16.1744280006923;
        Thu, 10 Apr 2025 03:13:26 -0700 (PDT)
Received: from [192.168.88.253] (146-241-84-24.dyn.eolo.it. [146.241.84.24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f235a5e9dsm47533505e9.36.2025.04.10.03.13.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 03:13:26 -0700 (PDT)
Message-ID: <d72376b8-a794-4c47-b981-11df6e17e417@redhat.com>
Date: Thu, 10 Apr 2025 12:13:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] batman-adv: Fix double-hold of meshif when getting
 enabled
To: Sven Eckelmann <sven@narfation.org>,
 Simon Wunderlich <sw@simonwunderlich.de>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org
References: <20250409073524.557189-1-sven@narfation.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250409073524.557189-1-sven@narfation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/9/25 9:35 AM, Sven Eckelmann wrote:
> It was originally meant to replace the dev_hold with netdev_hold. But this
> was missed in this place and thus there was an imbalance when trying to
> remove the interfaces.
> 
> Fixes: 00b35530811f ("batman-adv: adopt netdev_hold() / netdev_put()")
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

You must wait at least 24h before reposting, see:

https://elixir.bootlin.com/linux/v6.14-rc6/source/Documentation/process/maintainer-netdev.rst#L15

Also this is somewhat strange: the same patch come from 2 different
persons (sometimes with garbled SoBs), and we usually receive PR for
batman patches.

@Svev, @Simon: could you please double check you are on the same page
and clarify the intent here?

Thanks,

Paolo


