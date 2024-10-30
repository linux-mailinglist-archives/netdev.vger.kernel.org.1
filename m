Return-Path: <netdev+bounces-140444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 516969B67B9
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 16:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 082E11F21AA4
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 15:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6C3213147;
	Wed, 30 Oct 2024 15:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="XR5Qu21Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8371E3DC2
	for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 15:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730301794; cv=none; b=l5fkLTEaHo+oI2pBZX2o2HZNsK8LZPauRHkSL4xMSmH3VAXs1AAxYpv0jhsNfV8SjIW5cRqUv5j7Ltr0aAXVJJ4GPWzFKZG172+2eJf2Mh4j3ZfPCqevqv6RCZFI1s7ikPLHnaHWsb9IgVfHj/0Z3QTDW1Z5ILPGG3gD/P3qc04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730301794; c=relaxed/simple;
	bh=iu+F0QpBpIymx9Mb8vWJMs1rMDhvYv026jUBdr892qs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gjgAGEC++rSDbKURGzRuwRGM/2RKBbFGlXit/rjUzgM9zGyL5Y6fWjaeTaupQGBn+V8XJmXHMgOmB6aVfGuYBIhlDUNoJVFd4n8Xqi2DX5yHJWvGY+el4ZiiSAymOn6FNuopkBqby5kxo/Aoaa1Epw7rqH3j+mTh+OvOc6WPLMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=XR5Qu21Y; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2e3fca72a41so5505408a91.1
        for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 08:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1730301791; x=1730906591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OP44vKkaZ8TCjJgk08P04GYCIsessEUnYhYzif9jznA=;
        b=XR5Qu21Y/OePH8uPBmm0HsSxytIiFAGe8+i700LZBy61K0Uz0s2xvJ5Z7mwFYBXQNs
         ydskd2uKApqmMAYt6DLRFx4i8hDTCsI2uNdAx9Dn9NuN0Kqsiob8eWiqLNZPO5LfpEN3
         65kuV/9PszI0WypTGuFAd8voarpBoO4StAUhKfPXIyxdu5OtQ43Lg3WbIQy8DSms9iSR
         +46K1P7KPcgdcbXZN2Hnqjudmu05mTCnqqZ6ne8K6IvfKyfCpMjNE3z5kzzRBzx7GrDY
         S6lq4dMqNoWc9rpMBpLH2O2+Kn4p/xrEt9yOMuwScsMfqrcgZvpxZvnCX1pPdv0FREUT
         0Itg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730301791; x=1730906591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OP44vKkaZ8TCjJgk08P04GYCIsessEUnYhYzif9jznA=;
        b=JS7KIdZimJt7kUCMaGSwbikrPNV9uQfT+8wzs74NXLzjkvE4bpK5BD70bTB82DKs8U
         i7Cl5sTchOOSaqfRNK38bEYNqZKVYM2KzGIFx5aNANIPDBDFcN84ftjLlAR6dLCnHI4v
         2Mm0zkBpgUx+9WERB5g22pKp10KF6fHGx7fIilD1WpevZgv1tM7xhnWaj2C0IQQ+Pbq2
         IMSw8h6jPDmWowzTK8XND5YgpiHtMcHVyGIwCzWjEtyExN8f7cv3zNrTcI3nlb3H8tUq
         aECHPaOF10NUCB3IMcW91I+MVOZ9quq9Ke7AdSZ955w0ckHomkVNrj71/r0FOYYDrhxH
         jbXg==
X-Gm-Message-State: AOJu0YxI4AOXj9vhN1EqlM71ogadR+bhj343GTfEoPsY6jwnKeZ9NgEy
	ZT/two9pmeKR2Z4vs7s28ybkKudYKyKrcym9I7g7Z1pxOmzJHikxTQewtU2IRFUyPfrqNmr0HlQ
	C
X-Google-Smtp-Source: AGHT+IEiSInTP/WgvB8Iwxew4lGfgEKdPRUEJ92Pl9krgZVcbbPzoI8dAQK1wjwjKybWxRsz8OJ7zQ==
X-Received: by 2002:a17:90b:360a:b0:2e2:b64e:f501 with SMTP id 98e67ed59e1d1-2e8f10a6d2cmr19546145a91.30.1730301791303;
        Wed, 30 Oct 2024 08:23:11 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bbf6d327sm81955795ad.67.2024.10.30.08.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 08:23:11 -0700 (PDT)
Date: Wed, 30 Oct 2024 08:23:09 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Fabian Pfitzner <f.pfitzner@pengutronix.de>
Cc: netdev@vger.kernel.org, entwicklung@pengutronix.de,
 bridge@lists.linux-foundation.org
Subject: Re: [PATCH v2 iproute] bridge: dump mcast querier state
Message-ID: <20241030082309.44fe54d1@hermes.local>
In-Reply-To: <20241030084622.4141001-1-f.pfitzner@pengutronix.de>
References: <20241030084622.4141001-1-f.pfitzner@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Oct 2024 09:46:23 +0100
Fabian Pfitzner <f.pfitzner@pengutronix.de> wrote:

> Kernel support for dumping the multicast querier state was added in this
> commit [1]. As some people might be interested to get this information
> from userspace, this commit implements the necessary changes to show it
> via
> 
> ip -d link show [dev]
> 
> The querier state shows the following information for IPv4 and IPv6
> respectively:
> 
> 1) The ip address of the current querier in the network. This could be
>    ourselves or an external querier.
> 2) The port on which the querier was seen
> 3) Querier timeout in seconds
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c7fa1d9b1fb179375e889ff076a1566ecc997bfc
> 
> Signed-off-by: Fabian Pfitzner <f.pfitzner@pengutronix.de>
> ---
> 
> v1->v2: refactor code
> 
>  ip/iplink_bridge.c | 47 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/ip/iplink_bridge.c b/ip/iplink_bridge.c
> index f01ffe15..f74436d3 100644
> --- a/ip/iplink_bridge.c
> +++ b/ip/iplink_bridge.c
> @@ -661,6 +661,53 @@ static void bridge_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
>  			   "mcast_querier %u ",
>  			   rta_getattr_u8(tb[IFLA_BR_MCAST_QUERIER]));
>  
> +	if (tb[IFLA_BR_MCAST_QUERIER_STATE]) {
> +		struct rtattr *bqtb[BRIDGE_QUERIER_MAX + 1];
> +		SPRINT_BUF(other_time);
> +
> +		parse_rtattr_nested(bqtb, BRIDGE_QUERIER_MAX, tb[IFLA_BR_MCAST_QUERIER_STATE]);
> +		memset(other_time, 0, sizeof(other_time));
> +
> +		open_json_object("mcast_querier_state_ipv4");
> +		if (bqtb[BRIDGE_QUERIER_IP_ADDRESS])
> +			print_string(PRINT_ANY,
> +				"mcast_querier_ipv4_addr",
> +				"mcast_querier_ipv4_addr %s ",
> +				format_host_rta(AF_INET, bqtb[BRIDGE_QUERIER_IP_ADDRESS]))

Would be good to use print_color_string here. 


