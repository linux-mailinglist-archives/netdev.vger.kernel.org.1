Return-Path: <netdev+bounces-132615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBCB9926FA
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 10:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDBA51F22F61
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 08:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9037B18B473;
	Mon,  7 Oct 2024 08:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b="U549jf6h"
X-Original-To: netdev@vger.kernel.org
Received: from gimli.kloenk.de (gimli.kloenk.de [49.12.72.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5452917C20F;
	Mon,  7 Oct 2024 08:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.72.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728289694; cv=none; b=CleEJodxVmq56FuL79uzgkAAA0Ur8vZSduxYa13MV2rUydLhXqw4WYFsXMUtBhtdxS1gbbSFMyZxSsa6ongNMuRFeBcKW7j6fN38dONcyZTBlZLsYHQ23jxSNfAWy5BW6fGDwS+ixXmJdCjiuynvkKT7+czN0Ek0Wcx8H5c5sQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728289694; c=relaxed/simple;
	bh=1TWxU81SnlG1vGw1E5VPpYknGUgoqht2BDl/lm8VqNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QLu445ErM8h+LGff5Tm7qLPAV56BlUfVJus2HKYrtaakvg0yff/jvtwrVhGcke/hpizWmF9kWJ77E/ulGd6a5Ek1WevEVrsRY1KwunG+RJ5uxHYD6V5FY7j4B5b3zFDt3NABzZdTMFe9NEYXkmCmSP/Qy89Rk5d7cIfTieSJuIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev; spf=pass smtp.mailfrom=kloenk.dev; dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b=U549jf6h; arc=none smtp.client-ip=49.12.72.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kloenk.dev
From: Fiona Behrens <me@kloenk.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kloenk.dev; s=mail;
	t=1728289685; bh=1TWxU81SnlG1vGw1E5VPpYknGUgoqht2BDl/lm8VqNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U549jf6h4tVVbd15Fyf08M3U8tZCPfMaXsfKrNwGy9fP1JC1lUKGtYn66vQ/W1ZXL
	 ZS6Y921eAcM2jqF51wMrDeB+HJxACJemvrq8BmAY7O35XyFDSE+SS+99URjKoSZW7l
	 y04+rbTW7zDdkQgdXZFjL9QmGBGzpD8S/pcPuq0A=
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org,
 alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 benno.lossin@proton.me, a.hindborg@samsung.com, aliceryhl@google.com,
 anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de,
 arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/6] rust: time: Implement PartialEq and
 PartialOrd for Ktime
Date: Mon, 07 Oct 2024 10:28:02 +0200
Message-ID: <3A5036A5-EAC9-4B5D-8162-B140724CF3BF@kloenk.dev>
In-Reply-To: <20241007.143707.787219256158321665.fujita.tomonori@gmail.com>
References: <20241005122531.20298-1-fujita.tomonori@gmail.com>
 <20241005122531.20298-2-fujita.tomonori@gmail.com>
 <3D24A2BA-E6CC-4B82-95EF-DE341C7C665B@kloenk.dev>
 <20241007.143707.787219256158321665.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable



On 7 Oct 2024, at 7:37, FUJITA Tomonori wrote:

> On Sun, 06 Oct 2024 12:28:59 +0200
> Fiona Behrens <finn@kloenk.dev> wrote:
>
>>> Implement PartialEq and PartialOrd trait for Ktime by using C's
>>> ktime_compare function so two Ktime instances can be compared to
>>> determine whether a timeout is met or not.
>>
>> Why is this only PartialEq/PartialOrd? Could we either document why or=
 implement Eq/Ord as well?
>
> Because what we need to do is comparing two Ktime instances so we
> don't need them?

Eq is basically just a marker trait, so you could argue we would never ne=
ed it. I think because those 2 traits mostly just document logic it would=
 make sense to also implement them to not create rethinking if then there=
 is some logic that might want it and then the question is why was it omi=
tted.

 - Fiona

