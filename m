Return-Path: <netdev+bounces-256188-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eORSIxGwgWn+IgMAu9opvQ
	(envelope-from <netdev+bounces-256188-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 09:21:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07072D628A
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 09:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E374B3009F14
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 08:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86AD395D9D;
	Tue,  3 Feb 2026 08:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YSbc4qn4";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oCL8voa1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D5439448B
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 08:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770106893; cv=none; b=o3rBeWyaB67NX0jifEyQIQYL6Sv538q5CGOPC6Z/mVamAhaZcskrTvvfl3g9FWhiMmYpRL3UCVv2tDRGpeYlA1iwXsQ7cV/7VMu+gbFDBIdeR4ec4oMOQTIVdn0BWtMkarZiQ5iBLU8+CSDrsuR81/zi7KIMUl3VFkSDXng7oLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770106893; c=relaxed/simple;
	bh=j13cQCPRXYP43932eH3JGU5TFuadVDbX/7AnAEjIArs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eegOB38W6Py3Knnl5VTzeNg6F24rR7Q4nX7oV+v50bjmWrJRq4cRzXZv30kND0g8nk6tkPGMZMsAQEAoFJvuInSTTft58tzxYjavm/VU3BhlTEMEvKVFRlHGH6myxCfLmE70lkZsspZiX5n12SZ6SzU+1pRDl8XGFDj8retHp5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YSbc4qn4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oCL8voa1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770106876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uQ5Rv/3peZw/4Pd0hdC6ea5luKXUiE1fJEhMVzX2UZc=;
	b=YSbc4qn4eLV1WEPB3cgPc9xpFqLdJssdwlvG+Uigp9tRLYprxW5kR8jLIx+i8TvHhVGhSX
	MIyGH2ISUnOanhrfbmbGOLu5TtcDMMzuZH1TrrvQ1C8jr7Ci5nFRE/B7sOubBG3Xf5Psy1
	uZgsMDDkwocF86CoeSIsIGeios2/0Ww=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-_-r1kXmKM8SPmG8D7-g_Zg-1; Tue, 03 Feb 2026 03:21:15 -0500
X-MC-Unique: _-r1kXmKM8SPmG8D7-g_Zg-1
X-Mimecast-MFC-AGG-ID: _-r1kXmKM8SPmG8D7-g_Zg_1770106874
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-431054c09e3so4690096f8f.0
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 00:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770106874; x=1770711674; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uQ5Rv/3peZw/4Pd0hdC6ea5luKXUiE1fJEhMVzX2UZc=;
        b=oCL8voa1Cpl+N5P13rZjDHbcXIzpi/aSOyIqgYRXOV9f3n1ZVOQakyD4TRHOCpkN3k
         MFSInsaXzv116PUIWPIyJr+MpavtD+a4m6nengE+zuxsmmGoWRfw07gauLRZTVxGPSqd
         9HPtHQMbJJ5g0EHH2pNgO999Mj5b/r1VXlfzI/Y1pmm+bCpYeScOH9FGQVnqhF5fObTN
         6Hy0+iZazQRigKeUjt0r+hfkqoEaggV1S2WU+z93OE+wBh9jNV0oa983ZtgIm6eu08WF
         TE5N/byo8Dw4reOJxdTh/TUpIqpzsU/ebJR8YNM8/IeA6O1cCELGl4gfFPRuJu/aNrs8
         Fqkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770106874; x=1770711674;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uQ5Rv/3peZw/4Pd0hdC6ea5luKXUiE1fJEhMVzX2UZc=;
        b=U+Mh/S2xkKIGdXwmj15u67cwevLvFTULceoqzgtEZi5yh9R0SyzXNjV12Qzq5baPOo
         RZ4trlQbeSaYhmLYzA7329l4CDTAjer/DGNosAj6RD0NUn4SAZ2gzHq+fbEoxqsCexTi
         x+Q9Fr8qhtB8N58dR04IVEuCF0T+km7Z/RAEqyrWWRY4XmtQMhhy7ZHjPpJPowRYJ4Uu
         OP8ShGm40jcvd4IFHozqatD5BDcruEcTS5sbt46K2iMpkEPOt8P91wi57qkDMWhFXwEr
         vb46CIDejYxYQvhCNkUM+/SxNmL1yD7jrrfAJJdPkdmHnclURIe4E9t1Sit5W2ONtYj6
         2WGQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6sqEWKQXSCiFC3596Sn7COCJzb/iix1IEPb/ju2GXIek3PwXQW0/aLgJST0YOVhjAT4yw/Ls=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfP6HKpnf4sWhqdrE94qpJqWerGOr4tkzfhsoGJ9IqG5+s672H
	puNASPz3uqrq8jDst5ETvRe83QuCZxrTpM8eKi4DMFnWh/6xssSc/7FLcXKtIYB6jIgvzjXFCGo
	9SaXwRUEIAjPDHMVHfIaEAbFaotStGbJR8K7ldD1XcYQVpnl6I6N6k477oA==
X-Gm-Gg: AZuq6aK0PJZapOqP89pV4R5lZXiR8wr/mKF+Tl8Vxg2LvF4DRXIRBX/x+cPXCV0gvrN
	1qrxXbYdf8kSTfp0/i7cLFIij2I6hFjQG6mcQsGZr/7ZggzD+YuRga0kH7Qa1I3R/MHb3okSc4I
	94nfobzAUJd/kRBiE2XZD8j5NGQPYMxO8Vjo7u+X4o6NUC+T822DrriHdgKifmUHjmAR0nel3WJ
	08dTQX5XFkZuw3JP9pJ6Aulq9Q+bMNSP2aD4cHsreCDM5qOKOpmGNzZaWfBz6O92TU6G6pZhaZ2
	mE0ro7UcddzouTR80qrYEdwiXOs8q1V9BeigUPMpZrq8n7ryY8THVaamgea7fWq6GVXmxP5Mcg1
	16upI1+06+Rs=
X-Received: by 2002:a05:6000:2505:b0:42b:3806:2ba0 with SMTP id ffacd0b85a97d-435f3a6fd1bmr18500444f8f.2.1770106873788;
        Tue, 03 Feb 2026 00:21:13 -0800 (PST)
X-Received: by 2002:a05:6000:2505:b0:42b:3806:2ba0 with SMTP id ffacd0b85a97d-435f3a6fd1bmr18500421f8f.2.1770106873336;
        Tue, 03 Feb 2026 00:21:13 -0800 (PST)
Received: from [192.168.88.32] ([150.228.93.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10e4762sm48173246f8f.6.2026.02.03.00.21.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 00:21:12 -0800 (PST)
Message-ID: <e3a7f4b4-3569-422b-873f-0f4e1f11392b@redhat.com>
Date: Tue, 3 Feb 2026 09:21:08 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 02/11] net: tunnel: convert iptunnel_xmit to
 noref
To: Marek Mietus <mmietus97@yahoo.com>, netdev@vger.kernel.org,
 sd@queasysnail.net, kuba@kernel.org
Cc: Jason@zx2c4.com
References: <20260127070452.6581-1-mmietus97@yahoo.com>
 <20260127070452.6581-3-mmietus97@yahoo.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260127070452.6581-3-mmietus97@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256188-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[yahoo.com,vger.kernel.org,queasysnail.net,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 07072D628A
X-Rspamd-Action: no action

On 1/27/26 8:04 AM, Marek Mietus wrote:
> diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
> index cf37ad9686e6..a0d699082747 100644
> --- a/net/ipv6/sit.c
> +++ b/net/ipv6/sit.c
> @@ -1028,6 +1028,7 @@ static netdev_tx_t ipip6_tunnel_xmit(struct sk_buff *skb,
>  
>  	iptunnel_xmit(NULL, rt, skb, fl4.saddr, fl4.daddr, protocol, tos, ttl,
>  		      df, !net_eq(tunnel->net, dev_net(dev)), 0);
> +	ip_rt_put(rt);
>  	return NETDEV_TX_OK;
>  
>  tx_error_icmp:

Could you please double check that all ndo_start_xmit caller are under
RCU protection?

Specifically I don't see it in the
xsk_generic_xmit()/__dev_direct_xmit() path.

/P


