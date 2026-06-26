Return-Path: <netdev+bounces-302246-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KZpGEQy0PmrwKQkAu9opvQ
	(envelope-from <netdev+bounces-302246-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 19:17:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2B26CF5FD
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 19:16:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mojatatu.com header.s=google header.b=VAU++IS+;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302246-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302246-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BE9A30180B3
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 17:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7863C388377;
	Fri, 26 Jun 2026 17:16:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E30B35DA69
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 17:16:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782494201; cv=none; b=WKYIwJPCDd95VAWnir01/XyN3lm/u0cgripEpdQTatzWj3RdIGpoH3weaS5HI1vwIoGp45uCKPoyjd9cRaNnenj/PEiq02EcN+QFDvKg0brAlh/UaQvxvCfdDzhi7IGbEm5dSfWZsb858QnxdrILasAv0+J7Uy7Qm0d0SiZOW0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782494201; c=relaxed/simple;
	bh=iKD+oggkgZU95oyb3qBw03YB6gWojwE1nSPOK+opweM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YpZ5i/2H3Z/mWZVhoKvgiQBh4ZTpPx/xmHsq7grVTkFXCN5NCq5Oa+kuXujePfju0FhIcIqQI8sYIW3Y0NLCGVF7W4SvQy1eSUcthcu84EzP6EfViNz0wChSl93Qsp3KHMGYjGAsViwzNoVjlYwNnMUwED1HXeXpSCRmrZEvGlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=VAU++IS+; arc=none smtp.client-ip=209.85.221.175
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5bd75ef143aso445105e0c.1
        for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 10:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1782494199; x=1783098999; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hbwfYbjLKN6sERbTEauQOhNZrG1FwE92+YS5k0kfmbo=;
        b=VAU++IS+If4oyncgkEVnCYyeGsTFbP3BRbZoxez5wE7F37xwxiBEEMPXSI0hT8HhIm
         jEZ432HVp1336MZPbZJH+A5SJ7DkRtMc7N9U9PvGgP14oh4l1j6C2MlhwfXvuQfO/wwx
         4yKJUplvNS1apzyYGXv2oSKuHqJVRa8b4e6Es=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782494199; x=1783098999;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hbwfYbjLKN6sERbTEauQOhNZrG1FwE92+YS5k0kfmbo=;
        b=tGyRRaOPHXJFHqU+rpKy++M/CSKCCsSp9s4poeHCPatMFDycjXutmMa+M69xST1x6x
         ERoqNKU1bLt6ssemDRCa+JxhcfzJPnlvEbgB1wcLbsaQgfxbqbG+ZFng1eGvzgurG7To
         be/MTEscFE8OAJsdH/+i0TnNcQPDCP/KUyRLFhBEckw8BqmdwFC8QH++ciIYNPg02u6S
         wPDw0ANoxUIJ86SbLN25foyV9a1b74eEpraXFLXhawbZQPuKoL/8Cw4joI9rWRkt/Mb2
         eBkGu9TirssmKHLe97YdFeg9vjuX4bLXqZ+wBL3NOYZFt83wvg86S90U4860f/L65DsU
         Ox0A==
X-Forwarded-Encrypted: i=1; AHgh+RpmdURtFW5AR1wjQyaEh+UrMwnWyoiBagEvFtYWxJBbrK56Zt7A+urn9STslJq7ntLyrixslx8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEldzAECvtvt9Ec2yvLYODBjq4KQ4OhuhrfKtwthTZaxp6wMrq
	lbzOQG8SZJKiJsXuw5Fsx0XQ/1fPc3wyf1hxOTwQy9/KliT6dl6/4d7GG1Xm327klg==
X-Gm-Gg: AfdE7cn4TBLpOmP8X262KH8gGSkyElltT0YM0CCAgQ5tz2+2hJtxz2tx51XVn2mfC66
	jXitaz1HxkxUpmtVNpi+ynr/TKR9omCYwnFtOtA4MOtvG2oQgXgV/Kws9CtUD/qH/cghCPJ0nrs
	rlWnKjKoaE4we9ceqRcFbyPdULflOPbXTYK4wC2sW4Cvz8oTAe4aVxflBtzjkkXEaesSJod6IRD
	gWAnP3UUvl3HUJLp4axDDa9z+0VVRH4QJh1LBqGyZmQUX48VsL66IOiMPIKLbMaHWlGT2S8q9dW
	UINFYgcbncXne+F/gJ3lh/58YOJBiVpUk99SMFLQE1NBF9B4FHhnGkFz3EhD5aefut0nWHqpB35
	eQskW1uicfW8rV82ZmRplZkLUR1W1Seln9B2qfNPrpCImhyh1ET0WDrVqXI1qLcii8F3xUR67qc
	MwM/hhO0yeh6WuJe5l/T9VYWngo71l43/pImt1PHtcwsEZz1l7ZLbNvfwrt0WAWBs3aw==
X-Received: by 2002:a05:6122:3b19:b0:5bd:76f5:5dba with SMTP id 71dfb90a1353d-5bd76f55eb1mr1821928e0c.8.1782494198982;
        Fri, 26 Jun 2026 10:16:38 -0700 (PDT)
Received: from ?IPV6:2804:14d:5c54:4d67:f17:d82a:d5b8:20a? ([2804:14d:5c54:4d67:f17:d82a:d5b8:20a])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bd790d6db8sm1501231e0c.16.2026.06.26.10.16.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jun 2026 10:16:38 -0700 (PDT)
Message-ID: <5d57e4ce-0460-4ad2-9891-1bc7d24020d8@mojatatu.com>
Date: Fri, 26 Jun 2026 14:16:32 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] net/sched: sch_taprio: Replace direct dequeue call
 with peek and qdisc_dequeue_peeked
