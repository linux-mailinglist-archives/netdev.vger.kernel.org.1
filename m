Return-Path: <netdev+bounces-166457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 259B5A3609F
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 15:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E628818907AD
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 14:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8B62661B9;
	Fri, 14 Feb 2025 14:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stackhpc-com.20230601.gappssmtp.com header.i=@stackhpc-com.20230601.gappssmtp.com header.b="K3tUZZst"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1C6264A9F
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 14:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739543943; cv=none; b=WFoqLsQ++155zl23M1JUbdxqprc7SR8NeoyxKJRs+SjfAsGX56f0jzg3nosgSH8cNLIyWIWr6pBfaVuhDJkziZx1ihf4vWw/ay1a/dKzm7KRL2gM8VZ2EsSLq0YUfftO8A0TxXnJ4ipeS4JHQYQibyB31ztu+TRn8Rr6ug3qCzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739543943; c=relaxed/simple;
	bh=wFkxdvIwnJWPtmy3IVwliR+EGyMjmgmxBGvOd/UtBZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tuckEsva2gis0PU7tDN0T2G2FuVTekPu9DooJXYjN+LX0GfMG3c5N6PP0RdbWagJSNGcp/i6GFPeTyy1Yd9kl32FAY9HKBhej6zVebVJqJRHEZHKke9i4dyX8eG6s20pO3HXVXVl00N3FYbZF6tpPplUoaUzMt0moH4Ch453LF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stackhpc.com; spf=pass smtp.mailfrom=stackhpc.com; dkim=pass (2048-bit key) header.d=stackhpc-com.20230601.gappssmtp.com header.i=@stackhpc-com.20230601.gappssmtp.com header.b=K3tUZZst; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stackhpc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stackhpc.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-220f048c038so11999015ad.2
        for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 06:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=stackhpc-com.20230601.gappssmtp.com; s=20230601; t=1739543941; x=1740148741; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vhilAW4gniv1DVgcjzIBhwxNOhpawvc9uI+g4OceS6U=;
        b=K3tUZZstKqEvsrmXGbWEtzO6y4gz435WZI9bxgzC1h1ClPXNFk3W4AnvAU5p9Opg70
         3DymKHrFv/fjU6n15LtCz7W8vkcFQ3jh1bQY5w14mNNnu3fC7moY26d+/mTZAXUIZAzK
         GJZu096k+3raD5CcHZ8jEY7s7B1IeclPE2YxqJ+DIAIiEZvMqI7joXzExmZ0j29YeIqS
         CDY0jBvisHc5B29suuoxMR4O1NliwpzkEodbZ/TyiMLN6WlfqyuM/hvKhfBOFa9/g+IH
         Iq6qasH+J2J6NvvTXZKh5KN4ZvFIBVtfgnxMf4Xctl9rlEblZXilRHZywEvV93slQ6xW
         uJBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739543941; x=1740148741;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vhilAW4gniv1DVgcjzIBhwxNOhpawvc9uI+g4OceS6U=;
        b=ZPjLNOsnVCVKBnDwkvcCGdRjRglPCjrtggfqrSLl+J1IAiR4MorCoSGiF4H61YfFcW
         Xz5zywNwvrxdSorCMQxtCmfZ0GZ3a/1S2zFq4hYlyzpvDEMBUmNIlV2LLwgSXzpr0wVc
         ms8cFawoUJOd9J5HeUb+iAS7F8N4ZO06VrhhFoJ7D6yJPo1b87W/hyPvTNJBI4PBoSyR
         5pjfjBm9Ie4CVLK2QIEh4AjgAA4iN1l/IQTFE8iuOS9aQ2kE+NDdWfcNYnX1HdlY8UKI
         oE9dVQCsi7lnPO8BU/j2pjnPAWpxIjFXlChs674lY9AemI9gvucMdfnfGA6uLPPGlOop
         MC6A==
X-Gm-Message-State: AOJu0Yxb5jieQOwL4YMKu+a4xzkDG0dcTSangESvE5VzLKW3yDL4ELi1
	OtiGnGpbJH9UWwitf8DSj+lduBn+2rHfnphGy0RfHmYx+9wP/rJDZ7siL/wuLWhXVayUFi+ZD/3
	LSe9Thq+TVZITYVklRMHasocqr6niDG/43V1oww==
X-Gm-Gg: ASbGncu2lRQWtBfrY6Emc1A8royaXohsW9qfRGSNJ0Pe6um9qEX+GnbWMvxI+M1ZJ8D
	/5YGfqB1dQtBS5repsQCm+GGzCrd2h7g75Bw1VY+2e5lLb37mRLKfow87ord/1vazbv/94dS+ok
	F1oKsYpix1tnhXwzraHoY8KTivZaYw9qg=
