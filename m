Return-Path: <netdev+bounces-196351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A90F6AD4591
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 00:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96D7B189E31C
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 22:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD09288C89;
	Tue, 10 Jun 2025 22:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Y/HS4efw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834B0288C29
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 22:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749593038; cv=none; b=I4ursx0ZQsDXcc4hVaN+ZiZ6O72TjvWdKfgLt1yxavECnbAoQcVJlejGJzWOwPE7Y29EufktwDkeYJSQRgbBgvupEmo0+JTjPby7IIBaBgaMh9A61lRzeT01ygfWOmc3ny8XwAYjkPaB4/FUCBU2x1UN1ThMCnJiOMPXHIkJHGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749593038; c=relaxed/simple;
	bh=AQuSBUl4POx87aC0pz2dJ7RudtiNWawkc/IXHTTTSDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fVu7ew3x9zzUkEPTNxhEPEzOm18BT/jlvQJ38Qlhvk5o2Vur3WdCpFLqSVaA0CvgXWvr10f1HgR7B2IFaO9zaFjlZ7ODbfv87Npe0KQq7P/6CSZlnF13/9BUylvP7zXnhGnis5pv99SMv4YJq/pKg6NnbZl5ChKitn4ZJNiFOUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Y/HS4efw; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-747fba9f962so292469b3a.0
        for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 15:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1749593037; x=1750197837; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2HKAV4+QmX8qJ/5iVivDCfl+K8vVhwbVWIjZHILmwUw=;
        b=Y/HS4efwsydpSzsBiCpBA2XRLSTV9mK2bmDXxdkFjk2NZB61wWPNGdcM6NCpzm3WQ/
         +GhelhmUGq7+jN40iM8ReXhhhBCHP9hKMKhem6KM+07zJJCK0MVk1bEkm5mUCs/536HV
         /8n9oRhXPiToLvMPFEhnxHXmdLAgpDb+OV6G4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749593037; x=1750197837;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2HKAV4+QmX8qJ/5iVivDCfl+K8vVhwbVWIjZHILmwUw=;
        b=TFQyPsIywurz9kO3BtsKerS9eUUvs0SkdhQKM4UoAHXPzwbX1J1zQ8waezytAT8M1W
         eeyst+H83E/7idRmUI4dKhtf7fG+8HnByqf0FxE8qbEtlleoCdDOMw/XlZmbh/5hGhFB
         U7c5lA+Mv0OpoIz8pwa9YEMHoCblRFIWVsSHrM5R4ZQFIKNh9U/mrRpxcgHhj0XvwVxp
         9lQURq0Z/6vUG3jvO+jnDkFKTEi87ElhyiQd+ETXaXJKp4jk/2Afp5SPGV9RY7fVlmxq
         g4rwmKD4F9KXnp7NbcNaNxJwTB/aHBDo+OFtmYFOPvrxQK+Qq5C/QwL75LRlYG97vMpY
         l8TQ==
X-Forwarded-Encrypted: i=1; AJvYcCVX6zsKlQIsGTZfGQYIYZa9IQXK3gplTDbqLLZA0nEK57zwnQvpMNUZQ6hqKPvhFCF41eNbifk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKEfzJKcdQ3KE4iJEAQpqhkbtst/EZMaNP70ymkJfhk/M2x40e
	Qd5bqO8ovQjw8oKNnToNmkPwpxMcjb3QmFpnwxqqpvCYvnH6VKVVFLubHUHxxW3WoQ==
X-Gm-Gg: ASbGnctKEXlDdYiTP+cYvi2jAkVVZm2ciUxFcMGyC1JREb95j7Q9aEwn+HNlShMHiTo
	9P4m2Whl+kr3nurEIkMcQx7aDegE9jqhvoRoJ1jLFhtYrvQxuhG86Rw26iAXlJ+e8TohxOzyZqw
	aLDCtdYXkP2H3VNmYW2+UfF1gEZ78kMPFgmMO1tjVTmAGw6A1kibU5gfQ3Nbn2dEul6ZCXmWXxj
	4S/9Ssy5MdD8B/ygWcS4pio/PskUju2DPh0nUp6qBW4qDqQhAIRBqJEKcucDcCYQcKRUqICROO6
	2DOTwin8hKiDjpiregRJYsnjbwwWgueDpyW3/muLG1lLlQD7UD/mMJFDPFXHV7TYHuU8X0X09GY
	d2YdLeOC/5zOlrLhjppEh/lUn1FzO
X-Google-Smtp-Source: AGHT+IEIXuOZsMuSoYb7hNyiQAFPY8BACk5AsaFz6nHTA8M6q+uL6HODxkPFfsAfvjEVf9+iPCaqeA==
X-Received: by 2002:a05:6a00:2d26:b0:73d:fdd9:a55 with SMTP id d2e1a72fcca58-7486d351d34mr1345772b3a.8.1749593036803;
        Tue, 10 Jun 2025 15:03:56 -0700 (PDT)
Received: from [10.69.66.4] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482b083abcsm8220869b3a.92.2025.06.10.15.03.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jun 2025 15:03:56 -0700 (PDT)
Message-ID: <5de9e799-bc01-4fa2-8b99-1e54c7007963@broadcom.com>
Date: Tue, 10 Jun 2025 15:03:55 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: bcmasp: enable GRO software interrupt
 coalescing by default
To: Florian Fainelli <florian.fainelli@broadcom.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "open list:BROADCOM ASP 2.0 ETHERNET DRIVER"
 <bcm-kernel-feedback-list@broadcom.com>,
 open list <linux-kernel@vger.kernel.org>
References: <20250610173835.2244404-1-florian.fainelli@broadcom.com>
 <20250610173835.2244404-3-florian.fainelli@broadcom.com>
Content-Language: en-US
From: Justin Chen <justin.chen@broadcom.com>
In-Reply-To: <20250610173835.2244404-3-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/10/25 10:38 AM, Florian Fainelli wrote:
> Utilize netdev_sw_irq_coalesce_default_on() to provide conservative
> default settings for GRO software interrupt coalescing.
> 
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>

Reviewed-by: Justin Chen <justin.chen@broadcom.com>

