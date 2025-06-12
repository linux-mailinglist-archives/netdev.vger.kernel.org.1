Return-Path: <netdev+bounces-196896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 573AAAD6DB2
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 12:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E806B7A2F38
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 10:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932AD22423F;
	Thu, 12 Jun 2025 10:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="bQ3PZtPe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75D713C8E8
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 10:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749724163; cv=none; b=VmtdDIi8uLszSQ7ITceo80iOolmatuyTUWZjt8GWxNGS08sbKSkT6BYDPc8Zzp+ga/xgD3lBcyYUEqwtnk5ZLT6V+RFfp83Wy/3xotHVQHkuAAmj2+RbUaD5Mhow3NPYT54PZDxckZP4stp/RYo5T8QiswtpfocpD2GreGjK4XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749724163; c=relaxed/simple;
	bh=0zbMb3mFPp+ip+e4nKz08nM+1ytpVTZI84ga5mCht6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MItuAp7noUx7e5VfgEK8vFT0j+C+hwY4zLhMmD9yaoN1YjH45XMhXTLAvlwuRCtpqqwIh/rHOdSipmj7vUenStRmOVMHbG694kTURfM2QF6eUCylBQJXiB2I578BVwzmCIRiYSlhnAoBSrxnuq3as7toAzFzTKn4oFA7fggxgP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=bQ3PZtPe; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5534edc646dso837110e87.1
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 03:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1749724160; x=1750328960; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=78ceVZR5qaXY3MZm4XZpT6VKseBIJsVBY+CKmbmNT7U=;
        b=bQ3PZtPe4XKfNA4stGhL/oDHgPggNd+TQdJk3vdrM+LZQlV9OpvWICXLMdFeVVoUxO
         EPy3uwdU0Mx4ZzQYtH1zvA7cQBUFVPf1Lte7qzl8a8bqaMqyWcgfbM0jaYB8XiiXILNm
         DJJV/pTVDuuuY6gVFDMDG79aYOnJwlxjgkCwW86LpN99JtTMfH39cmJ/Jp4xhShWijOn
         xjvVoQUf1gKj1MCg6SD9sLNMZCcdd5ryisl+pqcpp+bBQHT3kra7aCkX9RiLM2Ybjuhu
         IrKDFKZFe9Pkc3VvzIFklP9+OAGavaL9YEQQy4JYIi8jAis07PBTwLrHlVUSC+QIdhQ9
         MRXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749724160; x=1750328960;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=78ceVZR5qaXY3MZm4XZpT6VKseBIJsVBY+CKmbmNT7U=;
        b=R8ayW1Rz2Ubk6/CPyxSjfjV21o4IPd0VwW2DXG29Z7/6mbymDjr7WH3SFuUQ3VbGO/
         VmNAYlLnU5/Wi62wC9KBjlCB+mm+ZODvhRmqBJvtrBN/dtfyDFJ3d1WIwCUc7SBuD2cP
         flYXQ7e4HGrXPLmQ1zR9W8xFzFQTUgTlYm6eemaWBgKyC56E5LwtKmxqOLG4XayLeAN4
         3BC5v/gKBpWlt28WAiu7LSK/fkdLbW7I0xokCHrW75eeZDR2t4tdDA92mKhL0eda5q3f
         tysii7q+xm51siLzZfSPsFiHHvcOYrWVHzmtZcPjHzuXiWdTJsx0Rr4gv0X1NP6+bi6S
         uzjw==
X-Forwarded-Encrypted: i=1; AJvYcCVIacahBSNbqpLr2DZUseZ9epBxQdqdAI+QBjKZCrroklesIH5VJd4MkNZPw1yaIWK/MF0WYb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKkl1DpOwgyI6sdF6+a1ekdXIHoCmKR1Yuk0JzbuKdEx+jLpz3
	o/xeU7ED6/AckhTpg1Tgk6OPCgKtdAYhUSI4BGSgTLWt6r73BGyUGwNq9UN1rt4/VMQ=
X-Gm-Gg: ASbGnctZ2xpWzIqsj7yIiNn2UbzP3ADIGatRLB+5MdjFGRBs1NcZPZNxqKTZlN4LtIP
	wPbXtT6OmFqta2CZigEI7ZTZzIisY5+v69q/qYWkmHFQNHcuE4c48AC4ObvKncBBGbC3jqcUFvb
	6Xlfs7j9JoSw2+7yTZrXw+P22ww8vgJc9R9KVuPXusKI3BQd+nn6D8vIBv8G38yDgvjnK5iKH0K
	/x336mkql9uUXFsIiA4UnaYt9TY6foGoCZzZvYzNKRWykmnJ56XnNt/YduQl5JLE22aGULi3w+0
	pD0PxScK6v9JlGwd8KDi6VtEhFQ/wjaOU9F6uwTHlkWBNuyeC/mFewrtb6HUd5cGndntpAZ1ehK
	oRaoi9NHvfNMykPbwh0rm75jCzKrRfsA=
X-Google-Smtp-Source: AGHT+IFJ/9dux+ndVTq3aJpz16CRTCPiC1oUqRJ7BjCIgJGYT6DD5N2Sk4rAdRc0Ka1X4BQUMT1TTg==
X-Received: by 2002:a05:6512:3a85:b0:553:3665:366d with SMTP id 2adb3069b0e04-553a54da132mr731269e87.21.1749724160010;
        Thu, 12 Jun 2025 03:29:20 -0700 (PDT)
Received: from [100.115.92.205] (176.111.185.210.kyiv.nat.volia.net. [176.111.185.210])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553ac11687asm67813e87.30.2025.06.12.03.29.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 03:29:19 -0700 (PDT)
Message-ID: <3f6a736c-a8d0-4524-93fe-fde5162d76d6@blackwall.org>
Date: Thu, 12 Jun 2025 13:29:18 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 03/14] net: ipv4: ipmr: Split ipmr_queue_xmit()
 in two
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@gmail.com>,
 netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 mlxsw@nvidia.com
References: <cover.1749499963.git.petrm@nvidia.com>
 <9667e583c46288b5dd1367ad5e1d75d1e438db81.1749499963.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <9667e583c46288b5dd1367ad5e1d75d1e438db81.1749499963.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/9/25 23:50, Petr Machata wrote:
> Some of the work of ipmr_queue_xmit() is specific to IPMR forwarding, and
> should not take place on the output path. In order to allow reuse of the
> common parts, split the function into two: the ipmr_prepare_xmit() helper
> that takes care of the common bits, and the ipmr_queue_fwd_xmit(), which
> invokes the former and encapsulates the whole forwarding algorithm.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> ---
>   net/ipv4/ipmr.c | 45 +++++++++++++++++++++++++++++----------------
>   1 file changed, 29 insertions(+), 16 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


