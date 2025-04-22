Return-Path: <netdev+bounces-184696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CC0A96EFA
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 16:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC510442A71
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 14:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C78E28D832;
	Tue, 22 Apr 2025 14:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AIUrKvdl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E720428D829;
	Tue, 22 Apr 2025 14:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745332313; cv=none; b=Xkl9bn1zby7IlXNAHll0WG4scVNswXuZCOSwp0BhLFJWUZCvzzjZdm/vWnGgd76UsRJVXhCksxU/KfymFuLb8GI6gnJHYMi+xOae47pnHk97A/RXg0Q9PUux0KLnM860UdiIvFAZHYtUp90gTI4wN1WRpCoHJ2HMBlTQTA6TjuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745332313; c=relaxed/simple;
	bh=I/3+wTmAf3FBNLCDu9mwvPy69eEH2veqCzLXfOX2FyM=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=u0SWDMDyUwaNfIxIoOLmTJN69ucjcGJpEXow45Tk2gL+Je+pNcpYK+Lx5BG56QVNGr+R19dQ3k1KUDVFZstw8K8Omhj2Wc0zi5EQQbEER5CtxBHBs/tke3xnbHWFSqJzExB0JRxalHg6/3nrubxCY0ei7Pu0AdkpmNmpCo0aHR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AIUrKvdl; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-224100e9a5cso61433995ad.2;
        Tue, 22 Apr 2025 07:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745332311; x=1745937111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M7mFfhbdxHQKXHZiL5DhNfWu+e4LKYbHRFDcRBXeqUk=;
        b=AIUrKvdlXKWnTG/KPFrs6hp8LvLp0PKzoacYDweecogwFrVDlkvcEQDJGrUnZQVggz
         fnZJM1ogbC0ErRYPtAJRTGjx87fcLSCtGnemPKl4gHZdi53b91CtQDMvID2OYVL2UmZC
         /jZ/+kYfsTj8XcS5EqmJuEOFtqYlluC5F9oz3sNNymTMEpnqj5IDGhU/NaLVsPc0//5c
         cdYaZY8sLMSkhvZnG/7P4ZNc90d9Z9beA6YhkVHT3MW0hCakg2CA0PbxTdPyKNn68pgU
         GUeSQVOZz6QVwFLq9/VUa+lGJUiOoAkkw+Zo4nccI2rS4/jQ1DcbMM0LMsEFji0NTCQT
         gOlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745332311; x=1745937111;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=M7mFfhbdxHQKXHZiL5DhNfWu+e4LKYbHRFDcRBXeqUk=;
        b=bRYTuPF+tgUyKwcJNDxj7ns2KAhit7DNAigJxjIQB041pzhIOFoZfbXNCg60hvbGbn
         /fK8TxE2SmRZwLVQkAEGOcBw4s+HpwvdKX4rk9SDWxKshBuPnMNTI3o8d+yFkieQFVVs
         X3/29Re8VW9JsIKHELBfXi4XViPtfGlpOio3gCH598FWAU1hQ0x7fiY0qbAu465wkCMl
         /RIU5HXaU7ktQ5GH1/wDcuDoAXNyrgSuShXpqbFEx5RoaOeb/E8Hw68u/wNWSchQBS50
         BBkak7Wyr3GGNMwGfxaqzuc8UMQjmHwKr/k2LRvaDT7tW25hM8x/9oSegXJRyfl9z8rQ
         KSsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYFRnEkjfu/G7DTsn6qq1itMhNSDUsN3uZJSQs96uQrYd/18ruCDj/QgtRvrcQf5FHD72EwUGCz1pEWhKQofs=@vger.kernel.org, AJvYcCWR7nrdEfVkFDKC9MBVt2vUfpw38ZVWlXMOhMR0TCk0p2PDuSsSluTzWcEPvyvljacfTGwW1iWPxUkDt5k=@vger.kernel.org, AJvYcCXVMXJxtEELTkZ6OMOVw/6kmlw5ynbLZD8kd5DAvQTVBddFL++1jB80kJOZ4MeTBQk/v6QPDXRA@vger.kernel.org
