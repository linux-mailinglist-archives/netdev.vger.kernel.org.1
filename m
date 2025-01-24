Return-Path: <netdev+bounces-160835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26519A1BBA1
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 18:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 301723AF262
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 17:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B02B1AA783;
	Fri, 24 Jan 2025 17:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hkA1Xxe5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE939474
	for <netdev@vger.kernel.org>; Fri, 24 Jan 2025 17:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737740764; cv=none; b=FLBXqme05d0SubYongt/m5iqspnxhGa8JBc+OYiSt085O57g7BBjyyn6+DxlXnCnl1BOj7XfhZK8aHL3FtTQ1V3lmtaJKnQotmbYF4hiWJMjTJ5DPb5+zemD8eb59HHXKT1MV4AkvNIDLKNgZusJw4tPsiktfn/Rh/WVT2sqx2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737740764; c=relaxed/simple;
	bh=3aj9rlgE9Q9nBIHpjrW/nronhsL1vcUV+ZyN0/hN5S4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qpJFaur23vG0qXh2t/ZhBi7KyvTxAhGPCzUIkfqP6wIbCmURsg7ZDCB8b9useeP6js0nJRlPP0MloD3EMQ6xiMcjMAXkZjKef6ncZD07YLFgVAYLe2ZtwZqA13NUTR0U2L3DKc8CQMzb17aPslVoO3yXLfca2g2pc/L2JMIhHGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hkA1Xxe5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737740761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=145ThqO6V6qSgYUwyPYyVldLSQPpAZreGKb1L+P7TGs=;
	b=hkA1Xxe5BZ4qkCgX8btrI+GsxgVMeTWZ6o1VJ2ZDWtQQzs9Tk+zpAZiIWBWl/FIxZkYz9y
	W2dMT+qCfLEQR+m35iKYHAubkiPdBHhQomeWMtvOlH1OXdFuROM5354Nf91PZFpR7t3ibX
	m3sj1vrYa2yPdk0ALsL3EJetX0HRzw4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-z5kWXetpMpGg3suDdFfmwg-1; Fri, 24 Jan 2025 12:45:36 -0500
X-MC-Unique: z5kWXetpMpGg3suDdFfmwg-1
X-Mimecast-MFC-AGG-ID: z5kWXetpMpGg3suDdFfmwg
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5d821f9730aso3558746a12.1
        for <netdev@vger.kernel.org>; Fri, 24 Jan 2025 09:45:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737740735; x=1738345535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=145ThqO6V6qSgYUwyPYyVldLSQPpAZreGKb1L+P7TGs=;
        b=aNb07PfWhGCCCE8hzFMN19JUeTzUXHnMpm2DsbmSCdafiy4OmobSfsyxFYNsnyelC/
         r8Hc6ediQOwYlOa93RuTHdOKY76xDONIBMRh1+pBEi69ZPb+y6yBx6YCKIQ7Xz4E0Qn8
         /RFmo4X5eSrXe9Ex3oA7kXU4b/bymmz9QG2Uspnni5Xb+IPZ9FmS524F5NKxTkoTCCIM
         GZpMUCV1b2pnpwSqspsRsrjDDDq36fRb3158MOX6Z92wPYYNGkaK+f/KyC4nvTo/FWxo
         xQ1Uz8J+e1emjBP2GNoC/+fNYkmBjeayuv8kZo8cMatFZznxJlgXttjwsxQCOCFpK+Fr
         8YeQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+VzBMZIIarkWlCv/oLQXD3wNnF3kxw8uwLWVGQacDNM1PytL/+q8sth3Xop+zGjummtA/6Ng=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyiFytwdF/oM4LuRj6/nJZLZmGb/r504kdvpWm/+N2w54LDrvQ
	kneDzZJX8Iq+MyogxU18ShmiReqpf52hVkkU3iD3RGVYfjcLG3tHLYYWG23lYlEew9kO84DJd6k
	f96Ar68eDOCIa8Dva5gh9ydPjW0JOVxVjzgbiHlxsmVmChi7t+Kl/6gMiifc9v2C3g6WJO+x45R
	A9ncX4e5hs6kVwZAtZKPCPHTjq0Kv3
X-Gm-Gg: ASbGnct0Ls8hm97gnYhoFDkluoAvTMbz3PBObLFQh0SlWHnwl3zchY6Mv4xDSHu6Yfs
	+AKBljTQn5HM/B0RkYJS0PHgZUUgt0bgu4vLj81TxWnzwjamPAZL7hsQhQB7VSBqqeR2b3Xiqfj
	A0CHZAGsFjkQ==
X-Received: by 2002:a05:6402:2787:b0:5dc:545:409f with SMTP id 4fb4d7f45d1cf-5dc17fed649mr4688234a12.2.1737740735480;
        Fri, 24 Jan 2025 09:45:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFk5OyIkGLcCdvkTB7EWKEF0Ng9Urtox4OSvtvCIJOvM8dlIUNoFtfOdb0RrQPLTg4+zwhooVDjdT01dNVi8Fw=
X-Received: by 2002:a05:6402:2787:b0:5dc:545:409f with SMTP id
 4fb4d7f45d1cf-5dc17fed649mr4688212a12.2.1737740735062; Fri, 24 Jan 2025
 09:45:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123-nfsd-6-14-v1-0-c1137a4fa2ae@kernel.org>
 <20250123-nfsd-6-14-v1-3-c1137a4fa2ae@kernel.org> <a95521d2-18a2-48d2-b770-6db25bca5cab@oracle.com>
 <4f89125253d82233b5b14c6e0c4fd7565b1824e0.camel@kernel.org> <Z5OdECjsie-MCFel@poldevia.fieldses.org>
