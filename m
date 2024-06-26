Return-Path: <netdev+bounces-106742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 378509175FC
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 04:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 571931C217DC
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 02:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCD717BBA;
	Wed, 26 Jun 2024 02:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jL2vWHez"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E6BBE6C
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 02:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719367459; cv=none; b=C1b7V5KixBEAKRujrtkJYMnHav/GYwRhVbwqRTtDJWmRZ0lOzHw+whMYecHxhDY6l0IkrBy9CSJGSCLIm2Ebbzf9drzZFEL8tMOvFj+d3D1/QAMFJ0IguLNuwEjjpvk1LfEI+dZDGjgnnVyJJ5Y4VXb/V8C7pfgD/kSFmTEKY9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719367459; c=relaxed/simple;
	bh=aN3og5AzY+B1LhNsYiHc045+QRwl7FQA47UgNpDyXqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WiVo5sbCVKB2bk8rlG6mCsV5yeNrw5sf3zmlYSegc87t/ppEshh+/0vvESjECVHj+F6DqjM3rKJxi/a/GYyANEEUcD0+EI8RoJye6qKbN49BqzBjGjw8EAPcXoh0/Q81UF3pTVcYHyLHWfgYyfNUFWruV+kYXYbNa7VlfpKPdb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jL2vWHez; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2c72becd4fdso4837614a91.0
        for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 19:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719367457; x=1719972257; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TqiKIjXRWpI2yH4Orhmj1cH94DD9CfoTw7Hr86cXKPQ=;
        b=jL2vWHez9FMYjgMKFlMFSSC3fbMjym2T4h1uvrRvEa/CKMl2zm9sxrboQlwm9NGCFJ
         FfgQvtgTCxJBIW5AfTHwxSFWgHeLMTGSLeCKyup7RRSyRgOTcMkkBls6avobsALfLe4D
         BpFi9+xd4DzNh2BcMgHwxGXpt2pAWPAsf357Dopa8j4NJZCQdjUxwDY6R/xLd9URYjci
         DiVkpkuspBPVRZQArMIV0pu+kAdl2xZ4aKJoYoo56lut96TlLe9L7pexE4i5wCf6Eg8s
         hZSOxiGgpUcpbhDrS2YmBesJVhzD3VMtMmBVQ2Tfi3dd4IgvJ3FGwFonfgdX0qdK72SD
         2Svg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719367457; x=1719972257;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TqiKIjXRWpI2yH4Orhmj1cH94DD9CfoTw7Hr86cXKPQ=;
        b=qZhavETqZBA3vn438W6WKvZGnyE241c7dXXiitf6IUYdYot9DfPzR+y0D8IXhjCdDe
         eX+Wy/ytslSG15WLEzul7iRPzxgiVwZTO9TitQZmMlMb5QZMI1C1p34t+LhpMEnCYvvg
         GEKLSR/Z+QnQPQGyq98yM6UJtRQkxmLx8V+2mv+G8ySOVYDSq/SROpM8vAwmUfT2tYh3
         rorZTkRPpS1LHFX7oek4oIiUZTr7S5Hr+8aZC+mMdJcJswn18HAJfovuek54jyNBMm6M
         NRJ5a7n898af56moBLxyyIZ1s3XmmeHvpY5bgSX96R/QDInruUvvroqlr5GHw+j7LwjT
         69pw==
X-Forwarded-Encrypted: i=1; AJvYcCXsQ/8erg1PdnBiCMz4HSLfQaETqZ9+7OYl3B0VtpyXurX9WXZ0DqHpO2v6KFjEw0Qvw6F9ZTbMT0FOwmhDHJ2nXaTR/9AA
X-Gm-Message-State: AOJu0YzzUwJNbsUOevWCyTFwE0JmwoGZhlLdhij1ymdZdfVLawV+rMCa
	To/APPjLWVSp81s/KSnmmmLMjRIsrZe5Jxh5grneqTXI24YuwJvw
X-Google-Smtp-Source: AGHT+IHHnSlCBBRX8/L4dQY5OopRdDp6aBmpsUlVcTc3KIcp2iwc8j7uJdOpWNtCbUBB0OYewRwx6g==
X-Received: by 2002:a17:90a:f009:b0:2c5:3dbd:58bc with SMTP id 98e67ed59e1d1-2c8613d5b39mr6810484a91.25.1719367457411;
        Tue, 25 Jun 2024 19:04:17 -0700 (PDT)
