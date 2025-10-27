Return-Path: <netdev+bounces-233129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD24C0CB94
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 10:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3143E189CA5A
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 09:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866E92F28FF;
	Mon, 27 Oct 2025 09:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7iaH7qP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C16245012
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 09:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761558025; cv=none; b=uWHiWbAjGWtv1Y4gq1+EB6eKeyfjH1SGg3YSGFy2zDJUWNZ8+zROhXvP/OHU9KdR/YYT1hyVMn3ei6hkreLgsuSoqaQytw3z4H2aVgOKFoYE0SMdiR1kCdptfwqDciJPJhFMQIz1CUZohN/NCUNCDAR7wfv7Gs9Q/R1nHy4R6ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761558025; c=relaxed/simple;
	bh=OBK/hlc3IhBJpXPcTuCdhYTqauXBw9jA6wbePkL5/aE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ToaEnnStFqSR6il9tI19AeHrkc6cvoKF5LLNeIgPJ6Kwdbgn9BzizixojbPxSk5icOm6+7IzfhuvQGy8tLZyxS3w1GuWZwxZzVXqabUT5ktbrbroiEo+ApwZ8+LI59vnS1wPcKkcuMo0ydFuz5YpT/M8wgSNBsLyfo+3fjvB9+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P7iaH7qP; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-33d463e79ddso5548188a91.0
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 02:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761558022; x=1762162822; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZhBVqQ4OBoFRlZguHQ3+Rolge9D6o3ln7YwlfvJX/I=;
        b=P7iaH7qPKZkfVaRsEXo933cmTWOTJpqFojapEWSk+XcKdvMLVMEDTfilaeO+Bpw1Qf
         smUvKDVltcMXaGvdY//mjzlqW4El8i7jjXfLaJPdWP2xr5Zsm4vjod9ISsol0XLAOHeu
         X6Sx2F7kiEmdMCuGaDuCoqPgiIqbGd1xZ3oRs0l9F+OfbEPM2OP7ijSYdjGAmZb1Xzqo
         bf4hYmXQbaHbgm/HyBnzTbRP4LR9W8tvbAU6qIy32QCacSAAfccvT1iK1HY9SwBCZAoi
         i3+HzbmdLmoz4UXIeBSHxNTMtrrCWd1rbLelVs5VZvGrSKElIG94DCVsMBRASBdr9bQd
         IOwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761558022; x=1762162822;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SZhBVqQ4OBoFRlZguHQ3+Rolge9D6o3ln7YwlfvJX/I=;
        b=Z164HEW1hDaTnlBNidrJLiatV140bKqmJ6tXqwpU7u3zP3xeA8CWcUoKW48agxyjsi
         n+AZmXJw2cSdrhimnvFXjTJ4pIa/FSbkoqWd6f92ezSj/KTn1QRvYU4ZamKI2YqCpGIp
         g1Z+LxsjJvB3YrC+8N/+auGkJPwKEOJNIbxQpGwz92Kz4dXcdZ9P4HMdN8SFEfF5eXnu
         OT9hKqT689jIc2cF43sq9zgqEgB3BhtyF7bqgRTNzOYZT+8QAr/zVkSSXGrJPODDkCpr
         syl8VbbKwogX12jL79kQxC5VJJzq5HOHyiYmD/eDu0ucSA8p0Y9cHiZn+F+uVRh2K3TM
         PJDg==
X-Forwarded-Encrypted: i=1; AJvYcCX20KN9bvlwAn3iTDVvWsDSuOzOXColXyU+F3ZeYeTe+NjqyZyHs6Y5kqNkhLWFQ7rwFYdLxwY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw44zdK/q1WExkUgjVSdcwRZRO+tKzf638yIRdK7buSre1LYuSN
	t8kXcNyvHIOpM9nyo6gF44pwaCDri+BXqBJadTcf84GoSve4ZjrgzGoq
X-Gm-Gg: ASbGncteTQ1zhxGjktSKqVn3e5m0bL+PFQkiZf6z2EaO7iqbyDtTCsXpMOwMfdw8pMG
	6wr06ckmNULwynJC6D02cwN1S6VHlXq0zX7ZTznC/B0fWXB1E71ag5MRr4zTna7MozCsiASeOON
	B3KzBIGNHFqWYuWjkDH3/1eI4KQrlnBsTeoSB1vVhevbWHJlKxHalyNRFlXXUnv3a4eM/uWuwhj
	yoEVyjd67BVPr2b8tmQuRtdk6/WLnhw41JCHa81yX1wZCmD4chHd13LibmeW68DbT5sW2xWk/AB
	bpbQJ6caoxH1Ng3ACx92CYZ/ypZMHOqXShorfzy1KrsxEuQWSRsmsDI1OeDk61rUbdy3JimNAIu
	VFwUVSmSpOC7lZ/wNKd/lIIkveo6t2X6IEbrj88YbI+io0Ls9aL6MwUdhenIKww==
X-Google-Smtp-Source: AGHT+IH1lzON7y8FAZpNw0PHIHHwRPVZE8rQDV1gpMfPb9o5k0miwVYUfPby0HNCF5HieZEKoNhNig==
X-Received: by 2002:a17:90b:28c4:b0:32e:d649:f98c with SMTP id 98e67ed59e1d1-33bcf85d5a8mr45413074a91.1.1761558021739;
        Mon, 27 Oct 2025 02:40:21 -0700 (PDT)
Received: from CNSZTL-PC.lan ([2401:b60:5:2::a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed81aa87sm7800126a91.20.2025.10.27.02.40.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 02:40:21 -0700 (PDT)
Message-ID: <b7850571-4e9a-4b9f-9776-8c7521b84549@gmail.com>
Date: Mon, 27 Oct 2025 17:40:13 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: phy: motorcomm: Add support for PHY LEDs on YT8531
To: Andrew Lunn <andrew@lunn.ch>
Cc: Frank Sae <Frank.Sae@motor-comm.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jijie Shao <shaojijie@huawei.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251026133652.1288732-1-cnsztl@gmail.com>
 <70e72da6-9f07-457a-9e0f-c5570ab6fe9c@lunn.ch>
From: Tianling Shen <cnsztl@gmail.com>
In-Reply-To: <70e72da6-9f07-457a-9e0f-c5570ab6fe9c@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

On 2025/10/27 10:10, Andrew Lunn wrote:
> On Sun, Oct 26, 2025 at 09:36:52PM +0800, Tianling Shen wrote:
>> The LED registers on YT8531 are exactly same as YT8521, so simply
>> reuse yt8521_led_hw_* functions.
>>
>> Tested on OrangePi R1 Plus LTS and Zero3.
> 
> In future, please could you put the tree name into the subject.
> See:
> 
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
>   

Sorry I missed this. This is my first time sending patches to netdev, I 
will follow the instructions next time.
Thank you for the information!

Thanks,
Tianling.

>> Signed-off-by: Tianling Shen <cnsztl@gmail.com>
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> 
>      Andrew


