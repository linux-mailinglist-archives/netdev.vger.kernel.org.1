Return-Path: <netdev+bounces-123444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8503A964DEB
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 20:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE5CF1C224D7
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 18:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A69E1B375C;
	Thu, 29 Aug 2024 18:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CPlYK/QJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CA94D59F;
	Thu, 29 Aug 2024 18:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724957006; cv=none; b=cAMJdNt6e67gIStd0dFoRaHhVsgwCVz1oZAShJ64IwDqZtE/qYqMceoh7HkRoVIk7LiQsRvC5SjWjRobVZi8D/ng6VrIGDMbrsw/1d7pjZ0h1ZYg/lFNfEtPlLjZhhrTatRV1q9i+hPVT3fE8JvGthhqm+04v1XcPgRvPLLobdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724957006; c=relaxed/simple;
	bh=vE+oHFDKn1n2H0ca0J6627LrKzdWqp1r5PgbRtG60jI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ijPLSjCI14NCFyj9qWwdrtxqZXgipKBvQxp1bjL9LO0XeRvwj0IM88eVkkRND7YQEmXbgGuScsUcml5eu91WVuqsWfEUOeFEHpsiO+s7vzwa/KHwlAI9549iS/lVVsRENFBEpypgKyMImKw3g0szKC8mKBsSEH2QQMRAcdNp0Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CPlYK/QJ; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-715cdc7a153so834242b3a.0;
        Thu, 29 Aug 2024 11:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724957004; x=1725561804; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4C7xSOcW/TzKaBdUZWPIdJ9PAcDUfVW7KB+BCThOMkc=;
        b=CPlYK/QJjoZ/Sb/O82Kog2l97PSM/wl6runqGGVtcwStezgFWNxPVtWj0q7p5uanQC
         51bsJSPJvTK+vzoxM25xZ+p5AwSHttnjFw/5cdt7DlTu+AQzBuamIM6tLvD7FdTEPEjG
         uJW2bmae1cjBsDvfudGsoIONvua2QC4jJO+VdX2cqPo/P6f1On7pLhX4ohy9tdcbNPTr
         gYjHwUPy80k3sfUylC1noM6qmlNWYGxYrdhP/lx+bdPRfKkV0UPXN8nko6WhVWTpK0pP
         5XPQTYkdMsv/VJ8l2G0+KIJy+Wim72/k8svT6oANR0RrZD3YGKfSwdgWi39xylLSSC9f
         lWUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724957004; x=1725561804;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4C7xSOcW/TzKaBdUZWPIdJ9PAcDUfVW7KB+BCThOMkc=;
        b=M3QY542CKaPVxVo3YL81GUwmT3ujnDZ5e9WI/TUC0zLUNU/r+m7QXlTFEeFEL8LA8p
         yfYOyNYLijhBBvqYIvRCOJn09hfd0OVDyuifcgP9pWB/vXuGbZs7T8QtBqvkFKhXwSmX
         n4VLulwQWuhZWT0r4StnJeQUTJVBsgPp86BFVeKnQN3Ns9hEeo1RT+tOxdpGesZvcc1A
         urSRfgIQnBX+IUhjrKVD97/BbLHAz63Bi+dZ/vkRaHl3jX3hPi1qoUzequUCu7wJUt3C
         ZhnH/OV2Ng+zwWMg7GHmwehtfeGt++w53XiepvUFHCacpx7P8XrdwZ0znK4mRmlYoMh1
         ZWmg==
X-Forwarded-Encrypted: i=1; AJvYcCX7FhNDUQOdXesSqbbjydtjxCElfnI5DL5CeANEL8wDt5z6hI2mEZeHEp3Jp0Z+Th1D5+4Fdzc17lebHi8=@vger.kernel.org, AJvYcCXD1TU9oG91XW8UWdUUpiQhtPK2VEIV9eRHa2I4i63VmkAzG6Grl6yL/R6afICvzBi4xrhZVlXN@vger.kernel.org
X-Gm-Message-State: AOJu0YwGtlnJy14NMchxaTxxiCb1s/WccVndT2kdXwiIuXy09y1NCP1j
	3Y9D9LvEJBu2Hkwdux+1K7K7X3MffzhiU7iqEcIGWaaZqBwT8bDN
X-Google-Smtp-Source: AGHT+IFVq3+ktr6bQOFUC8KGniIQIVORiHvN8Mt2AhB7WSm9HpXa44ndoShl8h6MzRhY/EwEB20hIg==
X-Received: by 2002:aa7:8895:0:b0:706:aa39:d5c1 with SMTP id d2e1a72fcca58-715e78a7047mr5738454b3a.8.1724957004073;
        Thu, 29 Aug 2024 11:43:24 -0700 (PDT)
Received: from [192.168.1.14] ([200.4.98.43])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55b9cf0sm1486289b3a.96.2024.08.29.11.43.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2024 11:43:23 -0700 (PDT)
Message-ID: <9f4831cc-84f4-4329-b912-d558c74797c6@gmail.com>
Date: Thu, 29 Aug 2024 15:43:18 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch net-next v4] ethtool: pse-pd: move pse validation into set
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 syzbot+ec369e6d58e210135f71@syzkaller.appspotmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240828174340.593130-2-djahchankoike@gmail.com>
 <20240829103552.09f22f98@device-28.home>
Content-Language: en-US
From: Diogo Jahchan Koike <djahchankoike@gmail.com>
In-Reply-To: <20240829103552.09f22f98@device-28.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Maxime,

On 8/29/24 05:35, Maxime Chevallier wrote
> You have an extra white space here. Make sure you run your patch through
> the checkpatch script to detect this kind of issues. 

My apologies, I did forget to run checkpatch, thanks for pointing that out. Will

send the corrected patch.


Thanks,

Diogo Jahchan Koike


