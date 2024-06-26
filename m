Return-Path: <netdev+bounces-106743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F913917600
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 04:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DC921F21B86
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 02:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF80E1BDDC;
	Wed, 26 Jun 2024 02:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NO9sHyci"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80714FBFC
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 02:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719367687; cv=none; b=jfiKCFX1JKRA4Koh9lmHXNiVJu2H4tRCE0gQrM2unzBch6h87d3RnEpLDVehPOrqYJvWNO1aLszesgwBQyfzJ2K70VLxILf0h8JwdFagPDb4kg4P0FRZPux5Q4bOE40yzCgLGjBDQVetqj3TBMZb96cEu+dVi5h9n1CNXgILGeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719367687; c=relaxed/simple;
	bh=Ys01ZVuy0Jw6SobqHoxvN/Kkb1hjB5Lu+XNQA2bxyWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WxwB5iG2Xb52yTbyGlXHcF4jQNYiKQs7qwAYJKyuzpnvH2iLneqSzFK+zbXg7CVEs+a+FQCJIOuMq8XDgk0w7HsyaarHjh4IMmw5hPdVMg3W3j9OaHVwSig52qZTjzBM25ujCXm3xj+6X7NkgJpZe14SkfcaITsdhUJ++Kkc5q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NO9sHyci; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7067435d376so68974b3a.0
        for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 19:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719367686; x=1719972486; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Snn/BCHYrJ3+Uxt7ENO5jx5Ae3+sahv85UiMD85+ip8=;
        b=NO9sHycishjUAxNVXbNChWqhRHT3/zUOGw12Syt4YXAjwSRJfWB1PQJmMVnKaeJku0
         BHQxfzDFmud1gIwwgEZ8eSHDtIPpEk94nDnUTICBQZTutVv/yYdwXFmRVBAXo6waxTaQ
         ysfcVV2CiZGPDnkKyRenthonDKnKCvHZRvOGL+AQwF5P1BMt1Fth68OJAyN3X9I8aJ4d
         mEMwSO9jViFNPiUoflYL8wHMHZWvJny89CksvI2JwViov50Lo4TEios6dsSCKPrdGjTX
         y+Roz3hu2YipQ3zumtq7tIzW9GuCVkvYV3KehKkabWpAqW9k4u7zCsLPrWe+HGrUjWrE
         fXYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719367686; x=1719972486;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Snn/BCHYrJ3+Uxt7ENO5jx5Ae3+sahv85UiMD85+ip8=;
        b=tbxOs/tyannvHo5y4rJdrcS0wwgbZ097UfAGnlByBVzO/nLUSTJOqze5+/09JLRH/5
         dDW0ud/h6RikqQsZfRynD1imm+h0RzC4U165cLaudefngDO+Zi88wkqAudUCj549ltcq
         PnP11d+X6vSzm/IB66uRJpY8S5xk/4OriOiGErQ7936VuaLyYVMvF2yEV7An3gh4ADf2
         TwVzSGrKQIMtWOqGIZMle1E/R6I7PM52poXXSD5vF+Q62Hq/+QkhcuB7RZTXCnpt+/n8
         R8BXnVugvAIA9zfoX9od/0C27e8tZ3U5Nbuyyg9/X4ZEY5IrpPGYrZHw8fbQieFaw0S9
         /33w==
X-Forwarded-Encrypted: i=1; AJvYcCV6RXJnVe4CBmNaVVJI3vNjnjqyXR4P4ZTEZcSY8JNtgvdvgph27svUXB5feMB+UaUCxeRBb0PQiQhA8IPXMNGJIJbEHVoL
X-Gm-Message-State: AOJu0YwoVvrPhi7m6CF18HU1+fGXbvI5WP876fOPvVB62fGFiFxxethE
	xPzGSTXR13A0qbS922wWl1eMprXcHgrH27x0dEHW23XInt2HNMe5803r5f7ZMKg=
X-Google-Smtp-Source: AGHT+IEokwBJgMOz6ORbotLRGD0TviWllVMJFBMkwq8/gavQpVszQYbRQtvs7eECbC3/Hy7DRZgxvQ==
X-Received: by 2002:aa7:8882:0:b0:706:a8e8:65a5 with SMTP id d2e1a72fcca58-706a8e8667cmr368096b3a.23.1719367685632;
        Tue, 25 Jun 2024 19:08:05 -0700 (PDT)
