Return-Path: <netdev+bounces-272595-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wG+oIrGYxmnrMQUAu9opvQ
	(envelope-from <netdev+bounces-272595-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 15:48:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 847C73464E4
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 15:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9DC7D301CAB4
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 14:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A74F3F9F27;
	Fri, 27 Mar 2026 14:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qqR2JPcd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE503F8DE2
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 14:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774622848; cv=none; b=syZ4AS0COUWb7UCpUC8XvgxNITAO7n515+0qBF5W+K4X9g5hMfY9YSUNbNcRwgAcsKyphdj1qbB89Se3crzZSYBf7mxBSLnt2fvkZ4dsEZvZD25nWB8pM8oxSQEQjbzwKtyIzJrGm6Y9W4Hip4PfrslHTGjjERBSJs0Ik592gvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774622848; c=relaxed/simple;
	bh=WvZF3DPpKluIo9MUvgvF1sOeZc01c39/L7+p0PCtXi4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F+ZG+ubpzyZZYP4MYbFL5j3krt8kP70i9xxkL10yhF2Dy4SkJLbukHGR4rnNgIeBv8h12JEj1b/xcHzZ18H+XmgucCSXm+lN0sZxGL83burV8kirgGc+fVhp1zoI3bro4OASDHoWhZQwQv+3287Yy0qov5Ko0a0IKXiCec22jTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qqR2JPcd; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82c646e980bso1593166b3a.0
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 07:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774622845; x=1775227645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Odcj+dtYWYVFjEUNAdIYNWIQsMvoa8Apjs5i0aEIWnI=;
        b=qqR2JPcdL3wSBgsboqVUihnSlNBfcytpASuHacHJYz+QYafEcngv6dVBqscEJSC/jZ
         TzEATTvAksNRbc/glTIOx2qAmlLGHj7JyEcXXmrnhgdOoi2nNehpEHHqR397ANu/L/4f
         Y+zxw9Hx53T8MJ5hwLz53LG1ybOZ7MY//AQPV9JaORPsZQRjxCiywRxBKPIe9/l/TJDc
         mMJMthW10wyzHsU6emwwQOutlQ+VF05FV85WupC1pLg4FRzG50CgjMWz8Vd9tuub58Ew
         +ylsdY7JKyPXkQIi0ZEqowZrk3Bsf/puIMfP85QjJneXw3W0KPK5UakEVLN380pHFN2H
         CXIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774622845; x=1775227645;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Odcj+dtYWYVFjEUNAdIYNWIQsMvoa8Apjs5i0aEIWnI=;
        b=YnRLzcMW+kskVeJW7hzLrubblM1MhDDFpMP8+b4DXTyJD9cT/DO70CBGaRZSYDAOUq
         Iq2KYFE+L7kIS+a0b0cFHgWYQm7KvZtbbeU2mWVyhfZb/wYGl0bhTzNCuYPIKLC5nlQy
         dSSN9rREzl8RC2G95W6UpkNPyAohF/kwBXhAvcxemJVHUW7tf9UeXWiqXhqTDXaGt4Mp
         ywSs6S2BLRMPehT2rW3F9Cxwf9Hf4c1KbcDpXMvRQCtVW5d6sJkN4LGkX9fqWvoHbYuG
         Oc9P4brZsCHOeS5JawswjEtdkqBV+mjYEMjIluSGAvRLRWx23X5boDrTiZ0ciZ8uM+x6
         a8zg==
X-Forwarded-Encrypted: i=1; AJvYcCWaflzQegvKBJUQP3vssv/WWW+byW6Zqsj04kCr1T6W2ZnU0ar/RFXPIru70B8VomJRAaq9mKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBxtjKJJs/kNV0qrqQTTmTePe3dGV5/6PXjqaR2d++123jto9z
	JedOM7bx+cZrTCzf8jMW+7NHFKAyuUrny75D5L+mRH9HSVjwrycd9Cmvj8vw6bi+R7NyHVK1zRh
	lvAfU7g==
X-Received: from pfbcp25.prod.google.com ([2002:a05:6a00:3499:b0:829:9bf2:a284])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3691:b0:829:a127:530
 with SMTP id d2e1a72fcca58-82c96059644mr2802752b3a.31.1774622845197; Fri, 27
 Mar 2026 07:47:25 -0700 (PDT)
Date: Fri, 27 Mar 2026 14:47:04 +0000
In-Reply-To: <CAL+tcoDZx9j_HuzTge3u11_kz8FmEVfw_DMzMRzRd9hv+gjTdA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAL+tcoDZx9j_HuzTge3u11_kz8FmEVfw_DMzMRzRd9hv+gjTdA@mail.gmail.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260327144723.3344613-1-kuniyu@google.com>
Subject: Re: [PATCH net-next] net: add sysctl to toggle napi_consume_skb()
 alien skb defer
From: Kuniyuki Iwashima <kuniyu@google.com>
To: kerneljasonxing@gmail.com
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272595-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[google.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 847C73464E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 27 Mar 2026 18:37:19 +0800
> On Fri, Mar 27, 2026 at 12:21=E2=80=AFAM Jason Xing <kerneljasonxing@gmai=
l.com> wrote:
> ...
> > > Seems a copy/paste of proc_do_static_key() ?
> >
> > Thanks, Eric. Much simpler right now:
> > diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
> > index b508618bfc12..a6a1b2c3f8e1 100644
> > --- a/net/core/sysctl_net_core.c
> > +++ b/net/core/sysctl_net_core.c
> > @@ -676,6 +676,16 @@ static struct ctl_table net_core_table[] =3D {
> >                 .proc_handler   =3D proc_do_skb_defer_max,
> >                 .extra1         =3D SYSCTL_ZERO,
> >         },
> > +       {
> > +               .procname       =3D "napi_consume_skb_defer",
> > +               .data           =3D &napi_consume_skb_defer_key.key,
> > +               .maxlen         =3D sizeof(napi_consume_skb_defer_key),
> > +               .mode           =3D 0644,
> > +               .proc_handler   =3D proc_do_static_key,
> > +       },
> >  };
>=20
> Eric, when I'm investigating the static key feature, I wonder if we
> can replace some sysctl knob that only carries either 1 or 2 with a
> corresponding static key? The merits are 1) we can minimize the size
> of net.core.xxx or net_hotdata which helps put the structure into one
> cache line, 2) in hot paths, the static key can be more efficient.
>=20
> Here is the list that I've found so far:
> 1. sysctl_bypass_prot_mem
> 2. sysctl_tstamp_allow_data
> 3. net_hotdata.tstamp_prequeue
> 4. sysctl_tcp_early_demux
> 5. sysctl_ip_early_demux
> 6. sysctl_tcp_l3mdev_accept
> 7. sysctl_tcp_moderate_rcvbuf
> 8. sysctl_tcp_nometrics_save
> 9. sysctl_tcp_no_ssthresh_metrics_save
> 10. sysctl_tcp_dsack
> 11. sysctl_tcp_abort_on_overflow
> 12. sysctl_tcp_slow_start_after_idle
> 13. sysctl_tcp_timestamps
> ...(some other tcp sysctls)...
>=20
> Some of them can be accessed in multiple places, which means they can
> be hot. Maybe we can try some relatively hot knobs first, like
> sysctl_tcp_timestamps, sysctl_tcp_early_demux...? Do you think it's
> feasible?

Note that a static key is only avaiable for global knobs
while most knobs you mentioned above are per-netns.

