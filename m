Return-Path: <netdev+bounces-132373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9773991705
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 15:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 873E52835CA
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 13:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0447E14B94B;
	Sat,  5 Oct 2024 13:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="yN4DdZkv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62254145FE5
	for <netdev@vger.kernel.org>; Sat,  5 Oct 2024 13:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728135514; cv=none; b=hF/YWBqL3/L092pJip01T79ZmEYm8c+2yKvy3p+/ABLF3KDgYe4nGGjQUznWpGoFsMByhwXZtY3ho0F3xB7mtVHSepB4GDUe+0s+A91u9GT80RF1B/f7WgxU6k6FUXA3AwSqIi+NTStlWG37mzEk6u4r2vxbNxKm0OHyBXGVREo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728135514; c=relaxed/simple;
	bh=9yrYIe9t7ddVgrKrXRtX72JcNFPtppbhRzr6h9SHQk0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JXG9vYVfJDduS2Jixdy3ea4pITsnTLuVQ7tLtw117KFMMRWrUIGVXhn9axETAfP8ZnN2f1jvGawLxlM0Sfgyr5MydsWaeY8YEPmfbMaciAtHO8jfs9GI8t4b//4KAz06kMwftaN0P8sNBbyS03UJAPlnM9u4nAg4jaSlE9zw4vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=yN4DdZkv; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42cb8dac900so29554815e9.3
        for <netdev@vger.kernel.org>; Sat, 05 Oct 2024 06:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1728135512; x=1728740312; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oj6Pl4/l9kZUzVF4GUsuM6ijTRqWmaNH+v4h1AOujcs=;
        b=yN4DdZkvtNZTN9cnGYnRNoJaZ95UgXq4P1uQSJ/ujMr06/nBngXPIG4hFzJslbTzS9
         8ZAG92XrlSCB5Txll3UkJi59YazmnPw/884njABKeGypfLnznLk0vdxNkt0Ac7i7GU+l
         lnKtSK27KrsTiKTnX7mqzeF0zYBftOJrkuIZAlcdbfsNxSsHGTtQiX2xsBIJpW6ItiLc
         ps0yF25G31iM0C4LYpD5eVIto/OLdqurDQ+d59gIhEJVIEGd07v+D7DSo23WWTs6wr+S
         bTyaq5WnAo9d0B9yobP2ECrpK6526UFhngmCQTbgNgZDJVY6+kbhyQwucQ+BG+oslDxD
         whLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728135512; x=1728740312;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oj6Pl4/l9kZUzVF4GUsuM6ijTRqWmaNH+v4h1AOujcs=;
        b=ToWheOkoO7HveFI+1pQYBpP4L1KIyOR/AB8lD6DJOrPkH+EYP7FPKd7fv2bhD7diff
         RRqlbrGVbcF7QiVNIoFWmdmY05ERQ28EZnIhljEQSJkIaLoj6t/qE9Z+Jtsr+de0qUu2
         eEh6yIMM4nDoYeIbwukpW0AkbS7lxePTz3Cjet6bj/HHM+IhmTGmOp7HhFSooipPl3Dy
         Drw/4lUdG7Jh+czHJnWVaPlO0M72uBJZvKBifpMtOsxaykvaokFVT9OHPYGM7GKa4gy5
         rpz6kOGTncGgKpbXqwNkiAYqaJ7Zch34g4lT4uChwrKsbFPJ3TD6NV71d+N/RAmUrCG6
         uPEQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0TsYodyyjOh8yRyS0+qxmcue7M1rp+7DoUwFFYEkG5eLiLR/R7CJLS28OUx+VdqPYThS5ssM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOa4hXW3tjHQXpaReN1BuHhcI/mdFanyRKD4Yq/ek7hzOpxGN8
	62Zi/vgBNsX8an5E3pqEjcRTdNMKhzgTg9ZwnF/NciHIxMI01O7v89WltsNt7/0=
X-Google-Smtp-Source: AGHT+IGlEwaQv8yERtc+sqSX21YoGipF4hsZC+fXEqjmnuZrB/c9LLxhwF5LgDAxb9zgFeHPkZnvwg==
X-Received: by 2002:a05:600c:3b27:b0:42c:de34:34be with SMTP id 5b1f17b1804b1-42f85a6d765mr46494725e9.3.1728135511788;
        Sat, 05 Oct 2024 06:38:31 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f86a0a8a0sm40965915e9.6.2024.10.05.06.38.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Oct 2024 06:38:31 -0700 (PDT)
Message-ID: <99f316d5-72a6-40d9-9803-c51180df4674@blackwall.org>
Date: Sat, 5 Oct 2024 16:38:30 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 2/5] netkit: Simplify netkit mode over to use
 NLA_POLICY_MAX
To: Daniel Borkmann <daniel@iogearbox.net>, martin.lau@linux.dev
Cc: kuba@kernel.org, jrife@google.com, tangchen.1@bytedance.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20241004101335.117711-1-daniel@iogearbox.net>
 <20241004101335.117711-2-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20241004101335.117711-2-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/10/2024 13:13, Daniel Borkmann wrote:
> Jakub suggested to rely on netlink policy validation via NLA_POLICY_MAX()
> instead of open-coding it. netkit_check_mode() is a candidate which can
> be simplified through this as well aside from the netkit scrubbing one.
> 
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> ---
>  v1 -> v2:
>    - new patch, also use NLA_POLICY_MAX here (Jakub)
> 
>  drivers/net/netkit.c | 25 +++----------------------
>  1 file changed, 3 insertions(+), 22 deletions(-)
> 

Nice :)
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


