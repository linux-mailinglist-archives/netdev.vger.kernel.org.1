Return-Path: <netdev+bounces-264998-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBYxDkyDq2n/dgEAu9opvQ
	(envelope-from <netdev+bounces-264998-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 02:45:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6FE2296F3
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 02:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1B2F3023DF8
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 01:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18D5321445;
	Sat,  7 Mar 2026 01:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XCKDDBs/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9303128CA
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 01:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772847944; cv=none; b=d2PpMVZkGvn/o6eyOMFncTV+TM63daTxBa4phkAIBmgwFS+7AT2QlZfiArQty/aZd9/O+iGiCT+79R6ki33SRd6Zxxl0F3Krhp6tadQxLiQOfYaLBnIczBqd1JGIUpzgBKZJYErZz9DeL5gluXdl7qiF9HLT7c0BncEPno+gAVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772847944; c=relaxed/simple;
	bh=tIcnesEX5pvJrJP6mxto2J3YWaErfy6PMHz/co58Hk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oOtG9FGnx50ETjKy1KUslHyQr4N/veJ7BGCz/pJjWiP9Mh1aDV57M/Gv0iBPgWRTxIb3hez0SG6CQvmZj52Q5oV2ifJrk/cZ2DhM+bJM3RypKk7+WNowA1xp9LEC2DhWI/Ef8tqigiZmBCVRSX6qeImnJYpqjjbzVNrkc85OE6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XCKDDBs/; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7d4c1d2123dso10806181a34.2
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 17:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772847941; x=1773452741; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tAXbtfx1R4MWQt4sPmc7JCtd9Ano5uGSzagBUlJwAoM=;
        b=XCKDDBs/tW1ktDinLMNEWLNkzbLd8ynr/gk2zgBvr/dh1kxZnFPRTAjJi9I/TiJeYC
         dnsdXnvw5rfk5q54saYxKQ3TT3awryV3es71uCMZTNoTN3hnoSORnDd7PLEOr3LEcst/
         v+YJKiCTs2fEUGVI4Vql71f2MeqvcR4YzhzWzHNMb41Q5qQH9aUmRR5/I6/z8eodSIOE
         ENnRUkZVWKLW8qlCAxruToSVOMrp1lCivoHfMDLVtTSJ+l1Zc/SaekwkhHqdv7/904aR
         URFJMFmBmKnTF/zxl66vvI9ojfCUu8tl3u+pDw4MnPmYbInT3ffjfPz82fi8mzRDpPNS
         FknQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772847941; x=1773452741;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tAXbtfx1R4MWQt4sPmc7JCtd9Ano5uGSzagBUlJwAoM=;
        b=Flvh0kHU18glY2AHeg20I1w7FzgZ249W6xHPXclh3BgN2CJjFAzn7kUHKeUHJCWTn5
         rHR/gU2dYr8O1MyGzCDioTWpbcPfh0sHCbpBJaDcVcPj2Kc2XooeA0brtMvMKExYxBfs
         BvQIcZQFXe2I+o7kVRoehK4DccPe+ljLWiSjCqKS7G18KQ0JyNO82RfcEol/uyKRA/j2
         zHd/fztU/MHHASBBI3qRKrIl7t1rWvrF06NVjXIwe4hqENcBHFAihTifYadVuLRpizSh
         VrElx42Vjp+NHYUTOyNvySb4TwhCXgf6TDiNlASfMQO6en+BaCNPR3ATX3eEKGKQrozA
         93Fg==
X-Forwarded-Encrypted: i=1; AJvYcCXYdwuxwr/pjRbeqCRtJDasw4xCT2H9DngfPOQ82NFLQ7H0wN8E7vM0aW9THZ3gxVIMc471hfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoFvXjQ4xCpyPD4BQxRiwnUbKLSCFZf0hN7A/8S2wObC8Aez5e
	AfrEnjdjg+HAsp68epkgb2Gki2fCOuaGeMlUOB+Sn5tJDG8pRpWVrzV5
X-Gm-Gg: ATEYQzwA6Hb2EaqmK8s8bEWzEWGndbbRnhWULLwnNXXZOabiVUx1JbjqPNeFWn+Jzv3
	kXXZvgUS1eyVjXZVM2K4TqHLMbi/U/NyGcA3Jl9BmdDswnifHLZY0eRU52gIdcbhZl2RgOkITbS
	FH9begUox4upLVuDEROJJQzl9z7MNkGTWkIuoSBeWwB6ZNQrzFu9Cvwn6uPY20OeOZUu9geekMN
	YN4PjYHLTAXTg7hwXJe3rHeT6aNF5687zv3yR2Sen2VQYYKmBkDRVEmPfgnE3S4EEA/cX3k2ERt
	NDw482Zt0oiIw5f3SmeDnpQo1/U4ZNpfEqF4iTtPd+CEelE8MXZe5pFxBChi76A/hl/RYvDlnX0
	7bXT6voJaS2LPMwsKlvYGMqzi0hlZpRC0zy8KMb0DTzsaMVjp0IEE/I03ar96tpZOTaTUWrV/n1
	jGZ4bj1+KAGnJluUxgeS/vzZTN5B67cEmQEVhCHDUVubtpLnQyYaEfTs5/OQ+LvKbEUXefJ4zhK
	WUZSfaf9ZrhkF9MCg==
X-Received: by 2002:a05:6870:374f:b0:40e:eb2c:8f6b with SMTP id 586e51a60fabf-416e448a08fmr2339974fac.26.1772847940680;
        Fri, 06 Mar 2026 17:45:40 -0800 (PST)
Received: from ?IPV6:2601:282:1e02:1040:481e:870c:b200:7ebe? ([2601:282:1e02:1040:481e:870c:b200:7ebe])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-416e68368a8sm2857838fac.14.2026.03.06.17.45.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2026 17:45:40 -0800 (PST)
Message-ID: <2a638f50-6d22-4abe-9f20-74367a0f3295@gmail.com>
Date: Fri, 6 Mar 2026 18:45:38 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next 0/4] Introduce FRMR pools
Content-Language: en-US
To: Chiara Meiohas <cmeiohas@nvidia.com>, leon@kernel.org,
 stephen@networkplumber.org
