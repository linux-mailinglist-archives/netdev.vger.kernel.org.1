Return-Path: <netdev+bounces-172113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99250A5044F
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 17:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2EE316A244
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 16:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B68D2505DF;
	Wed,  5 Mar 2025 16:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jwguc6iC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A6424EF7A
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 16:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741191249; cv=none; b=CnKpojPYipFphWrblC1OSFhxcbg4ZXSqdbCyE3+arYD/YJpa9tjawXv4Zhx5M/U39VH99yVDz5W4BdsYCW4Zwc+r83jtULlD0obmM6r25O96RxIBW1bk4lIPS+BcD9r47atDdQOWbLxs3GR8IvrffQsM8EtZL12+SUsNe1tWcyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741191249; c=relaxed/simple;
	bh=RMrmflyM/vQBdsZE5safKUEfbg929z2H2YiQNLpAwx0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ozBmd+FUeIvSc2JNoH+A4UXhYrobXQ2llzQqsedlxUW1OtQfpoldxYT1mT968TD2gYOvi00BPt8aYBgb1eBIlfjbu+y/RzuMg9z9bS7N24jOeJ9Zx6NbGGWqGyXoVoSvGdzG6tc8rt6kqmu8W7ucgjfzGlm4TPxLFvPsFn8ejnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jwguc6iC; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-85ad9fafa90so83250739f.3
        for <netdev@vger.kernel.org>; Wed, 05 Mar 2025 08:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741191247; x=1741796047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i4PHeCaoRxj/g4wjEMl31LuYczjT6QDLgPyE+wjfk14=;
        b=jwguc6iCV7zacOoK+gNYsZH2KKIHaQkTpp8WqY81yUNqoxdgxk5ks3KSHQEuObLVjt
         Je0Gp6LTq2/K4gdPX9tm+frwNFOR+kkTzzHxMFDs3ZuuB9tZJ8KrZEbiIhpth+D32ucc
         bPjis/cUc9TaJLPU+zv78D9Jhm6nAdXuR6N2ypw4Nl/r+SVXTIw0PF2MZfIAG72AoaU1
         i+WdPhdogbOA5xwyqJW5nl7lXVWTBRSOYqiohjAm/4CH9Un5xMOz4wYNGPovFSufiYbN
         OBmjCFfh+h1RQfI5WBGYm4AB8Sa832FsZLm82V5T5WnLMyXTwPkewiBxoRomjwDLlmlE
         ksnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741191247; x=1741796047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i4PHeCaoRxj/g4wjEMl31LuYczjT6QDLgPyE+wjfk14=;
        b=myI/z/HLJouOLhhqwcFWtmVimRYSmf4e7tfxs+oEnBzqgCgciCwxF47PeKOK/jQYZk
         CH/WX1ibHHv8VXiBZA2SWH1nESyE4FODcjQI1dwYM8L747ZnXLz8xmmIZ+yVA78WsjBi
         105U6bNcLUQuzS76pY/mI8P52lYpAtm/IkpaLPEfHcUMd7WFuD7KgCO5hyfekZq6J0Wb
         s260o8u8PM2r9H8S9GGVDfpNvfBof3VV3nALSjeoZOhZCY9KdtbCv3vaC2gvOQKbhvdO
         L1wGl7AjnOZvLEfEwOZXJZA0oI+4ZZilEqJnw9Wu4weytopYGHqO/v/WvQ92t3z/U2Gu
         VWOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbBGcQFvCUqS9RKw7Wlkhija0depaEh7fjhIH4EOUUcguiSaTbU2eoRhqPxAaNEjdVXuaz5sc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMBvtbZYGW3UFl5qxOFYc6KCbEAJVXgFKWFq4qkGhy6+lq463l
	lDya/2f+oxaYXZlv2Ft+EgAe2nC2qNMvOxiHnmOWJvP97wQd1VFWCgi05+evCiuQH8FIPbTRa5u
	QvoZwwf0HHg5TpInAbTVsRzNPGJw=
X-Gm-Gg: ASbGncvb4K7sgy6SwMWeR8361BrWYBVyNpkj894RJoNg+lroqRn8uWzVPtLQvSRwD77
	Gk2wRjxmzm8H1J/g2A/HcYqCyiUCPDd8WZzEdSKU4qd+S79T1EQog5jHQCm+ebDGLPVpXL2yOOJ
	iiYjqpQs/DkRJI3fBnkBRvJlkbWgjEBpqaUgGANQdjbtnhRVyu0ivVG68PBA==
X-Google-Smtp-Source: AGHT+IHidvAhWtlm7zmzVLJtrQ0TaWZdXIRWD5VN8RbT5US1zCNqx0I8iSU8oD8TV815OGA2+i8BnCiqlut/jUAqOSg=
X-Received: by 2002:a05:6e02:3d86:b0:3d1:79ec:bef2 with SMTP id
 e9e14a558f8ab-3d42b8a5d08mr47183285ab.6.1741191246834; Wed, 05 Mar 2025
 08:14:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b7c05496f8ead33582eb561b55d3e2fcf25bcf36.1741108507.git.lucien.xin@gmail.com>
 <295e2902-9036-46c9-a110-bf5bf27ed473@nvidia.com> <CADvbK_cD7gVbrOH3Ps6SXhbwyxka_BaMH+NvRY6rKBgwvORiRw@mail.gmail.com>
 <c7a9b481-190d-4b4b-a5ff-6f244c8c1abe@ovn.org>
