Return-Path: <netdev+bounces-211227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7A0B173F9
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 17:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48A406265A6
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 15:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353A31C5D5A;
	Thu, 31 Jul 2025 15:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YnzqK7Jg"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B370FBE6C
	for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 15:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753975819; cv=none; b=fZeoEuOmY82j6aBnfRwdW6zMkHpnjjoGluZ/JfrGMqXc1vzIG1/dEii3pXcGOdnnyoDUmZ+yS68pCxlY2FGZpOTpe4Pq+vfRG4FG5yEtzlfiOSk1E92XvXLdq50PgTqHyXmbMQyPC7knPzb5kELmFWFvtDPiakwXHbHJTdl2YBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753975819; c=relaxed/simple;
	bh=8jmN7HSIprpvchOA3h5PYxRrb3kV7jr1wO++TShAHRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gSkXnKeZcS5Yn7HcHXT53wJ0UG7ZV1bO871sS1B4IK5Jv4IDbTLVyT7QRV+34kUXe6nZWpW7PbX7FGAhPuYxEg+kC2M4WftpHSUUxmN3s3CXlrnVOe7pGYjoeUYhgR0PzNtmF/YG2Nhy6m/FVbUbMdkKJy/2Cj8KVHxy8BG/UUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YnzqK7Jg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753975815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=efGuZE+wy/IQW6vpAnhNn2yJPMeIDc4VvmD3tdcVmA0=;
	b=YnzqK7Jg772LZ9BKj9Njue3WI5Fy/55sTUGKddS9XUb0c6TMRXd0g+TrbRSLIY4r7Qr7Tb
	uBJUlFQ5UIhx2YAHPu4N9Bk7rKjSp3DM8fRBaiTcPw8mYVTNmbTuwTrtB0qVNffYFWkIx+
	BEt5CJyzR67G04kFDFWZfUdujVQihLg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-FVDtmnViO_q8Liegb1kKyg-1; Thu, 31 Jul 2025 11:30:13 -0400
X-MC-Unique: FVDtmnViO_q8Liegb1kKyg-1
X-Mimecast-MFC-AGG-ID: FVDtmnViO_q8Liegb1kKyg_1753975812
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ae2b7bdc8f6so93115366b.1
        for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 08:30:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753975811; x=1754580611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=efGuZE+wy/IQW6vpAnhNn2yJPMeIDc4VvmD3tdcVmA0=;
        b=mY6frHnINeAw1KIuYxiGD9iSZOwEXuiKHEwI6d1LHv+KBHmxfqunvF3GqslEDmt+u1
         vAKdLsVyPFh5MBT66dJ9W1ggTJx+6+iYoXtUkvquUrnEbNMRk1HV5f+ImcF71jHDDH/z
         itaHaYaBrfwP6O2YJ3t+w3KvIQVSOgGbQzNET+LqoS3nSvT1UYDhpxXB3ln7EaqRx86t
         PiDB+YhnVRzLGbXgtZm+n/zLNOnQYTGpeAxvRbn+xdZ+8NqBgjC+1waJyg/5xS4pHtgB
         9sYSWvKpiwsJ3bg8fXhJ5eQo4tjPrcEwHtaNuvwYZqg/4R4irStPTHjLLPHO/dkQ20fM
         B+sA==
X-Forwarded-Encrypted: i=1; AJvYcCWtqcMKObn/x2X1y23Vnk0BsSwi4Bwjlvur6Nvoj7tOz9EcZwF8EjulGjv1HbBQUjIePiWz9ng=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTiZC2dfeFiP9yN/CNvxvvCmtxkY9DpYbLay82Xsok2f/MXo1f
	IANOmvZ03t/zsTEcjBPv5+7a5iFifAeQR7X0s/niW2DXbBLUuRyOsYTtMKmk0b10EOnsdE726fL
	h4NS4ImCqvQxwzq+UjrvSW5AaOWKGLCsUyelz2gRHpNrsbx4bO/+jVSaiOSrpzfC5XMc63xlG32
	s82BOitCtJmOKYo+nZNNR3RIfBUko5O1aQ
