Return-Path: <netdev+bounces-187286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 20360AA6194
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 18:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEE4C7B80F7
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 16:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493D83D561;
	Thu,  1 May 2025 16:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wrKtWUIX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D494215179
	for <netdev@vger.kernel.org>; Thu,  1 May 2025 16:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746118323; cv=none; b=cXredrmJU5sqdpPYfhymyMT2dqHDhBfoF5EBv9Zty1Q5LEi7tjbE//P5plq+8Cdzo2e6wAXPK3ZE/juRh5yoemg+4/RGf2QgAV1U4/pQVWz/gepVi0L+NgTq/nPNr0H0XbEwuEz58CPq84SkKyYTaZrzCC+qqU5MqN18TGPkw5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746118323; c=relaxed/simple;
	bh=lcuM37nEEfw1eVtAi17oW/TmlS7ujhxVr0s+lodaBY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QRTwP1qhitq+NpM3+S5IwVTcf/Ky9FKB0mCDgfBsifyXNq6fD49QtjOYqE+FMQ+hzcZIkjIBjrtzJhbDrxagsljhAhGtaaYT+BMaPhcR/yDfihPR0MBl75cgBSxuaBbEIA+rUG1lfYFq5bLPqmFLIRco124UmWAP4pwWAw1jUSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wrKtWUIX; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6ecfa716ec1so14931436d6.2
        for <netdev@vger.kernel.org>; Thu, 01 May 2025 09:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746118320; x=1746723120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a2+qh8FDDcMl0mU8xoMNh8k3pyM8a4zq+RRhfHleKP0=;
        b=wrKtWUIX1X7uEvPtpLJyj/gaBcTih9IpzJYq9PYZgH9So4KWylzjhnusdD05Z7H6MZ
         2iWs79MeSeg2FZ+ZOcz9fPEC7CHuwkMxlVP+GauV9BbfEYl/rxMYLmR7WSQ8MHAFh6Ad
         xNKTPWIARLnmVcuRQLEw7P62lT4P+eX8CEB7zITBoJBYFBw8bPOfR8KmFu9Cfl4L2BDq
         DUoIC6SjKfigWhfmY5+pk2PL8EteY7OKLaKrArBR9e0FvpjIN9xa6G3uQqRKj1OVzS9f
         zlx39UvMHroFoGmX86i80TjPt2WNrUx3IGzL2JdqzbzcZmxNImuF7b7WnXA3wV8uvcfY
         gYlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746118320; x=1746723120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a2+qh8FDDcMl0mU8xoMNh8k3pyM8a4zq+RRhfHleKP0=;
        b=GcrU9MM71SmYg7BBqmXikWdxMT2fnhEPKaixXil8CTjVZi1lYC6fgaVBftuA7CUG4W
         v1rdB/4pfpDE+c5NSHfze9bmYPU4iSNN9WXc7CO1ahlQkfYJW5flv7foOj5D/RYR5Gzf
         YqbXPoBL1fv4NTkPbth/BUAj8iiBFcMJ6faOmDTfB9h4f5Xt8XML423qPnjluJkCb6hC
         OjfBg578hG+oBPTJjh4kgdIfUGhaKUbgiKX9riEMKk6z6jdvZkbw7T2OF38YpzV1LdOZ
         534cNdo+YNBdjxJBGIN1yF3m8U3XkJrtiTmOwizWJAUjC1fAwxEjyu8+Pu1ga0+p0/4k
         Ne6w==
X-Forwarded-Encrypted: i=1; AJvYcCXtHvyyoP0S/2O7Yca2f/Vo/pqaVAR76IVQIy3B/EUvpZbKTIlu6DxjXdR3PQM8b9SuQFKKeDI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUeDMRbqU+CenMFYDR58wlvLdtxQdUu8O0e0kjkWDkGWi6+sIZ
	3KQoXF0AS9pPDCk2uwGB5WcsGV/E3JI2b9B/NOSctYg535yWFL8LAlV5HrPFPld6p49YQKEvyqJ
	qAeGDFdq/H/jqNsI6fC9UUW2O5n14gPui820b
X-Gm-Gg: ASbGncsg2kKh6l4+Irzh2dQ5BAUQHVRJE33FvOegyLkoqDQYnFvvwNhz6+1I+KLu6gA
	0G0Ell/cmkNOCldI1PPXeJpLrd20bUb6RFl9aAJahSyrZYUEfLxwo2IOGqoZ0dp5AIl91CgftJs
	c9Kh6RcyZL80940f98JZWw1o0=
