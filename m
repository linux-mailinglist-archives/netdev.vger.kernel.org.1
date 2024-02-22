Return-Path: <netdev+bounces-74087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0BDB85FE4E
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 17:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E8471C255A6
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 16:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F706153BC5;
	Thu, 22 Feb 2024 16:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VEtZrckI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F2C15351D
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 16:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708620215; cv=none; b=bOS+0Wv5stPauag0EBsgnbV6RjjIv5ziLHPD04Ps6mTRBrLvoh3uVznAHdlyJu74YJVsv1eZBkDaKw/q/94qjEnNNAob7uVSmYDS3WF6slqGL6lDw7htD5CZso2ItXMvTVrIKSCWx7/MXDp7rsOAWpCcdCL6tmKDsg3Az+ih2Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708620215; c=relaxed/simple;
	bh=bE0wa/ms1roJkBNvlHsDdQbs0qlWdxZVWY8ymcq9GSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XqCOfnM8+GBdDVCZ3M+YLCPLyzjC1p+hMjaC68TERxjHj1UvrIDHVqmj+VmhuIIZBsowZkbxk+6vON1+IOKNXp5SrAsetJ3HBgY4FTxDDz4i8eIlw1ji6fSOHbbuZSPC5FMzl3kRxwdVdD3ce5XjgQkKUWi70iLKflrNrGhmWLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VEtZrckI; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-41277b9ef37so64945e9.0
        for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 08:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708620212; x=1709225012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bE0wa/ms1roJkBNvlHsDdQbs0qlWdxZVWY8ymcq9GSI=;
        b=VEtZrckIJS1TRzPmTFUWXwA/dAlojS5Zba1lJ9okm8llP1C8UjH8/6xtlOB/0tz3oV
         gYsktsI3A/GIFLI02na7UetQpnlX7gwQAVi8lRyp8Fxv89nGe2ydzKipEfka0e2Q9aOu
         JE/tFfXRk1qzrb3qLBWFUphqTlB8g0ahWoFEmcWyx7E4AQmtD8Pe37qXPEjMSrWBuIMO
         gs9UagMDe5olWBonjA3q2c3tcMkI5K5MynSFLZfsD16wa2LuncQ8XkM9HBokQjdOinu0
         12JRVXq3Cn2IG4OKVeS3AvJ9VJUlcxlmNl5ilNNxo5kzYUDV5Jnlu4TKMi0eGImpszQa
         aXrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708620212; x=1709225012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bE0wa/ms1roJkBNvlHsDdQbs0qlWdxZVWY8ymcq9GSI=;
        b=CX8dOth4GPkqmJ3ZwgMNl7NSl12er2w1H0JALrK5V81NPIssrHtTUEczWmNy3dXTtJ
         e8fVIjYacJ28kY55RTV5AGGcHRyemoPrAtr3sjg4cARiPvgK3DWU4Fcy+rDfFu4/qJAT
         wmJrURD+ReeKym9KmQv0G5zqh/YHkjL2Zs1A0D1u7NUJIlkhsNNWcx1w/2p5AiClGUV/
         1dwsE6Me/5EbJXHj1Ycja3lJJDlq5+uLSeGA09TOwvE8Syr7KhRIay9d4+Xjb/VHuGHR
         kNd73HqWc5IAJBzDr5r2DXV83toRMOfP/Fn55jdSqffPlOgN2c94u/XS+ITfPEab5Frn
         DmfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLIiuDWYLx4u06ywbdF/vS/6yLgbI8ugMnVacMKiMC6yw9C11Qr7CsqxrYhQCvUfHXhrWI9cH7Eoxx7dOWLAY7addlPsxl
X-Gm-Message-State: AOJu0Ywdar3uuh3RmGNLgA0Ng557rWvsSWXySBPS5j9gVFALbVXPYPnn
	n7QxnVhOWjeeF4t9bo0AIE4wdyT4zscZwTyUOk4nH9KNVxOYf4oIqpZ4J7dfd8IcBYSODOCNzKK
	etdysvmzpTy+HJh8vY4jcCQK36WDSKF09r0cP
X-Google-Smtp-Source: AGHT+IFbMj/b5Verf40o9FV6T3TaHTXMWbyWI2cS9prvzPW/ueUbgteEgVQA5MQt9Sw66RG+JchlrDV4B3nqb1G0l5A=
X-Received: by 2002:a05:600c:4e0c:b0:412:7860:a154 with SMTP id
 b12-20020a05600c4e0c00b004127860a154mr353620wmq.0.1708620211859; Thu, 22 Feb
 2024 08:43:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222105021.1943116-1-edumazet@google.com> <20240222105021.1943116-4-edumazet@google.com>
 <Zdd4HbfO2Bn9dfuz@nanopsycho>
In-Reply-To: <Zdd4HbfO2Bn9dfuz@nanopsycho>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 22 Feb 2024 17:43:17 +0100
Message-ID: <CANn89iJb0qCSb4oxEngT0Q60cyAGgr7+VOMyG6r82qeqUMdReg@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 03/14] ipv6: prepare inet6_fill_ifinfo() for
 RCU protection
To: Jiri Pirko <jiri@resnulli.us>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Ido Schimmel <idosch@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 5:36=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wrote=
:
>
> Thu, Feb 22, 2024 at 11:50:10AM CET, edumazet@google.com wrote:
> >We want to use RCU protection instead of RTNL
>
> Is this a royal "We"? :)
>
>
> >for inet6_fill_ifinfo().
>
> This is a motivation for this patch, not what the patch does.
>
> Would it be possible to maintain some sort of culture for the patch
> descriptions, even of the patches which are small and simple?
>
> https://www.kernel.org/doc/html/v6.6/process/submitting-patches.html#desc=
ribe-your-changes
>
> Your patch descriptions are usually hard to follow for me to understand
> what the patch does :( Yes, I know you do it "to displease me" as you
> wrote couple of months ago but maybe think about the others too, also
> the ones looking in a git log/show and guessing.
>
> Don't beat me.
>

I dunno.

Do I need to explain why we need READ_ONCE()/WRITE_ONCE() on RCU for
all the patches ?

Documentation/RCU has already 36000 lines...