Received: from Laptop-X1 ([2409:8a02:7825:fd0:4f66:6e77:859a:643d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c8d81d2ae1sm327176a91.50.2024.06.25.19.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 19:04:16 -0700 (PDT)
Date: Wed, 26 Jun 2024 10:04:13 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: stephen@networkplumber.org, dsahern@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 iproute2 1/3] ip: bridge: add support for mst_enabled
Message-ID: <Znt3HVpvOk8Ocpjg@Laptop-X1>
References: <20240624130035.3689606-1-tobias@waldekranz.com>
 <20240624130035.3689606-2-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624130035.3689606-2-tobias@waldekranz.com>

On Mon, Jun 24, 2024 at 03:00:33PM +0200, Tobias Waldekranz wrote:
> When enabled, the bridge's legacy per-VLAN STP facility is replaced
> with the Multiple Spanning Tree Protocol (MSTP) compatible version.
> 
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
> ---
>  ip/iplink_bridge.c    | 19 +++++++++++++++++++
>  man/man8/ip-link.8.in | 14 ++++++++++++++
>  2 files changed, 33 insertions(+)
> 
> diff --git a/ip/iplink_bridge.c b/ip/iplink_bridge.c
> index 6b70ffbb..f01ffe15 100644
> --- a/ip/iplink_bridge.c
> +++ b/ip/iplink_bridge.c
> @@ -30,6 +30,7 @@ static void print_explain(FILE *f)
>  		"		  [ max_age MAX_AGE ]\n"
>  		"		  [ ageing_time AGEING_TIME ]\n"
>  		"		  [ stp_state STP_STATE ]\n"
> +		"		  [ mst_enabled MST_ENABLED ]\n"
>  		"		  [ priority PRIORITY ]\n"
>  		"		  [ group_fwd_mask MASK ]\n"
>  		"		  [ group_address ADDRESS ]\n"
> @@ -169,6 +170,18 @@ static int bridge_parse_opt(struct link_util *lu, int argc, char **argv,
>  				bm.optval |= no_ll_learn_bit;
>  			else
>  				bm.optval &= ~no_ll_learn_bit;
> +		} else if (strcmp(*argv, "mst_enabled") == 0) {
> +			__u32 mst_bit = 1 << BR_BOOLOPT_MST_ENABLE;
> +			__u8 mst_enabled;
> +
> +			NEXT_ARG();
> +			if (get_u8(&mst_enabled, *argv, 0))
> +				invarg("invalid mst_enabled", *argv);
> +			bm.optmask |= mst_bit;
> +			if (mst_enabled)
> +				bm.optval |= mst_bit;
> +			else
> +				bm.optval &= ~mst_bit;
>  		} else if (strcmp(*argv, "fdb_max_learned") == 0) {
>  			__u32 fdb_max_learned;
>  
> @@ -609,6 +622,7 @@ static void bridge_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
>  	if (tb[IFLA_BR_MULTI_BOOLOPT]) {
>  		__u32 mcvl_bit = 1 << BR_BOOLOPT_MCAST_VLAN_SNOOPING;
>  		__u32 no_ll_learn_bit = 1 << BR_BOOLOPT_NO_LL_LEARN;
> +		__u32 mst_bit = 1 << BR_BOOLOPT_MST_ENABLE;
>  		struct br_boolopt_multi *bm;
>  
>  		bm = RTA_DATA(tb[IFLA_BR_MULTI_BOOLOPT]);
> @@ -622,6 +636,11 @@ static void bridge_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
>  				   "mcast_vlan_snooping",
>  				   "mcast_vlan_snooping %u ",
>  				    !!(bm->optval & mcvl_bit));
> +		if (bm->optmask & mst_bit)
> +			print_uint(PRINT_ANY,
> +				   "mst_enabled",
> +				   "mst_enabled %u ",
> +				   !!(bm->optval & mst_bit));
>  	}
>  
>  	if (tb[IFLA_BR_MCAST_ROUTER])
> diff --git a/man/man8/ip-link.8.in b/man/man8/ip-link.8.in
> index c1984158..eabca490 100644
> --- a/man/man8/ip-link.8.in
> +++ b/man/man8/ip-link.8.in
> @@ -1685,6 +1685,8 @@ the following additional arguments are supported:
>  ] [
>  .BI stp_state " STP_STATE "
>  ] [
> +.BI mst_enabled " MST_ENABLED "
> +] [
>  .BI priority " PRIORITY "
>  ] [
>  .BI no_linklocal_learn " NO_LINKLOCAL_LEARN "
> @@ -1788,6 +1790,18 @@ or off
>  .RI ( STP_STATE " == 0). "
>  for this bridge.
>  
> +.BI mst_enabled " MST_ENABLED "
> +- turn multiple spanning tree (MST) support on
> +.RI ( MST_ENABLED " > 0) "
> +or off
> +.RI ( MST_ENABLED " == 0). "
> +When enabled, sets of VLANs can be associated with multiple spanning
> +tree instances (MSTIs), and STP states for each port can be controlled
> +on a per-MSTI basis. Note: no implementation of the MSTP protocol is
> +provided, only the primitives needed to implement it. To avoid
> +interfering with the legacy per-VLAN STP states, this setting can only
> +be changed when no bridge VLANs are configured.
> +
>  .BI priority " PRIORITY "
>  - set this bridge's spanning tree priority, used during STP root
>  bridge election.
> -- 
> 2.34.1
> 

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

