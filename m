Return-Path: <netdev+bounces-245839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 32466CD9003
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 12:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 842B03012BD3
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 11:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3F433E34E;
	Tue, 23 Dec 2025 11:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OOuDMXHv";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qbm1Wtj7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D5A33D517
	for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 11:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766487606; cv=none; b=Sq9kq6LrKIzGtALxb8Uhj1tYwEsZiH9BOFG0Kv7rOt0sFoLaxGo3gvnOAlteXI6orG2Bf7pMf+7MuJmeL7xtVO23AdDZXmsfxdyH2amRION9+VZZl5pYGwvs/ysGvuEblfsc7LseWz9+B1AuSplH6aO67OzwXnHGV0dbnJ8fb+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766487606; c=relaxed/simple;
	bh=exDMAq/h2GKUuEGGzdMyph1AJA3f2RvGq5OEfZ29ohA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=c4i+knngP90BQw0QOQrpul5A2B4UkkhcVh49FUQQzmx32Tcl1eoRfTkU1muQLiZpcjVFrrE/0gLeUeRaDAHTlKusoZC5R/ASjkWRU4wRWMCdIBYE2ZEZfTtYJpm5Om4VswCEfN4zvhzrmJ5LONsNy06aat9HJxhYQs1gzXSBJKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OOuDMXHv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qbm1Wtj7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766487603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7e8prqN9qrQUnG40gwOc6ZnlIPJonuHZkFyNzxEWkZY=;
	b=OOuDMXHvuHfqKFZaGspf6LiusJEDJr9DlvXooD+Gztso1pZS6GlZfjcVu6/NoelpMFeNpf
	2lLXai4BTDsBO0yNCyTPwbwzNH6yYjSdcGrqvgH5IBXJS6ZuBhzi0enpYyuOJOx7HRHYL7
	KLPMg91amQHlZi9XXv9V15nL2brZiL8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-UA3leP7ZOACli3g5OOUmnQ-1; Tue, 23 Dec 2025 05:59:59 -0500
X-MC-Unique: UA3leP7ZOACli3g5OOUmnQ-1
X-Mimecast-MFC-AGG-ID: UA3leP7ZOACli3g5OOUmnQ_1766487598
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47904cdb9bbso48489075e9.1
        for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 02:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766487598; x=1767092398; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7e8prqN9qrQUnG40gwOc6ZnlIPJonuHZkFyNzxEWkZY=;
        b=Qbm1Wtj70UsmIhEDochVCYLITXRWLbEv6yyGRGuGfeOR9OQK92Zt7LT9bQqd0N/ecM
         A/uGAInttJb3Yk6fFLWqoaHY0E0C5cmGxDJhSdpAOgpRr9ojwaVAKVVP8ZFtkwSYpffI
         MSiBGjyIK+3KsZDiTKZq2dXkJKsKtmRIqjIk8B6VovjqvVHuuoTqqfOgWtCzANo5BBq9
         8VMAF8veO5sCkYc6binPGXlb34TvkGKnytO1vPzYL3sLyNqD+YuaJsGwhEG/tYNzPhvX
         f4UYNvqOcb9/zQEjRgg0QSkmXGVuo4nZVOHKt3K8mXw3VyO84ICjoAXCNzsvrZOwiHO/
         uILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766487598; x=1767092398;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7e8prqN9qrQUnG40gwOc6ZnlIPJonuHZkFyNzxEWkZY=;
        b=lo26hCEW5PahaPzkzKN6veLUictz1w3U25CiqVnRImXJf8C6LhOxaZk04pLKj+Wc58
         3Ue2gGbT4oWtggodpem9zDduwpITL12sZjMVP/fw/cPHnQRs7NW5hZCRGhmX5PgwKrgy
         E6GthpCp73xWODrSgO5cjL7DzwttgRSstK1piUlHQ6g3T7YIKwrDU1dSCHsC+fptTN0H
         kcaDcTAJVj9dh5oWSiFQz14VAv4quQUMGT7u19w3zdI8T8CBa/NIxND9qcwPLT/xAYKZ
         6vcSCmvYgOpCJG+WVb0ESl6nrn9e/FanGQPBv+AfTsj0UTIs06jbOCSTW9+XE0/5xF37
         oBUw==
