Return-Path: <netdev+bounces-184678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C33A96D71
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 15:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A72013AA2C9
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 13:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8F91F1507;
	Tue, 22 Apr 2025 13:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DEOSDgKX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E40212F5A5;
	Tue, 22 Apr 2025 13:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745329872; cv=none; b=qMK7r0QyX1/8fvbdg4zNk/znsNOadasFP90DJKVF7LXF4WcGU2/O4S5WQKYMpVpMsTgOZ9d4KE6NSpkO0FVjbWkBUxEpR2/kWfEKUOKegAARIOS/ajfOsnjK947K5ZKywNULS8K9VcSrDkZLwP3bkcPZ6pDiEfCjrThPib0AKa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745329872; c=relaxed/simple;
	bh=xKzrHeCadOGs+/42bx11CXiDm2ftgA8lhRuUSNQ3nWs=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ZGq08aK/YxOCDGC5jVTo9lLUHe0efq3ep/oMyW651cQzB4xWta0tzKH2uOdIyjCY4ADI4U9kXZxNBYcOZH1E/KMJJwjD4s72KQiaRfJVC5sfrVeY+OOVetD4JkZQR6CqURHHJAReYwaBsTszorccRoU9C6n7K6oBeLhKuAdbK/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DEOSDgKX; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b0b2ce7cc81so4404677a12.3;
        Tue, 22 Apr 2025 06:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745329869; x=1745934669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xKzrHeCadOGs+/42bx11CXiDm2ftgA8lhRuUSNQ3nWs=;
        b=DEOSDgKXZTi8gpT/Y1ShHznsCeRX7Xl4rlMkkAVUwUKsn238UXDQgukZmbGAtozIrA
         BWqna6o2dmz56NhuheXdjqmmKJILEtOVOIdotTJzaxECDL+lCiJ/2CYSXb22RU4DXVRQ
         b0b03pqKamjYRbajg7pnoAg4hqR0ytd1D+Q5uf+tOlgWWqYrFzIhx+mTMYzjKjrX3cv5
         uNImO8gwOYJiI6l07xSTlB1/dy2ZMvIVvMeJb5mXu6POGdUIplpuZEMigl2q0FiJEPue
         lFXEouvWwA29k7vwjo2ZdAKoqrmjCnmw7mLzuzs00AO1vjunhTb/QDcifX/eFDxftZ0A
         pJog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745329869; x=1745934669;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xKzrHeCadOGs+/42bx11CXiDm2ftgA8lhRuUSNQ3nWs=;
        b=TFDB5sZaMjyAFW4KKo3N3N3OSIngSigJHi5DoiYO3cGtT5A5u+Z0PW+8kYWsmJB8G5
         EYZIAyklP+xqI9Qv3yrQ9IoBw5tfB2lzpb3aEl3QQkKXJ5Sy1N6pvZpdaWS2m4LAidXa
         i4HjO0ZenTTHoaHX3Bm5y19scASYDM0nGzyg5Jo2J+//pg96672N8C5G99UMU5pAChRr
         GPyTnWXEh9dJIsqFptt/J0JQ/dOapmWYVJPBjXaiR09h9KrEvwpDkGo5AI1UUk7/+odv
         87RVO2nZ2QmFFhlVQi89w5yDwfYbDQWW6cKwo+unPUVlwLl9O/oncg30Gts3loiSrcLT
         MiXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGydUFoiSCTpqwZG+CkEFUEU/lfkzaryOxzq57ChcpxQWRjmCL9Xxn3aCXfOYGmODuIYMfwUUrFveneSg=@vger.kernel.org, AJvYcCWgU2gf6FnbfFiSmqRA1tlNoZLlWjc43l3ejcG0Ok5PwEihe0t0hQhzFr/pmAUWS+f8ryk6gY5qIs71XMmqIQE=@vger.kernel.org, AJvYcCXNNu7Jvlh2iig/FLh8JBl8ZyZSHYIzu4RIML5PjESuSjhVtvnXibUlSGQYAj0Mk88ZqEIvQFXf@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5kU46tcvt2wfDWxr+Ob+Go8UTuzeoxcHTyfuFpkkgVMBYHjf0
	Cdx3KxQPVSCVpLBNHGU64zcWLrnqBqrv8UcX5gOGXQLWXm/fWgCD
