Return-Path: <netdev+bounces-164864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA51FA2F721
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 19:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79A8A1676FD
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 18:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02AA19149F;
	Mon, 10 Feb 2025 18:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DC0CE4rP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580C525B668
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 18:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739212416; cv=none; b=KauiItsxMd+C8fXh1cZwqrEdMbEMlmV/pTGqSUO+uZehL39PEI0hTWjT3eh6HX5kBlyB757ms/XmNZ8mYAbmkOyaqwKqQdPbsp0DiJgwq9mKLgy5ZIPA9IgU38Ha5ldxkZy6AlLkjgUrUduEyoGh6j61vhpjTCzXppcvTKz1a8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739212416; c=relaxed/simple;
	bh=FldlKSi4vx5u5yvf/tdjPlmAgSCCR3427XVGuHCXffk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=hEaUi87UW8LEGF64g8tppMemU97EABvSNmLVlYcHtNCKfUJ4+apVs/eP+vtSFCvA0opYWh3SBB+GCBTQ32syAaUxpqMsPzwBNEptaw1TGO5981XIqDTwHimfoFt6ZLaJI2mAYIRe9g7tHvx1G1kCw8bt+fWGkBivuyFd0KF0g2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DC0CE4rP; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6e43c9c8d08so43292726d6.3
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 10:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739212414; x=1739817214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ShRlgBGZpZKqO6PtlBnYXJGHnYeXbOXbfAATqBtUPJU=;
        b=DC0CE4rPU9bnsBdo8FmqqAZtC3VOMrCkqyLTK3ignfazLmG/PPRvZc+I6PE6OZZ0SF
         H5UVvURzV/qJZd+jCQgCJKTikRrI44DA/HYb2dueOXrcYAdfROXxyjFFUAzfbsfmRB1D
         B0TN4JSnG8Nnk7vi+vUgh9Zx9AKIUS2jOGKoKmAfwWeo60VmX27NlKe8PRcaV9buV9L7
         jyo82Ab9bzecnIo+NBiRllOexSg6oLHHeGcDsNPOEPyo8Zp2SotcN9UNEdiS77ODFECz
         fJDfzl4B9tZBK4ln12RsAJjqDeGILA98M99gsRUZPZ321BTs5SWYYALvCXs/XeuQQlu0
         eV2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739212414; x=1739817214;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ShRlgBGZpZKqO6PtlBnYXJGHnYeXbOXbfAATqBtUPJU=;
        b=Eh/4UDrHETLF+ggjFEI7YmqgoYc1mP+E4hnQZQEcStMF/khDhG9oWLizUOmCZvTt4c
         fX47i+L9B2L0ipcEw2Mrj92bZ20rGwTyegXeE8QwZZprQlbHxKWxylCCzO6GqnX+KCTV
         KhVtNKnhSmk2b0ecUVi4lkeFLmjmW9VynE3QsZW6Ngkn/WWW1DBzrg2nenV8oQEoEkAl
         thSfw2B9napI6/SZj4EwfE5cEf9NNN9kx2wdlB44ZZdgvBUBNS0ifNuRJoDWL6gpCIkD
         C0pGs8RA7MM51ffEB05BEeOJA3S90Gqb/sXVgnrApmBQSzsBmUtxujYQrpHEM/xJNkPx
         rlsQ==
X-Gm-Message-State: AOJu0Yw+bb1CwBR2G1B9oN3TS5g0Wy4H8+YaXC1FoXHmgra6rOvRxke2
	10WoJVhbrK1XKs9lpADSr8OB3RxQ7lHI/aXhF5uJCfSY71EQK7A+
X-Gm-Gg: ASbGncuUXFk6/YSOU2BHdfnFuOWc+vu90wH3/dZrWhFKYhWm0PJSNLO7Xy/zk/MzC9v
	1RNxqq+vCQB5k18QlYttSnOqTkjDF19GpNxjeUr5cfq1S3rxOx/kV3uef7Kxnlaw2x55OxQLMb9
	8J2To7sgerwxg1UYaS7C1AGxOWf2sByC1iSDT4srn/EDokLtGBjSuT6say0ecb0wmHU0Qqn6nMn
	hD70nFcmM7G9dubWByO9K8J5p73pnOdWJz9Hv3VEUon3Ez5V0/g3hDCuVG9A0SE2OeX9h/EBlDG
	7QtPoCHtzJ2T1XkXNNV2TR9kBo9PN0dM4deHFq1RfKAwmt3DdJ+hpiucba8lBso=
X-Google-Smtp-Source: AGHT+IGabw3k5WwgCBiWbo2InDATC1OsxSr6gNvkgPMVDunpDqQp1iuA7lnh2BN0BZURGewj/l/nMw==
X-Received: by 2002:ad4:576b:0:b0:6d8:8390:15db with SMTP id 6a1803df08f44-6e4455c95e4mr172105046d6.6.1739212414105;
        Mon, 10 Feb 2025 10:33:34 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e43e07394csm47677956d6.25.2025.02.10.10.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 10:33:33 -0800 (PST)
Date: Mon, 10 Feb 2025 13:33:32 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, 
 Willem de Bruijn <willemb@google.com>, 
 Simon Horman <horms@kernel.org>, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>
Message-ID: <67aa467cdb521_6ea2129452@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250210082805.465241-1-edumazet@google.com>
References: <20250210082805.465241-1-edumazet@google.com>
Subject: Re: [PATCH net-next 0/4] net: add EXPORT_IPV6_MOD()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Eric Dumazet wrote:
> In this series I am adding EXPORT_IPV6_MOD and EXPORT_IPV6_MOD_GPL()
> so that we can replace some EXPORT_SYMBOL() when IPV6 is
> not modular.
> 
> This is making all the selected symbols internal to core
> linux networking.

Is the goal to avoid use by external code, similar to the recent
addition of namespacified internal network exports with
EXPORT_SYMBOL_NS_GPL( , "NETDEV_INTERNAL")?
 

