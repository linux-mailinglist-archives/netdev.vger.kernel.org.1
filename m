Return-Path: <netdev+bounces-115502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B8B946AF5
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 21:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5B932815CE
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 19:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800601B94F;
	Sat,  3 Aug 2024 19:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VtPSyMXg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53C31EA73
	for <netdev@vger.kernel.org>; Sat,  3 Aug 2024 19:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722712421; cv=none; b=nucx2ijulRDirLDI3W/t/H9ylIt7EHmlPdHNoAsxlaHOI6gczi1wHpLI3wOivf1BnBzJYaL79ZUxoOZam0Zf8ZEZ38Z4hC5RhXdHTwZhSh3oYatg5i5O1beT0IlaWn9OOVgMRdg9bCAR4Vg8DChPUctUvlEWn6RjlMQWpmSanlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722712421; c=relaxed/simple;
	bh=QXlxJWhvRrDDBwrUESBhj8IqWphytyIlxrIXmyY0cNE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=nzwPy/a6nsBV31isD9vY4KLg7CxdxSU1GpVI4SgBYByDL+6M+H+RDmJqDt0lq4PkpVOO+lAAvEzx0gX4+LS0/weZv7l2UrNGPhQiJ6i96/i2J85cc03qaTWLn7Xd0s3C+9AVjv484NABgKorwssFkMUEDSeeiaS4l6eOf+gmseA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VtPSyMXg; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6b7a3b75133so68724716d6.2
        for <netdev@vger.kernel.org>; Sat, 03 Aug 2024 12:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722712419; x=1723317219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CRq+Rxh63cTmOOtwGcEv7BrAoxCANJJrSxCebHkhlAw=;
        b=VtPSyMXgBHqjFjUIZbnnwuPYKZhL38DWW3AzCAkFYnVVdgGN9qMBlJ2HuvzSXlTzKq
         8/HHu9c3qWfy6n7lrtLjZENpGIeX4MSD6mPVNIxEe8LuZDzncosLjWZSrtPiyyc4Y8oB
         0FvqrOkn4RMp03j4/8q7HxOjjYWP+hHhUg8H3WuoHeE6K4bhlaAJpyFMyEt5qpY72yGe
         Ag2UzKyW8euShG5fANg0+uL0euPGLmXZp4LUExnhF/l8bBipuxvOBUd09d3abGavHO3e
         fYjHQZ+qUEG/Q98upksUfQuT1V0jHZ1WFDjjmD4gZgarhDOWUsPwYYmnHHRE7Zy2bds1
         IfCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722712419; x=1723317219;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CRq+Rxh63cTmOOtwGcEv7BrAoxCANJJrSxCebHkhlAw=;
        b=MraN6Jsr7nOyQTwAIF8tsJpX2scz8HY3zPz2vfQjEXkQJiQqv5CKWH6AKSfuW9R/3S
         SoAo+viIUE0nMFUj1r8zcqXmCUh5Shzwu0ijPWo7WocoMhJUDOspp8PI+MvD6C/fdJFk
         A/o4LTxoSgqrolPgsOPJ6qabzid5XwI4cWd/TJRSi0cAF8SH4nAG3M0Ux1DYLsT9sm/H
         7Nt5U5bkho28WBGb55R5m0ZPCdiBHk7plC9XsoCd+ksSZXKTNh41O8PNZdET4P1rCAUD
         IMWXIiK+ZVivbDpnnaEAlK8AbcJZvaFFmBIeEHVj3P/Awn2jGYrMzzhLiAlub0nF5N9i
         IHBA==
X-Forwarded-Encrypted: i=1; AJvYcCU5M9PsZ6napJeSZlDdQev8ayC0eyMiAM99GGjSpXi/1le8JRtt8hNXXGJET/WMfB/P/NebpOdGimenqH/G2hlXThjYuEAT
X-Gm-Message-State: AOJu0YxX2B1tEp8n21UoAPsTF/xA6ixxL9GakgkTYKgwRmLIeTIsyTDf
	1FAZLdU0itgsJIChbCd4y8klUkCKb5ntr4trCcXV7vlrvJ1T0T9csZrh5Q==
