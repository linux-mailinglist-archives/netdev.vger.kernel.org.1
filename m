Return-Path: <netdev+bounces-145930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A2D9D1516
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 17:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 103302813E3
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 16:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962E71BBBFE;
	Mon, 18 Nov 2024 16:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="h0UJf/Lw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA3413D518
	for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 16:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731946286; cv=none; b=eKJ1vb64NkNdFLSl80FSm5Y3EnScnNS5CZI5HVV2bD4l9p0LOkjJK4z6Rg9Wv9SLyjgcW7vPoozguYQpqCKVMI00aOvxg4dGoJSvOqkPQCOTsBH01nHKvBeZndiGtckFVeGtaCWdkGwp69un+klOHPG5gt1CFiDbdp3boLN4THM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731946286; c=relaxed/simple;
	bh=4jmd3ZaXjdZbqF8xYXNZM8N/IiW30oETCd7/3Ob9I9g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SWWHzDJzsHmJUOGssH4krCk2zZ/uq5HlxNknQLac8u661JMAJGfm8Mt+Ba+QJ68gTQMQ6cdqqNSht5qbkF265+crDZOXHOrXVCMmscMRRn7618kCVTWc02nwxx3jfk1byWb/3dfJ6f45nrGyeGrLXHBsxD/x5zcZ1eSS3zLnlsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=h0UJf/Lw; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2965e10da1bso713515fac.0
        for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 08:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731946284; x=1732551084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RFX176F9yddCmt5Wh7Oy+culie2TS0hzJxcolb5yYc8=;
        b=h0UJf/LwLdOuxCkQA+75IhembrHSY1uoTJTLj5OFH7sAutX+URIeH3fcIXky24piFv
         R2wCTWvfo3PXzUPKMHn4HXD9EM+wvFaLAfUUFAfsh13xOOJffyl5opB+FfuDEkZ+C4N8
         mA4637ArOwCUTj5sEZp6ueoAs1mMWUoC6Q7eT2Jm2ekUF2cf7cJNtPt4fifx55UCSVOn
         UJX50AQWNMWjbSXYJAaHVpVTbHp0JpL6ONMe/fqrZrql8XiCOgPMVswJjEmRWKucwoN8
         hRoXvZx3OsoTgwo5UJXUbZeJYhZ0YU50bsKHBTcwEFOwdYqwVh4bjK32p3UvclNyJCX0
         kMfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731946284; x=1732551084;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RFX176F9yddCmt5Wh7Oy+culie2TS0hzJxcolb5yYc8=;
        b=hKlvtJi14GN/8LMiP6Ui0xJw5ltM8uerzmDLdIgS0oHHRQM/EihjA6U1mfJ+XmXN/Q
         qsJhj5E8eqG8CLDehOFEHjPk0YlOxWADH4JrSSZtOTD0NiCWAdFfxUHwMEt1pM88bWiJ
         9ssHJXwai3NyLyxvt5R7/OAM4cTW3NOHdl6WN31lL5mxVesa8tXT0m0fMRDDUlORSkaf
         YIW13cafCa+HwFp+H6T4y1ZRmftZqi7hCSp3N5jlCIjENhZDeZLyAHNbzNdobCsqdh6i
         +Dra2KEO2mMzPElvHVGlcYzO7fGQXrN0AF/u8kw5JVVZ/CWHy3QcEoG2yWk0lr5Vd3sk
         VIXw==
X-Forwarded-Encrypted: i=1; AJvYcCUIhnGE3t+zg766bEy4x1rpxmDeI+xyvEIAU9aEKvZNAz16cthbl2UBJlD8AaPacYseikUfJK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYhVp1oVon4Yf1A7aq78tJsByRycOLJzazRkgdwu+e3laBk0k4
	p+knj2DD3ZoNOs/mHiWZjA5Bdd5PuvMN/bSyOfkJH+h6mzgUuSFyw+0ukaqtYbY=
X-Google-Smtp-Source: AGHT+IHLWogomQKFv4+SfGMqqx1r5l5JiprU9vd4VIYsYuahESKBVj2a/6Ge8gIxXEGYSL2BWBgL+g==
X-Received: by 2002:a05:6870:b508:b0:288:50aa:7714 with SMTP id 586e51a60fabf-2962dddc768mr9653303fac.24.1731946284080;
        Mon, 18 Nov 2024 08:11:24 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-296519331c1sm2676223fac.23.2024.11.18.08.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 08:11:23 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Trevor Gross <tmgross@umich.edu>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
 Manas <manas18244@iiitd.ac.in>
Cc: Shuah Khan <skhan@linuxfoundation.org>, 
 Anup Sharma <anupnewsmail@gmail.com>, netdev@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-block@vger.kernel.org
In-Reply-To: <20241118-simplify-result-v3-0-6b1566a77eab@iiitd.ac.in>
References: <20241118-simplify-result-v3-0-6b1566a77eab@iiitd.ac.in>
Subject: Re: (subset) [PATCH v3 0/3] rust: simplify Result<()> uses
Message-Id: <173194628221.10763.15458685063715699206.b4-ty@kernel.dk>
Date: Mon, 18 Nov 2024 09:11:22 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-86319


On Mon, 18 Nov 2024 20:06:57 +0530, Manas wrote:
> 


Applied, thanks!

[1/3] rust: block: simplify Result<()> in validate_block_size return
      commit: a3f143c461444c0b56360bbf468615fa814a8372

Best regards,
-- 
Jens Axboe




