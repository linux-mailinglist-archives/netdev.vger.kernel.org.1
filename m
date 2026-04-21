Return-Path: <netdev+bounces-280082-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHC6FYNd52l87AEAu9opvQ
	(envelope-from <netdev+bounces-280082-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 13:20:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF81743A088
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 13:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CAE353009570
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 11:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F85C388E55;
	Tue, 21 Apr 2026 11:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EeVXawz0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZaooRA3h"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06B0231832
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 11:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776770431; cv=none; b=p6AuqAzOd5KL4M08xr3TBo1b29jZ4ISoli8Ah/lJBnSCOUhxPJw1WcvfflE+p7nCbzzex16eZgrcHHfWbRocsyjCtxB+LsopJqUF+x0DHnViDSiTFu+LZ/TvjkRNZXBERgsCv0nkq8RSQHjzLWiyUa187PDCvEhg1ch8bfMYgZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776770431; c=relaxed/simple;
	bh=DsTbDxK61vxJ+uOaIZqxWXCfgTdsN2he64A+fb9FmUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jz+ysAFRgYk011xklfXh3PzwTRKoBpeNIcJfLo12cuDfFw0sQhm2sbbFS64ZbxapDqARe2bBxqI87LqkxvApkeWI9VJg38iKJAgfAYEfjmlF484R+qdFFtB16JvuW0QsHO341AB2k4r9zqG77sp6TDbTzkDnUgAc1W6fQK0UziA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EeVXawz0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZaooRA3h; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776770429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rrYkcyd6qjki3bZsG+bU43lxWX8WayjtYU1EyQJORUc=;
	b=EeVXawz0keu/wpq7zby9C/d9D2YD8MjMtKz0sCmL6KGMx4a1DgMKW/UYLAEMjSFfaVJ40H
	L5gYMVUWy8oxBL1bGPzXvVX8OlQk0LKsjoWNIvgsMeBYpU9vD2eW0sSatsa7JsjM/4eedw
	L669R9gKrmyDMbWIOLjnS9gJvGJLt74=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-Odbp5tQpMuO6TAvlhnB66g-1; Tue, 21 Apr 2026 07:20:27 -0400
X-MC-Unique: Odbp5tQpMuO6TAvlhnB66g-1
X-Mimecast-MFC-AGG-ID: Odbp5tQpMuO6TAvlhnB66g_1776770427
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43ff19e54beso1690936f8f.2
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 04:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776770426; x=1777375226; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rrYkcyd6qjki3bZsG+bU43lxWX8WayjtYU1EyQJORUc=;
        b=ZaooRA3hwQbJ/aLibnriWcJwc2QGytBBcCWoCXD/9A6O8jZQyA6wcb/SHXW1qEO65l
         /vzOobS1xhXnpOWoNC3T3WQKL34HmKL8uGMpaAsy1uBpWfPvRhhmIkZxNpuGrg6z1Ssd
         hDzkJrvAPn5XrtiIyPPMAIjgFbgnahTNR3IXJER1DQbpv9wUUSoHWDIFNVrw6DQdNZVb
         bx5YvPPWTwKRNP3B80DrJ+pWRKFv6DU39vo/jT3fp8KMCZr6KKqDsrcSfAamxfJJL1mW
         nwYbieb3vlenFoLSZP7gwjg02q1KrXhnhb4lg43skB60oGBjaR1uTSwYK1rs4JVCVDhJ
         FzwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776770426; x=1777375226;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rrYkcyd6qjki3bZsG+bU43lxWX8WayjtYU1EyQJORUc=;
        b=r4NrExa52M2/cDY/K0CJ1RAd40AaEUmG/QxRE84Bb5g69P2xj48iIq6eTqpsdnITLY
         Y4MZ0OHV9z76mA+rMSnkntGL9jd3cGgaOiUvu1m1CN8g2M6rnOTzeh3x5v7woFQCoBo6
         76hBzk7qfJ/8J7TLXWBW/cAyXYDny/TOmw/YBC+qbJEthUoGJDilTWvbTSWNX11BfvRc
         G79q4sfQTvypwVYZenKJi8jJUG+i4bEOX0daQgNt7C/rrcoY1K7D4+vdd3sXXzukOE0Z
         mghJTfTjC85xVcWrdeI7sITTZN9GyKLTxzvTST2sDXLj1iIjqCQZ3wu7LDy1CjWdTIvh
         2vgQ==
X-Forwarded-Encrypted: i=1; AFNElJ+jqhzDy0TArh1BZBC75I9bqjwceAEj5E/4wTn6Aljn3VKvlym+9WmqFZH9GxKLADOobQdHjgE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5IIlOZaO8km23ijO7a4EPeQkSxzMwE1DixhB5dyQitPgv51Dq
	Y+Nko7CQ1p1HXN0chOn+YMr1P+rklFXIblRGQMl/++PLI1xxYdvp1I+ddXu/ZJ1RglVDVROPza3
	deG4r28FaSSm9qquY1I7pLkt11R35J/vxTGY6Pp1gmAkZW356FdzOP1o4Ew==
X-Gm-Gg: AeBDievT/f99oO6pG7ZidPNnnTej2th0YRQBqpvVZwBc6eY7bJiQrbfM6fZqoi6QVp2
	j/LeTPJPMIqU/wPQxuiXVHahYG8b3jkgZbwZMZ8mW9K6lhT3+XTo1HNlHEYvqkfsWyq0cZB9ATa
	krm0hRV8TpDw/qKkT9lNwUr9DxKgAHnYtdA3ZEtEm/GgQZcc06Ybe/aXf56Oh8fUxD5+c8ccihX
	uySGzKXzAU27H5nXkvhWWK1sz4yeUzITibBuKU/r+J61/S5yPuyCpWMqFwxTUXKZWpFqaIZV/hH
	NfJ4F1j3xjQAdzpyCSZ3gIYKrHIM2OeqaqVBk5z8Zj6me8bFXzUpM6iZAUz4pR1woa380EYyZoH
	UloLS9wXVsUlbbey+V1xQhp0aHGWA4PzV0nwId5n0AgX4KvJRyA09wGufOjBFf/dNREY=
X-Received: by 2002:a5d:5d02:0:b0:43d:77c6:be6d with SMTP id ffacd0b85a97d-43fe3db39c6mr27082068f8f.7.1776770426447;
        Tue, 21 Apr 2026 04:20:26 -0700 (PDT)
X-Received: by 2002:a5d:5d02:0:b0:43d:77c6:be6d with SMTP id ffacd0b85a97d-43fe3db39c6mr27081982f8f.7.1776770425956;
        Tue, 21 Apr 2026 04:20:25 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.104])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4eec9sm34927627f8f.34.2026.04.21.04.20.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 04:20:25 -0700 (PDT)
