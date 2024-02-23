Return-Path: <netdev+bounces-74458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3C18615F8
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 16:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4926D284C28
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 15:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2E281759;
	Fri, 23 Feb 2024 15:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="NxFrQeSr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9CA823DF
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 15:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708702560; cv=none; b=M+POvI7KDW0B8VC10VlYmQ7ySloFKqZrs9UUMEMaUVjmmgvvYp+MUfoZ8SMKTGxooexbpRPazTFngjsdwHx+WgWvg1ABbF9MYHuYsc3/IuTLQAksNklOO+w8xCa5vwMDnDJUgmXGTg3CNh9J0CFgoz/jfrEmNIOf+XRYovdGXEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708702560; c=relaxed/simple;
	bh=mStnNampzKEkW7nNJUREOmHxM5+FJPfx70I1tFhZMOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c0slQ9+xwE1ZEXs2SWAWGzZPvIGGZ6V47K0NGE/C/TVIws+mznsuehClR5AlsAusxppZCW0zGQsQoCJtsTMfQDduxjifjbTA/WIh9KILPtUP2ekd8KhUI8Z7gdeEoMmK1junz7IdkLQuB8KX9xCLeePoM9osFYzFsfshTfnWUmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=NxFrQeSr; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4129833e069so946295e9.2
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 07:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1708702556; x=1709307356; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CMCJzX1yckFyPsV7CaxmQFvxNHx4x0JNCkKlsLr9jGA=;
        b=NxFrQeSrM1SK98SPnuN/hVNeBPH1owCLjtsUnVzm3Gq9rfSuImmyaDQpUjkK6/FTsg
         tqmyfL5OktAMSXxiYLuzShXm540L6qhCzMzqlZ+Dph+BBp0fSRQwOk061LY0RoPjGjyh
         M1Ctqbzjt+/sNYDeKWSEY1KTy6VLfRvJYee493XMvZZgpF/nVtxNArRB2T1sj3X40tY7
         d0aV12oyFaLHZIItnla8PORYWit+GihLPhr71r0NGW6QMbREoefN6KVKHUAEq0HLJW95
         x0W6EpWUTUmTA1M3cJaVb04AX5g1Igk/rXdsBrpYLLD35hZXFLk5e1ELmiZIHvkQ94s1
         7kAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708702556; x=1709307356;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CMCJzX1yckFyPsV7CaxmQFvxNHx4x0JNCkKlsLr9jGA=;
        b=oSsJWaXEFBaTRUOYNThlhNgkwIJ0CVsRpe0EQttfik2DDHHtK0jN0gEdqRd+CSz29Y
         7A0owl8TYSBkDxfiDCW6iuqHk3bAaZT5lcZb1qtpqhgbKlGMw6C2Ux1zmrHE0xnmLeP1
         vKjtkxiDiAOX9LkO8I656Ovp+2piJ85yzmxUJfP7zPolKW4irLH2kCHd2eVLo/w21oli
         PKqw5G/jd9Hls7EV4IXTYkV+/kZ3hdllagszSWZg4EIoloJew/CH3jL0H/dU7mdNDVlz
         AgdP2exHbFrMBcppkicEjt9o40t6GOLC3yery/nk9WEnbapqfB5crgVzTp2DVF6nPM9d
         A9Ag==
X-Gm-Message-State: AOJu0Yx+xOJHIklcLM3QR/fNNNM/m3tODe2X1CMaMG8qFiU0JieA0UK+
	o7UqDD+BI6j/1pRrpktPLvKRDHINXoI5QKukQBRVb+fP9agr7USjwaC8rk87ceU=
X-Google-Smtp-Source: AGHT+IG9Zc/WrbimtOv63IT0xMgvYRC2JCf3lUlS9m4KVv3+QgQLpOWox2ZRZhOGK4vpAYgxXRf3Lw==
X-Received: by 2002:a05:600c:1ca9:b0:412:616d:cb with SMTP id k41-20020a05600c1ca900b00412616d00cbmr163972wms.0.1708702556521;
        Fri, 23 Feb 2024 07:35:56 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:25c8:f7d3:953d:aca4? ([2a01:e0a:b41:c160:25c8:f7d3:953d:aca4])
        by smtp.gmail.com with ESMTPSA id r3-20020a5d6943000000b0033d96b4efbasm3148952wrw.21.2024.02.23.07.35.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 07:35:55 -0800 (PST)
Message-ID: <92f70d5a-8f0e-41eb-bae5-36433cc26dd0@6wind.com>
Date: Fri, 23 Feb 2024 16:35:54 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next 09/15] tools: ynl: use ynl_sock_read_msgs() for
 ACK handling
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 jiri@resnulli.us, sdf@google.com, donald.hunter@gmail.com
References: <20240222235614.180876-1-kuba@kernel.org>
 <20240222235614.180876-10-kuba@kernel.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <20240222235614.180876-10-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 23/02/2024 à 00:56, Jakub Kicinski a écrit :
> ynl_recv_ack() is simple and it's the only user of mnl_cb_run().
> Now that ynl_sock_read_msgs() exists it's actually less code
> to use ynl_sock_read_msgs() instead of being special.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

