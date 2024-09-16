Return-Path: <netdev+bounces-128612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF03C97A90C
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 00:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 800D91C26E77
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 22:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D084E13CFB6;
	Mon, 16 Sep 2024 22:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m5V5CqHP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334BD1B5AA
	for <netdev@vger.kernel.org>; Mon, 16 Sep 2024 22:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726524363; cv=none; b=pF2l41fyo8INd1O5KAMgFw9yRqwgq60kr3GbBL06P6GX42QE8MTPIg85/gz7ToKEz+Ae1Lys8WwGF5h7uOAavldT+1mFOM5K+hvl316fn0MdNq97yUmwgo4uHJz9Lf/asDcT56BYdSDUWgz2lH5GYUT7504DzLXpjSXcXhYYiW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726524363; c=relaxed/simple;
	bh=fBA/fQ2XlTubjQW5iIpzTCY4GKWCCvjZ1WxphHEPe2A=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=sF9bKXOJt/CDEd55gKLRoC71WtwZVVZNHcm+AYusnBc1yfxcQhnIOngttsfDc1C6UonUed6TJ8tLrhbTaVE9PzyUIsHnlA0Ye25Da7U4BskNRDtnBRZ/TOb+gocqv3vIKmFsLMnSc1TmQbqz7ZUq/GWWui5WoOOBIIjjotWafr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m5V5CqHP; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a8d100e9ce0so616048366b.2
        for <netdev@vger.kernel.org>; Mon, 16 Sep 2024 15:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726524360; x=1727129160; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=vc7Khm/tSO0v9JntP88eLarackDB86r4WhVJHEbQM4E=;
        b=m5V5CqHPeD04xU2fT/YI/DHvWv97cz8mc9DlT4m0S9NNy/Uh74l9fbIPpo5uABoMQo
         eRqNnavdaHliqZZstyy4aWzQeF4EM8+F0PWLhvbAXnt4XuR8IR0vkgQ3la/MiSaCLHUP
         P16yVBc3WzgQLFCNOm+gA3BVqdpXqDbRZ59OQhPOmBqx38ZfUYxc9j5a1kper00SaFbZ
         StTHL+g160C83Z4UpXrj/0Xoeyq5TL/LwF7MJ6PAn/3IclZGU4fdN/xhi3s/o4B23AvD
         +QFbpscBPo/ZVeC+Q6DGLVdCDBWt5P2Qyjz9JXRDoyL+mXeRzY6oJnDIZoFnuz+sdQBF
         DJpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726524360; x=1727129160;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vc7Khm/tSO0v9JntP88eLarackDB86r4WhVJHEbQM4E=;
        b=QZJeO/F2fwoW2ucRrMkzl122GNzNgrjj/4aG0HixKR6+3PWglLOo/68bRtk/hGNOoW
         +/znpBZcmrAXy/Lc9QQp73k5ryKYfpyTHkA9o8CwrpVy4W7EpcaY7Kh6R+QV7MrUVSeL
         zqAenTOKQEV/hWm+z8bi/9lJBFAvkUiQVD+S003NqGudWQD9qkCg1pIczPbshq8ADQ71
         ZAsPmfraADmavpgLQ1D5Cs9uuuUx09sLA3h7uHcHKmdXeliRmxEMV0zE7KO4ou9OhTje
         7qeMt86UN0xbWuskQ+T8/r8FhBqnoYaWhfyMVRd20LUl1ocOlZcjjGsnSnaPJTLTro/2
         /DWg==
X-Forwarded-Encrypted: i=1; AJvYcCWNxcbF4PDZ5dq7Yz3rT8zOK+fIPU+8bgnxx/bsYFzDz+jML1Ra41kMmxZhfwH1khfjjn5elkI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2vRH4Pfyt1CftFkgFNrjDN5peh0xrz32zjWGWjSoy3fVT8Fdt
	JNXMVkH2SUx8uPn7m9hu53Lu5VKZbKltPi8CDHbF0h7uzxgLIRZycdrW1yWI
X-Google-Smtp-Source: AGHT+IHVBN7GsBIjUGNNpZh8vWkDg1R5XDsUBxQ088KL8xxAfKRUu1VBo0tq50rl6s9VlwQCf46TlQ==
X-Received: by 2002:a17:907:97c8:b0:a7a:8c55:6b2 with SMTP id a640c23a62f3a-a902946e6b8mr1792161166b.14.1726524360396;
        Mon, 16 Sep 2024 15:06:00 -0700 (PDT)
Received: from [127.0.0.1] ([193.252.226.10])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610962d1sm366377066b.32.2024.09.16.15.05.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2024 15:05:59 -0700 (PDT)
From: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
X-Google-Original-From: Alexandre Ferrieux <alexandre.ferrieux@orange.com>
Message-ID: <e74ac4d7-44df-43f0-8b5d-46ef6697604f@orange.com>
Date: Tue, 17 Sep 2024 00:05:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: RFC: Should net namespaces scale up (>10k) ?
To: Simon Horman <horms@kernel.org>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>,
 Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org
References: <CAKYWH0Ti3=4GeeuVyWKJ9LyTuRnf3Wy9GKg4Jb7tdeaT39qADA@mail.gmail.com>
 <db6ecdc4-8053-42d6-89cc-39c70b199bde@intel.com>
 <20240916140130.GB415778@kernel.org>
Content-Language: fr, en-US
Organization: Orange
In-Reply-To: <20240916140130.GB415778@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/09/2024 16:01, Simon Horman wrote:
> 
>> > Any insight on the (possibly very good) reasons those two apparent
>> > warts stand in the way of netns scaling up ?
>> 
>> I guess that the reason is more pragmatic, net namespaces are decade
>> older than xarray, thus list-based implementation.
> 
> Yes, I would also guess that the reason is not that these limitations were
> part of the design. But just that the implementation scaled sufficiently at
> the time. And that if further scale is required, then the implementation
> can be updated.

Okay, thank you for confirming my fears :}
Now, what shall we do:

 1. Ignore this corner case and carve the "few netns" assumption in stone;

 2. Migrate netns IDs to xarrays (not to mention other leftover uses of IDR).

Note that this funny workload of mine is a typical situation where the "DPDK
beats Linux" myth gets reinforced. I find this pretty disappointing, as it
implies reinventing the whole network stack in userspace. All the more so, as
the other typical case for DPDK is now moot thanks to XDP.

What do you think ?

