Return-Path: <netdev+bounces-231021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4250BBF3D1E
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 00:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B0ED18C5585
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 22:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C77B2EBB8F;
	Mon, 20 Oct 2025 22:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="f43cV1wJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1332EBDCB
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 22:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760997740; cv=none; b=tGC5sOdqA+KegMGAF0dshaxBeSQ+04H1lthtznAU473mI3E7z4k5fPUXYsDbSuMbCa3mJL/gQbY14U9MWFBI0g9bPPYeqCN7HgierMoKuo84NUoOtB8ATblSgMCFo23FnIDAR1d9N+XfRqtYexQpzo/mCIjSiWSTCpvUFzwT/K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760997740; c=relaxed/simple;
	bh=g84O5BBHxizBzlTbx0ENCKIA1qgZHwTAxI+AXD4hRmE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kpwx9uKg3qccbfuaj9bAl4WnyOXqydUTR9h3h8S5VogG+CeGbk/5Mf4XU93Lr8WsOxhNSn3DesHVgXqYCGdGVMMY8raxSd8IED6zkZSFN/yKHZPlMCjUohMPHjBPC6/bjM79i5yS3ITNh6J80dQD6DT9SX5u/7Gbh4zfXJnFGBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=f43cV1wJ; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-33ba5d8f3bfso4222759a91.3
        for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 15:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1760997738; x=1761602538; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pGC4lUtZkCybSPABd3uFIGUFJMNEDwCb9SB1IGRtFls=;
        b=f43cV1wJ0wD9bOozHx6QDqZdd4Mjx7TlaJBZ2YPlFTMbY5ka9lXgPegeH5wHFAyhBs
         o9eZgBH9xU5fSAXMLzN5UjYr6VYFQeoyHYycHdHGMWyLul6gCKluhfMnlBOovtZbGtNS
         cG7TvCzeKMZI5mtvInhMqt9mPBVfvVRMpLASmuUAhUr+044xu9wF0ab4zaARBzvOcVjZ
         bHhC6YAlHxYkrWEeseYapPvqKI+v7wRYWZRvFTq7NvBYecY8U0fKyqF3u0biieBxlPfm
         FXWXq6TOShj0OEhyvcNIeKi7HE2gB8fGItk2w2b7eS6e7qw24e3UNLzXM1JUcIzm0ksH
         61gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760997738; x=1761602538;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pGC4lUtZkCybSPABd3uFIGUFJMNEDwCb9SB1IGRtFls=;
        b=AzjNX99Udp+2DG4BXJhzjkOG8O0lWWllK9nQnTIpleCRgx9O98ktrYYbHZnjmX1Tmm
         iGrfZMt0/IdsqwpksHSoXt1knMqLdh9O4lXnqZ9HGe++B8Ao7jsn0LHM0mlqsakFAN3b
         9xtyc0dGvpI9qBkJt/rNcsFNu5vUOVzXDX6t7GCCj/Xwbz7isP18f89OhZZi4A44lit3
         A14yFi+lHo8fjUi/HJilVa/QvSHx/c6UlMy5ereCX0/qzyPJ9bfmdQjOxlmPoWOuwHhM
         10QPty2rEcVTCGCCZ4MCUOLUtiJqf43gagO7av6r9KtymcNIYCEHDzSHL21nEsX6fYHq
         Hfig==
X-Gm-Message-State: AOJu0YzQQVTtItJ2XLYi67tUoVv9k/ebMIf/p+n/KWO5HtHgDERI4wrB
	SF29HJv48hiCIWTvRSrykWsJDL6GWcB/q8d5xb5P3BC+0yHuafqCZoUFEnSmsiag4WkKxXtUhaH
	6pZj7TJE=
X-Gm-Gg: ASbGnctuz2KUTA+b0JohumOp/nsHQ7juyOfWGnkGQmk0GH8WWAT4yvt8ScWlRtbd0ic
	NE0xOg4pcvQj5eAAsTktmrcaFNcCBML6cnDJu0cp8d45TYZX7Scn3nDtPIxRha7slW3Jm25++vh
	+GM/qr8JlcAqGuGm3uMrD+BcAs+TG6PVKgoRn6orVx46P0sApKaiEOWobKmvq2Ir3hgLVQJBBGo
	kGGGSPpznf57bQ1wWnZf4dDPxD9u6FTOCp/G/e2SAFNAQJR2WlL+BiPio8oBnK4YY/0HGWwSLHw
	LTFRTY8ZKjBsdqp4bYKn8FtqSr9PzGm2sW/+VMBV/cNVOt/ECdxCo3VWj1xXaHNUnfRwbLJLeWq
	m1pCoKe/GMUJzHlGQrw5jFL7qK8iyp1JZFzWRMG6Eq2YXgFiwsFmiETAkkgKs4HXd4QQrLY877k
	T2dVx4wEFNgw4hnt63BsJ9SwNev6pqn4VefBDWEF8bputxneQt0j0=
