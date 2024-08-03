Return-Path: <netdev+bounces-115504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7EE946B10
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 21:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E07F11F213E2
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 19:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0CB12E55;
	Sat,  3 Aug 2024 19:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSciiJVS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA82C200AE
	for <netdev@vger.kernel.org>; Sat,  3 Aug 2024 19:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722713414; cv=none; b=bNFCzYa8RJn9D1i5dfIXMFas+b6/MOZ9Qq6JmBAFSlgyh0hl2hbP86bL/5n2znB6sf2PSmITsTcPBDLSJQWccDVfmTJSyEoN6kOYwdN6f73hqn8Tqu5CB15gufJHKe+h2wzFHJ7zNIhcKxodFNpsNvpPK4h1hZKCaFuQGoktNOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722713414; c=relaxed/simple;
	bh=2h0etsuqHlXda7dulQ/ofpcKghPKIbR8+Ql/+j2utfg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Dwgii+011+9KUgnrTcfKlwc+qKOPmDgCadi8Wr/+Bq3nY9eiPfkGWRAiy3mJ8Bqk7cSvXtLqwrRWtS/Ve3B6gNavZYrQjvSoDPPpqsaAI7RaInFn0DzPrvGbOucitI7SYGPSymKQy/sWGL3eimD9Idrjq76H5XXC27GMIJkFKL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mSciiJVS; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-49299323d71so2818644137.1
        for <netdev@vger.kernel.org>; Sat, 03 Aug 2024 12:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722713411; x=1723318211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IiHY1vPTLJDj4xiMP2KIAcVtCTc7U7AuA9petNwdiTU=;
        b=mSciiJVSAatuW1sEcvPcnLaj7G/KT6gZR+MBqc/y8uGD8FxuoIbsC1R1VfvribeK8a
         auSm/7QIiaiX4vne28aP0M9h4K0QQbZhS+w3rAa3oJZv+Q685eWawjKInwoDqwXnAxVk
         WUEctHgJfuUU7EfO+QUeDwaw3aRN6tc/cCHAY3gWVlpLwK3o8GwY7l9fa99hCelYTbiA
         NCTVEmi42zdP5AzbSMizVIZb1LXrFdFbDJsmksBpytFx9gDSuF+B66RWQF5LMcd00ddq
         Yi0T78q1jGOWu3htiqeHbLYXxnHdzmTd6X9A0X2R8xxe/CnpUfdeyhqX64henxbZn9k9
         bgsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722713411; x=1723318211;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IiHY1vPTLJDj4xiMP2KIAcVtCTc7U7AuA9petNwdiTU=;
        b=WY6Tl8yiCnR2jzwhbMpsSrWMp3D4wUbaXOjdUovyNqq112nfLRIufV6HjTEG3jTbJ3
         XWBSv5fe4uHJD203y+iF30TZXnRUNK3Hc7tfdFKaJoAzRlNT/DbqnFRJMG3x10yKHx7o
         Ik67uynD7HYZDssFEuqhJ4n8X2vTI5twtglWViYQUK55pl9TJF1PiqKf2ffd+q9/k8Z8
         tkN9VYmqO25PgeMTnhj4us600Sx/0dO6lPjpZPUr2kf6oJqzSIEFL5R9otUDl+lTumRv
         RlEJBM+u3pLCKin+tT4H1rJOVDnactJNXoVwg3Maa4X5za62a/DjDqHMKF9Tuwl25QSg
         icSg==
X-Forwarded-Encrypted: i=1; AJvYcCVGsGahQ2DUfE8ON47rA2Psh0hwN9cVrvv4HyAWHgNfzLPzNPmHEV86IMD+Gi+shg+iSPdKk0maIbvDW7uLaDLl428v4NM/
X-Gm-Message-State: AOJu0YzRjH8rV4tvvlAfZfemmHXoa6ay8gb8VuOBfOECFNyi2zkgXEtK
	/4CYP2DndasLtV6xSt1GoNN8WJ0aXdDb4+dT/O+BWOnYtnpNP0Sd
X-Google-Smtp-Source: AGHT+IEfvsZiRaBijQ3BPJL9wLFHyYat8xHNjcPcvuh38CNlY56YAaIaqdr8wVRq1lzh0i9x7iEUyw==
X-Received: by 2002:a05:6102:6d1:b0:493:e713:c0ff with SMTP id ada2fe7eead31-4945bdd07dfmr9724809137.4.1722713411347;
        Sat, 03 Aug 2024 12:30:11 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c83c6eesm19039996d6.94.2024.08.03.12.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Aug 2024 12:30:10 -0700 (PDT)
Date: Sat, 03 Aug 2024 15:30:10 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Tom Herbert <tom@herbertland.com>, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 netdev@vger.kernel.org, 
 felipe@sipanda.io
