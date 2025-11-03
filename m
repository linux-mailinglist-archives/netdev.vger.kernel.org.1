Return-Path: <netdev+bounces-235158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EB7C2CCF0
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 16:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2D4774F66B1
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 15:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CEA322A27;
	Mon,  3 Nov 2025 15:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h6RbVYcN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79F4322755
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 15:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762183615; cv=none; b=gZWyntNKQXBPftrUdzvJxykCDE83OD1lkzE60tseeHfvWrGPry5jBhKexqulpKj733g9Qub97kim/umIVdCiiRLKjivxlVWQIx9O09zZZ7uTj5K0p+yC8OhDwjp01EnC6Na9sMEvh2FZGcBikdX6iWwnbsg4PMkP93D5/w7CmEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762183615; c=relaxed/simple;
	bh=HtYPErm+lcPCQ8/H+Y+ENMRB8yN0YIO5X53KhPaEGXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PMnlQyDvRs+PVpPHYuz3V8yhGJ/AypLK7qR9XaLc54FIKHjiZX/BobRqDFSHhNvqc0KsSqGgm6YcMSCP6haNkqie7FHwvqdImjbaq05n6AbR0pE6lRgdZzfnnzmwmapIqJdYaTHmjW/hBhiRrjSMmmBcgN60nEn8LpOvBCvMthI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h6RbVYcN; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4eceef055fbso80216671cf.0
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 07:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762183612; x=1762788412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZSWiwQJqc6XKle7yFUK9dQujqeGGNiGFVFQdXE3oOQ=;
        b=h6RbVYcNhwwUm2G9CcQJxTmdfbqysAAPARcEyCTFru87tdxqP7hUqcYKCqb8bmmdwt
         CH43VrHdwAUvGP8m7xMBpWKncVcE/hpVScN3T+RkA+SpNTLpitPYx0hXEsW3A4F+6OMJ
         +iV6H+BnHolpbWhpjfT5vpPxOKYjCmLw22TKvugMJgmbuFzWU4FtY1KaplcdSlUuY4IL
         AjQ5JMC5DDg/wUjy9lL8rW5ys23PToIXQG/vd22F7o4LmGMZWm3eqoS56dTQkYhkzlXt
         wfgwgUGNcxGkH3I5Re+bkuBwu/uWE8/aMKQTtUgM2u2VvbQ91zNvAAngoAWIEM6rgzuu
         NCUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762183612; x=1762788412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GZSWiwQJqc6XKle7yFUK9dQujqeGGNiGFVFQdXE3oOQ=;
        b=l1tWqothTbvBQG5heUbNj95Ts1aGbaEb7Bxvze5ArTpH5LTZlTAQfduuz73QXJSaC/
         oOorjrHszd6jEinq/QEDeROrflSCaVMuhP9F2UZ3F+EXZ3XHtmIDqIISS2CvCmtJMfgQ
         xHTO89v62DksRhsxJv384cLChXPgGLq9CrNn8E3Ru47EMBjxVWyDKJ7VUuDawZ4dwEzQ
         lyGRvi7HVDHdFA6MAmZGzp5VtmrP+8IpJ4UyGbdSzYQKYUBLsnNL6mO3cLRsI1lnpAkn
         xA1IHn5pa9SAS2xi8xa6q9Ji0RtrEtrSJWj3f84I0vieivU41Jivy6eBi714+HBtP6cg
         GOSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqGKWbP1hUNGovSFDMdeFq0pS2LlIUj1TqESwvkWoy5Bm4614mxxRxMRZuiQzfkMy/AeSRJ6E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+RtVHFPG5AMScRV3xsN5kigtca6WSB8LksatSX0j1iHAK9Jkq
	RYuC/r5AKc0QchlKBi+Kpr4rcC3tNIBI9cmXL9x7iwXMiRQIm8G9PsQWgeehddkzH/s+yaQhz86
	D52v3OWOJPUkY7YV/zm5sLvNRx/jP0DUQZhGVwyce
