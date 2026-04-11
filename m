Return-Path: <netdev+bounces-277716-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAk3Kr6c2mmI4QgAu9opvQ
	(envelope-from <netdev+bounces-277716-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 21:10:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2D13E16BE
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 21:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 79BFE3008D10
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 19:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C0A3BADB9;
	Sat, 11 Apr 2026 19:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SjY0BDFP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E0D285041
	for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 19:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775934648; cv=none; b=egXHXR3z1OFD0rQxayo+oxHi0MsjK2o1XLXRek+02pk/IPMP/F+FXBFFK5EFjhAXDH7ApD/DWoWPyyqYo9sNmedO7WzJZPmnEV8UckaHiqDlowpCChTsJSiKEmFsJ6XljIm8o/yUuM2Hs1BWpK09jaClrTvflP1JxYkuRGp+fJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775934648; c=relaxed/simple;
	bh=Gt4Xxndsu0mDlG5v2kYyydGq7LlY+vq3JTORXpadg6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7xQh/MzIqVsxSbt3Uqd2jNvGwuFmISlXCz4Z8eOMPSzH9RGa24pjUCrh7d2qMfH+ccBqKwjOofnNsmiUWnsjVxHPPs8XvDcG2ULIhMCLFWeFhNqo8dqw0kB5uqfblzZG7KsAkKnHZ99TCDPRuMF07TNUdjHm2h+0qv3pRXH+nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SjY0BDFP; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43cf5fbacc9so1463844f8f.1
        for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 12:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775934645; x=1776539445; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LPCBZIgMpZdjyF6123ihZ+k6S7UbApuUK4u6pzDSw+I=;
        b=SjY0BDFPcsOF9p5onWb6jBx2+e4Pn2oT2tEf0KAKQ+tJVISfbeBJb63R1X9TYg2Udx
         ZuyYSWiFEKVOv4fph5zQTel3S5ZoyV+adYsSgF3njZy9siZVv4GXskQIRgUfge37ch1n
         7dm6PYpykf2iAQyp0O5MtQJqRV1IuKtkzw4mE9bkd3jKWJP784dJMN0IXayi2ObZO4Ab
         AqUM7dSW2tgMu4Wge7nxViXsiJYqf5rH1zGSRUjGi8dRnK9cgc6c8SKknjK/DJyJ95sC
         2EcIRVmVKHfreU+wMBZzFcYGTKqGKFW3lPm018Yy0nogJYcvkvqm0JRRrRwf4RGzATHO
         GUCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775934645; x=1776539445;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LPCBZIgMpZdjyF6123ihZ+k6S7UbApuUK4u6pzDSw+I=;
        b=suTG5ILgYQrk7qxP9xJ/0YnEbrE0RsYfT5bHQu8NBkjsRoLiPq5mT78LcT0STiJ4f9
         o7mJkXBDzr6/V69JqQR3MUhk9YZVRktbf5Nb4cLyxy/QTakw+NO6Z+zrJ0zAotxltmYq
         qtVI9IPkH00O8kWeJoX3B8/ewNNiQcpW1AJiZwHttRTkfX1x9qyUF/rMpXc4cVn3Ney8
         bQEbXPtpJiJ0KsAZfCL+4OTgIkZCcZBzF8ylvAEfoQzhdNZ0wkgWzuU3flKF0C85B2lL
         442eqCIbYq8QodytkijtVpMlcO8xHf+QgRHKPev7UCa86+5huU9kUJUn2yJ9Ec9Q4527
         jg4A==
X-Forwarded-Encrypted: i=1; AFNElJ8qYjIuX0yBgdQJLk5J6yoSjeOWycG8Wi71CyoohhgSNaYDmx+rjhz16Z5uFvBp2pzX0w1FyTU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxLQ/BX70fvyf6vBXphTivJA0JWhHx0wKzy5J9Ml5dY5TNJzfy
	HZ7ek/nOZiOy5bS0CWzHTvPXV/yg/98xFpAE0VMM5Kfcn0ONIJ0vT1S3
X-Gm-Gg: AeBDievsp9isTNfPF60YuSyv7weoa4f80zPp1okxHAaZtLY8iMq/iCuaiPbKf/TwbEh
	RuQ1Wknw+PrZA17uk8xQ0Xllp8HTP3kKXnKwuOf2Une2kzJ+9CKw0hj6gpbAOW+ccqjUp6bLwyD
	MtfzcyIJFSMxB+MlsrXXHxx6rbuJtbL1qHx6l3pditbEWzy4qHwFoNrqyYgyz/n9lPpLVfwis16
	DuEMOdf8pRKksWFxNn5+7eo2xUik9DcrmWmkVR/QcwbeGGGnogYWq1QvoU2BZ7d7JiuvtO2Ac+M
	7uUDxmnGjsp2tSI1vmsJXnEY2BqX8Sv0dOT3cbUe/WbgQKurEAti8FeIZ5R5xL3iQsc+SXSryK+
	v9yZHOwZAEnNx8HxJdfWQaUrY+CK4e9WjmSM0xsba0Mn2PSouaJb/OTSZMzINFElEkUdaxMHkoA
	pv/CfdOnPUiAPNHFKgGvZzrq0oaygjqA==
X-Received: by 2002:a5d:64c6:0:b0:43c:edaa:f5e7 with SMTP id ffacd0b85a97d-43d64974247mr11812635f8f.14.1775934644764;
        Sat, 11 Apr 2026 12:10:44 -0700 (PDT)
Received: from gmail.com ([2a00:f41:1c39:2cef:2a0c:50ff:fe2f:36f4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63de2a69sm18093849f8f.4.2026.04.11.12.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 12:10:44 -0700 (PDT)
Date: Sat, 11 Apr 2026 21:10:40 +0200
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Madalin Bucur <madalin.bucur@nxp.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Simon Horman <horms@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] bpf: cpumap: report queue_index to xdp_rxq_info
Message-ID: <adqbrqZgYlmI37Ib@gmail.com>
References: <20260411175134.771552-1-azpijr@gmail.com>
 <CAADnVQJOKc0zP4=-STEX0szgzUeS7RaxQTtre=P92R0UStug8A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJOKc0zP4=-STEX0szgzUeS7RaxQTtre=P92R0UStug8A@mail.gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-277716-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[azpijr@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9F2D13E16BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Apr 11, 2026 at 11:09:56AM -0700, Alexei Starovoitov wrote:
> On Sat, Apr 11, 2026 at 10:51 AM Jose A. Perez de Azpillaga
> <azpijr@gmail.com> wrote:
> >
> > When a packet is redirected to a CPU map entry,
> > cpu_map_bpf_prog_run_xdp() reconstructs a minimal xdp_rxq_info from
> > xdp_frame fields (dev_rx and mem_type) before re-running the BPF program
> > on the target CPU. However, queue_index was never preserved across the
> > CPU boundary, so BPF programs running in cpumap context always observe
> > ctx->rx_queue_index == 0, regardless of which hardware queue originally
> > received the packet.
> >
> > Fix this by storing the originating queue_index in struct xdp_frame,
> > following the same pattern already established for dev_rx and mem_type.
> > The field is populated from rxq->queue_index in
> > xdp_convert_buff_to_frame() during NAPI context, when the rxq_info is
> > still valid, and restored into the reconstructed rxq_info in
> > cpu_map_bpf_prog_run_xdp().
> >
> > Also use xdpf->queue_index in __xdp_build_skb_from_frame() to call
> > skb_record_rx_queue(), which was previously listed as missing
> > information in that function's comment.
> >
> > Also propagate queue_index in dpaa_a050385_wa_xdpf(), which manually
> > constructs a new xdp_frame from an uninitialized page. Without this,
> > queue_index would contain stale data from the page allocator.
> >
> > Signed-off-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
> > ---
> > Note: this patch was only compiled, not tested.
> >
> >  drivers/net/ethernet/freescale/dpaa/dpaa_eth.c | 1 +
> >  include/net/xdp.h                              | 4 +++-
> >  kernel/bpf/cpumap.c                            | 2 +-
> >  net/core/xdp.c                                 | 2 +-
> >  4 files changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> > index 3edc8d142dd5..00e36b0ac74d 100644
> > --- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> > +++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> > @@ -2281,6 +2281,7 @@ static int dpaa_a050385_wa_xdpf(struct dpaa_priv *priv,
> >         new_xdpf->headroom = priv->tx_headroom;
> >         new_xdpf->frame_sz = DPAA_BP_RAW_SIZE;
> >         new_xdpf->mem_type = MEM_TYPE_PAGE_ORDER0;
> > +       new_xdpf->queue_index = xdpf->queue_index;
> >
> >         /* Release the initial buffer */
> >         xdp_return_frame_rx_napi(xdpf);
> > diff --git a/include/net/xdp.h b/include/net/xdp.h
> > index aa742f413c35..6db10e6a8864 100644
> > --- a/include/net/xdp.h
> > +++ b/include/net/xdp.h
> > @@ -297,10 +297,11 @@ struct xdp_frame {
> >         u32 headroom;
> >         u32 metasize; /* uses lower 8-bits */
> >         /* Lifetime of xdp_rxq_info is limited to NAPI/enqueue time,
> > -        * while mem_type is valid on remote CPU.
> > +        * while mem_type and queue_index are valid on remote CPU.
> >          */
> >         enum xdp_mem_type mem_type:32;
> >         struct net_device *dev_rx; /* used by cpumap */
> > +       u32 queue_index; /* used by cpumap */
> >         u32 frame_sz;
> >         u32 flags; /* supported values defined in xdp_buff_flags */
> >  };
> > @@ -441,6 +442,7 @@ struct xdp_frame *xdp_convert_buff_to_frame(struct xdp_buff *xdp)
> >
> >         /* rxq only valid until napi_schedule ends, convert to xdp_mem_type */
> >         xdp_frame->mem_type = xdp->rxq->mem.type;
> > +       xdp_frame->queue_index = xdp->rxq->queue_index;
> >
> >         return xdp_frame;
> >  }
> > diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
> > index 5e59ab896f05..448da572de9a 100644
> > --- a/kernel/bpf/cpumap.c
> > +++ b/kernel/bpf/cpumap.c
> > @@ -197,7 +197,7 @@ static int cpu_map_bpf_prog_run_xdp(struct bpf_cpu_map_entry *rcpu,
> >
> >                 rxq.dev = xdpf->dev_rx;
> >                 rxq.mem.type = xdpf->mem_type;
> > -               /* TODO: report queue_index to xdp_rxq_info */
> > +               rxq.queue_index = xdpf->queue_index;
>
> This is like 5th time people attempt to address this TODO.
>
> Just remove that comment. Don't send broken patches.

oh... okay. but I have a question, since the bot detected something
I didn't and queue_index should be propagated in
xdp_convert_zc_to_xdp_frame(), or maybe intentional?

is it better to do as you said, removing the comment, or doing what the
bot said with proper test?

--
regards,
jose a. p-a

