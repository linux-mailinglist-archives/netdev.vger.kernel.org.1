Return-Path: <netdev+bounces-204852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E19AFC455
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 09:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDC0217BA16
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 07:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B625F298CC7;
	Tue,  8 Jul 2025 07:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XaH7xx8W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E69298CDC;
	Tue,  8 Jul 2025 07:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751960426; cv=none; b=kly8cGVGyAZhCHn1AfbgcfaYKT4MFkEtggme77W9WOErvzAqM9lafzH4ggj3KS1F2qGegKtKzpDYLOfvFTzESEgbCmdLxcitLnVCrb5attrDTUitqi3BveKHo+pxCzJLt/WMjwFZ02kgLYd4ydK9hRHbEBIc+Fr+hONBTq1ndr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751960426; c=relaxed/simple;
	bh=IpoH5UJKnM+pB9pdNFO2rnnCUQXu6j/qNm4FivVuSfk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=RMGseDUeJcyMhOwo0gpr/e8oLnPp3wcEwijTT1WSq3IOfaY4rwA9HhouK7sW5aYolzd4T99E1KoX6GOuYeJpNAcIkgRw7nJ+kpV+7hLZszpghmFVWT3WDH0H6xSVvojlxvp6QbOtO+gpzT0nlw9qiU4LXqIw+zH0gDeNgqFEv5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XaH7xx8W; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-32e14cf205cso32669411fa.1;
        Tue, 08 Jul 2025 00:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751960423; x=1752565223; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IpoH5UJKnM+pB9pdNFO2rnnCUQXu6j/qNm4FivVuSfk=;
        b=XaH7xx8W3WYk4X3ATbOlQXI/BmBLvootclHWb4sRi8PA1cqNGvk4BXQvkl2OlvZ35f
         ZDzD3XXqa/otdB25hlHajJgSZDIPvDTj2v9sKZOFR5vCHhiJcsKtkIB/QaRuI2/x0ZjO
         CTj59UM+yj1XLuUTMKlFV8D2l0c79vLmI+qukwkn7q0nQFDqez5Lsa1DYL/b8BSjjFUh
         xu8x8w2smTAPtpXepHs+Oi0WoM4WDgTpGDaYJC+ybUHy/+ihC4LzD/2w/2fgUY23Kbi7
         wHGMGRq/l9/VPZJZfJ8cIaIK2WSHIDY5PkeUBUdgor4XOecavotrIRin5IYddRNhVuB2
         rhZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751960423; x=1752565223;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IpoH5UJKnM+pB9pdNFO2rnnCUQXu6j/qNm4FivVuSfk=;
        b=s7pB8QRZGbshov295VgKzTzBkxr/fWqDzYy7e0T/nRr0k17a+pywAvr8ets+fu0Cl0
         sTP+JhYwjDclvhgOcikyfM3voITJskfVKl/guNOaEmyLrl5E5OhY1IOxlmjafffUEWKH
         cL3akkwKjQZiSugGtWuzRWdyE9vYdOehpKjDTRHtDRyg8j9+X9a610cIpjVXhmTLV6MS
         JPHLw+9cEAVk4qBCfVtUHa0lCN48v/W1YfqvXcYMghrQbh9d13g/JhsYXKQoJ9FMDjj/
         PFVgZ97Szly5AqwO3HVCGBaXhVNL5H0Ft5ZFehen2EbWK+nRMefSEg2gL+D+aT9i3QGx
         wV9w==
X-Forwarded-Encrypted: i=1; AJvYcCVepDzoHJzYNFJMI01Hqv0+a0zTBe62aWPmVWTkYXQDjjwjpQK3yta/jULWHa+PW+2mF8cz82eTVb5Zlgc=@vger.kernel.org, AJvYcCXwzHIH8axDAl3+NzZY/xBmssC5zrkraD1Igi19ewnqT/34o/omxhmMa1BGyTYOaI0eG7Exsnvj@vger.kernel.org
X-Gm-Message-State: AOJu0YxEX27PzODxJyPSCVrD+IFh2yzsY3VeHknseS/TxmKoK5ga4sCH
	bTDzqgLUD8H0EcN/G2DEvaeTuB7w8z8T/OzJ6QiovekuA5qi4fyzS7AV0tz9MiRB1/TOLg9ce5S
	BSqbjU0JDjTnLeF5VwrO4wO92agdaUXk=
X-Gm-Gg: ASbGncsMM4RwgXR+EYwGYNP60SER2wphpyBWz3vLvTH5VNkbf1HbYy3WQ9kSQJHKyz/
	J+1HU4vS1mwe6P8mqXQQAAdp97xBdxBcDkb68eFg0YB3I9VBuJlYqTtVSOfUk6HwkvUTAvAt+TJ
	UZTR91YuDpX06vZs0qaYw5eN2XOIcMWUFj6vuugkpVj2SfF1IWeO0r8/Mlf5s3kIxCAQ==
X-Google-Smtp-Source: AGHT+IFN1H28agSvPK20T3e3S5R8SKpFL5I+d0jGXr1zZXskHqT+qpvaEJrcZ2tykFzB/uIoAtiSq/SDDWdnFP+iUeg=
X-Received: by 2002:a2e:a549:0:b0:32f:219d:75e5 with SMTP id
 38308e7fff4ca-32f219d7aedmr36283691fa.33.1751960422829; Tue, 08 Jul 2025
 00:40:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Luka <luka.2016.cs@gmail.com>
Date: Tue, 8 Jul 2025 15:40:10 +0800
X-Gm-Features: Ac12FXxi_pU10RtKw7JiEpXK5im0OhM9BC6DtNU4SZiTTcFHUP94roVdFSAZkTA
Message-ID: <CALm_T+3m_BDfKz3kPm_PmwH9BnsSySGxHE-hdceGQzObL+M6BA@mail.gmail.com>
Subject: [Bug] soft lockup in __sock_create in Linux kernel v6.15
To: Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear Linux Kernel Maintainers,

I hope this message finds you well.

I am writing to report a potential vulnerability I encountered during
testing of the Linux Kernel version v6.15.

Git Commit: 0ff41df1cb268fc69e703a08a57ee14ae967d0ca (tag: v6.15)

Bug Location: __sock_create+0x369/0x810 net/socket.c:1541

Bug report: https://pastebin.com/X0NX8ddd

Complete log: https://pastebin.com/Kbsk4Qrc

Entire kernel config: https://pastebin.com/jQ30sdLk

Root Cause Analysis:

During socket creation, prolonged lock retention within
__sock_create() leads to a soft lockup, suggesting a potential
deadlock or excessive CPU consumption in socket allocation and
RCU-related memory management.

At present, I have not yet obtained a minimal reproducer for this
issue. However, I am actively working on reproducing it, and I will
promptly share any additional findings or a working reproducer as soon
as it becomes available.

Thank you very much for your time and attention to this matter. I
truly appreciate the efforts of the Linux kernel community.

Best regards,
Luka

