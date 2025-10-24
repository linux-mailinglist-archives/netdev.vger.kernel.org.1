Return-Path: <netdev+bounces-232374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F95C04CCE
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 09:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7F42D3440CB
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 07:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40ED02EBB89;
	Fri, 24 Oct 2025 07:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="PkL5KFp/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F2B2EB86F
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 07:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761291803; cv=none; b=ddpFXSxZpbnWQT+3HcWo8D8h7cHqvrI4SNP5kXo6oDbnVZZejh6KkHQJ7eJL30BItwBlY9JwnS9sDDmdPLGZe+dpxNWxNhyWTAWXsweJHDmpVBHoJBgXlGkqLClNVJtVGZY8c0crSDjk4CMuNtv4rl7ye8E7XQbLDygY/kwXafg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761291803; c=relaxed/simple;
	bh=n9vrj8rw3vvgLnp0wFhiU0wr83DTSKQ91SlzmqgRO7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WAE4c520mIbeBMJiR6ReyabP4c/Wixw/lP67TJgm5kHYWcGHp/ki6+toIJZgteSlfe/ch4qef1+KqM0Kx9rd3ploakrrZpXEc/7196H27mv5OZjg9Wcm1PTiRN4z33tHrlPAIzd6f9Mn81AJYoI/B/oKocGoHwceiyM99XaIvwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=PkL5KFp/; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b472842981fso227613766b.1
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 00:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1761291800; x=1761896600; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=btg6WWXpIi0CWUiiHvKL1LewBs3OVn+no42TB4G5pPk=;
        b=PkL5KFp/7P3i8NiDEWB0LFmIDPhX+9t6CAfkDZ3joMpWEfkIkpwJRz0UmMYeivRgUl
         525dlBX/WxfXNFVpVhgBiOmpM0XLrhCsS+wut04tg+042TZX9eDL3vAVNCNVUCl2VDfa
         mLVi+bVeNG9A+jo8Ct0mpbMgvtuCuS/5ydSQoEPgKjjiLwdFIP+k+q5vvlB7aMYRz2Be
         2TQvjOz5XuMwmOUFi1/qwL0skLx6+A1oLHo9kZ4ajgseuvDY4DZH0JkTDnuMD6J1b/fr
         O5Nd7d1jL5PEEF1HA1roD5l9YRkce72xMzlAwSC177bF4bYm6QarF/2XO82h+m8jBlbC
         UgUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761291800; x=1761896600;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=btg6WWXpIi0CWUiiHvKL1LewBs3OVn+no42TB4G5pPk=;
        b=AFygiduUCo4LMZmmZXGfuWywToNetmnQBOnXk769zmXpHy6iEfMzCuHYAjQOmFtj8I
         9sHR+rk1dP/k9szGAloQc89QD5JEnE4y4DbFG772bjSbxbw2NZcNWxgA793s32CNf+6d
         eLBObrAljOYRWXE4IJC2TZqGkdC9u8TaaukxXdtgzhvOFJHNMKGEJhr0zDjpWeTU1b9g
         fQ8VeFqdvGCHD2TxHwV6lae/llhB3xBwtqKNSmE+JiPuytDgQwFWiSkMuDYJQgSy/Y5b
         8sfkkg3nd8oNml4B2cvNBLIDRLGO2U/bkBzRDNry6+hvLS/nmuNABlVyv9N8A10Ozc/d
         9F5A==
X-Forwarded-Encrypted: i=1; AJvYcCWk99Gl45qNGj5kc34EsYf39/JyINe5rt3NaR/y/b1CIWd7rR085yKlMXqqpycGygwGcHZXwuY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1ZvTX7UVstF96b9E0y5liyfJ1O3spRQRev8OUY8Yuhy8xjOvr
	f6It1Uh6Gb9vELpqAU4fQlzqf8sn+wykQthxop4BTbrWd51rEjwhBMGLWFQTZiATQsQ=
X-Gm-Gg: ASbGncta6dMBy3eywXamIgjB9NjKVZkY0aW1GIUAr+CTcjIAHtm0DhVXkBTM63xl/VN
	k/WD3laTgtAu8BtrsdGH6AkGQII0uyeyv3GNz6x6D+iWS7hKOBALdYFB5DpAxmxg7GVxuKHfFYE
	1Koy2O4X/tV/lCqjJ6SGTM/OATm0Yy1GLSQKZcy8Wauu9FcC88M6MYXxC7rArtHz3kpmCgvH0YF
	K1sCAsigtUB+Y4vGSJoiRKHGorKMFCHUuJzXd/k1BQNSxYKN6c5UTOffCFPSokHS6Vg0ygw4CuT
	HZCUZ3aKROaEMvpEAOt8369ZB0yrz5O18TXCR53cXYyN/arvBI7kmmgnd8KhAt3BFH/xSuS2GOh
	+JYytYOUH1jVrdK2ChZJQ6APNnb2tLqNMu/ABqHB3cnpAnAsEP/ZhqELmNMwh3ZnLVSFV/zNsba
	9q5EA/Wje2JH+SPQe9elxiFo73a//9d+fB3hiPDlnCHsY=
X-Google-Smtp-Source: AGHT+IENVgAAY05iZMjJCVKA8oSGaw8hZMk+fKU5hdYwbKNdz8hghfeyg+3i0gPeAqEdHdSGOTqcCA==
X-Received: by 2002:a17:907:1c21:b0:b6d:536f:ada with SMTP id a640c23a62f3a-b6d536f1134mr702214066b.43.1761291799580;
        Fri, 24 Oct 2025 00:43:19 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e3f316847sm3676823a12.23.2025.10.24.00.43.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 00:43:19 -0700 (PDT)
Message-ID: <4cb007ea-c29a-44e7-933c-cfe3f728d42c@blackwall.org>
Date: Fri, 24 Oct 2025 10:43:18 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] selftests: bridge_mdb: Add a test for MDB
 flush on snooping disable
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 bridge@lists.linux.dev, mlxsw@nvidia.com, linux-kselftest@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>
References: <5e992df1bb93b88e19c0ea5819e23b669e3dde5d.1761228273.git.petrm@nvidia.com>
 <9420dfbcf26c8e1134d31244e9e7d6a49d677a69.1761228273.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <9420dfbcf26c8e1134d31244e9e7d6a49d677a69.1761228273.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/23/25 17:45, Petr Machata wrote:
> Check that non-permanent MDB entries are removed as IGMP / MLD snooping is
> disabled.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> ---
> 
> Notes:
> CC: linux-kselftest@vger.kernel.org
> CC: Shuah Khan <shuah@kernel.org>
> 
>  .../selftests/net/forwarding/bridge_mdb.sh    | 100 +++++++++++++++++-
>  1 file changed, 98 insertions(+), 2 deletions(-)
> 


Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


