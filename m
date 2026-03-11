Return-Path: <netdev+bounces-266498-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFZfEk0OsWldqAIAu9opvQ
	(envelope-from <netdev+bounces-266498-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 07:40:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4DA25CEFF
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 07:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF502310FE14
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 06:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526E0317143;
	Wed, 11 Mar 2026 06:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="I3P454cs"
X-Original-To: netdev@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D69372EC6
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 06:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773211210; cv=none; b=stb7+JcWQvYiTBt8m0huwajg8Ke5+xGvzsucPfiMJJMJ0aS2X0XPVwg5jJvqD5E9aFZalSdqHPA2bzKD64PE1hT1CCi3PAyiicyYY9gaaOF7T/6lT1mqfQnodrYaHcQkfApjGAY/VUH5Z+NF3UoZ70mAaOjY1nTsAjKwbpTT+nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773211210; c=relaxed/simple;
	bh=ZsjOez3Qway2mYAXvu5QL0vJ5UlYJAMwXZdy+YBKfwI=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=YYJoTVI6284yUX7UAeglJEMQmx609+4ES6dZr1H1Qaxegtdhdlen7KwkBhk4P6b2CkXzMtn/TBfm1YygkHnHUqMui98BlNFlIxqQaTdBWDssgEgQpo92ExlbYbGvauA9YjMWy1mMIoEdZZch+zq/eKkS2JC1B7fMk7KwuTrsjfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=I3P454cs; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773211200; h=Message-ID:Subject:Date:From:To;
	bh=uofCL946arayV1G7q+ZDv8qxg7fecoCepNUKFyCvd9k=;
	b=I3P454csqaxRinlEP1q57TXo8aG73lTu/M9noypgRLs72609PQlh0NZlVEGGJ4XQqDnsryaV4wtMvPNg8D1Pt7N7KTKPll436mgXuogS34ZqNFCzNPDh/SdKxz4RUVffQdViH2KbhYEP612OCdvTse3AInWVDMlO4tffe6zwDC0=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0X-irTwk_1773211198 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 11 Mar 2026 14:39:59 +0800
Message-ID: <1773210927.2628298-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net v8 2/2] virtio-net: correct hdr_len handling for tunnel gso
Date: Wed, 11 Mar 2026 14:35:27 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>,
 Alvaro Karsz <alvaro.karsz@solid-run.com>,
 virtualization@lists.linux.dev,
 netdev@vger.kernel.org
References: <20260305031938.24518-1-xuanzhuo@linux.alibaba.com>
 <20260305031938.24518-3-xuanzhuo@linux.alibaba.com>
 <cf62a942-e1e8-4b37-837a-b0bd76297656@redhat.com>
