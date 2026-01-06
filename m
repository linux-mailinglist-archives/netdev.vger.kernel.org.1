Return-Path: <netdev+bounces-247477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 391FECFB17B
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 22:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA76430608A3
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 21:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871A930B509;
	Tue,  6 Jan 2026 21:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="l+D9DPAa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF522FD7C3
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 21:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767734800; cv=none; b=L2PSLww/0YB6i5MAZYBhe9o5qSosIlzdv0KfNbDqz52orY8ytiHYRRUv74GdegFKW87QOL1hvYpTlfkb9ieat77PMtazbSjQLLbwqZnhUKeheatvLUOsQfrf5ExyNWhayvkmPzFRjcEn6vX2Hh1zGxtDgjAS9yU7vqrecbU/gog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767734800; c=relaxed/simple;
	bh=aUbpclKNNPZ/FcDG092oROSFXqvaWQ0j0R4+pN1M0YM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iZTuXJjrDZ+kv0zQsDDIqeilk+blgB+ssL1ZxXA9oas7YnsHpmCPOmKh8v4+Qr6nE7j1jAFwn+gZhAS1h5X+DnLn674PsIHYnEJWfViegYy/Of+usgw8rB2jS2zv8w5wmJts6rAUyd1vUVq7yngc4dq3Wm54SX6Lbf2WPLxLqQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=l+D9DPAa; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-477770019e4so11885215e9.3
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 13:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1767734797; x=1768339597; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Jt+7l7BbPrvEn58gLJdPpzydFRZkJoL0Eyp340A9r4=;
        b=l+D9DPAao2Tw1/yKUKeC/huVIXRhxrdHfPvZWagaRy6YLbnuIGuAJY/9XzqZwjnJ8g
         q1ypTdhRCJTWeUTXb/J/cB8QS+Mkds8trcLq6zbUT5RZWR/z2I9yxQ2Pe/mkQ09NorwJ
         xgdWUXoN/fJp1xpDSaj5rUYmIV4ys9boamSK6lwnImGRrd2iGwdZrIWiqjMVvlgvXiZn
         l8hEEdODBVsM29sgB9RZbQo7CJKmTVqLrowPZVKDhXZ/7o1VhEJJ69qzjdOepjp5VSHB
         fOexcf6NmkWrNy+ArxwelULLY4/vWUgHamu2erJTpe9SDyUVxwcdH3TFBe4jqvlnM/Ow
         jaMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767734797; x=1768339597;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Jt+7l7BbPrvEn58gLJdPpzydFRZkJoL0Eyp340A9r4=;
        b=V4uNKa+AsHV79Z0/altq00R8E4a8voG4yn9YNvE2vxzfUK1wU+S5inTED/CX1fuOCw
         whA+2WmFWE5YQXyyPrn6cLyQyal2ymgnm9zObx7OsCqWbrApshsq4mBJAtd31Mk5g2bz
         ufNCYeODlEspcbwoUtMWSICyRn6sRgplC1m4exFrhQgp+P6WHqiAjB/0C4M5krlKfYyX
         r2ffZ/UKVyTecvE6G0ZqjRq4+EP5p5ciUZXVcssPedfkgpjzXNtqlZIUelOFqpPjaGYP
         LKD1TY2kuPUvlw4UHjoScolmPZtgPX688Kq1VeBzntmoIWQ+YhjStfxK4gjpqbzQY20W
         X8fA==
X-Forwarded-Encrypted: i=1; AJvYcCULu/rnuJGsCooXof303qywpqhEBQvImIEqaim0wcDJ3NK4yM5eXnE1Zk7hIPBJF8HWnqP+FtM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuOVs4E4WiTw7iLj6MxvRAaUtI72Xb1LoWN+4r6DkS1+qn7oyC
	hAKZ6s6m/pIRoRTjTxmEf4BrBzB2aWG7rEAupa+kishUL/9JiO5ymT2gUJPRGYhG/R0=
X-Gm-Gg: AY/fxX6xqwKTiMYrqUuUK2Xd9WcYzmPqNd0T3jOiOuwtyiqZZitkgVhzQvnZ6UZ2w7O
	xmW2p6OUU9a6VphUGoMvm4nmnq6XfW0jJR2YGxq46ApNs2RgqoBjJPuMLXuScT/r8ZHmo2pSFID
	ISVTJK52vDqIaYqtkKUsSL/GWZgxM08O4Rrr2rD0N3l+EvAjixLWCWmZps/EoAAlXHE6aaYvQ0x
	9DKs5IjUt+ZkE5tfmPYAfvY+3e5j1/M9J0QJVJJH3RCKl68U+wHNZpkLHeQuLnVY23WC50dr9gL
	UnH1eZKcgHTjcxjStBqI0bZ6dx8lpM6hHcJNZyiteRYykUKWRW5fJ/1R1p+jlSoKB2+f8uFcjt6
	YR6dZd8FdTTOSnIbmnwqwTCC2lrqDtnq6+lHgqSp/8vGLo7g5c3kbQdSKH57S/DptzHsBXz4hZP
	XLAU1skGr6zlZ8F4pBuBCxByn7y088/s469E4U9B5H/+M3Bu0RezwS2DXEvkHhlhZ8kODFWw==
X-Google-Smtp-Source: AGHT+IH3QaJawKDCtD5DCiDkgBXd7Le26CBUQttPpH4XyhUk7b+IRhWrHzS8o2rYfRe+Y3Hws+PbtA==
X-Received: by 2002:a05:600c:8b2c:b0:477:7f4a:44b0 with SMTP id 5b1f17b1804b1-47d84b3ea06mr2815095e9.33.1767734796773;
        Tue, 06 Jan 2026 13:26:36 -0800 (PST)
Received: from [192.168.0.161] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ee893sm6373283f8f.37.2026.01.06.13.26.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jan 2026 13:26:36 -0800 (PST)
Message-ID: <f3bf9a76-c110-481a-a89a-c54d5856cfe3@blackwall.org>
Date: Tue, 6 Jan 2026 23:26:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: bridge: annotate data-race in br_fdb_update()
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
References: <20260106194022.2133543-1-edumazet@google.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260106194022.2133543-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/01/2026 21:40, Eric Dumazet wrote:
> fdb->updated is read and written locklessly.
> 
> Add READ_ONCE()/WRITE_ONCE() annotations.
> 
> Fixes: 31cbc39b6344 ("net: bridge: add option to allow activity notifications for any fdb entries")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> ---
>   net/bridge/br_fdb.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
> index 58d22e2b85fc3551bd5aec9c20296ddfcecaa040..e7bd20f0e8d6b7b24aef43d7bed34adf171c34a8 100644
> --- a/net/bridge/br_fdb.c
> +++ b/net/bridge/br_fdb.c
> @@ -1002,8 +1002,8 @@ void br_fdb_update(struct net_bridge *br, struct net_bridge_port *source,
>   			unsigned long now = jiffies;
>   			bool fdb_modified = false;
>   
> -			if (now != fdb->updated) {
> -				fdb->updated = now;
> +			if (now != READ_ONCE(fdb->updated)) {
> +				WRITE_ONCE(fdb->updated, now);
>   				fdb_modified = __fdb_mark_active(fdb);
>   			}
>   

Thanks,
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