X-Google-Smtp-Source: AGHT+IFNZXpOncTCw8++MCjUYwQdWRNY703IWLqlt85EiLHOTjZiy50WPWA+xtX3i7nH0o3KCEB4MFbs61B4W49dR18=
X-Received: by 2002:a17:902:db10:b0:221:133:fcfb with SMTP id
 d9443c01a7336-2210133fe61mr6939335ad.20.1739543941046; Fri, 14 Feb 2025
 06:39:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213223610.320278-1-pierre@stackhpc.com> <Z685fovQy0yL6stZ@mev-dev.igk.intel.com>
 <CA+ny2swxXoMheYQV=gf=P2bYhTzt0J3RhtOZz0++rem=jcq7dA@mail.gmail.com>
In-Reply-To: <CA+ny2swxXoMheYQV=gf=P2bYhTzt0J3RhtOZz0++rem=jcq7dA@mail.gmail.com>
From: Pierre Riteau <pierre@stackhpc.com>
Date: Fri, 14 Feb 2025 15:38:24 +0100
X-Gm-Features: AWEUYZlrBhjJZbZcCJvSyGbGYlwPRh4x-urU_whcBwjbM6Dni_s47pUK8ohZYJo
Message-ID: <CA+ny2sz8+UFZtYFLEDo+VQrN3iEwSu_gG1+mKTWm4wL7PK+uTw@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: cls_api: fix error handling causing NULL dereference
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 14 Feb 2025 at 15:21, Pierre Riteau <pierre@stackhpc.com> wrote:
>
> On Fri, 14 Feb 2025 at 13:46, Michal Swiatkowski
> <michal.swiatkowski@linux.intel.com> wrote:
> >
> > On Thu, Feb 13, 2025 at 11:36:10PM +0100, Pierre Riteau wrote:
> > > tcf_exts_miss_cookie_base_alloc() calls xa_alloc_cyclic() which can
> > > return 1 if the allocation succeeded after wrapping. This was treated as
> > > an error, with value 1 returned to caller tcf_exts_init_ex() which sets
> > > exts->actions to NULL and returns 1 to caller fl_change().
> > >
> > > fl_change() treats err == 1 as success, calling tcf_exts_validate_ex()
> > > which calls tcf_action_init() with exts->actions as argument, where it
> > > is dereferenced.
> > >
> > > Example trace:
> > >
> > > BUG: kernel NULL pointer dereference, address: 0000000000000000
> > > CPU: 114 PID: 16151 Comm: handler114 Kdump: loaded Not tainted 5.14.0-503.16.1.el9_5.x86_64 #1
> > > RIP: 0010:tcf_action_init+0x1f8/0x2c0
> > > Call Trace:
> > >  tcf_action_init+0x1f8/0x2c0
> > >  tcf_exts_validate_ex+0x175/0x190
> > >  fl_change+0x537/0x1120 [cls_flower]
> > >
> > > Fixes: 80cd22c35c90 ("net/sched: cls_api: Support hardware miss to tc action")
> > > Signed-off-by: Pierre Riteau <pierre@stackhpc.com>
> > > ---
> > >  net/sched/cls_api.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
> > > index 8e47e5355be6..4f648af8cfaa 100644
> > > --- a/net/sched/cls_api.c
> > > +++ b/net/sched/cls_api.c
> > > @@ -97,7 +97,7 @@ tcf_exts_miss_cookie_base_alloc(struct tcf_exts *exts, struct tcf_proto *tp,
> > >
> > >       err = xa_alloc_cyclic(&tcf_exts_miss_cookies_xa, &n->miss_cookie_base,
> > >                             n, xa_limit_32b, &next, GFP_KERNEL);
> > > -     if (err)
> > > +     if (err < 0)
> > >               goto err_xa_alloc;
> > >
> > >       exts->miss_cookie_node = n;
> >
> > Thanks for fixing.
> > Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> >
> > The same thing is done in devlink_rel_alloc() (net/devlink/core.c). I am
> > not sure if it can lead to NULL pointer dereference as here.
> >
> > Thanks,
> > Michal
>
> Thanks for the review. I also checked other occurrences under net/ and
> wanted to investigate this one. It looks like it could produce a
> similar result.
>
> In devlink_rel_alloc(), if xa_alloc_cyclic() returns 1, we execute
> kfree(rel); return ERR_PTR(err);
> In caller devlink_rel_nested_in_add(), we would assign the value 1 to
> rel, check IS_ERR(rel) - which should be false? - and dereference rel
> at: rel->devlink_index = devlink->index;
>
> Should I update the patch to cover both issues?

Nevermind, I see you already posted a patch in the meantime. Thanks.

