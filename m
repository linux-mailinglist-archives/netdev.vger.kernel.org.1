Return-Path: <netdev+bounces-242579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 040EEC9248F
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 15:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9B28D4E2CCE
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 14:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C9A230274;
	Fri, 28 Nov 2025 14:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jFpd3jIm";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ndz3sy9/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60412227E95
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 14:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764339618; cv=none; b=fLn9FvbpkH5pWwvGpjryXZSSKJhMRAEjCIeLS245B9N8lbkZLbWWcQR0j4iJKspYrSD0svevIHi/EVDX0Z5mABgmXljVTGivG21owb+a6u7DAnR0CNqszrYLtBw8YN0XZ6DeFNeJ+9L36A6DOBKDYFjXwxrnSxYFCfWdN4eoFLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764339618; c=relaxed/simple;
	bh=8ZG50ZqkqkDxqSfIjwekhMuh5XfBJIyhfIgk+C9P604=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gd5gmvvLEfH0w3KfNe8lGYNAXSgW6wT8nq5PnYAe3h83oUwr/Cegv1lUsAqab3++PxRSaVj/aPonk2axOyKF7qP/dgWKjkEdleoMT5Utqm65/ZlbgQ5HZ0wIFP3hM7YBpel/jMSAQilOX5Obj9IaQLXnvXcsfSAMKaiWMmjEfaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jFpd3jIm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ndz3sy9/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764339616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kr44LRycnRrIIIsoZeGxJLnFhlm7tgfT91Z2PQUzwxE=;
	b=jFpd3jImFXVGsEF5O8R58GdP+xTPJ0zVtIA9SUpY0nw1hA9i6AZ6rfHyM7J/P+ZRstfPmK
	71D7mIX06E/TlDZEfQpJJmFBhEcXaF6KEU4vTpl6fycI8qjLRklr+xTVwdk0C1cfnh/sBb
	2N4Zrz9gijvkQYgzW7yh3tG09o4bCaI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-PfQqtoGBPr-yzO7wMGwr3Q-1; Fri, 28 Nov 2025 09:20:13 -0500
X-MC-Unique: PfQqtoGBPr-yzO7wMGwr3Q-1
X-Mimecast-MFC-AGG-ID: PfQqtoGBPr-yzO7wMGwr3Q_1764339613
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-429c5f1e9faso1516265f8f.3
        for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 06:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764339612; x=1764944412; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kr44LRycnRrIIIsoZeGxJLnFhlm7tgfT91Z2PQUzwxE=;
        b=ndz3sy9/hjkmQz0NNvuMezEAo99sApEe8085gVh3Y2wKXYGmrbrlxTMBkyDrB9LFA7
         IFF4vGYTi+lwUgt+MAWr5wwfvH+Whu0JiFeD6rvttabugICur+sSQCP57WQbaY4Yp7wq
         22ziiTkzFun9CSsQLPTmOuesmsmbjBdZDVnGTSonjFWb/N+T/1y99Ebxvs/4TH0w88+l
         7igSFCk4mA1Jvcqy7ZSuwE0aJ9ECAalKYfjBZyWRc7zKcNEucP7nPMS1Ophysq7v2nqB
         cV9nZ2FFPeMVFSL1l2KZ7SX3TrB9nSaTtwAGeyZcN26dK4SNh9MfInmk4ZU1DJI8R0+T
         j1qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764339612; x=1764944412;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kr44LRycnRrIIIsoZeGxJLnFhlm7tgfT91Z2PQUzwxE=;
        b=QYchCKcjDY1av5fp6BKgC8oTFu+GNnSeHFRp9NTSVNkDO7hX556BvmEB77rfD76+0x
         4FSkkR939yFYZNPXMTfIlRUjjfrOT4VOJDXyaTg+YODgNoO2jY5jJ97oqA4xCTuoO9tg
         ZwFnLLdvo5NqkwTLWQvsyOABQ+N3+FmDgWJIYZ9a8CxPgsxoq/zEhOArL4rUMH8j46lo
         8AMU8fy4skjEYC7/3IyBJSdxkqSOza+K6WmvQenclP7V4cM4NoRXR2WVS/wYpKKV48aX
         6sroo8vbebyH5dviWE+HVq3xqH3In9R4DkF0JE8VXuM1Uv42ORboub7xB9s2Qfsvk6q2
         iPuA==
