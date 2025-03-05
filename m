Return-Path: <netdev+bounces-172093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D544A50311
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 16:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78757164C0C
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 14:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C057824C073;
	Wed,  5 Mar 2025 14:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hllSFus/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C55D24A067
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 14:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741186766; cv=none; b=Xhn8/rk71L5Vf7zwee6R+8iw3rD6rvSSzlDCsCen4u9xGV/zVGe9U71608behoWTM05PizUOAPf+mniLpEBhVcIcL3ROjSRGI1Lcqu/998+y2r0QGdbpBBsXiTAIfIC4BorNXMpTRN3c5fQWP+RuBrhkdbOq/YMpnI/VdwXa0cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741186766; c=relaxed/simple;
	bh=1CQXj5lqNDf3ereRfcNRnmGJv8Pzf30z8+ukXV4RREU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T3YpfEixLxcWh7xJ4RRJ98nEbGK9u2joZspP8iP3cNifr+oXTpm7P5VlFplohZzV8nzkZxbJqRNmgf4ZU+K3FIuKuVIQ4hFLwklE/BjXOHz+tPR4+ySI7Pr1RAhUBTFR/yIuDMtEIU1CfB4QIlmlqsEHqXGK5XAAEbacjvqX+SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hllSFus/; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3d2b6ed8128so3132015ab.0
        for <netdev@vger.kernel.org>; Wed, 05 Mar 2025 06:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741186764; x=1741791564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tlljhCXEmLvAvdPM4fazMsSAmTzwSqJtbsL3HvGllsU=;
        b=hllSFus/7sUU3o+SRBdRUZFwXAX7+xMknKurO7z1Qm952hED32gJvI1CBh3Y7hNTQv
         FwUYuOub0bp+Vx275BzOcWL+wI1ZdBkfzD1sqn2JVL9lpmdYv11yC+wc0BihjCbtN0cV
         FI0k2IUs9y61vv8gigIpLhk6kl9aQrYLdi5U6K9uwcJLpiuyw2JoqiYv7F+1z0fh14RK
         FvteG8sBjQx0maSxscF28UzHNr7jDEzT06PVtFougSYtQCPS+jogYZ8b+c+c5dxXLCUz
         zh+bza93m5EPpQtO6kPK0fouXig/XO6RNkO8Q4F832Ppp5d8onOVoDn1DizAV2iXWxL+
         jiQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741186764; x=1741791564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tlljhCXEmLvAvdPM4fazMsSAmTzwSqJtbsL3HvGllsU=;
        b=B2CW5j8x/EYWSm5CLyIktv/nS4O3EesTKWrLjITutDEzcw8NzIfyqIFs5SQM9+kPKE
         5Cw+LvDTTVzXW+RwibHrrCdIDrCxUEJfVnjAj0b7O0uQSozjdzz+5ClcclwMYd6BkiR1
         CAimpjcCnsQutPC+M3EgfUYrWuQZWYxFqDdrxPEVhqKvMJb3F9RcahMU7JWaLwgGeHqv
         dvxP8J98WvSlAGBz7BLiLuHMxeFBvJip4pu9En42lolO3hqUuZt+TcQoipbgVBiB635a
         fBOGQXQuMnMLBgALSp0mSwf8Pm5KYpUTrtaQrqMBVT50CVe1efTtIovYLblTpyKF5cq8
         bSgA==
X-Gm-Message-State: AOJu0YzCMGx8y7b3dzIRStY7msv70DymzTCPietmtP2GaeaNupaEmJNN
	tIUBOV3r4CTJ7F/QoxgUMy6RMwYGdpxcRLbBRR+PWEZti0xPIizLGO0v0f8R9EFZHEl4Syz1B90
	4E/Edt1FQfBNMCbSbljQIauLzdm0=
X-Gm-Gg: ASbGncuk1/zHlgQ8GrGmCi/EUnK7jsp72itZdxfKZeQ4tspr/QUNgayfH2Y2UYSzDyr
	NWF8jk/0BJIyLsWOMqLn8DKGv2Cz690LQqkjNPH1/78TYhsjJuAiPAJBBMhnw216TH2bkgQ+dtX
	DDA6FE5ThcoMxUCH4/hsAhgN3AIAXBEPhMhWn9zGR0/+b+iOtipch8p1n+4Q==
X-Google-Smtp-Source: AGHT+IGI6NEP/8UcUw8HQ5saZH4BBSoKfCf+dpHKKh8KJVpmgO1TRNNYh+wSjCuj6UaJXRORGY3NTC3/lZgtQ1p+1/Y=
X-Received: by 2002:a05:6e02:3887:b0:3d4:27d4:f76 with SMTP id
 e9e14a558f8ab-3d42ba4648emr44198145ab.7.1741186764149; Wed, 05 Mar 2025
 06:59:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b7c05496f8ead33582eb561b55d3e2fcf25bcf36.1741108507.git.lucien.xin@gmail.com>
 <295e2902-9036-46c9-a110-bf5bf27ed473@nvidia.com>
In-Reply-To: <295e2902-9036-46c9-a110-bf5bf27ed473@nvidia.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 5 Mar 2025 09:59:12 -0500
X-Gm-Features: AQ5f1JoS-stxgYUl0_7701g8Rl1UFVpI6J5_8YR_Ye0FG6aAnwxyXdgXnAfmCcg
Message-ID: <CADvbK_cD7gVbrOH3Ps6SXhbwyxka_BaMH+NvRY6rKBgwvORiRw@mail.gmail.com>
Subject: Re: [PATCH net] openvswitch: avoid allocating labels_ext in ovs_ct_set_labels
To: Jianbo Liu <jianbol@nvidia.com>
Cc: network dev <netdev@vger.kernel.org>, dev@openvswitch.org, ovs-dev@openvswitch.org, 
	davem@davemloft.net, kuba@kernel.org, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Pravin B Shelar <pshelar@ovn.org>, Ilya Maximets <i.maximets@ovn.org>, 
	Aaron Conole <aconole@redhat.com>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
	Florian Westphal <fw@strlen.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 8:31=E2=80=AFPM Jianbo Liu <jianbol@nvidia.com> wrot=
e:
>
>
>
> On 3/5/2025 1:15 AM, Xin Long wrote:
> > Currently, ovs_ct_set_labels() is only called for *confirmed* conntrack
> > entries (ct) within ovs_ct_commit(). However, if the conntrack entry
> > does not have the labels_ext extension, attempting to allocate it in
> > ovs_ct_get_conn_labels() for a confirmed entry triggers a warning in
> > nf_ct_ext_add():
> >
> >    WARN_ON(nf_ct_is_confirmed(ct));
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
> >   net/openvswitch/conntrack.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
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
>
> I don't think it's correct fix. The label is not added and packets can't
> pass the next rule to match ct_label.
>
That's expected, external ct may not work in the flow with extensions.
Again, "openvswitch: switch to per-action label counting in conntrack"
only makes it easier to be triggered.

> I tested it and used the configuration posted before, ping can't work.
I've provided the 'workaround' with the ct zone for this in the other email=
.

I would also like to see the maintainer's option about this.

Thanks.

