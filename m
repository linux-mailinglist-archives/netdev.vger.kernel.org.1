Return-Path: <netdev+bounces-260914-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oC0pIpTonmk/XwQAu9opvQ
	(envelope-from <netdev+bounces-260914-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 13:18:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B7416197266
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 13:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2A28C301021B
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 12:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12C03ACF0C;
	Wed, 25 Feb 2026 12:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PXwrWZwG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="sNCWHDd8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E42B3ACF19
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 12:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772021903; cv=none; b=p6Dvio/+MvrJHfZ7KmNEj8WswBSxporCacqZdgjldvexsNTugHpN+phOuAvtmOMNdItoySN5iKH0tdP8LCqAFJzSbQtscU5PWXH5gZ76S4dWTfY4N1ZXFWxnFj+aCXFWx3YnRBYvIgw+JCBR2dBLd9rnif14zcRXFoge05z46E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772021903; c=relaxed/simple;
	bh=+IvlZv4NYJan3tCgqGs5gfqQQiOlBruLqq2DMpw10Ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OOqSI7TK6/jF514zWlXs7zixMBYuYOs2ZkTWIR5bU4dzFEkQg0CeyuAIryB3JqJ/HED+xGRhlktpEmMxrgcREH6WKxRlPw/3q58WKcLcXIusouH96aHpczHrbaE7VEwX5X+K5/VWc6N4rADbFPj/vLRyJ/rOX81amj2X7f3pF5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PXwrWZwG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=sNCWHDd8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772021901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s51WxFF04UegQjwCkS2I0W0zutiovtpKD1GDKaSV2FM=;
	b=PXwrWZwGY5wRQR6Y8yFx20tF1tuMqYB7xTRt4kjyAEDSUyvCvoe71l2SxOPrjX2bI2vU8+
	r9fqMOQk53q7Q3I7oyfxKPq84xZFDh4fL/0ipDQUaJ84ZDzXb5Np2MEi+UMY/b5xryPKut
	VcplCTV/l3Q6XbBq3Ta2g7/gn5pw29I=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-rx3DmbLWP32SzHc1B4-byQ-1; Wed, 25 Feb 2026 07:18:20 -0500
X-MC-Unique: rx3DmbLWP32SzHc1B4-byQ-1
X-Mimecast-MFC-AGG-ID: rx3DmbLWP32SzHc1B4-byQ_1772021899
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43993fea282so115336f8f.0
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 04:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772021899; x=1772626699; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s51WxFF04UegQjwCkS2I0W0zutiovtpKD1GDKaSV2FM=;
        b=sNCWHDd8JPbloxE7DsFS5ZcwilEqOZwizdZ+HJv12ewjIMervFKfL4ukCgEllnlU3s
         W63KaBkxtljQ1Gl02pZpxEWMNx9A2/28Xq7/whA61ouzRz0/sw99tHn+sfZ7p/YuEUsA
         DOrsemdIgFZpa8YXPAYoNFqbRez1F3/VXkZ7TwkVr5L42/f1clMnFtVT2Qfpg4Wzm5Cm
         La7wllV5VfiiGiW8/yakNYN01IHIRqUzM91zKDkIbOSwF0R8cfsp/lbCzHpjNFV+HIeF
         zLe/RJvcdvqe1RNhJ+J5VDCUg7uHGbruirk/HjCwTeNqA5Zi/xlCyEQgIRTyBnL4Pyw7
         hM8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772021899; x=1772626699;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s51WxFF04UegQjwCkS2I0W0zutiovtpKD1GDKaSV2FM=;
        b=k8q8ovJqhD1nIwAknKIY2wfmfiIauJeXFk6m9W87nEMGlp6Xn+PxWbYsB4VG+z1ClH
         3UVpG4eZr//yegEaBdKsqwTLDOLcNLAtawPblF6Hj5exsJc78L/+tYZADBTvuT3UgGLQ
         wUnP4DKO8Pei68ZYtmwbxv8D9KqiGQ9bM70bP0HMyXX88zpL8jK47WjQNcRsgtpEl8lb
         npXVyoI3N4I1DR4c9PmmrEpcds/EmA+kAoWOTliHG4Ph8VYHjbykkI6Uxem9AxilMAk9
         7hYIyFCjO73QyHBVfTt5MZIFv7v+Zsty4CG2LfET+pMq1x7s1y/joqi1Bjhn6L1DrRle
         bRsg==
X-Forwarded-Encrypted: i=1; AJvYcCU/RMDYG0upYqMFllC1quFAQ7NufPKSMcoFH56Wn0oIsxERMbjH4ThqCzFAOZWJBNwaE5jWMR0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze2nxmnxpfgvQghmkXOu10TpXu5jhNdcTM7LFad3XIWoWsHEhl
	5hwnZOvA9JutdqzqREcHyPox96UGfSVxszS5wV1LxnTjrLTJ7O15nbESiO0g0qHRwKiIt+Yg3rv
	jiEaEZT5sBd1UXHMfed0IGmC4w5mSXLmbrwbqKGdKhIUyzpwaR0+uo/5Q+Q==
X-Gm-Gg: ATEYQzxo7sgZ+nJ5l1eApuftifMGBoQefUMOPDCqjdBxbm+KAxTUQsCDsKp4cdso/EH
	Mcai8/uaAt+k03LwpjrzwubyXI2Ux5+Ja9vmUbpvfQoGVVfBixR0HgV6uEpEJpUvmhn/nlFTU93
	nuxib7RacO8pf7EE1XFzT80hNSTaSEcBR/7HDmZCzJZNjNHtfki4qKzIe/z764chsfox0ajivS+
	/Z8fweNG18gGU3i+PIEVT2xKoK2Pfl0L7y+x0QYSujCtJXzQuRUI2Ig/3kghjON1hqvZ+dLDd8N
	4bsStVtNe31FmB6/BzHa6a+Ax0MXpSHrh7PO/fEeOe0cuoM4jmvSq9rq/3tXczTApgH6MwG1j0I
	D5Fe6K5CeMUZ7gqz3uJwP2ZZneylemiVddFL+VVvPE4n1/A==
X-Received: by 2002:a05:6000:2311:b0:439:8f6f:1b25 with SMTP id ffacd0b85a97d-4398f6f1e2amr4041555f8f.1.1772021898591;
        Wed, 25 Feb 2026 04:18:18 -0800 (PST)
X-Received: by 2002:a05:6000:2311:b0:439:8f6f:1b25 with SMTP id ffacd0b85a97d-4398f6f1e2amr4041492f8f.1.1772021897994;
        Wed, 25 Feb 2026 04:18:17 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970bf9f77sm34011308f8f.5.2026.02.25.04.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 04:18:17 -0800 (PST)
Date: Wed, 25 Feb 2026 07:18:14 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Srujana Challa <schalla@marvell.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"eperezma@redhat.com" <eperezma@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>,
	Shiva Shankar Kommula <kshankar@marvell.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>
Subject: Re: [EXTERNAL] Re: [PATCH net-next,2/2] virtio_net: replace RSS key
 size max check with BUILD_BUG_ON
Message-ID: <20260225071659-mutt-send-email-mst@kernel.org>
References: <20260224065850.962826-2-schalla@marvell.com>
 <1772010702.3747633-2-xuanzhuo@linux.alibaba.com>
 <20260225042302-mutt-send-email-mst@kernel.org>
 <1772011833.9281492-3-xuanzhuo@linux.alibaba.com>
 <20260225043249-mutt-send-email-mst@kernel.org>
 <1772012166.8117785-4-xuanzhuo@linux.alibaba.com>
 <20260225044528-mutt-send-email-mst@kernel.org>
 <1772013149.5017734-5-xuanzhuo@linux.alibaba.com>
 <20260225050441-mutt-send-email-mst@kernel.org>
 <BY1PR18MB63742AD7C6599EC81A858427A075A@BY1PR18MB6374.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BY1PR18MB63742AD7C6599EC81A858427A075A@BY1PR18MB6374.namprd18.prod.outlook.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260914-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	REDIRECTOR_URL(0.00)[proofpoint.com];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: B7416197266
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 12:13:01PM +0000, Srujana Challa wrote:
> 
> 
> > -----Original Message-----
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Wednesday, February 25, 2026 3:35 PM
> > To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Cc: Srujana Challa <schalla@marvell.com>; pabeni@redhat.com;
> > jasowang@redhat.com; eperezma@redhat.com; davem@davemloft.net;
> > edumazet@google.com; kuba@kernel.org; Nithin Kumar Dabilpuram
> > <ndabilpuram@marvell.com>; Shiva Shankar Kommula
> > <kshankar@marvell.com>; netdev@vger.kernel.org;
> > virtualization@lists.linux.dev
> > Subject: [EXTERNAL] Re: [PATCH net-next,2/2] virtio_net: replace RSS key size
> > max check with BUILD_BUG_ON
> > 
> > On Wed, Feb 25, 2026 at 05: 52: 29PM +0800, Xuan Zhuo wrote: > On Wed,
> > 25 Feb 2026 04: 47: 22 -0500, "Michael S. Tsirkin" <mst@ redhat. com> wrote:
> > > > On Wed, Feb 25, 2026 at 05: 36: 06PM +0800, Xuan Zhuo wrote: > > > On
> > Wed, ZjQcmQRYFpfptBannerStart Prioritize security for external emails:
> > Confirm sender and content safety before clicking links or opening
> > attachments <https://us-phishalarm-
> > ewt.proofpoint.com/EWT/v1/CRVmXkqW!tc3Z1f8UYnWatK-
> > 8Gd3a7iLAAhjzwNasdLDRrDCP-M_xUEAECz9j2fwxWlWq3EugFfzY8uKAhQ-
> > Q2XIdQs89ldnlzrpsl9A$>
> > Report Suspicious
> > 
> > ZjQcmQRYFpfptBannerEnd
> > On Wed, Feb 25, 2026 at 05:52:29PM +0800, Xuan Zhuo wrote:
> > > On Wed, 25 Feb 2026 04:47:22 -0500, "Michael S. Tsirkin"
> > <mst@redhat.com> wrote:
> > > > On Wed, Feb 25, 2026 at 05:36:06PM +0800, Xuan Zhuo wrote:
> > > > > On Wed, 25 Feb 2026 04:33:57 -0500, "Michael S. Tsirkin"
> > <mst@redhat.com> wrote:
> > > > > > On Wed, Feb 25, 2026 at 05:30:33PM +0800, Xuan Zhuo wrote:
> > > > > > > On Wed, 25 Feb 2026 04:24:14 -0500, "Michael S. Tsirkin"
> > <mst@redhat.com> wrote:
> > > > > > > > On Wed, Feb 25, 2026 at 05:11:42PM +0800, Xuan Zhuo wrote:
> > > > > > > > > On Tue, 24 Feb 2026 12:28:50 +0530, Srujana Challa
> > <schalla@marvell.com> wrote:
> > > > > > > > > > Since NETDEV_RSS_KEY_LEN was increased to 256 in
> > > > > > > > > > net-next, use BUILD_BUG_ON to enforce the limit at
> > > > > > > > > > compile time and remove the redundant runtime max check.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Srujana Challa <schalla@marvell.com>
> > > > > > > > > > ---
> > > > > > > > > >  drivers/net/virtio_net.c | 8 +-------
> > > > > > > > > >  1 file changed, 1 insertion(+), 7 deletions(-)
> > > > > > > > > >
> > > > > > > > > > diff --git a/drivers/net/virtio_net.c
> > > > > > > > > > b/drivers/net/virtio_net.c index
> > > > > > > > > > eeefe8abc122..768ad5523dfa 100644
> > > > > > > > > > --- a/drivers/net/virtio_net.c
> > > > > > > > > > +++ b/drivers/net/virtio_net.c
> > > > > > > > > > @@ -6639,13 +6639,7 @@ static int virtnet_validate(struct
> > virtio_device *vdev)
> > > > > > > > > >  			__virtio_clear_bit(vdev, VIRTIO_NET_F_RSS);
> > > > > > > > > >  			__virtio_clear_bit(vdev,
> > VIRTIO_NET_F_HASH_REPORT);
> > > > > > > > > >  		}
> > > > > > > > > > -		if (key_sz > NETDEV_RSS_KEY_LEN) {
> > > > > > > > > > -			dev_warn(&vdev->dev,
> > > > > > > > > > -				 "rss_max_key_size=%u exceeds driver
> > limit %u, disabling RSS\n",
> > > > > > > > > > -				 key_sz, NETDEV_RSS_KEY_LEN);
> > > > > > > > > > -			__virtio_clear_bit(vdev, VIRTIO_NET_F_RSS);
> > > > > > > > > > -			__virtio_clear_bit(vdev,
> > VIRTIO_NET_F_HASH_REPORT);
> > > > > > > > > > -		}
> > > > > > > > > > +		BUILD_BUG_ON(type_max(key_sz) >=
> > NETDEV_RSS_KEY_LEN);
> > > > > > > > >
> > > > > > > > > Do we really need this check?
> > > > > > > > >
> > > > > > > > > If I understand correctly, the intention is to cap key_sz
> > > > > > > > > at 256. However, since key_sz is of type u8, its maximum
> > > > > > > > > value is inherently 255, making this check redundant. This
> > > > > > > > > is not only limited by this kernel code, the virtio-net spec defines
> > this.
> > > > > > > >
> > > > > > > > That's why it's BUILD_BUG_ON. It checks it has the right type.
> > > > > > > >
> > > > > > > > We never *need* BUILD_BUG_ON by definition, what this does
> > > > > > > > is document the assumption.
> > > > > > > >
> > > > > > > >
> > > > > > > > > Moreover, if NETDEV_RSS_KEY_LEN is ever reduced to a value
> > > > > > > > > smaller than 256 in the future, this check would no longer enforce
> > the intended limit correctly.
> > > > > > > >
> > > > > > > > then it would fail build.
> > > > > > >
> > > > > > > So, does this mean we don't need to account for the case where
> > > > > > > NETDEV_RSS_KEY_LEN is 128, but the key_sz reported by the device is
> > 64?
> > > > > > >
> > > > > > > Thanks.
> > > > > > >
> > > > > >
> > > > > > yes.
> > > > >
> > > > > Why?
> > > > >
> > > > > If NETDEV_RSS_KEY_LEN is 128 but the device reports a key_sz of
> > > > > 64, does this violate the spec?
> > > >
> > > > not the value of key_sz. If type of key_sz
> > > >
> > > >
> > > > i actually do not understand the question. this is not what
> > > > BUILD_BUG_ON checks.
> > >
> > > So this is the issue. Originally, the code checked whether the value
> > > of key_sz was less than NETDEV_RSS_KEY_LEN. However, switching to a
> > > type_max check means it no longer covers the scenario I described.
> > > Therefore, I think this is unreasonable.
> > >
> > > Thanks
> > 
> > 
> > patch 1 is unreasonable i think.
> 
> Patch 1 is targeted for net, addressing an issue where VIRTIO_NET_RSS_MAX_KEY_SIZE is fixed at 40, 
> which is only the minimum required by the spec. This led to virtio‑net probe failures when devices
> reported an RSS key size greater than 40. However, the driver also cannot handle keys larger than
> NETDEV_RSS_KEY_LEN (previously 52) due to the BUG_ON(len > sizeof(netdev_rss_key)) in 
> netdev_rss_key_fill. To resolve both issues, VIRTIO_NET_RSS_MAX_KEY_SIZE has been replaced
> with NETDEV_RSS_KEY_LEN.

