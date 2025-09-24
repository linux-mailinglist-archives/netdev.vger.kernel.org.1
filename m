Return-Path: <netdev+bounces-226108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8D5B9C2CE
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 22:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6B147A8773
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 20:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E3B32899E;
	Wed, 24 Sep 2025 20:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2SakJO1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740C6258EF3
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 20:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758746569; cv=none; b=BdLm2BVAB7lIBirKaXDmpqtRF6ROZ9VKap6SmkionMjL0KRU4DABC7v8O/uAtTj7mCJvF6irqy11OQho4QwdDdUvZRF/OUGBUDh1/QpONcc4U8Ee/BXPVRGucXzU4aGARUrI+vTOi/HYfHKvHUcRg2ijQT2msFtBTkepnLY8UcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758746569; c=relaxed/simple;
	bh=Ucz/i9AWOR9GXa1xL/rpLdGn6X6OtYj7N42zAdlWFDc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kh9PwfklD2t7jk0h9w+2w1+0N2X7JGulmjQccpW5aNH3RRCNITq0+F/ramDem/IXz+UGhvkIgMtURwrEue3TTWokHm+efTtujeqgLtz2MnxspvNdDI4Bp4SKuoqzmSfyJ1zl4Ij1LzuLkML6JIIHoYF0M2Hkur9r9DGDxy3m5I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T2SakJO1; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-57b8fc6097fso226956e87.1
        for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 13:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758746565; x=1759351365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bYnzcg/e5OYQohYl91H+gnYqtu6/MdF2Xt8l0Tcfgig=;
        b=T2SakJO1vr3FJERSIz0kEvL/x3IgIfeNLG9Zgp2GR/oP2UgIVxJm06L8A6Smztpr1i
         8dMok9N8R+85Eu8IcwwipwlxaTf5p0IA7uY39uUDNBhrOnB6A6qsBd1CKoYG9UABRSqT
         TI0yhoHXxwMG5Nq6/182c3ShLaw4WkL3ZVMrv+XZm8GKC/34kN8zEMlLow+EczryORoV
         n5Nx2knt0aMTtQCcShYZewSj8L1jJrHabi6sNht8tzK80w1jIufQDHuSRXcslwzJDJI+
         yXSkJMTMc4dAS/MMcyioPGNKas7HlGmuaf2TYpKx5Ilro2kjo3feoAX4KKiknzkHF9GW
         Ifbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758746565; x=1759351365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bYnzcg/e5OYQohYl91H+gnYqtu6/MdF2Xt8l0Tcfgig=;
        b=Pb8hzPmIfRHXSXtBvegetue/vpfnm9wC4EduxJgYMvCxRxOKsFbLS+Rl3uesIqtNdT
         KsainzAOIJNwHHUxPxPA30c4Ibv+I/pl5gzK/1GatNkuI4MCmWeGKaN5dVwb4Nf+InMS
         nqXgFz6qaMRBD8k9EALMgk+CGhkKm3Bj/tI0QdfbZSezgbWPOLLp3ILAN4GWivGixZwB
         3slS4QsVZi1f9jXc4b6/86N1AMv5XK3w8XM3woj9h2/2Pd4F/NERKhYoNBaqWutEBS+M
         xV7aNfhfxT8l5FFjMfZuoANVSRFB3mHnKLdZtfaPblhvDpd/RREJLyxmnYRVcJoa3fT4
         fs1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUBohgggJzBkqaB1XZx0YJaIwjQ34VgJJQlBsL/+7nKD3nwBvjNuRPHd/8g5ghNVOoZXd18dVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhsrpMJixaWDPk7lViSE8XDL43QkSULvGNSKuV0hFVUTDJt691
	HZfq3ZwBvcHK7TsdkgZosQmz7pQjLTGsi/7HMmXxzgbmPv9s8TxP+UrV
X-Gm-Gg: ASbGncuR3gt5uLfQpuHGBVnWLdgrqdcTUL2DpauWmeMQVIj+xdVja9yxgLkh0Ifpjd1
	1vLduy+F+KGAYQyTH3EUpQAwX5WrF1aYh1sqgOCjM0ONX8xcxfqKKeWCiIIEY/xhTv1lMlGgrq5
	2p7MuVYoh8kZmF4m8PG5JbbuJZI0cWSE64WFjK3nDMOuAriXkzgFYuV0F6x5t5FbmyNgn90zVwu
	8O7/IuYjDRngj5/iCVX/CWmUYHsMODWH1XdZlY1zvpVxPUa3iSvnHLxexx9+vxsxzsPcaltR9dO
	zd6lT9F8ZV8hzXqBn06sas8Ka/RLz1w5nWX2cft/lTgM9CIWJQxDvwbAg/sE4MhLYtjqQrdY+vT
	B/kUj3iagYdeZ6MMoHTBQL7rhN5QqUy466EQ=
X-Google-Smtp-Source: AGHT+IGyzL5f93thSN0PEzq2w767/JoDNWiJBH5bF6LdKrr9vgdH4gRJ604q0DP0F1tZQOVY9vZyEg==
X-Received: by 2002:ac2:4f0e:0:b0:55f:4ac2:a595 with SMTP id 2adb3069b0e04-582d0c284e2mr270160e87.16.1758746565220;
        Wed, 24 Sep 2025 13:42:45 -0700 (PDT)
Received: from foxbook (bfe191.neoplus.adsl.tpnet.pl. [83.28.42.191])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-583166560dcsm368e87.94.2025.09.24.13.42.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 Sep 2025 13:42:44 -0700 (PDT)
Date: Wed, 24 Sep 2025 22:42:39 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Petko Manolov <petkan@nucleusys.com>
Cc: I Viswanath <viswanathiyyappan@gmail.com>, kuba@kernel.org,
 edumazet@google.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 pabeni@redhat.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linux.dev, david.hunter.linux@gmail.com,
 syzbot+78cae3f37c62ad092caa@syzkaller.appspotmail.com
Subject: Re: [PATCH net v3] net: usb: Remove disruptive netif_wake_queue in
 rtl8150_set_multicast
Message-ID: <20250924224239.3ec0fcca.michal.pecio@gmail.com>
In-Reply-To: <20250924195055.15735499.michal.pecio@gmail.com>
References: <20250924134350.264597-1-viswanathiyyappan@gmail.com>
	<20250924135814.GC5387@cabron.k.g>
	<20250924195055.15735499.michal.pecio@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Sep 2025 19:50:55 +0200, Michal Pecio wrote:
> Do you happen to remember what was the reason for padding all TX frames
> to at least 60 bytes?
> 
> This was apparently added in version "v0.5.0 (2002/03/28)".
> 
> I'm yet to test the exact effect of this hack (will the HW really send
> frames with trailing garbage?) and what happens if it's removed (maybe
> nothing bad? or was there a HW bug?), but this part caught my attention
> because I think nowadays some people could consider it "information
> leak" ;) And it looks like a waste of bandwidth at least.

Sorry, stupid question, such frames are illegal.

That being said, I see that other drivers pad them with zeros or
other fixed pattern ('skb_padto(skb, ETH_ZLEN)' seems to be common)
rather than just DMA beyond the specified length.

