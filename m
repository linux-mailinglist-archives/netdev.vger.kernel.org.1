Return-Path: <netdev+bounces-124657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D886B96A651
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 20:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E1221F242B0
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 18:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F07F18B49C;
	Tue,  3 Sep 2024 18:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CGvqQHMs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA07A18BB89
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 18:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725387597; cv=none; b=XP/DOdbf9fUGx9DZ06UajjkPp2ywLpz8mH2TfTOzfcWtXBTq0954HESs8oEGB5elui+kLI5qCW95yiXPkl+7MiTrx1lFzEwy0ar5NMcxYN2PB60sFhVNGCLylUNZmLn/OYxstDw2gQPypYO36fCzVa2DcyWIqCkMXmXkGP/4zak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725387597; c=relaxed/simple;
	bh=XnysRGbK2ZdFqT6ZSELr1k8KXCy/vzYm5JnvMTvLI0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e/a90++bLrHEtQamQ4K85rcNEQNQ9OeT75pZkF1D7ddXeWVOdcF/WeEtEwZtLSBEGTqEh8oQRgI46VzYZL/WT6IxA+BRBsnvUg9d8mGXOPug6teO2TtniVX5KQyZ4BGFH1Pu80It5mHhQYSO+mfBE2nFdejBK5u74zZvX+wNYrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CGvqQHMs; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53349ee42a9so7627231e87.3
        for <netdev@vger.kernel.org>; Tue, 03 Sep 2024 11:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725387594; x=1725992394; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XnysRGbK2ZdFqT6ZSELr1k8KXCy/vzYm5JnvMTvLI0I=;
        b=CGvqQHMs2GvNPOQqm8YpMB06SvS58ep8NFZ+lDrf+8NUHx8m3oqMPeC2XMKfHY5sBA
         B66wfOlX+f9yCWOCvkxtgSiyAbCQL+sD4Z7pgucn3PwxN77Y+xu/SIxorsbaBdHUTrox
         8Ah1YGYI6Rbp5OsuiYgNxDUb/0nmxwJJp7gaSr5wO2kIhc311DD8t9WVEZw0Zcf43wJM
         utn58O7G8R6asRC/8WOP8UoD/5AJYSlhZJZYpxxfViq5fn7z3H59pOALZEk069a+vJxc
         gQrlKbaq9Ph7pWHs/cIzYVAaZMld2UQNYAFltwn/EDFrP51SufJ/z/nzXXsWPDFC0Kn8
         nrUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725387594; x=1725992394;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XnysRGbK2ZdFqT6ZSELr1k8KXCy/vzYm5JnvMTvLI0I=;
        b=L58zz4IBn9l2vSy1Q+MlQTGdJ9+MgVb7YNu/slwozP6J4+5c8BYlr4Qh4+UCBuzOvi
         0FZZZrQDKbmc4v2pHJOcoJPl5+4ECaWvV2wwMrxOUgNP3SGK8SCEJVWIihZroNtFeM+y
         JTDyTcmV3RpxiZBwyvp6SjyRSsFvnC6hQz5nM8vt+s3YOL8VlUxHc8fbm6XsYpD8+ZJJ
         /Me02/qxKCo5bVQ8RSuK2IEt2mVNI68JCg8Vq+SBUGiJc0Ur2oiSW3qndEEwD2bmlyuW
         4M57aW9Sz+pRlyjWrwRCn8fEn0I/VCnKz2A4h4dHwtHemvzI2gGyV1kbucSH8kQJZlUT
         ZbKw==
X-Forwarded-Encrypted: i=1; AJvYcCWxj4AZimTWWJ2m7crnMs+/1vYpJ41Z0uwN/jQzw0KMoCf4RXCMXXvIGHexrSLlpAlisZf5g0U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3CYODzcocQ8EhROD8wx7io8A92xByrrCk5+mauREI8aZWnSD2
	nAA+eAgNpN0WqssfCraOsXJDTm4PyaqX+/K0Dx63F9rFgfClZlsUANwvfacjHWgUw7TMMME00dJ
	KxqOmLdeNTn+TK47MVrRqIhPdidUxNmRrn6NX
X-Google-Smtp-Source: AGHT+IEcAdYTYFahTB9vEZLSGkWvx1t5jrbvK3aMr7ih/o73SqQqMsAoOzvLekpUEpO4yGG/WOJRxawcFxaPbM+eHeA=
X-Received: by 2002:a05:6512:1286:b0:52e:fdeb:9381 with SMTP id
 2adb3069b0e04-53546bab3b0mr9057868e87.43.1725387592997; Tue, 03 Sep 2024
 11:19:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822200252.472298-1-wangfe@google.com> <Zs62fyjudeEJvJsQ@gauss3.secunet.de>
 <20240831173934.GC4000@unreal> <ZtVs2KwxY8VkvoEr@gauss3.secunet.de> <20240902094452.GE4026@unreal>
In-Reply-To: <20240902094452.GE4026@unreal>
From: Feng Wang <wangfe@google.com>
Date: Tue, 3 Sep 2024 11:19:41 -0700
Message-ID: <CADsK2K9_MVnMp+_SQmjweUoX1Hpnyquc1nW+qh2DDVUqPpEw8w@mail.gmail.com>
Subject: Re: [PATCH] xfrm: add SA information to the offloaded packet
To: Leon Romanovsky <leon@kernel.org>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org, 
	antony.antony@secunet.com
Content-Type: text/plain; charset="UTF-8"

This patch simply assigns a value to a field, replicating existing
crypto offload behavior - it's working/tested in that mode. Many
instances within the kernel code utilize this information in different
cases, making the implementation pretty simple and safe.

Hi Leon,

"It is not specific to mlx5, but to all HW offload drivers. They should
implement both policy and SA offloading. It is violation of current mailing
list deign to do not offload policy. If you offload both policy and SA, you
won't need if_id at all."

Could you please clarify why the if_id is unnecessary in scenarios
with hardware offload?

For instance, imagine I have two tunnel sessions sharing the same
source and destination addresses. One tunnel utilizes xfrm ID 1, while
the other uses xfrm ID 2. If a packet is sent out via xfrm ID 1 and
lacks any specific markings, how does the hardware offload determine
that this packet belongs to xfrm ID 1 and not xfrm ID 2? This
distinction is crucial for the hardware to locate the correct
encryption information and encrypt the packet accordingly.

Thanks for your help.

Feng

