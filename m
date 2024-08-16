Return-Path: <netdev+bounces-119108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFCD954117
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 07:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9129C28BB1F
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 05:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0701577F1B;
	Fri, 16 Aug 2024 05:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZy+vPFo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2F5383A5;
	Fri, 16 Aug 2024 05:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723785714; cv=none; b=sM+pr/2HMpava7k5IXONlBZj4bXjeHhO4oXxB1JVNt7ZSYUeTGdIEBeH9FRB9RKLfJjufEW53AcTFulLQGTE/MXcTeFVlwGAVtTPxrFi0A7AkIg780D4dw6PulcpoctNRoXUpBQAUbD1AXzzlyuwDLRBCR6mIOwX2azDBy+2uKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723785714; c=relaxed/simple;
	bh=Tm34++vj9iSs/b78LRdCD8W0tSuA5ShDueYlwqp2jG0=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=gAl0q3dNMM9+ix052ZH4mrjgVqwPBPUj0eC0CdsnGbnBTsMBlEvJpOVopTIhrTB72c/n95Ck1XQ66eBAmzRnQmw6O02YTup+0v7rQWx9C+PAcIJW4nMNYgTk/jPD0PVrxdWubXmBx7FvCIBphvYflM0w8r96NqE6zaJ4KFXjrNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZy+vPFo; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2d3c99c5d69so219188a91.1;
        Thu, 15 Aug 2024 22:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723785713; x=1724390513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9CcEhw5TsYaq1P4cDCRscBnx0hYmAaZSB9RfOEJjnbU=;
        b=AZy+vPFo4Qs0jC2s87A5cDjTfI/gZcx7upn57dCSi/Nm1UUagxKfDtWenFg4hoTm1K
         5NnVBP6TPwTeJf8YdmmHcamsvsKDd3xgHVTXq/jOa0iOmWcRPPlgavT1lgVcvvijQ70n
         xzvL+slsc2UAQVkfafEoog8d3v5pU0M0mo3Simj37BD8vSAu1VioBd4ckTiM7d81vSvA
         C05MnbUchJzZulgOGSKKnbGav1TRYNuPg6N6AS5+tCX26w1PvodcKmHIt3qTdYnTnPg1
         7yD46yWeko/rAXdw7VQzvLhTZcG63mW1lR8QwkkB2vDQNRLDxPZ7mvfj649lxRN28gUQ
         hr2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723785713; x=1724390513;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9CcEhw5TsYaq1P4cDCRscBnx0hYmAaZSB9RfOEJjnbU=;
        b=vnjsbkA1O99kSbNOsTfZn0QqDPp88D6vQxDODyBQgepraYt+cY0163+dTgTUb44abe
         Ho5mVSWDDsOGExZnZmWXUlzltbplBsc8M6uhd/KnDhaxMAJbgYfm1e8XAYzyC4YOvQF+
         G8Z/ikhonah9g1XN7TQtP45Fi6peazZPCsJGLgoUa8wNTVMW+Qu6CoyHxtsSHU0G7THW
         4DD/Omdrf6/setzAvDpFNQ+2Dp+3eP66LgQuRFWbRV4MTIkY0+vmbXZpdIm3W6n/S007
         ncUem9Xf1okgJSkh+6ADV3ZWCG68b4X1wuJtvSxyFsdAR3AZlgrs7icX1GbbDTibscES
         trDA==
X-Forwarded-Encrypted: i=1; AJvYcCWRZAliwOQ5e9I1QcV0F6Bcr0tw7/X5BVtpeGdcgvUnPSqXjZ08+QBzXAjxaZUQic+MbeI3vsXd2xjCvu+t4gEptFiQL4Mb/sPcScaQEsn6mY/89EeuWEZCGzeh7rC/c2imq3QsPkc=
X-Gm-Message-State: AOJu0Yxfm5zAkXJiQjF0F8smh+9dW8ywVpznX94VRYEDDHYdcbV+nBeS
	1U8DZ5UtvBd3AJYiSgXlMYnVH0jtCkPkmKqpGu2lEOge/9Xwcj3A
X-Google-Smtp-Source: AGHT+IHtO3HckAwi9LJ23HftOUp6PyI9No6Fk7yV/gKe+KrG2aPDgc6eUOOUwrmKLK/fAzlWbaXRqA==
X-Received: by 2002:a05:6a21:328a:b0:1c0:e263:77dd with SMTP id adf61e73a8af0-1c990b3feaamr1069471637.1.1723785712461;
        Thu, 15 Aug 2024 22:21:52 -0700 (PDT)
Received: from localhost (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f03194b2sm18322355ad.86.2024.08.15.22.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 22:21:52 -0700 (PDT)
Date: Fri, 16 Aug 2024 05:21:47 +0000 (UTC)
Message-Id: <20240816.052147.1483659918879744727.fujita.tomonori@gmail.com>
To: andrew@lunn.ch
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, tmgross@umich.edu,
 miguel.ojeda.sandonis@gmail.com, benno.lossin@proton.me,
 aliceryhl@google.com
Subject: Re: [PATCH net-next v3 2/6] rust: net::phy support probe callback
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <b0a0438d-e088-44f0-8f63-f3632a4c6b90@lunn.ch>
References: <20240804233835.223460-1-fujita.tomonori@gmail.com>
	<20240804233835.223460-3-fujita.tomonori@gmail.com>
	<b0a0438d-e088-44f0-8f63-f3632a4c6b90@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Fri, 16 Aug 2024 02:40:12 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

>> +    /// # Safety
>> +    ///
>> +    /// `phydev` must be passed by the corresponding callback in `phy_driver`.
>> +    unsafe extern "C" fn probe_callback(phydev: *mut bindings::phy_device) -> core::ffi::c_int {
>> +        from_result(|| {
>> +            // SAFETY: This callback is called only in contexts
>> +            // where we can exclusively access to `phy_device` because
>> +            // it's not published yet, so the accessors on `Device` are okay
>> +            // to call.
> 
> Minor English nitpick. Its is normally 'have access to'. Or you can
> drop the 'to'.
> 
> Otherwise
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Dropped the 'to' and added your Reviewed-by.

Thanks!

