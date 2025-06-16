Return-Path: <netdev+bounces-198128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC615ADB579
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 17:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6139116492C
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 15:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D355521ABAD;
	Mon, 16 Jun 2025 15:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nePWQP+e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278447D07D
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 15:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750087950; cv=none; b=DzjjgR+wezLWP2Q7jBU2pLBYNPLHYZUOAY/Dv4mCopYaJg5WJxRsaYJJr7vLCyMGrt4SL66X35KHFUKbYlvo2VoVT6/f+hIlTSFjfZGfIJ/0lbZjrBo4QwGuDDdRr7AjyYH4lBmc4N1j9CZUVgom69TzDvPMKvyBOCfHGuO0k7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750087950; c=relaxed/simple;
	bh=C6QPic8D5Dr50NLEToijBW2WnLlcIvUtBHNraPM+3Y0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ji1h8P4SdyN9i0kqiW2BjBVMN2CJrFYXzwGDLPU4dYERa6cWMCY1IeELKf9Hk6Pc+HeTSx6rXzFGd3OnClBblOgP+96vU0SXINshfvOifbJ6FZyyqMt0WF3EKWF8du5/Q64lYYpFWAlCKLz9VNj1NWPuukw3cfA9zQUwV0I6xKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nePWQP+e; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4530921461aso39809235e9.0
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 08:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750087947; x=1750692747; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b9ECxgnlBEPN1ZzmbVKIFZnjMrIIq7xUCsgOdWC4cAE=;
        b=nePWQP+enhtOFlz3YI7PWdLhXwJr/Dy0NsenpnPtXmT6JNjXr98+0odHzsW9avtb5u
         3YKoW8+DILjE8r48f4E9IJYD8i+ufo0k6e50Q6KOV8nnBobKb09s8PRKu7q8utj+3Kvq
         Gh5ivLLxuc5nbZFDX32Z7RiVPJFR3SL0X8u3SP4Yr5uEuk1o/WEvRD4Pnv2OSo9ZWc0W
         XsPH/48nGQPMDnT7Sr3+sihYoTI7rROhI36A1qWg5vG6gur09AwpXpYKR8LCokR1HYal
         orEvwY3o96O1IMXNMhLkP8de6M+4ITg42p37OYzmIRJU3onOgTmYmIGr0kzUXEK/4HNX
         acrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750087947; x=1750692747;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b9ECxgnlBEPN1ZzmbVKIFZnjMrIIq7xUCsgOdWC4cAE=;
        b=srLQJBIRD9A/VEQ4YXkS9+qg9/iizdyU4WKXiJvxBIHFoyGZFoThfwCRX0tB3zrOxg
         yylJi3gt/tFLzhnraS2XPxzepggN2+4etVaX4To5+7T3Nv9jRNm+5WnXIFsq7L9waKUR
         piQtlhtC1q9vZfFXkeuzG0NMB04oXeVexwkU94/niavdjvs5b8d6KSgX3JVsq8n2ySWV
         UvzgFj04JDYjt77XI/m8ZJGMqV3bqAe3C0tjGjm9LmSYNIPtAv8MExSxb7zWreOshOOU
         8uDkuNZQGbjB20s5NH0Bw0QR0hXHJ7l9uH9Fn9YmDSMD54l4eXnPQ6ZcUbr3Qi4Cu5PL
         hfCA==
X-Forwarded-Encrypted: i=1; AJvYcCUVgc9MlHD3v1LU1nLc0a5fX/OGJr1FmxkCyQRSAkVsjvaqWOhM9Y4vCVwLdvknJTWnyXdyxrU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzauJSGoAI9GyRxjFbW9wV+fZTLe/29mEw9PFSe+AHC8/doKTEN
	1PtpviroXmZGHOozc7UcIp8T/dvfuJvx2AOnYo5y78lx9lBdF/EaLSJQ
X-Gm-Gg: ASbGnctkUqcBszceeG9qXdZJFUVJytE85JFfaoF19C+hn5Hrlfuh2OXAW2Cmvy001k/
	wegy/F5jq0/QkV5PvfnykTxqopGZvrl6a8pzQp22nxIM2TRnMn0BWmcR26DOAME6Hhwz/hfqWlV
	g7HoFyeF17itljxeYdHD4aJ4CuTHh5K77TmfdGG2QqUQpBUS9N2T7Q6LS/gvTwBR/F6KbVbfo6q
	08EWIu689GpXSH0Mwy7T9yPx/MIVFfjPeb89S8zHu2Q+F2tS5ieLvZPVdnQhQNdFLBlk6MtY3Gt
	tiApMrJAs8iy525l4r0QlAQ1JA/Qtkq/iCO9CbvCoWFlgA0ymNpambnzBa30Q5cNKE5ajcTy8qw
	BFSo4dw+AKmYCMhbkdVwjJBNK14v19WMl4s6GaVKzz8rWLfijXg==
X-Google-Smtp-Source: AGHT+IHkq8LrLQrzxsyZlo9tlv7aQOJfSxIwHgrNYLkM2fTsGTC8YWwjLvcQgoK3b9PbquhF+UHucQ==
X-Received: by 2002:a05:600c:4ed1:b0:453:78f:fa9f with SMTP id 5b1f17b1804b1-4533ca510afmr88788005e9.11.1750087947230;
        Mon, 16 Jun 2025 08:32:27 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a6078csm11245581f8f.21.2025.06.16.08.32.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jun 2025 08:32:26 -0700 (PDT)
Message-ID: <98a48c7b-539e-41b3-ab3c-e2398401c7f7@gmail.com>
Date: Mon, 16 Jun 2025 16:32:25 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 6/6] eth: sfc: falcon: migrate to new RXFH
 callbacks
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 bharat@chelsio.com, benve@cisco.com, satishkh@cisco.com,
 claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, wei.fang@nxp.com,
 xiaoning.wang@nxp.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, bryan.whitehead@microchip.com,
 rosenp@gmail.com, imx@lists.linux.dev
References: <20250613005409.3544529-1-kuba@kernel.org>
 <20250613005409.3544529-7-kuba@kernel.org>
 <6425933b-3b17-4509-86be-be4a75f12e17@gmail.com>
 <20250613075010.0b59564d@kernel.org>
Content-Language: en-GB
From: Edward Cree <ecree.xilinx@gmail.com>
In-Reply-To: <20250613075010.0b59564d@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/06/2025 15:50, Jakub Kicinski wrote:
> On Fri, 13 Jun 2025 14:44:40 +0100 Edward Cree wrote:
>> So granted that you're only moving code, but looking at this it doesn't
>>  actually make sense, since every path that sets info->data to nonzero
>>  also sets min_revision, so why not just do the ef4_nic_rev() check at
>>  the start?  Answer, from git log spelunking, is that when this code was
>>  shared with Siena, EFX_REV_SIENA_A0 supported IPv6 here.
> 
> Ack, I was tempted to clean this up, but it felt slightly outside of 
> the objective. Looks like I need to respin for enetc - I can change 
> it in v2 if you'd like?

I'd say just keep your patch as is, then I'll send a follow-up that does
 the refactor and also adds a comment about why the hashing config is what
 it is.

