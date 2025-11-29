Return-Path: <netdev+bounces-242703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 857C5C93D43
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 12:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB06A3A6AE7
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 11:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE612E7F0A;
	Sat, 29 Nov 2025 11:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aHA4GqDL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f100.google.com (mail-qv1-f100.google.com [209.85.219.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48B4276041
	for <netdev@vger.kernel.org>; Sat, 29 Nov 2025 11:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764417570; cv=none; b=RdHDahnm96SR0/MBrbzQrAS68zavDeXGdrwACyxNh+yCZn/fetoXz0ZwSHq4TyVfGCdLPPHNS/ZNIK6lgvKisA6kyqqhUrkqiT0WbL0ttUzhsq/ZTIZOTFNFrp0+IcNunP9tzkTpaaTJR/ZpqWYZtD1s2deYMuLxxSffFdp4cqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764417570; c=relaxed/simple;
	bh=U1Ssw4lZ2jfp1OsVrnw2M/14omKMBGMOxTLKnTRh4hI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rlfMzNFAEQnaitAUaUt2VHvpETW18y8IrnsGfaZ7FmGSxzFf027r5p83gmySJbSYb6fE79kvGz1tz2qnwCOwjqxEsxQBhbxzvi5LuurI/uZPh79DQFYxUbe8SJY7zw8rr/SIS8/fsmAGxYd/8rJireNiSwQdjj8bO+bQ+0O9qJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aHA4GqDL; arc=none smtp.client-ip=209.85.219.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f100.google.com with SMTP id 6a1803df08f44-8823dfa84c5so26510686d6.3
        for <netdev@vger.kernel.org>; Sat, 29 Nov 2025 03:59:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764417567; x=1765022367;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AMuZ4MA+cOuMgeux+0oZSodeGOO8PZYtmnxDebxkm7o=;
        b=FGRvUq8rzcZ2fwyusmZehMenYUE7PqHi0iNn8Dv4H2zEJjbq68rI7FqA6cAqKkRa4z
         GHCOM1Rcvhw0OIXepiBGo36ZbsnvtFtXlMPyJWgRJXvbKv3KBRDwe0z6mRWuFA0vo5EZ
         pz7nitAdKIP+FwZIWt1Xtnky9+V4rKfsak32jjWTD61XcqI/1MR9NbgI+sZ9kdr51KkB
         xrZUXmvlUmAjFF1Kk91akel5dzAZo4iFMgHkT8fOvnaBn2m+sMCFFHs5B/WLqt2vsc/b
         S5bmBC5g1YeYZ0AuhurpErjfpeFcsdGnGukpbIAnalHC6gR1zLBuXCktCbvSv836GkiL
         3WWw==
X-Forwarded-Encrypted: i=1; AJvYcCVV6fb2Yu3OMItyzf2wt/9lcadndsMCvcrbqTqSbVNy00IXFmf48Ic0TTvyybthE0t9qvCjB1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAWwfeyDESSW13PzKih6cSMj5iCz5uzqMXF/myMcWlUBiZUYR5
	DKMEUTzS+0Pob9UGSIM9ZTdUHSnEdvK8dnxUy5KqIYdfnKHeQfoXCtVhPyLowGY7r2Vic/SBUUD
	u3zym3EKFCXA2DCQm+jcXgUCFAzHrGeiy3KkCXamN1WOMtmdjS72ZMdEK/kPKUeCr2kLKuq0fcd
	3JR11pB+f7KxWATYbdM1QT+puxSJ/O11azK+0INVDM05mV4IuRez6qIq3F84++TaXbFjvCEwb4s
	DoJUViCUIL/8LU6hQ==
X-Gm-Gg: ASbGncunyZVVWXR2QKqU/CXL4ibSuT6wIkKHKnv7EsZLmrKjHslqAzzNhSd5KecGQwd
	ZgrykwiMiopTj9zKltYeicbQhgM26bpAX0yLz/eV47RX+qldINQbolKSAbTOmohNP+qDfVlqWSl
	bpSg9fjV3earF8a9L1P7SG/PPpijabfcQwldIo+9CPM4nJUcV9901vpI58jOWzWX3LRLZ6f6oIu
	2jRF1qqJVJhuaZm4SW6LGXBUm9vJrIc2+6TQMH0YEAjZ9hX2in8op9boG/LaJCpsjAaZm6EUMAI
	j8UrxgWfy7aZZ4mOAuI4lRuISAWjBKmPVqjspG+qQxUpwxDxXPoMa3OEofPcAHcaf7v5mGqYr2p
	bTTSUo4ZKDtvaObxXHX57QYb5x1i6O3P3cQkXZOVtru2iO6HE5icKZt5qUmzYz0P3A57966S099
	6C/ayQ4Y3ubY/9viNM3i+ox8Ecdk7TFAJX/MrVr9QcEcuxM5Ev7F0=
X-Google-Smtp-Source: AGHT+IFoNWQGzonfahTJsf5WrgLOJzym+NtKXyitbxFR4N6oUPNZSTgi0YuUDEydNIMxTVy1qt6LwoN5K8dE
X-Received: by 2002:a05:6214:4597:b0:882:7698:9f2 with SMTP id 6a1803df08f44-8847c51142fmr477469236d6.31.1764417567454;
        Sat, 29 Nov 2025 03:59:27 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-103.dlp.protect.broadcom.com. [144.49.247.103])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-886524cc9besm8670016d6.14.2025.11.29.03.59.27
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Nov 2025 03:59:27 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8b234bae2a7so495127485a.3
        for <netdev@vger.kernel.org>; Sat, 29 Nov 2025 03:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1764417566; x=1765022366; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AMuZ4MA+cOuMgeux+0oZSodeGOO8PZYtmnxDebxkm7o=;
        b=aHA4GqDLuDbRsf0rMCnWzKLCYBe077oywFM5wK1SuPih8tNSX76AhYwuTbQU02Knj3
         raOmaTnROwVxr0SNVwPKSd6d42lfVBal7jLs8cXfzFCc9qkjmGAWCLYiUPqakArpsRVR
         8/o+RrUW38eWUyOzKydqnNKg7mnNLmjCcLNBM=
X-Forwarded-Encrypted: i=1; AJvYcCUaUKMOOibaEehjo61GzP/UcBsRfWQX9mebCilpZ+MmNO5C0el+EHot7n54wSOoybGT4O4bm7U=@vger.kernel.org
X-Received: by 2002:a05:6214:c84:b0:880:80b3:e29c with SMTP id 6a1803df08f44-8847c489816mr497530926d6.14.1764417566536;
        Sat, 29 Nov 2025 03:59:26 -0800 (PST)
X-Received: by 2002:a05:6214:c84:b0:880:80b3:e29c with SMTP id 6a1803df08f44-8847c489816mr497530696d6.14.1764417566188;
        Sat, 29 Nov 2025 03:59:26 -0800 (PST)
Received: from [192.168.178.137] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-886524fd33fsm46223966d6.24.2025.11.29.03.59.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Nov 2025 03:59:25 -0800 (PST)
Message-ID: <73783333-658c-4d84-ac73-e9932fb22d64@broadcom.com>
Date: Sat, 29 Nov 2025 12:59:23 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: brcmfmac: fix/add kernel-doc comments
To: Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org
Cc: brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com,
 Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
References: <20251129073803.1814384-1-rdunlap@infradead.org>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <20251129073803.1814384-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 11/29/2025 8:38 AM, Randy Dunlap wrote:
> Correct or add kernel-doc comments for:
> - an enum name typo
> - missing struct member comments in struct vif_saved_ie and
>    struct brcmf_cfg80211_vif

Thanks, Randy

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> Cc: Arend van Spriel <arend.vanspriel@broadcom.com>
> Cc: brcm80211@lists.linux.dev
> Cc: brcm80211-dev-list.pdl@broadcom.com
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: linux-wireless@vger.kernel.org
> ---
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h |    6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)

