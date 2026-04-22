Return-Path: <netdev+bounces-280343-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCpIMfuA6GkILAIAu9opvQ
	(envelope-from <netdev+bounces-280343-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 10:04:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD06443385
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 10:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7FBA63009F3D
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 08:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C81F37D124;
	Wed, 22 Apr 2026 08:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bDs1aGyo";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bnSqLVxP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3F837CD59
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 08:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776845044; cv=none; b=St9+NB6ZKwZnz/kEsXF9v5lb7Hbgkf6YZMo0gwISSIam+81CJVP/0mRY36M6AVWWaT7gb3vSUXDM9f5Nc2JeecVB/hHVw5ujAiRrFJ4yaNiIRtikIeShvARfS0yntUsAM49zKgoylc1Dev1vqI4E5QAdx7qotSCj8y1Suktdf5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776845044; c=relaxed/simple;
	bh=n6FcGGfJc9FwT6eA3nxUiDSnvNyYqxRV+SHYqG5nBHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pDUq9ZNJuSKFRvmNYCFVyM1yc7WfAIfVIELLEJoJMvwaEvwbdtd4mAs+mPA5jk25c1FLIl/7Fi2RXuIVjjH5ofJxAFvSuOrPBI3o/KsQ+3AoWUdjHM7Zp8jCrjdrhTgh7vTOxI0DHrHdiW0/zU5bAVzFd2/jgVTOM3d4HuZ4ofM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bDs1aGyo; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bnSqLVxP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776845040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yggL1Y17qIJxiIQdsjnuguLrKkWd8ehhHbW7AOHNGYk=;
	b=bDs1aGyoLnszHvg5Ke8HSXExrXHqJGyZk9CSRQtZ8GgH55qcBpFMinsLBqOLQ/g+BmHIap
	zt0DEpFe5QwXLHkmowALwkLQu22zDbzEFrKiPXRRMriqTO3I60nz91AAvIxgWQNUx4VgTO
	bb3YmnzH5odpBMyHHN1TesWb/S4c4f4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-hz-AqXvAOmOYFA1L4UF_tw-1; Wed, 22 Apr 2026 04:03:58 -0400
X-MC-Unique: hz-AqXvAOmOYFA1L4UF_tw-1
X-Mimecast-MFC-AGG-ID: hz-AqXvAOmOYFA1L4UF_tw_1776845037
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48378df3469so34561555e9.1
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 01:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776845037; x=1777449837; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yggL1Y17qIJxiIQdsjnuguLrKkWd8ehhHbW7AOHNGYk=;
        b=bnSqLVxPSQxLQ8kwjwCZqaso1HXN7OFEm2L+U6eYRPUkm3euNhareMhDcYGJPudPR1
         oCTAzhjzYuNt1HUruRjgkFiDF5noMAEYVsmEIZtTBEhlCaNuY0FiwGAPiebkZjYYT7Bw
         qp8fcoGPqXetyBYMs53oS/7MY/7NBQO69KoDmmjXQBI6E4KrUlee7WiB8Kh02kkh+t3j
         Eggqa6QPNPDeMel6pZYgfivqA7WyGd2VIC5+IexVpXiWJxcYuYTBurz3u/lqH7bIaZod
         8xDhF3uX/+L4fXU0PNZbdMM57VtBSv+7cUtQmvjM/PXGgPu+fKK5dRO3yZRVbdpihaRf
         ijzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776845037; x=1777449837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yggL1Y17qIJxiIQdsjnuguLrKkWd8ehhHbW7AOHNGYk=;
        b=rGJ7am2dIXQ1StQ5uVdputouMq1Quq3+9juqyMjVrblUvV57LGt/OCPmYthrCYVRbO
         551Vx2jn/xGOL++me+D1pJmVuzjWgAdIEL3Z0XwxMXyZ2bYvFvigsa4NOEx63ofqeOL1
         ANTVJBhutWVcgVjlYW6+0Lk8wUJiBV9jeADQfXo6DXP4OQ6009Qh+NpMoBqei9gGPx2d
         TkJyWVScn2958x1UE12oJf6eA2yJiBLySNQTkXRFgmXqZXexAwuDeojPKJamgWDHvTaS
         cpu/RbPxW7xaVt/4QnY5bA6R+CmM0gPyMndoCpzbsseNt4I1eidCYZTPQ+KVGhovoVlh
         tDYA==
X-Forwarded-Encrypted: i=1; AFNElJ+GO7MIYHzMQlEzUNvzGRsG2UVQ4yf+obJlHxc+F6BjP+1RZDYIMHbT+IPk6HXHXJokhzxZG64=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4WhSZgdrPzzRZGofWyyPRYmujPV2gfinSMGTM7ov7jTNKQUvy
	FwZ82YchA2g37TeOEq2keWVboBF8dmMEJfn6U+AAc/AOqV7ebKsRjTmgmBMjpyWjTXt+Pn9SNcW
	XFXpQ/N2gmHLNaCIztqiDQ/VY8yqflx80nkUBQJ6+wpE/Ybc2kuH4QM18WurA5BKvlw==
X-Gm-Gg: AeBDieuQEvvhVF7SdtGSLbViWcNXXtX5xmsejSe8dE3iiWemLybrn3kNuoMtWiCc82n
	hn7UbkHZpDRPhSJSYuQqyTR0Hz7Vq1OrA4RiCE+4WbtLbDE4YTO7UavVHuaXF3l9MnwBmM0DAs6
	DaAMvOv6lGsE7F094OLlEVc7V1vdyqusNkpQiX9y88DHnth538CPlxDe9JVpAf/HZxT8V6SxSeI
	Xw7uy+1iqVGWainFX45aMUbSi0nDZEix0T6q37047/oyYjKiBesIuCA7azhA2yW1+nuJWayNo3w
	+0EyY4cvioMWCv2xzfNaRKZWZ29mU4F1XilHsKZUkiqZ9z5x7AKqiNiyyKsEgATjsSLnpD2QxYx
	aNpP5L2npdFkjRO984Rhg2No52BZtcb10NyLZWa6RzoJ1pdGd0xBs3+z81lQV9nOUuhPdaZS6Xv
	aHW5VMfg==
X-Received: by 2002:a05:600c:8b6b:b0:485:3c2e:60d5 with SMTP id 5b1f17b1804b1-488fb8859ddmr282793095e9.2.1776845036788;
        Wed, 22 Apr 2026 01:03:56 -0700 (PDT)
X-Received: by 2002:a05:600c:8b6b:b0:485:3c2e:60d5 with SMTP id 5b1f17b1804b1-488fb8859ddmr282792575e9.2.1776845036304;
        Wed, 22 Apr 2026 01:03:56 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-83.retail.telecomitalia.it. [87.16.204.83])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891df9e50asm179358765e9.0.2026.04.22.01.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 01:03:55 -0700 (PDT)