Received: from Laptop-X1 ([2409:8a02:7825:fd0:4f66:6e77:859a:643d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7067a3759e8sm5288865b3a.206.2024.06.25.19.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 19:08:05 -0700 (PDT)
Date: Wed, 26 Jun 2024 10:08:02 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: stephen@networkplumber.org, dsahern@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 iproute2 2/3] bridge: vlan: Add support for setting a
 VLANs MSTI
Message-ID: <Znt4Aqa2Kbsa3odW@Laptop-X1>
References: <20240624130035.3689606-1-tobias@waldekranz.com>
 <20240624130035.3689606-3-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624130035.3689606-3-tobias@waldekranz.com>

On Mon, Jun 24, 2024 at 03:00:34PM +0200, Tobias Waldekranz wrote:
> Allow the user to associate one or more VLANs with a multiple spanning
> tree instance (MSTI), when MST is enabled on the bridge.
> 
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
> ---
>  bridge/vlan.c     | 13 +++++++++++++
>  man/man8/bridge.8 |  9 ++++++++-
>  2 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/bridge/vlan.c b/bridge/vlan.c
> index 0a7e6c45..34d7f767 100644
> --- a/bridge/vlan.c
> +++ b/bridge/vlan.c
> @@ -56,6 +56,7 @@ static void usage(void)
>  		"                      [ mcast_querier_interval QUERIER_INTERVAL ]\n"
>  		"                      [ mcast_query_interval QUERY_INTERVAL ]\n"
>  		"                      [ mcast_query_response_interval QUERY_RESPONSE_INTERVAL ]\n"
> +		"                      [ msti MSTI ]\n"
>  		"       bridge vlan global { show } [ dev DEV ] [ vid VLAN_ID ]\n");
>  	exit(-1);
>  }
> @@ -406,6 +407,7 @@ static int vlan_global_option_set(int argc, char **argv)
>  	short vid = -1;
>  	__u64 val64;
>  	__u32 val32;
> +	__u16 val16;
>  	__u8 val8;
>  
>  	afspec = addattr_nest(&req.n, sizeof(req),
> @@ -536,6 +538,12 @@ static int vlan_global_option_set(int argc, char **argv)
>  			addattr64(&req.n, 1024,
>  				  BRIDGE_VLANDB_GOPTS_MCAST_STARTUP_QUERY_INTVL,
>  				  val64);
> +		} else if (strcmp(*argv, "msti") == 0) {
> +			NEXT_ARG();
> +			if (get_u16(&val16, *argv, 0))
> +				invarg("invalid msti", *argv);
> +			addattr16(&req.n, 1024,
> +				 BRIDGE_VLANDB_GOPTS_MSTI, val16);
>  		} else {
>  			if (strcmp(*argv, "help") == 0)
>  				NEXT_ARG();
> @@ -945,6 +953,11 @@ static void print_vlan_global_opts(struct rtattr *a, int ifindex)
>  			     "mcast_query_response_interval %llu ",
>  			     rta_getattr_u64(vattr));
>  	}
> +	if (vtb[BRIDGE_VLANDB_GOPTS_MSTI]) {
> +		vattr = vtb[BRIDGE_VLANDB_GOPTS_MSTI];
> +		print_uint(PRINT_ANY, "msti", "msti %u ",
> +			   rta_getattr_u16(vattr));
> +	}
>  	print_nl();
>  	if (vtb[BRIDGE_VLANDB_GOPTS_MCAST_ROUTER_PORTS]) {
>  		vattr = RTA_DATA(vtb[BRIDGE_VLANDB_GOPTS_MCAST_ROUTER_PORTS]);
> diff --git a/man/man8/bridge.8 b/man/man8/bridge.8
> index bb02bd27..b4699801 100644
> --- a/man/man8/bridge.8
> +++ b/man/man8/bridge.8
> @@ -266,7 +266,9 @@ bridge \- show / manipulate bridge addresses and devices
>  .B mcast_query_interval
>  .IR QUERY_INTERVAL " ] [ "
>  .B mcast_query_response_interval
> -.IR QUERY_RESPONSE_INTERVAL " ]"
> +.IR QUERY_RESPONSE_INTERVAL " ] [ "
> +.B msti
> +.IR MSTI " ]"
>  
>  .ti -8
>  .BR "bridge vlan global" " [ " show " ] [ "
> @@ -1493,6 +1495,11 @@ startup phase.
>  set the Max Response Time/Maximum Response Delay for IGMP/MLD
>  queries sent by the bridge.
>  
> +.TP
> +.BI msti " MSTI "
> +associate the VLAN with the specified multiple spanning tree instance
> +(MSTI).
> +
>  .SS bridge vlan global show - list global vlan options.
>  
>  This command displays the global VLAN options for each VLAN entry.
> -- 
> 2.34.1
> 

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

