Return-Path: <netdev+bounces-88424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 641F08A7298
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 19:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E841C2825D8
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 17:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29D013342A;
	Tue, 16 Apr 2024 17:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wzt72N49"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E3F1332A7
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 17:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713289486; cv=none; b=dpfa+v9a1iF/Yx6sZ8Q6xIBFaE9pupJ7WLVtCNrH/nM5ir2OiwkjP802/zO3LEgj1iPbA4JfptYwJJpeIcgpBtANvx9PlV/IZk46qx6LUo+9f81PzlcSIbU0kyEQJXjuAvsQPJjfEAH9DsYzFXbz3ld+4W4HOkqeoPC+0FxExfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713289486; c=relaxed/simple;
	bh=nr4g1oINXA11L+a73PiTlGoU/0iSIb8Hy8dL+fJSMlA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W+EbtBeu53kroMGV0TGpVEDJb4dOnXt3WJm+RvSSolu1U5u6WscMPU0MQI1rqMqYICl412TsxboHFxPBpx0/zc1na4RJI1FLL0UmX7bZoJFS0ZXsItTD8z2tAIqDA5pwWBqHIEvR0cCeHwvpN6MqAMR3DmL6nfP1MofjFZw3ktg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wzt72N49; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-78d68c08df7so369279285a.2
        for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 10:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713289484; x=1713894284; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XrIP5NfD1uVdOzJdpOysC0NK7Um7o2M5ma7/UNP5Z/c=;
        b=Wzt72N49XjcwXboAM0i0lVLER3SVtqUjKxSYu0Yk4HnBRnv+/ZAinvgy6aUoq76/y2
         NUDCkp1y5lAB9ww/UmwUmkUu/uj5DOSibZfkl284nRgjORxHn0hUuuSuQ3sIHsfFisFB
         t060S/4ZUcJk5O/T405CBix8LvhpB8H000wZME7ee9mCLMVI9xezX87QkDL284nelHEi
         aOaFRwPfL+Mm3z668QR+7Im0XtXmO+KtvWa3dHH1fcYiOPb6i+na7elWQPV7KuFMAlGz
         loNk9CTff5EINQAUbRQ9DrHVrtlBQywy7SQ0RzROFLN+9KVvT6nQYSOOtXit9/ZvwX+K
         P4WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713289484; x=1713894284;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XrIP5NfD1uVdOzJdpOysC0NK7Um7o2M5ma7/UNP5Z/c=;
        b=XQVc/j0tbf6kxNvnqZ/K4h2SEb3F7+yNBtFHOeZaqTPsP/fljBf+xYiQijwtS7kniL
         IYQA1KOj4E+x1CXFHwWKnqgCSmKGL61l4MlM9QAoUtlMccl1Xf69Adc9gW5hCgu3aMV0
         zn75Xy8HUR6JKm6VcDWxwhXjPcE0OKBkDZu5yWCEQiHUcp/myji9b5lAMNHTb10u+8gm
         7MckOcqQTky+EEAFHWwLrLECtRGa9sfXfH2yqlMNUst11oATz3SVdHHZNu6GdpwPb5dZ
         sLUc9jQ+OSIl4bz24XeQlV9uG1TaTHOuIsoLcINcKNrRVsE+2pHs1ku9qF7DU1zNEKUL
         ZwdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrKJ5nHv0KUZ/So1Q9ZkhcU9BApLd8FeexxCxMZQB6mzh5UF5pvy/3l7t0iskRI0ViUJh4J7k5VEdzHaHz02IF3Z2Q+V0O
X-Gm-Message-State: AOJu0YwEtCbN23ADTdwTuTWlSUZyKkVVSk6yTnZsbeh1mh90/GqgxXUf
	NZj5G44s8DN+v0jS8RIktuNSyBkjzvAKaeLgqBUBZWnsgqEVwEJB
X-Google-Smtp-Source: AGHT+IEn9tHMTKBV2UxEMUh8zm0oXy63l3ne0ZXcUpEPyKCR6cUqyYlvOFmruvOaxNfUTcE6WMFPdA==
X-Received: by 2002:a05:620a:262a:b0:78e:bd7f:4db4 with SMTP id z42-20020a05620a262a00b0078ebd7f4db4mr16543483qko.51.1713289484004;
        Tue, 16 Apr 2024 10:44:44 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id a15-20020a05620a16cf00b0078d5f2924e1sm7706590qkn.63.2024.04.16.10.44.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 10:44:43 -0700 (PDT)
Message-ID: <3b57b26c-3f1e-4db6-a584-59c84f16dcae@gmail.com>
Date: Tue, 16 Apr 2024 10:44:38 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: dsa: bcm_sf2: provide own phylink MAC
 operations
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
References: <E1rwfu3-00752s-On@rmk-PC.armlinux.org.uk>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <E1rwfu3-00752s-On@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/16/24 03:19, Russell King (Oracle) wrote:
> Convert bcm_sf2 to provide its own phylink MAC operations, thus
> avoiding the shim layer in DSA's port.c
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Acked-by: Florian Fainelli <florian.fainelli@broadcom.com>
Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


