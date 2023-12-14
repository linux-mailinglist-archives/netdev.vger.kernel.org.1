Return-Path: <netdev+bounces-57487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA268132AF
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 15:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29A93282533
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 14:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B232959B71;
	Thu, 14 Dec 2023 14:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DriDc4zi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85EF9CF
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 06:12:22 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-a1d2f89ddabso985310566b.1
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 06:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702563141; x=1703167941; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3TzeL0ZSjS0zpiE00HiTA+MkKO8bVUznzXu5wftU6rg=;
        b=DriDc4ziW3U39eUomzW1MGfSlCPLrPq385D+V/Byb3jgeCLfOXQwOOdAS6BFcHAOIt
         FR/K+WCNdOuay6TzXy+/kRuFS0khk71CEljcDX/AEtEPgOBE9m5yHg+ZA9zANdfhGdsW
         ki9uhGz3NGBUqXs+fuz2j3q2EMKeJmw5/V+nN9s6d5T5XJP6W7+0sdJgnpqrgGRvVFnW
         uYRCMDsHQBfg36u2QK6GWeo0b0UqyPK7u/0aYNdYtLjqCvEmofgsZ7vEpk3WNqvdupKo
         u5b7dHsrDglJc7Yq+X+0kIPcvOFLYFAO92Mj/4RMcY1YC9C14Fn3oxmvDNp9ziJxpToz
         mrbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702563141; x=1703167941;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3TzeL0ZSjS0zpiE00HiTA+MkKO8bVUznzXu5wftU6rg=;
        b=xC7cnij2DsP8ZyE1nFcv+oxlNeKfRiKVinYdPbG7zYXf4N1QcrDsxIpLAVUgrD55zb
         8mf6e3+RsDzikKrdlVfjPLIGA4pRaTW8Qz3A+j5QH8RVoaNovTsDwT0trh4TzUk9u6D+
         2k/U6reADqxPEpc6qhfmmY8uL66Hle9qVyKgzU+ZRtGhujlJONPe8LaQI/aRkbA9NWb4
         m5YqeqI3DMF9TUZAtNh7wscs00RugTST4orXREYcaTU/u5j9hayPtCSsws9YNLbNooqE
         ScQN9tDwH9FmyZd20k+t9oMbHvvoR2nBujB+uul0+nhB9fRvHj7FmKCej50APC0FFPnA
         2k4w==
X-Gm-Message-State: AOJu0YxSm23CZ+GDCq1WzXu5uz6nb+2a1JPNEv6ufpiW0jMEcatD6cLy
	vhte3edJs1PJMHtWWub8PDV3ubm58NTXfw==
X-Google-Smtp-Source: AGHT+IHKKvBNMKD30/N57NGCUtvTd2A62FWQKsk/ACuW3rSLBbiP5LqzOnxBo7wtb2FmUchzqssAXQ==
X-Received: by 2002:a17:906:5a49:b0:9e0:4910:166a with SMTP id my9-20020a1709065a4900b009e04910166amr5776870ejc.32.1702563140709;
        Thu, 14 Dec 2023 06:12:20 -0800 (PST)
Received: from skbuf ([188.27.185.68])
        by smtp.gmail.com with ESMTPSA id kt17-20020a1709079d1100b00a015eac52dcsm9398713ejc.108.2023.12.14.06.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 06:12:20 -0800 (PST)
Date: Thu, 14 Dec 2023 16:12:18 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, andrew@lunn.ch,
	f.fainelli@gmail.com, netdev@vger.kernel.org
Subject: Re: [PATCH v4 net-next 8/8] selftests: forwarding: ethtool_rmon: Add
 histogram counter test
Message-ID: <20231214141218.2qz7onhdp72itxam@skbuf>
References: <20231214135029.383595-1-tobias@waldekranz.com>
 <20231214135029.383595-1-tobias@waldekranz.com>
 <20231214135029.383595-9-tobias@waldekranz.com>
 <20231214135029.383595-9-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214135029.383595-9-tobias@waldekranz.com>
 <20231214135029.383595-9-tobias@waldekranz.com>

On Thu, Dec 14, 2023 at 02:50:29PM +0100, Tobias Waldekranz wrote:
> Validate the operation of rx and tx histogram counters, if supported
> by the interface, by sending batches of packets targeted for each
> bucket.
> 
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
> ---

Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

