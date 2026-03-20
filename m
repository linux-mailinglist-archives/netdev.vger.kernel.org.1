Return-Path: <netdev+bounces-269877-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDKEBl8ivWmr6wIAu9opvQ
	(envelope-from <netdev+bounces-269877-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 11:33:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7484E2D8B98
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 11:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2778303AB70
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 10:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F3E38A702;
	Fri, 20 Mar 2026 10:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YuXUAk7Q";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oy938Etm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8CE283FE3
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 10:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774002512; cv=none; b=nnQZxPVB/G3sJ95pBUizpQWyWjYaZTmzVJEzHPZUmhLzOuEXW/k+I2KHOnbYD/hyyzZAuSq6lMBajBn7VKkfmtuEC04Tmb58X/9aoymxkZxTWMxnCxCr6XUD7D58ta3ulY3Wmi5vRpeUggYH5KWiI0vRTcAi3mruWeyQ+3J6bH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774002512; c=relaxed/simple;
	bh=KyJKK5isZ64xOnxxGEaZ5VV7iYtLlVlKAJxcAORDKgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kC4e/wAsAqnPXkrf6NOsdASHPy2aMy5zkWb9Q11553O/kRA+1u8SKPynB9+sht9GON4F1uDfKl2eoIpuXhTmdbGcIgZIBs+B+4iIe06mS89kT9hSPfAoaN/T9+TJ/rFJBPNmLlGcKeAj5V212FvffwTZ8vlQk1KPp5hdOaGzOzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YuXUAk7Q; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oy938Etm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774002509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ETcinoc+Iu6TM4nD/QE43KJ6uJXP6/02M2IBKPvEmHw=;
	b=YuXUAk7Q3Jg0i4Jmyf4QML7ae2gisjMgjocC/GDtjIwbYFN7lg6u70k3bjcJl7R0eLuNqx
	aQiaCBjvAUhOUtyl/q9Obrxcjff5MgVnCidrOMGQLSEuPF9Lk4sRyN8V+t5NgmnEccQLk5
	9cOPEfzzfMPRo4KjArRmnY/q3HDdobY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-mwb34NciOYWZV9qKYI2sqw-1; Fri, 20 Mar 2026 06:28:28 -0400
X-MC-Unique: mwb34NciOYWZV9qKYI2sqw-1
X-Mimecast-MFC-AGG-ID: mwb34NciOYWZV9qKYI2sqw_1774002507
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-487018c8244so1565775e9.3
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 03:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774002507; x=1774607307; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ETcinoc+Iu6TM4nD/QE43KJ6uJXP6/02M2IBKPvEmHw=;
        b=oy938EtmFaMScZigzcKCBAZH+hLHJaQ9b2y98L36t3zE+Vs1GtNNnXKPI17lBSPHKD
         6DXTn2rpAW2oO0ou7oq+gS0kUDwoW2Qt/V2Sed7Rc2FVWiZWlUbfHmadbZad0EpRhEEL
         xSYJgfXkFyyftPK44NyvDtqK7c6Lct/YRZFQOO8g358QxOtoLnAPR/860KzgZBpVIs3r
         M+l7ZcKiAagOyNbObF6FKfVn0RNsk/2ABrD5aH7y3Gyf6XfMITjOAk4YqiAMNOhUANtE
         7jNeA/Ol3U2T3VxbfL2vCS7jEJgLipu06IWbCp9X9wUIT0MwGWKToWLJQWhXz+mGa9QG
         NfYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774002507; x=1774607307;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ETcinoc+Iu6TM4nD/QE43KJ6uJXP6/02M2IBKPvEmHw=;
        b=s3dI2wVokak0rDDl86EnpOHHmRaESPlHy3jUBYofN8Coh6y+oZseIcWGq2uIHVUUVv
         DYmIDcTL4dSAbWYKdq+jmkbdd9mvps1cYaLOSf0gKGqoQryNluKTJQX+bsO2K/t588hc
         psMc/5HOyuOTPznoZHeRnS0Zf2gDjQDbq2agAL+anQt8xm+kcp3k01bOM+ImIbbt3nnj
         27p1G4kroah1sw1GTN44UkhE/PBHqdWe8Kor2qFkgj/Vl4L1JVyo5f29MaIWQqReXOI0
         JibO/qi6hvXVJpCAt/tEBxx8Xr0kXXQoINwe/fo0z4yGBWeDZhUoeZsfgLzqcGuyz+Qg
         U1Cw==
X-Gm-Message-State: AOJu0YxI6z6QYP7VHjBDTA1H/U0nO26w0Bi87XD+oycVHR5ect/UigxB
	2OF1LdrUV+RFVeBmIObM8rpvP5DcA+ayOjXcPNVTACXOi+lWdros3rYfkS7ji6EotueOqWQUObz
	tLej5R0+gWzM48UP0Nl0ho5xNsb/T5/n3I+zdyEhoZND2A3qpBvEN6doGyg==
X-Gm-Gg: ATEYQzxx32UiiI5I+yefvsSMxOETeR2/5LQmh1jSop/zVDM72CP/2HNzQREFlfzCdpZ
	N4BEoQeLVXvqUvKC1KelMD69A0uOKWbsPVszRSARtv+3X9nlbTWBOnufqHG5JWvBggeDpthJ+ws
	gK4J5gHjYLFrijTN5+A9xzEaaU4HKxZ+203m7h1xPNoFeeX6oRcUlFuA4EP3216R1qWlMNV28Pb
	Lsi1gWfdOfnLKNUluUuT1GqRrdhVDZ3IMJx4sqbqWX3xvA3xxEmDjYl4oxoogCXMMw75YrJNB+f
	mxukotw1XwsRN2+EYlc0yNJEGhI0yKLiAb8ZbjV/mJzT57/mzdgfHonAk5SoeeMQ2EoqNzFekDt
	EfaOLshPC8zhKmFQ5
X-Received: by 2002:a05:600c:c84:b0:485:3812:36f6 with SMTP id 5b1f17b1804b1-486fee0bcc1mr34021615e9.21.1774002507007;
        Fri, 20 Mar 2026 03:28:27 -0700 (PDT)
X-Received: by 2002:a05:600c:c84:b0:485:3812:36f6 with SMTP id 5b1f17b1804b1-486fee0bcc1mr34021275e9.21.1774002506531;
        Fri, 20 Mar 2026 03:28:26 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1525:da00:3ac2:1a22:72ff:4256])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe7e3a94sm59954255e9.7.2026.03.20.03.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 03:28:25 -0700 (PDT)
