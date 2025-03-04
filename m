Return-Path: <netdev+bounces-171625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F9EA4DE25
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 13:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 427253A954A
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 12:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E15C1EA7CE;
	Tue,  4 Mar 2025 12:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4mfxV4p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6511FECDB
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 12:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741092149; cv=none; b=WzwTMXrUwIWvsM5yso2aa6HvHwGdi8dM/AD33suQ6jbDDzUOb/pazGraRZUmTc3xYlzUhz5n46gb0Hbui2jgua6jfJ1yBHcJT4FwUan9lw345zs2tVqKneLdxFydBYk91+l5qVvYxzhdIYHdvbHM3Yu03uw5YzGFkHiFROe4hfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741092149; c=relaxed/simple;
	bh=R1yKiQQ1c7+xSe+5Gmsq6GzTgGJKuur3QfO4dR4grYo=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=mOmxinv4kkNNNFNL7Z2hCoZ2EkuEj88YJg/SoEP0ucdAODbFnvGUr1X9cE+TT+9awt3Rd/qM3RWlijPF2Bg4rg2//yMQfxgfP/JONkPr5iAs5Zrdu3GTHPFJbNxXR5w8GIuWrPo5Q4CgNTYGZkawWQZK2gPQaLLSGq3oACL/JfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y4mfxV4p; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2234daaf269so81719295ad.3
        for <netdev@vger.kernel.org>; Tue, 04 Mar 2025 04:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741092147; x=1741696947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ttkzG28zrYQgwXcLa6fUzsqm7B6aclx92tJj9HpjdRE=;
        b=Y4mfxV4pAsmlm4PN/IFFsrBXaF9y8R407G7S8kYa/i7sT6JcFMnaj0AuzSl+jHtWra
         zp7GYElHQ4C/o5ALw/zY62F/loLjgDf1P/fBLY8J7ftTEQMWo56ll9o9BDOKaAuUcJC3
         s0vMWSAuREAlJKKzmzdf1wKG/GsxxRYfPnmYOkaU6poNgmKFyqaO5qSer832xD18hBef
         BF88ujPZm7hkJjn6ldjUWoEWKJyUlN4znTk0/QlxSyVUg2C//gC3qFefRptZ2zu+uNJU
         a8/Rc1p+dgA1RMKrRYuYx/CABPuzkQIrpsCzPRGcnh9XxO4IVkHpXnh/xLn1cATU1+B0
         7kiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741092147; x=1741696947;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ttkzG28zrYQgwXcLa6fUzsqm7B6aclx92tJj9HpjdRE=;
        b=YrbtxOBJ5F07XD7uJrnSIgdKEFBc4HFxjGvDDbobO0S0yt53ZVBamHUwxJ5xxmYE2f
         lR0wuL8BPMYj+QComj8iMvFHn2uYzCw2hLhxpXhndC6F/kbjyrh1YNnobdExR0XxZA14
         dSBWPmePRzh8ZQeqCK94oT8H4HkFrfGaM0TBK5UXJFj51l1pUs8ufSt/GuUvSTjRvxi9
         hDLIhH84Z0YSRYq8gv7RxVAlENxOnADZHtGVSoJapWU5JnRmJN7SpDKvBeEJyL0jT5rL
         pmukC/3ZhJUBQUnRnGsT+HWek4l/mLa5RtYGREb4+nyGLeI7oZJClgXqmgnGfrIgeEs5
         7++A==
X-Forwarded-Encrypted: i=1; AJvYcCUn2qYfYSijTAtcnCUjesE1iG0MBnricVGlfjhXPdbP2xxs22xbV4vGI+0fvf9W1pVU1P1ZNkA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGo73QreuHnW1LCxjzEKxm8hJ12mUvGMZoroZryfdB214C4zuc
	bxGhBIEkY9rSe+4sOps/TN0ddtJIQubTYo+hvSqQbi8GpEh8ljEN
