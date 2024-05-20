Return-Path: <netdev+bounces-97201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE338C9E65
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 15:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0BFD283552
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 13:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45962135A6B;
	Mon, 20 May 2024 13:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxVTRbHD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8774453815
	for <netdev@vger.kernel.org>; Mon, 20 May 2024 13:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716213016; cv=none; b=NjkD+U4lPNhoPDM+0A+Pf5p1ojwWYv6s5Q+X8SM736A60v6bbO6E8H2tTDshDf4mZDuZsKtSp7pYPrjzYpZRQrbS/VukH+nKYCdnm8R7+tfE+5HwJFBPEWL44NcMX9Ja2T0ZlT5QchwVnSSsvbNSgnh9C4PNt9XMT9NeMAjWeBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716213016; c=relaxed/simple;
	bh=+LpdZzub4ibOWwaHiuGV5rROQt3WzkoPpVZQMts9WAU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=hz3t65H/SnaudFtKKQExxBS1e+/tEYEzbnmSpkgKUiQ3UxLIEx58JW/BpgDWpQ8svb86UKk2rOw/xihlNyhLlC6ByATcXlMWu6A8fkBdx1w3G5eV80H+Sy9d6Wi9YUm4og9cfuCZ993hlnSd6dOpEcTksYgD86HJ6GVq+QbV/KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dxVTRbHD; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51f40b5e059so3861659e87.0
        for <netdev@vger.kernel.org>; Mon, 20 May 2024 06:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716213013; x=1716817813; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Id5MQBUbhYTcucL/VrmtJqQ9UUU3trmjX6vWkFhumf8=;
        b=dxVTRbHD7je7egSA9BYwQx/Gurc2XOgRK+XlxanU3uW7vMe6gNrc/kT+GZPkDFmPXO
         e9Q8bloaUPO1NGGK8Ll6dcGTOKxvWwZiBWWpyQD84komq8lHWKKJ9YmtYajRKdOmxddb
         PUJptUPCp4YzxepCXzvuydUBmoE+EqjL/Qvk0LTkG9IKpsSavhZI0SijtPf2sHt7ftSS
         XkNditYzKqsK6xLES2rSJGj3rdFAmGJaRvZIcgJ7VuFXU9CPVyFeQGpeKw5f2OJ65/+h
         ulT8613NeiwNou+s/8sL6h5Lk9jcUdaJT9V9oA8IqboN+Vi4NTX0ys5M28MC41Agl8eU
         +amA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716213013; x=1716817813;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Id5MQBUbhYTcucL/VrmtJqQ9UUU3trmjX6vWkFhumf8=;
        b=tJVU+rgLOVwkw5PE2FsUQJHAUuLTLcor7A18K3CiQaWb5kd2yh5ChKz39CgQASPXL9
         iZAf0ocF0tF/P5qcMVJ1vah5NIMZm8JYR7uqIfQ3MpXjen+7mXX7NeUhOXp6RbHeMHbe
         2QlDwC7vIM4XOtVqphm9L4u0/rF2f5zSH9/6LMkhRuZ4UPbdxyvELRZGTxgVklTXPRQx
         fNaM9L09Ijn8THcbMA/XfmEh7r9/nUOycZL9A7oOCXTwEOl5Z+34hy6QMMDSOaV0wZi9
         TUqdbXfBoGsMaidQV2+Ex2lgcYBBMDlOvdVK9pBfIKRjMGWHr+H4eN3iEprGi/L38ZIR
         qHIA==
X-Gm-Message-State: AOJu0Yx8jQJrTdJnX/NLXRfr3XGBPstJuZZi/pPFsPoEPl4OZbTupstr
	o4bk7BoKW5CJ3J9kWJmCaMMdpL6IxW1+VugcKpZeenddGwDQ6ahG
X-Google-Smtp-Source: AGHT+IGP00zBtOCXEGqaMsNFMvBmOf93z3tf4NZq4QrA9GIV8SolLNi0Jh7D+FabcsuNYDKfnlOOJA==
X-Received: by 2002:a05:6512:3188:b0:523:ab19:954b with SMTP id 2adb3069b0e04-523ab19962bmr11306221e87.17.1716213012314;
        Mon, 20 May 2024 06:50:12 -0700 (PDT)
Received: from ?IPV6:2a01:c23:c540:2f00:b478:f486:88c7:a503? (dynamic-2a01-0c23-c540-2f00-b478-f486-88c7-a503.c23.pool.telefonica.de. [2a01:c23:c540:2f00:b478:f486:88c7:a503])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5733bed72bbsm14986996a12.57.2024.05.20.06.50.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 May 2024 06:50:11 -0700 (PDT)
Message-ID: <af817788-d933-4cde-8bea-942397fd26fe@gmail.com>
Date: Mon, 20 May 2024 15:50:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] Revert "r8169: don't try to disable interrupts if
 NAPI is, scheduled already"
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Realtek linux nic maintainers <nic_swsd@realtek.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Ken Milmore <ken.milmore@gmail.com>
References: <9b5b6f4c-4f54-4b90-b0b3-8d8023c2e780@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <9b5b6f4c-4f54-4b90-b0b3-8d8023c2e780@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15.05.2024 08:18, Heiner Kallweit wrote:
> This reverts commit 7274c4147afbf46f45b8501edbdad6da8cd013b9.
> 
> Ken reported that RTL8125b can lock up if gro_flush_timeout has the
> default value of 20000 and napi_defer_hard_irqs is set to 0.
> In this scenario device interrupts aren't disabled, what seems to
> trigger some silicon bug under heavy load. I was able to reproduce this
> behavior on RTL8168h. Fix this by reverting 7274c4147afb.
> 
> Fixes: 7274c4147afb ("r8169: don't try to disable interrupts if NAPI is scheduled already")
> Cc: stable@vger.kernel.org
> Reported-by: Ken Milmore <ken.milmore@gmail.com>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---

This patch was mistakenly set to "changes requested".
The replies from Ken provide additional details on how interrupt mask
and status register behave on these chips. However the patch itself
is correct and should be applied.


