Return-Path: <netdev+bounces-304360-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pmRVGoRTR2rVWAAAu9opvQ
	(envelope-from <netdev+bounces-304360-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 08:15:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2646FEFF7
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 08:15:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=U6Y6YRQP;
	dkim=pass header.d=redhat.com header.s=google header.b=gHrt1p9b;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304360-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304360-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6110301FD51
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 06:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847D937A849;
	Fri,  3 Jul 2026 06:15:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC293115BC
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 06:15:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783059305; cv=none; b=SCAVGH8wSP3NZLQxoFlDlSVCIbEUkPGAn2TPOJ8ReyAazD4CykqHIx/FhC0QZHTn8LlxQWQk4Td+z0iLgOX4sR3qzVmYdMD2ZZgtr4uDxxw04FESGFkdw4jAvvXyKQUA6LRK1lIo99sDg5/Ymv/xKJ8jdBKH72kS3w0fl2Dn7LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783059305; c=relaxed/simple;
	bh=9pr+tZL0E+LO5I7pjzFlM7USPu/n04A8LtiShtX56AM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kcciah7m9y/ix+ZfXoD1adFeNrlhSRpS8rrqDXUg2C93oR6aGnnm0xZzcrj5K/sDnj/2eIWxQBJ/bTLiijgDwryv/Ib0FTa3GBChpvbw4WIPqpHH9NPCRT9CengWqarKVtYd73zxooI7zWet1vRkuSj5KzHXs1Qsjuf/pBob7+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U6Y6YRQP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gHrt1p9b; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783059301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4pOlqexGo+SN8z1PsfogoT427c7dvFT73CjafBodfTg=;
	b=U6Y6YRQP9TUgj91lzeRAHcw3iqLmEIAx2zGiJ5Zhznas+k8Zou44rGiQKmaZxt+uGI91LP
	eYLakeEVp9XLUYn46pw8+5MXHaxApM8B1yvW+EyJoRNH5BFo7itV0ULEbhThEMHrn1YuzM
	QnYt3jbe3HmuXwyI+tWAiJxNsfMzuq8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-KvZ-feElO2aFXFbIv5qb9g-1; Fri, 03 Jul 2026 02:15:00 -0400
X-MC-Unique: KvZ-feElO2aFXFbIv5qb9g-1
X-Mimecast-MFC-AGG-ID: KvZ-feElO2aFXFbIv5qb9g_1783059299
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4926fa2cb17so2294515e9.1
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 23:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783059299; x=1783664099; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4pOlqexGo+SN8z1PsfogoT427c7dvFT73CjafBodfTg=;
        b=gHrt1p9bKMN70vREIupmbB8cZuSZCZ+9+UxwF9mYxuWhki9Xcsb4Cw38SVx8y4KYQh
         Z5gQOZPqJmAxUNpX2CA4k3UvVtbWWQDMr+NcY5j8Jk/IPVEb1Pq1aDsODHgcypjcEx8s
         s0bD+Zj4ZS1L9kBbv9N8svIdoLj7d3luEAzI5Z6vGBcidunrJnbLf3onzGlh7xjGxtfO
         ZIPNNpiuADUblU6tGkHURdmHHON7weEBk7T3yIDydhFKXLoyA1dgJs5l9Faklk0uVLcv
         r2f32n61R5Z6vZrEEXIAtfzQy63Htkl8vRgb1cWJyR4eHCBZRc0yeCSCmBAJkDHba3hk
         GdAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783059299; x=1783664099;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4pOlqexGo+SN8z1PsfogoT427c7dvFT73CjafBodfTg=;
        b=DwfLtqck1bCnfTZvm544BlfoPkf+DgZTZQc1cx3Ks1GJ5sJk2WD4yfbtiV1mByOy8Q
         8iD98wEVZIXmEJmbVRSMI4jQvOuVyJ4QcoTNxXxeG3xgi4qkW9AMz0j1QOFzIBx1VpUz
         soXs74IuUOjsPfugGVFHq54q4GX2FJh0bETf4e43F7fa8Fx+8+v2fv0EjJ0JAJUZUtha
         UV0ZTj253gh3gltWfB4lKoc8BAjL44HksWjA3dTMTv1v0HaJ8iSprKhRjo+quMxyym/z
         TRuIS9ByWVi7gwFAzOVbH+bwF+7CQG/AURy5voKHGlULsfJbrUPvvWbH8alUtYgjmNvD
         v8ZQ==
X-Forwarded-Encrypted: i=1; AFNElJ9V7NnAgRzikTw9O5aAKI0VE49qM33Ewi8UEw2W6ZW6JkbAHAouPzQMNP1CI3z9C5XerEC7VAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkpNT/MwMcIWeqKi0UAQaZ9ArBOGPB9Y3ETaGv60IsvYVzVSrq
	G6Ks76B3589i1QHKlw3wiotNVQR0UXCeXyhY1BUnAt3wiymOvafZL9sWJdMvyH7V7Jr1hSWA9oF
	VQKmfGcS275DLb0Ldu0XQa24SagY4Nd9fiVa+/VBA1a6nL/Ris5KS2cW3XA==
X-Gm-Gg: AfdE7clxXmcyeLU0S/Z7U8B7lZ6HzRck7q1U7vPX8hN38IRPHYWXCBB03e8OaWCPuzf
	v+i5uBJzx4oZZ1XcGqSemIF+1n+2d9nzB9j9iTuyhn0ZzOFemX8HRrCYVdf28QFpQewfz/mZYKq
	eF66X+vGyDHyA5GYa1Lw1aFxp9xPa7IZi/EQt2Ys9tOYOPSoOkRAURPpOIT/GRG3K7iKGn/6hNj
	0xABGkfIhOhQTilchoLnfOsunt0Pog+SyzhqOf/E/Gk0ypLwyTgzFzDrkW88z1UxRkoE1gIXBzg
	tRYF04GkJb3ycgeAkHz49yeuzcRGEdbd+85sfqnsLcDQcvv0rb9/5uQeM65yOKXO1FuHYz+sG9v
	Aqgu2SI59j57DeoKBFnOSWxp+8jRHKjNrbCmo7XIKlCGhzoNedPoLdUcFa/972YRcXszWdFhj7/
	BRuR/NiUZRNQ==
X-Received: by 2002:a05:600c:3f0b:b0:493:cbdc:7cd2 with SMTP id 5b1f17b1804b1-493cbdc80cemr15197995e9.3.1783059299046;
        Thu, 02 Jul 2026 23:14:59 -0700 (PDT)
X-Received: by 2002:a05:600c:3f0b:b0:493:cbdc:7cd2 with SMTP id 5b1f17b1804b1-493cbdc80cemr15197565e9.3.1783059298559;
        Thu, 02 Jul 2026 23:14:58 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:2eb7:f61a:75:4534? ([2a0d:3344:5521:6b10:2eb7:f61a:75:4534])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493ce58c332sm15826425e9.3.2026.07.02.23.14.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 23:14:57 -0700 (PDT)
Message-ID: <38714267-42f4-457f-998b-0f26a8e59466@redhat.com>
Date: Fri, 3 Jul 2026 08:14:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 net-next] net: dsa: qca8k: fall back to ethernet-ports
 node name for LEDs
To: Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20260630015137.1591152-1-rosenp@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260630015137.1591152-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304360-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:netdev@vger.kernel.org,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BA2646FEFF7

On 6/30/26 3:51 AM, Rosen Penev wrote:
> The device tree binding allows both "ports" and "ethernet-ports" as
> the container node name.  Try "ethernet-ports" when "ports" is absent
> so that newer DTBs with the preferred name work.
> 
> This matches the handling already present in qca8k-8xxx.c
> 
> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Apparently the PW bot is still enjoying some PTO...

Applied, thanks!

/P


