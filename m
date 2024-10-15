Return-Path: <netdev+bounces-135914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D4F99FC9C
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 01:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45BDC1C2447E
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 23:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3681D63E7;
	Tue, 15 Oct 2024 23:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iuHKMp+P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA2821E3D9;
	Tue, 15 Oct 2024 23:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729036415; cv=none; b=PuZ/oZvylAGBXj0PJOqodytvZ4Ut4/E6NyTMUVb8lDbXgoxKATDWOJykMXAFohZF3fc3Y9fdBiMWBIIxFZePwRD1TwBri+R9fK2+VtWJhIpepugV1ln5iZqm/K6H2CwtCPNeczkvM5myFPL/TPGnZSSIa03mhADj7v8F6GbLT5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729036415; c=relaxed/simple;
	bh=uzJQ2dBAwOImyNrqhSSFd1/gdiYbgPZEN0pPuk1aRx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IfjONOcMUGwza9A/F4kwUr38bb80iylo8pYFgiL2HvGZS1GnHQGk/wPuC+Ec+DlH+KFdfYwQ8othUCyvmfLV0kTqVIKgEPdHvM20ibX0yM+tSwbyCZFGcNeegAcbooT12ZIZqrE1qU7AmR5WH9PVZAtNsILmT5VttrHr2e/aSMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iuHKMp+P; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4608da1bea5so1874261cf.1;
        Tue, 15 Oct 2024 16:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729036413; x=1729641213; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=e4KR182LaK05rZG/5JUQrunbZ48vXsg0VDrCT9GJ/AQ=;
        b=iuHKMp+PvCqR3a6c7nI8q3NgAigO+FUkrEB2oZZvoXEv6W2QqD0WwUCwfNdFaOg5Ev
         /dl5RbI2ref5tKVEmLRJjUDEH7t+Q2oCMFD6FxVOeMqgS9HBgEK4RaDvkaBH5ugNS9aN
         REeFQDyoIjFbSFJZ71+GWw5no2lJeRnL/35vY7Vw8FV7cbF6+0AQLQtsEtylKCxFy9xz
         Gogrf3OYkUVMEs7h6T/vmXFMsltQMTfvgdLX3tdDaCzx8cjUWbNLgHM5+bqj3xgPtSOV
         OsOaRU0nPpgQ5RNrqV9IhucY7EBBUM49tYKcnRTFcQ2L6WYj+LUktmP9WVRFP0FPFPuu
         ltqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729036413; x=1729641213;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e4KR182LaK05rZG/5JUQrunbZ48vXsg0VDrCT9GJ/AQ=;
        b=u4cWHqmh+UmZuHDGuxU7TmGEmFWRe2Wq3LYMu16DpExLBXwthybg0vS5vhP4ljb4DE
         Io5chO8xzjhApm+B+vcFMu3wu3zSJBcPwxQdBiq8e9YpQ2Dhp5Q60oC6wrrzNLbuJXc2
         PnCnbR/Y0jWEU83W5HHajMv6Y1/bDQScc+lGLa+o0UUFj+jYpdbxRj+zWiKbw8msknNh
         8zeTVwogTQdngrWTSVPKoIWMeGumJYwZ2l3NGm1kSC5SfDdS52EoxokAEbrVGqK4n2uj
         3qTvbe7pbZYYJIoFE8NRqlpIMrQkpGhKnqo8A16KfR9Wqw4AsNZZ5XUYc0LnJUOSkOxw
         QAFg==
X-Forwarded-Encrypted: i=1; AJvYcCWgP7xXFNEoYF3oQpl5b5NocL+brHOjdgGRK+lkjcV6lhUNZyXqStp4XfK0wswvBwB4DAvAyI1z/gyoB5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwERTcolviAePgx0zuqHJpBO/81SH1/a3gQefdXwwpElY7UyTIP
	O7aitvo8WNK1J4vlYhN+LIT8ImPjl3KCzv/aRRLNR5ClvXX4LuCY
X-Google-Smtp-Source: AGHT+IEA0knKDKnVrKLQDFNoxYVOmX+smrVXeSoFRKHSj5eO2+Nt2cLzdvjZepUPqoY/2rYuoGVPUw==
X-Received: by 2002:ac8:7d4b:0:b0:45b:5e8e:33b0 with SMTP id d75a77b69052e-4608a55d6c1mr30565031cf.48.1729036412838;
        Tue, 15 Oct 2024 16:53:32 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4607b0a5d54sm11724421cf.9.2024.10.15.16.53.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 16:53:32 -0700 (PDT)
Message-ID: <aa8ef3d0-677e-486f-b2b6-e46c04615e59@gmail.com>
Date: Tue, 15 Oct 2024 16:53:30 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: systemport: fix potential memory leak in
 bcm_sysport_xmit()
To: Wang Hai <wanghai38@huawei.com>, florian.fainelli@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 zhangxiaoxu5@huawei.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241014145115.44977-1-wanghai38@huawei.com>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20241014145115.44977-1-wanghai38@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/14/24 07:51, Wang Hai wrote:
> The bcm_sysport_xmit() returns NETDEV_TX_OK without freeing skb
> in case of dma_map_single() fails, add dev_kfree_skb() to fix it.
> 
> Fixes: 80105befdb4b ("net: systemport: add Broadcom SYSTEMPORT Ethernet MAC driver")
> Signed-off-by: Wang Hai <wanghai38@huawei.com>

Acked-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

