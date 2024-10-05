Return-Path: <netdev+bounces-132331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F5A99141F
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 05:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BBB4284031
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 03:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FE41CF96;
	Sat,  5 Oct 2024 03:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KmEgqpUA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72581BF24;
	Sat,  5 Oct 2024 03:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728099581; cv=none; b=uPTCG+bmX1syhmFVmKx4+E02Vt2ynszEt4K4G6AcRM4ggi1/+SfetqtbKffqezywZSU2ABk/jcPHMO+ILN5yE2gsYJ/csmcYWxrtawsKyiZ8HYlQQ6SN9Wxbbp+IIfu9aiEa12ZlGPz0kT9xf6RBtyW8zt/OOP3LJItzX8jiVWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728099581; c=relaxed/simple;
	bh=kY65+EQyEUB/s3fYKr5ruEqBkFmasyFgNmwmfjNhCnA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NoC+rHSJ068VFa0ICgxqkW2EjAWutHCKmuwUIfM8Nd7W3lcb2RSNFw1w+9CbeutJ5TZPWrsRcdMPlnxbMKYrwV1oLSIE7Vbu4K+TtnZUCTPJGfotJ1ZyUFRybLlAGTv2EfrLt5Od8kGxP1cNnAYA1tBDzCalB7gGVRDJPBgj4/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KmEgqpUA; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71b8d10e9b3so2098337b3a.3;
        Fri, 04 Oct 2024 20:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728099579; x=1728704379; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vEp4HO5zy0INQt0hTfN+DJNz3SJyXonQWr4DIQYCL/4=;
        b=KmEgqpUAvl5iGY8yqXUl8Mw6ca4mjGCRak/u4Uk5s4aLPW9/gvW+km9mLrshNT0Ek4
         gx2f5BgdrsCkOjcNxHDupGrCWu7gFxgEO7DQGsv/CJV9MoHuzNMBLiiI6uyhsYKgEqie
         TxwfYcKw231zJDIbcN8spJ3O6m/qDxwwLJCWHREBBBTudYDEkn5vQxs7b76ElGxPKsNB
         BoekGFvxbyQZK3O7xLfCARFjjc1y04bp6y8XilwbzDHu7kG/dIE3OWFKGU+G4R4Bpw4c
         7k1eUNhnvTjnhxvSF1c3Eqn1sobKC8MLWbwUSxTJTjHwyRrGR2p0VkXfVUQPE2aIBHTO
         kQWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728099579; x=1728704379;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vEp4HO5zy0INQt0hTfN+DJNz3SJyXonQWr4DIQYCL/4=;
        b=Syym9GOtBXpMp92wTHjeVAiCQXyiudDt9PDSCfhlu3uZGt1K/XQ7YpVbo/hVGRf/k8
         7xxSRKLLxttMiLQYEAxzynKWXIT3DXny8Lvsi0TwpPqdXUHiGo0Y12pSL9ymXMwmtZx7
         MHTSQARgMSW95pca7K6tVHScn4L811zA1ovCE4/U1hPBM3fQDaGbZ9YMVxLXbWRLir1G
         A8mS4gMD6MSRbuzXOf7oaeVF/M7vwwSj64cIjKnChQDAVjTexGy3IHhsYOnmno16uTTV
         3r9UQrmTT28zdG+BBrrGflzqx8zHaeOiac4ZVDA5i9Lc6XtvZQeHVu9fMBr4sADFtS7y
         Cxrw==
X-Forwarded-Encrypted: i=1; AJvYcCWqVIKTdgdVa7CJHjyWc+sGdQCS2KXAy58yXWSUiqqvKaf1POTPq/nyCe/Y8P0alcWL+y+ZKl0e@vger.kernel.org, AJvYcCWx9RzrH6NRbQHuqAXqGBqvOiVHRvQHbjT12r13Trng2ru00i3VEgPATCdrUQoTH1K+JcYxjuREa/OPOKo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3a0nnwbPDozX4CmNPsxWakgs/ZaHReFLjRPQ3A7h8gl/onK2g
	fiwQj2tbPEVfDrp7YBaD2aFguNw3QoqL/zHz52H4TiDIjN6FWkDm
X-Google-Smtp-Source: AGHT+IGZcGvuAemI673wkorUb+zzyaxo28ZxTGjJLbHoiK13rfp9DIhZriLx/HXsfLcdn6Lnh7X76A==
X-Received: by 2002:a05:6a00:3a14:b0:70d:2a88:a483 with SMTP id d2e1a72fcca58-71de22eebcdmr8423454b3a.0.1728099579128;
        Fri, 04 Oct 2024 20:39:39 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d6243asm625391b3a.151.2024.10.04.20.39.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 20:39:38 -0700 (PDT)
Message-ID: <a57f67ff-0f5e-4fb2-9127-7839d385298f@gmail.com>
Date: Fri, 4 Oct 2024 20:39:37 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] net: dsa: b53: allow lower MTUs on BCM5325/5365
To: Jonas Gorski <jonas.gorski@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Murali Krishna Policharla <murali.policharla@broadcom.com>,
 Russell King <linux@armlinux.org.uk>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241004-b53_jumbo_fixes-v1-0-ce1e54aa7b3c@gmail.com>
 <20241004-b53_jumbo_fixes-v1-4-ce1e54aa7b3c@gmail.com>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20241004-b53_jumbo_fixes-v1-4-ce1e54aa7b3c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/4/2024 1:47 AM, Jonas Gorski wrote:
> While BCM5325/5365 do not support jumbo frames, they do support slightly
> oversized frames, so do not error out if requesting a supported MTU for
> them.
> 
> Fixes: 6ae5834b983a ("net: dsa: b53: add MTU configuration support")
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>

Could be squashed with the previous commit, though no strong opinion 
either way.
-- 
Florian


