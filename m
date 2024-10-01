Return-Path: <netdev+bounces-130923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A7698C140
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 17:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 507ED1C232C2
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 15:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9901C3F01;
	Tue,  1 Oct 2024 15:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRv5lFjP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCC8C2E3;
	Tue,  1 Oct 2024 15:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727795526; cv=none; b=C7oaox81vOnY1Cld9yW+cUsTGxLubsVA+rfsRRrceg2jPmhN/zujxpnBXj/YpCrCp6Ub89wCry53ODLlIt6eug4oprpmPKljA1vh0SWp8jUOjIwx1lPY/jfmD46ZNibC2lb+i1qgu+JdRCf+/xNtiBdmlkKF0iZIXpT6K/GoIFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727795526; c=relaxed/simple;
	bh=4CMi0PgrHk5jz6m2lnNq2dvGQCypbYULpmcYcHB5ZgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q7ROFzU20n1LKSL8k0A+QGQECqZHb9x7Rtr+0y8cU1cnyP0a5tNVnfbNy+1S2rQBUgenh7yLTSc/BO6S5DWA8uv5N8e/xHYJFjtOFQjK/2KB+bUcwMhh8lWmuMtD697pg/WWkBZlPG73XHIk2XCur6bBIxc7QI4jNTzIfQuJ9RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cRv5lFjP; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-508f5ee8f50so1270534e0c.1;
        Tue, 01 Oct 2024 08:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727795524; x=1728400324; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4CMi0PgrHk5jz6m2lnNq2dvGQCypbYULpmcYcHB5ZgY=;
        b=cRv5lFjPDZwt2h/xYipMuz6NewcJYTkwgAIPvjnwkLDIfSP8OXJoT968zM05ikss/W
         70ihdzjvIOPVkKDSg9t6jpBCPrMPUtJu6i3KltO29OTNe1ZtZOvmUsmQDrwah6LH0xGB
         bHw4CjNeh43OFM7LWoBV8PVKfZSED1/JvPS4eurW5fcgIkrr8IVcsi3myeiL09CJGPlt
         MsvkGIHDs2OcMKdVGa2zQSOXP1Q0uVkDGL5GiCs+gE7Bsv9qD5Uok3Tb0dCG4AWfGvV/
         fQm7q5420IbHxC4aSh0H8lHfaHWejGavn/AA3MyKKVS0DncM4V2lG3raQsGp005CqSeD
         pPIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727795524; x=1728400324;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4CMi0PgrHk5jz6m2lnNq2dvGQCypbYULpmcYcHB5ZgY=;
        b=dBe/xTwya8321xv8uNwxjhgqN7AsEiLGotrdTOrQfHbE2cg6C0YRROwWCjBoC3fU+9
         4ZJelUCunMoR03zdnYGu6EJjGeXRw84BanS3ps0eWRqmGiVrZdhb2H8DpdUv0RJoQ/oI
         Gc6+M0iQgu32ftRmeM9ZOefM8CzXWastnwThfr31jfjjbHIqfk824fd6+HDmJsy+Y6Uv
         gNQjcJzkcUo+0V6CbmSy/BtMrlstDyNNTTdgynbVGH4GciRlUZrCBYlxJNfAolSNxEHs
         No/tFF3hYmjpYdzPkTlkC8yrBHIT6biG5z+3QodeM4tA0FSskG/eLTCpuPzSJKl3h6lM
         YkkA==
X-Forwarded-Encrypted: i=1; AJvYcCVtERNWUL7t68OtZj7eH56afo5UhYwV8yVQXLFcNxQHI0AdreUcJlX1JDzplXvZdz5e2pUnIgockFE3KFM=@vger.kernel.org, AJvYcCXQTHcJp2+KjCqA9jfgiiqlUfLsQ0TxASoVXZqWoQ0I/mrWpCdzVqFOzzS5BjLE7tLn4cjNemZI@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx5ekjxIWJP9prIEsgV9LP1hGriY25s+3LvkpG9reN01IGKlKm
	wAcj01dtmLkUaMq8T5pDDvZ6dSVbOHr/DyrV91WpXa8n+a8vNyy4FO6q78Ymrl0Z3Vxh4Nu+26a
	fclu2bz2/a1/1wlvzpzoxyTfzqjA=
X-Google-Smtp-Source: AGHT+IFSXFJhdkMnAkiwTP/om0JuBKKxMVYEvfd62ZvRkkLAueVBoD+F9ZJx5kJPFDxHwl70Cyz+G1cdVF92fa7rQaI=
X-Received: by 2002:a05:6122:794:b0:4f6:b094:80aa with SMTP id
 71dfb90a1353d-50c5821c445mr125273e0c.9.1727795524237; Tue, 01 Oct 2024
 08:12:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923113135.4366-1-kdipendra88@gmail.com> <20240924071026.GB4029621@kernel.org>
 <CAEKBCKPw=uwN+MCLenOe6ZkLBYiwSg35eQ_rk_YeNBMOuqvVOw@mail.gmail.com>
 <20240924155812.GR4029621@kernel.org> <CAEKBCKO45g4kLm-YPZHpbcS5AMUaqo6JHoDxo8QobaP_kxQn=w@mail.gmail.com>
 <20240924181458.GT4029621@kernel.org> <CAEKBCKPz=gsLbUWNDinVVHD8t760jW+wt1GtFgJW_5cHCj0XbQ@mail.gmail.com>
 <CAEKBCKOykRKyBGzBA6vC0Z7eM8q5yiND64fa4Xxk5s5vCufXtA@mail.gmail.com>
 <CAEKBCKOLPUYJaXOG9p8Gznve86vq+GxOde+iZAYRCPqdjEAgsw@mail.gmail.com> <20241001134233.GS1310185@kernel.org>
In-Reply-To: <20241001134233.GS1310185@kernel.org>
From: Dipendra Khadka <kdipendra88@gmail.com>
Date: Tue, 1 Oct 2024 20:56:53 +0545
Message-ID: <CAEKBCKNZ0=VjToNvjno=h88o0P2qc97LUdeJ5d9w-JtdneFGOw@mail.gmail.com>
Subject: Re: [PATCH net] net: ethernet: marvell: octeontx2: nic: Add error
 pointer check in otx2_ethtool.c
To: Simon Horman <horms@kernel.org>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com, 
	hkelam@marvell.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Simon,

On Tue, 1 Oct 2024 at 19:27, Simon Horman <horms@kernel.org> wrote:
>
> On Mon, Sep 30, 2024 at 11:57:02PM +0545, Dipendra Khadka wrote:
>
> ...
>
> > Are we accepting any changes related to the error pointer handling for
> > the driver octeontx2?
>
> Sorry, I think I'm missing some context.
> Could you explain in a bit more detail?

We did not accept the patch where Vladimir replied. So , I thought if
there is not anything like that there, then only I will send a
patch-set.
Hence, I asked this question.

Best regards,
Dipendra Khadka

