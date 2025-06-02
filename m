Return-Path: <netdev+bounces-194615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43877ACB561
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 17:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99D4D19416A9
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 14:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A64B222587;
	Mon,  2 Jun 2025 14:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUOOQxrf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B6C2222DA;
	Mon,  2 Jun 2025 14:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748875412; cv=none; b=EGnGjCoolTxzyXNXF5/3jKFHJwJg+np7Tzm91nv2tkTP+zI4AaHizsEWadtxL2/RqFkYLZHrq3EHaevQC28rmAcdCNU3n9K7Kq/R968aolKC29DdSmx2BntzxwOoSyJVdUrS+Q+sQKyE5RVoUvXH4SK6OldGS7PpOXQ+wnM9ihE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748875412; c=relaxed/simple;
	bh=7yC8mUe3M+J54KwrHUwtf8a40GQET+WZucGHxfgArQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g17z8RB5961PLGlCyLmig57KEVxtZdoqaCBKP2dM27MQJJ7aCEwa1oxsYwj+MEb80AbDbIrz6n59uBqqqb8jkGUp+LnlW4NwkII8IvwMFO90SppcYiIkQIlGXcgFnG2mjb6o4KsOBLruoCU+sh54dUeD1JKkVoHINARLPTwvYxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NUOOQxrf; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-32a7256ba04so22324691fa.1;
        Mon, 02 Jun 2025 07:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748875408; x=1749480208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8sRLCr7yx/MIni75hw8rTaRQ6OP4AeVqvCRwGnHFnfA=;
        b=NUOOQxrf/kZg8CxV4kkumFR1Dk5iJjy4PQY4EJyYLyj1qhjOnd+28eW99VhBviGIV6
         XKOVYGbOomW4j5GHhrMEUvp75krxoX//0YdzZqsfqrkk11TVZSy8Ax9e+XBtzQyGHKsA
         O65JEG+Ee0dOePZ4ReAuZHkpLNjR9gbgB6S3kQuArmWTEbBF1rhz2+oB5fIvzyXPS3+8
         xBsP9C9LZQWnyfBte87Nm3iWRJ9Tl1RrEpxTgOMgaAClr/GeuvoCT5NNSinHmUCdjisU
         A+3BLqcAbs9HBi4XXC+fuVldG5oSsEdM88mqcIq40MMptqGhuGbltwo7LI6vw+tMW9LK
         9ieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748875408; x=1749480208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8sRLCr7yx/MIni75hw8rTaRQ6OP4AeVqvCRwGnHFnfA=;
        b=XsH9nMVwLxA11xEtA3dthzHJRZWs7ABT5zMR8l32t2rc2J0C6lAUFvH+I3o/FXPtsw
         cW+heLsqM0qaYXoquunVjhA7YptyurIGBnsHpgrnIJhM3JVOqanpBIY4+D/WX7ALQce3
         o3dt9txXbJ+V/NO/FSnMYqrb6fs2Jg2lEbAMENdSuwosQ0mZVf5KC40eeJx/FQoqwPVs
         v40fMhUzE9YMbkmGdgfeeTpVXBsWwFkBC99xkH5C33r92IHxCLMysWyU+Zya9sR8kRDL
         a3DDaPg+GeTCptDQY/UsxiXhZXUsynMWWBVe/DN5kBdYRdPNKmiyEBdgCByCqyWnu+3o
         MvFg==
X-Forwarded-Encrypted: i=1; AJvYcCWx27oyRWjk/5Gt13Cz3zKINQVxOeHWu9mj+V8NAH059Wv/c/vhRQ39jl2pmaMmGhS68kQ1B5EA@vger.kernel.org, AJvYcCXg817Z1BJAa78E9G5y4Z8wfp5QamB9bkiy/YPtWc3Ut5paZ47EGzk1TomLe6sVDL4Mg33QwniMwl/XObo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9vzpJQ4pGeIdJUoFmDAf8cnOb/PQbiR1YDDwpSy4EtRjzZk96
	KzStlJ43cRxHWEzqWK5WH09OGpT049+P05VN4B/0x2+eHNedcOH6AHDB8PHvRr/+oM64IL7Yzan
	7fM81o9Jgmdvjffdr+mb1MMySAtvgukg=
