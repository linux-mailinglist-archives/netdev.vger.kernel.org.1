Return-Path: <netdev+bounces-212341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 884E7B1F7FE
	for <lists+netdev@lfdr.de>; Sun, 10 Aug 2025 04:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A414F17BD66
	for <lists+netdev@lfdr.de>; Sun, 10 Aug 2025 02:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44331F94A;
	Sun, 10 Aug 2025 02:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="nv38w8TK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832DA1367
	for <netdev@vger.kernel.org>; Sun, 10 Aug 2025 02:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754791312; cv=none; b=TxSnu3V5Hge1JXeYdm9ilPtCIPl2yz9DbJvkjv4x1TAWnMBF9c6SRw3YHIHtwdc3VoAWkD+B1OfFDaTZD5ahBirVuoUPThSlrmpHxrmsHj67YuGj7lhQW39yR12xSz4Tj2yIDh0c8bmdAt4joplE2/FjjeIYjG0vWEKxExA1dnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754791312; c=relaxed/simple;
	bh=dCvUpFgvClz8ydlEGwgka54i9za6FpnY59NV6CpRBgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fm4mZcloO1BQUhXKRrnBTo7odKNyUlEpzhzq0jzKAbl87/unNw6imOP4xwsJ1AynIMZFJ8kedGpPoJ6rA9ulqQlhrS2kTJy2rdTyX+9CbAyhAY3rFbIqeFZkwXKW84DGKvycLOHNGnjDqNgBKqE0or86dca5CBvtXowmoAlAbf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=nv38w8TK; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2403ca0313aso26490985ad.0
        for <netdev@vger.kernel.org>; Sat, 09 Aug 2025 19:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1754791311; x=1755396111; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=txwp06lVbueO9WkAKBe2DeTZ/z5GvsnD3cfuHHrHWmg=;
        b=nv38w8TKw0Wr1d2+/1Wmtj6O/NET30TciBuT+DhJboCushtDOBob9UuhUYinPorTxn
         j9sForYxHRgEXX80lRWLQ31XpXd2pr6mOOWDfIciZbjEY4aN/LEjNQ2OQ7efzFWrTwy9
         EXqL0UdKU18ccLrI9BVpU7452Z+PGXXs5xH/e36wyPskn11nn9pBNtIcRP68qde/f4oc
         7xIjpKtnB2cYhTSXzAiXhuLElgJxTN6S/6DtBZas2wDjMI4o4sCqIe2HxhwJ8efAfy2Y
         2EyltTMg9ztc1YW99hhTWyYUKvrySPvGpiby4vv9oYFliShPNzC0oJfwTwDolzVUl3L4
         tmeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754791311; x=1755396111;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=txwp06lVbueO9WkAKBe2DeTZ/z5GvsnD3cfuHHrHWmg=;
        b=AdLRXOwyGYrTXGj6BC3TRZ/NPw0CEfUzCNwaLVzvkAzSrJuqK7iLpTtPyPraIFvf1/
         8zBVIHEt3dnIv7a36057MU295SpgyAc9rZxg3dA5GnS+pNoVW2y09Ro98KSJP9IHAsdD
         6Y34eTI247zM/5VkBe96va3sfBlWrecDTWFGlY0rK6hBwJEmqYD6WQ7xTZXP7oMmSfuA
         /sQ/oyT/9UA0NN0kVnoTGviqdAe7IpWz0Fryd0LOchRTMPjUJi1q+7qmjo30cxcVtQMa
         yq6fI78lrEBPibVU4AVsL0YGURguIZSK7RUMhqMKhA9Uy/tsTwJ/GA5QsGC0PAF2X42U
         v/VQ==
X-Forwarded-Encrypted: i=1; AJvYcCUA8633GPMji5DWw2yJ2MNwarHr0L4TrNjuZ3b9sHJjOr33GeythZswze2lCHE6coNQzGS1gDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG7RlesXEQPDXC8H4bmYqk8eLO2rilb1+HsAae76I6TJcVz399
	KlcL03C9gUK9bryBweip+FuTYzWlzfOgl4VJXtSQ7EVQGWOrDsDBoMoTEK0gt7SpwlQ=
X-Gm-Gg: ASbGncs3RnT0danlqIHUTGuF1oONLdHIiw2xnBetw54o90KT4QBt6ihPd2oo9gnL2mK
	QSzWMsRbd1bNBxu6lU+59UzouNmajUq+SLTLo0Sa28siC9knv1vOhkgtnH0CHoTcCREco+d4p8K
	PTv+G2SyMr+z+t0QKGjg8/qryrEbkuW/jVieECF9OEA4OQ837IZ0snW34evbcJHLn67qBOgcU8c
	Mp86qrnTPg+VHZjcTFQeJDtCAdf+AoboFVWb57ugYIJ2hdiiroZ1GUyG+WTzmxHWKntSfTkbxL7
	wNM4ZTxiBfbsFxvhq5LUcp1nEOiC3/x57Ta11LEv+3ed91HHFXHeW0fjBacxLfBqv4/rv4CTwy1
	7PExuaEMRtifzHY3L9w2OvC5HQtA71rhBDdzWj1Z/Lf8Vu0sg3fzXJ1Aj7w5YnK1FW0SKeI8H
X-Google-Smtp-Source: AGHT+IHKQduhhyoSVs024Fbep9JQOWb5NZIDF5VXjs1Qfdqnm3/VRDLWrim+xDf5c7Rf1KdIVjmSLA==
X-Received: by 2002:a17:903:4b4b:b0:240:3915:99d6 with SMTP id d9443c01a7336-242c229ed16mr114172045ad.33.1754791310923;
        Sat, 09 Aug 2025 19:01:50 -0700 (PDT)
Received: from MacBook-Air.local (c-73-222-201-58.hsd1.ca.comcast.net. [73.222.201.58])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8976a48sm238757275ad.104.2025.08.09.19.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Aug 2025 19:01:50 -0700 (PDT)
Date: Sat, 9 Aug 2025 19:01:48 -0700
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	willemdebruijn.kernel@gmail.com, skhawaja@google.com,
	sdf@fomichev.me, shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net v2 1/3] selftests: drv-net: don't assume device has
 only 2 queues
Message-ID: <aJf9jMgcA42sAcCu@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org,
	willemdebruijn.kernel@gmail.com, skhawaja@google.com,
	sdf@fomichev.me, shuah@kernel.org, linux-kselftest@vger.kernel.org
References: <20250809001205.1147153-1-kuba@kernel.org>
 <20250809001205.1147153-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250809001205.1147153-2-kuba@kernel.org>

On Fri, Aug 08, 2025 at 05:12:03PM -0700, Jakub Kicinski wrote:
> The test is implicitly assuming the device only has 2 queues.
> A real device will likely have more. The exact problem is that
> because NAPIs get added to the list from the head, the netlink
> dump reports them in reverse order. So the naive napis[0] will
> actually likely give us the _last_ NAPI, not the first one.
> Re-enable all the NAPIs instead of hard-coding 2 in the test.
> This way the NAPIs we operated on will always reappear,
> doesn't matter where they were in the registration order.
> 
> Fixes: e6d76268813d ("net: Update threaded state in napi config in netif_set_threaded")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/testing/selftests/drivers/net/napi_threaded.py | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

Reviewed-by: Joe Damato <joe@dama.to>

