Return-Path: <netdev+bounces-243205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 245A6C9B806
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 13:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 97DF24E04D0
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 12:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A07031328E;
	Tue,  2 Dec 2025 12:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AjBQackm";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KF/VO+1d"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF41313270
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 12:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764679108; cv=none; b=FpCyLc+NA/uG9UGfEMzA6EDtYThkmiv6daUotmWZbiqAKv4C3XQHd28T/lgokUaT5PrGdCrBlPrh7Un4C0gnJjRg9JIog9SDKXoIDaMcKIWWWJswW5tezmf9d/sS7UEM1T3HBZJcfn0MVmv8RJt9XtcUmnQ6M61HHT+NVhIStZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764679108; c=relaxed/simple;
	bh=uV2yKzrBnqbLp8nyRPDUN46vL0tWE3xD6CqzQmunFNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Z21dhVwLIch4W3Z7Y8xS1qyD938SvRnyOR3SU49lUSGlP3e7U+O80Pia+mGJXO01K2leq3yMKA8lj6uneqMG5XK1Q2MSJIvUBLIbjli5anBIFHnD1CoRO09cUtusIXrEqMCjyu8Z6Im8xG4BJIq4/biO2r596ie+lDQg+7y7IFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AjBQackm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KF/VO+1d; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764679105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PV3JdNWJLnF3OTTD+K5SeEhcg1ng/+g4E+BqW+0ykII=;
	b=AjBQackmVOOW0H3EoOdtHjn83MTPsgvvLF6Ow4UoQSz2yKxbPcPHTxCYyBSqzT1ZNHZtUQ
	60lGmBCWZVS7JofOma+pMIAwXwLArOEuYZQ1eIkT7EJdBbJl7fpU8tmqWv3eGys4ltIeKp
	UVD336ezEIgQdRabOji0BcjL4kfjkAE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-wLAcSRHLMYqfqmQZRM-h0A-1; Tue, 02 Dec 2025 07:38:24 -0500
X-MC-Unique: wLAcSRHLMYqfqmQZRM-h0A-1
X-Mimecast-MFC-AGG-ID: wLAcSRHLMYqfqmQZRM-h0A_1764679103
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-477b8a667bcso60882315e9.2
        for <netdev@vger.kernel.org>; Tue, 02 Dec 2025 04:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764679103; x=1765283903; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PV3JdNWJLnF3OTTD+K5SeEhcg1ng/+g4E+BqW+0ykII=;
        b=KF/VO+1dWxhe2UX8a9sXNqXBNgtn70i2/rLjd5IpSDzHuPjf7iqU6A7HFvvYR362vE
         yBmQjqN5UjhlgJ2uiDPmEZpdNY+njrEk6BR87a2qFhttAF+8j8gurcLyPQH2aTTBTNhm
         P+S8h/x1/osPia9hdmEVz+Ht6oR4+9Jg/Vly+3sj2dEUoafYCqGCVOkwIYg7nRgcgTYN
         JpwTqUQ0Kc9Dct5x3jvs0HjCat00tffhbrqS8n61jeveL6kBxm5fzrsleavbA4fd7Q29
         M4uXkRsYezRk2K/Inh3mnWdb1VnMI6b5AHvwumpWPeb14bPm6ULXexe+klylMUR2KmSG
         qvTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764679103; x=1765283903;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PV3JdNWJLnF3OTTD+K5SeEhcg1ng/+g4E+BqW+0ykII=;
        b=wN1Tf5G6NYaLnTyZWV9fpTspUtawDrmTYL0M0lM5S5mx3XNOCtkQeh9IrSMOxoTRGg
         edjH4tq8FAAwkTUrV1zaCKWty7oUwWV/qNvKzxrIZdDs4eI13aKoTGDPXF/9GSSEIR94
         VG5a/vLIOaj8eQI2mUHPnTUqC08e/NtHoOGW4m/ECaDLYHs3sKLImMX5PfqtZIqgB87A
         k71QM917xucJ5FBn4Y5E3TOxR8V2PS0ParjtXvy+2TZpV6cLhwgyyyF1qBq3zmjhMQWj
         MCh++XezBw2SeQ2iAfSwY8tplRJ9fGp6Tc0iVrr9JcfrXnQXmxJGNOum6DfizJz441Ww
         jeHw==
