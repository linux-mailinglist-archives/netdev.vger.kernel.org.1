Return-Path: <netdev+bounces-115428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5949465A4
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 23:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8721AB23313
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 21:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A151136337;
	Fri,  2 Aug 2024 21:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="niy9k7XW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED661ABEB7;
	Fri,  2 Aug 2024 21:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722635770; cv=none; b=acsmflgD2jdCxzlHmThc8w6Nxaz249h9LRimVosRWC1Cs9nzNEMdw4Gqeiasnjm2WjYRk7x+lGbsbHldrJEENZJctEr6q+tEK3LnHne8Elfy/pcnHBMTFlPyKWo8M38gEgYxO5K18gs3Nlk3hAJVJHFwhvqPKIczfMfaKHC9kHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722635770; c=relaxed/simple;
	bh=KoJQTkF5/qzWbPnXYfzFAhkzD4NnVFN8YYBtaKqoSlk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AeTzR9BPJjdGQSCnj36mjMlsRjFWnHeiJ0jfSC9UHI+MNJ8hhAG/T1Y1z9+t1nuoaVwRNn1zPktMFDxW2mxShEtFu504eGcXxkP4AqR+FdWc5Bwk3kUEHdTM/Yf6gq59d18Bkl7NeyXZtZDDZsG45baew4J7fwbrjG+q+nfRitE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=niy9k7XW; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7a1d3e93cceso352925885a.1;
        Fri, 02 Aug 2024 14:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722635768; x=1723240568; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=veQpKVM0FRYM2BVfMh+eMN2MAv2BGzH3go5RC9CcCQQ=;
        b=niy9k7XWhIrBQttL8TjDUJmY0+x6GUDpGpVmqGYujDKJl4yzfuLsJM5YM3dOIlB2Ln
         eeC3KhAJz1nrqArNE+Ni8zwuJKDgFg4R7oVrCXsBt7+t+wy6weENtCxsqrAwBcT+EnUd
         qV/gWN4CT6vJsY3l/g++EeC9kOpe6CtHRRHkH0Wx7rQddS6/jZovjAXrgCmLZnXIUpPH
         9jEJb0idMBFvNvKp+84YU1TEGEfIXHYdsgWSkvg0a8M+AFFlbv9NVsPrHc+6e8nk6ym1
         yvn+VpO5tZY9Sew90dL4bAN8ietbkOSzg4bm+eIxz8a5Y026BxebLpI9kdYuwmn2DrJx
         jGQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722635768; x=1723240568;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=veQpKVM0FRYM2BVfMh+eMN2MAv2BGzH3go5RC9CcCQQ=;
        b=vkBn/pB2TWCw4uUWZHR7jUKa58mM3Kem7fryZ1KasaITQPQljbDzJhI7dE1/xelGLH
         H2vsPUNMgb4LYPTgTARTuP4kPyrpuyR9IX08E5UddZFXDDHvm9SN37PLiFl5TMgqWPYf
         xQN0FZxFHL502qU6x67GL/oyCNUw7lkiJSZvXJ8aWAlUNIgr8Z2UyvsCllC24bPE/nBb
         0ZpDa4ZfJGXfiiiWHw0Djs/Paef7Qbxp8vKWoO+eeJiwqs7p+BtJV8S+dLt3rDQ0X0aL
         aIbmMc60L/+eiwzeo8uQWKqbkkWNx4uPeg4JSW/9H1z+tBEKq/U0sf826xmDtyjy6nhg
         N9OA==
X-Forwarded-Encrypted: i=1; AJvYcCXHl4+8qoL0/YkgRvHUqK+fwubIzxl0AGGE3YiveEKNiapTeLrOlPwZegZPWMTAVANXwrqpGGe+Ko+7UbVrCkkOFhsRRkYYbY0YnFuam5JyNgepEzG+hWGt+OM/DvkUyvJxL48m
X-Gm-Message-State: AOJu0YxR2wkP+mXo3lOlAhtE7x8iGgA5QkDVK6kSEOt8LsjY2GXbp6nx
	2X2j5dBamrjgzTMIBQ4mJsRSjZsQ/iNXqPN+hSSafv6nW61AeV9v
X-Google-Smtp-Source: AGHT+IFuBqp2E5ZcS0qoBRo8IxE42i3DHGS9ztDv+PPv8owd8gQ5Rqe87bEsOAD79zQBEK19VvNqzw==
X-Received: by 2002:a05:620a:191d:b0:7a3:522a:b0a2 with SMTP id af79cd13be357-7a3522abf2cmr604154285a.17.1722635767874;
        Fri, 02 Aug 2024 14:56:07 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-7a34f7860cdsm121074485a.101.2024.08.02.14.56.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Aug 2024 14:56:07 -0700 (PDT)
Message-ID: <4f8fe924-03fd-41be-8e01-1580b650ec40@gmail.com>
Date: Fri, 2 Aug 2024 14:55:59 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 5/6] net: dsa: vsc73xx: allow phy resetting
To: Pawel Dembicki <paweldembicki@gmail.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Linus Walleij <linus.walleij@linaro.org>,
 linux-kernel@vger.kernel.org
References: <20240802080403.739509-1-paweldembicki@gmail.com>
 <20240802080403.739509-6-paweldembicki@gmail.com>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240802080403.739509-6-paweldembicki@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/2/24 01:04, Pawel Dembicki wrote:
> Now, phy reset isn't a problem for vsc73xx switches.
> 'soft_reset' can be done normally.
> 
> This commit removes the reset blockade in the 'vsc73xx_phy_write'
> function.
> 
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

Same comment as Linus and Russell, with a better explanation:

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


