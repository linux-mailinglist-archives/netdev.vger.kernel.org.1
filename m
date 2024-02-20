Return-Path: <netdev+bounces-73173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 717CC85B3F9
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 08:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 123AF1F2455C
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 07:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5E22C86E;
	Tue, 20 Feb 2024 07:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="SQ1v54XR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3D65B5A5
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 07:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708414084; cv=none; b=kVlJ+VSukhYFCIN+osAPcTOOgVD2M3PLjKE+B9u5MBtOoGY3U0vCGDndsSdD6eylyKQrGFOjb9Iw+39teIV28fu82ttQXWPkNG5X7GRF9G8vSvu//U81Nz+WwqwSZYWmhrYE8igRpRTYzK2SBvavikZDj9uzhu6zrrzaL81v8hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708414084; c=relaxed/simple;
	bh=gRyK9MEt8enXL4csjVHA5vxW3iLXF8eWZRe2umokJBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hYzaf0bAxv589ZPJ4NDBxGBFgDJduLl/ovHO5M3re/E/sGbx0aF737m1fN2Pt4WiNYP7tZ1f8lKDWbB5J0Dx7VmA/IUek5HMc+cHJeez2jtb6TA5q9Tn/ukbOl6YsehmUFGKBORIzGwvefABYz6uRfrIzL9Ic/2pVkiO8HQPZDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=SQ1v54XR; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a3e7f7b3d95so229158166b.3
        for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 23:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708414081; x=1709018881; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WOgAsZGtiEwrt1qoYyQg2TJYsouO2y4Q21AuzuU4q7M=;
        b=SQ1v54XRJ4ICgs22lVxPEThxRxM8fNBBTo7OiXsUFRrEiMA/ktDFGi4zP0cceyRd//
         pjw7FFUYDUzitWbGO1Xcsw1Vi4ZQyrq6fCBe0VkKnM0cbIObbQQ+saPvjKTUQWy5Rwgs
         e/V3Ys+hiZPAKLXFLjAX7TxvXAJfhDt0Jsry6Q6jBgAROLgYTgy7DgGQ1sIC6hQ8/w4N
         Sj8QQzbVgKFrtnxfZ+GQK0jyuKm4ChI3wly9ISbHWPyiVanc0fSLvlemnugAxSJL624b
         E8Lu57JL/XoWtTqOiKSLbYqWvPiUlIpst31V3OxNNiwJuG7nNAx3NXGWayf6h5fnRr16
         D25g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708414081; x=1709018881;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WOgAsZGtiEwrt1qoYyQg2TJYsouO2y4Q21AuzuU4q7M=;
        b=VjFQUtSTOZGTUKxCsndNgsgUSFWKBsKCDUAJQFz3ydeJy99eIr4rQ/Ak44yIuAplcM
         C2HjxcU7hlL1kyhXhaALczCWVRgyWP1SptnP0xNRFuM5wY0jXNeXJo7QkffkG+GgENqR
         GuTzTMqsLMOt1T4X0kD9QTQ3iM+h2tyWftSG0Yo+HVfQnh/heHop3TPaIBaw6kPQ7wrx
         bjEM4x4h3NZnANlQihfw40QwSmHHOrzIN8D6KvhA68tVtPqfXTXzUL2j/RBuXAdSp+nq
         pKektiMqC/WZMK5VfxD59N2fqhqbIDrQ25QE1DqCo27pY7l1RiuEewaFjcLljWzb/aYi
         D4xA==
X-Gm-Message-State: AOJu0YzCWYDpeT6YviRHOs0NrnJoFLIdWTsr5ocDETOAdnWG907T+iTo
	Jkiyafehcb/Hm4Dn4kiTq78h3J3YegOUMvxeVkZUJ8sSm6msbWQEmW+qKVzBH8U=
X-Google-Smtp-Source: AGHT+IE2Vm4pB5pZ5VVTkr0W/PSNISZXxezZwTVTSIp1GqdJxypfMjGIBT3S5Fsp0kxtReTOK5Pk1A==
X-Received: by 2002:a17:906:d0c5:b0:a3e:b952:3571 with SMTP id bq5-20020a170906d0c500b00a3eb9523571mr2827897ejb.68.1708414080960;
        Mon, 19 Feb 2024 23:28:00 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id x19-20020a1709065ad300b00a3e786d8729sm2172348ejs.168.2024.02.19.23.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 23:28:00 -0800 (PST)
Date: Tue, 20 Feb 2024 08:27:57 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, jacob.e.keller@intel.com,
	swarupkotikalapudi@gmail.com, donald.hunter@gmail.com,
	sdf@google.com, lorenzo@kernel.org, alessandromarcolini99@gmail.com
Subject: Re: [patch net-next 03/13] tools: ynl: allow user to pass enum
 string instead of scalar value
Message-ID: <ZdRUfZMRvjMlDqtX@nanopsycho>
References: <20240219172525.71406-1-jiri@resnulli.us>
 <20240219172525.71406-4-jiri@resnulli.us>
 <20240219125100.538ce0f8@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219125100.538ce0f8@kernel.org>

Mon, Feb 19, 2024 at 09:51:00PM CET, kuba@kernel.org wrote:
>On Mon, 19 Feb 2024 18:25:19 +0100 Jiri Pirko wrote:
>> +        if enum.type == 'flags' or attr_spec.get('enum-as-flags', False):
>> +            scalar = 0
>> +            for single_value in value:
>> +                scalar += enum.entries[single_value].user_value(as_flags = True)
>
>If the user mistakenly passes a single value for a flag, rather than 
>a set, this is going to generate a hard to understand error.
>How about we check isinstance(, str) and handle that directly,
>whether a flag or not.

Yeah, I was thinking about that as well. But as the flag output is
always list, here we expect also always list. I can either do what you
suggest of Errout with some sane message in case of the variable is not
a list. I didn't find ynl to be particularly forgiving in case of input
and error messages, that is why I didn't bother here.

