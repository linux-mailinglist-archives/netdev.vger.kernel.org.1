Return-Path: <netdev+bounces-243370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E62C9E260
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 09:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E69E2349BA8
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 08:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950EB2BD031;
	Wed,  3 Dec 2025 08:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nA1UG6TV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2083729C35A
	for <netdev@vger.kernel.org>; Wed,  3 Dec 2025 08:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764749385; cv=none; b=GxB57BXY5Tj33FnJ+fIrjrZnqomiPSHj6TI798BV+ES1bjWdkB0M4GKSIIK58k7mvWtmKd9d16H20pI+jj6rIHNb3kNLcpkJxNKKaUa9DwIYo2dQatXL2+AP7pwdhL/L6WId9i6170wzsjD0Yb9TYTQbYlxa+qg69mMIxpYTZdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764749385; c=relaxed/simple;
	bh=Qw1XIM7eSAhRoQYgDKc3vj7KReSh96uVF11Fo0SrVk8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HUJVhiyao0h8MUqDaI4UAB7dQgqOFxfuLFdhL0bSonVnsMqA8aDJUly9L09QjgV95aQoWPeDiEbR8VRbfuSqvr8EH0uqWTlLbdDMHZfGMNqHk7o6T45uOAczRwjrvTR8Ncl09+o/lLn3ZXc3E6neseTKoLoIhFRAQflipkD8aio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nA1UG6TV; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-298287a26c3so76083935ad.0
        for <netdev@vger.kernel.org>; Wed, 03 Dec 2025 00:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764749383; x=1765354183; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Qw1XIM7eSAhRoQYgDKc3vj7KReSh96uVF11Fo0SrVk8=;
        b=nA1UG6TVBVTFpaKurwmZs7uBgaDnR6LAxkObfZrD/jN1Hfpwris6j8WunnfGJLDmtz
         ZSbDdlBh5s0lp1eeporYKe8cXbIUTpJgi5/yxNuqElNuxBb9igiAxtDKEszxqKkKiTsc
         CW34nppAyfmNABIGBsmyRAp0Ygh3CO5spNX3sSEiqPxZ9Q1TlmJTPB3Kl8MRQX8oZ7tp
         A9IEUfoIvat3tWLQ8m602dxkimK8ceMKkfzQXhRE8hSJ0QMUniV9/FWpEwxVx1uZ99X6
         ByK5zQIswtkSjNQ2TO5K0wMKbGwtfqPxXgD9MUfCtby5SdBwJ7V82qQtZ39wp5l2t23n
         VjiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764749383; x=1765354183;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qw1XIM7eSAhRoQYgDKc3vj7KReSh96uVF11Fo0SrVk8=;
        b=aDcBaExi9u4cv4w8W9lrJj+FIp08v5QxjeCsZWLMoCtbIACayO75mttH1cbT0eYDio
         MuC6oK1vMuMkpHxR4k2wOEMrpe1+/o8/lq0BSZ1C2aKf2mbruYd1si3nwTIJYyIGy9AX
         BTAt8PDg1hSTEwkHwT10PO28h5hsJ+368HnwdzhVtAvijnD2odIhxPXFnPeDnCIIx19h
         gA7s12GMs82SOXdJ8axVZNdQTbjMRJV1v75Gkksz9mHafIewbEV4KTFzZnQ/mvuCkGzB
         SK0hAta8aKnAxsxcUIE8R7RdM6jvqmWixHncIn3YTahgfo5ufDwQBo6FPiuenFL9aD7V
         l4qw==
X-Forwarded-Encrypted: i=1; AJvYcCV8qePqYR4svzq+LhorpwhD2NFHr26T0tJ+rkWOD868Bdldnhfj006zZ0R2NT3x9e8kkvUepok=@vger.kernel.org
X-Gm-Message-State: AOJu0YyySAd0h6STIDcvMN/JEuq8ElzmVBvk+AwMpDAnUziTVs95mQ0M
	6DG6Mq8lZDeV6hHuvhIzofgSDU/v4HFDfpn6N91C351aj09mHavhrOsK
