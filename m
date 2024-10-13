Return-Path: <netdev+bounces-134880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C98499B7D1
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 02:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 511E91C21197
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 00:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CF817C9;
	Sun, 13 Oct 2024 00:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFgpcL5d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D921849;
	Sun, 13 Oct 2024 00:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728780548; cv=none; b=HeIxpWynxQHFCgMZMLmeF09fpZ9ks/yaDSpPFMvCE9sCDuaP80DIblvIc1zc/LL4OBdwIAo2N1F9sXzbHuvy4yFxkBd7boGsUKpAVD8udXbzyTo3V1lLcdgu/IsWQ1J3+mAMeZh7CvJx+HEn+Nr+31z7q24KbR3RlPtfXQpr/8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728780548; c=relaxed/simple;
	bh=RyFiUwmCv7vOK7crjOq3pEh05n7Fz+tBQ2Zbz7vKwGk=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=P+DEN5bO1andSVNmqfVO7BtmOxBib404nKsyB1rM/r6VwZmFu0kpqfgReAJYkFsrBSDiTruoW9M15ng+goSst+56lyTU5cj6w/iaCfdxBeefOkt/SeTkKoS46xY4h7bWIusAL74heePiNkK/SFpz4P8PcO5kudpdQ4XCEVRoXC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KFgpcL5d; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71e57d89ffaso254074b3a.1;
        Sat, 12 Oct 2024 17:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728780546; x=1729385346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jwrLoDTogE0g4uNq/QLL91UaSDWMWsJLryPOOQtbcXI=;
        b=KFgpcL5d73O0SSz5PvuDKIbndh0RHLt1slOfs+kXUMf4QDWQGlaz5SU1shsStFhfrT
         KtlvVpQI6JZ7a87u3nBqf480OivkYf5xEDpXU6hlJcV+x48t/IoX6joHwxkcMTv4xalp
         PKxERKkmx/FnMK9VcTmOLJNzELvg8YD6CAQ6r9HT9tVPbya789zcgA+vH5tiyJbVp2eQ
         zCTrpQhgnXe0cpPYHwFd4gB0VQnPpB1RjPQKe7vN+MeX1uq4a+7NdEu6+8nU/HlUuWZj
         90QIlFljo1Ru/XHXt4+Yj8hLlV/zNsM9czUel3Lg58tBjSkSTLm+wa0+T+BZjfN9t8lY
         V+bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728780546; x=1729385346;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jwrLoDTogE0g4uNq/QLL91UaSDWMWsJLryPOOQtbcXI=;
        b=jJ8dUEziKJXtGsu5/Kdqiw7ULi+yIi0YDRrD3ikeDTaTvJvNx/MlzFHg8uzNL75z9l
         XraNmnt5xi9mqJOY36IUE/gD6l/uVv1XL1vdaGM9e89iSTqwaU6dM/a5wuMtEhW9Fecv
         RLE/gLeUmsld977V7C5fSYgPXxzF9N7c+rBiFCde1mJCMQcjMh5Cy/4N9DeOGonZka2x
         wIc/xgIp2wsbu6GBZ+3b+0NhNvbvaIXXhgFbwd7Ehqyz+FHynx1A2zUeYOKsYRPoBsWJ
         ZCy1a8S1WfPsWRfndiQ+/nazwKrDFdLxu8s07+d7W1jowJQuIcBNsd35RpKT2OE3ZSZp
         52SA==
X-Forwarded-Encrypted: i=1; AJvYcCUP3CGNR/PChk+RRpyRydHPOl/SOVBvt6DZZRjPxMfezaNOMAAreVca8lfk/KHT/27OVW9jVjBEE2gsXzk=@vger.kernel.org, AJvYcCV+ywFSlIXZaOb3RS+d14rYa1E8Xguxf5Qkj3XLFkQEg2R0TMZvPcA8WDBEdBnMK0pgw9fimdIX@vger.kernel.org, AJvYcCXFH8xkRCNtDAauuamXb+qQP/cza+iK0GgvMr9/y8b+dhjk01BO0R7QDXOfe4jdeA54a9sCK0P3oU3afVjvOXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWCyeJ0EM7ePjsoJl1frrnJpXLfKkCRbDuYyRAnownsUcM9CWo
	oGvLW1+NCYLVJ0l5+8dpGhacOFmqrsJK2dqr5tPWUntpTba2mgDD
X-Google-Smtp-Source: AGHT+IEGj7ikz0B3WQTOuFpv2xuj9wwyggA+4SH2G5zDSt7cJzf5w8dHVpDdqx2a0j3OyJyEhhFLIw==
X-Received: by 2002:a05:6a21:505:b0:1d8:aa24:caeb with SMTP id adf61e73a8af0-1d8bcfc5932mr12318095637.49.1728780546208;
        Sat, 12 Oct 2024 17:49:06 -0700 (PDT)
Received: from localhost (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2a9f522esm4807092b3a.69.2024.10.12.17.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 17:49:05 -0700 (PDT)
Date: Sun, 13 Oct 2024 09:48:29 +0900 (JST)
Message-Id: <20241013.094829.1723074277269228254.fujita.tomonori@gmail.com>
To: gary@garyguo.net
Cc: fujita.tomonori@gmail.com, andrew@lunn.ch, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, hkallweit1@gmail.com, tmgross@umich.edu,
 ojeda@kernel.org, alex.gaynor@gmail.com, bjorn3_gh@protonmail.com,
 benno.lossin@proton.me, a.hindborg@samsung.com, aliceryhl@google.com,
 anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de,
 arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/6] rust: time: Introduce Delta type
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <20241012195652.4d426c90@eugeo>
References: <54924687-4634-4a41-9f0f-f052ac34e1bf@lunn.ch>
	<20241009.230015.357430957218599542.fujita.tomonori@gmail.com>
	<20241012195652.4d426c90@eugeo>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Sat, 12 Oct 2024 19:56:52 +0100
Gary Guo <gary@garyguo.net> wrote:

>> I'll use u64 for all in v3; The range is to u64::MAX in nanoseconds
>> for all the from_* functions.
> 
> If you do, I'd recommend to call it `Duration` rather than `Delta`.
> `Delta` sounds to me that it can represent a negative delta, where
> `Duration` makes sense to be non-negative.
> 
> And it also makes sense that `kernel::time::Duration` is the replacement
> of `core::time::Duration`.

Ok, `Duration` also works for me. I had kinda impression that it's
better not to use `Duration`.

