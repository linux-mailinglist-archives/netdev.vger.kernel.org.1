Return-Path: <netdev+bounces-260849-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFkGN8jHnmkuXQQAu9opvQ
	(envelope-from <netdev+bounces-260849-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 10:58:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 442B1195639
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 10:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A48E2301BF6C
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 09:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F9138F25D;
	Wed, 25 Feb 2026 09:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="sByVizMc"
X-Original-To: netdev@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65B1311599
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 09:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772013189; cv=none; b=g+eU0ZEhTtgXJhLiutWfCFyxLQN+k3cduU3rcKVkNsNTszx1XNtG4HV399uDNkE6gMLsML618TBCHGXEk2LX9mpJov1hwM+8sUOVJV8BatCXlJ8ln3yIHtkB+FyPBlas+EfArmVjG1094roIx8wq8+iVj0H3XMFdI+MmG6BjYuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772013189; c=relaxed/simple;
	bh=rE9DyE9PsTHuMCxDFN5nbZzUyeiy5TfnOuIRspSsthY=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=qg0vm0zJYhe2f6ftnRhuPYwEtxm9q2c2j2SatplVhvwoThTwcQmitCu9I9Bn892MyELkh3OaNiEW6HTSv5jVuqJnDB9D7slOfqHWNWK+WugTNgKZbs5j4Rv5COSvxLLaMeFjJdWYviDHHPbVT7gP2fdeNCvxlnjuAdVVo/urDi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=sByVizMc; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1772013184; h=Message-ID:Subject:Date:From:To;
	bh=OaIxsJYzBsv9YB5DX1bJNSVl0rX7sZyKSgOfBP3V+4k=;
	b=sByVizMc04bHCIkaW/Dagt/ueX3sBmWhZpqRFwgH4ZjKEVeCKonbt/VvZV2ai7lmMvDyMvGKlA2lGMWTmdQ7qP9AWUBy6I1HpxeP1Cn3gSmeqmVAVrW81vqt70EeC8MkttOIDBq8GQ9h7UaX/bMgQecrnfowB6Sykp8zzTVL2UY=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0Wzm3cER_1772013183 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 25 Feb 2026 17:53:04 +0800
Message-ID: <1772013149.5017734-5-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next,2/2] virtio_net: replace RSS key size max check with BUILD_BUG_ON
Date: Wed, 25 Feb 2026 17:52:29 +0800
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
 <1772012166.8117785-4-xuanzhuo@linux.alibaba.com>
 <20260225044528-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260225044528-mutt-send-email-mst@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260849-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:mid,linux.alibaba.com:dkim,marvell.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 442B1195639
X-Rspamd-Action: no action

On Wed, 25 Feb 2026 04:47:22 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Wed, Feb 25, 2026 at 05:36:06PM +0800, Xuan Zhuo wrote:
> > On Wed, 25 Feb 2026 04:33:57 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > On Wed, Feb 25, 2026 at 05:30:33PM +0800, Xuan Zhuo wrote:
> > > > On Wed, 25 Feb 2026 04:24:14 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > > On Wed, Feb 25, 2026 at 05:11:42PM +0800, Xuan Zhuo wrote:
> > > > > > On Tue, 24 Feb 2026 12:28:50 +0530, Srujana Challa <schalla@marvell.com> wrote:
> > > > > > > Since NETDEV_RSS_KEY_LEN was increased to 256 in net-next, use
> > > > > > > BUILD_BUG_ON to enforce the limit at compile time and remove the
> > > > > > > redundant runtime max check.
> > > > > > >
> > > > > > > Signed-off-by: Srujana Challa <schalla@marvell.com>
> > > > > > > ---
> > > > > > >  drivers/net/virtio_net.c | 8 +-------
> > > > > > >  1 file changed, 1 insertion(+), 7 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > > > index eeefe8abc122..768ad5523dfa 100644
> > > > > > > --- a/drivers/net/virtio_net.c
> > > > > > > +++ b/drivers/net/virtio_net.c
> > > > > > > @@ -6639,13 +6639,7 @@ static int virtnet_validate(struct virtio_device *vdev)
> > > > > > >  			__virtio_clear_bit(vdev, VIRTIO_NET_F_RSS);
> > > > > > >  			__virtio_clear_bit(vdev, VIRTIO_NET_F_HASH_REPORT);
> > > > > > >  		}
> > > > > > > -		if (key_sz > NETDEV_RSS_KEY_LEN) {
> > > > > > > -			dev_warn(&vdev->dev,
> > > > > > > -				 "rss_max_key_size=%u exceeds driver limit %u, disabling RSS\n",
> > > > > > > -				 key_sz, NETDEV_RSS_KEY_LEN);
> > > > > > > -			__virtio_clear_bit(vdev, VIRTIO_NET_F_RSS);
> > > > > > > -			__virtio_clear_bit(vdev, VIRTIO_NET_F_HASH_REPORT);
> > > > > > > -		}
> > > > > > > +		BUILD_BUG_ON(type_max(key_sz) >= NETDEV_RSS_KEY_LEN);
> > > > > >
> > > > > > Do we really need this check?
> > > > > >
> > > > > > If I understand correctly, the intention is to cap key_sz at 256. However, since
> > > > > > key_sz is of type u8, its maximum value is inherently 255, making this check
> > > > > > redundant. This is not only limited by this kernel code, the virtio-net spec
> > > > > > defines this.
> > > > >
> > > > > That's why it's BUILD_BUG_ON. It checks it has the right type.
> > > > >
> > > > > We never *need* BUILD_BUG_ON by definition, what this does is
> > > > > document the assumption.
> > > > >
> > > > >
> > > > > > Moreover, if NETDEV_RSS_KEY_LEN is ever reduced to a value smaller than 256 in
> > > > > > the future, this check would no longer enforce the intended limit correctly.
> > > > >
> > > > > then it would fail build.
> > > >
> > > > So, does this mean we don't need to account for the case where
> > > > NETDEV_RSS_KEY_LEN is 128, but the key_sz reported by the device is 64?
> > > >
> > > > Thanks.
> > > >
> > >
> > > yes.
> >
> > Why?
> >
> > If NETDEV_RSS_KEY_LEN is 128 but the device reports a key_sz of 64, does this
> > violate the spec?
>
> not the value of key_sz. If type of key_sz
>
>
> i actually do not understand the question. this is not what BUILD_BUG_ON
> checks.

So this is the issue. Originally, the code checked whether the value of key_sz
was less than NETDEV_RSS_KEY_LEN. However, switching to a type_max check means
it no longer covers the scenario I described. Therefore, I think this is
unreasonable.

Thanks

>
> > > the code makes assumptions but it documents them and not
> > > just documents them, build will fail if they are violated.
> >
> > About this, I am ok.
> >
> > Thanks.
> >
> >
> > >
> > >
> > > > >
> > > > > >
> > > > > > Moreover, you should add a cover letter.
> > > > > >
> > > > > > Thanks.
> > > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > > >  	}
> > > > > > >
> > > > > > >  	return 0;
> > > > > > > --
> > > > > > > 2.25.1
> > > > > > >
> > > > >
> > >
>

