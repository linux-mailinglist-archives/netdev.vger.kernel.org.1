Return-Path: <netdev+bounces-278334-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMULB+H23WlolgkAu9opvQ
	(envelope-from <netdev+bounces-278334-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 10:12:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 494233F6FC4
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 10:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A6426301A3CF
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 08:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220B2392831;
	Tue, 14 Apr 2026 08:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SvBAVnZG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ma7Cw+FC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F81B396B70
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 08:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776154297; cv=none; b=J9JK8Yq0QvU/bqGfYrPKEDZ36voYqDs6eP8QFDfj6jPBfcdgdbFuVyqIvWf597yaqa5bkMczB5XEzSA+vXIkIPcmN4c3hXhV8HOaq1P0pgwTSDVVQdaSCd7QMJstVplMlbfUQJWN/Myw9V45DnD6Vk7jZjP1h2AUng/GgFXGsco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776154297; c=relaxed/simple;
	bh=KNX8XC2wwGGxkUDIXlaj5gfOeGdyv0vM3lCH+V3fHjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ist6ucGraonuzofT/WJQf+IHwMKswbg+CPkJ/oMkwZAZ5aKdPGOdaw6q+63gdfW28NDpLS1x5OGdpyDw/wxJXG5HUKDN81322dT+yZVWy+vzxAcFp/OWmjnAX/fb3xJfqAKvkbtvCqwoTox+I/ZmkpWLeN0R0oJMr9NLQE5quSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SvBAVnZG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ma7Cw+FC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776154294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3RGbJ4Sp4gddtOIlLGrNwEQ3NrcedSvoP4IH+GVcGuM=;
	b=SvBAVnZGoZmk0C4JuZyOEA0cQtH7f6+7y5SdcPvGSysWQltZKtCQs/CjNMqDj31YdSBTo3
	UH5R7uZyTYFKHSN2+08GMdBM1FZSSPEb7bf7vf/kV1b2SY/+HsJAqSf2LrZjkHaiNkOSoA
	lDQBJmViiSy7a0z1Nb59M4p2M/eJ9Zw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-giLgTGKqMB6SfJzsCvaADw-1; Tue, 14 Apr 2026 04:11:33 -0400
X-MC-Unique: giLgTGKqMB6SfJzsCvaADw-1
X-Mimecast-MFC-AGG-ID: giLgTGKqMB6SfJzsCvaADw_1776154292
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-488ba2f4094so36071315e9.1
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 01:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776154292; x=1776759092; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3RGbJ4Sp4gddtOIlLGrNwEQ3NrcedSvoP4IH+GVcGuM=;
        b=Ma7Cw+FC/MTL62v9ClqZjOWN/wVGdu8qF9+Bm9KF6VfOf1ZKN5MGmqHBQJizY2sits
         nmAITPNgwCW1W9jQDVCyehXtlZ77lEqHF3SEEYpjZ+Pc5urh1YlhaOLmfqRuePLHnFef
         02KhTrG926mAx50aR8hceGxoICD3Qk1VWDezP2kOcSU42lzDXQttr5ttryqqK+8KXLCs
         FZhyRvSWSqgyNAcO19n9e+jYtgQEZW/xYad+zCyT3jnG56v4UzfUeSi0O1Yp98/71gl+
         7q7z3CwxXca9UfYmwimn3vWVjJ2cZu+EhInhTmvAVfpT4+BrF5+mqBLYu2AtoxnrWeFI
         iZ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776154292; x=1776759092;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3RGbJ4Sp4gddtOIlLGrNwEQ3NrcedSvoP4IH+GVcGuM=;
        b=iELEP+eUwpVq6cJaCY+pqUkphpG4YmVp+89RP92CyePmDc/6FELywk/2xZjRi+93Lk
         FU6gqdeCR/oTtjWC/LgagFIPT0bhuP6FrAt6NIVsF5/NOGU+PkAYraF3slydElDlnN8d
         vzZkjhL7VKAH4LZJsm7mzAJJ5hUM6UEnd7GV6lGBdSGnBvlv0DQ0IbY5GtKGkmXHgHdu
         xb/qevxVca14LIkofqvxUYgJ21i0yCjKhxCskPjvv/XE/fzBQ3NO5AuFygi8lGObqFcX
         XaS4eGZnVdm76m54JYRP3bHrP0C2xJ3JQNH0Ln1lpKWD9ry0vFuofHmWoEnu1F6JhfYg
         qMwQ==
X-Forwarded-Encrypted: i=1; AFNElJ/kDrLRlXO1j07nA8uIT2ccKoD3geDiOgjtvXsqwsjDBtn8yORANJNkaPwyQPUtO2nUO8BrE5o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2Z3Um8vEdTyRyI9WMkoqLdYryKRuCVdaoD1A2RlvA2Zj/BWob
	fzmGY/IljjU+6Hz7WbdEJzOf7/bzqsqo42HvzRnw6uiyRs9UvVSA9rOEvqLEOeSAGIahGd5NP9R
	fN3he4hXyjYhyEyoB3Nre/B7sACj8r8dZhhBvzXv3S2nUGsKJHxAutkpjVyAkK1EunQ==
X-Gm-Gg: AeBDiesFSSrra0BVS6lIr3gTyIVr4NurohlZCDJLeHacbXsEEMlkC1UKRAJWLSmzswf
	5oDRKA7Nmod2HJpy0USj8vCM1ay7aFoXzki37C3QJ7ClmkF9MZ714uppCPEnxEYJQaYQ0HJvq++
	bpUx9fkFBAzPkY/DhN7Q+fTabHSKsmUmYoWJSi2X6bjvbvu9+Z+MTpq+Ith5AYl8H1JGzb5KRMv
	Sv+Xo78mGC7v8cyJeLneFa9sLKzokPAJGgU9O6W6VOiGr8n8wOPFJnGsHdnObNuEp5y2N4t9+cm
	+ADvfJbNDP1Ngr23hiA4jn6JK5Mpkwwk/rLXjhmw5QiEOeBODe6tQ0xkUlDPFgxuYEumeJqTuga
	iodwD/E+HigXMt3ljBA79hkpTdGbmKk9V/ehLcNSt79WBb29YSNAQRRNE
X-Received: by 2002:a05:600c:8710:b0:485:3abe:ab86 with SMTP id 5b1f17b1804b1-488d67bbd1dmr239712905e9.4.1776154291919;
        Tue, 14 Apr 2026 01:11:31 -0700 (PDT)
X-Received: by 2002:a05:600c:8710:b0:485:3abe:ab86 with SMTP id 5b1f17b1804b1-488d67bbd1dmr239712395e9.4.1776154291367;
        Tue, 14 Apr 2026 01:11:31 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ee042ff9sm35610945e9.14.2026.04.14.01.11.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 01:11:30 -0700 (PDT)
Message-ID: <6191cfae-db06-4a4c-8e82-7e17ba0ffa6e@redhat.com>
Date: Tue, 14 Apr 2026 10:11:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/3] nfc: llcp: fix OOB reads in TLV parsers and PDU
 handlers
