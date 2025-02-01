Return-Path: <netdev+bounces-161940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0E8A24B8A
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 20:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 442A53A6AF1
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 19:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259E374068;
	Sat,  1 Feb 2025 19:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELRkDr7E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0672F5E;
	Sat,  1 Feb 2025 19:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738437287; cv=none; b=cj8PVmFQAfi8gf9PzILr+m2HurZL0Yl2tWr95dZbjWhDiF946mXNSLkFdXCXgzhfH81k27+lccIObi6ZxZKCtBOdwcqMdimiOkcyJfNiG5BPVKaabGm7InkpCHJKTj35JEgMDtfL+Ds/ms+Uli/OFUUp11gAebBWlyorzfGCPFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738437287; c=relaxed/simple;
	bh=7nmnf9csByOgE/n7rGMItBPUIhS3UBG3BqNgPkhrEJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=onDdYikmmOQNkMmYAWEklvm65zrRpLFJM1V2wSKETPdamPriB7mYbYQRKHmbLBhFQKYTmavnyy8T4iKgnb0furSkn6t+ex0Jg/nDA4x4Tn75CqmdTgGMUpZcWQ5anAu42fm+kegQjwfLNjhuP4jug6cBKD7Ff3Ku79eeNpTnqBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ELRkDr7E; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21634338cfdso74422515ad.2;
        Sat, 01 Feb 2025 11:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738437283; x=1739042083; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XndM4SUJuOZNaJGKM3Nluez+j/ai04AIsmdbMK/OdgU=;
        b=ELRkDr7E1nswOgATESelvx77ZopqVSHs7pCdWx0I2PW04qAd4/Lfw+yUfOaOBw2LvE
         /A+6h2+2bK3SNzE8BoUglTpn3TsjOXrazVvQFolOwMVXwPszvcR02MtMs4ITnIY7AXwE
         vT4XrBRgYm2y2iXwpb6Bshzx6j9kaMDnOKwyS8bqVFXqr1EcwZwQU37xrunSsqJC4Uhl
         bEqI6BzjOFS+vOWRLQVGab8Ya2XGA/41Lk3CrxshU0iXj3o5I0DEwN5oN2CYmR9v90lP
         wReJzoRP7rKncOR4gsSYTgpFYpd2tgDlgNka5Y5Ob2pYhi5maQ9vUrbZ4FUxT+r6kfAC
         AhTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738437283; x=1739042083;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XndM4SUJuOZNaJGKM3Nluez+j/ai04AIsmdbMK/OdgU=;
        b=EJNSiN5lVV9Rp+cyLVGVdVMoWIjiAvt2uo7M6HbzA8DuYX9ajIhlHkAcVUBbNE6fLF
         7mLNOvpQNREJLruBEFiFtdK2OXRQi6RjtmCRjGa3AG41HcPctJNlmTAwS8wICPZfpacg
         K+xysUAv7Nydt0980R6y68feKi9uMcGn53TfT//7At91SVwqLpjjS7DwwPrjf/P4Ajov
         uFUtnqbVVsTbHtxh7aqv5nm3ildpr5CTwoKhMJ+Qk1AL2+6Pas4pFNqBp1y1G6f1ghhJ
         tYZALtCDlxMy2Qghv5h/UBLHSMPnk+h/EmzgP4HtlyjyECniIOnTFzTrSX7TTPgfHrnS
         FS8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWpjSierNK+JG8/kuNvL56TDP/3CTzmq64i3EY1pl8tws90y7uZnSfa3guK9cFyOmJtq7dS1wyqdRjPT1s=@vger.kernel.org, AJvYcCXloShtHtxxqaxsfgRTCkVOy2hq9taP+PJMcQyE6B2ZXZ13dmh+suwEwtImGBCfPr5P1cQOHjFl@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs913pjB4Z3bB3xaa293XCnev53pF27c3aKkJSBL9GGmh/fYM6
	oVsbfCZz4Oq4IasbzemiYj87lfvkKvEmjjiRP5NAINzhNd8L/2Zq
X-Gm-Gg: ASbGncuJYXesN/vInc1PTpoAOTEook/LqHnYgLjeupa87pwDXi7chdlDqhcf69diwLA
	Z/sAs8zZzh5KECreBJ3waXaZbphceDLiDEY6I00q75yV3t03Qp+AUo9DsucGlJDxGtQg8WXvLzj
	9HydjPOsSjT/0YN0IcgXZjs0zke+mv4paH4B+P9ooewqAsx0GUndwenkCW/Zo4ZZvv85cZYQfPq
	J3H0XTiWbkffZRNg5YdmjciM9EqvVuYy5Uhd187PYNd5LUTzeqWflk8jVRWkkKXxGFa+cAP8kN+
	PjBV3hNR4750f8b5NASrHRJCm0Zd
X-Google-Smtp-Source: AGHT+IFB0fHVUPGOn0Y4YLnpgsNItVWNfXE3cnoduXNVQ8LV8KKiNZ0+PqrNHM/p1fOyunreivhv4Q==
X-Received: by 2002:a17:902:ccc2:b0:21a:8d8c:450d with SMTP id d9443c01a7336-21dd7df960cmr277991815ad.53.1738437283444;
        Sat, 01 Feb 2025 11:14:43 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f83bf93c23sm8240833a91.39.2025.02.01.11.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Feb 2025 11:14:42 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sat, 1 Feb 2025 11:14:41 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Yanteng Si <si.yanteng@linux.dev>, Furong Xu <0x1207@gmail.com>,
	Joao Pinto <Joao.Pinto@synopsys.com>, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4 3/3] net: stmmac: Specify hardware capability
 value when FIFO size isn't specified
Message-ID: <4e98f967-f636-46fb-9eca-d383b9495b86@roeck-us.net>
References: <20250127013820.2941044-1-hayashi.kunihiko@socionext.com>
 <20250127013820.2941044-4-hayashi.kunihiko@socionext.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250127013820.2941044-4-hayashi.kunihiko@socionext.com>

Hi,

On Mon, Jan 27, 2025 at 10:38:20AM +0900, Kunihiko Hayashi wrote:
> When Tx/Rx FIFO size is not specified in advance, the driver checks if
> the value is zero and sets the hardware capability value in functions
> where that value is used.
> 
> Consolidate the check and settings into function stmmac_hw_init() and
> remove redundant other statements.
> 
> If FIFO size is zero and the hardware capability also doesn't have upper
> limit values, return with an error message.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

This patch breaks qemu's stmmac emulation, for example for
npcm750-evb. The error message is:
	stmmaceth f0804000.eth: Can't specify Rx FIFO size

The setup function called for the emulated hardware is dwmac1000_setup().
That function does not set the DMA rx or tx fifo size.

At the same time, the rx and tx fifo size is not provided in the
devicetree file (nuvoton-npcm750.dtsi), so the failure is obvious.

I understand that the real hardware may be based on a more recent
version of the DWMAC IP which provides the DMA tx/rx fifo size, but
I do wonder: Are the benefits of this patch so substantial that it
warrants breaking the qemu emulation of this network interface ?

Thanks,
Guenter

