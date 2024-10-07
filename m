Return-Path: <netdev+bounces-132585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28696992418
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 08:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE9982831D3
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 06:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48783136354;
	Mon,  7 Oct 2024 06:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOTCS8Rz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C889A52F76;
	Mon,  7 Oct 2024 06:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728281172; cv=none; b=JZ2NbkBlUmebMrH66PubAcocS6bbzjQiaRLang0A5eb+2Cp4/YxrzfLJ0zPveVrOACGQW3vhKzcPAEEWroPy2tiT+O276GaJb+36xidrU0CpDnJyIfOQupVApPOrkqFXdEMBcIwlc6SOAG86Nb678AyNq1LZTo/FmSLHwafqXtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728281172; c=relaxed/simple;
	bh=+l3wlKA88q1ClQr4W+6U830Pe0etfYRBQMmgNTUPAIk=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=E7haA/4tFdcbjhc4l8JOdqEI96eypaL2y9wE+k4lN5oFDewnLC6lH9Z+w3ZLFD1P6U5GmRUoKnNHtT3YBg0ysICNhQoaYjCqgFMMC7ieG/WmiY2PuexFumhdBmTXRKJpe1wtgqur9WAPMjomX0wlhCo+8qOIgLtQlV6lnFKobzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FOTCS8Rz; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-6e7b121be30so2575149a12.1;
        Sun, 06 Oct 2024 23:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728281170; x=1728885970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xWHhUCe+PAU3jh7iwjTBYQhtG3bIBdoYbmm9fmNXtKs=;
        b=FOTCS8RzBPULVWoGy5Y4W/3k25WZkE47x7+TIvNXVw1nscdzQ0Nc2FZG5zTNIm12a5
         HDpOclXAb9QKKX2zY2SUhh3WDwt6kXd8q4m0bqdj5CaApUW84+fWwK2/IK1NmdOlz0nm
         WbKhY4oGX+hnI5zbmcBCaeNYDcdttg45OUGslUgEa6I60XHiznQpnFFE1UukAEykpPE5
         /gs3H7tuuEryleiBnCIZLKNKsOeqq5XecfePJ1Myf7VUurJR2SrNEYjQHZ6vYaLYC5M8
         kssTdKiN3P5ARGkQIvS6kGA7qwuBvl9RbxuxtRyGyYsalTSy9EEGmXHw7mmYo6/T7oWq
         +/9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728281170; x=1728885970;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xWHhUCe+PAU3jh7iwjTBYQhtG3bIBdoYbmm9fmNXtKs=;
        b=Bb+oPkgX6LinxXk7bP93ieoN6ML+vBnqV7m6nJuFo1eudzbtBXgMuUuaFfgW3Xnv3w
         xvxNbdZRYelamGqlqdCRug0BlEUO0RJJaxqUdYaVWuBa4b6GUmld/dUd8Lz94owWa4VY
         ime/WQk/TE51bU0V218r8pNby+MyCoJPgzfUT3zMo2L/Q0ooINXBo0mVD8GtvoFd8wbd
         xnx4QP/ipcaQp7wnk1eBSkrF7ahXc7XKFEnMV5cKRLqViLW9yfR6RrtSlH562iT3AJZq
         P65qzRG+3ZpgjsY9tVEW41yGEAKXajra3/2LdW5jvzVoEU1IVN2j9A0SiXEEtCvY2xy3
         mU7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUb4+20oHHbwpqlsV8koGoeXiYggC5bsvJWh4hMKdEtIOIs6Pj/B3WrGRmjcwWBYIaOS/ZKk7uIO0mOOZulgJs=@vger.kernel.org, AJvYcCVKF69Om+jV5llztFiiQhMgaFTeunKC49uW9teARNT4qDrOO978x26uP7RQAnB1coAXCqDBWZ19@vger.kernel.org, AJvYcCW/bQgkkJN5cTLj385V1ieMeYk3vATjOmHasNOQpjR+F8beWauv91Muxz5NkeJXZqoTuGGgVw8eC64xHYk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+xeGmPRgQjity0lVSgx0DsMEhQc2DlLPxh7ecM4aMU8WmNaP6
	9fdQTepELMbwPzJdFIax0q6Kaxc6YsJU7ME4dyruSvtBEiOqnKbB
X-Google-Smtp-Source: AGHT+IEvd3S8eK8gR4rQ41FHgEB3jyYUD2JrqICCWIkI4p+O2FH9zQaZzSQuw5zqN2tTZdGi8odBzA==
X-Received: by 2002:a17:90b:4b0a:b0:2d8:f7c6:e1dd with SMTP id 98e67ed59e1d1-2e1e63c1878mr15696218a91.37.1728281170093;
        Sun, 06 Oct 2024 23:06:10 -0700 (PDT)
Received: from localhost (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e20b12adbcsm4442851a91.53.2024.10.06.23.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 23:06:09 -0700 (PDT)
Date: Mon, 07 Oct 2024 15:06:04 +0900 (JST)
Message-Id: <20241007.150604.1865244214901545486.fujita.tomonori@gmail.com>
To: me@kloenk.dev
Cc: andrew@lunn.ch, fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, hkallweit1@gmail.com, tmgross@umich.edu,
 ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net,
 bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com,
 aliceryhl@google.com, anna-maria@linutronix.de, frederic@kernel.org,
 tglx@linutronix.de, arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/6] rust: time: Implement addition of
 Ktime and Delta
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <A3581250-0876-42FC-9B3F-67F437CC16AC@kloenk.dev>
References: <20241005122531.20298-4-fujita.tomonori@gmail.com>
	<e540d2cd-2c47-4057-9000-8d403247abf6@lunn.ch>
	<A3581250-0876-42FC-9B3F-67F437CC16AC@kloenk.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Sun, 06 Oct 2024 12:45:06 +0200
Fiona Behrens <me@kloenk.dev> wrote:

>> On Sat, Oct 05, 2024 at 09:25:28PM +0900, FUJITA Tomonori wrote:
>>> Implement Add<Delta> for Ktime to support the operation:
>>>
>>> Ktime = Ktime + Delta
>>>
>>> This is used to calculate the future time when the timeout will occur.
>>
>> Since Delta can be negative, it could also be a passed time. For a
>> timeout, that does not make much sense.
>>
> 
> Are there more usecases than Delta? Would it make sense in that case to also implement Sub as well?

We might add the api to calculate the elapsed time when it becomes
necessary:

Delta = Ktime - Ktime