X-Forwarded-Encrypted: i=1; AJvYcCX7Gz7KB5QlG7GEABXU2sNVqM0c/ArGUyJydexnMaGzszENloUU2bxlXcq3INqTpgY61HfPc+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOjZvz1m2mPnkppMhR5HTYEtfYBu/kF/z8bWMRoQ2sE0zSjtEv
	EPt5pHATWaiiENQg3/he7RcIqTcNtAHKhRntDkDKmzfcopdlY0jbSh69W4jRXrA95Urrv6Oz8sY
	okHiXe6282pB6EQqrM0LpJRMMN1Q1Y53CXvbpzzGkKlPd7teYurzpE5lfTg==
X-Gm-Gg: ASbGnct3DQICPy2d9p6pnx3fFHK2pGDcgUzCy0u2ct0ZjHkf2gv4fPXyxk9CrZBO7rO
	nU3JaTJWhAyG+MLt5cHhgUzgf2A8Adi0QyWtb6u0NV7aQOJHvZzj/EgUXgLYUS4efgIwPjni2Gd
	CzB6jXAb13OqYD70J5o9HHjJoZge8OYwam8Sk0g0XaP+hG1u/3+iJ94DTlynCq3ZbJ/lIhfa1mz
	3aEgfZWJoTmWVAdRQut6O4miox6cKJpkqG9TvxCYNssO8FnRch4GPE0g36ko/mXFX2yef/FOyn0
	yN7AQvDMV0Kak+awqtBONU1YtePMQj9/lLyh5iNlMwgvjHypfDemRX50s9YGsTdwVLRpW51wxnL
	nkX6Ecvijtxuc6A==
X-Received: by 2002:a05:600c:5252:b0:477:89d5:fdac with SMTP id 5b1f17b1804b1-47904b26093mr348084845e9.31.1764679103394;
        Tue, 02 Dec 2025 04:38:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFhY65J2KcZC7O5uPXBux2WRLGgbkP2OaDQQoHDloa+Y0pfFZ8qz7Pom+8kc+ipJeiPz/8PxA==
X-Received: by 2002:a05:600c:5252:b0:477:89d5:fdac with SMTP id 5b1f17b1804b1-47904b26093mr348084515e9.31.1764679102987;
        Tue, 02 Dec 2025 04:38:22 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.136])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-479279baac2sm14218335e9.4.2025.12.02.04.38.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 04:38:22 -0800 (PST)
Message-ID: <37ecfff6-19da-4b0d-9623-129431d5a218@redhat.com>
Date: Tue, 2 Dec 2025 13:38:21 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/1] net: mdio: reset PHY before attempting to
 access ID register
To: Buday Csaba <buday.csaba@prolan.hu>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <5701a9faafd1769b650b79c2d0c72cc10b5bdbc8.1764337894.git.buday.csaba@prolan.hu>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <5701a9faafd1769b650b79c2d0c72cc10b5bdbc8.1764337894.git.buday.csaba@prolan.hu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/28/25 2:53 PM, Buday Csaba wrote:
> When the ID of an Ethernet PHY is not provided by the 'compatible'
> string in the device tree, its actual ID is read via the MDIO bus.
> For some PHYs this could be unsafe, since a hard reset may be
> necessary to safely access the MDIO registers.
> 
> Add a fallback mechanism for such devices: when reading the ID
> fails, the reset will be asserted, and the ID read is retried.
> 
> This allows such devices to be used with an autodetected ID.
> 
> The fallback mechanism is activated in the error handling path, and
> the return code of fwnode_mdiobus_register_phy() is unaltered, except
> when the reset fails with -EPROBE_DEFER, which is propagated to the
> caller.
> 
> Signed-off-by: Buday Csaba <buday.csaba@prolan.hu>

IMHO this deserves an explicit ack from phy maintainers. Unless such ack
is going to land on the ML very soon, I suggest to defer this patch to
the next cycle, as Jakub is wrapping the net-next PR.

Thanks,

Paolo


