Return-Path: <netdev+bounces-172993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E42DA56C97
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 16:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04A413B59CF
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 15:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E952121E088;
	Fri,  7 Mar 2025 15:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYbTZ+wR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EE921D3F1;
	Fri,  7 Mar 2025 15:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741362639; cv=none; b=gKpH9Qm+ul639W0tH3HLkWh+GvGd9z+qXX9UfzwPX9uSEwZ2gOpLzwxoqUcwSInQIQ0+IZq4o+B9aeq6mE3sGxXAf4hspLm7twb+dAEGcEEol4WaUJfnhxGziXct4obAK5iiqMqOvvC9HbF/Qrnocd4rf9DKwjX9vlJI5PV6Yrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741362639; c=relaxed/simple;
	bh=kAXQ+ZzimJPAHAQLd0TOYBjQ15b/og8pUMD+4H5zX1Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g+RKkwwwhxP2zc8F6T/U/4AdxMojH7rl0J6cunGd3POgpOqXZu8tPV5afVibMRuJ+zr9BAH6DY27BwxDXhOMpdavb7BxHRP2AhEwJaK9SQp7pT6maaCGuTSTI581GzKQ5MzFduunhD9kKU6kZ8c90PT6FHKc+ZIGW1TTXZFSGs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZYbTZ+wR; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-223959039f4so41851545ad.3;
        Fri, 07 Mar 2025 07:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741362638; x=1741967438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DoxijE6homShQGTn723Kl+zM3ETyZ7atR0+PqV06nBc=;
        b=ZYbTZ+wR/7Vg8liSfHYz92vQpaNuMLsgu1SvGhmq2OZAfxYXSbyzAYKEheOfkQRpJN
         3lKXkX9SvKSZlI4J1O8D9qp3hJeDRt2UGucIptX6weSY9G/bh/uSOq5Ougem/b7h3Ki+
         oR7vnNcqeXEC5EREgaSQt+/s3w+h8j2aWprf7P/76okUrnKHf7SRHMO0KH1qPwHuR6DS
         yIEB6Y4RNJqoONijmr5L5iaMATH4h3V3sFXQHC6b+8J0Uymc5PVFmc5aWP6tAB47GDM2
         +wTY4ew0QAuWlwA29qE/pZ0D/x9VEXY40AuLhz0yd5AU+NMbqIVg45lXexTSyLi1FTv2
         sjPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741362638; x=1741967438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DoxijE6homShQGTn723Kl+zM3ETyZ7atR0+PqV06nBc=;
        b=ed30Z9SqIGm9cvGqPG4/ldhZqmUrY9FUOt4OOnDgRxcnvwCunCFOEXZuQcZPX0b1Xa
         jhuifpPuTY0k8AvTIzY0rEwT2K/GcXMTXafYH6D3uJXeb7jaP9oUPxC5mtB1uwL1wHiv
         btzBVC1Xb1+IdeBnVPhBYfM0NSQiGub8qwowFP5d32K+gPWvxBu+PKW0rjsF1/HPJRAQ
         u4r41eHHldxMrkXZl0XZiYeL7yVSSoMWvpCxVfThfJYtzRaTwIeKUelBpMONrh+VgxSI
         ckRYuGCfps85stoE8Ub3L9t3VtYEXJID7Sq90QOw7Pjy6NzNv1Q2Ruf7PNPBgLCPno1+
         8Vpw==
X-Forwarded-Encrypted: i=1; AJvYcCVwOjYzpcDHe95C8DcwY4r95uhZ4ZtKKPSAfi4Tebbz25ucbqqI2kfTPJSp0zRltnjkSt5Qfj5X@vger.kernel.org, AJvYcCX0x3iv04NsxSOjK8FrW81MhCXLkuE/x9vPGBQjaPi5bpfIU56RjpUhCYmfvDtxbZj9nuG1LrePc3BLt+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk4DIrx4uQEZvYXVUNICz4yO2EFYI53Z8gCmsLQYD9jfBCC5PI
	hPBzgkmYbVNIc2p1Gjh42dZ/3FPamjZO8BP4qGmh8O+PWRjBZMiW
X-Gm-Gg: ASbGnctbfAYK0ryw+OGQlvcy2J3h5Ssmvekei9jMAyuA7YrP1DcQbyBQiutdw7Zf25m
	R4W/FPSjU5XIKiJuxzo4T+wicZ0aHx6N7UK1bGHhZsnPr+kasFJIWGZ/vrpmHrB8LcuRxlqMBM3
	kPrViq64uGh9Y5PvilTE2Zgdl+wXqilrgUD7mghRv6lLTbmquxcLvI4VPNq2FN/TvlQdq4QVCQJ
	Ep+kmUpGQ7XOqaTybwOwpYrELsdYSJnML06YblkDoUYUxP9tu3UHXEjPE/sOb0GyjSzTNQ60gd8
	GsKa1C5tLXM9D3wWiMB/yb7V++u+UwKdTrZIMT7qSJrClljAz8Y0ontH86nIRRSXk3+i1tFWmtl
	sFtmIk3ipiQQYQS1JbVJqa7aXEmbHMvU=
X-Google-Smtp-Source: AGHT+IGmUABBTmY21SyHbc8+cWfQLDaPpbxWyZSUhUPMmDHRqzSjLtNZWiAc3bbejbxxw70wXon1kw==
X-Received: by 2002:a17:903:2405:b0:224:5b4:b3b9 with SMTP id d9443c01a7336-22428bd551fmr70396515ad.33.1741362637678;
        Fri, 07 Mar 2025 07:50:37 -0800 (PST)
Received: from localhost.localdomain (p12284229-ipxg45101marunouchi.tokyo.ocn.ne.jp. [60.39.60.229])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a7f8d8sm31409405ad.135.2025.03.07.07.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 07:50:37 -0800 (PST)
From: Ryo Takakura <ryotkkr98@gmail.com>
To: peterz@infradead.org
Cc: boqun.feng@gmail.com,
	bp@alien8.de,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	kuniyu@amazon.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	ryotkkr98@gmail.com,
	x86@kernel.org
Subject: Re: request_irq() with local bh disabled
Date: Sat,  8 Mar 2025 00:50:12 +0900
Message-Id: <20250307155012.84673-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250307135959.GL16878@noisy.programming.kicks-ass.net>
References: <20250307135959.GL16878@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Peter,

On Fri, 7 Mar 2025 14:59:59 +0100, Peter Zijlstra wrote:
>On Fri, Mar 07, 2025 at 02:13:19PM +0100, Borislav Petkov wrote:
>> On Fri, Mar 07, 2025 at 09:58:51PM +0900, Ryo Takakura wrote:
>> > I'm so sorry that the commit caused this problem...
>> > Please let me know if there is anything that I should do.
>> 
>> It is gone from the tip tree so you can take your time and try to do it right.
>> 
>> Peter and/or I could help you reproduce the issue and try to figure out what
>> needs to change there.
>
>.config attached; I used gcc-14.2.0-8 (debian).
>
>Simply booting it should reproduce; it goes boom when trying to
>initialize INET6.

Thanks for the config. I got the error now!
I'll take a further look later on.

Sincerely,
Ryo Takakura

