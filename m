Return-Path: <netdev+bounces-182624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3F2A8960D
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 10:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 850403B8209
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 08:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD6F2797A9;
	Tue, 15 Apr 2025 08:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FbkATYFt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC8C2741AC
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 08:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744704533; cv=none; b=Zy+lAiroAABD8hIRjWzo0otkXGxRdE+O04GMmDRfcoe4CLJo+eLTxmOhW+fP/QrZWxyTbGdYZTtCMQw2DZLkaQyhSl+BNxMKw8rQfb0hu9gFiSm4xYtC7ZsdWcgJz+2w9Xk/hW/K6C08ISoVkCV1CmPbmJ7cv47dm1pOQYrFguI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744704533; c=relaxed/simple;
	bh=tj/tiTyccxRZQDWEpqLrSMig9rg1/3DbwGWhfStxb+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V+mBgj14Z+6X3yX3o7mZXbKgzZPvGkQ09GziF/lGAV2/xbJ4kx/mTRBpOE9DsYojehusAvy9luxni03gwPz0L6X8JCO4P05eqsDDRKKYlYmFPXXoFTK5r3G+szVyVMZWqPppCzRC9TTx4YdU9xQr5/ZmNCpRM0BQygidkQBy1c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FbkATYFt; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-227d6b530d8so50427225ad.3
        for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 01:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744704531; x=1745309331; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NTHET1KsdFxeGkYvDwEe+2vjo0VKMhzQwc8ApAzC2uI=;
        b=FbkATYFtDwia4a5VTdUZh1Ua0s2iX7RQVndiWGfnuPlofZjkBcPPnVJ5o+lTp7sml6
         eesi1ICvrHRquMx2d9ziuKm6MHNwQbJML3MufmRNZjf/Ghy0WN+tvqKig6NEw8kqu4d3
         2/OKCfeqaEX3t7zdT6yuORtQi2w4Q+jbQT5UHo+gfmvr3DV+C2caL9NbbMiX7ThlIaZ3
         nEmn9d+J+uoiLDhJS0uhOuuTUeX24SDfWVZXAV+Z7rUDOjUVkAWRrCsDgTB4m2JgYeNU
         x9sUxlOS2dO7VXfO4/xRa+YHHkK1EXgsVqhpgzi/uMeqPOSZj0P93jTd0KpuQ2mJCRF4
         6rfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744704531; x=1745309331;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NTHET1KsdFxeGkYvDwEe+2vjo0VKMhzQwc8ApAzC2uI=;
        b=qvacFV8TB69DY96rFZRa9hPLooAug41B8OVL7sEvG+fMRwn1QKLtc5wdSQdwfb3H+A
         a1FwFVIc7F9Td1wbLFvz102FUK9FaYm/WkbjLFpo6v9b5VZwRHKkszFwqdqa9X/Eibrn
         DhwFu9lF4FQEf6HxkbN0E/d/MECGyxioIPT6rbQDaoreavNvrgkoi52GSA/OzDED3sga
         fm1pH2dhe0B61qiccmch+Mpl00pshxW8Ydxof1oWJwOdfP9NU58PwaHwNzETMnwfSJ4h
         3q351TcT467u3Fs80ZXLxpZpIdPIEJ+2jSUzsSY94uKina8sffeF3bNY4+P7mNHr9A2w
         69oQ==
X-Gm-Message-State: AOJu0Yx9iYpq3Qstn0s54cm87DvHTHKpEkrOQVxaXGiDSUZNff7/520r
	PnhKmsqeyNwlQwfuqmmkmmR7rv2+fJNKRcNbegQ4vkGYJSSE7vZz2OkGUa/tELZKdyCLDWkzRso
	2h5EJiTMeDNw+XM5WVlbC9wPMupRBFxkE
