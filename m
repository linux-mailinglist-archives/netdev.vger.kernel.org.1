Return-Path: <netdev+bounces-150416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEEE9EA2CC
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 00:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DBD318839FD
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 23:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54D819D092;
	Mon,  9 Dec 2024 23:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXgBx7GE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CB01F63F1;
	Mon,  9 Dec 2024 23:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733786839; cv=none; b=D5YrbF3onC3o6NP8TJzZ3T5AOG1xCq1tdVS5wXD9nj7tZ02YoDSM0kBkyGrz7/IOEH+1JhS4YRR6jO7JTtlrjZ8s/BUv9QtT5V7YbadQZUqdj30zUo0bIazxmbxBkRGmpV9Fk5r0gIAgYvPuR8Wk9DvzpfF7xq/dwZdS3QTVV3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733786839; c=relaxed/simple;
	bh=04/MH0M56ujvVA2ZfIC/nWxDqQhoaWeDEa7bj7YCsuo=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=W+rKPhdJAomWOf88zfZXBWLsePpgQnkp0IIx3gvk+qy247Z09N2sC5G6sKrn4pHc/TEJDIkWJpzWBMsaUxwcbA24ohQMqLRFS2lizUwsYMHpBHoCchBuKxVgdExhdU+1tqJWLHtsa65EqW4F/KzJKvxEHPwS88S6Mlhj/yOkaPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aXgBx7GE; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43540bdb448so476545e9.2;
        Mon, 09 Dec 2024 15:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733786836; x=1734391636; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VOwUSIA8zncOTJJLH5tfV96W1BUIMMiWQTicE6ZU+fc=;
        b=aXgBx7GEEA8dj1528ymBty/Ke+jztmeib802kvByHq3B7eQK3g/bSljlZT00gV9KE/
         zZGMg46xftePq03aybiB143YZ5yFPXdtZG5e63RN21qscIXoOvOVJo/tQdYN20pGI6r8
         z5n92QSGNZ4zO8PCtm4xP8o1OgY8pUbKECa62jmePq2RD82aV9D4I8S3U0ITiM6yf/i7
         O7EhltnIkDcaOLJ+1QpQekAoVWH7YVEmgOetdOggnSigSqSYLYRq4aoAaCPMhDf0GDP/
         gykoyjtpNoCA3L8pEbNMyFS/zuHsFUe6PxNPOk8gqMSxgEUcZdbNI+biYHiJW3GHQvN+
         hcYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733786836; x=1734391636;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VOwUSIA8zncOTJJLH5tfV96W1BUIMMiWQTicE6ZU+fc=;
        b=hWf/8l965Lm+PWUFmGk81lUkBXpOZ1vd/m6Zj8PxiUONAlxVmcaS0ZTJs8cW8JqaS+
         oIEvSsbfQJfSC48V1r0wBdOjql17pwWWTOZGcmarA0+BLNDXd68woSXYzQ/cb/T5yY/q
         rJNxGHn08Jz692yY/n64mJIm0JSbdlpo/yRYac/wJKsQkVEbERZ5VNa7xFK7r7r37uDY
         U8k1azUr05Tc4wTOG+b8PntcYqwEv+A18Cdo+poBK1W616t8qsYG1LqD9BMMTWCS8wQs
         dx9kqG/S88h71mKPCfpPVvG2tCZXZfeOs9XpfkJP1yMEYirc1osgjsruuEWZhgUq65bN
         MLKg==
X-Forwarded-Encrypted: i=1; AJvYcCVwyGNO7EJchxGziuxnPSb6iEqW0Wp0TK8BvrkMCfjNbQw2ve5I6wlp9IGzCWODfczSd6fUMv8E@vger.kernel.org, AJvYcCXVXcM6mhs+H2wlT2Md4b0N9qqgbAZINl7XfUckHRGvGv9R0xGGTvYEGfGq9F13P3x03guLKZFSz7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YypJYbTN96BzCGh2ZPFpSfTFdOnnKT/AlDEuYCWnzFsTO47nvy8
	v70b4eiVa7Y6EyJ50fe6D+F7R1xIRhNLfCh22ry+AAWkV10xRRbJ
X-Gm-Gg: ASbGnctCXRk27s91X5ZonKf+zvEh6555oSFYLdJv7TXA5YwSyUgcDgRz0OIDNS568aq
	mYNUEPJVKUlNTjRvSpBNTS3UZJh5qDnsZtk/mrwMO2T94YNTSWTXN95kGMKTOuJW0MJ37vayFGb
	jymfxnjOXtZJLCsduUVojQvlQgXdkzsU/JHJa/+v7psw4MDHgjxZRMZNPcKQqtoNAJqE8fxUh0Z
	at5klJb+TNdl2DcWB/JtdkUJ1vxNyGDiOP0lVLjbvV/UjBSSf+h2DCvbws7YPt8S2eLqRXjehyw
	2V/lfOPhdsBxkcX9kSyuB+3eY1FMOmVb8j9kFn+JIg==
X-Google-Smtp-Source: AGHT+IHEEaUJ0WolsIMg3C0a9dxYI8+HP3umoSGt8rF0abww2h6qayNCUKnEbtKpofX0wnMaGdoTvQ==
X-Received: by 2002:a05:600c:1d12:b0:432:d797:404a with SMTP id 5b1f17b1804b1-434fffa2ad1mr17984525e9.22.1733786836213;
        Mon, 09 Dec 2024 15:27:16 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da11935asm173690395e9.37.2024.12.09.15.27.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 15:27:15 -0800 (PST)
Subject: Re: [PATCH v7 12/28] sfc: set cxl media ready
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, martin.habets@xilinx.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
 <20241209185429.54054-13-alejandro.lucero-palau@amd.com>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <a26a8b5e-e74c-166d-d5e3-59099993bca8@gmail.com>
Date: Mon, 9 Dec 2024 23:27:14 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241209185429.54054-13-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 09/12/2024 18:54, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Use cxl api accessor for explicitly set media ready as hardware design
> implies it is ready and there is no device register for stating so.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>