X-Google-Smtp-Source: AGHT+IE3y/oLyOp6dcViaLlVQMCvdX/khmJhUqLCnytWkHG1rwuLL03WI9wMr5VuSiGavqiUoRnajQ==
X-Received: by 2002:a05:6214:5985:b0:6b5:101d:201 with SMTP id 6a1803df08f44-6bb983d58e1mr82442996d6.39.1722712418447;
        Sat, 03 Aug 2024 12:13:38 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c7b8826sm18967086d6.64.2024.08.03.12.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Aug 2024 12:13:37 -0700 (PDT)
Date: Sat, 03 Aug 2024 15:13:37 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Tom Herbert <tom@herbertland.com>, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 netdev@vger.kernel.org, 
 felipe@sipanda.io
Cc: Tom Herbert <tom@herbertland.com>
Message-ID: <66ae816115189_2a7a1f29434@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240731172332.683815-11-tom@herbertland.com>
References: <20240731172332.683815-1-tom@herbertland.com>
 <20240731172332.683815-11-tom@herbertland.com>
Subject: Re: [PATCH 10/12] flow_dissector: Parse Geneve in UDP
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
> Parse Geneve in a UDP encapsulation
> 
> Signed-off-by: Tom Herbert <tom@herbertland.com>
> ---
>  net/core/flow_dissector.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
> index 3766dc4d5b23..4fff60233992 100644
> --- a/net/core/flow_dissector.c
> +++ b/net/core/flow_dissector.c
> @@ -11,6 +11,7 @@
>  #include <net/fou.h>
>  #include <net/ip.h>
>  #include <net/ipv6.h>
> +#include <net/geneve.h>
>  #include <net/gre.h>
>  #include <net/pptp.h>
>  #include <net/tipc.h>
> @@ -808,6 +809,29 @@ __skb_flow_dissect_vxlan(const struct sk_buff *skb,
>  	return FLOW_DISSECT_RET_PROTO_AGAIN;
>  }
>  
> +static enum flow_dissect_ret
> +__skb_flow_dissect_geneve(const struct sk_buff *skb,
> +			  struct flow_dissector *flow_dissector,
> +			  void *target_container, const void *data,
> +			  __be16 *p_proto, int *p_nhoff, int hlen,
> +			  unsigned int flags)
> +{
> +	struct genevehdr *hdr, _hdr;
> +
> +	hdr = __skb_header_pointer(skb, *p_nhoff, sizeof(_hdr), data, hlen,
> +				   &_hdr);
> +	if (!hdr)
> +		return FLOW_DISSECT_RET_OUT_BAD;
> +
> +	if (hdr->ver != 0)
> +		return FLOW_DISSECT_RET_OUT_GOOD;
> +
> +	*p_proto = hdr->proto_type;
> +	*p_nhoff += sizeof(struct genevehdr) + (hdr->opt_len * 4);
> +
> +	return FLOW_DISSECT_RET_PROTO_AGAIN;

Do you want to return FLOW_DISSECT_RET_OUT_GOOD if IPPROTO 59.

Per your spec: "IP protocol number 59 ("No next header") may be set to
indicate that the GUE payload does not begin with the header of an IP
protocol."

Admittedly pendantic. No idea if any implementation actually sets
this.

> +}
> +
>  /**
>   * __skb_flow_dissect_batadv() - dissect batman-adv header
>   * @skb: sk_buff to with the batman-adv header
> @@ -974,6 +998,11 @@ __skb_flow_dissect_udp(const struct sk_buff *skb, struct net *net,
>  					       target_container, data,
>  					       p_proto, &nhoff, hlen, flags);
>  		break;
> +	case UDP_ENCAP_GENEVE:
> +		ret = __skb_flow_dissect_geneve(skb, flow_dissector,
> +						target_container, data,
> +						p_proto, &nhoff, hlen, flags);
> +		break;
>  	default:
>  		break;
>  	}
> -- 
> 2.34.1
> 