X-Forwarded-Encrypted: i=1; AJvYcCXX9FSuYoPH1lBGeUPwz5e1edaHOrUTlZDwdFGBkUQnh9wNixoIXzmGsU4kr6wceqQMqU8Q5E8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxff2CL6GKZYZ6/Dln+piV02TawyqT/pkTN1b3CBubW0xoonNHc
	PTdIsETzSJo1MDmJUhXlsfx4IXnD0xvaqp7p6cR6LacORRQ+bU2amjoNXywVbt2UJ+9Kdrih8wk
	ZD13MFZoskYsZi7s5OS30jOMRQp0LpXE/wV65bknXWIhUaQTK3N2i5r5/TQ==
X-Gm-Gg: ASbGncttxq6B6OrshubGdKWZuFP88U79opF5YbDLg6MtPCbM03Chk5Oesuzhg/4AyfS
	Vno0JqLp7f7MwuZdWW2/uKxmpT/BuZAuS3XGDnHJ4RsiQEqU6JamaYhHVS79VSorl4ufEap2MpH
	2oOniQQq05rKZIs25mnla5Jla6zByYt7Vz8pyg/kE6HLNTe8m0GZOKJ/Cg/yhL7OJFymaKRQfRC
	KhOAQK2/vUvQ37p/Jmm4MtTU6MrBfCmHISh/glyOqM7pETawOikHLWeONCgyKPnqkuh1mfsLEPl
	GN2SF79a8Kj22z8HSghjA5xcIPydznkBa/4e7/AXxPx9U/L1EuGq7DMccbI7xquG/CKUFQ67VBC
	2PKLQUjMNQdDQBw==
X-Received: by 2002:a05:6000:1a8f:b0:42b:3c25:cd06 with SMTP id ffacd0b85a97d-42cc1cee419mr30438923f8f.22.1764339612535;
        Fri, 28 Nov 2025 06:20:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPEkA/LoZdallg49g1MUTRCeyrnm9WywP2P1KOTjKBH4y40uAcYN4UEnTmkp4kPiOrnajn8Q==
X-Received: by 2002:a05:6000:1a8f:b0:42b:3c25:cd06 with SMTP id ffacd0b85a97d-42cc1cee419mr30438877f8f.22.1764339612057;
        Fri, 28 Nov 2025 06:20:12 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1c5c304csm9948281f8f.8.2025.11.28.06.20.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Nov 2025 06:20:11 -0800 (PST)
Message-ID: <8fa70565-0f4a-4a73-a464-5530b2e29fa5@redhat.com>
Date: Fri, 28 Nov 2025 15:20:09 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/3] xsk: use atomic operations around
 cached_prod for copy mode
To: Jason Xing <kerneljasonxing@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, bjorn@kernel.org,
 magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 horms@kernel.org, andrew+netdev@lunn.ch
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 Jason Xing <kernelxing@tencent.com>
References: <20251128134601.54678-1-kerneljasonxing@gmail.com>
 <20251128134601.54678-3-kerneljasonxing@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251128134601.54678-3-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/28/25 2:46 PM, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Use atomic_try_cmpxchg operations to replace spin lock. Technically
> CAS (Compare And Swap) is better than a coarse way like spin-lock
> especially when we only need to perform a few simple operations.
> Similar idea can also be found in the recent commit 100dfa74cad9
> ("net: dev_queue_xmit() llist adoption") that implements the lockless
> logic with the help of try_cmpxchg.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
> Paolo, sorry that I didn't try to move the lock to struct xsk_queue
> because after investigation I reckon try_cmpxchg can add less overhead
> when multiple xsks contend at this point. So I hope this approach
> can be adopted.

I still think that moving the lock would be preferable, because it makes
sense also from a maintenance perspective. Can you report the difference
you measure atomics vs moving the spin lock?

Have you tried moving cq_prod_lock, too?

/P


