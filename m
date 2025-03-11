Return-Path: <netdev+bounces-173944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD702A5C6BD
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 16:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB12B175395
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 15:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD3D1DF749;
	Tue, 11 Mar 2025 15:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HUUjsaDV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520D625DCFA
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 15:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741706717; cv=none; b=tXWf14PbYgo0BqP+5j3LunNYkImDZn5CMc8jrRxibSpM3vJ8Fl3YKMnA/1kvx1wBv5vMo7Qx/YMBXKzMLMQpWeFwzAsZtsa1mvl6i7ahMAp2B9IMaM2nEBFLhR3lIUb6Qs99fkzMWGhLpTCkNas9rRWRFiTSeBtpEk/CEDmTpV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741706717; c=relaxed/simple;
	bh=7Bp9L0XUWM9HtD0nXnjpoDsrkJ76vECMAdIWTHbJYpc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lk3jlSHYab/B2DMX7x/Y41Q3iypWGipYDmDxpTYU9IX0cMJT9QsDcDdANV2cE8Yu9A6JU59VuwR55Etf32N+mzhfrYeULddukaoT2mDmDnkTrvnJptoSJGII5YtSJCJOOM1uE0fp6PdTjfY0usuQYjL7Ua7xEtWgJRLTHBew9k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HUUjsaDV; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5dbfc122b82so11585a12.0
        for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 08:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741706714; x=1742311514; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Bp9L0XUWM9HtD0nXnjpoDsrkJ76vECMAdIWTHbJYpc=;
        b=HUUjsaDV/h6OJdxgsZ+37hrpAZcw3ec0vlJOy9XUpIzTYASBcuWKHCNLV2QFYV8t1u
         Syu8FiUiXO5sGDYPwcIwov0CFfAmSg8Qkrs35sqzFNU9N/eTlQpLSGCpNiHwF/2Qi78U
         dlrZCrIfqTFDj0jrYT6m3yTIi7NnzMI/fW0YsWRf8HgBxU1J8n0wGBBMHJ0ujXLrUgga
         cHBftxP4VKAuLVDHw19KTQGWm7hDoRK8Qq3oMpgAOQhT+Y5CzAIHSM1BFexjYEaydMpC
         oAOo6E6JNG9DGU5y4VTmzn8PsVt2NgGL1e9TAIeQBh+c0SLDgMxo9OlN15lUHRz0bnEX
         +a5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741706714; x=1742311514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Bp9L0XUWM9HtD0nXnjpoDsrkJ76vECMAdIWTHbJYpc=;
        b=gJnufgUmHHo5bu5vTbpAqEAwc/Rct2SBbSOxVSF2+WNP05+/2+lJCnBnYIhrsuQHgq
         mnDX8t+1K8hGZUaKHbH5Rm5B9ZQ1IZc3TKscDQO1GsdSpGJIS1KIHP++PD+ni7dpsdjD
         29VA6HV4C5ZhH0/Z2JaCS2tsRZ4NkGLBqQrKlOFt76WFaQ1O+WlhUj8APIktY2XLWdmw
         KZE/8K5uh5n815gYReAkY65FP+a6GNo1Nq3ciqSjTxfSTbmSS3oHtsIAUrqK/dJQMVM7
         sa1rxT481nZlQzN+N8mkfoJbuKye6yc9cnhLZYQ4YMejyu5RtP7H3WBIePCEue7OvV1f
         UPxQ==
X-Gm-Message-State: AOJu0YzL9Qt+ugu8DA4Obq7J2HJwy9ouUFmGB3RUdlqFCCUVmMFXvPtD
	8tZxKSW0ZIZTVHKdEsQXMwtBoVDkfKcdCi1C8nB2NKkuS+oXePsBjSWJWGLaGTaaOv1yT2dOmN3
	2SjObKtaR0oN7vJMgLfqQA8x60hnhoFIk0muV
X-Gm-Gg: ASbGnculjgR7mvk4L0wm+lFe0oUUzfRCmlyt2rSHve6b8AouIeaPmnQLFYdSzXad6rM
	HcaLPhqwhLmnnowuPERq4pa0hBjK9esjRPgwsB/PywWKR/wLuFJRVYnuik2XiYH+mAtUinmcnVO
	adr0yqmzpyNkzj/ZFvxGW+nT8PKL36xV6qP8b1gsg60H8HOkABiQgIXWw4zccwL3YOsAk=
X-Google-Smtp-Source: AGHT+IFJ+Zeetb2fHKVwImuvwaMBfM6cXpntiP+4Ydtlv8XW+cVvGKQDiMqorgEbo/Wt6gBVZwA8xdRT1ITflpkqSZk=
X-Received: by 2002:aa7:c918:0:b0:5e5:606e:d5a8 with SMTP id
 4fb4d7f45d1cf-5e6173bd40emr307514a12.4.1741706714455; Tue, 11 Mar 2025
 08:25:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311144026.4154277-1-sdf@fomichev.me> <20250311144026.4154277-2-sdf@fomichev.me>
In-Reply-To: <20250311144026.4154277-2-sdf@fomichev.me>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 11 Mar 2025 08:24:56 -0700
X-Gm-Features: AQ5f1JqB6yJCw8-bZi6XkUvhl4Z9hUm8qqLBipF6hy06bumhLqBL7PWMuXMFE8Q
Message-ID: <CAHS8izOkrSAZ+omAC4EVZ3NzesOC7dgKyEto0ufK-bRpP82FCw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/3] net: create netdev_nl_sock to wrap
 bindings list
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org, 
	donald.hunter@gmail.com, horms@kernel.org, michael.chan@broadcom.com, 
	pavan.chebbi@broadcom.com, andrew+netdev@lunn.ch, jdamato@fastly.com, 
	xuanzhuo@linux.alibaba.com, asml.silence@gmail.com, dw@davidwei.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 7:40=E2=80=AFAM Stanislav Fomichev <sdf@fomichev.me=
> wrote:
>
> No functional changes. Next patches will add more granular locking
> to netdev_nl_sock.
>
> Cc: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

