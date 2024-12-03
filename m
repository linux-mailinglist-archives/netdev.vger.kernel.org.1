Return-Path: <netdev+bounces-148633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AF99E2AF8
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 19:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 164A5281B19
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 18:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34AC61FCFD3;
	Tue,  3 Dec 2024 18:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WZnTudn1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7175714A088
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 18:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733250841; cv=none; b=CcICn2pi49eGZOUEHZHS/MrIhmZC8gXXKvMelRfj35Eja/HDxJNKReYhOawt5Mgn8D9i9G+5XyDfbovhVCTIIky8oprOhQ2xRkJ2WMl21yVxywE/FQwY8+1Qua5X0SCTv7CYhPemNk8+XAzJs9eeAwgqdidR0SFLE7unXvENMsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733250841; c=relaxed/simple;
	bh=AiTkXX0+17q6lneUn+x8DhOqdzPvdKXZvVxp7KEPWqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ts677B60dyg/gee1aIlA475RWRqRxVlffKqC520vXpT8GfNw+F9uGLlwUetW/2C2y9wMyFMOIrFy33e8xwirM8YO2yq80ruJvAet3TGYLsz+MHXvL8UGWIGTrPVQtPFqV7MPWRqScxduhW9RZqj0PbeZB5GvsTA2BO3XYFY0lk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WZnTudn1; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aa52bb7beceso672714266b.3
        for <netdev@vger.kernel.org>; Tue, 03 Dec 2024 10:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733250838; x=1733855638; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QqKkF2v3uvd5//tnEv6uDmGxC3MdaFCDiDd18Vy+GLw=;
        b=WZnTudn1uXinAgDpzvuz7CwkashhVU3WolNABbgQ+Kd9H/N6mV/Q9prF6KRec/65B3
         GbScBHuzdSQXTpNkXtsa6VuMIlG+UI58jrH+Yf0QADZNqMqPoTbYJXApaAhc8bsIa+sh
         jKP0ig4QHd/OYr1gyvQRJlZISeZUZ5/TQ0OaYn7AtXTt4U2p0EeDHk+7N3n7fvMSlRWR
         f3F89sR3t+uUhoIJjFmrY4fhrbdVbxROwhZoGHWS1qCKsXsifvy/w/mNOmd8eCylrtRX
         G4ZsCW8lyk0D1q3h3wcNSrEenkF2VktxglXrMaiFgK5h+hpJX7E73NYcSaz1slUHOIXS
         S4Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733250838; x=1733855638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QqKkF2v3uvd5//tnEv6uDmGxC3MdaFCDiDd18Vy+GLw=;
        b=NcuKalu/H07n5BOK42dwLybiRtWy5SwNAJc6Tl3Gek7bKOgchdNUqK1quHWNXw/4S3
         PvEUPOCjGS3djQID4MyKyTLZyEiBqyh2/DKeJQvGD2YxbZDU/aYlhpZSujP/nr8BHYK7
         30SxuJb7TrwG9CPs/EJ35M8bW4xAzctt/9s7yJQaSihPR+5zdV8EuWaI15kA8EbL1I0G
         369T+SzqdGkjdIWlqlIML+AYg/sQJr7xHmGtbRZzUV8n4y9ZjP+/iVCQD0gFcvTCbG7F
         7zOHiXCc96O/ShKXCZEpnDnF+piod/DMo1DXPP6IQopqqMlIGuHWYlAiR2gL7HfivoQ8
         kPhA==
X-Forwarded-Encrypted: i=1; AJvYcCUU3JCV8N2X+pwe0LR+1zfZ+D5htyRJenlUv3UCS0YAleH9N6AIfgiNwAyNIKdPGoyhuGnKrk8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4iTRMdsOdRDCVz1LYbtoYsFO2x2gl2DC7WDbVRTyBHE2kwvuV
	PboysVBaLrjzm4eryS/OuuLR/6zPljRK+zlV2vqpnwEoBGXBsq+swhea03U+eL8z0oS1dgdM170
	L5PtOXKDCTYBqqy1/T+fhqcjzbYWSDyWunFcT
