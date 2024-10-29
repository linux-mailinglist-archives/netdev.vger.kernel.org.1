Return-Path: <netdev+bounces-139925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 833D39B4A2D
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 13:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6C7B1C21554
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 12:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0190D20494C;
	Tue, 29 Oct 2024 12:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="v9eF+K6z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3107E1DE3B7
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 12:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730206340; cv=none; b=LnDa8TZDM6/kyy2JIJArhYKNrp4LPkCes8K3brrccug5DI8jYgX4HUWx6dhNQ9zorwvvVqZm5ilcci1TsReqhVsmng2rJ0dvP+gYg+yiD42JivceDZbX9c2foJEWz3o8ojhuz/gJOqmyLn7GtdMH38F8QaeGQILdnNxfs18B0D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730206340; c=relaxed/simple;
	bh=PaEFX8UKGmPlbEKFCW9rjcCKME3RDjMyJV1WBpoxrgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uqIJP0H3wfV0JPJpiUVovjLb+xa6vX3wbMqze+TAB/Gvkun9kLeKCMEipXhuTYoyJyqsaciQPw0kSWg09xleIXClhsXkwvaIdNMFV/pkHVKNK2Ip3XwDGbPHLRAlOjA4fxtkmWNzZzEPn4AZiAyPW3+nRZ/uxJgkW3NfvTrUcKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=v9eF+K6z; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37ed7eb07a4so4250211f8f.2
        for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 05:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1730206336; x=1730811136; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6lKoIiyJjp9MckQIeqD2S245I4EABWUXXAKp3J0a3MY=;
        b=v9eF+K6zmHhmFYfgTzP5tye/8QgrK///wiar/Ftucwtv/lSg4vFq/Gb0uKnrMGF3N+
         BrZyMjdYT5Prm01BLeXN3OAk8yVX0dIf1toLYjgoI8S+Sqq0CUivLhBrbitPYDwmwyT1
         vkXsJ58HjFYE6VJ/X7wXZHaELMvecKo4GDNB15fGHgiftp3P0bd1IfmI9crqBFc1fmtf
         Wd2y39rkJcaJdgqtr3l33LOOgecb7547FNQqY//6TFpqfQ/rRSSy3/UiKFUPucLEl9Tb
         ghp7GHC2G+QoLGJucHLBdaTcoc+6KRimHozP5mBRO+GYFMjV0qRP4q1zQmJGWLNDx6s3
         rgEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730206336; x=1730811136;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6lKoIiyJjp9MckQIeqD2S245I4EABWUXXAKp3J0a3MY=;
        b=MgtCLzpaEVEeGNPN7GlLAR/JMSLUrtpcyOVlmacXBJAigTPfxfdIAJwtvkrrRJw3i9
         7DejXp31htjYdB78fzxIr1EGsjj+rzX6ObZ+AgMy3yFBi/DRRB8pMlb3f/ECD3sZCG10
         ik/swCkhL1j1JMEdTf5OTQd6LbwKYGOB2mG40PGg2gMhWbWr7MCmbQRPx3OGD7O5PQJe
         fafTHo94zLS0urX0Zzr5IfkXMBAvigMJsOwbIrYiia/1DMgfUH/JNsROUO5Wda6vpBN0
         SFzYk5WVoySUb8tO0sKdXxDu+Qn6YnF+AFKcW7Gu1SX5LAnc5cJFh1K48HqwHUDOEnBt
         OfWw==
X-Gm-Message-State: AOJu0Yx4hSL2+yRnD2S9DUZeHE+1zgouatBomSxHpOjAs1/6yUNIZHBi
	Aru5k1WvDotNhXy50Ix341c+i4u3ScELLbAAmMHDj7Cw6cFwuiXddJ9pfXyQPr4=
X-Google-Smtp-Source: AGHT+IGzb3vOS8AxsOpotUP/o0c40F+7cK4MbHKEC2eK+0QlfsaYfHCPN/oxE98c6CH72ss93ycVSQ==
X-Received: by 2002:a5d:68cf:0:b0:375:c4c7:c7ac with SMTP id ffacd0b85a97d-3806121ff60mr7698339f8f.49.1730206336171;
        Tue, 29 Oct 2024 05:52:16 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b542d3csm173398665e9.9.2024.10.29.05.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 05:52:15 -0700 (PDT)
Date: Tue, 29 Oct 2024 13:52:12 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, donald.hunter@gmail.com,
	vadim.fedorenko@linux.dev, arkadiusz.kubalewski@intel.com,
	saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
	maciejm@nvidia.com
Subject: Re: [PATCH net-next v3 1/2] dpll: add clock quality level attribute
 and op
Message-ID: <ZyDafILiX4bFEfBI@nanopsycho.orion>
References: <20241014081133.15366-1-jiri@resnulli.us>
 <20241014081133.15366-2-jiri@resnulli.us>
 <20241015072638.764fb0da@kernel.org>
 <Zw5-fNY2_vqWFSJp@nanopsycho.orion>
 <20241015080108.7ea119a6@kernel.org>
 <Zw93LS5X5PXXgb8-@nanopsycho.orion>
 <20241028101403.67577dd9@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028101403.67577dd9@kernel.org>

Mon, Oct 28, 2024 at 06:14:03PM CET, kuba@kernel.org wrote:
>On Wed, 16 Oct 2024 10:19:57 +0200 Jiri Pirko wrote:
>> >> Not sure what do you mean by "clock info". Dpll device and clock is kind
>> >> of the same thing. The dpll device is identified by clock-id. I see no
>> >> other attributes on the way this direction to more extend dpll attr
>> >> namespace.  
>> >
>> >I'm not an expert but I think the standard definition of a DPLL
>> >does not include a built-in oscillator, if that's what you mean.  
>> 
>> Okay. Then the clock-id we have also does not make much sense.
>> Anyway, what is your desire exactly? Do you want to have a nest attr
>> clock-info to contain this quality-level attr? Or something else?
>
>I thought clock-id is basically clockid_t, IOW a reference.
>I wish that the information about timekeepers was exposed 
>by the time subsystem rather than DPLL. Something like clock_getres().

Hmm. From what I understand, the quality of the clock as it is defined
by the ITU standard is an attribute of the DPLL device. DPLL device
in our model is basically a board, which might combine oscillator,
synchronizer and possibly other devices. The clock quality is determined
by this combination and I understand that the ITU certification is also
applied to this device.

That's why it makes sense to have the clock quality as the DPLL
attribute. Makes sense?

