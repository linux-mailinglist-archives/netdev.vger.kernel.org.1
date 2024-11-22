Return-Path: <netdev+bounces-146862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8C59D658D
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 23:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 715392821C8
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 22:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0142A18C01B;
	Fri, 22 Nov 2024 22:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OCf6HTb3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE99176ADB
	for <netdev@vger.kernel.org>; Fri, 22 Nov 2024 22:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732313443; cv=none; b=bFOLKL19b3M7sGlou3DtaVi3YKm33jb0QA+IzSNCOXGmvhROaUbCfrQxd7Ps6NfGdAtNMzFs7Vze3r0iFvwNsq9eP9ruXRVSSL5/WjtGNNSoL+9AgMdL5tLa5vvP9OariP/XGKPg3KDGh791EF/8J9YF4yBjG8+P+XSMsLcS2Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732313443; c=relaxed/simple;
	bh=JZZeaLOPwWolDY9YeQvGEW4vFzp1CUFGGaoHcATQS+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FqDf0aJUEnP3UxFPPCRssjgXs36sR84DyrI7ScqhUpa7IHiOkOkov7ya3mJQPg5/CfusGcBMmrPmIiUzfPOFwG5Xpy9jMopPB9fgXHuqs2Up50D+J/Nq+J2DKvctthwbNFOaKOWxMWkupqytQNH+2x9pDsvPcyqJDWxWSf7BKnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OCf6HTb3; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4315a8cff85so5455e9.0
        for <netdev@vger.kernel.org>; Fri, 22 Nov 2024 14:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732313439; x=1732918239; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JZZeaLOPwWolDY9YeQvGEW4vFzp1CUFGGaoHcATQS+s=;
        b=OCf6HTb3BlfUZchsEjgfCt3k9KyLwDX2+0yD6JyNh7B/LGOkIGiSiKRf1vsemgxz5Q
         ei/h3sIj7oDb5fxj5j9X4jmTPJDUwnjUtCOii6eIZl1YZWOCjrqJ7xqqehcEwlYFJ5Qj
         4mCfcY/PbAeXJhELvz940ycZLqq0OZ851hY5QBua8ABy/5tmds2uUyPnMuRsAv9Ickhx
         Bd72xZodUOgk1Fp+Hu1x/XIFGusqxYXqBznCSDGg7yU2NkOxde5bQrTSCJzAsRsUDbPL
         GPubEQIQhu3OkrkrQ52FpUTqfTsiQFdMm0U7IHxJLOYps1cUUizCCD/xehkDIj2iY+k8
         PjvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732313439; x=1732918239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JZZeaLOPwWolDY9YeQvGEW4vFzp1CUFGGaoHcATQS+s=;
        b=G/GNK9w5uEHxpD5Mbtue6ggfeV7Lhv4V3XMYd2K91uyt4yyR3zd2DyJ87CchYEj6gH
         VLjK/H8p7XzQ00A1j43uRE9DsMrifFT4KVbKvwa5M+Ak76yt1FvOfLDsYGDhTFIknbkF
         Q/5wXAj1MiAclB8Y1aoYU4OcXLXa7ZiJazGRXmR43oiCl2VfyU3lj27hLQwzNjelxQAV
         JCV1EtkDHcG1xfoBWcp3wfYHcYml8XJdBLvuR3xguqhaIkm1b9SQ6PoynPapOH005gFV
         UBdmZtQdt3mDiaXHbcQ7SX311VDb1Hy9PqdLE3jgleXuol4wKrk0DHbq1nHwfjzbILgm
         rIew==
X-Forwarded-Encrypted: i=1; AJvYcCV9+R+UQtfoj7nysChgcLqZUgV1FxBi2OnqeNFM1H8AOwep4Preex+pKn3Ic1TXqnXxkS1As5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHV23btJgsP4JbYnGKnoebToiRzfrhbxo0G+9p9KOHLkmylkdZ
	Otzo81FKOScvoXB22ZK+DCXHKeTcvZZpUGWd8zgQntWqYRqV9Oedh5K/mllD+srpTvpfhbxIiOb
	nF1kI11bcazU2iXVdV/y5VJY2I+by8C9QRr5m
X-Gm-Gg: ASbGnctx4rCMx1IjblCKrqc1Wio7QbiTCoM1kxE2ttRNKrf2u6wCB0fi4cCJ8XlLxj/
	z6yjF4kQw98C1yaSnbR2uY8ofnZe+LSpBqtGFaTEsqjcymkPLbMeTxN5P3GvRYVz7
X-Google-Smtp-Source: AGHT+IHn2hbKjIPF1ezTNxBktlxUIPal4HpKW8bNKzDZRuGjbsJ5nlIo3O6z2oBBfRs1YAwI2NOCc3Pjz55YD+M7Nrw=
X-Received: by 2002:a05:600c:3550:b0:431:416b:9ecf with SMTP id
 5b1f17b1804b1-4348be050b3mr350525e9.6.1732313439462; Fri, 22 Nov 2024
 14:10:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107212309.3097362-1-almasrymina@google.com>
 <20241107212309.3097362-5-almasrymina@google.com> <20241108141812.GL35848@ziepe.ca>
 <CAHS8izOVs+Tz2nFHMfiQ7=+hk6jKg46epO2f6Whfn07fNFOSRw@mail.gmail.com> <20241115015912.GA559636@ziepe.ca>
In-Reply-To: <20241115015912.GA559636@ziepe.ca>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Fri, 22 Nov 2024 14:10:28 -0800
Message-ID: <CAAywjhRb0Lb9fJocWBU1r01521sy71hLOaH=92gqceXqUOGHJg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 4/5] page_pool: disable sync for cpu for
 dmabuf memory provider
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, Pavel Begunkov <asml.silence@gmail.com>, 
	Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>, linux-kernel@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 5:59=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Fri, Nov 08, 2024 at 11:01:21AM -0800, Mina Almasry wrote:
>
> > > If you do this you may want to block accepting dmabufs that have CPU
> > > pages inside them.

I believe we should be following the dmabuf API for this purpose, if
we really want to sync for CPU in. page_pool, and should not assume
the behaviour of the backing memory.

The dmabuf exporters are supposed to implement the begin_cpu_access
(optional) and the sync for cpu is done based on the exporter
implementation.

For example udmabuf implementation calls `dma_sync_sg_for_cpu` on the
underlying pages.

I think following dmabuf APIs can be used to ensure the backing memory
is synced:

Before cpu access to sync for cpu
`dma_buf_begin_cpu_access`

After cpu access to be synced for device
`dma_buf_end_cpu_access`

Sami
> > >
> >
> > How do I check if the dmabuf has CPU pages inside of it? The only way
> > I can think to do that is to sg_page a scatterlist entry, then
> > !is_zone_device_page() the page. Or something like that, but I thought
> > calling sg_page() on the dmabuf scatterlist was banned now.
>
> I don't know. Many dmabuf scenarios abuse scatter list and the CPU
> list is invalid, so you can't reference sg_page().
>
> I think you'd need to discuss with the dmabuf maintainers.
>
> Jason