X-Google-Smtp-Source: AGHT+IHwKH7bRC/TqD5cR/AUaiV/3bOZWGDCYig2ZUzkUVAm+8UnykCncFDQcJwcNffRAeiBD6cFzN1kckSuD7KOAbs=
X-Received: by 2002:a05:6214:2483:b0:6e6:6103:f708 with SMTP id
 6a1803df08f44-6f4fe131a89mr124885996d6.38.1746118320270; Thu, 01 May 2025
 09:52:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428195532.1590892-1-brianvv@google.com> <20250501151616.GA3339421@horms.kernel.org>
In-Reply-To: <20250501151616.GA3339421@horms.kernel.org>
From: Brian Vazquez <brianvv@google.com>
Date: Thu, 1 May 2025 12:51:48 -0400
X-Gm-Features: ATxdqUEOGH-j1CFr8QL7QMirjvKCDO3-hjrj3ELuS3nArE1V-dBcyC9tmga7-Ek
Message-ID: <CAMzD94SNJe3QcLgNCPtVqDa69B7qcghcBkSOPWzV43d_XAeYuQ@mail.gmail.com>
Subject: Re: [iwl-net PATCH v2] idpf: fix a race in txq wakeup
To: Simon Horman <horms@kernel.org>
Cc: Brian Vazquez <brianvv.kernel@gmail.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	intel-wired-lan@lists.osuosl.org, David Decotigny <decot@google.com>, 
	Anjali Singhai <anjali.singhai@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	emil.s.tantilov@intel.com, Josh Hay <joshua.a.hay@intel.com>, 
	Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 1, 2025 at 11:16=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> On Mon, Apr 28, 2025 at 07:55:32PM +0000, Brian Vazquez wrote:
> > Add a helper function to correctly handle the lockless
> > synchronization when the sender needs to block. The paradigm is
> >
> >         if (no_resources()) {
> >                 stop_queue();
> >                 barrier();
> >                 if (!no_resources())
> >                         restart_queue();
> >         }
> >
> > netif_subqueue_maybe_stop already handles the paradigm correctly, but
> > the code split the check for resources in three parts, the first one
> > (descriptors) followed the protocol, but the other two (completions and
> > tx_buf) were only doing the first part and so race prone.
> >
> > Luckily netif_subqueue_maybe_stop macro already allows you to use a
> > function to evaluate the start/stop conditions so the fix only requires
> > the right helper function to evaluate all the conditions at once.
> >
> > The patch removes idpf_tx_maybe_stop_common since it's no longer needed
> > and instead adjusts separately the conditions for singleq and splitq.
> >
> > Note that idpf_rx_buf_hw_update doesn't need to check for resources
> > since that will be covered in idpf_tx_splitq_frame.
>
> Should the above read idpf_tx_buf_hw_update() rather than
> idpf_rx_buf_hw_update()?

Nice catch, that's a typo indeed.

>
> If so, I see that this is true when idpf_tx_buf_hw_update() is called fro=
m
> idpf_tx_singleq_frame(). But is a check required in the case where
> idpf_rx_buf_hw_update() is called by idpf_tx_singleq_map()?

No, the check is not required. The call is at the end of
idpf_tx_singleq_map at that point you already checked for resources
and you're about to send the pkt.

>
> >
> > To reproduce:
> >
> > Reduce the threshold for pending completions to increase the chances of
> > hitting this pause by changing your kernel:
> >
> > drivers/net/ethernet/intel/idpf/idpf_txrx.h
> >
> > -#define IDPF_TX_COMPLQ_OVERFLOW_THRESH(txcq)   ((txcq)->desc_count >> =
1)
> > +#define IDPF_TX_COMPLQ_OVERFLOW_THRESH(txcq)   ((txcq)->desc_count >> =
4)
> >
> > Use pktgen to force the host to push small pkts very aggressively:
> >
> > ./pktgen_sample02_multiqueue.sh -i eth1 -s 100 -6 -d $IP -m $MAC \
> >   -p 10000-10000 -t 16 -n 0 -v -x -c 64
> >
> > Fixes: 6818c4d5b3c2 ("idpf: add splitq start_xmit")
> > Signed-off-by: Josh Hay <joshua.a.hay@intel.com>
> > Signed-off-by: Brian Vazquez <brianvv@google.com>
> > Signed-off-by: Luigi Rizzo <lrizzo@google.com>
>
> ...

