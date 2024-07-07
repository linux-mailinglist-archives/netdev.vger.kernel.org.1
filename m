Return-Path: <netdev+bounces-109680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D00929860
	for <lists+netdev@lfdr.de>; Sun,  7 Jul 2024 16:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CCBA1F20F5D
	for <lists+netdev@lfdr.de>; Sun,  7 Jul 2024 14:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281FD25634;
	Sun,  7 Jul 2024 14:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lz9w1q3J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5E224B29
	for <netdev@vger.kernel.org>; Sun,  7 Jul 2024 14:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720363447; cv=none; b=EZoibpwEjeFUkvahEGXNn5MZA3YQOW/0Z38dC9+eGXVunaartUgEoBSiG/gVIGfqAD4OVkX+NVNVBVyfE8SWDxl0XJry3AqIjuN/vNvq1W3F4GmsrgZW+w5RU+EKtOU/YWl27BTrq54aUhVwJIcPikdawNNMFDhL6Kt9ByP1b9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720363447; c=relaxed/simple;
	bh=AW6keBs1Ul57Un5+ysy6hgjSXWTaRwpRMfLWZu9ZJsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wgwspj/M/xfnMtXNVFdlF94ZCXGn7rj1IkOJs3Db6+kKdWhpg+7EY70ACKvVN9WjRcSEBD18UfuVFLqJGuwDAk8vGa+zj/eCUlkDsQPxsOkfxr5MsQLb46GVNZsTSPGyg4j+ZMjHrkc+niF7D9PZQ/BahFhMmXzWP7yOjIeBQaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lz9w1q3J; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-36796bbf687so1742447f8f.0
        for <netdev@vger.kernel.org>; Sun, 07 Jul 2024 07:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720363444; x=1720968244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IGMlismzpIIV36hUDEQhX4YT1GWs90McG/xr7WmfCzo=;
        b=Lz9w1q3Jh7wQuY+m2ecLNbJ7F5RvJ2odTMlnlLj6LFdiYuJk/oofYzOPc4QsSQlU4l
         7dWKmNs1j1LDF+ACs3Efa5a945fknXDnXGOmk8Yffs9w6JfZUk/3j0EqMZ/7IvPPSvwT
         erXG6qw1DT462aut7soykoe1e2V9m8YM9cJJm6KHFyjsqaPZd5FsUIPi/VXF0Ky6QJwa
         Vd2Or+pwQK8YjnlzSZAo275NXhBPL4I7qMgOc6XheyHpWQBOwQSv190EXtgw+ZXqpaeX
         IX0xqAW9660/zSiYLnX00/+UaZx37iJhNyMcvbxwVLcNrJ5l12WAGt01zu/ARJng29ql
         Zpiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720363444; x=1720968244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IGMlismzpIIV36hUDEQhX4YT1GWs90McG/xr7WmfCzo=;
        b=tCg+QF6eVt+/jGj4nNy9gI38ftOPjGgXnaVbvx/3VtHF4KCqD54TE4BafwRlZiWhX9
         MWOGJeT8AulvPYYZojD98lWnVC/jsuhRRVXWF3fak1K/Yd1agoVok/OjYzCYDhhlvAm/
         fSHgpwBazYntjlEUSdNiLUTzW59i/JUqAYoDRqHw3i34lwpq31ZIg2jcltdPlc0n86Tz
         x8FaNGqC6JuzDBt/m8TZqZRx8GWFrIii15mGAFlsLq4IxxAfHNfGwTL41UTykk8z3EyI
         zKuorAovS1KmOth5xsi5lqdX0w6ofPiceEQZWzROCTaxQ4BLD178VfYosqvHz5Ht95Ik
         KJtQ==
X-Gm-Message-State: AOJu0Yyl6Apz2SDqgxKRfCdOTDfUxeHL44G59yyqdCQ1PqPDO8oaeLev
	A+Fz2/9HP7D7r5xhPcp9RomIsfUiPMAINplSVNS+UR7Y3dF6ilYyYnUy/CsOruQn9leDow/3TtD
	XzVK7tvuXmLJ1MIMNLTG9paWhquctTA==
X-Google-Smtp-Source: AGHT+IFDJVVSgYumVweaA7B5Z5wCkdEe8RDtKe8RhU2DYB8n6eEHkAL4FmnHsPmKCoGBv60hBUNk+MCx0szqG+oWVAc=
X-Received: by 2002:a5d:5747:0:b0:367:8e56:f6be with SMTP id
 ffacd0b85a97d-3679dd314d3mr6533461f8f.32.1720363443476; Sun, 07 Jul 2024
 07:44:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171993231020.3697648.2741754761742678186.stgit@ahduyck-xeon-server.home.arpa>
 <171993241104.3697648.17268108844942551733.stgit@ahduyck-xeon-server.home.arpa>
 <20240703201502.GS598357@kernel.org>
In-Reply-To: <20240703201502.GS598357@kernel.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Sun, 7 Jul 2024 07:43:27 -0700
Message-ID: <CAKgT0UckcQ_XFpf3_SS6XXcJ6vsjBYARC-y3VQs04zL2c5HCKA@mail.gmail.com>
Subject: Re: [net-next PATCH v3 08/15] eth: fbnic: Implement Tx queue alloc/start/stop/free
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Alexander Duyck <alexanderduyck@fb.com>, kuba@kernel.org, 
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 1:15=E2=80=AFPM Simon Horman <horms@kernel.org> wrot=
e:
>
> On Tue, Jul 02, 2024 at 08:00:11AM -0700, Alexander Duyck wrote:
> > From: Alexander Duyck <alexanderduyck@fb.com>
> >
> > Implement basic management operations for Tx queues.
> > Allocate memory for submission and completion rings.
> > Learn how to start the queues, stop them, and wait for HW
> > to be idle.
> >
> > We call HW rings "descriptor rings" (stored in ring->desc),
> > and SW context rings "buffer rings" (stored in ring->*_buf union).
> >
> > This is the first patch which actually touches CSRs so add CSR
> > helpers.
> >
> > No actual datapath / packet handling here, yet.
> >
> > Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
>
> ...
>
> > diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net=
/ethernet/meta/fbnic/fbnic_txrx.c
>
> ...
>
> > +void fbnic_fill(struct fbnic_net *fbn)
>
> Hi Alexander,
>
> Although it is done as part of a later patch in the series,
> to avoid W=3D1 builds complaining, it would be best to add
> a declaration of fbnic_fill to this patch.
>
> > +{
> > +     struct fbnic_napi_vector *nv;
> > +
> > +     list_for_each_entry(nv, &fbn->napis, napis) {
> > +             int i;
> > +
> > +             /* Configure NAPI mapping for Tx */
> > +             for (i =3D 0; i < nv->txt_count; i++) {
> > +                     struct fbnic_q_triad *qt =3D &nv->qt[i];
> > +
> > +                     /* Nothing to do if Tx queue is disabled */
> > +                     if (qt->sub0.flags & FBNIC_RING_F_DISABLED)
> > +                             continue;
> > +
> > +                     /* Associate Tx queue with NAPI */
> > +                     netif_queue_set_napi(nv->napi.dev, qt->sub0.q_idx=
,
> > +                                          NETDEV_QUEUE_TYPE_TX, &nv->n=
api);
> > +             }
>
> It is fixed in a subsequent patch of this series,
> but a '}' should go here.
>
> > +}
>

Thanks. I will fix both of these up for v4. Most likely I will just
move fbnic_fill into the next patch as that way I can address both of
the issues in one shot.

- Alex

