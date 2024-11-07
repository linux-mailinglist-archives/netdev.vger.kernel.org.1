Return-Path: <netdev+bounces-142939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 384939C0B7A
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 17:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF5801F24125
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 16:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F785217F4A;
	Thu,  7 Nov 2024 16:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VqG0rdcQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F15C215F7F
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 16:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730996373; cv=none; b=lIW8vbzNaV4ryh68xo+sT2i/BAWgCtus+mco+J0cjFfZWXnXRlDaE2MmFYioMat3oXbl+0kpcQ4trkYfsCu27VuWOw6WAzG1efKwvQSbUI5FXnkbEq89B2OZTzbgizjXgY8xXxxz9iXWyXpdl2M+9QymzbwDBI4fBlMT/yGinkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730996373; c=relaxed/simple;
	bh=aPRAYHXEtudIFPUcFgeyrlLIT6LW4k7Bu/Ugt2Hnsg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BNico9Bz+XVprKBHjs3Fdl2WCSf9cMOCPQc4HUmXUV776Md3x8LS+N1z+pvQs4/y+nA2rMUGZQiqKpCpueciiYTrg7otgbVuh4zfhCWBkHM0hSqYLLS8OAt3JfTo4Swao0M0VEjl9bOBEi0TnLo+NDyCp/nmBpq7nk/gRV4lKGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VqG0rdcQ; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c9634c9160so1346363a12.2
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 08:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730996370; x=1731601170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aPRAYHXEtudIFPUcFgeyrlLIT6LW4k7Bu/Ugt2Hnsg4=;
        b=VqG0rdcQ0QY+GQw/zM95PaiN8AsqrIc61PA3eb924OkTc54KLfgMPV3bubK8bULkgl
         a+L3VCdI4USj/AiJglRrEtsJOxROu4dw4+mFy5YqiR8dW8reuL3umArcp2hXfrRCzlU3
         9RWKP2BlXfrcsaWr8He370Vsjqgo9V0N0443UEvfvFzRnlhg1ZSbTXR9bDxo+F+ZVqNx
         pwsyvQv1eH3mgbxtAHYkXFpgS/1iOaj9KEANIbptfgu/Y33rd9gGuR7Dtl0UvuJbybsG
         dPsKf2jbbBXCEYo3PREtn+RuhXfxvzdJ28MrD1TKAHHZvBHsRXkgO2G8gDClb6DU2xQo
         fFPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730996370; x=1731601170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aPRAYHXEtudIFPUcFgeyrlLIT6LW4k7Bu/Ugt2Hnsg4=;
        b=WohbYstBL9EIVMyBdr0HA7xb0Y+M9ivLBzhDCq5HEpU/VM6VqcasPEk1GbOqwDkoME
         /EKTp3QjmpvshhN90Vge7QOnQ9752yLV+8ym5oktPnxQwMCsrgVU6erKhhpIqQjocapk
         oWL/2wfix9+18h+0R/SYgIgJtZum+dKvHjpJCTLBaKvRSmRVnJHbo7ISvuQOHyubs3Gf
         YJ9R7UX1Tn8V2b+SzauRaCgaAbdcSLJnZpAu/yzwwsPLRRLGxZJauOfZqkdrqhNRTJDs
         Q1Q1TV4ZT4EmPx0D5jjLNLY+sARimUCgtZwkCAgcXh56y/7GlxUimPwuzgh5nAkQK8Uu
         Z0tQ==
X-Gm-Message-State: AOJu0YzSZK0K8PQRIvJ3AVf2v1TL+pHVyNPPXvkxYg1ayfgiqwiNdfbl
	uoudl5VKuKhsLQQ/zyyMD8OVO8aqLBfqe3gPOZU099MpOMButjy+7pDusgXZ8a7dg4DFuLTRn/5
	MkT3B17n/WHkPxpcAndFJPOweu53EWFdRORBs
X-Google-Smtp-Source: AGHT+IHZTvN+vo4eiPDgE7p8y2odw+C2NnhniU/nOg5venQ7ODAdJXCbEu8uXGYVCXpMHpm3LZqWUaCE4JhGaY1lp9g=
X-Received: by 2002:a05:6402:5107:b0:5ce:df55:7a00 with SMTP id
 4fb4d7f45d1cf-5cedf557a2cmr10958381a12.26.1730996370387; Thu, 07 Nov 2024
 08:19:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107160444.2913124-1-gnaaman@drivenets.com> <20241107160444.2913124-5-gnaaman@drivenets.com>
In-Reply-To: <20241107160444.2913124-5-gnaaman@drivenets.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 7 Nov 2024 17:19:19 +0100
Message-ID: <CANn89iJL3PD-u9jU-oS2XHrYX6xbvSc0KF=OxzGZj34HtyDdNA@mail.gmail.com>
Subject: Re: [PATCH net-next v9 4/6] neighbour: Convert iteration to use hlist+macro
To: Gilad Naaman <gnaaman@drivenets.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 5:05=E2=80=AFPM Gilad Naaman <gnaaman@drivenets.com>=
 wrote:
>
> Remove all usage of the bare neighbour::next pointer,
> replacing them with neighbour::hash and its for_each macro.
>
> Signed-off-by: Gilad Naaman <gnaaman@drivenets.com>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

