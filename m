Return-Path: <netdev+bounces-214855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A85B2B749
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 04:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 536D31B60E50
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 02:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1B4288525;
	Tue, 19 Aug 2025 02:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M00/pavj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2AA28725E
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 02:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755571738; cv=none; b=OWotxWmaSwkxcJJXh2DEVJshE1N/9XGwKoo9txHdFUyZabuDzc5uF7LsYbbrwkeLYPl+fHyvWWJVipQ6je5Ky+R0RVVIIS9zSscRhxG3JQShFB7mEUHcCGaf23sNWE+7WbR4RThUkTt3hS0LifQBEn3nrmSjhu1scS5oq+SAj5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755571738; c=relaxed/simple;
	bh=rKki1UBfO66wOspZuH0gsX0riYu6EtAjgPc5TTW/K7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DDz/hri5jL1oYVeqIvWY/PX+Zka6rFpLmP0ReMAid/IkEfrBP6e8nF+3V/+4HSI9QpN9LQRiV6wC+J+8Oy9UTfe3bi3clri2iZqW9BMnMavmLA5DIPtWWYHjTBQLMVoEi2pUfMiHh8aFg1Zltf1sBEJNe0k7vc4i/LDfre+gmuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M00/pavj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755571735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rKki1UBfO66wOspZuH0gsX0riYu6EtAjgPc5TTW/K7M=;
	b=M00/pavjlU8vzskX9xzbXJjKq2utamOvyhWXQN9ZX7zwAJfLcqCXkjU/F58+7Q0+4px+lu
	dGAoJkQwM0PR96Vwa4rl1tS+c5QlNTWfFGvErV3ECXlTlx0dj6g5Mwi5SWHhdMcbp7/1dE
	fmlbPgXzUmG8QpYL62J+ZlBnT1VrtQM=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-_pt5mgz5OuyCdojTFTX0pg-1; Mon, 18 Aug 2025 22:48:53 -0400
X-MC-Unique: _pt5mgz5OuyCdojTFTX0pg-1
X-Mimecast-MFC-AGG-ID: _pt5mgz5OuyCdojTFTX0pg_1755571733
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3232669f95eso4640541a91.0
        for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 19:48:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755571732; x=1756176532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rKki1UBfO66wOspZuH0gsX0riYu6EtAjgPc5TTW/K7M=;
        b=ZBVNit02DmCObLMSVU21UXeSC37dliS/gdSyR4Pecz3AM+KGQPNnDDO99rrM20lQMY
         WrwPNUG07CX4ZJvCTliZ2z3n5WsEFHJMO3+yuEW1dX1au2TdOZMng2y/9BDiOFExBHrE
         PvwICI5/LMnoo9BvMN6HZug+42LZk/ygeqir/MZAr07iXryIWDBTB3WSr/LqSkF7cvzF
         nM7VezPzhygUThTIya0omrSf6jOS1jqXURUrjMzLu0i0AAcZUXBpTCp4V9lR8BtUhJIp
         iBp/6hdXzHQEqfC4kyEpLf2sdnE7ikF0tjK73e3K2rQa/M2ldwpMHoFVZn0AB86vjMWy
         5Cyg==
X-Forwarded-Encrypted: i=1; AJvYcCV5TybYGcODEeFW8nxcbI9fwqHTNJsT4AMxs7ZLZ8GumWXSkwe59ZKR3BxKShIbrCqYH5BQcyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyITx0175KtXgEQrN3azS5diFGDuZxhhq5o0mrc81JTSsa7zAX4
	mNf++6OkKhuZpno8p5BWyMOdl8AdxRshK+T4VQqV4MFOCKLRmb44q4wpqhFXSaIEQSscv/T8FGm
	nEhYaiWQIEASjMFQ5t4fGwVdriVy+pgyuG9tsiRnJRL5g1nJ5DTvQ7GZyhZ6MPn/z6VB/oKX8uD
	HbbaX+a6Ry2ydCPF7M4o5/yRAUxVrMnx2C
