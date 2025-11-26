Return-Path: <netdev+bounces-241711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 11ADCC878C2
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 01:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E6EBE4E11B2
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 00:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4162486331;
	Wed, 26 Nov 2025 00:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ry5lZ1vw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pe6LTW5k"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC7C45C0B
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 00:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764115429; cv=none; b=oYtWM5Q2MP9rPd4/k4LWU0oPBvmucCarjAIAsX3LJafTGbW2sto4Yd4PLeoegH90Tba1g4HSHjiQKV/y29ReQwQigMoxmp0mXaurXHMVqGWA+XSOUO4oty6aE7ayv3YLbueAJK6N5KGq/QqUrTYWXoHeOU9xVSp4QgA1nwht3OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764115429; c=relaxed/simple;
	bh=Zm86rbf4ViZ/eAdZ8KwSBeinjex6AZ0RQ+kgPGLr94c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MZ0j8Yk6PClNTGyj9RCq0EFS2pjrOjk/pIeXbvqQG2ycNgl/JUa/BEmZ40PlwqbPGZZkQJ/hc+CMy6Xd8gjQWik3vnImR5yh0/iHK6DygWu2E7JjqhUkmQOEY8paz37DN1fxE38cJ1Q/pv9jQHtvdO3lvo1WPvZQMvWLybmlDUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ry5lZ1vw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pe6LTW5k; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764115424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vKRmZiEMk1to2WJzzrJwnxFSNJVHABWSWDpvrtN4fR4=;
	b=Ry5lZ1vwx5Z6ZHnEeKIP99QLRdEUBFjnCznSAUqW3zii76Hj4bCFm7T+m5KKO7AtXiBTFo
	UKtXPVOEJ67WTe5F2ymoSEu4USpJpBL/f48Ju8rJRLigPVxJjeHfJWsdg7XSmPS7BU2D3P
	++8zBAMYyIbIZ0yi7VWJ0NCWlvOuPW0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-R6Wh-f1dMuam6iBM1jjMiA-1; Tue, 25 Nov 2025 19:03:40 -0500
X-MC-Unique: R6Wh-f1dMuam6iBM1jjMiA-1
X-Mimecast-MFC-AGG-ID: R6Wh-f1dMuam6iBM1jjMiA_1764115420
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-42b2b642287so3192212f8f.2
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 16:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764115419; x=1764720219; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vKRmZiEMk1to2WJzzrJwnxFSNJVHABWSWDpvrtN4fR4=;
        b=pe6LTW5kXHOGMe1xSfmDKdxmjvUH5WB0a42j+Vv9DLiN5g76ho39WtWbITHQNelwXy
         Db/k+PcPwusZDkkWB64grxoo4kxltmfH7IailoIkaRs7JpnrJJP0rP1VF0OiHKVSZByx
         mMdM0rinzAQpTn5j4U7Pxt48bHY8JCGyPUTFQhzmWJ7vvmYydN/i84YGMUZC1ZUxgKYW
         xB11Y18epkyBR8m2agO1nXhlpolrzyXaHSme2YmeaqTXobx3FGT8LU3aLd2N9jXJwfaP
         8u796DVacjEBGEuj8QXHdfh9mTo+TSefDc54MOIJUCrgU4jla5Mw6dMp2rWOjzJlt7ed
         zHAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764115419; x=1764720219;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vKRmZiEMk1to2WJzzrJwnxFSNJVHABWSWDpvrtN4fR4=;
        b=a09IeclVe/qloFPOx0YtV/FUTdPekgdTlFSXFF9EPMPVkDrTm4Ip4+XjMg5nOsdzgy
         VRYWU4fRy3Bd3NxZM7kblYt7SjYSHG7pVDdOc6zfGZHXQTF9ieevUspcUqMsTD0/EVwH
         MRzDog51jy7SX+JEmU/nY6e+TvGeQIFtA6rBFhbaI8XFTntSVHTC84MkYsSknI+nUZu5
         9gmZruRlQ6F8bNAGW465Y74GQzzgis7xbZZ+pCtWSBUzVdcMq5NCeGNhMMVTed6E1f9U
         6wHuJKWfI1gBqINMWVsQvtPHEpKGcmMWLL3k8aE8vM1FVllHW+Cz0w8BsIlKd4VM6VqT
         Wmgg==
X-Forwarded-Encrypted: i=1; AJvYcCUnY6JY0MbgHqP2PlAX/qpk9P9GuwLo8u4Ez49ZF8sLpxaxp7qvtSBwSsaA9h6Vja4I8Yvza/0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1aav430LZpsmau0JatvDfjy3Hz9xKrwVfwb+YNzoAiTVRWqvf
	K9N6YA5cjf1ANHn3+M/81QlsIa4V2aZ+zFVCo2KwrCUvegd+Lu7bgFJ2gWEfJ4FjTT9dSKMPsGz
	r8Whv2/zTVl4L8nlzWZPZynnTuJvradURVRddpLBecCBjX+X70+JA5BnQAg==
X-Gm-Gg: ASbGncsmQJV3gfe5siixqC+nyPtjxYIyLNU7Iq/H7sk2t34M3l4ht34ruc6tz6z8tRr
	epUa/4XcV3EYDwOTMQMWi52TuHIeQUnx3xueIxse9lae0yYZI6UGDayc8oWQfa8RPU284fGTh3+
	yHnLqwdzkz5sKl0cRklhmmCEBAo1xWbXXB2ro/uoOIALPE3YSicrcoM56X1ndvyB2TFkzwb+69Z
	7kOkXd8189hRSvtRZsMxGlri3wp9XdJORKEm9RxGmFHV645mcGpLyvPZ15GaGrDK+SeZnBH76ED
	FIQOR+6aW/SbUqvkYUedZK1FL9xE8aUu5SWQ52KapAOkc9vEio68ssUccIWODYmnIM5nEGAhjKw
	7HS37nK5Kvp+m24tPSsoZTgVlJ+2ZGw==