# enetc + ocelot
./ethtool_rmon.sh eno0 swp0
TEST: rx-pkts64to64 on eno0                                         [ OK ]
TEST: rx-pkts65to127 on eno0                                        [ OK ]
TEST: rx-pkts128to255 on eno0                                       [ OK ]
TEST: rx-pkts256to511 on eno0                                       [ OK ]
TEST: rx-pkts512to1023 on eno0                                      [ OK ]
TEST: rx-pkts1024to1522 on eno0                                     [ OK ]
TEST: rx-pkts1523to9600 on eno0                                     [ OK ]
TEST: rx-pkts64to64 on swp0                                         [ OK ]
TEST: rx-pkts65to127 on swp0                                        [ OK ]
TEST: rx-pkts128to255 on swp0                                       [ OK ]
TEST: rx-pkts256to511 on swp0                                       [ OK ]
TEST: rx-pkts512to1023 on swp0                                      [ OK ]
TEST: rx-pkts1024to1526 on swp0                                     [ OK ]
TEST: rx-pkts1527to65535 on swp0                                    [ OK ]
TEST: tx-pkts64to64 on eno0                                         [ OK ]
TEST: tx-pkts65to127 on eno0                                        [ OK ]
TEST: tx-pkts128to255 on eno0                                       [ OK ]
TEST: tx-pkts256to511 on eno0                                       [ OK ]
TEST: tx-pkts512to1023 on eno0                                      [ OK ]
TEST: tx-pkts1024to1522 on eno0                                     [ OK ]
TEST: tx-pkts1523to9600 on eno0                                     [ OK ]
TEST: tx-pkts64to64 on swp0                                         [ OK ]
TEST: tx-pkts65to127 on swp0                                        [ OK ]
TEST: tx-pkts128to255 on swp0                                       [ OK ]
TEST: tx-pkts256to511 on swp0                                       [ OK ]
TEST: tx-pkts512to1023 on swp0                                      [ OK ]
TEST: tx-pkts1024to1526 on swp0                                     [ OK ]
TEST: tx-pkts1527to65535 on swp0                                    [ OK ]

# mv88e6xxx
./ethtool_rmon.sh lan1 lan2
TEST: rx-pkts64to64 on lan1                                         [ OK ]
TEST: rx-pkts65to127 on lan1                                        [ OK ]
TEST: rx-pkts128to255 on lan1                                       [ OK ]
TEST: rx-pkts256to511 on lan1                                       [ OK ]
TEST: rx-pkts512to1023 on lan1                                      [ OK ]
TEST: rx-pkts1024to65535 on lan1                                    [ OK ]
TEST: rx-pkts64to64 on lan2                                         [ OK ]
TEST: rx-pkts65to127 on lan2                                        [ OK ]
TEST: rx-pkts128to255 on lan2                                       [ OK ]
TEST: rx-pkts256to511 on lan2                                       [ OK ]
TEST: rx-pkts512to1023 on lan2                                      [ OK ]
TEST: rx-pkts1024to65535 on lan2                                    [ OK ]
TEST: lan1 does not support tx histogram counters                   [SKIP]
TEST: lan2 does not support tx histogram counters                   [SKIP]

This is just lovely, thanks for the work, Tobias.

Just one nitpick below.

> +rmon_histogram()
> +{
> +	local iface=$1; shift
> +	local neigh=$1; shift
> +	local set=$1; shift
> +	local nbuckets=0
> +	local step=
> +
> +	RET=0
> +
> +	while read -r -a bucket; do
> +		step="$set-pkts${bucket[0]}to${bucket[1]} on $iface"
> +
> +		for if in $iface $neigh; do

My syntax highlighting in vim gets confused by the fact that you name a
variable "if". I guess something like "netif" would do the trick. But
bash doesn't seem to be confused. I can send a patch renaming this after
it gets merged. There's no reason to resend - it's not a functional
change.

> +			if ! ensure_mtu $if ${bucket[0]}; then
> +				log_test_skip "$if does not support the required MTU for $step"
> +				return
> +			fi
> +		done
> +
> +		if ! bucket_test $iface $neigh $set $nbuckets ${bucket[0]}; then
> +			check_err 1 "$step failed"
> +			return 1
> +		fi
> +		log_test "$step"
> +		nbuckets=$((nbuckets + 1))
> +	done < <(ethtool --json -S $iface --groups rmon | \
> +		jq -r ".[0].rmon[\"${set}-pktsNtoM\"][]|[.low, .high]|@tsv" 2>/dev/null)

