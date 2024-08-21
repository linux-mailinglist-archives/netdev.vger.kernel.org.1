Return-Path: <netdev+bounces-120386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B919591AB
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 02:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B63872829D3
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 00:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B3881E;
	Wed, 21 Aug 2024 00:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BuBSOs5N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF69D3FD4;
	Wed, 21 Aug 2024 00:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724199276; cv=none; b=N88dd2UganQ6BiVCLrBc5vl1VxJD/BckeQru1QQM1ifrfXG0UOy5nmXtz963SIriP4PEABpD8TEcI/atiPTrBNLaTjDF4oSkrETvbUqdm7kKvxrXJ+qRASAZua86rnSGKUPMvsYlQBxi+YDHzRwD8G4UE2miMwZ4stL9dv6xfu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724199276; c=relaxed/simple;
	bh=P9Gw5/G1Kb8IGUvb7Zek2Gs6LmjSwb/PyjkrpdToRv4=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=BOJeC8rvuzr8lY+0VVx9AoxaQPdyugpl1Qql+UVoga7MOZFqmVZII6LlArELuFBL5e1wfFEk0VaAQI3R34LBTyp8OE6VidwHW/DNchfcTzXEsOe5AqSPbFCjAQq82Gk7YOsSmCvCpremQU0Z9l2Bom9Rfc9JZ6mh4F2HQsd3edw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BuBSOs5N; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7a1c7857a49so3711541a12.1;
        Tue, 20 Aug 2024 17:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724199274; x=1724804074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FXynTrIfojKLAVwK+Gtmc3a1ESdqQsnb5gsn2xa7MXw=;
        b=BuBSOs5NM1Ylzny90CZtcw2W5xSA6+CGooW1L7ss98NKVTaDRmPbmEgCjFUVydAFRx
         kNNiQoJ6hj2HHqvBVpASUxf6Z0Sd/a5VKCjsYxjCTjD7X6l7gJWoi0dpbYNr0uf19zHQ
         bIn9OllKlnv9aSP1lcwvz5cdhvh4m/LIxWCm6cXkiVlHBYMikwkK5Vu2XDBgQAhcZX6s
         tHqVTOvhApz87+yQOvSFfCW5EUOUyzY35AhoBzvf58icxxbAO78SQV60yg0Z5vu/Hegr
         2hErAenKN19EnggqwHhoUqhRJt3SNvCDMoAJHHLqVPVv6E6XeqFJtUVslGkeBB8cFNTY
         ikHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724199274; x=1724804074;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FXynTrIfojKLAVwK+Gtmc3a1ESdqQsnb5gsn2xa7MXw=;
        b=hmRCpw6/7QGAG4zwPvfGH+X9rmxLmrOt9wSUQhDMK1VJ3kysixuGZ2JY5+ycZp928y
         buBye48/aYNXH61I9+7PWFgIb6neEX2emwuqIu2K7R+2be6Rtvoee/GpzQsvTekO/74b
         30XUwbL/Qzof1S1GZ9h2Fz+RTwylJ7iHCJAgTHlLdTzfhk8dPYDIjA4KsIR1m4TJZZtQ
         nVkTIF31gXXo3J/PTjCYlJpNNuW0nDCNSB5r4S1hiwmCcwOwgKuINAdIJJgFCBmWWNn9
         V0VD9WER0dn3nZOooUeaLBm5jI4tMyTbMVNBjEdCDDa5YPnllLN8EUqHBcxDgfyvasOj
         K3dg==
X-Forwarded-Encrypted: i=1; AJvYcCVEr2GuCGyyQ8iOEpDbl+FS2nhy5DA+pHQeEZwzbJzePgZtd/9vWHvpv+hXt4qXXSjz/Hfw9lsUu+9KmEufuTw=@vger.kernel.org, AJvYcCXujQC5F6yRD9jhKpZype02G1fNwDt7dvxjRuqnacohEcgTSeaEJfQ0a4CokR+aMemuJatTBdY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuXw7V4kRxiH8gTjALdSLfkyuMPBPsbIM83yGxCh0tkw5zvRrN
	Bj0G58FzfGSW2W0sVLgY8r5mv9bQbX6pqKLxw/45JWMPTTnaikr0
X-Google-Smtp-Source: AGHT+IGPXO0GglNUWxFMPpgKsJ2QsgT1scWL/zvJpv9ozJZ1BjhjwsEgq1DkI4pSX2gclKHO3NHyxw==
X-Received: by 2002:a05:6a21:10a:b0:1c4:b8a1:6db1 with SMTP id adf61e73a8af0-1cad81a741fmr1228962637.38.1724199273905;
        Tue, 20 Aug 2024 17:14:33 -0700 (PDT)
Received: from localhost (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5ebb4dbfasm234730a91.31.2024.08.20.17.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 17:14:33 -0700 (PDT)
Date: Wed, 21 Aug 2024 00:14:19 +0000 (UTC)
Message-Id: <20240821.001419.119790971277689020.fujita.tomonori@gmail.com>
To: gregkh@linuxfoundation.org
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch, tmgross@umich.edu,
 miguel.ojeda.sandonis@gmail.com, benno.lossin@proton.me,
 aliceryhl@google.com
Subject: Re: [PATCH net-next v6 1/6] rust: sizes: add commonly used
 constants
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <2024082121-anemic-reformed-de75@gregkh>
References: <20240820225719.91410-1-fujita.tomonori@gmail.com>
	<20240820225719.91410-2-fujita.tomonori@gmail.com>
	<2024082121-anemic-reformed-de75@gregkh>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Wed, 21 Aug 2024 07:41:24 +0800
Greg KH <gregkh@linuxfoundation.org> wrote:

>> +/// 0x00000400
>> +pub const SZ_1K: usize = bindings::SZ_1K as usize;
>> +/// 0x00000800
>> +pub const SZ_2K: usize = bindings::SZ_2K as usize;
>> +/// 0x00001000
>> +pub const SZ_4K: usize = bindings::SZ_4K as usize;
>> +/// 0x00002000
>> +pub const SZ_8K: usize = bindings::SZ_8K as usize;
>> +/// 0x00004000
>> +pub const SZ_16K: usize = bindings::SZ_16K as usize;
>> +/// 0x00008000
>> +pub const SZ_32K: usize = bindings::SZ_32K as usize;
>> +/// 0x00010000
>> +pub const SZ_64K: usize = bindings::SZ_64K as usize;
>> +/// 0x00020000
>> +pub const SZ_128K: usize = bindings::SZ_128K as usize;
>> +/// 0x00040000
>> +pub const SZ_256K: usize = bindings::SZ_256K as usize;
>> +/// 0x00080000
>> +pub const SZ_512K: usize = bindings::SZ_512K as usize;
> 
> Why only some of the values in sizes.h?

Because this driver needs only some SZ_*K and looks like SZ_*K are
more widely used. But we can add more anytime.

> And why can't sizes.h be directly translated into rust code without
> having to do it "by hand" here?  We do that for other header file
> bindings, right?

No. bindings::* are generated from C headers and kernel crates
give them to drivers by hand. For example, rust/kernel/page.rs has:

pub const PAGE_SIZE: usize = bindings::PAGE_SIZE;

