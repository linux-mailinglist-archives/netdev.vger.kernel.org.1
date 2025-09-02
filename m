Return-Path: <netdev+bounces-219261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6D0B40D22
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 20:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE8DA3A520E
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 18:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B1A345723;
	Tue,  2 Sep 2025 18:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJ8O9yw6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7553FEEC0;
	Tue,  2 Sep 2025 18:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756837656; cv=none; b=gw39dipvoYEiGVCYFC2whiXkTbgLxdv3rlHauXnim8TJ8SspcEoN/H70E9quE4kL8zjppnlxgerpCuj/t8JlLGQfUdThfGeCDreF7sOQi6nNwn6LU3lNdQaLMOEE75NDwvsKTgujiFA/oW8mC3fUiVCRuwo642dcMZMc+jWTGAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756837656; c=relaxed/simple;
	bh=RniY1QhIS4rNF30XPcvMt38M97cZcDxO5A6QYGetGSA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ETIRnZgEmN+dvNlSPOs/0j/WgekO87cdCu7LhA2kCvISmkaPUuMc3iYgnN5y7R4RnDRfaIMydD09DG49hBkYCdoxDRj5lHBn/khdwk/8p+23TiUUctJAL+9eaICMI8e/i3PNbX7+VbhmAf5cN5uanwSrkQbIApjFDdobQke4i6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XJ8O9yw6; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b109c6b9fcso53972611cf.3;
        Tue, 02 Sep 2025 11:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756837653; x=1757442453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Crk8jlByEd51IcbbnWMmtW33dK705jGYGpNQa1TEeWI=;
        b=XJ8O9yw6iA1lTG59ICICAkNsMftlORV5YzMZySWa6oEf81Of8xBfN95Q3XNOvwK5jR
         UucnHEFGyByW4CjGj4hgPopBA9+QGcRvhDBupRKPMHiyiwbs8SXcHAm/6Kh777n3qsVy
         wLFfi6PgG7isx2Gi7JnSzcEhxiOEOygC/gx9nD89DRy5nLhNX4AlATtwblUTSXWrm5mq
         MgpWoGdk7Ja1YG0uknCqs9VRVE+BcuzcZpyyrSuReb/xqxVcdOmz0FtfnKpqz03teQIY
         fjLbDPAFRURTvdvpHBg4tDBGuqhD385QKx0qkynOKK5+xcSxzCFZpTib7AiC19XPHKEj
         lsKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756837653; x=1757442453;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Crk8jlByEd51IcbbnWMmtW33dK705jGYGpNQa1TEeWI=;
        b=j+ISJbtC9dQ10CUvPdpANQDyXaCCvmNXd3yQMPRROcJVHls4R/Tmuvrz35FsZOHiah
         SkeFVulz5BV4EqP6V7o0agxSJy+dzEnpGT12n+By79nerO0WGRHz6k6TsOPtcujuB08m
         WL+s8WWKTPvjQ4fbNcRktOwK3xtpLUkeBHoj3POTqwFMpNShHYNufMDMgvwjRtqQgx5/
         HLMCCf7es9R30Ugfdv00ds8wTmDPB9vm/1M3Gacp46uuijCO01aQM4nav+DrIH9+ow+f
         sp7bUl27XsmwBFZk6AHuv81Rk5bupLmG1CGLeyz3RJRVCCryXk/l71lPLH1/U8X+GRwd
         o4kA==
X-Forwarded-Encrypted: i=1; AJvYcCUmSA/pDocQk2FMXiJn4l/qzk1/rAorhXACO9BXX10VWla22XPS9ysuzNSwHxbAUc7bzHgAlhGCoFlOTTU=@vger.kernel.org, AJvYcCWrCIQqKdpU5WsMyJSgpKwA/6b5HA/ckt+LaqvfaHtn5e/9pJqqj10gpw+sW+frzYRpW0fgeIvA@vger.kernel.org
X-Gm-Message-State: AOJu0Yx64tx86cmUL22UqXoh4ztrAC8ZdcdE6D3Oe5XWq4uoGNq9/zmL
	41YrxpGeYE/GUpkyOBXEUXV//WNwakU8h8jtbleetQpyGGn9NbqC3eCfIJw8Xw==
