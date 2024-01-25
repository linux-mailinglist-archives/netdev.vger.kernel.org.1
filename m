Return-Path: <netdev+bounces-65723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99AC983B720
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 03:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B60B1F24118
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 02:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F205A5C9A;
	Thu, 25 Jan 2024 02:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="KqqBqQly"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F905680
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 02:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706149676; cv=none; b=qRq1rHe85MRioKQ1XU+C6NXp1d3UcLJufyuOcQFlsC1sJGKUwzz5otCGtSad+SxwQCzfTV8QzNP62UGsfI6oZD1M4CV/3x2I3BaeAp448IVVzo8z4hKdoMzVw/KayLwJ0/xqtw1XbHzDBKTZbxQVy4LjbLLcJRECah90R2t2pjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706149676; c=relaxed/simple;
	bh=qnq+G7LkKlEn08znH88snbb7Lp9uGgBR66ovXKeJlfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sQLSQfPZJUmekucAFpf7veporCunXIrMfBs0rzOs9YBDvD1p+tWTu0sIYk3b68CBar8JU0Zr0Nq77G0FW3IL10/G5e03iZeTxXDjRXxwcZEcE7joR5DKqo5HRnIwfBQ2FJwTDy4f9A8rwLfHsa3Vs3InZ/hJpXoxxQhqxTVa+bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=KqqBqQly; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5f0629e67f4so66035707b3.3
        for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 18:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1706149674; x=1706754474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qnq+G7LkKlEn08znH88snbb7Lp9uGgBR66ovXKeJlfU=;
        b=KqqBqQlyXGztBCQd+nXQg1My/BfwtdFVHJBU/TzNNjfSlajiyoMAyl6kfrQHYKKyc5
         VvfUp5B2afVRYfCRP+kXYzuhHeVFpUCybwTttKby1Mx24IHIqWJIgfj01nra9gADJhw/
         yQdknOYVOq9ABfchUfyV8O+Y1SBHqG9mlWJA4nM0K4X8E07OvrpMHS/TQPIAukIFjfMB
         3Ub8SZhl/yOf2vqArbRMqNy6ISLqtcqRV4z9y7zC7C27TCoqVx+kPu2q2iLPehMURDJt
         /43gGU56x1/GuvAmvIILJL2Pi1JVAuqlcrigEKfyIlNy+8quPYGFSzhiN4uMOvoda4qR
         NzCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706149674; x=1706754474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qnq+G7LkKlEn08znH88snbb7Lp9uGgBR66ovXKeJlfU=;
        b=o1cJcaWOOYqTa8lEqscLrWn2g8rgMKFjD0F4F9un7AA/14DgJ1mjn721kzbBxKquQH
         eFTpvimNknwRMTB17FQHnT+FXUzWeobFJZKTMRCwohj6mNr3s8pQHCiYp7+LJhXKylOh
         k+lH1sDpAKRszYi02Bg5knZPFAZUn+hm6/D5gpa2bGAE/pVmnLU3I4kY4KXXVgFSlL9i
         AoF52ZB1G1B5lerNr+D/vw3I9v+2ujjPbcINmiDs9PN/K9z1t2B00ZOZXFV2Jav2i+gD
         8dzf/XwCNLAtSJzCQEC+Z19S5+g9WqicQLIVaNepZ7E9Mw5LwsyEDRlbkrSgRECdDzA1
         Ygiw==
X-Gm-Message-State: AOJu0YwjkyBSF6VKA9C6mCT+DY4OkpZVgKQi+oRwgEGKyk4OwG9e9+W9
	EFgcUeO8/hWJ8WYIjWkLJFF1pTRB4jcSTQZ1XBqhwwkCSUQQvgpdaiL6lZf2L0HfPaY7Mh9nB4b
	T9V910px7xeZODrHdfa4by3Y8wRZ2bVmq7wd1sA==
X-Google-Smtp-Source: AGHT+IGzXCpT2tr5AIzjEqYyLg3qi2FnVeAovVO4V7L/EER003yMPuIRNJvBa0lnUo/XKpko8z7uoexlATle0QB2qE0=
X-Received: by 2002:a25:8106:0:b0:dc2:234d:e6ac with SMTP id
 o6-20020a258106000000b00dc2234de6acmr241935ybk.38.1706149673932; Wed, 24 Jan
 2024 18:27:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125014502.3527275-1-fujita.tomonori@gmail.com> <20240125014502.3527275-2-fujita.tomonori@gmail.com>
In-Reply-To: <20240125014502.3527275-2-fujita.tomonori@gmail.com>
From: Trevor Gross <tmgross@umich.edu>
Date: Wed, 24 Jan 2024 21:27:43 -0500
Message-ID: <CALNs47vYXeYeNzbpo0CvH1EX4-od9ZuD1soPTZLaJ+qw=PS3pw@mail.gmail.com>
Subject: Re: [PATCH net-next] rust: phy: use VTABLE_DEFAULT_ERROR
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 8:47=E2=80=AFPM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> Since 6.8-rc1, using VTABLE_DEFAULT_ERROR for optional functions
> (never called) in #[vtable] is the recommended way.
>
> Note that no functional changes in this patch.
>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

Link: https://lore.kernel.org/lkml/20231026201855.1497680-1-benno.lossin@pr=
oton.me/

Reviewed-by: Trevor Gross <tmgross@umich.edu>

