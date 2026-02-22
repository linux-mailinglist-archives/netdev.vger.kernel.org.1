Return-Path: <netdev+bounces-259897-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABovLz5Vm2kVyQMAu9opvQ
	(envelope-from <netdev+bounces-259897-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 20:13:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F73170270
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 20:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 898BC300FED3
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 19:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17638350A3D;
	Sun, 22 Feb 2026 19:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eX9geXYS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BC534F498
	for <netdev@vger.kernel.org>; Sun, 22 Feb 2026 19:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771787549; cv=none; b=XcUTAc8ohRoxCmANOF2hBJ1K4/77b3JbSLCJswXYUXj0fGplzPvdQysJUXpSo6yLzwsAQMto2I5Z6oI7MFyKdUey71EsJ4BYG7IZrW5pf7Cmp3ROUF/ttHoVKQlNSYII+6MZ0hf+INFv2eu+dclQ3RzSTI+DzeH2duQf0EJfpn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771787549; c=relaxed/simple;
	bh=WDYU4B2COo5wPNQEOkJnNyqNgaVyCN9liZiMYFO7p8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nAaHWGyKEMcxnVgB8vvb6iOXqGoPzimioRsgKLYqDU5h9wyEaFcBGCbnxWin5mQQzN95DvUFZgxoLAzQaU9Cl9OLwf5ihpK2b1wzRbhWl7mDQ3UI9/sm4ZyjmEX7idZSh0qaR24Cs1YNbNxrzZnbBt/loYaSvJDkjUnEQREuLA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eX9geXYS; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-480706554beso43778105e9.1
        for <netdev@vger.kernel.org>; Sun, 22 Feb 2026 11:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771787546; x=1772392346; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4HC92kY3YmOXxXaiIb4PsPv2+pjORHFu23rMYG4ouvY=;
        b=eX9geXYSIFrmlxTKSXZoDgz5DC/pqpl4yO5oxgeLqPd0jmgnDthQn7T9qen6JOoySM
         sjf6qqc18Fg0No3cJ0jqF11t5dGVYhBgA1DBtZUox+5iPkmsqz7q5hoISFvySbKQwuFt
         sMqDAyqcluy2Dx0o/1NKfxHTl8dXlFzCxVKefb3PJezXWUoKdbtsnP/12K3ml1QN1728
         QtlCwCsswzrmCisbTb6Y9B6BQ2M3l0AA07ex4dJOwc6mGIOKIOrD4bvvOlw6YXpPRMBv
         DQqSi40036viDoGB6a8CV/R+jOxzE/THcObyTzETSW+2y7NDZr4vSTsN4SWLqk/agCyp
         2ypw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771787546; x=1772392346;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4HC92kY3YmOXxXaiIb4PsPv2+pjORHFu23rMYG4ouvY=;
        b=a0VpLw03dqqMGrCuBTDlQdsclX31ueTj/ulfpfn/LuW/EAZeqwXl0Zny9p7ojoNTwg
         FaPU2oPv2jvisQQQP7w4UzJEmdNDzagcNTP1EooGAqGqukfw9x9ovFyvC1EJOGcKWJOf
         B+C38JDRmo0Mhm7xF7QkeAb+Av1SkqgmQzY00CllJ/NwHG9fjEFCvbDyCEkUBk1Y0ZYW
         KWuBMO9driv+Bgl7eWvHHDLHrtRCxD3WWn/E2qowXQk0i8PkSE/rEo6fnC/D29QWB06d
         X0RJJIuWOW9OG7lY5bwWtLdSmzAmnGRmbszUOE1S1xTUf3KOtWZsidQYfhp9bAOrOQ8W
         h+DQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGM404ccoQCyX5qHdgNxfc4cmtQnjp3QvlQinb9mHmkrIu3eg3Fj2eKVaJFU4mhuAHpFaYJ/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGF6wqIBgLpuMxJ4q9r9UUlmIqrHt1nSxwLU9bW72KTc83RzKn
	puPKN3I/T1kxG00x2t9RoqA9ByyiPNuXQ4LWbgZXG5S+/6r4dnxFjIug
X-Gm-Gg: AZuq6aKEVwqpk4N7GBFsa+xjTppr2REYnp0+0aUbIqM+zNFiWmIs077QvgERzeW9RH7
	tgZ0koPFmocbbvcoulAtn2Mk5IZBpkuwYMyciRQCMYXY8FQWi65c5jxMGUiNaGzH7qHrGTf11F3
	a++t9GKaa1wC8vUe7FuEVRL64K2wsxgT3VcMSDY26xNwgKwHa2F7FXdKiiVONRuF7JIBOr/M1b/
	0oW+BH4/IfJjb9x8Y60jbsGPrhl3i+b2l3KWNE/AkZX8HwgTzt8lZ8LJj7tnYrNCRw8mUd3Ud80
	C7ey275Pu2hxhB/ngh9R3bwDZ6vSd/CgtvA/lwag9eFfwizYYWEahuzglM7LSq4odghjutWFfu5
	qdQXKsw0mEQZl9WLW/J7n0yzR8AfSLgciap2aJJKUDLK7KUY4cl+8/aDmCMvcG/ywJp1mWx2VmN
	RRK56Z8Q7DFZ33iA7TKNX66mkJ8yBj/ospyX2wouqQH4vAw/0u7K8/ZarIXDHL8fDmKl71mN8+8
	efV
X-Received: by 2002:a05:600c:828c:b0:47e:e48b:506d with SMTP id 5b1f17b1804b1-483a962e003mr122153875e9.16.1771787546078;
        Sun, 22 Feb 2026 11:12:26 -0800 (PST)
Received: from [10.0.0.98] (snat-2.cgn.sat-an.net. [176.222.226.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970c00768sm14086405f8f.10.2026.02.22.11.12.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Feb 2026 11:12:25 -0800 (PST)
Message-ID: <79e33665-ff41-412d-ab17-154f6687233d@gmail.com>
Date: Sun, 22 Feb 2026 20:12:24 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1] net: phy: motorcomm: yt8821: disable MDIO
 broadcast address 0
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Daniel Golle <daniel@makrotopia.org>, Qingfang Deng <dqfext@gmail.com>,
 SkyLake Huang <SkyLake.Huang@mediatek.com>, Frank
 <Frank.Sae@motor-comm.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Sai Krishna <saikrishnag@marvell.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <d3bb9c36-5a0e-4339-901d-2dd21bdba395@gmail.com>
 <0308e736-c3e7-45d2-86f7-e729af9cb487@gmail.com>
 <3e64d8d1-87c1-45e0-9556-0ca844a90f73@lunn.ch>
 <740e8351-d8a5-4f4c-91e4-c278e4b7d248@gmail.com>
 <aZq-SbHC0eU9OenG@shell.armlinux.org.uk>
 <6d248bec-cb87-4238-9ccc-e901926e3226@gmail.com>
 <557033a0-e5c8-4384-8f40-21f37c2e7dc1@lunn.ch>
Content-Language: en-US
From: =?UTF-8?Q?Jakub_Van=C4=9Bk?= <linuxtardis@gmail.com>
In-Reply-To: <557033a0-e5c8-4384-8f40-21f37c2e7dc1@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[armlinux.org.uk,makrotopia.org,gmail.com,mediatek.com,motor-comm.com,davemloft.net,google.com,kernel.org,redhat.com,marvell.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-259897-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linuxtardis@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 20F73170270
X-Rspamd-Action: no action

On 2/22/26 16:15, Andrew Lunn wrote:
> On Sun, Feb 22, 2026 at 10:52:28AM +0100, Jakub Vaněk wrote:
>> On 2/22/26 09:28, Russell King (Oracle) wrote:
>>> On Sun, Feb 22, 2026 at 05:22:55AM +0100, Jakub Vaněk wrote:
>>>> I had hoped this would not happen on the Cudy router. The MediaTek
>>>> Ethernet subsystem driver uses of_mdiobus_register(), so PHY address 0
>>>> should not be probed unless it is explicitly described in the device
>>>> tree. That said, I agree that with mdiobus_register() this would still
>>>> be an issue.
>>>>
>>>> I was also hoping that moving the internal PHY would provide more
>>>> flexibility in the device tree description of the YT8821. If the
>>>> workaround were implemented in U-Boot by writing YT8821 MDIO registers
>>>> at boot time, Linux would not be able to assert the YT8821 reset pin
>>>> without losing that workaround.
>>>
>>> Why would you want to assert the reset pin?
>>>
>>
>> I don't currently have a solid reason to assert the reset pin.
>> The two reasons I had in mind were mostly precautionary:
> 
> Being able to drive a PHY reset pin in Linux is relatively new. It was
> added in 2016. Before that, we lived without this feature. If
> anything, being able to reset the PHY causes more issues than it
> solves.
> 
> So unless the PHY is actually broken and needs a reset to make it
> work, it is probably better not to list the reset.

Thank you, that is encouraging. Handling the YT8821 PHY reset
and configuration in U-Boot should then indeed be sufficient.

Best regards,
Jakub


