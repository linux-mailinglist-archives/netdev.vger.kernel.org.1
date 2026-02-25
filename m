Return-Path: <netdev+bounces-260842-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEGVJybDnmkuXQQAu9opvQ
	(envelope-from <netdev+bounces-260842-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 10:38:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2C0195213
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 10:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 890FE30930D6
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 09:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BBC438E5C5;
	Wed, 25 Feb 2026 09:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cmAKz+0u";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fahornke"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02FF3815D6
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 09:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772012048; cv=none; b=tQhgzfdKySlxfdNsPGqD6W6KF2vwmA1C2bXgpOJqfAq0J8QG1wgFchD5cA4sx1pHoiaMr49XfOkhESjJheodYAAL3IdDiW6h54rm9/9WuQTZGj9wNqrN81EFfKw1oYQTJbCzUVHPVgLVIR5xktIxOYNdBw4KYFOQtQFm6hzhF/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772012048; c=relaxed/simple;
	bh=vBjaUHm65tGNPiYlWRFPhKJtFf2Ma6GE/uA/rEPtwFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pjLWFbXT0aK7tfTI1lreiFCmqaUCqs//cmizIcMpYss4b7USUqfTAYRIxDo7adafrNVhC/e3gI9+gXmXmgwxQqR/P/53bYVXFiADQPAAinwNa7u+UzlFjD4tLFNtY1KRgxriLm2X8VIA5hc66TQOBsknH+UVfw+dGARi2enANjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cmAKz+0u; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fahornke; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772012044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zaDdVCZLCjzGBPi9U/x91/R0/36/oNSWSoktsMcUCyc=;
	b=cmAKz+0udoKOPqTNMPCsWRqS0IJusLguurw1fPdNTR4O/mk6R8jvkDLiF7UX78ASF0a8Be
	mcjfAmgqElTkKUZBxbqWtsLKd6alPaFyex/Xuk9vnSGwo3Rjq2HE+hpDa7yjo0Qpycx66A
	XV3pbstw3O+VnisORE8ie78S92tYTZQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-XNRY9vrsOCy5zkqRQATHEw-1; Wed, 25 Feb 2026 04:34:03 -0500
X-MC-Unique: XNRY9vrsOCy5zkqRQATHEw-1
X-Mimecast-MFC-AGG-ID: XNRY9vrsOCy5zkqRQATHEw_1772012042
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4836cd6dfe6so31335185e9.2
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 01:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772012042; x=1772616842; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zaDdVCZLCjzGBPi9U/x91/R0/36/oNSWSoktsMcUCyc=;
        b=fahornke+lgyHwGrdpSw3TH0rfONo/oMYcRgxTO68Ym0fqVs04uvtP7ycffcbJklUP
         C8B+KZSp0xXopQhUfcPrckMlUUklcnLWqygS89yK0Phlr9vrQx/jvtHjoXz6l3dwMOOx
         TPwcjuTYaTs8fnYmpYI5OQLqp2C+8iFUyNSi3CDNasho03zhJPKm8qgytZJzr9hT/2Aj
         nPiTbJ1AL8sJVeXKuvhkaB+Ipif4AoT4PmbaOiMJdxyMrlUJj08I72AKtpuudK738qzp
         Eid1DlQY3aRur8WllOdCV9aJiiW2+enS5qW3JkMt9ARq1R+dg81bcPKCLnwJAh9HDGdJ
         0S9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772012042; x=1772616842;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zaDdVCZLCjzGBPi9U/x91/R0/36/oNSWSoktsMcUCyc=;
        b=XTVWA2IIfg6QQ1NsOgAweOWK+X3rkUJQWIH3kh+BOG+10RcYugQhS/9WdwBFzZxQr+
         wNhMq3EJtjtkIajlJtnE5oYObqYnjS+h6o/23LXygc3SOQQDfQjJLAJrmrBCHhIXMyAs
         tlqYbwVUuVi7U4iUBQxwEfvhhPGus0p//cFhClJjaNWTG8O5vBb9cIUgwG7e3EALEdiE
         87X2q7/KX1/x6nGEtd2oGovq0c1kLj/lWcczCmE3TY7SljPg11w1ftdGA97e6t1mFFYV
         4XjdD6qlg+IfoR54FgXlKDU1cP7UM2F0gvaXsFEeIWstdn0di7+sgSBXFyFrDr6myIRb
         Xtfg==
X-Forwarded-Encrypted: i=1; AJvYcCVfIYwtha/X9NMS4Qb2OS3EAqMFOBT9nSfZIzHfdi/44KgrZLJvbGSutBUbe7FJ2UKQBBxb1/k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk7G4gJihTaq3MEHgwjyARTqLlEzCdsRvAgUJFzE51VF4Qf/i0
	40WI1LPdeK/XIZ2aMsynGYPfTJcof5waXC51HwCfxveZrkSwH+3jLv5ex2u4qJ3/lE2QNpIdDa8
	Us7BWHnecM3O55Mum7fjEbAAP6naJwATgJnaM1lhtZtCOESyehYYVPRizFQ==
X-Gm-Gg: ATEYQzx5n2qeI2czJxO3p4t8VcbpYgvP1tCG1LMcPETG9092lXsK8r6shuHT6JpfCg7
	soTBIO0SpcAwx2YGesyA0o2sT4mrU0ybnB87+R1Qsw1DpBj2CUQ/zdwbtJbxz0YjmPweLD2bImR
	rLRtkP5eohZC6a7+X/jA+7wD+bx6ulPE+jQtulIy+TMch/O97kfK/SHwB0YGx/BjXFsoYVJcNHa
	NYxGDlt2/vCInOrbc6UK+0PwTxFwWIzydSIRsfB/iPJs9VWcNJ00ZT5OUTCHZ9sXHOg/tJFThUb
	KtkNRRS0dSv0WSxzBGrLlDuD/X8nlMgpxR0eCxEFEZP68hAXLnuhY3/qP0B82txgNTN3ld4kHED
	qgzl/U7stSkvjuaN6NO9X4VOm2eSgc6FUCVHC7faQK+VPDg==
X-Received: by 2002:a05:600c:4f90:b0:477:55ce:f3c2 with SMTP id 5b1f17b1804b1-483bef2a427mr35084345e9.14.1772012042069;
        Wed, 25 Feb 2026 01:34:02 -0800 (PST)
X-Received: by 2002:a05:600c:4f90:b0:477:55ce:f3c2 with SMTP id 5b1f17b1804b1-483bef2a427mr35083785e9.14.1772012041496;
        Wed, 25 Feb 2026 01:34:01 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfbb465bsm18140895e9.3.2026.02.25.01.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 01:34:01 -0800 (PST)
Date: Wed, 25 Feb 2026 04:33:57 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Srujana Challa <schalla@marvell.com>, pabeni@redhat.com,
	jasowang@redhat.com, eperezma@redhat.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, ndabilpuram@marvell.com,
	kshankar@marvell.com, netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next,2/2] virtio_net: replace RSS key size max check
 with BUILD_BUG_ON
