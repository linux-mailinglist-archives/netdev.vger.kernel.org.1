Return-Path: <netdev+bounces-295095-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9fb+B6M3IWoHBQEAu9opvQ
	(envelope-from <netdev+bounces-295095-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 10:30:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8561C63E009
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 10:30:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=gpf8wxbt;
	dkim=pass header.d=redhat.com header.s=google header.b=jvWL7RcE;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295095-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295095-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8327301DB90
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 08:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97A93E0232;
	Thu,  4 Jun 2026 08:21:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13C73E00A3
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 08:21:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780561300; cv=none; b=LDne0hWRyXurWJk4ezGKACWQ0xtFeMNLDOQBhoNqr0bPTB/E41LAZ7Tl3x4H1MLCjU5gjUMaRchaISwhSkK7zUC9lDaEboHqd9UHTTTwp2McwsThK7qFC+34zyPSJtdsoGy90z5MmGhJutQKccvTXU/9GtQFzMsTQ9MJlIiMJHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780561300; c=relaxed/simple;
	bh=lyLEVoSy7cPnWoRIV7vp/WX8YuoCgz/kRZmaoRluvWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RrouVgWihdvsY3uKmi+I1IJN/UX868oXnar9tCBuy9A4MMhPfZOtox0xgw/Nrit/lxAos/JsJulSMNcgyfwxj5G6C+nqM8iFB5BuHXxfnK20wdVJzOlt3/auuq0QJHsyZITvu0HDdlQdD7fHgFsCUVkVvYvGC5bnmrctBeN5e3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gpf8wxbt; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jvWL7RcE; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780561298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PZcGJsSal8T9WZ+z65zYJjCayJlSk9Z139NGTW50LAo=;
	b=gpf8wxbtf0rW8XJvWGDc9h91cqPiXCQyDINGnsjhd9m9ZczugParRGTz+Bne0xTHtuYNfs
	uFlt/Yie/Yvj7If/7q8tWufbUPe89d6l2wnyQp/pj6cYsgqpdVb5KW3tLj/be8yiWNmZkg
	mt2NBni10vZFjFa+2c+lGs9XwDEsgPs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-AWRDrR7VMP6oisADUDEJJQ-1; Thu, 04 Jun 2026 04:21:35 -0400
X-MC-Unique: AWRDrR7VMP6oisADUDEJJQ-1
X-Mimecast-MFC-AGG-ID: AWRDrR7VMP6oisADUDEJJQ_1780561294
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490b3f53c81so1707535e9.3
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 01:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780561294; x=1781166094; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PZcGJsSal8T9WZ+z65zYJjCayJlSk9Z139NGTW50LAo=;
        b=jvWL7RcEriPW5qVy4EQR6lHkaWf5KtsOvEx3oq3oRtGGRFs8iwLMUfSim9kY2X8JbL
         tTqfpOO53ODwTXunCP2z4lyshNq4nw3fhOsA7ilaPg45S6eyvTadXF1nVgJAEI4euqyf
         14qm33ya7hvTq2/uquE0WQurOwGGdm1CuPhANZnBAtScOTLSdKiN6PB8OXxV28h60z46
         xbyBZeVEMjCKV3GGpbyod61YtzgRWgJf1A2EMsj1/VEtshJRTl+g7Twnx/d24yALgIp4
         W3S27xuXdC6cOJqEx7xcoVs4nxqWzPdHrPRJHBgREUu+X2+p8Rcw1HU2gB+u1GJk6a21
         2WjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780561294; x=1781166094;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PZcGJsSal8T9WZ+z65zYJjCayJlSk9Z139NGTW50LAo=;
        b=Doh8xP9XKJwGMJCvPxdZr8vwEh11LELR5LR6CtRvBjC3bYPR7W9ZWNvn5zw1jqRVbt
         2uzsZpyQ9Lsfm2KNWyZq3l+jCoEDWt3LbxJ6czESIwaMTXFEycGuC+j9jhwYIImEd2v3
         PsNtOqIZ/fN93jYyPvwsAzxmTvozQyIySJvCCSr7LsN0lULOEDBmQCDPvLoSXXKABYzY
         RDOhZeU2iuOyIKKN9IeLXzLwdFPEYu2inR58NX6IahZ1tRve5QXktHVXF7ikKH5Uai22
         1bEZhkrJmjjwiPuDDBh9FbFtqjSzuTLH3KoF54yelQvn+gT0cCbQIeLa1fOwDmTwWX/i
         2PXQ==
X-Forwarded-Encrypted: i=1; AFNElJ/2TuzvKT96Nid/h6rvq8n3s2JkiFM/d5pOQ15/WWOmFCDScxIEJ02KKA2YLdQN/8S9FPMMRlc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu3GzzuK+TK3IKdNiErogOVRi6ZGEQe5OyWPiTt94lPCYnmqfS
	wJtDweLtWMWUYVNz7A4Jf4faXXpkqL6ihEQjQ0i59REUJg7dmtUSCOlxkKhPQUkHruNSNuc8M00
	GPgiStl8gWymBC8Y9O0FHlpOk9+AoTP8HWfOU/QdYRSXH5cxhm7hiuca1pw==
X-Gm-Gg: Acq92OGct6t9WsJBogC6UdTHcDLwJEdKjxBtPGwtZhrEzLYZf3j3wrB72PHyNT4EcdH
	lploTreB4UTfVdQerm0MEwy8SE/FqwUsvu9gB5BWQ+HyP+x+hNCsu3/EbnPQEWNGztYDwbNyMIL
	vOan0Dz+ZUwXSYUWMeEv3MljJnVQ5a5yMM2IFGQ8jy+Ub4v+1P0nOoOMC1dZzm9RqRG6x5dfLBp
	YACo5XSGwl296Wykyb9X/3hJgT6LpJ7937o90Z1DEy+VKqNhE61tQa9qM0rk9c+KZXhQWtjWuc5
	vu1Kl8bZxjSdulReHgTInPtaR6QuLKxsunNMTgJBfvIMAiBCfbubHIFlofSFP1jUCpT8fqfiKTk
	NEDMFNr2eZsvOENBzTgeAfcVhRcOYahaP5Q6mlulM4HRZx7k3X8N8TglY1xgHqJpLrsk=
X-Received: by 2002:a05:600c:1f96:b0:490:53d3:47a9 with SMTP id 5b1f17b1804b1-490b5e7962dmr106047565e9.3.1780561294457;
        Thu, 04 Jun 2026 01:21:34 -0700 (PDT)
X-Received: by 2002:a05:600c:1f96:b0:490:53d3:47a9 with SMTP id 5b1f17b1804b1-490b5e7962dmr106047165e9.3.1780561294130;
        Thu, 04 Jun 2026 01:21:34 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.59])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f34413csm14143945f8f.21.2026.06.04.01.21.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 01:21:33 -0700 (PDT)
