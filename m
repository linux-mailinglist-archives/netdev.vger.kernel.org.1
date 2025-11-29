Return-Path: <netdev+bounces-242729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3A2C9456D
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 18:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 434244E228C
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 17:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5152376FD;
	Sat, 29 Nov 2025 17:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+lp7/0C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626E71F4168
	for <netdev@vger.kernel.org>; Sat, 29 Nov 2025 17:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764436014; cv=none; b=iJRxJWmGLq8gcg8wsk+iIutYokQB1mCKEnBkrmzYSUuXIc2/AW77EAe6mvs9h9v+5kaAsn1LPlHNdTuOc1tSrChuruBvvGW7Bsv6Wb0NIiQXe1E03rg4ekBM1rTGFLoEJjlmgtbIqhaali5iPNNorJ9qMfQSA4IZKxwYaloEwFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764436014; c=relaxed/simple;
	bh=mMptPi/5yPZvjITg7ksI28lKa/3fRSiDMoQzVc16cbY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=eG3jIpd2gZ7FNjz9jWfZuBqLqvZJvGMgR9mk5e0+GSZx8w+BwhbPAZSjf2NAXGzQa77kdUh1bjpbmKuzi1g9KpnUfnrJkV0PeKaQ6ym2wW0DCpF+sIqOxnEJn0e4o8hb6xcLm0KlD1tctMPl9LoHdxsTmlYmiqMLFywbRYzh1yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i+lp7/0C; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-640c857ce02so2493481d50.0
        for <netdev@vger.kernel.org>; Sat, 29 Nov 2025 09:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764436012; x=1765040812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GpVPHqrbrf9GwH41mb12avIzuZD6va8OPE/RSv+PMD8=;
        b=i+lp7/0Cd3BU0algU0MXmgHM/JjFCEKA0STcv71hBvh3QTkEJcUQ4chaSvdVrfBzJO
         3q1yc/SNybpONXcpAWVLWwmB1YOgtttO1Lb7y45eLW8Dvq3WBlShmdN/f1t5dJy0/MI6
         Evpzub2JM3ZBWHfy+BgMkbQSOfbwM2wpJeliwvJfinT8uap/FuFAVMxMEk0W6ulbg8X4
         95inaXfm3PN4GlUFGao5w82EVrSoCqwu+hMiWx1nK3CRv+VfyE1F0zjhvcMOX0lCS97+
         QfoU9L1/p4eejYJxrj4qVyoqiD8C1SW8CrJgTK5BUEPWUbWaTXTMXXiCT490gkcKbroj
         QVJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764436012; x=1765040812;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GpVPHqrbrf9GwH41mb12avIzuZD6va8OPE/RSv+PMD8=;
        b=Zs9oJ4bxo+xdwMGb3BNQ2Fx5ZOjKzwF3/NRj9ShptfN4ooMxWAPAoX/1Kq24jwGz2B
         MvgOSRsordhB0Sb1tvEP8eePl/RogIQHYStVIHX6qVEZ6WcXShPZTdx6cTfNAd1XRgfK
         yEFpVO6VI0AQVeY8U1HNuampSf566rUvCqJFAydZCEqhf6sn/ITKk788iTvIddlEJtf0
         M9L7VG3JebDwSYDX704txP03Nj8IycQ5V026wtdr6X3wgQ2EhgGKDeN+JcspMtRnRC9L
         ttq5zAQq0STviLqtYyw8rys2exMd+R/sa1nThStma5UVv4YkgW8VAvUva1CbsspDT/sr
         afkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcHNtrVFG1PiRVy+zo8EeF8zx1ZXg/x2hrf16CvBVe+JFYi30O/GFsYENQJgwYmOzVr4XKvMg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlkA6GAtIMxRVz/C+zfPlX1E7aQtT0p6ItC67tT3XqvlrbF+4H
	Tez6y6yethZPkvPHSZ9UbYWfbwOoQxCbP/sDu8XkBWJq0NiTBFJ4yvgzexqclw==