X-Received: by 2002:a05:6000:24c3:b0:429:c450:8fad with SMTP id ffacd0b85a97d-42cc1d196a9mr18800454f8f.53.1764115419519;
        Tue, 25 Nov 2025 16:03:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGBR55J7x3MTf+kofKm9ivnzfPRH5t94S9N5E/qvOiFWaJNtYDvbjL54tC9IkLOFKqnZLIwfA==
X-Received: by 2002:a05:6000:24c3:b0:429:c450:8fad with SMTP id ffacd0b85a97d-42cc1d196a9mr18800423f8f.53.1764115418994;
        Tue, 25 Nov 2025 16:03:38 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fa35c2sm36014357f8f.25.2025.11.25.16.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 16:03:38 -0800 (PST)
Date: Tue, 25 Nov 2025 19:03:34 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jon Kohler <jon@nutanix.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] virtio-net: avoid unnecessary checksum
 calculation on guest RX
Message-ID: <20251125190207-mutt-send-email-mst@kernel.org>
References: <20251125175117.995179-1-jon@nutanix.com>
 <276828c5-72cb-4f5c-bc6f-7937aa6b6303@redhat.com>
 <3ED1B031-7C20-45F9-AB47-8FCDB68B448E@nutanix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3ED1B031-7C20-45F9-AB47-8FCDB68B448E@nutanix.com>

On Tue, Nov 25, 2025 at 08:00:55PM +0000, Jon Kohler wrote:
> 
> 
> > On Nov 25, 2025, at 12:57 PM, Paolo Abeni <pabeni@redhat.com> wrote:
> > 
> > CC netdev
> 
> Thats odd, I used git send-email --to-cmd='./scripts/get_maintainer.pl,
> but it looks like in MAINTAINERS, that only would have hit
> VIRTIO CORE AND NET DRIVERS, which does not include netdev@
> 
> Should that have ?
> L: netdev@vger.kernel.org <mailto:netdev@vger.kernel.org>
> 
> Said another way, should all changes to include/linux/virtio_net.h
> be cc’d to netdev DL?
> 
> I suspect the answer is yes, I’ll send a patch for that in the
> interest of not having this issue again :)

I think yes. But only virtio net not core. I guess we should
split net from core then.

> > 
> > On 11/25/25 6:51 PM, Jon Kohler wrote:
> >> Commit a2fb4bc4e2a6 ("net: implement virtio helpers to handle UDP
> >> GSO tunneling.") inadvertently altered checksum offload behavior
> >> for guests not using UDP GSO tunneling.
> >> 
> >> Before, tun_put_user called tun_vnet_hdr_from_skb, which passed
> >> has_data_valid = true to virtio_net_hdr_from_skb.
> >> 
> >> After, tun_put_user began calling tun_vnet_hdr_tnl_from_skb instead,
> >> which passes has_data_valid = false into both call sites.
> >> 
> >> This caused virtio hdr flags to not include VIRTIO_NET_HDR_F_DATA_VALID
> >> for SKBs where skb->ip_summed == CHECKSUM_UNNECESSARY. As a result,
> >> guests are forced to recalculate checksums unnecessarily.
> >> 
> >> Restore the previous behavior by ensuring has_data_valid = true is
> >> passed in the !tnl_gso_type case.
> >> 
> >> Cc: Paolo Abeni <pabeni@redhat.com>
> >> Fixes: a2fb4bc4e2a6 ("net: implement virtio helpers to handle UDP GSO tunneling.")
> >> Signed-off-by: Jon Kohler <jon@nutanix.com>
> >> ---
> >> include/linux/virtio_net.h | 2 +-
> >> 1 file changed, 1 insertion(+), 1 deletion(-)
> >> 
> >> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> >> index b673c31569f3..570c6dd1666d 100644
> >> --- a/include/linux/virtio_net.h
> >> +++ b/include/linux/virtio_net.h
> >> @@ -394,7 +394,7 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
> >> tnl_gso_type = skb_shinfo(skb)->gso_type & (SKB_GSO_UDP_TUNNEL |
> >>     SKB_GSO_UDP_TUNNEL_CSUM);
> >> if (!tnl_gso_type)
> >> - return virtio_net_hdr_from_skb(skb, hdr, little_endian, false,
> >> + return virtio_net_hdr_from_skb(skb, hdr, little_endian, true,
> >>        vlan_hlen);
> >> 
> >> /* Tunnel support not negotiated but skb ask for it. */
> > 
> > virtio_net_hdr_tnl_from_skb() is used also by the virtio_net driver,
> > which in turn must not use VIRTIO_NET_HDR_F_DATA_VALID on tx.
> 
> Ah! Good eye, I’ll see what trouble I can get into and send a v2
> > 
> > I think you need to add another argument to
> > virtio_net_hdr_tnl_from_skb(), or possibly implement a separate helper
> > to take care of csum offload - the symmetric of
> > virtio_net_handle_csum_offload().
> > 
> > Also you need to CC netdev, otherwise the patch will not be processed by
> > patchwork.
> > 
> > /P
> 
> No problems on cc’ing netdev, just didn’t realize this one header didn’t
> auto cc the list. Will keep an eye on that, and happy to send a patch to
> MAINTAINERS file for discussion.


