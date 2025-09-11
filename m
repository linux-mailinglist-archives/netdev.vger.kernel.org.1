Return-Path: <netdev+bounces-222227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24334B539C5
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 18:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC78817C228
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 16:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BCC35E4D2;
	Thu, 11 Sep 2025 16:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4TJyvVti"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7463935AAC9
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 16:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757609930; cv=none; b=k/CbXePMQ2bp9IopgJwUl3drK6xa8pK5/aXWwnxYhzCCFGviZDc3F8NpBM6CKkulxUPQWvHihdrydq47qDCu/1v20JoudPzKkiBmjs/HA+pocjLqo8Mzp49NtyxxuRh7oCftsVVr6v/y4Try0VQrZ4mhUbs17dZNjzCvjWw65DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757609930; c=relaxed/simple;
	bh=uuS7kM0qrhhOE9WQoHsDnU7GgQRh55z0DMsuBkHdjns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qXa29csDlIz/AHeyX9kXVuD6ytmnh1Z44dqgBKvhB8qZw1V4sgJtf0hoxF4Hb6Db3LLHCzQ/7W7aRrw2hXqbNhyJfNV6VXZ97mRjYkP+7YTDwOWz7lJYSj31KdlGRictGLe25O39N47sLZJc/oHY1PVNLdBPdjRRCFX2/vOYl0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4TJyvVti; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-621b8b0893bso1338668a12.2
        for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 09:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757609927; x=1758214727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uuS7kM0qrhhOE9WQoHsDnU7GgQRh55z0DMsuBkHdjns=;
        b=4TJyvVti2kCXtcW8PPQROyffAHPMGSYDI0F0Pyra2yKq0pq+do4IxWy37nzsiMe/CO
         G7QPfUYIoeTOSCxohTMmTXT0Iby0hA7oNVkO7Tj5G/lXwdM8iwlwcqjYcGrR+DbqO7oV
         c8RFxAczMynBtv12XQCdXa/42aG0pT+83nJr7KAekOeM8eNReps3cYm/cg0//YLsiptc
         Nd5heBqXrwODyjq0NrfA6ntqKHjQ5GsTVByQMdux81pcgJ5N0Es6XPC4wbvUJWm9LufF
         jmUwhwPn2e89FHOQVyznqkxWukTnJ642FesXRcZhdPLJdjEO6UeM5+o/H2c7X9pezgM1
         UdyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757609927; x=1758214727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uuS7kM0qrhhOE9WQoHsDnU7GgQRh55z0DMsuBkHdjns=;
        b=US+9GvNbf7z1sVssJVfllnvXQcToiQK2+s5yQpUaAHSiofqWlzyqePSKssa5PfKKpd
         dlfsNgQ0JMkAnekw3tNS9W2/ht9yX+ZboJoFKhdGCahZ76HvkVvLEg+YR2kOiFTePu/e
         fR/4nbesiqNZQ5lb+jvloZhHPbrulRDhnj0YgQgN2ti+CfCVYGxDnlgdz9jDBNO2L2aI
         77oD2zq26AE9xWaKhraCA6vptgEXXUrGB0eKWRP0WHog9Hk81vMek1JM3kif/7hc1STj
         Eg+BXxyIbvcwG7cCZBb4sGhFZDWJcEABsZ9m1czCXADufFBChRS+zgUhEezbeZYqp2g3
         Hu4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUsIV1lsoTuEnRpaqveMiw2yO6Wq6b4GF1K+6FBDYaYhwrBIgVUHZO5cE7p8M1TeX4l53x9HEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YweoVniAaFcQFwx+NVXw5Wxx+dmIbdMoFTtoAYvwncmIWuKoTr9
	m2FTuSiF3zA6rZYryNBVxX/4JVogiQ2dfOKzEAYNlt/xnJSL5BEKXSDMq89lgLk8t1jiNiDotFF
	XZPE1JWlYh3aRa1J+p3zUCgO9VKL4nWI6C0UcDP34
X-Gm-Gg: ASbGncv+HvEebykqNCUew2V30HsUmW1XJ3yYAZJA66niTI3DGjEYCRJ+YdcwNfdpdJk
	UGUKB5XQ2/DYtbChJe5lcPxfDav2vOljGvXZHE8Z80QV5EnyX2VdEO7KfCaFR/far/3dM6+8gmc
	2fOso1wg8vDJF1FXe3BWgd20M2oVKY0YpIuPxb/OwXlBlqb4hKFmuSWwCoG3DW3dx9yEMYNBjrU
	13QI1BtZFc8TKdAm7zvWCQ9s6YG8LKzLx65J6MxiM9sci9n27rLZ471mg==
X-Google-Smtp-Source: AGHT+IHySNAyyKMFFuqPgQ3lZg5IKnbRbeIYOSmwwVAwNd4Us+WLMDzGhJntk9cdqK3RvCETHLV5I2R6kHg7pG1XnyY=
X-Received: by 2002:a05:6402:5294:b0:627:7d41:9f73 with SMTP id
 4fb4d7f45d1cf-62ed841e6c9mr246695a12.37.1757609926441; Thu, 11 Sep 2025
 09:58:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911030620.1284754-1-kuniyu@google.com> <20250911030620.1284754-9-kuniyu@google.com>
 <e4e2a47d-f653-43a3-86ab-f958264449ad@kernel.org>
In-Reply-To: <e4e2a47d-f653-43a3-86ab-f958264449ad@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 11 Sep 2025 09:58:33 -0700
X-Gm-Features: AS18NWD--Xa7ufioloZ1g7vNBkjl04sgMpP9PsxLCIjF8DqC7-OENbAwThAHVig
Message-ID: <CAAVpQUAvDQdodvheTKmRE6HiaBLHELpyc3jfbHPvxFiJ7jE9mg@mail.gmail.com>
Subject: Re: [PATCH v1 net 8/8] mptcp: Use sk_dst_dev_rcu() in mptcp_active_enable().
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 1:48=E2=80=AFAM Matthieu Baerts <matttbe@kernel.org=
> wrote:
>
> Hi Kuniyuki,
>
> On 11/09/2025 05:05, Kuniyuki Iwashima wrote:
> > mptcp_active_enable() is called from subflow_finish_connect(),
> > which is icsk->icsk_af_ops->sk_rx_dst_set() and it's not always
> > under RCU.
> >
> > Using sk_dst_get(sk)->dev could trigger UAF.
> >
> > Also, mptcp_active_enable() forgot dst_release().
>
> Oops! Good catch!
>
> > Let's use sk_dst_dev_rcu().
>
> Thank you! The patch looks good to me, but I also read Eric's replies.
>
> If the patches are sent to net-next, will they still have the 'Fixes'
> tag? If not (but I guess they will), could we have at least have a
> dedicated patch to add the missing 'dst_release()' please?

Sure, I'll split the patch into two and keep Fixes: for the
dst_release() one.

