Return-Path: <netdev+bounces-99864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 370FD8D6C89
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 00:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8A091F2393D
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 22:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C4581204;
	Fri, 31 May 2024 22:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="wfrwp7EE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404167F7CA
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 22:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717195111; cv=none; b=EnwfdcsTvj6oYPvRX8Uo+cay3TIQL5xqr8Sze4hyn7SICsIvEMktnRi7v3628Yfr9A/KWYgR0+3tdG+auPQriZzH/wnehbNGtIHG1UnnylOQz6yvHbzqGcpFox1NUm38ndPHdLJf+dBY9nP6vfl/igFtA0/ApCPyXm0drJYW7DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717195111; c=relaxed/simple;
	bh=h4JyXrJi+gBSa5lLBkpIihcCtI/uR8QvrlmlmKu42No=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UHunkF+cFERXgxl4PHmFGWaxTfff4+CKYyGFbhliMkthSD9ANBBdVwcU0G1a0gRtORO+H3kUOGbPjyR5CUeYX5ug4cmUKow8pWoPShnhPXqpjNPhkfbfH4PPh8dOXVWYN8UUkFn6Hm4dR7EWzWu36g69pNd+fNnoov7hvAREB7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=wfrwp7EE; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2bf8a874296so274931a91.2
        for <netdev@vger.kernel.org>; Fri, 31 May 2024 15:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1717195108; x=1717799908; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2yYK2uE8Kpg95mWVCP5Xxcz1E+wUtLeP/0NDnddLETU=;
        b=wfrwp7EEPtW85tEnOvNqi31OOQmAL4ZI7w/Rxyq0wpgouTx/3nRC2azUzB9cIirIms
         3uPQOpvftObmN/Ppp2Rj6Nz7UhFb5+KSsmX9Q2OLUKtVpqUVVgvWGhNQhDUY+Ez6iLQq
         8/UMS4VKOS04voejLbfFp1mZvZO1gJbz7Rdoz19B40WfV4nAo8TNMQ3TTiOiSx/NVD/r
         EIbH4+TOt7cj2ZcH0TgJb1RsNmRtJcPBTM5JYqZPDkr1WUIkzuYEHlXi9xf2HppHWqLD
         xXVaph3f8sOuhwjkjQ/Cb6PEaE9ppeyVs7AqiTRmesm0t5DA1b4idCDqaq9swZgqwEry
         3PmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717195108; x=1717799908;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2yYK2uE8Kpg95mWVCP5Xxcz1E+wUtLeP/0NDnddLETU=;
        b=wP0PijJ55M4GZ6o6eymv2slxrKbvmH9Hl0wNCTO+TiUduEb9nRhRuxd4mp63m9MnlT
         0mq1s8RwXHFo7rjB3ZwcDj1qBYRogd6ptfc2i1qF3d45/YPQxVqjHmEfnqUFS9h1WrDK
         JgRf/0VecjhCB+fFSj65X5vneGGUWc6CXIhMPvvA7C0zks1am+GwjLqEdyp39SCrDjpr
         aZwllwTCder3B0zOgNNBDTcJXY6mynZb4GCPIK6b1/Sj8fOE9ZHO8RO1ndrxS6Xu320p
         LPmFKndGfz/YZkMYy+7pvYXvHBJOa82tEDEEF87KGFQVaRWTS7NlvDRfUKmrxBwUlnUB
         wpvA==
X-Forwarded-Encrypted: i=1; AJvYcCVqbqZdFvVtQvRxQ6Bc19bop58l+zezUUpVMYvGyGSIKYgjvUAL/0hlMXuKiNVogK6Ny1497XX33rY1HLF4181iEODgj72K
X-Gm-Message-State: AOJu0Yx2SgJeqDTiRSrQ3NYZgteuVLaaVczlL5AqahD5HWfqZ5O4QLx4
	L/0b7+XXupcx2ROdoYyr8zxjZUlJdOn2DGYDsm1ESNF88mJl0Ng/+XJWeIV7eZk=
X-Google-Smtp-Source: AGHT+IH0rfXY9n2YUbV2OZkf1RvycKt9vdR1xSxO+Y7/mUA2cYgzYFf0Av+XrevlzMEpeatPy65HkQ==
X-Received: by 2002:a17:90b:805:b0:2bd:e340:377f with SMTP id 98e67ed59e1d1-2c1dc5ff523mr3031107a91.3.1717195108508;
        Fri, 31 May 2024 15:38:28 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c030fc6e7dsm3201061a91.1.2024.05.31.15.38.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 May 2024 15:38:27 -0700 (PDT)
Message-ID: <9764e3fe-36eb-48f7-aab1-e302fb9906f8@kernel.dk>
Date: Fri, 31 May 2024 16:38:26 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] net: Split a __sys_listen helper for io_uring
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: io-uring@vger.kernel.org, netdev@vger.kernel.org
References: <20240531211211.12628-1-krisman@suse.de>
 <20240531211211.12628-4-krisman@suse.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240531211211.12628-4-krisman@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/31/24 3:12 PM, Gabriel Krisman Bertazi wrote:
> io_uring holds a reference to the file and maintains a sockaddr_storage
> address.  Similarly to what was done to __sys_connect_file, split an
> internal helper for __sys_listen in preparation to support an
> io_uring listen command.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


