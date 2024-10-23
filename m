Return-Path: <netdev+bounces-138212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D76E49AC9E5
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 14:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DC411F21CE8
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 12:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249491AB6F1;
	Wed, 23 Oct 2024 12:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMVim+A7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AD819E99E;
	Wed, 23 Oct 2024 12:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729685981; cv=none; b=hsczFrQLGteOgGv4hh85U5qos/9jiCUSdaFZhB+MGxZ9o1ApAA0h8GxqWxyLucwpq/gZxTHpkDl+W4EUBySRs2VDQDVHuMpJH0jVLEQa9xoqHeM7VG/WdpcsQnHIW7uBQ6dbnxZ/BRekXHSK/m9rMWGoPI/WwnbM9HH/rBAzLZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729685981; c=relaxed/simple;
	bh=bpoSaXCNKO7Cw3mJI5N3nyjRvluxJRnEyt9XdHcLaHw=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=LG4HCBJjtNNk7krm0ZzzP/4iQ/ube5AAUNkJofN9qLr3877lpoU9rDH6Tgyxdaqn3H31GR0ckiWL+8yEH8cx+onRdnZY277XC2xTxpDiD2FmX8bcnavsfvYKH8d7VmpZJ/hfxMwO7WGBEngC8Mio9fW8tErK1iwiAbpz0dOOMJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NMVim+A7; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20cdda5cfb6so69422415ad.3;
        Wed, 23 Oct 2024 05:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729685979; x=1730290779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bpoSaXCNKO7Cw3mJI5N3nyjRvluxJRnEyt9XdHcLaHw=;
        b=NMVim+A7t3dhUeF34ZqSnxFvXSD+fiA4hSHO3TdotynfE/EjGEAeJd6MYHlnezqRhG
         QDj9gF55k6RMWGsRqvhuCvhh/PTSmTg+h2z39gh9I8dgY6BiOSWfKzjCK/YOXdEsXVIj
         ncZXZvIXROkofifSNwFGcbTgq3nkkGgh0w8+iNblhh/0kYS1NkZDlzF5LxbTTp93GYiB
         xBGzSeHe0UAebSxCVWLVHIlK0dYmbAG+4Yoj3kiHbNtb05tYhHhSP+DBAW7To8rnooWk
         cRTuadziO2xB7GQXEGjmgNYwtqZWlmWvwZ528GRFLlFDjcKGLzCEmjOftPQzyBHMX5HY
         1kCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729685979; x=1730290779;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bpoSaXCNKO7Cw3mJI5N3nyjRvluxJRnEyt9XdHcLaHw=;
        b=iMJbE6gEZtHBz8BsNDQEQPYD9IJqvXYLghVkTpL10cEdH75yRP/OJ+OVvOR8UpPH1V
         ggpjsXLSQPUX4BvrazX6Uv3dkR+Cq0gs/hh7CvIeICR16t9I8uPl9hoVd8F1dYEyydnr
         cW+TcEAqyRrteHJHP6bxo+lDx2QQMzNvHjlDJgfdoo/UQoMPmvAwGrx19RVAbkN/0cYX
         6VwvfPkD9CcnB0c2AMCYUIe32xL0wAYe2Kwl7QbMr3oKJeIaBdmllCwW1thkrQmADjdy
         84JbFhTFclhhMej0oyVq9HYJcDBy/lBDTDavoUAGk8fJAy+rP0ygB9SvNHWZK7umsbZE
         AvAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMFGv0RkNILT3sqqxTTnmJMRjgQPErm6eMDrs+MLr2k3AsZSpnURQRq6Vg+sRzcmYMmraWj95j@vger.kernel.org, AJvYcCVoG+uProIl9aetJTAV3h6XhWA6lZA1p6cYmLSWIRVMm/tZgvOa+a4qX/tk3KvHhUzWXWX0J3yn+hv41jcp8nk=@vger.kernel.org, AJvYcCVvkvMer3dl6Y59VcURb6It5heunUOZKQALDd8zSZtrJ+b60iQ4lTz/dZmdhW465JiPsDggA/2Q2qwdftw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVGewPAuIfM0UiEYvrWi0c8nrDGhJTm+e1L9ZLos6JY7f1hR0l
	+kroazeyrTJYTo6jstxN2qqRWKnkXpLjMNF0GRHhonPzWDLoHwHv
X-Google-Smtp-Source: AGHT+IGJh3IdzcNDdDdjjhDWtvRZ9eYEFwFvE4gYLdxgsHx7HcV7hGTX23QteHRJcq72I38G1dqnRQ==
X-Received: by 2002:a17:90a:f6d7:b0:2da:8e9b:f37b with SMTP id 98e67ed59e1d1-2e76b616a98mr2558286a91.24.1729685978855;
        Wed, 23 Oct 2024 05:19:38 -0700 (PDT)
Received: from localhost (p4007189-ipxg22601hodogaya.kanagawa.ocn.ne.jp. [180.53.81.189])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e76df52ff1sm1248770a91.6.2024.10.23.05.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 05:19:38 -0700 (PDT)
Date: Wed, 23 Oct 2024 21:19:32 +0900 (JST)
Message-Id: <20241023.211932.442277563193487776.fujita.tomonori@gmail.com>
To: miguel.ojeda.sandonis@gmail.com
Cc: andrew@lunn.ch, fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, hkallweit1@gmail.com, tmgross@umich.edu,
 ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net,
 bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com,
 aliceryhl@google.com, anna-maria@linutronix.de, frederic@kernel.org,
 tglx@linutronix.de, arnd@arndb.de, jstultz@google.com, sboyd@kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/8] rust: time: Introduce Delta type
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CANiq72msOTdVLjX+7+Xx4Si2Sh=s1M=wrg_T+QkpFyBHSC9gwA@mail.gmail.com>
References: <CANiq72nV2+9cWd1pjjpfr_oG_mQQuwkLaoya9p5uJ4qJ2wS_mw@mail.gmail.com>
	<fad19413-8d58-4cf5-82e6-8d4410fd7e50@lunn.ch>
	<CANiq72msOTdVLjX+7+Xx4Si2Sh=s1M=wrg_T+QkpFyBHSC9gwA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Sun, 20 Oct 2024 15:05:36 +0200
Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:

> Again, if you want to throw away all the unused methods and only have
> the rounding up one, then that is reasonable, but please let's not add
> misleading methods that could add more bugs than the ones you are
> trying to avoid. Please use `as_micros_ceil()` or similar.

as_micros_ceil() looks good. I'll add it in the next version.

I'll drop the unused methods in the next version. I think that adding
a type with the unused, very basic interface isn't bad though; it
could give more info about the type.

