Return-Path: <netdev+bounces-182439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5299AA88BE9
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 21:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC35D189B00F
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 19:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC3B28BA91;
	Mon, 14 Apr 2025 19:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bEcuCjG0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492274C74
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 19:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744657442; cv=none; b=p1wK0blQVJPq1TjTD3CXf6dCuwKsDyevCQKM3y33D8X1Pj6efln5BwJOo76ZlJmSvaLz9WeBqxxBePbWAJial1VRpdHn9Mht5N/91+pnAf7sWkK4HZSeh/01QjFn7rNLFQREcjaYf+HTvRbtoFpmigqvHIF4uqqoTYiwAvsdj4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744657442; c=relaxed/simple;
	bh=LAmiZYWwWCpK4b/OdFLWVNz586v66VznriaCCUUf0sI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YqeR6/wIJ/vcgiu/wjuA8pTBl/DX82J3kws5BCVopMKeTsX0gMBJPXvcFo74TN3Wz+Rtz7MKXfbSIoc0766usd1PiSaeQQhiNdtOGQVUNiVzXxL6HMwCQi8qVTJ25qBue1XM5Hg1e9PSckNqo8cxc+26kqGZ3XwBFdqfp4q0v30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bEcuCjG0; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b041afe0ee1so3842614a12.1
        for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 12:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744657440; x=1745262240; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vromD0FphuFgtqiB0jRacXjQCVse5zIiqCtle0NChm8=;
        b=bEcuCjG0YRKGxM9/bFbFbgkYDhZoRw6wDzVdeZGo/zipJced+3b5P/i6f8mmq6d94q
         BEpJXjxcjoWgl/I5WPQUsS58qTcX1dOd454K/mN+2SAnifq9i3LQvAnl7AGw4KA6uZxW
         I4q3I0eJ5nadLzS3oQ7XA4AUCuJQUYzwGw+Q6of6j1SV17BVkb+DhQGU2828M/dDszjS
         kzFHveS997Z4fZnvfA7WtTEm8i4AQUbnxMqKAh0x9+YEkqugkeCMgZmj1xpcyB9v529H
         bG4xrOMRoB/oL/jaaoIGwk8OGcRJLubdXW7+PMECHOPI4PI35QGzuRY5cbr+kxMbRxZZ
         iIcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744657440; x=1745262240;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vromD0FphuFgtqiB0jRacXjQCVse5zIiqCtle0NChm8=;
        b=etXZv6/tyMdaXT4g+6owhtwaY9ckYC5QseoJyLJ2AfmkcaSzP8H7ENoeFDwFiO0qrI
         slHdscP5kWkxq94G6MQJKQPUKjyQxE1kjIJleZLq6uYRCrpsBCHFiIpVVrNi91tbNQO9
         cnXxZQBQWMjVOnJ9mjwNGZ1Yl+qcpr+vNYAoPyMT9gWBrUn9glDEDU80XqcZuxqqnY45
         /2GvxHo2Z251GPoiuZoUTRFT4TaVtUMxzG8cAo6FCM/neTY945jV9JGxGY4qluJxX6Fr
         fKwZ4Ti7kNNwDDVKURIkbFhlDluDEJk3RWptx2l0ukFdC3Ze3UJ7Km/gKmsvpYcl4Rql
         RdmQ==
X-Gm-Message-State: AOJu0Yxy6orRpndUYCZqaMRYnndhtBivMktqbjCT/KvgM/v+a9kJvpYS
	AYRhrBqd7fS/YIRaasFLGQpsPOp4MkzOiIluSAa+38Dwbvps567+
X-Gm-Gg: ASbGncuhUJ8FI96Hybxf2D3SurtnfP4zm9HLaU5q4RAYFImOpNH+3gtMlWWWC28+DNr
	cMIqsEoPBliRmbGGpGKr1Rj1VoY3fIBmjqjicxNYDQWwNmmOnjzOhQ81BGNqvUNuS1lsRBpJFdw
	wAq51KKrad8vNPQL47d05AyLlInsgl9QS2S5Bof4x7ddZBwczqPuUh3o4L9V9hkUQTshqn4AN3S
	BxteEiLy2f7oS6wsrlSbcVwnW9QBjV2B1eAJgs203ssQ4gg9DpFHUhLj2JKAGtUabVlDH0jGzof
	LHg+2jpJARWs4WkNj+/RUCvH2yS+6XN/yIhgYJzKFrrq
X-Google-Smtp-Source: AGHT+IFcVq5WsHPbtnYER7mJm8dIQfr5IRurQnQB5RH1DcDO7fbfCMYgKCYwVElFfk6oUGM9ytIruQ==
X-Received: by 2002:a17:90b:3811:b0:2ea:7cd5:4ad6 with SMTP id 98e67ed59e1d1-3082367eed7mr14869864a91.32.1744657440247;
        Mon, 14 Apr 2025 12:04:00 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306dd2fe717sm5740056a91.0.2025.04.14.12.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 12:03:59 -0700 (PDT)
Date: Mon, 14 Apr 2025 12:03:58 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Konstantin Khlebnikov <koct9i@gmail.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
	gerrard.tai@starlabs.sg
Subject: Re: [Patch net 1/2] net_sched: hfsc: Fix a UAF vulnerability in
 class handling
Message-ID: <Z/1cHjRv/oKL1UlL@pop-os.localdomain>
References: <20250414010912.816413-1-xiyou.wangcong@gmail.com>
 <20250414010912.816413-2-xiyou.wangcong@gmail.com>
 <CALYGNiOV2sJY5gQwMX+U6ot9fFURHLWW+F87pBtH3T-RLDL+5Q@mail.gmail.com>
 <CALYGNiMtTKpn-BBPpnY+r9WxTPzgMB3rUS5ePO4HQNH1QgZEFQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALYGNiMtTKpn-BBPpnY+r9WxTPzgMB3rUS5ePO4HQNH1QgZEFQ@mail.gmail.com>

On Mon, Apr 14, 2025 at 12:09:54PM +0200, Konstantin Khlebnikov wrote:
> On Mon, 14 Apr 2025 at 11:39, Konstantin Khlebnikov <koct9i@gmail.com> wrote:
> >
> > >                 if (cl->qdisc->q.qlen != 0) {
> > > -                       int len = qdisc_peek_len(cl->qdisc);
> > > -
> >
> > I don't see any functional changes in the code.
> 
> Oh, I see. "peek" indeed can drop some packets.
> But it is supposed to return skb, which should still be still part of the queue.
> I guess you are also seeing the warning "%s: %s qdisc %X: is
> non-work-conserving?".
> 
> Actually, following code cares about size of next packet so it could
> be clearer to rewrite it as:

Actually the bug happened when ->peek() returns NULL (hence len = 0),
because otherwise implementation like qdisc_peek_dequeued() would just
add the qlen back:

1125         /* we can reuse ->gso_skb because peek isn't called for root qdiscs */
1126         if (!skb) {
1127                 skb = sch->dequeue(sch);
1128
1129                 if (skb) {
1130                         __skb_queue_head(&sch->gso_skb, skb);
1131                         /* it's still part of the queue */
1132                         qdisc_qstats_backlog_inc(sch, skb);
1133                         sch->q.qlen++;

To me, it is at least harder to interpret len!=0, qlen is more straight
forward and easier to understand. And more importantly update_vf() tests
qlen too, so it is at least more consistent if we just use qlen across
the entire HFSC code.

Thanks.

