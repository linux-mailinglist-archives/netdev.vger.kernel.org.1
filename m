Return-Path: <netdev+bounces-246088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6117BCDEC64
	for <lists+netdev@lfdr.de>; Fri, 26 Dec 2025 15:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC5D5300B993
	for <lists+netdev@lfdr.de>; Fri, 26 Dec 2025 14:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F69227BB9;
	Fri, 26 Dec 2025 14:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WTAFdQBN";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="akmgN8vY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406A95464D
	for <netdev@vger.kernel.org>; Fri, 26 Dec 2025 14:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766760650; cv=none; b=Kc9g3tGPp/xltjXnKwDoHS+oEyRl+Wu66YUUXoIzVURm1SCBI745qEIPSKXovWEljvsr28yBriLcJIP9JQ+hHEn60WKLi1rnxR71QwypmrxTX0LT7GRGm7MWkLLFMbrraJd+WSGuNRcT+iDgDxjn96j5yoNGGIN3afpSIWp94gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766760650; c=relaxed/simple;
	bh=PKXRGzbxh1OlfF0T9/TV4KDNz94u0vtq7bXgSU6XVJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gY3OlfWCsyzGdYsgMgfWZ9jmUszAurPdUEytZ33yDnfxQoZ1ZwDhoacGKzaoZi27vHMs1+7d9TBQ43nRlsuxpuTA5CYpzJZFyPEvXdd6Sfv3XzvvT+Bh9SM317fte/6dSS95ZzvfQ6c7SEtzcxYkM5R6b85EYjC4Gl+RxY79ez4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WTAFdQBN; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=akmgN8vY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766760646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7KQs8vvsCuYX4f4WNDWRFaCkEzOPPZG4H4J2HYQGAcg=;
	b=WTAFdQBN3oCJlv/bsrTK5NZb1/c/0bstaYlGeCFAjwNQ/FEPJ6+clqRtnkTYJUUV7PLk7J
	HTclUQWLRaVfnRPGY4G6bhSWrkZMYwg21QWrA7wAlB/mThpRN1g3S+YCf3VXiOVvfkbiI2
	u5FJGgOtWMaURp0UJ0LfyVVf72VwJ18=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-TcwO7ndZMOSzpZWDGgy99A-1; Fri, 26 Dec 2025 09:50:44 -0500
X-MC-Unique: TcwO7ndZMOSzpZWDGgy99A-1
X-Mimecast-MFC-AGG-ID: TcwO7ndZMOSzpZWDGgy99A_1766760644
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43101a351c7so5792577f8f.2
        for <netdev@vger.kernel.org>; Fri, 26 Dec 2025 06:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766760644; x=1767365444; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7KQs8vvsCuYX4f4WNDWRFaCkEzOPPZG4H4J2HYQGAcg=;
        b=akmgN8vYck1rsVdf/TcS392DbGkXfRpDjgK0p9JR37PDENHq1XzpbORfKKujrfx3oV
         42mh4oln9Dt4p72SjlmVdAzwpvqHp04VnK6nF0bttNZggGgtN65BVqW+Rd+GeUGO3lil
         eZwEHTYWPIUehZS/fUdXK17IQI1SqCZVKkUrWlOhhV7OQIb5/DXjv+77hYANDmZgTXgo
         OuJvulQ1w7BWnad69zVTECeACpMW4a6Bs7Uu3lObFnV2d2Xs2aNLzhD6ABjHO7We1Y1J
         SFxa8D57R/j6E+39KTu7ee2I4z2iPS1rlCSLDgkXtDWZchF5ozTgBeCZmusUjX856pVH
         mbXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766760644; x=1767365444;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7KQs8vvsCuYX4f4WNDWRFaCkEzOPPZG4H4J2HYQGAcg=;
        b=VtigX4XcI0SZl/9n8Q0+2zH17YHEerJPYKiEAh1TJJgmoSNRnwz3rP48SiVE9eZfR4
         V3ec61WhdKEhV+GQZcwUPmRczOo9kjvo4FRRsGJ4B9fV/KvL69xdkFqKtsWKcoIHsrj/
         7qvlm/6TVcgxYELIoElgcRJVEVgrIOm5PC66Z+MGSmPkyUIyf/NFP+YDEO5ftQWJSyJ5
         iBJYBZtK95vctLe/3xdjo1z6prwc6/9tT0v8+FxYnp98zwKxjCKNwwpV0FYTx/gQCnkU
         1SyZEJnUQ5n72OK1BQkQnbKSBkH14lat1ea6Mupif4vYPkYCR8jUGWBSGVbkvOfV4+jO
         4N2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUn8RTYDnhxoLtYyeIQjbfDDmA3D7mYn3wgqhtlawkOXIPx4RE2YBsaWxxam0NrIuencyq/TS4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz27hzP/0SFSyAQUFGcg5ISPgYvsZ6Z7yWJid8jmokF2tBXLEXm
	y8Lmr2Mrum1eMsemc0GXZNmtBoLRoiThvaozzGUO8O4QuymWCe0oGU5loVGly3yABpMqXtN1QQP
	McTHRTEDcmwCg1r8QAbtMieBQcrK3dIXi1wFaAz8m5wctvv7GWTK1q5ncRQ==