Cc: michaelgur@nvidia.com, jgg@nvidia.com, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org
References: <20260302155200.2611098-1-cmeiohas@nvidia.com>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20260302155200.2611098-1-cmeiohas@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 8F6FE2296F3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-264998-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.878];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 3/2/26 8:51 AM, Chiara Meiohas wrote:
> From Michael:
> 
> This series adds support for managing Fast Registration Memory Region
> (FRMR) pools in rdma tool, enabling users to monitor and configure FRMR
> pool behavior.
> 

Claude has some quibbles with the patches:


1. Type mismatch: RDMA_NLDEV_ATTR_RES_FRMR_POOL_AGING_PERIOD

In rdma/include/uapi/rdma/rdma_netlink.h:
> +     RDMA_NLDEV_ATTR_RES_FRMR_POOL_AGING_PERIOD,     /* u64 */

In rdma/res-frmr-pools.c (res_frmr_pools_one_set_aging):
> +     uint32_t aging_period;
> +     mnl_attr_put_u32(rd->nlh,
RDMA_NLDEV_ATTR_RES_FRMR_POOL_AGING_PERIOD,
> +                      aging_period);

The uapi header documents this attribute as u64, but the code declares a
uint32_t variable and sends it with mnl_attr_put_u32(). This mismatch
means userspace will send a 4-byte attribute when the kernel expects 8
bytes, leading to either a parse error or silent data truncation.

Fix: use uint64_t and mnl_attr_put_u64() to match the uapi annotation,
or correct the uapi comment to reflect the intended wire type.

---

2. Type mismatch: RDMA_NLDEV_ATTR_RES_FRMR_POOL_PINNED

In rdma/include/uapi/rdma/rdma_netlink.h:
> +     RDMA_NLDEV_ATTR_RES_FRMR_POOL_PINNED,           /* u8 */

In rdma/res-frmr-pools.c (res_frmr_pools_line):
> +     uint32_t queue_handles = 0, pinned_handles = 0;
> +     if (nla_line[RDMA_NLDEV_ATTR_RES_FRMR_POOL_PINNED])
> +             pinned_handles = mnl_attr_get_u32(
> +                     nla_line[RDMA_NLDEV_ATTR_RES_FRMR_POOL_PINNED]);

In rdma/res-frmr-pools.c (res_frmr_pools_one_set_pinned):
> +     uint32_t pinned_value;
> +     mnl_attr_put_u32(rd->nlh, RDMA_NLDEV_ATTR_RES_FRMR_POOL_PINNED,
> +                      pinned_value);

The uapi header marks this as u8, but the code reads and writes it as u32
using mnl_attr_get_u32() and mnl_attr_put_u32(). The type used in
userspace must match the kernel's attribute definition.

Fix: decide on the actual wire type and make the uapi comment, variable
declaration, and mnl accessor consistent. If u32 is correct, change the
comment to /* u32 */; if u8 is correct, use uint8_t and mnl_attr_put_u8().

---

3. Declared but unimplemented: res_frmr_pools_idx_parse_cb

In rdma/res.h:
> +int res_frmr_pools_idx_parse_cb(const struct nlmsghdr *nlh, void *data);

This function is declared alongside all the other *_idx_parse_cb symbols,
but there is no corresponding definition in rdma/res-frmr-pools.c.

Because res_frmr_pools uses id=0 in RES_FUNC:
> +RES_FUNC(res_frmr_pools, RDMA_NLDEV_CMD_RES_FRMR_POOLS_GET,
> +      frmr_pools_valid_filters, true, 0);

the macro's idx path is never triggered, so this won't cause a link error
in practice. However, the declaration is misleading and inconsistent with
the other resource types where the idx callback exists because they pass a
non-zero id. Either implement the function (if per-index lookup is
planned) or remove the declaration from res.h.

---



