Return-Path: <netdev+bounces-170706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E00EAA49A35
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 14:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C694B188B600
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 13:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B131E26B96F;
	Fri, 28 Feb 2025 13:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WNURMclR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2314626B2AA
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 13:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740747990; cv=none; b=ZoxdSW2ePKqyLhbFVsPgnKniso4ym9paMuzE+ftbJ1qLrH4fT3sZkCNzTQxs7HUaFl8IrLhTgWj3Qu7Yy0ti4f47xn8/DYfwHBIKjR3EbLzqp2WuO5Sf01nzbo1rCKqvJG6uP0qNXLaDaJsQKzX7jOQJNUTMit85HF6yo7xJWtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740747990; c=relaxed/simple;
	bh=+GsZ2x5HDjoLoOW+IXY8Q0+AMdGD72Srex7vp56yPeY=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UvUOMaJhm/xEIhEkRDFtw8cVkbalbR2+H3xfMk3A+A1F9IZBuTwJGwnX7icsPLVY9YuFADDkDExMMTJ7vV4+e6NujbY/ugNwb6b96/X8Y0y7QfCPLr1EeFb8jh76U+p+ajvz6hoGn02ogKp8nusSGcRy8CR4ymjpOca2oMhoFIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WNURMclR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740747987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rXONDGo6ihZ0iPAG84+CFGzh14N9ncmYlb6e6RA5ajA=;
	b=WNURMclRK/elCk10UKIXY71Bnt7gwcf6uyTgVTy6LK4XZcCcRIdb5NYSMMk2+cvA6y1/gE
	JFF6UiSLT6wfuYEttzu1DE+1brgapqZF5GugSMOTH4Opww2e2ihQoVvOEGYQP0oxI1e03j
	UR1K/SBp+toD84iDhXxZN6QRDtmVJJM=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-iTiBwDxROKqAJhBjhn7AAA-1; Fri, 28 Feb 2025 08:06:26 -0500
X-MC-Unique: iTiBwDxROKqAJhBjhn7AAA-1
X-Mimecast-MFC-AGG-ID: iTiBwDxROKqAJhBjhn7AAA_1740747985
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-54958006b81so13672e87.0
        for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 05:06:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740747985; x=1741352785;
        h=mime-version:message-id:date:references:in-reply-to:subject:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rXONDGo6ihZ0iPAG84+CFGzh14N9ncmYlb6e6RA5ajA=;
        b=VgyLU9n9RUiYjukvbmLsuUW3FhJYhArnmvh8LgZXmT+YRpA1LcCxnu1NLMprJZcEDX
         9Gob67q3z1Py7sVYdXvz380YNchk0KxNVyNw62h/iADtnnjfCv671B8NvnVd2ZT4Ca0F
         YfwcmoRTa+xSCDx21LfmT+DsdSkA3TJQsZu2oJXtrnDHXutb5Lg2+VPv1UTK/uNl4kMs
         vNtegidQQocRqogQ/M1AQBEfcvPOqrIP6UQ79W+rA8CcA4u3DMLwp6TR15u/EOubl7LS
         JMibAJIA1iGGp/nZMxkKe/dH4vUsMUgJWHlZBu8gi380recmMNcDYp0P4fJeEmtWgi/e
         kh+g==
X-Forwarded-Encrypted: i=1; AJvYcCVP2sqr8LSiyM9HkkmAkzszNFfK2yF63pi6t73TEjrFrNndpEJ3/O29vFCcwlU4LZ0rHG4w5UM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjpcoUWL49RbIF9m9A2JRnfMI7ANNGXnZmDLSThOtfJOBV+twY
	M/hDA66en/MAMOFp5YPwYp0WPXuunB8fPD87hhTg8H5iDKIIAGEEabLqP92mYYYYP8qRbVazbxr
	UymTzvGzNM5Aqv/CBWY+CDJ2tUH/+7gcUraKZf6+VsrN8wCMxMzOpzw==
X-Gm-Gg: ASbGncsPsilsCitm9pZ7UxJYG8Vc9v9IU+1Hije9uq9LF63lXPWt3DCQgBQ/IpuD37J
	+yYmaSXUzFI5qp4mul5+ZBbZsKY1ultwY3jNK8B5nvj11VM9f8SvwBiNZTF1M9TnKL76OTnjptF
	K5OGcapQgxZZKQwbkPIFHi8EGSuIVwCHCU6DsYMc3qoxy7Hj8/o/3BBYYgDmu7DUcR1LbiT7JRP
	rJgzTH0rPrS6sW43QHSAHBFhmseF5l6MeQ+01//62v97fS6aZc/6ce2INyj7K+mNAIzWtA1552Q
	43+0XA/zIalj
X-Received: by 2002:a05:6512:693:b0:545:d35:6be2 with SMTP id 2adb3069b0e04-5494c37b691mr1519555e87.34.1740747984675;
        Fri, 28 Feb 2025 05:06:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXotuHxxDRGbkDTRI047dsn/XMby3ovfUFDsR8yccG6wwU82nc0E5sR/kWuqacEJVRyen1nA==
X-Received: by 2002:a05:6512:693:b0:545:d35:6be2 with SMTP id 2adb3069b0e04-5494c37b691mr1519511e87.34.1740747984188;
        Fri, 28 Feb 2025 05:06:24 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5494cb3352dsm274562e87.184.2025.02.28.05.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 05:06:23 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 970B818B69EB; Fri, 28 Feb 2025 14:06:22 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Qingfang Deng <dqfext@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Michal Ostrowski <mostrows@earthlink.net>, James
 Chapman <jchapman@katalix.com>, Simon Horman <horms@kernel.org>,
 linux-ppp@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next v3] ppp: use IFF_NO_QUEUE in virtual
 interfaces
In-Reply-To: <20250228100730.670587-1-dqfext@gmail.com>
References: <20250228100730.670587-1-dqfext@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 28 Feb 2025 14:06:22 +0100
Message-ID: <87bjum1anl.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Qingfang Deng <dqfext@gmail.com> writes:

> For PPPoE, PPTP, and PPPoL2TP, the start_xmit() function directly
> forwards packets to the underlying network stack and never returns
> anything other than 1. So these interfaces do not require a qdisc,
> and the IFF_NO_QUEUE flag should be set.
>
> Introduces a direct_xmit flag in struct ppp_channel to indicate when
> IFF_NO_QUEUE should be applied. The flag is set in ppp_connect_channel()
> for relevant protocols.
>
> Signed-off-by: Qingfang Deng <dqfext@gmail.com>
> ---
> v3:
>   Move direct_xmit above the unused "latency" member to avoid
>   confusion. Should I remove it instead?

If it really is unused, I think removing it is better to remove it,
yeah :)

-Toke