X-Gm-Gg: ASbGncsCpv+dORJGDbO7POYjBhR3HlakxL9IqaTmuQ8lH/DiaLynwONOTSuvIizdpTg
	ZJajDzgAXAWBrJ/kYqq/4f+YPG8yKUc3q9YEQ0o4aqFLes8gaAQS03/4O9xCnIhzCR03Bz11bHo
	W9Rs5sO+83PruninD80rR9in+2ohQHSKaDyL63CfxEX2NuD8ZWbLtk3OOLU/Cft3Ey0IWJGpSSq
	9hxetYmmPQs25rPbIhY+Z6qqmEbHCchTX+UvDhPcjPbBlPhDDqkA5WoSPaAnrNgLXWQVvhag2Jf
	KXQ7WtlgBsaEjHx+5+Eucinf503QuOF1t7I4ejE7s7UiXgjrAWnmlz2LJyAEep24tcU2nKUKBMS
	ykoNydzrXsiJA3ANLkJuzbJls5ItousDxi0jVuy3toofVatvY1kFEC9HtiV7IX42sQmFQTv0gsj
	N+KH60HUQX9by+
X-Google-Smtp-Source: AGHT+IFMN0bHW8vOo7hHPM7ykqRYyWsKBTHUvKwl0w5Q/ZyXL2LJ0Pg0ukUOuysIU0oaC69/+tIvMA==
X-Received: by 2002:a05:622a:394:b0:4b2:9b56:84c5 with SMTP id d75a77b69052e-4b31d9e45a9mr148117541cf.26.1756837653272;
        Tue, 02 Sep 2025 11:27:33 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-720b6c07573sm15904706d6.71.2025.09.02.11.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 11:27:32 -0700 (PDT)
Date: Tue, 02 Sep 2025 14:27:32 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Richard Gobert <richardbgobert@gmail.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 corbet@lwn.net, 
 saeedm@nvidia.com, 
 tariqt@nvidia.com, 
 mbloch@nvidia.com, 
 leon@kernel.org, 
 ecree.xilinx@gmail.com, 
 dsahern@kernel.org, 
 ncardwell@google.com, 
 kuniyu@google.com, 
 shuah@kernel.org, 
 sdf@fomichev.me, 
 aleksander.lobakin@intel.com, 
 florian.fainelli@broadcom.com, 
 willemdebruijn.kernel@gmail.com, 
 alexander.duyck@gmail.com, 
 linux-kernel@vger.kernel.org, 
 linux-net-drivers@amd.com, 
 Richard Gobert <richardbgobert@gmail.com>
Message-ID: <willemdebruijn.kernel.868af9542505@gmail.com>
In-Reply-To: <20250901113826.6508-5-richardbgobert@gmail.com>
References: <20250901113826.6508-1-richardbgobert@gmail.com>
 <20250901113826.6508-5-richardbgobert@gmail.com>
Subject: Re: [PATCH net-next v4 4/5] net: gro: remove unnecessary df checks
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Richard Gobert wrote:
> Currently, packets with fixed IDs will be merged only if their
> don't-fragment bit is set. Merged packets are re-split into segments
> before being fragmented, so the result is the same as if the packets
> weren't merged to begin with.

