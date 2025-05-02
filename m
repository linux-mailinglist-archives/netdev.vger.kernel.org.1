Return-Path: <netdev+bounces-187402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25208AA6E52
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 11:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D9D74C17D4
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 09:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F45122E3F0;
	Fri,  2 May 2025 09:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bTylJekk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CC2205AB9
	for <netdev@vger.kernel.org>; Fri,  2 May 2025 09:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746178776; cv=none; b=f6rm7fSjV/FoVU0PHJN2o6j1aa7gZHQ9LtJy45O6h9VZw62NegakzeZxr7NOh65uxwzmS9nQ6WDI14q9NVsrX0meCJVl2KQUrwoGmBE+qjmBXUmyUqS9jepJM1fBaDmCcHs5eqs7g2JZcURDuS0FxD9FHpiaiYVezwlqxqqIoGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746178776; c=relaxed/simple;
	bh=bUC2ovIqDRYMP1p5Wi5+V8mwpGNo86wFcWNQiaEONJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZYpilQeM4BT2ilTk2RCp4Va4CYAxdk3ZZ/TEt4Cxa85Kr9CIdEyfVzw2+fMQLRvn5zO91E/lvWJ/qBSK0ME4Ee0xwhJCAkWCCeQYyRWMA109vbv6B2NGTWCrGmAZ4Q4CPel24lAZO1NsYWiYhC/7Q3ZVfELoDHsoduVEKTacq30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bTylJekk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746178773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KvMTjXIr23L5UkFhokRaZjcjsplgryREMKqsg59/0zg=;
	b=bTylJekkEcmxmyDaOoXwXtc/31l1fHOC+1yJPtNRVHiGnvUtUz7hTxzCxv8zZJwvtaxVR+
	7URAUv2Lkpa26mk2mpyDaLGcTuUIl/No6SBZMWiDYz+vsm6+7+faB5dtqe9wrJFmyIyLk3
	K0DaO7GuJXbgcW9tSkJrBPQkT7NILZk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-NFb9wJK9MBeEGPoEAFxHSQ-1; Fri, 02 May 2025 05:39:32 -0400
X-MC-Unique: NFb9wJK9MBeEGPoEAFxHSQ-1
X-Mimecast-MFC-AGG-ID: NFb9wJK9MBeEGPoEAFxHSQ_1746178771
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3912e4e2033so482601f8f.0
        for <netdev@vger.kernel.org>; Fri, 02 May 2025 02:39:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746178771; x=1746783571;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KvMTjXIr23L5UkFhokRaZjcjsplgryREMKqsg59/0zg=;
        b=ZQFtQVSl1PBRGlf3leacBRyqvMwCi9NWxr/X3Vohf6APLU/b0sAe/gZg2azSjjLgUI
         ciCLfAFdkEYg0AE7drjBH0sYIE/SkCItRYe6DshriEaRxxhYxhK4iRRVd2+1OUST6cpg
         kdXbiTDK7Z1Hp6jZLT60A+gc5u0dV/ORVt6ZuVAKeERJHu+W9KW2mXyCOdEN1ZP3EKJD
         Q5ZdLN7oLNf9c+6jr+jJZROxLY4ZSwVfXsAw4bJU9ZoSLR0aNOKgOXsAKv8oyEOP8c7W
         2vNdGXOOPhVtf2oCxglPWErE6uZ/vnEFuKQMcKh6WtsYvTX2w3gCi1+QrD4Kq8v3aDYk
         wfhA==
X-Forwarded-Encrypted: i=1; AJvYcCVE3LlRviowFG0/cjPhEHr7pqp6Mtlb4od3yDroE23Mr5YtziC1LI0NVcCZsT4p/DrZTGrN33k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2cXPa0GtCk/P7cnB5oz31lCrE+AAEODqiP6DcybwqgfLSeRUl
	KSCDehuFnOk/zYENjHuBNSDN0HkD/BLVyAA3ZcrDyNadLxwRoBqaf8vD9UX3hbKFkxHvKUO9lsc
	rNsUXiKuSem+GaD86jvwqU029Ypa0qSKTRFPzx9q1C9efw3RJcHHJSA==
X-Gm-Gg: ASbGnctbKz5iAKp7StzAiGlG/1Xv1Qb07UnOyqaWOG6/7lY042zLqY+9Y9MKjosF/cn
	iTuUAEhedtzLPMhEPEa+hgdC4iFxC8AvSaCZgVSA/4KPGl7iXd08ZDXXaM1clHR9NLKLXnW3nVf
	9SQ7mzpRUQi7ss0O57y+0/BlKGESVmfIWjNqEpYtcKLYCHtZhqIcL3t6N83ssT4rOaB4dD4BP4i
	H+2qoBo4bSlaYN8PUbRRzCLl5wuLVWLmetlHUSPSoPg37iwr9JdycR21PYYRY6xv6mLFxmZiYJ+
	9zaRMcBFyIyEW4TeMhI=
X-Received: by 2002:a05:6000:1786:b0:39c:1efc:b02 with SMTP id ffacd0b85a97d-3a099adcf74mr1557137f8f.28.1746178770918;
        Fri, 02 May 2025 02:39:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5qRtj7uOx+MrGjrQ0dlSuVyHoANGSwgxM48EP/hxqRnPg/Z9eT562Fod9WT5DTPyqxAshJw==
X-Received: by 2002:a05:6000:1786:b0:39c:1efc:b02 with SMTP id ffacd0b85a97d-3a099adcf74mr1557108f8f.28.1746178770589;
        Fri, 02 May 2025 02:39:30 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:246d:aa10::f39? ([2a0d:3344:246d:aa10::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae0bf6sm1660706f8f.18.2025.05.02.02.39.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 May 2025 02:39:30 -0700 (PDT)
Message-ID: <cb94f33f-2e74-4e5d-8f68-58322a290ffb@redhat.com>
Date: Fri, 2 May 2025 11:39:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 08/12] net: usb: lan78xx: Convert to PHYLINK
 for improved PHY and MAC management
To: Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Woojung Huh <woojung.huh@microchip.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King <rmk+kernel@armlinux.org.uk>,
 Thangaraj Samynathan <Thangaraj.S@microchip.com>,
 Rengarajan Sundararajan <Rengarajan.S@microchip.com>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
 Phil Elwell <phil@raspberrypi.org>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Simon Horman <horms@kernel.org>
References: <20250428130542.3879769-1-o.rempel@pengutronix.de>
 <20250428130542.3879769-9-o.rempel@pengutronix.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250428130542.3879769-9-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/28/25 3:05 PM, Oleksij Rempel wrote:
> @@ -384,7 +385,7 @@ struct skb_data {		/* skb->cb is one of these */
>  #define EVENT_RX_HALT			1
>  #define EVENT_RX_MEMORY			2
>  #define EVENT_STS_SPLIT			3
> -#define EVENT_LINK_RESET		4
> +#define EVENT_PHY_INT_ACK		4

The patch is quite large as-is. The bit rename should possibly go in a
separate patch.

/P


