Return-Path: <netdev+bounces-166572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7F0A36794
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 22:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 668E83A9969
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 21:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215AB1C84C7;
	Fri, 14 Feb 2025 21:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uPvf86OS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD151B6CE3
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 21:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739568688; cv=none; b=lm5Q1HifTyPuDR81+ctoyp5jDwq1zA4aq513Ed7pm6m8sOD/MKuAq3pngmaxYNhvj0AY5OG23MDpmk/53aBxjqT/Wd6j21zXMVCRhdNShwXiaoOYZllfZ1ldP0tWEw518wnJ00F93ejt9svJ+KVIxVdg4TPjAIUj7OdtYXZD0ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739568688; c=relaxed/simple;
	bh=mLhP6R7YWweXcivdBY2A/XcxMZzJHLZpLcuppCA2RFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LUP1YExPr3iFk96Q4wx8cMfGuSj2zfjYH6oaJyB5pukdzuqzSc2fJZldYzcTtixs1d9X8tnGcKfWmQzqj+THvBIBGmrVLhtgxQHwYnNl2OVV06PL4Ppu5PQ1T9jK3BqIjw2A3MDduDhcoNdrItGfk2IM6c6u6Pa71u+w0WVXcas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uPvf86OS; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43961ded371so3635e9.0
        for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 13:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739568684; x=1740173484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kv8U7j70PYl5cfn7kqcF8bcLjjHho8xoiNVAdIBE/us=;
        b=uPvf86OSD4Sln37IbyK8VfJWmy/C2PERw/N1SgHPlB/eSVL70TiujaLWtLfiDBD9ou
         0x+ockJrXQjiF6eqyTgGKVUmqhTkyFjqVRjKRXseW4guGWtUu7+7MlPIFLHT+uNBYxP7
         /I2yUDxHNGRJKiflwTE916gq0aclBO6cbW4acU6IjNmCKsFNpYTuBoTWhBcfJ0xpqbNe
         cvyhP60qjPdyUPyWSWhYi/pHS7uA6J92h+nzbuwxU+p9vbW7pDvDbtEUZr+eJqqs3IGE
         KYMhwi2zebZxhw5K4EgDQVC8pQzzKuGl/GTAj7rmU5jlSk/BkApbeDixilCdETI+Ph7/
         AM7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739568684; x=1740173484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kv8U7j70PYl5cfn7kqcF8bcLjjHho8xoiNVAdIBE/us=;
        b=S0brtBk3qaZht/YLNZK22uD8qhtz82+1+q3iL0+CArM1FjHzlnO0EpxhqE6GJNkt8T
         9BPK0qzANGRCoCAZct0jCXNaUhe3Y36oc9xagxy5RdTBAmeXsWLHM5hrGHBBim8If0ug
         5UmX8TnD0bjGLstpH6jjbazHKvs1lojAIGLIwOR50zuYGiz2VBi3KuZQRzvtMdamMdTn
         MqqJklcHzXeEy1hcYcmtAG2mQGS8tAiwCGBCzCIfmvuDFpHIwp+0po23uwVLWkXhxsqY
         9wpBjXpx6nfrbYlYfiRlhr0K3zivgIbVn0ihmb6PAkY02dZbtCCZO2Ju5aWBrwDpUW21
         NGfw==
X-Forwarded-Encrypted: i=1; AJvYcCXru294t6k5z8L+UUXthdWg3fKdwageqOYQEKdiKB6PFKFG5cmiS5OxDNSbnlWEXB/MD/LsmN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX7NqhJxttyyEp+eSbd/aAlvucDUaqo7cws8RshtFfMKKt2M06
	xw2VpeijjXGSxCl/nCQKFvaZ5XoAywSQoK53ktOh7F5hVvsbrZQKXPRIQ00+mbtFVvR3aiMNWQR
	TUkd7+577k7n3p4zKaAu/YCO9frqh6utO0qRr
X-Gm-Gg: ASbGncvEqQejbEerLhUO3QS3hw6jojc6RvZOIwizjZqSKkxwHng47d6YwgGxTMAcEtG
	Ok6GV2xPBdEPCERJtJSlbJEFV9lIWKaxy8Po2/tBo4yB8ob9kyVrMao5HBDxygKwDoDngWdzS
X-Google-Smtp-Source: AGHT+IEK5yyZkOUI1LdXRYdP5pBMBB5iDuQQ9bNd8GUAtdFrryUhxDCgy+XApzPbMetDkTKaDQ1WTRqmmEgbnhNEcfs=
X-Received: by 2002:a05:600c:4244:b0:434:9fac:3408 with SMTP id
 5b1f17b1804b1-4396f3cb4edmr232045e9.2.1739568684540; Fri, 14 Feb 2025
 13:31:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213233828.2044016-1-jeroendb@google.com> <20250214063845.5a9d2988@kernel.org>
In-Reply-To: <20250214063845.5a9d2988@kernel.org>
From: Ziwei Xiao <ziweixiao@google.com>
Date: Fri, 14 Feb 2025 13:31:13 -0800
X-Gm-Features: AWEUYZmMPqNoQKJPDtSpSUFyp9D_ysdQIyAZtLuNMKzE8f5Hl1iQqi2-2GHD0tw
Message-ID: <CAG-FcCOK36rYrf10iMp-B+j97skuwF4tTDOjJup2Sg=OA_HRNg@mail.gmail.com>
Subject: Re: [PATCH net-next v3] gve: Add RSS cache for non RSS device option scenario
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jeroen de Borst <jeroendb@google.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	willemb@google.com, horms@kernel.org, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 6:38=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 13 Feb 2025 15:38:28 -0800 Jeroen de Borst wrote:
> > -     return gve_adminq_configure_rss(priv, rxfh);
> > +     err =3D gve_adminq_configure_rss(priv, rxfh);
> > +     if (err) {
> > +             NL_SET_ERR_MSG_MOD(extack, "Fail to configure RSS config\=
n");
>
> coccicheck says:
>
> drivers/net/ethernet/google/gve/gve_ethtool.c:915:29-61: WARNING avoid ne=
wline at end of message in NL_SET_ERR_MSG_MOD

Thanks for pointing this out. Will send a v4 patch to remove the `\n`.
> --
> pw-bot: cr

