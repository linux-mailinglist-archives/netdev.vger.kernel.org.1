Return-Path: <netdev+bounces-275234-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOGIEGE20GlZ4wYAu9opvQ
	(envelope-from <netdev+bounces-275234-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 23:51:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BF039890F
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 23:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 35A77300722C
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 21:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C0E30E831;
	Fri,  3 Apr 2026 21:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jWPBOGHG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACE51EB5E1
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 21:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775253082; cv=pass; b=knfR6gMWCVQNQY5ENjoto9AKmq9RDT/GiESoXLj6jNGQMGJvp70CpvPm+W6i2Dg1lPOPcgK3Bd9xFC+MKDzGhL6HwhQI+CIMazptFeKYlzQYSLFfHCRegxBODdcP9bi8GWspQJLDetjxONaaqtJdZ7w7hBVi9J0eiYxneH40P6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775253082; c=relaxed/simple;
	bh=0x7xdB777t0lkGHvAFkQmXU7ZzNbVUfo2jSZr9bVVJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M8Y3UoZ5S6rEZ2Aby2PaxJrp08/PqGTwPWHiL4Q/k+nLUVB2CjQIxd2vzXTcbCk1Q5R5DSbbv5YZfdru16ikOGydJN39p6b7XsANnMPSpKhZNfmfIPIjZkca1XDSc2s29nXU7ac8v7VR8lX59SUizVj+ZJwgePV+1+iao+b6UQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jWPBOGHG; arc=pass smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8a3970f1a0eso33290036d6.2
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 14:51:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775253080; cv=none;
        d=google.com; s=arc-20240605;
        b=RenXv3/r4fFplZXvqs/4xyl7hgwtmvmSp1wG9+wPNwRdpipbcV8bnlatQY1A/KCHZM
         U7//kTiWN8Ru2a85O38D368baKqIgHnoSOPP/63o/8FzP3rjBcfIgGGd1yjMafmrsUo+
         K9yHRSLgjzGmUHtRNPvHK5OI4d9xLN/jMpN7Gt7J3vmJhXtX8R0ALN0mrPYjukxL881/
         9pHa3fvex/lrGpC3Y1aXEkmezSOFhjAgE7jOuM3pjA+WajWmcSjwcCSl5fVRF7CCAsS0
         n7hMNcrWNAHQMS7K/QrpHo/mD+CHMJYRFGDCvlPY0DqH+PBJlKH3YFiJJC0Pjau18JqM
         URQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0x7xdB777t0lkGHvAFkQmXU7ZzNbVUfo2jSZr9bVVJo=;
        fh=rLXoDT245DMUiFBHMfKqgoTBUDsgHEXu4vvsdrEkyOY=;
        b=Eowbiz2JRI+ztKi/lk1sRafE09oJRo9L1O1S7ybrlwgJgpHLB2bmbqwBVW7rm89PBM
         GhcCn+6BLrtssLWG5SGNMv53BDG6GhCELy6Iy/s7SiVClNl9VKGlFZ3CEDGf90b4RIEe
         3NIr/wdeyw3+lia8FIN2MgE/EZFOk0gquzpYt+FJUwQXBm9Bod2wQxxFW/yhWgcxjKtZ
         NugtK50HI09/deUxcDtpXE9oheWqlOmeeyeALSNizgEpDSlARYrVAfIjdYUTHm6RwW9B
         CjukFtpKy3SBKcrdG0gjjcPynN8rENToDa883x1Yp2Rv0XPVyUnjeL32iSs9elXvtT3K
         bwFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775253080; x=1775857880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0x7xdB777t0lkGHvAFkQmXU7ZzNbVUfo2jSZr9bVVJo=;
        b=jWPBOGHGzJj4UEpFdiAsyldYqNtU7D5Cp4OOhXHxw6teb/IleAT+NuwSS15B9v1rjL
         hMexLk1JjGKiyDXG5jDaO21OBi5p5G5BvT95M2JME12uXm4LR+9EdWq7BXvP8weOX69J
         nNaNt8xjysi8m3dy9NZwFMW4qdjbNYceyfca0uLrIqwaFU5CLW+UcMt1EBq5jrC/u+XS
         bfLjNxC6Z5OOcm3qykMG9TRaZpGP5eT8zKF/4D4Mnk8gXdqM7wrvAx7Ka0y3fmyZewH5
         TPNGdQDJGCP17uthMRE3YeU5ZTsWUB4xJKIQhGlnGHy7gXqj3N3eGc858qqBmohY8OAv
         nalg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775253080; x=1775857880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0x7xdB777t0lkGHvAFkQmXU7ZzNbVUfo2jSZr9bVVJo=;
        b=NLvU8KR6ojYtJ8QZdEA3MmV5ry/ncqgczqD/BgSV02ZdAHD2mX+28dIyb6DnCOqeQD
         jOXRnBGPeVs9mh2Fw2bToOVFlqYF0MV7lsevpNfuyT8KZaPNn7eeL/6fjaSrjsntfo9s
         Np9aUAQ+XKkVAhI65rIGX0ukLPkEEGI2/FmXcPXOXR63eru5tM7TPlRHDghBI0loyuMO
         riSUyMGtpXU1E+OaN5+Hk35IYMtR7b4P5YF1fyXfuVHRSsRbZNWA3amLILDkGxPzHAQP
         oLOzXceroEOCrZCP8VLiaEm/O++nNb/Zqfdy0XjSPCQBG2NHKLjO35U5CfPCDYTfD9R3
         H2Uw==
X-Forwarded-Encrypted: i=1; AJvYcCWuAIcgu8eMseZNMwONPaVI6S9ADOcTZN238oh6FdC3S0wr/MLTutyOLTHeKsCec6GMlHWB87E=@vger.kernel.org
X-Gm-Message-State: AOJu0YysKpRBOLnlMJ2wuf924IHIMkyMy9dLa5dME+6sXENOY7rCLdFm
	zqOP67YsOnI+8fpIw3mdJnRZJa+FWjB/+cYD+EKU6l/w5cj7H3v7YBTGot/wlGW5hP3c2c+/axl
	mzYJQofV1EodJRItqFsoxAe4lbSBVl2zsU+y6SfsV
X-Gm-Gg: AeBDievYHW8zS9gag0hLvLskwsPPlQ0NsRjNHLKxn6RnaxH4EReQdFkv826aTDYaoW/
	VAYqCb7zjP7j0mctIScVpwLiIpcfu9OmSU1yf+9Nq1w/yeR4ByNBkXewVojPxLvKlC6dIQM/ydX
	bi2mWhBuGteBUZvhE7Acxyq0MLe+JZ/2wHR7rsfsjPhFZQrJfXrBzjXSsLUizqEBwR6cFhF0VMt
	8ERGFxJOXTftdTGlCnfk+oOGUM2RKKRK2SiFi2LsdkVT9miXmB3wlbsAlNACXsndsO82u2lAeJV
	j0+9
X-Received: by 2002:a05:6214:501a:b0:8a6:268e:a17d with SMTP id
 6a1803df08f44-8a7025b8639mr77999346d6.21.1775253079950; Fri, 03 Apr 2026
 14:51:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402101732.1188059-1-edumazet@google.com> <20260403214418.2233266-2-kuba@kernel.org>
 <CANn89iKUKTYZ7NVNidtdssZXUAa95LmRpTYUQ29uGE99jLmLOw@mail.gmail.com> <20260403145010.4b4e5865@kernel.org>
In-Reply-To: <20260403145010.4b4e5865@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 3 Apr 2026 14:51:08 -0700
X-Gm-Features: AQROBzAOqUSguDINewmd9Umqei7ztQc8LcY4tLm3CHP0XHH4Q7hXFwetUv8TVzE
Message-ID: <CANn89iJDKPqMnJYqmp+qei8UzdmOuCoZ-T=XGrjHoZh5qDC_sA@mail.gmail.com>
Subject: Re: [PATCH net] ipv6: ioam: fix potential NULL dereferences in __ioam6_fill_trace_data()
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, horms@kernel.org, 
	dsahern@kernel.org, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	yimingqian591@gmail.com, justin.iurman@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,kernel.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-275234-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 40BF039890F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 3, 2026 at 2:50=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Fri, 3 Apr 2026 14:47:32 -0700 Eric Dumazet wrote:
> > > If the ingress device has more RX queues than the egress device (dev)=
 has
> > > TX queues, skb_get_queue_mapping(skb) will exceed dev->num_tx_queues.
> > >
> > > Since skb_get_tx_queue() does not clamp the index, will it return an
> > > out-of-bounds pointer into the egress device's dev->_tx array, causin=
g
> > > dereferencing queue->qdisc to read invalid memory?
> >
> > This seems a different bug ?
> >
> > I mean, do we need to fix all bug in a single patch ?
>
> no no, sorry, i'm just sending this out for Justin or you as a separate
> thing.

Ah ok, thanks for the clarification :)

