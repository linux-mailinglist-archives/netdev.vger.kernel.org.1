Return-Path: <netdev+bounces-102439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C49F4902F6B
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 06:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7B87281723
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 04:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5AC829CEB;
	Tue, 11 Jun 2024 04:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QwSAbbcN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E551763C
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 04:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718078744; cv=none; b=A8fQVy15fBDzJzHyOi8DSkPBtF5awbNufBaPAK3xE+VkX11RS1r+XZuXyUiELFKrqt96Hy/xbMao3kFQrmil3wDEJdbfR701OGzfL5f4abqQk3Qe/5fReKQRTdbrxcgvpTQKgdLMpPdg9DPlnIkr1UayJWZN9fqtdMGyYlrrzWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718078744; c=relaxed/simple;
	bh=nhSmcQvk8IxZki34EroocWrsydSpUUYmpOgRC9V4b80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gk5a26xYwMJVtZkJ+wRXIdfPfL//OHssF+mVYwbCjz38Z8T3F2jBK454bOmWIN4vtsY2rX5Ss8sBXhyhfWKSF5csXAS2zShSgYA7PhnFkpjMK/84Ny77rpSVwZlj5of/Sv9OKq279+UZckGgLN/JjQ6fGOaeQ7dpK2Wross3Qb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QwSAbbcN; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57864327f6eso1013727a12.1
        for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 21:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718078741; x=1718683541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhSmcQvk8IxZki34EroocWrsydSpUUYmpOgRC9V4b80=;
        b=QwSAbbcN680SaggLMFcReWx9hHqfkWCUCBMZMgjcX+OR1KYxN0WAXPWai0kDGAgAdy
         23pTEwqkfBd0BRuJ8mlKAuEpqLvfIxUbiJLwT655gHKNoN4o+C9J3uE6zhHAyjU0MtVj
         +mQq5I4FC3Puun3j57sf7hJG/mYnhSFjpdvAOmt9ToIIa6ctcd0akxiocw9K92v5z8uU
         Fb0PyIHmmDZMW1FR7jTDrmkL33xrEV6pbeT3d8mT1uDZHqTmROLo/FEm+OJcEtGK3Ee0
         kLpS4VOsVcE6uI9AZzHQTKIsymW4xqsSaVhkDb7ajuxb6JmyHq/TDuT+CiqR6b3gXIXk
         8mtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718078741; x=1718683541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nhSmcQvk8IxZki34EroocWrsydSpUUYmpOgRC9V4b80=;
        b=oJGlF22fkJ2rkKihzOTA1Eht9UWF35n3Q/cAbmbr0eNfAAjTQRD7WbkQEMXOnLvBbh
         0dKlK4PSuj0syiOenpkr+Nc/YJHaZpyow+ictrlp+ZHjNZM3ejqNpAQ8bWk5hMf0MlS+
         D5Mm1JTfr/0DW+w0b/Yc6ZE8NRxqIf/a1cz9j60to9VfRYqbG3zD8dAgtuC1eTyGWLi8
         s3vOg+RlgTPtykQtODMkKSM1fmUy7f3vPetOnyocKGquSlNqGhldb9jLhljrGbTWgaaI
         pPc2pVcy3a2zDUtpem4cxtcxYTPKlwOPpbkRNAXNr0+oc7tjnjahzIiWeb7aST36QdUA
         Lh6A==
X-Forwarded-Encrypted: i=1; AJvYcCVf7cMHXKUbinUNBasGbKDEZvsffCQs0fKLSylMhSoMPL85lBDC6fdZgE+BK3eF29coOb0HKnMk6alySgkcmtprZ4umpZUY
X-Gm-Message-State: AOJu0YzHweYd7WK5TDCpAlL7rXE3RiXSomsIt0NIwkcRiV1URUakKNMv
	Td2oi0kErOHUmqKL+P2QwThC22EapIl1uKlOC1QLA3NlwwRteCenOoAPjt4bd9R8bzGSweEyzPq
	UoA7+E30FlOd1oSwK3fgcpgWonFM=
X-Google-Smtp-Source: AGHT+IEQ7FZHmXCTHRrgXit/YdRsvimxtbY3ph9c3hIxrlwFbr1NHricpJ76HQeRV8GAqu+PXIvIIRv+sxmbvApnzPE=
X-Received: by 2002:a50:a45d:0:b0:57c:6d37:4f43 with SMTP id
 4fb4d7f45d1cf-57c90d2ac97mr850606a12.11.1718078741030; Mon, 10 Jun 2024
 21:05:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610040706.1385890-1-ap420073@gmail.com> <d1b1d6fd-26be-46c5-b453-538ca5880e7b@amd.com>
In-Reply-To: <d1b1d6fd-26be-46c5-b453-538ca5880e7b@amd.com>
From: Taehee Yoo <ap420073@gmail.com>
Date: Tue, 11 Jun 2024 13:05:29 +0900
Message-ID: <CAMArcTXk5VG3jH8UTjqjN15=CGD-v1z22yb3n09KWRQ3dqYB3A@mail.gmail.com>
Subject: Re: [PATCH net] ionic: fix use after netif_napi_del()
To: "Nelson, Shannon" <shannon.nelson@amd.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, brett.creeley@amd.com, drivers@pensando.io, 
	netdev@vger.kernel.org, jacob.e.keller@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 3:21=E2=80=AFAM Nelson, Shannon <shannon.nelson@amd=
