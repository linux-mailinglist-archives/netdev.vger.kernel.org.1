Return-Path: <netdev+bounces-132461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A575991C70
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 05:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8BA02833FF
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 03:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB62C1662F4;
	Sun,  6 Oct 2024 03:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LaxeQs9n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f196.google.com (mail-yb1-f196.google.com [209.85.219.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4730914A0A4;
	Sun,  6 Oct 2024 03:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728186709; cv=none; b=O8ieQlGpXjCC/RuMsTSKxSPZTDhSosXtMoauOUr0t0YB+n+i18cNa1fzLt2xnHe8tVhs+AgrhSZN6mKVmdLhB+cCtvptNGzPGGHSjdEvXVFwhxu9MMiDxAtUQJnc2IGoN347DeZdeBSxHBqwtyL7wkVmVo4QaikJNg430z2J0UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728186709; c=relaxed/simple;
	bh=jZKZ2UO/jNkIH84KCkvT3ekASIzLWn4Ix+KvLPyBI9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q+jFZky1MQXPjoz+U8YsKa/ScTyMYTerMhDGHulGSy4D0BD5SGtDlhUPi3jyOwjCh7DR2Rz0ccZT2VAyU8BtLq0YArLqgJWl7lz6l6KIK++yuS+AhRGlY1TMSJH5DkP3TsSIY/itrzpdPFGMpyHUwd1l+yMzpISbX7RqReA5xoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LaxeQs9n; arc=none smtp.client-ip=209.85.219.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f196.google.com with SMTP id 3f1490d57ef6-e1651f48c31so3088034276.0;
        Sat, 05 Oct 2024 20:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728186707; x=1728791507; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DmnrKeM8ZtCj0YQObsIfTA4iodtEfxZrWAoQnmY7rLA=;
        b=LaxeQs9nlmlOs6W7JwiVshv8B1XnvRITwgrTjxfc0m8BUbMmrrflrNjJQiNXoeXZQ5
         CfxujrZlLTaUqD6YUX/1UC6A3ZvCy0TR2/JwX1b4LiwFyHcyznh7wxII/qqrZ583XZsa
         KEFkrOu44WE4oO8jzS+cqgRVU+SdvTyY2Lv/DC3wLxR7VJmiZGxNchNkKT5hx4fLhrfQ
         HO8pOTXNc1rdIvElm/7RarQNsgtKCM9PLJMFS2iMOyCwrVn+BSZxjT0UKF2E8j3ntCQ7
         RVSqVOmxRh3Lvz2+PQUiw23SxDI8Y+ncoD54OxcOM6Gfbsx0x1+bVJ5RJDNuTlXo9bKW
         wv6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728186707; x=1728791507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DmnrKeM8ZtCj0YQObsIfTA4iodtEfxZrWAoQnmY7rLA=;
        b=kdP6FYvBb8iTfPDW0yYaAgozS2w0SKGJvqaIjf1FuvvmyaRO8iN79YXEijwq9t0Lew
         Jgk9W2cBZmwV8VnGUJ8xqUCGg+h/GYCXuLC0PXKrDmnPnLUxBsepBxOfbKnJvcQXkuAT
         LrA5o8kOCEBXfbpqpfqfk1z1IXF9CJws+3MN5r3LvrJUouAgte87uwEY2d77Ut1SoVKt
         is5he1BDevCBLpk00Kyk9mSRmZ+EfzZu5wg11/ztWucKKVXIGPh4TAQnq6Ce0QMDnujD
         RECpgLTgnKHJbvqg39cPAw0LbmOWYBm61vXWmYGb1Sis1s+KhvRRWHNRVpRDVplUzbA3
         oY9g==
X-Forwarded-Encrypted: i=1; AJvYcCVE5pr+EEvssEqob9bSGjRlLutDMZ9yVqxoiii+1wlD4mbdPMpnqX56AQG6CiIgneAY2xxaHSPF@vger.kernel.org, AJvYcCVFNwol8WMaCK+NwceyNgMwXMBPveKbPJhIWdNK9XkavtrhA26fr/p29jD74o6y79bGq5ycFNgtetRv6Uk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg3WPsJAFx33KzfaUdJmRyf8QGmDyT25HAU++CfahikCsHmY3e
	OB3JG+w8vUwJN9WclrEupqpi7PsxuN0lAEVTNLxTgEDGyqMN+I3wsWHpjxeuZdlnmU0yGGrkLc3
	1bMyuDnc2LHJGtAA9WyCSYXPGqCc=
X-Google-Smtp-Source: AGHT+IF0o4MtgQJ+VCa/5g+9ZpMnVWuoLvL2PomI6Eh/cEZuBzu3afuJFrPowCmyC+39xUQ9Xmx2QtYEQ5Wus855HM0=
X-Received: by 2002:a05:6902:2b8b:b0:e26:1400:2ba0 with SMTP id
 3f1490d57ef6-e28939488bcmr5686625276.51.1728186707230; Sat, 05 Oct 2024
 20:51:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001073225.807419-1-dongml2@chinatelecom.cn>
 <20241001073225.807419-4-dongml2@chinatelecom.cn> <20241004094314.735bb69c@kernel.org>
In-Reply-To: <20241004094314.735bb69c@kernel.org>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Sun, 6 Oct 2024 11:51:40 +0800
Message-ID: <CADxym3aO+KR8wthn9-LK7nOBKH+=+gbWykw-E-sVaaa+Lwpp-w@mail.gmail.com>
Subject: Re: [PATCH net-next v4 03/12] net: tunnel: add skb_vlan_inet_prepare_reason()
 helper
To: Jakub Kicinski <kuba@kernel.org>
Cc: idosch@nvidia.com, aleksander.lobakin@intel.com, horms@kernel.org, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	dsahern@kernel.org, dongml2@chinatelecom.cn, amcohen@nvidia.com, 
	gnault@redhat.com, bpoirier@nvidia.com, b.galvani@gmail.com, 
	razor@blackwall.org, petrm@nvidia.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 5, 2024 at 12:43=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue,  1 Oct 2024 15:32:16 +0800 Menglong Dong wrote:
> > -static inline bool skb_vlan_inet_prepare(struct sk_buff *skb,
> > -                                      bool inner_proto_inherit)
> > +static inline enum skb_drop_reason
> > +skb_vlan_inet_prepare_reason(struct sk_buff *skb, bool inner_proto_inh=
erit)
>
> this only has 5 callers, please convert them to expect a drop
> reason to be returned instead of adding a compatibility wrapper

Okay!

> --
> pw-bot: cr

