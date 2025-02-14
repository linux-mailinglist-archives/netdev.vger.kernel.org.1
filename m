Return-Path: <netdev+bounces-166445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA47A3603E
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 15:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A03C016F786
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 14:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C64264FB9;
	Fri, 14 Feb 2025 14:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stackhpc-com.20230601.gappssmtp.com header.i=@stackhpc-com.20230601.gappssmtp.com header.b="nJ7AR9z2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F3D5BAF0
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 14:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739542950; cv=none; b=a+we0VsqqTde/riHBkrIq11Hcpfp8xJxtjrkLZN1jc/kK47S7R6OuCMBmQSU6oAO2BkWqWdDOn7NbGFhsh3kSTOIW0xlrGsGplYWh/UhH5I4kTylI3Zu7KBOa9WH5Z2tVDINlPMmvOuq5CuGp6NZsHaxkQLMG2EZ3y5vT80g4d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739542950; c=relaxed/simple;
	bh=FQtKYIquccOBAXF8nC7VPvUvRQ9ASaN20ViQkiYyLEk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SwhJFRxBjI4aM+QIKk6UMy1O8XbgYmjyhXDt/BOAElWmW9EoS2edEU0We6aa41usa6cqQXJTdbv9fUl5AkXHao0FemdcmUvRyOxhspfzEHNoFvH1JAaGCzhDakHePrCU0K0aiAxQ1bLPTUpFAFhzbxIB8Oz+grs7uQSvqVhoEJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stackhpc.com; spf=pass smtp.mailfrom=stackhpc.com; dkim=pass (2048-bit key) header.d=stackhpc-com.20230601.gappssmtp.com header.i=@stackhpc-com.20230601.gappssmtp.com header.b=nJ7AR9z2; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stackhpc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stackhpc.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2fc0026eb79so3879566a91.0
        for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 06:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=stackhpc-com.20230601.gappssmtp.com; s=20230601; t=1739542947; x=1740147747; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mwjRmuPeZwUiI1OHQZ8a97HW6gr0U6pUai2Wl19pqYs=;
        b=nJ7AR9z2gdBCbpvJNca/0OxmCICmTw4BQg4sZ84Pl2/YkHvlIghEtlOjkbZFomzs0p
         WdthlThZW0QblRtZjGR8gns0pwXLbvryIzD/zQqJ94ya32h4XTbGJ3jNKGTY8sjEINj0
         FzHh1evVtl2XYdHNi/e2F9ziWhBJjzA9hB2c5VkepquBl4HuvlETnFPBPcXzefjYemAo
         3I4b0QYTA0MpIpldtt6v82DjMovYBr1vqteBf64CRznAYHlt5ZYqurftIQmTQyv799d/
         6yw8HHwWzvEPrNdPySU2norzCfomOdWpsl0yj8rFgtShKwfKEG2mAeJH3xcT1NB1eIQE
         mhVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739542947; x=1740147747;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mwjRmuPeZwUiI1OHQZ8a97HW6gr0U6pUai2Wl19pqYs=;
        b=DCDDymr4HrCzyB/Hphz8HK3gXDxaNaavKNmv8Q3MYHnBGwNCWIm0Yi0qNJ6ZCQyHL1
         dtKUlZm+OTQBIQ0C18j7SbalE02uEF40HX9l3N7d6dBQAAdNXDRlCUiio92+MwIC+3gz
         FLYd+3R+SNnAGY+ZvZ2UUI5GtrdgOtghF1Udkd4agG2b0+qiQ6BFcom5QGUThfw8Zre6
         A269n62Y71O04z86VFxtFYm9YzwIIhm/pnE75QZAkPuSF9BNpbiGJNaEQi3gb2aF89AK
         s96N5P4YRCRDmVGaK63b/0j7EQYBV7n60AgKmswPyo9YiuvhjSmqkimxjOAY8QsWkLwL
         M/kg==
X-Gm-Message-State: AOJu0Yyra9tRDEhTUQKEzkqqgDndGKId+GJDkxfdfeJrqDMMqSRxlh6d
	UWzDjUuYlSlXcMr8Mg9qBH8/ypUm6R5O3QAwCyLuIhVojpz41EhRI1O+bZBWl1SJvE0gPfAcKkp
	WQ5zRQ7nUvSvIhJSGJGUUpRjm7zGllmHnQb5yZRg8wJvMvfRjn/XqGg==
