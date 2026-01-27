Return-Path: <netdev+bounces-254002-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIxDExsneWkIvwEAu9opvQ
	(envelope-from <netdev+bounces-254002-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 21:59:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1779A813
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 21:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 30E3130074A2
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 20:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3318428B40E;
	Tue, 27 Jan 2026 20:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJxTSIHh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21602877DE
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 20:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769547544; cv=none; b=qEmez+i2BeyZDtLlczfQf6RgyVtMu4oaJh/apDBP/8ZSs670CeBwaK/vhqOR1/M3PX5oxg1qAyPLhlDOiUCaCY+PkNWzQ4VUYmOXJEH9iQ5+BnNZAMgrhiu+VWo7/cuwEWIh3I+QNWfWaBfryDbdP0iSkrlULOvCpK7A6DTnJb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769547544; c=relaxed/simple;
	bh=uIcwkzbqJN3pSWq6K5fH1Eh0+OwAbnFMRoChim/GMjM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bC/rMmrsSm4YTw2S35icQXhi37DAxaAhfCJpEgEHqE5aW9ZrrM9cfUZQHVNKEEOYBIiGxqC38oGvDIUKVenVVQ+TPV1ht9up6L5Yry/YK3hhzWkRqS2vlbrSFM9926e/fUiNVzHXkyVZ5lVDRiGKwF1aUT90fQ8ISV1/8PzL3Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJxTSIHh; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4358fb60802so130932f8f.1
        for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 12:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769547541; x=1770152341; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RPH9cRQ5hnz0qiQoHF0rnEXTRqbPpbIaCVqfz2DhLdM=;
        b=LJxTSIHh5GLS7w51XsmQYq3XzfDOXmsT/j3TTIYlL+sn/HnypYx19KQPifRLHaELEn
         QarodfjnfDcKdLld+UdfRDb5zcLzrdyRvMAYXHFpmpKc3yc5WvjYIWzxGfNzu2lneZdE
         E9kL++js7O7+M4RAMCjnUHPHAe8pLjU0Rtj5mwzZVq05jddZH9papMkOXCrKekxXjGNM
         ChdbxZ03sFQ1FPGlOFTBd4xOVnZUGxHHE+aAf7Fn3jrLTsgvzu+lSmx5XfLoGh6L+seV
         SLTnFs5pUqc8xnu32lnxX8I9TUnuu6oCvPmVoN/T6mYFncY7Y33JqBsokK4QVH8lkmaA
         dp8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769547541; x=1770152341;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RPH9cRQ5hnz0qiQoHF0rnEXTRqbPpbIaCVqfz2DhLdM=;
        b=OtOQ755LjccKK6q4d0KLFKdeSGfGyiisrjKHiEZUUEeHsB7vCQ+9RKCbOZaG+XVYyg
         wYea6B3oyJYWmfN20sfbRDUFhRidWpCpjcfs2EbM9KVNvm0BXHi02jfwg20O9ZNIWTOK
         9Ek6qVN/asxTKSCDUaov/8R0SJctCup72lLq0E9LbVbWhKKHEQ/zqcg3Z98C49IPpF62
         bCBRlIhwZv2cP20EZ3g/7RYWSCxYQ9hEwm96rNvujIhCsSlDPoqCVNxMpngFKzrNLOB/
         UCg1DZ3qHaIVCXoRpicaDxfkkB2QHZ6y7dyXrJmifogF99LOt73DJ3UKUCfJ3ZBLMzD1
         GxYg==
X-Gm-Message-State: AOJu0YzGGYSG5c2QqqNGBTdtHkfyMhIBaygYR22eChvJVwUoIZ8/ebMi
	1lzi0aihyedjfo0qC2kpnteayeuMlDFTLD9vUCsyuwzOlDkNeBJVAZig
X-Gm-Gg: AZuq6aIvm7cV7va94Y7Fbqh4slPUBkBuT+P1Th+raywzf8ZFcmcHsYbV74B/O+1ke/8
	+fsl6X/ug5XxTA3n95CVQO8neDl3MG6/tbUnqIyhaSvgK4E03SuswjU8q1cZDkU3ysmGQor0aba
	oZwnTmAmYa8AVNL0fT6Q0hO7T1Ike7x2w+/u/SUGTj19BTstlXJFqzlOXJqZAFBLxV7+iL08ynS
	9ldrGOIVeE58FP63YtnlZf3ax1ubfkw2GjyF/4QK6p8QGk5WfjlXLiodyBRjvY56ricNPUYjGpZ
	YmRJr/8i9KRIw7f7Dky4TED9ng1qcvRqWvXNtKhCdOAHHEYF07PKb5nvR9Pq9uX56lp1mzeIzql
	DQz60Vf2dcx+8Ny+IX+IcBwBvLuqar7QYrJ7kCfijf/QGyUypiD7zETxopUJf7LiZKbJlWDatFQ
	dDqtmziN4Q8dfiB/w0jw085hkJBidXdHe1LBUUkA721lt9Idg+lxaB4aFY5Gfv1Yg7X4l2tCsd3
	ExwbybEIKynRZCDeEV684adf+lG2IVgttYjW1Y/aAAteGT3Kbc=
X-Received: by 2002:a5d:5d8a:0:b0:435:953e:5897 with SMTP id ffacd0b85a97d-435dd211e38mr4800123f8f.25.1769547540821;
        Tue, 27 Jan 2026 12:59:00 -0800 (PST)
Received: from ?IPV6:2003:ea:8f19:d300:97a:bf24:fa2c:e12e? (p200300ea8f19d300097abf24fa2ce12e.dip0.t-ipconnect.de. [2003:ea:8f19:d300:97a:bf24:fa2c:e12e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066c4f3edsm81539245e9.15.2026.01.27.12.58.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 12:59:00 -0800 (PST)
Message-ID: <640c373b-09d9-4b54-9113-782df41aa152@gmail.com>
Date: Tue, 27 Jan 2026 21:58:59 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 0/3] r816e: Add r816e driver in Realtek
To: javen <javen_xu@realsil.com.cn>, nic_swsd@realtek.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260127113425.1989-1-javen_xu@realsil.com.cn>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <20260127113425.1989-1-javen_xu@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254002-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realsil.com.cn:email]
X-Rspamd-Queue-Id: CB1779A813
X-Rspamd-Action: no action

On 1/27/2026 12:34 PM, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> This series patch add a fake driver r816e to ensure the kernel could set the
> correct power state for #fun through r816e driver when suspending.
> 

I think a better approach would be to contribute to adding phylink/sfp
support to r8169, so that the SFP NIC versions (incl. RTL8116AF) can be
properly supported. This would have to include making the SFP I2C bus
accessible by the kernel (instead of firmware only).

> Javen Xu (3):
>   r816e: add a fake driver r816e for RTL8116af
>   r816e: Add a Makefile in the r816e folder
>   realtek: Update Makefile and Kconfig
> 
>  drivers/net/ethernet/realtek/Kconfig        |  7 ++
>  drivers/net/ethernet/realtek/Makefile       |  1 +
>  drivers/net/ethernet/realtek/r816e/Makefile |  8 +++
>  drivers/net/ethernet/realtek/r816e/r816e.c  | 75 +++++++++++++++++++++
>  4 files changed, 91 insertions(+)
>  create mode 100644 drivers/net/ethernet/realtek/r816e/Makefile
>  create mode 100644 drivers/net/ethernet/realtek/r816e/r816e.c
> 


