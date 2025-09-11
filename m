Return-Path: <netdev+bounces-222004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E953B529C0
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 09:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C002E1B21E50
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 07:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB742698A2;
	Thu, 11 Sep 2025 07:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOoqW1bD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE21214A97
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 07:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757575342; cv=none; b=RqXZWxjGBjKhaftZFyQsWd+iyx9TBRj7hYOxzflc/7s471Wh3vLIAn8AZwlGnXjUOc289jz4Xw8S3IADhCwDRlRlnZl9BAN76DHsKR7+b2wk3Qpt1x0PI6xdfT+ZIGThFXTiHxD0cdvK6cR+4Xibn6sNIAgm4Ts2RWbH84Lbwww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757575342; c=relaxed/simple;
	bh=ZWaN7YsA4DMy2XRDp49IiuKAKtTkNWybbq8m1ORlV/c=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=DCphA8oZrU/50gLJ7kJoOxz1OlLE2boodmnTYGgynIRwiB5vAVfVUXRE1UGl1VmM/LIupYLxF7G5xCUo2nlONb0srcBfOuSKieKReBuQhAtj/S/FCXbpfh2NHjciUBDxm8JO4rlAhoiBYR7+1UjfjlX2O9+4Fr1uD9lgUDRdPG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VOoqW1bD; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45de6490e74so3503345e9.2
        for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 00:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757575338; x=1758180138; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iBZDug7B3a6KZhOLQWyC0Abrerybwc7sC4SOlNu+UcM=;
        b=VOoqW1bDxpQoJRa2KUEmLv6ktm8YwJYEh5D9gC7TdwhY3HSjtzv/jf4ZU3Wp8t443X
         OPfaPd+Xao2lEXKnksBq2ZOU4VmxNbQ7wQwlL7WkQ1SZme21+kCUTIHD1TQb7lyL+jjF
         jBSU4WvKZz5ea26FfFVJbOcyx3g4Dazf4Y3w1sbs/YWOQw75qI86N9vfYIfZcwM6Ghk6
         R+bMQj05sqI0lZyLgeyn6SVYnGMC2rVdPVKNJN3BjnjB1n5ea1q/kdIV8ate6aR2f1iN
         ZqFANIoI2q560N9yeYJ6QyCsdxhivS8YHO75rYF9yUObM0GJaO/WBAexjUwvUmfFiFN+
         cKdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757575338; x=1758180138;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iBZDug7B3a6KZhOLQWyC0Abrerybwc7sC4SOlNu+UcM=;
        b=q+ihfUmNSfuybUTVxeIw/EAUoYg5zexYl0qzPPSVrWihPW5QYhRBRL/LAYfsEmaK1h
         i7lC0PZJUAPA+rebu8fqeMmmoVi26X+KwR9iJ2LWlQjgQfhNecO1Z6lRnU+1fSk/KvFZ
         kgYKWCxr8Yz8GjxHQpq7ZNnnyoadc8/4D/Pkpiy33XkblR8fk4+KBApcpGnep91Ed25q
         g4K307r0z4WO6PdKNnvQkts86ivLktSs+tDdPss34vPnRhfxuULOGKBxBtCZUMcZ27wQ
         7IXqMuH7KhOLu7/ZwYDI+OkFZmEmGTNECslwbAKI6ekvt9HQRJjhtrG3UoCsO8AZ0lsZ
         dDMA==
X-Gm-Message-State: AOJu0YwwzuaIJmglObOgL/BWeYs9jzu9eDGZUOTGDAd7F2JxAjsgs6XG
	I4mubmJTArCRXG6fP/Jm8Dd1DPAUePHBBo7VgKAKYVlXz8bcZGefTzFJSP3bkCcc
X-Gm-Gg: ASbGncsdpKH9Txl8t2OKGNa6lQ/CWrCJgLsk9Y13huW1MIfdEjKQyr4YYijhzpLA2SS
	hZdQQNiJ/Awsjw5ZEQHNtZVXiZh+sEuMPEbgGl1/SmPmqRWJxssVemmB7k+RwhULNwq+JvQNOLd
	AbHn6WwQizVUH29Nk6iffd/bVOyskYlVsnuyK8FzqS36pYzXeVCSLVEzvXANsfr2DgN0z9HRCYc
	+GL0j5ZXZl1/Fq6qKzlh9kTaWKdPdNSYMIqrDhbUNxXS6qIJ7l3N/oDy5NpdRa8J370gonyjtpb
	wZ4n9FIlJvdrl0l7Qp9Rrg3iUXmRY+bHp9A+8uKiFQCa+vuBELroTWF8aWJaCPYa1PaRAy6HhuE
	rIPjwk5z64iUXHl1CMSd2fb5SJAX6RpCBKsN4wj5v3O8KAX6VDRKj/YGAckm5dLTZtcJWtOIwZU
	zaRIB0d4OIPYx6JlHIZ2MvwnhM30Rp1UxFtLwdOLSDxu2bzfP1e4PV32ApGJOCoA==
X-Google-Smtp-Source: AGHT+IHz5V7nV8JBl91x1wAz8oXQZ/wriSZAbpgenGV/u8zJ6gkd3CH7anEVb0TSQOAHW6eGajD48g==
X-Received: by 2002:a05:600c:5248:b0:45b:7d24:beac with SMTP id 5b1f17b1804b1-45df73e889emr57541185e9.10.1757575338041;
        Thu, 11 Sep 2025 00:22:18 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f4f:5300:882c:6330:ec22:3cc3? (p200300ea8f4f5300882c6330ec223cc3.dip0.t-ipconnect.de. [2003:ea:8f4f:5300:882c:6330:ec22:3cc3])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3e7607770aesm1335638f8f.6.2025.09.11.00.22.17
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 00:22:17 -0700 (PDT)
Message-ID: <fe09b79f-7d87-4fc7-b0fc-f594c6eaa440@gmail.com>
Date: Thu, 11 Sep 2025 09:22:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/2] net: phy: print warning if usage of
 deprecated array-style fixed-link binding is detected
From: Heiner Kallweit <hkallweit1@gmail.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <964df2db-082b-4977-b4c9-fbdcfc902f9e@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <964df2db-082b-4977-b4c9-fbdcfc902f9e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/9/2025 9:14 PM, Heiner Kallweit wrote:
> The array-style fixed-link binding has been marked deprecated for more
> than 10 yrs, but still there's a number of users. Print a warning when
> usage of the deprecated binding is detected.
> 
> Heiner Kallweit (2):
>   of: mdio: warn if deprecated fixed-link binding is used
>   net: phylink: warn if deprecated array-style fixed-link binding is
>     used
> 
>  drivers/net/mdio/of_mdio.c | 2 ++
>  drivers/net/phy/phylink.c  | 3 +++
>  2 files changed, 5 insertions(+)
> 
--
pw-bot: cr

