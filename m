Return-Path: <netdev+bounces-128935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA5497C802
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 12:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EEADB25B62
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 10:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925CD19ABB4;
	Thu, 19 Sep 2024 10:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="mZsO4AGi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D8B198E99
	for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 10:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726742009; cv=none; b=grnRNHRi9jfWtsxSEcuYiFUuELZMPnAnOsIve+BFPm9pI1LCUjBfKNQ372rv+pCKfHjJ2Cuc9Irk1ahmlOqxkwymbgl5SJLiOlZva7SpNIFQYHE173oJOsAUuQargXtrPlyUE/obRzDGc+gPEs1zouFlk84IlUO8GcCXrs1Q2P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726742009; c=relaxed/simple;
	bh=V1YPdfqmajIEnriwvuftpiMyY/DSrs4cUIhXE5P3RNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MyIgOz9aj40OxBySt//b/YdbkfNj6r5UYcHGqAhjo9dj3GWMr+ko4bSueZuj3E9gn3gTKh89GodoBCw5hvXJ0FGJQYCuTTV7X9z/wkUVEIG0x/FApBdsyHGzQEEmH+WieJpgqS7vgh0lYVY9FLyE1+CPR+JmXnbkO098BxE2Mrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=mZsO4AGi; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c3cdba33b0so917079a12.1
        for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 03:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1726742005; x=1727346805; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6ElPw2rkqJxy3GrSWwEzcQxJQL1TZQOW7P03usn2dqU=;
        b=mZsO4AGinb40OfWru/ps8zvUfk+S+Sv18uHs3qO9gXqbkfZo6jyvxT/Re/ywXFoZxH
         mOU4itu+K9yI6guIlP54rl5nsTVEjlTf+PBJsy+Pp0775yFdo/YdmDaEE6FEYJp0zzGb
         L4tjX/8QrNrhZB833AZSgYQaJ5r3jqpMyU8m/gXYyl0ovs0orSbAfqDCyGr2m5qZMWp6
         bD5uQGmmXt3cjmloTyigVPG6KgjLmdAV4LpG/8tr7cGBE6Jv4bKhG+pj3wCKFXKuodIV
         otjD0mgd+IxlBI12HGph2/UyYiYjhPodkuup+KdgTKf25eP5W3QJwWX/1o9at5TXgoZ7
         hwTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726742005; x=1727346805;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6ElPw2rkqJxy3GrSWwEzcQxJQL1TZQOW7P03usn2dqU=;
        b=SOQqh/C8W0xM19KwVZtQdLwGYQNvnksNErjG4PtTvrETf2BZeup8KWfXyxI8ey+3uv
         6Qma/8L4ljLnxzu0rNM2J28F1VbTh1JYOMU4vHAR1xkCuG6w8KczHVRsfwLiH275x33n
         qM3jQR29VMgvcMrlST8wBSmVROcRP6JN/c7HRnkUtEFcGpkZhRacW7oIEetRcAcqFIWU
         x0EaRKgSV3gI3KRDT4Tx0OejwmpinPBtWyTx12kI8oKLucg/MCq+BSrLjK7cS3SySt3m
         LNZ3iipemGcvsqd+YO6LF8Upc0Zlt6Ji1Bb4cpazl7QO/XyIbs/0b5TlcU2x31Ll41q6
         AULg==
X-Forwarded-Encrypted: i=1; AJvYcCWKgscI0Bb1WV3/AJNWsaZLmWXJahl3gUuGWsdnlye+zv3UlhCA68ee22wxKDir3qn0J2gYK5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS2xr6bWG15fyOgVb1t/T0UkgMcztMbzkMSleJ2kP+/7ZddYRU
	CajxmAP7CFS77gDZpTfhXinUxM3kNi1LBlZXKXyqi4fZau0wYB4/4PR+Y3e2RZU=
X-Google-Smtp-Source: AGHT+IH5FaHwIy/HpPwgYVmO7IWOIFZ4wz7dkZfK70jhdOMRpGV6GaHoSjwhSDN9QfGUWFQLWu83lA==
X-Received: by 2002:a17:907:efde:b0:a8a:8d81:97a8 with SMTP id a640c23a62f3a-a902941ff90mr2191026166b.1.1726742004941;
        Thu, 19 Sep 2024 03:33:24 -0700 (PDT)
Received: from [192.168.51.243] ([78.128.78.220])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612e5696sm710812966b.172.2024.09.19.03.33.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 03:33:24 -0700 (PDT)
Message-ID: <934bf1f6-3f1c-4de4-be91-ba1913d1cb0e@blackwall.org>
Date: Thu, 19 Sep 2024 13:33:22 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next] net: bridge: drop packets with a local
 source
To: 20240911125820.471469-1-tmartitz-oss@avm.de,
 Roopa Prabhu <roopa@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Johannes Nixdorf <jnixdorf-oss@avm.de>,
 Thomas Martitz <tmartitz-oss@avm.de>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240919085803.105430-1-tmartitz-oss@avm.de>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240919085803.105430-1-tmartitz-oss@avm.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/09/2024 11:58, Thomas Martitz wrote:
> Currently, there is only a warning if a packet enters the bridge
> that has the bridge's or one port's MAC address as source.
> 
> Clearly this indicates a network loop (or even spoofing) so we
> generally do not want to process the packet. Therefore, move the check
> already done for 802.1x scenarios up and do it unconditionally.
> 
> For example, a common scenario we see in the field:
> In a accidental network loop scenario, if an IGMP join
> loops back to us, it would cause mdb entries to stay indefinitely
> even if there's no actual join from the outside. Therefore
> this change can effectively prevent multicast storms, at least
> for simple loops.
> 
> Signed-off-by: Thomas Martitz <tmartitz-oss@avm.de>
> ---
>   net/bridge/br_fdb.c   |  4 +---
>   net/bridge/br_input.c | 17 ++++++++++-------
>   2 files changed, 11 insertions(+), 10 deletions(-)
> 

Absolutely not, I'm sorry but we're not all going to take a performance hit
of an additional lookup because you want to filter src address. You can filter
it in many ways that won't affect others and don't require kernel changes
(ebpf, netfilter etc). To a lesser extent there is also the issue where we might
break some (admittedly weird) setup.

Cheers,
  Nik