Date: Fri, 20 Mar 2026 06:28:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net v11 0/2] virtio-net: fix for VIRTIO_NET_F_GUEST_HDRLEN
Message-ID: <20260320062811-mutt-send-email-mst@kernel.org>
References: <20260320021818.111741-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320021818.111741-1-xuanzhuo@linux.alibaba.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269877-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,redhat.com,lunn.ch,davemloft.net,google.com,kernel.org,resnulli.us,solid-run.com,lists.linux.dev];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.946];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7484E2D8B98
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 10:18:16AM +0800, Xuan Zhuo wrote:
> v11:
>   1. rename virtio_net_set_hdrlen() to __virtio_net_set_hdrlen(),
>   virtio_net_set_tnl_hdrlen() to __virtio_net_set_tnl_hdrlen(), and add
>   explicitly mention in a comment that such functions must be invoked only after
>   virtio_net_hdr_from_skb()
> 
> v10:
>   1. fix http://lore.kernel.org/all/202603122214.8Anoxrmq-lkp@intel.com
> 
> v9:
>   1. Introduce new helpers to set hdr len, and virtio_net_hdr_tnl_from_skb
>   calls them directly.
> 
> v8:
>   1. move changes of virtio_net_hdr_from_skb for udp tunnel to #2
>   2. remove change for num_sg
> 
> v7:
>   1. fix bug reported by robot
>   2. Still splitting into two commits, as the issues fixed originate from
>      different commits. This separation makes it easier to selectively revert to
>      previous versions.
> 
> v6:
>   1. rename to guest_hdrlen
>   2. introduce a function virtio_net_set_hdrlen to set the hdrlen
> 
> The commit be50da3e9d4a ("net: virtio_net: implement exact header length
> guest feature") introduces support for the VIRTIO_NET_F_GUEST_HDRLEN
> feature in virtio-net.
> 
> This feature requires virtio-net to set hdr_len to the actual header
> length of the packet when transmitting, the number of
> bytes from the start of the packet to the beginning of the
> transport-layer payload.
> 
> However, in practice, hdr_len was being set using skb_headlen(skb),
> which is clearly incorrect. This path set fixes that issue.
> 
> As discussed in [0], this version checks the VIRTIO_NET_F_GUEST_HDRLEN is
> negotiated.
> 
> 
> [0]: http://lore.kernel.org/all/20251029030913.20423-1-xuanzhuo@linux.alibaba.com
> 



Acked-by: Michael S. Tsirkin <mst@redhat.com>

> 
> 
> 
> 
> 
> Xuan Zhuo (2):
>   virtio-net: correct hdr_len handling for VIRTIO_NET_F_GUEST_HDRLEN
>   virtio-net: correct hdr_len handling for tunnel gso
> 
>  drivers/net/tun_vnet.h     |  2 +-
>  drivers/net/virtio_net.c   |  6 ++++-
>  include/linux/virtio_net.h | 53 +++++++++++++++++++++++++++++++++++---
>  3 files changed, 55 insertions(+), 6 deletions(-)
> 
> --
> 2.32.0.3.g01195cf9f


