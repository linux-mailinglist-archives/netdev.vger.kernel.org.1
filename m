Return-Path: <netdev+bounces-287228-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBD/E0tQA2pQ4QEAu9opvQ
	(envelope-from <netdev+bounces-287228-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 18:07:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CF8524595
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 18:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1B39A310429B
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 16:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4403C8C71;
	Tue, 12 May 2026 16:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BvEOKVK7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="atvtpASn"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55C337756A
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 16:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778601733; cv=none; b=eAERmcjDo0aIVOhcDLBoCiLTZn/M/X3DBRtSR+KgNDSs8A6SkAQhYp77+8diNd1ctdGvMiPawqFe1J8kV3F0fi4H9Pgmy9nfpxqjtdD98TXpYMC3pieOHfyV99vDV5UR5C7/3pFw5wfZTYpZ2BSoUlnRF5eEFUiIjGQSpRkCA+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778601733; c=relaxed/simple;
	bh=vWr9cfyQCOSfH7IJmIj+myZeDwfb59BivVN4VpsvMRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oyP81ms9MzpcHtn8BTHZgodiry2w4nrBdWoDyMSTn8NBTvxsnPBRxEn/Pv4bj/ner9K9UDDAMnv6GxZO6DxKmcLcYToUY9HFfEN0FFOl6r5XcP3J5szV9n9oYTPOj+E+DhG4A0OUT2Ezfblh8vr40k57qvnuInZYO95j7UPbxow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BvEOKVK7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=atvtpASn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778601730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FIUiJKhl00kL6+7DmOinctS+OWNE7gekD3egzsDj+sI=;
	b=BvEOKVK77kFv+y+Pw798HkuBhyHGT5BMinQ0Bpfcs4nCNkvddBWUBrFWz4WB1s/HbUaLkc
	ILkuXXaapO+9WDzUwB5vuw70dwuNSxUBMr2QHf7P+6xA39AueN7VmHcoCJ8fuk+qe1WMiC
	6ext2djKmcGS9SjsBxX6VusNEjS4nEg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-VZbevgmdOuOj8CB_5wcMTw-1; Tue, 12 May 2026 12:02:07 -0400
X-MC-Unique: VZbevgmdOuOj8CB_5wcMTw-1
X-Mimecast-MFC-AGG-ID: VZbevgmdOuOj8CB_5wcMTw_1778601727
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-44696b11265so6507375f8f.0
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 09:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778601726; x=1779206526; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FIUiJKhl00kL6+7DmOinctS+OWNE7gekD3egzsDj+sI=;
        b=atvtpASn5Dfk/7FGVkodl5WTDAnbYKqjdEck4Y0kJDEvRsdXPeLad4OVT9vBDzt2NT
         a8YgJE6130o3Oh/3iwTa3rLnDyI+m2uOO4ADx2wY9baugbbB01lHy8NhA37ao3tCMZOp
         PoLyHJIrux79wUq9fuseSjoovEm4bzUVAbB2WdZSvFvHPUe7F4DOQBpp974rk7K0QCZ6
         bG1xgip9lKdnIeugkPaP7bzIF9fXyHNqUVMFk1D5SbTJYVwQfOvGpGuuE76JlBDp7cey
         zbhXdJNhrxs0+rj/fDhtYhw2iRkDG47zHDmsQApID29xIVl80twXXGXEL7ruYRilKkkB
         54UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778601726; x=1779206526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FIUiJKhl00kL6+7DmOinctS+OWNE7gekD3egzsDj+sI=;
        b=HXorS5a+Ne+PV0Pv1qc8YJSliryY92bKgseefdFKgt5veZmQGy/JTWp4+dkb4nSZvV
         IxBjdBQar0l7kElK+mAhsA/BVohl9J3n0JhINEtC4tl68nFf5FzFXykvqrTVnuGziDHV
         e1OdH4mESWyK5wr1KG1r92xcKxxh3H/cu2gYbYrfd4GAT2zctnoMY23WmXLNByscG7WM
         kCROKms+bqKLu5XuX8ZnfsOjXYVT1txHKSJ2pvVCRf0Pw7O3ZFB/w5w3h4tUDPfOrfuB
         BJKMGVl7YJSaqacVjLKoSc9Vm8R4qPFuhFIDUPaJrsydM8pGPQyr0v5vhzdhntRG9xTn
         Lb3Q==
X-Forwarded-Encrypted: i=1; AFNElJ8iyB/6GKeWbh42KV2D0o31jcWmx4BO3m9FiT9gZ9ouGr9TEeLH9T2w5sRN3dr9YHIY3USe1Xs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfmF/M3qtH0+6hlBPcye6g8n4/ae36yqEXiwLIJNeQL25bRnd7
	nhy9PESgCdhnoO69DZCX/nE7DCcCnvBqb4jdXe+fCVnioLH8tMLo2wiHrLDm6k8ZCEMqe4T7ToH
	t2SaTiTycOFEA9ac4kUyXAwatKb9EgfTFqAngmJ7w+haECfHeC17As6G9tA==
X-Gm-Gg: Acq92OGuAkLjdKF3WGXzsjjUurmF2rfcJaSZWIm7xsvlzBFtGyJznjb7XN8wBBi4OPL
	IlYJVBls9j2TrM8AT8A3qtGIHhNE9MNPiC9SGAyz5kg5wOz5hBlleLbiGLXgB44leKSFZUSLpWU
	sgUIPbzyog0QJ1KjotuJ5UGB0XjV5QVR6Epp9WI4fyUhBNClAB+598X3wBXHYZPOeTHari02KCJ
	rq2N4+Q6r/SBqXtuDfZC9S/jZylJY2hMjqA+PGEUcD22S+r7wcdEa6CWSFY1ZZeHCWvjGYgNMXJ
	C5yuZ8mGVRSPrctkddMMhjqKc4TjGrem2Kyz0F/ssWdIa+lXRZB7DZQP6yGkkK9hasYZ+bEPcXS
	/UPvxjIoFLO2eRcFk1sLJTSMMFA==
X-Received: by 2002:a05:600c:444f:b0:488:9439:880d with SMTP id 5b1f17b1804b1-48e8fe84e0bmr59315635e9.29.1778601726334;
        Tue, 12 May 2026 09:02:06 -0700 (PDT)
X-Received: by 2002:a05:600c:444f:b0:488:9439:880d with SMTP id 5b1f17b1804b1-48e8fe84e0bmr59313645e9.29.1778601724684;
        Tue, 12 May 2026 09:02:04 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8e64385bsm22758065e9.12.2026.05.12.09.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 09:02:03 -0700 (PDT)
Date: Tue, 12 May 2026 12:02:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Polina Vishneva <polina.vishneva@virtuozzo.com>,
	"den@openvz.org" <den@openvz.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"eperezma@redhat.com" <eperezma@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"jasowang@redhat.com" <jasowang@redhat.com>
Subject: Re: [PATCH] vhost/vsock: Refuse the connection immediately when
 guest isn't ready
Message-ID: <20260512120019-mutt-send-email-mst@kernel.org>
References: <20260511145610.413210-1-polina.vishneva@virtuozzo.com>
 <agH3WvJtAsQ_5zx4@sgarzare-redhat>
 <962b26d2d1daa9411fb71efab6af2c75d1c5f0d0.camel@virtuozzo.com>
 <agM8cxqUCJNjBDlm@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agM8cxqUCJNjBDlm@sgarzare-redhat>
X-Rspamd-Queue-Id: B9CF8524595
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-287228-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 05:39:48PM +0200, Stefano Garzarella wrote:
> On Tue, May 12, 2026 at 02:32:14PM +0000, Polina Vishneva wrote:
> > On Mon, 2026-05-11 at 17:56 +0200, Stefano Garzarella wrote:
> > > On Mon, May 11, 2026 at 04:56:10PM +0200, Polina Vishneva wrote:
> > > > From: "Denis V. Lunev" <den@openvz.org>
> > > >
> > > > When the host initiates an AF_VSOCK connect() to a guest that has not
> > > > yet loaded the virtio-vsock transport (i.e. still booting), the caller
> > > > blocks for VSOCK_DEFAULT_CONNECT_TIMEOUT (2 seconds), because
> > > > vhost_transport_do_send_pkt() silently exits when
> > > > vhost_vq_get_backend(vq) returns NULL.
> > > 
> > > Can SO_VM_SOCKETS_CONNECT_TIMEOUT helps on this?
> > 
> > It can, but it might be difficult to find a correct timeout.
> > 
> > And, generally, there's no way to distinguish "the guest hasn't yet initialized
> > the vq" from "the guest is up and running, but didn't reply to connect() in
> > time". That's exactly what this patch is attempting to fix.
> 
> Okay, so please mention this in the commit message, I mean why
> SO_VM_SOCKETS_CONNECT_TIMEOUT can't really help.
> 
> > 
> > > 
> > > >
> > > > If the guest doesn't start listening within this timeout, connect()
> > > > returns ETIMEDOUT.
> > > >
> > > > This delay is usually pointless and it doesn't well align with our
> 
> I still don't understand why this is pointless. If an application wants to
> wait while sleeping, it can simply increase the timeout long enough to wait
> for the VM to start up and use a single `connect()` call, instead of
> continuing to try and wasting CPU cycles unnecessarily.
> 
> Hmm, or maybe not, because the driver will definitely be initialized before
> the application that wants to listen on that port, so it will respond that
> no one is listening, and the `connect()` call will fail with an `ECONNRESET`
> error in any case. Right?
> 
> If it is the case, is the following line in the commit description correct?
> 
>     If the guest doesn't start listening within this timeout, connect()
>     returns ETIMEDOUT.
> 
> I mean, also if the application starts to listen within the timeout, I think
> the connect() will fail in any case as I pointed out above (this should be
> another point in favour of this change)
> 
> 
> BTW, I think we should explain this more clearly both here and briefly in
> the code as well.
> 
> > > > behavior at other initialization stages: for example, if a connection is
> > > > attempted when the guest driver is already loaded, but when nothing is
> > > > listening yet, it returns ECONNRESET immediately without any wait.
> > > >
> > > > Fix this by checking the RX virtqueue backend in
> > > > vhost_transport_send_pkt() before queuing. If the backend is NULL,
> > > > return -ECONNREFUSED immediately.
> > > >
> > > > Signed-off-by: Denis V. Lunev <den@openvz.org>
> > > > Co-developed-by: Polina Vishneva <polina.vishneva@virtuozzo.com>
> > > > Signed-off-by: Polina Vishneva <polina.vishneva@virtuozzo.com>
> > > > ---
> > > > drivers/vhost/vsock.c | 10 ++++++++++
> > > > 1 file changed, 10 insertions(+)
> > > >
> > > > diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> > > > index 1d8ec6bed53e..a3f218292c3a 100644
> > > > --- a/drivers/vhost/vsock.c
> > > > +++ b/drivers/vhost/vsock.c
> > > > @@ -302,6 +302,16 @@ vhost_transport_send_pkt(struct sk_buff *skb, struct net *net)
> > > > 		return -ENODEV;
> > > > 	}
> > > >
> > > > +	/* Fast-fail if the guest hasn't enabled the RX vq yet. Reading
> > > > +	 * private_data without vq->mutex is deliberate: even if the backend becomes
> > > > +	 * NULL right after that check, do_send_pkt() checks it under the mutex.
> > > > +	 */
> > > > +	if (!data_race(READ_ONCE(vsock->vqs[VSOCK_VQ_RX].private_data)))
> > > 
> > > Why not using vhost_vq_get_backend() ?
> > 
> > Because it locks the mutex, which is slow and unacceptable in this hot
> > path.
> 
> ehm, sorry, which mutex are you talking about?
> 
> I see just a comment about the mutex to be acquired by the caller, but I
> don't see any lock there.
> 
> > 
> > > 
> > > Also is READ_ONCE() okay without WRITE_ONCE() where it is set ?
> > 
> > It's racy, but as described here in the comment and in the commit message,
> > any possible race outcome is covered by the subsequent checks.
> 
> Okay, so what is the point to call READ_ONCE()?
> 
> > 
> > > > {
> > > > +		rcu_read_unlock();
> > > > +		kfree_skb(skb);
> > > > +		return -ECONNREFUSED;
> > > 
> > > This is a generic send_pkt, is it okay to return ECONNREFUSED in any
> > > case?
> > 
> > EHOSTUNREACH would probably be better.
> > All the current send_pkt functions only return ENODEV, but it has different
> > semantics: they mean that the local device isn't yet ready, while there we're
> > dealing with the opposite end not being ready.
> 
> In the AF_VSOCK prespective, I see ENODEV like the transport is not ready,
> so I think it can eventually fit here too, but also EHOSTUNREACH is fine,
> for sure better than ECONNREFUSED.
> 
> Thanks,
> Stefano

I think it's worth trying to do the same thing with e.g. TCP
and see what error, if any, we get. Match that.


> > 
> > Best regards, Polina.
> > 
> > > 
> > > Thanks,
> > > Stefano
> > > 
> > > > +	}
> > > > +
> > > > 	if (virtio_vsock_skb_reply(skb))
> > > > 		atomic_inc(&vsock->queued_replies);
> > > >
> > > >
> > > > base-commit: 8ab992f815d6736b5c7a6f5fd7bfe7bc106bb3dc
> > > > --
> > > > 2.53.0
> > > >


