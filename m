Return-Path: <netdev+bounces-158748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F81A13207
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 05:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA4A27A2E65
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 04:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6598C15252D;
	Thu, 16 Jan 2025 04:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFKn9xS6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BD74A01;
	Thu, 16 Jan 2025 04:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737002556; cv=none; b=DKzaHU4bahLUPjQS/mIfCySz6y2zzZkr9T2g2CK7VZXWmJ/GlpS4fNBArJBT9CdQ70a+0A9Pdb+LD6m1pKkj4g2pAmvIJ5TfwwnQ1OMONO5OD/7GZn3SFATeOKGAlMVJgo4jsG//dUThlYYGNpxb2l548c7I0ZY+0R1A38SpYzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737002556; c=relaxed/simple;
	bh=Vc+8HUJI9ajHvEkwsTV8Xxd958VCwxmLyh0VR+NP/iw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UmPHa2CQcb3BAi8xyCzK+2z8/gHFi+GUPua6vzk5weLVKazpbRgMtxSTG5NcTnAjeDZodIkeWyWuR/3DmXo+Cxg5b5wR1sirGspp3vFukCX0gWttIRNI3MKNWTtutYaT4xyGN+c81EivXwOJqxe5GvIdwhIg7SjPfFzkuSUTYJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IFKn9xS6; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2166651f752so9952585ad.3;
        Wed, 15 Jan 2025 20:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737002554; x=1737607354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHj7ri5OVtg4QKKoVCyZMM8tEP6V7lzENuUM05/wz2w=;
        b=IFKn9xS6Lj2LzYxsvSC87llixlyndwnfW3kINiOlX5m8J2gBFf79sZ9tjkdLbf+/UO
         lL0D4qQ1eEHMQxYavwDtP4SSspHAn1TCmxTq+cEv2WPiTK2Wl/R+qxG1JjJnIkniNKNZ
         O4wLSqbleF4bjzUn3Yn3swL+jMjCXReAK/UrDFshA1uhXy4EacEoYWhM89gqIKb9/cws
         vzAkDJDaCEluiKgdSwKvo1PuwcNA5KPujtja+dgtJx6pOCJQ/dDcVuZlhy1h0riaWt7B
         5JkbZwMHC+oHZSPwaeMcbLVpMl0L/zsTeOQhvKyxQx6BI6KMtOzcLlUKQfaXRyXCwo5i
         ECgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737002554; x=1737607354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HHj7ri5OVtg4QKKoVCyZMM8tEP6V7lzENuUM05/wz2w=;
        b=GHcr2pKRGM5MWSFeNnvWLQvHBV3DdVQbMdqNh3TZGMexEAESKezc0D8FtD21q8EVxf
         j4T2d9eFa6ibHeXln94Ch1YH2Dd0Q0V82P19XSOzmj2jn9WQ+Oy6As3DUIalx0IEsPA9
         gHaEgKrCuFbGwJIiTbXlhTtbr8S/1ymDqqU/g/X3yhxijKA7mXV13mMOTaMmTO7yhWMx
         qQ2GjQ8OOQeIszpgoD+RNDvE5f4OPJjw40zwKmyXEk4BOK5aeI+WTzby7Az7UtQrWcHa
         us/yjCNoi/xJJEEXZlUSD3ZLOdwTnOey6SzReMa38riaRBb/iZmfziV3eJmorpIFtszs
         5itg==
X-Forwarded-Encrypted: i=1; AJvYcCUBftUw7NNA4rlqAyD7+MiLNpwiMn2OECS9rzpxuh36wCHlC2bPqtRQwivWJHDO6UozQzEEkB2tw12SnfJckmE=@vger.kernel.org, AJvYcCUgpdhQQBkqOPaH/zLGjNT1PngD3YLNXcKKzFvHKl5eQXSoILp4WZwWYQOCq6AUWfzvtbZlGIY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza1Za1NX2JxDPwszh2vNoV8GIPzm/x56Cn60ozU6lysTKCDxKg
	A0IkR5jRHgt1l4UCDRTEyzCiZeYaxdUBoLgT8CIfehAnoYt6towBr52IaGij
X-Gm-Gg: ASbGnctN1Y+X7I01b0WOM5zDMHp1lyd9ex3z60XuVDtJnFoSxBGpgNfvMS/q4za6pIl
	NIO6+lTFhnOcPSeswcZmkLPnZCv8Lqzcr23D0R0MKv+2LOMNuCT3LVSqMyt4a6dItCCXU2Hgo/s
	beS1WO9jQNn4f+Plds95jsz+QX2bghstd3xqEyYpftZvjGnTNVWm/jrC98rmNF3Ztx/xsUAc1Oy
	4vYOBfhna2BYUNDoWKULyF2RJH5P4f2hBdxLcMFMORJfTnxK1IPhVGMUt+4DzgJZZqKnCPmiPHj
	rXf2/dC7gKiLrgoqM/p9PBRcQ9JRZ771
X-Google-Smtp-Source: AGHT+IFkYf47GJ8czgv3H9k2ZXcQWB9V+Rk4TOoFndwTvzrxeuRKQY/eVQ3xbMHzo4e6xyawjaTXPg==
X-Received: by 2002:a17:903:22c4:b0:215:3661:747e with SMTP id d9443c01a7336-21a83f48c2fmr407037165ad.8.1737002553891;
        Wed, 15 Jan 2025 20:42:33 -0800 (PST)
Received: from mew.. (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f217a60sm89161045ad.158.2025.01.15.20.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 20:42:33 -0800 (PST)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Trevor Gross <tmgross@umich.edu>,
	Alice Ryhl <aliceryhl@google.com>,
	rust-for-linux@vger.kernel.org,
	netdev@vger.kernel.org,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@samsung.com,
	anna-maria@linutronix.de,
	frederic@kernel.org,
	tglx@linutronix.de,
	arnd@arndb.de,
	jstultz@google.com,
	sboyd@kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com
Subject: [PATCH v8 1/7] rust: time: Add PartialEq/Eq/PartialOrd/Ord trait to Ktime
Date: Thu, 16 Jan 2025 13:40:53 +0900
Message-ID: <20250116044100.80679-2-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250116044100.80679-1-fujita.tomonori@gmail.com>
References: <20250116044100.80679-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add PartialEq/Eq/PartialOrd/Ord trait to Ktime so two Ktime instances
can be compared to determine whether a timeout is met or not.

Use the derive implements; we directly touch C's ktime_t rather than
using the C's accessors because it is more efficient and we already do
in the existing code (Ktime::sub).

Reviewed-by: Trevor Gross <tmgross@umich.edu>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/kernel/time.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
index 379c0f5772e5..48b71e6641ce 100644
--- a/rust/kernel/time.rs
+++ b/rust/kernel/time.rs
@@ -27,7 +27,7 @@ pub fn msecs_to_jiffies(msecs: Msecs) -> Jiffies {
 
 /// A Rust wrapper around a `ktime_t`.
 #[repr(transparent)]
-#[derive(Copy, Clone)]
+#[derive(Copy, Clone, PartialEq, PartialOrd, Eq, Ord)]
 pub struct Ktime {
     inner: bindings::ktime_t,
 }
-- 
2.43.0