Date: Wed, 22 Apr 2026 10:03:49 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Luigi Leonardi <leonardi@redhat.com>, stefanha@redhat.com, 
	netdev@vger.kernel.org, Mathieu Schroeter <mathieu@schroetersa.ch>, 
	David Ahern <dsahern@kernel.org>
Subject: Re: [PATCH iproute2] ss: fix vsock port filter
Message-ID: <CAGxU2F4C4JbqBEWehBhhOehGaXZJOWLkQ09hjaaSAh8-J5W50w@mail.gmail.com>
References: <20260421-fix_vsock-v1-1-812c80a76c1a@redhat.com>
 <20260421163757.31da8751@phoenix.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421163757.31da8751@phoenix.local>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280343-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,networkplumber.org:email]
X-Rspamd-Queue-Id: CAD06443385
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 22 Apr 2026 at 01:38, Stephen Hemminger <stephen@networkplumber.org> wrote:
>
> On Tue, 21 Apr 2026 14:35:12 +0200
> Luigi Leonardi <leonardi@redhat.com> wrote:
>
> > parse_hostcond() uses get_u32() to parse the vsock port into the
> > aafilter.port field, which is a long. On 64-bit systems, get_u32()
> > only writes the lower 32 bits, leaving the upper 32 bits set from
> > the -1 initialization. This causes the port comparison
> > "a->port != s->rport" in run_ssfilter() to always fail, since the
> > corrupted long value never matches the int rport.
> >
> > Fix by using get_long() instead, consistent with how AF_PACKET and
> > AF_NETLINK handle the same field.
> >
> > Fixes: c759116a0b2b ("ss: add AF_VSOCK support")
> > Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
> > ---
> >  misc/ss.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/misc/ss.c b/misc/ss.c
> > index 14e9f27a..6e3321ac 100644
> > --- a/misc/ss.c
> > +++ b/misc/ss.c
> > @@ -2323,7 +2323,7 @@ void *parse_hostcond(char *addr, bool is_port)
> >               port = find_port(addr, is_port);
> >
> >               if (port && strcmp(port, "*") &&
> > -                 get_u32((__u32 *)&a.port, port, 0))
> > +                 get_long(&a.port, port, 0))
> >                       return NULL;
>
> If you use get_long() then the code could get negative values.
> Actually have port in ss as signed value seems like a mistake in original design.
>
> The port in unix domain socket is inode number.
> Originally it was int, but got changed to long back in 6.6
>
> The port in ss cache is int.

Yeah, as I mentioned I think the issue was introduced by commit
012cb515 ("ss: change aafilter port from int to long (inode support)").

After teverting it, the filtering on AF_VSOCK works correctly.

IMO (I don't know the code at all), commit 012cb515 is incomplete and we 
should also move from int to long lport and rport in `struct sockstat`.

>
> The ss code is one of those legacy dog piles that needs a major
> overhaul and refactoring.
>

yeah, I see...

Thanks,
Stefano


