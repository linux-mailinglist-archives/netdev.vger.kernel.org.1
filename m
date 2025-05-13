Return-Path: <netdev+bounces-190102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F39F3AB52D1
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 12:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98A917B3EC0
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 10:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018C7239E69;
	Tue, 13 May 2025 10:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q9ATNSLm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A26723909F
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 10:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747132089; cv=none; b=KqWaRXKkoSuS9ghQqfL8C39NDo5ka4qhVRKujp8x6sH1X6KodfYGI8geu3W8VFm1MH/gJLTC34XpTVpGWU8xZgZv6jbNSd/+ys4kiUJHKpgSrYyZBirQwUK/h7zz7x4jqBRiGE/lE8LaNwqQOVCqO3IyARoW+KDGKl14c/Wa9cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747132089; c=relaxed/simple;
	bh=JsjZMJfYqcTmeLGG65HJW+MIA3UYXoh1TeVbs7C4rVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wr+B2aTSS5GTUfOXK07U7QoWysXCmumrH/xR2RWKNcIEMJXLBYuuhzvQQRJyuN8frRJ7TqQGkpKKwmbqrpQbdKXMNaWiIqY0esue7sRH2pCVKDx2FJU33g9+3bI9RyLFDaAuOnJazSg4Sh9oEgEOa8hesCjG6NW8jFKQD9sMLbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q9ATNSLm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747132086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7eU874MO87ek4WqCyxGFc1W1sDCzA0tMdC6MVvmyNWs=;
	b=Q9ATNSLmKDyVH2s6iDwNwoxksWaL3vAiBp6QXzwIF92pSN5dvQxtRFtt7m+XbnJlVEG0JH
	Ru1iiAAko8wmH9Z5qg3gWyW0yW9iMgHnYStL290zetoN9H7fnT6fu53xgOxItgdWukLpLW
	WFm9d79BOEA78YNuR0fY/MaZBdnq5q0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-jv7_LzbfMhGA9Y4sEYWRZA-1; Tue, 13 May 2025 06:28:04 -0400
X-MC-Unique: jv7_LzbfMhGA9Y4sEYWRZA-1
X-Mimecast-MFC-AGG-ID: jv7_LzbfMhGA9Y4sEYWRZA_1747132083
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-442e0e6eb84so17752665e9.0
        for <netdev@vger.kernel.org>; Tue, 13 May 2025 03:28:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747132083; x=1747736883;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7eU874MO87ek4WqCyxGFc1W1sDCzA0tMdC6MVvmyNWs=;
        b=pdQNCzeajveV63+o7pzSVwa1obQ3pg2Y7EXHTCJQPHru6pcWlGjUj2OevudteXKNxm
         GkatvCkAI226XCbft0DPYR2HDoa3XaJkC4ak235tKHHyxNxTel67YW9mAypPYjgXzPgJ
         JX3DwTBeOImONcWR8FX2a8zIzU6VuU+PhO7cZ4Q965/UApgDPM4HR50BPUjQlhTTO2vl
         /jKPlBDsLo4UiqoEwTsGuvLwRrbr126U6uJkkKDb3Abm6tQddJe/T70JwViLdhbyOUxm
         6Hse+xxeLjQ9o+f1J3tI8URIppKE4sai9kyozMYAdWN36FXYaaw6FKdiaHA1LyOURQwg
         EvAg==
X-Forwarded-Encrypted: i=1; AJvYcCXbotTFl6bYtVx/z7MJeBBfOLXm5yQjm72ZtM7MjW+aAzUEE+fd8dQzDcBkTZtviESqz+TMpV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaFzNwyDr/d0a3dwyZm+0Ed+oFz9WeVmtoC4UP592NQ653m/C2
	e+icZroAXcoSEGHeCcqntpwLPJNtGYIiNCzVp2wsfir0sPcsh7gOCo1txJERjmagpxoWqViR/2x
	GaD8THHavaOtL7hizNhzOawjRphvSdLF2rinj5uNjD8zc9bPo2QL2mg==
X-Gm-Gg: ASbGncuq6b4+VEys+XzK/JBYd5mF1TUQJN0vOWO07QopYUmSLJAcQkaGyr7WbtHHzdN
	rvhmiwDwiSfVtHHL72BnfOsuWUhushsLKQOJJ6Oyc4swnMTPYXPXC+1FprYSev2ShnDrCGdzSk3
	eJquT4KvUoecEjVodkqEinGaOD5V0s+KnHQIMdlb2vpqLcRt4W39MM7J6oUOL2MltGB9jH5fpaO
	vlDbGRN7cv7Ey7VQDo8ZeEPoX7LTtw+Bcw3xQrEa6B6xwp/kR+fwrCcf6Fq8zIYekemojNoOlsD
	qtYo44+hpKvhhvht5nc=
X-Received: by 2002:a05:600c:8589:b0:43d:412e:8a81 with SMTP id 5b1f17b1804b1-442de4c6fd5mr72297955e9.28.1747132082802;
        Tue, 13 May 2025 03:28:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhHQ2cPgBoVj48TAENCfdPzKusy4rZ/hGFeFFzSKN+dmp8zg+z0ztV8NE6hckRltPdEYYtyw==
X-Received: by 2002:a05:600c:8589:b0:43d:412e:8a81 with SMTP id 5b1f17b1804b1-442de4c6fd5mr72297745e9.28.1747132082470;
        Tue, 13 May 2025 03:28:02 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:cc59:6510::f39? ([2a0d:3341:cc59:6510::f39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442d67d5c09sm164248635e9.7.2025.05.13.03.28.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 03:28:02 -0700 (PDT)
Message-ID: <aea8db43-e8d7-4cbf-b445-aa9b8be64708@redhat.com>
Date: Tue, 13 May 2025 12:28:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: dsa: b53: prevent standalone from trying to
 forward to other ports
To: Jonas Gorski <jonas.gorski@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Vladimir Oltean <olteanv@gmail.com>
References: <20250508091424.26870-1-jonas.gorski@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250508091424.26870-1-jonas.gorski@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/8/25 11:14 AM, Jonas Gorski wrote:
> When bridged ports and standalone ports share a VLAN, e.g. via VLAN
> uppers, or untagged traffic with a vlan unaware bridge, the ASIC will
> still try to forward traffic to known FDB entries on standalone ports.
> But since the port VLAN masks prevent forwarding to bridged ports, this
> traffic will be dropped.
> 
> This e.g. can be observed in the bridge_vlan_unaware ping tests, where
> this breaks pinging with learning on.
> 
> Work around this by enabling the simplified EAP mode on switches
> supporting it for standalone ports, which causes the ASIC to redirect
> traffic of unknown source MAC addresses to the CPU port.
> 
> Since standalone ports do not learn, there are no known source MAC
> addresses, so effectively this redirects all incoming traffic to the CPU
> port.
> 
> Fixes: ff39c2d68679 ("net: dsa: b53: Add bridge support")
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>

@Florian, could you please have a look at this one, too?

Thanks,

Paolo