In-Reply-To: <cf62a942-e1e8-4b37-837a-b0bd76297656@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 8A4DA25CEFF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,lunn.ch,davemloft.net,google.com,kernel.org,resnulli.us,solid-run.com,lists.linux.dev,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266498-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xuanzhuo@linux.alibaba.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, 10 Mar 2026 11:05:33 +0100, Paolo Abeni <pabeni@redhat.com> wrote:
> On 3/5/26 4:19 AM, Xuan Zhuo wrote:
> > The commit a2fb4bc4e2a6a03 ("net: implement virtio helpers to handle UDP
> > GSO tunneling.") introduces support for the UDP GSO tunnel feature in
> > virtio-net.
> >
> > The virtio spec says:
> >
> >     If the \field{gso_type} has the VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV4 bit or
> >     VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV6 bit set, \field{hdr_len} accounts for
> >     all the headers up to and including the inner transport.
> >
> > The commit did not update the hdr_len to include the inner transport.
> >
> > I observed that the "hdr_len" is 116 for this packet:
> >
> >     17:36:18.241105 52:55:00:d1:27:0a > 2e:2c:df:46:a9:e1, ethertype IPv4 (0x0800), length 2912: (tos 0x0, ttl 64, id 45197, offset 0, flags [none], proto UDP (17), length 2898)
> >         192.168.122.100.50613 > 192.168.122.1.4789: [bad udp cksum 0x8106 -> 0x26a0!] VXLAN, flags [I] (0x08), vni 1
> >     fa:c3:ba:82:05:ee > ce:85:0c:31:77:e5, ethertype IPv4 (0x0800), length 2862: (tos 0x0, ttl 64, id 14678, offset 0, flags [DF], proto TCP (6), length 2848)
> >         192.168.3.1.49880 > 192.168.3.2.9898: Flags [P.], cksum 0x9266 (incorrect -> 0xaa20), seq 515667:518463, ack 1, win 64, options [nop,nop,TS val 2990048824 ecr 2798801412], length 2796
> >
> > 116 = 14(mac) + 20(ip) + 8(udp) + 8(vxlan) + 14(inner mac) + 20(inner ip) + 32(innner tcp)
> >
> > Fixes: a2fb4bc4e2a6a03 ("net: implement virtio helpers to handle UDP GSO tunneling.")
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  include/linux/virtio_net.h | 31 ++++++++++++++++++++-----------
> >  1 file changed, 20 insertions(+), 11 deletions(-)
> >
> > diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> > index 23f42bb8ece0..906157779955 100644
> > --- a/include/linux/virtio_net.h
> > +++ b/include/linux/virtio_net.h
> > @@ -209,18 +209,29 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
> >
> >  static inline void virtio_net_set_hdrlen(const struct sk_buff *skb,
> >  					 struct virtio_net_hdr *hdr,
> > +					 struct skb_shared_info *sinfo,
> >  					 bool little_endian,
> >  					 bool feature_hdrlen)
> >  {
> >  	u16 hdr_len;
> >
> >  	if (feature_hdrlen) {
> > -		hdr_len = skb_transport_offset(skb);
> > -
> > -		if (hdr->gso_type == VIRTIO_NET_HDR_GSO_UDP_L4)
> > -			hdr_len += sizeof(struct udphdr);
> > -		else
> > -			hdr_len += tcp_hdrlen(skb);
> > +		if (sinfo->gso_type & (SKB_GSO_UDP_TUNNEL |
> > +				       SKB_GSO_UDP_TUNNEL_CSUM)) {
> > +			hdr_len = skb_inner_transport_offset(skb);
> > +
> > +			if (hdr->gso_type == VIRTIO_NET_HDR_GSO_UDP_L4)
> > +				hdr_len += sizeof(struct udphdr);
> > +			else
> > +				hdr_len += inner_tcp_hdrlen(skb);
> > +		} else {
> > +			hdr_len = skb_transport_offset(skb);
> > +
> > +			if (hdr->gso_type == VIRTIO_NET_HDR_GSO_UDP_L4)
> > +				hdr_len += sizeof(struct udphdr);
> > +			else
> > +				hdr_len += tcp_hdrlen(skb);
> > +		}
>
> I already mentioned the following a couple of times, with no replies...
> perhaps the 3rd attempt will be more successful.
>
> I think it's a bad adding tunnel specific check here. It sounds like
> layering violation. Instead you could have tunnel-specific variant, say
> virtio_net_set_tnl_hdrlen(), and use it in virtio_net_hdr_tnl_from_skb().
>
> Or you could try what i suggested in:
>
> https://lore.kernel.org/netdev/CAF6piCLkv6kFqoq7OQfJ=Su9AVHSQ9J7DzaumOSf5xuf9w-kyA@mail.gmail.com/#t

I saw your suggestions, though I didn't reply directly. I proceeded to adjust
the code based on my understanding of your feedback, but it appears my
understanding was incorrect. After re-reading your suggestions, I think
virtio_net_hdr_from_skb does not need to be changed. Instead, within
virtio_net_hdr_tnl_from_skb, we should directly call the device header length
function based on whether the feature is negotiated.

Thanks.

>
> Thanks,
>
> Paolo
>

