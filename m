Return-Path: <netdev+bounces-260863-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDUSH0jKnmm0XQQAu9opvQ
	(envelope-from <netdev+bounces-260863-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 11:09:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F045519581E
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 11:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE58630465E1
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 10:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE5C38F92A;
	Wed, 25 Feb 2026 10:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="INaiBdUT";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JkQDmUSZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3109A38F940
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 10:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772013935; cv=none; b=IN8gKjHrpdpW2skXZ8v9O6XdpRAk2D6twGLw6h/S+EifX6nk+gJEHk5xzx85sO7rfzijjhqSfH0swUbEsA3rBiN3pZk5tBDmKra9RLHYhrSkWgnKawe7B3wBky7dtewZrfKRMaPnpKxB2IO25mFJrj8hciTfjfvsaV7WasRI0aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772013935; c=relaxed/simple;
	bh=137Htqus0VCz2fkUEoX0C6QiaDNRn9ss7lhpg4S4VP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u0YEi0R2N4gV+FQsb6FWNuOV5ldo4egLbQvUTuxck/TsPtagnrhreoEUbp7IzzvCVZfisO3gORckWrwusT9l5YPkqZPpdML5Ef11yD8qN5WPky9Iv+7/ibt//9PvIfo8a74v7P4PsaZ8yhLIrsssTPWGmjz5deA3VZm5TbhFFzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=INaiBdUT; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JkQDmUSZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772013933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gCbdDmWBjVylwCV0fkm3KEsq7bDVRfaF0cb6VnbpnMg=;
	b=INaiBdUTaXXeiVKU4Feom/IMYUfwc3J2Psl23CXprNRM7AtkgpOgSgXK9X/ieZl2Vx357G
	Rs098AJXEXmoOOkka5DNXXPKEjqj9YLN2eQBU1tLchekp3kJS/cZTHOqqxG/DjRgycc14s
	2vMPxkFLvEsNjb8HgHnCgs8nMnn7GF4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-jkEbnxGiMiSgG2oxmqBrxQ-1; Wed, 25 Feb 2026 05:05:25 -0500
X-MC-Unique: jkEbnxGiMiSgG2oxmqBrxQ-1
X-Mimecast-MFC-AGG-ID: jkEbnxGiMiSgG2oxmqBrxQ_1772013925
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4359849d324so5755803f8f.1
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 02:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772013924; x=1772618724; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gCbdDmWBjVylwCV0fkm3KEsq7bDVRfaF0cb6VnbpnMg=;
        b=JkQDmUSZORjpgFDq5XNPrfaes5cqybAVx4be3VB+bBA2WHkyaZpjY3lI/tWrqsDZy4
         AXNguIXVF8caJfubuwXoyC22irNRA9YLF8zmYYELgy4LhZwk/ZV8MrbqN9E2l7OD0gb9
         8XH89P6JQkzFx2nc1XU+wysf54+pTb+x2oDE61fs3UkjdB0ZqO54jO7cDg6v7tq5Ig2+
         Tddt0GOoCCcDL4CQzYlygnV9QmtWAKaGiYfoZNcHFSrMpT8K5Rrg5Mp847VTwsJpnnlM
         JifGi1jQh+ya7i0uXgwJMz6jQGPv/o24jY2RKzcwEtjGVM4nwd18XPM/aY6pYiMF9Bv7
         Ii/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772013924; x=1772618724;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gCbdDmWBjVylwCV0fkm3KEsq7bDVRfaF0cb6VnbpnMg=;
        b=FDbnAyr0CkgCDD0+D66bjxaxisYmdjgn//FAjfdJYAfuNTKsS3cqrJb9uDjA0zS2NS
         UDfvrm0S3nOpvrV1P6lOCoNMPutEdQDtebpcSWe1noK+Kbf/2W3zcR8VqG/Qe0c1G3XN
         olFw4nmxdlsV8HQ40z055urS5DfIWXKic5i1QuVIiPk3sugPI3+Qj2T3aaWfqF+KfRvt
         a518uX7x0UdzyVLM2978olcEYvsty95BHLWbEsktOu2BcMYg25zvJp1/i3Mte94RUJf6
         Cbsr8xu+5ZxPXg0v5zdUyXs8haHK1YeLr15y+GgHhpVLbeYgGpBha21o42qG6Rz+BFD1
         b8BA==
X-Forwarded-Encrypted: i=1; AJvYcCWneFADIbonewgZ9QG3m4Uu26HmPCM4EuG/0h3KTV4dMFa7TtAQnXxev48uREE3vU7kq/xx39g=@vger.kernel.org
X-Gm-Message-State: AOJu0YylicsMdPByIQMvAB5KrjlINqWmyyUH9u5RTudoCecja+JDrURI
	xK9zfjv/lJUJA3qWQQC7l7slLGJf71CpEzEawDV7SdZePdF7epRD+wyk+1KpSKNghi4u8ChzDvJ
	nrQi9Sh25qEflK3Vwhkj0YkAZTlZ9Y5EMPuRdy0XZDcO4SyAsYOSlKAhtbQ==
X-Gm-Gg: ATEYQzy6qyv2LIy+az6QCuuLEMlO8WK1G3dq+neGWyaw/TsshE8EaeUpAPMi7vd+s4T
	X4wJjgXcttzYkuoicxMcvyswKR7txSLo2mvgavqyFxInd4t8FOJr/Ims+LWV9dVGJq4gsiDFIJW
	FgN+j26TKyuTDEdYX+ZJ9aRZDPECjMyC+zTddiajowy716HbdUpfWuRrbNi3ShiBBzCXxyX0Nn9
	R9D8oziCI3DW5XrCiCfvqb+wMLbF1KYAILqhtcETh/lSbRUg9PBMMn+u0awLNeN+qBVEhvzrcTX
	b2xG1lJWlRHnP3G0whmWOc/5uQDYRKNnh6wHACxVBVKoryALy4+edZ8DoZ/KGQUBZCbNEf1Fk7V
	HZTMHIBI9LhD+XNBfHUyjwdnTuqeXjUwi4Fr8uCWCTA+wbQ==
X-Received: by 2002:a05:6000:2086:b0:435:8aa0:a30c with SMTP id ffacd0b85a97d-4396f182df7mr27572614f8f.48.1772013924357;
        Wed, 25 Feb 2026 02:05:24 -0800 (PST)
X-Received: by 2002:a05:6000:2086:b0:435:8aa0:a30c with SMTP id ffacd0b85a97d-4396f182df7mr27572536f8f.48.1772013923743;
        Wed, 25 Feb 2026 02:05:23 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970c00768sm31641564f8f.10.2026.02.25.02.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 02:05:22 -0800 (PST)
Date: Wed, 25 Feb 2026 05:05:20 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Srujana Challa <schalla@marvell.com>, pabeni@redhat.com,
	jasowang@redhat.com, eperezma@redhat.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, ndabilpuram@marvell.com,
	kshankar@marvell.com, netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next,2/2] virtio_net: replace RSS key size max check
 with BUILD_BUG_ON
