Return-Path: <netdev+bounces-279002-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id zK7WGlHB4Gm8lgAAu9opvQ
	(envelope-from <netdev+bounces-279002-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 13:00:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B5940D12C
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 13:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 97C01304D66D
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 11:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E0A3A6B77;
	Thu, 16 Apr 2026 11:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aQnboQpr";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ux7x48BZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667C439023D
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 11:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776337230; cv=none; b=FxZF+RfaFzwhjhRcRcDXUIYEVLYnSidx2R6kEU2UdEzJNDJEXAkTwNJhjn1Wnxj73HusKU+jHOPk8VwvXzOWHrZ04kRzBg/E0zIVEQ518HoummUbaMWHL2MgRYDQcfsProqPZJKecOj4PUBP8BNdTcz4TEdUSxa/7LmYR+Lcnu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776337230; c=relaxed/simple;
	bh=uvgls/AWo0ZB2eaUcYzcRFg7uIPxau3CKDqtTkrxZGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fonA5I9UHM/R+22Y4JLz700kEW3rdVzOSJ351G1X5H+N8rodLknVjVndKcPrCqprYoiBonRT0dppR9eHxZlPzBQNxfI3g3Sxjo8DnoDFrbMQO+fLW7Mp5GD5UZ+HN1js4EPHHrTMyeXgigq2YvVXNAtBGER65FV0AF9ww2Av8ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aQnboQpr; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ux7x48BZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776337227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=immR39HEnQITIkEYEn8WgdgXgd+QOcertjMezwfG0S0=;
	b=aQnboQprpKuFAwtXajdg4LKozsGu8B3fhyKS8eExHHa7d45DIsvTOYrsuB1Y7MkokOGxTG
	GS8uSGwgVhzIXbAPm3quRj5bt/IrIwYJVmhcL7YFz2N5oOL4QcFd2m1sxEOgDhve4CDAAB
	j+L7jiegiQAT6Xj4mYhbE3Ot5X+CXCA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-ICW0nYPOO9C3geQw7fNb0A-1; Thu, 16 Apr 2026 07:00:26 -0400
X-MC-Unique: ICW0nYPOO9C3geQw7fNb0A-1
X-Mimecast-MFC-AGG-ID: ICW0nYPOO9C3geQw7fNb0A_1776337225
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4837bfcfe0dso71629725e9.1
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 04:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776337225; x=1776942025; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=immR39HEnQITIkEYEn8WgdgXgd+QOcertjMezwfG0S0=;
        b=Ux7x48BZTWIjqrRtHBsxTAqmskx8Q/yX1Iu8qtii+WrTmQWV3Q4Oj5xaZbWWXhkPQV
         5pzAjkelCEzpqgKnoSl2d7wQl0wNCSRtzsUiC7QwBkC1HfXxl70+OOfvlaTP6+zsRwxg
         7YRGrO3Vuzg4JX7jd4UpMiMODPegom7b8avFT6BXf02nK/jzTFEhZeM2eMB4rxHF8Ch4
         9bOj23SrNkwKBCbb8kz5SopNG1IyHWPUpBWdvllIVpLBHiNVhr47Tp0QFveYM0GjWmdQ
         mZ6jRUjjIvXxr+vqBRhETLOi3mHxW5LRZtNGWNxppH5YksA6QOjdEDnTVNbIbyyg0JEp
         aF3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776337225; x=1776942025;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=immR39HEnQITIkEYEn8WgdgXgd+QOcertjMezwfG0S0=;
        b=gFWG4A8zd8w7XdDh+chG5VXrHyoJO2VBlDmgX8Q1cIe3F8FhrbFbgqJnU7wBN9r0my
         P3niFwxiprycGZu7/g9I9PwmuWfv3AxHrurwTf7ALSFQybpq8ls81hIR2dQ9sfXJxkDg
         bDqX88qRLzHhxUv2bSQdR+EU3a5i9EGZz7KK+ebj7d6DCB+hYZBFaHHR6zPj7pCywqPY
         ktLLOg2cnSapzbONJwwmJ4vdM1NXPWZvE98pXm8A+hNWZZ3ZXMDd3wZFLebXn7H2O+uX
         fW6lPPyG+sAjJTqLL+2uj3kNjIcbST0vma1p77UwLYcOP7nbPNvG5K6H6UujGfihvkJA
         rcmQ==
X-Forwarded-Encrypted: i=1; AFNElJ+fCIoazBdeCJLqeLBQEjxHhcwm/4icAQRe/fbGpgDSwStObvgNUYJewuHKyLywD4ZH8Nn2UR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQR8qkgI52H09SxNJLeZFcZGZgxCqTPka8wctKrN0CEkqDg6RL
	+LQrAPxSPyA9sqcncFYNhoJ6nlUQrkFoRPArcbEy3r657hWKdW+ggt87geL5KhPFH87V9UROMYp
	qLbCkKTraAJfa/DgbnSL+c3oOC+UCElJHNGMzQaYM9KovauGUvk8Egseylw==
X-Gm-Gg: AeBDiesnsc1cbH7bhbT7reYN/2d9K5afKZv+I69GZdbUZaE+Zidj9R8pqPfoQCGkrrn
	hBdX/IPCVp2VohFsWx1pxbg6OP89VeTZFlnJKqh9OIJAR+/OEz4d+vkEm9D6jiD8z/w3e0d5y9S
	GOeHRWyFogNGGi6k2H2/hJsKA0Vnu3WMqBE5Z8Pgkid6RvvwwATOP7snK0E/qhaMWkVt86lLcMf
	BR0YIsaFUF8/V1633KcBXA50+vtvAstt78Y4LC82pU5+AZSek1iBwa0mOpbq9Du+6MtWfywORrA
	9GTu038C8uIGFMjGU6sc3rOaEvyDMhKv+rVdbEiuiJCKTzEpgD68XoRs2pqPb1aaLP1IO6Igm3S
	3OEbAsUDw3SSo9ayR5F++BpC89UgQUJZuqTDlhAyqki9yyiR8cU2tMaecJ1qln9k3x60=
X-Received: by 2002:a05:600c:871a:b0:488:c683:be89 with SMTP id 5b1f17b1804b1-488d67f0b8fmr367583005e9.9.1776337224931;
        Thu, 16 Apr 2026 04:00:24 -0700 (PDT)
X-Received: by 2002:a05:600c:871a:b0:488:c683:be89 with SMTP id 5b1f17b1804b1-488d67f0b8fmr367581755e9.9.1776337223973;
        Thu, 16 Apr 2026 04:00:23 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.122])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f5821115sm46483195e9.8.2026.04.16.04.00.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 04:00:23 -0700 (PDT)
