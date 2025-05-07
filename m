Return-Path: <netdev+bounces-188565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0460BAAD662
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 08:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D864A7B0E9B
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 06:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75889207DEE;
	Wed,  7 May 2025 06:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGPdWvH7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59271A841B;
	Wed,  7 May 2025 06:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746600549; cv=none; b=AnDYLkSN/mpOUQNamn1QPWElh390ynn26fH6UvRW48/Wk0ySSCJ9j2z8xYE55tbxu+3FE7r5Br4bTR10nT5WGBDiUQDZds7HXUiXwaAbO3jXs3aDjKutYIaLvFCFpOJ04V+GAT5ACb25rQghxkVor20/DJdRK7Vjd1gA93agHq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746600549; c=relaxed/simple;
	bh=6od8uRrYSUaSVT/T+tLPe6mskPqnL0ygxd8bHislvc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u/StvSk5h4Ws93K7xfslYCkkAHx0If5kt8KSrwxOfGm419aD1vNa6uNS371gQQlpvJ3XuupQdVjNT6sDCVZ/DpWkynNE6Doys3yU1reLEykLEG6N4fetZ9SUxKxyvw6Uao0jH8tjVJNDDLyRaa3NeAukjPlFUs8K4Rqcod5z/5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gGPdWvH7; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a0ac853894so1293928f8f.3;
        Tue, 06 May 2025 23:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746600546; x=1747205346; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=V4QFzr6eQ8oGixp9WBtt+Tr7aRVU7Qo9dv0cC0uFmeE=;
        b=gGPdWvH7vFQd1XaMjUzWUQz/wOkmB3/vfd721nw4xeQfNv0IvHZz0YvgkG5IngFTWT
         Irx56IVGbouK66ag7UVcj65Ohe+FNYJa4xDvl4V61Xl2Dqznz6fLeCxKV7LrvFQD2uUC
         0KAuTV11OaA+6DsFQidF+lT+tTl20X8juR5+c6bGwIjjB7s3f6GMN7PCe+ZGZr+BL2h8
         Ax4nqPOkOMtIG8jZ3FWI22EncwAI5WUQS4BhLTjRbd2Vp7RmyY35JsX2jpCoeVsJuXnd
         yvnlaPyqlhwdY1r+WUJsN48QoQcNixC+zV1regHd6zS72xYGp0HglT6FhjDw5nsobQlg
         oeXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746600546; x=1747205346;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V4QFzr6eQ8oGixp9WBtt+Tr7aRVU7Qo9dv0cC0uFmeE=;
        b=ptUYciAEB+zQvreW4wYajnCcENrBKn8QdOAppyg+nqZjFwPvsFFc6dX083svekrTG7
         wDpRVAdMkIsqdQiwul5uuusK03Tx1KTxQWBguyCJI18xA+ZJErkBKOwqmTkWit6bQLrG
         4NWWAw1sfcKcoR6xzMD2dRAZ/y9KHLZAVCfMMsT4g+/FxlgvFlqJNMKek4HchFwWP6qX
         7i8/A9UqyxQz4CMkfPlMU4jjftlud/bTMjVhXCtDVG3XzWR+DFUyyMjlbfyvg/yFjrry
         dlVUFOv8Px5XJYSGXKCyQto9c85gAwCkCPdnHBzxxh8LG0JZFHsOrGuohTJC8DyzV5aO
         ZaNA==
X-Forwarded-Encrypted: i=1; AJvYcCX83tmNckJNX9724uZgVzNQcD6KSVvmEKxmgsWWxkPmLJOw43zM+DtakTFKSbMx2nPe2iC+FMvT@vger.kernel.org, AJvYcCXzu3x1pGhN7Hh+G5PuNHOofM1l/XDXeaZ4nDOfkP1717X1cmJD0PnP35S0HunP4N2xne0NkINDEECq8aY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3MqfZHNySFsk4ldzOxtnz9a72II7/xt+vfnOlAZKJK+Eq0ZYO
	s60NW/x22b4uQyy/zk2tEsO0Ki1h6O2wgZZ3BZLMyXrEKnv8gj8aDYY7mQ==