Message-ID: <20260225050441-mutt-send-email-mst@kernel.org>
References: <20260224065850.962826-1-schalla@marvell.com>
 <20260224065850.962826-2-schalla@marvell.com>
 <1772010702.3747633-2-xuanzhuo@linux.alibaba.com>
 <20260225042302-mutt-send-email-mst@kernel.org>
 <1772011833.9281492-3-xuanzhuo@linux.alibaba.com>
 <20260225043249-mutt-send-email-mst@kernel.org>
 <1772012166.8117785-4-xuanzhuo@linux.alibaba.com>
 <20260225044528-mutt-send-email-mst@kernel.org>
 <1772013149.5017734-5-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1772013149.5017734-5-xuanzhuo@linux.alibaba.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260863-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F045519581E
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 05:52:29PM +0800, Xuan Zhuo wrote:
> On Wed, 25 Feb 2026 04:47:22 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Wed, Feb 25, 2026 at 05:36:06PM +0800, Xuan Zhuo wrote:
> > > On Wed, 25 Feb 2026 04:33:57 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > On Wed, Feb 25, 2026 at 05:30:33PM +0800, Xuan Zhuo wrote:
> > > > > On Wed, 25 Feb 2026 04:24:14 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > > > On Wed, Feb 25, 2026 at 05:11:42PM +0800, Xuan Zhuo wrote:
> > > > > > > On Tue, 24 Feb 2026 12:28:50 +0530, Srujana Challa <schalla@marvell.com> wrote:
> > > > > > > > Since NETDEV_RSS_KEY_LEN was increased to 256 in net-next, use
> > > > > > > > BUILD_BUG_ON to enforce the limit at compile time and remove the
> > > > > > > > redundant runtime max check.
> > > > > > > >
> > > > > > > > Signed-off-by: Srujana Challa <schalla@marvell.com>
> > > > > > > > ---
> > > > > > > >  drivers/net/virtio_net.c | 8 +-------
> > > > > > > >  1 file changed, 1 insertion(+), 7 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > > > > index eeefe8abc122..768ad5523dfa 100644
> > > > > > > > --- a/drivers/net/virtio_net.c
> > > > > > > > +++ b/drivers/net/virtio_net.c
> > > > > > > > @@ -6639,13 +6639,7 @@ static int virtnet_validate(struct virtio_device *vdev)
> > > > > > > >  			__virtio_clear_bit(vdev, VIRTIO_NET_F_RSS);
> > > > > > > >  			__virtio_clear_bit(vdev, VIRTIO_NET_F_HASH_REPORT);
> > > > > > > >  		}
> > > > > > > > -		if (key_sz > NETDEV_RSS_KEY_LEN) {
> > > > > > > > -			dev_warn(&vdev->dev,
> > > > > > > > -				 "rss_max_key_size=%u exceeds driver limit %u, disabling RSS\n",
> > > > > > > > -				 key_sz, NETDEV_RSS_KEY_LEN);
> > > > > > > > -			__virtio_clear_bit(vdev, VIRTIO_NET_F_RSS);
> > > > > > > > -			__virtio_clear_bit(vdev, VIRTIO_NET_F_HASH_REPORT);
> > > > > > > > -		}
> > > > > > > > +		BUILD_BUG_ON(type_max(key_sz) >= NETDEV_RSS_KEY_LEN);
> > > > > > >
> > > > > > > Do we really need this check?
> > > > > > >
> > > > > > > If I understand correctly, the intention is to cap key_sz at 256. However, since
> > > > > > > key_sz is of type u8, its maximum value is inherently 255, making this check
> > > > > > > redundant. This is not only limited by this kernel code, the virtio-net spec
> > > > > > > defines this.
> > > > > >
> > > > > > That's why it's BUILD_BUG_ON. It checks it has the right type.
> > > > > >
> > > > > > We never *need* BUILD_BUG_ON by definition, what this does is
> > > > > > document the assumption.
> > > > > >
> > > > > >
> > > > > > > Moreover, if NETDEV_RSS_KEY_LEN is ever reduced to a value smaller than 256 in
> > > > > > > the future, this check would no longer enforce the intended limit correctly.
> > > > > >
> > > > > > then it would fail build.
> > > > >
> > > > > So, does this mean we don't need to account for the case where
> > > > > NETDEV_RSS_KEY_LEN is 128, but the key_sz reported by the device is 64?
> > > > >
> > > > > Thanks.
> > > > >
> > > >
> > > > yes.
> > >
> > > Why?
> > >
> > > If NETDEV_RSS_KEY_LEN is 128 but the device reports a key_sz of 64, does this
> > > violate the spec?
> >
> > not the value of key_sz. If type of key_sz
> >
> >
> > i actually do not understand the question. this is not what BUILD_BUG_ON
> > checks.
> 
> So this is the issue. Originally, the code checked whether the value of key_sz
> was less than NETDEV_RSS_KEY_LEN. However, switching to a type_max check means
> it no longer covers the scenario I described. Therefore, I think this is
> unreasonable.
> 
> Thanks


patch 1 is unreasonable i think.

which is why patchsets should have a cover letter btw so
one can reply to just patch 1.


> >
> > > > the code makes assumptions but it documents them and not
> > > > just documents them, build will fail if they are violated.
> > >
> > > About this, I am ok.
> > >
> > > Thanks.
> > >
> > >
> > > >
> > > >
> > > > > >
> > > > > > >
> > > > > > > Moreover, you should add a cover letter.
> > > > > > >
> > > > > > > Thanks.
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > >  	}
> > > > > > > >
> > > > > > > >  	return 0;
> > > > > > > > --
> > > > > > > > 2.25.1
> > > > > > > >
> > > > > >
> > > >
> >


