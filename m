Return-Path: <netdev+bounces-145094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 268B09C95BF
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 00:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFF0028115C
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 23:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C881B140D;
	Thu, 14 Nov 2024 23:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYNvrsk2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E281AAE09
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 23:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731625456; cv=none; b=dcAnn6jvHResfzdUvPbpI36GQOpkoZiyFc+NkO3dEEahLOIk41XTmqckQATZTXW0AwJrevlwD+Jz0w3B4tFxcoYRejlt+JnroJb6eioOpYb0lNQtPwg6+02C/yKiQouH6Aks/r5iDg044GnozT4dVcEm6tNMCLG7QFTOnpLQk7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731625456; c=relaxed/simple;
	bh=9tUI339DN7wesr30h/xeGndSx4fGpKneAgqNYyIgYDE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=aQY1pTUmthAUiWG54ByQvEJUqq+gRA0Xjd2GX0duXMYQgtpVz0Odiwsad9lY0Mz9QDtcNuu9t5D7IALa+dxCBeY8EnwsJ31yaH3vEvibAAdaQa0DpPEx/BC9/ZWfL+zRtUOGXk5HOeV1N7xhLNpY5C+DHBFJKgtt10xLpu2JutA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iYNvrsk2; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f75c56f16aso1476291fa.0
        for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 15:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731625452; x=1732230252; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O3nfzBybMuHhnyeTAK7sjJweGzVV0nXyC+TMHEQjPvE=;
        b=iYNvrsk2P/xEL3BHL8Y/RfHqykaJRejWVkdUmZ845QrJwSge5rvfw1GHembv1fy/SN
         4hSS47AZWOsjVW11r3U8kgLfbstgqSBhgaSG4MOdq3C7+T7d93IEZC5eoexprRktnFCg
         SqWEXycJY1ntUMAksmMP9e7cFcO1K8mOvzfnhLCsZYLiH1Wue0Esc5pi5b7/SIwsDu2r
         Z3uo7LiD649S8RBhiuo9j+bnkiQVRniIJkd1Lz9dkuKNIYU+ThiikwGfQfUuJ4Nex/lH
         Ulv0txC0wTWFnwfcoX3Jw7bQqS7VyNzg3d6JtBr53gA1TXz82pDE2wlssbyuaa2sQCQz
         hPkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731625452; x=1732230252;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O3nfzBybMuHhnyeTAK7sjJweGzVV0nXyC+TMHEQjPvE=;
        b=JgZR4bivoLcDgOAVtch9W+LacAF81kztnfTFWUunXz75Cb3E7IKDWbkWQkgINvUVPO
         zCYHZFzilaOxTkE0hPvJLkKOub/UlK00WVd5HRrwb9QwysLx65OdUDXpVm1D6E/HyYZg
         xXfrpdsvecI/QwTAbRYg2xmDzdj22K8nVhB7Qlbd6HchUURvNW4PhKvRTO5CkGXBSfWS
         XIR8f6Qv6CnEiKH/S0qPTgNQ5Nq/mu8GPA7o4BEsNnZfRJuYfyycFSJBIuaBv/GIdrkE
         UFgHGiJiIw+Jwcj5T7IxWsSfVQc6Mwjy80CUk1+LdHG4LT4MHrO4dPzNk8OQckKqBH5V
         2bnw==
X-Forwarded-Encrypted: i=1; AJvYcCU6OoV1kw8MgL/lGQJYZx50lIZDUf5QxYMPNBr9po5mt1ey7raffRMyAwCAsgaUTJBrZsA8aM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YweyU+N6lRrN/Q7Q/38I0KArw8N1BwW7XXHXJu2RGj3D7jUdkSs
	+zn5D+hQSQ+HsWz/nVZTNxG8D1OjipZI96DEEBHqSKNP0zAondV0SLgh7w==
X-Google-Smtp-Source: AGHT+IF5Nx9kGckj4W/pUPsxOIfSZ5KG+BrSuIzwzenV8bPxfAReqYnmZIaGcDzU2NjWHtVNhzlYEg==
X-Received: by 2002:a05:651c:b27:b0:2fe:f8e1:5127 with SMTP id 38308e7fff4ca-2ff60665f0cmr3611401fa.9.1731625451318;
        Thu, 14 Nov 2024 15:04:11 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dac0aef0sm35778395e9.28.2024.11.14.15.04.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 15:04:10 -0800 (PST)
Subject: Re: [PATCH ethtool-next] rxclass: Make output for RSS context action
 explicit
To: Jakub Kicinski <kuba@kernel.org>
Cc: Joe Damato <jdamato@fastly.com>, Daniel Xu <dxu@dxuuu.xyz>,
 davem@davemloft.net, mkubecek@suse.cz, martin.lau@linux.dev,
 netdev@vger.kernel.org, kernel-team@meta.com
References: <890cd515345f7c1ed6fba4bf0e43c53b34ccefaa.1731094323.git.dxu@dxuuu.xyz>
 <ea2eb6ca-0f79-26a7-0e61-6450b7f5a9a2@gmail.com>
 <Zy516d25BMTUWEo4@LQ3V64L9R2>
 <58302551-352b-2d9e-1914-b9032942cfa3@gmail.com>
 <20241109094209.7e2e63db@kernel.org>
 <7fd1c60a-3514-a880-6f63-7b6dfdc20de4@gmail.com>
 <20241112072434.71dc5236@kernel.org>
 <07e69b19-36c2-ece4-734f-e2189b950cab@gmail.com>
 <20241113164635.3b02c8b3@kernel.org>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <9ad65782-2208-d79f-27ee-59c3fd1a9eeb@gmail.com>
Date: Thu, 14 Nov 2024 23:04:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241113164635.3b02c8b3@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 14/11/2024 00:46, Jakub Kicinski wrote:
> Good question on the netdevsim. Adding the callbacks seems fine.
> But making it actually do RSS and nfc on packets to make the HW tests
> pass would be more of a lift. So I think you'd have to add a separate
> test under drivers/net/netdevsim for this. Is that your thinking?

Actually I was just planning to test it manually since the HW tests
 running on other devices should cover regression testing going
 forward, but I guess I could give the relevant tests from rss_ctx.py
 an option to skip _send_traffic_check(), and call them from the new
 netdevsim test.  test_rss_queue_reconfigure() covers this bit of
 code; some of the others like test_rss_context_dump() might also be
 worth running on netdevsim.

