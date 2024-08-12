Return-Path: <netdev+bounces-117795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA0794F5A3
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 19:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 698E01F21D8E
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 17:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D175B187845;
	Mon, 12 Aug 2024 17:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crHiI3oK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426151804F;
	Mon, 12 Aug 2024 17:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723482658; cv=none; b=ezJLKN6EppKrolXPOk9LjSkAbMBzDGwISBs+buYEGcZ/YvcqlGjRzuTcstlS3LCaaU26LKjXvOXoqYvDsMe3VUaU6OlsnMcCGRG1PW/TMzRkO6S0HAzPCKREkRZQ3LigyLxX+r9LbzTrU4CD3o8GcDZx2FnzzUlnFVODwt4Vvio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723482658; c=relaxed/simple;
	bh=rsXNiVZEMLxYlpUNFpH7EKzqHYn6sLglPcCzTO6pebc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=W0ehnDBE1IqOCINwiTWN/nVpBxAoSKpbzA9+wdxApuotUUe476CliJXua1ZvDj9Zkyni2oX6plBMPyfdjKadkC6vVR2GA/V82a5vzMnyVDviIlY+c5RSDPzK22RGXcQaOlvW31ExzVVGUF7ejRMifGT+VpdtKCcN9t+ix/JPlqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=crHiI3oK; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-45007373217so46604561cf.0;
        Mon, 12 Aug 2024 10:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723482656; x=1724087456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5GmlbQLiHR38r1gA1FeIC/Lbp6kj8sG7wzB37JoxXC8=;
        b=crHiI3oKvxkOk9CMJMw1MTBhlLMYMXskOkNXfS1jqFMHFdXRZIwjZl4V6rEz8Or9EL
         L3kqnf6SheUMPe7KkPCVcvQ/j+3s+ggmOsK8ZEGupHoZR0hUa/Gl9Ubsb+tiyox59G01
         Dfs6KZLA8UlBXTNGmPd+Ccp7Jjm4ZOhqxrNqTp+JMJmDyiMILinze7xx7a8r0CRBsirP
         xTQbs4zp3IGH/RGTO9uOiGdXYc8DiDGQ1hanVCx6Hq18mY2k5LsshfLCGcqos7/h3Ir2
         Lbwfo7dqLZEwuI600sMHaUUnYzz5uESXuQCDgA+WH/UUhMa7WwFU9E0TQWtrs6PB7on1
         VDSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723482656; x=1724087456;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5GmlbQLiHR38r1gA1FeIC/Lbp6kj8sG7wzB37JoxXC8=;
        b=Ha2sEjZWflkzZ1gfT71VwuSpixT6EkiettMifWytq9iH5KhxSkhbNeLcEe1ic1j207
         caNi9gyt0T8FijlC/W/dZDS6Kd/FJciItf5xdzRIXYvC8QjBNNYwVrVGoXk9PHVDaUuU
         CKx2GmaGSkS9TuUHNfwBd/eJAFU62Z3/R2O8v4wTPykpJX1xlLGRScXOkmm6FFR9QYb2
         gcTHrDHeLQjhFLJWiNFUYncslFrDQIMCQULA5XQPg3/Okc4y/JmCfHyC4EIaC9105XUI
         +V5Kj7yJR/xGrhWF8cO9QPzAZBuLUVc6eslNXGFlPO3J5o4+vRTSKeCuIR+gRgMimZn1
         JM5w==
X-Forwarded-Encrypted: i=1; AJvYcCX3vLTn3UXHznLPjbOTT++iFmYijKq3HPyoGmt/635AHlVTXmk3hlCNi33D5alWvVdixWo9qBKjkamaknTu+Mo5yFIwPDaN0Di4356+B+MwljQo50I+z2UpcJaMiL6+dBAdWVIQ
X-Gm-Message-State: AOJu0YzSEdktHCbju9Bv75rTwpc5pR5tbJSa0YoF9F157xU8dQjhURsP
	ECWHdc9BuHUs7H8eXHBD3r5zAjb79lR45d91y8MfvchR1UtDhdSk