To: hexlabsecurity@proton.me, Vinicius Costa Gomes
 <vinicius.gomes@intel.com>, Paolo Abeni <pabeni@redhat.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 Jarek Poplawski <jarkao2@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, linux-kernel@vger.kernel.org
References: <20260625-b4-disp-31bcb279-v1-0-85c40b83c529@proton.me>
 <20260625-b4-disp-31bcb279-v1-1-85c40b83c529@proton.me>
Content-Language: en-US
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <20260625-b4-disp-31bcb279-v1-1-85c40b83c529@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[mojatatu.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302246-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:hexlabsecurity@proton.me,m:vinicius.gomes@intel.com,m:pabeni@redhat.com,m:jhs@mojatatu.com,m:jiri@resnulli.us,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:jarkao2@gmail.com,m:vladimir.oltean@nxp.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[victor@mojatatu.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,nxp.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[mojatatu.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[victor@mojatatu.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,proton.me:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8D2B26CF5FD

On 25/06/2026 06:51, Bryam Vargas via B4 Relay wrote:
> From: Bryam Vargas <hexlabsecurity@proton.me>
> 
> When taprio's software path peeks a non-work-conserving child qdisc, the
> child stashes the peeked skb in its gso_skb; taprio_dequeue_from_txq()
> then takes the packet with a direct child ->dequeue() call, which ignores
> that stash, orphans the peeked skb and desyncs the child's qlen/backlog.
> With a qfq child this re-enters the child on an emptied list and
> dereferences NULL, panicking the kernel from softirq on ordinary egress.
> 
> Take the packet through qdisc_dequeue_peeked(), as sch_red and sch_sfb
> now do. The helper returns the child's stashed skb first and is a no-op
> when there is none, so a work-conserving child is unaffected and the
> gated path now consumes the skb whose length was charged to the budget.
> 
> Fixes: 5a781ccbd19e ("tc: Add support for configuring the taprio scheduler")
> Cc: stable@vger.kernel.org
> Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>

Reviewed-by: Victor Nogueira <victor@mojatatu.com>

