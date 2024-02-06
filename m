Return-Path: <netdev+bounces-69425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8054784B26A
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 11:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B4CDB257FD
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 10:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5470C12E1D5;
	Tue,  6 Feb 2024 10:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vsljQ5HY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9296612880E
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 10:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707214961; cv=none; b=llCrbEZeV8LBd4pRIqUU1S9uVF4nmaiPa0Yge3k/MNicQGKIpjs3hbkX1WSeJEdNWYNMjE6juEeUriMJ2640KueAvRQCzjN9geDs8XSlJVa1AuZ+XOaPuvuybKq4+Q+WOl0pwFRTxmXgaypdFC1Pbhky6ord2AWqhrFWYt2nrYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707214961; c=relaxed/simple;
	bh=M4W8YPKTrAsH9n2fil5B241iL6s8q4tbReO1J8Rn9H4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dc2lH+eaOKlWwRwcRvLvtso/30PNernIIgPh4h6YpQ9ehoTJkoHwBxURZSSKbIED6X6c5hhxKRx9lWJVJ1tbGGRm3Tu6q3cDNR2fu1qLKjXmjbdKzn9/+J+tpOamU+Wa9l/cAyelJ4ewTVFQ8438EjVYZcedi8n0iy1ctqyNWYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vsljQ5HY; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-560530f4e21so7456a12.1
        for <netdev@vger.kernel.org>; Tue, 06 Feb 2024 02:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707214958; x=1707819758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hgeab0y0Ks4vMzm1Cgxum9Eoc5ZGyKRKHtPjput/NRU=;
        b=vsljQ5HYyARJjcay2cMvCPIykAKZX0At8m4IDxnS7Eg0pv/CbeYniX2O3hy0Rmpxtq
         b+9eoe/oWb/7r8ePFnOSNSa2I6lUvnzpqcTToVPPZDyWKoz+OBuM3dHPp6Jlocwa9Te9
         oWTUFr6cMvZL0MdGiz1UO0bmHDpsy6UM0OgfuSKv0VJBX697xWY8Di1HGHTl/ur5ntoF
         XHR11sbHMojP+bFWzkn1XuJ+r4eG37BXv08FCndAnIkfu8CKekuef+V6KUgNmym892MT
         HF0KCnohLB1EUTE8lXTDDNHVuZllHeLNA4X38i+fGZrdZDSXDtys8sTwSr65YkIkfo0L
         BUJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707214958; x=1707819758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hgeab0y0Ks4vMzm1Cgxum9Eoc5ZGyKRKHtPjput/NRU=;
        b=YZotUSaPA5r5xkPzBainawVB5Ru/jCT1/YgQdcTg4269zhmb/ibNXSyLe7t6DOxIl7
         XdsY170lyi+mCOWgeClTthCZEiiXsHGRv+Z6mXvsJAZFrZ14QZkqP4jgoNZoxpTYSFP5
         wM2lJJEwDnDFF6W0QDEFGtcTP7V11BYN4Sl/e9dq8afT+XGPrK6Jt8M/G4D9TQJhg6KB
         s3YbgC5k4WIJQ4BoK162ihISRJCnJJlkq6xI/EJjFifuxBsCMGbaZzwk+YCOypiNeoOk
         6h5N/Nd7nZ1opj7xYi2QXbUvV3y8yaLyd83SnCJhAUyybIPt619G8HFkve2gsBSClF+j
         tnNg==
X-Gm-Message-State: AOJu0YxxeeAS1Wqn0bMo5ECBCsmIlzQQdPlthKFCQglTw4UpsGMps2k+
	eOuNVsS++nfghc9okzM0YNrZv/5cposxFK7yDENfESowiinu7Zh3NSLeF3HKH9548ZzkY0jx+V7
	HgRJHRE8MgD/hUv1p2KBanikNtLDAju3DQrXV
X-Google-Smtp-Source: AGHT+IFUn2GKF+zS6Vzo2yv01A2IiAiGbcW0X79LSewCSGtCokobXcLiaGc5dcJivlkBba69ECcCFzMpfWH3x41H1yk=
X-Received: by 2002:a50:f60b:0:b0:55f:993a:f1c2 with SMTP id
 c11-20020a50f60b000000b0055f993af1c2mr156645edn.6.1707214957565; Tue, 06 Feb
 2024 02:22:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205124752.811108-1-edumazet@google.com> <20240205124752.811108-6-edumazet@google.com>
 <170721115936.5464.3838090704873147346@kwain>
In-Reply-To: <170721115936.5464.3838090704873147346@kwain>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 6 Feb 2024 11:22:23 +0100
Message-ID: <CANn89iLJrrJs+6Vc==Un4rVKcpV0Eof4F_4w1_wQGxUCE2FWAg@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 05/15] geneve: use exit_batch_rtnl() method
To: Antoine Tenart <atenart@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 10:19=E2=80=AFAM Antoine Tenart <atenart@kernel.org>=
 wrote:
>
> Quoting Eric Dumazet (2024-02-05 13:47:42)
> > -static void __net_exit geneve_exit_batch_net(struct list_head *net_lis=
t)
> > +static void __net_exit geneve_exit_batch_rtnl(struct list_head *net_li=
st,
> > +                                             struct list_head *dev_to_=
kill)
> >  {
> >         struct net *net;
> > -       LIST_HEAD(list);
> >
> > -       rtnl_lock();
> >         list_for_each_entry(net, net_list, exit_list)
> > -               geneve_destroy_tunnels(net, &list);
> > -
> > -       /* unregister the devices gathered above */
> > -       unregister_netdevice_many(&list);
> > -       rtnl_unlock();
> > +               geneve_destroy_tunnels(net, dev_to_kill);
> >
> >         list_for_each_entry(net, net_list, exit_list) {
> >                 const struct geneve_net *gn =3D net_generic(net, geneve=
_net_id);
>
> Not shown in the diff here is:
>
>   WARN_ON_ONCE(!list_empty(&gn->sock_list));
>
> I think this will be triggered as the above logic inverted two calls,
> which are now,
>
> 1. WARN_ON_ONCE(...)
> 2. unregister_netdevice_many
>
> But ->sock_list entries are removed in ndo_exit, called from
> unregister_netdevice_many.
>
> I guess the warning could be moved to exit_batch (or removed).

I will keep the warning, but move it, thanks [1]

Speaking of geneve, I think the synchronize_net() call from
geneve_sock_release() could easily be avoided.

[1] I will squash the following delta for v4 submission.

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index f31fc52ef397dfe0eba854385f783fbcad7e870f..23e97c2e4f6fcb90a8bbb117d75=
20397f560f15f
100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -1907,17 +1907,19 @@ static void __net_exit
geneve_exit_batch_rtnl(struct list_head *net_list,

        list_for_each_entry(net, net_list, exit_list)
                geneve_destroy_tunnels(net, dev_to_kill);
+}

-       list_for_each_entry(net, net_list, exit_list) {
-               const struct geneve_net *gn =3D net_generic(net, geneve_net=
_id);
+static void __net_exit geneve_exit_net(struct net *net)
+{
+       const struct geneve_net *gn =3D net_generic(net, geneve_net_id);

-               WARN_ON_ONCE(!list_empty(&gn->sock_list));
-       }
+       WARN_ON_ONCE(!list_empty(&gn->sock_list));
 }

 static struct pernet_operations geneve_net_ops =3D {
        .init =3D geneve_init_net,
        .exit_batch_rtnl =3D geneve_exit_batch_rtnl,
+       .exit =3D geneve_exit_net,
        .id   =3D &geneve_net_id,
        .size =3D sizeof(struct geneve_net),
 };