X-Google-Smtp-Source: AGHT+IHAqzdpX3WollrdS6iAJjINTNksPg/CfvXjqQwa4xvz9GrNKp0B6IipUBCVkGkdK+Jqwy4kbg==
X-Received: by 2002:a17:90b:4b51:b0:32e:7c34:70cf with SMTP id 98e67ed59e1d1-33bcf9237b8mr15583037a91.36.1760997736382;
        Mon, 20 Oct 2025 15:02:16 -0700 (PDT)
Received: from ?IPV6:2606:4700:110:899a:69eb:7404:382b:b6e3? ([2a09:bac1:76a0:838::1d1:a5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33d5ddeb131sm8906676a91.4.2025.10.20.15.02.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 15:02:15 -0700 (PDT)
Message-ID: <1f974f16-c46d-4e9b-b0ed-c15b5d5c45cd@cloudflare.com>
Date: Mon, 20 Oct 2025 15:02:11 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] ice: General protection fault in
 ptp_clock_index
To: "Nitka, Grzegorz" <grzegorz.nitka@intel.com>,
 Frederick Lawler <fred@cloudflare.com>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 AndrewLunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 "kernel-team@cloudflare.com" <kernel-team@cloudflare.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
References: <aIKWoZzEPoa1omlw@CMGLRV3>
 <8743bbc9-8299-495c-8aef-842197bd8714@cloudflare.com>
 <IA1PR11MB6219645389921FD751CA0C8B9227A@IA1PR11MB6219.namprd11.prod.outlook.com>
Content-Language: en-US
From: Jesse Brandeburg <jbrandeburg@cloudflare.com>
Autocrypt: addr=jbrandeburg@cloudflare.com; keydata=
 xjMEZs5VGxYJKwYBBAHaRw8BAQdAUXN66Fq6fDRHlu6zZLTPwJ/h0HAPFdy8PYYCdZZ3wfjN
 LUplc3NlIEJyYW5kZWJ1cmcgPGpicmFuZGVidXJnQGNsb3VkZmxhcmUuY29tPsKZBBMWCgBB
 FiEEbDWZ8Owh8iVtmZ5hwWdFDvX9eL8FAmbOVRsCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsC
 BBYCAwECHgcCF4AACgkQwWdFDvX9eL/S7QD7BVW5aabfPjCwaGfLU2si1OkRh2lOHeWx7cvG
 fGUD3CUBAIYDDglURDpWnxWcN34nE2IHAnowjBpGnjG1ffX+h4UFzjgEZs5VGxIKKwYBBAGX
 VQEFAQEHQBkrBJLpr10LX+sBL/etoqvy2ZsqJ1JO2yXv+q4nTKJWAwEIB8J+BBgWCgAmFiEE
 bDWZ8Owh8iVtmZ5hwWdFDvX9eL8FAmbOVRsCGwwFCQWjmoAACgkQwWdFDvX9eL8blgEA4ZKn
 npEoWmyR8uBK44T3f3D4sVs0Fmt3kFKp8m6qoocBANIyEYnUUfsJFtHh+5ItB/IUk67vuEXg
 snWjdbYM6ZwN
In-Reply-To: <IA1PR11MB6219645389921FD751CA0C8B9227A@IA1PR11MB6219.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/31/25 4:01 AM, Nitka, Grzegorz wrote:

>> Hi Intel team, anyone have an idea on this? Looks like maybe removal of
>> device 0 that had originally registered PTP clock isn't handled well?
>>
> 
> Hi All,
> 
> Thank you for your message. We're looking into this.
> Yes, at first sight it seems to be a race condition hit while removing PF which is PTP
> owner (and responsible for removing PTP clock).

Hi Intel team, any progress on this issue?

BR,
  Jesse

