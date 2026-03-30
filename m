Return-Path: <netdev+bounces-273096-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BjcLXczymk66QUAu9opvQ
	(envelope-from <netdev+bounces-273096-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 10:25:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1BB35715B
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 10:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C87CB303FFE4
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 08:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE82386561;
	Mon, 30 Mar 2026 08:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MEXvWtD0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ku5xHglb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61872853F3
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 08:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774858591; cv=none; b=YV5RGWPhiEk///BgpDUF7ABHP3RokPsPFjUFk/fRg3YGpKgW3bGj178N9KEfFOW14xOWzcb8yrGRuqt1T7GlklAhVYDj0ge5wz4gLuNaSTQSk/++chWRgVM48yozMOoTjt1rujUIc3vPiBr7niduYR5udqXB0tC0NAIF+F8czRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774858591; c=relaxed/simple;
	bh=By4eW9Zb10ghfy0n9CPP37jKpN0AagRfW8uFbdFSbvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=E3g2UTit2wFKlROHjJDRUpb4C7rHeuFc8MhkGCNs4hOtrw6vA4fxEtxjopVtaYFi6dzKzxPBpomtvpnrQJ5T+QfcPLL+sFvM1JrRMsdWan1EGZ56vhia2iZr9qlbw/aRr/2CcD4pCqGzesWi+7FgpSpNJrJyzBV7SqqNOsv0klg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MEXvWtD0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ku5xHglb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774858588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ypB2JuOYFQ76h59u5fI832JUnC4VsBqTjzqI4AF5uHA=;
	b=MEXvWtD0BqPr0F2XCHJlZSE5ygNmZX8vzpITMqtVcjEhI3nm76Qos3JxTB9sADkoGUKc7L
	LHFxH7vft9V3Py+ovP165etljilQvS+oRSOkbI9xIxQPm5qLMBgEV2nfq9aH6A38Qo3EVX
	Rns5Oi/O3hm4+w9NQTsy6a2x5VXtzQA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-qYoJqKceOrOaRVKq6YVaFw-1; Mon, 30 Mar 2026 04:16:25 -0400
X-MC-Unique: qYoJqKceOrOaRVKq6YVaFw-1
X-Mimecast-MFC-AGG-ID: qYoJqKceOrOaRVKq6YVaFw_1774858585
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43d03ae4f2aso185899f8f.1
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 01:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774858584; x=1775463384; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ypB2JuOYFQ76h59u5fI832JUnC4VsBqTjzqI4AF5uHA=;
        b=Ku5xHglbADgD3eJ/wRPnsyRHTVb6FSFbxntnPZmxAs8ht3m6uuin80PsPTk0G2+V3x
         812AVt9ADm18pooDXfuenV7sAmlENzrwW/HKwoilIERwuDXo4JkfVVDdmU9nyL7cHEOX
         K0jgliQlPmvbHnUhdTEqTSRSLUna63AOYImlBNmNTMKqYdPRXrhZKk8+R5MS20KdgFN3
         vS6czaZBpz3y2B0NijhAO6e4bLo4NsVI6UXk80J0SVHUnX28FD517oiZPUgX8tBS5PbB
         7c0pjdLwQ4vz6aw4eGQPultQyYMmHOaxVABfIO37S81v/iS60UEj5bRkcdtyEaBp7c6B
         bP2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774858584; x=1775463384;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ypB2JuOYFQ76h59u5fI832JUnC4VsBqTjzqI4AF5uHA=;
        b=BGyicKA/0PsByZ9WPEAPAgtOe9faGbVM5i/3hKU6UxkqvGpd5a3lfgL88iu4Oksy18
         XuaSlFmpthAkubbl9Q+j0My1oJNnnv97vVrv8EC5F1qHCYRwo0P0HxYbah9YPhGBthjT
         3KG/XUcg11OuHDzLe9EZVQcOdy5+tvi1p51oCDF5DYKGIyJZQIPgeO+fxzYz7x4Rcff7
         eMZCy9POZEveYGS8kkSzUm8QDIb7JujCBfnpI2r+01koW+44hW7hRN7XX80YQ/NF8M2M
         q165+kk21DzlH06kN0Qs+u0j/AIU1j8gC+Mj42CKsDJdBiTpSvGBeNgD+LHeyj6nBgQo
         6CAw==
X-Forwarded-Encrypted: i=1; AJvYcCUI0f2qQe+Ph9whUMjM/FooSF5lwfNnxA/PN46ULIn8QOHuP1h29PnaPlsO6VL0KABVTjzhlhg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm5Mn6yR6h2YEpmSvU8j2LA8qM9VGxiwnDifFBxVYSPrPKKToe
	DGn0IhWGdHqKQesE3YwEvOfNpzlKtnxVwSPhMtaEhcI3AiDDR49AIRjNw+F8Q8DUNHcr0+vhkSD
	AJPeTZU2sNrxQ/yNQ7E0MYgdhW0jH94DhzAFMZuH0FdSJuwX4XA/Az1LC3A==
X-Gm-Gg: ATEYQzxWbLR3VMQFki4EfaGeCRJykKGEZ7hfZ2Q8GkYndOSy6/2tLpiUsdl4a2mtQOi
	s80stDJ4RA9iDdhG5Ki8KeX+z+DbHf5hPVKGgP8qCgCeZng6JxyG4FZ9aExZZIblTIwtsjjWr46
	D9ZuwAKONy5cx6e3507QYXXE/VIk2uu6yFKG1BH9pB8eOXDjddkKTS0VpHytt5AOJB2jdqldpU9
	GqFbrPwB9bxKfnR9/OUD7GN08aBeEOJ3NlTLvhP2Lw8WMrhm/z0bayFq6wO+0DxwgNf5sz8+Gcn
	E2n0NQA/S+bjm+vD6rnbUimn4mVoKGFh1lcGefWgGexv1DRa3GBj8pDvrQt4FJDQQc6THYbuo+C
	g8hbn2dgSkx+LO3xt+Cyb2IaU1lbZ5XcAl7c5k1WRllB7O1guJhJyOZqJ
X-Received: by 2002:a05:6000:4305:b0:43c:fb48:6856 with SMTP id ffacd0b85a97d-43cfb486a0dmr7326689f8f.13.1774858584500;
        Mon, 30 Mar 2026 01:16:24 -0700 (PDT)
X-Received: by 2002:a05:6000:4305:b0:43c:fb48:6856 with SMTP id ffacd0b85a97d-43cfb486a0dmr7326606f8f.13.1774858583929;
        Mon, 30 Mar 2026 01:16:23 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.222])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf2570b18sm19761934f8f.31.2026.03.30.01.16.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2026 01:16:23 -0700 (PDT)
