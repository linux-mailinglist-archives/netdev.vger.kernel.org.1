Return-Path: <netdev+bounces-148303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FF69E1107
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 03:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F532282489
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 02:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB6F6F307;
	Tue,  3 Dec 2024 02:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEphATNF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24D517555;
	Tue,  3 Dec 2024 02:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733191424; cv=none; b=sdw0gPSlm0r3/4kgyEnDP73mpSzOnrwx1Rz74eYOkIxJsPT62FLiT2mijEbRPyC56Z56p3PKlYmU4YxMD+oI29fUgQfnrLtJICS9bAU86RtImDuKllTEF4LbemZaqBrc+TJYt6Uq6IvBiMo8LK8t8CI79wtZJS0XNRhvwlmz/VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733191424; c=relaxed/simple;
	bh=oGkL1VT2CFKlGNx4pw3YpRidsPj6S16ZFLrKXPdlAoA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FdB3Z95TGAMXwO1os3mmlEtSBRCIPk2/ogiUywZf4TSUlY347vDlsMopmvuN3ECPKM+B0UgRTqwCT9Fl3fRk+D/Kuer9QZ/1gIuAqgvkA9DFTTyN49HylmJzjhfAiqjCJ3JruUkIYhwoDqoRboNlglL+t6CwPSYxzXDS89wQ0KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EEphATNF; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21577f65bdeso14813725ad.0;
        Mon, 02 Dec 2024 18:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733191422; x=1733796222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZtsxUMh+XFIIoRCLBTewSQ7foIeXplcGO4qMt8g9uHM=;
        b=EEphATNFtZgF7FDJvPA9EVX896ymv5PjWHvdfvPGUO4Nmg0vpx4fkbDzea3sPTBgVB
         6G1+VT71QhmCFFrC9ezo6cMIprowQS+WfzNH0jx3gwvMRvcW5pDlhbTGuOBRlYYci3tr
         gKT8DUPoRj/6C+fkY1q0QCYKM6V7ZG+Cywhhzbs8KA8vpv8HjgSfmUO5tZmQQyF5gGPa
         ivGkjEKrVG+oAjt4bezDyHmNbyxtlD5ipKJv5vZr/LapyUsvgFfMLtKyn0dCvnyWSc/7
         Om4Xz2T2StxUxIIO7P+5nDWyykn5qJZuwVBtn5QMyWSuxOluavW+oRnluquDOGA/sD+y
         4Y+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733191422; x=1733796222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZtsxUMh+XFIIoRCLBTewSQ7foIeXplcGO4qMt8g9uHM=;
        b=pM00d7lOxkMGib9KrxCwkBCLdLjFpkVe4M/1zED+nITF6Ub48L/LTPMHrxlI6kHqiB
         fooqJpu6lwK5UxdT/30iUSNhDrkj7wDFpkjovMI97rEZcqTuvwa5eoQ4X6cx11ZDddnx
         cG9D7pCekarJY0ULWYiH41HrejW+QjW0poQxR+I5D3LWQwAO2wPPdI/Ll293MJ54tBgm
         fSdw1nM/DuJsN8GKK1MlmgcMyHeKahG4t8HALCbqPLdieGvgT0uIsKCuXliRareuvUtx
         OQbVVaK3tU04qoXCTWed3mSIOnviJ587JnrqdTWc1HcZgwXC0zZZEuVKZuhW7sIbesTt
         TwvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRJlHqIwdmK/2uLvR7SAPfqEEyW2bIiyCdPZLSmzM8z3aKCw315+d5oNQUFgqBMzBK2Rk5jZ/Tavj3J24=@vger.kernel.org, AJvYcCX+TLOgbyoqr63Re02mM5R689/CfmEk/zrPp67xkltbCtWsFSP3MIK8mV7aghKgUL9w1aeZd7pu@vger.kernel.org, AJvYcCXQaxwlBMcue6cGFNNaiPEMnU4bzq6P5ZN+8vIlCi/D+kxOK69MpRGn5PgzuN1jXYt+Bh0w2ewi2fLGMt4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKak8uYdOzhb9m160iMocsvIxftH9lPdyEF/KgQhcdGOC+qc8i
	iOLNW3E5XtYrd64A3s04QD89FBmuo1Tz4wZ5Jr0CsC9vBtbgFJRFK/5Q4A==
