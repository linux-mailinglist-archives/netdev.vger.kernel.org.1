Return-Path: <netdev+bounces-85936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E677E89CF10
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 01:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DC4A1C23A52
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 23:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B951494B8;
	Mon,  8 Apr 2024 23:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMNwVvOS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7146E17745
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 23:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712620251; cv=none; b=HYbOZRZ6iUt+Kd39Ldz3SKohFhOlH94YkbyzOoEH/NFDxqZ0KjjStJ4H/1bBb552O+9zTtze3gaslkSE+cX6CtcxZOyFH6RLYoYbXswsTq9yHY+dajNBpj1Kzi2wjWO1UV614ww8wSkg1dSeKhRoF731/jAOA0FXrhALMiLm6J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712620251; c=relaxed/simple;
	bh=DAN70NkiRF8SdVY/+TlURS9O1d7Loog3dXVE7fk2JgQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K9xhWiX1NDad5DU3Hu0uc7xsL6k3UmURrvlWJWaft5juHbZOZooeaHDinJmbgpIWkRZT0i/8Y/biBlCQXKtxlgidMU8uWJcJvl7f4aRXpBjARFn1+0r7h3SrPJPR+90YuQdtgOPDMtU8+mBgyJRhfvlD1v1Wid+Yn5bno72n7AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YMNwVvOS; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6963c0c507eso52263816d6.1
        for <netdev@vger.kernel.org>; Mon, 08 Apr 2024 16:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712620249; x=1713225049; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/iVh9rbjAiQZhW+JhHliqVmc0hyx/OKQjjkWKKAl+D0=;
        b=YMNwVvOSybWAAypEaWs3Io2qZO0P+5CbQH1CKeVB4AMX5qntlXQbWgYYBqSkv8lGU+
         OMm17xxKYKkkBYv1/QwQq+f7VKot31qXTlUx8CVa63LW+1HaSX7JSewSbfdKIThzi25V
         Zf1NHAElRvKcll7FVy3Vq5ZwjwHQ5deaFOMCBNxed6P4kQYCMmUpSqoRhZFLuqJw+IW8
         JVGFnU20rQ72DURGo4Hz6E/Ko1yB0tnTShgANiPHDhrr2Q6rDINjB1R4k98KVZrsexNU
         02UyMKTg/eul/DFbvz4maQ9gJdGw97+UDNRbGkpQiaP2EezNb3MA10SSymXOmncKAAYO
         I+hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712620249; x=1713225049;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/iVh9rbjAiQZhW+JhHliqVmc0hyx/OKQjjkWKKAl+D0=;
        b=Ec2/9xXMNgS7o/CDvOv5bqGJb/DGnOSQNXHDXcfpTgWuFe11047gg+lhwEAYfSLNi4
         z2PP4y8c00Dd0cWiLtdCYcYtOTxjSvtPvJ5oMN2+Nav8HSrnYknC4pu7YPCGwvFQQePX
         4WVpa5txIuJnQn7OChSjeFhQNekRLSq/QiSA/FR8iogz2A4zOdFG4MXmA24xtG9mMeFh
         n6De4sPwUPfO+0mOo3rymt2PutIqsrzz1zDdhgElRf/Ce+o92edt5lFW8XxfLrbnPWTa
         rsY8c8RAfkck2i+riKH1OqPU9ZvhUY6kKAIDLvh7l38yq2JfeYbIb+6L8TqkQCdV3PU3
         LYEw==
X-Forwarded-Encrypted: i=1; AJvYcCUc+4/JfdTKEkmXucPKUb8quBGalhkIiH/BFzwWkghA4UPuUhTOEDFOnQ6bvkVdQYBZqw255nXtqFndjVFZHyOodxFLF5Vt
X-Gm-Message-State: AOJu0YyXt67yZjDzDgE9cbNj0YMirjHFaMytci2gU65AJqDkP59qohN6
	gQSTJkuaay2IsoC+17Zc/+KczFEgJn+tVxaUPLrCRtQnPjtfBcEl
X-Google-Smtp-Source: AGHT+IGucXifT0wMAdeJi03l+Xj/LxYC0pZ9YSIn8qZmHAHU+wmX1HpBK8BSab1ceyKWiMvjd/B0Hg==
X-Received: by 2002:a05:6214:2403:b0:696:4771:9b57 with SMTP id fv3-20020a056214240300b0069647719b57mr2028413qvb.23.1712620249278;
        Mon, 08 Apr 2024 16:50:49 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id mn23-20020a0562145ed700b0069b23e58468sm624094qvb.43.2024.04.08.16.50.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 16:50:48 -0700 (PDT)
Message-ID: <b62cca10-3548-4b56-a993-59c2f7519599@gmail.com>
Date: Mon, 8 Apr 2024 16:50:45 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] net: dsa: introduce dsa_phylink_to_port()
Content-Language: en-US
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>
References: <ZhPSpvJfvLqWi0Hu@shell.armlinux.org.uk>
 <E1rtn1z-0065ou-Ts@rmk-PC.armlinux.org.uk>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <E1rtn1z-0065ou-Ts@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/8/24 04:19, Russell King (Oracle) wrote:
> We convert from a phylink_config struct to a dsa_port struct in many
> places, let's provide a helper for this.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


