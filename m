Return-Path: <netdev+bounces-172097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF003A50354
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 16:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 183BE1659F9
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 15:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557C024C668;
	Wed,  5 Mar 2025 15:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IzsGd4Um"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFAC24E005
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 15:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741188050; cv=none; b=XIj67I77GKZqAk3+CxAPFz3YjBu1mPIvAU0y4kVJN3WKvuLmuRWFr12va2l2mF7Ltj8WLrC8iL9adx6eIAQdGJUlK8ODvdbVYPW0AvR2X278FjkxIkncJjs8LoM1KLVIIWODbcI6R9rwpA0CyErwhMA6kE0QCsYVyuTQ44bwHe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741188050; c=relaxed/simple;
	bh=OjjGO0yF/bVtFNrT/Leb1l19nlu7tpgmSaMDjQfq1G0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jCa80hVRLA4pllcilGKIYmszTq+phfgzSqDtO2d3XhcxPtHc9CCQBiOMvpMFoHJxDNbP7GFwoYbCw7C6qwB3/h78hR55CKbIwFxDu5xj1yyTScZ1zkPxtwRFj72pTf8u9GkRxqqv+aQtyYJCR7dLiGAvuxRwWuEa59Ox5gmijOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IzsGd4Um; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-85517db52a2so121733739f.3
        for <netdev@vger.kernel.org>; Wed, 05 Mar 2025 07:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741188048; x=1741792848; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jvK275tSXvHPQiLNK/xBGRs3h81JlRdlz9efQRemggA=;
        b=IzsGd4UmlzFqGqJ9C2DkWEEBC8qWhluZM4gW9y+y3DVA5ZhZG8CLK9mhIVZxyZrfrr
         fVhj27LoRR3fexUby3PSY4SB+lqo5W3lXqdRtN+xSe+6zYqsz7UFz7sIqfvWR2armjqd
         uJvZt2SGJlvb2A3lhtb92ptweiq9hzV6FFtJ48jSsw5fRKtoJHfO2PmmTi33aOPy5M1X
         kfhz00W6c/ZybaOsYS4/VIp9hyMehcLMIDUD5UG8ioENaZYKMwmcf8ZDzWgzYsCfGf2N
         EDSEbuhH7eMEppdWStYNdKuKFYFvRsiBQtQMV31EjOuoojw1hjz7b4DpAA+PFB4ZN435
         uvzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741188048; x=1741792848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jvK275tSXvHPQiLNK/xBGRs3h81JlRdlz9efQRemggA=;
        b=QB8kyxCle14aQRTpnfackAffnFgkV4NtrqrZoS9EK+TqGh2uF0KDuUs7g29QJwBqp5
         4yBL4lefrH5cgWZlNWdtZrjq3RRiUPCxLhDRaLoVPsM3z4Lx3UZBsZv4fhbGJAQ5Qsdx
         0N3kXTt6ZrpUVbnb6WWp5e3wihSDrq2SAdXj5GdS35E7cwXCRW0Gw21yitrQWrmu6nPX
         hi8CV1uRGVBBDUhx5WEsJsjj9gcK/GNMo0NUlolIWLZ1E7xTPASQ9gx582fSNtfxu0r2
         ion1V+XRaHDdE3ui0QrD8rZ1uJ/TsAMNgZo6e6/lqYE8xfozraIkW55miU7KAJ1UMxYi
         R3BA==
X-Gm-Message-State: AOJu0Yws6LuC8a95Pl8VywFsBjjgoXECk8n9jDy/0E+4eDwnnJa/2+8O
	mfYyfnHaTOacCUFaZE69I+HSd4ADpy0nZDs7R7onDHUX7aOF5F96HAF1WYcbDQ/zrGYM2xSl21f
	GjiGufCy4UFrUwyHkw6DzI0ovRxw=
X-Gm-Gg: ASbGncsIGXsCSnWqOJXvyA3pSFFCjKX+t6l5zlt9lU7wqPBuBdf5Lsr6/P7lHw1xLW3
	EktelvZ3RXREnJ32zSMaNcHlMIf7UkXgSS0TYsULtY6cLsNduq7vznpU5fxNY2XJPEwsh2rtsfq
	6UrI/BWHkJ3aZ7jrSBPz9nA8lJNp27G3RK3zlVdm50+DhQ6YoVtEnHEyBULA==