X-Forwarded-Encrypted: i=1; AJvYcCV6ZgeMavyuFbKfOJMuqnCvZ048S0TisOWWE32zC9GePuzBnyaa08ji4orKPfz3f2i2wnnviW8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4BjFEg09F8R/2vznbTp8qIkf+LwirlCSM5O/SjZD+J1Xt+pe4
	bRbRRlIIo1EVmI1uaXp9x1avHhnuIvdYs5h81AlB5ru2ByuV4jWi6XbgyiF6Y6jKqz+b5Hfz40D
	YMmYMD10Ej28j8z11xV+XeNSW44ASAptlDG40GKlfkWLuTejLFObZnnCg7g==
X-Gm-Gg: AY/fxX5vfQhjgfyRdKlMDNwOBPTHzxiK8RSeVbACUeDhGKCzTRS4kz/DEnPQTvQSUYF
	3C02xoT7Q5t74Vu4TSYKT3VXAPZhM8Dr3HzpSMCrP+4+CmgFVorEzIgd+I8elM/Npro89YHs9+w
	hBxjL+Lm2HTBuj8F+OK6h/N/R8K80xx05Z3QZzLDhRI2mhVKfVFN/hVwDjQP5zSkt2J389kIlmX
	xB0Z5ory2wmqhdS2CbSuEZCK0kKSsRf3LfChRPQN3ZjXzd07mpaOzI6cAOX8jC2UAcXqUGRcYWv
	uhHAel+xbaT5KZZCe3SyMzVPDUR2UL8UP2xAa/l1gtCmvJdcpvkw8RgKnfyPq/dBb38sWrNp9UO
	YtDFvPDnJXvUs
X-Received: by 2002:a7b:c454:0:b0:477:7588:c8cc with SMTP id 5b1f17b1804b1-47be29adacbmr116656165e9.7.1766487598062;
        Tue, 23 Dec 2025 02:59:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHkrQ8ropbitAp5IN6grRc181zuj+oDJatbka2bonXqMH16VVO9pVEQzrfe/dc+B1EkcHXjVw==
X-Received: by 2002:a7b:c454:0:b0:477:7588:c8cc with SMTP id 5b1f17b1804b1-47be29adacbmr116656075e9.7.1766487597685;
        Tue, 23 Dec 2025 02:59:57 -0800 (PST)
Received: from [192.168.88.32] ([216.128.11.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be2723d19sm315996975e9.2.2025.12.23.02.59.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Dec 2025 02:59:57 -0800 (PST)
Message-ID: <90e2fe83-c8d5-4948-b06b-3bb5161def1b@redhat.com>
Date: Tue, 23 Dec 2025 11:59:55 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: docs: fix grammar in ARCnet option description
To: Abdullah Alomani <the.omania@outlook.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "horms@kernel.org" <horms@kernel.org>,
 "corbet@lwn.net" <corbet@lwn.net>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <SEYPR06MB6523D44E490FF177C47BEEBA8EAAA@SEYPR06MB6523.apcprd06.prod.outlook.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <SEYPR06MB6523D44E490FF177C47BEEBA8EAAA@SEYPR06MB6523.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/16/25 2:15 PM, Abdullah Alomani wrote:
> From daadb4f6826bf2d5369acbca57b570269010c761 Mon Sep 17 00:00:00 2001
> From: Abdullah Alomani <the.omania@outlook.com>
> Date: Tue, 16 Dec 2025 16:00:35 +0300
> Subject: [PATCH] net: docs: fix grammar in ARCnet documentation

It looks like the changelog is mangled, the above lines should not be
included here.

> The sentence "It following options on the command line" is missing a verb.
> Fix it by changing to "It has the following options on the command line",
> making the documentation grammatically correct and easier to read.
> 
> Signed-off-by: Abdullah Alomani <the.omania@outlook.com>

Do not apply cleanly to net, needs a fixes tag, and the target tree
('net' in this case) specified in the subj prefix.

Please have a good read to the process documentation before the next
submission, thanks!

Paolo


