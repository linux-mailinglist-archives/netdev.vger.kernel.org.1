Return-Path: <netdev+bounces-73717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3248185E01D
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 15:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D16F81F24EF3
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 14:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95FE57C0B8;
	Wed, 21 Feb 2024 14:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bMxPfnUU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13737C098
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 14:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708526547; cv=none; b=PeSB9a9+kdMsr6N4wWrjcv0cohAuD7wjnMk95nY6crkxCKCS/tABmZ02Dsqj+N6D1Kz4p07aUcKI4YEIVDNwRRueKV+LWrCD3ZKvuUmPGrvjks4zYS3fIKOhfR3uIIo9e1yEcMkQBXkrkQsTkJsTC8Ic6kBeihcPXw/a/QwwiwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708526547; c=relaxed/simple;
	bh=gFSz4L+aI0Gu8pUuZtJXXMWlr821tG1RaZ8uUQEGGMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gb/DlNwzB+rD5eYc5gbR/NvHk7PXbYN0DlRk3ayAKf/ToM2FV2QoRjtSQ7X3n/hpga6lW6utsrLsuJ4OwOiCErS4lE0GvoyuOjzEV+lapMgDn6BJC+ZhsMsf7LV6LmJPdbdUFCT1nZjNYCuQvkg1FOQM99K0YCo5ZHNymSMjFHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bMxPfnUU; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5650c27e352so5256a12.0
        for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 06:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708526544; x=1709131344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gFSz4L+aI0Gu8pUuZtJXXMWlr821tG1RaZ8uUQEGGMo=;
        b=bMxPfnUURc6uuJvANabw+3/V2moudaIJe/zJUHu0rtjM3ZfkADUE+Ni+1pQve+d/bS
         Sj6rB4kKrp+1S+cSw3Y8NqMbrX9gXxKA4FHzi/fLdfGCdUyvQ7yGyFVvl5FYVhBQr1pv
         zQTxOWFkH0MB4f8Bh97Gl6dA3kpC9qHA9E9eOIOLzeAiInmSXxyFDE664f0daVZQqrRU
         XeKljyfkaZYEbDAS8vl944mTLcQ2y882tRx9pM/z4MyniOzVOZ9FBp+o/iu/TqzO9Ew+
         8Ct1SxBq/i7mG1VVusGtx29u8lnsxi2BMO6ynNlF4KKTF5worTugi/vesVUFFE5+DIt2
         cAXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708526544; x=1709131344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gFSz4L+aI0Gu8pUuZtJXXMWlr821tG1RaZ8uUQEGGMo=;
        b=UVHXngaBeP4oC+p2WYrgXNO75a0yubgpuWwOeXhNkDjOBg3LTr85yRBmcwZtb3ECii
         dXytdYZ5I5c/M9LzWrBsE4/gs7yFTLLJr5nHqmNpMTtRr3Zcic4nhbScD9nzXpHyC7ma
         sUipUtMB96ItXyWWCvMmRnhYaPxmlf4nJnjD6VvaYJ/RL6vwvEozxVAGBIoA2F/L8e0h
         C4TXDJ4jlo9Za+1lKbsOdUMHrn/bNOz+/NaLup9/wgdVrUEAxk/kOH9TYdv/dWaBHyWH
         TLrbeB4z3CHoQ+MLwpN9p5RSWl6DyEedKOrRX9a/KU6hSm/GFoQI1yMZbK3ax4Yo23K+
         MtQA==
X-Forwarded-Encrypted: i=1; AJvYcCW4+uL9//zhg3QllWUjIujdHI7tgrk6v67uafQfXDDOcmNq9XucI0ZtYruwPaikWJuq1nYyeXPEYsXqw/qorBpXDPtA0vN6
X-Gm-Message-State: AOJu0Yy66befG4BGv+HyS4RBHMutef65f1sqXMoA/Y83jha7ldsRFlm+
	xQfTOAtj3ZuAm45AeRr9qw8V9qZDm82kNHxwWcwDcTn1BOaHnhAkCq+5XYT6aQLxLCGLnTeEJdm
	P/thxJbArYDMVQWt2iXyy/8HJdm6AcPW7UXiP
X-Google-Smtp-Source: AGHT+IHk8Jm2n0dCP4T6QpyCSNvoGJjSVoha0b246PUzY7nlFEp9vsec4maWmqM0VyfSkBjYm4/eCqfxdXAXqTAozoQ=
X-Received: by 2002:a50:9f04:0:b0:562:9d2:8857 with SMTP id
 b4-20020a509f04000000b0056209d28857mr188654edf.6.1708526543966; Wed, 21 Feb
 2024 06:42:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221025732.68157-1-kerneljasonxing@gmail.com> <20240221025732.68157-10-kerneljasonxing@gmail.com>
In-Reply-To: <20240221025732.68157-10-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 21 Feb 2024 15:42:10 +0100
Message-ID: <CANn89i+Uikp=NvB7SVQpYnX-2FqJrH3hWw3sV0XpVcC55MiNUg@mail.gmail.com>
Subject: Re: [PATCH net-next v7 09/11] tcp: make the dropreason really work
 when calling tcp_rcv_state_process()
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, kuniyu@amazon.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 3:58=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> Update three callers including both ipv4 and ipv6 and let the dropreason
> mechanism work in reality.
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