This can perhaps be reworded a bit for clarity. Something like "With
the changes in the earlier patches in this series, the ID state (fixed
or incrementing) is now recorded for both inner and outer IPv4 headers,
so the restriction to only coalesce packets with fixed IDs can now be
lifted."
> 
> Remove unnecessary don't-fragment checks.
> 
> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
> ---
>  include/net/gro.h                 | 5 ++---
>  net/ipv4/af_inet.c                | 3 ---
>  tools/testing/selftests/net/gro.c | 9 ++++-----
>  3 files changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/include/net/gro.h b/include/net/gro.h
> index 322c5517f508..691f267b3969 100644
> --- a/include/net/gro.h
> +++ b/include/net/gro.h
> @@ -448,17 +448,16 @@ static inline int inet_gro_flush(const struct iphdr *iph, const struct iphdr *ip
>  	const u32 id2 = ntohl(*(__be32 *)&iph2->id);
>  	const u16 ipid_offset = (id >> 16) - (id2 >> 16);
>  	const u16 count = NAPI_GRO_CB(p)->count;
> -	const u32 df = id & IP_DF;
>  
>  	/* All fields must match except length and checksum. */
> -	if ((iph->ttl ^ iph2->ttl) | (iph->tos ^ iph2->tos) | (df ^ (id2 & IP_DF)))
> +	if ((iph->ttl ^ iph2->ttl) | (iph->tos ^ iph2->tos) | ((id ^ id2) & IP_DF))
>  		return true;

This is just a cleanup?

If so, please make a brief note in the commit message. I end up
staring whether there is some deeper meaning relevant to the
functional change.

>  
>  	/* When we receive our second frame we can make a decision on if we
>  	 * continue this flow as an atomic flow with a fixed ID or if we use
>  	 * an incrementing ID.
>  	 */
> -	if (count == 1 && df && !ipid_offset)
> +	if (count == 1 && !ipid_offset)
>  		NAPI_GRO_CB(p)->ip_fixedid |= 1 << inner;
>  
>  	return ipid_offset ^ (count * !(NAPI_GRO_CB(p)->ip_fixedid & (1 << inner)));
> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> index fc7a6955fa0a..c0542d9187e2 100644
> --- a/net/ipv4/af_inet.c
> +++ b/net/ipv4/af_inet.c
> @@ -1393,10 +1393,7 @@ struct sk_buff *inet_gso_segment(struct sk_buff *skb,
>  
>  	segs = ERR_PTR(-EPROTONOSUPPORT);
>  
> -	/* fixed ID is invalid if DF bit is not set */
>  	fixedid = !!(skb_shinfo(skb)->gso_type & (SKB_GSO_TCP_FIXEDID << encap));
> -	if (fixedid && !(ip_hdr(skb)->frag_off & htons(IP_DF)))
> -		goto out;

I understand why the GRO constraint can now be relaxed. But why does
this also affect GSO?

Fixed ID is invalid on the wire if DF is not set. Is the idea behind
this change that GRO + GSO is just forwarding existing packets. Even
if the incoming packets were invalid on this point?

>  
>  	if (!skb->encapsulation || encap)
>  		udpfrag = !!(skb_shinfo(skb)->gso_type & SKB_GSO_UDP);
> diff --git a/tools/testing/selftests/net/gro.c b/tools/testing/selftests/net/gro.c
> index d5824eadea10..3d4a82a2607c 100644
> --- a/tools/testing/selftests/net/gro.c
> +++ b/tools/testing/selftests/net/gro.c
> @@ -670,7 +670,7 @@ static void send_flush_id_case(int fd, struct sockaddr_ll *daddr, int tcase)
>  		iph2->id = htons(9);
>  		break;
>  
> -	case 3: /* DF=0, Fixed - should not coalesce */
> +	case 3: /* DF=0, Fixed - should coalesce */
>  		iph1->frag_off &= ~htons(IP_DF);
>  		iph1->id = htons(8);
>  
> @@ -1188,10 +1188,9 @@ static void gro_receiver(void)
>  			correct_payload[0] = PAYLOAD_LEN * 2;
>  			check_recv_pkts(rxfd, correct_payload, 1);
>  
> -			printf("DF=0, Fixed - should not coalesce: ");
> -			correct_payload[0] = PAYLOAD_LEN;
> -			correct_payload[1] = PAYLOAD_LEN;
> -			check_recv_pkts(rxfd, correct_payload, 2);
> +			printf("DF=0, Fixed - should coalesce: ");
> +			correct_payload[0] = PAYLOAD_LEN * 2;
> +			check_recv_pkts(rxfd, correct_payload, 1);
>  
>  			printf("DF=1, 2 Incrementing and one fixed - should coalesce only first 2 packets: ");
>  			correct_payload[0] = PAYLOAD_LEN * 2;
> -- 
> 2.36.1
> 



