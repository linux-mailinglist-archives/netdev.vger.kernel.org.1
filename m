Return-Path: <netdev+bounces-154950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE458A00757
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 10:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2009E18841C4
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 09:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415841EE7A4;
	Fri,  3 Jan 2025 09:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="WVEICf6v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FF31D151F
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 09:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735898391; cv=none; b=epNo9pAuglHMtv0LpIVdVqFgCjM2fjhAmh75pQx7QKT//JeNQ/jIfRfO8mwAhZGyUdPwXRBFMl3OFTQxn+HHeGB0w1+lVrCldldMJJxLvs3Z1lJy69rdE8eix3lWGNEhmCfTFTi1+Lj72TINUjPywLuGPwEX4zzHBnhfGYR+Tv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735898391; c=relaxed/simple;
	bh=wII6R6CkHTELP4m9fEmWPJ1g3/ccW7pwWwr3aaYh1RA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gh5aO4FpAmQVW4BdP6cM0W/I2/zzn/FHGbVjtuV36nKxC6dn2yqsQw+bqmKnS6ok8KBBMJUc7oQkjtAAgnMkxW3sKUk6OrX3TIHlvDJkvmu/cpc+Sa86CS5XacwZRWC02hWbuwQhL77CxymQajfLidJtXiAITQ1UAv8ZWubc+e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=WVEICf6v; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d3cf094768so19475816a12.0
        for <netdev@vger.kernel.org>; Fri, 03 Jan 2025 01:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1735898387; x=1736503187; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FF5769PjL+UoPJW3i3hqulJto6e1WeUkfttVmz9CJ9c=;
        b=WVEICf6vv5IZnZlwhT4y+5egafA9BQS6TRaokGGtBGUmUVH8aTU/OzQiZDw3dUqqXq
         CsV9aPLd4y+jNyeStcS8N5R4iL9F3COyyBCCbTEd7RES290EmWgHjfWlbFTVBsh/aiFx
         ZqcmVSPfwG4nmVEvOXcO1qr+VpGyxmNoPXTVfdErKSD6nsuKqFQyi8YiOXUj7iJaVbBk
         MoYebOP39ozpVICNRftg2BKJf85539NqXEtcmyoJqGg25VdpmUE5WmCALES9sP2Dqbf2
         ZAgDHVLd3J1TKgp5yd7K+CBRskClueDXBeKkoS7/evZcA7NgkAyxig31exePK6vPMN8W
         IDuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735898387; x=1736503187;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FF5769PjL+UoPJW3i3hqulJto6e1WeUkfttVmz9CJ9c=;
        b=qXjA/WFueXUhYpuMww69cTo+Uz24Npr0Vn4J1UznuHokKE0JYJxsMubIYSm3P4UiRc
         exN64d139Szsn9RRnl6p5mFoDVzegQEeXM6N3RDMOxRhPnPGJcSXtMB8bNDflYvX9llU
         +2obXRACb02JixYC/eYfHEW7X4bPJBnzjfbmh2kIVh5sUMRuoHoiY6+pvfUkfW5DzL4z
         NCd1DK3Hw995cwo+61teWrrZZeIRfIxdYkLnFl6HRpfzGIqZzPxx+pkKjPbzjCg0X2sM
         HSeRyF2SXe/kXaiPh8YVXZ+8x+YnmVPkMZttD7gokpYPM+jQMEKfWunfBc7y7ToalYzm
         Do+w==
X-Forwarded-Encrypted: i=1; AJvYcCUNHLgsXYg00UWva3Pb8OVvHJFo3Qs7io7eLOzXtpCcB4n5UrOqO36rmjBxUSs00MPwqjuQntM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx2pE+vqp5WnA3eNYK9Ufklg7/Ehncy9YXHTADx2BABooYk2X8
	5FeWD144nzAZdWYJISqML2PqWn+zoXfKj342IRTK+UnQU7+uW6BvMab/vFwVbhnI8TGcZmyB62/
	u
