Return-Path: <netdev+bounces-301285-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iK9rDQ4xOmr53gcAu9opvQ
	(envelope-from <netdev+bounces-301285-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 09:09:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C36776B4B7F
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 09:09:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=YtW5WegU;
	dkim=pass header.d=redhat.com header.s=google header.b=YAwZIktk;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301285-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-301285-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4903A303CF9E
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 07:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A4839185A;
	Tue, 23 Jun 2026 07:08:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5FA3BD224
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 07:08:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782198519; cv=none; b=G+b/P0nlIqU7GnZ8YvLVg7u1q/pF7M6TpCWd8/o7hiEW/JuBq6EX4IYbC8xgh67tzRC4d9aKJBFvWJhzE+kYdc6ok9Nux/7WUufOmYMSRZI918OnFy5qgp78U8OVrsX7vmF5LxGS8ZCd2EfvEqpKpxBRKm/T/+A1rjWo8zceRLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782198519; c=relaxed/simple;
	bh=Ke1LitD4OywmlOwFcW273fMBllWzfXSPBRZr63oLg7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SkZK0sdAVW1QzdhMARx228bUtKFoS/dq3DCrFtUQHL1cFPF8RAzMIC8bSl4cLFMA14N0dtdju5psz5kNpjwsxz+ta72kQNlQgJWoqwEVN31aSJA77+uLDB/nwhgOm65JO3a0N+Wu5JQP3jcgkD15XInAN0spx9XJK+SyeNsgxjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YtW5WegU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YAwZIktk; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782198516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T+KsZAD0oHJlxnltaTZ/cFJz2c7aO0R1ESRDEl7NjrY=;
	b=YtW5WegURLUmVnvWjqKbN+a1JftP+LFqxOUPFKSuYfKa9sgAxxnWEWUS5bMbWYPpRkLCaq
	pb1qVcUOw46kjdg6VTbtrqL4ZOUZiVfWokqM9O0cMcq3VKlYo98bzhYmePzCHe+TDPpsS+
	+kXceFERNtDFfh8l/QGsp3Ij4MEUsmo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-wTt2UAZAPcm1ERzDZRbczQ-1; Tue, 23 Jun 2026 03:08:34 -0400
X-MC-Unique: wTt2UAZAPcm1ERzDZRbczQ-1
X-Mimecast-MFC-AGG-ID: wTt2UAZAPcm1ERzDZRbczQ_1782198513
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-462c4593a33so3513983f8f.3
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 00:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782198513; x=1782803313; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T+KsZAD0oHJlxnltaTZ/cFJz2c7aO0R1ESRDEl7NjrY=;
        b=YAwZIktk0PD2EezLCR2w5MtbTWbOGZf8+inqb+DiU1VX8oPoNBSGC2mG+jhDemWQYr
         GZCtD2Km6+giwI1Vpr1ekgAvXrIAyx3YNcj+5LDgaK9gjaIbBb2UFuIOarpwTvaoOc03
         9XURtnkHuacj/IGBaEfIUfW4igvYbQujGwOHGXezkAUTpFMbol76vis1jCGpb6RPnlVA
         +ZPzWOU4X8gybb55hHcrweoE9nloNylXbqEtsG4Jaka3R8prNPF5YjO4FzXPAYf69jYS
         6opIL1bQTra6bzaKII5bCUsNcSQsf0GSaST9hlLpS9AvYbdYnR7pkVhKW9OaxP35WB24
         2g/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782198513; x=1782803313;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T+KsZAD0oHJlxnltaTZ/cFJz2c7aO0R1ESRDEl7NjrY=;
        b=gsl+uNhB3iIoggZ8tNQStglBkWg90EO9I3IrTD/Hk9d+05ZR+cw/RbrzDxbjrCAzB4
         BUe6yTsYyvwiIH1aYBBM58cL5kyHskQ3sV/9R43e+9pReeTbIkT97IrJ9T9XYLa6e02N
         VCa9oFAjNh5CgKag2NO2hylJVxGk+b9rSzdqzVSKnImOEYkBzymjxUvlMlpWNKXGDBpI
         E95yiMCo8iT5c0jv+laE+d2Z8tu9wTOKnN/Xlbbym/gBTod2hpSnvS/afE8jj+aNTJ+z
         IupFsTHwkdyA+bwIsYI2kJHVnRNpCxuZ5qt8SuxP+GtKwnA5mYN30IvDGsIBJwGAFgO2
         JNeg==
X-Gm-Message-State: AOJu0YwMCn6d++F/i3NVsjPm2u0p1vM0SennnbFUezMgOrHm4Ho+JwAX
	LiNtR6zo/O6veQl8nOhaYyadj6OXI1m0VPgRp999yxNk2zQqP7Q250+m2IhAl8Ddy9LnslUFsfE
	h6yErNMZyWI1fFTjrhHukfhTKIcdIXt0b37NMpIuoDYs0uBhFbL9CsIVq+w==
X-Gm-Gg: AfdE7cnQtqGfBF8yfsFsUIHP8P6s0VtLTlQtrvyCBP1IUVMUgykSIbZs/YiHsfGAgm3
	W1pIVPH6E2cOTWu98LZIFJ6QnwYOOsbKrBAK6pEMRekhUvcMM9e9P/EWVyxe9kt/akcUSybM/EB
	GAVJsl/qtjLgqK69Aaj2BPWK2MsLZhLVMpTimsAaQFTs1RE7X5m252SjSrdqBMw8oA4oLPMXvWp
	xJkfjFNIkr/p774YR8v4VfMVVics5PAWym6aYt/T247Km8N8GaWeMhqqSNZvlgiu20CI2am+m/Z
	rI/SpzoLQcY/4nN3L3Cz6Kl50mnHnxncFtxAFndAcVNc+KeqHqgIQtUu8AQGFEhUqfN/CMbbWle
	vj7G1jr7NZmKsEVqw4HCoTbmlkRB3X6+reJgFV67B/1rEiSTCNULKJ7HCHRHt
X-Received: by 2002:a05:600c:4453:b0:490:d32b:39d6 with SMTP id 5b1f17b1804b1-4925b37973bmr21307785e9.19.1782198513380;
        Tue, 23 Jun 2026 00:08:33 -0700 (PDT)
X-Received: by 2002:a05:600c:4453:b0:490:d32b:39d6 with SMTP id 5b1f17b1804b1-4925b37973bmr21307275e9.19.1782198512939;
        Tue, 23 Jun 2026 00:08:32 -0700 (PDT)
Received: from sgarzare-redhat (host-79-34-22-35.business.telecomitalia.it. [79.34.22.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-466643f4ee6sm31772016f8f.5.2026.06.23.00.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 00:08:32 -0700 (PDT)
Date: Tue, 23 Jun 2026 09:08:27 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Brien Oberstein <brienpub@gmail.com>
Cc: netdev@vger.kernel.org, regressions@lists.linux.dev, 
	stable@vger.kernel.org
Subject: Re: [REGRESSION 6.12.90 -> 6.12.94] vsock/virtio: large AF_VSOCK
 transfers reset under backpressure
Message-ID: <ajoulmq3g7nuYHF0@sgarzare-redhat>
References: <467b01dd017b$733792d0$59a6b870$@gmail.com>
 <ajkAlpiyPWmNPWfx@sgarzare-redhat>
 <618701dd023e$063de350$12b9a9f0$@gmail.com>
 <ajkmjgGdJp9Dj6em@sgarzare-redhat>
 <672f01dd026f$54fa0600$feee1200$@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <672f01dd026f$54fa0600$feee1200$@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-301285-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:brienpub@gmail.com,m:netdev@vger.kernel.org,m:regressions@lists.linux.dev,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,linux.dev:email,sgarzare-redhat:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C36776B4B7F

On Mon, Jun 22, 2026 at 01:48:27PM -0400, Brien Oberstein wrote:
>Hi Stefano,
>
>Confirmed -- the 16 MB buffer fixes it: with socat owning the VSOCK-LISTEN
>and SO_VM_SOCKETS_BUFFER_MAX_SIZE/SIZE at 16 MB, a 6.12.94 guest passed
>21/21 large transfers (1.5 MB x12 through 8 MB); the same 1.5 MB payload
>failed every time without it. So the per-socket workaround covers the
>bridges whose listen I control, but not vsock services I can't
>reconfigure, which stay broken on 6.12.94.
>
>Agreed the old behaviour was buggy in its own right -- it was
>over-allocating past the advertised buffer. The practical effect for me is
>just that a config that worked on 6.12.90 no longer does on 6.12.94.
>
>A question mainly for stable@: until the merging work lands, would an
>interim be acceptable -- something that keeps ordinary small-packet
>workloads under the limit without reopening the DoS? I don't have the
>kernel-side expertise to judge what's safe there, but I'm glad to prepare
>and test whatever interim you think is right, and to test the merging
>patch when it's ready.

Let me try something: one of my patches merges the SKBs when we exceed a 
certain threshold. That should be enough to fix this issue with STREAM 
sockets. I can extract this patch from my series (which does other 
things as well) and minimize the changes so it can be backported to the 
stable branch. I’ll see if I can send you a draft later today for 
testing.

Thanks,
Stefano

>
>Thanks,
>Brien
>
>-----Original Message-----
>From: Stefano Garzarella <sgarzare@redhat.com>
>Sent: Monday, June 22, 2026 8:22 AM
>To: Brien Oberstein <brienpub@gmail.com>
>Cc: netdev@vger.kernel.org; regressions@lists.linux.dev;
>stable@vger.kernel.org
>Subject: Re: [REGRESSION 6.12.90 -> 6.12.94] vsock/virtio: large AF_VSOCK
>transfers reset under backpressure
>
>On Mon, Jun 22, 2026 at 07:55:30AM -0400, Brien Oberstein wrote:
>>Hi Stefano,
>>
>>Thanks, that matches what I'm seeing: large transfers reset mid-stream
>>instead of the sender being throttled (reliable above ~1.5 MB, fine below
>>~90 KB).
>>
>>The bind for me: it's not just this mail bridge -- I use AF_VSOCK for a few
>>host/guest services, some of which open their own sockets, so the
>per-socket
>>buffer workaround can't cover them all. That leaves pinning 6.12.90 (losing
>>the DoS fix and further kernel updates) as the only blanket option.
>
>Okay, but in that case did it work?
>
>>
>>A few quick questions:
>>
>>1. Is a -stable backport of the merging fix likely, and roughly when?
>
>We don't have a fix yet.
>
>>2. Could a smaller interim land in -stable sooner (e.g. more default
>>   headroom) without reopening the DoS?
>
>What we've merged so far is the best we can do for now, but anyone who
>wants to help improve the situation is welcome to submit patches.
>
>>3. Will the fix guarantee backpressure for any packet size, or just widen
>>   the margin?
>
>It should fix STREAM sockets for any packet size.
>SEQPACKET/DGRAM is a bit different since we need to keep boundaries, so
>it will come later if needed.
>
>>
>>Happy to test any patch
>
>THanks, I'll ask you to test.
>
>>I have a solid reproducer and can turn it around
>>in a day. I'll also file this as a tracked regression so it's not lost.
>
>Unfortunately, it's always been partially broken, using more memory than
>specified, so I don't know if this is actually a full regression, but I
>understand.
>
>Thanks,
>Stefano
>
>


