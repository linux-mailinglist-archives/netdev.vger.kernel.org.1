Return-Path: <netdev+bounces-60230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D93A581E4B7
	for <lists+netdev@lfdr.de>; Tue, 26 Dec 2023 04:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 457FF282BFB
	for <lists+netdev@lfdr.de>; Tue, 26 Dec 2023 03:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757E4107B3;
	Tue, 26 Dec 2023 03:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U4J1fql2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A82C1078E
	for <netdev@vger.kernel.org>; Tue, 26 Dec 2023 03:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703561559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ph9pqyH1SKt/ykslqZ05q7LYqXwWOYyL1VmFIBCy1cs=;
	b=U4J1fql2wjqPXeNYpOrAh9qirGPZAUcqRCELVrm5hYFIHNtZzovJuwMwWCsC/iLGcb5aRl
	xA8P8l0qhFO290RENJTfgPLKPmhFqxIl3gQc3LYY10FzHFAI6gAsL/xRpSAH05S0pwTfHA
	TlsaK2NTGB2de9ugj048wDfggqWbYqA=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-cZtk6LyyMCyVVX_QGj6_lQ-1; Mon, 25 Dec 2023 22:32:37 -0500
X-MC-Unique: cZtk6LyyMCyVVX_QGj6_lQ-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1d09a64eaebso39795295ad.3
        for <netdev@vger.kernel.org>; Mon, 25 Dec 2023 19:32:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703561556; x=1704166356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ph9pqyH1SKt/ykslqZ05q7LYqXwWOYyL1VmFIBCy1cs=;
        b=vr38kAQAHZfysK3K7LNYtnLBjRYp4ixUdOc4u0AktrYdgb1ENdkOeo3aX70u9Ui+QD
         waXm9zHOEmrcYZFV2KJQG2pub0KxZ8+3h/bL5XhGROrEEVxza9pRjGDDBTNmJwoMiO2s
         mqmBjHt0Fx1NtXrT1rcVFbklpJpxrP9Mun42gJp2NdFgZ2DOHAslTGStBA3UOt22V7Ib
         b+U0ZrCzkVcRTVrEli2HZera8cj+RkiKL6t42fRBj7YwMT4SOZ/tb3PsDw+5Yb0vQguI
         bJWshHfUSO5cG3/lMS4geey1YsbmjYYG92b/kKFAylqFgpKk40tprjCVMJnqjsAqoTei
         Cw/w==
X-Gm-Message-State: AOJu0YxWCdeOifHbaFaGibvknmagTV36l7tfKPG4TSOXg6PmxJDbKpKI
	YbWSQTdtwnfvyoK9l/Buld7LAXY2PlaPCIGnBsMVzL/63FRcrhq7iKJvjmKr2Ndx6xsJ7Oe+Z/c
	mSjiB+v6E1sCpfSYHDXA8ghMviB5mfksNvcZZaRI1
X-Received: by 2002:a17:903:124d:b0:1d4:69a5:edbb with SMTP id u13-20020a170903124d00b001d469a5edbbmr1426744plh.48.1703561556468;
        Mon, 25 Dec 2023 19:32:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IERAn1+duEGCL81U434Oigr4BxdRwF+MbGMw6zhv+eHeSmA8fvL2MRrv0cQH7UGDE2MpsZdeQ0V7zpgkVbj1tg=
X-Received: by 2002:a17:903:124d:b0:1d4:69a5:edbb with SMTP id
 u13-20020a170903124d00b001d469a5edbbmr1426729plh.48.1703561556191; Mon, 25
 Dec 2023 19:32:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f9f7d28624f8084ef07842ee569c22b324ee4055.1703059341.git.hengqi@linux.alibaba.com>
 <6582fe057cb9_1a34a429435@willemb.c.googlers.com.notmuch> <084142b9-7e0d-4eae-82d2-0736494953cd@linux.alibaba.com>
 <65845456cad2a_50168294ba@willemb.c.googlers.com.notmuch> <CACGkMEthxep1rvWvEmykeevLhOxiSTR1oog_PkYTRCaeavMGSA@mail.gmail.com>
 <20231222031024-mutt-send-email-mst@kernel.org> <CACGkMEsZDYFuvxgw63U5naLTYH5XNwMTMNvsoz439AWonFE4Vg@mail.gmail.com>
 <20231225025936-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231225025936-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 26 Dec 2023 11:32:24 +0800