X-Gm-Gg: ASbGnct4xg5QwhJRTTVLZlCOMoKBfxVTGptatXaFYfhzMDdeBYaguHRQnoY7leGzzBs
	Cv9w/dTUJ8O+Q8VhdCsAuA214kTeEC+pAvGKaAs10fMBucrYn+ljtmJJvvrhEQMbUrQ/10D7pNx
	KPKFWfTmcsf5wQWrpfP90kAzRLnhrmigw=
X-Google-Smtp-Source: AGHT+IEBau6ImqGth6Fq250yBUYs80VZl7aCAXnuAD8CT/dDqhb34PdVb+3Kbo/r0XnrmQVFXJ9Jv/Im6pmaBaE8oQ8=
X-Received: by 2002:a05:6a00:1788:b0:730:91b8:af1 with SMTP id
 d2e1a72fcca58-7322c3e8957mr18031241b3a.18.1739542947418; Fri, 14 Feb 2025
 06:22:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213223610.320278-1-pierre@stackhpc.com> <Z685fovQy0yL6stZ@mev-dev.igk.intel.com>
In-Reply-To: <Z685fovQy0yL6stZ@mev-dev.igk.intel.com>
From: Pierre Riteau <pierre@stackhpc.com>
Date: Fri, 14 Feb 2025 15:21:50 +0100
X-Gm-Features: AWEUYZmTJtvUS-UTZ4BEXe1G5LtXUtNuYz_t6hyfiPYjoSVSbG6RtTXcELyy2E8
Message-ID: <CA+ny2swxXoMheYQV=gf=P2bYhTzt0J3RhtOZz0++rem=jcq7dA@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: cls_api: fix error handling causing NULL dereference
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 14 Feb 2025 at 13:46, Michal Swiatkowski
<michal.swiatkowski@linux.intel.com> wrote:
>
> On Thu, Feb 13, 2025 at 11:36:10PM +0100, Pierre Riteau wrote:
> > tcf_exts_miss_cookie_base_alloc() calls xa_alloc_cyclic() which can
> > return 1 if the allocation succeeded after wrapping. This was treated as
> > an error, with value 1 returned to caller tcf_exts_init_ex() which sets
> > exts->actions to NULL and returns 1 to caller fl_change().
> >
> > fl_change() treats err == 1 as success, calling tcf_exts_validate_ex()
> > which calls tcf_action_init() with exts->actions as argument, where it
> > is dereferenced.
> >
> > Example trace:
> >
> > BUG: kernel NULL pointer dereference, address: 0000000000000000
> > CPU: 114 PID: 16151 Comm: handler114 Kdump: loaded Not tainted 5.14.0-503.16.1.el9_5.x86_64 #1
> > RIP: 0010:tcf_action_init+0x1f8/0x2c0
> > Call Trace:
> >  tcf_action_init+0x1f8/0x2c0
> >  tcf_exts_validate_ex+0x175/0x190
> >  fl_change+0x537/0x1120 [cls_flower]
> >
> > Fixes: 80cd22c35c90 ("net/sched: cls_api: Support hardware miss to tc action")
> > Signed-off-by: Pierre Riteau <pierre@stackhpc.com>
> > ---
> >  net/sched/cls_api.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
> > index 8e47e5355be6..4f648af8cfaa 100644
> > --- a/net/sched/cls_api.c
> > +++ b/net/sched/cls_api.c
> > @@ -97,7 +97,7 @@ tcf_exts_miss_cookie_base_alloc(struct tcf_exts *exts, struct tcf_proto *tp,
> >
> >       err = xa_alloc_cyclic(&tcf_exts_miss_cookies_xa, &n->miss_cookie_base,
> >                             n, xa_limit_32b, &next, GFP_KERNEL);
> > -     if (err)
> > +     if (err < 0)
> >               goto err_xa_alloc;
> >
> >       exts->miss_cookie_node = n;
>
> Thanks for fixing.
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>
> The same thing is done in devlink_rel_alloc() (net/devlink/core.c). I am
> not sure if it can lead to NULL pointer dereference as here.
>
> Thanks,
> Michal

Thanks for the review. I also checked other occurrences under net/ and
wanted to investigate this one. It looks like it could produce a
similar result.

In devlink_rel_alloc(), if xa_alloc_cyclic() returns 1, we execute
kfree(rel); return ERR_PTR(err);
In caller devlink_rel_nested_in_add(), we would assign the value 1 to
rel, check IS_ERR(rel) - which should be false? - and dereference rel
at: rel->devlink_index = devlink->index;

Should I update the patch to cover both issues?

