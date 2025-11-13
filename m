Return-Path: <netdev+bounces-238529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 554BBC5A831
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 00:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6214A3AE978
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 23:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE56328622;
	Thu, 13 Nov 2025 23:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzu/2UyX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA86A328608
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 23:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763075915; cv=none; b=mB+eav3WUOI/qvkQFyyX4wbVFgES8CwEyYqzBaZh3gAYCf93O6a0rm9avbY+O0uarYj5JurTeNex1b/oGYuU1DlGoGYHYC93SDFP9PvgvEde6ZgqVMCW5bES9tASqsnV9d79kSfFhfwiPO8Nn/plpuieQPlb4u9hrS9iyt/lCHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763075915; c=relaxed/simple;
	bh=MHKO0LuYkwgQG08kcxnR45HkZ1E4snqVlozKGhkbUEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QDBzSPV6B2KRCgiRTICaf3xfkFgZ9c+c6EYnwB0gM6syyOpwm7YTXDp6d9XPSTLkUXoA8kgbLildeIjxep2DH9jwbxDnO6rkVmIH8A8RxJgRzq8L1bBBOxTjnIICVw1ILzxGJFgaGtLhNDoSN0bq6uZdqNiSabBIUG/cFqqR4bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kzu/2UyX; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7acd9a03ba9so1136781b3a.1
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 15:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763075911; x=1763680711; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JqxHSWJwh9CDjb4VTHqcw2rRdk1CxzwDECQB2jam6Gs=;
        b=kzu/2UyXgKDSH4O7S2mF+c9ov5WtoxL3p1gj4Y/wPvv/8Paben7QYfalZbxrRQg/KA
         y4EaQipxxs6tkWe/WvLZJCkNn+mxHSz4HGHCohza0HqIKi/7qYVnpykYJCSkiZki2S7e
         54034dJ2I0HQ+4QPUSInOjFRKGrt8pcsLcCUPnUZleJ44ir+XhXNV7uAafOedRXISsqF
         JuT/rKsH58WKA5uu79ABpqTZ/CjwlZ0Qv9XI60QS6BbLaji8gptDgRQ8nna/3oV/c1a1
         aBnQ2Jleoe6Ysm+ja/z0RRYOPHy/P1nzygjB3/GsvORaoaaUfbpae38TXGS3d+jf/3Ld
         dU2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763075911; x=1763680711;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JqxHSWJwh9CDjb4VTHqcw2rRdk1CxzwDECQB2jam6Gs=;
        b=vb2yvGKWFvcxTX1yq4/zrqLzR5Iv4Gcjtw3p4ZLXB2wZr//ktLCD5YtmiYtZXKK/0p
         6AerLfgZFFW850yx2f0TiGHsABscPQ20LXjcGlcAzCFTC/ZrSu501GHuTwZfCf+ZIIp9
         LvB1z9ak9sCc07baIAzIdsjHD3pgkjYBGoMzXAl77YRlauUbRwuVTIt9bXqjTrjeyXHb
         bmRZtS8aFI65qBoDyDZyKRJEEnr47KR8MYBErq0f12H+m9KNuNVP2zUEg7KtbVQSn2qS
         Cw70muM7FNFVhf4Dn+lCQrYTis/H7+BZe78nBSbPKLDDlZzpI5saiGak870wzljA4vHv
         Hqmw==
X-Gm-Message-State: AOJu0YxiZgUVD09CxN2igGfmU+0K6rrBrA3+o0nfkxWXnY2voZv/w2NH
	BEexi0FhAdT+Z3JdGp81zvqfJB9+vj9ndOX1QNcskzdud7qVl1sJlw5R
X-Gm-Gg: ASbGnctsVByu/P8rg9TyunBXP2fxw3IEW5RNvF0LNIXeMA8ZC6iSOBJI/xRVGbCYINz
	nWyCh0+wMy8mz2uhfIj70LXe3FHzYkjDoAiEcJLuPmhRMEw2tNkRpQLaVoQ61ZrvWt7aoLakn/x
	aRIXHulGZWQgSZ7HWuTcJgfksgYZ9dbKN5ukpxYk45hf/uucduxz0Q4iCkhxNU93crzlol1OvRm
	XmYlpSmAqD3rQ/v+Ggh+K64ky3lE+BaZ2rrBlIS17VmLK9ATpFMNevAJkR5NxmVnJAUf0YZb5K1
	vudDkOOeEUGicq8JuPET70YmcCNMivWBTqYgrpa+khG1HR952UAavQLRB1pFgAR6gz9yD39oVSt
	SLtIgFh7RxNr9tJI2mEfYgtnqvD2N9HfSGzD1jsRTfOvTIvnXRwmbEPLlSJ/QG45Zx7tlNS2JCy
	TGz5s+x5qEw2YEn40DxMyx5Z1X33Bw9NI6gXHBfG3+rEPRzESe559fU5aG5Q==
X-Google-Smtp-Source: AGHT+IEQwGTvzdxqueYQ7ZxwR+VwJWgC9inc87W7wIjhNC6b8Gq6/Q5GoOgqUVdaggkmUxHv8fh/yw==
X-Received: by 2002:a05:6a20:7d9f:b0:33d:7c76:5d68 with SMTP id adf61e73a8af0-35ba209f574mr1514067637.46.1763075911213;
        Thu, 13 Nov 2025 15:18:31 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1151:15:c56:221b:35d5:85f? ([2620:10d:c090:500::5:6ae8])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc36db25bfbsm3240711a12.1.2025.11.13.15.18.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 15:18:30 -0800 (PST)
Message-ID: <cc4cea32-e8d4-4fb4-81f8-121b47209c1f@gmail.com>
Date: Thu, 13 Nov 2025 15:18:29 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] eth: fbnic: Configure RDE settings for pause
 frame
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, almasrymina@google.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, kernel-team@meta.com, kuba@kernel.org,
 linux-kernel@vger.kernel.org, linux@armlinux.org.uk, pabeni@redhat.com,
 rmk+kernel@armlinux.org.uk
References: <20251112180427.2904990-1-mohsin.bashr@gmail.com>
 <289f4375-c569-44ca-86cb-18b48d17c9c3@lunn.ch>
Content-Language: en-US
From: Mohsin Bashir <mohsin.bashr@gmail.com>
In-Reply-To: <289f4375-c569-44ca-86cb-18b48d17c9c3@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> You should store this away in mac_link_up. Pause can be negotiated. It
> could be the link partner does not want pause, does not support pause.
> When phylink calls .mac_link_up this has all been determined and you
> then know how to setup the hardware. Here is too early.
> 
> 	Andrew

Agreed. Even though fbnic currently does not support autoneg, moving 
this to .mac_link_up is the right approach. Thanks for the feedback.

