Return-Path: <netdev+bounces-199300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA99ADFB49
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 04:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2307F177BE6
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 02:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A051CBEB9;
	Thu, 19 Jun 2025 02:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f//SZKdr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEBF3085D4
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 02:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750300640; cv=none; b=Bi6L2H5pH2czHmTlmgMBCtLV1Nj/jaQlW7px3WXJI0+7o24wM+MTz11I66WwB3V7vsV+ZiUVeDaFsoJ/QGTCnN/Vh68Eqk9eiV116s3GtKmhSW0ArowiaugbIAFe7pv8iwh9RfNFJVRqU8cripfbeNNbDKy+AlpP8kVhrR0SgXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750300640; c=relaxed/simple;
	bh=7RwdTXCgYu79I95wlvoCXOa11d07fc/0jrB5nJuuEHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hLxwehBn13RS3YfgVLDk21dfn43Vvny/H90TluxnzAJzDymrD7lghPAHr6xx5+ucuUiuGIbPvuMj9rAQw507EIKWT+D4RVszo3pPxH76J5M741sm/QmXfckVMTKCQniQ3CTeuztoy+rK+UKsJoo3PF9qK7UifK1tZbwqY6Mftoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f//SZKdr; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4a58f79d6e9so3462251cf.2
        for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 19:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750300635; x=1750905435; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aum1L8JhI6F/2p7B5XtWo0RvKmSbz6dUOzpTeERszJI=;
        b=f//SZKdrKkusgDgLGtH/mOFLsrpllTzquhYVDatz5OIgZ+YhMZ0ZJoHv1xltfwMVZ2
         4qLNWztv8VOjsrzJa6Yyd6ImD9aYYj4wimzInyd8zoVoZ7zZSAmUhLLcSGo5I0f2K8ir
         6f9HClkIm2Kcn9j0YfjC6i+V9b8gkOdAEzxGTzfJEEAZlmzHww61HNg1GinshlL+tQwx
         +lq2nuCFegK2Rk/6S/LZdwaGdTFzIqUTioIF3ndbFl0nx6S61+Z7pf+vn491MZ1sMcyL
         UQqOkDoQVDMoHanblpBAIJRiNIxv3T+g0hY7SDWdgvuiyg7xulDYBMgF/diSS+IBBhxy
         mLfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750300635; x=1750905435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aum1L8JhI6F/2p7B5XtWo0RvKmSbz6dUOzpTeERszJI=;
        b=KpyEOPZMEYsSGn5atJevKgDR20f1jpoM5UWSUocQLpY9pmjAvhF5PI60MOQAr6g694
         cZzYAVwAOeVIbTetRvUT1DNM7wGnzodVTZDCDg+SnjdB6aE68NMjqFNz3Ii54QRoiIEz
         5tYyKcym+7J1q8eulH8V7EDXMzfZj/MruiAdcARibMwNXqeJidnRZoBfyZHEfG14ri+U
         q/BPP7y6ne42NTiGk0KdEhbSmR8w4wKBv2eYzs3YZl/nY8bcaKShKbvZFUAelftKX6yr
         LXFRvccAhkzDaRmjfU4HkjR3OdJsIfDf7M/j3Do0p59xq9c1sSTWuvVMS3LkxWFUx9SV
         6SsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUytx92bcrqiZ/axSbqYNbfIuprgUROGKDeOuC8R0nvm15w9gJY/anUmQzFjjJ47YtO5vS6r+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCf/2HYEormws4ElDBRbg477PZBWN6dzxhh5OM/yliVkPAECnV
	nS6D5vOLSV/Pt8kjP/ofwG+1W2Bb7iHUTQwSmpXgPfpTAkOyTh6T5kqt7c0G47FvXiXSWqiYaQb
	CVm6cGlJfez6VTJQ8eNAm4gagdEWgWMv5WIdX3LUy
X-Gm-Gg: ASbGnctH/qfYYjM5+OYMrgo1lpT13n86BRZhc05deUd812HQvnzMaypS45DDnU/sdZw
	FgwLOIvAqnt5AMENekANS40c53Wa9z9w6Ljz4RiEePXQ1/+ReLG0sFpgLMpXxfIh73keB8PLhs7
	gPFE+D5SsB3RYW8qrE2gowBa0z8LgR9T01nfaEaIGShjPy
X-Google-Smtp-Source: AGHT+IG1Mcyf4FUCKEDBenxHYYJYLoypgZcOZXaV78vHllkyMvKciPZtwhkNavnaP/WXHcJmzmEkjhKBWKD+jyVPBmI=
X-Received: by 2002:a05:622a:180b:b0:4a7:6e64:ecae with SMTP id
 d75a77b69052e-4a76e64f2a7mr28283041cf.30.1750300635355; Wed, 18 Jun 2025
 19:37:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618140844.1686882-1-edumazet@google.com> <20250618140844.1686882-3-edumazet@google.com>
 <20250618234338.GA2863787@electric-eye.fr.zoreil.com>
In-Reply-To: <20250618234338.GA2863787@electric-eye.fr.zoreil.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 18 Jun 2025 19:37:04 -0700
X-Gm-Features: AX0GCFvpqcbMcN--N2BgLt5GkisQZOSBHU9nhXQCQQBoEzlhpN7tyBnHFhTWshw
Message-ID: <CANn89i+KR8AOeLqmXa-dbd3Vv6wWqakv+krd5+c0BUfZ3QSAZQ@mail.gmail.com>
Subject: Re: [PATCH net 2/2] net: atm: fix /proc/net/atm/lec handling
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 4:43=E2=80=AFPM Francois Romieu <romieu@fr.zoreil.c=
om> wrote:
>
> Eric Dumazet <edumazet@google.com> :
> > /proc/net/atm/lec must ensure safety against dev_lec[] changes.
> >
> > It appears it had dev_put() calls without prior dev_hold(),
> > leading to imbalance and UAF.
> >
> > Fixes: da177e4c3f41 ("Linux-2.6.12-rc2")
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> >  net/atm/lec.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/atm/lec.c b/net/atm/lec.c
> > index 1e1f3eb0e2ba3cc1caa52e49327cecb8d18250e7..afb8d3eb2185078eb994e70=
c67d581e6dd96a452 100644
> > --- a/net/atm/lec.c
> > +++ b/net/atm/lec.c
>
> Acked-by: Francois Romieu <romieu@fr.zoreil.com> # Minor atm contributor
>
> While moving proc handling code from net/atm/proc.c to net/atm/lec.c afte=
r
> seq_file conversion back in september 2003, there was a misguided change
> turning:
>
> dev =3D state->dev ? state->dev : atm_lane_ops->get_lec(state->itf);
>
> into:
>
> dev =3D state->dev ? state->dev : dev_lec[state->itf];
>
> .get_lec included dev_hold. I didn't notice the change :/

Thanks for doing the archeology work.

Indeed, this came with this change recorded in  (
https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git )

commit 4aea2cbff4174dc81a3f7f8a0e07fea75333f8ff
Author: Chas Williams <chas@cmf.nrl.navy.mil>
Date:   Thu Sep 25 07:15:41 2003 -0700

    [ATM]: Move lan seq_file ops to lec.c [1/3]