Message-ID: <CACGkMEsJQv=KoU0UiPNM_CkaqHf=uLRONdDB36=y80=m_jwONA@mail.gmail.com>
Subject: Re: [PATCH net-next] virtio-net: switch napi_tx without downing nic
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Heng Qi <hengqi@linux.alibaba.com>, 
	netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 25, 2023 at 4:03=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Mon, Dec 25, 2023 at 12:12:48PM +0800, Jason Wang wrote:
> > On Fri, Dec 22, 2023 at 4:14=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Fri, Dec 22, 2023 at 10:35:07AM +0800, Jason Wang wrote:
> > > > On Thu, Dec 21, 2023 at 11:06=E2=80=AFPM Willem de Bruijn
> > > > <willemdebruijn.kernel@gmail.com> wrote:
> > > > >
> > > > > Heng Qi wrote:
> > > > > >
> > > > > >
> > > > > > =E5=9C=A8 2023/12/20 =E4=B8=8B=E5=8D=8810:45, Willem de Bruijn =
=E5=86=99=E9=81=93:
> > > > > > > Heng Qi wrote:
> > > > > > >> virtio-net has two ways to switch napi_tx: one is through th=
e
> > > > > > >> module parameter, and the other is through coalescing parame=
ter
> > > > > > >> settings (provided that the nic status is down).
> > > > > > >>
> > > > > > >> Sometimes we face performance regression caused by napi_tx,
> > > > > > >> then we need to switch napi_tx when debugging. However, the
> > > > > > >> existing methods are a bit troublesome, such as needing to
> > > > > > >> reload the driver or turn off the network card.
> > > >
> > > > Why is this troublesome? We don't need to turn off the card, it's j=
ust
> > > > a toggling of the interface.
> > > >
> > > > This ends up with pretty simple code.
> > > >
> > > > > So try to make
> > > > > > >> this update.
> > > > > > >>
> > > > > > >> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > > > > > >> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > > The commit does not explain why it is safe to do so.
> > > > > >
> > > > > > virtnet_napi_tx_disable ensures that already scheduled tx napi =
ends and
> > > > > > no new tx napi will be scheduled.
> > > > > >
> > > > > > Afterwards, if the __netif_tx_lock_bh lock is held, the stack c=
annot
> > > > > > send the packet.
> > > > > >
> > > > > > Then we can safely toggle the weight to indicate where to clear=
 the buffers.
> > > > > >
> > > > > > >
> > > > > > > The tx-napi weights are not really weights: it is a boolean w=
hether
> > > > > > > napi is used for transmit cleaning, or whether packets are cl=
eaned
> > > > > > > in ndo_start_xmit.
> > > > > >
> > > > > > Right.
> > > > > >
> > > > > > >
> > > > > > > There certainly are some subtle issues with regard to pausing=
/waking
> > > > > > > queues when switching between modes.
> > > > > >
> > > > > > What are "subtle issues" and if there are any, we find them.
> > > > >
> > > > > A single runtime test is not sufficient to exercise all edge case=
s.
> > > > >
> > > > > Please don't leave it to reviewers to establish the correctness o=
f a
> > > > > patch.
> > > >
> > > > +1
> > > >
> > > > And instead of trying to do this, it would be much better to optimi=
ze
> > > > the NAPI performance. Then we can drop the orphan mode.
> > >
> > > "To address your problem, optimize our code to the level which we
> > > couldn't achieve in more than 10 years".
> >
> > Last time QE didn't report any issue for TCP. For others, the code
> > might just need some optimization if it really matters, it's just
> > because nobody has worked on this part in the past years.
>
> You think nobody worked on performance of virtio net because nobody
> could bother?

No, I just describe what I've seen from the list. No patches were
posted for performance optimization in recent years.

> I think it's just micro optimized to a level where
> progress is difficult.
>
>

Maybe.

Let me clarify what I meant.

If people can help to optimize the NAPI to be as fast as orphans or
something like 80%-90% of orphans. It should be sufficient to remove
the orphan path completely. This allows a lot of good features to be
built easily on top.

To me, it seems fine to remove it even now as it breaks socket
accounting which is actually a bug and NAPI has been enabled for years
but if you don't wish to do that, that's fine.  We can wait for the
coalescing and dim to be used for a while and revisit this.

Thanks


