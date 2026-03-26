Return-Path: <netdev+bounces-271972-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCbkEroNxWkI6AQAu9opvQ
	(envelope-from <netdev+bounces-271972-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 11:43:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6EF6333A47
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 11:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7358A300D467
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 10:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025C13C3424;
	Thu, 26 Mar 2026 10:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FiJKmcUG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IVvXAVfh"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E80E3168EB
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 10:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774520737; cv=none; b=i5nzt+sgReT6e0WUmAkZjlNd4B7c/I9cjfHbOh1Yg4GhZ8KjhPT4Seo9O7L/O0QtnnxTZDLjs8ibw7Wwk/ibcdZ53+DSgQ0y1S2ubWw+ygTYk1awRdTmDqqc6DUpMv0+DADDiB9o+YnGwSI3F1HmHov5Gh7AMgxp85nnWkSGLSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774520737; c=relaxed/simple;
	bh=JgpRYIF9T/Z+29y0i99grSqwIODB8HiI8W9wpOXNZQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RX2dJw0SxTgyNppcDPsefWKF457M6I8+HtPqyGvg+iXDWqdwIJhWhdEDU2aAo+v1lOQ9/TkknYRKwCyEIj7CpUoV5XV+9jxSjZIkh5H2ofIR27byjsnqX9K01eGmwaLR9CxxmYuqd3Dii7jC818D+KqCQ/+FB3AGFXkiFN7MSmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FiJKmcUG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IVvXAVfh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774520735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BZMdR5mD3YAWrVXEIuBlAnHV2JLWFbsl0mHokYFYrkA=;
	b=FiJKmcUGnJAiuH8SxvQaneljfSF6hJ2mi09wuY98H3xlk4t93yIQiiqNpCmk430zzsej7n
	50A7ZOBoC+/NvbxZAHR4/qiOQN8k4gRT6YruBDjUgZ3haHgke2p3CaGgbQGIH83SBTHD8e
	6O7Dz7icrg3JSufDbqoRJ8KMDRu/a+Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-xFTRybJ1Ok6lVN5bpv8H3g-1; Thu, 26 Mar 2026 06:25:34 -0400
X-MC-Unique: xFTRybJ1Ok6lVN5bpv8H3g-1
X-Mimecast-MFC-AGG-ID: xFTRybJ1Ok6lVN5bpv8H3g_1774520733
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4853b5b0fafso16298905e9.3
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 03:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774520733; x=1775125533; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BZMdR5mD3YAWrVXEIuBlAnHV2JLWFbsl0mHokYFYrkA=;
        b=IVvXAVfhvkxQKnC9IJQhPi5qaSkzNC/2Um25gPP2y7+2Bk5ZaW0Y/XC2OuicHvR6ip
         AzsZ3UGg41G21eWILds0I1Q2fGW/D8H1jxOyLJT3xl8073PdmTFW14SbKd1V3tH5mQj1
         bsnkL4W7KaqTYI/0rwdVq75PyCAZuAmlt+1TAmnZENqffPLTAGCz6Sl4AbvfulqXC36F
         Y9dhlB+kELFCKG0TP4yU6iu6C+Y4pdIrbnWaKjVuP4bgk7rw6KIqGeF8HeIkS/6+gOLc
         1MFfEsLCQgTbPEi2zyC33Bptnw1hiwp2+rntljo14ZE3ac/QzWSpgV3+xxoSYAN4f1yc
         s0VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774520733; x=1775125533;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BZMdR5mD3YAWrVXEIuBlAnHV2JLWFbsl0mHokYFYrkA=;
        b=QY/Cx1tPeChHS4PRqmu0RtQ6fkaqwq0AGOPJgQHnb+cEI4cDa6CNdeZFCbS3HP++6l
         eOYUiT+kuILF/x/LTQxDKchr3JcBD69zLuZIdyNHIgXMzAKxwS9+m72lq5WLJeSq+rVi
         Y3G3Y7TcgomEwpPRJDXtRDwCQ5ixJoD7sP2jHPzG8FXgHxYtLKnkF4b6hB22Qifpgvk2
         tl+Q2gcjwKcxf3rsgYP9I38iX/rbs4VgJANyMA6FY4JzW/uNSvp0Wmny3nAMj/7vRK94
         tsmKhktqtcA09GsHtOYG9Kwa9QKMDR72qf6EbXDaGYf2R9SN263ecOoBi166AqBrIaNZ
         Y3sg==
X-Forwarded-Encrypted: i=1; AJvYcCVmnEX8LGX7pJHLfFNMu+pFBflfmEsxWnfpFUE5JandYxpAqnQeSd/En6uKFobOlMk1GmYmJgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdWQeDzSoCoouDUStWrpCT0ciU9XhK9nx+I+ovs1cO2sRKYU+x
	h8FVW8fmf31SjZSfej2XzzFKNO9dRSTqEmno725Bm0JBeBrsbtLvj8FI7KS3RZhim6EiWv+avQj
	Z24FL344xf3PKSQb2zvSf6OHrqoAZSD2CBu0v/k7D4dA7Mk3iYFm1w7ImGA==
X-Gm-Gg: ATEYQzxIPtt7dAXTNOj8jfeSPEvULeCTffSIFe067CNxSmuYDhAvya+6iOYENOK6PZv
	8iyBnGk9m9TCZr85t6yJ5PEM13PkolplhLYD/q3fzVzf1ckUbz+z2gPZxoAQke6BigewguFafwN
	B75SmZv+QotpjtwU1iVa+vWgjNRtg6Iwobo0rhGh8Bco5iWL6z8ExwXLcWeOr5b80vkxyIwwbNd
	06v7/6zpYshWZUWi9DRzehT+d/9SSQBstWF0tVi5z3zRSsex8z5+1bpuNB5xLlIFFJ3xCtM10pl
	a9P6tgIaF6H4Brozcgq9EUIIQxyW3zTBrLYEyLhcu6OY4GhJla5yQchRlqu3aJRmk6Mm6EdTyAO
	Z1iI7MMTN8FJ8y69fWTdrDT0JL3jad6PE85VM9ujNmpXxZ20icph0g27v
X-Received: by 2002:a05:600c:6087:b0:483:2c98:4368 with SMTP id 5b1f17b1804b1-4871605a9a5mr100245255e9.18.1774520733164;
        Thu, 26 Mar 2026 03:25:33 -0700 (PDT)
X-Received: by 2002:a05:600c:6087:b0:483:2c98:4368 with SMTP id 5b1f17b1804b1-4871605a9a5mr100244675e9.18.1774520732670;
        Thu, 26 Mar 2026 03:25:32 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.153.60])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722cb10fcsm22392255e9.14.2026.03.26.03.25.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 03:25:31 -0700 (PDT)
