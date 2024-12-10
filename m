Return-Path: <netdev+bounces-150627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 062F49EB042
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 12:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CB23282918
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 11:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C137B19E99E;
	Tue, 10 Dec 2024 11:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AAqLH6Iu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC5A15252D
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 11:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733831775; cv=none; b=ADceWX61I595ebHMirbbK3dF7Yz362fahc6yTk3DCxPWxuISpBQSeV79CD+MbHCM8XU4/fFBFqIPzlSp/+Yyk5VewSnIh5hBEm4awizQaLSmDgO6GiDfN6HxjgvvC1zL6eOUHEIErXhyC5LNgCOGO4BMZNK4an4kGv0IDc97nHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733831775; c=relaxed/simple;
	bh=9D30XLU1YqyFDqV1u6rGU63M73Y+CHh8wTylgtao8T4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KriqXkbIzY7Gp82Ho1C3np4Uz9wSJhVcgnguk+oxpzVecQx2y8XC8TiciYTRSnGo493G5QfCHihmbyQWFiBcx6vHLyYcchpAOvA1bwyviovXemd8WLHEqXB9azlLx3JG95RzJayNX5nnn3jjb5fvS0gQYH4FKaya4IoPT+JL+8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AAqLH6Iu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733831773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9D30XLU1YqyFDqV1u6rGU63M73Y+CHh8wTylgtao8T4=;
	b=AAqLH6IunAyH72zOny+vMRpxcNeWDhfNrth8u0MJWXGMJwLkwgSbvOsgPbL1BM8U6qlLA/
	Tc/HS5C1AzmVzUzJPLyJ90nE6qiMbVB/pqIwU1Lwy14JTHl3o7I6OkX8zXM+yIHcdUMpVL
	QfT3fPPg+X4lm8mSBmMZKP+SD4qBOCo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-4VC9xsbnPOy4hnJiEW729A-1; Tue, 10 Dec 2024 06:56:11 -0500
X-MC-Unique: 4VC9xsbnPOy4hnJiEW729A-1
X-Mimecast-MFC-AGG-ID: 4VC9xsbnPOy4hnJiEW729A
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-434f3a758dbso20504485e9.0
        for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 03:56:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733831769; x=1734436569;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9D30XLU1YqyFDqV1u6rGU63M73Y+CHh8wTylgtao8T4=;
        b=HyyWdROA+q7vQN1DIj30NurrVxkeUcbylcDtDn9/N62G9PbVePSCYuDsfAU4+n1fIb
         HSIq0zvozH0WTk5TwaOBKi+7bqEZmzZppIVq4uun22fu2ITinfqwmgoG2/TTZG86SGI+
         pDvaTV6gyiX/LTe5AM8E4ZB1J8DCQhJuh6KnOKIKAAKyMSXpsgIbk89vhK/0+e/kZ+zJ
         828AnHcRRZASNPT9RGSm+DQilCzl2UK/3ocW7Ff/OoHuSYCZG5KODKeq4cwTyx7a6XZz
         2YPBBu67u95gXsKguqCbVTN7e6ASY693049NTBmQ3R7R/spDtZLxwFNq8gjQna6R6GP+
         6Byw==
X-Forwarded-Encrypted: i=1; AJvYcCX0qzNRfk5Gn73wbKVAbSOvInoCAfytV3LM4RyGogWgSvFcOwuFKqxW9ShqyrQ+N5PglkgnJQI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4c47eO99iEygzLAz0JPLavGan+tKB9zRymjm0NS5HxCX8KDkg
	dBXPeqMS+owzy7Nkcs6bbrNWIeDJJHakfpTh4ow91meKy02AKojdVQlZW5GJchaQG5hyri9bhCF
	gsZdM4Ims21eKMsccHPhluGq6EAryEkAleLlOoub0V4LVQvdcnkquUA==
X-Gm-Gg: ASbGnctPhVe7hUBa5gLaFNQ8TwjYmVYPw90DrA+Bt2Nb3XJGA0YowJPzp6MrrFm9HIA
	+pEUWJPWdy60faVCQ6c51XJIqRn6X635ngJmoN8LCciSPGZjSvykc7aMM+e1j9PHt+LNNq6DU8G
	5elKEXPqdNgdUa741qn+oQrZJhsYK2OyRrAvqdUicyGUdCaux4kC610vs7PnmAqpaJa84pTXpJG
	Ur3sOHb8tKvDcomIqKAnypY1Cvm5jRyLxEwObYxtsWBSRH2ykPUNY0gIY7tzH4hMUWvkRFEH6uy
	N9ZtGzeg5amzBJRuAQrfEWceeQ==
X-Received: by 2002:a05:600c:1da1:b0:431:54f3:11ab with SMTP id 5b1f17b1804b1-434fffc8aafmr36672215e9.33.1733831769655;
        Tue, 10 Dec 2024 03:56:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFBbN8A080kEtPt9BMjRTNDgrzEK3dfC71r4vFm7hnAFt6/No3fGb8mFcxtnMlmtMYyN/pmAA==
X-Received: by 2002:a05:600c:1da1:b0:431:54f3:11ab with SMTP id 5b1f17b1804b1-434fffc8aafmr36672045e9.33.1733831769373;
        Tue, 10 Dec 2024 03:56:09 -0800 (PST)
Received: from [192.168.1.14] (host-82-49-164-239.retail.telecomitalia.it. [82.49.164.239])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da119a96sm191300075e9.40.2024.12.10.03.56.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 03:56:08 -0800 (PST)
Message-ID: <e6a812ba-b7ea-4f8a-8bdd-1306921c318f@redhat.com>
Date: Tue, 10 Dec 2024 12:56:07 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 1/1] net: phy: Move callback comments from
 struct to kernel-doc section
To: Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Jonathan Corbet <corbet@lwn.net>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, linux-doc@vger.kernel.org
References: <20241206113952.406311-1-o.rempel@pengutronix.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241206113952.406311-1-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/6/24 12:39, Oleksij Rempel wrote:
> +#if 0 /* For kernel-doc purposes only. */
> +
> +/**
> + * soft_reset - Issue a PHY software reset.
> + * @phydev: The PHY device to reset.
> + *
> + * Returns 0 on success or a negative error code on failure.

KDoc is not happy about the lack of ':' after 'Returns':

include/linux/phy.h:1099: warning: No description found for return value
of 'soft_reset'

Thanks!

Paolo


