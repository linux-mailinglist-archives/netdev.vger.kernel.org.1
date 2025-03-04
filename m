Return-Path: <netdev+bounces-171849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D6DA4F191
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 00:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4307718832DF
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 23:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A5A1FE469;
	Tue,  4 Mar 2025 23:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="es1E7TGt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D37327BF61
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 23:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741131377; cv=none; b=uoj0dwIs7ARNL4de3eO40xpnS0c9hiEdvyrSoDCXG9ZFl+eG4GSjVT3Rzqs2gRrcLnVRUa5z+26S+e1HgoZv4EtKIEE33+GjnmX2qVcu7/fd2WVPKFNg/neuQ0w1TF5FsifDRS5IgRoJsuVYbBEluBJTdNlkidd+Cl5n+5alD2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741131377; c=relaxed/simple;
	bh=4Rf8c4vACXegGnwP8fMe2FHVvKFhgehnfRjxlP3pwZQ=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ruH/HKf6C6RQnnJEv9lBF+X68TLsCGLvoLdFNti5GHzj4EDJkC7SbVRCizKiPbwBRdt3SIT62I9WyeFPCFXEKhopSrtFHD19uxILXQfKigugEz/wq2+x1woaOYcsYJggKB9nFKzLbdAhkBIFCDMGpRHWnw+tiEKKlXvfwD4tV78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=es1E7TGt; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2239f8646f6so62961345ad.2
        for <netdev@vger.kernel.org>; Tue, 04 Mar 2025 15:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741131375; x=1741736175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xOaLsUFNMKX9yNmjDC6l9SSU8pNGtLAoq8bDkRDFR78=;
        b=es1E7TGt9HtzUkAcKCuy4dAFjmY8cfMGyDjeLar+pzipmT3JBzbvbq/sbE4Ws/gheO
         h/rWVGxfJswP8j2d1W8F9xIN7zy7Ldd4+I2H/jKGGmoFufjKqh1w8xo8HEBRwAnbFUAd
         65xd70MLku3c16HB7zwgeCtdfDDLP127HheXd5jOv/JlDDwOmID1KuwP72ikcdzsL1Kr
         Tnk4+gXS4jfpLTOSTZYlc1SgjOTDYdOqKIlcl9qujRAZvD7AV9kLY315xh7bRC6pp7xg
         WvIY1lsCnHeT9t25zeB0zb9E7yTuJ9O3dho95thVjjF78wPDfyB1Q428mk9tm2qoUzVs
         Flrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741131375; x=1741736175;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xOaLsUFNMKX9yNmjDC6l9SSU8pNGtLAoq8bDkRDFR78=;
        b=V6dL7WwA3JUEYn6Dxpdad6Iy6X/GnQVPmd7uZ4DNGFfiSavuzNt44sBy2BZpdo1RvE
         GTzw/NycWH/wH1WH9RzPjYSTMoGEgyhK50yXH3iVlRNxJegRsx/8yi9QPClpL4UV/vkX
         HzJqCEiqMbK91Q9jbT59MVK1zeGBNXUvSFP5RnUkvJId4Gtq2GZPVVpIiu4SvFXg5b5b
         h7KV/zwFyhgwDVZvip+/JPthTkJ9SExDuGm/tjCMsMAEHfHxFp50l+8Z9P+vt7Qb/gYv
         sbBJUrp9Strxf3LxKouaQvAGxsHO8fiRl5JQ6rvw4eNzUXxGO6iMXdSGnX2tQ5Qx385z
         TBgA==
X-Forwarded-Encrypted: i=1; AJvYcCVR/ebJsgv4oKI9wj6CU4NLvYX19PL3iy/OYPO5BlJMuPlBXeHfIH6D3LR4h4n8MugF4DpNefE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvBpJ/iiMXeUtgxvLmV4rpb5dtklNGerN+c3r+i2479koIP/hk
	4HWGL9NWMZ2IlXiK+XKUoZDPqkc2GyyILKqeIgAHAOd92I8rX8O4
X-Gm-Gg: ASbGncvmyswpscaq/Lzj5dAI9F3CNfiym6zfuvnMBJXOwp+DJOPeX92Ncn+YOQOKrys
	INwR/4yJMnImM8jPc3LweCl4VS3fTyWw83W2UrPqkLbp89zdrHlaeL9ROTThx7fPmoSXMyEOZHA
	xvfOQm+vlvS3Obwc5rPXu2tilK+9TyaDH3l+jy7jfvbAPoPk8A1wgqk5Y0X6hic+NvtuSmorw6o
	UT9gNOuELmXXX5U3h/1vuLZGTZecSy63AQBeFDb4Dr8D75CKlg/WCl/78VsGw72lxdVrpsVs7De
	R/O1Rl8GplxR9cE0hRpQNtMkeChwxGkcXwRiazxwPGUXz0tS+wqDLj+2Uy632KcueiUl+7eRzNE
	7O4brWctCCytA9rAm50oMD0nsSkA=
X-Google-Smtp-Source: AGHT+IEb305EP+HI8rLyyOuovd4k3XMn978nCWB+726aL3uukAe9rlirZnb9hT6+Be10LEtgtuNp1A==
X-Received: by 2002:a05:6a00:2303:b0:730:75b1:7219 with SMTP id d2e1a72fcca58-73682bea834mr1232923b3a.12.1741131374761;
        Tue, 04 Mar 2025 15:36:14 -0800 (PST)
Received: from localhost (p4204131-ipxg22701hodogaya.kanagawa.ocn.ne.jp. [153.160.176.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734d444a9fasm9590420b3a.60.2025.03.04.15.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 15:36:14 -0800 (PST)
Date: Wed, 05 Mar 2025 08:36:11 +0900 (JST)
Message-Id: <20250305.083611.17262540520569099.fujita.tomonori@gmail.com>
To: andrew@lunn.ch
Cc: fujita.tomonori@gmail.com, max.schulze@online.de, hfdevel@gmx.net,
 netdev@vger.kernel.org
Subject: Re: tn40xx / qt2025: cannot load firmware, error -2
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <89515e61-6aeb-4063-bc47-52a9ea982a26@lunn.ch>
References: <5f649558-b6a0-4562-b8e5-713cb8138d9a@online.de>
	<20250304.214223.562994455289524982.fujita.tomonori@gmail.com>
	<89515e61-6aeb-4063-bc47-52a9ea982a26@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Tue, 4 Mar 2025 17:21:20 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

>> You hit the error during boot? In that case, the firmware file might
>> not be included in the initramfs.
> 
> With a C driver, you would add a MODULE_FIRMWARE() macro indicating
> the firmware filename. The tools building the initramfs should then be
> able to pull the firmware in. I see you have:
> 
> kernel::module_phy_driver! {
>     drivers: [PhyQT2025],
>     ...
>     firmware: ["qt2025-2.0.3.3.fw"],
> }
> 
> Does this last line do the equivalent of MODULE_FIRMWARE()?

Yes, it should do.

