Return-Path: <netdev+bounces-240205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C20DC71715
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 00:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A562034867E
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 23:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D1827381E;
	Wed, 19 Nov 2025 23:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="isNqOpll"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A26372AD5
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 23:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763595044; cv=none; b=a8cN80HOrRukDFkx89kYEqJLYIYdLaquGm3Fx6JtoV+0520iXeGGvazQVnHB8Q11aWWoXoV03FPIUwMxZUQhFjIHZz31A819zWNYKhdhuz8rM3wUEKrAhgS6ZboHMDRhgtV9tZVGft49XrggDLHCEkxIV4gy3xT3u+nvrl7P3s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763595044; c=relaxed/simple;
	bh=s6qliBbpj3HadloS3LfzfZX2m2178c65fLTr82dFOzU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G2V1DgCdq2rZ/D+wP+6S72NQwTDT+CEq/lbQvRQ7bJ6H3u9NT3KxHBkej41OiMWGCchNTjQq7CDD73kRYIOEkfTxHOkFIKErWSpmnKL9RYWZV3rnTxsiMB0fMwWCzc0JwJvuAILlsgH+xhAuNSmWOhpdejf1pgpYHFEF7JAjnuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=isNqOpll; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-92aee734585so10181739f.3
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 15:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1763595041; x=1764199841; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pvUp7RGUmmjs216+lVxeFp2Csv+aHXWOg5Fjh55n6xY=;
        b=isNqOpllfMTvF074WovwmdGyGKGt/6mrZ0edVAPnfZBR3YSbtSTdLgfsYTXxeUCrLY
         uFrSdTHswFafDSUbwroJs9QtXuMEESRkgsULjBo68SKyCXHliNoODURacLEZt01bVRb3
         xkZFpiwDpeJITHkYK0hddJUSYas+eh7khWrY/V34oZWSLzvRgMmSw06LAhi4PgUbyduI
         8ziGDW00q3gstJUhs6G6he3DPHxjqZFiZafHq6PAWXI0EaSEgr0AQrAB6HKy0pOOLPki
         KBka7hnkP71fMtWFo1eVC432p2GA7kbjgX6nlubVpTNtJyjrQSoG8YiYzTFpyxmgnI4y
         3OXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763595041; x=1764199841;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pvUp7RGUmmjs216+lVxeFp2Csv+aHXWOg5Fjh55n6xY=;
        b=PjYPIFDOMihsOQeePRsGeUkIlsFz2z7GCXQ8xLhTVTAg9+KWz/TF4vJiWcIEaaG/8K
         0VVNbgZB8aeaDlBlTkUil3zNcw0TFtW/dsTXgUjdvGhEOWGodzaUcf2tVd21Wb/RkTdf
         hYwcVBJ5hVWZk9jdZ8cZVsyyDppHpDl8MM0yDh38j/T3aJS9WhTOqPk1PiVR4fVLdTny
         liJVoI7JBGmFwjP+sLLJKR9g6Pr5gDfae4fvt+1fuSd3qWCqQ3hMDB7KpuScBB1yJBJd
         s0JVDAr401IErAio6TWEz4koTpBQbyxzQgoE7SWe19v4DQ0KECPOwzWw/fGywV6IvFpE
         mw7Q==
X-Gm-Message-State: AOJu0Ywn3/Bq4kesDmVRQtSDv9BHdKvrWGhLn6PcLfin7k3p6703h/eP
	niO4FDM256qrAQosRGIpnG1A/V6rGPofJLG+Zh7Zm+jJqPCQul7A9rxXw9fUObe5VJ8=
X-Gm-Gg: ASbGncuurwFZxnw7yB9LDW1iKhHlgfS/PB1ANR0gx4veQpBPHXKnPr6R6Nb+qO2rT2L
	j65kn6BRAkHlrbGxdvwfyz5Qc9VTyT/cIP7cZK7YYev/DXu27AaIgMDk7E0W2NKYyGBxWLc1mWd
	pohFnCyOBVcz9ft7bgPKk9CcbVXBtTckvl+N01xHsyLz/Vs7dBk7VYtYHvlwU1snOD7rx3I3Ux0
	IHTBzsu/FUxfUeFSGf5fKyzhMXFnirhWnQRj3bt1QlBD6+8y+gV2wB7TO1+E3zuqE2yfXcjTUhy
	Klo9N+69kRG3SJMEf63ecwcSuXtGk2Lc+7EpRmd1wq0S91BJLKWtC8Poo/rZwqEZl+kkKvhAs19
	t8xRaoKrBUpYvPA/gmLigzTd5ym+aANzZGELRwp6r5XNIgSZGWyQAIatWCPMWQZgD/F1qxPo0fz
	TMOrcx+h8N
X-Google-Smtp-Source: AGHT+IERe15bOQxQuX9smf+xaJao9XmWQ9dJkk7j6R3CpeTHjwtEMaDwQdMNpRp6kWa4xj7sFPC8+Q==
X-Received: by 2002:a05:6602:2c0b:b0:91e:c3a4:537c with SMTP id ca18e2360f4ac-94938adfacbmr86360139f.14.1763595041205;
        Wed, 19 Nov 2025 15:30:41 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-949385c2405sm29374939f.6.2025.11.19.15.30.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Nov 2025 15:30:40 -0800 (PST)
Message-ID: <8ab727b0-e377-457b-9b3e-2499ea38abc0@kernel.dk>
Date: Wed, 19 Nov 2025 16:30:38 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Introduce getsockname io_uring_cmd
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: netdev@vger.kernel.org, io-uring@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>
References: <20251024154901.797262-1-krisman@suse.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20251024154901.797262-1-krisman@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/24/25 9:48 AM, Gabriel Krisman Bertazi wrote:
> 
> This feature has been requested a few times in the liburing repository
> and Discord channels, such as in [1,2].  If anything, it also helps
> solve a long standing issue in the bind-listen test that results in
> occasional test failures.
> 
> The patchset is divided in three parts: Patch 1 merges the getpeername
> and getsockname implementation in the network layer, making further
> patches easier; Patch 2 splits out a helper used by io_uring, like done
> for other network commands; Finally, patch 3 plumbs the new command in
> io_uring.
> 
> The syscall path was tested by booting a Linux distro, which does all
> sorts of getsockname/getpeername syscalls.  The io_uring side was tested
> with a couple of new liburing subtests available at:
> 
>    https://github.com/krisman/liburing.git -b socket
> 
> Based on top of Jens' for-next.

Ping netdev / networking folks on patches 1+2...

-- 
Jens Axboe