In-Reply-To: <Z5OdECjsie-MCFel@poldevia.fieldses.org>
From: Olga Kornievskaia <okorniev@redhat.com>
Date: Fri, 24 Jan 2025 12:45:24 -0500
X-Gm-Features: AWEUYZlk0e3zRhoIFSwqe_8QW40j8dPKOXT8uO2uxe_QaW0veSU-j8Ou9ZdO_rw
Message-ID: <CACSpFtB9yjDpKc_0QrNS2sHN9qFsVQQLvL7ALmG1OE1W+Wivtg@mail.gmail.com>
Subject: Re: [PATCH 3/8] nfsd: when CB_SEQUENCE gets NFS4ERR_DELAY, release
 the slot
To: "J. Bruce Fields" <bfields@fieldses.org>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Neil Brown <neilb@suse.de>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Kinglong Mee <kinglongmee@gmail.com>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2025 at 9:08=E2=80=AFAM J. Bruce Fields <bfields@fieldses.o=
rg> wrote:
>
> On Thu, Jan 23, 2025 at 06:20:08PM -0500, Jeff Layton wrote:
> > On Thu, 2025-01-23 at 17:18 -0500, Chuck Lever wrote:
> > > On 1/23/25 3:25 PM, Jeff Layton wrote:
> > > > RFC8881, 15.1.1.3 says this about NFS4ERR_DELAY:
> > > >
> > > > "For any of a number of reasons, the replier could not process this
> > > >   operation in what was deemed a reasonable time. The client should=
 wait
> > > >   and then try the request with a new slot and sequence value."
> > >
> > > A little farther down, Section 15.1.1.3 says this:
> > >
> > > "If NFS4ERR_DELAY is returned on a SEQUENCE operation, the request is
> > >   retried in full with the SEQUENCE operation containing the same slo=
t
> > >   and sequence values."
> > >
> > > And:
> > >
> > > "If NFS4ERR_DELAY is returned on an operation other than the first in
> > >   the request, the request when retried MUST contain a SEQUENCE opera=
tion
> > >   that is different than the original one, with either the slot ID or=
 the
> > >   sequence value different from that in the original request."
> > >
> > > My impression is that the slot needs to be held and used again only i=
f
> > > the server responded with NFS4ERR_DELAY on the SEQUENCE operation. If
> > > the NFS4ERR_DELAY was the status of the 2nd or later operation in the
> > > COMPOUND, then yes, a different slot, or the same slot with a bumped
> > > sequence number, must be used.
> > >
> > > The current code in nfsd4_cb_sequence_done() appears to be correct in
> > > this regard.
> > >
> >
> > Ok! I stand corrected. We should be able to just drop this patch, but
> > some of the later patches may need some trivial merge conflicts fixed
> > up.
> >
> > Any idea why SEQUENCE is different in this regard?
>
> Isn't DELAY on SEQUENCE an indication that the operation is still in
> progress?  The difference between retrying the same slot or not is
> whether you're asking the server again for the result of the previous
> operation, or whether you're asking it to perform a new one.
>
> If you get DELAY on a later op and then keep retrying with the same
> seqid/slot then I'd expect you to get stuck in an infinite loop getting
> a DELAY response out of the reply cache.

If the client would keep re-using the same seqid for the operation it
got a DELAY on then it would be a broken client. When the linux client
gets ERR_DELAY, it retries the operation but it increments the seqid.

>
> --b.
>
>
> > This rule seems a
> > bit arbitrary. If the response is NFS4ERR_DELAY, then why would it
> > matter which slot you use when retransmitting? The responder is just
> > saying "go away and come back later".
> >
> > What if the responder repeatedly returns NFS4ERR_DELAY (maybe because
> > it's under resource pressure), and also shrinks the slot table in the
> > meantime? It seems like that might put the requestor in an untenable
> > position.
> >
> > Maybe we should lobby to get this changed in the spec?
> >
> > >
> > > > This is CB_SEQUENCE, but I believe the same rule applies. Release t=
he
> > > > slot before submitting the delayed RPC.
> > > >
> > > > Fixes: 7ba6cad6c88f ("nfsd: New helper nfsd4_cb_sequence_done() for=
 processing more cb errors")
> > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > ---
> > > >   fs/nfsd/nfs4callback.c | 1 +
> > > >   1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> > > > index bfc9de1fcb67b4f05ed2f7a28038cd8290809c17..c26ccb9485b95499fc9=
08833a384d741e966a8db 100644
> > > > --- a/fs/nfsd/nfs4callback.c
> > > > +++ b/fs/nfsd/nfs4callback.c
> > > > @@ -1392,6 +1392,7 @@ static bool nfsd4_cb_sequence_done(struct rpc=
_task *task, struct nfsd4_callback
> > > >                   goto need_restart;
> > > >           case -NFS4ERR_DELAY:
> > > >                   cb->cb_seq_status =3D 1;
> > > > +         nfsd41_cb_release_slot(cb);
> > > >                   if (!rpc_restart_call(task))
> > > >                           goto out;
> > > >
> > > >
> > >
> > >
> >
> > --
> > Jeff Layton <jlayton@kernel.org>
>


