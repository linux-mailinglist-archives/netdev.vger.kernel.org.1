Return-Path: <netdev+bounces-135178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD9799CA29
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 14:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2DFA285181
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 12:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68BCE1A4F11;
	Mon, 14 Oct 2024 12:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJKWJRNG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FE31A4E8A;
	Mon, 14 Oct 2024 12:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728909060; cv=none; b=nfWLTLlZ8+qWdG7QSZd7D3p+kXa+omVkc9L5DkHrrpWT0mxmWHFnEVkLoooXapUt9p3yY2jywgW9EqtLAIIAMgMpLeMQl72AbrB5iGJE4/pQwHc3AhxY0zJRbo/rZSW+7o/WxqPQmbu10tfBO5nn8tB3GN4DKbkkyJYm4rMi9Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728909060; c=relaxed/simple;
	bh=pHECoy3/r9XXzpDOOuZYAKk4VzIkq3Z702n4d5UrFMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e6imMM+Z+ghfu6ten3i7YWla4wwgMAR7cDFyUhGNi0Su6AZnIBmUJohjcR5Z6BB7wyqf4xLU+/3aDhaTksWn3pRlXyQYBOwQWAos7reMzD8FKPysgGCDOm9TkQVcHs7HaJzjZm+apPTAUy5Ou1G5XBdnaJGUNGK6ZD92aJUqtdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJKWJRNG; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-6e2e3e4f65dso36788847b3.3;
        Mon, 14 Oct 2024 05:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728909057; x=1729513857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M0dC5BuFU28/f2J/fAJcT8u8dNYYIjtMKBLL/kYiXms=;
        b=cJKWJRNGsjrryEGe0+xC6wBqWbwsyHid6M3ekrnJ1A4Lo7UiX+1/AY+Nc6lbKrPbj/
         KTFEuG3xO64lEtb5z6y5Q4ySPu7Q9Pg865mW6PTuP8crO9YSerZHf1/YNGL26oONnE9y
         r9YHejxLiQTS1wQYDAoBrDIS31KgK5zKMoT1ZK87FPTj833KDw2DPxs333+so6obcO0l
         D+FcEwSHP5f0nMvlGCs+pXL2HfJxjs+Pa9+49yQwtMa2COPAnTsHauIOBdaTnDuAVP52
         InyR0ObG1eD2GON5RCVrFJM7DJOuNbvccOKMBzf4TGDiXswbjjpSbpMjjFfYvS33LTrg
         Gudw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728909057; x=1729513857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M0dC5BuFU28/f2J/fAJcT8u8dNYYIjtMKBLL/kYiXms=;
        b=IEcANQoE+y23fUlQl/Wy3i4345/BIvmR0FBfyMjm2UEccWiwCSMv8EX3NsKGODp/fa
         GOE39ulVMvqw8EIoKNq5bjTGK0U/mMbPyVooT0kjONN9cYefP1zRzVfD0OBPS9GUGroT
         /Rl9XWc86NLtQMc0obQsr3jB33z4pViuxo3HHBc05j4ejdoAIBmT/N4jenvr5xRxiY/P
         TpxvTAku8w62lmVd3mk7zu81Osw0l9j2vYi+GUy1PIG6jHHW+DxNI1F2SkuYEj7FUKZo
         0x5OxJhpTQcDvGq28gP7sgJRzOkvRwE0xSUx6uHc57cWpq2mPzQl9e6i2AgYuJLE1Hk0
         WJDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxmnKw34RGW6tnv0Zrhg2g7IyYc9OJDLdl78Yz4JCGIKzvyHR7UHT3im99tODIOs3glQHxLeyR@vger.kernel.org, AJvYcCVqrfJ55UCA6c+I4+u7F8hbPju0yvSRRYt1kqvYvpam4sVpRRFkCDt/EteL+jd9qnFYheV285Zuher9wk4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU8qwywYxgF7dw2VpHhwzFrO2d0nfcEnSEvJVG9zyzrQWeYhU5
	a+TY3xAnnnYD7PrcN65JKDxXeV0DnBKDbycmKdonxZqO1z7iA/EibipDhxEL1cQD7cI7bQvHgeu
	IQlnavZz5CsXH0TN5jeUAVwGvvzQ=
X-Google-Smtp-Source: AGHT+IHd16g5nn1RyWruTrHC4hhTzSkHepD6pSwIfQXNCMzh1LDAgrPS/tLW+iu0r6lafI+lcf6W0Xoitkn+nI3Muw8=
X-Received: by 2002:a05:690c:60c2:b0:6e2:1570:2d3d with SMTP id
 00721157ae682-6e3471e8b79mr89219927b3.0.1728909057646; Mon, 14 Oct 2024
 05:30:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009022830.83949-1-dongml2@chinatelecom.cn>
 <20241009022830.83949-13-dongml2@chinatelecom.cn> <ZwvKEait2FZ7K03c@shredder.mtl.com>
In-Reply-To: <ZwvKEait2FZ7K03c@shredder.mtl.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Mon, 14 Oct 2024 20:30:57 +0800
Message-ID: <CADxym3Z4kyVh2W60ub2QtzcRXHCmFfhmprht0_p_bBdbiJVM0A@mail.gmail.com>
Subject: Re: [PATCH net-next v7 12/12] net: vxlan: use kfree_skb_reason() in encap_bypass_if_local()
To: Ido Schimmel <idosch@nvidia.com>
Cc: kuba@kernel.org, aleksander.lobakin@intel.com, horms@kernel.org, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	dsahern@kernel.org, dongml2@chinatelecom.cn, amcohen@nvidia.com, 
	gnault@redhat.com, bpoirier@nvidia.com, b.galvani@gmail.com, 
	razor@blackwall.org, petrm@nvidia.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 13, 2024 at 9:24=E2=80=AFPM Ido Schimmel <idosch@nvidia.com> wr=
ote:
>
> On Wed, Oct 09, 2024 at 10:28:30AM +0800, Menglong Dong wrote:
> > Replace kfree_skb() with kfree_skb_reason() in encap_bypass_if_local, a=
nd
> > no new skb drop reason is added in this commit.
> >
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > Reviewed-by: Simon Horman <horms@kernel.org>
> > Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> > ---
> >  drivers/net/vxlan/vxlan_core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_c=
ore.c
> > index da4de19d0331..f7e94bb8e30e 100644
> > --- a/drivers/net/vxlan/vxlan_core.c
> > +++ b/drivers/net/vxlan/vxlan_core.c
> > @@ -2341,7 +2341,7 @@ static int encap_bypass_if_local(struct sk_buff *=
skb, struct net_device *dev,
> >                       DEV_STATS_INC(dev, tx_errors);
> >                       vxlan_vnifilter_count(vxlan, vni, NULL,
> >                                             VXLAN_VNI_STATS_TX_ERRORS, =
0);
> > -                     kfree_skb(skb);
> > +                     kfree_skb_reason(skb, SKB_DROP_REASON_VXLAN_INVAL=
ID_HDR);
>
> Shouldn't this be SKB_DROP_REASON_VXLAN_VNI_NOT_FOUND ?
>

Enn.....It should be SKB_DROP_REASON_VXLAN_VNI_NOT_FOUND. I even wonder
why I used SKB_DROP_REASON_VXLAN_INVALID_HDR here.

It seems that we need a new version, and I'll follow you comment
in the other patches of this series too.

Thanks!
Menglong Dong

> >
> >                       return -ENOENT;
> >               }
> > --
> > 2.39.5
> >