Message-ID: <77503dd8-d882-4079-9dc8-f0cab89c0a7b@redhat.com>
Date: Thu, 16 Apr 2026 13:00:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net V2 1/3] net/mlx5: SD: Serialize init/cleanup
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Shay Drory <shayd@nvidia.com>,
 Simon Horman <horms@kernel.org>, Kees Cook <kees@kernel.org>,
 Parav Pandit <parav@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dragos Tatulea <dtatulea@nvidia.com>
References: <20260413105323.186411-1-tariqt@nvidia.com>
 <20260413105323.186411-2-tariqt@nvidia.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260413105323.186411-2-tariqt@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279002-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C9B5940D12C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/13/26 12:53 PM, Tariq Toukan wrote:
> @@ -491,23 +508,35 @@ void mlx5_sd_cleanup(struct mlx5_core_dev *dev)
>  {
>  	struct mlx5_sd *sd = mlx5_get_sd(dev);
>  	struct mlx5_core_dev *primary, *pos;
> +	struct mlx5_sd *primary_sd = NULL;
>  	int i;
>  
>  	if (!sd)
>  		return;
>  
> +	mlx5_devcom_comp_lock(sd->devcom);
>  	if (!mlx5_devcom_comp_is_ready(sd->devcom))
> -		goto out;
> +		goto out_unlock;
>  
>  	primary = mlx5_sd_get_primary(dev);
> +	primary_sd = mlx5_get_sd(primary);
> +
> +	if (primary_sd->state != MLX5_SD_STATE_UP)
> +		goto out_unlock;
> +
>  	mlx5_sd_for_each_secondary(i, primary, pos)
>  		sd_cmd_unset_secondary(pos);
>  	sd_cmd_unset_primary(primary);
>  	debugfs_remove_recursive(sd->dfs);
>  
>  	sd_info(primary, "group id %#x, uncombined\n", sd->group_id);
> -out:
> +	primary_sd->state = MLX5_SD_STATE_DESTROYING;
> +out_unlock:
> +	mlx5_devcom_comp_unlock(sd->devcom);
>  	sd_unregister(dev);
> +	if (primary_sd)
> +		/* devcom isn't ready, reset the state */
> +		primary_sd->state = MLX5_SD_STATE_DOWN;

Sashiko says:

---
Since primary_sd is only populated if devcom is ready, this condition will
never trigger when devcom isn't ready, contrary to the comment. Instead,
it triggers on the normal path after devcom is ready, immediately
overwriting
MLX5_SD_STATE_DESTROYING with MLX5_SD_STATE_DOWN outside the lock.
Could this allow concurrent mlx5_sd_init() calls to see the down state and
attempt hardware re-initialization while the group is still being torn down?
Also, can this race and cause a use-after-free regression?
During a concurrent Socket-Direct group teardown, the primary PF and
secondary
PF can execute mlx5_sd_cleanup() in parallel.
If the primary PF completes its cleanup first, it will call
sd_cleanup(primary)
which calls kfree() on the sd structure, freeing the primary_sd memory.
If the secondary PF is preempted just after releasing the devcom lock,
it will resume, evaluate its local non-NULL primary_sd pointer, and
locklessly
write to primary_sd->state. Does this dereference the freed memory of the
primary PF?
---


