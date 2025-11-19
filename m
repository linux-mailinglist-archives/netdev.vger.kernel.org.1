Return-Path: <netdev+bounces-239837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB50C6CF53
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 07:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CD959347EB3
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 06:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70BF329D29C;
	Wed, 19 Nov 2025 06:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBdQcu7x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91C4824BD
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 06:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763534223; cv=none; b=qT7AQ+FOCRbUwTymGHNo7AgWmIhfEFkEwDSSWdpfDqB8kl29r4YnK9o7QgcIPTKuiljyiZfKmWgSdJNQE8C3VE8AhE904kSxAcoF7MDrY0Css6P0jytH8Q2LraYSPPyXHSJCAOsQKuFn1/n5tGmFtE6srZTy4BQUdh+LVNG6IbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763534223; c=relaxed/simple;
	bh=Le0iWZgrgUDJ7qSZDHkB62gl6d1Z4NVf4FP7gCVxcNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XG5HDdx1muEjDV5rQxO8XufHo4eW56ke4hqDKbEhpC+gme0glm+vaRdiQmvpl+PC7vvUyoBPiomVGbDwHBZyDTlyrfrShbKiILpqvlcSkl8TqTQa7hinrr2RKHjttrdHotcYAVvU9+NwlVjMIpZpyTCiGw1rs56tSlPyDoaWk5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UBdQcu7x; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47796a837c7so25605635e9.0
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 22:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763534220; x=1764139020; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FMePX1vjoF4SrbxoHCbNwjxqr08IbebsHvXQ4MMOz5g=;
        b=UBdQcu7x8RVb20im7T60bxH3yd6kGqzuyX/J2I7txqAooePRaNO1iWSpbDc5Djw4Xo
         rEJN74y7kdRCswGZmIM9KdU+zMk318jTjRGqjbKA5ppG67OdNxuXyBB8mmuf30ThVsm0
         FTfcfdo9ijRwgRYFxYBjYtFuA5AY5SmJ8/MxzXqUcZctI79QaPxIg5NAcHTQNrcuf2Fq
         qJSqbWOd8cCuXip9P+A4rHMbfw7SmSyOKM8N1qNf/pB+oiqd0eUKFHUtu3zkuAqJNwn+
         J/4VZILM5CD8+8/uh3LWhn5sLD9p0MBV98xlwAdZOn23v8r8GlbDWZ7YNAU4Zu6Rp/NR
         qjHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763534220; x=1764139020;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FMePX1vjoF4SrbxoHCbNwjxqr08IbebsHvXQ4MMOz5g=;
        b=E3VsrvHV7v3LgPPInpKEXk0nYJusWZAoG6X1pVIaxrxKxMZgsUATjT2ug0LGVosLeH
         NiN5YiSimhCjUqxUEWUCm4kBwGyCNpMouoSn5pm9ESohUPeWCBFVxDZvVJG3ZFtkDdw0
         TizABpxt1GhtdMU7TVr+dFdk1fIuqPunUTEw9VWPWzx1jnH8V75mZz48BPJqsa5cEGyX
         q9M1EadOvG0rJcz+BmuVZqB7BHrCF7xB74VvpNFtl+fUp5dixXlqLwNw41j+Q3LLapkr
         TwIOsYzWJDoL+Oc6iXXXOOtp7vXdygWgq0boriNNqOJkHM/3YMuWchDGBIVwGBmAtUFY
         whDA==
X-Gm-Message-State: AOJu0YxdMtY9IqqisJ5RjENKNV03tpXwh1Wyb55gX6a9t7vQUoK980TG
	W76ovs536Anfs3X8OIJ2MwSiWjWXY9H3ADV2zsy+nb5l8iMOxQ3XVV4s
X-Gm-Gg: ASbGncuUo9NF1+XXxK6Xvasu9pdclVopevqHCoOtI/WCJ/sZKH4n7UJ4xzAJez57xOa
	xBGbOI46w3B7IVDaaXy3CTYN1+4APzUSGcO5wpbx39QWvyFj0hEUMFXL6cSdcC6IMPsvMjr4vGF
	pkHB8Vlkg7eFMMvDK8wuIg5wk5AN63J7xQWnq3hp8RWjfE/mqyxtOfz3cTEtTCAzhKwsDUT82Tq
	E6Gtm43mPoi0xQ9HAp7jNZMSDeOIYsmDz8Dd4/15CdFGkTh32Pi54/5TA4ActBa1cCXp7oe2dEX
	75XhwoxqaOdIcQmT7/8j3x5Km71ZoZ9gbSd+7bPzoHyJBDKizuHuopkosJ/a3OhHh9bmgDpVbkq
	9PCC7PuSLnbEJ+tN5eALagXpIYl86W3QpfEDTBt0DAJoWsM4bvG8e24X6utRfAe83Ca6B903BTn
	jwQ0q5gwlNZYOQPxdb2Id3D8wRIbQEmvQ8uSuqo4tsKzvwEAfTvFxa4669e2NQ7RvFIcVmvl05W
	b+nc1NUqQOTwEOk8vdIhP+bm0ui1J+C6VTPBVlIaO7cCuwU/HE=
X-Google-Smtp-Source: AGHT+IFAIrtYXK2V1FNFAMx+jg+79LDKEKFaIk8krlnwsJ5MJnpciHrawcL4xilU8GJs9ERtHzDmTQ==
X-Received: by 2002:a05:600c:4e86:b0:456:1a69:94fa with SMTP id 5b1f17b1804b1-477b1990afamr7488795e9.13.1763534219839;
        Tue, 18 Nov 2025 22:36:59 -0800 (PST)
Received: from ?IPV6:2003:ea:8f29:4200:d0a:45b2:7909:84c4? (p200300ea8f2942000d0a45b2790984c4.dip0.t-ipconnect.de. [2003:ea:8f29:4200:d0a:45b2:7909:84c4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a96aed1esm35179305e9.0.2025.11.18.22.36.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 22:36:59 -0800 (PST)
Message-ID: <37faada7-1b21-4ccf-9ca5-78756231c2df@gmail.com>
Date: Wed, 19 Nov 2025 07:37:02 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] r8169: add support for RTL9151A
To: javen <javen_xu@realsil.com.cn>, nic_swsd@realtek.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251119023216.3467-1-javen_xu@realsil.com.cn>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <20251119023216.3467-1-javen_xu@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/19/2025 3:32 AM, javen wrote:
> This adds support for chip RTL9151A. Its XID is 0x68b. It is bascially
> basd on the one with XID 0x688, but with different firmware file.
> 
> Signed-off-by: javen <javen_xu@realsil.com.cn>
> 
> ---
> v2: Rebase to master, no content changes.
> ---


Reviewed-by: Heiner Kallweit <hkallweit1@gmail.com>

For my understanding:
Any specific reason for the different version number scheme?

