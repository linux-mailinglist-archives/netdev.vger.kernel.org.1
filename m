Return-Path: <netdev+bounces-158481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D167A11FC3
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 11:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99D381603B4
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 10:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37DCF1EEA2A;
	Wed, 15 Jan 2025 10:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X/up0YZ/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AFF248BD2
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 10:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736937166; cv=none; b=LQLZlaGLinyh0XGmJ/FAe6iLWEnk0LOoaK6fU3n2I1gl8nIRD4SP5t8UjAIbSAuWM4HlkJJMnKjuRnGYw0tN5jQLzq0XpzqVa/kKCE4HM4etHDo2KuV3oSBKKxWcKAzNZJBYRhoWDReYoEeQajh7pssc2UF/5tIgYEFZ5zvzQYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736937166; c=relaxed/simple;
	bh=kG1nWW7S26qSrv4/pOdn/YimebDaM2xgx3XXbTQ3qfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sy5yykXX2WJp7s+lbOCTyGH+GttrTcqIbP91LE059/qRRptFJA5c1HaQVLiz3BA031dhlp0KjvPYrONHA5AdtYYdebOIo6BgqXb6zBUnIpm2Tq/saMzEhmXI4PbPY8vz7mvVMQDyMDRwnFPbBqoPwLEk7PYIUMeJU3xD37q993E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X/up0YZ/; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d88c355e0dso11569045a12.0
        for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 02:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736937163; x=1737541963; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kG1nWW7S26qSrv4/pOdn/YimebDaM2xgx3XXbTQ3qfc=;
        b=X/up0YZ/0DxZau1men5f6Ejp7Ujt5dckS4hMfzC9gro4BNlf5spIgcfVH6jvG4JCYV
         V6e9aTDbEIiqcVz230fzSCrqfmegXljuAaXPc+T1zsycxcrAp1/3tA0K0NlFwFf91Uig
         7jS9JsjgroI3YmubFCWi2DXtQpG+wxEkO5ouTiHKk8vCBd5Gl2t5yO7AjN7+QNElojSn
         MaftygNoSwI5ewhRBBzgymqhQMigk82X0Ejhl1vHi6hlLFRGmsqHBpHhkcveYipxAjAK
         Emr66mGgxumAUnjTmxCiEyvt81i6yIi8zQ5ZYoxXxeREuvrSA4jHeKV27W4g5sxpqA32
         1HfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736937163; x=1737541963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kG1nWW7S26qSrv4/pOdn/YimebDaM2xgx3XXbTQ3qfc=;
        b=luGwiAU8KNBf7tvUgtUB7p1Mu8MdheLvp9QVIfYgtb3syc5uSfznF6CXO7dcaFXdTf
         P/IKY7WxEhhH+b/YjHaLs4DTg7WGG9BDkFA1rmI42gdL1stfGVMSBwC2P9nKvduh1mmy
         LeqdRNuiHW1XC5/OQdrI/yy1tuT9TzR/lXl6/gNSg/TiP4zW0Tix0bJy2PLWyomehwfT
         T/2d2C6KIWjYeNqJyTq9rJPf3GH5x0Lf7NxGAyR1Uum7PgxJWHZlioH3I5FtxMNzHIf6
         YKjxuKVJFyQRw6G8Mn3sgOxim6/7AZjMFPfi+hwAOqahwznJGHg5TCifW0Pm0iQyEF2n
         eG4w==
X-Forwarded-Encrypted: i=1; AJvYcCWqkMOs/tiNJd4zaI7Kmq3T1pPOg/6gOV/UsbiuOEVVZJtTXgelbBx83LKkMUkrZt7BgJnex/U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2s4xxldpaxW7Ll95zwssIzu+CnF7pF+JqgRYcOkVlPyWx4h3E
	0axvKzletZcAy6SCx0n8LURsVAaehQBNZrmnTh0rlw+swS3BJm4wQ5GrAZXoFWX1xiGSYdBxDRQ
	iVYeqbjhGT/PxWdCnr0fu7+26WFSG0W/cbSpZ
X-Gm-Gg: ASbGncuTPDKn2KcZgdbBom43zbXMrDL+Pzak8e0+3TUucPrbKzj5ksesMsWajRbCyvN
	uVYK+M6m6kpjVXbfxlpBUy8L0aOv7bGV/spACFA==
X-Google-Smtp-Source: AGHT+IFPNXYBqfx0I4jfHafkpWjEsjTdYHAjhR1WKOc5vCiQK+5CBkdcw4uZ0x7DBp+g1oKYKtVDQxhzB0j26zc24p4=
X-Received: by 2002:a05:6402:5241:b0:5d0:eb2d:db97 with SMTP id
 4fb4d7f45d1cf-5d972e64807mr26411907a12.25.1736937162549; Wed, 15 Jan 2025
 02:32:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115095545.52709-1-kuniyu@amazon.com> <20250115095545.52709-4-kuniyu@amazon.com>
In-Reply-To: <20250115095545.52709-4-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 15 Jan 2025 11:32:31 +0100
X-Gm-Features: AbW1kvZRxgr6RBlkemaEruACALC58hN-tYaTjd8BNvR5B3iUrBVXlTBKV2-p8Jc
Message-ID: <CANn89i+4qWFZhQQbHapKt9FYtMUzH+WiK9UsKbHBzT9J2E3yDg@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 3/3] dev: Hold rtnl_net_lock() for dev_ifsioc().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 10:57=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>
> Basically, dev_ifsioc() operates on the passed single netns (except
> for netdev notifier chains with lower/upper devices for which we will
> need more changes).
>
> Let's hold rtnl_net_lock() for dev_ifsioc().
>
> Now that NETDEV_CHANGENAME is always triggered under rtnl_net_lock()
> of the device's netns. (do_setlink() and dev_ifsioc())
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