X-Gm-Gg: ASbGncub8sCRJ8h30uK5ykmfySVI7RiRxlX169xcksPCWS8UGOzILrh2cMc+1CNAWyL
	ZmH6Cu5/vFSBymPps3CE46MIT2Y6sjftgvQ7u8bt4vZoeXAv+aKJFjoD35iicaCkY5sNkLpEeqa
	ewY9Xk+08SRDbhlJTYhQXj+kKOoKJg7IRWwf0pFp2gg45hRl4P+Bh1uQ==
X-Received: by 2002:a17:906:fe02:b0:ae6:c334:af3a with SMTP id a640c23a62f3a-af91bbff55emr339553266b.6.1753975810986;
        Thu, 31 Jul 2025 08:30:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5c9yIisVqfaFsfCitspiLklBi+v8OwNwd+81HnIxrh0XVGF7Bd2GCjIVQsJ7OLqh9uU8xi9NdthF8zdbYdEE=
X-Received: by 2002:a17:906:fe02:b0:ae6:c334:af3a with SMTP id
 a640c23a62f3a-af91bbff55emr339550366b.6.1753975810480; Thu, 31 Jul 2025
 08:30:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730200835.80605-1-okorniev@redhat.com> <20250730200835.80605-4-okorniev@redhat.com>
 <cdeb5e12-5c61-4a95-8e31-c56a3a90d6a3@suse.de>
In-Reply-To: <cdeb5e12-5c61-4a95-8e31-c56a3a90d6a3@suse.de>
From: Olga Kornievskaia <okorniev@redhat.com>
Date: Thu, 31 Jul 2025 11:29:58 -0400
X-Gm-Features: Ac12FXyu4ke7AXpdJWvJjWBL1u_s87jJMDfrMGmbaMXP6xuZW7P6B3nrHVs7sWU
Message-ID: <CACSpFtCu+it5n2z=OXRARznR02aU4d3r2z7Sok6WzGt24C6-NQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] nvmet-tcp: fix handling of tls alerts
To: Hannes Reinecke <hare@suse.de>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, trondmy@hammerspace.com, 
	anna.schumaker@oracle.com, hch@lst.de, sagi@grimberg.me, kch@nvidia.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-nfs@vger.kernel.org, linux-nvme@lists.infradead.org, 
	netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev, neil@brown.name, 
	Dai.Ngo@oracle.com, tom@talpey.com, horms@kernel.org, kbusch@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2025 at 2:10=E2=80=AFAM Hannes Reinecke <hare@suse.de> wrot=
