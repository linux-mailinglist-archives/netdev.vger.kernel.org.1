Return-Path: <netdev+bounces-153616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B24F79F8DBB
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 09:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B794F18930FD
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 08:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3461A0BD7;
	Fri, 20 Dec 2024 08:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="rxDamQGY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD0C1A0726
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 08:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734682179; cv=none; b=NfiotJEb1F0nMUdDpc+rvZ8o2i98na6Bjh4snAC9BjRnRvd2HwxIqQ8aje8Sq48GLkULRRwzYqZ6yvxZNtBiwKJUbysSDGFUk+yg/HpamMADz6KFuPxy5nJs4Ma9ibA9BcyECSVGDATXcbVVrs4u4O0BFltDI9IwABOL6TykMx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734682179; c=relaxed/simple;
	bh=RZGLnoL48vAfpOS6MUjRxghvSaxCzIP33faA7KSTB48=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ok74lhpTE81Jls99S2stIWotkAxYKDUEuVyZ17JPt3z3INkucgABlWFu5Em1vxB0b0R2sfL8orUW6dKbtclcYuy9yaLOdQWzpPatDrCBsYXx2f0GY2X54j0mTBiGmfAttXv+1Y2NfhFFCv2ny3NlglwesCMm1fgyDjzR5dr/cpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=rxDamQGY; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5401b7f7141so1323885e87.1
        for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 00:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1734682176; x=1735286976; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QF6UIXiEkHZmXmCHoNP/5n9jgMJUTxHNacJ4sboJOKQ=;
        b=rxDamQGYKGbdHhDUbXzBaxDcQWqBp3kKy1zSvmUtYoKfbVxEOp32S3EuaYpKnu2Qji
         tWzg7YxZui37wLjz+nQp0o+AimwT8cqLNAoIgN9JGewGLfrEco0H9QSvjKmyt8UgHtD7
         uMtDGm+1HLoSJWYzekl+Vrx1H26Xie05uI1bfcUaKyAB67zRomlIw+VPOSQBaImi0qFq
         L/BIo/Cy4wQMxHWo3S0DXrxqs5KM7q0b9zP0qSfHDiWXkVGEQsk7Vq1OEf9ONY6ClR1R
         s6HerZ4tZ59+KX8BGsr4zbON4Bzn/TdbNOPm6MmK4EioJ2iagCaDznksKBglLGMtmgMw
         F8lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734682176; x=1735286976;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QF6UIXiEkHZmXmCHoNP/5n9jgMJUTxHNacJ4sboJOKQ=;
        b=dmzdLEiA+nfufZUIW1f61bPXSGvR1+UfbooRFH9m1I5ZXd/sQTl7Kln79z/148n5zt
         T/OoibnT9Fy7LAdMQf987vOtse2X3hjTbhBrjqWIBUJazWYjbuhpcDveK3oyk5bt/GuP
         U1B39m2j1k70Xx5uYQPbjx9ZvbF8acyq1Wbz6lHeIQr8N+Smhw56WkVANiuk1UvIYqcm
         zoUSWs/TuTWSrbJ28ggijXQ1gck0nFV1U1YG4E3kqLUI9/KKxR8sQQP41a0GyI3groMw
         dM0Yxk4kJQpzh781LvftF6cozh5ZoL3Smf/oOpxxRAmawG/6PqG1vRsZwuSH83FjpnI/
         AiHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzeuPcoObpMTwf18vExiNSkbL/yASDLbVF4B2r2YWswnRPdap1mj8L1JYyRrVOASU5dZxP+Gs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfba4i3xJbpVelyIEXu3qQDRMvgx1OabifaOFrqydbiM3bm5U1
	aeghrZVXoMhMxDbkOEJqf0oQIbJBNdujqwVf9RoWMrS9hs7qD9JKbns1UpQ4DZs=
X-Gm-Gg: ASbGncs4DojSYFU/NLqRp0EX45ExvnSkdWWCet82vGP6nZ72PY1YbYDKYTxR9tAJCLn
	L81WvaHebx+ajvhTnOH9eRozPi3IRdUsCznVlXeGZXPjQEoyIGhfK9PgXsQo4LdxUaXR9BcfSWl
	3YqWma32OEH6FmJFAmYMLCHPMa+ATjg0MwBvL3eay1tcwgYDAZK6hdPzWeRLV0D67qPEjL2ALlU
	anBo8r0VYW4qd4iCGEzLigCMD+H97AP/zvQOminBOJTVXhyh2KA0CDnnOaFgBFsCj8ZPyDAP1g4
X-Google-Smtp-Source: AGHT+IFwM9giffUHrEP/MTz0pVObL+nMy8Xk6RiX3KQ+DCpfdFx5uhdfpy/4qHCmQMHFdCluSPPBOQ==
X-Received: by 2002:a05:6512:1387:b0:53e:3804:57ae with SMTP id 2adb3069b0e04-5422957ac55mr661172e87.51.1734682175720;
        Fri, 20 Dec 2024 00:09:35 -0800 (PST)
Received: from [192.168.0.104] ([91.198.101.25])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-542235fee84sm419634e87.69.2024.12.20.00.09.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2024 00:09:35 -0800 (PST)
Message-ID: <7b009b7f-0406-4dc1-80b3-79927d6143f0@cogentembedded.com>
Date: Fri, 20 Dec 2024 13:09:27 +0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net: renesas: rswitch: use per-port irq
 handlers
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, netdev@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Michael Dege <michael.dege@renesas.com>,
 Christian Mardmoeller <christian.mardmoeller@renesas.com>,
 Dennis Ostermann <dennis.ostermann@renesas.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>
References: <20241220041659.2985492-1-nikita.yoush@cogentembedded.com>
 <20241220041659.2985492-2-nikita.yoush@cogentembedded.com>
 <CAMuHMdXV-2bdU9Cmk_VHTJ=M3Afg5aTfY=_k=p6v1igzpV5kBA@mail.gmail.com>
Content-Language: en-US, ru-RU
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
In-Reply-To: <CAMuHMdXV-2bdU9Cmk_VHTJ=M3Afg5aTfY=_k=p6v1igzpV5kBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> But it is not required to use the same interrupt for all ports - GWCA
>> provides 8 data interrupts and allows arbitrary per-queue assignment
>> of those. Support that by reading interrupt index for each port from
>> optional 'irq-index' device tree property.
> 
> Sorry, but I can't find where this property is documented?

I will add this.

Nikita

