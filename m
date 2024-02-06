Return-Path: <netdev+bounces-69527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F3584B8A2
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 15:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FC8F285BDE
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 14:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB972133420;
	Tue,  6 Feb 2024 14:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yyn2UjtE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208E71332AE
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 14:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707231424; cv=none; b=MoYg7P89XcbfHGFwD/4dqkIzdE/UN1ed1QsN6+MaqXhT4xrFMGZ4r3fnG01Wh5aTKAbqWG+XaC4UO7MTtLHuIaf10GL98JClPu1yvoUBOMHH/i4bHPRGr8k5vrnHNl67b37LEP1b7chcrOfLFqkG2YYeH+ve9Sa7D1r7phsghzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707231424; c=relaxed/simple;
	bh=PoMW5Q6UrU4QGMhwq9QRDhrYKAr9TnNOB1wofNuBKxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rljimmx+hJFjqCCSSKsWfe+3C467j7wkX0hI7vm3QMJvJuZ4b6PxDkM09Aaq+77Td+eOAVqka+mE56IiFuopJBh46cNoyvhWN7/6BcOAuEcZ341woHZ3FBeX2Ldexx/BLmhaSA/4uQncJzMZ1MomdA40PYak3sNAqiMN30tZjzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yyn2UjtE; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-560530f4e21so10737a12.1
        for <netdev@vger.kernel.org>; Tue, 06 Feb 2024 06:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707231421; x=1707836221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BBTSg4JHj8MuJyKVh9CBbVq0JOZhhjmfpsZfG/mA1Xs=;
        b=Yyn2UjtEaQr+irOaLGr7622CtsEFEtU6aabhfexy1tSnPcjte3frJtWKsfG2TYlQzb
         BOsfA3B8DG2vl8VqdmYUSWSn38nu7n5T1jKr0B0dofs4hFR9Ml/p6oVpbBXvxVnA79Xg
         x33Dl5Qk8VVWIZlFXwQZY59/+Qkf/Dty5Y7U/ZieIUe/466nDgiZMtIsZSEVnwkEQGok
         C2T1RBSou1FYTKV+oPqEaAWUQObEPqakdzXkoyY/RmrGt7Mb27VJDQ7FlyQ6e72qo0eH
         7oJR/vA5dsn1WT0WQoBHH1GJ5t9+/dAO8Y6ODrL1IqvdUpFF9O0KcFZpbPASAy9THVbU
         PvIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707231421; x=1707836221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BBTSg4JHj8MuJyKVh9CBbVq0JOZhhjmfpsZfG/mA1Xs=;
        b=nTsWDuaIE0QoxqX8C4puXH46USJpvFQMcchlNRAI9ZGXzwtJ8FRTGP27sPI5cXQKAi
         YTjsWQS9vA1h/i7orSr8VLPWUdn5jNamH8tAF86N6eF+V7TZlOKrK8ppFXbFFq1MNx3O
         ea+NStJ3N6diU0L7fuK7rSkcJ9OLXRmTc1I89SQ8jgsVpggHUoI9p1zpHBKS86INao7f
         dYa+/ePYozdJut0yVnFy5VXmuxe+1XbZ1IZjsCarJw3uwXe7/VRrK8yq7520xBAP2YMS
         mFsk9hgQeHOCngcKzhhwhX2vfG7rgZDZaHS7Wn4DTxsTZCiBp2mdteocCgK9RmM7VKsp
         YBFQ==
X-Gm-Message-State: AOJu0YwEhlYLrSAK7Qzw2hWFJn/R4fTw9UmuzuBJ3wYSWvTEnDIaGCdv
	adWhiuzDD3oP/t+Vp63Wil8YhXYomIIVQunz1bssyB3gzl4EUmFB+ciBzmu6l4OUNv4Y5xPitaA
	seqwV8KJ4zy0sSmG0sFGcvhzQX5KHEkEeK2NG
X-Google-Smtp-Source: AGHT+IE9bQPoVKefOR2TDqCjaJuIbiWWPLVENg3PYPhVUmxaN/CSmJ0Ag9LmwbB04h15BpwC82tV2zIDryfpf8eZ0lE=
X-Received: by 2002:a50:c34e:0:b0:55f:e704:85ce with SMTP id
 q14-20020a50c34e000000b0055fe70485cemr158201edb.3.1707231421249; Tue, 06 Feb
 2024 06:57:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206131147.1286530-1-aconole@redhat.com> <20240206131147.1286530-2-aconole@redhat.com>
 <CANn89iLeKwk3Pc796V7Vgvm8-GLifbwimPJsDTudBZG-1kVAMg@mail.gmail.com> <f7t5xz1k5h4.fsf@redhat.com>
In-Reply-To: <f7t5xz1k5h4.fsf@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 6 Feb 2024 15:56:46 +0100
Message-ID: <CANn89iLjHcLGvvRLVBnmk7tXXgKagS_t_VnetWkjs=0rhKtnJA@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net: openvswitch: limit the number of recursions
 from action sets
To: Aaron Conole <aconole@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Pravin B Shelar <pshelar@ovn.org>, 
	dev@openvswitch.org, Ilya Maximets <i.maximets@ovn.org>, Simon Horman <horms@ovn.org>, 
	Eelco Chaudron <echaudro@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 3:55=E2=80=AFPM Aaron Conole <aconole@redhat.com> wr=
ote:
>
>
> Oops - I didn't consider it.
>
> Given that, maybe the best approach would not to rely on per-cpu
> counter. I'll respin in the next series with a depth counter that I pass
> to the function instead and compare that.  I guess that should address
> migration and eliminate the need for per-cpu counter.
>
> Does it make sense?

Sure, a depth parameter would work much better ;)

