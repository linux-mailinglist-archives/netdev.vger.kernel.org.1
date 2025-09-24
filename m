Return-Path: <netdev+bounces-226013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C8AB9AAF4
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 17:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F07E23BE4FD
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 15:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D839C30B522;
	Wed, 24 Sep 2025 15:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="yzaJmM62"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F8B155326
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 15:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758728002; cv=none; b=S5Gj4TTjEisaqIZrII8FF29k3qw4vkWQJQNJ90G4A9foBySp/liHzVEZ/9VEuclH0fsZrwZRQCD1V2BlTboa14YU3cLXaZzKOANDzF4SfCEZunlvIRVAIEnv557qlYvgNgr4RRwcfkymkvZwbqEo01rr3Gcjjq4W8zJKGnKxkDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758728002; c=relaxed/simple;
	bh=oj40lHJe2CXGo61XnScdHEqFvpXJOdvbt9aC6Rr03U8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jmBH5dYgMf2+l0iG6QDYbzxl7C/YI6Q2Egb1wyUClqmjs0+p+TZXN3zd4s9ghD5lcgz6t/pRGDQnUwvw7FBSA175bnUZoz2NKwF/zJL4MMCxGVe0NOuCRPu84+N56vTZtoQ3v9iZVjeAQV1tbAg45A4wiuEnOfWWyw3DXwBdfIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=yzaJmM62; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5821dec0408so963769e87.1
        for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 08:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1758727999; x=1759332799; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LIkBf3qivogFIYB3w/+L+S2G/9aj30PqRjDjHIQrDuQ=;
        b=yzaJmM62jiv9QSyXTAJV8YMaZYJPsQJnaZ8EQSGY6iVJcTB1Y6jck+O/vzR4fvBo23
         Lmys3K/s8KmivHQSc3Rks5UVyvtvFjJucSNig5Yek3vT8q+AByNaweeRdseBYBX+rrM3
         tCU9dkng65n4FlD3hyKvWXtaJRtAvO28kHEDlmALkb9zKk/MaFrfa2BshSPywPI0aDfs
         LyuYVJ4wsIzEoHJ6OlRUL5xTTnsDXlNWVPWSkDV0xYBnATj1E3jSdV5DRXA9uZA0uK6c
         TnXZi9rw8GV02Lip0YajFcviymIFM4XwxKPwr/Vvt7jrCJeRzAwg3LDsB/6FdTHOWHa1
         iD2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758727999; x=1759332799;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LIkBf3qivogFIYB3w/+L+S2G/9aj30PqRjDjHIQrDuQ=;
        b=C0Z9tdBaFZmI/3Nwd1+E7DwhSeeUSW/xkOAF4OS6H7wYwY7ZWJWDswM/Wc+5K9EDio
         N7jPbSP3f2QMAs9EzM5rGeCXr3u4iQFDqC1Fxqcq3VfDLqiaO5yilXkEwW08fugdNjZd
         eAne7O8TjJAjAvJm/kFoYBiLkO1fGPmZ3PzXyWAsn93JQHu0g5AfJKsXyDsZ3mY6QGhz
         1Gvr2JAGE5KKDZFsZRX0f4ltHDYF+nAMxZyujmAfh6VzVBORAXLqfWu+h77B6WgUn7iY
         UVp8DV7WC5fagSBFsxnoIeQIEwIyYm9kzNYpkMuN54N461rEHPyBXN/E1w1cBk4ow4nY
         yZ/A==
X-Gm-Message-State: AOJu0YyOj/bSCqxpAsT9xG/+80xr3GOqVLeTzCAsLOAqxTu5tFQfUEgh
	ZQOxfV71nPtSvefUmYQq8flS7vRKColHvqN/sTLK1X/9Yu+N1BsF28NmcDtw/+Rt1bY=
X-Gm-Gg: ASbGncuNS262UwrlJ7Q/mkXeG3BAKcPdtxGy1DjszpcQK7Ab4TqEFsu0jfSIDQPqPBL
	z83h6kl2oO3EJw7sIeUqfaJKFLkB3F/5rT1xhVGO34/W4wuvrc8Q1w4ec2UXT8afGelV6GxPhJZ
	KzdIySirYyPx7D4jyWHVFE1a/4W6HUJCTe6o9Gxwph8tq7wLGwgw2LZGD9aHQeSY+xKhwQ1+Ke3
	9cJlyhNx174zj8Zy4P+1YvwKlYWrCw1qGjzYhIyhswe/FkMCweIdxNyWmqGCq9zrVFct2Stp90Y
	11V774X2hYxnqFjhKdTMNaZFsod7aFBYzZs/duEkQMn45q7uhvIHuVLcFVoIvgFCXV8MnZl3peq
	/77iB3oibm0i5FBbvONK4f730sqgf/G4yldQtMrTEal/nWB+f
X-Google-Smtp-Source: AGHT+IH1GOx/pgpEVam+Qq+Qt3KSl//uKOXGpLYUqrQ7YkBLxLp90yiM5cgLCS5fXN5hydSO30VRWA==
X-Received: by 2002:a05:6512:a91:b0:57d:a4e9:5b00 with SMTP id 2adb3069b0e04-58072cf64e0mr1912058e87.30.1758727998821;
        Wed, 24 Sep 2025 08:33:18 -0700 (PDT)
Received: from ?IPV6:2a02:810a:b98:a000::9a07? ([2a02:810a:b98:a000::9a07])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-578a9f1419csm5120236e87.148.2025.09.24.08.33.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 08:33:18 -0700 (PDT)
Message-ID: <007fd561-70be-4960-9e74-06792be5818d@cogentembedded.com>
Date: Wed, 24 Sep 2025 17:33:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [net-next] net: renesas: rswitch: Remove unneeded
 semicolons
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Michael Dege <michael.dege@renesas.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <e6b57123f319c03b3f078981cb452be49e86253b.1758719832.git.geert+renesas@glider.be>
Content-Language: en-US, ru-RU
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
In-Reply-To: <e6b57123f319c03b3f078981cb452be49e86253b.1758719832.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> Semicolons after end of function braces are not needed, remove them.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>

