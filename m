Return-Path: <netdev+bounces-197310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 253F8AD80DE
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 04:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D359D1E1DAA
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 02:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592E11EDA0B;
	Fri, 13 Jun 2025 02:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mz9m/AU6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF0E2F4317;
	Fri, 13 Jun 2025 02:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749781048; cv=none; b=VrtCXbBvvxE7N04evM8Nyv9mChqLEF7fE3RS+aGiaEJsEhGYlNAYASRpNUDz0+9Jji0GsI6H1YUz0GFivSh+MT1TWa9/t/GkBi3ILgD304c3xjdvHhxSr41uSh/eG3JJJvOFFxz0eT5jijfe0nLXoo5N2IOFVYvCVvxFhWRH2xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749781048; c=relaxed/simple;
	bh=dv406CTcJe7hDjtwr0Fl8OfsmC4T2JqLewR2EqlSbt0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SpOPX0HVSfAsLOIq+XWSsz31XFr2VreKD936tO6+7zOWplTkjEiO69Cd95+XVCs3VyY+T5G8353y8oq2nwpI54chefHhSdGxw9+KZsaj/CCimd4i9QNhbIAmlp2znKKWMF3ajLSWESxz64tQrdGvt3Y1D773nmYtABE8IXgGsWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mz9m/AU6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BD32C4CEEE;
	Fri, 13 Jun 2025 02:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749781047;
	bh=dv406CTcJe7hDjtwr0Fl8OfsmC4T2JqLewR2EqlSbt0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mz9m/AU6ON0POuKMo2eZzIUTblQZmK/Gfv36zjByTLqglsRgJCbBBfJ1MbLYdU7q1
	 xtUJQLRhSYMw4jmpRBoEy49cWJxHZD7JBhrSEcPNPrmWm+tNC0zq5fIVNkBb/kX7Fo
	 KzrnIEkEcWmaMNe2W173P3lCzdTKZbtc1UC++g6lHXAp0AjIoLUjIzRkg82MS/r7Zi
	 3gwpOnbV3Xysr+3D+ZDP4cFGsZr88al5ZxYYkNLjNTDhnNkK7e6jtLynS2LuAsz1t6
	 4myFDgxryB3LcC7OrPGDnO/J9eoy6Y8yASIEHon7LY9V5FYPbK+I8lacZ8H3WQrH7Y
	 Kvqx2mVnE0fBg==
Date: Thu, 12 Jun 2025 19:17:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Zejdl <petr.zejdl@cern.ch>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, "Paolo Abeni"
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: ipv4: ipconfig: Support RFC 4361/3315 DHCP client
 ID in hex format
Message-ID: <20250612191726.2a226cdf@kernel.org>
In-Reply-To: <20250610143504.731114-1-petr.zejdl@cern.ch>
References: <20250610143504.731114-1-petr.zejdl@cern.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Jun 2025 16:35:03 +0200 Petr Zejdl wrote:
> -		len = strlen(dhcp_client_identifier + 1);

maybe keep using len here? Assign dhcp_client_identifier_len to it?
I don't think switching to dhcp_client_identifier_len improves the
readability and it inflates the diff.

>  		/* the minimum length of identifier is 2, include 1 byte type,
>  		 * and can not be larger than the length of options
>  		 */
> -		if (len >= 1 && len < 312 - (e - options) - 1) {
> -			*e++ = 61;
> -			*e++ = len + 1;
> -			memcpy(e, dhcp_client_identifier, len + 1);
> -			e += len + 1;
> +		if (dhcp_client_identifier_len >= 2) {
> +			if (dhcp_client_identifier_len <= 312 - (e - options) - 3) {
> +				pr_debug("DHCP: sending client identifier %*phC\n",
> +					 dhcp_client_identifier_len,
> +					 dhcp_client_identifier);
> +				*e++ = 61;
> +				*e++ = dhcp_client_identifier_len;
> +				memcpy(e, dhcp_client_identifier,
> +				       dhcp_client_identifier_len);
> +				e += dhcp_client_identifier_len;
> +			} else {
> +				pr_warn("DHCP: client identifier doesn't fit in the packet\n");
> +			}
>  		}
>  	}
>  
> @@ -1661,6 +1669,33 @@ static int __init ip_auto_config(void)
>  
>  late_initcall(ip_auto_config);
>  
> +#ifdef CONFIG_IP_PNP_DHCP
> +/*
> + *  Parses DHCP Client ID in the hex form "XX:XX ... :XX" (like MAC address).
> + *  Returns the length (min 2, max 253) or -EINVAL on parsing error.
> + */
> +static int __init parse_client_id(const char *s, u8 *buf)
> +{
> +	int slen = strlen(s);
> +	int len = (slen + 1) / 3;
> +	int i;
> +
> +	/* Format: XX:XX ... :XX */
> +	if (len * 3 - 1 != slen || len < 2 || len > 253)
> +		return -EINVAL;
> +
> +	for (i = 0; i < len; i++) {
> +		if (!isxdigit(s[i * 3]) || !isxdigit(s[i * 3 + 1]))
> +			return -EINVAL;
> +		if (i != len - 1 && s[i * 3 + 2] != ':')
> +			return -EINVAL;
> +
> +		buf[i] = (hex_to_bin(s[i * 3]) << 4) | hex_to_bin(s[i * 3 + 1]);
> +	}
> +
> +	return i;
> +}

Feels like this helper should live in lib/net_utils.c or lib/hexdump.c
as a generic thing?
-- 
pw-bot: cr

