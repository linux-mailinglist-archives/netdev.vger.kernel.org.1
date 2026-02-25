Return-Path: <netdev+bounces-260836-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +C7CJZrBnmnsXAQAu9opvQ
	(envelope-from <netdev+bounces-260836-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 10:32:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1306619506E
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 10:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3EC9130EBAC9
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 09:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774E9385520;
	Wed, 25 Feb 2026 09:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BkHLlQxe";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VHOaf2O7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBA82264DC
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 09:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772011463; cv=none; b=gJPB9fSMgCxPgRCewOjbJc8ZEZHVeZUL+aL32yQb98hIhaXbI5AbqyjWK7p7AkOZ4OF06iy4YQY3XBvkDeUoFDmV52z/sQfVQ91/qZUr4IIHmQ72A4TyiabM/HeX/2714GG1OukbOH6BmuXgqFOEzU3bme5kIT5Lt/crYevH1C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772011463; c=relaxed/simple;
	bh=7uacBGYBiSdhOUvMcdrU/IsdPqCW87JB2my+jD3wn6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/KI/Q0dWjMD2sQtySAyKqmd5MiiZYJsWGHdkFOXMFS1hCXQUkSGNkDm82HnPno3IRi+YNOc8E71Sxr7tGz7pzTiPvg1dhONGr0VeQkpGGts1ZhICME50rf/E2/5N29v644QyS1aH7irPyKH40+cM2Pc+fb6JeEwBTz7ISLpAbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BkHLlQxe; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VHOaf2O7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772011461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CAfCd727gg/hE7rTMdRZLpyODpAzeMqClx6IQZcOXTs=;
	b=BkHLlQxeMUitUFVNVXEJ7q1u26AfD5nN7q19Yys29aj4wXv4x7G/wbG50GM86+UB9PJb7k
	O4HNCOMObozCUQaf/NYCGPZ3iijWL41xauClMqV2I/YxCwDmy1pGazrfv2/xe46qxoZoGN
	o93b1IY6ZUBDwDlC/P86B/oBANJMezc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-53N0ucjDOa25Dcw5CRg3fA-1; Wed, 25 Feb 2026 04:24:19 -0500
X-MC-Unique: 53N0ucjDOa25Dcw5CRg3fA-1
X-Mimecast-MFC-AGG-ID: 53N0ucjDOa25Dcw5CRg3fA_1772011459
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4837bfcfe0dso67622685e9.1
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 01:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772011459; x=1772616259; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CAfCd727gg/hE7rTMdRZLpyODpAzeMqClx6IQZcOXTs=;
        b=VHOaf2O79V1Jqd/ox5oxpjuTnZi0KC/IxaXSObDKXF7FW7jh8dfvlFOhGTq8GqPfo9
         LKtggy70/V//es2l/ObOWmXOdvA1i++SqvD/W043y6fJf+uBmbnbBXs9i0XRERMNM6p1
         pDNeMlK01DOF2rdaVGnLFSE0TQJHkTI1KRDcFahTlyumIQ3P+ts3CQtxtYPdg9G8tPXp
         xSsRV3NCRARKu4GdfzkEJl6Vvkrb4+2YF/lVdTIX/oJbxiCEwyM5ELPpXZVCPMJYpiWs
         XKeLMIP8QY1OhuygMk3rINryiejLUykRpw+5/F65JsEZuR1DMVoG4JdR4XZku8ojnxm+
         RcrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772011459; x=1772616259;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CAfCd727gg/hE7rTMdRZLpyODpAzeMqClx6IQZcOXTs=;
        b=AroL1CjZwEDU+oZ1ZYqbiFWO1xCVMnaOIeOrwGtT2RKo0MbJt/6zwtTmminiOOzPxI
         t2JhFTHvdABezO2iQ7kXd5cxJSbYt/qLtj69T1KLCw6sQcIBmO09wfug3U4Jfo5Fg0Pk
         /Rr93JWz+ULhStahtc8myV2DMVr5QobRwd5otfG1xoXdZ/v7md9wEtqtGomu2i69ilXA
         1yZZio6C5Fq77jS85PY96vtVCAsMnMERWO7G9+JR4DVvYA/P/MXh8nn4dHE66by3PtvL
         7pZKbKEvnmxdCG1hKSRgCSRwIsiWeZyEoaGa/1ZxF0QKdzpLdPZj0FdnDuyPtDHJLxQX
         teEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvssuY1vPaTRb/n4op34n4szoXfqYE8sVRq+7Rlg5LbwWP+uit+q9YJ4Ja7MMkHuMPx03e+lY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+j0IamKvw0OiEXw7yKagr7soVPOWts2Ld/UC58ZWlfmL7xoBL
	UHJAbRkCAD/C4aRLmdH+BII58IuqbfDS7hJmzwC095S6LH+3CdYH+RyUVF//Lsv4RHavBO8k9G7
	y/bl0SvZy1jC/CSCfBYIe+pH5hnUNX7KNJjmGLsFdcfQhPE4NnfUU7bEOCw==
X-Gm-Gg: ATEYQzzRn/dhpk8PV8BC9qZVkt9Oe5xB6jREIKZTrvkIpcxWe+ljGHkPfBp3JZy0uQB
	0DF8v1hAlx36TaKwYjWLTvsK/0pavwYMU8pQpFsZALyM0CKqxH1kNkSypGjhO2p7e9MWYFEtqC/
	HT6cT57vq776ciqKjHvwi1aBl13552aHMQkmCDCjgxV9hhvz3AXcP3n4TMXECvsXS6FMo/ba+29
	uqZXAqRzTED2iNWxs69O8ZhBIyc9DHbtlwefMKEAHny8+qnmWtkNsfHBrhxu8Sj4aqltT+YH1e7
	NCaeeDi6Fh/uFRUWFVog3TkTU2FYmY0cvEFgEq4H/x5mQbmMgbOArFps4PfEkWNIjGiAxSMaWgb
	NzhvJYLxaAr8xxFabjEDXKM575U8V2V+zXzFril92IhfJJw==
X-Received: by 2002:a05:600c:c16b:b0:47d:264e:b35a with SMTP id 5b1f17b1804b1-483bef248f2mr31894425e9.13.1772011458563;
        Wed, 25 Feb 2026 01:24:18 -0800 (PST)
X-Received: by 2002:a05:600c:c16b:b0:47d:264e:b35a with SMTP id 5b1f17b1804b1-483bef248f2mr31893845e9.13.1772011458027;
        Wed, 25 Feb 2026 01:24:18 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d3ff1csm31882149f8f.20.2026.02.25.01.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 01:24:17 -0800 (PST)
Date: Wed, 25 Feb 2026 04:24:14 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Srujana Challa <schalla@marvell.com>, pabeni@redhat.com,
	jasowang@redhat.com, eperezma@redhat.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, ndabilpuram@marvell.com,
	kshankar@marvell.com, netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next,2/2] virtio_net: replace RSS key size max check
 with BUILD_BUG_ON
