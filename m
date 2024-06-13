Return-Path: <netdev+bounces-103388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD0E907D7D
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 22:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0AFA1C2263B
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 20:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070A713B2AC;
	Thu, 13 Jun 2024 20:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="EwTI2E6m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26D72F50
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 20:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718310870; cv=none; b=Lmr6vmBQMwZegDxcAyCcxuvzYHIKbc7bch8ToEicBUUxbcuIoGJIcm31zS48OpSi21B3VjCbE/o+xYtBxqAbSk9TZHsjJ+d9j3Qd6+Jkx3hjCuScx1P0TCc+RRZxjhkJOOUs2b3WERCwK+GLUsZCkyy7Axl5hDMV9537mrFIJ8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718310870; c=relaxed/simple;
	bh=nc+mPxRGc5Sz0ngfF5NQ6+JnS6qnxPqDS2PYIF6tfKc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Dt9qVGWi0TwmmNu8FsGJzo3OSsEcXS54rNVBDfFanfDZYsnKqb30z7hSFR4Xen76gDqZUzOGHrWk9skroiYuZDz0vbVQl8pKM6z3Lwuc4a8AR2p8HeQ+Ikqe3ku1tbRbDLMt3WxcHjPFikbfvq26VXTZKfUn/JXVx8vDI7hu5p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=EwTI2E6m; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52c4b92c09bso2257196e87.1
        for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 13:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1718310867; x=1718915667; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=6ABAS6JxztAHBz6Xb2ragAH4N+rel5l8SZ7hr9pi4GE=;
        b=EwTI2E6mY9CJhB+CY3Dbtor4g1prS/HbTkmzdgdRxA3YV+RhYRua5Rfvo8ndEf0r3V
         jlUYh2JYvFOZILsPWocISA5A9jz/VYFkS8WrlG5xgds3OQ3JxbAkjoT7rn1WZjVlcLjQ
         QuW6Mh/n4D+DRiLBXn5/vcS3VqMRMEjTouKZ2lyGB0K5H8Wc0grkkdTEB0LSTscy1SZ+
         6NM2ggS6LRGTQgJRWvustPtql27vOx4YaQBjNb1ld13Dds6m2GQH9DhkCz8YHTZfFERQ
         oqaqeTvJaIxG8eiQth9o7WnsL8aMdg389HmIYL/klM97LzlI/tdrPwjH0mLUmStknB//
         Peag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718310867; x=1718915667;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6ABAS6JxztAHBz6Xb2ragAH4N+rel5l8SZ7hr9pi4GE=;
        b=oWKYalSMZauExxzatSxSTW8MRJZShBssRmXTPNQylS89lxXW8ZQj9vWA1M+cIulNeu
         4ngODISdBqSBEfwkxmGyVwENZpJw8vDx0MR0hjIXzL7w7KCnAEnghavALzzDF60RClwo
         RGti4nNZtnG6UvP+pUiHxayB4HJ6tEa+ij7FBvmlMUdyDe4FhebzVx9+bcD41iCuqJ6Q
         ospAjCtvjApPpBGJWm9l6JvhMvJIPl5k4vezA9ld2+Yl/I5vTg/ZB8QRDdqUfqUQecc3
         coHq8UgXLWsMW4pSaKS+QKUQQRdfBtdMXM11pPhwchs4SEagy8H/AE5euikhwCt29+o7
         1dAA==
X-Forwarded-Encrypted: i=1; AJvYcCXjXJh7e4cjsR9SFhBM3OoFYbD0S+wCYlQUSHVYJbXQiRgHv295hivR+zpBSCdn90XwBS0d2uicjpXKwpoCnntIzhbCySzP
X-Gm-Message-State: AOJu0YxJ/58k3zQ1n8tSOT2EjnsZfIDDrbKOLQWJNBRWkhgcF64VuOkk
	yQlRVqPc4aF2wre1EAmpPGYypHh4XLaNx4MhLAFfD44jhjpuvVRYaoioB2F5HQfy+wfevW0AK2I
	9
X-Google-Smtp-Source: AGHT+IHqYJ7qsAKcu1YTQYnMdQIPsEwAACZbZjZvE112truyVZNTbd3dtJLiUsf0U+1UBegFzANZsw==
X-Received: by 2002:a05:6512:70c:b0:52c:8fce:5f5b with SMTP id 2adb3069b0e04-52ca6e9b0c1mr543724e87.60.1718310866485;
        Thu, 13 Jun 2024 13:34:26 -0700 (PDT)
Received: from wkz-x13 (h-158-174-187-194.NA.cust.bahnhof.se. [158.174.187.194])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca287240asm334916e87.177.2024.06.13.13.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 13:34:25 -0700 (PDT)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: Stephen Hemminger <stephen@networkplumber.org>, Hangbin Liu
 <liuhangbin@gmail.com>
Cc: David Ahern <dsahern@kernel.org>, Networking <netdev@vger.kernel.org>
Subject: Re: [iproute2] No mst support for bridge?
In-Reply-To: <20240613093654.2d33d800@hermes.local>
References: <Zmsc54cVKF1wpzj7@Laptop-X1> <20240613093654.2d33d800@hermes.local>
Date: Thu, 13 Jun 2024 22:34:24 +0200
Message-ID: <87v82cfupb.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On tor, jun 13, 2024 at 09:36, Stephen Hemminger <stephen@networkplumber.org> wrote:
> On Thu, 13 Jun 2024 18:23:03 +0200
> Hangbin Liu <liuhangbin@gmail.com> wrote:
>
>> Hi David,
>> 
>> I can't recall why iproute2 doesn't have bridge mst support after
>> ec7328b59176 ("net: bridge: mst: Multiple Spanning Tree (MST) mode") and
>> 122c29486e1f ("net: bridge: mst: Support setting and reporting MST port states")
>> 
>> Is there a reason that we rejected the iproute2 patch? Or Tobias didn't submit
>> the patch?
>> 
>> Thanks
>> Hangbin
>
> I never saw a patch, and searching the archives does not show it either.
> Maybe never submitted or blocked by spam filter.

Your spam filter is blameless. I wrote the code, but never posted the
patches for some reason. I will try to rebase and get the log messages
in shape asap.

Liu: If you need to test something in the mean time, you could try
building from the old branch:

https://github.com/wkz/iproute2/commits/mst/