X-Gm-Message-State: AOJu0YyxJa5IVRLWCU/DeJgBa6u3ZqnWt5IH8oUjg8qvf2f+F40CdMtl
	D+ZfQi5YYBaXd7IAR0yz4CvJhj4U0Fk59ZPvQTv05enNCRz6KQMU
X-Gm-Gg: ASbGnct9rEk9JNqYb6sDmBBFOSud3xufHOjb4yQtHJM7O4hz3ihlkWYXezKUcuf0ql6
	MkxoJw0e39ye//AzEw3PSbBuvomL9OlvP1MNB+ORQec1sjMhnOrdGsjADSmLg4ol1+ulmXctEsP
	Y0pzMiidCd2FI74jDRLnXvGu/urVyz7ZFB2SSqJKwjnsvPjRvDU8P+vL8RZH4UEMuIlEvn0unPW
	F0fMfOk1nI5qDWsUuy01a4vOhMKbHo2XbuaBOSEYfDJZcR0xiP05jZDczKHu9dCmd9SzxxY64Sj
	E/uteRPnPUx1fY7IBZrGVixpBOmEqunfJ6IqwRkLJwYcROaThww/uGzehJlqtqC9zb4EigWAj9r
	9QFX+F4tQfqjr7c8vGyxhigyWsczrZhfAvQ==
X-Google-Smtp-Source: AGHT+IHGLINwJNecuB+jZD/re/b6eY92fnTCBBDek8l8rDonYpDqTGoY0WP0YQIuxfMtCWhCDLyM2g==
X-Received: by 2002:a17:902:f54f:b0:224:1781:a950 with SMTP id d9443c01a7336-22c5357eda2mr230766295ad.14.1745332311255;
        Tue, 22 Apr 2025 07:31:51 -0700 (PDT)
Received: from localhost (p4138183-ipxg22701hodogaya.kanagawa.ocn.ne.jp. [153.129.206.183])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50eb4edesm85427615ad.123.2025.04.22.07.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 07:31:50 -0700 (PDT)
Date: Tue, 22 Apr 2025 23:31:32 +0900 (JST)
Message-Id: <20250422.233132.892973714799206364.fujita.tomonori@gmail.com>
To: boqun.feng@gmail.com, a.hindborg@samsung.com
Cc: fujita.tomonori@gmail.com, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, andrew@lunn.ch,
 hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org,
 alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 benno.lossin@proton.me, aliceryhl@google.com, anna-maria@linutronix.de,
 frederic@kernel.org, tglx@linutronix.de, arnd@arndb.de,
 jstultz@google.com, sboyd@kernel.org, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, tgunders@redhat.com, me@kloenk.dev,
 david.laight.linux@gmail.com
Subject: Re: [PATCH v14 1/6] rust: hrtimer: Add Ktime temporarily
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <aAelbeiWVZgL-kMh@Mac.home>
References: <20250422135336.194579-1-fujita.tomonori@gmail.com>
	<20250422135336.194579-2-fujita.tomonori@gmail.com>
	<aAelbeiWVZgL-kMh@Mac.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Tue, 22 Apr 2025 07:19:25 -0700
Boqun Feng <boqun.feng@gmail.com> wrote:

> On Tue, Apr 22, 2025 at 10:53:30PM +0900, FUJITA Tomonori wrote:
>> Add Ktime temporarily until hrtimer is refactored to use Instant and
>> Duration types.

s/Duration/Delta/

It would also be better to fix the comment on Ktime in the same way.

Andreas, can you fix them when merging the patch? Or would you prefer
that I send v15?

>> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> 
> (Tomo: seems you didn't add me Cced in a few patches, could you add me
> Cced for all the patches in the future, thanks!)

Oops, of course I will.

> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Thanks!