X-Google-Smtp-Source: AGHT+IFLcYDav0KVXMN2KfEHyhEXk3F31X4SDAF5U3UE9px7N1cCuNLgoAAoBeZCOyO3l5iMHbR5Rg==
X-Received: by 2002:ac8:6887:0:b0:446:59db:9184 with SMTP id d75a77b69052e-4534cb4fd53mr4799531cf.22.1723482655960;
        Mon, 12 Aug 2024 10:10:55 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4531c26dc23sm24810601cf.75.2024.08.12.10.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 10:10:55 -0700 (PDT)
Date: Mon, 12 Aug 2024 13:10:54 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Wang <jasowang@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: ayaka <ayaka@soulik.info>, 
 netdev@vger.kernel.org, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 linux-kernel@vger.kernel.org
Message-ID: <66ba421ee77f4_48f70294e@willemb.c.googlers.com.notmuch>
In-Reply-To: <CACGkMEsw-B5b-Kkx=wfW=obMuj-Si3GPyr_efSeCoZj+FozWmA@mail.gmail.com>
References: <CAF=yD-JVs3h1PUqHaJAOFGXQQz-c36v_tP4vOiHpfeRhKh-UpA@mail.gmail.com>
 <9C79659E-2CB1-4959-B35C-9D397DF6F399@soulik.info>
 <66b62df442a85_3bec1229461@willemb.c.googlers.com.notmuch>
 <CACGkMEsw-B5b-Kkx=wfW=obMuj-Si3GPyr_efSeCoZj+FozWmA@mail.gmail.com>
Subject: Re: [PATCH] net: tuntap: add ioctl() TUNGETQUEUEINDX to fetch queue
 index
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jason Wang wrote:
> On Fri, Aug 9, 2024 at 10:55=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > ayaka wrote:
> > >
> > > Sent from my iPad
> >
> > Try to avoid ^^^
> >
> =

> [...]
> =

> > > 2. Does such a hash operation happen to every packet passing throug=
h?
> >
> > For packets with a local socket, the computation is cached in the
> > socket.
> >
> > For these tunnel packets, see tun_automq_select_queue. Specifically,
> > the call to __skb_get_hash_symmetric.
> >
> > I'm actually not entirely sure why tun has this, rather than defer
> > to netdev_pick_tx, which call skb_tx_hash.
> =

> Not sure I get the question, but it needs to use a consistent hash to
> match the flows stored before.

This is a bit tangential to Randy's original thread, but I would like
to understand this part a bit better, if you don't mind.

Tun automq calls __skb_get_hash_symmetric instead of the
non-symmetrical skb_get_hash of netdev_pick_tx. That makes sense.

Also, netdev_pick_tx tries other things first, like XPS.

Why does automq have to be stateful, keeping a table. Rather than
always computing symmetrical_hash % reciprocal_scale(txq, numqueues)
directly, as is does when the flow is not found?

Just curious, thanks.

> >
> > > 3. Is rxhash based on the flow tracking record in the tun driver?
> > > Those CPU overhead may demolish the benefit of the multiple queues =
and filters in the kernel solution.
> >
> > Keyword is "may". Avoid premature optimization in favor of data.
> >
> > > Also the flow tracking has a limited to 4096 or 1024, for a IPv4 /2=
4 subnet, if everyone opened 16 websites, are we run out of memory before=
 some entries expired?
> > >
> > > I want to  seek there is a modern way to implement VPN in Linux aft=
er so many features has been introduced to Linux. So far, I don=E2=80=99t=
 find a proper way to make any advantage here than other platforms.
> =

> I think I need to understand how we could define "modern" here.
> =

> Btw, I vaguely remember there are some new vpn projects that try to
> use vhost-net to accelerate.
> =

> E.g https://gitlab.com/openconnect/openconnect
> =

> Thanks
> =




