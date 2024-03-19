Return-Path: <netdev+bounces-80575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 901FA87FD9C
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 13:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B42BB1C22333
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 12:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFD45474B;
	Tue, 19 Mar 2024 12:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KYbBmJma"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E188C38398
	for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 12:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710851512; cv=none; b=FtN6YKvJYZvck08i55gDLwnOJjNSqiRRZzrmOK+lHrXpIWjUhI2xryLi1wUq4+1TJ8P5eg0lWkIvAKfkFdwLGNlla4Ok9Rgivikh8HPeeD4JpoWQOp4RnrInQzANKzOSgkzYXL+WJtF8DiMkkHnyZjDBMaZMGiSXcz/8QJ0YSeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710851512; c=relaxed/simple;
	bh=aUx48zrKCU0t82c5nuqGikm2QyAaCGYwVpEQjOvkHwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cLDsHr4dDeyVxlTyEvY+sR8F046j4IEKC+k9SF4IVGfieCH7gH1d71iQyQKjTgsyyc4hmEcNgBitXyK+eeSHNxoUZEzTPfneGUasWom5A2btf0p/a3BpnRIscaJRK2d7P9sWjqDWPBQzz80DxIF65gSgoTP7/qX5PkXD5ERgbXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KYbBmJma; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1dca3951ad9so35835235ad.3
        for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 05:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710851510; x=1711456310; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QxN5l6ceE50Lgv4vm7uUVT+0yFV3t20huG/NVIeOXAo=;
        b=KYbBmJma0o0ZFXA1/VlvMs+Kv00983jclD6aq3FklEQcA7XAh9znnxSKOGh0cyd8G0
         retRWAcgZSjWT/stuGC2P9RTXPsWK9P1sMhJ9sRX4MWr5O2rbS2+YnAtY+pt3dfqJv/T
         jhyWKyWrrba6K+w93JAUFIIsXHK7AMd0mvYulKGGBS4v33gvb76m3osqTbd2kQqWZSug
         w8mDYWhBgZo313sT89ctWk6VNpXM3wzG9SdlBMsSmXO/pR599wp3IkyLLyaw2KGNe+Ni
         p8zNF+ioE5wdcTYRvXufk9kW7wlQ++CrXm3mcPNG7gQNDu2I1q5igTc0QKaXdMGbmW0b
         SZow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710851510; x=1711456310;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QxN5l6ceE50Lgv4vm7uUVT+0yFV3t20huG/NVIeOXAo=;
        b=YBuzEAnSYoUUxtq2V2LDZPngR9r140oRPq7IOI5w6w1j1v/yqDLvNg26O4KGLV3K7T
         dl5IgcFeuxCiM3R/s6d2CkJ1HddClbgSae8bHIQAL0wDF+YMUhWY1rY8UNb+oVlKir+S
         zeMAurnpfnKWkxvC9UNLsoApenNymeEqAx6VgivqDa3/hm27skmH7owiBZAC7iHX1uWU
         FbahhoVyvv+gxgoa7VQ1usA2z9HR2jOz/y7DhklcRBTWK7PjRcdatgluVVEIfuQEwMF5
         JcbSRw3ro00XeSRuPn8/FU7lKSggv2nLQIAaWNJhVnstkuRTHpxb2hzjfc0474vUNW2R
         j/Ng==
X-Forwarded-Encrypted: i=1; AJvYcCXSjbSoHjDDFGnjgqfLSdvEkg6geDMUFdHxA3awhVVD+BK9lrmQreMnKmGzg9Li3V4bJm49En/Znm9YfzHUDVlPni953HRq
X-Gm-Message-State: AOJu0Yy3RsiEm64ocHwWSAkkcjOQB8jCGoydkxS83B6pWmRgwO2d5MGR
	WVrdceReQkaeDeu+ZguBGDlEM4R7Dtfp82Z9bE8DvpFnmpTZw/r2
X-Google-Smtp-Source: AGHT+IGfkIptzNxGpOQkMF608I3+fhF5sC+G45TeMxLU2AwYPTmhDb/qpo61hXmN/MQE062uHfy7oA==
X-Received: by 2002:a17:902:e94f:b0:1dc:7bc:d025 with SMTP id b15-20020a170902e94f00b001dc07bcd025mr3275088pll.4.1710851510014;
        Tue, 19 Mar 2024 05:31:50 -0700 (PDT)
Received: from [10.230.29.214] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id h20-20020a170902f7d400b001e0410bfcd5sm1701998plw.192.2024.03.19.05.31.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 05:31:49 -0700 (PDT)
Message-ID: <522c63b5-1db0-4e18-9cf3-83bfeadf8c36@gmail.com>
Date: Tue, 19 Mar 2024 05:31:46 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: phy: don't resume device not in use
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>, Paolo Abeni <pabeni@redhat.com>
Cc: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
References: <AM9PR04MB8506772CFCC05CE71C383A6AE2202@AM9PR04MB8506.eurprd04.prod.outlook.com>
 <c5238a4e-b4b1-484a-87f3-ea942b6aa04a@lunn.ch>
 <AM9PR04MB8506A1FC6679E96B34F21E94E2202@AM9PR04MB8506.eurprd04.prod.outlook.com>
 <AM9PR04MB8506791F9A2A1EF4B33AAAF4E2282@AM9PR04MB8506.eurprd04.prod.outlook.com>
 <5a27414c77ae0b0fc94981354fa6931031b3d6fc.camel@redhat.com>
 <f6f62bef-5766-4fe1-a6f1-6f18d627737e@lunn.ch>
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <f6f62bef-5766-4fe1-a6f1-6f18d627737e@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/19/2024 5:05 AM, Andrew Lunn wrote:
>> Please note that the 'net-next' tree is closed for the merge window.
>> You will have to repost in when the tree will re-open in a week or so.
>>
>> However this change could be suitable for the 'net' tree, if Andrew
>> agrees. If, please re-sent targeting such tree and including a
>> reasonable 'Fixes' tag.
> 
> This is the sort of change that i think it should only be in net-next.
> Suspend/resume is complex and not tested too well. There is a chance
> of regression with this change. So we should introduce it slowly.

Totally agree.
-- 
Florian

