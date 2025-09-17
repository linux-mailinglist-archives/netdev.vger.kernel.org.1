Return-Path: <netdev+bounces-224149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9882CB8142F
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 19:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 563B23B8193
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 17:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFC52FE045;
	Wed, 17 Sep 2025 17:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4eValvNL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06DA2FFDE6
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 17:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758131826; cv=none; b=LzQBFlTCPAPXd5uPQwCJlC5U/1frTIaV8W1m6F3fsx0NVpT6uRnz12A9lhR8s9KCVlCdRdyl0NtgFOkRuxCuKW61LCcSLxa5yFxHj6iFYLZL2ni0K+7He03f5RIMIOTiCEHbH6ksrtuNu02v3nFBOq3xXb3NwwhiVYtEajJIdzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758131826; c=relaxed/simple;
	bh=TSvJlr704CKx/cfRFOjh/vjSrZRGeDDCYBcFuzEhaeg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YsAwTmjI/UF9dsfHaz79xegMzEGe1dlFE8wgTGZyZNKJRQo7cPI+O6W7JIr3DxF4bPCHPO6dFY/2sB3PC4sVx0WCNKmD87PFS3oH8buZvblY/i1qpYoQR2w5Y2XLFfi34ZkutUR88bAmgjAQQYw8ap+R+tDdKF4m4u1Gu+rK88c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4eValvNL; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2570bf6058aso1133755ad.0
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 10:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758131824; x=1758736624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TSvJlr704CKx/cfRFOjh/vjSrZRGeDDCYBcFuzEhaeg=;
        b=4eValvNLeDTzqFyIIDXsAkyOhnjF9x/VBH4HyPK64P1gvd2elmEfAlroK0foLI9pbJ
         A86g97UgNft6IY9p0VCRqK80GFDxS7haC32NQDgg3L74xirJ7N3U/Ozkg85WPV7nvkqx
         pcQeMlS8g3iok1unS4xZ+azq9Y/qlOiK3npxxYEWscnSzaVrMxe6GBROxQXn7AJFeztd
         yYSDuXf4mft9HfjVBJ8wwAwv5ALNneTFw3On+ScnhRpehECL5C41KEV4JFyuazisX3MU
         AUBDxNBLbRtauxvaww7czsNSk/lk5QpZDcPuNUEhBuWeNC1bx3d3VcHlqM/7U8tcPMN7
         LP1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758131824; x=1758736624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TSvJlr704CKx/cfRFOjh/vjSrZRGeDDCYBcFuzEhaeg=;
        b=JMiWiZNWP15f2tXt1grembQ00c/XIfTjNmI0Jm8soxkTCERdzPnr1bqvzG2SROKcRv
         /IfasvzLnGtqMKq+9lTVb/tWfC5fX3GAXdiPtlut+QAshK+HoHIaxDMvRtsclmbKCEju
         dA1IZ848/c381m73SLlC35MIIoqCiVhwCd4SyCUkFZoPOa2f7UpvbTn6ntqaQ/glJj6e
         HmrfDZZmYv+lyFGycmEqJ/2Cnw4A01U4//10+E7+Uk+z8hHtMJ82CFgegCQPf6BbeshT
         PwRpM1u3UDMDP3DMqMTdE/uU69zql7TnYWJxKfDNXMeet0ShtD3rnJSs0mKgNGVi8xNu
         9S9w==
X-Forwarded-Encrypted: i=1; AJvYcCVwUZPnbPumeOvVqgyF/HBRTvWHw0HqVKDMJZt2ha1CEe07p83qwOykrfxVBHrU9h8gR4ZYmFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYpCxA3sqTy71943ols3si7FfJRVGFX5GZMKP1fWSV7ZWzlOB9
	xNFEuhWQc6mO9SfxmrX9N5zA6TQVWznmfypWo9e3SCX+pwDiPAe0X0VWhJZ9xqpyqcq+Zg/L9kO
	YJZERAXu0RITx1vt7rGbnAvauDrZiPBd74AkbFDEN
X-Gm-Gg: ASbGncuPQh+cpiyvb3X94OC7MJc77rHUOhbIo/EWLW3SE+IkQ7E7fQJ21W2Ybx9j6pY
	Jo5oM5/n/0KM9V/MgaG8AupI23iWeAWJjtr07S5cbM8/yOKbXBVxdpuySws4qkLRAO/Rf1FDFRm
	Ky0Lg0JajIGFEsTjT/ZwfBHdIi1FgSjot13SxDIFOgxRs7S41OsqLjUUtMfH7Kbr+VCKRsH+ozp
	nbfUYv/4/LHmbLt8C0kiBzb8DEGaDQWm72Lr7+P0XXm
X-Google-Smtp-Source: AGHT+IHbxMlKRMFhB+PBX0sXiGNrVNurA14cH8x8gvEfTbRO9kU1rSVToA0XPISn9mt2/VtkNazrAUts468SIOR0v6s=
X-Received: by 2002:a17:902:ccce:b0:24c:8984:5f9c with SMTP id
 d9443c01a7336-268137f314emr36740855ad.36.1758131824113; Wed, 17 Sep 2025
 10:57:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916160951.541279-1-edumazet@google.com> <20250916160951.541279-2-edumazet@google.com>
In-Reply-To: <20250916160951.541279-2-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 17 Sep 2025 10:56:52 -0700
X-Gm-Features: AS18NWB-q7VMIVcDkb2ovLugxLWEwqpxBvQk76E9bupvKoZjCDtBWUs3VkBLM9I
Message-ID: <CAAVpQUDSNDOSriMhb89u338LEQdtL0_6+KQH2VdKREhuJm1qKg@mail.gmail.com>
Subject: Re: [PATCH net-next 01/10] ipv6: make ipv6_pinfo.saddr_cache a boolean
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 9:09=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> ipv6_pinfo.saddr_cache is either NULL or &np->saddr.
>
> We do not need 8 bytes, a boolean is enough.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

