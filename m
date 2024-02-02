Return-Path: <netdev+bounces-68721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF8D847AB7
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 21:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA1AF1F231F6
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 20:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD757428C;
	Fri,  2 Feb 2024 20:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CnBf+IED"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4BC6310E
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 20:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706907070; cv=none; b=iHW3Mj6xVCcBhU0xsSxsFIPXjSlYAQkyRgqLKkG3gGAgVJ6fD+Xqtdsb61mFN7l8W4VYZnNiktJwGN70s8emkFcvDYSZhENCrumr7QXVA82lJPHfIOppNSHEXrQ4OfHKRqms+awklj4c2BxiFA47vtjum53rqdyOLUgEUlLI84I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706907070; c=relaxed/simple;
	bh=TC7HRIqXTR+8mPsLyq/3qpPGN7cey0WfYsX0189ZmT0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=oyv0LYbT2TOD5U9ASOARLtJdx7itXZYK4hIECA3SEnV4aGNqtXUaSowBOUhaoCRbeRpsntxrVFqcYAD49dK1+rA+p5Ian0HLsQ7OdJ8nm+57AeYIrXD00aKPOpfJDuaQ2Ki2WGaYZGroli9DZF5y4SpozbqkjWtk8BlceGtJkEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CnBf+IED; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6ddd1fc67d2so1925934b3a.2
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 12:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706907069; x=1707511869; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=QUOLivjsZbHCREIAaoaMDHaNPDVqlHwXUANPzreXoLw=;
        b=CnBf+IEDDfTaz6eZ2u+HPZKErbrrDIMsnB1VsHmxiBahvXhOhJj5p5OS1ZbrS8MmVT
         Irm9xrOOMrsUpDKFY84EFy1Ss6boDMyVAXbvqFofc269vZae8kJ7iYftsu06agINJFBM
         3gDr/eY7bnrD0VGRhix3+jDLHMK1XkGESl040uNxBwpOscr1EGz/sXGBNHNagk0qcSUi
         ZDU5ps83lIcJSGuDzkXqAnup8/acYb/tvKwW0IyW2rkHz1F0RmH/Tad6t6Li66ouasV3
         ZdIsxUHKcYCred0sw1vt0vMVxbNbVzjbXPjwH2OwfkFjyiGtwR3t3DEuzvC6EUv8Lqnm
         /lrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706907069; x=1707511869;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QUOLivjsZbHCREIAaoaMDHaNPDVqlHwXUANPzreXoLw=;
        b=JL05DVRx2wiJNtD3pv4tHGZfR7mkaRClVC00qBai0V2eYQ48bDKsOucQeRUH7QND8W
         ibsJE3MBDntA5J9nBEe1LCvuy6prfJggOq0uOpaW0/IqaeJmO3EWXRuZC3divX3eq0pe
         gCXqR9ebLXoVijwKSk1fNC25511IB1RHvy/LJWoQ/yg0UzDUxpvim1lVyvzkUk+9Im5a
         0uqAP7884x+bYBqd8sZ3I7eV88+lGrJEbMA/HutUg1XX/hxrPIzbhLAoUatiCJ3KFPvl
         CJwwRou3Ya3+/19BVDRxWlw4VV7+8JVnriem16oQpmerCrB+ofd7319P6OPg0TtBQAyx
         blMg==
X-Gm-Message-State: AOJu0YxJnCBDJ5N1SGIALLBhbYCsnYZoa4TNFUCIgmXwC8CXG6AFfi55
	pOoMq2ZHBX2k6B+EIWnGUhQ5BJPFC2RMwG1As65QMuJ8uSoAOXNo
X-Google-Smtp-Source: AGHT+IHbH42rEGR3AsFHuSUm8xbAej356+6T04DdyMIDNjt317AyY0bbzUb0uTCHo0QBFZDdxMhd5w==
X-Received: by 2002:a05:6a00:2309:b0:6dd:84f5:34ae with SMTP id h9-20020a056a00230900b006dd84f534aemr11121990pfh.2.1706907068694;
        Fri, 02 Feb 2024 12:51:08 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXh97U84V6yypDuOmmtHVNttnvl194U8mcv8YejR2MWDtci9c+TnIk53FZBXEqiMiId+ANdJjmpG4M6o2U64s4c2PXZWlVQhN5v4c2Z3BQP/9Z+80u9NOlsnMUuT/aNV9b1kz3bt3sGqZdUFoM=
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t3-20020a62d143000000b006e001635563sm999382pfl.118.2024.02.02.12.51.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 12:51:08 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <39a8176f-7c22-41ac-a027-dac10e349c51@roeck-us.net>
Date: Fri, 2 Feb 2024 12:51:07 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Persistent problem with handshake unit tests
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
 kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org
References: <b22d1b62-a6b1-4dd6-9ccb-827442846f3c@roeck-us.net>
 <20240202112248.7df97993@kernel.org>
 <f76d66dd-5920-4bf1-95f5-dd64f19826d4@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <f76d66dd-5920-4bf1-95f5-dd64f19826d4@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/2/24 12:49, Guenter Roeck wrote:
> On 2/2/24 11:22, Jakub Kicinski wrote:
>> On Fri, 2 Feb 2024 09:21:22 -0800 Guenter Roeck wrote:
>>> when running handshake kunit tests in qemu, I always get the following
>>> failure.
>>
>> Sorry for sidetracking - how do you run kunit to get all the tests?
>> We run:
>>
>>     ./tools/testing/kunit/kunit.py run --alltests
>>
>> but more and more I feel like the --alltests is a cruel joke.
> 
> I have CONFIG_NET_HANDSHAKE_KUNIT_TEST=y enabled in my configuration.
> The tests run during boot, so no additional work is needed. I don't run all
> tests because many take too long to execute in qemu.
> 

Follow-up: If this test isn't supposed to run during boot, please
let me know and I'll drop it.

Thanks,
Guenter