X-Gm-Gg: ASbGncvzeBwnVTC9v3mCug/qwR6VK5yMZG2H7B5nKsG1bHuJesQJc21LSH1UIZNEs9s
	1i4vU4qJREf/jMahLB5ggs0jL57M1m8kx6OT+R/Fi5+jBJ0dukuzo9ArWwfFVcVTPqD43TrrYQE
	ArJRCJsXh1YPghzn68BHUrm6veWyFfU4W+hl4CgTNQOnAO80nhHbvECm4hdZCaw4nIJJat07G+P
	Z9VtfxNaBhSvM/oPciwtdtmBkKgXJoRCKIAJcXbCAs2pipazsHUsU7UvqKOChxVbCo8cxLd3NjI
	Fsxzw/t1oCKCJ9BYNg2qUMTpLhCdLMOiVkYcvSf/gA6UZgEZz2ly/o9iAUTgWTPHB8EVtZi4960
	6bpPWdzG1aehpNk77c8/4SzdyJl7EheKcMa5e9hoQu6bksyFvz/93F0Vhn7kMrG7GODcZKOGGWm
	NNRiLJ
X-Google-Smtp-Source: AGHT+IHVAJgH6iNQUq/qq/5cZzhIodEMBNjNWVoukyiQk7rGtJ5lMYoopnbs9oYWc0sjDPqvb7hSQA==
X-Received: by 2002:a05:6000:40cc:b0:3a0:7a5d:bbfe with SMTP id ffacd0b85a97d-3a0b49f1a61mr1673464f8f.43.1746600545922;
        Tue, 06 May 2025 23:49:05 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f2d:8d00:bc1a:5f17:cc8a:49bf? (p200300ea8f2d8d00bc1a5f17cc8a49bf.dip0.t-ipconnect.de. [2003:ea:8f2d:8d00:bc1a:5f17:cc8a:49bf])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-441d43cb578sm20343005e9.3.2025.05.06.23.49.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 23:49:05 -0700 (PDT)
Message-ID: <a975df3f-45a7-426d-8e29-f3b3e2f3f9e7@gmail.com>
Date: Wed, 7 May 2025 08:49:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] regmap: remove MDIO support
To: Mark Brown <broonie@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, Sander Vanheule <sander@svanheule.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <c5452c26-f947-4b0c-928d-13ba8d133a43@gmail.com>
 <aBquZCvu4v1yoVWD@finisterre.sirena.org.uk>
 <59109ac3-808d-4d65-baf6-40199124db3b@gmail.com>
 <aBr70GkoQEpe0sOt@finisterre.sirena.org.uk>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <aBr70GkoQEpe0sOt@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07.05.2025 08:21, Mark Brown wrote:
> On Wed, May 07, 2025 at 08:09:27AM +0200, Heiner Kallweit wrote:
>> On 07.05.2025 02:50, Mark Brown wrote:
>>> On Tue, May 06, 2025 at 10:06:00PM +0200, Heiner Kallweit wrote:
> 
>>>> MDIO regmap support was added with 1f89d2fe1607 as only patch from a
>>>> series. The rest of the series wasn't applied. Therefore MDIO regmap
>>>> has never had a user.
> 
>>> Is it causing trouble, or is this just a cleanup?
> 
>> It's merely a cleanup. The only thing that otherwise would need
> 
> If it's not getting in the way I'd rather leave it there in case someone
> wants it, that way I don't need to get CCed into some other series
> again.
> 
Understood. On the other hand is has been sitting idle for 4 yrs now.

>> improvement is that REGMAP_MDIO selects MDIO_BUS w/o considering
>> the dependency of MDIO_BUS on MDIO_DEVICE. REGMAP_MDIO should
>> depend on MDIO_BUS.
> 
> Well, REGMAP_MDIO should be selected itself so none of these selects or
> dependencies would do anything anyway.


