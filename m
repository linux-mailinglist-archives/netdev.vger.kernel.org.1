Return-Path: <netdev+bounces-140523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6433A9B6C3C
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 19:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95F071C20C95
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 18:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C5A1CBE9B;
	Wed, 30 Oct 2024 18:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="ebIeaF5t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5E41BD9F4
	for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 18:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730313273; cv=none; b=G1JuK/cFzqSWX+3ybxLzlPebw/UGnjrQAT+VV+ugeKZzC2knwalATJHJ75dNx98mGJtGtBgGyRbVIp+BTgF/pnff2NSvxza7+pwZhpYU20V7PkK9XYkfGkyodadPM/pPrSgDbmvSSRuf2c0cNC+JvC+kj3DAbDuyJn3mj7g4iHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730313273; c=relaxed/simple;
	bh=E6cu9zg8SKIw/CtYh23N8/PR5WsIj5eBgUO/uLYYfD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=muRkcvb54kioppIVKXGZyOAJ8p4dKLY/llDrv7+NliRJbH/Ft6MAW15+2oN72xFlm1eiA3pIhpmxgllsnaAcAugm2juIif9hY7TnvAMEXjG/PR/oosZZqej1MBiWv8xCBp2VSLTx+R7fc/fEPztThFN+iMgske8862v5TyIaE4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=ebIeaF5t; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=zBGzzKw89CFjzrXJpSK2U4Xvs6z9fASj5aohHXX8tmc=; t=1730313271; x=1731177271; 
	b=ebIeaF5tGC3NIToZTqsJoXtFgiMmyRgYCIYYPT1WNuUxWChPk/lUMiI4Gwgfz4FjsQN1pizrx4u
	om69ymaFgnMT/dAvLg9FkdTiQyJL+d1L0PZeyDFp0IPRR2b50YgIhj9WS2O2DCVVYhG1IMMwsLO3C
	x3DG3mE60/ntXToj5sZWyDCZiPIX53J5YwKRIMP5305RBXkkpCXkAL/cde9kynjbsW9eL6FeDmd9t
	VTUHJAWizpYzbaUqecxEv/a3farKPXya6GakgKL6vLyt6z6/JK/XK+oPXsBLrkFqV5kIaJk+k78vI
	EC6ugbU/JB+lg+hvRVsFdPwMXHDushwgrkVQ==;
Received: from mail-oi1-f181.google.com ([209.85.167.181]:42334)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1t6DWY-0001kk-7j
	for netdev@vger.kernel.org; Wed, 30 Oct 2024 11:34:31 -0700
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3e6359ab118so78626b6e.1
        for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 11:34:30 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy+SaDMQYkd+CuSGraclV7TtgDpFf+O0G5WDUEKyAG9diheIaLF
	ZLO/8x3LrOql0LTYxzyRzQtnRC+O+5MFAlf027Rwlb8etILArpxCnNEiA9ATbx4jA2K5tZCPZyX
	YyBUJFnKlv9d4hrkUIu+UmvhZNUk=
X-Google-Smtp-Source: AGHT+IEjLwvSYOqg3YuWeinzugZ3RQ19UCVpmpb7AkUi1UhQxiYlW2D212gM1dR7jZe/aac3R3kf3jrE968XlSlqbrc=
X-Received: by 2002:a05:6808:2e88:b0:3e5:df4a:6113 with SMTP id
 5614622812f47-3e6529158e6mr4145659b6e.14.1730313269757; Wed, 30 Oct 2024
 11:34:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028213541.1529-1-ouster@cs.stanford.edu> <20241028213541.1529-9-ouster@cs.stanford.edu>
 <e99174c4-7c09-486b-b1f0-9c57b1582232@gmail.com>
In-Reply-To: <e99174c4-7c09-486b-b1f0-9c57b1582232@gmail.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Wed, 30 Oct 2024 11:33:53 -0700
X-Gmail-Original-Message-ID: <CAGXJAmwD-o7s7dvRbWLACuzsPV_UEwHotg2rpy8aCHeGf5390w@mail.gmail.com>
Message-ID: <CAGXJAmwD-o7s7dvRbWLACuzsPV_UEwHotg2rpy8aCHeGf5390w@mail.gmail.com>
Subject: Re: [PATCH net-next 08/12] net: homa: create homa_incoming.c
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: netdev@vger.kernel.org, edumazet@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: 6bee508a35d8245455fa42c2dd36c733

On Wed, Oct 30, 2024 at 11:23=E2=80=AFAM Eric Dumazet <eric.dumazet@gmail.c=
om> wrote:

> 1) kmalloc() can return NULL. This will crash your host.

Oops, that should have been checked. I will fix (and it looks like
there may be a few other places that need fixing also).

> 2) get_cycles() is not generally available, and can go backward anyway.
>
>    There is a reason it is not used at all in net.

It looks like sched_clock is the closest alternative (I need something
that is fine-grain and efficient)? I will switch to that unless
advised otherwise.

Thanks for the comments.

-John-

