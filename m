Return-Path: <netdev+bounces-112939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F37193BF63
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 11:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBE5F1F22658
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 09:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106AE198A28;
	Thu, 25 Jul 2024 09:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AQLK2DGk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84495172BD8
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 09:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721901243; cv=none; b=mt34uzNd/9s4163UTUBp+6e6J89EGn5uyp5cuNxdmDQis+mARAPE2xZFW4HFqnCffSAFINOguS16YlxhtdmydtPc5hUHZ/0GjfcgAo260JDYMdUe1Ro4DoCqjiIdj1opxx4C2tiyx75Fr2qOfh5e6YFNRZWtVtSX+J9trBKyPNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721901243; c=relaxed/simple;
	bh=TRogKpvrGbqxUvdw8euZYKuVBYuIo9/CTs0zy8grZV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V+Pq3h0CvQm/HNTLtc/Uk9BSB6d4tuYVWHdIgBk7pEJ6eVzHdGjq6FJfyB8yljZMjQvtpE97F0+e4FFVFd/oRLCPfDY7kANhvahCxrCLAg7JLElZbb827jrQMBi4xKesEmqY1kYcmovlW64F6083JTftsGgcc6taF9OuYPL8D/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AQLK2DGk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721901240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Azo1YWuyIM0irZB6B+BIwEhaWJ15+/vkqjauTRjqjt8=;
	b=AQLK2DGkWfGqc1vaUIsptF+7z9EBsrHfK85S4sO2aHnnuSgZQIOL98PWfDjnIcmxk/S+wG
	cl1F8aHGry60K6XCfyS0zkcbxOuZf5jXAdCSLy/Pb97B3f0toKvBRBxCD5RBf+pRIrjhxS
	I9trwIbKuHkKaR19uamMUQr+KyooO9g=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-dDyB6DmHP1iInhyvc9jsUA-1; Thu, 25 Jul 2024 05:53:58 -0400
X-MC-Unique: dDyB6DmHP1iInhyvc9jsUA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-369c99e4a88so142502f8f.3
        for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 02:53:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721901238; x=1722506038;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Azo1YWuyIM0irZB6B+BIwEhaWJ15+/vkqjauTRjqjt8=;
        b=b+0U/tZs7FrPG6Hsjr5WSp75eX3v3u/gzmGS9i5WYOJAIckFOjSXkHOAWKXwP7hgzX
         QiZ4MqvlfB7aFIKKyfG1DypRpBM1lchKJad3l9szd+u0cCWQhXq72uCTAYmfSyZqnJ78
         3X5sjh2jDMTie0UCsnlgsLm4itccYgwkBo9KSJTcKEY06oYjW2NHKFGwkSWT+R5M5y3O
         dG58vgo4sVeaG1sZn//ut/LlvsIDIPiH9pQW8yvyldr+oylRE1++zZswHMpDV4IIYYhR
         nor5hm3czd06+ntUVOoC6T4LT/l3TeXimD4Bjl1nRg9QshRdNDz4/N9H1jkrkYgh8Ucg
         DIWA==
X-Forwarded-Encrypted: i=1; AJvYcCUMfvD4HwZ7+Q8pvmh65hf3COjy8n5LkdaZAhBzTR1vB6LI7c+vC5oD8KV/4IdpG0SJziybSkk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYgdOFwciCoe9LOCG5hWELJ4xYV/PSHlUIrJM4CWPogxac74wa
	Hj67q3byBXsbzawtDYQgEelpYug25OVjLpdxNOyW1cKu6NfA4A6EFpbQniIhyD5wznpg8ovwO00
	SJdvR04wNQT1EUQFDzTgd4epeN8em7tdX7cboyQu3Ib23eL4t1sJ1fQ==
X-Received: by 2002:a05:600c:3c89:b0:425:6dfa:c005 with SMTP id 5b1f17b1804b1-42805440493mr7672545e9.2.1721901237836;
        Thu, 25 Jul 2024 02:53:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFI9xUvHg0R+EO/RKq9ufzKkJZaoU8wz7XHuGLoen5hz1S74CdRTqMxjnghTCleM8tL0hE06w==
X-Received: by 2002:a05:600c:3c89:b0:425:6dfa:c005 with SMTP id 5b1f17b1804b1-42805440493mr7672425e9.2.1721901237386;
        Thu, 25 Jul 2024 02:53:57 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:b231:be10::f71? ([2a0d:3341:b231:be10::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427f941352asm67749725e9.41.2024.07.25.02.53.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 02:53:56 -0700 (PDT)
Message-ID: <d3d97260-f840-4ea8-b964-64e36448bf96@redhat.com>
Date: Thu, 25 Jul 2024 11:53:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: usb: lan78xx: add weak dependency with micrel phy
 module
To: Lucas De Marchi <lucas.demarchi@intel.com>,
 Florian Fainelli <f.fainelli@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
 Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
 UNGLinuxDriver@microchip.com, davem@davemloft.net, edumazet@google.com,
 gregkh@linuxfoundation.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, mcgrof@kernel.org, netdev@vger.kernel.org,
 woojung.huh@microchip.com, Masahiro Yamada <masahiroy@kernel.org>,
 linux-kbuild@vger.kernel.org
References: <20240724145458.440023-1-jtornosm@redhat.com>
 <20240724161020.442958-1-jtornosm@redhat.com>
 <8a267e73-1acc-480f-a9b3-6c4517ba317a@lunn.ch>
 <v6uovbn7ld3vlym65twtcvximgudddgvvhsh6heicbprcs5ii3@nernzyc5vu3i>
 <32be761b-cebc-48e4-a36f-bbf90654df82@gmail.com>
 <ybluy4bqgow5qurzfame6kxx2sflsh5trmnlyaifrlurasid3e@73kpadpk5d3p>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <ybluy4bqgow5qurzfame6kxx2sflsh5trmnlyaifrlurasid3e@73kpadpk5d3p>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/25/24 08:50, Lucas De Marchi wrote:
> if you are saying that the build system should automatically convert
> this:
> 
> 	config USB_LAN78XX
> 		tristate "Microchip LAN78XX Based USB Ethernet Adapters"
> 		select MII
> 		select PHYLIB
> 		select MICROCHIP_PHY
> 		select FIXED_PHY
> 		select CRC32
> 
> into (for my config):
> 
> 	MODULE_WEAKDEP("mii");
> 	MODULE_WEAKDEP("microchip");
> 
> then humn... why is CONFIG_MICREL (being added in this patch) not there?
> It seems even if we automatically derive that information it wouldn't
> fix the problem Jose is trying to solve.

I hoped that the 'weak dependency' towards mii and microchip could be 
inferred greping for 'request_module()' in the relevant code, but 
apparently it's not the case.

The MODULE_WEAKDEP() construct usage makes sense to me, but this patch 
will need at least for MODULE_WEAKDEP() to land into net-next, and to 
grasp more consensus in the phy land.

Cheers,

Paolo