Message-ID: <3dd59d38-5d16-4632-ae4c-0416c70f5a17@redhat.com>
Date: Thu, 4 Jun 2026 10:21:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 5/5] veth: time-based BQL completion
 coalescing via ethtool tx-usecs
To: hawk@kernel.org, netdev@vger.kernel.org
Cc: Simon Schippers <simon.schippers@tu-dortmund.de>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20260527135418.1166665-1-hawk@kernel.org>
 <20260527135418.1166665-6-hawk@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260527135418.1166665-6-hawk@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-295095-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hawk@kernel.org,m:netdev@vger.kernel.org,m:simon.schippers@tu-dortmund.de,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[tu-dortmund.de,lunn.ch,davemloft.net,google.com,kernel.org,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8561C63E009

On 5/27/26 3:54 PM, hawk@kernel.org wrote:
> +static int veth_set_coalesce(struct net_device *dev,
> +			     struct ethtool_coalesce *ec,
> +			     struct kernel_ethtool_coalesce *kernel_coal,
> +			     struct netlink_ext_ack *extack)
> +{
> +	struct veth_priv *priv = netdev_priv(dev);
> +
> +	priv->tx_coal_usecs = ec->tx_coalesce_usecs;
Sashiko noted _ONCE() annotation are needed here and for lockless reader
below.

/P


