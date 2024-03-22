Return-Path: <netdev+bounces-81257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A4E886C21
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 13:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1096AB236E7
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 12:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77AD38FA3;
	Fri, 22 Mar 2024 12:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PXiBX+fd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB661E892
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 12:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711110754; cv=none; b=l/Mf7j5gjBBcxRsLlQSA7RiBF+k6Ww4jCEZOSF218PGmX3OmgSBYSszxYb/6csIZsfoJs1WEhJ6U/BtBr2c2q+bum+AuwAy3kT1PqoKDL61W7eMItjon2faM/eymX0BxxDPbSHnOjpVnlZZkl4Jw4scLcsWn7bzlh+c+AXcQMng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711110754; c=relaxed/simple;
	bh=MSth3NUJYhCxQqw8nX3MWsVkHAIF0iMGn8NhujNAFT0=;
	h=Message-ID:Date:MIME-Version:Subject:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bwm0ssAuXWwyh/ZsUR5EzlaP42N+82AboKadn+TC5ORGhgt5YDWFE7FvWE6Fb+4HKbcqpZsv7fZQqS1UZOz3P0The3MN19Jkn+ErPgNYbeWbgTvcKXMvLjwJMW38VUTzxX66K4qca1avIt0AYcdBurMXpxCFRpTMtpo57kZH2Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PXiBX+fd; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-515830dc79cso2270594e87.1
        for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 05:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711110751; x=1711715551; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5ACWCBBBDQsVgE9tJrsRZi6E6Z9JJQgSatT+1My1XZ0=;
        b=PXiBX+fdnNoGrH43hkWKU1r2bkigdaKnHdTyN+Egyb6TfsTOfXXSpLIGLGNtuI/6NV
         uyYy/8y7wDLYc27MHWUIwY5u6PpwAMW9hwjjfJG5cCadPw0J8uARb70MVSXStZQMQTUT
         A/iXaFKGpsMFJZwCUVrc8ZWtKiKQU9NQ/YKsOeLBpDnSzMtIUi/+6e0B2sBVAGsdpXXZ
         mmjLFOPzJ9gQoarPPWX6RNok5rXNyfxxgta88Zz/E2V3AmGfrTeFgmwTrITJZSai2sUa
         mw06U0F4Qv4/FI6iuQKvtRZgoirqEqtavdY56gVAOppYv0xfS1+QkHdSwnON7cBjVTYT
         wyVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711110751; x=1711715551;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ACWCBBBDQsVgE9tJrsRZi6E6Z9JJQgSatT+1My1XZ0=;
        b=JXaHnd8AIi4uGtrLvGfPPt7i5bcR7PDOVb9YajqYoVNC6JLQg/bazdUqT0U4cRXP6S
         0Iy5dya49hLAfxAqgd8kNtNuFT4CPC8KtS288mDq1E2syFnv3PkoPLrzb7+idT5XAvjI
         6SIvg4TD4OvQ4gMhihdzJiUE+p3bHr5uM2vWpN2i67QPOSlhVDKlSSrKIUA1gFRlo/DH
         XgbRToMo+Ond3CIn+YQET6z7DSOmkGv1sdnpqNJTzab9yiJa6ZoOhL8of7kNWBrlNByQ
         7A5FAcoPVTiijGRDcBMEftIooOUg1iPjCDvY4RoG+A5h6Onuo8Sq6Oi3hmE+Amum0hIO
         Zk4g==
X-Forwarded-Encrypted: i=1; AJvYcCXoq8Ezki0SKNx0yq4bnsM+8AVxBUborFw13m9VQXw6WmDDt3PL6DL4RqmOoy5Vvfp1uKu/yorMXl+IrJ5APGgXgSdzqWHc
X-Gm-Message-State: AOJu0YxJbbrkJ9scttgDKI6E5Itz1DSE3iUrEh0E02lRjahoKO6BkB2d
	i9WdsZvqEbJXBsfOsaJRhEoHQ7nkc2gptrS6Kx31Vf+bXtZLVn4UZMnpVYpH
X-Google-Smtp-Source: AGHT+IFTNRBW5IivMBoLyLvNOBlY2+x9P2QFM2IomF4Xiyjhhm6HwuIVrA0ZTCS2vLw6yk0kQ5JRSA==
X-Received: by 2002:a05:6512:529:b0:513:af26:8cd0 with SMTP id o9-20020a056512052900b00513af268cd0mr1628632lfc.68.1711110750998;
        Fri, 22 Mar 2024 05:32:30 -0700 (PDT)
Received: from ?IPV6:2a01:c23:b9ee:2200:3c84:d0e4:1607:95e7? (dynamic-2a01-0c23-b9ee-2200-3c84-d0e4-1607-95e7.c23.pool.telefonica.de. [2a01:c23:b9ee:2200:3c84:d0e4:1607:95e7])
        by smtp.googlemail.com with ESMTPSA id v22-20020a50a456000000b0056bb65f4a1esm1019410edb.94.2024.03.22.05.32.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 05:32:30 -0700 (PDT)
Message-ID: <99d1e399-16bd-49fd-9fcf-4db6fc029780@gmail.com>
Date: Fri, 22 Mar 2024 13:32:32 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: r8169 DASH-related issue
Content-Language: en-US
Cc: atlas.yu@canonical.com, davem@davemloft.net, edumazet@google.com,
 hau@realtek.com, kuba@kernel.org, netdev@vger.kernel.org,
 nic_swsd@realtek.com, pabeni@redhat.com
References: <0dee563a-08ea-4e50-b285-5d0527458057@gmail.com>
 <20240322104955.60990-1-atlas.yu@canonical.com>
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20240322104955.60990-1-atlas.yu@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 22.03.2024 11:49, Atlas Yu wrote:
> On Fri, Mar 22, 2024 at 6:16 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
> 
>> No, this only checks whether DASH is enabled.
>> I don't think is redundant, because the original change explicitly mentions that
>> DASH fw may impact behavior even if DASH is disabled.
> 
> I see, thanks for the clarification.
> 
>> I understand that on your test system DASH is disabled. But does your system have
>> a DASH fw or not?
> 
> I am not familiar with DASH, my system's DASH type is "RTL_DASH_EP", and I have no
> idea if it has a DASH firmware or not. I am glad to check it if you tell me how.

I don't have access to datasheets and can't tell. Therefore I asked Realtek to comment.

> My patched r8169 driver and r8168 driver both work well on my system.
> 
>> My assumption is that the poll loop is relevant on systems with DASH fw, even if
>> DASH is disabled.
> 
> I know your concern, but in my case it is wasting 300ms on driver startup. Maybe
> we can find a way to avoid this together.
Before applying the change I'd like to ensure that it doesn't break anything on
systems with a different DASH setup. So let's see whether Realtek provides some
more insight.


