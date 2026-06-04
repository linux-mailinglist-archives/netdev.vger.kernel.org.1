Return-Path: <netdev+bounces-295473-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IMjVGt0GImrURgEAu9opvQ
	(envelope-from <netdev+bounces-295473-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 01:14:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E99643E8E
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 01:14:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=YaElgTFt;
	dkim=pass header.d=redhat.com header.s=google header.b=VjXZ3xoJ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295473-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295473-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0A08430091D9
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 23:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1703A30BBB8;
	Thu,  4 Jun 2026 23:14:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE152DEA95
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 23:14:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780614864; cv=none; b=DQAyatzNr3bb4nbMB0z4O48ka67hpmMbkyeuBIECZkMLBctfK8+pHAprECIgvgEKhVWimj5yyN17e10Y0xPMsn0IOe+eiEgHHUj/xMUY/TfP3pd7vKJd8ZhikRxY+9i6CthX2j+VGT2/AvAidYax9aV3BcZIFFrOXGkjQDn3UYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780614864; c=relaxed/simple;
	bh=5y3PcmFRYqRP1NnGXJUwB0A0KdsvIgR/FJxx9aWTUsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U0y8h5NEQZmHcNDYo9nMUrIh+8HLq+ENIEo067go/uqShTTQOW9X3gj8Sj3DDIRJyQEvDl8xE4sLxr3uJhAT4JwUjdpke4/pxIOJS6Ms0Oef3r4a13RIzF+XIOCvc5zSk7P1hQqE/qYwBBFjcz8+qbfoVppi6xYfmctCKlvGhjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YaElgTFt; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VjXZ3xoJ; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780614860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BLGZz3723Aln9n0iz1W4fVsSKoXjcy4jTxlM5UdbXW0=;
	b=YaElgTFtz5plumd3F9BmbQui7KnXRyEM2UVoXCdQoFTHSc9m+zaepTrAQKvMT3kaD24Mor
	I2vnA4BqOLh91Nif6LdX5DexXWqpkS0erhrPYj5xcbVv4JdXtMBiOWaKmuWEA63QdN1Ed9
	INLf5nlDDa8S+ac3z1/Ru38/LL20Wps=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-Rfg_ZVhAP3upC-eGUcHNVw-1; Thu, 04 Jun 2026 19:14:19 -0400
X-MC-Unique: Rfg_ZVhAP3upC-eGUcHNVw-1
X-Mimecast-MFC-AGG-ID: Rfg_ZVhAP3upC-eGUcHNVw_1780614858
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-45efa2f7009so752600f8f.3
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 16:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780614858; x=1781219658; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BLGZz3723Aln9n0iz1W4fVsSKoXjcy4jTxlM5UdbXW0=;
        b=VjXZ3xoJ+7gWk5xZ7MaEQIZs2AQEihJoTGtNlR329G+CyghMJ5Kz+UuOnM1hY3r4nh
         NXPRM4rmYQpBVNPxofnQFzuI/UJ2AF2Ug8nuxk+5I+6YeCp3026A39HElL8Rc/sXxX5Q
         /Y7G5NqFDEtFOOViULpsSKvGGNLXaI5qT3aP5EnSoOehtcbJue1YLgdvDaO9arOKteO+
         UUtQT2NxKFLSmvanssklYrhl/PtMIO682auIkFVYlJUlXEc8CyUeMtEA2H5JvNpOfxuN
         y/+J7wHUBCMZuGh0pw0mmpeW5IJW7LS/V51s5I0AFGmSYpvpylUIWHOcQMbq3X5nksLN
         XCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780614858; x=1781219658;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BLGZz3723Aln9n0iz1W4fVsSKoXjcy4jTxlM5UdbXW0=;
        b=cLAYMVCSufs0vMZQYkiQ6YPVEsmR27h5ihIaKwZbhi+T0U60Cv6/Dg2faNXQNUGgd3
         TAsn3m1qwbUag1/kHjb2gLEdJKVmh0J0qK5uG/Ec2FILUaqP/FgdF/sn58HzcqCyr3k3
         5DIKEkgO1r//38I3peECoraymldtngjtVnMXyVw1SK4bBtGBRlKSd55v8Q7/WFFTctFe
         lSBX3YAIHLTg4NfDEc3ZqOnZ6+Z1Z1S5XViaomgmBgbz9qoR5DMuTVax5itWUzKpjc+k
         +0IbwIucdPhLaV+ZkVTQLoSlHmZBWX4BXQzMrqVinSVm23OI1Msoh8u0GDm+3Ip2/pPA
         kwSQ==
X-Forwarded-Encrypted: i=1; AFNElJ8/nXO/QMeXb4kK+VMnpKu4w8Ke6mykrd98wcQAyIpNeM/jdXmn+cMzlib3gIuZjqT90DdrpAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YygPf6RW6Wv1zCeVdVnrbjedDNurfcTRiA8HlpByTSxrmnDFEV4
	DHMkSa9L8vjHMA3bPFArD06jpJDS14touh1R/sHXUQTT6jdAtAmiI9bd4spEENhRWRW+bv7U66G
	YOt1XaJtbzDTCX5GBYOfGP1YO6FIay7buyug0MpB/MNfSoqwE042JofqHZA==
X-Gm-Gg: Acq92OHckdmFoOVJqQ3X7ORfFQo3WdIEQToSana05LyhDq4tAKikdgKHDpJoJ+6oVr5
	uNWzAQJvoSIJK3jVAKyiyjb7FRLeY4+aGoCI1Rhq8BVhEz5jxD6Rv2oqf9W8oZ8uUPfGq/s3Myp
	LLII1+zjRx4XW8tfrteFh8n0mO6OTtarwreXHe19Aue7QLlf0AAAZVmlCFnmyOVGW6bDqd3Bwt7
	j1c6dDbawCBLBncd2PgdRk0ec8YsHe2l5F5q0WzJ0LG62jT2Cx9GQ78E+/B0bMVEUlIUKT5noFQ
	xbZsrxTPrddU9YNY7yCJMUijqperzo7skYmVf5zBDJ56y6zIfGwznh4QBiIvEhBNZda2ZLf4fv3
	R+Bo0XccYHz0pb95+l39luBO7qUhC4Wjjcbd3NlJ5EP7+iE4UDMJpeMo=
X-Received: by 2002:a05:6000:b82:b0:460:1301:dec8 with SMTP id ffacd0b85a97d-460302dc4a8mr1134266f8f.3.1780614858151;
        Thu, 04 Jun 2026 16:14:18 -0700 (PDT)
X-Received: by 2002:a05:6000:b82:b0:460:1301:dec8 with SMTP id ffacd0b85a97d-460302dc4a8mr1134244f8f.3.1780614857676;
        Thu, 04 Jun 2026 16:14:17 -0700 (PDT)
Received: from redhat.com (ppp-94-66-118-61.home.otenet.gr. [94.66.118.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dc577sm19910295f8f.3.2026.06.04.16.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 16:14:17 -0700 (PDT)
Date: Thu, 4 Jun 2026 19:14:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Qing Ming <a0yami@mailbox.org>, Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Shirley <xma@us.ibm.com>, "David S. Miller" <davem@davemloft.net>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] vhost/net: complete zerocopy ubufs only once
Message-ID: <20260604191341-mutt-send-email-mst@kernel.org>
References: <20260601104300.197210-1-a0yami@mailbox.org>
 <b6182472-503c-43e9-a850-87cd40f86aa8@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6182472-503c-43e9-a850-87cd40f86aa8@redhat.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-295473-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:a0yami@mailbox.org,m:jasowang@redhat.com,m:eperezma@redhat.com,m:xma@us.ibm.com,m:davem@davemloft.net,m:kvm@vger.kernel.org,m:virtualization@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mailbox.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 50E99643E8E

On Thu, Jun 04, 2026 at 12:55:49PM +0200, Paolo Abeni wrote:
> On 6/1/26 12:43 PM, Qing Ming wrote:
> > vhost-net initializes one ubuf_info per outstanding zerocopy TX
> > descriptor and hands it to the backend socket.  The networking stack may
> > then clone a zerocopy skb before all skb references are released.  For
> > example, batman-adv fragmentation reaches skb_split(), which calls
> > skb_zerocopy_clone() and increments the same ubuf_info refcount.
> > 
> > vhost_zerocopy_complete() currently treats every ubuf callback as a
> > completed vhost descriptor.  It dereferences ubuf->ctx, writes the
> > descriptor completion state, and drops the vhost_net_ubuf_ref even when
> > the callback only releases a cloned skb reference.  A backend reset can
> > therefore wait for and free the vhost_net_ubuf_ref while another cloned
> > skb still carries the same ubuf_info.  A later completion then
> > dereferences the freed ubufs pointer.
> > 
> > KASAN reports the stale completion as:
> > 
> >   BUG: KASAN: slab-use-after-free in vhost_zerocopy_complete+0x1d7/0x1f0
> >   BUG: KASAN: slab-use-after-free in vhost_zerocopy_complete+0x101/0x1f0
> >   vhost_zerocopy_complete
> >   skb_copy_ubufs
> >   __dev_forward_skb2
> >   veth_xmit
> > 
> > The freed object was allocated from vhost_net_ioctl() while setting the
> > backend and freed through kfree_rcu()/kvfree_rcu_bulk after backend
> > removal, while delayed skb completion still reached
> > vhost_zerocopy_complete().
> > 
> > Honor the generic ubuf_info refcount before touching vhost state, and run
> > the vhost descriptor completion only for the final ubuf reference.  This
> > matches the msg_zerocopy_complete() ownership rule for cloned zerocopy
> > skbs.
> > 
> > Fixes: bab632d69ee4 ("vhost: vhost TX zero-copy support")
> > Signed-off-by: Qing Ming <a0yami@mailbox.org>
> 
> The patch LGTM.
> 
> @Michael: to you want to take it via your tree?
> 
> /P


I wan't copied) Alright then.



