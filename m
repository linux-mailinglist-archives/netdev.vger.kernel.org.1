Return-Path: <netdev+bounces-155737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 434B6A0380D
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 07:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 369501647F2
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 06:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C16A1AAA10;
	Tue,  7 Jan 2025 06:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ipSSQurJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B9F157493;
	Tue,  7 Jan 2025 06:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736231891; cv=none; b=MVp/gxfkuxfywuAMSFK5d23vfbW+9XirTq8GAty/VILkWLR77ApOv964awza1EoDSwAIM68OVoDlp+iUsLK9S1r78siz0QzbOnJYYvXxgjHZRUKNK/9mdHPOB62yCTT42XXy1n9Dky09F1TU16kFH52iObCimDdpla2Z/LGlUCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736231891; c=relaxed/simple;
	bh=METGOcRyFp3faRSSBkC6QzjEDC1ls9uLiI4yCaQfXFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o4jzqDGOlGx+xxUJmZL375V0r2zqe5xzjvIIj8kqEcYjpIBn2hDPT8LUxQpmUNOleenP9tPSzxXdmMztC9eb/GoHEBSCCFbe/8NAClSP5No0IvNxrAUfZ9KvY2/P96sGyPnGSPsSfIEE9r+TqDH14N5oSUEHj+eInyPvpy1UmCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ipSSQurJ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2164b662090so193944615ad.1;
        Mon, 06 Jan 2025 22:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736231890; x=1736836690; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=orCDsDNFA6uclIQ3/usGvXWL2lE5OsemzFx60WJJZsA=;
        b=ipSSQurJrrF5kB2fnRcF7zXalX8Z+9qwoJDihfnJ6Umvn4vDRiDbRbnXe4K8RQrlHb
         SZrW8CUvALjHPQN2zAsN8yWtx4VIDDYyXom783Cs/0egr0+KxP7O1UDta1VB5grIH/Sv
         +SHnFYXOZ0DRLnrFY+UDPi25aIYo1CCcqBizryDV90EJqwnv6U9QElza/YDWb/WM658z
         qs+jAUQyJLllPBCjHvEFcq9yj5pxyMi3VrJf2lx6tnrlIriaEcWLWfjj8ykMADdoleRV
         6RdgA1IlBjj832ixZNHOVpllPvW9egADA3Q6u4bjFutib82/V5/JjlJmabRkL1ZEley5
         ljnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736231890; x=1736836690;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=orCDsDNFA6uclIQ3/usGvXWL2lE5OsemzFx60WJJZsA=;
        b=PBmQzQL/uw0ToYSM2aE1bdBI6RL6DZVmv11YnmgcrzD5rcWpRWd3cDVJ9cms9Nmz4s
         rCIB+I2FoBwiXGujQVANS5sUb5rDfTPreQOG/RgekP9WB7hSURDspBxyM6HHzGhBNI9o
         c7NZNpSs1Noqx7wR9bTmeX5Zzrr++m5UWef8p1XPmUHXRYTgEWoefYmMP8Bop0hSthkg
         Wi46NMY7j2sDbFBCbZ+rF/bxLP+/v+1JvCnvFoSa7uh7Bvny4vvpyKK281ZPHCJ+CZ2/
         fFE4HOCxjVf53H8RIntCATPG1fX67IHxyNAjazac4VRr5nlPAzw1b+0Qrq3LFcgAALSp
         StCg==
X-Forwarded-Encrypted: i=1; AJvYcCXT/wYjHsCSrtSUdgQK58wyDl5PMAqCWRdAOUobFnU+g5hN1I9XjICw2XSN3/jnBtg4glEWr1SkeyUI@vger.kernel.org, AJvYcCXee/rRkJuMeV7/BvJnaeTNVPOhwFRBeIBNkFMm3JJSsuPexoyxHQL+JZ1kWwcFimy+oMP7hNwjRXttEX6y@vger.kernel.org, AJvYcCXxtz1Bwyshnz+QLN4nq+hI+h+vKmQRcHVwpp6Il1UVYnVgHaIS78bpSyereYA3Pei988zizLzK@vger.kernel.org
X-Gm-Message-State: AOJu0YythrMrtGc7rhUjZBisiHoELq1wzmTcgqPH++zAlnotWxVLXAjU
	ml/PmhaArdmPZbWDP2g5wbiuUifJdKSNz+WaTPp7hLggK3tkDwiP
X-Gm-Gg: ASbGnctOIxzJxKbUO0iZOxwg4oJBCe5VXyr59cibS94arBhyTthk+xrKjPn0orYIUGY
	BAvTXv1E6ztaf+I790uf3HZjZ+cy8xx9bomCt+hJd9sLvlHx0zPueH0+g5n9uS0/cyPKl4Ua2py
	SXB5l9E+wavinbbVtPXmNgbBzTc2KxrH/jj684kv6pfmgnBqPRiyKdIklm7BO7v4G0CBxuEBB4W
	kaHT3Wut+653vvGkXYeG3e2IqqEaIA5IZO4xW+ZkHh2qjiHiN0wb6vfRmN2C0+8ZR0HzMbMe1Zr
	MWaM2rZHx7t4XrqW1bNAIxNu9kDYj7WIO5w=
X-Google-Smtp-Source: AGHT+IGWjFIAveI9yo5Dqy+7qm6ujTkxPVuxedvySkpkmuvq5Mxo0g2bGXtAvQZqm2ic1gDjzturbQ==
X-Received: by 2002:a17:902:d2c9:b0:216:4c88:d939 with SMTP id d9443c01a7336-219e6f133b6mr907204635ad.38.1736231889846;
        Mon, 06 Jan 2025 22:38:09 -0800 (PST)
Received: from [192.168.0.100] (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9f5227sm305467095ad.185.2025.01.06.22.38.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 22:38:09 -0800 (PST)
Message-ID: <39e559f4-375b-4e4e-8c81-3d1d8858e839@gmail.com>
Date: Tue, 7 Jan 2025 14:38:05 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 0/3] Add support for Nuvoton MA35D1 GMAC
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 mcoquelin.stm32@gmail.com, richardcochran@gmail.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, ychuang3@nuvoton.com,
 schung@nuvoton.com, yclu4@nuvoton.com, peppe.cavallaro@st.com,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 openbmc@lists.ozlabs.org, linux-stm32@st-md-mailman.stormreply.com
References: <20250103063241.2306312-1-a0987203069@gmail.com>
 <20250106163054.79cdd533@kernel.org>
Content-Language: en-US
From: Joey Lu <a0987203069@gmail.com>
In-Reply-To: <20250106163054.79cdd533@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Jakub Kicinski 於 1/7/2025 8:30 AM 寫道:
> On Fri,  3 Jan 2025 14:32:38 +0800 Joey Lu wrote:
>> This patch series is submitted to add GMAC support for Nuvoton MA35D1
>> SoC platform. This work involves implementing a GMAC driver glue layer
>> based on Synopsys DWMAC driver framework to leverage MA35D1's dual GMAC
>> interface capabilities.
> Would be good if you could reply to Christophe's question.
>
> Then please rebase on top of net-next/main and repost.
> The first patch doesn't currently apply cleanly.
> Please leave out the second patch, it has to go via
> the appropriate platform tree, rather than the networking
> tree.

I got it. Thank you!

BR,

Joey


