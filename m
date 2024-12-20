Return-Path: <netdev+bounces-153667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF189F9235
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 13:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED8031888778
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 12:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2D32046BB;
	Fri, 20 Dec 2024 12:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="vSb7SljQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46153204596
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 12:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734697698; cv=none; b=M2tM2lFQkHuZ8nQuTsfVgObyLG4LRdpNOMj3HACMsVNi6Bq5Qiwj7WDCKWh6TCVEtPJ2PFD1H4mjjbspvEnMmrDopA9qGRq2QZTeeRtb61ZYgAun7HHNlmGsnwJWMNtME5UHkA1RTnpaeiGqB5E078tl8mwYhCXequDsOl/C7UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734697698; c=relaxed/simple;
	bh=Ddb6v77SHWQ01yjg5zQWJJWLi+Qk+6+wE6upKt6anmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E19opWAMRpnEEeVUzR/dpWYnA29Q8ecLiV01wU7VtY0wfxV6xdZUrobI4EgBDieUDI91iFftFR628uwEI0g4JE1ZljeF5CMQ+JjfGVl3T7xS69CyUaKwn3GHpvCJ4x6oTAS9A3cMiFEg4By/vGXlJW4mLBt91mPWBmeFCMxvw1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=vSb7SljQ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43623f0c574so12592095e9.2
        for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 04:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1734697695; x=1735302495; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PK3ngqbeNw4BOnOakPdfhW4DY28wx9y6ctKhCJu1Yn8=;
        b=vSb7SljQDLnLAsLXPxQg60KQz7T6rCpa13zKH9v4I7clFHRGrF49kDaduZzPrFDUPH
         Cyh7jkdtqov7XKyH/caO0Dl4D+4p27jSEtmIekeWgePqSgaTPlGTGtzL4xgJ/sMBudEh
         xbJdMugxCCVY2I2COLQ/vN0r7X69tCBs1Ip6XburNeqj4uiIi0IypXc+QOfXcw07v4xp
         oGIfuWAFBobeUVHPIbQwasDde4Dm3nMSAvi8BYxLMv0KEeuvpzXkqMm9iFLgsNf+1Lnh
         H5AnYLnJQKQXlf1cJgjfbdpqZpuReLLh/DL7ZieB95z4QHHRq32MB8ue1Y05WdDBcgSE
         gwyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734697695; x=1735302495;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PK3ngqbeNw4BOnOakPdfhW4DY28wx9y6ctKhCJu1Yn8=;
        b=IJh2ghe43b8KHxPGiyinljB8WaZO9KvnzfwoUE8HUyiH9EQR6a1Qq9PcFDp/+T+Ki7
         TWif7CjGf2eLxufSL5HEq7AShSOQwFheu52RnA0HZ2UEYXy9zdZFRuSha5cuy4jmYTbk
         XCF93pJ7upHyNdO4vyj2QQcTLuaLvWu7A/xylkJsRkLaNwkAdYCF6Xd7DEQg12jgTypO
         k39bzJGQVkmatfPjzcmijOk/Mm7Av4nTZ8aaE2AD4AmaagKG580mVhOkFUTmWUdKE9M3
         7crh6vVuXI/shL40uprjed3Ynv9cYEiooKgAToJzjl512w12/1MKuq/UiHJ9aj9DdlDb
         z27w==
X-Forwarded-Encrypted: i=1; AJvYcCXxYk3tfcGOC3Luy4DOFVeNJWBnhiMTmmsRzVrPneE1Z4DN6FcCpulfD2S609ZWQ1tQ0jllVOw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+XPSww7HxWTX1TcVqbKvH9fhMpGkgYr78ESquTl9lQrUu8Gfu
	f4FZh0xzg6oKLDFipF1H4dGxd9osrv+BDw/x2cJi+gd9NdgtngsoAbmHM7sAUT0=
X-Gm-Gg: ASbGncumqGwD1qIinBXs/wXd2tuhvisOtMBOGLJEwiUSZjVu6iEbxfMNyrOR1a2uTGk
	/v9iBr2l58MPdtsk0N/eglPuWTe1zKFxyDxI1mCLCf6+QDG9BpSnLF7Gq4hTQeJtZwc4OttY5zl
	o962vW4eUOtv82lBp2Ny0BxLBRacy0pygOwe8kqqwU+nUqgm13lm4KylrU3qOEXh0U40LtczXAy
	jE1OEHNt/3X2K899Rs5jQGLNR2R+OqDt5m62CbsyyYLRVa+qix5W90sNr8ZmHQOgeVsdEhh4XgT
	a3jKhlbCFm1I
X-Google-Smtp-Source: AGHT+IERzTmIuZ5ShE2OixsRQokWqLCp5nlaW4wpXU7HE4OP8i/8gpF9Ee/IWg29uVu7gnnL3BEArQ==
X-Received: by 2002:a05:6000:1fa7:b0:385:f7a3:fed1 with SMTP id ffacd0b85a97d-38a223f5cf6mr2525361f8f.44.1734697695631;
        Fri, 20 Dec 2024 04:28:15 -0800 (PST)
Received: from [192.168.0.123] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c89e528sm3994788f8f.83.2024.12.20.04.28.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2024 04:28:15 -0800 (PST)
Message-ID: <50b37747-6820-4849-a578-a168e62dda6f@blackwall.org>
Date: Fri, 20 Dec 2024 14:28:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/4] selftests: net: Add a VLAN bridge binding
 selftest
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, Roopa Prabhu <roopa@nvidia.com>,
 bridge@lists.linux.dev, Ido Schimmel <idosch@nvidia.com>, mlxsw@nvidia.com,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
References: <cover.1734540770.git.petrm@nvidia.com>
 <baf7244fd1fe223a6d93e027584fa9f99dee982c.1734540770.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <baf7244fd1fe223a6d93e027584fa9f99dee982c.1734540770.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/18/24 19:15, Petr Machata wrote:
> Add a test that exercises bridge binding.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> ---
> CC: Shuah Khan <shuah@kernel.org>
> CC: linux-kselftest@vger.kernel.org
> 
> ---
>  tools/testing/selftests/net/Makefile          |   1 +
>  .../selftests/net/vlan_bridge_binding.sh      | 256 ++++++++++++++++++
>  2 files changed, 257 insertions(+)
>  create mode 100755 tools/testing/selftests/net/vlan_bridge_binding.sh
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


