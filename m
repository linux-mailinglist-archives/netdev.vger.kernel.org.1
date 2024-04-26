Return-Path: <netdev+bounces-91569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 441BE8B3147
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 09:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 508A1B20C76
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 07:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C715A13BC2B;
	Fri, 26 Apr 2024 07:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="STAT+mb4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3703F13B7AF
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 07:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714116325; cv=none; b=WKig/jwvL6LEo01urA77jVjO/gOTFdRvjkxfg0MBONNjlkmsuM+lTan/PeNSts8ewxXNbztK1xMSWga0vki/mZ6XSHobBCHJgqTyVB9fmePllOhGJQmBkdvgMGcFf4vcLyaYtfs07Y8NOt2K7p61fxTh3AQtCSumqfxQ5gK+fB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714116325; c=relaxed/simple;
	bh=NBDLmIbfeg4MLxHaUiISLNIYEFid+SJMJ/4nQNFwMw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r+hG2TeKkRoqFb4XIvBct2wuYdfR/QgIphr6YoGdRVPGWbK1Rnkngd8uimYBtwsjlOuGCSH3u1cdYPyz3UY7ccqo1bpNtAihmDxcPtv7YKxwSo5ZOwsGW80qWMsa1byxYkgpQAc3lzLILOlfSipW45dlTc1P/4H1xUVPspUsUJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=STAT+mb4; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5722eb4f852so8434a12.0
        for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 00:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714116322; x=1714721122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NBDLmIbfeg4MLxHaUiISLNIYEFid+SJMJ/4nQNFwMw0=;
        b=STAT+mb4B7h2FcarqqtaAajMQmedPAfw0RxX8jdYkRtn0+Smjv+8xQ2fOSGPRBQjLv
         1jDZH0kBg05U3KEyoOIjAo5Yk2L8e9HMGpJZlFmnxv9GNO3909kcc/kYamm5E+BCqsVW
         B7vLCqPEIe+eAwMeIx0KmoM2wei22OmeU+KmIy5audDO5tSRzVdgdHv7XjdbPZLqhA9W
         +fTVj01Up3dm65n+UwDgvbpe+d/rSEdRgrxhvt/dfS1FG6+Z+0WUXZoDDBraZyR67bti
         Glk+whjqiTVK7q9rIylSXMAmCqVVeKeJa1NpAetnaUMeMDyxs3GY53AwtmI4x7PoRTB9
         d2Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714116322; x=1714721122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NBDLmIbfeg4MLxHaUiISLNIYEFid+SJMJ/4nQNFwMw0=;
        b=Fr2Onypq9ROW5YichdTuRV7QMsrTr7KApw32bx+SqflDXUbc6XbER9hKheg1s/ga+z
         sMvcgqAhYK5fOAPklE7uoEewbELs1KkGaIEeIvjujQt15PgWqHpUheKohTymgr5TtyAm
         MWBvVadnEFFzTxBdFC59mRPIVUNlTWEhNn2Ld/rhWj6D5yu1jUvuJfA4FM0G8blVTSPo
         IEqmFp5jUqXCqckMA0xjgHSPmjOATUSsnyrUs6vL6QVm2c3ylz/g/d6KAOZ8ioDQZUjk
         Acf9wKdgHdhRzC2f/pZw8ZJkvfjTi1kNDJ5WeINUsBPqrvpdkJPlJKraczxxBAEHnZj+
         1NVw==
X-Gm-Message-State: AOJu0Yxd37Ioe7IJKmYX0THdhMV8JrmrhsNlf+NunYECGTIJh03Hey+J
	ZPWbZ9rhUpQJKwqv1TF6St0rBVpFvazSV6Qtv0hDE60BvCkWo6F9BFoM8+Gpf1PteD0nkToEKwl
	iqixP7oAKCs0o1smYsIRClZic1wofGK+RDR2Jvn62YGcld+h8xg==
X-Google-Smtp-Source: AGHT+IHJu+O1gwIIMR43lt1fCVWwc4P/N/Gev1TLJ4a6hdyO0c80V3/nTcQiztmrwOx9YzRgprMZtE+I2DQUllnRPOk=
X-Received: by 2002:a05:6402:2899:b0:572:fae:7f96 with SMTP id
 eg25-20020a056402289900b005720fae7f96mr107283edb.6.1714116322303; Fri, 26 Apr
 2024 00:25:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426065143.4667-1-nbd@nbd.name> <20240426065143.4667-5-nbd@nbd.name>
In-Reply-To: <20240426065143.4667-5-nbd@nbd.name>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 26 Apr 2024 09:25:11 +0200
Message-ID: <CANn89iJNcYqdmNZWu0mtVR44Xyq_Kx7hqpoJqKbR8jTKoEyfhA@mail.gmail.com>
Subject: Re: [PATCH v3 net-next v3 4/6] net: create tcp_gro_lookup helper function
To: Felix Fietkau <nbd@nbd.name>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	willemdebruijn.kernel@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 8:51=E2=80=AFAM Felix Fietkau <nbd@nbd.name> wrote:
>
> This pulls the flow port matching out of tcp_gro_receive, so that it can =
be
> reused for the next change, which adds the TCP fraglist GRO heuristic.
>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

Reviewed-by: Eric Dumazet <edumazet@google.com>

