Return-Path: <netdev+bounces-240678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C48BC779D7
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 07:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id B8C2C2CBF1
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 06:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43E3334C2A;
	Fri, 21 Nov 2025 06:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kg3E31GY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B2E332907
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 06:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763708006; cv=none; b=s4ABGqCPKcOGzX1f8vIi6296zsRpkurTcSrVUVjLfEjB3OvG1/iGwekEAwzs8izMVSFhdRBOhyPauGXYWqXO5f98LGegdThQEdPJ7aIuNHne5+XfWbWlOStNYqUE2uI1PY5ocdlwWasTCxqMbMBYKIOyTGKHvMTJwAeDuc37Ero=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763708006; c=relaxed/simple;
	bh=YoE6DX9QPrZ8nJtKpQk0wObbgEu8hWylBm+gY9w6WKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eMDhgVbhX3G2opGCmJNpnSSiiRNyzoRziIA469K5pdOFQH14X70tzAJohZyRt/0fjYKMCiaPNeuID6i9R8wGKxe4/sFy9DObEHUwoxRjKdT2nxJDmBzaa2vlon9iGYWgw/uUeIqQJQb+86BUGkrbOTtUQUrA5hnDgHhv5TSniKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kg3E31GY; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-477a219dbcaso15916855e9.3
        for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 22:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763708003; x=1764312803; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=34q6eh1LVMr1p8gZ6yDK5bs90rev74r8o+EQAEX0tF0=;
        b=Kg3E31GYQWJ1esr5+xhv4eYxV0Xfa1Xc2Z12+8tUeari0lUC37qXR84K7cKUDUQ7xo
         ivFk5tBkfch9pz0ZD4dBp3XlD6DxD65mbDQ5adj55ckgAz1wk0u2TbUYrOwQPrVlFNX3
         8zfW4hvhsWy6oU6p4aKnPJCKIpsG/B8EsjrBI/YoGIBXCXpjy2f1WmX2H0R8fp8NQndd
         FOq7DMyG8Gk3FMc254Mz9Vl566eYkWWzLh1alu7kOIZVdLR8pdNBeu91Ba3/f0x50gMs
         whsRzASwrv98qQz8m7BRvbhCiF6X7+GHThkhWUArDOEMXC5q9TffDXBPDSOnVXhxUQDh
         atEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763708003; x=1764312803;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=34q6eh1LVMr1p8gZ6yDK5bs90rev74r8o+EQAEX0tF0=;
        b=SdRFgrBBDCIZwkh1FZ1Rew9hmaTJb+qse6jjNTg5MnTjLl+xddrCl82W9kqLRS+X6l
         GXH2H81kdJsXuTAaqfMX4uez6Js9H9YnZSkvuwOABPu01ej0djcYPxpO5nDCL5Lqro5D
         IiLgrC0U2C9A6j5vi3uS+NDOMd9njOh3wFKDlOlUUtDDf6kHRjA6oLlgY4lwVg+ZDq/I
         aRDgAG6aEleKaFJxjx5/iSQHHANiVMwSeoT/x7mTIin/UsfQExYKr5hZX+5DSLmq5iC/
         pzYjX9Cc4sYYvo15MA2ZNNIvorPdZmHyh1w7ygHelhBAKAUhBFEmaXUNGSXQH9tOZ+qG
         kukA==
X-Forwarded-Encrypted: i=1; AJvYcCUM5kSNe+Zx05tfEZrSiHdjcw0sDqg2ralsc3y8p6/FgPdlyLKE/4hUJRZJBRCj2rkf7rJU2Pw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjvCqef10/Tq2W+d/owQcz+xsLWV8z0yWVW1OuOWrt3k6HKxMt
	HH7o1wyPSwEmt0867X5zQQpSBmtFY+g4CtlSQOLc55JBgliwwgE1edOz8b4pRA==
X-Gm-Gg: ASbGncsIfgKou/wxIz0Il/SqrkDZ+n5Uyc9Yx2MvVwRASOY+42P17yJPTvIKxwT0UFF
	MBqWaIGGFCL6gT6aBCrBCdwPDBDnJwdpCxyBwMnzyjxVz4K8feJ5+OeHmJWBzN3rW168kG9zdrS
	ZMs+MHMmnnUPBILBkFlCatwlVUQrccLSBUb6mWL0iJ/YPSkoM668qkIXYccWmSed704B3GjbWCc
	+gHVcU7GdNkKIs6bp4mLelXBw5skCBN5GmtVsvzw0W8YzJso7rgahxCK+PPjtkciZQKjCeOHcCS
	6HmcPBG7zYXXm4OjMQ8A7TWuUERqkQkRvhDHgYkGzDfgq3+CCVRngvxXvKJQzjNKrtDLtD+R3x4
	26MyVy71JsfkvTduiTFiI2ZEcAHE9bkvtEoL+mdxkyYvqb/pAnmDpBO2VvAnfZnaePnA4qjDD/p
	4N7JbODMCvOa8aGSQKHFzDZXvYEWHW9N6E3HQO/5Pb4SxwyixWFI+yIgWLGv4fma8MBehVoanIB
	+SQ/HtGAzJM99Sj+QTRhGGGGdIiV63vn9KpYJ5JLkNfVh3rAjyQeQ==
X-Google-Smtp-Source: AGHT+IF/bCF6j+QcYZhz3/GjrRtGdXGXhke+GG+32dX287Zxkm+fmXd+FgvxVzsloEl3viC1coDIww==
X-Received: by 2002:a05:600c:1c82:b0:477:73cc:82c3 with SMTP id 5b1f17b1804b1-477c01ee405mr10875795e9.26.1763708003257;
        Thu, 20 Nov 2025 22:53:23 -0800 (PST)
Received: from ?IPV6:2003:ea:8f20:6900:9d47:8de1:7320:72f5? (p200300ea8f2069009d478de1732072f5.dip0.t-ipconnect.de. [2003:ea:8f20:6900:9d47:8de1:7320:72f5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf3af0e1sm26049155e9.10.2025.11.20.22.53.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Nov 2025 22:53:22 -0800 (PST)
Message-ID: <8cbd4650-aeed-4d1c-8173-957776dfec51@gmail.com>
Date: Fri, 21 Nov 2025 07:53:21 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Question] Return value of mii_bus->write()
To: Buday Csaba <buday.csaba@prolan.hu>, netdev@vger.kernel.org
References: <aSAHVPsxrM60lRIj@debianbuilder>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <aSAHVPsxrM60lRIj@debianbuilder>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/21/2025 7:31 AM, Buday Csaba wrote:
> I am preparing a patch to eliminate kernel-doc warnings in mdio_device.c
> and mdio_bus.c
> 
> I have ran into an ambiguity: what is mii_bus->write() supposed to
> return on success? Documentation/networking/phy.txt does not give any
> information about it, neither does the kdoc in include/linux/phy.h.
> 
> It is clear that 0 is treated as success, and a negative indicates
> failure. The reference implementation also follows this convention.
> But the code in mdio_bus.c, for example: __mdiobus_modify_changed(),
> seems to also expect positive return values from write().
> 
I think you misread the code. __mdiobus_modify_changed() returns
a positive value in case new and old value differ, but __mdiobus_write()
never returns a positive value.

> Is there any other implementation that allows positive return
> values for success? Should it be mentioned in kernel-doc?
> 
> Thanks,
> Csaba
> 
> 


