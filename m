Return-Path: <netdev+bounces-108919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 548D892639C
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 16:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16308284F04
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 14:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B763D17BB1E;
	Wed,  3 Jul 2024 14:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="ZU5Ii0UP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118E6176ADB
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 14:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720017577; cv=none; b=iVJhl4ck/BYOrP79oZoqdvCIeS5qvDeywwKaJInQ42f+7Dxn3mzCUvJ4MStsEHW7xfOoMJZrSvig6s3rCgNlgvfRYKJDRvBCi314RiKdI2fEOnZOAoIZIyuwqu7NBxXjcMm+RNz6QhfRlClHjixaDgvr4J4yujx7TTfHsTVCiac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720017577; c=relaxed/simple;
	bh=zqs/S4HfuT/mMZIv2i6FS5axAqEpuhFMOaT+29ULZ4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ipMl1bvr4PBJLmxNlQtHLZAfg2s/E3NzlMEzEtqXsmdQWMpLFp4dn5tTgSrl+m0hobozMV/FlN+YHvWvjeO737aFyS3KLy1cUyJDFebst+kR+MSRlbLYS/IN1tRPnH76qnrOydbBuKuZyIllFobd/aIn4lmP+fxnTyCq2QCFf38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=ZU5Ii0UP; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a6fe61793e2so314848966b.0
        for <netdev@vger.kernel.org>; Wed, 03 Jul 2024 07:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1720017574; x=1720622374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W1PsUXKPUub912pKCGeBU3/M4oCz8Ulzi51DYjGCbdI=;
        b=ZU5Ii0UPcUf6qZfwxQN3JsfKsBEAHdhYxQjE5HoY/Q6SRMP/j5/l0mUm0KEJNiEt1p
         KhaMSHkwe5aiNJNBTVhdF6rrAGHUFLX7X+z2pArdZEABHwFqdphEWMOZKsAUTnv7o6CH
         e8fA1KU+/iXwyXTezE2wS0KxXYXzjmInm5re20bj/Gv6yjtLhE+PLmgi4YbyjGAaQ6U+
         /LMFxU/7kJ9/PlqnXgQu5CCkn0i/yBrtYJOlMhum4h/uONZyjWhCk3Ts2BeBhgxX3mnt
         GgDgh37v0Wlm9k0uBlOFl19p7omq+lzwz7F06NCsQOTQV78FkhK5uBekLuSZ0BbYK5Eb
         /M+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720017574; x=1720622374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W1PsUXKPUub912pKCGeBU3/M4oCz8Ulzi51DYjGCbdI=;
        b=K4dI8XTdSuRyQA1zNFdrMLOOH+JJCtQAly2QCwYJuDNfB879s08r9QNOVJxqRbgo8Z
         acesaWIlB1A7ia3qyKR3/13GobFWDBK6goEnyfDQ7lNSGaiwhPRQFHaaO7JKvb3t0DdH
         lJlH1cBdLYx5W0jJJYGIlJu1erXl4ghyKxqaHQoXwqLKIWfN0KMXyVh6XQe41nbhOY1N
         tVu9bqBoLG4ZuiBiRxBq2awD6J+QqWvYNjHwqfeTySqKm9vP6rtKu8gSyojFIQpnsqXr
         RHedwQ83qeW8kebrwpOBr3B2XLw6sUpgCh7LI/cxNlMEQk8hDaq3gE7fnAOZy2AR2PXR
         rJyA==
X-Forwarded-Encrypted: i=1; AJvYcCWCxpNKOzFac+A6ApZFFghV+5Qaryv6l/f3Q4HHiYeNB2H4mHAGzGv1as98crUOKbn+G9Di3wGvD8mU2OQ93Dq39x6+DdmP
X-Gm-Message-State: AOJu0YxAySc1asxZk/iU03YxYR+ethl5fD8aHp3CVtxdQxer8m4VX6sr
	lyV4GXeRpHpldTsM7ZlGd+AeIN2JSLqA+v1YsasMnAtAGfa6qLUM/8eImmbRx8oj4uRjUYHA0GP
	XwcUYRAHgkPh21i7lOcj58eU5mvOod/INt4iZ
X-Google-Smtp-Source: AGHT+IEAryDZIZW5HPIxZlOmiMOd7zHSKqikS1Z0q6ifIxLuFLBnfNI1sZBoalR/9yuQK5v9xA1wXv6Yz1Vhw9CQwkM=
X-Received: by 2002:a05:6402:1cc1:b0:57c:7c44:74df with SMTP id
 4fb4d7f45d1cf-587a0822c1dmr8474116a12.29.1720017574269; Wed, 03 Jul 2024
 07:39:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701195507.256374-1-tom@herbertland.com> <20240702184633.1f05673c@kernel.org>
In-Reply-To: <20240702184633.1f05673c@kernel.org>
From: Tom Herbert <tom@herbertland.com>
Date: Wed, 3 Jul 2024 07:39:22 -0700
Message-ID: <CALx6S359NS66o1npL494NQ_pe3A_5BKKHt+GRvMTV-ud7RhXew@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/7] drivers: Fix drivers doing TX csum
 offload with EH
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, jesse.brandeburg@intel.com, 
	anthony.l.nguyen@intel.com, cai.huoqing@linux.dev, netdev@vger.kernel.org, 
	felipe@sipanda.io, justin.iurman@uliege.be
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 6:46=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Mon,  1 Jul 2024 12:55:00 -0700 Tom Herbert wrote:
> > Testing: The code compiles, but is otherwise untested due to lack of
> > NIC hardware. It would be appreciated if someone with access to the
> > hardware could test.
>
> Could you pop a script under tools/testing/selftests/drivers/net/
> that'd exercise this?
>
> This will hopefully guarantee good coverage soon, due to:
> https://netdev.bots.linux.dev/devices.html

Sure. Thanks for the pointer.

Tom

