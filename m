Return-Path: <netdev+bounces-107484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E8791B2A4
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 01:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7A0F284FEE
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 23:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BC81A2C2D;
	Thu, 27 Jun 2024 23:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="fbBFBKOc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993141A08D6
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 23:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719530443; cv=none; b=O+uxbHbGo9G76bjILoLMK/ja+yznnRaX+0wUWk4xgES2nafYRt1cMy3e7Gg21Ve1B5CeyneD4ajH5XCbe/k0rJ3lY5BFkJckkIG85ly10nGojDVKP3XzzRVtvTe1nBeHGZsdD2InUvr4JTwNb5/Q9Aa21W5DI1p5LtcCK2uqL+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719530443; c=relaxed/simple;
	bh=gRxqlpUrJIn2rrgg9hOqeWxXH2ELcfMisGGAC097etE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ExBAwRcyHb3EuUZjI9zCJ5JonE1nj4/PesEqQD49ht45MmutnjZ3mCRDer2sXw8MGl0ra6nCJeEZPdt99YlzHY/PNo2YwViQdDuEKC9OPbPHdNi2yUW37CZpmv+55nhiDb1bSRvwPsn4IDEf6/wLC+2ocGQrWi2zn5LGAX4e+N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=fbBFBKOc; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2c901185d73so861154a91.0
        for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 16:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1719530441; x=1720135241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vOCvXo/2fbFeXV6IwXWr8Dvazrecngf2u3CpMkK5Mxo=;
        b=fbBFBKOctS1m4LHS591+HXPZ6Vvp/wVPG5AwhCsu26FLIyPTutoitjHdT6/1IT5uxT
         mt2UqVuS/u4PDZAgFfKE5lzBbqX88Td6TTkrqhPv06/hQ+MhTGMjUQfI4BlFs+sy1ZRh
         SJEmJrcRVW9iBcIvRDgQZZrQA0QaseBCOfWSq0ZSyL7g2BUekg9uPZiiwQ98t0h2vLhF
         SjH+Chawacw5nb40LdmreNd4dehMx2cR7LxVslWD0IWEkpUEhPr3M6vf3wEFYXSkxXMi
         85Q/ikdA/1NctQ4WLt/AiToRfwztHzYrjcbURDhU6nVv4qZ9HZ6nkTRj9k3o/RYXdnND
         Qa0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719530441; x=1720135241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vOCvXo/2fbFeXV6IwXWr8Dvazrecngf2u3CpMkK5Mxo=;
        b=N+lQoKMc7d2ttAXj3aaZne18n3ghTwHXPEnVOdjekNpi1hsW/nYJ4gXNmEmOj1RSi1
         N+OIktF5IQ/Hf2AcMom4o7FdUZGDcaDy+HMpUP8ISVVG96k+4zO+KGOT6DN6YTZt54DP
         nis8a1HfcW2h6+r5ig7gNAyFwG3EDGCgBmbrnqy4CyRLIlpDyd6LZbn3HtY5TN6Ezk3G
         o5/uzlT5MntCz6pQSgklpfEeL2zpSZR6CLBzPQ3QZ5rd+CE+ByQC7eIgcszcW7eL+m+Z
         MqLSKy+OJqtgpsn/XB/EpkvOrVluFQ1Wu41Ov2TMf7+o4DFlIwCNQshQkyWMLR5lcEoQ
         +kqg==
X-Forwarded-Encrypted: i=1; AJvYcCU53j71R4usNvEFpZKUgcg6kHuYmzmYTDEHdVgFwUjh4Zy/aC7fgBLiMX8eLyp1V1vIb068XrMPzMPgVaLj3tT1rMVmt28a
X-Gm-Message-State: AOJu0Yyjo3VVkQxbaXcJ8NP1+c+H6KTuLGxl6vciIBOXC2ul+OCG91Ln
	gRbIaZgbfzUURcpqtw0pzjHJmB2yUdinkZ3awFdZKr3gH+cBeAA0IfLzsqxAdns=
X-Google-Smtp-Source: AGHT+IFKLLsyNlwY14kh3BFSZdvkXV6HV944/ADWxcBKyFc9yku7/pHdnHXSL9elgDaZJ2ZM27xj6A==
X-Received: by 2002:a17:90b:378f:b0:2c7:af75:6c51 with SMTP id 98e67ed59e1d1-2c927d39892mr28143a91.18.1719530440671;
        Thu, 27 Jun 2024 16:20:40 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91d3d6179sm338431a91.48.2024.06.27.16.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 16:20:40 -0700 (PDT)
Date: Thu, 27 Jun 2024 16:20:38 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Roded Zats <rzats@paloaltonetworks.com>
Cc: benve@cisco.com, satishkh@cisco.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 orcohen@paloaltonetworks.com, netdev@vger.kernel.org
Subject: Re: [PATCH net v2] enic: Validate length of nl attributes in
 enic_set_vf_port
Message-ID: <20240627162038.6e16d851@hermes.local>
In-Reply-To: <20240522073044.33519-1-rzats@paloaltonetworks.com>
References: <81d39fab6a85981b28329a67b454ca92e7e377f8.camel@redhat.com>
	<20240522073044.33519-1-rzats@paloaltonetworks.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 May 2024 10:30:44 +0300
Roded Zats <rzats@paloaltonetworks.com> wrote:

> enic_set_vf_port assumes that the nl attribute IFLA_PORT_PROFILE
> is of length PORT_PROFILE_MAX and that the nl attributes
> IFLA_PORT_INSTANCE_UUID, IFLA_PORT_HOST_UUID are of length PORT_UUID_MAX.
> These attributes are validated (in the function do_setlink in rtnetlink.c)
> using the nla_policy ifla_port_policy. The policy defines IFLA_PORT_PROFILE
> as NLA_STRING, IFLA_PORT_INSTANCE_UUID as NLA_BINARY and
> IFLA_PORT_HOST_UUID as NLA_STRING. That means that the length validation
> using the policy is for the max size of the attributes and not on exact
> size so the length of these attributes might be less than the sizes that
> enic_set_vf_port expects. This might cause an out of bands
> read access in the memcpys of the data of these
> attributes in enic_set_vf_port.
> 
> Fixes: f8bd909183ac ("net: Add ndo_{set|get}_vf_port support for enic dynamic vnics")
> Signed-off-by: Roded Zats <rzats@paloaltonetworks.com>
> ---
>  drivers/net/ethernet/cisco/enic/enic_main.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
> index f604119efc80..5f26fc3ad655 100644
> --- a/drivers/net/ethernet/cisco/enic/enic_main.c
> +++ b/drivers/net/ethernet/cisco/enic/enic_main.c
> @@ -1117,18 +1117,30 @@ static int enic_set_vf_port(struct net_device *netdev, int vf,
>  	pp->request = nla_get_u8(port[IFLA_PORT_REQUEST]);
>  
>  	if (port[IFLA_PORT_PROFILE]) {
> +		if (nla_len(port[IFLA_PORT_PROFILE]) != PORT_PROFILE_MAX) {
> +			memcpy(pp, &prev_pp, sizeof(*pp));
> +			return -EINVAL;
> +		}

If you have multiple error conditions with the same unwind, the common design
pattern in Linux is to use a goto error at end of function.

