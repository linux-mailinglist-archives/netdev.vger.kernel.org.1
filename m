Return-Path: <netdev+bounces-292435-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDQTHq9GF2qS/QcAu9opvQ
	(envelope-from <netdev+bounces-292435-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 21:31:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9A35E982B
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 21:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14650300DDCF
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 19:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A52376A1A;
	Wed, 27 May 2026 19:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cy7+5Uog";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qex4Gtce"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E73D374758
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 19:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779910193; cv=pass; b=JwRIDhYxuS5piCDoajZH8YNylqdOmIKJ22eRLityV2wwVngz7ccFJGkeekU8jfvU6Ov67I/0TGpZ/C93QMDXKOflzzrSfBnqpzKFAPu706OCeOQCkMeCSb8zlp67XGnVkbcSdzxANAxPbSlD5U69m//m1W1YdOqpNN5qoyapOWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779910193; c=relaxed/simple;
	bh=mI4DM/wWXgFpRBoa1oWbSDDYSxPkY0g0LzVWkMC3hhw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WnQI+xWfzi2FfAuPj9Yolomcjb2hpdZSSa60oDhlMD4OUuwZ2mWmviHhAlBirHdQoQ+qbIW9YFWbFTVK8q4vuf7Ha7VpXka9S9i3kaRGEQ6hUt5iaVC9m8wsQXK9RWrGOx11+q1bZ/iIQ7/AblgMaMzzBGVwJtS7AMZGgOm9jeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cy7+5Uog; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qex4Gtce; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779910191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zmOixJ8OhAzEjiG1t8Rown3BNCiSEDWt/TKSXpZPIRI=;
	b=Cy7+5UogVC8vBQyAJq6yrxM0bQETij/EY54BCrkKIr1Fgauphd28Fc/oiho03osIp3Wa2j
	vfIiw8qKxZTe0O21YaCizC4qLGy/9I/o+sR+hzzqz79Zc/7SenqyDyNdXBmiSbfenY1MFf
	lR53nl39tAloeenbZBnSpMz6WkdNQik=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-Z5JvpHR_Mw6rswA1fFOnww-1; Wed, 27 May 2026 15:29:50 -0400
X-MC-Unique: Z5JvpHR_Mw6rswA1fFOnww-1
X-Mimecast-MFC-AGG-ID: Z5JvpHR_Mw6rswA1fFOnww_1779910189
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-bdaf3ed080dso857594266b.0
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 12:29:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779910189; cv=none;
        d=google.com; s=arc-20240605;
        b=MelsS4IcpFF2Bm/we2XcBeHlsIBEa7aWdNjWJf9sjObY4UdytPlRBYhSOwJyiRNjTy
         7XeRVGTFlAF4JYC9/MUtpBBnnGv30MG3UkGCI8X8og0bBdnJtUZ5GAMd48cKnUqnMUAT
         dzDFBpwkDaifq1DpWuIJF4Vij4CxRLIPNn7j0425dQk61Ds7Eon1ZX9KguDlsKjzHL/l
         GsyCzG/jKTa2FK4eNqg741iEb3NTqlFOmAK8R8zvzm/UwQ3Fh7sAO5Cf+G/JPKnQOi4V
         FO7wG3gSfvLCuhmy23TIJZePpD0mLdOKBNflnWe702ebkufwIsALHCR+9zv3Xm9RfpWM
         CpMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zmOixJ8OhAzEjiG1t8Rown3BNCiSEDWt/TKSXpZPIRI=;
        fh=dDWxIercJX0UniPvjYGrnVRxx27JbmSHrbThOxnjQ/I=;
        b=gGxn0l1DwG7kM4KO2BPZbXSNwDz1aVO6CO/PWCV/qOp8GNhr6FEW69NF6qoG2KG//S
         CMQSeb0k4+XxDNhi/+/SNE9EGzqWamddnPBZ/wFWYXg/g2uE3hzgnMAuc9hCCxkppk/y
         WPglqn9ivfRwjBC+N3Q6C0+25PBW4r6B2lLkRLCEkOdKILfEMgY/iOlNN3HNNz7aw0vl
         YBvQ4ar8+RdXbtAJgdm0k4fPK+ELy56uF4au/kmJ9VTXOqAq4NxUhnzH9KgJgheLaf44
         jKYoOOSKsWwZMeKroVbWOJFH7uFtcnkhKXs1mgH4LG+vb9ek4s0IXICTmYsFE3i2IlOu
         tJEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779910189; x=1780514989; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zmOixJ8OhAzEjiG1t8Rown3BNCiSEDWt/TKSXpZPIRI=;
        b=qex4GtceIzW5/0eMLtyC7ZfOx8PwtZ4ZPjFUjmJYXmmbRzVVVw1i5WN8qasWuDHXUF
         1+DPa9H0NPDdvuZIvgFjCuOiedHoogsBC3OBmsEwXg8zyRIn+OTWCMths3vn0BvvgtpI
         +VRvHE0INEvxpOYFCXd8UrVdV8sCYyEXoNlMX0whFZkv7bRMX2ZPyh4iDS0mpBCH1vnl
         +SibQI+5fGUxuAgM+1gSFwqvRFUaizvwU/fX0HiLvlFGeuZhXt3XKNe/kj7viz5FABIO
         z+e/vgLHIxouWa45HjPy6dQ3q0XdVrMn/gxgmYdB7sZxh7/fgdJVexCA8IE0tXq2lTMj
         4D8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779910189; x=1780514989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zmOixJ8OhAzEjiG1t8Rown3BNCiSEDWt/TKSXpZPIRI=;
        b=VI7BEtfloIuVrvMH++7TKbxH19oTAT7ef0ZsC13S39ctFDiQvWOXOlRBEJnQ3K4piM
         T44XxkhM+IiryLa2Y+vnr2DZif8vOlED7WOqNZk+hlNTED2grxHUXLcwKPO4Wc/6pnYO
         R5A2WYWuz2lYk0lEIofx41cb/pWnfvzx7ms31NpTnE2gQ0plNBow644FU4mT/VCya4ab
         pDSuqkIxJt4NRDIkoKUlnxo9WD05EkuF4v3opWtw9TJreu5lwMF66n6H+vjxL+1AdZVX
         30L0cFE+AtTFGqaoCqQlEzVxo4pvBTYGC7Hn44lbeDCTQipwLbfNroDuxSmpXn5DRVey
         SUiA==
X-Forwarded-Encrypted: i=1; AFNElJ9qvCPe3/xtQX3KzVEMBZod9hmPde5thNYJydaNX55/knRN8G5UMTXmOzMsxnWoXYHQ3QCjXUg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz13EF/mvBqGUxyjRax/5uVLKgD2O06dJQNA5OrHa4uEqB355ow
	rF6CtoHshNzPb2hDjE5aHRneKqr0MaNMGMUbSvFpUnKUUfg0YKd41bqNpmgvbthdqIVStTmt7e9
	GqGPM9KHtRH3bwnGgoWXilVoinMkvmlX1w1aBR4x5/XmmLAwVD+fEOdDsuuV2Qu0gyBW2rMSngM
	tLB7Y9jGJVjtzfgC+DmAr97F5QRA3CDCZl
X-Gm-Gg: Acq92OFcHeHktWEz0vCCMpCxLxVgKZlIl/0AJeAsXgOZnWkKqe5yZWdXeRzmmG/zv+h
	3h1UWniQx33dIbzogh8o2Zb+g2wH/sdfnK3Lxw1RxuvrJPYb6jd+3VGdGl7vkj80cUY6RFqft7x
	dv6mE/SmKIwTjDuF5F7xMOdzBPD9ocK+06lKYbYL6eNFxMWQeW+Ypq7IHU0pUOgG+MOzrJma4Ew
	lyAsqK6m7Q4/+bQzgADHAjVxvaFRzdI9w5dBS9Fz3ypbQd3qRtv/Bci4qAQVijZDAEZgAeXROcu
	4GJCKgXwjnAYlb6By6jPuUv0bkBn7Z3qvdY=
X-Received: by 2002:a17:907:501f:b0:bdd:f2c9:80cc with SMTP id a640c23a62f3a-bddf2c98604mr929426466b.21.1779910188845;
        Wed, 27 May 2026 12:29:48 -0700 (PDT)
X-Received: by 2002:a17:907:501f:b0:bdd:f2c9:80cc with SMTP id
 a640c23a62f3a-bddf2c98604mr929424966b.21.1779910188396; Wed, 27 May 2026
 12:29:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513172443.1128496-1-rrobaina@redhat.com> <20260518173507.2f2529c9@kernel.org>
In-Reply-To: <20260518173507.2f2529c9@kernel.org>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Wed, 27 May 2026 16:29:37 -0300
X-Gm-Features: AVHnY4Kl_unlcX1KSh4XkjPdquZdWKNsmSzuZiNKp6pIC0wDMd2CoGNSVFOT7sI
Message-ID: <CAABTaaC98dqM8U-7xkdW=b=50UKu0SQyBO629LDdphQ9DC=P=g@mail.gmail.com>
Subject: Re: [PATCH v2] netlink, audit: prevent false ENOBUFS on timeout expiry
To: Jakub Kicinski <kuba@kernel.org>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, paul@paul-moore.com, eparis@redhat.com, 
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org, 
	Steve Grubb <sgrubb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292435-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rrobaina@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: CD9A35E982B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 9:35=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 13 May 2026 14:24:43 -0300 Ricardo Robaina wrote:
> > When auditd is bottlenecked (e.g., by slow disk I/O), kauditd blocks on
> > the netlink socket.
>
> Holding socket lock during slow IO sounds very wrong. One could say -
> that's abuse of the socket lock?
>
> > If the wait timeout fully expires (timeo =3D=3D 0),
> > netlink mistakenly interprets the zeroed timeout as a non-blocking
> > request. It then triggers netlink_overrun that drops the event,
> > completely bypassing the audit subsystem's internal retry queue, and
> > falsely returns ENOBUFS to user-space, resulting in the following error=
:
> >
> >  auditd[]: Error receiving audit netlink packet (No buffer space availa=
ble)
> >
> > Fix this by detecting when a blocking sender's timeout has expired
> > (timeo =3D=3D 0 && !nonblock) in netlink_unicast(). In this case, inste=
ad
> > of retrying with timeo=3D0 (which would incorrectly trigger netlink_ove=
rrun
> > on the next iteration), safely free the skb and return -EAGAIN, allowin=
g
> > the audit subsystem to gracefully enqueue the pending event into its
> > internal backlog.
>
> The socket _is_ the queue, normally.
>
> Please explore fixing this in audit?
> --
> pw-bot: cr
>

Hi Jakub,

Thanks for reviewing this patch as well.

First, regarding the lock: kauditd does not hold the socket lock during
slow I/O. The sleep in netlink_attachskb() uses schedule_timeout() on
nlk->wait (a wait queue). No socket lock or mutex is held during the sleep.

Second, regarding an audit-only fix: the symptom manifests as sk->sk_err =
=3D
ENOBUFS set inside netlink_overrun() (called from netlink_attachskb when
timeo =3D=3D 0). Audit has no mechanism to prevent or clear this socket sta=
te
from the outside. Potential workarounds all fail:

(1) Clearing sk_err after the fact is racy and affects other socket ops
(2) Avoiding timeouts entirely defeats the anti-deadlock mechanism
(3) A new NETLINK_F_RECV_NO_ENOBUFS socket flag doesn't exist in stable
kernels where this bug is actively impacting users

I've submitted v3 [1] with NETLINK_UNICAST_TIMED as an explicit opt-in
constant. This is strictly additive and leaves all existing callers
untouched:

- Standard blocking (0): unchanged
- Standard non-blocking (1, MSG_DONTWAIT): unchanged
- Timed blocking (2): new opt-in for audit

Would you mind reviewing the v3 and checking if it would be considered?

[1] https://lore.kernel.org/audit/20260527192150.949400-1-rrobaina@redhat.c=
om/T/#u

Best regards,
Ricardo


