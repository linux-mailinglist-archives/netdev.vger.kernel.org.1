Return-Path: <netdev+bounces-297188-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZM68NR1PKGreBwMAu9opvQ
	(envelope-from <netdev+bounces-297188-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 19:36:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C594F663008
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 19:36:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=dama-to.20251104.gappssmtp.com header.s=20251104 header.b=Q2XumI+s;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297188-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-297188-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D27053019338
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 17:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951364A13B4;
	Tue,  9 Jun 2026 17:22:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576492D0C97
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 17:22:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781025734; cv=none; b=UHOAw5X0eExhwZ/6oIKN4MCRG5RWSg7/iVNJwCYWSs6sCfz2ZHeMQLSO7dhRscBPkeumrV4oDrt+D8pzPQ33xEX3iipQu+1qN4gea8ktswxFem+/GpWXqGlH+HNG9Xe/hBNRrZMJhvCYbDzLqWuY7j3bv7qTCNHXsjI3afhwJww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781025734; c=relaxed/simple;
	bh=EAoIaV9pNUjobuXUO1ePSeJoEsKaKZUvgUq0xCcWJwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AyIvFWy/QgvLF9wt1KhW004hy2pjIty16m3ookViggiKkT1Xyq3SDxy1DjlvpN68tumfrMM6b5zZY4jPyMyy3+pEiVYBC6snQoCwFYYCoRJAyu1PxpExGCLiFL2MCs6RcQ7kV8zOALKk4McXhx/448xxddvQ8/3D1LWS44iV7YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=Q2XumI+s; arc=none smtp.client-ip=209.85.216.54
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-36d630c0e35so6314792a91.3
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 10:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1781025733; x=1781630533; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ce4y9KqIyAjhQ6PxfVsDJXSaJXhk3BB5Jl2BkdFmxQk=;
        b=Q2XumI+s7PiJcVemIXJ1aONkvFkfaHnVplgbOxj4xZ0iLYzpqf+A/RoRuHAHdTJTR1
         6XNdxdOmCljF+crs5Actzofs2AxmZvdcMWPMrCYBjfW2awBus3MGZxABreZ4YPdsE1WZ
         TT9++opAPgypJXOpmzi58g0i2qBLwdh2dGvGr0uAQ2hJX0F/92CxdCTJddxPAppWo79j
         fkJ7wYUeAV7c5I26wK5/Lof6mmHqqVBq9iIGaUSI7BWy9UQPHTjfdMoGq22ivNADOXkn
         fJAiwRHvzMiieIbA8R+rAQv6MgtWKMGFxKJcI8W57pOG1iobm78fk3f0cjvQKoyDEIkz
         S69g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781025733; x=1781630533;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ce4y9KqIyAjhQ6PxfVsDJXSaJXhk3BB5Jl2BkdFmxQk=;
        b=QzwcRohmI1lHhna/+SbwgKxwSG5KS2eAovp5V8UhDO7FmnlJFo9zAr+qqH8oVij0gb
         uKcbYkNNGQv9+e0NuED3sdDuIdWyUMbnmVa5pRY9dlOGk1cwvknLTVhhDZ7C7YvfO3Qg
         3Ke1pwWdLPxN4uyP2xR5ZOFnwjy2N2YjFFj+4OP3CdN+tPzme2h0sHO6hZ58B1haft2f
         eY0P3BKPQbQUIo/mzbrvD/MzPBxTn+rQmZmrDPIJ/u+ePWnmHJ4Vn94dI+N6rbOOHCMA
         sCdx9r2+oK0DUeVnht8jNRaechAw/HSBCcnN2lsR05wyhT61YPXnG+8yBIlYSDP1EPgO
         Gp5A==
X-Gm-Message-State: AOJu0Yx0mIgq3IoQZpiTN+TFVYX9SZ1NER6JOWSVam/nAvcJcSLyAXEW
	17EhC0iQH3HzJR1Gw5zDFdIIY6vbCwqaOMldXb2EO3G2aLGJaxhiREXNMm5PHiHl0Tw=
X-Gm-Gg: Acq92OFdsfBw8CYlYAtZtbPoWIFHy9OtFSHQLIbV4cdYhWt2KlbZDAIdJktMeRoOMFq
	O2HRvuXJ/McZABxxBkWe6i1tz4/f0VmCcbbxdDO7aPFGNnC59g7u4gPq7CHAdKuynMOT075JzyM
	Vf8FsI1KZRPLC8XSWfSCOVmz709XmJbR4NpKfbxf1JPZBuy7zljVtFtdmY5Uw3a9c3EGcW2jsP2
	lrHEAR7dHIGsnc9Gdbk9JGerym5L2sFvcjsAATnbZ1FVKnoUk1qrDYr68XhEffYJSsV49+obBpx
	Skijk+jrN0ZjhSB9zzXXpSuAW10ZpfLctm2c3aLVosVQVCtH/Y1HQEFGHxk9Xky5XFr21fFC31w
	RgAJ5W7MYRLTtI/cc1vRdXbf1WmYHC0uT4k5cLvOhA5nku/FeZxFoQmd2cLFbFzyos2RC0duvD5
	ypG8uEyhsUsXWHxtTo3hcZHKwXZw==
X-Received: by 2002:a17:90b:3d01:b0:36b:b3f4:d578 with SMTP id 98e67ed59e1d1-370f0095c8emr22699988a91.15.1781025732705;
        Tue, 09 Jun 2026 10:22:12 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4d::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6bf830b2sm18483208a91.4.2026.06.09.10.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 10:22:12 -0700 (PDT)
Date: Tue, 9 Jun 2026 10:22:11 -0700
From: Joe Damato <joe@dama.to>
To: Michael Chan <michael.chan@broadcom.com>
Cc: netdev@vger.kernel.org, Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>, horms@kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net] bnxt: fix head underflow on XDP head-grow
Message-ID: <aihLw8yR6Vu5B6lS@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Michael Chan <michael.chan@broadcom.com>, netdev@vger.kernel.org,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>, horms@kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20260608203129.920104-1-joe@dama.to>
 <CACKFLikOyMh3Kbee-AifLXQryyPt-CftW7VYHeeKWoCuMoXj8w@mail.gmail.com>
 <aigoUdgW/icfFwvh@devvm20253.cco0.facebook.com>
 <CACKFLinzaJr8EjXx7yME5cKv9LR1+pF+2iY43V+GeYdEjbUo+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACKFLinzaJr8EjXx7yME5cKv9LR1+pF+2iY43V+GeYdEjbUo+Q@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[dama-to.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297188-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[dama.to];
	FORGED_SENDER(0.00)[joe@dama.to,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_RECIPIENTS(0.00)[m:michael.chan@broadcom.com,m:netdev@vger.kernel.org,m:pavan.chebbi@broadcom.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:somnath.kotur@broadcom.com,m:andrew.gospodarek@broadcom.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[dama-to.20251104.gappssmtp.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,dama-to.20251104.gappssmtp.com:dkim,devvm20253.cco0.facebook.com:mid,dama.to:from_mime,dama.to:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C594F663008

On Tue, Jun 09, 2026 at 09:44:17AM -0700, Michael Chan wrote:
> On Tue, Jun 9, 2026 at 7:51 AM Joe Damato <joe@dama.to> wrote:
> >
> > On Mon, Jun 08, 2026 at 09:22:07PM -0700, Michael Chan wrote:
> > > On Mon, Jun 8, 2026 at 1:31 PM Joe Damato <joe@dama.to> wrote:
> > > >
> > > > To fix this, we need to do a bit of math to recover the offset if this
> > > > is a page fragment since it is not passed into rx_skb_func
> > > > (bnxt_rx_multi_page_skb, in this case).
> > >
> > > I wonder if we should add an offset field to struct bnxt_sw_rx_bd to
> > > simplify things for page mode.  Struct bnxt_sw_rx_agg_bd has the
> > > offset field for a similar purpose.  Thanks.
> >
> > I don't mind doing that, but I wonder if that's better material for net-next?
> >
> > In other words, we get the minimal fix in (this patch?) and then do the
> > cleanup and struct tweaking as a follow-up in net-next?
> >
> > I could definitely be wrong; I had just assumed patches for net were supposed
> > to be as minimal as possible.
> 
> I think some minor refactoring/struct changes to make the fix
> cleaner/simpler should be fine for -net.  I think the total number of
> line changes should be about the same either way.

OK. Are you OK with changing the signature of rx_skb_func? I was going to add
offset as an argument so it can be passed through.