.com> wrote:
>

Hi Nelson,
Thanks a lot for the review!

> On 6/9/2024 9:07 PM, Taehee Yoo wrote:
> >
> > When queues are started, netif_napi_add() and napi_enable() are called.
> > If there are 4 queues and only 3 queues are used for the current
> > configuration, only 3 queues' napi should be registered and enabled.
> > The ionic_qcq_enable() checks whether the .poll pointer is not NULL for
> > enabling only the using queue' napi. Unused queues' napi will not be
> > registered by netif_napi_add(), so the .poll pointer indicates NULL.
> > But it couldn't distinguish whether the napi was unregistered or not
> > because netif_napi_del() doesn't reset the .poll pointer to NULL.
> > So, ionic_qcq_enable() calls napi_enable() for the queue, which was
> > unregistered by netif_napi_del().
> >
> > Reproducer:
> > ethtool -L <interface name> rx 1 tx 1 combined 0
> > ethtool -L <interface name> rx 0 tx 0 combined 1
> > ethtool -L <interface name> rx 0 tx 0 combined 4
> >
> > Splat looks like:
> > kernel BUG at net/core/dev.c:6666!
> > Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> > CPU: 3 PID: 1057 Comm: kworker/3:3 Not tainted 6.10.0-rc2+ #16
> > Workqueue: events ionic_lif_deferred_work [ionic]
> > RIP: 0010:napi_enable+0x3b/0x40
> > Code: 48 89 c2 48 83 e2 f6 80 b9 61 09 00 00 00 74 0d 48 83 bf 60 01 00=
 00 00 74 03 80 ce 01 f0 4f
> > RSP: 0018:ffffb6ed83227d48 EFLAGS: 00010246
> > RAX: 0000000000000000 RBX: ffff97560cda0828 RCX: 0000000000000029
> > RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff97560cda0a28
> > RBP: ffffb6ed83227d50 R08: 0000000000000400 R09: 0000000000000001
> > R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000000
> > R13: ffff97560ce3c1a0 R14: 0000000000000000 R15: ffff975613ba0a20
> > FS: 0000000000000000(0000) GS:ffff975d5f780000(0000) knlGS:000000000000=
0000
> > CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007f8f734ee200 CR3: 0000000103e50000 CR4: 00000000007506f0
> > PKRU: 55555554
> > Call Trace:
> > <TASK>
> > ? die+0x33/0x90
> > ? do_trap+0xd9/0x100
> > ? napi_enable+0x3b/0x40
> > ? do_error_trap+0x83/0xb0
> > ? napi_enable+0x3b/0x40
> > ? napi_enable+0x3b/0x40
> > ? exc_invalid_op+0x4e/0x70
> > ? napi_enable+0x3b/0x40
> > ? asm_exc_invalid_op+0x16/0x20
> > ? napi_enable+0x3b/0x40
> > ionic_qcq_enable+0xb7/0x180 [ionic 59bdfc8a035436e1c4224ff7d10789e3f146=
43f8]
> > ionic_start_queues+0xc4/0x290 [ionic 59bdfc8a035436e1c4224ff7d10789e3f1=
4643f8]
> > ionic_link_status_check+0x11c/0x170 [ionic 59bdfc8a035436e1c4224ff7d107=
89e3f14643f8]
> > ionic_lif_deferred_work+0x129/0x280 [ionic 59bdfc8a035436e1c4224ff7d107=
89e3f14643f8]
> > process_one_work+0x145/0x360
> > worker_thread+0x2bb/0x3d0
> > ? __pfx_worker_thread+0x10/0x10
> > kthread+0xcc/0x100
> > ? __pfx_kthread+0x10/0x10
> > ret_from_fork+0x2d/0x50
> > ? __pfx_kthread+0x10/0x10
> > ret_from_fork_asm+0x1a/0x30
> >
> > Fixes: 0f3154e6bcb3 ("ionic: Add Tx and Rx handling")
> > Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> > ---
> > drivers/net/ethernet/pensando/ionic/ionic_lif.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/=
net/ethernet/pensando/ionic/ionic_lif.c
> > index 24870da3f484..b66c907d88e6 100644
> > --- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> > +++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> > @@ -304,7 +304,7 @@ static int ionic_qcq_enable(struct ionic_qcq *qcq)
> > if (ret)
> > return ret;
> >
> > - if (qcq->napi.poll)
> > + if (test_bit(NAPI_STATE_LISTED, &qcq->napi.state))
> > napi_enable(&qcq->napi);
> >
> > if (qcq->flags & IONIC_QCQ_F_INTR) {
> > --
> > 2.34.1
> >
>
> I think a better solution would be to stay out of the napi internals
> altogether and rely on the IONIC_QCQ_F_INTR flag as in
> ionic_qcq_disable() and ionic_lif_qcq_deinit().
>
> Thanks for catching this. If I remember correctly, this is a vestige of
> an experimental feature that never went upstream, and eventually was
> dropped altogether anyway.
>
> sln

Okay, I will try to use ionic internal flags like IONIC_QCQ_F_INTR.
And then I will send a v2 patch after some tests.

Thanks a lot!
Taehee Yoo

