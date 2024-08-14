Return-Path: <netdev+bounces-118292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A099512BB
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 04:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66FAFB21024
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 02:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7846B28DB3;
	Wed, 14 Aug 2024 02:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TnGYuMlY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1136B111A1;
	Wed, 14 Aug 2024 02:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723604275; cv=none; b=i6HTsMZYpQas1ot5c0sDVDfJAyYzcMKGCIRMngMCn+uyZtoddSMYrml/KVKuA4GfJZFbmq3Vz9fVuJEgn2wvg0++yPIfTaEjty8oC+mXgZxz5o9rQB6rAXAtHB40ARWL1NQiTbWC4CxXoGSeoILlAx4Yg2J3+/jnN1SEhPx1kqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723604275; c=relaxed/simple;
	bh=MzFat4AX19+kz5477CKCdM9Bs9P14aV91oVUIceILbY=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=iumk/Zpsu3rxdOnZKJRqsgpAjGrp7SUVKSMzTOxTrI0tp0YN/1H4zmOEzRMARjMgPcziYtX1gVP7yvXwycEUEwVeP52MK6CM2vlYa6062fzhQpfWWc/Q2fJ5jS8tTN4Vok+UErOV5HQdodLN5mzrX3RzMZ0cvzsXgkn4AdU6A7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TnGYuMlY; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2d213dff499so610280a91.1;
        Tue, 13 Aug 2024 19:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723604273; x=1724209073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=97nZLM1M4+Xy8zLwa/bcVunjf/6RvaetZ9cky/UBnXQ=;
        b=TnGYuMlYopgfvZ7w8DcmFCRWcsDkbKmc6Oq3LyW+nrrbfdIyuIvlU36DGwz7mxZPXy
         Q0k+Wtf7QhQKKSbH2fpGthJ9TiodDXOHh4BNt4rWG/vFVTDLsDlHD2PwuP1QCJoXklaS
         ixjSxmR+8areX0EwpuQG8LIiCfi2gjpmoV6saZJJCH516hZsqr9kfqYdjMDaZJ9UIJIU
         daEgsktZzyOEE8lMG/5EaM+B85Cz9y8/G6VGI7YwbniBMLpCK79sTbv5g4PtTN/fbO7k
         +UfxyUqFFiNGKZCSB6L3IHGGbFRWo30tV8n+uvttl7eryPbuzRiX83fqzvF/fHHt/mwR
         3Y/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723604273; x=1724209073;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=97nZLM1M4+Xy8zLwa/bcVunjf/6RvaetZ9cky/UBnXQ=;
        b=IRjssUqS1vno/9dmNh/WJ9Bc6ms0Keorf4Nz7xdVqV9eizte5BTjX/bvOWSdE76bsc
         WvMF/ONhddZWuNvmEwQfHXyD7JWlVZBXSqPzO+M84QWhjntWVsbuYrDN4YJ7iM6U4Nfo
         kXfr/rdLeG9o2whDuYRsHBxGPVr8bb42Bwu1Xs4X1DwZkkTcbHnLCxDA81v4c95qQkkp
         Glhm8xeuoQTLPfoM7uSO43XGW6ElcIFQF4Ap5sZahpJY224oihWI759G27hzVuzyPgLF
         0uxQd4dazjuVTeoEX7nGWnsWIJSZrJctqYBHw7gqcOsTANFAkS6/20+LPfHstV8Ut1aA
         XOCw==
X-Forwarded-Encrypted: i=1; AJvYcCXsr0qMpa/oB3NETuSuRKTBaaJ9XkrGiEQAIEpu4PVqKYz94meX7i+f9Qe5RMqG3y2aTTTN41U3tY0H7Z6p7/HfZzc7dpNHycOeS+T4dcQ2u1rStQqY3iJJzrmWvKao00KZZAY54mE=
X-Gm-Message-State: AOJu0YyJ82MH1Pb+kTG7OJ8yo2SGxai5lIL3MG0u+6anfe8X6PFWVMz3
	5eEnIbdOd05tbvJGl3bw6tiIURVplLuG/cwHD0nv5V5tQMb695Jg
X-Google-Smtp-Source: AGHT+IEtDbaSusmE32dR8Lmfk1fAMUNpmgxxLX6m8szPS4+uuX0s1CFkoMn2cZ9Uw7F2zJKxiC2hvQ==
X-Received: by 2002:a17:902:d4c3:b0:1fc:5377:35ac with SMTP id d9443c01a7336-201d6520277mr10380355ad.10.1723604273184;
        Tue, 13 Aug 2024 19:57:53 -0700 (PDT)
Received: from localhost (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd1a93edsm20101615ad.130.2024.08.13.19.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 19:57:52 -0700 (PDT)
Date: Wed, 14 Aug 2024 02:57:49 +0000 (UTC)
Message-Id: <20240814.025749.1664228309880354540.fujita.tomonori@gmail.com>
To: andrew@lunn.ch
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, tmgross@umich.edu,
 miguel.ojeda.sandonis@gmail.com, benno.lossin@proton.me,
 aliceryhl@google.com
Subject: Re: [PATCH net-next v3 0/6] net: phy: add Applied Micro QT2025 PHY
 driver
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <174bf437-5adf-4ebf-b909-036d6443dcf5@lunn.ch>
References: <20240804233835.223460-1-fujita.tomonori@gmail.com>
	<174bf437-5adf-4ebf-b909-036d6443dcf5@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

On Mon, 5 Aug 2024 03:10:50 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

>> The MAC driver for Tehuti Networks TN40xx chips was already merged in
>> 6.11-rc1. The MAC and this PHY drivers have been tested with Edimax
>> EN-9320SFP+ 10G network adapter.
> 
> Sorry about being slow reviewing this. I will get to it by the middle
> of the week.

Would you happen to have a chance to review this?

