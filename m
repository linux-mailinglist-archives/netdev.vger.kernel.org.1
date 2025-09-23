Return-Path: <netdev+bounces-225679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80710B96C3A
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 18:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA119173C4C
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 16:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9242C2E612F;
	Tue, 23 Sep 2025 16:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="20JRUndR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF6426C3AE
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 16:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758643714; cv=none; b=LZiV5muVLzdoGSI8lti1LXwLubxzTrgUxH7jPmEsU8eonyTKaOrIQ7kYNa2p931oQMJsxcUspPNVaRdeRxJDV+dU7LxJ7A1GMs8wOg2kJebMK3gJDdR2RG9dNitTa/B0y2jI7jP5V7IiOfudb2EMPkP5G3ZeqBTRb6CFwkOQSX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758643714; c=relaxed/simple;
	bh=sxbRvK9OdGpAwngpaMvgersbDCyqlAMTmz6xBMO3hc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ujkyJsHHL9qvXXJkctpHgBtoGa6hqDbG5I76jFe27X8kmbN7mYzDP7sBPOSOhke0ytMBmxccFAWubh6v/I5gBadFSj+hHXFahq+oRLdbHf1ioVLZObJY0v9P4mKJnE01Z8b2ufATT26zo45K/1Q1erzh0fy1fN8RkCkReDfPVAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=20JRUndR; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b55562f3130so1381070a12.2
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 09:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1758643712; x=1759248512; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zn6Mvuo2dzjtDxM71s+uFF4wqTdcTSTG7aNq/ZOAW/o=;
        b=20JRUndR9x5VGESJ+S3eroNxQg82IWoVuoDIANZE8gEeJ/9C8an54eIr7po7xWxETJ
         3oRh1TcPMT/paV8SbOhT3VM0RHJGMEJoLQxmhTBlKQx4/tXCyd9OYD98VLbzuIl9GDUv
         Qic5ohrX2c4Vm/ciPBvOuca6/WJSiycdIJq05+IsbBXY8Hs9KGNl+ps0OaUaQebETgQK
         i9xp5bgblfmbwmxQEzYPWAsgk61nWSJ6ORX4dnZh+/h9VjcMU4DZP6oI8hiusXJ6r5Cp
         9HlQWqgZX6sPIuZPalYWkiPNzeSl7xWlaurS404tRXVc+mB+tX+MTCJJbdKObEkk6TIs
         8ngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758643712; x=1759248512;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zn6Mvuo2dzjtDxM71s+uFF4wqTdcTSTG7aNq/ZOAW/o=;
        b=bY4KwQs6MItkS2/1+fABvlFxBR9LM3nidkmD6GqOn0yAIblDLrxxAjksQ4mv7LcEKO
         yNpSRwy7mX5hyUpehyIB60RFTt2zN/cJEdfTL7xntCblsEq3lr5sd2/GyNuq3U/ak0jU
         20sQTRQSK1gAVfhQ0gvMcw3uRaKfbf4/fmKkbiujHs/D0W/O59xthWZAEfDwqetAd1YM
         R1BEg+eBdlZM3th6msLmzkFMiDd7U/5E/ycejs2uoWUNxrFuG8BpOno/fOS3bli95nrZ
         dNs7AlHBjjBsoDVdb+G5icJrIfsAR3dg9LetvCucu+nubRXWVeDPzf+83SuZUhTmGs/E
         W+bQ==
X-Gm-Message-State: AOJu0YwQre9giB5JQf7VJNnRHsAEjKl79AH+QrNW9s9I1/PwYhWvC5RB
	Vw5tPNLWZUCF79GIqe7Rm7IA6n7ZY3SxRu5XiIphyKxVKLZopXAy/VBY5lJB0n25XFw=
X-Gm-Gg: ASbGncuxiEhIsY2rCKcbCn1YbHKyT+tRSjSBVEEBsZF2UHlNB6inPkRhIvYgtW0xbT/
	ClQrEJLACF+HpKC3/FqkLmHtEh4k42wMtymxdKUWTauaH+um6QnLYYDZHvr1VGMZrdxUXDaIZ6Z
	3HPOUOEYFSR02m+AdgF8d9KHPFMS3cQycoRWRZcThvGa/Mi0j+Q7aD8YTdqi91SOvXeTzvJWRFm
	N93or6x/SOijxALrLHa82L9OhRoy5iUIdmDg4P8rUB/9pKFfmBBaCNACAZkYw+7hrAa0lRQlz0v
	ojL5dXthrGYLsHB4lPemHoM036GigvkWPJ6L7k+C9ZXWSquffH7QZSJ6zw2F1fY9AtstyPFOSoq
	njF8QwEKE6yp9NTMqMp85gFuteZkb8dCmg9FhgOwin7WRq5gcCjua9tQexgRioadj
X-Google-Smtp-Source: AGHT+IF3cZHVbp3tgTRcPr3hT+w0SnmMM4i1lfdtUaK02T73T2tgrz/KXuRmiF1SvBIdqIZE8awJZQ==
X-Received: by 2002:a17:90b:2689:b0:332:3515:3049 with SMTP id 98e67ed59e1d1-332a91ba786mr3612187a91.4.1758643712247;
        Tue, 23 Sep 2025 09:08:32 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:1:ce1:3e76:c55d:88cf? ([2620:10d:c090:500::7:1c14])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3306085e6e7sm16482892a91.28.2025.09.23.09.08.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 09:08:31 -0700 (PDT)
Message-ID: <5709255a-6cd9-4c0d-970c-a7e2c92984fa@davidwei.uk>
Date: Tue, 23 Sep 2025 09:08:30 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 07/20] net, ethtool: Disallow mapped real rxqs to
 be resized
To: Jakub Kicinski <kuba@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com
References: <20250919213153.103606-1-daniel@iogearbox.net>
 <20250919213153.103606-8-daniel@iogearbox.net>
 <20250922183449.40abf449@kernel.org> <20250922183842.09c7b465@kernel.org>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20250922183842.09c7b465@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-09-22 18:38, Jakub Kicinski wrote:
> On Mon, 22 Sep 2025 18:34:49 -0700 Jakub Kicinski wrote:
>> On Fri, 19 Sep 2025 23:31:40 +0200 Daniel Borkmann wrote:
>>> Similar to AF_XDP, do not allow queues in a physical netdev to be
>>> resized by ethtool -L when they are peered.
>>
>> I think we need the same thing for the ioctl path.
>> Let's factor the checks out to a helper in net/ethtool/common.c ?
> 
> And/or add a helper to check if an Rx Queue is "busy" (af_xdp || mp ||
> peer'ed) cause we seem to be checking those three things in multiple
> places.

Sounds good, will add.