X-Gm-Gg: ASbGncvab3CxUFsO+c9Z7QrGxr33p9z0ERUyIIHmXuFi8ac5FK6OWi/tgXtSH/2h0np
	PVhbWHjwXM4uvkyH13rWVkhK6CqCmSbJ0Yp+Z1q6Jg06/zwpiPYrfTiKor3Hm5eq0A2GEh10Oxr
	o+s+l5P5euRkEuf3YKLL0xKyrRORC3fGXWlHFRuMUvWx75fPcNP7B3E6HrcNinGAQmB7Tp8UnjO
	tTZYYNaFwXb5JSH5+eCjAEBFkXnAr8FakwXL+nbCxbYteI=
X-Google-Smtp-Source: AGHT+IGntlHzteD8zmiU7Ily9CXIelHYFGfjQVFqN0cuB4JWz37qzC5Ex1Ovks7LVjLzw+N8Yz3xAw==
X-Received: by 2002:a17:903:186:b0:215:9eac:1857 with SMTP id d9443c01a7336-2159eac1b3fmr83999545ad.5.1733191421771;
        Mon, 02 Dec 2024 18:03:41 -0800 (PST)
Received: from localhost ([129.146.253.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2154764f312sm63036215ad.102.2024.12.02.18.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 18:03:41 -0800 (PST)
Date: Tue, 3 Dec 2024 10:03:31 +0800
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
Message-ID: <20241203100331.00007580@gmail.com>
In-Reply-To: <20241202163309.05603e96@kernel.org>
References: <20241021061023.2162701-1-0x1207@gmail.com>
	<d8112193-0386-4e14-b516-37c2d838171a@nvidia.com>
	<20241128144501.0000619b@gmail.com>
	<20241202163309.05603e96@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Jakub,

On Mon, 2 Dec 2024 16:33:09 -0800, Jakub Kicinski <kuba@kernel.org> wrote:
> On Thu, 28 Nov 2024 14:45:01 +0800 Furong Xu wrote:
> > > Let me know if you need any more information.  
> > 
> > [  149.986210] dwc-eth-dwmac 2490000.ethernet eth0: Tx DMA map failed
> > and
> > [  245.571688] dwc-eth-dwmac 2490000.ethernet eth0: Tx DMA map failed
> > [  245.575349] dwc-eth-dwmac 2490000.ethernet eth0: Tx DMA map failed
> > are reported by stmmac_xmit() obviously, but not stmmac_tso_xmit().
> > 
> > And these crashes are caused by "Tx DMA map failed", as you can see that
> > current driver code does not handle this kind of failure so well. It is clear
> > that we need to figure out why Tx DMA map failed.
> > 
> > This patch corrects the sequence and timing of DMA unmap by waiting all
> > DMA transmit descriptors to be closed by DMA engine for one DMA map in
> > stmmac_tso_xmit(), it never leaks DMA addresses and never introduces
> > other side effect.
> > 
> > "Tx DMA map failed" is a weird failure, and I cannot reproduce this failure
> > on my device with DWMAC CORE 5.10a(Synopsys ID: 0x51) and DWXGMAC CORE 3.20a.  
> 
> Let me repeat Jon's question - is there any info or test you need from
> Jon to make progress with a fix?
> 
> If Jon's board worked before and doesn't work with this patch we will
> need *a* fix, if no fix is provided our only choice is revert.

Thanks for your attention to this issue.

I requested Jon to provide more info about "Tx DMA map failed" in previous
reply, and he does not respond yet.
This seems to be a device-specific issue, no fix can be provided without
his reply :(

