Return-Path: <netdev+bounces-129554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2FD9846C5
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 15:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 961861C21D9F
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 13:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D791A76AF;
	Tue, 24 Sep 2024 13:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="s9YZZySS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15331A706F
	for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 13:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727184783; cv=none; b=XUx3pz2Yh+N4tEOQ2mOsX53scTGHyuO73zJ8gkX9Q0yKblQBCY1ae/lr15Qfl4pI77ZzHK3iBRXuaWB61kB7KGonhHRRdzY2QnsW42oGonKPZOlnEpKdiU7kowOecJygMRE0ovl3OXykVDw32Og+wrPoQ00ZMKPKgru2RZE1GEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727184783; c=relaxed/simple;
	bh=zyF69t0jxLA0Sg61b0pLpjejIj55t5UUwOvTfHql5NQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V2bDzyARyAGe53AKSSdIUXnXe2s/FVHFKCBzJpvPGTi8Qv4YKAYoqaW7F/uj61Tve1RxcP0s7EGBQF0jduQzPZoB5oKSg3skWRvMmAOYozhXFGKlIiMf4AwQl8R5ks+43BJbgxNq2gNGkB3zfxqVf8EOahDQ1QzjmyHtXHNgat0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=s9YZZySS; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5e5a0519d00so1197280eaf.3
        for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 06:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1727184781; x=1727789581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SFma2tLGVK6CuxpMi6SW8SNJuIb6p2HSu5tYW3xDL8c=;
        b=s9YZZySSPcKPUZkfjiF+7bPJacuioGCrVFWkdkaLtAu5AUjezKNxbw38Yx0/HTwGXj
         vS9o9P/MNj6ylI7ypfO8E+7/rq1QkAo70B5b0w1rwRuGCKWHfO6Pt1ZUvGWxj35i3mpB
         Q0dof6PTYJW8NPstWyM5b0K/hcL9gwlW10zA6qp2mKBZgoeQxCu8g7KRpD1+/gOX1d33
         Q1UIfO8qy4BdAENUdMJao0IeN5Pnf0bAwuMZd66f2YWtLW4qhtNNnkJ0uT8flpnBpTHA
         lP4fImieRNOSqbWAlTGzEK825rP+cOUtlfRfX4rR7HKJWSrdcwnjo9uJ85oeFh6AxJ24
         VcMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727184781; x=1727789581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SFma2tLGVK6CuxpMi6SW8SNJuIb6p2HSu5tYW3xDL8c=;
        b=M0DUx6m3ORpTBm5sm8kMiTSHrskObaZnyJNRRhENKLHW0kjuGJpVHmLFnqnmgteDPt
         8iRB0BmAkXs+dgxf03wwtkSIJHvp/BqA4c9QAKRF7kdMfzzQFmnoKQeehGY38q0C0cG5
         LP1m8xXP7afcLNY9VCv2JY2dmRYcnJ0yXco2pp5ijgi3256Uk/Strcu60M7LtTxQaqQq
         H+bYH4X2/tMiZtIHHBIaCM1jOOAXC7p0KI4mzRgnL+hvwRycxRsSCGdxLn/b1qOIQso9
         oGjkhQ8n0iM3VhP+d6mXjS7CZvkysRjkuIQC7BP+pxBRgKYiURERduQaj+jrz/8dDcIB
         tTDQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7Ft4oYkEWCyxdRhQVSX7mcLjE3bI7n2krMc7pGoMR23xhwIvXtpTPKNEbKSuAtPUVnIQyIyM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqv3k7xcHrm8OYctlBDCthLV8KC3z4WxNZSTH9Xax+06eoDjlo
	ZKtyQ4P7KxCRejYsNJtffVACd4XPTWRPe6xo9R85a/8UEgvD6LcTY7b+COkGxmY=
X-Google-Smtp-Source: AGHT+IHyraTLMnSqfRhvqLf0XswmKqahjZtmkjaSKk0J9EX/vsul6nQxVKBsx4075Q17ZvK3zidHsA==
X-Received: by 2002:a05:6358:9107:b0:1aa:d6fe:f422 with SMTP id e5c5f4694b2df-1bc97627978mr258305755d.18.1727184780859;
        Tue, 24 Sep 2024 06:33:00 -0700 (PDT)
Received: from fedora ([173.242.185.50])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7acde5cc309sm68452385a.84.2024.09.24.06.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 06:33:00 -0700 (PDT)
Date: Tue, 24 Sep 2024 06:32:58 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: yushengjin <yushengjin@uniontech.com>
Cc: pablo@netfilter.org, kadlec@netfilter.org, roopa@nvidia.com,
 razor@blackwall.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, bridge@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] net/bridge: Optimizing read-write locks in
 ebtables.c
Message-ID: <20240924063258.1edfb590@fedora>
In-Reply-To: <14BD7E92B23BF276+20240924090906.157995-1-yushengjin@uniontech.com>
References: <14BD7E92B23BF276+20240924090906.157995-1-yushengjin@uniontech.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Sep 2024 17:09:06 +0800
yushengjin <yushengjin@uniontech.com> wrote:

> When conducting WRK testing, the CPU usage rate of the testing machine was
> 100%. forwarding through a bridge, if the network load is too high, it may
> cause abnormal load on the ebt_do_table of the kernel ebtable module, leading
> to excessive soft interrupts and sometimes even directly causing CPU soft
> deadlocks.
> 
> After analysis, it was found that the code of ebtables had not been optimized
> for a long time, and the read-write locks inside still existed. However, other
> arp/ip/ip6 tables had already been optimized a lot, and performance bottlenecks
> in read-write locks had been discovered a long time ago.
> 
> Ref link: https://lore.kernel.org/lkml/20090428092411.5331c4a1@nehalam/
> 
> So I referred to arp/ip/ip6 modification methods to optimize the read-write
> lock in ebtables.c.

What about doing RCU instead, faster and safer.