X-Gm-Gg: ASbGnctwb06cRzwYZ9UpNkcM4xQaP6hwcMuAWCDv6jVAF8rLC6oPAQtms3z3uBYJO9j
	qdEenIXlKO7m7/2HBOAqJuYPt4+htbLef2Q+mR8GqojFE39SrGmsWhOj1CYPNiXw93wx6t03CH1
	fWmsM3SIxjOCP2AGUHVXd5fmKPUTatytQQ2gWqgROtnGCN6RdICKU5S6DG5/nlyicQrBpJxJLfv
	ZGN4qzz0rXxTVZH3TFUnC/vJFcJxkmroaCKVbkMsNXUcDFBFTP9udPodxylt/apBK6xGA==
X-Google-Smtp-Source: AGHT+IF+mGJu8f1sIqdbKIgmUXDm3aO7KzyDpfzDBD3k3+tS1nf7R8zcW/+SyzIacTciXf8ui1YRp56XzAYhwO3skb0=
X-Received: by 2002:a05:622a:2591:b0:4ec:f4be:6b12 with SMTP id
 d75a77b69052e-4ed31073e8cmr165852591cf.72.1762183612241; Mon, 03 Nov 2025
 07:26:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009094338.j1jyKfjR@linutronix.de> <66664116-edb8-48dc-ad72-d5223696dd19@nvidia.com>
 <CANn89iKvgROcpdCJu726x=jCYNnXLwW=1RN5XR0Q_kbON15zng@mail.gmail.com> <20251103135918.mieB1dYO@linutronix.de>
In-Reply-To: <20251103135918.mieB1dYO@linutronix.de>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 3 Nov 2025 07:26:40 -0800
X-Gm-Features: AWmQ_blK-HQjVUx7Fz1ixHyCR3tPrcYSWynAmxPxVZjLtzwD4YwWomDo3bMRYAI
Message-ID: <CANn89iJaf3qwTL82qJyDx1_Eq0RAQuprdy7CyiRd8YWoXD=Vzg@mail.gmail.com>
Subject: Re: [PATCH net] net: gro_cells: Use nested-BH locking for gro_cell
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Gal Pressman <gal@nvidia.com>, netdev@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, syzbot+8715dd783e9b0bef43b1@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 5:59=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2025-11-03 04:36:45 [-0800], Eric Dumazet wrote:
> > Adding LOCKDEP annotations would be needed (like what we do in
> > netdev_lockdep_set_classes()
>
> You mean something like
>
> diff --git a/include/net/gro_cells.h b/include/net/gro_cells.h
> index 596688b67a2a8..1df6448701879 100644
> --- a/include/net/gro_cells.h
> +++ b/include/net/gro_cells.h
> @@ -10,6 +10,7 @@ struct gro_cell;
>
>  struct gro_cells {
>         struct gro_cell __percpu        *cells;
> +       struct lock_class_key           cells_bh_class;
>  };
>
>  int gro_cells_receive(struct gro_cells *gcells, struct sk_buff *skb);
> diff --git a/net/core/gro_cells.c b/net/core/gro_cells.c
> index fd57b845de333..1c98d32657e85 100644
> --- a/net/core/gro_cells.c
> +++ b/net/core/gro_cells.c
> @@ -88,6 +88,7 @@ int gro_cells_init(struct gro_cells *gcells, struct net=
_device *dev)
>
>                 __skb_queue_head_init(&cell->napi_skbs);
>                 local_lock_init(&cell->bh_lock);
> +               lockdep_set_class(&cell->bh_lock, &gcells->cells_bh_class=
);
>
>                 set_bit(NAPI_STATE_NO_BUSY_POLL, &cell->napi.state);
>
>
> > Or I would try something like :
>
> I'm fine with both. I can provide a patch body for either of the two.
>

LOCKDEP annotations should be fine, thank you !

> Sebastian

