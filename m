Return-Path: <netdev+bounces-284051-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id II6QAk0U+WkY5QIAu9opvQ
	(envelope-from <netdev+bounces-284051-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 23:49:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9BC4C4381
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 23:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57B2230262C4
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 21:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D28367F2F;
	Mon,  4 May 2026 21:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="adKnOEFo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198D1363C6C
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 21:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777931330; cv=none; b=PcdtBUqoTv66ONntmuBsxoq8S+g6ZO+Yger0Odz/DeR/1pOUwrQUIYWWC8ekPI07udJSXQOzP3e4CsYWob2dol3RqJCFM03EXCxZ/qXfYrVtNVUJeyEzPkadEy50O2BoKEVfYhp2CfV3yoiEiD4vPgq6R4sqXYBNMUKjDGjJYJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777931330; c=relaxed/simple;
	bh=LEfOvRpQYcrDqT5+S4ih49Shh2djX8a2POcizZgtyEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NX595gCC1oYtjpten3tz48XQYv4sq/6/I6gnxLUu01BS6IXiFwbdX0GQ/EuS0PHjKyUVX3SP19Wx/BiDHzZFYF9z74XvAomb7qp7KIRUnOHjqCbU/RhipHpPSvAkXYnkG9JOhpCIvFKSKScqEWIzS/N4jVQet0PHcBcDcK2MOZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=adKnOEFo; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ba0fc8b1f0so10530235ad.3
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 14:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777931328; x=1778536128; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vleGyxmKxeO4GNIP1qujBMrg4IEFuG1bs35WPUgfDlk=;
        b=adKnOEFoXz8qKyDlRnCzuv19P42xuHX1j5IMWit1iPOaACz58vLrro7+KtChAqMHi4
         NN0kxyh6ALYhlQPMtHP5elg8BDhKa/STk1m40G4b1+uyyDWrFybAu4s0AKgUWN+Iu+gv
         7drE30Tz3QjQmQj85S9V3p9GxoQd1iJUfjXgMZAmOYsI+0Sb76almUULwwTvJk+ZOfo+
         vJynjbc3R+DgLb6ACaqfjvG62vFHcwsZ6Uv+NEVai6jqefs3VdFCDonF83jqLhSAabkN
         BiK3rPc2fD6Gva8X7ep67gmyVKygxwyPymokKyKyPqKDCQmPUQ1yxsQ5oZHhEakGEH/q
         8ZzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777931328; x=1778536128;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vleGyxmKxeO4GNIP1qujBMrg4IEFuG1bs35WPUgfDlk=;
        b=HJvMv8woVRwWAlhyBBTNbRjeiI9791wcQRnUqU9rP6pg0TJbDwrma8ahZqlp8XRPKW
         zPL4C48UK718zg7apQ/Jp7v8aQn23QRyXsGRH2WEcLx/3RHoBzxqgdeOyLbzbhvfmzPO
         vkqyOkVc1cXCBzwN9nfyzhSyaEoYs6xrM4GHJw9Ji/h3jG7W5aPTIIVH8+9la/CZ45hV
         Z1uHtmwbG4AXPUOcAdC7RPXH8g/CLT5ZL7CQjYDEJUQoVv4FSc3+bRQ3yG27camW+ccR
         oS9dOY8xdJX8lwL/2K1k+/bUqz3hkdImYcTSsL5l5FUeBT6J5cRo/24OIJgVVpoPZH2M
         g/og==
X-Forwarded-Encrypted: i=1; AFNElJ+9c03MoeMt4K1U+3TXnT5Hg6G6fWQWnf3mHOnzNrU2HoSidw6DjOEadHhcygoexEL+ZqyCqlI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXOf+rBhS+MUiDLZ0Rk4m7eJLF9/f+Tmik49ulJCgfvkaIvcxy
	w4zrxJKBMpFHePAryagkuC4179Qiifrr1ZKoXf0wRPRpAnIGxPttrsAc8ds2OAhVo3ytx8zWSnU
	JOGj/Uw==
X-Gm-Gg: AeBDievYsVumczHGaQZIJP2ojSAz+ZSyN494OBxvRt7ISGsJ4eklCHZ6E4xAtc4iukc
	iARGXUB68HTk9i/SF7KbMPZpjLWknlWB9ISZlAtmvFAhS4/BHYLTBOjtnsd3r1M3QPy39wPefKU
	KjHb5Z4uIdIu4QOBH8JgXNCXPipr6i5ch6w2Wq4c8b83B3aJTKSPh4OMXBu1h+fo08O5tPdYzh+
	V4PiamEMKXwJIDJyG6E+9Foc5troKKGNeVaNoj1WkS7OJqXpRZMySHtagwb4SV8Xq1DW2nQO4CP
	JWIJBsH3wEwEW5UvFR0rXeAL22PJJ4l70/zacB2rhd37/tq28evoqsuWHIdFQk3Hxg3gcoI4vXw
	bOtTiXvU26YiBDNC0k4NQS4bNxg3ZgV3WKFJ3DZJDkQaC+s9jLTFkyOrqhlLcjfmB/sk6nKUXZ7
	mKGtO7JkrNSYsxfEJz33CUKck1FlpOzW1bzK7x9/7QXjnOSTTT7hcWcPy2845De5JEHH4bdeIDN
	8/ufQ==
X-Received: by 2002:a17:903:40d1:b0:2b0:ccad:de1a with SMTP id d9443c01a7336-2b9f260b4a7mr121673915ad.30.1777931327578;
        Mon, 04 May 2026 14:48:47 -0700 (PDT)
Received: from google.com (76.9.127.34.bc.googleusercontent.com. [34.127.9.76])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9caa7ebc6sm115903505ad.5.2026.05.04.14.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 14:48:47 -0700 (PDT)
Date: Mon, 4 May 2026 21:48:43 +0000
From: David Matlack <dmatlack@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org,
	Leon Romanovsky <leon@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Shuah Khan <shuah@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	patches@lists.linux.dev
Subject: Re: [PATCH 05/11] selftests: Add additional kernel functions to
 tools/include/
Message-ID: <afkUO56H6KPy5afA@google.com>
References: <0-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
 <5-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
X-Rspamd-Queue-Id: 9E9BC4C4381
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-284051-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmatlack@google.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On 2026-04-30 09:08 PM, Jason Gunthorpe wrote:
> These are needed by the VFIO mlx5 selftest in the following patches,
> which includes some headers from mlx5 and also needs a few more
> MMIO-related features.
> 
> - DECLARE_FLEX_ARRAY in new tools/include/linux/stddef.h (wraps
>   existing __DECLARE_FLEX_ARRAY from uapi/linux/stddef.h)

Is this needed? I don't see it used anywhere.

  $ git grep DECLARE_FLEX_ARRAY tools/testing/selftests/vfio