X-Gm-Gg: ASbGncsbEF/PEimC/3G9nvwSEv75a4R4vMS0FmPosgkUFPKBBl/GAK40lSS42G14m59
	XJxFltboLyiUtm7IiNwfMzTcD0el3JJQNGuU+jKZzUOjt4fq6NBIJ4y1hb3BjGSTtFHJ4PZFER5
	9xd8xSTr5trANDR1i4OmAbuwi0FuM2cmg5ND+hWh7gVXm7lfNfZumsYVT3MQ/OmnAiMAFP8zGus
	jMZOI7w86whLSRVsjv0E1PuGqX7glj44BBd+BUhd2qFc7lG+cZCuIoCA77kITJr8nTFQaZpaVuh
	jwySnVLHujDhJsopmSnsF8rI4y7iZjq+xKaFZnSsQf5OUlINYd8rRMsFLBYCN9PyGDU+km0vGfB
	r6KYn/l0fQbfhAHLxyU13PwNv56csSSkohbYDFDJNiMWDGOwXZTqHOoDYt6eNT9A+c7ebD4MEmP
	szo0tcWiW1Wq8r1sHvVRV4IMeK+H3rNrlKI92uBVPsj/N9AU8i/IR9l4Lejmdh9p6rWy8=
X-Google-Smtp-Source: AGHT+IF+XDxpUAIUULEjXGGMBjh+RMsC+JzeQv27qoe2yb8sqkZJX44LbNpuPOerCMfGVoJVPEMEWg==
X-Received: by 2002:a05:690e:23c6:b0:629:acb6:d8a with SMTP id 956f58d0204a3-64302a90a70mr17599354d50.26.1764436012179;
        Sat, 29 Nov 2025 09:06:52 -0800 (PST)
Received: from gmail.com (116.235.236.35.bc.googleusercontent.com. [35.236.235.116])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-6433c48472dsm2702283d50.22.2025.11.29.09.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 09:06:51 -0800 (PST)
Date: Sat, 29 Nov 2025 12:06:51 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 John Stultz <jstultz@google.com>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, 
 netdev@vger.kernel.org, 
 Eric Dumazet <eric.dumazet@gmail.com>, 
 Eric Dumazet <edumazet@google.com>, 
 Kevin Yang <yyd@google.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Neal Cardwell <ncardwell@google.com>, 
 Yuchung Cheng <ycheng@google.com>
Message-ID: <willemdebruijn.kernel.e4c6aa98a939@gmail.com>
In-Reply-To: <20251129095740.3338476-1-edumazet@google.com>
References: <20251129095740.3338476-1-edumazet@google.com>
Subject: Re: [PATCH] time/timecounter: inline timecounter_cyc2time()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Eric Dumazet wrote:
> New network transport protocols want NIC drivers to get hwtstamps
> of all incoming packets, and possibly all outgoing packets.
> 
> Swift congestion control is used by good old TCP transport and is
> our primary need for timecounter_cyc2time(). This will be upstreamed soon.
> 
> This means timecounter_cyc2time() can be called more than 100 million
> times per second on a busy server.
> 
> Inlining timecounter_cyc2time() brings a 12 % improvement on a
> UDP receive stress test on a 100Gbit NIC.
> 
> Note that FDO, LTO, PGO are unable to magically help for this
> case, presumably because NIC drivers are almost exclusively shipped
> as modules.
> 
> Add an unlikely() around the cc_cyc2ns_backwards() case,
> even if FDO (when used) is able to take care of this optimization.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Link: https://research.google/pubs/swift-delay-is-simple-and-effective-for-congestion-control-in-the-datacenter/
> Cc: Kevin Yang <yyd@google.com>
> Cc: Willem de Bruijn <willemb@google.com>
> Cc: Neal Cardwell <ncardwell@google.com>
> Cc: Yuchung Cheng <ycheng@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