Cc: Tom Herbert <tom@herbertland.com>
Message-ID: <66ae85424c858_2a823d29427@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240731172332.683815-13-tom@herbertland.com>
References: <20240731172332.683815-1-tom@herbertland.com>
 <20240731172332.683815-13-tom@herbertland.com>
Subject: Re: [PATCH 12/12] flow_dissector: Parse gtp in UDP
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Tom Herbert wrote:
> Parse both version 0 and 1. Call __skb_direct_ip_dissect to determine
> IP version of the encapsulated packet
> 
> Signed-off-by: Tom Herbert <tom@herbertland.com>
> ---
>  net/core/flow_dissector.c | 87 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 87 insertions(+)
> 
> diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
> index 7f0bf737c3db..af197ed560b8 100644
> --- a/net/core/flow_dissector.c
> +++ b/net/core/flow_dissector.c
> @@ -9,6 +9,7 @@
>  #include <net/dsa.h>
>  #include <net/dst_metadata.h>
>  #include <net/fou.h>
> +#include <net/gtp.h>
>  #include <net/ip.h>
>  #include <net/ipv6.h>
>  #include <net/geneve.h>
> @@ -35,6 +36,7 @@
>  #include <net/pkt_cls.h>
>  #include <scsi/fc/fc_fcoe.h>
>  #include <uapi/linux/batadv_packet.h>
> +#include <uapi/linux/gtp.h>
>  #include <linux/bpf.h>
>  #if IS_ENABLED(CONFIG_NF_CONNTRACK)
>  #include <net/netfilter/nf_conntrack_core.h>
> @@ -887,6 +889,81 @@ __skb_flow_dissect_gue(const struct sk_buff *skb,
>  	return FLOW_DISSECT_RET_IPPROTO_AGAIN;
>  }
>  
> +static enum flow_dissect_ret
> +__skb_flow_dissect_gtp0(const struct sk_buff *skb,
> +			struct flow_dissector *flow_dissector,
> +			void *target_container, const void *data,
> +			__u8 *p_ip_proto, int *p_nhoff, int hlen,
> +			unsigned int flags)
> +{
> +	__u8 *ip_version, _ip_version, proto;
> +	struct gtp0_header *hdr, _hdr;
> +
> +	hdr = __skb_header_pointer(skb, *p_nhoff, sizeof(_hdr), data, hlen,
> +				   &_hdr);
> +	if (!hdr)
> +		return FLOW_DISSECT_RET_OUT_BAD;
> +
> +	if ((hdr->flags >> 5) != GTP_V0)
> +		return FLOW_DISSECT_RET_OUT_GOOD;
> +
> +	ip_version = skb_header_pointer(skb, *p_nhoff + sizeof(_hdr),
> +					sizeof(*ip_version),
> +					&_ip_version);
> +	if (!ip_version)
> +		return FLOW_DISSECT_RET_OUT_BAD;
> +
> +	proto = __skb_direct_ip_dissect(ip_version);
> +	if (!proto)
> +		return FLOW_DISSECT_RET_OUT_GOOD;
> +
> +	*p_ip_proto = proto;
> +	*p_nhoff += sizeof(struct gtp0_header);
> +
> +	return FLOW_DISSECT_RET_IPPROTO_AGAIN;
> +}
> +
> +static enum flow_dissect_ret
> +__skb_flow_dissect_gtp1u(const struct sk_buff *skb,
> +			 struct flow_dissector *flow_dissector,
> +			 void *target_container, const void *data,
> +			 __u8 *p_ip_proto, int *p_nhoff, int hlen,
> +			 unsigned int flags)
> +{
> +	__u8 *ip_version, _ip_version, proto;
> +	struct gtp1_header *hdr, _hdr;
> +	int hdrlen = sizeof(_hdr);
> +
> +	hdr = __skb_header_pointer(skb, *p_nhoff, sizeof(_hdr), data, hlen,
> +				   &_hdr);
> +	if (!hdr)
> +		return FLOW_DISSECT_RET_OUT_BAD;
> +
> +	if ((hdr->flags >> 5) != GTP_V1)
> +		return FLOW_DISSECT_RET_OUT_GOOD;
> +
> +	if (hdr->type != GTP_TPDU)
> +		return FLOW_DISSECT_RET_OUT_GOOD;
> +
> +	if (hdr->flags & GTP1_F_MASK)
> +		hdrlen += 4;
> +

The only difference with +__skb_flow_dissect_gtp0 is these two
branches. Can probably deduplicate.

Also, escape early if any of the other optional field bits are set?

  #define GTP1_F_NPDU     0x01
  #define GTP1_F_SEQ      0x02
  #define GTP1_F_EXTHDR   0x04


