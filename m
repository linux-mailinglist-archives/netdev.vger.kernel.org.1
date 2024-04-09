Return-Path: <netdev+bounces-86138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6F589DB27
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 15:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9C6E289B26
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 13:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802611350EA;
	Tue,  9 Apr 2024 13:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wl+fOySI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0FA1350C0
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 13:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712670199; cv=none; b=oCkSAXWooE8l1uobeHf31iwStMwzUnMfGklP6b92XKNULs8kbimkFYY69ReLpMmozr48hxL4EdY34X8f1NI41SpOuFhNVhjeUQoJhdTc0BkeFKq6iIZc9v0BCrr4zMK1iAmCC3+DOP1LhqnBZwFpKUaCZjHOgVKGTZHQooAafjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712670199; c=relaxed/simple;
	bh=yKJSXOjjWfUT4oVrQVVn4bWizSfYjLz+IXERJbRqhJ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jQcfPxV2608uYVEj0BlDVosYtgRADYryYB0lSP5SIOw4MN633xN7C4CC1gXXwfMIRuqUUGMRSYWivHWQal0JdBACDdoBADxjKvYFLL3Z8i7hZGMRH4NrTExa+O4T9Bz55QEan2/umpi54UKH8omKhJ1vTCi68dpw0d4NQRAStAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wl+fOySI; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6ed04c91c46so3755910b3a.0
        for <netdev@vger.kernel.org>; Tue, 09 Apr 2024 06:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712670197; x=1713274997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HbJaku5S1saOKhyxjx+ImI9HX4ZZf5UgoTZfbk+GrEE=;
        b=Wl+fOySIIl3kjuIlugdD0vxygLTC4LkXy6RP+Oo3yMkaPrCs9FaVKIUfG4jGoOp0Dh
         Te2y/bMQFw5p1ZbH4uv1Xknk0S0OFiNdHbJ04fy3Co01TsSiNDvwz0xgN0Sw31AvMj58
         6fT0pdA+D9AnEKatruYU6l0UL773besoiRUGvu0UdLr/eG/xtu9gpaeT5ay/tWW2kpyc
         ySqr8jybg5YyFFTPQBqmg7eH7B5/9H8gnHwS9Fzf10UFxLfA89jggHMz8TI2azDfIxj+
         FV/wmThg+B+bd7GtEPkfC6jfDT90lEOZCfxRJISXjrlFqJglm8EOqwzhWFouxhhmsXxM
         ZLfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712670197; x=1713274997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HbJaku5S1saOKhyxjx+ImI9HX4ZZf5UgoTZfbk+GrEE=;
        b=M5Cf/KdF1uJ9ErvDbklLfW3ZOZ623OZRouiF/zFZuCCfvd28ehuXGYmtEoutnCiVBt
         9n7drywi6MsdlEZlSkPzYDy2X4wvFgMaKrOCMsf2eS5dh9x1VkKq8gr8/oJmXefK7z5w
         Zks5Y7uCv7NpnLk5yUXY5FieDCzhuSBpNbRunmmZANzXEJOvQ4otif8ylFc0OpyEp5SK
         5B/6ddpK5zW04trdcdiWulYY7ZCMXBHkAIdcWbVV8rEPI+jxaECriQuZbftMNJXgY8Nj
         nWBMfi2mFdrm9mfPylXhbl0UWS4UY0UN7rTIn8fY9hLylVR0AF3mjW0KC8qLdtPqrnI4
         gTuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLuXpfLlf8oBW0dvrZQgKRbt2EppVrQSjcTIIQG9fzCsQkMeWe+zX38KVULAuAQcxvUBzHntC+LMy4zvi5iQqI9W2oKf7i
X-Gm-Message-State: AOJu0Yw7pXNa+XoMWEfkWPNrhc3GytfjiZ1BKgn8ykMClqTNAh8p5z7L
	R+CTOaeH/WpKkHVBfqB+6tQY4uXUpmW1805/KcywvrUrlZ+G9g7s
X-Google-Smtp-Source: AGHT+IGCnfzv1LTc7yB069rXcbqX/zcq4EBmmLGOl3gyBwZoBWcDcQVr4NX3Wsm/uzwz+DnzgvCOrA==
X-Received: by 2002:a05:6a20:d498:b0:1a7:50b1:8f90 with SMTP id im24-20020a056a20d49800b001a750b18f90mr12533691pzb.37.1712670197169;
        Tue, 09 Apr 2024 06:43:17 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id lb14-20020a056a004f0e00b006ecf3e302ffsm8618520pfb.174.2024.04.09.06.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 06:43:16 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: kuniyu@amazon.com
Cc: aha310510@gmail.com,
	daan.j.demeyer@gmail.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	eric.dumazet@gmail.com,
	kuba@kernel.org,
	martin.lau@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	willemdebruijn.kernel@gmail.com
Subject: Re: [PATCH net] net: implement lockless setsockopt(SO_PEEK_OFF)
Date: Tue,  9 Apr 2024 22:43:11 +0900
Message-Id: <20240409134311.11505-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408183114.76329-1-kuniyu@amazon.com>
References: <20240408183114.76329-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kuniyuki Iwashima wrote:
> It might mitigate your risk, but it does not exist upstream.

> We don't accept such a patch that adds unnecessary locks just
> for a future possible issue.  It should be fixed when such an
> option requiring u->iolock is added.


Ah i see.

I learned that you should not carelessly patch major code 
considering potential elements that do not immediately exist upstream.

Thanks.

