Return-Path: <netdev+bounces-158484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 646AEA1220F
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 12:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACA8218811F7
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 11:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3714B1E9905;
	Wed, 15 Jan 2025 11:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ey8eb32D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9B0248BAF
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 11:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736939103; cv=none; b=pD91IUTAIodN+flGZwqhGQATXVKXmUpGYfGV1SJ7NQok/55GbdIKPTKZax0U1nD05zdNZhDfVp1IMLQhJzFyNt5gaw5fa1p0jZ/2qjnBeK/kbaXiawnveL6PW4BqCzSKzv/fpH83qMT8q5qxKfZPU9IHwlRjvBxunwRP+dYFmKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736939103; c=relaxed/simple;
	bh=iocIl67crlEXJbHxs9NCMSHeVr654TTSpdj3FYE4El0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Ob4EmHUjinktGEfBmBo0oltgkVJ2gz6CCSk7S5iHIO3D/q2DYZbnChHANYW9UecZ+YeJoC71TJkODoiuMGDepm6emhUUE8XdOxaPsk6gfaVcbXxwyuUsWH2bL8/9jWQeW2vpxlh22zLLmRYDI/Tl96LKQMgMx8RXl+RE71U/bEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ey8eb32D; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3862b40a6e0so3535511f8f.0
        for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 03:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736939099; x=1737543899; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FYRpDWelijRYrLkPswGM2HivoPOdZSY003kQLqAAz4M=;
        b=ey8eb32DC640znP00ES9NBhoDNEf2EK/qmeO4IxZ5+3HBstKKlgHXqq3acKt7uaN+M
         zBWfFNBRX+uAZDExhoacuCkZ5SmCvWmKOzFCSJ7SwbKygM8EDcSkKlfhgQkXUWq+Sja7
         xm5lC5hX5X0EI7uQaq2saQt7YHhBDcOuQ23jWSXEdals+gwRiyI8UUKzRC29YidjMaI3
         Z2cJ/NJOs490328U1MdIhv9HT3tevofihXwSn32rXPTYNlI2FVUe5Ebc6ObVf60bayqU
         Rba6cIqI6fEbzoDfBfyDxkzpiylC8PK7DLNODM/Zek3KYF1iKbUgk0Lb+thKR3tVWa1M
         g4Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736939099; x=1737543899;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FYRpDWelijRYrLkPswGM2HivoPOdZSY003kQLqAAz4M=;
        b=o24AYql9ITAczbqv8ecs9jxBnGahiE374yt7Q5S6yXSckglnk8jMMktlVsHRAL79r+
         ShXB+DP70wU07S0w4c5ql7mnbPy61hZvNyFVlmKMpPZWDHupxeVVMtqVxUA1P4WHZ8io
         FhgRl8r05NlUm18w0XyHalLnNKmofYSJ/ww4T5kM1GSve/HNFJGcUyz7JVKgBrZUQ1yW
         RWPJL8yO6iAtmB7fKYBrhfbVeo4GknXTQ8KJFjdBd90p7a89ojiMihjqjAix1d3G0nu6
         FWc88xseLwWN7U4YzwxsIXi6Zpa70vGf3rnn6MwKu5zcoS6hFvygCA70RsJAGs/KU3bF
         Y1cw==
X-Forwarded-Encrypted: i=1; AJvYcCXyBreA6AjNsKaDMCFk2OWpak7QCDuR6e2XFTa/QJGvOWE6nPgau32uwJ5hDRSl5U2vmKwHLxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YztcceSERINVLtIACbUWDRE4SKltdI5xCmZF+pgU7eDik2hgo5C
	CsRICA1xONFaScCt0skVVqzm1YU6jhAp55eYz1oshoak5fblm2L0rEi9bw==
X-Gm-Gg: ASbGncsz1OuLjwWktv1tr4PjrK/umlWdj9MZnrUTrGeNjLVCK1qRiZhke4auFm/bYol
	MWcdDVunypUrVCxzSWkUDwp+PuSFn2ZKb1bR9l9BXqBmYg4T8+AkL6V+o9UH7abHun+swBsPAHK
	tYe6rD/ftaVa/u27VC2Plge3oeuUgPt/vSOyMewDhIsLJl41JWTE1yMK5Us6ZFEJzGjpskAR0kZ
	ChuOrKsGqIJFY45qF/vkIENYNEu1TH7NOQPvhj+LIALU1zqBbvF7leUV12ksG/wy3LT5MvM7NaP
	+hCz5TPNH4l0h4/gyJKP3FnlD0cQmk6aXo5A+YtSTRfQ
X-Google-Smtp-Source: AGHT+IHdtQFTjnGOYRqFdiSRZJVK0BHhs/X+ySkArhiV2kKhcsQYpo7k/p5hA3YSLMyrZmlD0tzmgw==
X-Received: by 2002:a05:6000:178d:b0:38a:2b34:e13e with SMTP id ffacd0b85a97d-38a87303df8mr23428683f8f.18.1736939099326;
        Wed, 15 Jan 2025 03:04:59 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c7499821sm19139265e9.2.2025.01.15.03.04.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2025 03:04:58 -0800 (PST)
Subject: Re: [PATCH net] net: avoid race between device unregistration and
 set_channels
To: Antoine Tenart <atenart@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org
References: <20250113161842.134350-1-atenart@kernel.org>
 <20250114112401.545a70f7@kernel.org>
 <f87576e0-93d2-42fe-a6da-09430386bc16@gmail.com>
 <173693410183.5893.12485926901643155644@kwain>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <7fe79d84-70ba-5bad-58ed-6bfa1a28e555@gmail.com>
Date: Wed, 15 Jan 2025 11:04:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <173693410183.5893.12485926901643155644@kwain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 15/01/2025 09:41, Antoine Tenart wrote:
> Quoting Edward Cree (2025-01-15 03:51:12)
>> Would __dev_ethtool() need a similar check?
> 
> It doesn't because it calls __dev_get_by_name() and returns -ENODEV in
> case dismantle started.
> 
So, to check I'm understanding correctly - this is because
 ethnl_default_set_doit() calls ethnl_parse_header_dev_get()
 before it takes rtnl, whereas ethtool takes rtnl before it
 calls __dev_get_by_name()?
Subtle enough difference that the commit message should
 probably explain it.

