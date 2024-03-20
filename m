Return-Path: <netdev+bounces-80809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09412881234
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 14:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69B97B23BF2
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 13:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7946E4087A;
	Wed, 20 Mar 2024 13:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="22g04wQv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90BD4085F
	for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 13:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710940694; cv=none; b=deCqd9pNwvJMfPH7DLA31OcuadN4aHp7qjfZ3rd9a3wOBnTOCjDxa5BOpuZk/cT+cNQph7kpp2WYIfcGCPuyOS04LsykJDxpX9qR1keXVBQuyeB9YL4vlK3QJIFAh3b9sI3lrJlsaYbWxb5CnoBn1sjVJp0d0g8uB05JlDPYxx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710940694; c=relaxed/simple;
	bh=gJv93glI4IbZ0x7qvxaWWoD7sG/e4NPjhYNms1uoS4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DC8844coIp8dX0FFn9aAtvIcGtyxcvEJO5fPDTo0RKiXoKZw4lCcDqjxtkxC5PAQ0SY/IMgIYNHqCdTOzUkLAN//xdiYbTiZjNheJnqovHJTdQDTnMoSASYsF6dkaw+mKz23De5ltX46dkoOOCyPwm+M7PLJpLzrRBm7n40WbdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=22g04wQv; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33e285a33bdso3454977f8f.2
        for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 06:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1710940691; x=1711545491; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9LKPlS1clWVoFLEHzGk7lXwi7HDphPo0zW27afPMKwM=;
        b=22g04wQv8Lb04aq984GH+IY6FX/VL+rSXHOLuh/eblxUAqgUZ0TUrB/t0HHg3Q+LSF
         jjrBj33sa7qXTYK/Fr8TtpWJnMcDA3Su9kgsnygc2UohfXLM6kVqmryagdr9NljCefAs
         o08gQN1Z5XUVsk+Rwr+z/7ppWp9w8ZAkh0k+/9JUEzhFhT7cbRJg9p+UlYHjeuPU2KV4
         kkZiD7rfvRbnDV4fqA0xjanlLm+x/hgzMVfBxatgLWjydBmVQY+QAM0jgGYFi2aMPb5u
         olXM9fVmc/bqoLyy8CtliYbWi5cbLq/Hn6iKkxL9CCOh8q9tHwtTykthXtsplSdA/XXp
         kZ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710940691; x=1711545491;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9LKPlS1clWVoFLEHzGk7lXwi7HDphPo0zW27afPMKwM=;
        b=cARwfCLmN5/lnLcl065zJd+usBjka2vWTXxxY0YMURTcZQdY8mHP6zrNHQuJqGg9M2
         b0r7H4vM1NXMwKxGLIfH4mHt/FPj9hIxFozDgz+v2ObHNupHa4l40yF2LlCclSKOR06D
         hEUzR7O4cfeCeg1kGkNI0fWm7YlCihaWInIJBkw5zLZLTUhglfkODKxzV2HqOuTRvm2E
         L1Ve7MD/VJ825PxXCA8uwYnCB7tphugW9Zga41PaEhD9Kf7CRu1anjMEJIVuuGlJOWzz
         nVPTRY7p0rNhV3Njp5bwIGf6HwnLCj8cM2O3PzUPDz/DFNA2j+1yI8iT6t4cCr/wlHX7
         V4pw==
X-Gm-Message-State: AOJu0YxduXMfIZJgCbitDwKA5ynYnOODqtMeeEp0ZICjJveQ6EL2iW5Y
	JjiMMGvMazBr8yeNA8hnuBpmAg9TFWrHw7hu16KiZDlIgV4iCIaKucUqNTWQhXQ=
X-Google-Smtp-Source: AGHT+IHosND4qs/kXGMNaNd3XBEajAnpt3ZeO8d89EU57TzdzXMkQp5pat+HbWtA8G4aSYHxgi7+6g==
X-Received: by 2002:adf:e3c4:0:b0:33e:7650:24c8 with SMTP id k4-20020adfe3c4000000b0033e765024c8mr14238373wrm.12.1710940690700;
        Wed, 20 Mar 2024 06:18:10 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id w10-20020adff9ca000000b0033e72e104c5sm14668964wrr.34.2024.03.20.06.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 06:18:10 -0700 (PDT)
Date: Wed, 20 Mar 2024 14:18:09 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, amcohen@nvidia.com,
	petrm@nvidia.com
Subject: Re: [PATCH net] selftests: forwarding: Fix ping failure due to short
 timeout
Message-ID: <ZfriEc8i3A5jPMmg@nanopsycho>
References: <20240320065717.4145325-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320065717.4145325-1-idosch@nvidia.com>

Wed, Mar 20, 2024 at 07:57:17AM CET, idosch@nvidia.com wrote:
>The tests send 100 pings in 0.1 second intervals and force a timeout of
>11 seconds, which is borderline (especially on debug kernels), resulting
>in random failures in netdev CI [1].
>
>Fix by increasing the timeout to 20 seconds. It should not prolong the
>test unless something is wrong, in which case the test will rightfully
>fail.
>
>[1]
> # selftests: net/forwarding: vxlan_bridge_1d_port_8472_ipv6.sh
> # INFO: Running tests with UDP port 8472
> # TEST: ping: local->local                                            [ OK ]
> # TEST: ping: local->remote 1                                         [FAIL]
> # Ping failed
> [...]
>
>Fixes: b07e9957f220 ("selftests: forwarding: Add VxLAN tests with a VLAN-unaware bridge for IPv6")
>Fixes: 728b35259e28 ("selftests: forwarding: Add VxLAN tests with a VLAN-aware bridge for IPv6")
>Reported-by: Paolo Abeni <pabeni@redhat.com>
>Closes: https://lore.kernel.org/netdev/24a7051fdcd1f156c3704bca39e4b3c41dfc7c4b.camel@redhat.com/
>Signed-off-by: Ido Schimmel <idosch@nvidia.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

