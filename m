Return-Path: <netdev+bounces-249533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C3AD1A8E8
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 18:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E8B7730081A2
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 17:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05A42F12AB;
	Tue, 13 Jan 2026 17:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akeuCVbz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2439C29A312
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 17:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768324558; cv=none; b=HsqLmvqSl7UiEh62niDtzUo8cBKnBrBnm1LDrWuKBJMWtvoLdTHtKhcKAw/7YkU9fEtYlssAY9HcI3dXH/D2q9z/lfe+PasC+7X8NGUjMjocTWC4XFsCWeMqYSP6A7HBUz6Pz3bdsfOiiYMyj0aacWJgvvYxA1ia25c7iLAhFDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768324558; c=relaxed/simple;
	bh=q28vyDEXPHEJ9QDyxfprEn1rnsmUX3qessCbgQLh5tE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ywxnh8hpZuC7nbWEJn66l3WleH5V9Dn4yT/g9/V/+4VQJ4kNnLql4miK9pmQ7lZgJMRPUuNq7atRXwZ+Z34QprUf5/JCfhoS68MTjJIxWiEv5gh7Hawgg2v3Zj3qusQinmaEqeDCbZxYWQb4/8STdLojLtZS+OBGzNRfz3tzXJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=akeuCVbz; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-47d59da3d81so179645e9.0
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 09:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768324555; x=1768929355; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p6rvAxFjWvFw+4tTD//439iEW3QzpifeDgJlgu8aZDo=;
        b=akeuCVbzWj35ySH0F4AuSH2+s78v53gpcBIfrE70/9DeJ5SHhMBKWdiXEaGTNVsLvB
         YTGN+gggFJ3AfccddGQww5SzhVL110/qm3wKOf8co+xUu/gsaXnvtYr3CN6HWvgZNl/i
         iu/2R34N4HEhQsfiLdlO9kYbw0yxWtB5IDn18kTNK1AbwOiau62nrhuKGT0S7gonMyUe
         GhJoLEeQLfLF6z1MamXo6Yd9Pb8X3FDQEIkJ2tAH6+tyO7yltaw0QhkPLCibvwyhWpEP
         wVdRde+O/tfGIDeFBFC0a7toDFbKu6KWEEJdQyUaPP49IobxyLc/bnURtEI0YM/VQq91
         XkoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768324555; x=1768929355;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p6rvAxFjWvFw+4tTD//439iEW3QzpifeDgJlgu8aZDo=;
        b=RGpkEvN3GUAIV5yTHdBbiVStNmCNN4IWCP/fhcgHJ1jSf4DN2+MwhQ43lYvG86g3jT
         bIhF70N2nsuC2iQQKDDLsIXTQ4WaQj1cbglUjTDJF8aXyN0YaHDsPpRlYlCq9ho1efdK
         MhQVUj/qGPTRVaYqXyCPykZ9rD6KEbMDoXBWhwvn0yBVQ6wkOOx/Df1OCHwznx3yGmHd
         1iMgXYJf2lKdLAlKg3pwK1N4H7x4wUxgPvmfoO/8Xp6PHahlrJoyYUR0zUEvhnp+rJl2
         7GyRmWfdULoxPR/vhbk0AI1eOsl1bLek10SyAk8GMpXcikEP1s9VV52lSmkh7R2kWau1
         7/uA==
X-Gm-Message-State: AOJu0YxtRhL+MtfLIOXuiF2tjZgpq4+H71fMq8kJKkn2t6GA3mnQJbBQ
	KzL8EfSMqtUc2iSUlp0rlAxeaX+28wtbtUQ89QD/TrrAiDx8Q26aaIXz
