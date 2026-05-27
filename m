Return-Path: <netdev+bounces-292433-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDfLCRdGF2qS/QcAu9opvQ
	(envelope-from <netdev+bounces-292433-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 21:29:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E7C5E97EE
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 21:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC1763035A87
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 19:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD7E376A1A;
	Wed, 27 May 2026 19:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gcY0Nv87";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DoeHvw2S"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD2A376A02
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 19:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779910023; cv=pass; b=B+ntQGHrHYWfZX6azla3zf1112KmPfUYKgVYmdUqn6X8XukT29ldAh7DTQ2HF0bzla0N3BvEHpeqof30HHeCreCV8dmewktX//XogiTjYGA8jKN1KFOGuTOmLX3JmKHkH6uY4Qgysx9P0eC8eLIO8ExZBmHt8svps/d6JOCHMFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779910023; c=relaxed/simple;
	bh=tRyD8S/7RSDfaZDKPuW63Y75gzxAnkDJsrt5x6tXdl0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nV9bJ1C4gH4k0lWavGor8NsAyL0u/kbO4p3o3aDNqlTmaKq5v1lRm2o1V0KrXeEo1rL1gxnuCIoaUX/Ww3vSe3+fzNLhi8JOob714IzsO42Y6LbVmSVVCW5bwhG+viMEoP+ti1jtVJQ1dyYinNICnluORuQks+s57ko+f+5Orac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gcY0Nv87; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DoeHvw2S; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779910020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eDgC1+ol0lrg6Hw8wi9KK+95vBs3YsLQwxjbK9FkMtQ=;
	b=gcY0Nv87hZb1UldloeylwUMle8Pvc9SOKvLOldstbb8SQLYFcaVAtlxrhOsBmLOCDGYjsc
	uTHCXfy3AE/D3AFPv3hrahIUYsojXe/8zvREDwdXahid3xft91XY7/PnULXbu8eW7igwPB
	Dp+eADtqJRh2QdJsaIVYheIUiOnwYkM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-f5yLsqA2PD2n4Sz24hmI1w-1; Wed, 27 May 2026 15:26:59 -0400
X-MC-Unique: f5yLsqA2PD2n4Sz24hmI1w-1
X-Mimecast-MFC-AGG-ID: f5yLsqA2PD2n4Sz24hmI1w_1779910018
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-bd52e4acb11so898248766b.3
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 12:26:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779910018; cv=none;
        d=google.com; s=arc-20240605;
        b=CvZIzncwLKkDR6uh6nvG2DoqZYpnMSIGTGF2XJVLednaHWCdA8qxAD5CF2+OZvj09x
         xtTL6QoWZZF7zYcenMOT9Kxj3Q3eAwFg+F9pCm8xk3+ACnpFBiDsHuKLuZoNBw5DjQwo
         eULDHxsx9pwO7v7F2kmlbcy3saAbczcakAkzQVKQe45iFMEdZp0JUHHwNQ3AurhFi5LW
         HhL0xL3z20KsTUxFFI3+4Zt9FOXsOiolnkOB+LInzEFMZuPWkqddO/fYvvE2iZT+vDNv
         8kskNvESoZqBkQN8kqZrn9j4cgw1lCZvluowFbqXRRPFS4/Ms6BITfv66rfA1coJg/wi
         GtwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eDgC1+ol0lrg6Hw8wi9KK+95vBs3YsLQwxjbK9FkMtQ=;
        fh=KpBDcKWJjEhnmfqv/J7qM8mJafnBqVE4LqXTKEMpPLI=;
        b=gVThxzpocTBGsVNaYEZT8N1/FOwRnTI2HKcu/01JkI0FiRMX4jcyYIkh+hQS7a/Vwa
         6nWG4RoDx4xYO+DajYt5qrDKWGkmWDW2S4phyOorsK4qe+DKRKUsRNR4cs8FXxIB91z6
         bne20vVQEtR7TfSwCLwmmhfRhxaMpRUd0FJGG0H2G2A0N/q0ER0E6aVOq/uN6b2apCOR
         o4Pqx7HzMANvMQT3s8YQJ+VqHXBa4cPco5KSkFf9DEotmjHNZrkUAzWMzBiaYdJGG6MN
         iOxoM038ZASozpRTl8IqyptKF4SqpRhtpxB5yLximtDOnabBXvqNOV2RiQqPKCDNiFbX
         oFIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779910018; x=1780514818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eDgC1+ol0lrg6Hw8wi9KK+95vBs3YsLQwxjbK9FkMtQ=;
        b=DoeHvw2SIASX+6u59CFRdS4WPIU8xrhzbR0ntRaT6auHowbd1cZSPgEdKeD7VoFt+M
         GlbtDLrOwTID655T6gJ7HqG9I+LMCvL8YWHrcLz5FBvAsQQNSVIpgeiaW19CCx+D6lHM
         WpOYSVlQC/tU2RfsJoncT3oZYezHhm4U4hyHXjtORLv1PveqM5j+b009PkLWelWvMIu+
         xUwZsgbJmXAdtDCYqQ+VX+ylsIM/OoD/aEGS2DUPxfT8NRT6d+UU8Xfxk7fIqUhH3+dl
         1LJ25uXmPcwIErW+xXCQJF9esM/QaK26nGgSleKr4+YaDQ0kCHR2Kljlmw8I3ods6Lu6
         O/Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779910018; x=1780514818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eDgC1+ol0lrg6Hw8wi9KK+95vBs3YsLQwxjbK9FkMtQ=;
        b=kpibaFAituI1nvxxtPHNBpG2Zna1/a/tlm+i8g5GyrxWXuIBNx2YRkryPGFPhLA6PC
         VzQGd9MmkCkAkCgR5/nzbbHoxh3Yfj242z5SiH+VAP6LK2+aPNmYIbP6JH+M7ozTTSxU
         Uw2qINZVr02auYQcHpG68aSq5eWOU6Wayog5LhOJjxE1SdqjWKTq28B74MeKYr3YlyUz
         6iqvEZ0ZenCbM7U0wJDUX5fzWYbEl9jfLQSqw3KbFFkF+dVt5RwUQA7ZzxTd7xAyZh1q
         CcVKPKrmpA6j3LaZK8vA87a+OLvMaC3Z0KESc98p91CXCJdkNqR0/oQvWk1zsf7YlZLf
         29wQ==
X-Forwarded-Encrypted: i=1; AFNElJ9qSt7aQoF/et4ooehb1YgJF57geygze8kN7ww7Gq3+WrBnyIqhn+b02zOYRF4i02W2Lwne2y8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoGSYU8BHDsIeHf6MwlHozEcKtYiUk1I2C9OYFWFoN1PiERQXK
	ii2CoWREt0mhBbp+G2dV2KeVef0J7vywL8ejysYlcKndBmH8Jid6Qykeo/YigUtYyCrHQ9IKi6g
	X8tsgIacUn3fKbQnTRja8IlqXDMrYED1NzrV0DCiG2kzlFIMIrjUO3Unxo+Pexo/+oIph6FUEQP
	0MMdd9lboyUcpw9bOF0KAdZZ28+v7zvmkv
X-Gm-Gg: Acq92OF30bYPlI/fs1kZcuKbeAlCbuc0iWV0OF4sGnHgv/WngOAUTrIMWoE8eRARCut
	GTwWJrK2K0XFcKCSy1FsnHfsC9jd7s5bIMtYiA1C8IC/7D4gWoskh+dMQmXqUpzGsFTYUGI6SFL
	XJMrBq+33d5pvVpmDppwOeJ0+u3wOvokksqVi7BpBPdHsv5CJmMJwa5tQYPcK2YsLIus17Z6/oF
	HhUwew92pYG39xd7Qmjtvr0OuiIwkepZ3j5S5WanMOuTgPLs1vgwggzzF+FdCEYMcAgL/S8zeOs
	QoAiHcAh1d0wkfi3cGwsF2JYvTltbmkSpRY=
X-Received: by 2002:a17:907:d40f:b0:bd5:7c2:70c9 with SMTP id a640c23a62f3a-bdd281aad31mr1622130966b.47.1779910018054;
        Wed, 27 May 2026 12:26:58 -0700 (PDT)
X-Received: by 2002:a17:907:d40f:b0:bd5:7c2:70c9 with SMTP id
 a640c23a62f3a-bdd281aad31mr1622129366b.47.1779910017620; Wed, 27 May 2026
 12:26:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513172443.1128496-1-rrobaina@redhat.com> <20260518110345.497489-1-horms@kernel.org>
In-Reply-To: <20260518110345.497489-1-horms@kernel.org>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Wed, 27 May 2026 16:26:46 -0300
X-Gm-Features: AVHnY4K-reI0086BeMjQSycAAft71q3cHtqRbjZQbDcDy0iRCMsusMf0JXZo2uE
Message-ID: <CAABTaaA-nzvY8Ki1Lx56BOei+ppgBRZ35Bn=zR1jJ77u=V9ZrQ@mail.gmail.com>
Subject: Re: [PATCH v2] netlink, audit: prevent false ENOBUFS on timeout expiry
To: Simon Horman <horms@kernel.org>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, paul@paul-moore.com, eparis@redhat.com, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, sgrubb@redhat.com
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
	TAGGED_FROM(0.00)[bounces-292433-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 75E7C5E97EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 8:04=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> From: 'Simon Horman' <horms@kernel.org>
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev
> ---
> netlink, audit: prevent false ENOBUFS on timeout expiry
>
> This commit modifies netlink_unicast() to return -EAGAIN when a blocking
> sender's timeout expires. This bypasses the netlink_overrun() call to
> allow the audit subsystem to gracefully enqueue the pending event into it=
s
> internal backlog without falsely returning ENOBUFS to user-space.
>
> > diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
> > --- a/net/netlink/af_netlink.c
> > +++ b/net/netlink/af_netlink.c
> > @@ -1351,8 +1351,18 @@ int netlink_unicast(struct sock *ssk, struct sk_=
buff *skb,
> >       }
> >
> >       err =3D netlink_attachskb(sk, skb, &timeo, ssk);
> > -     if (err =3D=3D 1)
> > +     if (err =3D=3D 1) {
> > +             /* timeo may have been zeroed by schedule_timeout inside
> > +              * netlink_attachskb. If the caller is a timed-blocking s=
ender
> > +              * (not genuinely nonblocking), don't re-enter with timeo=
=3D0 as
> > +              * that would misfire netlink_overrun on the next iterati=
on.
> > +              */
> > +             if (timeo =3D=3D 0 && !nonblock) {
> > +                     kfree_skb(skb);
> > +                     return -EAGAIN;
>
> Could this regression cause silent packet drops in non-audit subsystems?
>
> While this change prevents false ENOBUFS for the audit subsystem, other
> subsystems like InfiniBand's IWPM use rdma_nl_unicast_wait(), which sets
> nonblock=3D0 and operates on a kernel socket with a timeout.
>
> If the timeout expires because the receiving user-space daemon is
> bottlenecked, this new path will free the skb and return -EAGAIN without
> ever invoking netlink_overrun().
>
> Without netlink_overrun(), the receiver's socket error is never set to
> ENOBUFS. Would this prevent user-space from being notified of the dropped
> message, leading to permanent state desynchronization between the kernel
> and user-space?
>
> > +             }
> >               goto retry;
> > +     }
> >       if (err)
> >               return err;
>

Hi Simon,

Thanks for reviewing this patch!

You are correct that the timeo =3D=3D 0 && !nonblock heuristic in v2 relies=
 on
an implicit assumption about finite sk_sndtimeo. While RDMA/IWPM with
MAX_SCHEDULE_TIMEOUT would never reach this path in practice, your concern
correctly identifies that the heuristic is not surgical enough.

I've submitted v3 [1] with an explicit NETLINK_UNICAST_TIMED constant
(value 2). Callers must explicitly opt into this contract, leaving IWPM and
all other subsystems completely untouched:

if (timeo =3D=3D 0 && nonblock =3D=3D NETLINK_UNICAST_TIMED)

This ensures zero risk of silent drops or state desynchronization in other
subsystems. Does this address your concern?

[1] https://lore.kernel.org/audit/20260527192150.949400-1-rrobaina@redhat.c=
om/T/#u

Best regards,
Ricardo


