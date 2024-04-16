Return-Path: <netdev+bounces-88281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6DF8A693D
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 12:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 130BE1F21FAC
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 10:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3147128814;
	Tue, 16 Apr 2024 10:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKBkthMV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC4012837E
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 10:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713265168; cv=none; b=F4HfZQ+D7h6hVBIljlrQkW41FJVaQbeqjUuIu024Ii0A+76nJzBn8w9hhAg7V8PFtt3z8QsiDKmXhfE2wwMmwy5pNwVuoMzQoCYfvYKwG4DxS8uxe/E/pvNkuYR5hjL0rDy6xNCmDTfv+d7JLk173rtbXkFDUT1cYzZQEp/2BYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713265168; c=relaxed/simple;
	bh=3LsWGxkwVx0t5bTDQO9rXkPIQRdhikJCc0vMmTFx9x0=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=XCGC7eQLq2e4sTyyQSkYu6CVpwVrlWAa6yh78YVsPIxhW7GdGApDSjjcNNggy0ix3IyVC5Q2f5Q+SYIqLxRsmctmev5pAQYP0QS6HPCiU5mKnHFiiH0jDiCq2jn5bpD1FVlMgi1mikl8iOeQ4y9+eQfarcNluL2CdyzXaDcR8h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OKBkthMV; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6ee0654573aso526805b3a.1
        for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 03:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713265167; x=1713869967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3LsWGxkwVx0t5bTDQO9rXkPIQRdhikJCc0vMmTFx9x0=;
        b=OKBkthMVkcEyUxIv/qNWZ95mlpXtbPD0Rb6/0eup9n8aychpbAE/WZyCilNlHemX4c
         8G6IZm6s6w3QQ8JJw3T3iX77pGxshQYeGC1azqw9rlVRraAZdGDGyApXZaFj1FEUXEPS
         fZwMyZWdbF2al0vAgKacs9XrAN2SG8XW8l20h+X/zW2bHvbSrSAfHDjFkd8j0c+ccMCl
         AEEIp8WndtlRTpnq17ncGgsHdMrU4SM5jkYHki8I3nDWjrVqBR7XfW0Y/sS8uvtPYGem
         XTXUL26Cw62LLyywJAnqeJ58sJtDc17Tod53eiksbGcNiAKs/ybOS9KnMKhc05EV4wy5
         OVtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713265167; x=1713869967;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3LsWGxkwVx0t5bTDQO9rXkPIQRdhikJCc0vMmTFx9x0=;
        b=YB2PR5k6lhPrB4kYUmxHYawlwwCuxryQ61DOHLtz6fdttgXZmGdkv4DVao/1LCYz6O
         g4nbrTuB2godWTUx/zD8AK6PW4QRmghEXxjmlhE2fXEZ72JFFNiZlqQ1OKLUaqgDzbI+
         1tRR/tQZk3iTup4rd0theky7FQ7KmEG14FCL3Z7e7ATuEeYAIVPkEfC2I/7LCqjfQSc0
         56hXe9AKyNq+Sd0sbImq5tYsMDgt5RFCYRdcBXOAjUUw/50xZsL5OmpcuuI5GV6Ohako
         WBdQZF/Gn8ke0yXcnWMqzlEEzZbW6sRg5959dcSwpP8x+sEhsOb88kc0uj1U2i5eOy8x
         O0Bg==
X-Forwarded-Encrypted: i=1; AJvYcCXJBtgYB8MWp3uC93wW7cJNhGErPfcnsKc/paqyBvf2IJnQwYQASDipwCY/lBACfRXCpXHMIInI1Mm5KnCPue5DCPbGOhGf
X-Gm-Message-State: AOJu0YzLZJ9CncDopzzAfj6JDrmoDezzx8+TeuRqQEqRZpXQs12ODLkd
	0yU7pzC40qd1LoDMb989Gz3dUBjbBq7y9gRZE58PwVqC0xS2VNI57MpfUAhy
X-Google-Smtp-Source: AGHT+IHL5mgPk45yD/+syPuTUuHsWfAisNyV17kvs6sjvfjjlQUZPeM4vBCstU2OATL60z7kRY112Q==
X-Received: by 2002:a05:6a00:4a05:b0:6ec:ceb5:e5de with SMTP id do5-20020a056a004a0500b006ecceb5e5demr13024372pfb.0.1713265166909;
        Tue, 16 Apr 2024 03:59:26 -0700 (PDT)
Received: from localhost (p5315239-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.87.239])
        by smtp.gmail.com with ESMTPSA id 125-20020a630283000000b005e485fbd455sm8525837pgc.45.2024.04.16.03.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 03:59:26 -0700 (PDT)
Date: Tue, 16 Apr 2024 19:59:12 +0900 (JST)
Message-Id: <20240416.195912.615260830449617081.fujita.tomonori@gmail.com>
To: f.fainelli@gmail.com
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org, andrew@lunn.ch
Subject: Re: [PATCH net-next v1 0/5] add ethernet driver for Tehuti
 Networks TN40xx chips
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <e9506345-8245-4b3c-83a1-9425e0b37136@gmail.com>
References: <20240415104352.4685-1-fujita.tomonori@gmail.com>
	<e9506345-8245-4b3c-83a1-9425e0b37136@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

On Mon, 15 Apr 2024 16:21:35 -0700
Florian Fainelli <f.fainelli@gmail.com> wrote:

> Thanks a lot for attempting to upstream support for the TN40xx chips,
> those are extremely popular 10GbE PCIe cards under USD 100. Last I
> checked the vendor driver, it was not entirely clear however whether
> it would be possible to get the various PHY firmwares included in
> linux-firmware, that is the licensing was not very specific either way
> (redistribution allowed or not).

The code of the original driver has MODULE_LICENSE("GPL"). The
firmware of QT2025 PHY is embedded in a header file in the source code
in the binary format. So I assume that it's also under GPL.

Unlike QT2025 firmware file, firmware files for Marvell PHYs aren't
included in the original driver code. The README says you need to get
Marvell firmware files and compile the code with them. So I guess that
they can't be redistributed.

