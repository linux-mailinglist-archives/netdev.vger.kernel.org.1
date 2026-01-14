Return-Path: <netdev+bounces-249887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB69D20354
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 17:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DE3943002526
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 16:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FB237F722;
	Wed, 14 Jan 2026 16:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KaFbdj6B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD613A35C6
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 16:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768408184; cv=none; b=W2u6zdKRzrYjK884m/EnkIo9VADna9a0aFvytD7rKniKTF4a3aPoW8lzDy/AlHTo9LXrxnCRrLzIUIDF7yT7YuFo03s++WoiVUidYC+3xFtHHfM8eD3lZSGZ/7V5ol6PXtTF/i8YCGN4p5pxgcpNJpyi3q514eWPvbH8zjbfPgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768408184; c=relaxed/simple;
	bh=MjPHk3EmtDPhGYdLITTZKXeC850lyP15BAAA2k7LU44=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JvOicSetSaP1Z/1ow46csY0ofBUkNkBEhjNFVx0DTA3ZcfHnONvfXXB7HYUh98CcMHJJeX3DopYbVzonVG4wwP6dJuzxbt5A0pURNTZGyBr6km3qb8a4pCC/9woo79PbxIDMvwfwOLx9kSV+gVAXrPHtkBjdWT+iwBoqnFgI2wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KaFbdj6B; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-432d2670932so16399f8f.2
        for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 08:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768408171; x=1769012971; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wOGask9npR+YlnkUj5CzN/Pzieo1MzhAPrMcaH9JsNk=;
        b=KaFbdj6BCYQyw/Y+iUeCUT6hsYBdyqhnEQ3wHBnpoxYvYDSMhj7XXOO0spko/mmpsl
         Onw+JevrvYzLo9MzTE760/wfAwg1E5CI0WnI7WkXQqfpFqANwpJVvh+diK8WL/tyP0w4
         7uYbKthMWAPQgTe2uR3XU4mfOscKPzitBqY0cKj+pKBc2xvokHeDU/hSnHPHE2hl2r9K
         xUZvRIxP8JYrR4l+ws36YvA3kxE8w2e7DFeq32NCLp7V3kbU4KtyyRIzeiNih6GEa1/Q
         idhEwgep+Sw5BceDYkVqNDnvfDqmlL5v3bUe/I7Ho1FMI/721X2g/9q3a+MFk7Rdhhg+
         GUZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768408171; x=1769012971;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wOGask9npR+YlnkUj5CzN/Pzieo1MzhAPrMcaH9JsNk=;
        b=lPZIKea3PWoIGkNooqHa4A4x7IPBqq1yxtTWy3QL5TRouwp3ctjY8u/byJ1lgaklKk
         2M0UKuurB4hvf/JgQAlcyNi/kExs0uLLdTGnpUgpUqOOZOZtd6bFC+0X2/YmM5NW5GOJ
         q5sPwWOSgu7qDZWEZVNJvcMi/ZvWhH+6j4fB4RAZnysk1nnBtu0gg76yDGc4FJLUD20f
         9LxXLw5+buBRpPJFXTC2LOChBHoXX7VqbV8sE7vIkmMrV/SUDh3XiKD34hw6sfERjvdK
         dgB2QWor6QT7ySFcPZ8DHzsRSJ0XSsquMzPBKuYBZKM2s3mZYJ1FqANSvTG2lQaw00PD
         PFSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUatSwlZdZ0x66t3cDIOEhZJlluUzwZJro6rQdtFlKKLbGYIvGYT6g60fPnDJe5c9YYlO5tPUE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza4qkLFQ8j8nKXM7DUY2S3G2SXtnvsP8WuUIKLXLK6KaTYm2A0
	mJuFAl/1wiDk9+KHU48sdREl6yx+0+//mIDgPXCPVKo27JbfSTeqmlVA