X-Gm-Gg: ASbGnct7ohnbgCZlDCVOCK8lgWXKUhtE9nKMO68kdouVLcwS39Rch48uS6d5O2DRxEV
	Fyzg6GKaxrUfDlwyZtk/SeGIiExwqvAH0
X-Google-Smtp-Source: AGHT+IHnxqG92YVtStVjZYah/icLuoJi6eoNA30zNZxYYAz9M51WyvzhWU0k2AKD3VdIxOEQAf1njTdW4/KX4S4b+gs=
X-Received: by 2002:a17:906:23f1:b0:aa5:639d:7cdb with SMTP id
 a640c23a62f3a-aa5f7d4ec79mr265151266b.22.1733250837622; Tue, 03 Dec 2024
 10:33:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203165045.2428360-1-edumazet@google.com> <53482ace-71a3-4fa3-a7d3-592311fc3c1b@ovn.org>
In-Reply-To: <53482ace-71a3-4fa3-a7d3-592311fc3c1b@ovn.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 3 Dec 2024 19:33:45 +0100
Message-ID: <CANn89iLT6oAA-x+KX=sCAANBZKi1K52gOy-VW0hmofbO3GEhtw@mail.gmail.com>
Subject: Re: [PATCH net] net: defer final 'struct net' free in netns dismantle
To: Ilya Maximets <i.maximets@ovn.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Dan Streetman <dan.streetman@canonical.com>, 
	Steffen Klassert <steffen.klassert@secunet.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 7:23=E2=80=AFPM Ilya Maximets <i.maximets@ovn.org> w=
rote:
>
> On 12/3/24 17:50, Eric Dumazet wrote:
> > Ilya reported a slab-use-after-free in dst_destroy [1]
> >
> > Issue is in xfrm6_net_init() and xfrm4_net_init() :
> >
> > They copy xfrm[46]_dst_ops_template into net->xfrm.xfrm[46]_dst_ops.
> >
> > But net structure might be freed before all the dst callbacks are
> > called. So when dst_destroy() calls later :
> >
> > if (dst->ops->destroy)
> >     dst->ops->destroy(dst);
> >
> > dst->ops points to the old net->xfrm.xfrm[46]_dst_ops, which has been f=
reed.
> >
> > See a relevant issue fixed in :
> >
> > ac888d58869b ("net: do not delay dst_entries_add() in dst_release()")
> >
> > A fix is to queue the 'struct net' to be freed after one
> > another cleanup_net() round (and existing rcu_barrier())
> >
> > [1]
>
> <snip>
>
> Hi, Eric.  Thanks for the patch!
>
> Though I tried to test it by applying directly on top of v6.12 tag, but I=
 got
> the following UAF shortly after booting the kernel.  Seems like podman se=
rvice
> was initializing something and creating namespaces for that.
>
> I can try applying the change on top of net tree, if that helps.
>
> Best regards, Ilya Maximets.

Oh right, a llist_for_each_entry_safe() should be better I think.

diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index 2d98539f378ee4f1a9c0074381a155cff8024da3..70fea7c1a4b0a4fdbd0dd5d5acb=
7c6d786553996
100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -448,12 +448,12 @@ static LLIST_HEAD(defer_free_list);
 static void net_complete_free(void)
 {
        struct llist_node *kill_list;
-       struct net *net;
+       struct net *net, *next;

        /* Get the list of namespaces to free from last round. */
        kill_list =3D llist_del_all(&defer_free_list);

-       llist_for_each_entry(net, kill_list, defer_free_list)
+       llist_for_each_entry_safe(net, next, kill_list, defer_free_list)
                kmem_cache_free(net_cachep, net);

 }

