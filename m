Return-Path: <netdev+bounces-306660-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id we1oLOlCUWrHBQMAu9opvQ
	(envelope-from <netdev+bounces-306660-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 21:07:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A3673D882
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 21:07:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=VY16zhBd;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306660-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-306660-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B17C3300BBA9
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 19:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9484C3812E5;
	Fri, 10 Jul 2026 19:07:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pz2-f0.google.com (mail-pz2-f0.google.com [74.125.228.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3007437EFE6
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 19:07:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783710439; cv=none; b=nsukFhOG+SokwwUWkKFZS9MgN49lvq+bFrMzVKWSMOXROkkUNBg323z/5VZeZoLu4H17PKT1y/YRq7kclQJdcQnThCUVGr3WbJGvpoFeqx4pm46jNT/WxMNbHdjq7xMNDf2Jg1EW4GSTu8VB5zkZndEmuXhDom+D/Nb1Qt4xqZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783710439; c=relaxed/simple;
	bh=SEmPD7JblkDJEFTqqdJbX3FS5ZS5bnh861fzGASB8Vs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fa06b04CapoFwlUEQOatiTCFov+mzwb6I1fkSNTg0b5kg0YeDJsgAaH0kLmkx2ahMJUR4wF3yd1OwH7eVKMKOm3WOgqflMMIlefOriwCNOMFZjhXSR3iclxIIF+//Bz5JzX7WD4+lfFXQsipRxjztvn4X21w6H1hXQ6wqVTatg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VY16zhBd; arc=none smtp.client-ip=74.125.228.0
Received: by mail-pz2-f0.google.com with SMTP id 41be03b00d2f7-c95bd574471so512856a12.0
        for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 12:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783710437; x=1784315237; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VWBjaJanp528VpTu2TOH4GFEEplwcn9VXFowenlC8oo=;
        b=VY16zhBdtvy8kx0Qv3/hNaOhjnG+AsRpAtHwJdWQXyXY2iDIpqNvSe3OR78QpwFJef
         9Z4Rs7WoagyIscid+iGekoOmkLJIqKgciOgSz9eTfjt12R/+DlUB8fotKygOdh8rXi2n
         USfusKgkb56lRVfYj7taPDzNhnNkJOIjQZhrejCe2z8kmXi9eU5+nZmbfDWh9TiUpwOP
         LzyCPX8mnj32gowWADaZ7I+kuMYEtm3khD5+2OmkGFCupUiM8n55Stk2+gxghiAc8tuj
         rxszWrSknPTCWkBnTabQxFOZDUedGK20qcgPYyERN4ZwEPCYlDX8J7eUEYt+H92bRFO7
         51mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783710437; x=1784315237;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VWBjaJanp528VpTu2TOH4GFEEplwcn9VXFowenlC8oo=;
        b=MVe8ErVp8vob0XtRVgVE/WrhYwhKK0dww1qOPCSZZBE32xfi+bN5YLUuJ0f8I0Rgrm
         ArMyhI34KmVGdOaP7OIQwpqTpAx3gbhY21Trvtz6+O7DpfnJY7aAsroKCSzGFYd5Z+K+
         cIHLWZK3gOrg9uyjcfaaBnVH48zy+Q09Ytsuc1wzvUxQA6M9UG3Ekzq4wVHPrmfR1nK1
         FSCREOsLeVpheYewgjfbYvpqhCNuAUy39PB4QqE6WAvsy9QsVpGQz0RZhb3jH6rxhNLh
         ccFIyjwGctVId41vtjhEDZi0EiOWyPf9uyM5fzMfzLvGp0XZFvkBF/R2Sm/AEMXT/8vu
         x50g==
X-Forwarded-Encrypted: i=1; AHgh+RrwOmQlOk/XSNSUfyiNFtVlRaX4IF8lnJL+5EDU1XgI2P6t1GcR6wfPGUETdpUwBBYe61jeQh4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy95UEd6BDu5g2BbpjvBuGhKAlR66CgdiXqfjS7rVa+Vji49Tev
	NViQnHOiyhZj+7Z0BWqgJM6wXqW6qRvoGyyxijwID9tXgiyfrr6fSFXw
X-Gm-Gg: AfdE7clWo1fEnjN4ExZdxjQztL0frO5iSPx/gF7xpwhu08B9GgPbZpP9y2ql+g2cq1N
	oHLTImIUuAdhLwJlyx1MqmLPBY//ZGT5coesVr4NEJsXJD6hJLzgpbj0PvN1XdnbA5s4lyjwoLU
	osVJSIg0cOxJTD1umz94IrBQg9dpTkHeXFnt7N1RqZNksH7kWbvqHP9K1TxMAcUSu3FacZ0enz9
	FDBd+/3SeqycinhSmsx9IQ4PPGY7jowbwnXB2ZOPsxL2go7JObmGN7UJyZZyhuHcABuYHo5dv9E
	tDLVmF8juBV8Qm1lFZIPYdfmlWkieOn9sT2z/K0L2sWdq3PVeOAzIe12TbZ97ohRC4t5kYEmN24
	69ul58PKQzzp1pWI10iDf9GDp+tHqe6lCuS9k6Z+B63p8N3KUcOEixF/kke/VDqzfyTFL6O57me
	cp76OLXhITspT5l/X+
X-Received: by 2002:a05:6a00:180b:b0:848:2eac:bfb2 with SMTP id d2e1a72fcca58-848895db4e2mr303610b3a.13.1783710437502;
        Fri, 10 Jul 2026 12:07:17 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4f::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84856e7c8edsm3299574b3a.36.2026.07.10.12.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 12:07:17 -0700 (PDT)
Date: Fri, 10 Jul 2026 12:05:23 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Vladimir Vdovin <deliran@verdict.gg>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, 
	Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v4 1/6] netlink: specs: Add XDP RX checksum
 capability to XDP metadata specs
Message-ID: <alE8oBxkrak8n602@devvm7509.cco0.facebook.com>
References: <20260708203410.45121-1-deliran@verdict.gg>
 <20260708203410.45121-2-deliran@verdict.gg>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260708203410.45121-2-deliran@verdict.gg>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306660-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:deliran@verdict.gg,m:lorenzo@kernel.org,m:donald.hunter@gmail.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:andrew+netdev@lunn.ch,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:aleksander.lobakin@intel.com,m:andrii@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:kpsingh@kernel.org,m:haoluo@google.com,m:jolsa@kernel.org,m:shuah@kernel.org,m:maciej.fijalkowski@intel.com,m:jakub@cloudflare.com,m:aleksandr.loktionov@intel.com,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:intel-wired-lan@lists.osuosl.org,m:linux-kselftest@vger.kernel.org,m:donaldhunter@gmail.com,m:johnfastabend@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[33];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,davemloft.net,google.com,redhat.com,iogearbox.net,fomichev.me,lunn.ch,intel.com,linux.dev,cloudflare.com,vger.kernel.org,lists.osuosl.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,devvm7509.cco0.facebook.com:mid,verdict.gg:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 49A3673D882

On 07/08, Vladimir Vdovin wrote:
> From: Lorenzo Bianconi <lorenzo@kernel.org>
> 
> Introduce XDP RX checksum capability to XDP metadata specs. XDP RX
> checksum will be use by devices capable of exposing receive checksum
> result via bpf_xdp_metadata_rx_checksum().
> Moreover, introduce xmo_rx_checksum netdev callback in order to allow
> the eBPF program bound to the device to retrieve the RX checksum result
> computed by the hw NIC and reported via DMA descriptors.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Signed-off-by: Vladimir Vdovin <deliran@verdict.gg>
> ---
>  Documentation/netlink/specs/netdev.yaml |  5 ++++
>  include/net/xdp.h                       | 18 ++++++++++++++
>  include/uapi/linux/netdev.h             |  3 +++
>  net/core/xdp.c                          | 32 +++++++++++++++++++++++++
>  tools/include/uapi/linux/netdev.h       |  3 +++
>  5 files changed, 61 insertions(+)
> 
> diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
> index 5f143da7458c..6d0d90d3a614 100644
> --- a/Documentation/netlink/specs/netdev.yaml
> +++ b/Documentation/netlink/specs/netdev.yaml
> @@ -61,6 +61,11 @@ definitions:
>          doc: |
>            Device is capable of exposing receive packet VLAN tag via
>            bpf_xdp_metadata_rx_vlan_tag().
> +      -
> +        name: checksum
> +        doc: |
> +          Device is capable of exposing receive checksum result via
> +          bpf_xdp_metadata_rx_checksum().
>    -
>      type: flags
>      name: xsk-flags
> diff --git a/include/net/xdp.h b/include/net/xdp.h
> index aa742f413c35..e255ff786131 100644
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h
> @@ -586,6 +586,10 @@ void xdp_attachment_setup(struct xdp_attachment_info *info,
>  			   NETDEV_XDP_RX_METADATA_VLAN_TAG, \
>  			   bpf_xdp_metadata_rx_vlan_tag, \
>  			   xmo_rx_vlan_tag) \
> +	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_CHECKSUM, \
> +			   NETDEV_XDP_RX_METADATA_CHECKSUM, \
> +			   bpf_xdp_metadata_rx_checksum, \
> +			   xmo_rx_checksum)
>  
>  enum xdp_rx_metadata {
>  #define XDP_METADATA_KFUNC(name, _, __, ___) name,
> @@ -643,12 +647,26 @@ enum xdp_rss_hash_type {
>  	XDP_RSS_TYPE_L4_IPV6_SCTP_EX = XDP_RSS_TYPE_L4_IPV6_SCTP | XDP_RSS_L3_DYNHDR,
>  };

[..]
 
> +/* Please note the driver is required to invalidate the checksum if the NIC
> + * reports CHECKSUM_UNNECESSARY or CHECKSUM_COMPLETE and the eBPF program
> + * modifies the packet since it can change some fields validated by the
> + * checksum.
> + */

Sorry, a bit confused about this part. IIUC this is in response to this
discussion https://lore.kernel.org/bpf/aaLYfWnuuf_ne72u@lore-desk/ ?

Looking at a few drivers:
- bnxt (bnxt_rx_pkt) does UNNECESSARY - ok
- mlx5 (mlx5e_handle_csum) does UNNECESSARY and skips COMPLETE if there is
  bpf prog attached
- fbnic (fbnic_rx_csum) - can do COMPLETE even with xdp attached?
- gve (gve_rx) - can do COMPLETE even with xdp attached?

So none of the drivers invalidate anything (and nether the bpf machinery), some
choose to (correctly?) not report COMPLETE when there is XDP. So was the
discussion about documenting this and giving some guidance? This probably
belongs to that `DOC: skb checksums` section of include/linux/skbuff.h?

Also, can you add your new rx_checksum to
Documentation/networking/xdp-rx-metadata.rst's list of supported kfuncs?

