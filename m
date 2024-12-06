Return-Path: <netdev+bounces-149804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE549E78B7
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 20:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BC3318844A9
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 19:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55CD1CBE8C;
	Fri,  6 Dec 2024 19:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="KPr1iBy0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1649714B08C
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 19:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733512697; cv=none; b=NG0W8ulangydQtRAPD4uOSfNXFVL77Z5le24DseDbMvesql6Z9HPKnYy3rKOaVHQ48wbDMwo6KcFYW2jLvi/TaGm8mFi43jl//rBfkgL8yrC9j6vi52fJROCm/rNXBYK4M6gNOBLnadMhod20dUnoxmbwTLR2L6KIyHTXTr6ZzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733512697; c=relaxed/simple;
	bh=XXEsKHStx4nAG+6QErJ1NiHGu6mTByr3YcI0FFX/DLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=boLoYEoBm0svvc8A8MYAIHWjGnn5HxY84xq8YXD7X5DUTj07G9MJdI2ncCF2ig6QZqMjO2gjray4HdmxLbxXb9Una5pa/tjm+whH/bqebCWt1L5vgSzmELIaPsEjLY7QtxZmH4VQViGPewRRJRYg6Sq8Mw1fdNdcW3WTFYNcMoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=KPr1iBy0; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ffe4569fbeso33772231fa.1
        for <netdev@vger.kernel.org>; Fri, 06 Dec 2024 11:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1733512694; x=1734117494; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XXEsKHStx4nAG+6QErJ1NiHGu6mTByr3YcI0FFX/DLg=;
        b=KPr1iBy0FrEE17TDfJQI2s6Azr173ocp+ycFX4CUZxKV5QPV9KWtlZzC6qYpo35+cg
         3ox9ve/sGFGjdcJugZFImoC+fRQMDPkWo3c0OT3eXyUSUZIIYibyvPY8rDNfdIRp3eQF
         0H0DjYbEGDyr5Bvc9MgduaD8atznpsEd6UmeGOjaa41KxWLTXsSEQyG57lNOZtdoenJW
         udM7+1qdBwhOIthO6cTpCNRazUhVYTvZfkZdY3GC+xRKlP9Ma7yoK6m3TYaecr44ZDBO
         C1f2/hijYyM8YmsIYcUJrHBOlxGtb+ZQaRJjMzgztALJiT6A9TQzSt2vZffRKNrTQfDC
         jAgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733512694; x=1734117494;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XXEsKHStx4nAG+6QErJ1NiHGu6mTByr3YcI0FFX/DLg=;
        b=MAdbKhHuKxTD1fvll5CIOeEF5kop799RTVUghZiKGyQjPcMBc0uGjPtjyv4MPhqSvw
         VqmlOp8LghikZj15SX18CQZbCeIWnXc5F9RmO02crJlLroEY3xgOTF6uz4RkvWb6qCs2
         aF7s/REJ5zVf8ztVfLeX7O4oVIbqoWb9MBUVsMDbZdUco6aHlmhmwPyNBLt36eeIWLWF
         XmcMxvZ6HIv+oZIzBlay6//IEnfUk51w5rHTMN/1oIzpYEiP4Kipj1p5ihVuj/IPe8NN
         zhCdtq+KY8VX8ofzG506VcMNawrOPED+kNmEFO1JwvsyxYpWCF+6OdVBwJdMC7i9HSXI
         hnKA==
X-Gm-Message-State: AOJu0YxJsXcX59zwnAE7CtdDdsVcOq+PVJwY26lhR9zk0p7XtLM80wxr
	qnknRgtobj8hm8juSJuK1hOh1zyn11Yr7uH0UoVd+3VEKZQjqh6bfDeReMtp6CQ=
X-Gm-Gg: ASbGncul8awCctyQOwlFFF+DnbyzpzSnI4kCIeihB950gLXSHL4uHxL7yVv0i+L873V
	JEHe3S4wnTsdBwlYcwJ4k1oVKCc+b0YaFWjl42yEpXvN/S9b11AxQsYgnPfjdIYQsbrFmDhsOzT
	8r97uhWW9I1SUdToBt4wN4LKpg31hNBaFfbI3rzur2Sd/roodFFvB9tC6r5LGzblmSIoJh1j0kY
	0bkIIZoI9oAs/ArqlZy4VSILFSo1Lv8esepPbxRoLwvZLToDRgdY5ixYkX9lD5Rmc4UUw==
X-Google-Smtp-Source: AGHT+IGis4qREcli745RBFrLJcy+fcg/7cCX/7Rt7z8z904kRcAYTDaWI9H2MT/YlwbjEUPc5o2viw==
X-Received: by 2002:a2e:be23:0:b0:2ff:b3f0:68d9 with SMTP id 38308e7fff4ca-3001ea9934bmr32824321fa.3.1733512694247;
        Fri, 06 Dec 2024 11:18:14 -0800 (PST)
Received: from [192.168.0.104] ([91.198.101.25])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30020e56f44sm5485231fa.104.2024.12.06.11.18.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 11:18:13 -0800 (PST)
Message-ID: <b39e495d-dd23-4965-bc1c-b30db81be0f8@cogentembedded.com>
Date: Sat, 7 Dec 2024 00:18:11 +0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/4] net: renesas: rswitch: fix race window between
 tx start and complete
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Geert Uytterhoeven <geert+renesas@glider.be>
Cc: netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Michael Dege <michael.dege@renesas.com>,
 Christian Mardmoeller <christian.mardmoeller@renesas.com>,
 Dennis Ostermann <dennis.ostermann@renesas.com>
References: <20241206190015.4194153-1-nikita.yoush@cogentembedded.com>
 <20241206190015.4194153-3-nikita.yoush@cogentembedded.com>
Content-Language: en-US, ru-RU
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
In-Reply-To: <20241206190015.4194153-3-nikita.yoush@cogentembedded.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> 3590918b5d07 ("net: ethernet: renesas: Add support for "Ethernet Switch"")

Sorry this patch sent out broken, I've reposted it fixed.

