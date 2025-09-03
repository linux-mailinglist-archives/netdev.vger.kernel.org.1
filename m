Return-Path: <netdev+bounces-219606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 666D0B4247B
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 17:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A854C7A6478
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 15:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E536F31A548;
	Wed,  3 Sep 2025 15:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aKRpV8KM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5686531A064
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 15:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756912158; cv=none; b=NIwzZehV22p+mC4wfhiGcNmFVWYjuwZj74Hz7e+9ieqaC6dSCqPD7CrMU2ElBF50SDclcdfuodRSpFzPssxVv00SR9x67aGcYnf7VM71Gz9wM80CAs1LI4QMbyZPHovSZZfEpFqnMkO1E1/qCMRo0ccLKHCfS+T4/NK58HvKvaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756912158; c=relaxed/simple;
	bh=5Pi5QXZ6QGDAB9hteXIIJvF9tuLN07ObaFkC5C/BRh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tNUBdG/5BeASbVWx+5/dcIjP4O5H11QW4aUvLgVXGmXn2gZO4GtKptzwN4r4jsgQJph3v/tW7tDfDk3fqF/wyQCWeqn1aIII15zO1uK4UNFecqsnFuN7v6h8cklt5w5X2Rvjti7UZc8hVmOtgB3OCjy8m84GAz2GKh9zpUpUVRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aKRpV8KM; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4b48fc1d998so318021cf.1
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 08:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756912155; x=1757516955; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Pi5QXZ6QGDAB9hteXIIJvF9tuLN07ObaFkC5C/BRh8=;
        b=aKRpV8KMvor4oQ4AWPdKD7dNKhJ6RD/nmg12gf79N6GkKlQkuHqA87rnKliDMRNRHt
         6lBvrqTB2RyBaYHjz08rKA6OF0NYkduclu/Yd8s1KnIVgql2CvFg4iM+lL96bXAgvhmS
         IE8zx+zZWgoMeFcBEvc+l+izlILeAG0mCHOh429aMYrCe7xleeH5k+V6qIYdoIuQ91yQ
         NOxZqiOVtTKef3T5eg2PleEKLxrK8/vOUA8MKFNAPy08+imA8LCOPn4mcAeTvaRHbsqb
         nGTjpJ0jdW8k5a1qSAn76Il1V448ZtSMBYx7M7E7xD0uD59mw6yW8f41CGimMMxHlz2u
         UKag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756912155; x=1757516955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Pi5QXZ6QGDAB9hteXIIJvF9tuLN07ObaFkC5C/BRh8=;
        b=TBPYpa1Gmbi52v76hqf+GmpS9HAhB7WEGCyW7kbjEoSqWoegTrIMiy9Py0FtI+z99N
         E9tdctp1l8w5FwyJ3hvLvNofK4Si+K6kIUOEjdTG0rSsweoLeAEyannJ63YWoEg2e7CG
         gtp0V68hkxPXdR2MwI2/FtZ6MGsvICcBxxZnUR2diIHE2pbLt1TalTxIT1Jos+eRQmcq
         l0Cm4sBRzrcJE4gqB3TYb42XGJZotqvhbdOIdOKyD38RFJWFdqKejfMMjfT658nceKXr
         9TylpEVEqNnjf3Wf0zi0CdGLSdeexF3aJ9PalUHvqOQqUGUUybRdpASO6+ZzgWb7++56
         kZNA==
X-Forwarded-Encrypted: i=1; AJvYcCU82ij97G4ZamO02SGjJbkqvGZgWEw9ndpLwm+ERjlnwgwTU7UIzfvdZyVEN3SrQgLpKL+L/VM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyemF3bR2DdDkUgLNLA9XEwI5iaVka2xwCE2lzy6bUXgO37499F
	Peo/iHgK+7UjMVBUETAc+UlVfZD11qkpfIAnbYI2OYBR/12yfIKZyMuW44SGJvihl7YNvUVdfuV
	fBhQWBLzqDkmy7BbnZcr50JcSBjvdTKnhMEZ80wDB
X-Gm-Gg: ASbGncsqNXbE7gq67moOp0aVjBfHBhhEYiPMpn1r30x7VwX4arzbfcfOfdM4ydAcvUS
	vxpFn5sEt1lZFa9U9nqYSzJ+jEV6a2zYeiEWyITLrlGqzmoN0sJOLOTmZpx1srPNKt9AFTaP4Op
	VoDKF9iilRCgLfmQP6Ybm+4WWR4EnjNsndknqL/BF/e7kiaj8BvdE0n5CB2YD/wtIN9puFAaNaj
	fOmda4HdsMV19GEknviFRSx1RnIgRii31eLZ9zA0IWlNQ==
X-Google-Smtp-Source: AGHT+IEePtByKnJ8fuj1lBqob92SnvG9Zn0jVINd+g+TU4F6mSjBEF4M9DLJuSJzVw8KIbPlHVMa2jK84licwpuNrKI=
X-Received: by 2002:ac8:5f50:0:b0:4a9:a4ef:35d3 with SMTP id
 d75a77b69052e-4b31b2aaf5dmr22032991cf.7.1756912154880; Wed, 03 Sep 2025
 08:09:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903084720.1168904-1-edumazet@google.com> <20250903084720.1168904-3-edumazet@google.com>
In-Reply-To: <20250903084720.1168904-3-edumazet@google.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Wed, 3 Sep 2025 11:08:58 -0400
X-Gm-Features: Ac12FXxPEY4me02TFOd8lOdMKXQL5AAtiU-E3jLerXdXjhcOnsL4wbl4BmOi-zg
Message-ID: <CADVnQyn-=hBRJ10L7AapP4nuZQ1x38B=1+4+KdQgt0kDMo8MXQ@mail.gmail.com>
Subject: Re: [PATCH net-next 2/3] selftests/net: packetdrill: add tcp_close_no_rst.pkt
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 4:47=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> This test makes sure we do send a FIN on close()
> if the receive queue contains data that was consumed.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---

Reviewed-by: Neal Cardwell <ncardwell@google.com>

Thanks, Eric!

neal