Message-ID: <20260225042302-mutt-send-email-mst@kernel.org>
References: <20260224065850.962826-1-schalla@marvell.com>
 <20260224065850.962826-2-schalla@marvell.com>
 <1772010702.3747633-2-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1772010702.3747633-2-xuanzhuo@linux.alibaba.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260836-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,marvell.com:email]
X-Rspamd-Queue-Id: 1306619506E
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 05:11:42PM +0800, Xuan Zhuo wrote:
> On Tue, 24 Feb 2026 12:28:50 +0530, Srujana Challa <schalla@marvell.com> wrote:
> > Since NETDEV_RSS_KEY_LEN was increased to 256 in net-next, use
> > BUILD_BUG_ON to enforce the limit at compile time and remove the
> > redundant runtime max check.
> >
> > Signed-off-by: Srujana Challa <schalla@marvell.com>
> > ---
> >  drivers/net/virtio_net.c | 8 +-------
> >  1 file changed, 1 insertion(+), 7 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index eeefe8abc122..768ad5523dfa 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -6639,13 +6639,7 @@ static int virtnet_validate(struct virtio_device *vdev)
> >  			__virtio_clear_bit(vdev, VIRTIO_NET_F_RSS);
> >  			__virtio_clear_bit(vdev, VIRTIO_NET_F_HASH_REPORT);
> >  		}
> > -		if (key_sz > NETDEV_RSS_KEY_LEN) {
> > -			dev_warn(&vdev->dev,
> > -				 "rss_max_key_size=%u exceeds driver limit %u, disabling RSS\n",
> > -				 key_sz, NETDEV_RSS_KEY_LEN);
> > -			__virtio_clear_bit(vdev, VIRTIO_NET_F_RSS);
> > -			__virtio_clear_bit(vdev, VIRTIO_NET_F_HASH_REPORT);
> > -		}
> > +		BUILD_BUG_ON(type_max(key_sz) >= NETDEV_RSS_KEY_LEN);
> 
> Do we really need this check?
> 
> If I understand correctly, the intention is to cap key_sz at 256. However, since
> key_sz is of type u8, its maximum value is inherently 255, making this check
> redundant. This is not only limited by this kernel code, the virtio-net spec
> defines this.

That's why it's BUILD_BUG_ON. It checks it has the right type.

We never *need* BUILD_BUG_ON by definition, what this does is
document the assumption.


> Moreover, if NETDEV_RSS_KEY_LEN is ever reduced to a value smaller than 256 in
> the future, this check would no longer enforce the intended limit correctly.

then it would fail build.

> 
> Moreover, you should add a cover letter.
> 
> Thanks.
> 
> 
> 
> 
> 
> >  	}
> >
> >  	return 0;
> > --
> > 2.25.1
> >


