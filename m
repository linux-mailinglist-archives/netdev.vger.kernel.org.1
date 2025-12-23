Return-Path: <netdev+bounces-245843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7855FCD91BB
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 12:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EAA030124F3
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 11:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77F532BF2F;
	Tue, 23 Dec 2025 11:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TgR+5gUZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JX3pmpJp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D42315D3E
	for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 11:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766489294; cv=none; b=PQsIrhhn+V//k8YRo0xNVh7IbnXvAuoXYSmp+WCjMTIWzuT7nGjullcnvDG/eDxlLLY2IwJun0HCACQq0SWSiUnXUWRfjOdItYaCSBeUIa02O+MgqNBgcjDJBtgl2dUhOxORx1j7CZysICpEUCIrXGbiaJzZ+FV+LcV/dQuWOPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766489294; c=relaxed/simple;
	bh=RgW/8V+hhXXLMxh2ZD0gO3zj5swpvL2VBQs3M7Qz7hA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dizzPURA07dpdeAJWQgE3uZd/ExGW4D7xvc6NN13iW70uhvsanQndy/rW/Sqfn5aNunNzsOpauw/MPvWH29tqXH5huQJRhnCdqt4a1afcbc5mGC4i2VbWYfpM6IbulBwfMx+f4UemEBx+YyKAW7U+I031LkATQXq0LU6/8+ka74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TgR+5gUZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JX3pmpJp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766489292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=onfWSIfZZxCxgUeBk1t87PeUwtH8Jr8hx54o4pMbZFY=;
	b=TgR+5gUZaLIyiMhcADbfyk8FTzvpmoMBWyfrc/qeoBdC4VLNNLW6Fl3llIZJovoKTgAsnk
	IOPgy+IuF76nLCcnx4/DGPsHyvhgiZeaN0FiGCPFAWJZyK1oyAhTdGUtXC9j0jUYtveb4U
	vDMfN2wnNkl4SumzjXN5I8wf5zbUCZs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-kmTRaKBmOhmL7XHB2gEgYA-1; Tue, 23 Dec 2025 06:28:10 -0500
X-MC-Unique: kmTRaKBmOhmL7XHB2gEgYA-1
X-Mimecast-MFC-AGG-ID: kmTRaKBmOhmL7XHB2gEgYA_1766489289
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47788165c97so27875535e9.0
        for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 03:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766489289; x=1767094089; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=onfWSIfZZxCxgUeBk1t87PeUwtH8Jr8hx54o4pMbZFY=;
        b=JX3pmpJp57LqdPpJ09R13Dr9G8gR8ljK5HPzrgJ91UXeODwTDZb9cLG1e8+qEG3l27
         AHwZVAan1ppLMX0WQdQpBtjBJ2fT9wRRgGmwAS3eKiP8BbnZPM9a9J7lLw7k+Zs6DjsZ
         S5XAP1p3i4CH5kOmxuko0pK3Ig7ZQ29qflGJSo7WiFDN1llirllbyR7De6Wyxkd/B8t3
         nEjuJjgeaDcqQyhrhUWmM1wI5vhJOZIsYzrbokaJ3dpBGU6boyUaQWs9otmX59R4Yf3N
         SRrs+Da8H6aSUI6EPKIXnKpiNrqfhbSezX6+ZJ3mp4G2Tl2gbxvezG9BRh/qUM3ZWUxz
         Of3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766489289; x=1767094089;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=onfWSIfZZxCxgUeBk1t87PeUwtH8Jr8hx54o4pMbZFY=;
        b=CrWYKQGA3a1IfA+kjB2bkJBllLs9tISxO5Ua+E66QG0BSc1Ir+yMeGjcVAT92SaxxZ
         HRnzJmFTPfaTE1zLDFPeIXJzcsY7xT1j/KVZN5mWd7gIAFQyK978oWV0gx9oO/vQ0ysZ
         caIAnc2m4VJzu5W5REwlLRfcsKBhYnkd2r6VIdUDL0FfrQgwsnM+AbfxQxEoodSN901Y
         FIJwrQXMgKklbQZ+bU0aFsa7W7h5PuWH8moOWM5i0X0TTQhn36jYj1nOD08b5Lyaq9o6
         LPmswt1gO/sixFLX9NiLof/gu9OJNXpjSyq+ZUZMo1W+NoU4kw6NO7BoW+8V6uCV8O3u
         +DJg==
