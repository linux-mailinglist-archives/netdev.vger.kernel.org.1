Return-Path: <netdev+bounces-171553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73217A4D9A0
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 10:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CC873B2955
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 09:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2361FDA9D;
	Tue,  4 Mar 2025 09:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P7F1tfve"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1A61FCFFE
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 09:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741082082; cv=none; b=PKE7tWL6jxHFbG14R/UDB9WcvdkO8AQLqueLgbwDKBNpI5nBFr/uISX7DHM4EjkpaQKhhY44K45BwetpazsYd7GLs0bYnexrCVjZxeWo8LPsKqTGtwk8c29i07cBXASMX5gbGgW7P2il47RcecnmevdnHxkPqUTkcB54YWPDpZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741082082; c=relaxed/simple;
	bh=bEZtTwPyY37XnL+BOrDB3iYLlnxsxgbs+5Nwb5ZPZ5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DY0rm2NxqvjZX6fDt4KaafkoRdIHqGy4IN/rjE0C0sX2I8Dl3cfhyT6UEJ1pBzL7avmb8Wdxqfg1KpixRsiDkF2mFhlb6K8PUKNMYdZtkSz5krDK1TMpR8S6gzQZDvd64Tsqgqfv37LBDm/9AMJ15AQ6lMk9AuBxqvQ87oTL30A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P7F1tfve; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741082079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u7cLRomgT9aYrM8YJE7hwcT94wlH0qz2XRoudr3Vr10=;
	b=P7F1tfveGx7sbKQfgNrnqVOyKW6oY+YWQfFzCeKFfDBdhrsWPgg+WUVmPx5oxQ3+lEO5KG
	m8aaf7+d5z954gsn9yHVO4aVHJGgBR1qJTokOKMmpQ6/LPYGJZxnp54wHhZjTJReQzGL4D
	VHQwtemXON7iqrxHqRemhl8ZL2imMZk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-8bf7ljmoMVih7q8hEAI-vw-1; Tue, 04 Mar 2025 04:54:38 -0500
X-MC-Unique: 8bf7ljmoMVih7q8hEAI-vw-1
X-Mimecast-MFC-AGG-ID: 8bf7ljmoMVih7q8hEAI-vw_1741082077
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-438e4e9a53fso37969185e9.1
        for <netdev@vger.kernel.org>; Tue, 04 Mar 2025 01:54:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741082077; x=1741686877;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u7cLRomgT9aYrM8YJE7hwcT94wlH0qz2XRoudr3Vr10=;
        b=ZfdkgLn8gzhOUaw3K59poxLuVphV+6Hi2mCd1ZUK/vBBJ9NAGTUoZ7PfdOx/BMSDYc
         tPQYHys+0ujJqZpBfgLzYfSP6lgUuNEBvc3MoXa3KbcIgFI8SmmnX7p6ZBeYUE6k/8NO
         KBLoiAJfbjsp7NpFQqKZMF8LbN+vDVN9hrC6K2I21F+okV7b3nCvvFYz83lkoJ31R6sy
         ah0SonlS3lyhaqoDEEVEdSM0oPp+b4hX4wmEpmclUHCwVChjTQfhzQcNSEmEq7kfcPOI
         1EDwARPAGDbUJkrjfooaNvLavwowEk5Nyih1E4f9o5FLNUtJ53yNK7pKY+awi1iVwd6h
         DYvA==
X-Forwarded-Encrypted: i=1; AJvYcCUBx9jQlREXssMc7cKX2Q3zEYVg2gST/VT6m2Pn9zVrAs+hSk4u9cm5at2FRWa5yh3RWCYol8k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz83Bkj/QE2HhLeMmz2d+8weDGV4kHq/Al6eVXyiFFxQS3DtLNv
	ndG2ixSIw5/hR9+/ydjddM7OejWyguC6C11A1iY5IdaQA6iVKq34lg5akO4Axj6tpoLSBegnU4B
	EuU43muo6d9uEUo2nuWYQidFIIJodgswcooYW9/PVStWg4hLPfEG7Pg==
X-Gm-Gg: ASbGnctUaS8obNLWlPqJRgm0SV2OHZuL7aeH4NOXFowF6xYWBsVM1UD77eYSrhzsmVN
	zvWYKZyPezjB71CQ3UCORFTZLhoYPyBHMMLmerlXd2OPnle+SqR3eYVJ+5TYtZcERHbuCgdGl8u
	APz2zO1W+ujVBASdB38jCnJZgpvxp7ALWrccr1TDqZUv37V8zpznPtxbnjjEhYKbYtjGSrSnnQf
	7DBpYI51Sf7pn22oraT9t1NzlFh+KYJ53wVXJt8Q5SYUOxlpXaIp9q9Gi12k4sRpHSr31Gj/UpC
	u0hOjPcPWNew3tVXY6FwWx4QX6jZ5Es0C1rcx5z/VBUuvQ==
X-Received: by 2002:a05:600c:1c8c:b0:439:9ba1:5f7e with SMTP id 5b1f17b1804b1-43ba675a843mr118312625e9.21.1741082077452;
        Tue, 04 Mar 2025 01:54:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGCYvnIe76LEUSPaxBjczhESkT9xksjygv9YFGPgN7D+cz81nubOVGbUrKCatMMMLTJvcstbw==
X-Received: by 2002:a05:600c:1c8c:b0:439:9ba1:5f7e with SMTP id 5b1f17b1804b1-43ba675a843mr118312285e9.21.1741082077032;
        Tue, 04 Mar 2025 01:54:37 -0800 (PST)
Received: from [192.168.88.253] (146-241-81-153.dyn.eolo.it. [146.241.81.153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bbc030d24sm82094335e9.22.2025.03.04.01.54.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 01:54:36 -0800 (PST)
Message-ID: <48885074-b590-41e6-9794-49ec12713cce@redhat.com>
Date: Tue, 4 Mar 2025 10:54:34 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 3/6] arch: x86: add IPC mailbox accessor
 function and add SoC register access
To: Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 platform-driver-x86@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org,
 Choong Yong Liang <yong.liang.choong@linux.intel.com>,
 Simon Horman <horms@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
 Jose Abreu <Jose.Abreu@synopsys.com>,
 David E Box <david.e.box@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin"
 <hpa@zytor.com>, David E Box <david.e.box@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jiawen Wu <jiawenwu@trustnetic.com>, Mengyuan Lou
 <mengyuanlou@net-swift.com>, Russell King <linux@armlinux.org.uk>,
 Serge Semin <fancer.lancer@gmail.com>
References: <20250227121522.1802832-1-yong.liang.choong@linux.intel.com>
 <20250227121522.1802832-4-yong.liang.choong@linux.intel.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250227121522.1802832-4-yong.liang.choong@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/27/25 1:15 PM, Choong Yong Liang wrote:
> From: "David E. Box" <david.e.box@linux.intel.com>
> 
> - Exports intel_pmc_ipc() for host access to the PMC IPC mailbox
> - Enables the host to access specific SoC registers through the PMC
> firmware using IPC commands. This access method is necessary for
> registers that are not available through direct Memory-Mapped I/O (MMIO),
> which is used for other accessible parts of the PMC.
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> Signed-off-by: Chao Qin <chao.qin@intel.com>
> Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>

Hans, Ilpo, are you ok with this patch going through the netdev/net-next
tree?

Thanks,

Paolo


