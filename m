Return-Path: <netdev+bounces-131482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB21798E9E4
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 08:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F38D71C21B4C
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 06:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FCB80C1C;
	Thu,  3 Oct 2024 06:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wKP9V9wr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E6080027
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 06:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727938617; cv=none; b=tIYKLbxhK9Vre+IZuS4Kzp9ddO7lx9OUW4Cydoo+dkzoMQV49kApQ9ALNw2l1pFAl7Q3xWAtca3H2PSnhqcDSLq/3MhVIcylQ6HM1YCladcl60A+1AnUGk0S4OgetnAS80XLz2e6/CeoFk/KhxEIgIGt5jN2HpmmIDgLgov5OLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727938617; c=relaxed/simple;
	bh=IGpmuVLcXVWgMKVn/b5bxnOvXBZ2ZZR7dw9yWgKg2+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KNfdgH4l0LMSA5q/XU8gjuppihq18TJoKOYqmwMUbSTG1jCg/cRs00UmLopy3ph6JrbvMhNY5LhRohDQ09ttxqsdcmkivTJHeekNOV5scJ/ngB3U2rwt4Z/8VH/TZ7Wef0MblO8XFasElZbSL0LHVpqN1cvWBMYiUweStd0oPyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wKP9V9wr; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-45b4e638a9aso140861cf.1
        for <netdev@vger.kernel.org>; Wed, 02 Oct 2024 23:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727938614; x=1728543414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IGpmuVLcXVWgMKVn/b5bxnOvXBZ2ZZR7dw9yWgKg2+8=;
        b=wKP9V9wr9aoQbzWBA/J7RzYx7wuMQTDn6CaFa9J8M32uFrfwyCMHrlmL+FfU5Ex/R3
         cxtk4KaZuoTHNYBPZUqHqf48OX3QBwM9j7kVJl3h4S0hapTeohyG3fOOrOUM18biiZYt
         o8uUaht0XSFEYnHyymGD7nXAx2VPh/9ZPn/zuhSh5VNBOXvFYJypFJh1rOLydbWHQp8G
         E/9GRrBuig/NElxGa1rJE7uZnf8B2ttk7xZYi1pQaoii/tCW5EHgJbkTDrDyydvf8UeN
         jyjd4kcIE3rJNaQphrh9w8I92CYf6fqWCklS6u+W2jz6BpMnuxt8JGgBcAz6JDb5QMZf
         Dh6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727938614; x=1728543414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IGpmuVLcXVWgMKVn/b5bxnOvXBZ2ZZR7dw9yWgKg2+8=;
        b=VeO/qy/3qjNVspQJdcCIVha2BPIWM5HXkIc11yJvUeixp/tl7BrrXl5I/STXFs4hQ5
         RLP26t97RG49onuPHG9nINbedLs4/tjevU2CcTK4eymq8vnYgOMEPpkOjAT6WU+E+6fO
         DNLLy1FWPVqkhKMYj2K1heRN9ckYXenbAHbB98FSMMUo3KrTuQigEudF4nIhZu1qvOrJ
         0Iuits4YfMEfRbmU2ayHH9y48b7aOi0GwGXDpljUBV0ViGPY++dOivtLvRQof6lEXZDd
         VPwJ/TW53Gse6eHs/MnxgIhibKMTnfuSauJwna1C3Tho2n/nCJw8KswcexcXm6lSKenL
         Wf+g==
X-Gm-Message-State: AOJu0YyQ9DyS6rQhgaINW/pNLtJybpCZwm9OSbG0ZR6fdr5mc/b7XalV
	MfUFYTWH4b7JccpbZyws2boBVT25bLyyZCYK95lHBQjngP5wMr2P3qg5VCnyCfKCF3CNMCdL2HI
	beVTC7P3U2mTEN3AnaI9RjHNaoWZxT5t472/wMLxjRlmCPWdJLg==
X-Google-Smtp-Source: AGHT+IHw0qO6ipNTI2wbR4jjIW3xzwDcLBJeY8RBTZCNgxwhsmJc8vw+14+wJ0EO/rIR0TxcQ4qb0HJEnzehvSXVJDs=
X-Received: by 2002:a05:622a:7692:b0:459:a825:54b7 with SMTP id
 d75a77b69052e-45d8fa64c16mr1256731cf.23.1727938614278; Wed, 02 Oct 2024
 23:56:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930171753.2572922-1-sdf@fomichev.me> <20240930171753.2572922-5-sdf@fomichev.me>
In-Reply-To: <20240930171753.2572922-5-sdf@fomichev.me>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 2 Oct 2024 23:56:40 -0700
Message-ID: <CAHS8izNn77oHbcxbLkQM-mmkijkix9OH+EiUBB7smCbxbxhU5Q@mail.gmail.com>
Subject: Re: [PATCH net-next v2 04/12] selftests: ncdevmem: Make client_ip optional
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 10:18=E2=80=AFAM Stanislav Fomichev <sdf@fomichev.m=
e> wrote:
>
> Support 3-tuple filtering by making client_ip optional. When -c is
> not passed, don't specify src-ip/src-port in the filter.
>
> Cc: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>

Sorry for the late review. Been out sick this week. I'll take a look
at some of the low hanging fruit out of this and hopefully finish the
rest before the end of the week.

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

