Return-Path: <netdev+bounces-153461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 886219F821A
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 18:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D3CC1897285
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 17:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864A71A265E;
	Thu, 19 Dec 2024 17:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTuN6/Zc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3C619E99E
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 17:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734629702; cv=none; b=m6ghvL89nDl0uElZK5fPS/xwSaSITkLcUBuGSvA/c3g3TWMWXURUmlgr5LgF+mP0ZhbkRyc3GzTtCyMPaCNDSt7jPwlrpYH0yZlfozhLKD+yU9gwGFoyGS/Czt6o/sHAv7nDi0IYNjMlgjZKu7OOVDIr8r0ci3uNWZNaFC9UG0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734629702; c=relaxed/simple;
	bh=Uqia1xHZQpDEZtXO58H5h35imRo/hQVBD5DGTtxEZIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oPWUll1cAZ0Z3BX0lP+PeXuEBXX3gKSEgR8n4cH2Tqi13AvfLDGpz8Y3h7uKy1rahWG3P6mRz8xQ0c/If5TJvTyXM0pBFAsHY8rRHnh+S8UlrNPUj3EXUK7/UWpgnWvPYqGC/e8WS6NgMXmUx4SnB4XvWhqcDygfizJL3TlnHSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LTuN6/Zc; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7273967f2f0so1320028b3a.1
        for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 09:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734629698; x=1735234498; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Uqia1xHZQpDEZtXO58H5h35imRo/hQVBD5DGTtxEZIw=;
        b=LTuN6/ZcKddy3VNiD5T7pD7/fAX+o9Ab82oz805CtwY4vemBJvHvdKrNSyRuZ888Sb
         8cLGvrqanj4eY6Juo49iLVzkN7rtArVlVPPaa3pI1BsToF9/PB5klt9oe5cWfinDUxiE
         lkG15mm7yjle4bAoozLZ5pMRMNBEw0cXmYwnRdguwlJur7HlLYtcIdcd4cv7RBtBWT+f
         jZ5/tLzko5JOO/CU0rt4vXKAgTPwZZ5QDQ0UxCzMYt0sB7kFpqFaTVaeCwvGPItIe5Cr
         2Y5Ss+9zqEgShXgDoOUCem31SkmCh6hyHQam+0KKR5R8nLN3Nyf9XWAiwstwhM0PTljx
         Wdgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734629698; x=1735234498;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uqia1xHZQpDEZtXO58H5h35imRo/hQVBD5DGTtxEZIw=;
        b=uYrpv4jUWVriEBAt/JZElHoD4eAqaC9jiIFgvfZoEWPCG3z/UKoBvAzxpn/q6BLoml
         PdPWjdgbvZeKM+QAuwos1gPOhimuXcAWGg++SCsw+s2kCl04iI9JRQBnQ2cqiXLQkzls
         oX+i/8A7xCbLb1b3KrQ7ecU7N7wcjY1sCKhbo1jVFCwp2a3AGuEm+JA2LakLxM3Gcl6U
         Ig3kZygrJKZmaWCNtYDOuTBU6K0swiYN0JXjV9kbPb5ihUhvUesd3Lw8XepCacjxR+IY
         XnTr/MNTc354fcjoEfCBNNmq+4vbArXtQubGuaaQVLy6677WyiBM0t/q9bppE07NAgL0
         t7fA==
X-Gm-Message-State: AOJu0YyUaCzSlG6gDfUpKn4rELIn3y92/+FOZhNy4QgH2JygXXYUxMmV
	aJK1g+O8DAS4cFPra71rCK1j4AylH/AHwieZ6hzL5jeiE9ZQAIA8dK6lMQ==
X-Gm-Gg: ASbGncsd1W4xJwNoCsZhXm8UwPSDmuVpxM3+JLMHJhz87wU7hbC/z0dANf9soqVi+o5
	Z7YG2FnGpPU9KZNfReqJkSpAMqokLQB0QGY3iwZX4h2pcnUQTK4RtsDwWAvibqrtdvsn+lrqSZR
	hXC4+OBuDFCVy7q6WWWczckexQtyHT+nA7TcHYpAL9SmRk7cPUoBqoQtlKaDKDu8a1aTJyASwli
	QyW8pCVCyVd+2yrC1EpLxPtYUVNjbPT9qZrz0PE648oWZUvp9dFYJemnaXz4dMrRVOKSlv5sW15
	ikwfODFp07y5
X-Google-Smtp-Source: AGHT+IEYfLLM97qvkjJYO0oyJuwynsTMskt1Ilj4xnX62U9aIIWhQCJ9KBiT9rSAbfnXFUjC0QzXbw==
X-Received: by 2002:a05:6a21:32a2:b0:1db:eb82:b22f with SMTP id adf61e73a8af0-1e5c74f32efmr5595356637.5.1734629697976;
        Thu, 19 Dec 2024 09:34:57 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1145:4:9688:47db:95de:dad6? ([2620:10d:c091:500::7:358f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8faf9esm1619271b3a.144.2024.12.19.09.34.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2024 09:34:57 -0800 (PST)
Message-ID: <9e022720-f413-411c-be64-77c8b324549a@gmail.com>
Date: Thu, 19 Dec 2024 12:34:55 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC ethtool] ethtool: mock JSON output for --module-info
To: Danielle Ratson <danieller@nvidia.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 "mkubecek@suse.cz" <mkubecek@suse.cz>
References: <7d3b3d56-b3cf-49aa-9690-60d230903474@gmail.com>
 <DM6PR12MB451628E919440310BC5726E5D8422@DM6PR12MB4516.namprd12.prod.outlook.com>
 <f0d2811d-e69f-4ef4-bf0f-21ab9c5a8b36@gmail.com>
 <DM6PR12MB4516A5E32EB6C663F907C24BD8492@DM6PR12MB4516.namprd12.prod.outlook.com>
 <cd258b2f-d43f-4ae6-bd7c-ca22777d35e3@gmail.com>
 <MN2PR12MB45179CC5F6CC57611E5024E2D8282@MN2PR12MB4517.namprd12.prod.outlook.com>
 <f3272bbe-3b3d-496e-95c6-9a35d469b6e7@gmail.com>
 <DM6PR12MB45169CD5A409D9B133EF3658D8292@DM6PR12MB4516.namprd12.prod.outlook.com>
 <02060f90-1520-4c17-9efe-8b701269f301@gmail.com>
 <DM6PR12MB4516F7998D67014D9835C5F5D83F2@DM6PR12MB4516.namprd12.prod.outlook.com>
 <DM6PR12MB4516E1A2E2C99E36ECA9D87AD8062@DM6PR12MB4516.namprd12.prod.outlook.com>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <DM6PR12MB4516E1A2E2C99E36ECA9D87AD8062@DM6PR12MB4516.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 12/19/24 9:18 AM, Danielle Ratson wrote:
> Hi Daniel,
>
> I didn’t get a reply from you.
> Anyway, here's a like to my git repository: https://github.com/daniellerts/ethtool/tree/eeprom_json_rfc.
> The last 4 commits are the relevant ones.
>
> All the CMIS modules dump fields are implemented were sent to internal review.
>
> Thanks,
> Danielle


Thank you! I'll try it out on my machines.


