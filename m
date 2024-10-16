Return-Path: <netdev+bounces-136024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE0A99FFC5
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 05:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FCB71C24326
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 03:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C947F186E5F;
	Wed, 16 Oct 2024 03:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k75JJuPE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5611018B48F;
	Wed, 16 Oct 2024 03:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729050835; cv=none; b=Ez/7hMvq0/FRUxR4IQR/JSAGsvJ8q2sR3W+P/jI+96ee52E5j+Ppmc1Q+MzXkVLXfYy5pZ/Owkn34zUpPOq3tX1jBegpJxjCtekGyS6QqGWQ5dBMulbOkTYA5CsZznu7OuKNFWZKqn8lPz05Es9CHmcBBXJohJzbmfQjyFGkL7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729050835; c=relaxed/simple;
	bh=IcMWuPB8VR64rDLYBYOGRGA0VJQ3fRc0RASHVWzNl3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ceTql4xMi5leuDl+VV9WtQam1Apl92YtR37YadFqHJVDIbaqdoPEyCrDGVKxVUFZegfdUhe/GND/9UPEwrSuzhIGYHHDZNVnfx6FjRqMFIVfHPkvMJPzCYSXmzwbr42oCA1VoVPZ8hRA5qnWXDxXItei/N9pPFA7NfiViDq+SHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k75JJuPE; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2e2e88cb0bbso3470274a91.3;
        Tue, 15 Oct 2024 20:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729050833; x=1729655633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0j1SQRGmCZOe+0FnzFGm8ZqtXpWgNmgq2ZQqT19Tg0c=;
        b=k75JJuPEmkW/5f/xQ3WHDc5M6+3rQ3ign+Wap3FNf5/2zgehUwIJOiBbRXBScmdcXq
         ZHxKltuRk/XNjVCuf2Z3Dt8lMOdR651iQT6bT7TG3/amDLKn+CqyQuvfaSycu//wuOAh
         VSWmAmxTlRA69j2Vnw/MOzJpjLZ/WnK/gPuYrPK/YqjOojDHLuMHPqseBfiEyDqbzHO4
         QrWfniNlAo3ibYj3NPsWiUar/Xz9v/u+n/J5M1NrCxDI8/d+oAzzcLDSpxJeDCg/GY0N
         H9xQ+hBjCcO4jH5011tjcEESwPYkFCycMSUqC+olQoncybVlvNIzkBeBewEjHJtYKKG9
         vkXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729050833; x=1729655633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0j1SQRGmCZOe+0FnzFGm8ZqtXpWgNmgq2ZQqT19Tg0c=;
        b=Kr9+fBscGpHYlV1gO60TxwvCiakOq8ex+gXR+wLNi9uN5DAfbXefWLu3lwBvP5+ho9
         WfB+9i76sRDwphKpNVLVuWFhe9S+7zDTjg9J6mr08ygwT3gnwMlJFUWn47227Xn32a7g
         RYEY1VfinDUhtJ1iIpllYAl7JNqeFbP0fUqSRDCjj1hwu7XzYsNpcVFYy5coxblit6uQ
         DzgBH7s/4nwIwfNEN6OSnCSrUNFhb5Ek9Lwp2bWQZ0P5qfWd5igD16WyDbnsJRr2Zfxp
         4coEC+PRlzw8gAdSxdPWkJuiP4agS6xBwz5r5WCWa8oF9Lgqydhbxxajo7KCqzB+93N9
         H+Cw==
X-Forwarded-Encrypted: i=1; AJvYcCU6ryejA0jd+AUpdKpfvBCdLBl1lQ9GhMZaXHF4FQ+nLxyZg6YvdbQxcHBwY6leoz0+dN1yJjwBW/EySSA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAUu8TYbqpLqG3h8K3WkziGaS9Sa6sVOzwUU4AAiGfy5hcK+FO
	TT8gOZhAqXuH3NAFtJGnetl17yg5bk2UXerCp+BmeG7MqmCa/Q6tcDal+qCF
X-Google-Smtp-Source: AGHT+IH6giL8Trj0ATYvjOWORVSahtJgstNR2ZjYBD2gOGpvAMUjXOAIwhRHF+AKVU2DWRwuIWxZUA==
X-Received: by 2002:a17:90b:4f81:b0:2d8:82a2:b093 with SMTP id 98e67ed59e1d1-2e3ab7fb661mr3079549a91.13.1729050833148;
        Tue, 15 Oct 2024 20:53:53 -0700 (PDT)
Received: from mew.. (p4007189-ipxg22601hodogaya.kanagawa.ocn.ne.jp. [180.53.81.189])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e392ed1a4fsm2885691a91.17.2024.10.15.20.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 20:53:52 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	tmgross@umich.edu,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@samsung.com,
	aliceryhl@google.com,
	anna-maria@linutronix.de,
	frederic@kernel.org,
	tglx@linutronix.de,
	arnd@arndb.de,
	jstultz@google.com,
	sboyd@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 4/8] rust: time: Implement addition of Ktime and Delta
Date: Wed, 16 Oct 2024 12:52:09 +0900
Message-ID: <20241016035214.2229-5-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241016035214.2229-1-fujita.tomonori@gmail.com>
References: <20241016035214.2229-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement Add<Delta> for Ktime to support the operation:

Ktime = Ktime + Delta

This is typically used to calculate the future time when the timeout
will occur.

timeout Ktime = current Ktime (via ktime_get()) + Delta;
// do something
if (ktime_get() > timeout Ktime) {
    // timed out
}

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/kernel/time.rs | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
index 8c00854db58c..9b0537b63cf7 100644
--- a/rust/kernel/time.rs
+++ b/rust/kernel/time.rs
@@ -155,3 +155,14 @@ pub fn as_secs(self) -> i64 {
         self.nanos / NSEC_PER_SEC
     }
 }
+
+impl core::ops::Add<Delta> for Ktime {
+    type Output = Ktime;
+
+    #[inline]
+    fn add(self, delta: Delta) -> Ktime {
+        Ktime {
+            inner: self.inner + delta.as_nanos(),
+        }
+    }
+}
-- 
2.43.0