e:
>
> On 7/30/25 22:08, Olga Kornievskaia wrote:
> > Revert kvec msg iterator before trying to process a TLS alert
> > when possible.
> >
> > In nvmet_tcp_try_recv_data(), it's assumed that no msg control
> > message buffer is set prior to sock_recvmsg(). Hannes suggested
> > that upon detecting that TLS control message is received log a
> > message and error out. Left comments in the code for the future
> > improvements.
> >
> > Fixes: a1c5dd8355b1 ("nvmet-tcp: control messages for recvmsg()")
> > Suggested-by: Hannes Reinecke <hare@suse.de>
> > Reviewed-by: Hannes Reinecky <hare@susu.de>
> > Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> > ---
> >   drivers/nvme/target/tcp.c | 30 +++++++++++++++++++-----------
> >   1 file changed, 19 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> > index 688033b88d38..055e420d3f2e 100644
> > --- a/drivers/nvme/target/tcp.c
> > +++ b/drivers/nvme/target/tcp.c
> > @@ -1161,6 +1161,7 @@ static int nvmet_tcp_try_recv_pdu(struct nvmet_tc=
p_queue *queue)
> >       if (unlikely(len < 0))
> >               return len;
> >       if (queue->tls_pskid) {
> > +             iov_iter_revert(&msg.msg_iter, len);
> >               ret =3D nvmet_tcp_tls_record_ok(queue, &msg, cbuf);
> >               if (ret < 0)
> >                       return ret;
> > @@ -1217,19 +1218,28 @@ static void nvmet_tcp_prep_recv_ddgst(struct nv=
met_tcp_cmd *cmd)
> >   static int nvmet_tcp_try_recv_data(struct nvmet_tcp_queue *queue)
> >   {
> >       struct nvmet_tcp_cmd  *cmd =3D queue->cmd;
> > -     int len, ret;
> > +     int len;
> >
> >       while (msg_data_left(&cmd->recv_msg)) {
> > +             /* to detect that we received a TlS alert, we assumed tha=
t
> > +              * cmg->recv_msg's control buffer is not setup. kTLS will
> > +              * return an error when no control buffer is set and
> > +              * non-tls-data payload is received.
> > +              */
> >               len =3D sock_recvmsg(cmd->queue->sock, &cmd->recv_msg,
> >                       cmd->recv_msg.msg_flags);
> > +             if (cmd->recv_msg.msg_flags & MSG_CTRUNC) {
> > +                     if (len =3D=3D 0 || len =3D=3D -EIO) {
> > +                             pr_err("queue %d: unhandled control messa=
ge\n",
> > +                                    queue->idx);
> > +                             /* note that unconsumed TLS control messa=
ge such
> > +                              * as TLS alert is still on the socket.
> > +                              */
>
> Hmm. Will it get cleared when we close the socket?

If the socket is closed then any data on that socket would be freed.

> Or shouldn't we rather introduce proper cmsg handling?

That would be what I have originally proposed (I know that was on the
private list). But yes, we can setup a dedicated kvec to receive the
TLS control message once its been detected and then call
nvme_tcp_tls_record_ok().

Let me know if proper cmsg handling is what's desired for this patch.

> (If we do, we'll need it to do on the host side, too)

I can see that the host doesn't have any TLS alert handling now. If
the only place where (TLS) traffic is read from is in host/tcp.c
nvme_tcp_init_connection(), then that's seems like an easy case
because it uses a kvec to back the kernel_recvmsg() msg structure. If
the ctype is tls alert, you can call tls_alert_recv() and pass in the
"iov".  -- assuming patch#4 already went in by that time)

>
> > +                             return -EAGAIN;
> > +                     }
> > +             }
> >               if (len <=3D 0)
> >                       return len;
> > -             if (queue->tls_pskid) {
> > -                     ret =3D nvmet_tcp_tls_record_ok(cmd->queue,
> > -                                     &cmd->recv_msg, cmd->recv_cbuf);
> > -                     if (ret < 0)
> > -                             return ret;
> > -             }
> >
> >               cmd->pdu_recv +=3D len;
> >               cmd->rbytes_done +=3D len;
> > @@ -1267,6 +1277,7 @@ static int nvmet_tcp_try_recv_ddgst(struct nvmet_=
tcp_queue *queue)
> >       if (unlikely(len < 0))
> >               return len;
> >       if (queue->tls_pskid) {
> > +             iov_iter_revert(&msg.msg_iter, len);
> >               ret =3D nvmet_tcp_tls_record_ok(queue, &msg, cbuf);
> >               if (ret < 0)
> >                       return ret;
> > @@ -1453,10 +1464,6 @@ static int nvmet_tcp_alloc_cmd(struct nvmet_tcp_=
queue *queue,
> >       if (!c->r2t_pdu)
> >               goto out_free_data;
> >
> > -     if (queue->state =3D=3D NVMET_TCP_Q_TLS_HANDSHAKE) {
> > -             c->recv_msg.msg_control =3D c->recv_cbuf;
> > -             c->recv_msg.msg_controllen =3D sizeof(c->recv_cbuf);
> > -     }
>
> As you delete this you can also remove the definition of 'recv_msg'
> from nvmet_tcp_cmd structure.

You mean 'recv_cbuf', right? recv_msg would still be needed by the code.

I can send v2 with that change. Whether or not cmsg handling is needed
in v2 I'd need a confirmation on. Given I'm working on compile only
mode, I'd rather keep changes to minimal.

> >       c->recv_msg.msg_flags =3D MSG_DONTWAIT | MSG_NOSIGNAL;
> >
> >       list_add_tail(&c->entry, &queue->free_list);
> > @@ -1736,6 +1743,7 @@ static int nvmet_tcp_try_peek_pdu(struct nvmet_tc=
p_queue *queue)
> >               return len;
> >       }
> >
> > +     iov_iter_revert(&msg.msg_iter, len);
> >       ret =3D nvmet_tcp_tls_record_ok(queue, &msg, cbuf);
> >       if (ret < 0)
> >               return ret;
>
> Cheers,
>
> Hannes
> --
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 N=C3=BCrnberg
> HRB 36809 (AG N=C3=BCrnberg), GF: I. Totev, A. McDonald, W. Knoblich
>


