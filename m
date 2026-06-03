Return-Path: <netdev+bounces-294667-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GN5DKC/kH2qZrwAAu9opvQ
	(envelope-from <netdev+bounces-294667-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 10:22:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C88635A73
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 10:22:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=blackwall.org header.s=google header.b=HhPvNOcV;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294667-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-294667-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5A671309CE03
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 07:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40EF402442;
	Wed,  3 Jun 2026 07:50:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5736F402BA0
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 07:50:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780473044; cv=none; b=Ld28EfEnFSKxNI8LmLj9jDQFoo33KBv9WuFg1MMe9mbgZv3xkc4IDK3VGgOsBLtxI4OvO1gmi1O8gUSH2abJh33h0FxUIeTJ9C4s5zSHu77THQaUQtXwZHzHwdN96K/mSDyGsrTV8EfqxM5Tf4rsCRWGmT+cGS1LGP0LrUjU8XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780473044; c=relaxed/simple;
	bh=DfKZU2lEpY/XWuD80Z8o6lGViXs83jlHA85EQaV6BcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tPm17I8I80I+okERhcBaKDHESfa6f86/+GXz04I8iYGPUaRY6yEHeXU5DvdNwXH6IdLtbuBNoP5byBfA2Z1BNtzuBE4tKg+gCjmCFQ58L1TSvVDiPlUBAyd4URpipNKxnI2HhtNooi+RmZe7KYKKqBrXAu+3Sa6//rdizRLwBts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=HhPvNOcV; arc=none smtp.client-ip=209.85.221.52
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-45efb698ef2so2145706f8f.3
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 00:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1780473042; x=1781077842; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6FFnDjQi9nJ9DDSXP3upNDWWSUY1uZfMzeFgACqAkmQ=;
        b=HhPvNOcVRafBqp7ZUjRztSr7BCsq2zsy79K+f3OHCnIkdiKNgOIdXkrdA0j6eJKVHY
         9cxu3j1PpyXR42qI3hvbmGooyzOAihc93pImqcatzP/PAwYPZ4oL3i5zPXvJcNEsKikf
         lJRtZiBekApR04CdwaZKsbP0DqYl/KrSLsAU90vSRsl0OAS93ZZ+D/2BgLCaTaLfliFl
         5A0m+a0iZcXecXthaaKPzsFAHmC4CpmjzwMetl0qBjdorPeb3qYPtEbS60QckqOLKgyQ
         1Sa5e3zl5yLcLPTMyfOXxs/MdySg/A0J5UPZPbsmeN6KStnQwB7A6tIM8zSwvtLvxawv
         KS3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780473042; x=1781077842;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6FFnDjQi9nJ9DDSXP3upNDWWSUY1uZfMzeFgACqAkmQ=;
        b=FWAuOjz8cnmhVQB3F2sCWNK4iANuW9T7Z3w23H/ggNtYD/5pBDMlQaA5PkmwOb3m+j
         XLj6M8dBCh0Z8f5eYhh3huEns/FCh97MNqS33SNDVtaO/dxEAZK0xkf+m21hYSPmBX5i
         Qr9W89E9RjqJtRLGlGpndL3bRCx4QtctrV6bUI4uFquxlaBUbEjutafwG7khIq2pPWMK
         cqPHRe2k7c3RTPJTTMARBcMzTALYuIqn2Mq9C5WhyTER/wSPAdhrBopEp3NHnhXF5HeU
         JvbNhLeweWBUIyN9ta/N5qiyVi70Q8bJ7xlYuUTwj10GKiE+AOz8CTQG5gZNBLZI0lpb
         wh9A==
X-Forwarded-Encrypted: i=1; AFNElJ/tbt2eBLuxoRwmO49Ummyq9+KSn3MUZesWnWj3kSoifNT4oJI0tIPm/GLI4ph2nn2uE/zTIv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYFMKFNp7M8/z8hQOScRWjez8xi7F5QbCKGNUJ3WPC+KTQ/5b6
	GfrFfidynfSCub0N17T2qSmp5uQHKt+xgLHtxzYNXwGi41nx6uAbEQLvdpZsp5lMz1M=
X-Gm-Gg: Acq92OHoWecQYcgqnIF7lM8DJkdzYgjUFlUIIHdm0hdGbVMr8YsZlFktghRhPmIeezn
	bD9btGdhhw3AKsS4Oerf2RRZdClrZHpMbISKn6h0oGjW9XVRKPHlwxDu3VWgMPfqOCIi1fuybn5
	gpzvEjZRBCc7XlTJ4jfmk6BJRt7sVGz4erQ9VXo6ng2Ry1NtlEXHY/XzYvppBQUs0DBXOELRrWx
	1m7N4Px7cB7PQtjjLv9UbUQa56Bi+hxtJ1o0nn2LNktV08adlCVSiSjbsQPOyqm0uxcp+vvd13D
	YU18HiU78ysUaHUKHP5metmwEQwtSlLpOGg+zTQjUu0CARB9VEKm5rF+sWhTdQvRjArSz8Easb7
	LQffKvA/xfhSvisCStpnvSW1FKEGil2tMon7+hC7T+AVSWcAKp2SvjwGtbe5EPKCwOHT9TT30PR
	krAWnml+8q5F+RcZvu5FZ8lHb+FdlkofUoKMCxI8bB4qQQQOapULygWZoq6iEZ95AK
X-Received: by 2002:a05:600c:5394:b0:490:b0e0:3de2 with SMTP id 5b1f17b1804b1-490b60f9e98mr36120885e9.33.1780473041726;
        Wed, 03 Jun 2026 00:50:41 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0e76feasm120928085e9.9.2026.06.03.00.50.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 00:50:40 -0700 (PDT)
Message-ID: <e20a2bbb-8bbe-4998-8c46-4171f35c2ab0@blackwall.org>
Date: Wed, 3 Jun 2026 10:50:39 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 09/11] bridge: provide lockless access to
 p->port_id
Content-Language: en-US, bg
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20260603062043.3911278-1-edumazet@google.com>
 <20260603062043.3911278-10-edumazet@google.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260603062043.3911278-10-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294667-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:idosch@nvidia.com,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[blackwall.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,vger.kernel.org,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[blackwall.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:email,vger.kernel.org:from_smtp,blackwall.org:mid,blackwall.org:dkim,blackwall.org:from_mime,blackwall.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 71C88635A73

On 03/06/2026 09:20, Eric Dumazet wrote:
> sysfs show_port_id() and BRCTL_GET_PORT_INFO need this.
> 
> This will be needed for upcoming RTNL avoidance in "ip link"
> dumps (cf br_port_fill_attrs()).
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> ---
>   net/bridge/br_ioctl.c    | 2 +-
>   net/bridge/br_netlink.c  | 2 +-
>   net/bridge/br_stp_if.c   | 4 ++--
>   net/bridge/br_sysfs_if.c | 2 +-
>   4 files changed, 5 insertions(+), 5 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


