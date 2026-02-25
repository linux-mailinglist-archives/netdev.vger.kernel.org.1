Return-Path: <netdev+bounces-260843-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YESoNYrEnmkuXQQAu9opvQ
	(envelope-from <netdev+bounces-260843-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 10:44:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 433F1195386
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 10:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E89BA311C32B
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 09:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0114E38F244;
	Wed, 25 Feb 2026 09:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="SSw/mes0"
X-Original-To: netdev@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2D838F946
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 09:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772012303; cv=none; b=WscOR5hiiDZ5her9GzDnc+vesbmaxDaNYnrAtcCr0YxAo6Rualj2sctO0O09zVGyvPAtI3sYSJtFh2Ars/7ZimraNf/lhdsZ9mhelLHY6MdxTKGgOTWStjR/sxqPMNJPQHuk8PkVegl1DhXMjTNtLUi/lni7IhqCYThbNmAftsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772012303; c=relaxed/simple;
	bh=1dLLMH5GIoxKJEBTV/utfHr/NfjFSZ5psEIajw3MuOI=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=oAeEc/sfzYIPP5g+Sg0aJnOw8MgXYT01qGiChHq9qxCBsg4iQLkp6J8a1JoX6VugJv4CHH4BX6jhcA28NScCU9eiIuzFRDX9KG/ADhzAmqYXI0Tgj7bCdQ3MHGoadUAV3cMuxfm/e63eLu93195gjhoEhcYmmOugTOu6ZAL2VXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=SSw/mes0; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1772012297; h=Message-ID:Subject:Date:From:To;
	bh=TFcqJpM92n7IwSmqYDILwf+RYMnPdukEY+exes7lVbI=;
	b=SSw/mes0W5+RHgNgZVtnd0N1leVwwckTjTAkK7c9f7Yc8scplEWMmbr/vC8xjlnbs5S4aQYahlqFTwDxXnerRoamMIbsgDKeQN0O9qcAlNTbRSf+/2PwfbfT91heGeLDpMoL8beKIT+g1VBLTRGW1sKXRcRlroKr3tbssvrKED8=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0Wzm3Usy_1772012297 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 25 Feb 2026 17:38:17 +0800
Message-ID: <1772012166.8117785-4-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next,2/2] virtio_net: replace RSS key size max check with BUILD_BUG_ON
Date: Wed, 25 Feb 2026 17:36:06 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Srujana Challa <schalla@marvell.com>,
 pabeni@redhat.com,
 jasowang@redhat.com,
 eperezma@redhat.com,
 davem@davemloft.net,
 edumazet@google.com,
 kuba@kernel.org,
 ndabilpuram@marvell.com,
 kshankar@marvell.com,
 netdev@vger.kernel.org,
 virtualization@lists.linux.dev
References: <20260224065850.962826-1-schalla@marvell.com>
 <20260224065850.962826-2-schalla@marvell.com>
 <1772010702.3747633-2-xuanzhuo@linux.alibaba.com>
 <20260225042302-mutt-send-email-mst@kernel.org>
 <1772011833.9281492-3-xuanzhuo@linux.alibaba.com>
 <20260225043249-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260225043249-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260843-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xuanzhuo@linux.alibaba.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:mid,linux.alibaba.com:dkim,marvell.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 433F1195386
X-Rspamd-Action: no action

On Wed, 25 Feb 2026 04:33:57 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Wed, Feb 25, 2026 at 05:30:33PM +0800, Xuan Zhuo wrote:
> > On Wed, 25 Feb 2026 04:24:14 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > On Wed, Feb 25, 2026 at 05:11:42PM +0800, Xuan Zhuo wrote:
> > > > On Tue, 24 Feb 2026 12:28:50 +0530, Srujana Challa <schalla@marvell.com> wrote:
> > > > > Since NETDEV_RSS_KEY_LEN was increased to 256 in net-next, use
> > > > > BUILD_BUG_ON to enforce the limit at compile time and remove the
> > > > > redundant runtime max check.
> > > > >
> > > > > Signed-off-by: Srujana Challa <schalla@marvell.com>
> > > > > ---
> > > > >  drivers/net/virtio_net.c | 8 +-------
> > > > >  1 file changed, 1 insertion(+), 7 deletions(-)
> > > > >
> > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > index eeefe8abc122..768ad5523dfa 100644
> > > > > --- a/drivers/net/virtio_net.c
> > > > > +++ b/drivers/net/virtio_net.c
> > > > > @@ -6639,13 +6639,7 @@ static int virtnet_validate(struct virtio_device *vdev)
> > > > >  			__virtio_clear_bit(vdev, VIRTIO_NET_F_RSS);
> > > > >  			__virtio_clear_bit(vdev, VIRTIO_NET_F_HASH_REPORT);
> > > > >  		}
> > > > > -		if (key_sz > NETDEV_RSS_KEY_LEN) {
> > > > > -			dev_warn(&vdev->dev,
> > > > > -				 "rss_max_key_size=%u exceeds driver limit %u, disabling RSS\n",
> > > > > -				 key_sz, NETDEV_RSS_KEY_LEN);
> > > > > -			__virtio_clear_bit(vdev, VIRTIO_NET_F_RSS);
> > > > > -			__virtio_clear_bit(vdev, VIRTIO_NET_F_HASH_REPORT);
> > > > > -		}
> > > > > +		BUILD_BUG_ON(type_max(key_sz) >= NETDEV_RSS_KEY_LEN);
> > > >
> > > > Do we really need this check?
> > > >
> > > > If I understand correctly, the intention is to cap key_sz at 256. However, since
> > > > key_sz is of type u8, its maximum value is inherently 255, making this check
> > > > redundant. This is not only limited by this kernel code, the virtio-net spec
> > > > defines this.
> > >
> > > That's why it's BUILD_BUG_ON. It checks it has the right type.
> > >
> > > We never *need* BUILD_BUG_ON by definition, what this does is
> > > document the assumption.
> > >
> > >
> > > > Moreover, if NETDEV_RSS_KEY_LEN is ever reduced to a value smaller than 256 in
> > > > the future, this check would no longer enforce the intended limit correctly.
> > >
> > > then it would fail build.
> >
> > So, does this mean we don't need to account for the case where
> > NETDEV_RSS_KEY_LEN is 128, but the key_sz reported by the device is 64?
> >
> > Thanks.
> >
>
> yes.

Why?

If NETDEV_RSS_KEY_LEN is 128 but the device reports a key_sz of 64, does this
violate the spec?

> the code makes assumptions but it documents them and not
> just documents them, build will fail if they are violated.

About this, I am ok.

Thanks.


>
>
> > >
> > > >
> > > > Moreover, you should add a cover letter.
> > > >
> > > > Thanks.
> > > >
> > > >
> > > >
> > > >
> > > >
> > > > >  	}
> > > > >
> > > > >  	return 0;
> > > > > --
> > > > > 2.25.1
> > > > >
> > >
>

