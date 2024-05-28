Return-Path: <netdev+bounces-98457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C1F8D180B
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 12:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C86F61C2479B
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 10:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03323BBEA;
	Tue, 28 May 2024 10:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DQ/WCKyC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BC3161321
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 10:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716890662; cv=none; b=sL2MeqW7XOmVVXiHgkezkXgsDqipL9RCq8sLScBkdwnbxteyYcpcXY8hlMMOjDy2o7A3aKaHHLMohXtNTZiLMBgWlyp9fxl7oOC95hO28Z0LGQS/+GD6I/3C4MCKF800DViTJjDU7WF8W+WRwiN2g+FcdQvmpr3d3ZUlsMc3Er4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716890662; c=relaxed/simple;
	bh=s6Qte951Iz4D3qEWseQabuqp2d2H7MtBMZA7+fgMxls=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NRrjvP+mmREHtK9fXOTsGOh/SAptP/5EXlFNegKMZ77b4+z2qURF/1LMRnwYWqFapcephT5T1b4WuZPq2J76uJdZVTEIeH5+iEQwBh7pnj4hbq7dBjyyO0+nbasLeRzIi3UXVizLNmC8gxXQnCt12RazxIEWJmoV6CauAkn8bIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DQ/WCKyC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716890658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=dcvsDbrOq0GkpjSztve05vpNT+2/RrsUPlhndH7vsLs=;
	b=DQ/WCKyCnC4K/My82VBiP7Rlz01f3ungM+MHAROnaPeJdkSUObtSs7aUl90Rmr+hsKxt5e
	kCRbWMueTycLHeNvz3TCmNmSt2DAyxMrZhMadwKrosR1o5+8RgKEUA/Now3w9ZJrwE6gMR
	1voY3fyQRZOPBrPRZsX1MWE9G54+3lU=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-679T3mPHP6CwitqW5lCyeQ-1; Tue, 28 May 2024 06:04:17 -0400
X-MC-Unique: 679T3mPHP6CwitqW5lCyeQ-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-528dc407951so138037e87.2
        for <netdev@vger.kernel.org>; Tue, 28 May 2024 03:04:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716890655; x=1717495455;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dcvsDbrOq0GkpjSztve05vpNT+2/RrsUPlhndH7vsLs=;
        b=BGQqZY8lHI0cgKGy62+K6OXEdHxe/aG8DaI6OkOwc4/R33I+HGg2bFlBO+L1bMhxxr
         ndfE2pCZOANjK/mFG5gLaNR2YNtL2M/5FGST/mDLt4zdw6dNr02qFcR0XZ6RjjfJVUs9
         GnXmw6c6xrJ9CDk0MwR7ElmR5QVIrykWhtw5sg4imLnM5yX1pkU+xRFgczkt5LC+fCwK
         v66LF4Hy3a2qqvRZj/b+9Fl0/Noa7NmPRkZ3CHmV+YCHp9y4f4JHd3k576R4lN8638qc
         gRdIDKvr8XLmvjcz313SNMcgkruscF3cSGZZtmLvpnAwFo0Nqr9MwIm0MH99I8OU9KVQ
         GjHA==
X-Forwarded-Encrypted: i=1; AJvYcCX/QB0dzB1UzRK2ZRudTfD8OicYiPf3O0q0rba9ve+oV0qFOlglrGRXsHD3P14N8nn6z9vzkq9Acdk8frDE3I0gAI957j+c
X-Gm-Message-State: AOJu0Yzd9wmm77bpNH7DDrI9k5ZOjIRt1Lrtk9m4rLUCi2Br/QYcXq6C
	VAxfVQ1H+tKYrvUl5lkOvp6OZAuo44f3Iae0JG8OR+6AXrnpeJcqa5q/vgCWyk5nZFVgML8Hwmv
	+2vB1zvYopN2KRWTJTU8td2HZu1m59rUGcmAOPXAek3AZSxYLCUs9F8ASuU8nwg==
X-Received: by 2002:a2e:700d:0:b0:2e9:8417:bd83 with SMTP id 38308e7fff4ca-2e98417c2f6mr14578501fa.2.1716890655566;
        Tue, 28 May 2024 03:04:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDX6q4BHIIUrvRpHdC4viyVbBbRa7x2mqeybNkxr9smMj9o8Xg3R3KLzlmvTOAu7aaRV/Hqw==
X-Received: by 2002:a2e:700d:0:b0:2e9:8417:bd83 with SMTP id 38308e7fff4ca-2e98417c2f6mr14578221fa.2.1716890655039;
        Tue, 28 May 2024 03:04:15 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b094:ab10:29ae:cdc:4db4:a22a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35b1d7a496asm1458750f8f.87.2024.05.28.03.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 03:04:14 -0700 (PDT)
Message-ID: <c443d5d84fc32beb6e11c6dd5fa506abcd6b4fc4.camel@redhat.com>
Subject: Re: [PATCH net v2 2/2] Revert "virtio_net: Add a lock for per queue
 RX coalesce"
From: Paolo Abeni <pabeni@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
  Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 virtualization@lists.linux.dev
Date: Tue, 28 May 2024 12:04:13 +0200
In-Reply-To: <1716865564.880848-2-hengqi@linux.alibaba.com>
References: <20240523074651.3717-1-hengqi@linux.alibaba.com>
	 <20240523074651.3717-3-hengqi@linux.alibaba.com>
	 <a8b15f50960e15ba37c213169473f1b1d893f9e0.camel@redhat.com>
	 <1716865564.880848-2-hengqi@linux.alibaba.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-05-28 at 11:06 +0800, Heng Qi wrote:
