Return-Path: <netdev+bounces-106756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE4E9178A6
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 08:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFC50B2194F
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 06:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047F314B07E;
	Wed, 26 Jun 2024 06:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="LwBQoF01"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7029E14AD0A
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 06:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719382342; cv=none; b=Da65vg9vld0d5weHukO3Nu6YuhldGOlvmABb2nj4rMGYhOFxDTKlUeC3UB4y/JjycNA4TfjqQLSa2L+uctKbo7LgQL6B59DCPFpn1VubuJhoRl5ox335PVK202EedTeGM2RA9hF4dQYeYjrVDbnATVNW1dTVVFSK7+ZBEiORoto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719382342; c=relaxed/simple;
	bh=3IHUnMysPIrsBbbMOJVZA/aR5LfcvHnEMCNFSRo5/G8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dPiZxz1sdxovbCvgeHYbRavYDclrCXG9BI3AAUUc7uLfIAPgQTNb2WfBRBDzZCLdQXmJ0awehf2rePtBqsPdv4rsv/YaIy/bmhyTEQ/UdJVc/6J32HOvTAnLsa2R64aVEShjYD8nYZl/WlsIdhUs0CGsB+amU5nSCZ5wWOG032o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=LwBQoF01; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57cf8880f95so7399123a12.3
        for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 23:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1719382340; x=1719987140; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=De4Qa64Vy0xiCCjx+ckyEn5vgf1jElvReJSCZCiMh6U=;
        b=LwBQoF01mQNdMTyeISRddbZ3hy81A81rTV9UY3gmi0N0mbuF5LosfLay1H2mIMgWgN
         dLkXqf8SIX7AUeAHSeXXp5xTZ3oJ014Fl8IZe+FQGnjSPrVThtbNRIwBQhjYsyD5NUuh
         HucUyrw0GpemZuxJngfZNkWZiB16QJPW0/3gK4VLLT5RDHyN+0eF9pnZScTwsFys6UYO
         nTw7GfQ+ApTQ/QWTGT3RJgo2rNbLvu/0EPgqOSjoHJ199WImkUZxX8EsOO8D+Rie1LP+
         t4ZZN4OYZ6aHCthlS2gJ1uzHdXFhgY1PIxekhX/EuhiHmjtx4zCviGdsUJDQXBhF8IMy
         /8bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719382340; x=1719987140;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=De4Qa64Vy0xiCCjx+ckyEn5vgf1jElvReJSCZCiMh6U=;
        b=BQXKqX4tXv0CSjxvnT/MwltVKBWoe3g9jpWUNefQOnxHVkElT/duXFsoYwgSFIC1P3
         FndHauM+vqv8b9YK0kL/9yAb+7RWZvuJ91PhjO3cMCDYjMHHE0dnOuQRiz8+gwITIxBA
         UzQQX+vYVz9ghONJH/tzCtRxi7gaRKck1Q977S7D8aIcGmyxBHQQ5qQYZErMD14f3onR
         Qta3t/vcGS0/QWfOkwEHttIb1QBoWWLXIqrJxUrskxKaIIeBt/YSUC6PYZvmvOmK9amu
         W//YVNJfxAoMAXSI6akeYDLNfLMekRvO6E+ikHQWOvauPiba1J+aBYZdFcYLBGg5H0d5
         Wckw==
X-Forwarded-Encrypted: i=1; AJvYcCXXVl7jx4v8JJvpDW2rjC0c0kFnIJHU1SxleL7DAyhX6n0YLBA4VnTM2Pu7EneQ/guxzHonXbKvGTWZJQ7i0Zl8MLP5gh8m
X-Gm-Message-State: AOJu0YwnoX10zlKy1qp+etFvAqgZc7z3QUoqmZIohPuf/UUkwpmVIPZc
	FqP9PRfPKHI31vUeSif6LvwsE/xdxp6cPudlBOblkzStu88i1W4m43oxy7QTGIY=
X-Google-Smtp-Source: AGHT+IFNEIF2xAwZ81aI1JLG9NfFixSsNfH8n+rPoMP6WihUXDTh/CDDfYYTAoM+X7piloN6WZIMiw==
X-Received: by 2002:a50:ab56:0:b0:57d:69d:e6f8 with SMTP id 4fb4d7f45d1cf-57d4bd63273mr8259384a12.18.1719382339802;
        Tue, 25 Jun 2024 23:12:19 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5827db501d9sm1266419a12.7.2024.06.25.23.12.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 23:12:19 -0700 (PDT)
Message-ID: <08be9f68-09a2-40c2-aec8-7d24cf4febcd@blackwall.org>
Date: Wed, 26 Jun 2024 09:12:18 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 iproute2 1/3] ip: bridge: add support for mst_enabled
To: Tobias Waldekranz <tobias@waldekranz.com>, stephen@networkplumber.org,
 dsahern@kernel.org
Cc: liuhangbin@gmail.com, netdev@vger.kernel.org
References: <20240624130035.3689606-1-tobias@waldekranz.com>
 <20240624130035.3689606-2-tobias@waldekranz.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240624130035.3689606-2-tobias@waldekranz.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/06/2024 16:00, Tobias Waldekranz wrote:
> When enabled, the bridge's legacy per-VLAN STP facility is replaced
> with the Multiple Spanning Tree Protocol (MSTP) compatible version.
> 
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
> ---
>  ip/iplink_bridge.c    | 19 +++++++++++++++++++
>  man/man8/ip-link.8.in | 14 ++++++++++++++
>  2 files changed, 33 insertions(+)

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>