X-Forwarded-Encrypted: i=1; AJvYcCUES9w5veyPtityAFrS6bDbvTzfhRKpTXEVnYRXgbs1dUZiQY0ci5b088nVVmgR1PP3vzAkd+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyH80j5HsSvSkVJhcpM3a4VhUNx3o21KnQ/U5BSkNZ/QfE7/dc
	xb9Jouv9LbCMs4/jp5lbrEn9UrYm5YdZsnzLwiU3l4dQnnWigzOPh2Fn3xR8vCZUBUy7a8oYkoB
	gODHyqIJ3gbKbSYKhLTZoFvOZNvw2vitcPAz1zJfuILlCj6fUCr4vDeGxMA==
X-Gm-Gg: AY/fxX4rj8vSUlpyFzOnqnaa0YiHwnJ2A6BgU4ssXVGdgKEg98G0qETjD6iZ4rrFSvB
	vaFliglEKeySkeBFsKDXZb2Z/jyFi0ia5XndqMljATvSNp+DPr0Ht/XIFt9PlOmc6HFys6oW9JN
	uRGI0Qrb4W1/FbAsPZwKDEaH+QwUNB8b9KPI/bCMa4ERKWq8pKw3Y1gGIJxGz/qKvuEtZL6xhxc
	Wn5cpeG6B06IjeO73qU7uTkOzRkGEcZLf8CpKDvEJDmFNV+8MKNC/ADen31CeIFrXgfaWayq5mw
	nGno/iG2G35aKOI2QTtuMAQhpG+rGw6NgWXQsbNVtY5NMUBMHl3P/yoMvm13k/hn+sYSrXK6Bav
	tlt10Qx0boJAd
X-Received: by 2002:a05:600c:470e:b0:46e:506b:20c5 with SMTP id 5b1f17b1804b1-47d19589469mr139632755e9.26.1766489288925;
        Tue, 23 Dec 2025 03:28:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH4LeHi3yY22vGkPD7kF27exlEuU9vK2kNrrWTIhwglW3gPfsUmNL29FuUOPiEYjgWzdUA9Aw==
X-Received: by 2002:a05:600c:470e:b0:46e:506b:20c5 with SMTP id 5b1f17b1804b1-47d19589469mr139632345e9.26.1766489288407;
        Tue, 23 Dec 2025 03:28:08 -0800 (PST)
Received: from [192.168.88.32] ([216.128.11.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be27c2260sm282256475e9.15.2025.12.23.03.28.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Dec 2025 03:28:07 -0800 (PST)
Message-ID: <91d7740a-b340-449d-98e3-d3cf0aae5f78@redhat.com>
Date: Tue, 23 Dec 2025 12:28:06 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1] net: phy: mxl-86110: Add power management and soft
 reset support
To: Stefano Radaelli <stefano.radaelli21@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Stefano Radaelli <stefano.r@variscite.com>, Xu Liang <lxu@maxlinear.com>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
References: <20251216162534.141825-1-stefano.r@variscite.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251216162534.141825-1-stefano.r@variscite.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/16/25 5:25 PM, Stefano Radaelli wrote:
> Implement soft_reset, suspend, and resume callbacks using
> genphy_soft_reset(), genphy_suspend(), and genphy_resume()
> to fix PHY initialization and power management issues.
> 
> The soft_reset callback is needed to properly recover the PHY after an
> ifconfig down/up cycle. Without it, the PHY can remain in power-down
> state, causing MDIO register access failures during config_init().
> The soft reset ensures the PHY is operational before configuration.
> 
> The suspend/resume callbacks enable proper power management during
> system suspend/resume cycles.
> 
> Fixes: b2908a989c59 ("net: phy: add driver for MaxLinear MxL86110 PHY")
> Signed-off-by: Stefano Radaelli <stefano.r@variscite.com>

You need to add a suitable  From: tag at the body start, or use the same
email address as the sender, whatever you prefer.

Also the resume/callback bits are IMHO more new features than fixes, but
I will not push back hard against them.

Thanks,

Paolo


