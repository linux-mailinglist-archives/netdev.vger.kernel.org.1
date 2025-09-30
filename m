Return-Path: <netdev+bounces-227327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F851BAC940
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 12:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D43A51925F3E
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 10:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1532F7AC4;
	Tue, 30 Sep 2025 10:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YGfxW3Tk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345992FABE3
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 10:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759229951; cv=none; b=hli3wCmB2+SaBXe6xo+lufOTpPddHyP44zTcpD/DRUFqP8yw571GnWmFl89XBfq4w6x0K5r2HJtXq+y+/5N7//hJZofTG8IERKQV0YJgRLZIA7jlHZQgJSez5YR/fibc+dPhAdI4Fuf1vPxWoS45RzaHbDdRW2Torx492K75tS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759229951; c=relaxed/simple;
	bh=aD5jGL56V2tce4m9N5SJnlY9Yue0hnBtWnJ3rC2zM6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JHaykmsVp+aSWtBrX679ccTJhw12vhSkEkBPA9J5BxZHcPs3+4DZcJRjboRASqSbO/x6FaIE75h+p8T93pPi/CeqjIEPbqVHLPfIyUX4lKsPS6kUbePc3x+/fsaXOFv/wz6CcD7P4LbtRAlbFibUZdPndCTMpFAgEPLyhrEhKSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YGfxW3Tk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759229949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SVOA0Q0ymTDoBZOCl3mOf8HuY6BSBntN7jY80MGvrho=;
	b=YGfxW3TkKDx4jsZBZdCGT2UhLyGP9S3Y549+LvNki0jNZoCEv2Wma9MtnXUj2814owLEBr
	yl5Pqy9vkm8z1B39Iy6gPH44DafRhhraniG4pl44Fo28GdQEPSkqw55BaXrOssmph+jGwy
	keAIHsPSnK0wnWNoTqEoR+ndHSpsr/A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-km4XX77HPwSVYx99o7xRbw-1; Tue, 30 Sep 2025 06:59:07 -0400
X-MC-Unique: km4XX77HPwSVYx99o7xRbw-1
X-Mimecast-MFC-AGG-ID: km4XX77HPwSVYx99o7xRbw_1759229947
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e2d845ebeso41727615e9.1
        for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 03:59:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759229947; x=1759834747;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SVOA0Q0ymTDoBZOCl3mOf8HuY6BSBntN7jY80MGvrho=;
        b=GNIcA5ByeDvtMfY74ASkbj29D0g3G2hUkdeB4D6/7Rar07oKry5+SxKxmqcxeFivpx
         Zwv0SlbJwYvQQcrzyR6Hib14TS+334dfjyIznp/OWSRHyVuWzmwhwCzTkD/ShpnHzSe1
         LGR/HLt2IlxmUAw6nYW9KWG+eLDOKn+W73+JNRh9qlbyjLcBiuXbWWozddtS8tLCJ5wJ
         iRlCGRXf/AZ5TDBbd6wNX21p2eRlXxxZ3fJA5GfKPDm/3XJpBpn64ThuPF3wx48hl7fy
         pQUiQEGREO9GIWwvQ/NiT02Ngpl9TetixYpMp7CZiCJMimqn64zFVQAEq1TZC5NMPu2q
         VupA==
X-Forwarded-Encrypted: i=1; AJvYcCXTeBjIcOCAcs/GIqOr+RZyKcxsUQMDrUK4zc9b5qV7f/ak2RZ+IFMuuswTpzGihTWNfUdX1QE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAp/3qXjtgwl94zs1qhUbW+T05QVyKK3arpu7/bJGhn8XRYolY
	bG3IdrIRINrKHdkt4wcKhIcv0jz0WNueBtZxx1iQVXLTQV4y0947CAnS9trkWFunoHTkrGUf3a/
	fk7BTPyh84bGD56msP1sI77cVgG8KK2D1i4r7AkEW+swhuyJY0NVkNosuiw==
X-Gm-Gg: ASbGncugHGddc8eNRSvjnzrcSaNMpMvBjb0HuSIm2Kzr8dugleE9bQrvggOMzbzlJdz
	0nouXTXy/rP4zyWBt0ZOPFGCCeM1OFT0XA0g+dn1I6uhX7lTV7qw/TwkiL+QpH6x/aX4P2EafQd
	4XkDhZEOk6niUv2e/B96mfQhlV5W1UcnlXAO8kNvszUUFWayOrWtlqsdjNrhyzIvRH0cZYsmBPx
	C6h31vT7klPEA0q3W8fTxLN4ORkMPVrQNe1x+wLLUGDBCbzOBd2vK5Chnn2NLmj7/taQDL0tRCV
	dBKbnNkhCqMN8Ymu2So0w0KgklXqWw1SirAL4ve8i1JD8pjUwe1WuYnyMShvYH2yZSfCFkJfB7H
	MPh4xUJ711iLSCD8bQw==
X-Received: by 2002:a7b:cd98:0:b0:45c:b6fa:352e with SMTP id 5b1f17b1804b1-46e329fb852mr152040405e9.18.1759229946559;
        Tue, 30 Sep 2025 03:59:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFl75M5KM/nmhV85NmfLdPrO6RTkSlsYl+oX9QrpyA/JV+GEDplaQbfuu86mibd2UCwjkweEA==
X-Received: by 2002:a7b:cd98:0:b0:45c:b6fa:352e with SMTP id 5b1f17b1804b1-46e329fb852mr152040055e9.18.1759229946107;
        Tue, 30 Sep 2025 03:59:06 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2ab61eecsm263007585e9.20.2025.09.30.03.59.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 03:59:05 -0700 (PDT)
Message-ID: <b92d752d-b4c3-4f3b-8a2b-1c7162af63b7@redhat.com>
Date: Tue, 30 Sep 2025 12:59:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 2/5] net: phy: introduce
 PHY_INTERFACE_MODE_REVSGMII
To: David Yang <mmyangfl@gmail.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Simon Horman <horms@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>
References: <20250926135057.2323738-1-mmyangfl@gmail.com>
 <20250926135057.2323738-3-mmyangfl@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250926135057.2323738-3-mmyangfl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/26/25 3:50 PM, David Yang wrote:
> The "reverse SGMII" protocol name is an invention derived from
> "reverse MII" and "reverse RMII", this means: "behave like an SGMII
> PHY".
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

My understanding is that Russell question on v11 is still pending:

https://lore.kernel.org/netdev/aNbWEdabqXIaoo2T@shell.armlinux.org.uk/

and the net-next PR for 6.18 is upcoming. Deferring to next cycle.

Cheers,

Paolo


