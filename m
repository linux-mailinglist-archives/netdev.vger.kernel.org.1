Return-Path: <netdev+bounces-275737-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMwQGCMe1GmJrQcAu9opvQ
	(envelope-from <netdev+bounces-275737-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 22:57:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F033A758D
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 22:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 547B7302515D
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 20:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF4B311C32;
	Mon,  6 Apr 2026 20:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o6jHBOC0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD393009F6
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 20:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775509021; cv=none; b=nhvmvVE9AmEUWeUYHXXT+U90rl57AKIhbBqr2WxrhgqBMRSGub9oQ/+/2EgLBFHdkrk7ZWa9G1sq3xls9wua3+yLrOc0yUfEHqM7P4HHOxePxrp5aTL+ea3ZzETXhyzJlDYOjKE88z1oxv70nwHSYSN3wOjAdC5buUTtUVmF3IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775509021; c=relaxed/simple;
	bh=z9ymFt/yV556ogk1/KubQwbpDGG7ebWj5Z0TkeYOemM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Jp4RcIoNPWFTSnNUP6P6yuFfYDQCyqPU16IOzhxQj2fA3aLNHemue2ZKaT0axdZtCUOMV/oP//wV759qPA+b1XiuVpjsNai2b+3cxZdtwSdJJ//MhGhP/evOcxmkC7cJSq2zcYevHMC9ncIP2ksQ4fmHlyNglQr+RgzzG4WRQTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o6jHBOC0; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-79a46ebe2beso41133857b3.2
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 13:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775509018; x=1776113818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IbeQ7RU4fPJs1XWunFP2puvppP11EJLLY6x9wM0vzAs=;
        b=o6jHBOC0fjoX+xJ71qHYrnNLP60bB/b2cAuzOK0LiwgDY7zJtA91Ei8uJrwjIIwDy0
         Pn9epCKoLMraOtBvX2nqUnJb1uEfpQd9j6Ny4IKQLvpPYuHGjRfjOMUL6k65cB8rQLb8
         rLuvRtqHm306aLDziIPaMf/jrwnwLkR1UrRcTBGNq+rj1Zg/rVsNKj5m5oCMguRiZK/N
         WpeCD9ScMX7qoRYhPmEDtQIW23iETpKSoR9IudnkSUeo0a8ySafMigAryVRG4H/SWM0d
         mtJAJXR4REjaPuU+NtvHjfpKEwDYGSPD+Gd/fFq6tHRIL+bQPe8xyJ2nKFYZNC7Y7CiF
         Iy6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775509018; x=1776113818;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IbeQ7RU4fPJs1XWunFP2puvppP11EJLLY6x9wM0vzAs=;
        b=iOSGb5XqRDuS6Ng7mk29aCLfvTGLRUqQXH43qDUIBhKfdWfbfSRncHKtNbIqlUJ/aN
         cM5GQueNQC1pkUH77ddGI1GEGZvycwYYvjUcwhBEfjBuon88dwtdxRiL2Dwn2874Rkd6
         CthulfytS/wj6+eWAj2D1DfX0Q2gqBBnFmEit2qb+EvbZkmVZewYog7MlFUDpQdy9sB8
         zZ9cGthcrilcbxO+jS9aL6MFgQpM7uGnbDjiazU0oPSksqrA+A7jsszcHIgrM6vocVsW
         6GMT8ocVcIWmiZQDPcz8NtrYe32Y0bEizTq59IBufMVwe8kPDiLgLccoEU1EjymkyV+d
         jCGw==
X-Gm-Message-State: AOJu0YycAV/xftEyHMD94Ge8G+bTPR0+ZpOHydtdTxbi+DBmm+CJl7pZ
	hstNwTA9920HKnVkGZPloo2H5dltqTidamZ9+sGm/2ROqLPvVu1oQAn7
X-Gm-Gg: AeBDiet4Tw3OlzKkSKnRwsc1x18ica/LhkM2+2je/BdWJ7QgaXxxxS+XqYWaKQROqI4
	x2OBrL/31xeBAbPMMeHL/8hfS30wDqBMXk81ntj5uzYvxfARvUfyJTCPn9EZIVxY5yaKpfu7D/o
	E1niFXmVH6qEzxryt+GTIpLu5XkaPK5SCiwvpdjeNG5KmlRMY6ESoq/IfRMuPnXuyX/WN+OVcr7
	YGTNQYgw/dOuVdDo1tbm+98KU8T0TvNXIj3jMlf27omlRsLTqpAJQgdEmXHk0TDbsOxSQ1G8Gsj
	iSb/+pdoFY4oWQwidNT7Aozen9vWiAytyTeUoAgAfWBSbqx++Ps1YQJh6VROgzr3+6yL0YtD1bt
	h4ems9xuJtEcny95o58/qoBsH8JpRQ7IPMuW8ZGW2rWbfwfI7jj0a2bn0/KKloYrjxk3NUO6lYc
	qTpoahT4ev+Z2P5JhclUw+qRt0ygqhDTf5bvC6bIiJ9aLvoAJfFZUYOm5JqvJyo8Jjr31od7jN6
	nSSj5gSuGPZ9wk=
X-Received: by 2002:a05:690c:38a:b0:79a:7cff:7b81 with SMTP id 00721157ae682-7a4d556cdf1mr149463227b3.27.1775509018352;
        Mon, 06 Apr 2026 13:56:58 -0700 (PDT)
Received: from gmail.com (172.165.85.34.bc.googleusercontent.com. [34.85.165.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a36e42fec3sm58182407b3.4.2026.04.06.13.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 13:56:57 -0700 (PDT)
Date: Mon, 06 Apr 2026 16:56:56 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Joe Damato <joe@dama.to>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, 
 dalias@libc.org, 
 andrew+netdev@lunn.ch, 
 linux-kernel@vger.kernel.org, 
 willemb@google.com, 
 linux-kselftest@vger.kernel.org
Message-ID: <willemdebruijn.kernel.33be72b96419e@gmail.com>
In-Reply-To: <adPm+n8Uw3O2S5bY@devvm20253.cco0.facebook.com>
References: <20260403233240.178948-1-joe@dama.to>
 <20260403233240.178948-4-joe@dama.to>
 <willemdebruijn.kernel.400d24decd7d@gmail.com>
 <willemdebruijn.kernel.14a8e29bbdc9a@gmail.com>
 <adPm+n8Uw3O2S5bY@devvm20253.cco0.facebook.com>
Subject: Re: [net-next v2 3/3] selftests/net: Test PACKET_AUXDATA
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275737-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[dama.to,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 20F033A758D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Joe Damato wrote:
> On Sat, Apr 04, 2026 at 11:30:09PM -0400, Willem de Bruijn wrote:
> > Willem de Bruijn wrote:
> > > Joe Damato wrote:
> 
> [...]
> 
> > > > -static void do_rx(int fd, int expected_len, char *expected)
> > > > +static void check_aux_data(struct cmsghdr *cmsg, int expected_len)
> > > >  {
> > > > +	struct tpacket_auxdata *adata;
> > > > +
> > > > +	if (!cmsg)
> > > > +		error(1, 0, "auxdata null");
> > > > +
> > > > +	if (cmsg->cmsg_level != SOL_PACKET)
> > > > +		error(1, 0, "cmsg_level != SOL_PACKET");
> > > > +
> > > > +	if (cmsg->cmsg_type != PACKET_AUXDATA)
> > > > +		error(1, 0, "cmsg_type != PACKET_AUXDATA");
> > > > +
> > > > +	adata = (struct tpacket_auxdata *)CMSG_DATA(cmsg);
> > > 
> > > Sashiko had another interesting observation that this access may be
> > > unaligned, as cmsg_buf[1024] has 1-byte alignment.
> > > 
> > > That is not new in this patch. Indeed most tests in this dir just
> > > deference msg_control as struct cmsghdr * and CMSG_DATA as whatever
> > > domain specific type.
> > > 
> > > The man page also warns about this and suggests using memcpy to
> > > access CMSG_DATA. Not sure why it does not warn about the other
> > > cmsg_.. fields.
> > 
> > The commit that introduced that has more context
> > 
> > https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/commit/man/man3/cmsg.3?id=36d25246b4333513fefdbec7f78f29d193cf5d9a
> > 
> > It points out 32-bit platforms where cmsghdr is 12 bytes.
> > 
> > At least one example given, ptpd, uses a union to ensure alignment
> > 
> > 	union {
> > 		struct cmsghdr cm;
> > 		char	control[256];
> > 	}     cmsg_un;
> > 
> > But at least one other example, ssmping, does not. So I think not even
> > the 4B (on 32-bit archs) of cmsghdr fields can be depended on.
> 
> I'm fine with adding an "__attribute__((aligned(8)))" to be safe, but FWIW, I
> think the key point from the commit message linked above is:
>  
>   shows access to int payload via *(int *)CMSG_DATA(cmsg) (of course
>   int is safe because its alignment is <= header alignment, but this
>   is not mentioned).

But that conditional on having a union as showed to make sure that
the structure has the struct cmsghdr alignment.

A bare char[] won't have that.

Anyway, in practice on the platforms we test this hasn't been an issue.
Fine to copy the example from other tests, leaving out the alignment.

I will follow-up with one patch to update all of them at once, once
I'm certain that I did not overlook some other mechanism that
implicitly does guarantee this alignment on all platforms.
 
> struct tpacket_auxdata only has u32 and u16, so 4 byte alignment seems fine
> and I don't think the issue applies in this particular case. But, as I said
> above, I am fine with adding the attribute to be defensive.



