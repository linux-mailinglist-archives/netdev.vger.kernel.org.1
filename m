Return-Path: <netdev+bounces-238496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD4BC59B90
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 20:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F28D334E90B
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 19:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6998316907;
	Thu, 13 Nov 2025 19:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLlvBkZJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F199D242D6B
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 19:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763061746; cv=none; b=E7ac8Efj2yJbi+0T26lFeyaL3bgnLaf/7oJQZQtkyN4tTgTAvz4DND1ONowJ2Vee7OAp08gCowVIKWTczzZf5rvDgAuSUkI42+HrrxCURDJVMjenj9tYC0Kq9Zq0jD3D/eUWJmLIIpOfkMztVCt7nVWAD2eTRaN1wbPERhLkcyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763061746; c=relaxed/simple;
	bh=6GSPpH4JqV7cJATH5sxmvD3vVcA2TwGkxC88JIVFRIU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tdFVob7+8YsEGYuD4JDjMz/Rhkj8l8kw0Z3M1Usk7SJUT2ZzjafBihUMsdpqAjKkhbxPhaNJbFKvQ9NOWQVQlnZpyxAe/7oV+C6wwZMxum9jur+0DY+uFdFnBKl67DmFavjat6wf4gfKOyCFRjkZsdlB5jdUDR1S/JsV5co7txs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nLlvBkZJ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47789cd2083so9134995e9.2
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 11:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763061743; x=1763666543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aP34M4Porl2Kml84YDC6rvjo3kn0PHOh2ZYJyPAftOg=;
        b=nLlvBkZJPrTwIxsI0ZNNIbwfvLRV9Kb2xEOrDkG6DAikc9u+6CDQUjE92csBocuyVn
         yN3qP2RpxTO/o1dfmj6twYseBTOAZJhMCgRUS4o8qOQ3b8JTF7Isqk99ZaQjIR9f9eBA
         bWckwyOU6ov1PahGIP/O7AaEtjrQwFrh8JxPN6g03DdVCDQkQgW43eVhImGMC89KicKz
         crd1uRkjNe77fWapS5QqEdtz/DD8XIHE0s/wCRNHitB5+zVlvhSZcr3CbtMFjakN7YLK
         ThjKWdTz+OK7pf38vNJlY0pFP7UOZnW3tan51ct/x7lemoKTLnyvoo/SGCC4YCTIKeJ5
         piVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763061743; x=1763666543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aP34M4Porl2Kml84YDC6rvjo3kn0PHOh2ZYJyPAftOg=;
        b=Woi/838wv2SdkkEb3JHcBenQTx/HK8aP7w0O1V5ot4D+LvqmZSuK+ypOtszlvmShbu
         /VaQnawxffZYI9u89Cy5bH9D2/N0dzFrM4b01Q0DApzKkSvhxKizwJ39BSw0geKKZztM
         P9Tq3xTFI9Hpjq9QuyXP8XF0tsMgb6BW+b3enoUp8mlEzc7aZTITGAVQw9Qk63jPcMIZ
         Uimmso+MESooIw5nHWF4RGCvzMAEHtqFoO4QHlW/vfXDgKM/WUY5e0pBpJhS70QLzPqd
         J7DplCraKcVMPHUX9gKvBrjvt3Y5EpUGwHGpNNjo5YSXUoSB7/qGOgu1kUq0LTq0BBbD
         b+3Q==
X-Forwarded-Encrypted: i=1; AJvYcCX3uRHFtSN/EyCnIV0HiBCQfujA9DuHdjmQUnD5MVvX3+XYjtcBAktXEE1rul4QRA4x0nepi+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpbIv5pL2xjYET3QhU+v311cCjtCdnJyKoTlJQ5BX3xdzg+i9T
	+UI63kyjIWurY7i8B3TF1tFKfDPg1XKEo5FUNC1GTmIrM+AKqmpz9JZr
X-Gm-Gg: ASbGncuUZdB0ohuue/lcyo5PE0Q6hEaXRYwHPBQcxd0XOIXBqUjXHdjKrnfgEn8TPVX
	+N2LpI+n1f2kCsoSf+Rz031ageec5bK2VfQVBWAWn8uOccZRQxpred1sJZae+AcMdvIKKnvqFK5
	GdQH++VNMz20dLiBhQR0wLitz0+T2sqaajj/p3FXD3fIvHzb2TV70eMXlj0C+OEXgHZ8N0fhXM6
	AstZIED/fVYv3rDD+Kq8NL6YGYCVbdfzgWVgeczMwFGoPXZJvrdFoECNPgF6GatDZ74WicUIaNh
	VGumM0QqZXKpD9MANh5jWqtLvSaPvduGtkmwTMGTWXCorgj/2WtuyU541q7GXPBs4pcPnkg1Gwr
	gXTE4ThCuovOAo9v18MTUYZoNFQBJWUSAtp1nhFelPXr8KXDwWRAdlsrfPctoaZ8HkyAKaqRakN
	nFg2nKek2FwGOY72OPh3MdVj2ARbzG+hV4bbvg99P8sJwhunBIa2nK
X-Google-Smtp-Source: AGHT+IFnzCac5LPqhF1dr/JQF1yR6r6fyY87UXe+SLTMp8uw4OIWkmG8Cr/NlSy5VqlWNjVFIrwUeA==
X-Received: by 2002:a05:600c:8b43:b0:477:561f:6fc8 with SMTP id 5b1f17b1804b1-4778fe50f6dmr6586875e9.5.1763061742774;
        Thu, 13 Nov 2025 11:22:22 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778bcf75b8sm27665445e9.1.2025.11.13.11.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 11:22:22 -0800 (PST)
Date: Thu, 13 Nov 2025 19:22:18 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Shi Hao <i.shihao.999@gmail.com>
Cc: pavan.chebbi@broadcom.com, mchan@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: broadcom: replace strcpy with strscpy
Message-ID: <20251113192218.3c17dabc@pumpkin>
In-Reply-To: <20251113082517.49007-1-i.shihao.999@gmail.com>
References: <20251113082517.49007-1-i.shihao.999@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Nov 2025 13:55:17 +0530
Shi Hao <i.shihao.999@gmail.com> wrote:

> Replace strcpy function calls with strscpy to ensure bounds checking
> in the destination buffer, preventing buffer overflows and improving
> security. This change aligns with current kernel coding guidelines
> and best practices.
> 
...
> -			strcpy(tp->board_part_number, "BCM5717");
> +			strscpy(tp->board_part_number, "BCM5717", TG3_BPN_SIZE);

No one really knows that TG3_BPN_SIZE is in any way related to the destination.
So this doesn't actually make the code that much better at all.

Since tp->board_part_number is an array and "BCM5717" a constant I suspect
there is already a compile-time check that the string fits.
The strcpy() will also be converted to a memcpy().

So all, in all, this makes the code worse on several fronts.

	David

