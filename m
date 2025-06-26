Return-Path: <netdev+bounces-201622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2C5AEA147
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 16:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BACE7AD05A
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 14:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD0A2EF9BE;
	Thu, 26 Jun 2025 14:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="siNr/D6l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617C92EB5B2
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 14:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750949329; cv=none; b=BrAl4T2QmqRvCq4WF+etkAlABIIVcFng74HSDtl7Idr/dqsJCwR4nhLgT4wKuqTpE2sZBFKWTa4OUAye2HU6OU1PfjX8PYC4rx/FV4vbvkpi+udtAkG0a6Dhxv8La4WW+yGxI3w/4gM0zbUxeKhZZgCcy4/+KHRBZve1qgqZ4RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750949329; c=relaxed/simple;
	bh=JVZR+Kz46V4l8Wj05V5Umq6bO7w7x9zDle7Z/pTcgQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iAOXslcbESEal3LQ69GrVvMOjNMXlKAizFDfVyuw+xXetHz3diF/wfhNUKwsZKob5XLXfpcKASg25xVgVtFxA4+HxrkqS7B24sVqWfNLBWIB6yA3Y/l5pCJgkcu1mBGjELR7ZM89EUpRiH5NFdxqrj3V0eFXTmVr7uK7gjxe1lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=siNr/D6l; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4a4bb155edeso14112421cf.2
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 07:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750949327; x=1751554127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JVZR+Kz46V4l8Wj05V5Umq6bO7w7x9zDle7Z/pTcgQM=;
        b=siNr/D6lTWEMkkpCKv08RBd+iYuIe1lxNL+nC19EwqJreEHzXFi95GaK0K/R+2dPPs
         RAZrCPZSl/0L7C+Fn7iji6RqaKr7j4SMCdwwuVChapibUZuhdDrbwOcGFeaFcc8AQ5is
         9FVcd0EH1a0ZSsr1T/MJM9DTit9tJ360f1r6euI9BY8HMsa7XTXwrsXYktSShwh7Q/1c
         0TE10vGiykztUf5vpD92oqEr8je5eDCuqnaeySOCTFSQ8fAK+K7xyPKzoHEw0jo+x8wC
         BniC9XMwgpWjOX7uoH2wS04z6RyFYG9ux2EEwEvckAh41wAkYqkuRTun4G2WyBB6xMwF
         wbig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750949327; x=1751554127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JVZR+Kz46V4l8Wj05V5Umq6bO7w7x9zDle7Z/pTcgQM=;
        b=eqnFl2oWAV4DAguDYa89bGEV0GSNRjafdqjms/rPHCOvV6jJhSxWqHvrXa9tQ1RE38
         mB3b5yFF2A+VGUJB8ZsFFbzGJBPExLipeoaf/03Bctcd/nHG4CqaCeBXfjc0yIvzK8cG
         PI+Z6nRCpY65T/x9JPurW7rBYb+20ylbrtlW4+bVvPkR87pmdSrpL4g/OW9V8pJN9G1U
         eAeJLjptwTtPYDARfvP4w6Enr9RWtW/YFTHsFCapFTF9ywSiH1kClVi75Q+6ZC94g9Iq
         ADSqNk48TqYGikKtx50kgHKbu4Q2xQRFpSZLQQ/1JkZZxz8CAJU7/JpKwoUKj1Ki+l41
         g5ZA==
X-Forwarded-Encrypted: i=1; AJvYcCWRg8Q0sqkBjMIZcTC42Tyu+M3NOEscmXmIIv2dJ924/GktourfUebbSPitW31BM4WFov2h6DM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMGwVQD7Ta2bPFo3ikP0k/FREZ3ejee9mzlmA2vAGthATO/hU+
	fkQu/agMdBxHttoE2QYywav9KVz4rj0/0Jewo2T1hmseTirpb5Gik1AVEFLE68sqSYFArbM9PON
	wZAdpQnuqduMH4kd4a5gblK6WB2P90qun+9Y/UbWF
X-Gm-Gg: ASbGncvzDbAJjmIL/lOu6t6xw4gSslwjpmMbQomlaVNnd5erhCo9mq89qp27+QBSryH
	p+7GPzBVuD2Y524zMQo5b0RpsQ0Qed4BcbfZzZFg0S3Zmfbf+jTJeIctyYK6+v/24YSJWO4fqop
	PEv4eQ+XVxQfwVHDVKcVItNF13Ad4WuEKKryzF27l/MnM=
X-Google-Smtp-Source: AGHT+IEQzYsmx3Nxkug/idVsDPJgTkxgHJqlrZZyEcOoXlSKOZVi1U8dXU47tVt8pCQmaqvYo7p3iq00Rwgru7ox048=
X-Received: by 2002:ac8:7dc8:0:b0:4a7:6e83:d1ca with SMTP id
 d75a77b69052e-4a7c05f4a97mr99799291cf.10.1750949326925; Thu, 26 Jun 2025
 07:48:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624202616.526600-1-kuni1840@gmail.com> <20250624202616.526600-13-kuni1840@gmail.com>
In-Reply-To: <20250624202616.526600-13-kuni1840@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 26 Jun 2025 07:48:35 -0700
X-Gm-Features: Ac12FXxs92N4bH7RCDBD_ID-O3GtMiB5-xwuuiwSR9-iFR9QYYnkbbrW4C_BKck
Message-ID: <CANn89iJujjF6=G-2z0_jv5S+wy6qajb80xNy4y5Gp69-msqOqQ@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 12/15] ipv6: anycast: Don't hold RTNL for
 IPV6_LEAVE_ANYCAST and IPV6_ADDRFORM.
To: Kuniyuki Iwashima <kuni1840@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 1:26=E2=80=AFPM Kuniyuki Iwashima <kuni1840@gmail.c=
om> wrote:
>
> From: Kuniyuki Iwashima <kuniyu@google.com>
>
> inet6_sk(sk)->ipv6_ac_list is protected by lock_sock().
>
> In ipv6_sock_ac_drop() and ipv6_sock_ac_close(),
> only __dev_get_by_index() and __in6_dev_get() requrie RTNL.
>
> Let's replace them with dev_get_by_index() and in6_dev_get()
> and drop RTNL from IPV6_LEAVE_ANYCAST and IPV6_ADDRFORM.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