X-Gm-Gg: AY/fxX54GR8osREkSZ/lEgwKzaDWwnB5aseF+WOX2GfJZrhjxUwFrbL9pP0uPqceIWz
	raesoHdSvOvoC5f2Rw02bCYpnJudInwf+wuZ+qUXvqROCH2/L1fwowWmqoprK/P3e4LwnWD5w0F
	GizKA8NMEFjTcPPxeayIYziNLnWxOsOHtO29F837xbV9JErrINHg4qvg0l7IonrzVQIbv/urAu1
	D2D98tLcoNKCwpeQhQFa3WxtoSxSrFhdIJNWU7muqKpixBjMRsmwUucG4n4euZN4a/tYHwDDneF
	vjZ42PoBMsoUo+cWf/sOr0PaF2BL3kZqorxoPLDN4YwoNpiwtL02TXHH+8Rw2QxVZ3PxTUhX8E0
	xdAOx+ZlTx/k58Pj1lC01hsxlILm+XnFsmw==
X-Received: by 2002:a5d:4e46:0:b0:430:fe22:5f1c with SMTP id ffacd0b85a97d-4324e703af5mr20129795f8f.59.1766760643536;
        Fri, 26 Dec 2025 06:50:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMQ5W8XwHXEz0VCwLYh7DYgtWB1N+w4NhUInEUeh59gqlc2IFDP3VMltMmESqxQ1YzyY8Evg==
X-Received: by 2002:a5d:4e46:0:b0:430:fe22:5f1c with SMTP id ffacd0b85a97d-4324e703af5mr20129768f8f.59.1766760643060;
        Fri, 26 Dec 2025 06:50:43 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eaa46c0sm46411703f8f.34.2025.12.26.06.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Dec 2025 06:50:42 -0800 (PST)
Date: Fri, 26 Dec 2025 09:50:39 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jon Kohler <jon@nutanix.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] vhost/net: check peek_head_len after signal to
 guest to avoid delays
Message-ID: <20251226094933-mutt-send-email-mst@kernel.org>
References: <20251125180034.1167847-1-jon@nutanix.com>
 <20251125184936-mutt-send-email-mst@kernel.org>
 <4F24DF4D-7F5F-4BFC-B535-57C1AD66762D@nutanix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4F24DF4D-7F5F-4BFC-B535-57C1AD66762D@nutanix.com>

On Wed, Nov 26, 2025 at 04:49:11PM +0000, Jon Kohler wrote:
> 
> 
> > On Nov 25, 2025, at 6:50 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > 
> > !-------------------------------------------------------------------|
> >  CAUTION: External Email
> > 
> > |-------------------------------------------------------------------!
> > 
> > On Tue, Nov 25, 2025 at 11:00:33AM -0700, Jon Kohler wrote:
> >> In non-busypoll handle_rx paths, if peek_head_len returns 0, the RX
> >> loop breaks, the RX wait queue is re-enabled, and vhost_net_signal_used
> >> is called to flush done_idx and notify the guest if needed.
> >> 
> >> However, signaling the guest can take non-trivial time. During this
> >> window, additional RX payloads may arrive on rx_ring without further
> >> kicks. These new payloads will sit unprocessed until another kick
> >> arrives, increasing latency. In high-rate UDP RX workloads, this was
> >> observed to occur over 20k times per second.
> >> 
> >> To minimize this window and improve opportunities to process packets
> >> promptly, immediately call peek_head_len after signaling. If new packets
> >> are found, treat it as a busy poll interrupt and requeue handle_rx,
> >> improving fairness to TX handlers and other pending CPU work. This also
> >> helps suppress unnecessary thread wakeups, reducing waker CPU demand.
> >> 
> >> Signed-off-by: Jon Kohler <jon@nutanix.com>
> > 
> > Given this is supposed to be a performance improvement,
> > pls include info on the effect this has on performance. Thanks!
> 
> I had already mentioned we’re avoiding ~20k schedulers/IPIs in that
> example, but I can add more detail. Let’s resolve the other parts of
> the thread first and go from there?


the discussion seems to have died down.
I suggest reposting with perf data you have
(which test, how much improvement, what cpu usage)
collected in the commit log.

thanks!

> > 
> >> ---
> >> drivers/vhost/net.c | 21 +++++++++++++++++++++
> >> 1 file changed, 21 insertions(+)
> >> 
> >> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> >> index 35ded4330431..04cb5f1dc6e4 100644
> >> --- a/drivers/vhost/net.c
> >> +++ b/drivers/vhost/net.c
> >> @@ -1015,6 +1015,27 @@ static int vhost_net_rx_peek_head_len(struct vhost_net *net, struct sock *sk,
> >> struct vhost_virtqueue *tvq = &tnvq->vq;
> >> int len = peek_head_len(rnvq, sk);
> >> 
> >> + if (!len && rnvq->done_idx) {
> >> + /* When idle, flush signal first, which can take some
> >> + * time for ring management and guest notification.
> >> + * Afterwards, check one last time for work, as the ring
> >> + * may have received new work during the notification
> >> + * window.
> >> + */
> >> + vhost_net_signal_used(rnvq, *count);
> >> + *count = 0;
> >> + if (peek_head_len(rnvq, sk)) {
> >> + /* More work came in during the notification
> >> + * window. To be fair to the TX handler and other
> >> + * potentially pending work items, pretend like
> >> + * this was a busy poll interruption so that
> >> + * the RX handler will be rescheduled and try
> >> + * again.
> >> + */
> >> + *busyloop_intr = true;
> >> + }
> >> + }
> >> +
> >> if (!len && rvq->busyloop_timeout) {
> >> /* Flush batched heads first */
> >> vhost_net_signal_used(rnvq, *count);
> >> -- 
> >> 2.43.0
> > 
> 


