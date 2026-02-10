Return-Path: <netdev+bounces-258039-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLJQJ7DcimkOOgAAu9opvQ
	(envelope-from <netdev+bounces-258039-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 08:22:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF047117DDC
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 08:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9FA343042095
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 07:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FEC333440;
	Tue, 10 Feb 2026 07:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YmY6jpQA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A2329BDBF
	for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 07:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770707977; cv=none; b=SfG6IC2Jt9ktUU7lhbDwMMA4kza2ZlzC2IlP+3UYyZNn7GF0b96D0Mgt4FTAzg/xKqf4EOST0O3fH1RAGOhoOOnISIEnL1N6pyLwFbfYh99aWPnGt8zUrQvqeUo30KywQtHY1J+wgCAIUfJZ1ueOBJR7XBmnGwdBcQ3wV4hHAhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770707977; c=relaxed/simple;
	bh=kK65SW7wtq+k4q7fFJpOPJsrEnIS4z6aEb/D8VHBUTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z5xB4IF7uCrzOlIsqR3fPVmg+VslB1yM8d05gWHde39rJkCNFUCjl4o4rVrI2mHbCuyqlkOk6MjWbOmDXJHsXHub0wq+I6P7ZO/sEdfylfvZ6+ANOVYC7w14o37Zxw+tq2kNtDzjJCY8MAugDRBfK2WZO/mbvXHfIBUl3Iw8c4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YmY6jpQA; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-480142406b3so40569105e9.1
        for <netdev@vger.kernel.org>; Mon, 09 Feb 2026 23:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770707975; x=1771312775; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iL6lJolXxpsljH7ymwbj9tMKM/d5rRakiir1KETedaQ=;
        b=YmY6jpQATQnauZ7e+G7JDTuBFqljaYYVptmXlLquUE4OWw20UlgbIrVaDzvLq0c8IR
         +EMTTg9+gZNDzsoBcdrrLI9dlQh+rSmYGZlh7JVXCYun1m2NSVF4j1Ld+JEnsa7lrB+9
         UXJMZ2ZJutwvQR2vgmM0V1q/UaX7D77zCooxfdtx+8XJc6OMleGfDgwbG/cc/fgZa5Am
         zBmMyOi3MmC3sVwpmEe/bCa4R32gKElYaYazyvYJ9L6aL/8Y0CbOHFQiOly5hcsRpUX4
         op23WMe7jV9vrhaP7GaFAhOgGfhwKaEjF+1f5ceu1UZDWOVhjO+2xAuXUtWnKpwAx4mx
         XNTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770707975; x=1771312775;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iL6lJolXxpsljH7ymwbj9tMKM/d5rRakiir1KETedaQ=;
        b=L5n6BTk5oxsvPB+PnLwbdO8lSBKfB1y0aNvq6TJWdlkpj8LZheTJB5hTy+53PEi2A7
         XRS02GsIja2wrefMZQW095QqptYTy3qpwN5j+A8Q63R8qg7hoeE1Bbfj5mH2+eYIVEIq
         Lqnfdbd83u2y4nHg9bipwNqsis3FSW3Scu3JzioecnugU0JoSK5kj1FdPclJ7YiaJyHo
         cs3jXnLYetcCBcoh43ZS7OZUca1lHg/CR5OaeaoVZ/a8oQ5mr2zHIKGvWU6xFdb+JCIi
         ouyHPLHCsvqXo4Q+L+HPPKtX4aX/hdfyKUN49BXrjt8tKV4t8J9dW/r3O+gdWjjkpRdx
         kvDA==
X-Gm-Message-State: AOJu0YzO+Uq7MBaeSDFxjqqJx0s9pFPzPzK0yhv5JBDyu0Cny/s/l2oB
	GlfuoAH9DgAoIPHG2vPuKpHpKSVY55+vdFjJfW/L0ChcVJ5ktbfaSusY
X-Gm-Gg: AZuq6aJPuPdyq35672thXbepFYI1bY/NBsKZCbjMnCZmhdIXvNNMh+4Dpz1iXevnsNa
	+WDq3qa4ZA6BcE5aaax/308ki2rkXttzkN0o0T517tchKUXfSB5Je2XwwwWPb/Cli1JgBVqRVjW
	DIys0iSZkgr4qfZBvdwqbpgWMxZusQN30PA6a7R9rOdO6rsnyaxCnTmcFXDwO/Zbkjb3MaDONDe
	1MxTMvXZbIBsiCo/ZP+807fO+jpxrDiprlY88Tz8QgrLC5W/NftTRcq6/ugi/4hJhS/nGYIEwqB
	u9Wr1ZtCCXmckuczTkgNeg4dBnx5xc3vQw3waqJWvtSE+VOo+ZwMYXvtKIIk1L3q9fQMAVmXq/s
	K/pOmhClhWdZ78iRe4ilFN5FLjtkCk+nt/c+P3zXqyeP+mw4cY+EYAzssXC6puUPrjcRcn6I3fM
	IGXv5VlQe0tpHbQ6nvPbfdi4RIPKa4XbcxdhzWWdtxX44LUyLJiszx4q5c6xc3USJehjt8Ew921
	qD8+I8jXIKfC3aWn025GhzdE6fBxij/fRrQ61yyhMGfwCH7zuaQ8r0rO3N+ntWrKkOYTZGSzw==
X-Received: by 2002:a05:600c:1f94:b0:480:4d37:e742 with SMTP id 5b1f17b1804b1-483507e16d5mr16562735e9.10.1770707974457;
        Mon, 09 Feb 2026 23:19:34 -0800 (PST)
Received: from ?IPV6:2003:ea:8f4e:8700:387b:1469:c43:7e0c? (p200300ea8f4e8700387b14690c437e0c.dip0.t-ipconnect.de. [2003:ea:8f4e:8700:387b:1469:c43:7e0c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4362974527fsm33115284f8f.31.2026.02.09.23.19.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 23:19:34 -0800 (PST)
Message-ID: <8070340c-3521-491f-95aa-7e377ccc8cb6@gmail.com>
Date: Tue, 10 Feb 2026 08:19:32 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4] r8169: add support for RTL8125cp
To: javen <javen_xu@realsil.com.cn>, nic_swsd@realtek.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260210071134.1530-1-javen_xu@realsil.com.cn>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <20260210071134.1530-1-javen_xu@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258039-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realsil.com.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EF047117DDC
X-Rspamd-Action: no action

On 10.02.2026 08:11, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> This patch adds support for chip RTL8125cp. Its XID is 0x708. We apply
> different and firmware for RTL8125cp.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
> 
> ---
> v2: This patch fix one mistake on phy_modify_paged(phydev, 0xa43, 0x10,
> 0x0000, 0x1001) which is phy_modify_paged(phydev, 0xa43, 0x00, 0x0000, 0x1001) on patch v1.
> 
> v3: Set phy_modify_paged(phydev, 0xa43, 0x10, 0x0000, 0x0003), bit 0
> means 'link speed 10m PLL OFF', bit 1 means 'ALDPS PLL OFF', bit 2 means
> 'ENABLE ALDPS', bit 12 means 'ALDPS XTAL OFF'.
> 
> v4: Fix some format mistakes.
> ---

Note that net-next is closed currently because of the merge window.
Please resubmit once it reopens.

