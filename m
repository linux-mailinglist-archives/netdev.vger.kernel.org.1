Return-Path: <netdev+bounces-168180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFF4A3DEBE
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 16:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A00F3188F5C1
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 15:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D9B1D6DC8;
	Thu, 20 Feb 2025 15:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="STiiFojI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58511CAA6E;
	Thu, 20 Feb 2025 15:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740065755; cv=none; b=WRZ8pluyWLBE5c9AQea/hnyKbYGeDonp4JQtXn5PNTLtSVBd48N69G3GhsODc7wcFlUPyKRdXKaCUR0MK2l6KBCwYv3Whjh5YXrqTIVAbMsx9xRGNSPlhUGYdH06kn8eFliqLXRzcUYK+MyzM7RqgQycVzcQXPbZ9Tkf7B5Zjb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740065755; c=relaxed/simple;
	bh=9nv/cYIcD32ddhH44H9OjS/Tdj+zze238Fz7pf/cv/E=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=UKdRyQcb9B9GnQkhld1Tw9D4nIAPaCdyz8EZ2f5gn/TNZJSU2qnDVVzKsUFZiB4SzBPcIj8EsUW09UE+crT2vD6YJCP1ijtHaLT1ee/3wdsx/2zQrPa+Kmd6tjpR0bQfVn6IoVU5vGTWZYh1jXyRsvU2Ar+JHOWVrTlFIYVUCO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=STiiFojI; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4397dff185fso9521335e9.2;
        Thu, 20 Feb 2025 07:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740065752; x=1740670552; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hQVzt3Q5mUQsNaypGsAUlFBMvFluRZ8UVc8nJz0lyU4=;
        b=STiiFojI82wkhTbGaNhWvZk3g1Btt8mSsvWLl/M8mpp+UIlNWzHhTtq8AioQa9OHoz
         IGnjE83RgJUZAVcq+ldAkzCQ5Ek/aiatvmqlpG6CbIixnNJiHWjMY+g30XdQn8yacifV
         4h52WiHjyUxZu4Chyfn1uUFs2f8JfO2YPH1028mIVJbeg2IeIb5bZiUDaksYmh1E8eOk
         tQ7sDFrB3z9vXojXSFD8it0kvlR5q6Qu+7r7Kw8SFZqiHaAJ1DOL6NuoM/p1ZOpszLk3
         Jbx6EayzkeHteTlZaEzKkjVU5ni/TvdNrlhnl6BX0es9s9eGFahpCRUT144l/+8c83/b
         +r8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740065752; x=1740670552;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hQVzt3Q5mUQsNaypGsAUlFBMvFluRZ8UVc8nJz0lyU4=;
        b=vG47D0v8WBmYaNAFSxKyrofOmvf/ab9278dg1Xg02wbymJaJtN7D9M6csS2L3wpKvo
         GLaxjlfJHuFj97o4gM/gk2PpktpIhS+phcEKTJgDixOiRhm9WImWDVNjEXNjymEZDJtE
         WFg03o+DzmEO+v7e450JpiUMFt9qSx3mVbZE2Kj2LZKts24TJmsdfEqrDnck4dzBSVCp
         kFZ/WcWdHt86QKn0/lgJXz+j8phqsfA0f1klT7+ayr7suVhIdZHkJj5NyT1fR8pN/vEM
         UJ5FG3qh6mXajfuXajQV3eidoEs14bd4g/kQKto8hVC0IVHGXtons+fC7h9sBLZ6K/eO
         EvoA==
X-Forwarded-Encrypted: i=1; AJvYcCXerWg73uYWyGC46luhoo6H4epR0N8eFwUPpJ8bAoan5HjUBcahR7+gqJVKdeNzsaJ1/sl7Il2N/rlo2is=@vger.kernel.org
X-Gm-Message-State: AOJu0YydVnhZbHnfDTWDP9txzZGiyNPJRxtf1AMcA9WPMfDhX4c/KmRu
	84k5pos7h1p3iMOZLseTdGI8/FefmRthTVWCylnTTBj3rtSppPMI8tjp4A==
X-Gm-Gg: ASbGncuixLoc7guztElK9nZt1ntIy0k6LGN7jQi9I7t9vsxd0u+XSktVhOG1SYIm9iT
	S2ZLVswZBlZKz/uL7uZH+T/PNRnwCKz+yvRp//DKL1Pgt8UURR1h3LrydIin5UF1tA56rkP6v9O
	ZDF8A85ED4pDrZF6DnF3iLJWEM5FyzEgmZjGXlQQ6hVx+fkeMv1BlsF83AVdRU2YcqogtaA4KYV
	f+d8T+Q6f1tGjbarP6rI7QQl/U996yj0wSQaJhcDbZJlUWWq4NLmwhH1ldW0ezKfEyAnE0RwQky
	5Xg8nsf/+j04g/uQLv+Dm5RRaHfPXi5Dnerm5jM4Z6XC/n4M2pEL97Q+HkIq5psZVtpJdA5ibfP
	MIpc=
X-Google-Smtp-Source: AGHT+IHJ1J65yJX9Zdi0qFRx80nkkCHdoOKjy1wYpeHaS6dVyus1BTaO0fZMNr2FWw4TRmcHmRMYww==
X-Received: by 2002:a05:600c:46ca:b0:439:8185:4ad4 with SMTP id 5b1f17b1804b1-43999ddad86mr73682795e9.27.1740065751923;
        Thu, 20 Feb 2025 07:35:51 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d9be9sm21261113f8f.79.2025.02.20.07.35.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 07:35:51 -0800 (PST)
Subject: Re: Null-pointer-dereference in ef100_process_design_param()
To: Kyungwook Boo <bookyungwook@gmail.com>,
 Martin Habets <habetsm.xilinx@gmail.com>
Cc: netdev@vger.kernel.org, linux-net-drivers@amd.com,
 linux-kernel@vger.kernel.org
References: <CAHiwTZ=O=sHBD1RCZgAWRRo3Kb-DQvWdu_7FSws=Zxg+TM4Dyw@mail.gmail.com>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <92115b07-a0ba-1881-cbca-3798510c3f16@gmail.com>
Date: Thu, 20 Feb 2025 15:35:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAHiwTZ=O=sHBD1RCZgAWRRo3Kb-DQvWdu_7FSws=Zxg+TM4Dyw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 19/02/2025 10:04, Kyungwook Boo wrote:
> It seems that a null pointer dereference issue in ef100_process_design_param()
> can occur due to an uninitialized pointer efx->net_dev.

Yes, your diagnosis looks correct to me.
Moreover, besides the calls you identify, the function also has calls to
 netif_err() using the same efx->net_dev pointer.

My preferred solution is to keep ef100_check_design_params() where it is,
 but move the netif_set_tso_max_{size,segs}() calls into
 ef100_probe_netdev(), after the netdevice is allocated, and using the
 values stashed in nic_data; also to replace the netif_err() calls with
 pci_err().  I will develop a patch accordingly.

