Return-Path: <netdev+bounces-104355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B8E90C38A
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 08:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BAB0B22554
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 06:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C27C3D3BD;
	Tue, 18 Jun 2024 06:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L7iiPqrl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DB422EF2
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 06:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718692081; cv=none; b=hqlApBMU7E4/d6lh0P92+3sakLrNLHEOCABD0SIqA02M5ZO17t7BPsnWO3RgAye64ZAQP9STLrG88vW0sCbDjafLbMPYSyEBhHiKcF7z1ya6GE1kHuvbX8jT7ZjfILewtg7hpSzuniOoAoyhYt558uFwB8thE4OYPOdPmadrytY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718692081; c=relaxed/simple;
	bh=HiGYo2uQtCI8bIcv2Awhdl6qK6VnjMdrMnp1V5XydQg=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=KA8XZpxKrT4WZruJHQK1DeOp/T+TEfPKp7BsLUJZBhIxsyjGgizMffKa2JAl2HGUePm7UG4Bp+pZjIeIMySc05sXEp0ew9A1hnQ9FFPs6FB50gX4bsxZ2Om7SwENGZLks1HGzq/T2V9mhCjG3oHFS8/70AvVv6yXCqB5GdDOyCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L7iiPqrl; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2c2cb6750fcso951572a91.1
        for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 23:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718692079; x=1719296879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U+LrtVTHn/ItpvjCgKMAKwzJQN04T2ESimS575h0VbE=;
        b=L7iiPqrlR6a2iEnuqk9FoOlyl9Tmr7kiUWRUoL9GGhPrldVbZe6MydFWt0+02tYTQX
         AfBXnnB43BZS/rlTlvtB7zveKXRV5INiX4bdZHm4tNnWF7jC34IfqGTLw15uQiroZGcH
         2IIh561QNS0kDozZ6uN5o5JsFRTo1hvuFRtgSH+HOXC/O0Lq6Qyyjj7Zd6SpmytL7qnf
         guJWkTnDV0kQrVGHCLsW69erFPnGqcRNSrSHC1VNaqfQVVaNM5u9L7ZBw8vGRh6tnHJV
         HpgmdYY3xAeDILoDrEKqtLWQ3eR56eu33VEBXObcB2AgH3x+wV2HC1CSAcVECnhdAxWT
         L1nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718692079; x=1719296879;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=U+LrtVTHn/ItpvjCgKMAKwzJQN04T2ESimS575h0VbE=;
        b=lDfZRHolDfCEvJQw9FwYra5Hx8BwYfGdCkj7eerw2R8lRKbUQvVKDApZWpky9LIeqO
         nwYo7EF7Q9I+X6kz1iTfrZYjFeh/7j/uflfbC3PSHwvbpeBld4uXsltNdBrH47IGiUBL
         7sgH8iD921vhzPco/2W97yAYprEn2VY/jY/E0dWVjSPgDWYUpBfJ6NSEqfvWOH+6cgbu
         fp3Ijw+k+CSTm3LOJxstPFph4gBt7WQVtdLizEW/W3+iU22R65dYJbvkrE+8BcG8/ajs
         Qx/U7D3oPb/kp9/ZC5lj19KU8YN4QVriouoeeepiFqBO0RrBeBsfrCmBGoifRUZSeM/J
         Yzww==
X-Forwarded-Encrypted: i=1; AJvYcCWsZDvZCTq37VHoXPTGfBucvjZDW1B12RZ0pMnS12e0bXX5++6GlleVoZyXpuDRrIilTxMwfppq5y4g1UVh30V8yrx5R9oA
X-Gm-Message-State: AOJu0YyOngX1ME1B2J0Mqnl2qifuMz8eMXgejRmop9EBklqptPjDtOPu
	l4PN9Uj5T3oeN/fJPsB9HCpzJGtf5icvCjoMII9nZNLbPyF6p+7M
X-Google-Smtp-Source: AGHT+IEvS5Zmd3DkyYnwCi5pI0rkxpiE2yvYtTBQFPSx2wX4Z7Lt6krgXQJch84hbAfe27cyFQJWEw==
X-Received: by 2002:a05:6a21:3391:b0:1b5:cf90:de41 with SMTP id adf61e73a8af0-1bae82ca243mr13914331637.5.1718692078977;
        Mon, 17 Jun 2024 23:27:58 -0700 (PDT)
Received: from localhost (p5261226-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.15.241.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e55c96sm89214975ad.61.2024.06.17.23.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 23:27:58 -0700 (PDT)
Date: Tue, 18 Jun 2024 15:27:44 +0900 (JST)
Message-Id: <20240618.152744.1503724041927300572.fujita.tomonori@gmail.com>
To: andrew@lunn.ch
Cc: fujita.tomonori@gmail.com, hfdevel@gmx.net, kuba@kernel.org,
 netdev@vger.kernel.org, horms@kernel.org, jiri@resnulli.us,
 pabeni@redhat.com, linux@armlinux.org.uk, naveenm@marvell.com,
 jdamato@fastly.com
Subject: Re: [PATCH net-next v10 4/7] net: tn40xx: add basic Tx handling
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <5a38a8c6-a4a2-4e5e-b6a8-b02e86b8cd5a@lunn.ch>
References: <8c67377e-888e-4c90-85a6-33983b323029@lunn.ch>
	<20240617.144427.323441716293852123.fujita.tomonori@gmail.com>
	<5a38a8c6-a4a2-4e5e-b6a8-b02e86b8cd5a@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Mon, 17 Jun 2024 15:58:48 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

>> 1) initializing the table in module_init.
>> 
>> 2) embedding the calculated values (as Hans suggested).
>> 
>> 3) calculating the values as needed instead of using the table.
>> 
>> 
>> Which one were you thinking? I have no preference here.
> 
> 2)

Got it. Updated the code. Please have look at v11.

Thanks,

