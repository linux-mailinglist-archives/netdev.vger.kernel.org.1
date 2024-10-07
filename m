Return-Path: <netdev+bounces-132582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0279923E6
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 07:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C6C61C22129
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 05:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2782D136352;
	Mon,  7 Oct 2024 05:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JiQkSGt/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D03F23AB;
	Mon,  7 Oct 2024 05:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728279435; cv=none; b=qkJC72xfBaxgs4AbaNVpwtUEPrDIs6+JECVPcllHzTC+DY9Hjh7x0XiX+G1nGSlBlSfj+pXZas4+KacDFat6psnCL2TdgwpD2Ee/dk1yonXPfI58IwpFiy2halPgevyrX1K/S4pHEhDFgnpwD9eTnQHo+7Oz1tCFrlq5lgKq0PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728279435; c=relaxed/simple;
	bh=JCadmrC3h0MujzKXcT8U0aRt9DPEEGzc5jwPr2ZooF8=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=S5xhQTGGWEjFUtCN6fQYoKfpXfdUtixbKZ2Rn7VFEWAIFzB32qstH1/cw/6z3M1hN58hiDDQE7I3Gq2QyUC+xKdQZpib2X0KfxN3XwRMk81l7seEMMk78AaPPqaG5RzGgfQ5DFiZdsBz9izy3Fm+sNoqpu3fy4Z1t2btifzO9ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JiQkSGt/; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20b90984971so41798905ad.3;
        Sun, 06 Oct 2024 22:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728279432; x=1728884232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cF9L8ZHjqNNLKF2lJh0mQWJpMrn9fQAJhxqakMnEFAI=;
        b=JiQkSGt/F5Oeo5CIeVL8Qw9o5y69W1zWDs+AvVd6fGO+9Xvoi9IEfpN9LmHcHD+OZM
         vANIWOcAuOq7L3DwThrS16pnLhAeCu0vA5E4nAgZH1uN7tqvm3lT6SrmwsKMZK0EgP7y
         lbqIn+ersa7EuNVng193bc4/FVzZs3hanaxAtH16qdCJRKGn+8/2WfN0KWFg8jbPqjbr
         auowu0H3XDKG4FjoqOpAbHNmsAcJDaqcdakKlpGvuM7nMAGMoDapQeQIEkfVoFC0TRDT
         ILGTgBMuEnncqgNit2lqu0xg8aYZamxxG3G6mH204FvZPiecd6DK7n14ER0qqQ159LuP
         N/qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728279432; x=1728884232;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cF9L8ZHjqNNLKF2lJh0mQWJpMrn9fQAJhxqakMnEFAI=;
        b=jeX0vgDgp/rRMS5Clm3Ypir153+zeHe59foP2EzJLP2o27MhcW8fA6xrDDcWqXb5vq
         ZsKlNoMP/HOuF5Id+Ky5MbNAwK3C2sJZTN17WaARxxNX0DHzK/5vwmpEURO+lAJzm30C
         3PmKqP4WNKEdi9Bo3MMXe+YJRpjyPtyjutSEomEXVNeaqR8ivYGmTrShkrnBJMJd36l2
         SDccGLyedk4OcJBnZt6HYjZ4dXzZaf+/6JHQG+LE3vHy7HqbKH30XUZbqY7obIci3z14
         Ror8XZSU1o7mAbQg7L1E6MT40/tq3UJoK+HHLqf1PY6Wha7r/ZY4sQpQu45Y8M+1ISHu
         5lYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwbJYLnTmY/PR1PE5D2a5eUU4KTw74zKeKBDdovQo4N90AAIrzw4EmwoWSBEajUt1pKNFy5Vc0WVwjhP9vCo0=@vger.kernel.org, AJvYcCVeg/WawCNYI0ueVL5jI94QqC3Co4x1J/QcBKKQgVI4NNAhzrPZTeIndH9zfW0QFk73bBOjsySEfOmHljw=@vger.kernel.org, AJvYcCXq+hnDdk9XDNcpanXOc8c08PDawJn+LAaLMckUvtBOoJfGUT1HmeCG17OPAkxxYqMPNArPDUz4@vger.kernel.org
X-Gm-Message-State: AOJu0YxqzxGyfY/4K+zijlRfklgW0wmEfqNcESMFW8M7yHdF7jH7HXU1
	x6CVh0qFqBLxioHTBBTm0xX45FmNIcyY/ByAc4p+qyGJN5AcNCnd
X-Google-Smtp-Source: AGHT+IFV3bfcM3/+6NJSr4u/aMHjiq8zXz5plHNqa6mGpBlqdEH6TUKOc5eNKUGE5sjlVkCXrY5w7w==
X-Received: by 2002:a17:902:c941:b0:20b:937e:ca34 with SMTP id d9443c01a7336-20bfe05d555mr113149585ad.34.1728279432506;
        Sun, 06 Oct 2024 22:37:12 -0700 (PDT)
Received: from localhost (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c1393175csm32539055ad.140.2024.10.06.22.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 22:37:12 -0700 (PDT)
Date: Mon, 07 Oct 2024 14:37:07 +0900 (JST)
Message-Id: <20241007.143707.787219256158321665.fujita.tomonori@gmail.com>
To: finn@kloenk.dev
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@samsung.com, aliceryhl@google.com, anna-maria@linutronix.de,
 frederic@kernel.org, tglx@linutronix.de, arnd@arndb.de,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/6] rust: time: Implement PartialEq and
 PartialOrd for Ktime
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <3D24A2BA-E6CC-4B82-95EF-DE341C7C665B@kloenk.dev>
References: <20241005122531.20298-1-fujita.tomonori@gmail.com>
	<20241005122531.20298-2-fujita.tomonori@gmail.com>
	<3D24A2BA-E6CC-4B82-95EF-DE341C7C665B@kloenk.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Sun, 06 Oct 2024 12:28:59 +0200
Fiona Behrens <finn@kloenk.dev> wrote:

>> Implement PartialEq and PartialOrd trait for Ktime by using C's
>> ktime_compare function so two Ktime instances can be compared to
>> determine whether a timeout is met or not.
> 
> Why is this only PartialEq/PartialOrd? Could we either document why or implement Eq/Ord as well?

Because what we need to do is comparing two Ktime instances so we
don't need them?