X-Google-Smtp-Source: AGHT+IHDfwG5mFdn4XwSs2pXmKCMUHKBKdrIgA+GVaKmhjqWUm9xb1+da0LC/1s7qe1EW+zlVMJq0r6uNKh0QL7UBj8=
X-Received: by 2002:a05:6e02:1c89:b0:3d4:2305:a1bd with SMTP id
 e9e14a558f8ab-3d42b97561dmr39536725ab.15.1741188047659; Wed, 05 Mar 2025
 07:20:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b7c05496f8ead33582eb561b55d3e2fcf25bcf36.1741108507.git.lucien.xin@gmail.com>
 <f7teczc70m1.fsf@redhat.com>
In-Reply-To: <f7teczc70m1.fsf@redhat.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 5 Mar 2025 10:20:36 -0500
X-Gm-Features: AQ5f1JpTHl8XUB74OVDSTrI0t1vF6D41I44nfMEskvUQfozGvmJKXQR82VXCUtE
Message-ID: <CADvbK_c32VgdixBdCzVSpD5sptcoRzuD4NbxdxChLebWLiN85w@mail.gmail.com>
Subject: Re: [ovs-dev] [PATCH net] openvswitch: avoid allocating labels_ext in ovs_ct_set_labels
To: Aaron Conole <aconole@redhat.com>
Cc: network dev <netdev@vger.kernel.org>, dev@openvswitch.org, ovs-dev@openvswitch.org, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Jianbo Liu <jianbol@nvidia.com>, 
	Florian Westphal <fw@strlen.de>, Ilya Maximets <i.maximets@ovn.org>, Eric Dumazet <edumazet@google.com>, 
	kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 8:00=E2=80=AFPM Aaron Conole <aconole@redhat.com> wr=
ote:
>
> Xin Long <lucien.xin@gmail.com> writes:
>
> > Currently, ovs_ct_set_labels() is only called for *confirmed* conntrack
> > entries (ct) within ovs_ct_commit(). However, if the conntrack entry
> > does not have the labels_ext extension, attempting to allocate it in
> > ovs_ct_get_conn_labels() for a confirmed entry triggers a warning in
> > nf_ct_ext_add():
> >
> >   WARN_ON(nf_ct_is_confirmed(ct));
> >
> > This happens when the conntrack entry is created externally before OVS
> > increases net->ct.labels_used. The issue has become more likely since
> > commit fcb1aa5163b1 ("openvswitch: switch to per-action label counting
> > in conntrack"), which switched to per-action label counting.
> >
> > To prevent this warning, this patch modifies ovs_ct_set_labels() to
> > call nf_ct_labels_find() instead of ovs_ct_get_conn_labels() where
> > it allocates the labels_ext if it does not exist, aligning its
> > behavior with tcf_ct_act_set_labels().
> >
> > Fixes: fcb1aa5163b1 ("openvswitch: switch to per-action label counting =
in conntrack")
> > Reported-by: Jianbo Liu <jianbol@nvidia.com>
> > Signed-off-by: Xin Long <lucien.xin@gmail.com>
> > ---
>
> Just a nit, but after this change, the only user of the
> ovs_ct_get_conn_labels function is in the init path.  I think it might
> make sense to also rename it to something like 'ovs_ct_init_labels_ext'.
> Then hopefully it would be clear not to use it outside of the
> initialization path.
Right. If you're okay with it, I'd like to delete this function and
directly use the following code in ovs_ct_init_labels():

cl =3D nf_ct_labels_find(ct);
if (!cl) {
        nf_ct_labels_ext_add(ct);
        cl =3D nf_ct_labels_find(ct);
}

since the function was originally introduced for only those two places.

Thanks.
>
> >  net/openvswitch/conntrack.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
> > index 3bb4810234aa..f13fbab4c942 100644
> > --- a/net/openvswitch/conntrack.c
> > +++ b/net/openvswitch/conntrack.c
> > @@ -426,7 +426,7 @@ static int ovs_ct_set_labels(struct nf_conn *ct, st=
ruct sw_flow_key *key,
> >       struct nf_conn_labels *cl;
> >       int err;
> >
> > -     cl =3D ovs_ct_get_conn_labels(ct);
> > +     cl =3D nf_ct_labels_find(ct);
> >       if (!cl)
> >               return -ENOSPC;
>

