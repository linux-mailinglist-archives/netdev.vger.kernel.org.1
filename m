Return-Path: <netdev+bounces-95324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 472B78C1E09
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 08:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 669DF1C20873
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 06:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596291527A0;
	Fri, 10 May 2024 06:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZA/aZvsW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDEE13A86D
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 06:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715322333; cv=none; b=iH/ZG2CLGWc59LE3n19BkV7ByScLa4KvSrOyGYfm/IedBd/OKg5l9U3GcAouaC49KC/Opx6JLBLK0kg6BQzkk5UxxDIvxXBGmZ4zQUAzPregI/bzpoTqwCMvO22z/AffaYZqqwr5CsEDEUqxlIo/xo3LTSKOwCEbWzNTejpZPYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715322333; c=relaxed/simple;
	bh=p0NRJPhcoFWHgBvTdTZyPt4A1HB4xQ+Q8YtpJD+CbzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lWNFIvyYHKLKi/K14VFI4gfS6V6IQks8OFcFz4+H+dacVdl68IeeyezbEii37rK69g/X5CU3oJFKT+tFnWrdEZsgpRPBKawqOZhvo1/OVXMs+znqSoAqzFfLgmxSCCAFRhqXcDfJAo3f8Il7bTXd7k0k2WC7cf5nVHcQSlTc0jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZA/aZvsW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715322330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GHgrKMZJMRwygDDtmV6g8fUqPzYJOIm+nsZVqZObz4k=;
	b=ZA/aZvsWTYYndyqmQfgxCkqyZu2eLOzcjn03UUclhSnNgYoSECzXIJpf9rdk1eW+ArASDI
	WB90oKesfv+z6ekUmFPM8JZf+2lE//SKgncwfbmO/qgE67uENCCaMziDyDynPk3TXuJoBx
	3DXaJydhAL25S9jq+wZdmXFTBvmphv8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-CH9qNR1xPoausOlhO4MYhA-1; Fri, 10 May 2024 02:25:28 -0400
X-MC-Unique: CH9qNR1xPoausOlhO4MYhA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a59a0d2280cso126394866b.1
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 23:25:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715322327; x=1715927127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GHgrKMZJMRwygDDtmV6g8fUqPzYJOIm+nsZVqZObz4k=;
        b=oFb41POSvnhPG7H0JWv3bFBJZYeIDRf9yWqhmzUAeN9gZ8BXY458cUGXilN6tqKpQN
         Pjjcrl7JyguiNuxbf4NnvzilPvnrnBreFkdPveC8f++y2ie/mDFuUC2tlPwfY6cidNza
         dfQ8rjbrYPRsZOtDT9Dpo6RgWJk+n+ertWhC0rd+aQkS8necLyvPY8ElBUB7iTTIpSwB
         mJ9NBrEC7j16NSP/VvfpLA/NNc6xWsNeD9+aP2sxylukcdqlTrMON0iAchR7HXYpruPM
         AONGVcU5A/Jfz6Y4cjnHb4HVZ7mYLIjon1px83cwfRRFbKqjXOvWjCsMQYGY5wb/92Ip
         qghA==
X-Gm-Message-State: AOJu0YyeJsCg0C+JUJ3pklpWtKP0ZX25/NhdeZ/ImkKy7F2cV0kQ8pPJ
	pbu3LGDkRVIK4ZXsYttUTkCj/28u6tmHTksoZ7Fcb1G0WHNPRaDy97rF+S6N2sfcIwLQPeSh9bg
	E3vHPxvXfozRxbo+IgE8MmKMu8WtXo1MfAds8Gvc7TDZgAnxhM+wouMQXSuabTw==
X-Received: by 2002:a17:906:ecb4:b0:a59:a7b7:2b8f with SMTP id a640c23a62f3a-a5a2d54c68bmr108844266b.9.1715322326895;
        Thu, 09 May 2024 23:25:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEj6J2YPmDM5j+YZTmExKVoSBFRbr1zcqMvmS5VCfBlN4G58bHtGF73RCSRm31LKwAixyOgPw==
X-Received: by 2002:a17:906:ecb4:b0:a59:a7b7:2b8f with SMTP id a640c23a62f3a-a5a2d54c68bmr108842866b.9.1715322326490;
        Thu, 09 May 2024 23:25:26 -0700 (PDT)
Received: from [172.16.2.75] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c7c59sm150686166b.137.2024.05.09.23.25.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2024 23:25:25 -0700 (PDT)
From: Eelco Chaudron <echaudro@redhat.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, dev@openvswitch.org,
 Antonin Bas <antonin.bas@broadcom.com>, linux-kernel@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Subject: Re: [ovs-dev] [PATCH net] net: openvswitch: fix overwriting ct
 original tuple for ICMPv6
