Return-Path: <netdev+bounces-99978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D282F8D74B1
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 12:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3762EB2113D
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 10:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683B9374E9;
	Sun,  2 Jun 2024 10:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q0/RIoAJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5EA134C4
	for <netdev@vger.kernel.org>; Sun,  2 Jun 2024 10:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717322424; cv=none; b=sFuo5rzjnhNC/3y3yvqHnwlmeS2sqKsJWfnn+E6GK2me2nAcLyq6tnVj3NKhYPgGz6CG0DINab6migz7wBMR/09VrYuUAWNMZUMlC+9256Z9KmwtVMQboM/vT+7/BKnNQXfOBI6mhvVb27q3TH+HgcwDev7S/dveWIw3btRiKCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717322424; c=relaxed/simple;
	bh=HEhSG4+mRS1nZ+PjmPl4mXmikQADX7MPWQeQabc7pCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pT66asJ1/w5IeK1JFO0GOQ/DfKek+XopF0soAizCIMt2gGy8STZrIpuREaULC1QyfYKu1wPcfFdjUkBeaJIWesu8xYrgF/BCUqtI+pNRa8T6kV2PPMa9yZBshE+52yUz7jx2PHD+veFZLNbYe6WKNmP1v1UPYcZrA5F8cjZHi4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q0/RIoAJ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42135a497c3so36945e9.0
        for <netdev@vger.kernel.org>; Sun, 02 Jun 2024 03:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717322421; x=1717927221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SgNo7tmpieGVze/+PEnwgBOltq1cSDq/eNb7C8oH77s=;
        b=q0/RIoAJbU4i22SWkxNLcB8NEpqwuCT2Jg+Gilu5Fvf4v8A4WnDePK9NhBNRG28RiN
         TOyh71vo41/6iLCScIVEhs3whA+bEgvcXPXRVFzp9NTCMGyjQWtHjaX54w7oCbAlmV9V
         t23+FjAZIrrGrhTvvC/jKRbiyGcxlOo7qJafaxhLYiI6QUHdqY6YsCTXfAveBJF8sJlg
         0IjQJ7drDtZR2xJQfV5NYiWKQooTNmXSR2VVFFIKXUaxIp2T2XW0QVkN/LFNBDToCoIB
         UE9+KtdPfCKnax+BaUC/OBM3HwfiVKtmOPvXinXZHYto6Ws+Vzt2TIZdJDKNOqyk3eY2
         ooOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717322421; x=1717927221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SgNo7tmpieGVze/+PEnwgBOltq1cSDq/eNb7C8oH77s=;
        b=WphLTg4tu0B68VZm5mYnkhEkpegnOXWYL/FuDECTOKs7GaBIbfdoXbzhZrGYDl9otZ
         fWJ+2PgDQhQdWUxZg5LEEauDw0g5DVu7emPXixDs0qUipYE0XaSUDiKCKOIiSHHWp8Iz
         63VSRWCSUfgJdZCV5kyMfTNxs038OXvIsQrhqtPCHzCR/z5ehW2JGa0Ey2OfRSfxy5/G
         RVnslQ11jOLL/r4Vl2kzwPCSrJMYcdiRVkRKvkg0iI1Hf9VGPZKHBkns/RAx7Iu40PhK
         4S93a5qm7RKc7ly+JbM3x1OLPTrtOYaJMB3xDmIdnrSvcBM8vSq+9VOKR9GutNaVsRss
         DC6w==
X-Forwarded-Encrypted: i=1; AJvYcCWGiipEyPt+6r24LVq4yMrg/LSnk1uEp31i/HcejovpMJ6xNpZKQZWWzFNyJElLOQEFxF483AOWzXe9f48y//EvkOPVcGZl
X-Gm-Message-State: AOJu0YwJKFwuBaBEZlC8ZfLj3yAt7CA0JZgaU+Rf1DFpQsYLq0POHs4z
	IsxNKrvqqUwyw1mMcm5FiBVCoYXazX//vCg2nikAcNtzwziDVxboARxZAUfMUNnkjiO5crjwbFb
	WPssTfZ6wsMlfQtNsehtokmN4Jp73h9xe9cYax1D28uEmKIw9RsRz
X-Google-Smtp-Source: AGHT+IF72/Kq6OP/T5OJeK7Ym9xgUmUaMFRXEU5tyKgpo9eDEfWv/70RLtngc+MQh5GtQ0esCNU8NURNHIm4uRq7I8Q=
X-Received: by 2002:a05:600c:4586:b0:41f:a15d:220a with SMTP id
 5b1f17b1804b1-42134f3119fmr2065655e9.4.1717322420419; Sun, 02 Jun 2024
 03:00:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240601212517.644844-1-kuba@kernel.org> <20240601161013.10d5e52c@hermes.local>
 <20240601164814.3c34c807@kernel.org> <ad393197-fd1a-4cd8-a371-f6529419193b@kernel.org>
