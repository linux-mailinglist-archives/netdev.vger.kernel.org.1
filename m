Return-Path: <netdev+bounces-109238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE6B92782A
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 16:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA30C286514
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 14:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DC51AEFF1;
	Thu,  4 Jul 2024 14:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLyswuB4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A1E1AED3A;
	Thu,  4 Jul 2024 14:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720102875; cv=none; b=AE93f5JxPAGatEMGVNB6ctJZrGZken21dyIocrJVylKHE9QCi4I6gDSzokWXdqZEkojFB6sli3XZmtA52XrIT/bgiXw1/OdqEJccsrUl/oicAjsCePiIMRydzmvx8pIKk63Y+FFZCS7bpM5geW6WTmrAVVdqU8xNA9ZT5UhnDAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720102875; c=relaxed/simple;
	bh=dtJs/mlP5TqeSFNvqsF9NgvGa2f2V8tx72IbVVet0XY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KwKvbpaXkKOuPVQgsBO6Hy2o5upR7OAkO1rI2+XEJQSkRNxzzuRBM3YJ9RDt91W9Gg3S+eRuSDhS+TbHUg+MvXwjjAg8cvMSVz4cqDnREpIsBQ85ZjtYfqzHmtEbAqXjIRFZWVOb9pfHbbFGmvisPLslZVuXDOs3IoLIgUOwoG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SLyswuB4; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fb1ff21748so3783905ad.3;
        Thu, 04 Jul 2024 07:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720102873; x=1720707673; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DHqp/0g0cWxpjDK3cFPyUUh5NMgsCqOCbHb/t7M/QjU=;
        b=SLyswuB4xlyBFSLZ1ZcCnqHK1/mthgOpBIoqO/yPvYCyniN3S408MHqFf4dbD5n/Vx
         5CO+SDMmI4KCM5rETnospjt661EeoBU68lVmWaj3Df/tfUlE+qj9ZZpH+4/7nuANvcOm
         njA8Mwz1D6PKisvCF9e6jTS4KF1SMtzJDmSQFX1YpVNsMxIzLEIHzOAJIPqD7tvHIbBM
         Gw4FjMUFODICJtlvFhSiZKZKeWe1PNwVjlIOPydxDSEP5XSyjzMqTiSXiWUcPnTCuDSv
         IPbwi2XG/swfQVMqr0LiEmuJzDOUCTFlPke1wkvFK1eN0fnFI9Ijdm6Wk3mH3RC3mqtp
         yCcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720102873; x=1720707673;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DHqp/0g0cWxpjDK3cFPyUUh5NMgsCqOCbHb/t7M/QjU=;
        b=vMQInJzANYfuGB4udjVGQWrobOajOb8QOoRLZIOymNEHx2xn0E6gK54QBxBHytyDoG
         YUVMZSnZSxFR6IPXRxAzWI/BsrrqkzcHloPRmi9CvxGNSTLt6Tyn69f/XUBjtYYbtI/4
         59Yj+pZFVTvvUrwKDn3MjckA2Ae3uq6L/vx4DNnwWdfWNYe8qVcNZSkClB9PHvQbVDIS
         De2PhIZQkewGLNJfpxSXqNmqTr2QOK+9HyYfJRsxJmva+Gok/r6Eq0Ahc9lx9aq74HOi
         KVKtNRAhh27/f+yiyswSAWuqZKGae1bYbVBYkofYnkbO4XuDh20Rt1NppeyFH2/HhH2/
         Z5JA==
X-Forwarded-Encrypted: i=1; AJvYcCW/Kv6bKzEzIMnjofj//lBK3cGJYgPWuzs5VnqveeqFB+vJ07tTgqoAlIkv1Ui9MTu3dqQ++azC39i4egOtXze5UbadS2hUg+CmOzJ4mFu2+RbbWI4fpItNr/9bNmlgZ+2f5ebH
X-Gm-Message-State: AOJu0YzMpQy58m89sFrMr7jWmSYB4uQGJgrNtGuI7Ddcm0okC2lQI5Lf
	rD/6GY7oPL3eP0pLsA2FM0CqlDx2vP0UOZRG3KTG3T73OBtiS78j
X-Google-Smtp-Source: AGHT+IGMOb1iAmr9YuX8soStafBBy/6myE0L2RVYmRWnnIkDKUkeLGBaNK1mq2/0LJJjz5ZUlrfsnA==
X-Received: by 2002:a17:902:e541:b0:1f9:cb0c:5b8f with SMTP id d9443c01a7336-1fb33e163b5mr16513645ad.10.1720102873033;
        Thu, 04 Jul 2024 07:21:13 -0700 (PDT)
Received: from [10.40.5.113] ([89.207.175.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac2f03acdsm123088185ad.302.2024.07.04.07.21.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jul 2024 07:21:11 -0700 (PDT)
Message-ID: <1f45e8ee-3c59-4cf0-a965-7eb0e3cb885f@gmail.com>
Date: Thu, 4 Jul 2024 15:21:00 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 1/1] net: dsa: microchip: lan9371/2: update
 MAC capabilities for port 4
To: Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Vladimir Oltean <olteanv@gmail.com>,
 Woojung Huh <woojung.huh@microchip.com>,
 Arun Ramadoss <arun.ramadoss@microchip.com>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, UNGLinuxDriver@microchip.com
References: <20240704141348.3947232-1-o.rempel@pengutronix.de>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20240704141348.3947232-1-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/4/2024 3:13 PM, Oleksij Rempel wrote:
> Set proper MAC capabilities for port 4 on LAN9371 and LAN9372 switches with
> integrated 100BaseTX PHY.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