but where would driver *get* keys larger than sizeof(netdev_rss_key),
even if device supports more.



> Patch 2 is added as per your suggestion to address following warning in net-next after  NETDEV_RSS_KEY_LEN
> was increased to 256.
> +../drivers/net/virtio_net.c:6642:14: warning: result of comparison of constant 256 with expression of type 'u8' (aka 'unsigned char') is always false [-Wtautological-constant-out-of-range-compare]
> + 6642 |                 if (key_sz > NETDEV_RSS_KEY_LEN) {
> +      |                     ~~~~~~ ^ ~~~~~~~~~~~~~~~~~~
> +1 warning generated.
> Sorry, I forgot the cover page.
> 
> Thanks! 
> > 
> > which is why patchsets should have a cover letter btw so one can reply to just
> > patch 1.
> > 
> > 
> > > >
> > > > > > the code makes assumptions but it documents them and not just
> > > > > > documents them, build will fail if they are violated.
> > > > >
> > > > > About this, I am ok.
> > > > >
> > > > > Thanks.
> > > > >
> > > > >
> > > > > >
> > > > > >
> > > > > > > >
> > > > > > > > >
> > > > > > > > > Moreover, you should add a cover letter.
> > > > > > > > >
> > > > > > > > > Thanks.
> > > > > > > > >
> > > > > > > > >
> > > > > > > > >
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > >  	}
> > > > > > > > > >
> > > > > > > > > >  	return 0;
> > > > > > > > > > --
> > > > > > > > > > 2.25.1
> > > > > > > > > >
> > > > > > > >
> > > > > >
> > > >
> 


