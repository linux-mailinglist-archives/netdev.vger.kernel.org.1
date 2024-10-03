Return-Path: <netdev+bounces-131487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E707598EA1D
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 09:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF4301F27C6F
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 07:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7ED145B0F;
	Thu,  3 Oct 2024 07:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CeAPR7rx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A64B13D245
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 07:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727939265; cv=none; b=rbvUjaJBAQ7Cy8r6Jih3+DcBMxhkFSdHv+34NvpIk0Mq9UIr5N2/lk247QX7bxAANbYOrzmRc9PtB+u8z5dpKO0iSPuJv6G7jPFxwqFtoo7GBnCYMEudAcuVu0zSNRolf/4+Kmk4UU4sxVF9Jltky+mawn8pokBjlI9V9+K0Df4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727939265; c=relaxed/simple;
	bh=BOxGOESbJxQSIMDevjL5fRTBra8sOlJRoJvGNftnXMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QvDBJBSVWjCGIkX/Au7ugNWZ4v0ONFEEhEyYyvgt66MzAUYTIj2rURGfZYVEuHIefvyxECjSxzuxOg/GHodEED/F1TFjkXcJlGMPPzLD9NI+0x+hFlJZja/7Rj4SqY+loTSsqQzl1xb6v2PL4cXLY0ay3/T/YWPZOw7fhRG1pbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CeAPR7rx; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4581cec6079so172131cf.0
        for <netdev@vger.kernel.org>; Thu, 03 Oct 2024 00:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727939263; x=1728544063; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BOxGOESbJxQSIMDevjL5fRTBra8sOlJRoJvGNftnXMU=;
        b=CeAPR7rx34ka7qOcURe5xOtZJlmLrGVOGTcXX2x7v3rP8RuM8Mnn4HWJbM5Z7hyuWc
         kALGP/12G3ogVrZLS2mFubchJs7CvEe0HSC9+whfHyNf3tTIfEjtRlQV7/b37BcdlbS8
         +RFa1NQXIVrbj9mEqiclJAErW1VPzYIrjcVPGLX9SMrHbei3oKs5weslsPV3kOrkAcUp
         At4moWCrvUlbFfpjko9QOKW4FqFy/zVYpLyga0WfDn8MUt9mMkxFx9nzfObY63XFORCX
         inMIAOKc0wGQgxGPhaKFdjeO/B96uo2iLI9fBp9fcBvoyfAVi/nvboBPtX68j+yF6BIR
         noHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727939263; x=1728544063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BOxGOESbJxQSIMDevjL5fRTBra8sOlJRoJvGNftnXMU=;
        b=bdsAqeoXZLYY4+W0F/iE70GzI4o/z+vW5uceE7fYmezW/I7XVW5EZ2q8lDddyz1CI9
         S93tM7dXd6n6DDauQqRlick6q38n7p4Plm+WxtBtbfefQCVlbGZ2qKiJ5mZSudiWgXfq
         OBSWy9ixlnG3c7ErlQwxnBoVoW4/rJB7O6bf+r/NUU4wSzAGNiueNj67/4ozO3svtw4+
         oepHHAFs5OLmLGJ/YWyOeVHfVgQ/y9tvuxeFVVjcI1WK96NTsW/YhDiPfd5z8TzyDsnU
         1acjUGDhtMmdJv8Kg2sBIF55vjPbEwOWhvWmRkStVYlUvGYigAHH+Bdi0s33Pn0J7nHo
         9wQw==
X-Gm-Message-State: AOJu0YygwW/fOZnJXydbsx3gtDTC0BRZAmMeUlkApj1Bs4YAen8pql5C
	9Sxjx5k8GyG+JLF0v6ZVVi2OwUl1GkkSGWsMuAUaSBq/sUOoNABLWAAzTXtz9jK9rhR3Jw3dqeB
	f/tKWJmC43H3QOeIr6ksaLXEIhLD/SwFhVGBC
X-Google-Smtp-Source: AGHT+IEhAGDOvrjIxlpBDmiTA1gCRgkifc0TMQyCa/a2yNVm0tGb2VBQZHPhGOS3xhbDKX8guF777g1CnNTXcumMPFc=
X-Received: by 2002:a05:622a:47c5:b0:456:7513:44ba with SMTP id
 d75a77b69052e-45d8e1cff9fmr2143631cf.4.1727939262993; Thu, 03 Oct 2024
 00:07:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930171753.2572922-1-sdf@fomichev.me> <20240930171753.2572922-7-sdf@fomichev.me>
In-Reply-To: <20240930171753.2572922-7-sdf@fomichev.me>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 3 Oct 2024 00:07:31 -0700
Message-ID: <CAHS8izP-Dtvjgq009iXSpijsePb6VOF-52dj=U+r4KjxikHeow@mail.gmail.com>
Subject: Re: [PATCH net-next v2 06/12] selftests: ncdevmem: Switch to AF_INET6
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 10:18=E2=80=AFAM Stanislav Fomichev <sdf@fomichev.m=
e> wrote:
>
> Use dualstack socket to support both v4 and v6. v4-mapped-v6 address
> can be used to do v4.
>

The network on test machines I can run ncdevmem on are ipv4 only, and
ipv6 support is not possible for my test setup at all. Probably a mega
noob question, but are these changes going to regress such networks?
Or does the dualstack support handle ipv4 networks seamlessly?

If such regression is there, maybe we can add a -6 flag that enables
ipv6 support similar to how other binaries like nc do it?