X-Gm-Gg: ASbGnctFPmGIMU+dOxNM/AZNBEaT7bHzALFqIag3o+uXRxQpOSq7DL7oVsadlSc4w1L
	XzHyz/9kd4iqiIA4OtrXqPRUTAApiCvLWWBNLqfEt2gxvptvKZGvzV3s7sPYQcKT5/pn/Tbg5lf
	2HIliPiJp3Px4qTWgcSoVgPhuM/XbRRsboCbFWFfK2kXDgZRrfeNrLYTY5vpmoV8T/SrJnHvW43
	HG/BIiTTLU5dYN++SFBQMTFg/I6cl+Brh3k4zpR8NLPdeM/GkMR3Urm6MVflJnTcntNM0IvQePL
	zNlQeSzRM8fq
X-Google-Smtp-Source: AGHT+IHFNrVbuHUJ42+AEeZKTZ9A8Laq0Bh/ynnBiMncFarn5T5E60lnEdA/r32vm961/qNqZfpdMw==
X-Received: by 2002:a17:907:3f8a:b0:aa6:acbb:3653 with SMTP id a640c23a62f3a-aac27027037mr4671567966b.12.1735898387309;
        Fri, 03 Jan 2025 01:59:47 -0800 (PST)
Received: from [192.168.0.123] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0f01608fsm1864529366b.150.2025.01.03.01.59.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jan 2025 01:59:46 -0800 (PST)
Message-ID: <e7a27b5f-a4fc-4eaa-b215-d7a1bb7fc234@blackwall.org>
Date: Fri, 3 Jan 2025 11:59:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bridge: Make br_is_nd_neigh_msg() accept pointer to
 "const struct sk_buff"
To: Ted Chen <znscnchen@gmail.com>, roopa@nvidia.com
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org
References: <20250103070900.70014-1-znscnchen@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250103070900.70014-1-znscnchen@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/3/25 09:09, Ted Chen wrote:
> The skb_buff struct in br_is_nd_neigh_msg() is never modified. Mark it as const.
> 
> Signed-off-by: Ted Chen <znscnchen@gmail.com>
> ---
>  net/bridge/br_arp_nd_proxy.c | 2 +-
>  net/bridge/br_private.h      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bridge/br_arp_nd_proxy.c b/net/bridge/br_arp_nd_proxy.c
> index c7869a286df4..115a23054a58 100644
> --- a/net/bridge/br_arp_nd_proxy.c
> +++ b/net/bridge/br_arp_nd_proxy.c
> @@ -229,7 +229,7 @@ void br_do_proxy_suppress_arp(struct sk_buff *skb, struct net_bridge *br,
>  #endif
>  
>  #if IS_ENABLED(CONFIG_IPV6)
> -struct nd_msg *br_is_nd_neigh_msg(struct sk_buff *skb, struct nd_msg *msg)
> +struct nd_msg *br_is_nd_neigh_msg(const struct sk_buff *skb, struct nd_msg *msg)
>  {
>  	struct nd_msg *m;
>  
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index 9853cfbb9d14..3fe432babfdf 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -2290,6 +2290,6 @@ void br_do_proxy_suppress_arp(struct sk_buff *skb, struct net_bridge *br,
>  			      u16 vid, struct net_bridge_port *p);
>  void br_do_suppress_nd(struct sk_buff *skb, struct net_bridge *br,
>  		       u16 vid, struct net_bridge_port *p, struct nd_msg *msg);
> -struct nd_msg *br_is_nd_neigh_msg(struct sk_buff *skb, struct nd_msg *m);
> +struct nd_msg *br_is_nd_neigh_msg(const struct sk_buff *skb, struct nd_msg *m);
>  bool br_is_neigh_suppress_enabled(const struct net_bridge_port *p, u16 vid);
>  #endif

Hi,
This should be targeted at net-next (subject should be PATCH net-next).
Also please try to keep commit message lines shorter, checkpatch flags
this one as over 75 characters. You should wait 24 hours before posting
v2 of the patch.

Other than that the patch is ok.

Cheers,
 Nik


