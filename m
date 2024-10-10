Return-Path: <netdev+bounces-134205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC42998655
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 14:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32373281EAF
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 12:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DC81C7B9D;
	Thu, 10 Oct 2024 12:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lJlZKJr8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723941C7B99
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 12:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728564063; cv=none; b=unZ6hHwmSkx5P6+pgnBrBl11cQjmPrhdRZnIJ9RYbB272xLOgQYZwc/BOpWsFMpAXTXATA2EzcNzPkSt69hwF7IOgBV59Z+FvCqPJcfTY0JbC34gIECDL7SeskOodqy7DMzJuP8InvYfyqFzR7Ro5mdnrtMnfmTHbp01D7cwNVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728564063; c=relaxed/simple;
	bh=8ppIwcz3CS+2v0NWFFAahAGCJPi7hhClB4Adm4iBCRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uhrIShoDVWq3g9PlgV1hkSuWFxNmNR+RvJI/eIq3nM47tdAD0AGpqFr6fZmQbTGitWnEH6R/nD+XWA3OLC5XIufHYVhdLlLt6H1L0jAsfvLVqs0U9hR5Dat+jsmlOuHIGg4HPnBunkUpNhdbl/j/urNbH85hBQibmYMukxhIANY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lJlZKJr8; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a994277b38bso52823966b.2
        for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 05:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728564060; x=1729168860; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ppIwcz3CS+2v0NWFFAahAGCJPi7hhClB4Adm4iBCRM=;
        b=lJlZKJr8B+dN5jlPeIlRjs198YjcnwYrex6NNWd/x1dGJxqjIUdM+jlBYszHaRGjpL
         tW+Pc2vRu/Tkve8Hjrl3blTFFhTOIdk1W4sJUNgqS1+dDEEIUkaT76myrBksgfxCRxSv
         niVRR892woXRj+Tub+ZpUZwRQEoLyk7s/zCWWKI8fbsNQ1RHi4I8DOJIDCI/dmzB7ZtG
         yRnOJRszWe52M0rSzrfhxSoDPunFZTZln0VT4ixuDNOAxDP9lCSUEF8TqaSQsy5qHQRQ
         Et01S8dhIEuI2MAixsJthBPcdDx/dABzqm1FhpV//bRt+HWLxpdSh5Sw5y9wQlcK8YjW
         VbpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728564060; x=1729168860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ppIwcz3CS+2v0NWFFAahAGCJPi7hhClB4Adm4iBCRM=;
        b=gE2jKC/ghHf2E5MJcErWOM834UDMQA1mejAnVnQ1HnSjR2qgQJNpcT/dKoylwFmiwA
         ZK9kYuseo2oN5/ZJsyUMYgdB/J2RYM3AMTTENDuivNBOG2/hCuK26WZcVCJ0VVi28F9v
         GeY456gIvzD1gmbgCcgKTIxZIxjsRESSuhBJBMdyT2ISGQYF6iCC1olg/oxuHgNRjnAq
         0YhSm7r1n9yl9XIwInjCuSHkBHiE2RWIwZWxPd4lAMUzYMZhKP3wHCeMqAk4DWk3FzFY
         JB7cYGedB+eTCT5eMCHliUSHGIdnCqBES29Kua5GOBduKvCQo9JD835CbluYFNl6l9ME
         RNWA==
X-Forwarded-Encrypted: i=1; AJvYcCWOdGwM+OYU1mGKVIw1KATj438z6exbDj2koCVREXBX4EaqjRd0Qu58R/uRh2E05fCNd6xKqXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyILQp1JGbVumzCpiqzzIpT4iyyJX3QZjkr2CBpo47cTZ6y5gRk
	3kVzxZHr2YynrDWrobpXQZc01s/OzpmCBVIdk5zxpNNSN+ne7X9Gp8wsXbyPZHGNuJtGnI2oNMl
	lHrtLbc1u2HB4bbkgKJhGgxgbjbFG9F3/8C9s
X-Google-Smtp-Source: AGHT+IFEbyyek24mpN1eMM0Hd+dp6kP9bikvJEyh2Jqv/fm0j7IMhRmMRTkpQfQtNt3/yxp0hLexyDT4Gny1R/6BL0w=
X-Received: by 2002:a05:6402:210e:b0:5c5:b9bb:c341 with SMTP id
 4fb4d7f45d1cf-5c91d623839mr7612938a12.26.1728564059514; Thu, 10 Oct 2024
 05:40:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009231656.57830-1-kuniyu@amazon.com> <20241009231656.57830-5-kuniyu@amazon.com>
In-Reply-To: <20241009231656.57830-5-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 10 Oct 2024 14:40:48 +0200
Message-ID: <CANn89iJk0htjZt+Q2FXqXsP6369boYcnBrZUoVhuJtVOGUyQ8A@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 04/13] rtnetlink: Move simple validation from
 __rtnl_newlink() to rtnl_newlink().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 1:18=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> We will push RTNL down to rtnl_newlink().
>
> Let's move RTNL-independent validation to rtnl_newlink().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