X-Gm-Gg: ASbGncv/KoP6AAaBeCaXwWXaZX/1+sEMFVhiB24ge5zPuFukVvZNBylZ+m1DrGxCs0v
	UMkji/uPBmy9iejW7597R2V/9xJ6TuYhGMfM2QGC2eOG2jBjuhEoUXyNQGNLlN1IWy6BRUb5rrB
	Ezs/BX3cNKxiQzDWsA+v8AkPbzF+NCDLWyTozAzhGPTDeSMPBtsb+BjKrhpGt0HTw7gRMJeQNaB
	k68Gw==
X-Google-Smtp-Source: AGHT+IEEcH+4OLZzCssFzfwa/cKP04dOQbVZS9DKOiJVdgSrGkQ0Fps7ZkZnqqJcxvfYZLHPVGhPVzV1C2bpZmGOxDI=
X-Received: by 2002:a2e:ae1a:0:b0:32a:7826:4d42 with SMTP id
 38308e7fff4ca-32a8ce1a85dmr33732011fa.31.1748875407557; Mon, 02 Jun 2025
 07:43:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250602135932.464194-1-pranav.tyagi03@gmail.com>
 <EEF63CCD-BEED-4471-BF07-586452F4E0BE@kernel.org> <CAH4c4jJYxXr=Q_cWCmDrRyWGEHnSfyOzM1kWCBWUC+jSXFafpw@mail.gmail.com>
In-Reply-To: <CAH4c4jJYxXr=Q_cWCmDrRyWGEHnSfyOzM1kWCBWUC+jSXFafpw@mail.gmail.com>
From: Pranav Tyagi <pranav.tyagi03@gmail.com>
Date: Mon, 2 Jun 2025 20:13:16 +0530
X-Gm-Features: AX0GCFsctWBBCiIn9aID_uSBMZ7fA1PXMIhUWRhKJ7qfTF05O2WXmZUCcCzjZiw
Message-ID: <CAH4c4jJ_jKmPPOVfKKBbQzsQesNGdYbz4AWb9ZVZPpPEgtOP_g@mail.gmail.com>
Subject: Re: [PATCH] net: randomize layout of struct net_device
To: Kees Cook <kees@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, keescook@chromium.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 2, 2025 at 7:52=E2=80=AFPM Pranav Tyagi <pranav.tyagi03@gmail.c=
om> wrote:
>
> On Mon, Jun 2, 2025 at 7:37=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
> >
> >
> >
> > On June 2, 2025 6:59:32 AM PDT, Pranav Tyagi <pranav.tyagi03@gmail.com>=
 wrote:
> > >Add __randomize_layout to struct net_device to support structure layou=
t
> > >randomization if CONFIG_RANDSTRUCT is enabled else the macro expands t=
o
> > >do nothing. This enhances kernel protection by making it harder to
> > >predict the memory layout of this structure.
> > >
> > >Link: https://github.com/KSPP/linux/issues/188
> > >Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
> > >---
> > > include/linux/netdevice.h | 4 ++++
> > > 1 file changed, 4 insertions(+)
> > >
> > >diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > >index 7ea022750e4e..0caff664ef3a 100644
> > >--- a/include/linux/netdevice.h
> > >+++ b/include/linux/netdevice.h
> > >@@ -2077,7 +2077,11 @@ enum netdev_reg_state {
> > >  *    moves out.
> > >  */
> > >
> > >+#ifdef CONFIG_RANDSTRUCT
> > >+struct __randomize_layout net_device {
> > >+#else
> > > struct net_device {
> > >+#endif
> >
> > There no need for the ifdef. Also these traditionally go at the end, be=
tween } and ;. See other examples in the tree.
> >
> > -Kees
>
> Thanks for the feedback. I will update the patch accordingly.

I also wanted to know if the __randomize_layout can go in between
struct and net_device as ____cacheline_aligned
is placed between } and ; at the end of the struct?
> >
> > >       /* Cacheline organization can be found documented in
> > >        * Documentation/networking/net_cachelines/net_device.rst.
> > >        * Please update the document when adding new fields.
> >
> > --
> > Kees Cook

