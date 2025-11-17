Return-Path: <netdev+bounces-239079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5D5C638CF
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 11:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6CDB84F607A
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 10:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F6E2D47E4;
	Mon, 17 Nov 2025 10:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ffXqzCbi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA1828506C
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 10:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763374914; cv=none; b=nNlSwLMwj4ZIsqYzSpiutvzZztV53CDbhxLhdJrGmmYsn6JyBBitE4NisE3fNek8EI48G+Y6pZXYa++tqe3XBTOepMWQ3ZCJ69SkVd9I632Ka1+b0TE0PQL47d+4h+go28EY7U8DLCqAKXDzDZXXR/SXtEql+fvy6CzyzEwa13g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763374914; c=relaxed/simple;
	bh=CscepbcOC8+QzaBdcyDmuDNMM7WVrlZmU0atPfWVUdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hRMatt3LNlroOwlFqOCFzIeoYJl631uR3hV4obqMizZ/pCx4pzawfPk8zOOvhfkUH0VcRc5QIhOQXPl/tVrXoqysaqQDSp9K4dU3DZvvmzKt9Y3n9QxKZMtZ7RubIz2cRI5G5Wo4f95HWjGS91FsACnkLDV1IgzlMEp/FARsrUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ffXqzCbi; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4ee2014c228so6332401cf.2
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 02:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763374912; x=1763979712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CscepbcOC8+QzaBdcyDmuDNMM7WVrlZmU0atPfWVUdI=;
        b=ffXqzCbiqDP92IyKiDiYvM9J/YeTgdd+iFHRHjxlOzSVeERVhi3SDxvBXmGHZspN6t
         i+Z9baPwov4/webpt7RxOMp2ykf+VmiuKjeTA+nEPy4MmMh2F8TQt2GKsBdSjLTm30JQ
         kgnqMzdp2RIccIyoj6jv6TpvemQBhymfcU2qdQTH6ljcG7So9H0Uv5Tkf+I8yeNWS8Jt
         rGfrpBx1EU24Zqnr35tEM/6do4Tx6V/CZFsrEd7E9R80fRvmG4G6twT9YwUVUa2QdbS0
         MihGszn2kQ/D4m0FkQ+KzDM9qAD2+n041fgn3XMjYEc2HN0mhWfPJJD5+qAm01j8ciMS
         MTcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763374912; x=1763979712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CscepbcOC8+QzaBdcyDmuDNMM7WVrlZmU0atPfWVUdI=;
        b=bdR5ypnJuRQ5C+3lQBDJ4ylEAUqvRS5lNVnOzd0zA7qOtE1RCBExsSNsOOQjjqVL7Z
         Y4IlDbSec9TKS9q02Xr1BTO+VQbCEwvM8RCiV+kMIBzdCCuRkACuUhKtx2+XA0Dz8JS0
         xqINcp604a6VZe8fudKiZYsCyEt3yXgVHnWjjIabxRG/x91gf+sxBr2ZBxpJsFiuC704
         ZMqPS6h5EPo7vORMp84OvZ5qyrR94xb4bpHQgye1ZJrkpW5ulc6p5+rqd7nwJKSF+xqH
         fQ1L8CZu4gwJVkNX3rwsWA9Z1R9exnbTihVlqmlP15O+cjhCXpCJmaAV0GfAdg57Zp2T
         CLiw==
X-Forwarded-Encrypted: i=1; AJvYcCXEE8gJiL47o64gVO9xm9dnAXwYsVFpP7o/M6jasY0kXT3BFxA6VnR/JBsJ+Nm0iSP1Fbmiaow=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8lBOJiVGyw85Z8lgCLgsQ908+OlQtNHHmTAzoVvbJKQq0Mz0u
	mENAM5nDNEOs9rKkITKqiaQ1HewZDXj963awvY0wnXk5E8YTtWogsWC1Evr4UTqS3Q6rzaWh+cF
	wNww81Gs7g74OjCoXWPVvJcq2jvmkaHs4U0+umXZ2
