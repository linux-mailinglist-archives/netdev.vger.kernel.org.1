Return-Path: <netdev+bounces-74453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F058615BE
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 16:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C10752814B2
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 15:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE5D85638;
	Fri, 23 Feb 2024 15:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJzyw+2F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462E785287
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 15:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708701955; cv=none; b=Wcjnz/uKzR8ATP7Qaqtwn5qQgc/5CsEF+JkXsJiaSgaqcG6eEHU25oTXYdxt/OsuDU7prh9mciL+7SuJpwZ7O0O8tShkqcnXWJdXphWAY9wMXVF0wooM84RRgIM2x4tfHBfJCtzEvqb/CUnS/zb3UqNduV5x4CEsj46QdDZHnug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708701955; c=relaxed/simple;
	bh=SccVUWG1SK2LiMcZDHmXZXdIpowtOlVd67W5rjqT/dA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=TzW2mPIYu0oz5UbmBRZoGz875k9k2nM0S+Cdoor69ytwP0oPGucyULHT6TnsbD91mObgyN3/tvFaJmfzOimrBzbk/fykhzsFq9og5PdssN2D1mwt+9WpE/5229q9NvdnqKKzL5ZRtXrSzsXzNMRiF0q8zMt0+HIA4mzZ8EYNUFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BJzyw+2F; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41275855dc4so7740655e9.0
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 07:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708701952; x=1709306752; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SccVUWG1SK2LiMcZDHmXZXdIpowtOlVd67W5rjqT/dA=;
        b=BJzyw+2FkeGrOiowoFQ0qKvDOKve/irJ0ERje4xR0pZMpjnRwSx1Y04Eaxl7C4Am0T
         BT1F4u35gtD2xQ+nb7+Wd35226ExZmB0LjUMKuTgakiKtse0tGvRP6d9Pa6Wzn4YxNDL
         j/JGOydeKPPXYsYuQk1uphHqLjWOX4y8RHmhnozVfqqrgA8UiKU2CzFopgL0TtefBuei
         18v/sSEovnI1avR4Gu4A6+QL958SyFBcw2Xqv6E071c1zRRztE1V+gjVeKc4EM2pLNz1
         tXMZaEMROLmDzMUaoKUgzOsCw0CgyJ5CqCEmCes/i5QHZnyAVOmULQw+lbz8aSLs9Sxs
         FLRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708701952; x=1709306752;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SccVUWG1SK2LiMcZDHmXZXdIpowtOlVd67W5rjqT/dA=;
        b=pJENd+C/1lZoluLuLvvsRCR46IM5m47/ll06ijWKfqqiW6ZSj5AdDopfSdZLHlNMnQ
         F6PVJG5pkl8+wDc55gQOywQ4EF+lgHWCDxpLyj4RCNvkrsQfB+CAUaO8d8BhSt0BE5/w
         3DkH9ofeyOoO36ali67jBax/KQ+aT8NN+jnlCnqPHi+62X+R2j/PyqW5krkE0gHtp1JP
         ZIUvUEqTjnU6OfVjGYxyxpfNqA+KJPZauSGEVFHDyPW63EDH08zTOLwDsRX5F6iAS1oE
         N9rlDSDwITibWZnLAEVKMqKYYajiU/l9PZHv4OxEO75VJWxo3kV6KH+luD4JZjbCRuCk
         pWsA==
X-Forwarded-Encrypted: i=1; AJvYcCVvW48lA3juTD/jQ1LzcXDQ7nCAtBBw/uLo6MMu5MzV2EZgig5dZHUPgaY/yG+GqFxDcljo6lJcvg5WHJWM47ill2ELms7n
X-Gm-Message-State: AOJu0Yx8ptJNSOcG+tPSnVVcVDKJIPSxOAImVzm9GKjxDFCELqekXYIS
	XafYnnrQXB8bhdFsSr4w3vE60iK9OrZyoIs/0mMXONvijSVfITZT
X-Google-Smtp-Source: AGHT+IEhLeumiE7allZDqk5vEC3JitoZEMtTIEewoeCyu5Wix3LlYQHsKxsXLkCuTq4CNopDB6mqqg==
X-Received: by 2002:a5d:6a0f:0:b0:33d:71e5:f556 with SMTP id m15-20020a5d6a0f000000b0033d71e5f556mr81353wru.27.1708701952593;
        Fri, 23 Feb 2024 07:25:52 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:e821:660f:9482:881c])
        by smtp.gmail.com with ESMTPSA id j2-20020a5d4482000000b0033d4cf751b2sm3181242wrq.33.2024.02.23.07.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 07:25:52 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,  Jakub Kicinski
 <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  netdev@vger.kernel.org,  Ido Schimmel <idosch@nvidia.com>,  Jiri Pirko
 <jiri@nvidia.com>,  eric.dumazet@gmail.com
Subject: Re: [PATCH v2 net-next 09/14] ipv6: switch inet6_dump_ifinfo() to
 RCU protection
In-Reply-To: <20240222105021.1943116-10-edumazet@google.com> (Eric Dumazet's
	message of "Thu, 22 Feb 2024 10:50:16 +0000")
Date: Fri, 23 Feb 2024 15:19:35 +0000
Message-ID: <m2cysnqkc8.fsf@gmail.com>
References: <20240222105021.1943116-1-edumazet@google.com>
	<20240222105021.1943116-10-edumazet@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eric Dumazet <edumazet@google.com> writes:

> No longer hold RTNL while calling inet6_dump_ifinfo()
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