X-Gm-Gg: ASbGncsl7EMznaTmeWy2N/34HpqZynMqEtV/ropwvN81X/8/TgYyoeGCaP5PZBwbTXq
	6kupl3bFwdJbeMJFTu7lg4WoeqkmfDLdFMxI5GVlqLz6sZBjE1A+0Ylon3UrPbtZfeqSsd5LvHw
	53V0vDpJLlxbb8j2YbqJKkDsMNS8rb+b1q73FPE3y8cakuNc1C3/Wkzqhty/16xoV7opV3N7fde
	trtCtuXvD8JbMKe9n5DHvwL1iU9/jzPDV4IxB7eWSLnfKrOwnY/wPl/yivtCFVryPFDyf8F5Eu4
	ZU9Wp1qIlEIsuia354vh+tA3WdyYt/zTEWYR6nbfd2Kw2sUzwVPyqWPVxBhRVMmCewRQozRMByB
	stLGN4JRQJEp3FBNt3ZKe9mU=
X-Google-Smtp-Source: AGHT+IH7g7HLPrgrirUhH7WbBplTDpWsqEo7X6lZeHAH0gOqzVtZ9uaIxnUlmIFLZ8kuUyn8sEOMmA==
X-Received: by 2002:a17:902:d4cd:b0:223:2aab:4626 with SMTP id d9443c01a7336-22c53567019mr209711955ad.11.1745329869356;
        Tue, 22 Apr 2025 06:51:09 -0700 (PDT)
Received: from localhost (p4138183-ipxg22701hodogaya.kanagawa.ocn.ne.jp. [153.129.206.183])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50ed12cdsm84956995ad.204.2025.04.22.06.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 06:51:08 -0700 (PDT)
Date: Tue, 22 Apr 2025 22:50:48 +0900 (JST)
Message-Id: <20250422.225048.2114914440124077525.fujita.tomonori@gmail.com>
To: a.hindborg@kernel.org
Cc: fujita.tomonori@gmail.com, boqun.feng@gmail.com,
 rust-for-linux@vger.kernel.org, gary@garyguo.net, me@kloenk.dev,
 daniel.almeida@collabora.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
 bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com,
 aliceryhl@google.com, anna-maria@linutronix.de, frederic@kernel.org,
 tglx@linutronix.de, arnd@arndb.de, jstultz@google.com, sboyd@kernel.org,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 tgunders@redhat.com, david.laight.linux@gmail.com
Subject: Re: [PATCH v13 3/5] rust: time: Introduce Instant type
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <87cyd4bjcp.fsf@kernel.org>
References: <E9nr7KtdtfgTx8OzOOMM6dg3LRl1-BqtqXj6-tGosNOz6Gi2PvOpoyiiqPGv_9nL8hfBOcnCbGP-LfBKIjlV9A==@protonmail.internalid>
	<20250416.124624.303652240226377083.fujita.tomonori@gmail.com>
	<87cyd4bjcp.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Tue, 22 Apr 2025 12:07:02 +0200
Andreas Hindborg <a.hindborg@kernel.org> wrote:

> OK, Let's keep Ktime for hrtimer for now. I am OK with you putting
> `Ktime` in `hrtimer.rs` but you could also put it in time.rs. If you
> don't want to modify the patches that already has reviews, you can add
> it back in a separate patch.

Understood.

I added a separate patch that temporarily adds Ktime to hrtimer as the
first patch in the patch set. Each patch can build and run correctly
and there are no changes to the patches that have already been
reviewed.

> Either way we should add a `// NOTE: Ktime is going to be removed when
> hrtimer is converted to Instant/Duration`.

Added. Hopefully, I can finish it soon.