Message-ID: <210f5d0b-6232-4c0f-adff-3a97d54159b3@redhat.com>
Date: Tue, 21 Apr 2026 13:20:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 2/2] net: airoha: Add missing bits in
 airoha_qdma_cleanup_tx_queue()
To: Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org
References: <20260417-airoha_qdma_cleanup_tx_queue-fix-net-v4-0-e04bcc2c9642@kernel.org>
 <20260417-airoha_qdma_cleanup_tx_queue-fix-net-v4-2-e04bcc2c9642@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260417-airoha_qdma_cleanup_tx_queue-fix-net-v4-2-e04bcc2c9642@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280082-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DF81743A088
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/17/26 8:36 AM, Lorenzo Bianconi wrote:
> @@ -1055,8 +1058,33 @@ static void airoha_qdma_cleanup_tx_queue(struct airoha_queue *q)
>  		e->dma_addr = 0;
>  		e->skb = NULL;
>  		list_add_tail(&e->list, &q->tx_list);
> +
> +		/* Reset DMA descriptor */
> +		WRITE_ONCE(desc->ctrl, 0);
> +		WRITE_ONCE(desc->addr, 0);
> +		WRITE_ONCE(desc->data, 0);
> +		WRITE_ONCE(desc->msg0, 0);
> +		WRITE_ONCE(desc->msg1, 0);
> +		WRITE_ONCE(desc->msg2, 0);

Sashiko has some complains on this patch that look legit to me.

Also the pre-existing issues mentioned WRT patch 1/2 makes such patch
IMHO almost ineffective, I think you should address them in the same series.

Note that you should have commented on sashiko review on the ML, it
would have saved a significant amount of time on us.

/P


