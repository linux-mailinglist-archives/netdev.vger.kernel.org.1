Return-Path: <netdev+bounces-243253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92292C9C485
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 17:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DFD83A6948
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 16:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D418299928;
	Tue,  2 Dec 2025 16:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m5xovShV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f68.google.com (mail-yx1-f68.google.com [74.125.224.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D442296BDF
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 16:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764694026; cv=none; b=OBvNJTKIOaVqP62lsLG9CVRk84U86USdA+TCTLcb6BJznQB7RwFJyh4NtrQmlmO8soLpZ8zz2UsXwHZtU1WX91jVyjsThLCyNW/4ADZRAcJKsAqHhfMOpLCYRw5quBdTS6XH3obZ0UGbcNDqYgGBse4bwGbjuxH60WqPwNilPF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764694026; c=relaxed/simple;
	bh=rvHOTZK54QpLdmz7OdwA+atkWLFefRgYdIVDMu9Y5jY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UAKOJEf2ayONJGbpv7W298J3OQydHT9XNtfT/N+42uvgE2E/xWY9xlKMNqF9s10Sk4NHBeXK3gIK26BfG49Ms2K1VKH1lE+8kc7yY0xp4tN5alrvkUzljMpFgHoBqv2XiYOulLvsegf/22bh2KlRlyBBlejGqKDzkeAoaz+25kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m5xovShV; arc=none smtp.client-ip=74.125.224.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f68.google.com with SMTP id 956f58d0204a3-640d937c37eso929321d50.0
        for <netdev@vger.kernel.org>; Tue, 02 Dec 2025 08:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764694023; x=1765298823; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JwFSV7IqPTrkvtkooe90woZdm3G0cJXWAoU5KVeF0Ng=;
        b=m5xovShVMZkpqtTZ0V1gJLmqR6wlnlufJa47QwICkUv46IMfUHL+WllEi/niY6CvwK
         3dTv9/a0SByI8BB9RTylThxTnHzwXME6iRokh//pjQw1QFoHSjIYB73Nz34BDK+oXxHB
         /R8qolQsN9sjYOUkVRsyx48GXueyJuELM9F6BIfsuhAibThN3SohLD3Yy/RG/6zDPMyX
         fURyUtXgQXxbCukQEcG1rGAMjEx67GR/rZBLiJh0yPGPv2jqbdg11TVIfEvWJAOkEBc2
         6MsKeaA7HTXp/+4Xu0DkboCtHiynZj3qzDH2Jq+JobTGAh4LF8rPF0Cwgw+U/ghrY+uo
         hm3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764694023; x=1765298823;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JwFSV7IqPTrkvtkooe90woZdm3G0cJXWAoU5KVeF0Ng=;
        b=OTFhp0oQRvm/wDGRTGKW4XYiptGZfafs4Z67X9+qOQcwpNz+GrDyZ33zFF8eXtuTHf
         Un5NEExXQO0A+0AIPorzuLmwRXDPpbUPmXkGwdf0TKucaVlmvvHlrPbIEsbIt0rfFpUZ
         7p3mwyJL19aVBg7TXcsVEneKQ+6/T/swpcAoYfhn75L/3fgfh732rhVhVLyK9IMqK2DZ
         gWQ6eBIjzGjFdiYVS7yMCaX/kHs+RNLGcWOzBr2WzX9lE7XifBh8J6zMwhO07Juq2gKC
         LcnZoPPEtmoqLeMnTM5wvk3Iw3m22dyy5yypxZmk1kGhQTxv+K5OtZptgTBozIgbYLDn
         quKw==
X-Forwarded-Encrypted: i=1; AJvYcCVfo5LmpJu8zHk6IyfcJdHsCEQHtfVPHDJJDr2EHDX52Ih9OOEuMuxbrMyq7lUb7yx2II34AfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9yq+bdto/CC2aab8+2U0nlh+TJKZ+10iLvuSmrUjdDIaIicc+
	2j7keXgZuCez8VPlF0IbQ405Zw2esayDUvL0ptOfsi0PqxQv13CP4ic/
X-Gm-Gg: ASbGncuCrFSAMPY8y6da3sWUfCnQaUpul3t8MmBtX28m4AWqSEEc/kGtviFnDfzgT1Y
	BawOITgisAHg9gUf+0XqxgW5GLsbClhr9hgdoB3nqQ9tEZvupiPAhji/Ike0pmym14cfE5DtN8u
	CMrtJtEzUrIdELyYSP9aVxu7NJ0ncLpoOkH/F57Xt5kNKDaxVKcgzYggnHhGR554q//ZbU2+bTS
	YCrqHBl49+za9bs5oaHSBmfJunc8WtcDWk1bShKZrOBk5BFhzOuHHF76i3wItQuqs/a5vBiC1g1
	je5icWxKlmZdMJJ2yCbD/mdC2FWTnl6Vy5v2ntjF+8f8qX5MWBojkuz9kLcNQU8l0c9CSw080UP
	LKiuARST69S0oLqpMVFZKorcsei51OMBkpqlvgRpFSYlHis67OO9OrQ1cNo0gVJoyfQ5l3Q66F7
	7zC7gA2Han
X-Google-Smtp-Source: AGHT+IGt2Ur80bYsSXzrKRVSLKpbd+SPPtBmH6YL8d9mStw5ux7IrJzsUEkOr2hw+F7iJseVNUvtyg==
X-Received: by 2002:a53:c04e:0:20b0:63f:be57:ba64 with SMTP id 956f58d0204a3-643052da1b4mr20333827d50.8.1764694023325;
        Tue, 02 Dec 2025 08:47:03 -0800 (PST)
Received: from localhost ([104.28.225.185])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6433c443ce5sm6380420d50.12.2025.12.02.08.47.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 08:47:02 -0800 (PST)
Message-ID: <1dba15b8-64e8-4ed6-b3d3-9bfabacd2d1b@gmail.com>
Date: Tue, 2 Dec 2025 17:46:58 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] selftests/net: remove unnecessary MTU config
 in big_tcp.sh
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20251127091325.7248-1-maklimek97@gmail.com>
 <20251127091325.7248-4-maklimek97@gmail.com>
 <8fd45611-1551-4858-89b5-a3b26505bb00@redhat.com>
Content-Language: en-US
From: Mariusz Klimek <maklimek97@gmail.com>
In-Reply-To: <8fd45611-1551-4858-89b5-a3b26505bb00@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/2/25 13:01, Paolo Abeni wrote:
> On 11/27/25 10:13 AM, Mariusz Klimek wrote:
>> This patch removes the manual lowering of the client MTU in big_tcp.sh. The
>> MTU lowering was previously required as a work-around due to a bug in the
>> MTU validation of BIG TCP jumbograms. The MTU was lowered to 1442, but note
>> that 1492 (1500 - 8) would of worked just as well. Now that the bug has
>> been fixed, the manual client MTU modification can be removed entirely.
>>
>> Signed-off-by: Mariusz Klimek <maklimek97@gmail.com>
> 
> While touching this self-tests, I think it would be nice to additionally
> add the 'negative' case, i.e. egress mtu lower than ingress and bit tcp
> segmentation taking place.
> 
> /P
> 

Good idea. I'll update the tests.

-- 
Mariusz K.

