Return-Path: <netdev+bounces-213181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF07B24037
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 07:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2241688224
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 05:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3F329C325;
	Wed, 13 Aug 2025 05:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l12r3CxW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0582285047
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 05:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755063228; cv=none; b=hV5SV2aELKMbIJsbiCZfvXNpFCxcCMHC0ffNKKUZ91C63d5lz08WI4CidCtKqAUQgaW/tVmfjmQKEpvpOr5qZ/sXD6bhLjH5AEpx7q8b2ZEnEW3VRR1cTN1xtnor7NGF2b8EENwN0wFXBmL0nIHuDS8rfvFF4ywDNpW5QPDdR+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755063228; c=relaxed/simple;
	bh=szl39VgGc6cHz9GvoA3e/6o6qymzSMMd7iMeLQXVQXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JpJIOEfjP0VfEk915jVnDYBeGgbsuzl5rpB5Cdsohaz4UYaYntyVBThlIcWBow9j2vuM3IR7cuPRlHr9aFOWA8ynSvl/3OerQcS2t8do7Ti/SfGvTw+MK/vu11xJAbjricyFp9eQfhfTGHsiE8/x3bIKrES5HIXoG8msxs+pBg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l12r3CxW; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-242d8dff9deso37594185ad.2
        for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 22:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755063225; x=1755668025; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=szl39VgGc6cHz9GvoA3e/6o6qymzSMMd7iMeLQXVQXo=;
        b=l12r3CxW8jNYU/KA4zV5W8iEd7I/nRrUvF4V2wp2M4dIA1gSEhSlsyWOgFe9j5dNoT
         nL7rsNGzdgPQHErtlLec9pcNgWhiipb4pYoSTdgF8ht2AUbGm3q+zOKeZacdIjALJA2W
         9/ybOGm0WFbMR2up9hT7xXCM/4pEWIoXkJG960jjpcrFbpC0AyqAO6p6U3xapfNDGJ6o
         trqfx81MRUrB3mQopRqAkyIFHGiLGVTGmEKVuXJKgr7LO1DQESB/623IphoEKlz9+T/y
         j7oySYUXBvbQuL++gKNXevboEh+bClD2vH2JhS2IOk9prfTiQjsyNf75sYJtcTl++32Z
         e/jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755063225; x=1755668025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=szl39VgGc6cHz9GvoA3e/6o6qymzSMMd7iMeLQXVQXo=;
        b=KThK22R+VCMfpXFtg/HztdFOsxG9ix1Iq7XAbrnHEozUoJPjRmIWm4lEDwFEppY30N
         uvWzfqELgHoEuz03j/cwWvpx9km3LP6bvMOlBOeWw4/SuZbIElYGXYxNnOSYXdX83aXe
         sZ9fhrXQd93HaRkIM3YwdRnYZE/kfsl+bARBUnm9UvbZrxHG5raAy+A7THUdc335ov0e
         Lu4VQRsg+1lHU8IpiwKQGAmDsdx3+4mJX4QAZJTMUJ7FROa5h87odDAA8UOrPlQAiFHJ
         wdopLmyFfnHlGYnJOKSc2ml+O0i6RGD4WTYm5/tOb3QkADQ4z2+9H9CkfQZQQ+XA1pD1
         Pj4A==
X-Forwarded-Encrypted: i=1; AJvYcCWm/82sPKsG+QM/dxYhl7YLyOPTKwoMYGtfWhYx6Bh0apWkd5xxgkEznKZkk4td35mKVyVBMXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKK67pJXGJ2Zh7gX30d7HtvDFfjZpwcYb0eNbY6LTmxgPb/uFV
	Fcdv1hGW36AxQXdRwEtA8aioZG+0GdMMo1PmB3sqhihoWAptkI75QME3JVAV1oDFxQGwmXuJDmA
	9ApzWeEwtrUywyMZgBj9BlFJDN7/RThCmocl0YXLH
X-Gm-Gg: ASbGncuMfDJoGGPnHT09hrd5XijOaKi8WtUMEz7kOalYSYBxBVtJphDmKFhOq6Nrv0n
	0yvAoAH+1Gc5Iw2u3J7kQPVVOfNNlhQLoZu4aj9WuqrWQb6zvdQWZndiuefe2eRy/VMfDKoZO9O
	DODd3pMYVO5uUn0tA7iU8dXYTvf7N2O8ngMc8S9PuFuKmh+GKS3JzK1013iVcca5Ii/moU23qA7
	LaOBMeDPj1D1ibZ57nd0iCS2AKHlFx/G9hVL34G
X-Google-Smtp-Source: AGHT+IEvhBqfIBgz0Uy2LltljSmLkoge547dd8TrEfVD4oSiAV8QynzIkXQpbdt7iwRQkewsj68bM9S2qDwCDc6MSfA=
X-Received: by 2002:a17:903:3c2c:b0:243:597:a2f0 with SMTP id
 d9443c01a7336-2430d108278mr26839105ad.23.1755063225019; Tue, 12 Aug 2025
 22:33:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811215432.3379570-1-kuniyu@google.com> <20250811215432.3379570-2-kuniyu@google.com>
 <20250812180256.712d316b@kernel.org>
In-Reply-To: <20250812180256.712d316b@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 12 Aug 2025 22:33:33 -0700
X-Gm-Features: Ac12FXzyccBeDCNPXTyJcCxO6QF78T5PTJcX6Dl3w2G6b5GiIiaXz2LTRSx3rTw
Message-ID: <CAAVpQUADmTFY08hm2owgb7NdJMBgzwQYE-qWN67TB6+eLC7HPg@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 1/4] selftest: af_unix: Add -Wall and
 -Wflex-array-member-not-at-end to CFLAGS.
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 6:02=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 11 Aug 2025 21:53:04 +0000 Kuniyuki Iwashima wrote:
> > -Wall and -Wflex-array-member-not-at-end caught some warnings that
> > will be fixed in later patches.
>
> Makes sense to enable the warnings first when writing the patches,
> but I think we should commit in the opposite order. Fixes fix then
> arm the warnings. I'll reorder when applying.

Exactly, thank you Jakub!