X-Gm-Gg: ASbGncuh5CAd3qsAUVmSxuFr3ooGAaQBX/VDaTlFudL8sAxGAU0XvibbSyLGyXyCDVr
	0cTXhnHcoU8Lt02jugOLBssgBdIZdScx2CqFJI2huMxSAlSDQC/n8PpOmH3ebTbTmTIB67VqbeA
	XS1e9CW3pZJ0eqJm88XvAKITtmjQdTcCHSezRcSRQ2ZEDV8pBedz91tG7Z+91kJSy1vL+2rwD47
	WPqFBk2SpfnGaGLy7YeWkL3BXSY3NSORFNSZCUCwaRiX4Xp+6lITtChKAvh7Mopo73sB/U=
X-Google-Smtp-Source: AGHT+IFuyeGLLK13zsnocUzaJFJkkgmncQZ5EJyPpMfJYBBiLNIQzzaWJF6Xzmc1TFVxKe5vOTDTGf7jMugC9Qgz+cc=
X-Received: by 2002:ac8:7dd3:0:b0:4ee:2541:6540 with SMTP id
 d75a77b69052e-4ee2541b583mr19702501cf.55.1763374911520; Mon, 17 Nov 2025
 02:21:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117100745.1913963-1-edumazet@google.com> <c378da30-4916-4fd6-8981-4ab2ffa17482@kernel.org>
In-Reply-To: <c378da30-4916-4fd6-8981-4ab2ffa17482@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 17 Nov 2025 02:21:40 -0800
X-Gm-Features: AWmQ_bnU5NstPoC22fhtPKBluYRKne26knFThnGv-8-dn_lLDtNWHNSVtBVnj30
Message-ID: <CANn89iLxt+F+SrpgXGvYh9CZ8GNmbbowv5Ce80P1gsWjaXf+CA@mail.gmail.com>
Subject: Re: [PATCH v2 net] mptcp: fix a race in mptcp_pm_del_add_timer()
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang.tang@linux.dev>, 
	Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot+2a6fbf0f0530375968df@syzkaller.appspotmail.com, 
	Geliang Tang <geliang@kernel.org>, MPTCP Linux <mptcp@lists.linux.dev>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 2:15=E2=80=AFAM Matthieu Baerts <matttbe@kernel.org=
> wrote:
>
> Hi Eric,
>
> (+cc MPTCP ML)
>
> On 17/11/2025 11:07, Eric Dumazet wrote:
> > mptcp_pm_del_add_timer() can call sk_stop_timer_sync(sk, &entry->add_ti=
mer)
> > while another might have free entry already, as reported by syzbot.
> >
> > Add RCU protection to fix this issue.
>
> Thank you for the report and even more for the fix!
>
> > Also change confusing add_timer variable with stop_timer boolean.
>
> Indeed, this name was confusing: 'add_timer' is in fact a (too) short
> version of "additional address signalling retransmission timer". This
> new 'stop_timer' boolean makes sense!
>
> > syzbot report:
>
> (...)
>
> > Fixes: 00cfd77b9063 ("mptcp: retransmit ADD_ADDR when timeout")
> > Reported-by: syzbot+2a6fbf0f0530375968df@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/netdev/691ad3c3.a70a0220.f6df1.0004.GAE=
@google.com/
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > Cc: Geliang Tang <geliang@kernel.org>
>
> The modification looks good to me:
>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>
> While at it, just to help me to manage the backports:
>
> Cc: stable@vger.kernel.org
>
> > v2: Updated/Added Reported-by:/Closes: tags now syzbot report finally r=
eached netdev@ mailing list.
>
> Out of curiosity, is it not OK to reply to the patch with the new
> Reported-by & Closes tags to have them automatically added when applying
> the patch? (I was going to do that on the v1, then I saw the v2 just
> when I was going to press 'Send' :) )

I am not sure patchwork has been finally changed to understand these two ta=
gs.

>
> I don't mind having a v2, it is just to save you time later, but maybe
> there is another reason.
>
> Cheers,
> Matt
> --
> Sponsored by the NGI0 Core fund.
>

