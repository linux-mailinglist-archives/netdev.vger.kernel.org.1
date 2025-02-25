Return-Path: <netdev+bounces-169386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBD7A43A52
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 10:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A93F53A7F6E
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 09:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC502627F5;
	Tue, 25 Feb 2025 09:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3zioyqL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEECF214208
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 09:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740476971; cv=none; b=APLUUk1saHdI8vD2mNByJ8bh3jCTjqYB+wjZESUUADrLwThNLdfokjxZ4YaWJh0gYy8Ca8UlbcbSKWiBMycK3YsOb5FEKc+bphzCgmP9Bkb5avL9Y9N8pyTPPAdg5hVRghmnJ85UbUmSsgA0r637ckjrU3Gl4ylTDocsXmxXYOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740476971; c=relaxed/simple;
	bh=TWnUhtH/9KOD8g+USQh2TZhP8+lpYajWpK3+tx6mrtQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G+JBJGtcIf8u3pD/IhF2hsrchwgJGVEJlPzmOPmE32QJbyCohXVxdduI4rfcjMOPGkF3tawro0El4owzm0qLFpa8lpqAWz7rp6tm+HNxSaXXwEOagwR6sWJaCmaQA9IKr/WiZDEGvZxbTsqbia9ELtwwCj6UyR/nto0VX5QVm8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3zioyqL; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-438a3216fc2so50881705e9.1
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 01:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740476968; x=1741081768; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sEu9/X1NjIhBo5BotYwQxniS5PzU+f2d64QntvWNB50=;
        b=J3zioyqLIJJ7cv/l22/aIYihTxKe/hi/S7OIZLTCng5OJQQIuASCTfYfKkup3ZVrzD
         f1NJHsTzqU7NVucrG3WTkzRQgNNzgL1FYp+jZPpsQptxzG8546qETFLvZFKLczukKJoe
         nyW8AYTbO5FR4HAXS9J8cxZ1qFiQ+d1xvSO+zFP8uoLGo5XSyRFxyqN3KnlgdTkKfgXC
         5YGwzyRefMbvqDjT2WA1nY/lIX6hNLUP98vt+tZbcuHoMZ6ej2SvbDOkLAumiyxHOK4e
         Av1qzIVty5Kf9Jotda/IyG/UBpQe9gEtAbRaUkPw7zD+upl0/HAk5h8gKdkXS8hekx4h
         IaJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740476968; x=1741081768;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sEu9/X1NjIhBo5BotYwQxniS5PzU+f2d64QntvWNB50=;
        b=opXJ9FIuNsdTw19CTcUinFNGeWSD7Fx/H1MMdF4a+s4C/VDB/Y8Kk8Q8aF+FtZ2J74
         nDebE51s1/+dSZ+psqrb6afRk9NXjK4IKNh48WReef14LdahJ0J/Is9s3hIU0E2APNcC
         aBDYbF5jnoVPBH2zNnwnwcSD6jnBEhaV1TTlMknS3+Lw+yGQbfJ2rAuJytjlmLr8b4Mf
         78/LkV1iHSBZMeOutwMSNQr7N/5ZPAW4V7Zpcq2y0sSN7DNg91XjKGlWFsteHI4o1iYy
         aQo2p+JoSoUA1+ThrU0IwiLH2jNyEPXO3EiD4j+5o4vmiAYN5gWm4bRoZJ5vAD9HySXs
         WxNg==
X-Forwarded-Encrypted: i=1; AJvYcCVRjkgH26539Qmg5wslwHxKNTrLe4cwKO5ah1dHp2SFRJ53xnJ5lp5DEypdOYOxwPin4Sn6nYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD7FGZR8yQzYM5gB8KvM2Kj1NlFiZKkGs/nM8aAxBW+NVej5OT
	kKmRDI1fWPdhiRTZ9WyXtwdtpNeY/4xb8qviARXTqFN+MKXcGbsM
X-Gm-Gg: ASbGncsKAs/zixnYzBCdJTNtcenKEC8HdvDReP6d6/6Scu6DevPQRyWJJg8mBg6EaD2
	+1/vsL/sOHPbqfpZ4vyUkpZ/F62hmfq+LmSQCXR0pG10+gH3tlJJduusL5OKI41vOOxjQYVhvSG
	HoUnSPbWWStlWU+jHW8KtmT0oiVoQuRY9ivY+EnQnRAadcLn8lPx8aRzr1JV3BtCM+1qK2tqWOG
	7J/hoyJL5DVV+vIH2x8XpwhEv39dOqfv6EK+LCCeBASOb+U+F3ZnvjhNG1pKy44tLkiJrOBJTob
	daLUIPXxkST0TOaTzksHIA/1dMGZqpcdNVPAmsNuHxoU5Q==
X-Google-Smtp-Source: AGHT+IFyBx6cmr/6DqoQPjHrpL68DGEoWCIyN22hMBawBYKzwVgmugzNhTPdsfHErlIUUyiU+Zst5g==
X-Received: by 2002:a05:600c:1c04:b0:439:9b2a:1b2f with SMTP id 5b1f17b1804b1-439aeae1c10mr132617705e9.3.1740476967427;
        Tue, 25 Feb 2025 01:49:27 -0800 (PST)
Received: from [172.27.33.12] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ab155ebd5sm19362475e9.25.2025.02.25.01.49.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 01:49:27 -0800 (PST)
Message-ID: <635478ff-faa8-447f-864b-80d01eb92157@gmail.com>
Date: Tue, 25 Feb 2025 11:49:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [pull-request] mlx5-next updates 2025-02-24
To: Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
References: <20250224212446.523259-1-tariqt@nvidia.com>
 <20250225090737.GF53094@unreal>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250225090737.GF53094@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 25/02/2025 11:07, Leon Romanovsky wrote:
> On Mon, Feb 24, 2025 at 11:24:46PM +0200, Tariq Toukan wrote:
>> Hi,
>>
>> The following pull-request contains common mlx5 updates for your *net-next* tree.
>> Please pull and let me know of any problem.
>>
>> Regards,
>> Tariq
> 
> <...>
> 
>> ----------------------------------------------------------------
>> Patrisious Haddad (1):
>>        net/mlx5: Change POOL_NEXT_SIZE define value and make it global
>>
>> Shahar Shitrit (1):
>>        net/mlx5: Add new health syndrome error and crr bit offset
> 
> Thanks, merged to rdma-next.\
> 

OK.
As mentioned above, I need it in *net-next* as well.