X-Gm-Gg: ASbGncvOrAntn+MrSo+kRZ0Ha4FL8kKMcZlal0ERwa7s4fEV1MRuK9lCU6enMAUT+pC
	zBOQSqsV1K3O2MT9ZUQnZBxOZkh7UG2del4vGrKFg6AO4AWv5CMbV8detliIEaUXEsjT4Nr3KW/
	ANXMLikB/yUoGNgoT75fMeTu0=
X-Received: by 2002:a17:90b:388c:b0:2f8:34df:5652 with SMTP id 98e67ed59e1d1-32476a6c3b0mr1536789a91.21.1755571732538;
        Mon, 18 Aug 2025 19:48:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6dKD0oWKP+FU214PIKLYVdhY8eEWItrOTXjcxGw6l+G1j5qcpIfVxj44ZLVtPTiZnrRSk7uCddgfYxZ/3F0A=
X-Received: by 2002:a17:90b:388c:b0:2f8:34df:5652 with SMTP id
 98e67ed59e1d1-32476a6c3b0mr1536750a91.21.1755571731921; Mon, 18 Aug 2025
 19:48:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815085503.3034e391@kernel.org> <CGME20250818011515epcas5p21295745d0e831fd988706877d598f913@epcas5p2.samsung.com>
 <20250818011522.1334212-1-junnan01.wu@samsung.com> <20250818083917.435a4263@kernel.org>
In-Reply-To: <20250818083917.435a4263@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 19 Aug 2025 10:48:37 +0800
X-Gm-Features: Ac12FXwGjt0tc43brXAcZucIny41hc0azUrrUQ6OWLOA5fDrbWEhAZEnJ-HtEtw
Message-ID: <CACGkMEsVJcb2YYvfXYA0soE++cPEmQatkC0tB+shNKB=OTteWg@mail.gmail.com>
Subject: Re: [PATCH net] virtio_net: adjust the execution order of function
 `virtnet_close` during freeze
To: Jakub Kicinski <kuba@kernel.org>
Cc: Junnan Wu <junnan01.wu@samsung.com>, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, eperezma@redhat.com, lei19.wang@samsung.com, 
	linux-kernel@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, q1.huang@samsung.com, virtualization@lists.linux.dev, 
	xuanzhuo@linux.alibaba.com, ying123.xu@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 11:39=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Mon, 18 Aug 2025 09:15:22 +0800 Junnan Wu wrote:
> > > > Yes, you are right. The commit of this fix tag is the first commit =
I
> > > > found which add function `virtnet_poll_cleantx`. Actually, we are n=
ot
> > > > sure whether this issue appears after this commit.
> > > >
> > > > In our side, this issue is found by chance in version 5.15.
> > > >
> > > > It's hard to find the key commit which cause this issue
> > > > for reason that the reproduction of this scenario is too complex.
> > >
> > > I think the problem needs to be more clearly understood, and then it
> > > will be easier to find the fixes tag. At the face of it the patch
> > > makes it look like close() doesn't reliably stop the device, which
> > > is highly odd.
> >
> > Yes, you are right. It is really strange that `close()` acts like
> > that, because current order has worked for long time. But panic call
> > stack in our env shows that the function `virtnet_close` and
> > `netif_device_detach` should have a correct execution order. And it
> > needs more time to find the fixes tag. I wonder that is it must have
> > fixes tag to merge?
> >
> > By the way, you mentioned that "the problem need to be more clearly
> > understood", did you mean the descriptions and sequences in commit
> > message are not easy to understand? Do you have some suggestions
> > about this?
>
> Perhaps Jason gets your explanation and will correct me, but to me it
> seems like the fix is based on trial and error rather than clear
> understanding of the problem. If you understood the problem clearly
> you should be able to find the Fixes tag without a problem..
>

+1

The code looks fine but the fixes tag needs to be correct.

Thanks