Date: Fri, 10 May 2024 08:25:24 +0200
X-Mailer: MailMate (1.14r6029)
Message-ID: <339289BC-47E8-4B7C-A7D2-F53A6BA54CD0@redhat.com>
In-Reply-To: <20240509094228.1035477-1-i.maximets@ovn.org>
References: <20240509094228.1035477-1-i.maximets@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable



On 9 May 2024, at 11:38, Ilya Maximets wrote:

> OVS_PACKET_CMD_EXECUTE has 3 main attributes:
>  - OVS_PACKET_ATTR_KEY - Packet metadata in a netlink format.
>  - OVS_PACKET_ATTR_PACKET - Binary packet content.
>  - OVS_PACKET_ATTR_ACTIONS - Actions to execute on the packet.
>
> OVS_PACKET_ATTR_KEY is parsed first to populate sw_flow_key structure
> with the metadata like conntrack state, input port, recirculation id,
> etc.  Then the packet itself gets parsed to populate the rest of the
> keys from the packet headers.
>
> Whenever the packet parsing code starts parsing the ICMPv6 header, it
> first zeroes out fields in the key corresponding to Neighbor Discovery
> information even if it is not an ND packet.
>
> It is an 'ipv6.nd' field.  However, the 'ipv6' is a union that shares
> the space between 'nd' and 'ct_orig' that holds the original tuple
> conntrack metadata parsed from the OVS_PACKET_ATTR_KEY.
>
> ND packets should not normally have conntrack state, so it's fine to
> share the space, but normal ICMPv6 Echo packets or maybe other types of=

> ICMPv6 can have the state attached and it should not be overwritten.
>
> The issue results in all but the last 4 bytes of the destination
> address being wiped from the original conntrack tuple leading to
> incorrect packet matching and potentially executing wrong actions
> in case this packet recirculates within the datapath or goes back
> to userspace.
>
> ND fields should not be accessed in non-ND packets, so not clearing
> them should be fine.  Executing memset() only for actual ND packets to
> avoid the issue.
>
> Initializing the whole thing before parsing is needed because ND packet=

> may not contain all the options.
>
> The issue only affects the OVS_PACKET_CMD_EXECUTE path and doesn't
> affect packets entering OVS datapath from network interfaces, because
> in this case CT metadata is populated from skb after the packet is
> already parsed.
>
> Fixes: 9dd7f8907c37 ("openvswitch: Add original direction conntrack tup=
le to sw_flow_key.")
> Reported-by: Antonin Bas <antonin.bas@broadcom.com>
> Closes: https://github.com/openvswitch/ovs-issues/issues/327
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>

This patch looks good to me.

Acked-by: Eelco Chaudron <echaudro@redhat.com>

> ---
>
> Note: I'm working on a selftest for this issue, but it requires some
> ground work first to add support for OVS_PACKET_CMD_EXECUTE into
> opnevswitch selftests as well as parsing of ct tuples.  So it is going
> to be a separate patch set.
>
>  net/openvswitch/flow.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/openvswitch/flow.c b/net/openvswitch/flow.c
> index 33b21a0c0548..8a848ce72e29 100644
> --- a/net/openvswitch/flow.c
> +++ b/net/openvswitch/flow.c
> @@ -561,7 +561,6 @@ static int parse_icmpv6(struct sk_buff *skb, struct=
 sw_flow_key *key,
>  	 */
>  	key->tp.src =3D htons(icmp->icmp6_type);
>  	key->tp.dst =3D htons(icmp->icmp6_code);
> -	memset(&key->ipv6.nd, 0, sizeof(key->ipv6.nd));
>
>  	if (icmp->icmp6_code =3D=3D 0 &&
>  	    (icmp->icmp6_type =3D=3D NDISC_NEIGHBOUR_SOLICITATION ||
> @@ -570,6 +569,8 @@ static int parse_icmpv6(struct sk_buff *skb, struct=
 sw_flow_key *key,
>  		struct nd_msg *nd;
>  		int offset;
>
> +		memset(&key->ipv6.nd, 0, sizeof(key->ipv6.nd));
> +
>  		/* In order to process neighbor discovery options, we need the
>  		 * entire packet.
>  		 */
> -- =

> 2.44.0
>
> _______________________________________________
> dev mailing list
> dev@openvswitch.org
> https://mail.openvswitch.org/mailman/listinfo/ovs-dev


