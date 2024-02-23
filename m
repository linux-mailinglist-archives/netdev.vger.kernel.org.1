Return-Path: <netdev+bounces-74490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8546861796
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 17:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0A95B27408
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 16:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D5981ACE;
	Fri, 23 Feb 2024 16:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="bcVGObZU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EB984A2B
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 16:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708705084; cv=none; b=ggKwDMdZAZDnSgPWwDywS5LkvV9QX5BJahRPOqhF6GGTNICgEfOvQ2i+BRD5MRDgSkTI19ERkJqp2NIm1TmKwDgHtkhjv5LsfWCpc07KXcsFiAQXsnLKxFeRlLagN3agkilIF2zy8TGuAOjzbVhfnC3pLgvsrG1piIIs0nUvMGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708705084; c=relaxed/simple;
	bh=ZeKpEDGthyBm92GBJ7vynaoZV/nbSU8wb9wOEWK9WPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EuBGr0+JMKFAtOswTxgVl933gpOdChzxp8qlB40AGQwnXmEJ2Z9K04DJD0XcEf/Ss8rUQThBe+Sp9MANnrfneA1657UqvDaJ1U6T9T5Wn06dVs6+cjURJkapn6Ns7Xsm6oDlxVVuH6hbRGusGL4k179wyMBIIABd2L8o/swL3fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=bcVGObZU; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33d7b8f563eso776137f8f.0
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 08:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1708705080; x=1709309880; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZgNUcQoYuTvAcrfrpLGWN1fgqearz8kZ3wmE6QwbLHM=;
        b=bcVGObZU4tjSq2wBfRoLWkyhhr7a29gxUInR2zyq2p80Pq1SwVL+691I4psg95Xo8/
         2oO4rOjEBOEqtlhCZnbK/NJehoy1pj4lKc9nUgGxda8IY7FZfn6zT7b0WDvpR7mAS3sF
         ZQJhsQbn3GQdXEF8nOxK5d/YQmoRjrKCNDr4qjo9PL6A3Bms1g9ALYIcsnghtDE47wCd
         dtzwWAgKQ0p5UK0G+34Y1lVMBUNWkjLSR+yjoUHU3BoFPHBLqYDwLyMdifqmzqgLh61x
         WKq8lkiov/tQrbW+CsogBHoo/NyZloiOmrSygplw7Zx+Wm5H3Ja+y8Q+gumX517sZua9
         Fe9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708705080; x=1709309880;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZgNUcQoYuTvAcrfrpLGWN1fgqearz8kZ3wmE6QwbLHM=;
        b=ou/yyTsF6ZAAvMFqQOHvneeyjEnyXW3Zug4hAlP9CaF1DfNypPTexj7BtYR3tsG+4R
         U/5+8j/wHbiC7eaTH24glrn3SqrE6gBrm3vwHUOxtXQ0wN5/hPnqB3LbjWVVkligbiO+
         MTPXwReEbYvj30h11acoJd4QjAiIoH2X8tlj0pID8c/4q/EF9osnjV/3bVdMwxmZ+o5a
         KjMdNcSOJj87NrZ87C9ZzJbWHhcXomKRULds4pHV8E16IjiQj2NAi5u08uiMmI7GVhWk
         iBDpS/06PA3dwEo+g+5ToFuDhqXFTQryQBFMF2dB+AyoJVi8EV9qNMSqFMqRV+hc5edl
         z5Kw==
X-Gm-Message-State: AOJu0YyHFB8WJnc7AFLpyErIMdQ0PLi2/zcKADKVcteFlgVEDnBdRcTU
	iUocI3lAQC1Ib4MsVO289V2Z5KOJwjyoQugpET/e0sTrgxmrmnY4SwV2Xuiwo2Q=
X-Google-Smtp-Source: AGHT+IFOcxa6ij3IkcXSt80A2iHQxqjYAoK45c/7wNgN/am/tPdYGhgqqrrUkzYmZZ6rdLJXweeBUQ==
X-Received: by 2002:adf:a418:0:b0:33d:63c0:3b70 with SMTP id d24-20020adfa418000000b0033d63c03b70mr135444wra.62.1708705080213;
        Fri, 23 Feb 2024 08:18:00 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:25c8:f7d3:953d:aca4? ([2a01:e0a:b41:c160:25c8:f7d3:953d:aca4])
        by smtp.gmail.com with ESMTPSA id b3-20020adfe643000000b0033cffd1a302sm3264606wrn.57.2024.02.23.08.17.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 08:17:59 -0800 (PST)
Message-ID: <cf131d9a-368b-41a7-b0fc-daeea144e26f@6wind.com>
Date: Fri, 23 Feb 2024 17:17:58 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next 15/15] tools: ynl: use MSG_DONTWAIT for getting
 notifications
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 jiri@resnulli.us, sdf@google.com, donald.hunter@gmail.com
References: <20240222235614.180876-1-kuba@kernel.org>
 <20240222235614.180876-16-kuba@kernel.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <20240222235614.180876-16-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 23/02/2024 à 00:56, Jakub Kicinski a écrit :
> To stick to libmnl wrappers in the past we had to use poll()
> to check if there are any outstanding notifications on the socket.
> This is no longer necessary, we can use MSG_DONTWAIT.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