X-Gm-Gg: ASbGncsMX4lFX1xTExls+n/e7IV7B/dMDCO9aM1ym6q6w07164uk7VDamYkE/Rc0s3R
	KMlEDu0azNskxKZ2BeYkOMd39k+Z0/hEu1yuiDuHIEVXz9w4RdQHIS9Yu23WOiqQR0DRfhQL3V+
	59rU7suVTP8suhFlgfhNRPUTeDdBiVzbmrV887YWFhTOIcpSwf7nvMHV9korsFi/gdGe+Ob39St
	KLEuYgyieoLC9KlWdCLcEF6etPPHyc5lCQXyt1qcj8eQjM6DNMT4KqWAG2D308nRFtvwzq9+Tbs
	P7OXqB2ipuGtoHjEVDJvZb3hvuGTT55l89MTsv0CX+i1Wi1P6cZhMzqUrW/8Gthpk5+f8yZb5JF
	pX4NYg7d8aicTg616/BZQLIzwnN388KZ89x54/lAHNUIZ35UTsxpX9DbXzXtU66N3xDL06Y4t1u
	2dbY9wtZZ1VL80
X-Google-Smtp-Source: AGHT+IFAlfUiSP/0APry1y+m8EN2DB6nA1GfpdSjA37sLcnI7XG/xYfVBKXtv81HhltCS2vstIvzZA==
X-Received: by 2002:a17:903:3807:b0:290:9332:eebd with SMTP id d9443c01a7336-29d6833d1b8mr19425575ad.10.1764749383315;
        Wed, 03 Dec 2025 00:09:43 -0800 (PST)
Received: from [192.168.1.4] ([106.215.171.188])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bce441ae7sm175527585ad.25.2025.12.03.00.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 00:09:42 -0800 (PST)
Message-ID: <f34adbc99606c1f9157112123b7039d2a5bb589e.camel@gmail.com>
Subject: Re: [Intel-wired-lan] [RFT net-next PATCH RESEND 0/2] ethernet:
 intel: fix freeing uninitialized pointers with __free
From: ally heev <allyheev@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel	
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>, Alexander
 Lobakin <aleksander.lobakin@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>, Dan
 Carpenter	 <dan.carpenter@linaro.org>
Date: Wed, 03 Dec 2025 13:39:31 +0530
In-Reply-To: <eaf30e67-ce1a-47ce-8207-b973ea260bf5@intel.com>
References: 
	<20251124-aheev-fix-free-uninitialized-ptrs-ethernet-intel-v1-0-a03fcd1937c0@gmail.com>
	 <81053279-f2da-420c-b7a1-9a81615cd7ca@intel.com>
	 <ec570c6f8c041f60f1de0b002e61e5a2971633c5.camel@gmail.com>
	 <eaf30e67-ce1a-47ce-8207-b973ea260bf5@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-12-02 at 10:17 -0800, Tony Nguyen wrote:
>=20
> On 12/2/2025 11:47 AM, ally heev wrote:
> > On Mon, 2025-12-01 at 13:40 -0800, Tony Nguyen wrote:
> > >=20
> > > On 11/23/2025 11:40 PM, Ally Heev wrote:
> > > > Uninitialized pointers with `__free` attribute can cause undefined
> > > > behavior as the memory assigned randomly to the pointer is freed
> > > > automatically when the pointer goes out of scope.
> > > >=20
> > > > We could just fix it by initializing the pointer to NULL, but, as u=
sage of
> > > > cleanup attributes is discouraged in net [1], trying to achieve cle=
anup
> > > > using goto
> > >=20
> > > These two drivers already have multiple other usages of this. All the
> > > other instances initialize to NULL; I'd prefer to see this do the sam=
e
> > > over changing this single instance.
> > >=20
> >=20
> > Other usages are slightly complicated to be refactored and might need
> > good testing. Do you want me to do it in a different series?
>=20
> Hi Ally,
>=20
> Sorry, I think I was unclear. I'd prefer these two initialized to NULL,=
=20
> to match the other usages, over removing the __free() from them.

I had a patch for that already, but, isn't using __free discouraged in
networking drivers [1]? Simon was against it [2]

[2] https://lore.kernel.org/all/aQ9xp9pchMwml30P@horms.kernel.org/
[1] https://docs.kernel.org/process/maintainer-netdev.html#using-device-man=
aged-and-cleanup-h-constructs

Regards,
Ally


