Return-Path: <netdev+bounces-148317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBAAE9E11A2
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 04:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76FE0283321
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 03:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F35B13AA27;
	Tue,  3 Dec 2024 03:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PuIh8r4Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD8A17588;
	Tue,  3 Dec 2024 03:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733195809; cv=none; b=PgAB3+c6j6sYlAvntVsijhCXxwMv4VGdxhvE0S/8fVHPYrUzq+T9Srt6GB/h7YX5XT1BpeGPNAzm8H0+C6UIDnqOYfD4MSE1nZLuj5BvywUcSLEPuUmSPq8SwJXL+oooyOS8eny7LHmY+myv+JlVxgtSKOqQ3Hho7+ioBATjyvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733195809; c=relaxed/simple;
	bh=8c4o0LLNa8WegNyqtXukVNXSWfDPvu9wi7OwwAqXm/I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mxpUp056II0HXgy8Bm++i6l9iGqjvZi6lNzYqt+wHZ29F+9x+I9UpxqVh2UiGhDtrS7ocS5WT91X8kg+ICV0tXxiU4eHtL2kyPobK8rwu34kTnLDLBKJwzb2HSZzVb7fNx0aqGJ4mQIpQ235RG8UzffyW6lEBREDxnFs7F1vUx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PuIh8r4Z; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-215ac560292so11514815ad.2;
        Mon, 02 Dec 2024 19:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733195808; x=1733800608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pIOFihO5lZulDGiIo9cjka3yr/GB/wNq1xFLe4/g6UQ=;
        b=PuIh8r4ZRGET4i1d9pNjVD24hmoMqq1HkfficKCPEKu51lwK717xFD7ARrh7D/wgnN
         huUolNqQWP/ra/36ashGbldNA8KQBL4kZ6Fd6AjbfTpzT2yKTnnuCipK98PRsLDDdefa
         O4FbWIG9pXGB4fC+GOhoGtsrcMHic6WybQPcOGWJvc5bivL11mUe5yhanG9YA9gZCh+g
         zTzULVDxV6Bl5WwqpUd0b6G6C/CAyjGhrT5A7cRCA77FpH8I8Rf35fgBvKlygMfihO3j
         iZ1t4xFhcITyaEK3nnHCzBZSB4h3nQsAxwEQtCACh9YBl+KXOMjvdXBzLQh2IefEJ22q
         te/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733195808; x=1733800608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pIOFihO5lZulDGiIo9cjka3yr/GB/wNq1xFLe4/g6UQ=;
        b=lc4INqRBMamutRIl7C/7UY83nEIf9D51+949xXf9Ns7+zKZM+wB1abU2NAtTCuji5c
         sOnmE3RtuOkZN/79B6EmnQ14ie2kum3ryToTOIL4pVzMCMkLNM8JUBIZ4GDFK9ROMOf3
         8OPkeMIjRmC6LXao0xMnX9rmB4dvP2yUnp8G1VKNYDFhnfsDUI6WSGfbptp0w0MYA8Un
         x8vcVgwAueYoHS4fBc9UerXUnADbSC/8NxruiTeaFY98A1gxM+SOAq9IKPiy77iIyE/A
         ntBLhGD5zVoI3RylHsBl75+hZIHuac0PekFSKl9daOwshQvEyGxTBIPsw2xafAqQyGlX
         Ts2A==
X-Forwarded-Encrypted: i=1; AJvYcCV5b5dV6R0cYQKzQCs6Pw3YwE/f3C6zBzqUS7ccUcKM9KT5ETIjopTucbcQ/ezxo1BINXmOxSQ3@vger.kernel.org, AJvYcCWIr3GDpDI2ZiWGpprBuyNilnrucdMqqwAfB6fdRcY+oQN0/T6UbB8+wEoMR2ZbjxkyyZvxpEhVoRXcgok=@vger.kernel.org, AJvYcCWtYlxBbIR4v/T9Nqjgaa33mAlcVhyLebcSVe3rww50JiACY6IBTdD3CsrS0Zps3eYdRVgxJqGwuhFMR7U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbdwl4q9xdSrpDYoK0yXjHZA25zQUXCibLrbHW9JEG/6+dKOea
	/AoN2T8h57mFwW6GFr6XcZ5JN7/CUXidyPLm0XgmKKP0vEvJesUT
X-Gm-Gg: ASbGnctWYWUVZgs3vhDQm6Bo+ZqDMZ7s+2L5B/BvkefreXdDSk6t5xTZHn5R0HL8D5m
	lb++zidOCsy+FaL62E96baOLaOUBSKSvn/qOHEeDVhxXxeTzAQn93eBT2tuyV6B8oAlqdxMwD0j
	qc7CkdMa3OEA20f3tuJbTxsRnHdrQPrmQ8iY5BtsKzhy+pjp17tRvnFLVrIrF5LhJxjH6u3tJgF
	UCKFwTsiiUuJk0puo+VzrWyDbuymjog5AnIoTSfXnrz69Q=
X-Google-Smtp-Source: AGHT+IGkajd+wXbub1dVhniWHfN5HNxSkBjvscahKPLZ0y3K4evPJwTrTBCiH7ySlVKJBh8wV2JAqw==
X-Received: by 2002:a17:903:228a:b0:211:8404:a957 with SMTP id d9443c01a7336-215bd11c778mr13695595ad.41.1733195807686;
        Mon, 02 Dec 2024 19:16:47 -0800 (PST)
Received: from localhost ([129.146.253.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21597c5baacsm24105215ad.96.2024.12.02.19.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 19:16:47 -0800 (PST)
Date: Tue, 3 Dec 2024 11:16:37 +0800
From: Furong Xu <0x1207@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jon Hunter <jonathanh@nvidia.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, xfr@outlook.com, Suraj Jaiswal
 <quic_jsuraj@quicinc.com>, Thierry Reding <treding@nvidia.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH net v1] net: stmmac: TSO: Fix unbalanced DMA map/unmap
 for non-paged SKB data
Message-ID: <20241203111637.000023fe@gmail.com>
In-Reply-To: <20241202183425.4021d14c@kernel.org>
References: <20241021061023.2162701-1-0x1207@gmail.com>
	<d8112193-0386-4e14-b516-37c2d838171a@nvidia.com>
	<20241128144501.0000619b@gmail.com>
	<20241202163309.05603e96@kernel.org>
	<20241203100331.00007580@gmail.com>
	<20241202183425.4021d14c@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 2 Dec 2024 18:34:25 -0800, Jakub Kicinski <kuba@kernel.org> wrote:

> On Tue, 3 Dec 2024 10:03:31 +0800 Furong Xu wrote:
> > I requested Jon to provide more info about "Tx DMA map failed" in previous
> > reply, and he does not respond yet.  
> 
> What does it mean to provide "more info" about a print statement from
> the driver? Is there a Kconfig which he needs to set to get more info?
> Perhaps you should provide a debug patch he can apply on his tree, that
> will print info about (1) which buffer mapping failed (head or frags);
> (2) what the physical address was of the buffer that couldn't be mapped.

A debug patch to print info about buffer makes no sense here.
Both Tegra186 Jetson TX2(tegra186-p2771-0000) and Tegra194 Jetson AGX Xavier
(tegra194-p2972-0000) enable IOMMU/SMMU for stmmac in its device-tree node,
buffer info should be investigated with detailed IOMMU/SMMU debug info from
drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c together.

I am not an expert in IOMMU, so I cannot help more.

Without the help from Jon, our only choice is revert as you said.

Thanks.

