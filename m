Return-Path: <netdev+bounces-90667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED168AF758
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 21:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE2121F2308D
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 19:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3201419AA;
	Tue, 23 Apr 2024 19:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="b9aEDmEy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A0513E418
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 19:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713900594; cv=none; b=jkh29YzrwOSI/w55uEmSKDJ61ITCn0+w0Bjth4euwYiFFJR6LxEILHr8Qjz8bdlpd49x/e/RSeZzcszqTnxZDM7UAfzHAioY4eGv0tX0eA5ZbPJSkeQIS0mnFkhTGNUwhxOvOyNTvsKAq3XM/GJF6FCtMHIBZN9Tg+HUbqdtLvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713900594; c=relaxed/simple;
	bh=UkjqzAEY+xUmI8ibNgSjLH18pwa4XJKVzG1+CmZUhos=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TKwGgR4b0jB5X4ncvgSRwmKbszeDr13N56ILGH0kpNBsaMuCLPADd1TeGKZKAz7CF9oPu7fAMKZm29PiHjQA+BDWR4lk3+x3/91QL8IDuRfbhr5d/xYIj6maWRKYBnh9VOjY3GoCtV7Fzz+Ed3C3sfTzlkWCITgfmnokNyTW+8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=b9aEDmEy; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-617e42a3f94so67098757b3.2
        for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 12:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713900591; x=1714505391; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AdYVTxq72Ghh0+nryy4S2GXt7RvzUpURnWrK7wREYZs=;
        b=b9aEDmEydrz/Bv03fn7/cKnQLMyRN/pQFTWvDLlT1gSB3AVTusdbLEpCFBDBo3ZS8n
         NRXqByTtRgzd5VF4xnV7N8F9W+lhElsY4jZ0O+a6hdbiTfAbbBqz51L9FTPkjQcl9gu3
         Su+5BrGG/VfFy6tRtD6l1sPOaLyHtUINrALTO2/gBpK2VlO5GprZngQg275sdfmIEOWF
         Xz0b6GJGvEHHpHtAGrP2hlNS6+P0BYRWDNlRD7i8v0Cqlw6Odxzze9BN5y/JrsNUcE0C
         IOv3hao7mugMds09LAKi5E0S2NmSD+gF+NrSkeBHighWGN8cZFJZUHWiUbd1CBcBcKnD
         4d6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713900591; x=1714505391;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AdYVTxq72Ghh0+nryy4S2GXt7RvzUpURnWrK7wREYZs=;
        b=TTPm99deKzywB7qD4ontoSFfz4i9nxbmxPG0HKCVdbIVLVF9Iz7vKgbmh+et2papBJ
         vQReEB8VFloBj+fsZ2JZP9ZXCHWHwZ4uGK1RYbFdRaA9AWKIkJA6b2L3zyTO3yqt4WUp
         AMCfkPbvSJnOm285K7m5fGefkcm0YxStWDFBL7ax+Gw/hO78JuFV4SgXAMn0pfNgTZUR
         qU7yViHRJ+nmlYsStXq2r9CA2soJeTlnaedFShLmU1JE68XypmyvCvENw6gUGTgTD1QA
         D5pKXGrSlhzPR6Km5YubFi935MqqP79/z8jILkv4lkw3vO+sN/9lNv0wSweVKFkIVGEP
         kovw==
X-Gm-Message-State: AOJu0Yyim91mn/TMdfHihzTH8IZk9TjMqylufZeT/ljCJj6L1i6sHgQ0
	luBDyXJnWyASN9cgxJBBFIbG1o4IavYTDeYx3qTFg30EU/9FPDfNRUKtNAzYkpE=
X-Google-Smtp-Source: AGHT+IEnnvuwBABQJt3unA0O+RDYv60NQgWnLneWCgqrxcnIEsIM6phki1YZACvHdPbW1qeS25vuLw==
X-Received: by 2002:a05:690c:a98:b0:615:2d5a:e398 with SMTP id ci24-20020a05690c0a9800b006152d5ae398mr542644ywb.21.1713900591171;
        Tue, 23 Apr 2024 12:29:51 -0700 (PDT)
Received: from [10.73.215.90] ([72.29.204.230])
        by smtp.gmail.com with ESMTPSA id i84-20020a0ddf57000000b00617cd7bd3a9sm2558766ywe.109.2024.04.23.12.29.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 12:29:50 -0700 (PDT)
Message-ID: <795d794c-35b8-4ae7-9a97-296523c5bf3a@bytedance.com>
Date: Tue, 23 Apr 2024 12:29:48 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH net-next v2 0/3] net: A lightweight
 zero-copy notification
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, edumazet@google.com,
 willemdebruijn.kernel@gmail.com, davem@davemloft.net,
 cong.wang@bytedance.com, xiaochun.lu@bytedance.com
References: <20240419214819.671536-1-zijianzhang@bytedance.com>
 <20240419204754.3f3b7347@kernel.org>
Content-Language: en-US
From: Zijian Zhang <zijianzhang@bytedance.com>
In-Reply-To: <20240419204754.3f3b7347@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks, will update in the next version.

On 4/19/24 8:47 PM, Jakub Kicinski wrote:
> On Fri, 19 Apr 2024 21:48:16 +0000 zijianzhang@bytedance.com wrote:
>> Original title is "net: socket sendmsg MSG_ZEROCOPY_UARG"
>> https://lore.kernel.org/all/
>> 20240409205300.1346681-2-zijianzhang@bytedance.com/
> 
> AFAICT sparse reports this new warning:
> 
> net/core/sock.c:2864:26: warning: incorrect type in assignment (different address spaces)
> net/core/sock.c:2864:26:    expected void [noderef] __user *usr_addr
> net/core/sock.c:2864:26:    got void *