To: =?UTF-8?B?TGVrw6sgSGFww6dpdQ==?= <snowwlake@icloud.com>,
 netdev@vger.kernel.org
Cc: linux-nfc@lists.01.org, stable@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org
References: <20260409233517.1891497-1-snowwlake@icloud.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260409233517.1891497-1-snowwlake@icloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-278334-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[icloud.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 494233F6FC4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/10/26 1:35 AM, Lekë Hapçiu wrote:
> This series fixes three out-of-bounds read vulnerabilities in the NFC
> LLCP layer, all reachable from RF without prior pairing or session
> establishment.
> 
> Patch 1 adds missing TLV length bounds checks in nfc_llcp_parse_gb_tlv()
> and nfc_llcp_parse_connection_tlv() — a crafted CONNECT or SNL PDU
> containing a short TLV value field can read beyond the skb tail.
> 
> Patch 2 fixes nfc_llcp_recv_snl(), which accessed TLV fields and
> performed arithmetic on an uncapped length byte before any bounds
> check, enabling a 1-byte heap OOB read and a u8 wrap-around.
> 
> Patch 3 fixes nfc_llcp_recv_dm(), which read the DM reason byte at
> skb->data[2] without verifying the frame is at least 3 bytes long.
> A 2-byte DM PDU (header only) from a rogue peer triggers a 1-byte
> OOB heap read.
> 
> All three bugs are independently triggered via RF (AV:A, AC:L, no
> authentication required).

This series looks like an older iteration of:

https://patchwork.kernel.org/user/todo/netdevbpf/?series=1079400

but it reached the ML 2h afterwards?!?

At very best you have some serious setup issue. Please have a look at
the repost policy and especially at the 24h grace period:

https://elixir.bootlin.com/linux/v7.0/source/Documentation/process/maintainer-netdev.rst

And, given the above problem, please do not share any more patches for
at least 48h.

/P


