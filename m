Return-Path: <netdev+bounces-66206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B8B83DFD4
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 18:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D34C1F23737
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 17:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36DA21EB41;
	Fri, 26 Jan 2024 17:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cequ4ljg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00022031C
	for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 17:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706289461; cv=none; b=mjP+1uVW750a8tpfcKDG7NGX4ZxY5qq+x5/n4TueL7Hz1tdxA6GxozxSIZTiReMfR3WPJeEpDOUipGaccTOuJg7QlFNYguR58obdD9Vd4yOY7a7vYK2GQoiCk3EBm4JVTm5SdGgmpvpe8LJXyb84FVEbooY4OTc0UFo/Hlw+ejA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706289461; c=relaxed/simple;
	bh=Uy4Tppe413jOQGBceN0KQ2oIFgmubM6tH7atW1oQXJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TF+gfhH08/DSmExTGnSjMOGCiNJ6blba6a3ub8VsP9hB1iW1zhPt9MbxseC3dj8gU4VejNPPtj0qAwSB/zxfBMOVFoWj1/7QpiHFrFzOZf7xz6rQ1G78SVb2N2bKSoHXfsLxNdyp7Cj6wkGKisM5ceqNtzKtvOFoYGOUG1mMBak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cequ4ljg; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7bfcc7d196aso16926639f.3
        for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 09:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706289459; x=1706894259; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Uy4Tppe413jOQGBceN0KQ2oIFgmubM6tH7atW1oQXJ8=;
        b=cequ4ljgs90oLCdC1CjLsiqunrisdl2NagsU0yGEfg7AXA8nvumQyNTv3ZVjdncgUA
         /X2oEdnfT9T6OkmEEQ8CDPaBUqOsiqJoFLaLkzJ+LNVXBNyw//Ls6ESkUAvYtCqrRvHa
         QEPIJIBiKi39zA5zDA3q+/IrDtKnK6qtSiMeY4u69q1VFyHQjrJoUlKQ0jooEAc+8G+3
         wK8UUbyQZ2nYm2zCxPrkNrhZaEF+NNK7Ah5IZQI1qqYzq99Ni8vmXR/6BuwEeYTIZOti
         yeN95pBJiIrdCA/kgU9EbmZrSYieF3t/M8oNAoulvs7CLORX+92+NjKlQotL4kUnXVwq
         0vrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706289459; x=1706894259;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uy4Tppe413jOQGBceN0KQ2oIFgmubM6tH7atW1oQXJ8=;
        b=aU7/usLTxpvwWXWOSiLBIj8FtqTJ13IiLTqC0guCSglotRY5L7sf/YWA3OY3HwWZkt
         nTu2L9orH97TjZOwqM+bY2026hr/pWPwP4bomAW0DRzRjVGcHF/ZufNOjOxWjnDXWatO
         obQuwiZw/yNDvL2j1hzgH0WyBOPM6/jpYX4+JafurBoeQpb8I0W/m4tr6Zg25BvvpxR8
         ynp/0hUdaV6h1PEhO3G8pWo6Oz0TuA0RLOqm79ddpFXFmXXbINtvREJXKBotTxg1xI8I
         YyKeVud4n8QoSkrSnbhWpZZfXGwtCYtvxjCFJqR+ffTcweKA8gyB+I8wuPtbwrraRnTQ
         0ONg==
X-Gm-Message-State: AOJu0YwBH+rZ6fxE+O+vD7l+JjIVbRXua/3ikirztko7HODvfzpL/KsM
	Ib6z04ftbKHt1aV9FnyCAVnhlF9yE6YrQU6tyMY7ItWhn8d0FCSd0ULA2J9E
X-Google-Smtp-Source: AGHT+IGUjMoWkciTscVyQSfzEIwOoz9zdl/i2gnz/lq7QPE6qaI2QNq8S91kHNVvN/aZWBgdYHkEdQ==
X-Received: by 2002:a05:6e02:1251:b0:361:a7ff:f569 with SMTP id j17-20020a056e02125100b00361a7fff569mr72243ilq.7.1706289458751;
        Fri, 26 Jan 2024 09:17:38 -0800 (PST)
Received: from ?IPV6:2601:282:1e82:2350:ddd8:edb3:1925:c8bf? ([2601:282:1e82:2350:ddd8:edb3:1925:c8bf])
        by smtp.googlemail.com with ESMTPSA id bf6-20020a056e02308600b00362b4d251a5sm186557ilb.25.2024.01.26.09.17.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 09:17:38 -0800 (PST)
Message-ID: <fa8e2b04-5ddf-4121-be34-c57690f06c63@gmail.com>
Date: Fri, 26 Jan 2024 10:17:36 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2] vxlan: add support for flowlab inherit
Content-Language: en-US
To: Vincent Bernat <vincent@bernat.ch>, Ido Schimmel <idosch@idosch.org>,
 Alce Lafranque <alce@lafranque.net>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org
References: <20240120124418.26117-1-alce@lafranque.net>
 <Za5eizfgzl5mwt50@shredder> <f24380fc-a346-4c81-ae78-e0828d40836e@gmail.com>
 <1793b6c1-9dba-4794-ae0d-5eda4f6db663@bernat.ch>
 <1fb36101-5a3c-4c81-8271-4002768fa0bd@gmail.com>
 <41582fa0-1330-42c5-b4eb-44f70713e77e@bernat.ch>
 <1e2ff78d-d130-46d4-b7ad-31a0f6796e1a@gmail.com>
 <e60e2cc1-02c0-452b-8bb1-b2fb741e7b43@bernat.ch>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <e60e2cc1-02c0-452b-8bb1-b2fb741e7b43@bernat.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/25/24 11:28 PM, Vincent Bernat wrote:
> Honestly, I have a hard time finding a real downside. The day we need to
> specify both a value and a policy, it will still be time to introduce a
> new keyword. For now, it seems better to be consistent with the other
> protocols and with the other keywords (ttl, for example) using the same
> approach.

ok. let's move forward without the new keyword with the understanding it
is not perfect, but at least consistent across commands should a problem
arise. Consistency allows simpler workarounds.