X-Gm-Gg: AY/fxX5B63UUPsk3SMN2JxW3kGMEDBIo+OKEQOdnrvye5z50Jhx4M+JESEOW+g+WdxM
	Le0mkX/p8uBLF3R3xEh7NGq1dcu3rLjTcrLSmjra0gjMxw3nUpZve8Anq3ffW55bUv+99J7tX3E
	hvngV6gfiqGZ0nYZp0rtROEA4SDQQM06jOMiqBLEtXNa+fqhGr5wKOOo9y5t4elkRASJscNht8+
	v98scFUiqHVFnaYblci/83aEDz13NI0EGo9clG2oIxdlu3yEQGEuN8b24p8LLrFmOo/ceIqBR8R
	r1haohdVt/pTV/CT0BXUhM6PFtoQGBDEOjR/QIY7nJpfvutqjYic6W4BjYbT0ZKCQLR0yStyNUF
	k1Vf93123y1lRRxDR2VrOwfXPCwr8mdsW0AGv8hCQ98Ill0O+Z3BIMl+FTap6iqngcsJP7C5j/q
	HGiUNbrimrU6GQYflqOSTeMXjiqcbuiWplKYexKoo=
X-Received: by 2002:a05:6000:310b:b0:430:fe22:5f1c with SMTP id ffacd0b85a97d-4342d5dd3d4mr3043280f8f.59.1768408171137;
        Wed, 14 Jan 2026 08:29:31 -0800 (PST)
Received: from Ansuel-XPS. (93-34-88-81.ip49.fastwebnet.it. [93.34.88.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-434af6b2988sm147835f8f.28.2026.01.14.08.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 08:29:30 -0800 (PST)
Message-ID: <6967c46a.5d0a0220.1ba90b.393c@mx.google.com>
X-Google-Original-Message-ID: <aWfEaBla1K6AZnsY@Ansuel-XPS.>
Date: Wed, 14 Jan 2026 17:29:28 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: net: airoha: npu: Add
 EN7581-7996 support
References: <20260113-airoha-npu-firmware-name-v2-0-28cb3d230206@kernel.org>
 <20260113-airoha-npu-firmware-name-v2-1-28cb3d230206@kernel.org>
 <20260114-heretic-optimal-seahorse-bb094d@quoll>
 <aWdbWN6HS0fRqeDk@lore-desk>
 <75f9d8c9-20a9-4b7e-a41c-8a17c8288550@kernel.org>
 <69676b6c.050a0220.5afb9.88e4@mx.google.com>
 <e2d2c011-e041-4cf7-9ff5-7d042cd9005f@kernel.org>
 <69677256.5d0a0220.2dc5a5.fad0@mx.google.com>
 <76bbffa8-e830-4d02-a676-b494616568a2@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76bbffa8-e830-4d02-a676-b494616568a2@lunn.ch>

On Wed, Jan 14, 2026 at 04:56:02PM +0100, Andrew Lunn wrote:
> > > Yes. What you plug into PCI is not a part of this hardware, so cannot be
> > > part of the compatible.
> > > 
> > 
> > Thanks for the quick response. Just to make sure Lorenzo doesn't get
> > confused, I guess a v3 would be sending v1 again (firmware-names
> > implementation series) with the review tag and we should be done with
> > this.
> 
> Since this is a PCI device, you can ask it what it is, and then load
> the correct firmware based on the PCI vendor:product. You don't need
> to describe the hardware in DT because it is enumerable.
> 

Hi Andrew,

I think it's problematic to create a bind between the NPU and
PCIe.

Do you have any hint on how it's possible to read the PCI
device attached? I'm not aware of any API that can be used
to enumerate what pcie devices is present on the device?

Considering how tightly integrated things are in this SoC
I still feel firmware-names is the most effective solution
for this. The WiFi offload is mostly optional and sadly
due to Airoha limitation, it's not possible to have separate
blob for the single feature/support.

-- 
	Ansuel

