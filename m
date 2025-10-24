Return-Path: <netdev+bounces-232555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DCCC06896
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 15:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 237CF4EFC83
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 13:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E5F13AD3F;
	Fri, 24 Oct 2025 13:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JR4DanK4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C30C3191D6
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 13:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761313115; cv=none; b=XlX1fEHxYp5UaWb8oeljD5Xg3VkTgRQU6zEm64WfxsbxbNJrWRK32mR3zRKLe+gcO3OrGruH2krUsLSJnq3m9bZtbkIf7Fh79mKFVtozYpb/wo1vDuonXBqzARH6FJH7EBC5rHXd/GdPTvx3CkCM7JeFHbqttDSny7sLt639hxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761313115; c=relaxed/simple;
	bh=p+8WyoMhFflWFHZt7X1weqT9mnWBboqQhKnCPj4m96o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lc/3foh6gkOEHtytELGHyhXLu3bUVlFtNZfCWH81zXR8np6+IBq67b+e4MIctV4Cmq18upgDFTmzST4xcIzV2p2gxWozgyVRhWGfFReZgbEjq5xX9c3es+kLW3pfTrlrQ5KG/dJGjL/aELh48ABNcmz28V+a3kiVO8a1r39PtDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JR4DanK4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761313112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=71m5zv9N4Q7maC6TR7eEZN7fiixAuyNubMN381e1JPk=;
	b=JR4DanK4ek014utzV90mWw6fAd4YkJrpxeZVBIe+Y6P247vpXtCOAZrUwFMHo4KaqP4+JL
	eTilaM1PMfRRDSbRLJ8GnjTHEjW6rWccCOhmNxvRI1OQTL93IBErXvmp6Jsaxt3+tnl9Jj
	XZLqOAXo9XKEvkgQxcdtAxTZj+eL26w=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-10-GWmFM14zOxS9w9IxZafYWQ-1; Fri,
 24 Oct 2025 09:38:27 -0400
X-MC-Unique: GWmFM14zOxS9w9IxZafYWQ-1
X-Mimecast-MFC-AGG-ID: GWmFM14zOxS9w9IxZafYWQ_1761313105
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 327A9180121B;
	Fri, 24 Oct 2025 13:38:25 +0000 (UTC)
Received: from [10.44.33.203] (unknown [10.44.33.203])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7B92D19560B5;
	Fri, 24 Oct 2025 13:38:21 +0000 (UTC)
Message-ID: <56ba4cd5-32d5-452b-9312-f6b778a44ef3@redhat.com>
Date: Fri, 24 Oct 2025 15:38:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] tools: ynl: fix string attribute length to include
 null terminator
To: Petr Oros <poros@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>,
 =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>,
 "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
Cc: mschmidt@redhat.com
References: <20251024132438.351290-1-poros@redhat.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20251024132438.351290-1-poros@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12



On 10/24/25 3:24 PM, Petr Oros wrote:
> The ynl_attr_put_str() function was not including the null terminator
> in the attribute length calculation. This caused kernel to reject
> CTRL_CMD_GETFAMILY requests with EINVAL:
> "Attribute failed policy validation".
> 
> For a 4-character family name like "dpll":
> - Sent: nla_len=8 (4 byte header + 4 byte string without null)
> - Expected: nla_len=9 (4 byte header + 5 byte string with null)
> 
> The bug was introduced in commit 15d2540e0d62 ("tools: ynl: check for
> overflow of constructed messages") when refactoring from stpcpy() to
> strlen(). The original code correctly included the null terminator:
> 
>    end = stpcpy(ynl_attr_data(attr), str);
>    attr->nla_len = NLA_HDRLEN + NLA_ALIGN(end -
>                                  (char *)ynl_attr_data(attr));
> 
> Since stpcpy() returns a pointer past the null terminator, the length
> included it. The refactored version using strlen() omitted the +1.
> 
> The fix also removes NLA_ALIGN() from nla_len calculation, since
> nla_len should contain actual attribute length, not aligned length.
> Alignment is only for calculating next attribute position. This makes
> the code consistent with ynl_attr_put().
> 
> CTRL_ATTR_FAMILY_NAME uses NLA_NUL_STRING policy which requires
> null terminator. Kernel validates with memchr() and rejects if not
> found.
> 
> Fixes: 15d2540e0d62 ("tools: ynl: check for overflow of constructed messages")
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
>   tools/net/ynl/lib/ynl-priv.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/net/ynl/lib/ynl-priv.h b/tools/net/ynl/lib/ynl-priv.h
> index 29481989ea7662..ced7dce44efb43 100644
> --- a/tools/net/ynl/lib/ynl-priv.h
> +++ b/tools/net/ynl/lib/ynl-priv.h
> @@ -313,7 +313,7 @@ ynl_attr_put_str(struct nlmsghdr *nlh, unsigned int attr_type, const char *str)
>   	struct nlattr *attr;
>   	size_t len;
>   
> -	len = strlen(str);
> +	len = strlen(str) + 1;
>   	if (__ynl_attr_put_overflow(nlh, len))
>   		return;
>   
> @@ -321,7 +321,7 @@ ynl_attr_put_str(struct nlmsghdr *nlh, unsigned int attr_type, const char *str)
>   	attr->nla_type = attr_type;
>   
>   	strcpy((char *)ynl_attr_data(attr), str);
> -	attr->nla_len = NLA_HDRLEN + NLA_ALIGN(len);
> +	attr->nla_len = NLA_HDRLEN + len;
>   
>   	nlh->nlmsg_len += NLMSG_ALIGN(attr->nla_len);
>   }

Tested-by: Ivan Vecera <ivecera@redhat.com>


