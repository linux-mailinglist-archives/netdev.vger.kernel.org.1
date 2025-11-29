Return-Path: <netdev+bounces-242727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EA108C94528
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 18:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B94694E2B04
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 17:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C787F23AE9A;
	Sat, 29 Nov 2025 17:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="sGNMbO6T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EA8235C01
	for <netdev@vger.kernel.org>; Sat, 29 Nov 2025 17:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764435811; cv=none; b=Leu8iBQIf5d6jsQRSEeNljfRbdy5naaenClyZ2233bvEZ+TQj7MnkMidQ3D8RuHgi6lgyoU3zCRkM/DUfW+qe4Mzgo23U5Y/AnMVvvUQpfRU24gEJF944xLr0RmdihsRLo0w/BVtUqcRc6lsy25Sn+vA8oV4zjMqGcvSUM9GZjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764435811; c=relaxed/simple;
	bh=UG6BImwAw0rc1V/PYQuBi08tBpQDy0BcQj18aGudhAk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nDDJygd8kBfUuiKsed0kQ104Cd2kTaTOr0fpuh3zM4DQnL/itOmidLpYJ8rYI163Z2uLkSRPfh2givccZjWbzTPH5efIC4ti/Hm5e9Xejnp7ahRNmtBrO819Fe8NkGyKH8RsnzM687b527BoFGE5oGlFcksFIAMw4Wcgjy7Nu/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=sGNMbO6T; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47790b080e4so12571895e9.3
        for <netdev@vger.kernel.org>; Sat, 29 Nov 2025 09:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764435807; x=1765040607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w3NL6lljZUIz80S32y8CRSrRW0oz1aLxnHtOot0GJL8=;
        b=sGNMbO6TC1zfTEnv9YZTlU8jCQMwJJOof4Y5aII5rOvEikVlxvRPRg3i4tunktHly/
         8C5cdHIf67TmcIqjyyHlsfGUXGOdIUVMa2V8M4ElJQFeaCWOgvl5Nmsw/hyXIDHAuPAg
         0x1tdXYhNDNAgS+CVJ8pHmwkrped1tAiaZdS7xnuRocNKBLR8aIV9mz2xMZwDdHhSDHC
         Hxgm2xolQkJx/mB3rG1K8Pt73YC4cTkcQJO2boDcadK6j6PoPhIR0ctQ4GcPwhJjuioV
         oZiKhgPcylo3JvZ5EBlNwGWipSoS0ADZuSfrKBPeV1Jf2XpaJrzdQDJ0iuSjIGfXUXAs
         8SvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764435807; x=1765040607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w3NL6lljZUIz80S32y8CRSrRW0oz1aLxnHtOot0GJL8=;
        b=aLRVEy76+gn8MOJDrkPYN30RNObcN1ym2Ha6Ki5jDSdezig8IIprIhBFnPPI0kzsV/
         /af2BSe3VyipxALXzjW9D00m2CR1gdZxUg398+LIkjCTM8r+eqO/6ZzioPzc4tcTSmQh
         Ik9qZLGh5Pvn1SY+4zsh/Gf/1tN+6uZ3A9xUhBnmcJS2ixjqrtpxzsI7lBfly9i42+c1
         ODTie7xtQkvduuSJkSoMvLM7GFsJE8n3kNMCU6G9YS2O5DKfLbg6T/2xl1gMclPSw182
         QDnI2XP20cEFymi4FxqZ0bJYrKqV1Iqw7t2xg/Mryvmuy86ulNqicsz67T/2uQmwE+P/
         4xfQ==
X-Gm-Message-State: AOJu0YzYBISTDd6ZxUl9caX0OGCWs1GnhymzxCLD6/beVsv7OyZGjxsl
	VGTMzmwK2tV3gs+00lOl10DhXCF16z0IYjpw8Gtab/vGiYj3yuAyeBnvvPjgVFO2rYc5wrZL1l5
	j5iRN
X-Gm-Gg: ASbGnctT5WXIHhqCwX9uLRyhWq5TB2jncrdC9mAjuJi5MxQ7jFvtRA/uyTSYrGjFJWO
	jKwoUDZsT9mNRUhu+2Ex9+vZPD3gBxMBSrMvjczZU8piZoh3dRsAJ+Kuz/NaKEpdOyFfivO0onk
	0j0EZ59w4EQe7fH2RXvCmLTMKhnPQ0JnRZbNdDXkhE+QA0sm5jTfXOgwBM+wB+TOhlox0z4pyTS
	hQQ0MydcNyE3gsUe087XkOx/NhnAKVht9FCWVfEuovODgIaN0vFj6ZgpYUAT77I8N3z4t0TcfMC
	ZSOg9OaNVlQ9SfSglhMrA4NHBhFd21jo6D5hAqokEE7DsVCVmuLWt568fiEfz1GPTokrmobrajg
	wv1CkFjQUhRUw+37wt+0GhL/jVuLynkYJurc8tPCxpFJz++fLOpxGUIfS4tQYX3JaUgw8y1oO+5
	I8/zvCVr5wne2ebXu1m2oSxaRzdj3UK9PRm+nDt5Zit/ePNo4Md01/FBECShYSpwI=
X-Google-Smtp-Source: AGHT+IFMyGWGn1s47jdw8AjAdihGCO1Ca1kpb9N1dRAunGwTYi03BItPfZ0L/KhrSR6N1PNV/cWbNg==
X-Received: by 2002:a05:600c:5249:b0:477:5897:a0c4 with SMTP id 5b1f17b1804b1-477c10c858bmr314859575e9.4.1764435806589;
        Sat, 29 Nov 2025 09:03:26 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1ca8e00fsm16251408f8f.34.2025.11.29.09.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 09:03:26 -0800 (PST)
Date: Sat, 29 Nov 2025 09:03:20 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: netdev@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, Oliver
 Hartkopp <socketcan@hartkopp.net>, David Ahern <dsahern@kernel.org>,
 linux-kernel@vger.kernel.org, linux-can@vger.kernel.org
Subject: Re: [PATCH 4/7] iplink_can: add the "restricted" option
Message-ID: <20251129090320.594aa81a@phoenix.local>
In-Reply-To: <20251129-canxl-netlink-v1-4-96f2c0c54011@kernel.org>
References: <20251129-canxl-netlink-v1-0-96f2c0c54011@kernel.org>
	<20251129-canxl-netlink-v1-4-96f2c0c54011@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 29 Nov 2025 16:29:09 +0100
Vincent Mailhol <mailhol@kernel.org> wrote:

> @@ -257,6 +259,9 @@ static int can_parse_opt(struct link_util *lu, int argc, char **argv,
>  				invarg("\"tdc-mode\" must be either of \"auto\", \"manual\" or \"off\"",
>  					*argv);
>  			}
> +		} else if (matches(*argv, "restricted") == 0) {
> +			NEXT_ARG();
> +			set_ctrlmode("restricted", *argv, &cm, CAN_CTRLMODE_RESTRICTED);
>  		} else if (matches(*argv, "restart") == 0) {
>  			__u32 val = 1;

Good example of iproute2 has banned use of matches. Because usage like the
(think of what happens when user was previously using 'r')

