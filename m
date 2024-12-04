Return-Path: <netdev+bounces-148795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB569E3284
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 04:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7229028200A
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 03:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA461684AE;
	Wed,  4 Dec 2024 03:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="gPx+LZm1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C9B142E86
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 03:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733284781; cv=none; b=MV3QkkZf9Gxpne8wBFdqw7D4ImXuEcNIgOU20/U9YF/gyVBt4WQqiZK89lxfuX3Iz6DkJbEQVeqgp2riE8oT/XFwM5TKlfxBWZc8VshsaDeqUGGCoEPKy0m8fzxTqQW0fIVEZwP5rIE3Z+Navq22hV+rErOeCvX1MD4kJkSubn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733284781; c=relaxed/simple;
	bh=KVJ99v8GTxtw9LSuDOAanYq7D0aqfVdB0hpxkdLFB7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jn5qz8sM7+Qnr+izdgAoZmclgItOxN7s4EoAJC+YNmAfnqGDdEVvGhBBlowvUUPDRaEjwiqjxLyjq+x7X33jziOThzpmrXXbDcDoVhi6ODRjp4Tbqk9mpZcIpU60idWMjeoT7R7mBd7K+z9yX6bHpmbf28A67Dnd5tbn9VGdR30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=gPx+LZm1; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e39841c8fd6so4823476276.3
        for <netdev@vger.kernel.org>; Tue, 03 Dec 2024 19:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1733284779; x=1733889579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FOrupCXXnAI5WtAArMxAm91491VHPiGEFp7ye8g18Fs=;
        b=gPx+LZm1HJYGcb4iLO9oBNKcdkG0RcjmsQ0ER8qfcX23LqT4YSGf0vPHGs9GTR58O8
         br0aToGpwMijf9o5MdzOZEwYZNFL6z4RimV4teNDeBkQDyYHJow4rFfOyIBVDED94BXz
         Ho3GQMmikFzjNEdKep5hDFxe8FgHaaB62FL8Fp18lkA5/PalEXPMuRKNOCsmhzqfLyEl
         Ix/MBPWHmsk/yNRYLTJlawmz9EmcpErTBrVIqFbO1iD6wPTJiqF6iUx3YtW1LCjV4MER
         fNNMFudDWTNxETnQvlCFWN8NBgkJbEgFT7W+Ur3NxDkuS7AySPq5ukOYosIR3+ouy7sh
         LIBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733284779; x=1733889579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FOrupCXXnAI5WtAArMxAm91491VHPiGEFp7ye8g18Fs=;
        b=GEMwYrar+TEY6RnA6Q4DBpeCVdqueM6vCtQq5RX9/CXSHzrXB9BXd0olqQvnD9g1Mn
         R/4iAup0wTgG9Sb6lQjBajNgPVhKnTKXmAcs/azZ0LNvJaMXyAc5ABtMFXTx9BHgMJWH
         acDi5Xftj2+GNT79f0Hx/Te61qCSGcojmlmoKojQmDkOo6PrUg8Sa6IdsqeYFABqvHW6
         RjS4YhQTsHGo/DmQxye1LxjhLfSB+UjqphacnJbG8dN5LHbzBXIB/C7IjKkhwia0YRqR
         cn4Fz518g/jjcAcxaOP+UblIGUpj2MHSQEXUu9T7fxW3W0LGjvaD7D0VrKKjESWWddWu
         rPPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvCznOp1fyxl9nvlIwTCaXuGxCrSsoFKXabuogLLZzMTEf5L/YVynpowkBqjleYaEst8+ceTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeGglWrWR2yLEcAosvBZ+HIj05gbkYW5ywzSS4IhwsCtOXQaRK
	dxxoSsWmT8XcPk7vyID9/WgXjzDWKPpArXGrlUbI2/NM5kDC+1HEpqQjFYrMs+t9LsWnIw/IhHh
	d3rXQ/MAg7lsASKEbD1XnsLb2yNQ4AILpBXWAY8kJOgSzZLk=
X-Gm-Gg: ASbGnctWrpMSQxoePGDTcmLh7c8bWUmmoRRhDXsN2eXhxm7QrNUSGUxjaKnIh4JKAu1
	8JfeHikAyhO+A8yVE54OtYJHmq6u4Jg==
X-Google-Smtp-Source: AGHT+IEo33yp7ogkVaVMdUjUzukVBKi0xOatKbmssZ5xoJqeM3IqXXDbpfBByvJAQ0DPK+A5fkN6rnUVuXX8dRSveP8=
X-Received: by 2002:a05:6902:1143:b0:e39:a3d9:48eb with SMTP id
 3f1490d57ef6-e39d3e1d1b7mr4710701276.26.1733284779295; Tue, 03 Dec 2024
 19:59:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKHoSAtO1vE+_-Fo9Gc9Tv2bgtubkBYk6uEOddJr79DNQvmSQQ@mail.gmail.com>
In-Reply-To: <CAKHoSAtO1vE+_-Fo9Gc9Tv2bgtubkBYk6uEOddJr79DNQvmSQQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 3 Dec 2024 22:59:28 -0500
Message-ID: <CAHC9VhRMaQ5jZBP7SVGbxiGTqHagMrkU+CW9OFySNG6Fwh4esQ@mail.gmail.com>
Subject: Re: "general protection fault in netlbl_unlhsh_add" in Linux Kernel
 Version 4.9
To: cheung wall <zzqq0103.hey@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 1, 2024 at 11:31=E2=80=AFPM cheung wall <zzqq0103.hey@gmail.com=
> wrote:
>
> Hello,
>
> I am writing to report a potential vulnerability identified in the
> Linux Kernel version 4.9
> This issue was discovered using our custom vulnerability discovery
> tool.
>
> Affected File: netlabel_unlabeled.c
>
> File: netlabel_unlabeled.c
> Function: netlbl_unlhsh_add_addr4
>
> Detailed call trace:

...

> Repro C Source Code: https://pastebin.com/aHhVhbJ4

As you surely know, Linux v4.9 is absolutely ancient from a kernel
release perspective and is no longer maintained by anyone; have you
been able to reproduce the problem on a modern kernel?  I quickly ran
your reproducer on a Linux v6.12-rcX test system and did not see any
errors.

--=20
paul-moore.com

