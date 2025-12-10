Return-Path: <netdev+bounces-244229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A81CB2A1A
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 11:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9731C303C829
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 10:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4978F3093D1;
	Wed, 10 Dec 2025 10:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jzb3qOLq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891863093AD
	for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 10:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765361332; cv=none; b=qApTvY7hFKUOJvsarjh313VwxBR8RY9A7zxMUFesom7IAs32DaHlSEndTewnvWx4nP1E9dLTAv3BuNTzOIrxWDzrjnbZ8dy7wUdWsJ6/UUqXabKVxXkoW8aSkfkaIC4xLc5sU/eyNTVGC2pfk1IJfjwh1Xe04H9UU51vpfadaiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765361332; c=relaxed/simple;
	bh=MJhTumMY+Rp+DB84OTm/RkSgYcX9Zva7nUwegUsKNpo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QXFSguEjCHw3gE++j6Tc+65TdGSK4PYA0oH9yEhZ+BUWdEFv7WdW6mxx6HcnnK4joXrNk+oIUjbRHCNQQcMlVFIJx51fQOb9/3iWtiSWFN+wDAuzR3IxQwmPg6xUSQrtwz8s5XjsdKz3Pmru7+3n7DXapDMWth9HxgHF0+/WK78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jzb3qOLq; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47a80d4a065so9978855e9.2
        for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 02:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765361329; x=1765966129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NseMtzZhpH2Cj6pYcRihbjYl8y/WsGV5r9gIyYoFNUs=;
        b=Jzb3qOLqFB4Fouv5sgGbieeuPevNpGH+oxW/P6lTAlx/cJZjbvKddmU9gUbs/nfqFN
         6qame/YInFT3R88TwuzSCMyI9WkCfpl5Ge80VZ+tdQvxDZsY0KSM60LyWEdNnd2mvVhm
         c0TV6LtjyQzujVG+u6w5a6Aui875ImuFtaL5ZE6wX3a1QzEqYHMvvnJPDBi0DG0AA2VO
         B1gN0p0kpiLTn5V7WLXOdNbDDGMKkrFG8Uj0+ozHlcalaoqsHYQmFWYBhVRzPhQ0Y60/
         odtkFAQML8hw1B2/vMn4erUQmXhSYr8wbhHNtMOxruwUOXV3SADowxJw8pJGcritPC8g
         ygEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765361329; x=1765966129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NseMtzZhpH2Cj6pYcRihbjYl8y/WsGV5r9gIyYoFNUs=;
        b=YN1QZrrAjJnxLbDv4eIMfPpUFObPnVOYsm1Icej7d95Et8qHD6esdtVNUHbKMJeS3f
         zLELQNs4VWc1Xa6BJEUccNa+7cB44LalTty4uDU3X6DHOf+VQdvDbsrkFzd7uaJvGT9i
         CrEuRubMBM9VE86DNOgmYPKtkeT8ObxokeKCoVH7GRD/fPuFsWMIuogtLSIuk61Plok4
         Ttv5iDrTA2v6Cz3NNFKXXCaR6fgCtt0cCoa6c8ewjLoLhcr1Jf9JGTF7tQIF8d6WBran
         Pn+hXcbc6ya8HM7m6Y1LbE9+YugJyy/u4veXqfOihEHz+81RDNiflBIAB3OlVOs68WP2
         COkg==
X-Forwarded-Encrypted: i=1; AJvYcCVZB3vm0zyQJn5xgaJZS9RKUcf/ygmrdSe1HLGPUklgcSL78hBHNaI4qdshKcUdehDYV4GGgBI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS7lWTgJNuEAs85RJeUkqNOpJlmahQZ6925eLgSb02/w+7SxFL
	sRPyJdFN8IEGjoWXe835VjLcQnfH87YkvgDGMEbOpOa0m7BLnJDI9Fo9
X-Gm-Gg: ASbGncuYa9ALYMr5rDt6frrpl4l4IPNgqZ/UbFbsliQR9QxqInI6tO8IpV/XOkg/8gX
	0/6CeYeG96DFqmGc2b77KqJwG1sbdTjKPy6+tLQa2i1s7qZXQ4Egi2naD5bKLG7d/CkarjGOlQv
	FpFXJEqPSeszfQ6DjqMv7tx1xKreq1ALsC8Z7igL8/4SGElw8DDaSuMRYIynDgNaeTrgenq5MIT
	gSYLwwiOeiK91jAh0DnRJThR6cJ9H+rAlQphvzpfHX9loHD7YCDFUje1c+Ht8YjLSzdQKovkJHM
	xUO35rp6NwzLgY23eEbfP40SXb5TML+BQCbh7Q6mMID9n5X8VajhMyPVWhF58B+tGw04dn/il5l
	yMEEKE97S5vvV+E155+QhILRLyIr3iy9adgvB7o2j81UftssHd3Gv+ArFKixvDo8trmQqtxuuin
	/cxkjjCcYcrb9Pz8gK4svIVN+RfsdhJo02jTO+1CmZYPnv1oNkIJE9
X-Google-Smtp-Source: AGHT+IFEJS4gDpOtkiXbQ4hQTDHkTmoqgl6+D6XpHgC+rNy3vgC5+/pYYcJMyggTtOaqPE8b4aQw+g==
X-Received: by 2002:a05:600c:3151:b0:47a:814c:eea1 with SMTP id 5b1f17b1804b1-47a838534b1mr17827505e9.35.1765361328735;
        Wed, 10 Dec 2025 02:08:48 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a7d9d23e1sm38527975e9.4.2025.12.10.02.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 02:08:48 -0800 (PST)
Date: Wed, 10 Dec 2025 10:08:46 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Crt Mori <cmo@melexis.com>, Richard Genoud
 <richard.genoud@bootlin.com>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, Luo Jie <quic_luoj@quicinc.com>, Peter
 Zijlstra <peterz@infradead.org>, netdev@vger.kernel.org, "David S . Miller"
 <davem@davemloft.net>, Simon Horman <simon.horman@netronome.com>, Mika
 Westerberg <mika.westerberg@linux.intel.com>, Andreas Noever
 <andreas.noever@gmail.com>, Yehezkel Bernat <YehezkelShB@gmail.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: Re: [PATCH 8/9] bitfield: Add comment block for the host/fixed
 endian functions
Message-ID: <20251210100846.04e59dcf@pumpkin>
In-Reply-To: <20251210182300.3fabcf74@kernel.org>
References: <20251209100313.2867-1-david.laight.linux@gmail.com>
	<20251209100313.2867-9-david.laight.linux@gmail.com>
	<20251210182300.3fabcf74@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Dec 2025 18:23:00 +0900
Jakub Kicinski <kuba@kernel.org> wrote:

> On Tue,  9 Dec 2025 10:03:12 +0000 david.laight.linux@gmail.com wrote:
> > + * * u32 le32_get_bits(__le32 val, u32 field) extracts the contents of the
> > + *   bitfield specified by @field in little-endian 32bit object @val and
> > + *   converts it to host-endian.  
> 
> possibly also add declarations for these? So that ctags and co. sees
> them?

The functions are bulk-generated using a #define, ctags is never going to
find definitions.

Adding kerneldoc comments is also painful.
I don't think it lets you use a single comment for multiple functions.

	David



