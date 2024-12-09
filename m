Return-Path: <netdev+bounces-150415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5AC9EA2A5
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 00:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61B6B166037
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 23:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8781FD78F;
	Mon,  9 Dec 2024 23:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCYqDCmn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08EF1FD784;
	Mon,  9 Dec 2024 23:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733786597; cv=none; b=mw9OPawQXowqFp9CysYAWYd2LSEwmMmSGRdwsMXLhrktjIiZXxcD9wK2R3O+UQKlcU9klxh/uz7KhLPMNXWbf3V0ja7ptFPEl6gPGVjyqv6pwlUmwPUxPMBt0LCuPKqhpWL3wqVjzQ2SWuJnMfL8HUgYH3quufeUd+YHL2f6lUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733786597; c=relaxed/simple;
	bh=+gif6e0smt0RnkTq1EZX/AMhSMN57ebH823DyqlbyuQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=JaqEJa85fjuBKil8uCCKhYgpHVhGHZaYqO0ztZBl/+HJ0UKGi7mi9FaxmXzxJeUiOqzrl96f0PS/8r1uQABBSjuzbDCaRw7KrLuuE4AoV5vg+VRjV0qoswxcbN1t6k0WR9QAaep+RzHkZCr2U4a/wCIQEQ/JnFZHVMrRklcwenU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PCYqDCmn; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-434f74e59c7so18113145e9.3;
        Mon, 09 Dec 2024 15:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733786594; x=1734391394; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I3O/namvwZh7mWqYOnCyGGTPGGIZdSp8lYqrwpaa6uU=;
        b=PCYqDCmnc79pyCmf/W3YEbIw4zGhXVnSEY9sicUL2TW/XkoRSwRAV9OkfVwqureKpR
         ztkbXOprZoyUzY1ICxq0c8KTrNalWmyYgIBu3xJOfQgY5/ws/SfiWo/0zsYSHE97Nn7u
         0iM5zcZRRBZ563k8WrnIYFwQWq8/09nKbuh9+0ruucPjSWiuY9p/buN1GaSCI8dAmPwR
         EvljhBqbhHgtFO8NG/FudlIp2HclFmb7kighyeREt5mgiBt3XCwg6Oy55LiIp/xDNBt+
         4joajhecAMTYdQwoMmXQNPIBGy7ZwLDUJUB/bKbSADcxn+OlID0rLr1sjkDC6yHpZtUT
         jvkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733786594; x=1734391394;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I3O/namvwZh7mWqYOnCyGGTPGGIZdSp8lYqrwpaa6uU=;
        b=QBgqI1kHnziCdCeTIAf7StiBIXao/8w2k7q+yWEpxFEvVaN9nmjvOLPbwsaQ60P4hb
         3tzCHaorYI0+afOCTjgF8PRnc+005g0p+Q9oXY25Jpr+/p0FiZKPN9jCTgD7gfb4Gupc
         8EAmXBAT3KIvFOon2V+5PsFD/rafhr2fvK+f9+C8Cpd6aj5saiWOyhzXB4zTJ9GyTD/T
         Nt2N0SZlpseVE5m/cpYwUpoqBQG5I19UzYdQPc53V8tgkWy+/1/Fwn+QyiNsoaTL8+Yp
         8ROJRHNqiM0vNO9F/D3P5Q4LVZ5fkrvEph1p43z/B39LVUmgzVS/4PKaVsiTDnO30AtN
         jXJw==
X-Forwarded-Encrypted: i=1; AJvYcCVhXZuELvz23KYHEpzU2hyFAr4JmytjCeW58uZGm2njw3n52u40mC7SH5Hl76AZuTRTTvyqpMrAiyo=@vger.kernel.org, AJvYcCX9icVKIUEjavhMhS7vq8POEulTb6a1jZbv1HCYREy+w/epFSS9xwvk/915+X74f5ZGOBfRWBJq@vger.kernel.org
X-Gm-Message-State: AOJu0YyMw0qofBbqr59+fwF+boatTERL2XoLIUQPf5DORKhlR+zw54sO
	lmqwb1tasfO4b1o7CMg6s0273cwsLLA9ylNYOFgSWS68eaRdSIPy
X-Gm-Gg: ASbGncvQEdlFR/Nvt8e9g/BmurRfCQPEFCEbcBFqHu1qCFuAoTg6vcBusMtGKnJZz84
	Gfx67BZzZV/3GV+xBJc1VX1meYcOquymTB8c7f/ZMF3LPrPkS+YEeaaZkvj2llJvYJhZCP9h3u8
	g78fdMwqnCMSMaSGkrFdzsyXGzcBydj0SEUPwomGBgC5H0M6SlB7AdPjH+LJjVSgdtZGnEVxnAg
	MrsrgzkzgKnpoG7DwFZs4KyqPavmHg35hL+Y7SY6IYh17I3PYLG2BjOjpvYBxiyALrfVHJxVfEt
	vUtOhf2pQHYSpU5wRTh/cfpVIr0ORqKXMpWfHEan/w==
X-Google-Smtp-Source: AGHT+IFhHlC4i2DFSluBo0t7xBaGHwgM3BrHwWijsu0xPK18qikg3zKnjZGBDCfFHfZ7xC3hOyfMPg==
X-Received: by 2002:a05:600c:46cf:b0:434:f586:7520 with SMTP id 5b1f17b1804b1-434fff30dfbmr24176305e9.6.1733786593812;
        Mon, 09 Dec 2024 15:23:13 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da1133cesm175896895e9.34.2024.12.09.15.23.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 15:23:12 -0800 (PST)
Subject: Re: [PATCH v7 09/28] sfc: request cxl ram resource
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, martin.habets@xilinx.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
 <20241209185429.54054-10-alejandro.lucero-palau@amd.com>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <7d5f791f-0a33-cb5b-965e-31de560bd7ec@gmail.com>
Date: Mon, 9 Dec 2024 23:23:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241209185429.54054-10-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 09/12/2024 18:54, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Use cxl accessor for obtaining the ram resource the device advertises.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
> Reviewed-by: Fan Ni <fan.ni@samsung.com>

Acked-by: Edward Cree <ecree.xilinx@gmail.com>

