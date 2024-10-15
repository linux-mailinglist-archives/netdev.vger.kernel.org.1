Return-Path: <netdev+bounces-135712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 673E999EFC3
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 16:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FF4F1C22C1C
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 14:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10881C07D5;
	Tue, 15 Oct 2024 14:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="QvzI/Nms"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B51E1C07F8
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 14:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729003140; cv=none; b=GMeXLlWg3bYP5IZY2y8WiTy4xFBA3IkMHFdWDmMuH0n9WX1TL2JjTLQVDDjXVVdN7JpkDfacNKNPprmG8d2M6e7l5XMK/I5bnF/8JDJiVlORYLBfPhIse2LYSCyA7xn1KItA7htoz5obY9W4Wmw34S8YZC3tkRNnrYyOHL56bl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729003140; c=relaxed/simple;
	bh=YbsVtXEiED/jTCHWmuNL+zSTdO8cwPAod/bXjHRXX0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JRqHnrRirunAt0Qsi43CWt+TgrT8Uj6mlw6ch+yv1FLp/+xYxPfhvkgrwcIoxx7nZAU70WIW6yEMiX3QbCZjudUe/9PezZkdjaUwBdAIivvMQLRQTpRZU21ps4Mw838pKeE0uKOLICv6WVDK6Ft1IV8FFRprooEeTXqflcva4rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=QvzI/Nms; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43144f656f0so5050675e9.0
        for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 07:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1729003137; x=1729607937; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b9CY3DmJi21ePtprvLNUEQjnzqvnCFzd63MfErkeA00=;
        b=QvzI/NmsgDilIvKSUzbBiqLophvoMhIx/bTb0gDsegn09RiGdNOlMxhw5pfDgN41a8
         AF86Jta8/BrIzHe5Iz3b4ldLGMTtzbfRRGEbXtK7SOf3nqUlV2hToG8GVVt+DTlGY8QP
         3znEG3X0Lz2B9slX4tqIhlVtPzcDC3U766mLGk+imfGhWDB3FDCglmFFWhOp2PGlLT8L
         XdMsZuLNPSgA/MDaEjSPcRqoBJqQsQY+d+7DYDCFhyiuU6NPGOKgOGqceCGpLA1wTB0g
         xi4KBJOXR5nvM5X9NY7fFes4yn5+6xGLQmeIb4Y0/WcHBsqEjAHZRS9aRToTojRh7Ekl
         B37Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729003137; x=1729607937;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b9CY3DmJi21ePtprvLNUEQjnzqvnCFzd63MfErkeA00=;
        b=rezihE661n8G9i+lwZ3K5OS3jxboQIKrf/odfro1ChgIN1LRtVaVui39qJhjBYi/BV
         Tertjp0wd7OdCbD9SSip9H4dW8DNZ8FAzyTdydBM78bJye3Gpyot79g2YD+I+5h6TlTe
         mjyqmIEa8+0Cn5zpGVOL4FIzAQaT2tIFSS/hfvx0Ip+X4yQCX3zeN2Ee5aFNJp2ke79V
         LETkqHj/Yv3iSawnTlF2X3guyS2/9mmBtZYvRa9Bbd4Q448kuTgnahw5efdqbN9A09Xt
         orvfbGxIm26i4CxMfy2NR4GAYjzVWLZR5bPXOeE7OMZxNHhxh8bjniFr3x0M94vZRENZ
         pD0g==
X-Gm-Message-State: AOJu0YwAg2AUO/UewuklFadfv+ocgmJCK9GeCvEps25nmaUSuMIlQ3wW
	ODufpa3FbYHS7jAgiCVTViDgXhICrUboUeEIci8hHNeNnUfsnWhwBx2rdqhQb9w=
X-Google-Smtp-Source: AGHT+IFuGggl8bnvYtKvJ8OUc9LH8lctz9So27l2hsRT0WK3NoFg1exzL/fFJB/naGN1Do9tVu3DUg==
X-Received: by 2002:a05:600c:3ba9:b0:42c:b52b:4335 with SMTP id 5b1f17b1804b1-4311decaa31mr136500875e9.10.1729003136622;
        Tue, 15 Oct 2024 07:38:56 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa7a23csm1750861f8f.18.2024.10.15.07.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 07:38:55 -0700 (PDT)
Date: Tue, 15 Oct 2024 16:38:52 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, donald.hunter@gmail.com,
	vadim.fedorenko@linux.dev, arkadiusz.kubalewski@intel.com,
	saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com
Subject: Re: [PATCH net-next v3 1/2] dpll: add clock quality level attribute
 and op
Message-ID: <Zw5-fNY2_vqWFSJp@nanopsycho.orion>
References: <20241014081133.15366-1-jiri@resnulli.us>
 <20241014081133.15366-2-jiri@resnulli.us>
 <20241015072638.764fb0da@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015072638.764fb0da@kernel.org>

Tue, Oct 15, 2024 at 04:26:38PM CEST, kuba@kernel.org wrote:
>On Mon, 14 Oct 2024 10:11:32 +0200 Jiri Pirko wrote:
>> +    type: enum
>> +    name: clock-quality-level
>> +    doc: |
>> +      level of quality of a clock device. This mainly applies when
>> +      the dpll lock-status is not DPLL_LOCK_STATUS_LOCKED.
>> +      The current list is defined according to the table 11-7 contained
>> +      in ITU-T G.8264/Y.1364 document. One may extend this list freely
>> +      by other ITU-T defined clock qualities, or different ones defined
>> +      by another standardization body (for those, please use
>> +      different prefix).
>
>uAPI extensibility aside - doesn't this belong to clock info?
>I'm slightly worried we're stuffing this attr into DPLL because
>we have netlink for DPLL but no good way to extend clock info.

Not sure what do you mean by "clock info". Dpll device and clock is kind
of the same thing. The dpll device is identified by clock-id. I see no
other attributes on the way this direction to more extend dpll attr
namespace.


>
>> +    entries:
>> +      -
>> +        name: itu-opt1-prc
>> +        value: 1
>> +      -
>> +        name: itu-opt1-ssu-a
>> +      -
>> +        name: itu-opt1-ssu-b
>> +      -
>> +        name: itu-opt1-eec1
>> +      -
>> +        name: itu-opt1-prtc
>> +      -
>> +        name: itu-opt1-eprtc
>> +      -
>> +        name: itu-opt1-eeec
>> +      -
>> +        name: itu-opt1-eprc
>> +    render-max: true
>
>Why render max? Just to align with other unnecessary max defines in
>the file?

Yeah, why not?