In-Reply-To: <c7a9b481-190d-4b4b-a5ff-6f244c8c1abe@ovn.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 5 Mar 2025 11:13:55 -0500
X-Gm-Features: AQ5f1JpirVV2ys_8Izf1jMOabSXfuyPnfKNnuGFYl8N-8lrGIxAm9hBT4zIVHZg
Message-ID: <CADvbK_dWq8Wff5vmY6tMvQ7Pe+LSo5VBH04HREWmn6PdnCF8mA@mail.gmail.com>
Subject: Re: [PATCH net] openvswitch: avoid allocating labels_ext in ovs_ct_set_labels
To: Ilya Maximets <i.maximets@ovn.org>
Cc: Jianbo Liu <jianbol@nvidia.com>, network dev <netdev@vger.kernel.org>, dev@openvswitch.org, 
	ovs-dev@openvswitch.org, davem@davemloft.net, kuba@kernel.org, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Pravin B Shelar <pshelar@ovn.org>, Aaron Conole <aconole@redhat.com>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Florian Westphal <fw@strlen.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 10:35=E2=80=AFAM Ilya Maximets <i.maximets@ovn.org> =
wrote:
>
> On 3/5/25 15:59, Xin Long wrote:
> > On Tue, Mar 4, 2025 at 8:31=E2=80=AFPM Jianbo Liu <jianbol@nvidia.com> =
wrote:
> >>
> >>
> >>
> >> On 3/5/2025 1:15 AM, Xin Long wrote:
> >>> Currently, ovs_ct_set_labels() is only called for *confirmed* conntra=
ck
> >>> entries (ct) within ovs_ct_commit(). However, if the conntrack entry
> >>> does not have the labels_ext extension, attempting to allocate it in
> >>> ovs_ct_get_conn_labels() for a confirmed entry triggers a warning in
> >>> nf_ct_ext_add():
> >>>
> >>>    WARN_ON(nf_ct_is_confirmed(ct));
> >>>
> >>> This happens when the conntrack entry is created externally before OV=
S
> >>> increases net->ct.labels_used. The issue has become more likely since
> >>> commit fcb1aa5163b1 ("openvswitch: switch to per-action label countin=
g
> >>> in conntrack"), which switched to per-action label counting.
> >>>
> >>> To prevent this warning, this patch modifies ovs_ct_set_labels() to
> >>> call nf_ct_labels_find() instead of ovs_ct_get_conn_labels() where
> >>> it allocates the labels_ext if it does not exist, aligning its
> >>> behavior with tcf_ct_act_set_labels().
> >>>
> >>> Fixes: fcb1aa5163b1 ("openvswitch: switch to per-action label countin=
g in conntrack")
> >>> Reported-by: Jianbo Liu <jianbol@nvidia.com>
> >>> Signed-off-by: Xin Long <lucien.xin@gmail.com>
> >>> ---
> >>>   net/openvswitch/conntrack.c | 2 +-
> >>>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.=
c
> >>> index 3bb4810234aa..f13fbab4c942 100644
> >>> --- a/net/openvswitch/conntrack.c
> >>> +++ b/net/openvswitch/conntrack.c
> >>> @@ -426,7 +426,7 @@ static int ovs_ct_set_labels(struct nf_conn *ct, =
struct sw_flow_key *key,
> >>>       struct nf_conn_labels *cl;
> >>>       int err;
> >>>
> >>> -     cl =3D ovs_ct_get_conn_labels(ct);
> >>> +     cl =3D nf_ct_labels_find(ct);
> >>
> >> I don't think it's correct fix. The label is not added and packets can=
't
> >> pass the next rule to match ct_label.
> >>
> > That's expected, external ct may not work in the flow with extensions.
> > Again, "openvswitch: switch to per-action label counting in conntrack"
> > only makes it easier to be triggered.
> >
> >> I tested it and used the configuration posted before, ping can't work.
> > I've provided the 'workaround' with the ct zone for this in the other e=
mail.
>
> I think, the test provided in the other thread is reasonable and logicall=
y
> correct.   The link for the test:
>   https://lore.kernel.org/all/2ee4d016-5e57-4d86-9dca-e4685cb183bb@nvidia=
.com/
>
> We should be able to match on the label committed in the original directi=
on.
> The workaround doesn't really cover the use case, because the labels cove=
r
> a much larger scope that zones and it may be not possible to use zones in=
stead
> of labels.  Also, the ct entry obtained in the test is not from outside, =
AFAICT,
> it is created inside the OVS pipeline and labels are also created inside =
the
> OVS datapath, so it should work.
All ct entries created by action=3Dct() will have label exts allocated.
This is because any flow with ct inserted in the kernel increases
net->ct.labels_used via nf_connlabels_get(), which ensures that the
new ct entry has label exts allocated during its creation. Therefore,
I believed this ct entry was created outside of OVS. But I might not
be aware of other scenarios where OVS itself might create ct entries.

>
> On a side note, the fact that it's allowed to modify labels for committed
> connections, but it's not allowed to set one when there is none, seems li=
ke
> an inconsistent behavior.  Maybe that should be fixed and the warning rem=
oved?
I need to check with Netfilter developers regarding this.
If I can't find a solution this week, I will revert
  "openvswitch: switch to per-action label counting in conntrack"
as requested by Jianbo.

Thanks.

>
> Best regards, Ilya Maximets.
>
> >
> > I would also like to see the maintainer's option about this.
> >
> > Thanks.
>

