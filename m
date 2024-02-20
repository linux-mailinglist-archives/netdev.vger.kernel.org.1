Return-Path: <netdev+bounces-73246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5E385B96A
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 11:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CCE9B21017
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 10:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF99626C6;
	Tue, 20 Feb 2024 10:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VsRA3HRR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BD4629F3
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 10:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708425896; cv=none; b=tq6UsK1yaFhdqMXTK07tVbVyUTCf/TO1Js9vbc2CZs+6jp/q0RF6CS8mxbHxeISxHxJT7a0XWceejRBBj51ZjqAQWwVxW+y3ZFVNjzEnhxFkZ0DIW3b+OjeitPtEnW3W00SnshEp3BSUaMgiAS/bvgIPukR2PJt0Yy1CHmewaUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708425896; c=relaxed/simple;
	bh=s/PV7qpElskRhq3eT3h1D21HJQdHFMmJsk5re13pDkk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=lL2rxcMF+5jrfg4bYJ1E105xI8FDeAR8pQRPp9+JesEKCeV/n98EVgiJdsvS1mG3GQS0KtW3fYnqAOuSn1AD5xvSG6VLqP4E5MlwjNXXT8skW+GvskDMbusT0sxSrjAmo6mY9IWsnk4/V3UlZh6upI8Sn1v/j4fPcWWspntbfpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VsRA3HRR; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4126d65ace3so4898265e9.3
        for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 02:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708425893; x=1709030693; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6EkMGp94bzxo7V76A298vKS1z4S2mO5MpTKzBFFfqeQ=;
        b=VsRA3HRRfF6+wD97Q32FmjJ8DnokYKhRfokMZHxRDTCqZXNhS4TYDAwBtMUZrREUEc
         sGH+2OsXk2ThHZ2bsokTSd35MazupLQYjYlmNaFSBbvOqXJx1LUvRxAYrHtDolRIHo0K
         owd/d81uGskcdGK/qTopghGoCI0BlOYOv9DynIlyJs0nxB2XNewpgdeaJFctVxYVSXdx
         RQ5tBjfp4os1mM1J/7Q8UiFSfbOh0EfD6BrF5nDvvClbOptPmiVDrJ5Dw4czQbMYYvei
         Yk0JFDNGQ58xj1AhCGSz0xIu5zkEHSHIWG17+udH5QFqaBTvxzksKiK+6lKldEJsrPXO
         4WwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708425893; x=1709030693;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6EkMGp94bzxo7V76A298vKS1z4S2mO5MpTKzBFFfqeQ=;
        b=qpumNLZyPzTCH4MLh8iQjLJYiXt+xjsqW3qlMCURC9GiuW363vC55/rKVWoPk2BtLN
         inII7mdYfZiU+TZuVP8wuQ1KwXvRRvz1/8xRiLB6BOMiKxp3RbcKDEZsFKRjFG1e1Ipj
         KkgndCM0eI6/epV1yn0tcQnIfOZIG+QtLPXWW6QFW6/KQV7sfe/ZspyUqhDkJUNhur5x
         bKD2DiYS2sAzP4SYOQfsXSqeLXtpESsui0b7hUYnjnHNzTOvzv2EBp8XQnhzyGaL+9an
         /91plJvuJ82Y9VBs3sNz8L0FoPJ7GQ7e9iryc5/xjRUUW2TS9yXmNSlWPkmgqjaXo5KW
         sFRA==
X-Gm-Message-State: AOJu0Ywp0ivBE9IHfipwiij/eMna5JVHlkvJxMxJeMLCEbS0pqLwap50
	zQ+04lgrifEgJuM0NYhTvCjbdB9I5WGkmtInkEaUByqzZJeiF+PeIQQuSKIA7S9f85oB
X-Google-Smtp-Source: AGHT+IEwtKIYQapcHoVxayzpONMz4pMQB2vP7/5vlbQN/PHP5hxeRCZGFpb6FSUH0IBUgFmBYC3ncw==
X-Received: by 2002:a05:600c:45d3:b0:410:2d72:63b3 with SMTP id s19-20020a05600c45d300b004102d7263b3mr10666453wmo.23.1708425893500;
        Tue, 20 Feb 2024 02:44:53 -0800 (PST)
Received: from [192.168.123.152] ([185.239.72.23])
        by smtp.gmail.com with ESMTPSA id s10-20020a05600c044a00b004122fbf9253sm13970788wmb.39.2024.02.20.02.44.52
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 02:44:53 -0800 (PST)
Message-ID: <a8824d0f-07d3-4cb1-9d0c-18e0f91919cd@gmail.com>
Date: Tue, 20 Feb 2024 10:44:51 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: John G <ijohnyyh@gmail.com>
Subject: Galaxy note 3 9005
To: netdev@vger.kernel.org
Content-Language: en-GB
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Manty, I am sorry if this is not the correct email address but it's 
the only one I have found.


I am using Crdroid on my Galaxy note 3, I believe you are the 
maintainer  however after any version update starting from 7.31 webview 
fails. Is there a fix for this or a work around?

I believe you are called Santiago García Mantiñán Nickname manty.


Best wishes John.


