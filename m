Return-Path: <netdev+bounces-155324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FB1A01E2E
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 04:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDE6318838F2
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 03:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6F719C569;
	Mon,  6 Jan 2025 03:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wja/fxbY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E88194ACC;
	Mon,  6 Jan 2025 03:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736134300; cv=none; b=CbJVrvSYoKO9BKu6YIfXfiqGYhB+fwtGxny1Qdh1x56QHvKr+P7QCLlrjih7cpdPOfHH4OaVjpGzX1/N8BCUtc9lCtPoW+UsQCb00v3uLmvgAmbrfhY/zWwXSszftfh3cahkEz9pJFYr3eoWdNdQcHtjv1dqRDh0P0ah2ozXDcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736134300; c=relaxed/simple;
	bh=f5OVWMw+9aBuLn9NAJuvR0M29BPWywB4LOQsgcIZV6M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IeYf+bVdaJlJpYeMG59e+cFLoJj3Cp7GIr4/nKSvItRcbWZxZv0U9a70IB97t1BmJ3JaIIm9Pzk2WVZWpXVpk9zV9nJ9rHd/YvYFnWYHCn1pqdNy9T5TJaLQN/UmQETndkwSUc+HzqiSdg5dMSf54IrTYvKEaert5kV1E6o/GoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wja/fxbY; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21619108a6bso183616565ad.3;
        Sun, 05 Jan 2025 19:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736134297; x=1736739097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R8mP8DEnmETe5Y+9Sxyec2gKqq8KbiwpR004KnVNE+M=;
        b=Wja/fxbY6h+PNADUbFqV3OT9l0rRKXi+0Wu3VWO4HQFTkiZqwxxDyVy1TxvFKqzO4y
         +7ZUuaq0VRV/HxYHty1lL6QUbZUuiF800Xq1ObuZTg1I6EEdVb9c4WeGDsHB3mJZolhT
         TR9UdavMkxHHGLhdWJ38YuIa/w13hct7lLjGDMMeM+qyRSXKSESnp6+eHkfLWZBFqVdZ
         X90W0R3MzVwOWoGMZnHvhYoGj/pDRQYG6waycZ9CrLlW6GhQtMALHYxKqAvRTupu7Eg9
         +PWGX5oO9GcHAvXhBO6JO778r/3vTzten8+d5PMIGtvt2onMd1Bwc8sJmTL2O4dcbAzx
         eyxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736134297; x=1736739097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R8mP8DEnmETe5Y+9Sxyec2gKqq8KbiwpR004KnVNE+M=;
        b=KHa+HuVNsxJb7sm0J2pCBnGPVyrhjcBZoeJJGUCyi6fzoFv4zfFRczEbgllrMP2VWX
         UJeXosayO/21o+YK7UAXwsW+yj9/Uk++hhHUTY2JzLpJnUoQVrie+D1ONwDWSgiJWuFW
         9/sfBIbn0yI15nvaM6sdDVmFm9JLKWXqrdp9w0rsRlreMkamfod1gnNW3yHXPli+NGvP
         YUR7qKPo4c6x3BB8mZnlomSDV+bxJLjgPEfpFYM99z9+Z7Zic2aAl12KqrS27IJWDVmQ
         +18bALcXMbSWbhPmZPxYO1CmH1R2ubLPa8L11Mz4cSc7c9q8qA9IQi0I+gVZ/1ahAvIV
         lD+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXcccNUx9MzDJHnReOyagvNhpvB8/fFzRwsfuhkFG3/8vmC4/QgOBBoyjAeiOQTG4KliWbNHJIpBuK2bDc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz23U6ARICWRryattjOkGRf9ejCFI6Zv+ioOLVklHN4dnsoeYH3
	TbBRFR85FAx81+qMIOb4qb6L1UbodduRAzHthrqHzRwWOeILbPfF
X-Gm-Gg: ASbGnctzFfkpcXtN7IUYxnKM5f8eYYI0ohxUObJyxlpCOv1JCcCBXgthLeZMCoTWMpZ
	psL3ZHwtwPKMAniBwcq48QRoedUbKxpcD47p/k5PjT/f28Dvgm46ihBqZdSWzffU98Qa3M5APQo
	MAay+biFctow5887xbuNwbdpdGydgb+m3jsUMAE1yjuL43Dx3fnk7acdz9OstJ3DqyP1oC7Okp2
	OEeLMC/5FuNkoEmIs7Wxm4ut3tYjQdCr4k/gDsQNQqrI2VXwUmuvw==
X-Google-Smtp-Source: AGHT+IHKgl25h++MZ9dMIYcDr7ijqZ34klV8XDrGpkkwiq9K5VDL0wWtjXsOpVOVhNImJE3EBbKBAQ==
X-Received: by 2002:a17:902:dacf:b0:215:6489:cfd0 with SMTP id d9443c01a7336-219e6e88028mr710992755ad.3.1736134297225;
        Sun, 05 Jan 2025 19:31:37 -0800 (PST)
Received: from localhost ([129.146.253.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9d4645sm283394795ad.168.2025.01.05.19.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2025 19:31:36 -0800 (PST)
Date: Mon, 6 Jan 2025 11:31:23 +0800
From: Furong Xu <0x1207@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Jesper Dangaard
 Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v3] page_pool: check for dma_sync_size earlier
Message-ID: <20250106113123.0000384b@gmail.com>
In-Reply-To: <CAL+tcoBfZRNrHarZzmRh0ep+QrfZOntm82hECNb=aMO-FdmH8g@mail.gmail.com>
References: <20250106030225.3901305-1-0x1207@gmail.com>
	<CAL+tcoBfZRNrHarZzmRh0ep+QrfZOntm82hECNb=aMO-FdmH8g@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=GB18030
Content-Transfer-Encoding: 8bit

On Mon, 6 Jan 2025 11:15:45 +0800, Jason Xing <kerneljasonxing@gmail.com> wrote:

> On Mon, Jan 6, 2025 at 11:02 AM Furong Xu <0x1207@gmail.com> wrote:
> >
> > Setting dma_sync_size to 0 is not illegal, fec_main.c and ravb_main.c
> > already did.
> > We can save a couple of function calls if check for dma_sync_size earlier.
> >
> > This is a micro optimization, about 0.6% PPS performance improvement
> > has been observed on a single Cortex-A53 CPU core with 64 bytes UDP RX
> > traffic test.
> >
> > Before this patch:
> > The average of packets per second is 234026 in one minute.
> >
> > After this patch:
> > The average of packets per second is 235537 in one minute.  
> 
> Sorry, I keep skeptical that this small improvement can be statically
> observed? What exact tool or benchmark are you using, I wonder?

A x86 PC send out UDP packet and the sar cmd from Sysstat package to report
the PPS on RX side:
sar -n DEV 60 1