In-Reply-To: <ad393197-fd1a-4cd8-a371-f6529419193b@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 2 Jun 2024 12:00:09 +0200
Message-ID: <CANn89i+i-CooK7GHKr=UYDw4Nf7EYQ5GFGB3PFZiaB7a_j3_xA@mail.gmail.com>
Subject: Re: [PATCH net] inet: bring NLM_DONE out to a separate recv() in inet_dump_ifaddr()
To: David Ahern <dsahern@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Stephen Hemminger <stephen@networkplumber.org>, davem@davemloft.net, 
	netdev@vger.kernel.org, pabeni@redhat.com, 
	Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 2, 2024 at 4:23=E2=80=AFAM David Ahern <dsahern@kernel.org> wro=
te:
>
> On 6/1/24 5:48 PM, Jakub Kicinski wrote:
> > On Sat, 1 Jun 2024 16:10:13 -0700 Stephen Hemminger wrote:
> >> Sorry, I disagree.
> >>
> >> You can't just fix the problem areas. The split was an ABI change, and=
 there could
> >> be a problem in any dump. This the ABI version of the old argument
> >>   If a tree falls in a forest and no one is around to hear it, does it=
 make a sound?
> >>
> >> All dumps must behave the same. You are stuck with the legacy behavior=
.
>
> I don't agree with such a hard line stance. Mistakes made 20 years ago
> cannot hold Linux back from moving forward. We have to continue
> searching for ways to allow better or more performant behavior.
>
> >
> > The dump partitioning is up to the family. Multiple families
> > coalesce NLM_DONE from day 1. "All dumps must behave the same"
> > is saying we should convert all families to be poorly behaved.
> >
> > Admittedly changing the most heavily used parts of rtnetlink is very
> > risky. And there's couple more corner cases which I'm afraid someone
> > will hit. I'm adding this helper to clearly annotate "legacy"
> > callbacks, so we don't regress again. At the same time nobody should
> > use this in new code or "just to be safe" (read: because they don't
> > understand netlink).
>
> What about a socket option that says "I am a modern app and can handle
> the new way" - similar to the strict mode option that was added? Then
> the decision of requiring a separate message for NLM_DONE can be based
> on the app. Could even throw a `pr_warn_once("modernize app %s/%d\n")`
> to help old apps understand they need to move forward.

Main motivation for me was to avoid re-grabbing RTNL again just to get NLM_=
DONE.

The avoidance of the two system calls was really secondary.

I think we could make a generic change in netlink_dump() to force NLM_DONE
in an empty message _and_ avoiding a useless call to the dump method, which
might still use RTNL or other contended mutex.

In a prior feedback I suggested a sysctl that Jakub disliked,
but really we do not care yet, as long as we avoid RTNL as much as we can.

Jakub, what about the following generic change, instead of ad-hoc changes ?

I tested it, I can send it with the minimal change (the alloc skb
optim will reach net-next)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index fa9c090cf629e6e92c097285b262ed90324c7656..0a58e5d13b8e68dd3fbb2b3fb36=
2c3399fa29909
100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -2289,15 +2289,20 @@ static int netlink_dump(struct sock *sk, bool
lock_taken)
         * ever provided a big enough buffer.
         */
        cb =3D &nlk->cb;
-       alloc_min_size =3D max_t(int, cb->min_dump_alloc, NLMSG_GOODSIZE);
-
-       max_recvmsg_len =3D READ_ONCE(nlk->max_recvmsg_len);
-       if (alloc_min_size < max_recvmsg_len) {
-               alloc_size =3D max_recvmsg_len;
-               skb =3D alloc_skb(alloc_size,
+       if (nlk->dump_done_errno) {
+               alloc_min_size =3D max_t(int, cb->min_dump_alloc, NLMSG_GOO=
DSIZE);
+               max_recvmsg_len =3D READ_ONCE(nlk->max_recvmsg_len);
+               if (alloc_min_size < max_recvmsg_len) {
+                       alloc_size =3D max_recvmsg_len;
+                       skb =3D alloc_skb(alloc_size,
                                (GFP_KERNEL & ~__GFP_DIRECT_RECLAIM) |
                                __GFP_NOWARN | __GFP_NORETRY);
+               }
+       } else {
+               /* Allocate the space needed for NLMSG_DONE alone. */
+               alloc_min_size =3D nlmsg_total_size(sizeof(nlk->dump_done_e=
rrno));
        }
+
        if (!skb) {
                alloc_size =3D alloc_min_size;
                skb =3D alloc_skb(alloc_size, GFP_KERNEL);
@@ -2350,8 +2355,7 @@ static int netlink_dump(struct sock *sk, bool lock_ta=
ken)
                cb->extack =3D NULL;
        }

-       if (nlk->dump_done_errno > 0 ||
-           skb_tailroom(skb) <
nlmsg_total_size(sizeof(nlk->dump_done_errno))) {
+       if (skb->len) {
                mutex_unlock(&nlk->nl_cb_mutex);

                if (sk_filter(sk, skb))

