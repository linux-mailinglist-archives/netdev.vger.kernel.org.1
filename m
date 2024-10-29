Return-Path: <netdev+bounces-139946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FF79B4C56
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 15:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3AD0B2381A
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 14:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEAD206518;
	Tue, 29 Oct 2024 14:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="X5LbThzo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2C2205E30
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 14:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730212906; cv=none; b=iDL64NeD+/y4nha+C8dC890AncPia0iXt0Aq15Kk+6YN1zZ/+p5oSWNS7vGjsR39vDNmuTK1hotQFL0yr+pF9/fEhfDkNNRohNnJrM7TQ1K49zeyozgJ1eyaX5GBNmsFvG01savKytVNWg1GkDMunQ6btlvB4J3ZJXr8zzG6rLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730212906; c=relaxed/simple;
	bh=bmi5h6ZQA37gMD5MB4TTr6wgvZS5AulQ5cVXmtRpHa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sST/xHLGTrc8bp2queH+3OToWGh89/odU7TgJ4aLsOvSeQQsfOZNC5IXjeI5JUw6mBGBhXHB2q34VERPZSnJrpzrapXWkvKy8lqQ8JXwIEnFDZVnlPJzjccXVXdO9SQBY9n2l3kBVwtKvo/vcLx725RaSsxMgFq8yMoWFmhHAsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=X5LbThzo; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4319399a411so42044405e9.2
        for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 07:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1730212901; x=1730817701; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hAEBAsKPjHOLc9MneqC9ZrgRHxYiYOgc+UGFxcF2YJk=;
        b=X5LbThzoCSBsu+w79JJgEX16G2v7QypshWO6pY9HHz+gb/L7mfkNcDuH2O/1IiLbcJ
         owa6fBL0zTNoWHRmh/PLiSMd4HmnoG8LXCav+NEYStalnxaGi4R3ykPnX26a0mEsaERn
         d9xZ6WIgbQrnucjhs5NVK/xsFYlO5oIb4kwRW5kJdGaXnJeW+NZuHoQ+bomdpCf3zTTi
         XuDEjLdcVbCMDJzIpQWxwdeTqiPScEneufLS+0VzlXNzSMCIBUbtLY2REdwJuGU0o3SG
         mVY8aucZ/Xfx16evppBL5TYevJgsExxGfpmuOocS5udAY0Y7VvB0/nM3f4hGYo+CgtLs
         a7Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730212901; x=1730817701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hAEBAsKPjHOLc9MneqC9ZrgRHxYiYOgc+UGFxcF2YJk=;
        b=QdY1RVF+/arwj6STDQE57Qiw9EG8oimfkyS44V9BYvxZSCquEx2E8RWNp9SmCTHSXC
         wPaV3WJcSXE+Ar1fiPLELs+q+/Iw4VVHI/JZNCmh/MlXWG+zwgRrghP6Ba80UfjoBk2v
         ZBrX+AvV0KvTjJUQRk0PYz0QMP9Cd8LqKMeLn4x1EKyKo3uswWb2N3G7yVPB54bMpKNi
         tc6uPa0sxP6S//1ah8b6JwZ/liH1pk6eUr3V+PG23eXe10Bmby2RSplimFr78S1qZ0Sv
         981Y6kHwbCTX3bzWOnoR9JFS9hewpWWBYZwxTyF20oDXNS1xpWwNkvszpKz0bPN6638e
         k1/w==
X-Gm-Message-State: AOJu0YxUE5kKkrZyIlsQXjjrIQWNG4WZjpu5CMTPk3+eIG4JL9NpwOz7
	hnIP/3wi3vhUdzMeh0V5vEKdn7UBIw8BJBe1F2da3ntIOyU9/vLPG/B5Ggynymg=
X-Google-Smtp-Source: AGHT+IEYarmqcmDJLmXtJIkWAWqgMXJBsOgKvq2V4mohdc2h01DTjHmgqpssPtJX+cnAO4CE5DbLOw==
X-Received: by 2002:a05:600c:3583:b0:42c:baf9:bee7 with SMTP id 5b1f17b1804b1-4319ac9ca86mr98028775e9.12.1730212901373;
        Tue, 29 Oct 2024 07:41:41 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b566f11sm175509335e9.20.2024.10.29.07.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 07:41:40 -0700 (PDT)
Date: Tue, 29 Oct 2024 15:41:36 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, donald.hunter@gmail.com,
	vadim.fedorenko@linux.dev, arkadiusz.kubalewski@intel.com,
	saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
	maciejm@nvidia.com
Subject: Re: [PATCH net-next v3 1/2] dpll: add clock quality level attribute
 and op
Message-ID: <ZyD0ICz79VRiDIv6@nanopsycho.orion>
References: <20241014081133.15366-1-jiri@resnulli.us>
 <20241014081133.15366-2-jiri@resnulli.us>
 <20241015072638.764fb0da@kernel.org>
 <Zw5-fNY2_vqWFSJp@nanopsycho.orion>
 <20241015080108.7ea119a6@kernel.org>
 <Zw93LS5X5PXXgb8-@nanopsycho.orion>
 <20241028101403.67577dd9@kernel.org>
 <ZyDafILiX4bFEfBI@nanopsycho.orion>
 <20241029065129.503f51cb@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029065129.503f51cb@kernel.org>

Tue, Oct 29, 2024 at 02:51:29PM CET, kuba@kernel.org wrote:
>On Tue, 29 Oct 2024 13:52:12 +0100 Jiri Pirko wrote:
>> >I thought clock-id is basically clockid_t, IOW a reference.
>> >I wish that the information about timekeepers was exposed 
>> >by the time subsystem rather than DPLL. Something like clock_getres().  
>> 
>> Hmm. From what I understand, the quality of the clock as it is defined
>> by the ITU standard is an attribute of the DPLL device. DPLL device
>> in our model is basically a board, which might combine oscillator,
>> synchronizer and possibly other devices. The clock quality is determined
>> by this combination and I understand that the ITU certification is also
>> applied to this device.
>> 
>> That's why it makes sense to have the clock quality as the DPLL
>> attribute. Makes sense?
>
>Hm, reading more carefully sounds like it's the quality of the holdover
>clock. Can we say that in the documentation? "This mainly applies when

Yes.


>the dpll lock-status is not DPLL_LOCK_STATUS_LOCKED" is a bit of a mouthful.
>I think I missed the "not" first time reading it.

Okay, will try to re-phrase to avoid confusion.


>
>Is it marked as multi-attr in case non-ITU clock quality is defined
>later? Or is it legit to set to ITU bits at once?

For non-ITU as well as for possibly advertizing quality of different ITU
options (option 1 and option 2).