X-Gm-Gg: ASbGncuBO4ju71VDJ7ljNwYOOLmk4fF2VDqLi0mHzYmxbF8er5JZBIUmv2q/PmuIBw6
	WPgm18WBN1CEyAmvgdui6kylnYmHyrYeMgU2mDX2747+js+NWmKsDlWfJeXvXshQRgkPn/565l7
	IS9Y8fKxr198/1U3c0l+OjJBtkkGBB/zqit8hs+KpOOW/w9lM+62oCVVDrD9usaWiM5hXN8t9sX
	49sTE0fBGxMB9/PDFY4jddtyYGqp1YIITJruleOA3nlWGuYVAi18u71088iL/o6uXWrqnM4FQTL
	ncbaQXgsJnSbADmlxEGkQAm/rKY3tBjTWCBOSuvQagDNupfofu6MbExaj5DSZR6GSXQxCDLvMrL
	fwyL3TEVgwpVi7K/md7d+RPJ/L9Q=
X-Google-Smtp-Source: AGHT+IEODZt44IIc+stAr+BoCWgP+Xf0nl7JFdtNm9Jz6YtuuQoRJUbw54XEvioY1ltfsF+mUD03gg==
X-Received: by 2002:a17:903:2410:b0:220:d81d:f521 with SMTP id d9443c01a7336-2236926f07fmr244141775ad.51.1741092146802;
        Tue, 04 Mar 2025 04:42:26 -0800 (PST)
Received: from localhost (p4204131-ipxg22701hodogaya.kanagawa.ocn.ne.jp. [153.160.176.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501f9da1sm94228445ad.68.2025.03.04.04.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 04:42:26 -0800 (PST)
Date: Tue, 04 Mar 2025 21:42:23 +0900 (JST)
Message-Id: <20250304.214223.562994455289524982.fujita.tomonori@gmail.com>
To: max.schulze@online.de
Cc: fujita.tomonori@gmail.com, hfdevel@gmx.net, netdev@vger.kernel.org
Subject: Re: tn40xx / qt2025: cannot load firmware, error -2
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <5f649558-b6a0-4562-b8e5-713cb8138d9a@online.de>
References: <5f649558-b6a0-4562-b8e5-713cb8138d9a@online.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Mon, 3 Mar 2025 22:29:37 +0100
Max Schulze <max.schulze@online.de> wrote:

> Hello,
> 
> I am needing help with this:
> 
>> [    4.344358] QT2025 10Gpbs SFP+ tn40xx-0-300:01: Direct firmware load for qt2025-2.0.3.3.fw failed with error -2
>> [    4.345075] QT2025 10Gpbs SFP+ tn40xx-0-300:01: probe with driver QT2025 10Gpbs SFP+ failed with error -2
> 
> 
> I have built a mainline kernel 6.13.2 with rust support and have this card:
> 
>> 03:00.0 Ethernet controller [0200]: Tehuti Networks Ltd. TN9310 10GbE SFP+ Ethernet Adapter [1fc9:4022]
>> 	Subsystem: Edimax Computer Co. 10 Gigabit Ethernet SFP+ PCI Express Adapter [1432:8103]
> 
> 
> I have put the firmware here:
> 
>> $ sha256sum /lib/firmware/qt2025-2.0.3.3.fw
>> 95594ca080743e9c8e8a46743d6e413dd452152100ca9a3cd817617e5ac7187b  /lib/firmware/qt2025-2.0.3.3.fw

The checksum is good.

> Is there anything else I can do?
> 
> What is error -2 ? Who generates it?

The Rust drivers use the same error codes as the C drivers. So it's
ENOENT. FW_LOADER subsystem returns it; can't find the firmware file,
I think.

It's weird because looks like the firmware file is stored on your file
system.

You hit the error during boot? In that case, the firmware file might
not be included in the initramfs.

> ( NB: You could mention the hash for the .fw file somewhere in
> sourcecode, until its in firmware.git (doesn't look like it ever
> will, huh? [1]), so others can verify they have the same file as the
> driver authors...)

Yeah, I'll mention it somewhere.

