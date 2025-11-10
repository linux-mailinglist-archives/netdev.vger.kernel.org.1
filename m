Return-Path: <netdev+bounces-237376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31092C49C76
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 00:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 555EB3AD4D4
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 23:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8626303A21;
	Mon, 10 Nov 2025 23:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iU4aKmJm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E682F2DECCC
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 23:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762817849; cv=none; b=tOhy1ZX9oDC/9/DYnYSNSx8VgNSk2+aoSPD98v7ENvBbNCdR+8xrOTM4VMpTZ1dS3pSnjzmvZalOsVwyYslDjAbfWqzyHIMVXWoOSiHhAjUKL8jIGexrQZ7BPMbEh/cQrpvW3WqjCAu0wCdR2YYWY7nDeXtHRvCibvvRLIeDDZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762817849; c=relaxed/simple;
	bh=rXO4cV7y/7KRb7+PNQISNcMuBYWSEWB/8HSqi1ED97Q=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=eXUjAbySTA9mtSbdz60QhN9T5jWaQAwSpKOn6/epJ0Wz2pC9XGj+f+fAaR+J358fbnva5kcJs0vGhTH0m8CyjzfJJ5we8oSNSFOavBu1ZZUCkN1HZbXE1eeV6jB7LuFiBDKQ+/XthUziTIy4v8uN5zP+73/XZ76qnQGC6OiQTxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iU4aKmJm; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7af6a6f20easo2878252b3a.0
        for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 15:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762817846; x=1763422646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sONTki0cwOLfaZkpfYHcU55+KIViW3n5GsMd/O6clDo=;
        b=iU4aKmJmPQFFu6HuGPy+dniFZzsRzu93Dztck37kZux+NCANth5dS/vn5Kf7tl1cs8
         8eDdYdJ7kqKRx5Woe7IEOo5m+4KdS/EQ6G9g/wVpwJF/altfX5qGUBq3hYXA1NXgDAdA
         kikT3CzIf85oY4pC/aOdq9t2PL2SwtLaQE5wQnqcMxJ1+c1TlL1ChasGIUmjMtZTXbMi
         G0KyCDdObgOvygJQge/6ovktyRI+joN0I7ZblWsQCk+tft329gQBzPU7TedOe3PERrk1
         MONBz4NxHCjuqQTIWdHtiHWF+KZDJ10mQBFn5YED7t+I4sFzPTziFLSPPiGq3Xw2Qwxn
         43PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762817846; x=1763422646;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sONTki0cwOLfaZkpfYHcU55+KIViW3n5GsMd/O6clDo=;
        b=Yfgv9NbuOZk2prQEUTzfsVmoLPRXGchfbXbUb3/qVVgiD5/MTaNUKOiOFUqHhn8uUo
         ISU0KZ7z6ZW6y9kfxy+D8GWExUWR8NIcDLvRG11OFMZLAOpacZpKJnptVInXZFUI6lYI
         pzD1OgvfsnGc3GxW4CKo//jBxmLycTXB/gK72z9Jz/qhlzgqbLW3kAM72ubKh9DcDQvJ
         ezEMlOcpeCGFWXMxdUQJslNbiHi6ZHshLFd693iFtCRH2uSW4mgSL2l+llemKVRnS0Uf
         yXI/wOrC3xN8hHQ5Ryun5OY1sOwqaLE/8R5HY+RqbjfnsrdzENKmC9qhH2LUWCfadfAo
         968w==
X-Forwarded-Encrypted: i=1; AJvYcCWunWGb5sa2dZ0R2ywyIQcMh9hK9tmOVMp/qPC82mLAiduneB37YbN+JyGzil3yUYN7YLsoFvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCZdkSKGN/QSrYE3Sm9v5iB5SkNUiF00fmPfOHr/SdusXnMwuj
	UmiK0TXy0Irh8pTYx3BMrUoaXnTWjmltU8WHRq9m5llpKQ4rV3AJPrKS
X-Gm-Gg: ASbGncu+ssyai6XPWxdLO6Y+YeRGADQ2Ds5AsJPw5l5CCoT6oqZgNVepwpa+/5y+lbk
	oqjX2AM8hK3fGv399aKQ4kOq4h2+HxcI1vzhQ2dqGlXSzbmdqkNqLj9ifsGI0L4CnOwab7oK3o0
	CB0Wbwj85cymY2fiReplbe3aWV9bEdnL2DcwvUxcBrZ8v5lWGFlq/WQbpLAWOI7fP/N38BTRo9C
	YavfHA+2SPeSfboZUJEsWywAFw5hzb+MjwMdHWfYFxBo/32uK6Y5fcB/7NooyvH7nTvmftGiop3
	gjQYs7EshXeugvqSnuUNb62AmdE4R52u+twxxJ0WK1P9w6vbqJqO4FpN1Bo0lA7YfH/Qn740sJ9
	pYwpEavShbrj7gV8B9Rgz0XrynWJBMSVEw9f0o9bWSthiUbEjbrb1J8unAvm7jTmzRc01nvlBRv
	tFCuUJt5s8p0y+y2Fp3pqHOGs3d0YZyMM/bOz/Ck9PYul4cLQRISoooSzWJsI5EQWp
X-Google-Smtp-Source: AGHT+IHk0TS6U1teQSHT2W5LJ/UoVkLAhqZnFd416dWAUwj/XxNWZoZkE3GEbfX7u/ERSkanItOk1A==
X-Received: by 2002:a05:6a21:6da0:b0:2df:b68d:f73 with SMTP id adf61e73a8af0-353a3355034mr14081651637.34.1762817846261;
        Mon, 10 Nov 2025 15:37:26 -0800 (PST)
Received: from localhost (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba8ffd3f6easm14277596a12.21.2025.11.10.15.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 15:37:25 -0800 (PST)
Date: Tue, 11 Nov 2025 08:37:20 +0900 (JST)
Message-Id: <20251111.083720.572544715756974945.fujita.tomonori@gmail.com>
To: ojeda@kernel.org
Cc: fujita.tomonori@gmail.com, alex.gaynor@gmail.com, tmgross@umich.edu,
 netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
 boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
 dakr@kernel.org, linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH 3/3] rust: net: phy: follow usual comment conventions
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <20251110122223.1677654-3-ojeda@kernel.org>
References: <20251110122223.1677654-1-ojeda@kernel.org>
	<20251110122223.1677654-3-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Mon, 10 Nov 2025 13:22:23 +0100
Miguel Ojeda <ojeda@kernel.org> wrote:

> Examples should aim to follow the usual conventions, which makes
> documentation more consistent with code and itself, and it should also
> help newcomers learn them more easily.
> 
> Thus change the comments to follow them.
> 
> Link: https://docs.kernel.org/rust/coding-guidelines.html#comments
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>  rust/kernel/net/phy/reg.rs | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

