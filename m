Return-Path: <netdev+bounces-138076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B809ABC8E
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 06:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54A4B1C22CC7
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 04:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0A08615A;
	Wed, 23 Oct 2024 04:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQwLnKx8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C224CDEC;
	Wed, 23 Oct 2024 04:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729656127; cv=none; b=thrNwzGRAuihTenRTxg4nxgCEjF79e9LXKHOiupEiqvSnOxG2Ao82t8zICNxj+pkJG6bXsbd59YoRpaj6N4C0JhXQw5Atlvv3+0ysaWpk9JQsWn5XlUznnsI9RxVocI7ppWtbW75gApuyBjD4kY+K4dY/qFQuUx4Blo+44NasoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729656127; c=relaxed/simple;
	bh=qzodVM/fsIWfHIH6QY879X/S4GNE9bYUaL6TGQKEBmA=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=u9itOj/G3dTqVWSyyts/3iMEF0BsAXvV4W1ScRpe2dTC3IH13GgxkGxB2iRPa/mH2rNJhToovTtFKqVtMV10go+gr62grFCCZE7yXQmVzWfyzoGZX9bY9hWtcIMo2ABahoEsPZ1Yo2ByO3eJ+3ATX3XlVBU5SJXBRWveiast/Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kQwLnKx8; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20cbcd71012so57381525ad.3;
        Tue, 22 Oct 2024 21:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729656125; x=1730260925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eIu4VTe+QT3AZHq1LvTMrjErchdwMO0AUGPJLBr3RTw=;
        b=kQwLnKx8buFNtTQRxtu5WbcigKf3EJlnJG8vTkWcOhHjlfkJJplKkVUK7LqL2S1ZeA
         NTcaqn1nMS/QhUM4C2U9E1+fa5pOO4RlCtiNLJLAReeQ58kJastJFOYTL13ZLa0LST1g
         88ISHRKGcCRz6EJg5d/gbU46wcX8AnXUwv94bLDAEHp6YQ2Y2MbxFaIdeZaLJGdvQzRk
         hr8cCGQBi9fxVagfRAku8H3y/HrCCMlZJmVuZHdgI9thBDoPbW6zj8WliOI4LwbOInwu
         KxtFh19YF/OOPZM9HWKsYZVhaFxpg7o9x7ieD+47/jTVFqBbI+kDevlvGs8ERxRoZRvA
         DFxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729656125; x=1730260925;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eIu4VTe+QT3AZHq1LvTMrjErchdwMO0AUGPJLBr3RTw=;
        b=tM5EsJemc1nw1c9QScjeFqyiMfj6ZXQgQKAwYXofc2PRIVzhPheAAgMVHGKXzEi+jb
         f3jkM9U3kaciG2gM88oYEPZqDJKIYXWeXZL76ZsbjnyIkHGJh4Tn5qJZ2+czuuBI5FSt
         6I4z6MFgTj5+WsSqnOr1vHCJXVJZkrnAZlNaT5XZwu5kB0RcKXRNiH0H/ccQI5FI9cMD
         ywnEcdsnMz3ORt5Aa2QmbAk/+QGij4LPYKFCsryuToG4qiAguHZb0zFoZxyucE2HqxNd
         M3vlX2vOea9XHNUTFC9tl/IcxMqxfTXoF3k2Fqu9eiUftdGO+qzH2jBzpJ+Ua5k8uvpZ
         9yEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgOMRIYSDGlkSV7oTfMibfeAoVKbgsoe8SJ0WvyAhR1WtKMpVQv5hRbaD3/lC15xw66ife5syr@vger.kernel.org, AJvYcCXKfxZ759HvtZ/MoHUkVLeWTTmbIJDQ8v8hnW3RQGgQWjpNMfQwgx3Ci9/VukOsvQmISVDo2MUuCNGeBI0=@vger.kernel.org, AJvYcCXT0yMGlmDAVwAKsifr5ATTHSH5dD2BipaX/bHOnDR60oTD3iDxlDwm9u1FDvX6W+17eTjoMAfX90wO9SULBgY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5aHZ1J77tVRhGLvNRLAK5oNYQ7g8ep32Z1o++z+m0PGCqrm/B
	ehr4a/ji9XtS9UEEKAPc8sLT9JffJiSrSAh4YTZ7t74GjNwkgpSp
X-Google-Smtp-Source: AGHT+IEA0OaL7TmanWUylnGUWgTWQuYf/CJqzWPqvzO6FA5jN5lErx5NU1zG9Ikfn+WCvjv+it06lg==
X-Received: by 2002:a17:902:d4cf:b0:20c:8b10:9660 with SMTP id d9443c01a7336-20fa9e9f824mr14785265ad.44.1729656125159;
        Tue, 22 Oct 2024 21:02:05 -0700 (PDT)
Received: from localhost (p4007189-ipxg22601hodogaya.kanagawa.ocn.ne.jp. [180.53.81.189])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0f65c0sm49255125ad.289.2024.10.22.21.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 21:02:04 -0700 (PDT)
Date: Wed, 23 Oct 2024 13:01:52 +0900 (JST)
Message-Id: <20241023.130152.200800395770389333.fujita.tomonori@gmail.com>
To: andrew@lunn.ch, anna-maria@linutronix.de, frederic@kernel.org,
 tglx@linutronix.de, jstultz@google.com, sboyd@kernel.org
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, hkallweit1@gmail.com, tmgross@umich.edu,
 ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net,
 bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com,
 aliceryhl@google.com, arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 0/8] rust: Add IO polling
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <8dfee5f3-98f6-4b84-8da7-0bf4c61bae24@lunn.ch>
References: <20241016035214.2229-1-fujita.tomonori@gmail.com>
	<8dfee5f3-98f6-4b84-8da7-0bf4c61bae24@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Fri, 18 Oct 2024 16:26:54 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> On Wed, Oct 16, 2024 at 12:52:05PM +0900, FUJITA Tomonori wrote:
>> polls periodically until a condition is met or a timeout is reached.
>> By using the function, the 8th patch fixes QT2025 PHY driver to sleep
>> until the hardware becomes ready.
>> 
>> As a result of the past discussion, this introduces a new type
>> representing a span of time instead of using core::time::Duration or
>> time::Ktime.
>> 
>> Unlike the old rust branch, This adds a wrapper for fsleep() instead
>> of msleep(). fsleep() automatically chooses the best sleep method
>> based on a duration.
> 
> This patchset is > 95% time handling, and only a small part
> networking. So i'm not sure netdev is the correct subsystem to merge
> this.

The time handling code became much bigger than I expected.

I'll send the next version for the tip tree.

TIME-KEEPING/TIMERS maintainers, would you prefer this to go through
the rust tree?

