Return-Path: <netdev+bounces-185459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F687A9A784
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 11:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 589B1441E6A
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 09:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506AA21D584;
	Thu, 24 Apr 2025 09:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="byWvjK39"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812451C8639
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 09:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745486149; cv=none; b=cNjpif3ugD4tpHCodCWtl4tWB+OisVGDRy6kKk4itaD1y1inU8hO83nwcuNYRsEWpHXToOM1vXx4uvz1omTF2AGtBD9ITOlidUocH3+hT8fecKrt2CB2duapyvGoAoAviCO/usQZRhgdckb2p/QOrONPV/zeFAlBEnXtvyME0Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745486149; c=relaxed/simple;
	bh=4PPawEHJO0RzXIkSTztsBVavys1JxXqDXM5aGgonoaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pr8v5sot2Z5xU0n5QtXkSgjCZbgfgjB3RHc2r2TXPIm7sXDTlrDbxSZASPXGkH0TqaSHymzqXilAXKo994vBa0+8zjZwp9APnPdgvI1plXxBJs5s2HQ0yJNratKEAlDSdzPWG/MeSK0SkpPvEDWmO1kL1aIBBLHYBS2r7vnwv44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=byWvjK39; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745486146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nan/dGsgD9S78SkEaYqX3b7ONqNlN/LPIyKNn62zAqQ=;
	b=byWvjK39U73Mvaxo+K12loQQfbnnBabqMwWI9DpDIN8fWS75r94ltm8fZ/eq7Ep9NWrONc
	zBwm1C3oDOUvTXraDkVvj7Ea5t6XbNYP9PvFdYFSRUkKdNoe2K0m4lku6m6+IYgZo8m5Nx
	NeQ5pFwz7ytRegR+SqRRQRe4CtnjuIw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-yTTzHLZRPFSGEUUPTSwXzQ-1; Thu, 24 Apr 2025 05:15:44 -0400
X-MC-Unique: yTTzHLZRPFSGEUUPTSwXzQ-1
X-Mimecast-MFC-AGG-ID: yTTzHLZRPFSGEUUPTSwXzQ_1745486144
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43ceb011ea5so4596485e9.2
        for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 02:15:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745486143; x=1746090943;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nan/dGsgD9S78SkEaYqX3b7ONqNlN/LPIyKNn62zAqQ=;
        b=ZCm0Pw04Djrfx8kMzIaVJQo8Bp8h3mhckmxiLc5ztkjSGTkeQ9N1yk759Cdp+Wm96J
         jITdm8/brbKm/zIFwKvgQSbl3z3TujK6FhdZT9DZrobwmL7gpKUGCvpny5orL7j4lamv
         EikhxOmMgdOoB5oWP5UiNDgd2ydx15MG3IUihF6MeeOC4hxCFiWuZl1SriHA8N6wTXej
         9ef8OpLid0mCO5+4EtZv1UXQR5Z8wVTQIRrKV1M9UE1x8BIpuXLHbFmtGKYPueCYIVdh
         kopUAQnBgrNFzHmiQCi7evsoR89KB5G0yU9u2tvjep7PIDhdoGhsp5paIJ9gGpZwSWhi
         ZiTA==
X-Forwarded-Encrypted: i=1; AJvYcCWmHYkfafgG6Rb+dXGTEgZRm7owYRshNmgyqUv5PyZbSes6pTEzyYiwf2SHl2XEq2xFtpRwQGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcCOTmjo/CRqexDpcUeVRgmECWYyz6rBwYF4WyhHEv/9Pv21qH
	4rE54BwvRXScUSN3wqxuq8LD2/699YgRdlN3K4Q4gCHXRLMhkzwyVbwgC1VPDjeU3L4x2uDTyso
	K0dwd48ApScsm9Dlew3me0pNmT9/Q1bnDj3aZBVxAWdHYiZyzduxcmg==
X-Gm-Gg: ASbGncsma8Hny9xFWsl+UmiWazjFFycsxz9/ewp6FZUY6X/QwSTZQXS5h3HtUdvh89d
	N5TbByz1Typ4hVcCcr8K2obgkZgU5KXH2syH6HCRp89cl9y4lDdPykQyyU/xTHpRMlzOvmWvi8u
	hCvEWmh/OUkL1lvcyF7WhaW47qEhACYy3Kwy5ZH3CVYGQFx5O82aANGAuIqvQKyCrWqAuxGMkrc
	wUWKS8xDQOGcAdCXxSytgmcjp3xLp4nX2VyfWyFTA0Pwq94yMus2oUcFs/PkoqYCWIwiN19/o9Z
	wtkvR7gN1JUgzSU0V3/GNxN96C8DwYyI2nm0r/M=
X-Received: by 2002:a05:600c:19cc:b0:43d:45a:8fca with SMTP id 5b1f17b1804b1-4409bda8921mr17007355e9.30.1745486143548;
        Thu, 24 Apr 2025 02:15:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/CKaXSwE795wZUKbdy/SE0/+hp8SxgM4T+j4EpSsDG0YNbGbvkOkUHo0Iq1UkKPXD7k+EEQ==
X-Received: by 2002:a05:600c:19cc:b0:43d:45a:8fca with SMTP id 5b1f17b1804b1-4409bda8921mr17007005e9.30.1745486143230;
        Thu, 24 Apr 2025 02:15:43 -0700 (PDT)
Received: from [192.168.88.253] (146-241-7-183.dyn.eolo.it. [146.241.7.183])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4409d1e1abcsm13060505e9.0.2025.04.24.02.15.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 02:15:42 -0700 (PDT)
Message-ID: <cf0d5622-9b35-4a33-8680-2501d61f3cdf@redhat.com>
Date: Thu, 24 Apr 2025 11:15:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: dsa: fix VLAN 0 filter imbalance when toggling
 filtering
To: Jonas Gorski <jonas.gorski@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Florian Fainelli <f.fainelli@gmail.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250422184913.20155-1-jonas.gorski@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250422184913.20155-1-jonas.gorski@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/22/25 8:49 PM, Jonas Gorski wrote:
> When a net device has NETIF_F_HW_VLAN_CTAG_FILTER set, the 8021q code
> will add VLAN 0 when enabling the device, and remove it on disabling it
> again.
> 
> But since we are changing NETIF_F_HW_VLAN_CTAG_FILTER during runtime in
> dsa_user_manage_vlan_filtering(), user ports that are already enabled
> may end up with no VLAN 0 configured, or VLAN 0 left configured.

Why this is a problem specifically for dsa and not a generic one? others
devices allow flipping the NETIF_F_HW_VLAN_CTAG_FILTER feature at runtime.

AFAICS dsa_user_manage_vlan_filtering() is currently missing a call to
netdev_update_features(), why is that not sufficient nor necessary?

Thanks,

Paolo