Message-ID: <c5c71526-047b-480d-bf4f-6ebc47357f49@redhat.com>
Date: Thu, 26 Mar 2026 11:25:30 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mpls: fix missing NULL check in
 mpls_valid_fib_dump_req
To: sunichi <sunyiqixm@gmail.com>, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org
Cc: horms@kernel.org, kuniyu@google.com, gnault@redhat.com,
 leitao@debian.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260323071515.1945612-1-sunyiqixm@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260323071515.1945612-1-sunyiqixm@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-271972-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,google.com,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D6EF6333A47
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/23/26 8:15 AM, sunichi wrote:
> The attribute tb[RTA_OIF] is dereferenced without verifying if it is NULL.
> If this attribute is missing in the user netlink message, it will cause a
> NULL pointer dereference and kernel panic.
> 
> Add the necessary check before using the pointer to prevent the crash.
> 
> Signed-off-by: sunichi <sunyiqixm@gmail.com>
> ---
>  net/mpls/af_mpls.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
> index d5417688f69e..28bbea30aae3 100644
> --- a/net/mpls/af_mpls.c
> +++ b/net/mpls/af_mpls.c
> @@ -2174,6 +2174,8 @@ static int mpls_valid_fib_dump_req(struct net *net, const struct nlmsghdr *nlh,
>  		int ifindex;
>  
>  		if (i == RTA_OIF) {
> +			if (!tb[i])
> +				return -EINVAL;
>  			ifindex = nla_get_u32(tb[i]);
>  			filter->dev = dev_get_by_index_rcu(net, ifindex);
>  			if (!filter->dev)

If you reorder the check I think it will lead to better code:

---
diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index b32311f5cbf7..41510dce5329 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -2170,13 +2170,16 @@ static int mpls_valid_fib_dump_req(struct net
*net, const struct nlmsghdr *nlh,
        for (i = 0; i <= RTA_MAX; ++i) {
                int ifindex;

+               if (!tb[i])
+                       continue;
+
                if (i == RTA_OIF) {
                        ifindex = nla_get_u32(tb[i]);
                        filter->dev = dev_get_by_index_rcu(net, ifindex);
                        if (!filter->dev)
                                return -ENODEV;
                        filter->filter_set = 1;
-               } else if (tb[i]) {
+               } else {
                        NL_SET_ERR_MSG_MOD(extack, "Unsupported
attribute in dump request");
                        return -EINVAL;
                }


