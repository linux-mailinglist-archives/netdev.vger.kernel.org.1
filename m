Return-Path: <netdev+bounces-200794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 643F1AE6EAC
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 20:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B6B37A5E64
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 18:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DD82DAFD5;
	Tue, 24 Jun 2025 18:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b="fu+Ej2Gy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8886A274B34
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 18:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750790102; cv=none; b=o2LfNSrnWrxCp7pBNqxtsb1D+l7gVymWbP6fGycmidBzUj3WmaRNfnby+DoVziuzyDa826pgZmSEYysbVtkSdmHDZZC07uGAgZLoeAQ1sgJCxzuwMRJFIEWf+eMqo8wqnM7IvTb/6+ZRcv4/Ty72QrN9LSg8kzwfLWCJ/IbcH3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750790102; c=relaxed/simple;
	bh=FyMtzf3UMG4zcdd6lXh07V5464nm4eugc84yG+n/pRQ=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ik9AGd5DDUe2eSXgareFPJV0m7GbTVVc3KbqvI21oAIAOHhVhMwHc6VJq7YGkULXxHW81WRbvDamRCJV+DuXkMPvXrVh9qmXyJ7t5I7d8kP+eCBRmps8BxA3kUmHJ0zLT7k9k2R7HASvb/I8m9JA3mLhiaKbZD8HE60LOfNneL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info; spf=pass smtp.mailfrom=jacekk.info; dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b=fu+Ej2Gy; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jacekk.info
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6088d856c6eso1531025a12.0
        for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 11:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jacekk.info; s=g2024; t=1750790099; x=1751394899; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+oUXxIfYOVwST5bWKMo3Tg1ykdOeL3eZDAJJuwYSVG8=;
        b=fu+Ej2GyfG1mCcMIkbl4CkQJDRdh4Xikk5OGNOxsV/tJqK5fR28gxVO3xsw0O/wo0M
         bjZ4JBBS6I58aBTgskj92xHCDSmScniJ6rvpjkGrgWkTpzcZFc8iqUX1DfXQOOlXZYCn
         lJCYWel0EbpKyBe+g2Ggx7yfLZPmU8ZdnxfmKYq262U3/jg0EiQ3NBH5Xzu80xWqNlqZ
         GVNXNZAS3DkDh1VT7NTDplBPjCeGLxSzl2UNLSqNZq3bEvMZ50oTGEGO38jl9eCU3Xu+
         UqOfj8FV7SWgOTNUzMyn+qhFny4OHos89TQeA0FyA8KxzHofdQ5dCxQFRRtGJ13r2q6o
         f6Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750790099; x=1751394899;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+oUXxIfYOVwST5bWKMo3Tg1ykdOeL3eZDAJJuwYSVG8=;
        b=tTEQA3+GrEpt3b0cQuEijHsNWEK1cpl0WRJiEzd7QmhXGwyywVcmV6pO3yuOcKTMwF
         4lgahaa4ssl3vHbjAN9G/S93UVA7kD49HyU7/G9nrVh7DZm8wSj2AYLACHaPtb7VFFD0
         jaGxUNXf8DHwHxDzB6frl2vOcBORSsyfhB4sBivZXf05fkrkdVjD12NZldhD0xciHxj7
         4nVWz12pR0RNHq5hy4Aa2Hl7Vp32pikWRamNxKcGxsRxulfDiVfnmooPBuJkcfOHkopd
         z9TnfcnwQJ8fxpdUrrG/H4gWvvTNHAafAtSSshpU/KbFCjWX0XcEALjR77HnmNhew4nK
         gOXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUk8s5qZa7l5fkhmq2DOrCdkQu4X+azn+0oyGQoih1hmShZ7mDZWj7leWLJmnYnunxaUg81bqs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwde/i81GbUQr2B7eeBS20XGcKhBwDAMVBXd7jTIebdRQdEoUm
	k9TeGc+D0L3Epi78zh+83wrPMtxUScHu43IjDkn6p+nxH8mcyCfAzN4GqF5ch0SGwQ==
X-Gm-Gg: ASbGncu9RZ3f8ATw6NCQDaZaPuaMl862ESyBjIrVrtIojG8MQyF70rclP8do7phWl6L
	HGahbQfQ3eOqXS/lwB+BkMB6ygcj1qAWhhPpZqh4WJGmjKOLRSk8A0lzVgTtDSQPb6WeRKywa/D
	Sx5PkSOmV1vnaUanaK6h24LspgdGLrDV9ZdXcPiKl1/ovE9BJlr8pvqAVbWDDhdutmDk/+1/xeW
	IzsSdUyoOBUEmJk4oV2UHaZhRKpmav6S/NwGZORpjfXB9wEyeRcjqUAAFfafcwm7FtOfFQFTUzR
	401ilgQe6HY4Ve3ITOqdijlExUnytxRDamA3lSGkbLrd54lo8Ra0izp98KAJl0jojRpXcQD8irU
	=
X-Google-Smtp-Source: AGHT+IF2Q7EXG3dh+dQGTwWFowwLHHyt4QaH8eo9c5nwntSUh27oaezGZyQ+fWjE9kDMnfbTjUYneg==
X-Received: by 2002:a05:6402:1e91:b0:604:e440:1d0b with SMTP id 4fb4d7f45d1cf-60c46435e1amr762835a12.4.1750790098337;
        Tue, 24 Jun 2025 11:34:58 -0700 (PDT)
Received: from [192.168.0.114] ([91.196.212.106])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c2f1ae651sm1380305a12.28.2025.06.24.11.34.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 11:34:57 -0700 (PDT)
From: Jacek Kowalski <jacek@jacekk.info>
X-Google-Original-From: Jacek Kowalski <Jacek@jacekk.info>
Message-ID: <e4903c9f-6b84-4831-8530-40ff6e27a367@jacekk.info>
Date: Tue, 24 Jun 2025 20:34:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] e1000e: ignore factory-default checksum value on
 TGP platform
To: Vlad URSU <vlad@ursu.me>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <fe064a2c-31d6-4671-ba30-198d121782d0@jacekk.info>
 <b7856437-2c74-4e01-affa-3bbc57ce6c51@jacekk.info>
 <8538df94-8ce3-422d-a360-dd917c7e153a@jacekk.info>
 <431c1aaa-304d-4291-97f8-c092a6bee884@ursu.me>
Content-Language: en-US
In-Reply-To: <431c1aaa-304d-4291-97f8-c092a6bee884@ursu.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> You are comparing the wrong value with NVM_SUM_FACTORY_DEFAULT. You 
> should check it against the checksum word 0x3F (NVM bytes 0x7E and
> 0x7F) which is used to ensure that the base NVM image is a valid
> image, and which in my case is left unchanged by Dell in the 
> firmware.

You are right that I'm comparing the wrong value. But it is only a 
matter of variable name:

-	if (hw->mac.type == e1000_pch_tgp && checksum ==
(u16)NVM_SUM_FACTORY_DEFAULT) {
+	if (hw->mac.type == e1000_pch_tgp && nvm_data ==
(u16)NVM_SUM_FACTORY_DEFAULT) {

Could you check my change with this modification?

-- 
Best regards,
   Jacek Kowalski

