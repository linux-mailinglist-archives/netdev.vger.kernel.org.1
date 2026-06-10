Return-Path: <netdev+bounces-297867-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bvpbE1X5KWq0gQMAu9opvQ
	(envelope-from <netdev+bounces-297867-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 01:55:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E34466D745
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 01:55:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=jN3lWqlu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297867-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297867-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F0853085932
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 23:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33853750D5;
	Wed, 10 Jun 2026 23:54:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBE9328611
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 23:54:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781135677; cv=none; b=s8UdVsLxBiJHundqah+5LsOymgrg0auct6pKrIWA518UzUrJ0UaiX9j37RHc08s66dSoR49C+iHy+QTLm8NG4s9zyJ3A7xP8NEdtXh7/YJn7WM1N6cIrI6E98qSiSZOsOs6GZaqxa32FXaOG83lo65hodDUF8MiZKgeodOBIy50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781135677; c=relaxed/simple;
	bh=R+wUutuwT+5QI84LgboJOHnbBhtzWpMTzlAyxl0pepM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CEB1OY6u6I1QoWJMxjPDAbIUKa06Nfkiew/V/N4dE5WFNA9eQqkVd+JEx4plDb5GlnsXiKID3UM6dKwf8U6NYDOqNltKGXeoVZPcnxEZPcGYjkGZxaXsE9Z2r9yDBkyXgrXZjDxPEeQ/wotBVqHsXHzPVbok/zut+CiWTL1SRSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jN3lWqlu; arc=none smtp.client-ip=209.85.216.46
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-36da8439078so6412929a91.2
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 16:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781135676; x=1781740476; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UJuxqMjj8s1mtTk71FrfuP5SorAlRG4cVqBQ0z56DYc=;
        b=jN3lWqluFmBdi75CDNMg72O5s67s2kROd430FcksV7HFemjZ7Da2vywr92+JjIKm+C
         En9c4IxPtLn7G8NhUYvhUeu+bDcr1yQfiAw6dV/4RNOlMuH2OFN2pmPjqAHAmkyJ55Y5
         5QmSHO7q87MVYbCyEmi9q/JsnxmlWyoFr08U5WZwg34fnFTFxOL84UccJNKpq64+ud5F
         bxmmnLNpWFiR1hTjGPoTqZ0dJAIutS2qlZ/jctnf+NYPjG48hi1wKueWhLD/wEPu3qJ1
         FTcaLJs9xMoL6+zRs//vUM+5hefoky0IVYoiJyktCELqy2uFQd9/Ifoivy5FVzDRR3j6
         S+bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781135676; x=1781740476;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UJuxqMjj8s1mtTk71FrfuP5SorAlRG4cVqBQ0z56DYc=;
        b=DDrIzwjGkA8z2S86SXOP9NMzMCiqHYCouu0u2VNyNecbEs7Zr51+xrD7Nku7c/GwwI
         nBNNpzVxW/fjJ77K5Un6YfERZ9Teu+gjyPZrexmuU26ATZ9ELjlwl+7askCLmNipzFVz
         m8S5rOkuL3d3DPED+mP4J3gLNxEsibLe4kR5J0H4tGZim2KjRmnkMfU2qrpSLsVU0u2C
         KYeJTOGMcLy4/qtbW60LbFNFVMvt2MX3xadb+4VUV+icsj6h+IRaPhz9DztN9otgsyae
         knHyHbU8jQoox1z/fRKb1UO5w3O4CoA6kKta037bII7j/MvRk5JqCFku6FBxPShMpE3U
         kEHg==
X-Forwarded-Encrypted: i=1; AFNElJ8OmUIIbcNtZ9JRC0bWQK7xxkkqm89E6VGDSq2CQwhokItRM9OqXNH7xAA/U7mKEeNv3dDRHqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ1dmpHM8V+HEaGt1Cduiw/8mxKmKW+0emVrPG5SgmtJXXMzvK
	khzXrU/Om/2jtgAA3AHXJ0wXfSqPAnR5229P5JT3kJoLLH7cr6S6gF75
X-Gm-Gg: Acq92OGehJCxQQpmYr3rNxPbxHrQ7tUAfKchzZHU+3fVnVvY/VGzb4i0Nx1wtCWE79g
	hbl+UwfbvXY+AG223lczNThYvfY3Hd5dN4xVkQpigTojMS1zqDN9wHixU/0CGHBmlgvdv0cJEIB
	JjRlGwSB/Z5jM4omd2FPCyosDO7w4NiLdn9cL9PGW00sNqVonYJ7xQd29nFj1XTSsnnQj0Ih8AN
	gj6ogfVy8QPhUV8UgVx5zrI/741NduHyhBaRQDi6h6EKNG8wqIOLhuDse4jpvGYy2js/BwX2juq
	En1JAA7apBhT9uIBzpf6wQyTom2q0OdFjm6pZGf/k/l9ZkUqqod4jONnyHkEQKUfdTr9p0PP8Vj
	Kn4L3Kt8PdC2CSDNZmU2BTy//c1Uvbk2Ds1jQuldJYHDLRZEAt/W6G1rv2RUyqzV1aTTN9KzUoL
	v9IcxnFwslBbtAEjMfNbYWRwf6uR6l+iIewYOth9iaDDGFcR9lFluMDDRqP2E9i+Ai/w==
X-Received: by 2002:a05:6a21:1f8c:b0:39f:3ca8:a33b with SMTP id adf61e73a8af0-3b5e31f0202mr45982637.17.1781135676116;
        Wed, 10 Jun 2026 16:54:36 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:4a::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df0b374fsm21882661a12.25.2026.06.10.16.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 16:54:35 -0700 (PDT)
Date: Wed, 10 Jun 2026 16:54:33 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: kuba@kernel.org, razor@blackwall.org, bobbyeshleman@meta.com,
	dw@davidwei.uk, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 4/4] selftests/net: Add hugepage kernel config
 dependency for zcrx
Message-ID: <ain5Odzu6ybCuMRT@devvm29614.prn0.facebook.com>
References: <20260610080344.701380-1-daniel@iogearbox.net>
 <20260610080344.701380-5-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610080344.701380-5-daniel@iogearbox.net>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297867-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:daniel@iogearbox.net,m:kuba@kernel.org,m:razor@blackwall.org,m:bobbyeshleman@meta.com,m:dw@davidwei.uk,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9E34466D745

On Wed, Jun 10, 2026 at 10:03:44AM +0200, Daniel Borkmann wrote:
> test_iou_zcrx_large_buf in drivers/net/hw/nk_qlease.py runs iou-zcrx
> with rx_buf_len > page size, backed by a hugepage-mapped area. Thus
> add to the Kconfig.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  tools/testing/selftests/drivers/net/hw/config | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/config b/tools/testing/selftests/drivers/net/hw/config
> index cd20024218cd..ed8642b68094 100644
> --- a/tools/testing/selftests/drivers/net/hw/config
> +++ b/tools/testing/selftests/drivers/net/hw/config
> @@ -3,6 +3,7 @@ CONFIG_FAIL_FUNCTION=y
>  CONFIG_FAULT_INJECTION=y
>  CONFIG_FAULT_INJECTION_DEBUG_FS=y
>  CONFIG_FUNCTION_ERROR_INJECTION=y
> +CONFIG_HUGETLBFS=y
>  CONFIG_INET6_ESP=y
>  CONFIG_INET6_ESP_OFFLOAD=y
>  CONFIG_INET_ESP=y
> -- 
> 2.43.0
> 

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>

