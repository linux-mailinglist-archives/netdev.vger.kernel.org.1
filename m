Return-Path: <netdev+bounces-250210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F80FD25008
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 15:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 220DF3005F3D
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 14:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66BB199252;
	Thu, 15 Jan 2026 14:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y03g9Vto";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="m6je4vTJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6857F30E82E
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 14:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768488094; cv=none; b=qP0nb+COVfbjL+1KOyKA9hG8UalS4e1v3gWqJZnJjmwoplIEtMi1L/bchm8VhwZIhkMybS/nZFTQ6+6KieFbNjDZMiN77WZwqEMZUy9Q+WZodaG2dOdwZFQt9rX3bDfUR/UjfBT/GRo3dK19sBQsyu/4QBMHSGvsz6DCgwbYAAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768488094; c=relaxed/simple;
	bh=TyU0gMLqFTK+pDBPFxFjaSk3mG90q+s7JHDJ5rmGvyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g7SJqeTU/YT0iMLTi07sT44NVM/apf3kWqZZ1iUwk6kliefQM0IhImyhy1Wxuc58YEipP4ubF6hWPhQSfWpC8RaZRcEprjK4vSApx/jEeiJV++Eb3+zA61jJVn+Cz5Zp73QqH8C8uTX/goyUXriK1iGMQFNAP4vxj6rbXHcQokI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y03g9Vto; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=m6je4vTJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768488089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vIbzKrAPTN6vgr0Z1Kn5aIZgGvfkFePJqqJV9nUj6cE=;
	b=Y03g9VtodqqYXJfRui5jXFqYZ0EVGk9Y69Xvaivvfn/gwDwfsFuIf0fCeL1s9/2UqyQ7r0
	eO1RhaS6gw0WAWh0NNG9BRAzbqm3Mb0/KDaYkC4DZ26VeFzYQiMx1dVF5I6AbYKrCjFCNV
	tw5wenFQngW0VgF8CI7t34YW708fbA0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-q6_eoXAjPQGEaYm12SBVUw-1; Thu, 15 Jan 2026 09:41:28 -0500
X-MC-Unique: q6_eoXAjPQGEaYm12SBVUw-1
X-Mimecast-MFC-AGG-ID: q6_eoXAjPQGEaYm12SBVUw_1768488087
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43102ac1da8so895376f8f.2
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 06:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768488087; x=1769092887; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vIbzKrAPTN6vgr0Z1Kn5aIZgGvfkFePJqqJV9nUj6cE=;
        b=m6je4vTJ1Yj9QAFVZGtE/fZX2MW7dWlZow1df5G2lHI9R8SyPCDjgP9tKND2LALlxu
         fbidf6d75jykZQwF/7JNqJWksGOMJI6xYESJ+Uv8iC18TaUGvEL8oTtlb5mg3X6eDOSL
         KXX4NrTYdO1M/0e/Sh5/hnLmyFIDQ+c317btyBmTPeBWmIi7+im4Ql0JMxph/tSpCpEK
         0Ipq3G9weVAob8rJZFxzF8Xb7fZFN4+axpzhcVVk72Q0TRi7Jkaiavo49/Giujskwv75
         upDZcHzNNPOoPIHcu8ejXwSibnpgZZClYqAEMGy7SbTBUOZZTa8V/o06gnASJNHegoN5
         Gcxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768488087; x=1769092887;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vIbzKrAPTN6vgr0Z1Kn5aIZgGvfkFePJqqJV9nUj6cE=;
        b=PqZkCn7nlrtM79x7S0zwoa1/sgOuiUAqVMJQ1F+Y6twzTvax6eibwVZKoK1KbkXJqV
         cXRw+YTBE1xEQrNy92YsFXd7qCwDzANt1xMIlNPkIQYka9X2WYi0FgNwjhoUK+F+rSZg
         J2Nb4h8T0BC6NO7ffgJZhkdMJdrorSlE87D/jVps1bLPYbOdOR36Fc6e/R5eCm6pMF5v
         91bSd2WWWUkaaes/Nf9N5ydmt163UauXSFJLXd1R1mpDV+lnoiWhfcjgiVoaAC7p3TLj
         WP79L5WNOl7nf1KPvlfLDDWvzFG9OtCDHUZ6+c82KsL5HvhsMwbvQI+6fNH3Ar9z1zbC
         3oFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJ1nK0hqgrSAY2rR4Tqp08WWrbE1WlfqUnZt7ebhDFBts3AjebqGfBacehbtb9RFiqxKpFpbY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgZPzZBsA2rdElVsoaLmbWR+bDqKz6U0R9KEc/p0Z3dOXcS4s8
	/xDshp79Qd1l4zGB69aES3OMM1NGEzR/Q7e5W0INVY/3paU38rld2LzMMcP1RkXbfXhpcxaE9fw
	XnVNLZKwhCgQUuPBOwDlJb3Eky/da+jWvh7VwKWCzSIMVZ0ZBm/3qQ3whPQ==
X-Gm-Gg: AY/fxX5ZqSgG6vZt0qjGd/gX9TiIRRqPTkfqWXnJ/7rRJ5gkSCrrGUV1c5xh9h8+5OB
	TJ38OoDF4GOfSXH07vhZoLiJcoXuvXImRveJZy7tKOgB9q35lKgV50irCcDvLGPC0iyV1Q8O6T6
	pFY8Gqvvli1lQdHblich+stVj/bUkq0jyi+Ge7uuuaZ2++8N7YU8Ip2iEHIYpOgpUPajgMYkFvj
	eVtbGNYpqIsM+iHAKXnsZfEGCgKk6JqrKqFFsaY9DkvveGZdzVqioIaNXZ34xGq025UXg63c0ep
	a8kOgGZUs3OnuYulwvuAl0d65Xz4LYYysqVqFiuDd9CKadDUy7lxGyVrSyU0aOYpzvWCGcet5yG
	ZvgRQQl7q938+9Q==
X-Received: by 2002:a5d:5889:0:b0:430:f5ed:83d3 with SMTP id ffacd0b85a97d-4342c4f4d35mr8729828f8f.5.1768488087147;
        Thu, 15 Jan 2026 06:41:27 -0800 (PST)
X-Received: by 2002:a5d:5889:0:b0:430:f5ed:83d3 with SMTP id ffacd0b85a97d-4342c4f4d35mr8729776f8f.5.1768488086690;
        Thu, 15 Jan 2026 06:41:26 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.128])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-434af64a6c0sm6403382f8f.5.2026.01.15.06.41.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jan 2026 06:41:26 -0800 (PST)
Message-ID: <cc302f3c-c4fe-4660-b069-8eaeb21b5580@redhat.com>
Date: Thu, 15 Jan 2026 15:41:24 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] net/mlx5e: RX, Drop oversized packets in
 non-linear mode
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>,
 Cosmin Ratiu <cratiu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
References: <1768224129-1600265-1-git-send-email-tariqt@nvidia.com>
 <1768224129-1600265-2-git-send-email-tariqt@nvidia.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <1768224129-1600265-2-git-send-email-tariqt@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/12/26 2:22 PM, Tariq Toukan wrote:
> @@ -962,6 +962,12 @@ static inline u16 get_cqe_flow_tag(struct mlx5_cqe64 *cqe)
>  	return be32_to_cpu(cqe->sop_drop_qpn) & 0xFFF;
>  }
>  
> +
> +static inline u8 get_cqe_lro_num_seg(struct mlx5_cqe64 *cqe)

Minor nit: duplicate empty lines above.

/P