Message-ID: <20260225043249-mutt-send-email-mst@kernel.org>
References: <20260224065850.962826-1-schalla@marvell.com>
 <20260224065850.962826-2-schalla@marvell.com>
 <1772010702.3747633-2-xuanzhuo@linux.alibaba.com>
 <20260225042302-mutt-send-email-mst@kernel.org>
 <1772011833.9281492-3-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1772011833.9281492-3-xuanzhuo@linux.alibaba.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260842-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5C2C0195213
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 05:30:33PM +0800, Xuan Zhuo wrote:
> On Wed, 25 Feb 2026 04:24:14 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Wed, Feb 25, 2026 at 05:11:42PM +0800, Xuan Zhuo wrote:
> > > On Tue, 24 Feb 2026 12:28:50 +0530, Srujana Challa <schalla@marvell.com> wrote:
> > > > Since NETDEV_RSS_KEY_LEN was increased to 256 in net-next, use
> > > > BUILD_BUG_ON to enforce the limit at compile time and remove the
> > > > redundant runtime max check.
> > > >
> > > > Signed-off-by: Srujana Challa <schalla@marvell.com>
> > > > ---
> > > >  drivers/net/virtio_net.c | 8 +-------
> > > >  1 file changed, 1 insertion(+), 7 deletions(-)
> > > >
> > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > index eeefe8abc122..768ad5523dfa 100644
> > > > --- a/drivers/net/virtio_net.c
> > > > +++ b/drivers/net/virtio_net.c
> > > > @@ -6639,13 +6639,7 @@ static int virtnet_validate(struct virtio_device *vdev)
> > > >  			__virtio_clear_bit(vdev, VIRTIO_NET_F_RSS);
> > > >  			__virtio_clear_bit(vdev, VIRTIO_NET_F_HASH_REPORT);
> > > >  		}
> > > > -		if (key_sz > NETDEV_RSS_KEY_LEN) {
> > > > -			dev_warn(&vdev->dev,
> > > > -				 "rss_max_key_size=%u exceeds driver limit %u, disabling RSS\n",
> > > > -				 key_sz, NETDEV_RSS_KEY_LEN);
> > > > -			__virtio_clear_bit(vdev, VIRTIO_NET_F_RSS);
> > > > -			__virtio_clear_bit(vdev, VIRTIO_NET_F_HASH_REPORT);
> > > > -		}
> > > > +		BUILD_BUG_ON(type_max(key_sz) >= NETDEV_RSS_KEY_LEN);
> > >
> > > Do we really need this check?
> > >
> > > If I understand correctly, the intention is to cap key_sz at 256. However, since
> > > key_sz is of type u8, its maximum value is inherently 255, making this check
> > > redundant. This is not only limited by this kernel code, the virtio-net spec
> > > defines this.
> >
> > That's why it's BUILD_BUG_ON. It checks it has the right type.
> >
> > We never *need* BUILD_BUG_ON by definition, what this does is
> > document the assumption.
> >
> >
> > > Moreover, if NETDEV_RSS_KEY_LEN is ever reduced to a value smaller than 256 in
> > > the future, this check would no longer enforce the intended limit correctly.
> >
> > then it would fail build.
> 
> So, does this mean we don't need to account for the case where
> NETDEV_RSS_KEY_LEN is 128, but the key_sz reported by the device is 64?
> 
> Thanks.
> 

yes. the code makes assumptions but it documents them and not
just documents them, build will fail if they are violated.


> >
> > >
> > > Moreover, you should add a cover letter.
> > >
> > > Thanks.
> > >
> > >
> > >
> > >
> > >
> > > >  	}
> > > >
> > > >  	return 0;
> > > > --
> > > > 2.25.1
> > > >
> >


