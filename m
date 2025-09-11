Return-Path: <netdev+bounces-222308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D2CB53D49
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 22:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7488616E0DC
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 20:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABF02D77E0;
	Thu, 11 Sep 2025 20:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvDQV01b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444BE2749D6
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 20:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757623857; cv=none; b=gRPy7Zuja9ZO3z5auIy7Kv6aZlTCbDzoZvJtildG4P90e9yn0vXS2Qo84/gGrJNjuitzyLkIC3GznUIa6NoFSbNg6X+8bEqNLy1JLgObdYcQe4kAvsam90YJg4cMZR6EvY67UBuMZrbTk9koPRDLucKo42Oj6xTv+4T4xJyAN5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757623857; c=relaxed/simple;
	bh=d8rATXNV6jwI27OQRWBABzzdKruqGj9G1fXFI/mzmxU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tJL5G1K4PWFFlUFeMgJipFLDdbf8i0nVrIMTdZfiSSUOEVXWDzxkm/d4nDxge4z+xvYg7y2ZhzvHovZH1uqg4hZEq8YEau3zpx+ieaTcOuNICrBMlsVwvaEVScPwea2gxgXDFd1kNOFnnW/mWTz7ow1vzVPyeRep4l3uFxc3dnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EvDQV01b; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3f663c571ffso9974395ab.1
        for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 13:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757623855; x=1758228655; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Uu6kfves/POM92mLVndwNA/FpMTrKaaEatZAEOTv6+4=;
        b=EvDQV01bnY55PD2+49gmj9+/2wXVdPu5GkLLSEP7mwzUIL/UWFs3lwfmjNrYPrAF5j
         WbqavHKq8xQG0724Q7lfUMglfeTMA9b1zNnYlByrOTlSplvb1lLShkwdk81n//bw4XEM
         N0rxxhek6M6kab+HFsMapj+KR1pwUebspie5DpRBD2ZTT4TGVYbkj+R5YutB6WsKA6yx
         D5Afr0oaYtlSwwlel6ffHit34yO2x9CZvF5sA9wMLYu/cPcinQXHLRTbZZRlAsgEEJGA
         zfmgYOcCKqQTMqb4pZBB/2OX1ccMKYjwCo0eLM+nvWGK5jMLE85DIB53oobVOINS/tOk
         DiEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757623855; x=1758228655;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uu6kfves/POM92mLVndwNA/FpMTrKaaEatZAEOTv6+4=;
        b=jvoz7MZ6lnnKrw4h7Wn3xAJhJEe1le4w+bujEd3XGBA3RQOBo8kXEhmEz5yD1svLoh
         7MfsLItyOrAOY2nJxX5lEuRXwrOHCmveVqHRSYOIhw+62HCIGXvV4idM4gI/Le9G6G4/
         S8fL7Y3B5vzXB1HUcUMHb3YZE0QQh+WSq3FmpBHQf587oPx2EiciksbcIPrxJ9aejs17
         oh0TRnEqRVCjNmdB3k/RrgiCAX+Rjj5j4zxp0QAfaCK2xxZmR5Yurus1uNqP5Swr1EMG
         Od4PFsCqal41iPl3eaordNXL1qwK76iGLkzOOSAKMNQGNdQgvsSNm9biXj2akc/h3hSN
         /Fpg==
X-Gm-Message-State: AOJu0YzCAXiwc+/Ciqp02yeheiTbXKqZeqU5IA3pmLkCvGl3aua3BfZS
	k9uyqdVzIP6G/n+YSSrXsmN2DyCxqL3qdh5oEueGwKe3FVcgH8Etc3gE
X-Gm-Gg: ASbGncuBsMlmYVMpcNEzwAQrkeF/0eGSxAiC/CIlIFNXTvGaI51+VRPLbk8o8s43aGs
	FOl/HpNTYBIZROg9VTInR3VJlGBkWHrXAr7BEMCZQ753N0DyYI4WdneNGt1MCOL607Z37VQQFyN
	di1cQsvigeOYdmAyOu7xCzIjGZfxZ6Hjm7b4+MpIEvL2EQ/RZv/hss9nU/l45LAkTl5qQWjyOhj
	ZSYNapTkNCMwiz4V+GHzefiuDhVG0kMhNPZmU0rW5tzfdAgFJC5DGwOy4l2LzErmSNhCTE+cwTs
	j2D59l1SVOGvSBd98PyY3ntdXLQcES50E1dQo1pwT0qNSBrfPSJdvKybqzCr3o8umUKyS4+U2Cv
	JwN35pnedduR/f48D0JMgtbORXKjsckjUubkqFc93QF8I8xYr56GbwtWzKrL3+6ab9cN6IfWaKa
	hwrFdsqmDM
X-Google-Smtp-Source: AGHT+IEmgql8TI+4EKQmxTY6TXKgdfegECZsDBOMbGLUo/Cv2qnZQoIgVmEXCRFcKpRFLz2xp0hUTg==
X-Received: by 2002:a05:6e02:1946:b0:409:88ab:d51b with SMTP id e9e14a558f8ab-4209e8344e8mr15692175ab.14.1757623855240;
        Thu, 11 Sep 2025 13:50:55 -0700 (PDT)
Received: from ?IPV6:2601:282:1e02:1040:d54b:8f4c:6b97:7d20? ([2601:282:1e02:1040:d54b:8f4c:6b97:7d20])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-511f30bfa4asm935113173.71.2025.09.11.13.50.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 13:50:54 -0700 (PDT)
Message-ID: <d5b7afbf-318a-49c8-9e40-bcb4b452201b@gmail.com>
Date: Thu, 11 Sep 2025 14:50:53 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next] tc/police: Allow 64 bit burst size
To: Jamal Hadi Salim <jhs@mojatatu.com>,
 Jay Vosburgh <jay.vosburgh@canonical.com>
Cc: netdev@vger.kernel.org, Stephen Hemminger <stephen@networkplumber.org>
References: <20250907014216.2691844-1-jay.vosburgh@canonical.com>
 <CAM0EoMmJaC3OAncWnUOkz6mn7BVXudnG1YKUYZomUkbVu8Zb+g@mail.gmail.com>
Content-Language: en-US
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <CAM0EoMmJaC3OAncWnUOkz6mn7BVXudnG1YKUYZomUkbVu8Zb+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/9/25 9:32 PM, Jamal Hadi Salim wrote:
> 
> Please run tdc tests. David/Stephen - can we please make this a
> requirement for iproute2 tc related changes?

I will try to remember to run tdc tests for tc patches. Without an
automated setup, there will be misses over time.

> 
> Jay, your patches fail at least one test because you changed the unit outputs.
> Either we fix the tdc test or you make your changes backward compatible.
> In the future also cc kernel tc maintainers (I only saw this because
> someone pointed it to me).
> Overall the changes look fine.

Sent a patch to add a tc entry to iproute2 maintainers file.

You say the change looks fine but at least one test fails meaning
changes are requested?

