Return-Path: <netdev+bounces-147081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1352C9D75D6
	for <lists+netdev@lfdr.de>; Sun, 24 Nov 2024 17:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C65C72856C4
	for <lists+netdev@lfdr.de>; Sun, 24 Nov 2024 16:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D5518132F;
	Sun, 24 Nov 2024 16:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWeiisD7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAD0189F45
	for <netdev@vger.kernel.org>; Sun, 24 Nov 2024 16:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732465423; cv=none; b=PWTIoi94fqUR216jI+efS3vSbxPSzkPxxxWfPPkq9434h66zR4yeQygCDWlh+3ZOjl6aybKbALObmKPEvTsEuPgMXTAe8NHhBkddyrOoQrGMtA08wLqZXtPqueoNUbr/xo27fgHONqGUJvn5kgfBsZDUuqBYHp79TUt1WLUWFTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732465423; c=relaxed/simple;
	bh=wqDs0a0YupFpI14wRwj88Xf9uoUxI566mKIH9QjhDhY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DoBUg/WIVYF4havrnqWhVAkO6/BsSNhTHfMgVn3cPnWszbuxATky98HKylHRrTAynKvsL8rY5/gfBk0z+MkfuYYmVLw53760IvVlLb3kbvc1yUf0GfHGcReSnjTL/XLhydFz8PCqoEG26cELUelNyBwh74AJgbhsretCIg6ipAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DWeiisD7; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa5500f7a75so43259266b.0
        for <netdev@vger.kernel.org>; Sun, 24 Nov 2024 08:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732465419; x=1733070219; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fGiePBTinRuWEgwnwqm1SPPbfO1wh6pzmHZlUjuM0gg=;
        b=DWeiisD7ehj3QAOadC9394j0m6xTk/sIJiINTnvOV3y3DSk4j8gbQDZ5KEYS2kXTMg
         OWoukqp/L1yj0vHBbux1jvFnKmCYke5VzG9B37SvUuFP5IlIOa0WBBHxrcjTDEgfSMLE
         mqmiCxLGkbGbZSPoAEvHmdLQkW4dS7H4Aak6xD9X6JQbKVlpWMTphQgbuX/7WOdHcD20
         H9w25uosf7qnBrw3w/j4c9xFlnv4M+n8KHTfIqEYzxdmkSbcIa8BUYo2OHHSFUFhcdYc
         0E/p4KycYS/IsqhIEr05iZmCggsPsLOZt/05d+J5Oz9HeVW6VMGzl8ceBMex17FFoDIx
         Q/8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732465419; x=1733070219;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fGiePBTinRuWEgwnwqm1SPPbfO1wh6pzmHZlUjuM0gg=;
        b=kdDPfvaqbtsfktBpFDT/52XkAnhOc4//dZGZ+cFb9JIFiKJ5PYnP8SZ7YWfLKjt9gV
         G0DjzkVLacGvAwzxe8oqqhv6qAoTL+GFjtE+Qpgd/jODEQbaIGBrBvnNAdmbzU/nKBbh
         Sr8Zmiolm6pTq0t88L7u1rz7kvBrlBjN6ujn+sB50W9bSOgg1b51KPli38bez3qebIM6
         i8wIxplFFIT9ILXcJVqlzU1EJf5ddA1swRtLh4hBX7lw/48QdrnNiKW+tx09jpTq2Cin
         erQffDnAvB4kCLqzq7faSQmnNnEwgmnXR3IsiFxb0XUu/Krnk4a2WwtWrr+sQ+bPO+CV
         mOsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHpuQPxBsj3JuR87AIxSlKK0WS/UDPhNS3ycIclRjZZ6vwYKq2QNzL84AYBj+toKMe2/2gEgM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0V0C9l2mCB6Yu18E24QBKHfinKyZu8C5kkL9ljj9Sg2wFmBq9
	+OGI8XIkeEpTaUNB/bvyoGGhNbST1t1988RIYifFStKeVwAZApdK