X-Gm-Gg: AY/fxX6dj48O1rW+lICW3rzHrMdXPYA90Qf0LUAyzNpMc1SFcZU2ntqk5Q0yRAcrd1f
	9Qgnk3VjRtgQkKM1YSOA/G1Qs80KssZ9PGjhU37ZY8JD8tqKhAbzzXOR0zNYx6XgZZjQZsTeJ6Z
	BG7XI0jG9MVKED+pg1Qszfqt5/mw/FnDdv1uWIE66MJmSpNVAOJW33g6L4u9I8psIAi2JaHk9Z+
	J1lAIsFVyl/EgOFtAnQNNeqr1gSoe3iDFTVeHA+lnoYGj2+5i3ukY68OoBddPL3wsxQvsMzHB9E
	2imDX+Bx+L90kXnNPG6usN5ot6k7QHgTU1eAs1YdL6B+y1whzBGcRfDZtfqjxDjAAHlzvCfKEqD
	2uXrqTeFYFPIq0V0ySop0eyYCD2koFw4TlaCl4yrovC/jpIFifvLrskGHaplnMlYLrFGiV/JV3/
	Wqw9qPhVQrTIy2wVb9xAi9D/UFpDTGs5vlSpjkGDWl7iP/nrAlpTD50BqowoSw62YN6L/p0wgdR
	yWygrtHYvj3MkBn+EoXlhzFpEHuM2kqINi8Vo2CtVM+OyJYGdVGYRwLzn083MbQ
X-Google-Smtp-Source: AGHT+IEHxCakWIFxcarfwrER3M8t1lh4CmVsq6CKvYTROj0vP/XKK12cab1bvm55l3J2Ye3rGv4LZQ==
X-Received: by 2002:a05:600c:c48f:b0:47d:403a:277 with SMTP id 5b1f17b1804b1-47ed7bfd511mr47909125e9.4.1768324555240;
        Tue, 13 Jan 2026 09:15:55 -0800 (PST)
Received: from ?IPV6:2003:ea:8f03:3800:f014:2739:8365:c879? (p200300ea8f033800f01427398365c879.dip0.t-ipconnect.de. [2003:ea:8f03:3800:f014:2739:8365:c879])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ec5d95edbsm202358445e9.3.2026.01.13.09.15.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 09:15:54 -0800 (PST)
Message-ID: <54148fa4-cb73-41c7-bd5b-fe6e44d80567@gmail.com>
Date: Tue, 13 Jan 2026 18:15:53 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 0/3] r8169: add dash/LTR/RTL9151AS support
To: Paolo Abeni <pabeni@redhat.com>, javen <javen_xu@realsil.com.cn>,
 nic_swsd@realtek.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260112024541.1847-1-javen_xu@realsil.com.cn>
 <eb4bf4fb-a1a5-4e4c-aa54-aef6b131ea2d@redhat.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <eb4bf4fb-a1a5-4e4c-aa54-aef6b131ea2d@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/13/2026 11:01 AM, Paolo Abeni wrote:
> On 1/12/26 3:45 AM, javen wrote:
>> From: Javen Xu <javen_xu@realsil.com.cn>
>>
>> This series patch adds dash support for RTL8127AP, LTR support for
>> RTL8168FP/RTL8168EP/RTL8168H/RTL8125/RTL8126/RTL8127 and support for
>> new chip RTL9151AS.
>>
>> Javen Xu (3):
>>   r8169: add DASH support for RTL8127AP
>>   r8169: enable LTR support
>>   r8169: add support for chip RTL9151AS
>>
>>  drivers/net/ethernet/realtek/r8169.h      |   3 +-
>>  drivers/net/ethernet/realtek/r8169_main.c | 130 +++++++++++++++++++++-
>>  2 files changed, 130 insertions(+), 3 deletions(-)
> 
> Note that you should not have posted this revision with the previous one
> still pending:
> 
> https://lore.kernel.org/all/20260109070415.1115-3-javen_xu@realsil.com.cn/
> 
> I process the patch in order and I applied the above before reaching here.
> 
> @Heiner: I'm sorry for the confusion; the patchwork backlog size called
> for somewhat urgent action and I thought your doubt for the patches
> posted there where solved. Please LMK if a revert is required.
> 
Patches are fine with me.

> @Javen: please wait for Heiner feedback about an eventual revert before
> any further action.
> 
> Thanks,
> 
> Paolo
> 
Heiner

