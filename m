Return-Path: <netdev+bounces-119961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8217C957AC1
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 03:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99A8F1C20BF6
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 01:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D56134D1;
	Tue, 20 Aug 2024 01:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCVPdB/Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19535101C4;
	Tue, 20 Aug 2024 01:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724116079; cv=none; b=dkjNbCcXPDGTif4PjjydQglAo7ANcHKiUDIOix3yvoS6LuNqXUv89+YmzhNmW55Nq4mvMqWtSVJyIRPG4ZlJb0WTj6jLZKRJ9aouKwgq3yMbWf2BklJqmAkI/lduisoRDGrj6CVB3HqR97O3U3uGt1m6F3k4YgcK0xb21JyuSO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724116079; c=relaxed/simple;
	bh=8pCLvRPG4vgUWMwhpSX2k+B4vS50nxxwKI3EYcger/A=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=lQhhMbOCyXkxMYqc5qCag/k9MZK2jtFCZzRmrwph5PT5US5AnEa/uAtpPQAfPYYSXbcdOtcfB/XsqhjNPeaV9tyd22dBFaH+fs77LEIu3GV/7onvjmII3rMLSE6NbmZFqHh9kiVoGo5kUf815HsCsqdlKSP+e0P79jwbSewCv6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CCVPdB/Y; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2d3ed48c748so714899a91.3;
        Mon, 19 Aug 2024 18:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724116077; x=1724720877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FJLjhXumluvEXGs+t8WvUNcMLDpSA9d0j5Qakf+/Ks0=;
        b=CCVPdB/YODvSiG+OBKxgiccJIuamJaqGnfJc7IixiPcNgkhBLygsijjZd/rDgEEVno
         Q3HMz7nMVLgGYPdBcroIFSffXGrDpDJklkAEwCwXCUeYeOfFGqPm/mxGc8WnHgJyyJoJ
         4RMvUHP5esPlg3kYch+TTFQu+k12awHs9lRMH3Suc+0pzaGafm3wbmmqf2oyl2iLFASp
         /3+h6yyqmEUVbZf6felOHIZAHPpGqUpm5WLlZm34ZZTk1ZJsIKVb/qpXD6dK6PfBG1Rs
         VI7FIeqvDLIjYQfHNG3vRAovusJ5xDft9ZhOppG6b6yTa9FN1esgKFNRe2JSM2QzVXl6
         s3DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724116077; x=1724720877;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FJLjhXumluvEXGs+t8WvUNcMLDpSA9d0j5Qakf+/Ks0=;
        b=T12JzRpGuTqgLj3lcuVa0BC/vnJajS4CGbN3aSv9l0hJUYm/Ajdroh1+SWSgN/STM+
         b5ul7IDusVJeZUoLWYcDpVjBZ+/Mz1BxXSJtl60iV6vZJjCqmWEHoR+HnIAWePUHOTtd
         eR9VUrVf6Pw6olcNpF2TfAhCKlCdS/7+QbwThIcVio92wcGzDnKXzS1U7RJU7VpgnI6B
         wOGbS0AzPjMP8NVrwfWKhg5VqzddcuxSOa/uckApLaMd2XPAt6MfpKaG4sQ+wh+UafTx
         utxxo0lUrzIJTTJKzGPw6jFvZYv5x99y2lZRShXniAI8YRilnh8ugZNgkBLWzIL/n5T7
         oIWA==
X-Forwarded-Encrypted: i=1; AJvYcCX1HDxO1PPoxebY3beep9/qszMVYZRlszQcE8nayJTv36Hk0cSGG08EqEKUWbJtocu4lMShHWA=@vger.kernel.org, AJvYcCXJDUrXGOBmGvWfvHbt28YwvZTkOW/WDFIGAw4TBppbdz6C0T8fmesSAAZY38wlU9ziUatevLTa9MwpiAqgjfc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+bh91FHtyqYIB9yEbt8t0TQ46faCOssYYrZjQEjnwtFtEADvy
	OxcXx1kf3cI/LZXBWqJOyOwELpc/45kA+0EqFblPQCAs3nM5bNCf
X-Google-Smtp-Source: AGHT+IElPVxr9HUXP2x9gBR+LSW2l11InNVV2F8rmy5Md0Z0Xmr9FjogKoH1t3Xw14utHjE3NkGECg==
X-Received: by 2002:a17:90b:209:b0:2d3:d6fd:7218 with SMTP id 98e67ed59e1d1-2d3dfc69c13mr7900076a91.2.1724116076991;
        Mon, 19 Aug 2024 18:07:56 -0700 (PDT)
Received: from localhost (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e2b64e7bsm7950878a91.9.2024.08.19.18.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 18:07:56 -0700 (PDT)
Date: Tue, 20 Aug 2024 01:07:43 +0000 (UTC)
Message-Id: <20240820.010743.20238453596963731.fujita.tomonori@gmail.com>
To: andrew@lunn.ch
Cc: tmgross@umich.edu, fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, miguel.ojeda.sandonis@gmail.com,
 benno.lossin@proton.me, aliceryhl@google.com
Subject: Re: [PATCH net-next v5 6/6] net: phy: add Applied Micro QT2025 PHY
 driver
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <5a063eb5-923e-4743-b72e-57f3fbf82107@lunn.ch>
References: <20240819.121936.1897793847560374944.fujita.tomonori@gmail.com>
	<CALNs47u8=J14twTLGos6MM6fZWSiR5GVVyooLt7mxUyX4XhHcQ@mail.gmail.com>
	<5a063eb5-923e-4743-b72e-57f3fbf82107@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Tue, 20 Aug 2024 00:46:25 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

>>     //! This driver is based on the vendor driver `qt2025_phy.c` This source
>>     //! and firmware can be downloaded on the EN-9320SFP+ support site.
>> 
>> so anyone reading in the future knows what to look for without relying
>> on a link. But I don't know what the policy is here.
>  
> Ideally, the firmware should be added to linux-firmware. It will then
> appear in most distros. That however requires there is a clear license
> which allows distribution.

The firmware is an array in the header file in the source code
distributed under GPL. I plan to add it to linux-firmware after this
driver is merged.