> On Mon, 27 May 2024 12:42:43 +0200, Paolo Abeni <pabeni@redhat.com> wrote=
:
> > On Thu, 2024-05-23 at 15:46 +0800, Heng Qi wrote:
> > > This reverts commit 4d4ac2ececd3c42a08dd32a6e3a4aaf25f7efe44.
> > >=20
> > > When the following snippet is run, lockdep will report a deadlock[1].
> > >=20
> > >   /* Acquire all queues dim_locks */
> > >   for (i =3D 0; i < vi->max_queue_pairs; i++)
> > >           mutex_lock(&vi->rq[i].dim_lock);
> > >=20
> > > There's no deadlock here because the vq locks are always taken
> > > in the same order, but lockdep can not figure it out, and we
> > > can not make each lock a separate class because there can be more
> > > than MAX_LOCKDEP_SUBCLASSES of vqs.
> > >=20
> > > However, dropping the lock is harmless:
> > >   1. If dim is enabled, modifications made by dim worker to coalescin=
g
> > >      params may cause the user's query results to be dirty data.
> >=20
> > It looks like the above can confuse the user-space/admin?
>=20
> Maybe, but we don't seem to guarantee this --
> the global query interface (.get_coalesce) cannot=20
> guarantee correct results when the DIM and .get_per_queue_coalesce are pr=
esent:
>=20
> 1. DIM has been around for a long time (it will modify the per-queue para=
meters),
>    but many nics only have interfaces for querying global parameters.
> 2. Some nics provide the .get_per_queue_coalesce interface, it is not
>    synchronized with DIM.
>=20
> So I think this is acceptable.

Yes, the above sounds acceptable to me.

> > Have you considered instead re-factoring
> > virtnet_send_rx_notf_coal_cmds() to avoid acquiring all the mutex in
> > sequence?
>=20
> Perhaps it is a way to not traverse and update the parameters of each que=
ue
> in the global settings interface.

I'm wondering if something as dumb as the following would suffice? Not
even compile-tested.
---
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 4a802c0ea2cb..d844f4c89152 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -4267,27 +4267,27 @@ static int virtnet_send_rx_notf_coal_cmds(struct vi=
rtnet_info *vi,
 			       ec->rx_max_coalesced_frames !=3D vi->intr_coal_rx.max_packets))
 		return -EINVAL;
=20
-	/* Acquire all queues dim_locks */
-	for (i =3D 0; i < vi->max_queue_pairs; i++)
-		mutex_lock(&vi->rq[i].dim_lock);
-
 	if (rx_ctrl_dim_on && !vi->rx_dim_enabled) {
 		vi->rx_dim_enabled =3D true;
-		for (i =3D 0; i < vi->max_queue_pairs; i++)
+		for (i =3D 0; i < vi->max_queue_pairs; i++) {
+			mutex_lock(&vi->rq[i].dim_lock);
 			vi->rq[i].dim_enabled =3D true;
-		goto unlock;
+			mutex_unlock(&vi->rq[i].dim_lock);
+		}
+		return 0;
 	}
=20
 	coal_rx =3D kzalloc(sizeof(*coal_rx), GFP_KERNEL);
-	if (!coal_rx) {
-		ret =3D -ENOMEM;
-		goto unlock;
-	}
+	if (!coal_rx)
+		return -ENOMEM;
=20
 	if (!rx_ctrl_dim_on && vi->rx_dim_enabled) {
 		vi->rx_dim_enabled =3D false;
-		for (i =3D 0; i < vi->max_queue_pairs; i++)
+		for (i =3D 0; i < vi->max_queue_pairs; i++) {
+			mutex_lock(&vi->rq[i].dim_lock);
 			vi->rq[i].dim_enabled =3D false;
+			mutex_unlock(&vi->rq[i].dim_lock);
+		}
 	}
=20
 	/* Since the per-queue coalescing params can be set,
@@ -4300,21 +4300,17 @@ static int virtnet_send_rx_notf_coal_cmds(struct vi=
rtnet_info *vi,
=20
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_NOTF_COAL,
 				  VIRTIO_NET_CTRL_NOTF_COAL_RX_SET,
-				  &sgs_rx)) {
-		ret =3D -EINVAL;
-		goto unlock;
-	}
+				  &sgs_rx))
+		return -EINVAL;
=20
 	vi->intr_coal_rx.max_usecs =3D ec->rx_coalesce_usecs;
 	vi->intr_coal_rx.max_packets =3D ec->rx_max_coalesced_frames;
 	for (i =3D 0; i < vi->max_queue_pairs; i++) {
+		mutex_lock(&vi->rq[i].dim_lock);
 		vi->rq[i].intr_coal.max_usecs =3D ec->rx_coalesce_usecs;
 		vi->rq[i].intr_coal.max_packets =3D ec->rx_max_coalesced_frames;
-	}
-unlock:
-	for (i =3D vi->max_queue_pairs - 1; i >=3D 0; i--)
 		mutex_unlock(&vi->rq[i].dim_lock);
-
+	}
 	return ret;
 }
---

Otherwise I think you need to add {READ,WRITE}_ONCE annotations while
touching the dim fields to avoid data races.

Thanks,

Paolo






