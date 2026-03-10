Return-Path: <netdev+bounces-265969-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDFdHgPtr2nkdAIAu9opvQ
	(envelope-from <netdev+bounces-265969-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 11:05:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1213E2490E4
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 11:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1B5423016EFB
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 10:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FEC340A6A;
	Tue, 10 Mar 2026 10:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PKX/Desk";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pLiGIETs"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DF81F0991
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 10:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773137152; cv=none; b=s/MFWlV1DdDPlQ7jEO7uK4k5AKzD3asA4HjitFvrKnjcyw/V/0fmkiSgjPIGnhNPE7UuWxSGqLeexJNHc0eoTwxq/yhAuwNy4mKNySV6EIr2ya//jrQHhYbzzjN0FNi4GW+jjyPFnsQ+b/3JnCkgmSAzr6/fgLekOAgMACX6CBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773137152; c=relaxed/simple;
	bh=ZVDPlz5F6+j8JfdfnlCeg2sGkIXu+w9bb1JGF7xr/bY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WX7MumLK4BSZXfIGBFhjc+8y2DnbPXSiDsDhwB5Nl3an8F7inZRrQkf/zjnEEHis7ko/tzhRel+fvHOSPtQCjIr0M6wPVvMTKeG56n6zwr9dMThv7yJ/b0jc9LwjpLq445NJ4g3xfsP524hhvAJ0/nFafvV84uehfHAVPsGk5QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PKX/Desk; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pLiGIETs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773137148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=caLp6CkyccqcspSiLN9NhR+0Z+lORpoggQJiA3V+ZYU=;
	b=PKX/Desk8R/C0Q00BfAj9Rcykuta+JalFb3yfsvM938uw6B0edMan2UrLfK51/VSYPGOpW
	3AJ8VCBZrwUKNsOx5kWUvb22ZIkI3GbG5AMTFrzxjUspTTBA1w0YVCsS7pvdmESgNDCQDg
	DYuvWY4QLLpdZkeWcEHbYUHwbGwRt5c=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-jLUty0q8NQC4ztj9QnKGxw-1; Tue, 10 Mar 2026 06:05:41 -0400
X-MC-Unique: jLUty0q8NQC4ztj9QnKGxw-1
X-Mimecast-MFC-AGG-ID: jLUty0q8NQC4ztj9QnKGxw_1773137137
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-485389bf0daso14549425e9.0
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 03:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773137136; x=1773741936; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=caLp6CkyccqcspSiLN9NhR+0Z+lORpoggQJiA3V+ZYU=;
        b=pLiGIETswh3cDCMKCkm7A6x7bcfkPeCL+Vlve2sQC7odR8aXuNODGhaFsJscvgbzER
         H5zF+V2L3JSwd74WLtxrtxBcFyhmE4nsvGWx8Yvu43hpgFSGxSDtmp3R2vb6wEv7ED95
         n/i4lqefPzRKERCH3ILviWo/Qv3NORltmHGBFEpa4mdOMq6J0Ryqdk0bMcI3Fap9d0Ti
         xs7KPMDPoyfBL+kfzqeOOc6vZRPCmlEPUtPxX4FxXAVvli+0alL7Klg7c0T148xZTpzP
         icfM3LlvZEoVoY5gF9YF48AcFqa2lc9qSm5/sO/9XkI5v35ocZG0Na9jgY+xAODDfcHe
         iKeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773137136; x=1773741936;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=caLp6CkyccqcspSiLN9NhR+0Z+lORpoggQJiA3V+ZYU=;
        b=JTIyg64Lw1uhwkyxC0ZiK9WBj8VOKcacPDpi0zoeT1Cqf2AbSQH8RONxfeqQ7uNlOF
         kB4GpMt8iiL36hT61+HKdKmFws2CFfGr92Qk5AxbpslK7zJEwTdYnr8OiCq4DheidBo5
         9Rn1Bmep9O5oYny2AI5vqwV3kt8eNkQloyjGoHY1is8guzYg2TPST7sHoSe9mYWjCeWx
         v2crCUayHPu2ScZ+EgFT71S3yX92effp02CPc224tDcTj54cNWJIAUmhahAuT8EutjfE
         a/6Junl8lHqHmUXU1Kt+8CT3iHRlGjrHOwoY15HPIzhO6SIEejuOnnGrxZCZpHK4Hn0u
         VAbA==
X-Forwarded-Encrypted: i=1; AJvYcCVNYjoTsvWa2EcqvougwKN5ThT4ckicD4FetfgakjghU5HeptoS3U+QRjhucnFlg0AwYLcC35o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsT0ieUspRDG75nfo+myXDyoF8OGPBH28nZ7giIsn1vQnUXBoF
	Ce8Nhr2pAqqot2PR3KilKxGZz/lL0atedy8VndPENEEFKSkOZzTGbGPEqL/WM541DB8TskaHdl5
	BoDbm9kI30ulH9ySovPlNLkJw//4e2+HOTkdzO2b3+feMAINFThatqRrMrg==
X-Gm-Gg: ATEYQzwWs/3loP4/M3UwvJM1LIB4iTofjhGHvSrdyPXtlnRLhjf5plXPN70fEeELmS7
	MH7SPlWNRtn5u7pvcLvxQsPgncWyZ8vAupz/heLDjEwKxEvnmM3fp+fyJW/jRdsx+ZpxHmg+rcu
	8+OKu1ontt8YitAZl0v5j1XiegrSg6zWxceDbKeNyZgBkt4/SYX0/jj7Y1DM5eoIALEaz77WEvS
	pnffR2n+o+1Guh4C4/VsQaF/shexEt0PjSAFMxNpjyflUeUdUSMNqLqEYJPrZAyMuYzDTF6kKnE
	z1wcpPUSoWRgfnerjT1anCVew/3vR5hhrrohsfLODXvK9zIzORPwUjpBzG5Q8lTP6JTshEjbbCm
	Anrbk4lLNnep+LwFryIBUFK+M6Tgo/unPMdyPVkbgkKYX9niFe5EK1ixW
X-Received: by 2002:a05:600c:8707:b0:485:3ff1:d5c3 with SMTP id 5b1f17b1804b1-4853ff1d6a6mr93411635e9.5.1773137136137;
        Tue, 10 Mar 2026 03:05:36 -0700 (PDT)
X-Received: by 2002:a05:600c:8707:b0:485:3ff1:d5c3 with SMTP id 5b1f17b1804b1-4853ff1d6a6mr93410985e9.5.1773137135513;
        Tue, 10 Mar 2026 03:05:35 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.224])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4853149caffsm96041305e9.1.2026.03.10.03.05.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 03:05:35 -0700 (PDT)
