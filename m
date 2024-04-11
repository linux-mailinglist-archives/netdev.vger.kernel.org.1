Return-Path: <netdev+bounces-87134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F9C8A1D6F
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 20:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9987288BD2
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 18:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41641DDD23;
	Thu, 11 Apr 2024 17:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTqmeeN8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3FD1DB559
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 17:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712855257; cv=none; b=J47BJT4aHfbTLOWvoBF0TePMaJ3vkiHepqMsW6lCwuaeRKK8BHAgxnJ0MCpAJnW1F47L8IYhs8wCFk9o0N9BWpGzA6g9qX+v52wOQ8lWUSaIKRzGiw6rVMR/0ajypSEjkisilQHORH0jSlPaAca1eM7ZKzKghDm9EYXrCR6a4Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712855257; c=relaxed/simple;
	bh=WCobET+iO7e9O4Y/HP7uF3jpuqt/5PQ3jfkBK5rURmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=teH66JOa+SVOIg0tYFgUZvfGElXjt2bbRng5GqbwFhmdpKfm64ED2MjeGmplXrHyqtxPglLbuN2Abgm0HPv3Patp9N5CRRmKtzg0f7HmLmFR9iBDEAG67sko3WSOHhkh4AUreo22dycQFCvk4qnGIP53uKuAri/9G+zWlxKEXWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TTqmeeN8; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6ecf8ebff50so35328b3a.1
        for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 10:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712855256; x=1713460056; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e6YJ5Qu/Hcgbqp2fIXC519Y2ehC9xWP82cayt/Bbwtc=;
        b=TTqmeeN8og7CNnFxVqiiCgYsICVsmNZ+rgPQEXVDEokY0jJjihqCGJ6tXLeiJMu9H6
         +msN/wbc86pPx4CkxU6L2Ym1lYvikHSrLX4XAnvPVpO5HUPwqGPz/l/Rk/uSzOkagM43
         OyJPNbbkEiYkrrzyfgyx8xqcBYsjUX8l+EEiplAlITBjuqWx687WOY8qykRZ/rwvbMy8
         Jhjz3mNahvBS6G/AiJGI0KAcZ1EV788KyNYzBdLhFzUE9nVeC8dr3eLOd0Oz+2BOZJ7v
         /mBetl2cDqsZAXNER+UmHE2oZ1RyFELwrC3ktpj3J1AUGdqLUBXVBXrrj3cdCTO3V3VQ
         /3zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712855256; x=1713460056;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e6YJ5Qu/Hcgbqp2fIXC519Y2ehC9xWP82cayt/Bbwtc=;
        b=S7W/H//VFxO7SgKR7fdrisIMW91C5BEjB+pmgLF6IvYWBzhmGbQ6dvWK0H7JMaD4aN
         4TnaeSqisjk3FsuhgN+tlu8OHNtO6sPhb2XGNfNwDCmM7QmKAjxt3A86GBUSVe6p7KUp
         LOZqne+Lx+owlE+RXQVUl0RLf7QaZoFdaB1ZSHawVIBPk7825oXlq1MuobadhlZR+fOw
         ZKvjka6g+yPSyZsFXFEa3EHrlRYjTd4q7+1+2mCJMeGKCLqbk6B4uE0kSXY+E1APyY8+
         uxFuRr9qxRJpcdeq3SbdIGiHhIVqPP2jP4ML+G2JywgHva7Bcozme+oPYm/8RSq7JdxJ
         mGUA==
X-Forwarded-Encrypted: i=1; AJvYcCVNmMFJbcwdVMf7JR+uZX+Gm2DdoPhJdXSLspWMTN8iioNdgYNXhTmn3ollydFmklehmNTTIKGKWKj4eJiWefrsBDhlyqnA
X-Gm-Message-State: AOJu0Yyt6nw/N6knSWSiS/XKfbMSerrpzxwtZApZoMeyjv03D6Qz4BoX
	D8ZyWfgT+PAARaar9wjJPWG49db0A0AeoFsIgzf14mCrxujcB6Df
X-Google-Smtp-Source: AGHT+IF/Dqh9UvnbVK8/U9/idKq9c1dFyPx2YbkAtMNXY8acxz4aSOhFXR+SPdNoxIjN5OAuOAiynQ==
X-Received: by 2002:a05:6a20:dda4:b0:1a7:8071:94d with SMTP id kw36-20020a056a20dda400b001a78071094dmr3966088pzb.25.1712855255993;
        Thu, 11 Apr 2024 10:07:35 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id g10-20020a63374a000000b005e4666261besm1307968pgn.50.2024.04.11.10.07.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 10:07:35 -0700 (PDT)
Message-ID: <00598141-ca3b-47db-8f31-2f2a663d8f81@gmail.com>
Date: Thu, 11 Apr 2024 10:07:33 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/3] net: dsa: mv88e6xxx: provide own phylink
 MAC operations
Content-Language: en-US
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>
References: <ZhbrbM+d5UfgafGp@shell.armlinux.org.uk>
 <E1rudqK-006K9N-HY@rmk-PC.armlinux.org.uk>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <E1rudqK-006K9N-HY@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/10/24 12:42, Russell King (Oracle) wrote:
> Convert mv88e6xxx to provide its own phylink MAC operations, thus
> avoiding the shim layer in DSA's port.c
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