X-Gm-Gg: ASbGncv+ygrHUm4UfTPpj+bYpmvAGda6008hwdRO29UKDjX2OMEOEsOR3wWWCVWgTLg
	s4gvwHVca6QNYjKz+ml7IZA+rgqIH2y1XgaklUOanRHr9ss0rF5D1iP/sZn4VglbIOUi3yOWKOb
	1RhgRdQthelB5rO944EYZSRu/sLHFNFqiJUNx2SZzAjFJO73A=
X-Google-Smtp-Source: AGHT+IE1H0dkdlbHVL3qZ9FOR/aeoPAU1udisGnhq1yGo4fqzaN2J9QOiYO3yZzc8JLSHmRNpuLaS1CKpMI8aHODwnc=
X-Received: by 2002:a17:903:1b23:b0:215:89a0:416f with SMTP id
 d9443c01a7336-22bea4bd55bmr228405765ad.30.1744704531390; Tue, 15 Apr 2025
 01:08:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414010912.816413-1-xiyou.wangcong@gmail.com>
 <20250414010912.816413-2-xiyou.wangcong@gmail.com> <CALYGNiOV2sJY5gQwMX+U6ot9fFURHLWW+F87pBtH3T-RLDL+5Q@mail.gmail.com>
 <CALYGNiMtTKpn-BBPpnY+r9WxTPzgMB3rUS5ePO4HQNH1QgZEFQ@mail.gmail.com> <Z/1cHjRv/oKL1UlL@pop-os.localdomain>
In-Reply-To: <Z/1cHjRv/oKL1UlL@pop-os.localdomain>
From: Konstantin Khlebnikov <koct9i@gmail.com>
Date: Tue, 15 Apr 2025 10:08:40 +0200
X-Gm-Features: ATxdqUGB92zhCu-H7ueCoNq2zCHcUCTPf72p3nWkQV7w5tdf4PdDWrNILhyv-s4
Message-ID: <CALYGNiPSPCS5K8moi_Yvzv2GJ14oK-bc+t75tuDiF8cCR=JqLA@mail.gmail.com>
Subject: Re: [Patch net 1/2] net_sched: hfsc: Fix a UAF vulnerability in class handling
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us, 
	gerrard.tai@starlabs.sg
Content-Type: text/plain; charset="UTF-8"

On Mon, 14 Apr 2025 at 21:04, Cong Wang <xiyou.wangcong@gmail.com> wrote:
>
> On Mon, Apr 14, 2025 at 12:09:54PM +0200, Konstantin Khlebnikov wrote:
> > On Mon, 14 Apr 2025 at 11:39, Konstantin Khlebnikov <koct9i@gmail.com> wrote:
> > >
> > > >                 if (cl->qdisc->q.qlen != 0) {
> > > > -                       int len = qdisc_peek_len(cl->qdisc);
> > > > -
> > >
> > > I don't see any functional changes in the code.
> >
> > Oh, I see. "peek" indeed can drop some packets.
> > But it is supposed to return skb, which should still be still part of the queue.
> > I guess you are also seeing the warning "%s: %s qdisc %X: is
> > non-work-conserving?".
> >
> > Actually, following code cares about size of next packet so it could
> > be clearer to rewrite it as:
>
> Actually the bug happened when ->peek() returns NULL (hence len = 0),
> because otherwise implementation like qdisc_peek_dequeued() would just
> add the qlen back:
>
> 1125         /* we can reuse ->gso_skb because peek isn't called for root qdiscs */
> 1126         if (!skb) {
> 1127                 skb = sch->dequeue(sch);
> 1128
> 1129                 if (skb) {
> 1130                         __skb_queue_head(&sch->gso_skb, skb);
> 1131                         /* it's still part of the queue */
> 1132                         qdisc_qstats_backlog_inc(sch, skb);
> 1133                         sch->q.qlen++;
>
> To me, it is at least harder to interpret len!=0, qlen is more straight
> forward and easier to understand. And more importantly update_vf() tests
> qlen too, so it is at least more consistent if we just use qlen across
> the entire HFSC code.

Ok, that's a matter of taste.

> Thanks.

Reviewed-by: Konstantin Khlebnikov <koct9i@gmail.com>