Message-ID: <4400db54-aaf0-4cc4-98b5-bdee35e29cce@redhat.com>
Date: Mon, 30 Mar 2026 10:16:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/6] net/sched: netem: cleanups and improvements
To: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org
References: <20260328182704.456993-1-stephen@networkplumber.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260328182704.456993-1-stephen@networkplumber.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-273096-lists,netdev=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2C1BB35715B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/28/26 7:26 PM, Stephen Hemminger wrote:
> Cleanup and improvement patches for netem, done as follow-on
> to the bug fix series found during AI-assisted review.
> 
> - replace pr_info() with netlink extack error reporting
> - validate slot min/max delay range on configuration
> - fix slot delay calculation overflow for large ranges
> - remove unused loss model struct fields
> - remove stale VERSION string
> - add per-impairment extended statistics (delayed, dropped,
>   corrupted, duplicated, reordered, ecn_marked)
> 
> The xstats patch requires a corresponding iproute2 change
> to display the new counters in tc -s qdisc show. This will go
> as separate patch after this.
> 
> Stephen Hemminger (6):
>   net/sched: netem: replace pr_info with netlink extack error messages
>   net/sched: netem: check for invalid slot range
>   net/sched: netem: fix slot delay calculation overflow
>   net/sched: netem: remove unused loss model fields
>   net/sched: netem: remove useless VERSION
>   net/sched: netem: add per-impairment extended statistics
> 
>  include/uapi/linux/pkt_sched.h |   9 +++
>  net/sched/sch_netem.c          | 120 ++++++++++++++++++++++-----------
>  2 files changed, 89 insertions(+), 40 deletions(-)

I wild guess this is causing TDC failures:

# not ok 364 8c17 - Test netem's recursive duplicate
# Value doesn't match: bytes: 294 != 196
# Matching against output: {'kind': 'netem', 'handle': '1:', 'root':
True, 'refcnt': 2, 'options': {'limit': 1, 'duplicate': {'duplicate': 1,
'correlation': 0}, 'seed': 6495514880116664183, 'ecn': False, 'gap': 0},
'bytes': 196, 'packets': 2, 'drops': 1, 'overlimits': 0, 'requeues': 0,
'backlog': 0, 'qlen': 0}

Possibly patch 6/6 needs to update the expected netem output accordingly?!?

Also there are a is a checkpatch issue on patch 2/6 (empty line between
fixes tag and SoB). Tentatively set this revision to 'changes requested'.

/P


