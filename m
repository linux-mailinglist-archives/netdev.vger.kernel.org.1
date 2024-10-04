Return-Path: <netdev+bounces-132024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFDF99027A
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 13:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E2F9281EEC
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 11:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0A615B13B;
	Fri,  4 Oct 2024 11:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MCwVMQf1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC7E15B111;
	Fri,  4 Oct 2024 11:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728042500; cv=none; b=GbeLldHact/Oe0KusS5MJsX6NaGUgyLfiZF8EzemMj8k0Tqs6pqh9+J0w+W18KMndvdyj7Ah33uYhnyzJtoJLoKRW+/kSt4fTVc3em3iewsFvEmwHyzNP87YesKgQMohbuWlvkOsP+vDqEDzwbyDZ76iBVKSI2aaXe7fSYGA8TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728042500; c=relaxed/simple;
	bh=ktOLvR4Iqgs8PtW6U5YcW5q2wtfztJu1AKzJuRJ5VeQ=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=rG9p9Orz5kB0hyczyhFTcb0a7Hwa/X9qi4jcQ2b1J35KAPah+JofhK1vTFv7Tra23jhmL0zQFGKyuEQ7QzE8Q+66vizWIZXPFnNU4MEPX0ghWxvVhwqxHgwTMwsG0cZWtPUgTii4GxH6Y1V4XtKR83hfD7LvQyfbFwFZZ7svcRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MCwVMQf1; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20b7259be6fso21789765ad.0;
        Fri, 04 Oct 2024 04:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728042498; x=1728647298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Si3+f6l0lHQXgBRS4ewhvkkqYUKZZULAPxMJAAUGVA=;
        b=MCwVMQf1bzlAPddfTFmgwHJbmXnLmPnPANmOcJ0ZBG41kX4P+TtmGAPnK7v3guAsng
         c4/trFq9fOhjPsnUA5VVH2RazXLlq4JG6aNParzhIEHF0l6F5py97R05+2WAFNz5pLMC
         z8DqDmnwYRToqnqDSiXrQarlc4i3z8gb9szVsMY1RTVEDAyffFbWF1ihwacR/gMoHoED
         c50zVJtuItejMp+2Ii6B5cY9T+Nnqmx/e2yaZJwqWnPovdWTVROLEpW84motZPQBYp9x
         HtRMGIfoBxMYJ+5ZsnCVBRGQK8KzgLyO/3vhTgFlEsIHmhjQL6esjvP1witywaxEeLAv
         /zog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728042498; x=1728647298;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8Si3+f6l0lHQXgBRS4ewhvkkqYUKZZULAPxMJAAUGVA=;
        b=pc3b3lX9MlXgmHlGaKySc+BNd2aZOIFEynXhxgeH/YY8T4qpBvGMy5E4d3blmQaSyV
         VB3DgaCB2rZuH0ShEyQLoAN+E81K8bhLTNObtVuT5cpJ2tm0mPhpxqR0qFwjODK4W7yg
         izHn98nrbWcaYO5hltoroXxHwOh9yyq9PQNwn6unTw8pWRhw8c8C047QC0ihfM5gnvQc
         FbCKvMRBq2GQ0wOz5fjcqJmKFUw5GqGYTMpv3WKb5wGJyKp9Dgd5LQOChcieC2B0v25s
         q7ShRahoKIgQKnK2a0NR90jJgh5Y20y2YM4A+99zsOPDuI7suQg6g/XohJiUtA05seTJ
         eHeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYvpXhOCzfOWiA8s2wzk0W/aRKSn8r4HJqhWxvyGuA39Ga9hNlXKGd69SmFuwZOGzO4Y+iOkAWa2Fk3DW2VtM=@vger.kernel.org, AJvYcCV54jCHFICZZrmuP2jA4s6F5hFkTMGnQfdPO1TjwP97VqL7SEw0sN3uoslUDORLgXQpzn0VgjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnVTxShU3IN9QEPTC6LO4ItPtZent0tLKSEvnrZJRnBN9sJAl/
	gJLy58WeQP5GmoNu88jl2Q9do8Edi8Ukm8ZS390oiMmaFsIW25BK
X-Google-Smtp-Source: AGHT+IFVc7BBKDLVa9eWzUVKOdhKvCJvaVU7e4VBSbw4EssJralX3008mahfGHXEuAEDpq04QbBR/Q==
X-Received: by 2002:a17:902:e809:b0:20b:9547:9b3b with SMTP id d9443c01a7336-20bfee319f8mr25048305ad.47.1728042498405;
        Fri, 04 Oct 2024 04:48:18 -0700 (PDT)
Received: from localhost (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20beef9128bsm22511635ad.128.2024.10.04.04.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 04:48:18 -0700 (PDT)
Date: Fri, 04 Oct 2024 20:48:03 +0900 (JST)
Message-Id: <20241004.204803.2223000488444244418.fujita.tomonori@gmail.com>
To: andrew@lunn.ch
Cc: boqun.feng@gmail.com, fujita.tomonori@gmail.com,
 dirk.behme@de.bosch.com, aliceryhl@google.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, hkallweit1@gmail.com, tmgross@umich.edu,
 ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net,
 bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com
Subject: Re: iopoll abstraction
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <203e2439-4bba-4a0a-911b-79c81646a714@lunn.ch>
References: <20241003.134518.2205814402977569500.fujita.tomonori@gmail.com>
	<Zv6pW3Mn6qxHxTGE@boqun-archlinux>
	<203e2439-4bba-4a0a-911b-79c81646a714@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Thu, 3 Oct 2024 18:09:15 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> We probably also want a comment that this helper cannot be used in
> atomic context.

Yeah, I'll add such.

> Do we have a Rust equivalent of might_sleep()?
> 
> https://elixir.bootlin.com/linux/v6.12-rc1/source/include/linux/kernel.h#L93

No. I'll add bindings for might_sleep() and cpu_relax().

