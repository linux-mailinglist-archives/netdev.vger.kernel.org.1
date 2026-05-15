Return-Path: <netdev+bounces-288250-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EN8PKWvqBmpKowIAu9opvQ
	(envelope-from <netdev+bounces-288250-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 11:42:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3FC54C9FE
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 11:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9655C30AFA43
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 08:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BF9425CFD;
	Fri, 15 May 2026 08:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PHicn5HD";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BjwrBKlT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37894266A2
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 08:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778835472; cv=none; b=TJcOPdqgPWUCDSuRhOKhNBSjS1S4Lqagwr4scp54RPaMTVXFGunjw6YoMxJ/dCDw714pATWGcMs2x7nriHvfWDkzyKv8yIwuT2QROD2yP1Icg/pV7RWagVmha3Bx1F2K5kpkHnAbaJlet3oGsHtZHzm79/IcP498rbH5tFCsQrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778835472; c=relaxed/simple;
	bh=yiJc4Nt7lDDJQvZBzjmQQRrY7ovUUA6spxCpoO5M6TA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dx9PuNkE6BJSEUjCBkRp5xBPCeSnvVl4BoJpL83gfQ+qF6PKfdrVLo1TIYpDd+Lcj8kSDCMd5QJe6mdqvIWK8SdoTY+jpWu8ap0l95DQmDyMbcy/T7CYuwKitoR8oerrKF1kambtIFL+KWxNQRLHzK8z3TWp2fcTpv9ExqTUu6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PHicn5HD; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BjwrBKlT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778835468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=76MGKo7laS3q15QwVBANhPivXoLiqDoqFX8CsnX+SSM=;
	b=PHicn5HDA7k8ctrJsEuhXatYFXgMRd0TdEZTmTsztvPuIO9444FMZJOdgMYuCEKEuRH+kC
	uK6TuyUrSZ8mTE2Zc5/cyKsbzS208SY650Nrhb51DPKQIu10/HkmHsPFX8RYy8wv/VHh2S
	vio4a7SYyhSs8EZ/AbdGTIFeoOCUPio=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-Cpv4ePmPPI-n2TTDpgiPkg-1; Fri, 15 May 2026 04:57:47 -0400
X-MC-Unique: Cpv4ePmPPI-n2TTDpgiPkg-1
X-Mimecast-MFC-AGG-ID: Cpv4ePmPPI-n2TTDpgiPkg_1778835466
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4411a2c034fso7899113f8f.3
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 01:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778835466; x=1779440266; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=76MGKo7laS3q15QwVBANhPivXoLiqDoqFX8CsnX+SSM=;
        b=BjwrBKlTCxL/58XE00cE1fkaBhtzGi2Rz11zf70pMP7pjafnMH5e5CdJXhw2Ug5+He
         Ngsb9jHf2Bs3e95c7lcaKcK3rgA9D5GnL/p+kxCoC7RjEVJcjNcJE+Un2RihsCldWSNG
         QzGfqzGGE6xprpsnk0bR5+NRzDIpJt+JrwXyGwLjewuJmq3uNEc2WnfFT2x55OF+oCWU
         EHRS/cLo3wusti1PAunCkr2Prc3oM5zMNofWdGkPvcd7dZZCT/osGLxB6mQF5pdpC2pU
         oU7K62+TfHdgonHUH96Zf6pOUmP6W/pK3oCxJCDcV9TCvvTbQEcAk5OWWyDKGHGab++F
         gzPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778835466; x=1779440266;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=76MGKo7laS3q15QwVBANhPivXoLiqDoqFX8CsnX+SSM=;
        b=YihU2tWfHVdvwnCd0TFp5phiXDkTBKRRKCA8CgXj8fdjEM40t/s576NNDCS//UDrwr
         vU60Qr3Oqs1Gq1lynU48620fOi6gQUcKEklYeNQMHBNNodPy58y9/finKGSOOuJaXYON
         MLU1msCaKA+djz274hHVe3gEZ3BeYJo0rLngRyS53+jBX7DNBK4po0QfuOpK7yGeNtzV
         0YjAXU38vfLbi2vgUkJrHj50I5Dn9FeBVDpw2o7nc89GHXqufa3XzExPj19jkDwl13+h
         wmYjMUI5PaWc9owXtiHpN8wBQqKzEuzRRCplupTDWeH7xkD5PhTNd1vYx+jlNWCvF/o6
         in5w==
X-Gm-Message-State: AOJu0YwhtJYB06Lp6W0eR4ArP1NALRVPdlRrQPio++i2qQXE6mniUokZ
	ttTLUx8C/iKTtZXoMkYRqIxeayiiXoz2mN8jZALr8yh9IFtMB46OhIm50UE+yB3OfNtYdirWyLg
	EnTrcLw/BQFRwMDlZokhOTZrex7jqhMpEZDonY4VQyMQHGP53bsFr4KC+lQ==
X-Gm-Gg: Acq92OElm9Jh5HGwOvPIGYoOKnI3wCG8UpVtJjlmPIQqjCzeuXcnUj14TC92LFmyZ8B
	AkLIvpgRM4DD5Eylif3iHSRjx6GBfjNSE5jNz/uap8zZRDDhk1CO28wZcTkyOmMM4qt4mwIeVNT
	tCF0wZMbFL0tv8d8wKWvPIMXU6K1WtHEYvVbKEvj+80DfjyBDKeQNF8KbwO9bSEsaoxwuwDGHN1
	eK/tW8uurPtf+jfxtiSOF7tACfF5Is0ISBbBydjsswsZqM0rbf/VtrlPOi2qVtq80I/VP8rotW6
	t2xtaaKNDVcQNamGv+DcxQaMtwtxB+lPui+nJCntcSVsoQXAu4/7ew2dJe2S7GcJ5JjmxB82zcb
	oiFsnTljEeOpa
X-Received: by 2002:a05:6000:240b:b0:43c:f1a5:56f6 with SMTP id ffacd0b85a97d-45e5c5a8dc8mr4021848f8f.43.1778835465815;
        Fri, 15 May 2026 01:57:45 -0700 (PDT)
X-Received: by 2002:a05:6000:240b:b0:43c:f1a5:56f6 with SMTP id ffacd0b85a97d-45e5c5a8dc8mr4021803f8f.43.1778835465227;
        Fri, 15 May 2026 01:57:45 -0700 (PDT)
Received: from redhat.com ([31.187.78.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ec3ac86sm13294048f8f.14.2026.05.15.01.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 01:57:44 -0700 (PDT)
Date: Fri, 15 May 2026 04:57:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
	Stefan Hajnoczi <stefanha@redhat.com>,
	virtualization@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH net v3 1/2] vsock/virtio: reset connection on receiving
 queue overflow
Message-ID: <20260515043940-mutt-send-email-mst@kernel.org>
References: <20260513105417.56761-1-sgarzare@redhat.com>
 <20260513105417.56761-2-sgarzare@redhat.com>
 <agXh36gUe1K6__Bk@sgarzare-redhat>
 <20260514111513-mutt-send-email-mst@kernel.org>
 <CAGxU2F4qWcQTmXnH74V8xZKADLiEMUmCc0+ktW5fZOXdTP4Bdw@mail.gmail.com>
 <20260514134347-mutt-send-email-mst@kernel.org>
 <agbWNqhzvEHVBvC2@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agbWNqhzvEHVBvC2@sgarzare-redhat>
X-Rspamd-Queue-Id: EF3FC54C9FE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288250-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 10:29:55AM +0200, Stefano Garzarella wrote:
> On Thu, May 14, 2026 at 01:44:53PM -0400, Michael S. Tsirkin wrote:
> > On Thu, May 14, 2026 at 06:45:00PM +0200, Stefano Garzarella wrote:
> > > On Thu, 14 May 2026 at 17:16, Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Thu, May 14, 2026 at 04:57:16PM +0200, Stefano Garzarella wrote:
> > > > > On Wed, May 13, 2026 at 12:54:16PM +0200, Stefano Garzarella wrote:
> > > > > > From: Stefano Garzarella <sgarzare@redhat.com>
> > > > > >
> > > > > > When there is no more space to queue an incoming packet, the packet is
> > > > > > silently dropped. This causes data loss without any notification to
> > > > > > either peer, since there is no retransmission.
> > > > > >
> > > > > > Under normal circumstances, this should never happen. However, it could
> > > > > > happen if the other peer doesn't respect the credit, or if the skb
> > > > > > overhead, which we recently began to take into account with commit
> > > > > > 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue"),
> > > > > > is too high.
> > > > > >
> > > > > > Fix this by resetting the connection and setting the local socket error
> > > > > > to ENOBUFS when virtio_transport_recv_enqueue() can no longer queue a
> > > > > > packet, so both peers are explicitly notified of the failure rather than
> > > > > > silently losing data.
> > > > > >
> > > > > > Fixes: ae6fcfbf5f03 ("vsock/virtio: discard packets if credit is not respected")
> > > > > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > > > > > ---
> > > > > > net/vmw_vsock/virtio_transport_common.c | 19 ++++++++++++++-----
> > > > > > 1 file changed, 14 insertions(+), 5 deletions(-)
> > > > > >
> > > > > > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > > > > > index 989cc252d3d3..4a4ac69d1ad1 100644
> > > > > > --- a/net/vmw_vsock/virtio_transport_common.c
> > > > > > +++ b/net/vmw_vsock/virtio_transport_common.c
> > > > > > @@ -1350,7 +1350,7 @@ virtio_transport_recv_connecting(struct sock *sk,
> > > > > >     return err;
> > > > > > }
> > > > > >
> > > > > > -static void
> > > > > > +static bool
> > > > > > virtio_transport_recv_enqueue(struct vsock_sock *vsk,
> > > > > >                           struct sk_buff *skb)
> > > > > > {
> > > > > > @@ -1365,10 +1365,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
> > > > > >     spin_lock_bh(&vvs->rx_lock);
> > > > > >
> > > > > >     can_enqueue = virtio_transport_inc_rx_pkt(vvs, len);
> > > > > > -   if (!can_enqueue) {
> > > > > > -           free_pkt = true;
> > > > > > +   if (!can_enqueue)
> > > > > >             goto out;
> > > > > > -   }
> > > > > >
> > > > > >     if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SEQ_EOM)
> > > > > >             vvs->msg_count++;
> > > > > > @@ -1408,6 +1406,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
> > > > > >     spin_unlock_bh(&vvs->rx_lock);
> > > > > >     if (free_pkt)
> > > > > >             kfree_skb(skb);
> > > > > > +
> > > > > > +   return can_enqueue;
> > > > > > }
> > > > > >
> > > > > > static int
> > > > > > @@ -1420,7 +1420,16 @@ virtio_transport_recv_connected(struct sock *sk,
> > > > > >
> > > > > >     switch (le16_to_cpu(hdr->op)) {
> > > > > >     case VIRTIO_VSOCK_OP_RW:
> > > > > > -           virtio_transport_recv_enqueue(vsk, skb);
> > > > > > +           if (!virtio_transport_recv_enqueue(vsk, skb)) {
> > > > > > +                   /* There is no more space to queue the packet, so let's
> > > > > > +                    * close the connection; otherwise, we'll lose data.
> > > > > > +                    */
> > > > > > +                   (void)virtio_transport_reset(vsk, skb);
> > > > > > +                   sk->sk_state = TCP_CLOSE;
> > > > > > +                   sk->sk_err = ENOBUFS;
> > > > > > +                   sk_error_report(sk);
> > > > >
> > > > > sashiko reported some issues related to setting TCP_CLOSE state and not
> > > > > removing the socket from the connect table:
> > > > > https://sashiko.dev/#/patchset/20260513105417.56761-1-sgarzare%40redhat.com
> > > > >
> > > > > I'll change this by calling virtio_transport_do_close() and
> > > > > vsock_remove_sock() in the next version.
> > > > >
> > > > > Stefano
> > > > >
> > > > > > +                   break;
> > > > > > +           }
> > > > > >             vsock_data_ready(sk);
> > > > > >             return err;
> > > > > >     case VIRTIO_VSOCK_OP_CREDIT_REQUEST:
> > > > > > --
> > > > > > 2.54.0
> > > > > >
> > > >
> > > >
> > > > And so the bag of hacks grows. I feel this is energy not well spent.
> > > > Please, let us fix this properly *first*. And then worry about how to
> > > > backport.  Maybe it will not be so terrible to backport after all.
> > > >
> > > 
> > > TBH I don't think this is an hack, but an issue we should fix in any case.
> > > Regarding the second patch, I see your point, but it's a big change
> > > that worries me. I'd like some more time to fix it properly without
> > > rushing. Staying calm without realizing that userspace is broken like
> > > we are now without this series :-(
> > > 
> > > That said, evaluating further, I think we have a similar issue also
> > > with STREAM on the host side where the skb usually doesn't free space,
> > > so we need a merge strategy also there.
> > > 
> > > So, I'd like to have time to fix both definitely. If you have time and
> > > want to go ahead, please do.
> > > 
> > > Thanks,
> > > Stefano
> > 
> > Well my patch was a start, we just need a strategy how to avoid copying
> > everything, right?
> 
> Yep, and then there's the question of how to handle EOM without a payload,
> but I think that's a special case. In theory, we don't support sending it,
> but I'm not sure if POSIX allows it or not.

It seems to, but given we didn't allow it in the past, we probably
should not start now without a good solution.
Really we should add a feature bit for EOM to steal a byte from
buf_alloc. Or several bytes)

> That said, is it okay if I send a v4 of this series?
> 
> (I'm not sure if I'll be able to work on the merging next week)
> 
> Stefano


I do worry we are piling up hacks and we'll end up with races
for all our troubles. That said, up to you.


