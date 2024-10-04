Return-Path: <netdev+bounces-132031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B937A9902B2
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 14:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8EFE1C211EE
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 12:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818DE15CD64;
	Fri,  4 Oct 2024 12:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MwVW/OSO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1690315C121;
	Fri,  4 Oct 2024 12:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728043716; cv=none; b=iYzPPUeECVmmLsJ0l0IUtjBso9jMJx4nCMCYCdy+eqHq3N/eDJHxY61bsK21sP3FSd4sj/LSl1RRrSGlMtOlkUM0tFFyRBvMeUC+1S+p3YWe5JMPQNEqBxogH+EyPLzr5cxSBhdjUeqKQwRObQaqa4zpjS0WtCl6JtHhSi6P7Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728043716; c=relaxed/simple;
	bh=JPed9/QJevwfntRlcIkPect3/WkrDR9pOyxYyQZkKgQ=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=r3aPf8IGXjZTZqYVcKVzzD52UloPRdVuGzjNYDbA1NHtcFgvx6xieSU1Wtn5R2sFFpv6oGeFGV6VzCa43sP2LjespfnhA5plcRVWsWJh6ngFzgrUDntgYIHqDXGZt3rumBsuIhZrnjUeEWDS65/eXm6WE9KO7ZTQT5VlwR2yP6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MwVW/OSO; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20b78ee6298so12688715ad.2;
        Fri, 04 Oct 2024 05:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728043714; x=1728648514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p4uHfljjdM6prAXR1fYXZLisMASJ67uOgKvibzFyhcU=;
        b=MwVW/OSOz57nwjNQrPP7Mid9xGDGVWDoH0lm4OKHQW/6srHMoHdJk+z4U7jjSZLsWg
         7vLqvZ900RONcTy+x3R6PX/SapEUYIk9v77GnXRof8ws6bOGlf+TD2ASp7fBJ0uJe/uu
         aNvxhReX56nRVlYaRGOk0YQzEZGElILo/MXiXn3TM940r7aOCepHE+SXFUzU6jOYl505
         /zaYl01l3+TFHanfJpvkvH7OP7itEXK/fT/WxD0hgOWxM0diwZC8Dc+xYkebtwkCc5Rd
         4sTGpLbILdMlubAlIWXEUaF0eVq1XXZEfiQLW/LZ9HGT9go8UXSywhNJtclcmXlXrN4b
         VzkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728043714; x=1728648514;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p4uHfljjdM6prAXR1fYXZLisMASJ67uOgKvibzFyhcU=;
        b=YS9e2AuBVSW1QmlKPCBasBaMPYuphE4/Wq+GCIAyAhx5vjLVgRXOQtXOOt8JTDtYYy
         UwoTLUrpaqQXyBdU0uRyFwfl8Lks7avtxVp9phNnmF7C4AgoiKv5QR7FejmfzLr0YOiM
         Yt+Fgoq7mfsnJs3a7JpgROuZExaDfV/OhFMhHQZEXDgKqv5YxD5TEk7GB1T74Dz8zjRs
         dj/6/VghkTDNZxDS6xAjUpcHnQmrX5qJOzMCr22erqbR7jHay29VWna/xwhc8BXCLC0K
         L1l63P1HZvtuA+ZnsVk4G9gFLUbAFjBuUkk4TMMUbAYYSWixW/XG4M7Xd/v+zxAnc418
         SJqw==
X-Forwarded-Encrypted: i=1; AJvYcCWEflk0lgPfhLc0rqDsYGeNQ66Zt0sE25Ar5jAJGUhrcxFT3RZ1H+z+nvuBAzovuwN9KyNtmejY9KaXekbJnfk=@vger.kernel.org, AJvYcCWTu3zX8hqbcreJl9J/FEUF7CU76Op00zfzy9hMKXhNy/Xi4Eh6A43b0MJpW5QJjInAdqCH0NU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8kK6p1ArCph25wptB/DShWZpCuJeRc2JT2Nd4MLU208vEo9Cs
	oyMm9SjxxxC7fqjnyh1aqbGHoJ01xK9MVW7HyTqcLZWghauwDJFT
X-Google-Smtp-Source: AGHT+IFSM38c/Z2OOdcMail1JBfLJF75MEi8Yd45SG/8JBtGN9H25DwWSYyYLy737kBpO8Je+KgYYg==
X-Received: by 2002:a17:902:ecc9:b0:20b:4f95:9325 with SMTP id d9443c01a7336-20bfdfb4cdbmr40154915ad.17.1728043714009;
        Fri, 04 Oct 2024 05:08:34 -0700 (PDT)
Received: from localhost (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20bef707035sm22821125ad.275.2024.10.04.05.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 05:08:33 -0700 (PDT)
Date: Fri, 04 Oct 2024 21:08:19 +0900 (JST)
Message-Id: <20241004.210819.1707532374343509254.fujita.tomonori@gmail.com>
To: andrew@lunn.ch
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, hkallweit1@gmail.com, tmgross@umich.edu,
 ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net,
 bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com,
 aliceryhl@google.com
Subject: Re: [PATCH net-next v1 1/2] rust: add delay abstraction
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <b47f8509-97c6-4513-8d22-fb4e43735213@lunn.ch>
References: <20241001112512.4861-1-fujita.tomonori@gmail.com>
	<20241001112512.4861-2-fujita.tomonori@gmail.com>
	<b47f8509-97c6-4513-8d22-fb4e43735213@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Tue, 1 Oct 2024 14:31:39 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

>> +/// Sleeps for a given duration.
>> +///
>> +/// Equivalent to the kernel's [`fsleep`] function, internally calls `udelay`,
>> +/// `usleep_range`, or `msleep`.
> 
> Is it possible to cross reference
> Documentation/timers/timers-howto.rst ?  fsleep() points to it, so it
> would e good if the Rust version also did.

Looks like the pointer to Documentation/timers/timers-howto.rst in
fsleep will be removed soon.

https://lore.kernel.org/all/20240911-devel-anna-maria-b4-timers-flseep-v2-0-b0d3f33ccfe0@linutronix.de/

