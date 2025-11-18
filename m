Return-Path: <netdev+bounces-239337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D798C66F8E
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 03:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 570A4342FEC
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 02:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA0C156230;
	Tue, 18 Nov 2025 02:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c34mmzoJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7792ECD1A
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 02:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763431648; cv=none; b=RLaYwE3qrsY4LnJ2TCH6y8PrntOGe5NshV/L+NPHQbvBEMtQN/OmTg8rZANjOZ5TIUUYxphyu+QuGh3FRCGnlu39ixY+k+3NWKoQpLIT3R7jx2McuhLSghWC9A93nCwqC5h9PoQFXLiJ7TCyWPxoPW4NFBHjNIWqHRarchTCa7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763431648; c=relaxed/simple;
	bh=d0NCOZJJNo/QvvUVi+5418KFMdeGfap8AvEyEU4ZiJk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=PyFqendzU2SwjwX4wzeH4+1tTlnObXVxPwnY2cnvXxHC9VQnaA0WTMtySf3iSRs9wiSFzPhNuHG7+0iqqSU9fu3MM05AyvhH2hhG67rwvwVSIop/krxO5A3LNoc22awypR4hyYgWBsSk/zwmbdeY/21N37p+QeHRKMWlvAVImMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c34mmzoJ; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-787ff3f462bso58123387b3.0
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 18:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763431646; x=1764036446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O+bbE3OhXJxIQdLe1DhINb3qNSZ6w1hgqNqphxg+ayg=;
        b=c34mmzoJxihUWekbUYpyYxN+92101A8A2cSY8feYKqnncI6wTJ78/e1BLvxxcQawZc
         mETwugMfWobxO8DWASEwYwXH8TcR5tNZPbuLw/Y1PIR30Rf0IFUOK07XbG/ksS8YNrGu
         KcIU+4fa18lKigC3Xq+IvJO9zbVp0UskVOt3IrCCf6q6aKNXcqQGV3VYHpohPU8Z3DBW
         OjryhBmUThWRjxsfIIxuDgCbCcgT5Nsclq91CUlSyy7AbjQn8RsJHouBJL1VWP1nGBwm
         sY1GFu0bNaMn18yl4xWYWB5uV0jnIbwXu29UNI7n9YJxXVtJy6bJ20+yrM1kIuIOPuHi
         mDbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763431646; x=1764036446;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O+bbE3OhXJxIQdLe1DhINb3qNSZ6w1hgqNqphxg+ayg=;
        b=CxhBWGwHQJsmzBEW/TCJB47WVexifWtOhyEcEVsmmyDApdLaChxs68rzbcQtabyZSb
         QZpXZjpViUHjTY1vXXA954r/St3fCUaND5dakzm1etcVDiVqZLIeDUbOADvGfqJ33KYZ
         JYqdYtIbHYOIMWmp7U9n3+pnvDNV8/cL/DU8k5P80HU4PwS9iGKH5xGPyy9UCpUqRnaO
         OINlFh9bcSqSNkqmM5qF/XNH3B8Vxdcna6bVesGl+JdfWubAybaRxQghmEf9Dl/ZI25p
         cKbPqC4ff4kexVuRswTh8vW+bcZF7KfIvdQv2qEOTGaCzNMlLAu4iVycw7oPIOZpOPoB
         /cug==
X-Gm-Message-State: AOJu0YxonQz+J92NnUB3etvoJ7qHxRjUbmJ7AaqDORV3OEUL4644JOul
	lCZlHvB23fJCCSYbiqujB/+Jmz2QYENIBhUF1mE84chkkeFJSIybIsNyFc0vZqLg
X-Gm-Gg: ASbGncuCaqFAR8xoGlTgLkubPkgg2sD4FZwZw3I+Uzhcsv5Cc7oCILzaxjjCRrY9iA/
	nLVsMFuHRk0b4bT8o30/WCwXWRMAvem6b75XFzX58ZgenrUqGRXP4TZeoq5tY7qU0RE8najEH9B
	GEFevbmgRLbN4aZzxf1lw7bcWHRuaePTn1pzisc3o3i/Zs4RFKeR6EXq4pK8slJCOUxndzhQ6WA
	SirkECa1inQYtq+zIoLifKAU2ZpraYXufiPEXRvz0BaSXtxVYXiplEKw/PdEltozTkyT7W1OSNG
	8k+mVX+qNw2x90Uejd+N9eDn2JqN9LL7FrAZG6GbVB0VIRAyHn7sZdSqT5dIYQLkonBpBI1Y1WX
	365UCHSnJnPwdCphUDBfgQ5KuAKVWYJZ9XZ+Z1Rf2VhKkDcBRAzu3CNHSZHOAucEqkSImK4q+oe
	rJ8mLQ0/uIwnw3vcBu6YmMVRCGDVJuXvXxVGTyBRwbIc22jhyG2pKmJNEqtpAtkTHGfgA=
X-Google-Smtp-Source: AGHT+IGQSis/hizaYu2fWi7q3sXascE13j9zagyfvse+heGgaTnKZy7u+/QE7GqF+u9UL/OH1zOwhw==
X-Received: by 2002:a05:690e:1306:b0:640:d1cc:2be7 with SMTP id 956f58d0204a3-64213502521mr1374662d50.30.1763431646034;
        Mon, 17 Nov 2025 18:07:26 -0800 (PST)
Received: from gmail.com (116.235.236.35.bc.googleusercontent.com. [35.236.235.116])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-6410eabbd71sm5309016d50.16.2025.11.17.18.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 18:07:25 -0800 (PST)
Date: Mon, 17 Nov 2025 21:07:24 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 shuah@kernel.org, 
 sdf@fomichev.me, 
 krakauer@google.com, 
 linux-kselftest@vger.kernel.org, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <willemdebruijn.kernel.262f4158d9fe@gmail.com>
In-Reply-To: <20251117205810.1617533-6-kuba@kernel.org>
References: <20251117205810.1617533-1-kuba@kernel.org>
 <20251117205810.1617533-6-kuba@kernel.org>
Subject: Re: [PATCH net-next 05/12] selftests: net: relocate gro and toeplitz
 tests to drivers/net
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> The GRO test can run on a real device or a veth.
> The Toeplitz hash test can only run on a real device.
> Move them from net/ to drivers/net/ and drivers/net/hw/ respectively.
> 
> There are two scripts which set up the environment for these tests
> setup_loopback.sh and setup_veth.sh. Move those scripts to net/lib.
> The paths to the setup files are a little ugly but they will be
> deleted shortly.
> 
> toeplitz_client.sh is not a test in itself, but rather a helper
> to send traffic, so add it to TEST_FILES rather than TEST_PROGS.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> diff --git a/tools/testing/selftests/drivers/net/hw/.gitignore b/tools/testing/selftests/drivers/net/hw/.gitignore
> index 6942bf575497..8feb7493b3ed 100644
> --- a/tools/testing/selftests/drivers/net/hw/.gitignore
> +++ b/tools/testing/selftests/drivers/net/hw/.gitignore
> @@ -1,3 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  iou-zcrx
> -ncdevmem
> +ncdevmme

modified neighboring line

> +toeplitz