Message-ID: <cf62a942-e1e8-4b37-837a-b0bd76297656@redhat.com>
Date: Tue, 10 Mar 2026 11:05:33 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v8 2/2] virtio-net: correct hdr_len handling for
 tunnel gso
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, Alvaro Karsz <alvaro.karsz@solid-run.com>,
 virtualization@lists.linux.dev
References: <20260305031938.24518-1-xuanzhuo@linux.alibaba.com>
 <20260305031938.24518-3-xuanzhuo@linux.alibaba.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260305031938.24518-3-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 1213E2490E4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,lunn.ch,davemloft.net,google.com,kernel.org,resnulli.us,solid-run.com,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-265969-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 3/5/26 4:19 AM, Xuan Zhuo wrote:
> The commit a2fb4bc4e2a6a03 ("net: implement virtio helpers to handle UDP
> GSO tunneling.") introduces support for the UDP GSO tunnel feature in
> virtio-net.
> 
> The virtio spec says:
> 
>     If the \field{gso_type} has the VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV4 bit or
>     VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV6 bit set, \field{hdr_len} accounts for
>     all the headers up to and including the inner transport.
> 
> The commit did not update the hdr_len to include the inner transport.
> 
> I observed that the "hdr_len" is 116 for this packet:
> 
>     17:36:18.241105 52:55:00:d1:27:0a > 2e:2c:df:46:a9:e1, ethertype IPv4 (0x0800), length 2912: (tos 0x0, ttl 64, id 45197, offset 0, flags [none], proto UDP (17), length 2898)
>         192.168.122.100.50613 > 192.168.122.1.4789: [bad udp cksum 0x8106 -> 0x26a0!] VXLAN, flags [I] (0x08), vni 1
>     fa:c3:ba:82:05:ee > ce:85:0c:31:77:e5, ethertype IPv4 (0x0800), length 2862: (tos 0x0, ttl 64, id 14678, offset 0, flags [DF], proto TCP (6), length 2848)
>         192.168.3.1.49880 > 192.168.3.2.9898: Flags [P.], cksum 0x9266 (incorrect -> 0xaa20), seq 515667:518463, ack 1, win 64, options [nop,nop,TS val 2990048824 ecr 2798801412], length 2796
> 
> 116 = 14(mac) + 20(ip) + 8(udp) + 8(vxlan) + 14(inner mac) + 20(inner ip) + 32(innner tcp)
> 
> Fixes: a2fb4bc4e2a6a03 ("net: implement virtio helpers to handle UDP GSO tunneling.")
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  include/linux/virtio_net.h | 31 ++++++++++++++++++++-----------
>  1 file changed, 20 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 23f42bb8ece0..906157779955 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -209,18 +209,29 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
>  
>  static inline void virtio_net_set_hdrlen(const struct sk_buff *skb,
>  					 struct virtio_net_hdr *hdr,
> +					 struct skb_shared_info *sinfo,
>  					 bool little_endian,
>  					 bool feature_hdrlen)
>  {
>  	u16 hdr_len;
>  
>  	if (feature_hdrlen) {
> -		hdr_len = skb_transport_offset(skb);
> -
> -		if (hdr->gso_type == VIRTIO_NET_HDR_GSO_UDP_L4)
> -			hdr_len += sizeof(struct udphdr);
> -		else
> -			hdr_len += tcp_hdrlen(skb);
> +		if (sinfo->gso_type & (SKB_GSO_UDP_TUNNEL |
> +				       SKB_GSO_UDP_TUNNEL_CSUM)) {
> +			hdr_len = skb_inner_transport_offset(skb);
> +
> +			if (hdr->gso_type == VIRTIO_NET_HDR_GSO_UDP_L4)
> +				hdr_len += sizeof(struct udphdr);
> +			else
> +				hdr_len += inner_tcp_hdrlen(skb);
> +		} else {
> +			hdr_len = skb_transport_offset(skb);
> +
> +			if (hdr->gso_type == VIRTIO_NET_HDR_GSO_UDP_L4)
> +				hdr_len += sizeof(struct udphdr);
> +			else
> +				hdr_len += tcp_hdrlen(skb);
> +		}

I already mentioned the following a couple of times, with no replies...
perhaps the 3rd attempt will be more successful.

I think it's a bad adding tunnel specific check here. It sounds like
layering violation. Instead you could have tunnel-specific variant, say
virtio_net_set_tnl_hdrlen(), and use it in virtio_net_hdr_tnl_from_skb().

Or you could try what i suggested in:

https://lore.kernel.org/netdev/CAF6piCLkv6kFqoq7OQfJ=Su9AVHSQ9J7DzaumOSf5xuf9w-kyA@mail.gmail.com/#t

Thanks,

Paolo