X-Gm-Gg: ASbGnctB9ZfSzXqIORmXhb/741HDZLEnNuN2oVOOkSOVFgs3GRHMofvP4OgUn0+BwqM
	0CrMEfsglkncCiKhiM7alKLAyN4D1JDP57EV59WVQL3gHe26t0vXD7yuoNvo4Pqqa+cHMDx17X1
	9bPwh5Lxx9UxXVgwno1gUPZ7X3LN18KqvTjKG5SZABRCzP9n7ZuwtCkosre5Q+mBZXVFNsb/3/P
	4GUoCEqq0QPwjA56vpGrKRlFvlP+/To6wyOKD88NbU/RwF7KeQDVKxC3TG9TpqWNHhgy/iZMmtd
	jOZxnPU9zGX+ZQfjjYA2YLmLJlIeBfABCAKa3WxfCXZolO5YqhYPJt3pfVT1Y6T9B+GpPGKu2SO
	cm1wYbw7yiKu3uygCSfXuQAl23zLK06bsDtcVnmQ=
X-Google-Smtp-Source: AGHT+IE3iLvJC5WGf2Ins8N9Q/J/BHuOB32mteqdPVj/2dgwZVkwqHa9gIqlRMSwaEpeh6us1Rb0Ow==
X-Received: by 2002:a17:906:c4c8:b0:a99:5466:2556 with SMTP id a640c23a62f3a-aa509d5d5c7mr780638666b.61.1732465419345;
        Sun, 24 Nov 2024 08:23:39 -0800 (PST)
Received: from ?IPV6:2a02:3100:a9a7:f200:e561:66ed:8fb3:331? (dynamic-2a02-3100-a9a7-f200-e561-66ed-8fb3-0331.310.pool.telefonica.de. [2a02:3100:a9a7:f200:e561:66ed:8fb3:331])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aa50b57bd96sm361353566b.148.2024.11.24.08.23.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Nov 2024 08:23:38 -0800 (PST)
Message-ID: <2e4cfd07-c8ee-470e-9a68-6a50dcd00e04@gmail.com>
Date: Sun, 24 Nov 2024 17:23:37 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RTL8125D intermittent disconnects
To: Connor Abbott <cwabbott0@gmail.com>, netdev@vger.kernel.org
Cc: nic_swsd@realtek.com
References: <CACu1E7GJttr8EDjLxYMBkfkKSK2=ZS7hb4bsYAhqO00bt07QtQ@mail.gmail.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <CACu1E7GJttr8EDjLxYMBkfkKSK2=ZS7hb4bsYAhqO00bt07QtQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23.11.2024 23:35, Connor Abbott wrote:
> Hello,
> 
> I recently bought a motherboard with a builtin RTL8125D Ethernet chip
> (XID 688). I updated linux-firmware to get
> /lib/firmware/rtl_nic/rtl8125d-1.fw and tried out the patches enabling
> it, and while it mostly works the link intermittently disconnects and
> reconnects. It seems to be caused by high bandwidth, since doing a
> speed test in the browser seems to be a reliable trigger. There's
> nothing interesting in dmesg other than "r8169 0000:06:00.0 enp6s0:
> Link is Down":
> 
> [   36.133656] r8169 0000:06:00.0 enp6s0: Link is Up - 100Mbps/Full -
> flow control rx/tx
> [   36.476108] r8169 0000:06:00.0 enp6s0: Link is Down
> [   48.507244] r8169 0000:06:00.0 enp6s0: Link is Up - 100Mbps/Full -
> flow control rx/tx
> [   48.821220] r8169 0000:06:00.0 enp6s0: Link is Down
> [   60.947170] r8169 0000:06:00.0 enp6s0: Link is Up - 100Mbps/Full -
> flow control rx/tx
> ...
> 
> These are the messages at boot:
> 
> [    9.512877] r8169 0000:06:00.0 eth0: RTL8125D, cc:28:aa:a7:bd:85,
> XID 688, IRQ 100
> [    9.512880] r8169 0000:06:00.0 eth0: jumbo features [frames: 9194
> bytes, tx checksumming: ko]
> [    9.534565] r8169 0000:06:00.0 enp6s0: renamed from eth0
> [   10.716346] Realtek Internal NBASE-T PHY r8169-0-600:00: attached
> PHY driver (mii_bus:phy_addr=r8169-0-600:00, irq=MAC)
> 
> I tried this both on a branch based on 6.11 with enablement patches
> and some dependent patches backported, and on recent (today)
> netdev/main. This doesn't happen with a USB ethernet dongle I have
> laying around, so I don't think it's due to the network or something
> else in the stack. Is there anything I can do to help debug?
> 
Thanks for the report.
Does your LAN indeed support 100Mbps only? What looks somewhat suspicious
is that there's exactly 12s between link-down/-up in both cases.
May some network manager interfere here?

You could check whether behavior is the same with r8125 vendor driver.

> Best regards,
> 
> Connor Abbott


