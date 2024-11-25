Return-Path: <netdev+bounces-147128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C36F9D7991
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 01:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A1D1B2134B
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 00:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E3B5227;
	Mon, 25 Nov 2024 00:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUZ68LHc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A974E624;
	Mon, 25 Nov 2024 00:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732496317; cv=none; b=dkBZQaBkXFRslzon5O91ube8PDHc1fO/OSX42ICSUK72SjugBc6E8NsfTsZeAMBgUVYikSe8r1me6gEtk54WdWVXxrLw3Arny4vOmcaeeEm/v+/641D4zBRFA4NrH+6Jaz7c76pqNpLSOYVKFciJFMl3tBg9qKNTlIuz+hjM4N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732496317; c=relaxed/simple;
	bh=sHNxsRUg6n7Yzu2ZeQgRMVMu+LeUSkO2J9kYDWyLjLw=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=oKjI4y9HQuLOBhokdwn18f6XJDB34sZScCXNyQ8umGQpRkFM8iRgwPJzj/TmhVvdpVhrcGJZ3Az/0riYEWX9PcETyOEQW9tZcu/mJmYvbvUjOGYaDFGFgBHoFIoej8URfzeG6dxL1DT7msvjrEHjaaWscgyAhT0nE7ExMQi5OrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QUZ68LHc; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7f71f2b136eso3090426a12.1;
        Sun, 24 Nov 2024 16:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732496315; x=1733101115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rBQ7gCf6/iupN6KSFuGFeD5+BWky9yGkProoTV97HB0=;
        b=QUZ68LHcHy3q9PfbEoxzUdMeW/XgT7jsY1hnfIm+LfciW5dOK9F5IyOsFr3kjMla/1
         XZhhU3bYltdF22AzgXt+hiQm7Zd0/pbH5KKr8GbJOUutdASOx42JbSrpN6SSfhakNMNw
         rtpnpRPvP9MAoxtoexdMRHagkbgzpQEnhArznDUzqoY5I9Yxmf/JDJU48OxYBK46Lg8h
         FpWofjGhmKiFo9mF/kICR/7wVhx0bkgFm8VdzLLpihdD0et1U9NqdccRZCkVREQfH+Sg
         SQl+1SxoUoY/7PH2u4qmUjEGytq0BL7YWWZt5GVKJNgiSbbqyjIgkTBixmakseel4FgH
         GMRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732496315; x=1733101115;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rBQ7gCf6/iupN6KSFuGFeD5+BWky9yGkProoTV97HB0=;
        b=F4RIlauoJ+G048SJ9zNvO3+WtXdC3MBHVvANdRyAiMxmrBpGvR45cHFkdhOPZc7woZ
         MDt2iWgdwCi3OGAaYTGnlkfaQrkBvjkygm2e4s+D2WZwjHkG8ArquFixbdjhA9q9X6Si
         jn/Qv8gZ1U+7GZEs3zCsJdh9HYjT90nuoic4nC1D8VcsWcav5y065Pgctg2dk/PueIjn
         CY9o1TSwduxbjpsHkUliD9jittX59YIgmvogBCsM39IVI2Ja02QhenNxvVOGAqJOoyV4
         jSTBmKUlhJe2eK8pSteFCmq/pAUBlw28Ed43TyJ0D4kHmJKx3X+AONBhNNOgIfBKQsYO
         zxsg==
X-Forwarded-Encrypted: i=1; AJvYcCUwBQe2k/OEWawteuCOTbAmSK2GeUyxN8AM317qkO4aKgBnSg5O/O0Vur97J/6LHtdfFd8cEvgdD73sHGqsQRg=@vger.kernel.org, AJvYcCV8gRUgQPOM6Orjk9yrasQokfLe4mOvsAtzXcxNgCKgBj8q4M7q8SFlRr672Bz+rSGpzKd2AMg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHddIag1kIOotanxo7MZ4mLau+nqEAM1FHVc52mKeCw9pj2TA2
	B3yRw0MDpkMMcVzCeTP7ecX//ZN4HcDQFzT8s/kFeVPxWAjd/MTfpy/xYJhG
X-Gm-Gg: ASbGncte1sMAYNytO0E92FZgPsEJAWLNg9jPiPLWXDZt5fWtDEpMaFv/xyNpQmKDn5T
	7vbkHtRD6xdsPCo+hVx7dyVTQGHNEP+YvaYJ5pucr3rnrcUStuFd06MbmJ61Qgb91FzhoIMNIBq
	7m0rCtPaQm6RT2nDVeHIxqqSkgt3FC7QU0Vb+cN1kUD3UaYPPEdes+NKTm4qLkAcEr5gIwgrk2W
	2bxyDgurR6t4M9AwZYjmgCgFugCpR2YuOhhV8RYwtpoPXU19IazyJQFuxzUotzTYHIc6UmXajxQ
	cwg2sXzYlCvDbf8bh39gBOlQgZDPYQ==
X-Google-Smtp-Source: AGHT+IG1h4liJrVLEdMPvhubXg/PnmmvYKXXN+rIeZ+vXQzOfxTz4HA284FHBBPymrBfxaQl4Q0ejQ==
X-Received: by 2002:a05:6a21:33a2:b0:1dc:7d9f:948c with SMTP id adf61e73a8af0-1e09e5ff70dmr18052674637.46.1732496314902;
        Sun, 24 Nov 2024 16:58:34 -0800 (PST)
Received: from localhost (p4007189-ipxg22601hodogaya.kanagawa.ocn.ne.jp. [180.53.81.189])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de479a94sm5186269b3a.77.2024.11.24.16.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2024 16:58:34 -0800 (PST)
Date: Mon, 25 Nov 2024 09:58:19 +0900 (JST)
Message-Id: <20241125.095819.2078794726631634489.fujita.tomonori@gmail.com>
To: kuba@kernel.org
Cc: sergeantsagara@protonmail.com, rust-for-linux@vger.kernel.org,
 netdev@vger.kernel.org, fujita.tomonori@gmail.com, tmgross@umich.edu,
 ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@kernel.org, aliceryhl@google.com, andrew@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com
Subject: Re: [PATCH net] rust: net::phy scope ThisModule usage in the
 module_phy_driver macro
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <20241124162700.4ec4b6ce@kernel.org>
References: <20241113174438.327414-3-sergeantsagara@protonmail.com>
	<20241124162700.4ec4b6ce@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Sun, 24 Nov 2024 16:27:00 -0800
Jakub Kicinski <kuba@kernel.org> wrote:

>> Fixes: 2fe11d5ab35d ("rust: net::phy add module_phy_driver macro")
>> Signed-off-by: Rahul Rameshbabu <sergeantsagara@protonmail.com>
>> ---
>> 
>> Notes:
>>     How I came up with this change:
>>     
>>     I was working on my own rust bindings and rust driver when I compared my
>>     macro_rule to the one used for module_phy_driver. I noticed, if I made a
>>     driver that does not use kernel::prelude::*, that the ThisModule type
>>     identifier used in the macro would cause an error without being scoped in
>>     the macro_rule. I believe the correct implementation for the macro is one
>>     where the types used are correctly expanded with needed scopes.
> 
> Rust experts, does the patch itself make sense?

Looks good to me.


