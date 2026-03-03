Return-Path: <netdev+bounces-263119-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJ+ZGC+7pmk7TAAAu9opvQ
	(envelope-from <netdev+bounces-263119-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 11:42:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3A11ECDFC
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 11:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2BFB31190F8
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 10:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5710C38229F;
	Tue,  3 Mar 2026 10:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFyilK4N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF785D8F0
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 10:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772534205; cv=none; b=prpxtciBu27h9k+zOaic+/WviemnAwcpc6u9A8YEowLGIJ2j2ufnkZp+qvAokylesyC+S9ULellDhYP15s/x6thCqtW8ElBXEaCNJ+ViEJIKD9x5ynldgx7dOCEYaDuKiRe6S3AU+F+hXaNcrPJhkXs7e3G1VZaqJ60GiHaVDbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772534205; c=relaxed/simple;
	bh=1rjxW/gEDvn7mZR1MF6JMbQeqfXPM1b3WdfpT/gBD4k=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TP057YKGo3ioM4Eu+WLBgShb0fXzXj3p9rYGe8vMMLn9HWsWO/wfE8jPKKNHl4AtMcPp/y4mGRWlzO3foe6esEoKVDKL0ztp6B9w8EkAsJkkcQS4yJgpRjkGRLgqpCsj8c2ypfYOupuKE3THfC8AK2+3Qxl5Uvnu3xt8/N3GH7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FFyilK4N; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2addb31945aso40726705ad.1
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 02:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772534203; x=1773139003; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f1los/pfPSmKakgcrBheDkXg5dHteBXNTE3QfxOrjGo=;
        b=FFyilK4NIQzjfQgJSr3H54R+Np/IRKj8Gm4vjLi1tWWhVvG2qorbo1Bb7PLLmXLIvC
         rHAkkmNKZND/I9KIaZL1Thsn+0JwvXO2zRKaSjGpMeZFI+e0xut+k1jgZya/E1I4UfTD
         A+X0UGlmqA42rKv7bMiyUPukmKI5jicp9ft1IA7vZW9jmOBTjIU5KyesOyTMNsQV+qm5
         ZoKtBdzGvbW5Z2A4nrWoFRAzbWmycuKglwwiXT/JqDgcCPfQWffcBm1EXk0Nbjuqe+Qp
         JozlmOhMfy/qEz+VATew6Wh4d+kXo0DPp/KJq7x3OpFGkAx0Ywn1YgWgY//ADhSRd+Pa
         BtHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772534203; x=1773139003;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=f1los/pfPSmKakgcrBheDkXg5dHteBXNTE3QfxOrjGo=;
        b=lF233Il/s5Np+D+9YwgjohuWGkknXYux5mvtimPJFUGkwrho5MBmSxPyT62eUO4bBv
         QgORV75vnEynmJIIWjGdBHjCreHuAKjGeC3h6v2UZku2fZtX6xh5frZGJbZwKP81dgO6
         0X+PynLue12Oh4CaV2Ynl4suRLECNWbYEiI+rfjQgJ/8uBfM4+gfhGOb7rZsMz6cBsEC
         XVw+YtsfbXBpXOvoeVm4oWge+Vfc+viKGc2/SrTtmpDsXeRA/Ov91V6htigUZzC0RTLU
         nL/xHS2864FwEqXxf0ArZ7m3uOJzvHpfdA+JF3LtaBsb47O6n0+D965Xttbhw7g9WCGO
         xi6w==
X-Forwarded-Encrypted: i=1; AJvYcCU7fLPwONZqxW4yCKW5jRNQM6oTAZosiQ8mkOxWo1RFedTVshQ1Tj8zeqGXl65unqZByvjz0jk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBsNf+WJnoHpyMvjSW9aKtU4uROQPUPPBpu4pKeb4I4nD6262L
	hc8dgmQiS2wMMdUvBwOyHHUCilyN833n96rNcuxiAO7E9U5jqIb+aZP+
X-Gm-Gg: ATEYQzwIbt1K8KJI2jrD6tIP+i5/xgIhtCJMZrqSb4XruC7E1s1rnFxjq/1ghL19/Up
	S29Xc9op5VyqacveDBNPLp/NK3tZ8vtlq0xWkURVS++VrSkSUKjArLspOtJd7Qn5d8e4ipZnEYI
	mde93fYLplF6QuRgse0IjouBmseNiUayKe7Rw+MOWdMiJJp8YfEyzKHrSO/6Dk0WzkytR0Lxv7n
	DTz2XFBT5gkaaSjEKnDOE9JUdMb1I8/vu+ZcRNeS/BXRg+LkzYd5dtI5BgbzMLX13QJNRq9zL+M
	LALp02WoZQrlxb5oBS7rAtN+czF3vJ0UQ9WB61ob4X5kz6S0VVC2rQYmzQk4XGrFI+qbEIUoCcZ
	3eSS5XMs+PawLjzwP/t2H2FrZ2V1UmMLpN1avr8K6tK3IAZOxuaVXEbIzskFPrqG5IgnfILDUE3
	JSPrmkS85Pz3JBqM7OnqF7/BoY1eehjPJomXjh8R0OO/w3ctS1RPW5TnCfBr/RmoI=
X-Received: by 2002:a17:902:fc87:b0:2ae:5104:571e with SMTP id d9443c01a7336-2ae510458f2mr58341285ad.9.1772534203306;
        Tue, 03 Mar 2026 02:36:43 -0800 (PST)
Received: from eric-acer (36-225-117-207.dynamic-ip.hinet.net. [36.225.117.207])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6d24b3sm158606995ad.78.2026.03.03.02.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 02:36:43 -0800 (PST)
Date: Tue, 3 Mar 2026 18:36:39 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: charlie910417@gmail.com, jserv@ccns.ncku.edu.tw, leon@kernel.org,
	mbloch@nvidia.com, netdev@vger.kernel.org, saeedm@nvidia.com,
	tariqt@nvidia.com
Subject: Re: [PATCH v3] net/mlx5/core: Allocate ttc_params on heap
Message-ID: <aaa5tyHK5L-btPtd@eric-acer>
References: <20260226114219.2111793-1-yphbchou0911@gmail.com>
 <20260226174601.2120282-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226174601.2120282-1-yphbchou0911@gmail.com>
X-Rspamd-Queue-Id: BB3A11ECDFC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-263119-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,ccns.ncku.edu.tw,kernel.org,nvidia.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yphbchou0911@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 01:46:01AM +0800, Cheng-Yang Chou wrote:
> The ttc_params structure is too large to be allocated on the stack,
> triggering warnings for exceeding the 1024-byte frame size limit.
> Consuming excessive stack space risks causing stack overflows.
> 
> Allocate the structure dynamically to maintain safe stack boundaries.
> 
> Signed-off-by: Po-Ying Chiu <charlie910417@gmail.com>
> Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
> Suggested-by: Leon Romanovsky <leon@kernel.org>
> ---
> Changes in v3:
> - Use tabs instead of spaces for indentation
> - Link to v2: https://lore.kernel.org/all/20260226114219.2111793-1-yphbchou0911@gmail.com/
> 
> Changes in v2:
> - Use kzalloc_obj() instead of kzalloc() to align with the new memory 
>   allocation API introduced in v7.0-rc1 (Leon Romanovsky)
> - Link to v1: https://lore.kernel.org/all/20260226092857.1583984-1-yphbchou0911@gmail.com/
> 
>  .../net/ethernet/mellanox/mlx5/core/en_rep.c  | 15 +++++++++----
>  .../net/ethernet/mellanox/mlx5/core/en_tc.c   | 15 ++++++++++---
>  .../mellanox/mlx5/core/lag/port_sel.c         | 22 ++++++++++++++-----
>  3 files changed, 39 insertions(+), 13 deletions(-)

Gentle ping.
Please let me know if any changes are needed.

-- 
Thanks,
Cheng-Yang

