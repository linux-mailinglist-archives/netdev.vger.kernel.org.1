Return-Path: <netdev+bounces-257242-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBG8FuG9hGmd5AMAu9opvQ
	(envelope-from <netdev+bounces-257242-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 16:57:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9A9F4D60
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 16:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1D8273006098
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 15:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7E142DFE4;
	Thu,  5 Feb 2026 15:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f36gIb70";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dgbWmAbY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2113D421F10
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 15:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770307037; cv=none; b=YmIeWpK+MYNN4Vf7c3ZXbRE6sbXPTJBwnuuShR+J1CnEfbyjnHhsHXzOEqhmBCUvgZNh2LdpTLyyV6dM5hiIBbqbATABUxFoLpaJTpz+0kGip7mtVrC4YLdswoyFfQT2c+nIffYJyV7CQJZ0qjsNzfQShbmHuRp6N2JOmHdS2FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770307037; c=relaxed/simple;
	bh=uTFRtOzk76BST5VS+Lip0kikkOj/ahnj2fnN6yMO73E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eOo7fLfqnpnku6mpkmOGzfy0plkPdtzPSZ87YCnXK6fJbTyXUoAho6PX1clEeJf+b7nknQtNLtUOsqk5LJaFdz9ScMMEeXKh10BnTg0VQ7JXGSHPIWNh+5j78KFoy501ze3psYnGQpfOC8pU/x2ZBU0VIih1fjGwf/JAnEZFx4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f36gIb70; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dgbWmAbY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770307036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XGSaW/PyR/xsnHgTVbJJStPR08qCT++OSZAv5+zvB4U=;
	b=f36gIb70PBpcv8IIrSTQEk+xvhtbNHgKuTSfr1+0YsefrGjDh9byO+yrDJvSdQefOaj0c5
	5yjOAU/J/SqF0+OFJISpeOgO1B1t79D7hpA6YcOWyRqhf8F4M9p2mYVplm8bgloCk5A+gS
	56S/2YmfcczidBjTj2A/+yuKJgLsh9s=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-fcyLU0hBOEelcujN86iqWA-1; Thu, 05 Feb 2026 10:57:11 -0500
X-MC-Unique: fcyLU0hBOEelcujN86iqWA-1
X-Mimecast-MFC-AGG-ID: fcyLU0hBOEelcujN86iqWA_1770307030
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-435add03f12so795851f8f.3
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 07:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770307030; x=1770911830; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XGSaW/PyR/xsnHgTVbJJStPR08qCT++OSZAv5+zvB4U=;
        b=dgbWmAbYlKzwSfbmf78zJpF09VHdVBYZEzjC5ZHT9mWYLjPS9weLCBVCyszJt0jK+a
         yH2+z4HTH9TRSMqv6sFAvT+VKe4ua3yh+2G95PcGFLRaKbO/bJhHd0feTDJ8RXHPPsDQ
         7QMnLd9x9lvzXsDLVHx9ks9Uol4zwtZydJswksL7Ldj/uzecd1dSJ0arOmnt5Zr6ZmtA
         yfTV+7d2YVyDMWwvH/VBTifM2JUNyYbxnQ+lY76jQZFTcYwW5uQUSC9iAbwZ6XYWKhZn
         Eb8iPn54JjRIhBKyiCxS/JbzXFDWxeZe/AKSjDF97tCZgua1UBqCCJ5L8RKC1qJeFj+G
         XsYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770307030; x=1770911830;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XGSaW/PyR/xsnHgTVbJJStPR08qCT++OSZAv5+zvB4U=;
        b=cHwx1LfTQGQHFTt+hfqdGZAje8rvUWWo48UBtDQ3Wyo20uZ4PSbVdwlafRa3lc6O/7
         X7XMJ7opKoucl9lrmz8gtyRE88RUKw5mg/SbnpANbsBwLYNUXSSERhRvGPRsbVsF/UZN
         5+PiCmYVH6X3yE4UDpZ6FnXZ32LWDC59KhcN/2gk8pSNL182ohvc0tcQMwLch+2uqKst
         T/CS9qyQ9ZvpR2IjuQUbf5D24/5ZVIfV67app3GALAKREXhMH4WjKtv1OQ7eq98Vennm
         L1KV0C3dsTrjw7fX+jY1PWJdheRb+cWo07Itr/wPdlwCZMOEU/WWlF2pSNNUvDhLz+Hy
         4i4A==
X-Forwarded-Encrypted: i=1; AJvYcCXhO9AC12MJy7+duIWYOuQ02Q6f8T/4FjwYryh/EDAhE1OfriYy3dF0w7jEZR4WDWarPsOKQPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXHMK28alIs7BBjb5LraYeQx8jW7Fp9UdgIayj7W7ivdrrtltR
	gUTZu4IgBaJjkcaNqMp/TJXJe9iR8T9BjxmmU17y9uoypr2doTZfbXEVRBcUKpI0rpqv1E2fG1h
	UBnOKHZpSYd9oLVOs0e5mdLXFNpCkppOuCkisJ4W9xHU087B7PDeoK2stxqS7JNGCyQ==
X-Gm-Gg: AZuq6aI/ITezfZD2hdsdt6o2FVQMagi66R2roHUODyFiMIT5jJuxHRb+Ci/al4I853E
	w6Ous3SXRRuIH4CXyEcGrZ3gdYROwUYzckBACEyxjG9vAX7628y5j/ZIuUV4sm4zzNzxar92yyp
	1/LIYSdN76/bXLaZCF78TVEQfg1uSKt22wNPP1cbY+hwFZtTHSyZYUGvSOfBf87Omms46kSdXgm
	BrfVT3XDVccbBZduT44FXW0sjA9Wxog/3JnGlUe7DvIxv5AJ462fMylLLxLFzBpwfTLpptV4AFz
	jBY5xJFSGW5vutevMcSgw2tkmpwWjZTlDiqARxqoA+xw628D+F4o2exF8JNXIp2e+H27F3X1hAc
	WBxNDJESls/3R
X-Received: by 2002:a05:6000:1ac7:b0:435:a647:a3b8 with SMTP id ffacd0b85a97d-43618055314mr10647371f8f.36.1770307029620;
        Thu, 05 Feb 2026 07:57:09 -0800 (PST)
X-Received: by 2002:a05:6000:1ac7:b0:435:a647:a3b8 with SMTP id ffacd0b85a97d-43618055314mr10647335f8f.36.1770307029161;
        Thu, 05 Feb 2026 07:57:09 -0800 (PST)
Received: from [192.168.88.32] ([216.128.11.114])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43617e3a546sm17453676f8f.17.2026.02.05.07.57.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Feb 2026 07:57:08 -0800 (PST)
Message-ID: <722cba76-363e-4273-8150-2b50c9f591a5@redhat.com>
Date: Thu, 5 Feb 2026 16:57:06 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/mlx5: Support devlink port state for host PF
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>,
 Or Har-Toov <ohartoov@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
 Parav Pandit <parav@nvidia.com>
References: <20260203102402.1712218-1-tariqt@nvidia.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260203102402.1712218-1-tariqt@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257242-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: BC9A9F4D60
X-Rspamd-Action: no action

On 2/3/26 11:24 AM, Tariq Toukan wrote:
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
> index 4b7a1ce7f406..5fbfabe28bdb 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
> @@ -1304,24 +1304,52 @@ static int mlx5_eswitch_load_ec_vf_vports(struct mlx5_eswitch *esw, u16 num_ec_v
>  	return err;
>  }
>  
> -static int host_pf_enable_hca(struct mlx5_core_dev *dev)
> +int mlx5_esw_host_pf_enable_hca(struct mlx5_core_dev *dev)
>  {
> -	if (!mlx5_core_is_ecpf(dev))
> +	struct mlx5_eswitch *esw = dev->priv.eswitch;
> +	struct mlx5_vport *vport;
> +	int err;
> +
> +	if (!mlx5_core_is_ecpf(dev) || !mlx5_esw_allowed(esw))
>  		return 0;

I was able to miss the AI feedback here:

---
The old host_pf_enable_hca() only checked mlx5_core_is_ecpf(dev) before
calling mlx5_cmd_host_pf_enable_hca(). The new function adds a check for
mlx5_esw_allowed(esw), which returns false when esw is NULL or when the
device is not an eswitch manager.

When called from mlx5_host_pf_init() in ecpf.c on an ECPF device that is
not an eswitch manager (the path when mlx5_ecpf_esw_admins_host_pf()
returns false), this new condition will cause the function to return 0
without enabling the HCA.

Is this behavior change intentional? The old code would enable the HCA
in this configuration, but the new code skips it.

The same concern applies to mlx5_esw_host_pf_disable_hca() below.
---

and indeed it looks relevant. I think you have to follow-up or send a
revert, whatever it's easier/faster.

> @@ -1347,7 +1375,7 @@ mlx5_eswitch_enable_pf_vf_vports(struct mlx5_eswitch *esw,
>  
>  	if (mlx5_esw_host_functions_enabled(esw->dev)) {
>  		/* Enable external host PF HCA */
> -		ret = host_pf_enable_hca(esw->dev);
> +		ret = mlx5_esw_host_pf_enable_hca(esw->dev);

Just FTR, more AI feedback here:

---
The old host_pf_disable_hca() was a void function. The new
mlx5_esw_host_pf_disable_hca() returns int and can fail, but the return
value is not checked here in the error path.

If mlx5_esw_host_pf_disable_hca() fails, it returns without setting
vport->pf_activated = false. This leaves pf_activated set to true even
though the HCA state may be inconsistent.

Later, mlx5_devlink_pf_port_fn_state_get() reads vport->pf_activated to
report state to userspace, which could then report incorrect state.

Should the return value be checked, or should the pf_activated flag be
updated unconditionally to reflect the intended state?

The same pattern appears in mlx5_eswitch_disable_pf_vf_vports().
---


