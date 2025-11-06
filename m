Return-Path: <netdev+bounces-236280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0551C3A8E0
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 12:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE39F3BF1F5
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 11:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9697C30CD82;
	Thu,  6 Nov 2025 11:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQBvXb0j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75752E5B0E
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 11:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762427909; cv=none; b=tJ76/Y2PceP6CPgqOqyJOc0vPt38QGGNH3+wDIKDqhjGfxvAlaRijuvekp7et4PjRYvBqQloUo2rDSjLuc7PfP7muHtMpgDtvHl7gYcWw1iHj6htXe2QcyzxHu0IIDzaYXzI6ETkeKCW1AsiJ8DaMndy/+8qAgUb4Fos3ipPd60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762427909; c=relaxed/simple;
	bh=q9qP6rinajMx7rtOD8a1zMyKxHJNeqzScHocjyeWyek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=umA5h3dpvnzSCYZdrBMYHhTdtDcwWdxSM60GIfNaMmLrcFqy7ruHC2/NspUDkFrBxGhsa9yGkf2v9xrSlCgcOgPTvDpBBDD4vGdGX79xoCT0zPNv7hl/dDKYVAYCq549KhufeOOeILoDlQgRFs1rJoIfxL4a7pXkzVjfPtWzKCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQBvXb0j; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4710683a644so5804025e9.0
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 03:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762427906; x=1763032706; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0/rBOe1zXcqjIALzT6F72Jxuxm+SnLT+ei/iO9Tb6QA=;
        b=FQBvXb0jKOn03KiimnTJ8W6jcsm4iHvBqAW1xoFSsvySbC6ppWVRSMPQIRUr9G0pXT
         aQAp1x++Rv7CaTG8+VoqDJ+gamd2wTOnRMhJ+BA/JrNaqGhwrnbS8MeG3KQnB6jw5zrX
         MPrjwOIbYKggtaW0TRTEY4g9uwBYQ19Nm1GA02BZIROx/hSGE9r7uk7WM5NeHz7q4Ntc
         OFlvRHhOpWaw8hykoVXI6gw5DLnuoYm0uY9+dU6iX9lOyfWV/GIMAxyJYVe+Cpjea7zJ
         oMaUZySHhj+QUpBl5DEYR9FN5uplXAmBPSOuwEoCpQBSqKSZ8R6JBro6WgmG77lqrcWN
         t98g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762427906; x=1763032706;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0/rBOe1zXcqjIALzT6F72Jxuxm+SnLT+ei/iO9Tb6QA=;
        b=wy7EFMH2VTY3Lr7Bct2Zrid5f3T0rP9zx9K4oqnNyLz40pqNI5E/cZN4kNJj8/6DJf
         edt4EJbUYybjnvGwgUHXpqK1jnrQYwqeadGWIgBxqpSUgK27w4YTOqO0uGg5uiz5fg2t
         +nmEXinRIgNSsAs+q36dXoZEHdaAQ1vfZuYQ7Aq9TT1/yd/xyx6sGP2koiujbg4C8sC9
         10K++8B82uMxjWbIuVxogLK3ALzVwhGvWOhx/GCnEWik2VCC2JZGUrsYFNNwXXZmY3go
         OAER8oA3SDYssnu+4EJzxUjtoOsrhmYlYg5EA8zEGBNTr259PAHoth3UWHScVWi8Q/2H
         bMvA==
X-Forwarded-Encrypted: i=1; AJvYcCWv7xSSmt33a2F4PYCB/3FnGWtzsxwg7vIG/2hNQRWbWtRrLBgxSSfoyzi2Faz/wQ/aOv5UjYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFPm2c5WAq4Jfo28WMtownv4wVEtznYTSUrR7APMv8A/FVqq2W
	oLosvdCwCbLbmeYhMPVbNMCgBRrUdhqKruBnywZ+jX3cetruQn3+L2ER
X-Gm-Gg: ASbGncs9giSiGj9FxVoJe7ibC+3WOZyLOMtVGecUmp826+OrHNh2zxsz4luosuH2YUR
	vx+5Ny8vn6ycBhcuW/wVhSytwnS3bcscCj9Ljn/0gdfzlAsdZ0O221HlAcIEGIEqEDIpudYAB3R
	cfHYrxHjEkqIYshMmm4tx9f8qcGf0seNo8A3+ACjnmw/UX13xcNwIJcVXXTtV2wAm7o85x6Zhy6
	t50WYUTWnZOd3wCJNC7OKNHrJgroaSqoDuwtIGSsj37PlSCw3Idn5W1g5RfyN9om/eURLtD1vQe
	phXVG99FdDB+Y9EHx/zLZ6NPGbherUbBiFRCwEVCeS+Lt7Hl9ErP9mdeFzC07/p5/AsgODFrJJk
	PxK+VfDUk92xgDikEu0eRP/r58OZD3foUr0kFZbE6EM4JbhO5Qg06Lr+nZdos28WdA6VS7GG1V1
	O3Q9V+iiCWVylNcsT4J2Nxio76MepHifAmiolhMCgy8WR/w9ni7QI=
X-Google-Smtp-Source: AGHT+IH838wzTECzdx/Te5XL+1DFPqB1sYTzYK94ZHlQm4rCvG7UEgR+8sLaS7ijKZwBzyxRnmSMYg==
X-Received: by 2002:a05:600c:a108:b0:475:d278:1ab8 with SMTP id 5b1f17b1804b1-47761ffd211mr24852765e9.2.1762427905771;
        Thu, 06 Nov 2025 03:18:25 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477632bda1asm36383835e9.3.2025.11.06.03.18.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 03:18:25 -0800 (PST)
Message-ID: <e49d76a4-9f61-43fc-826a-2a5b452d3149@gmail.com>
Date: Thu, 6 Nov 2025 11:18:23 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/7] io_uring/zcrx: add io_zcrx_ifq arg to
 io_zcrx_free_area()
To: David Wei <dw@davidwei.uk>, io-uring@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
References: <20251104224458.1683606-1-dw@davidwei.uk>
 <20251104224458.1683606-5-dw@davidwei.uk>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20251104224458.1683606-5-dw@davidwei.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/4/25 22:44, David Wei wrote:
> Add io_zcrx_ifq arg to io_zcrx_free_area(). A QOL change to reduce line
> widths.

Not sure it makes any difference but doesn't hurt either, so

Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

-- 
Pavel Begunkov


