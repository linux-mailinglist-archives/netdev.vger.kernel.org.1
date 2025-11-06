Return-Path: <netdev+bounces-236279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA1CC3A87A
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 12:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BB7354EE7B5
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 11:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F8730F541;
	Thu,  6 Nov 2025 11:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXAazodc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8144830EF7E
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 11:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762427825; cv=none; b=YDWSFw0El5B67iT5jjWE5Y3Dtkvf0sPqVhytsJFDk01vEabXNtpn4KNZbcFOFHOTvdUyOpkmHQiUS2BMKYjJ1rf/Jdc2uGAvspS2J5PWkXPBYBRmzBgkIEQ75QK25KVms8o14hnF9WLYeVek2HuQ7sjtLwDHpiOfFOZ1y6I0BTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762427825; c=relaxed/simple;
	bh=t7T9bdLSkD9Nv6Zb2rZgtyVhZXo2xta2IQVpO2VwIUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cuywVK/2OnHAIaAsos8y2AZntxLHGwewLhbqfbO3/P4X0E64uZXcUd8RSKMesNN7WT6sf/e3a9fHIBUz8eyVUn2Yyi70Mgop+eJU/84NiGbrvR5MwE+B+PoNaHnDXsbx63MI0j8DPcqcdF0LbxiYHztdx+PTJRXHIULrzaCxuYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DXAazodc; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47755de027eso6405715e9.0
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 03:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762427822; x=1763032622; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2pwpif3AbMAeC4QL8pDydgnEKfTN0SLOUAnIYQfQy1U=;
        b=DXAazodcJTGzgp1tpv34kaS357hYOnTl9OA0oQbmWPXBmDEpwwZsrGXrfHISAmadYK
         de2zEiTEzgpIGS62WumnvW5uhsdqRQjb4bJcEwJ7yDOSry6PmyhXZiO5jp8Xm/p+ZDWs
         l3Gkwyk1t5fbLA8suXudUwENUV11ilSfSWXxBQHo09wP9bBclq4cD68WlYhewU2Qty/m
         7guxBw7E9T30LJNIHKn1YOnEPD8/lOiy0ONXtTnmAMcJnbV8J0qeFiCtxkmzwHt5Ddmt
         t67uhzkoDz6wbAOE3R9qVjThr1GcxLavDuh3nIRTHwrYIkj/trtEdyQMfA4hc4AZQ0gN
         B+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762427822; x=1763032622;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2pwpif3AbMAeC4QL8pDydgnEKfTN0SLOUAnIYQfQy1U=;
        b=kcNREHXPMLzg9KgJsbBOyAW2JChy8V6yu/VtzbqcwWhAP3WWHgkHSqGy61ML1XKjIV
         412oOnnGn+18g6o+fiiC9rnE7HtkvzKcH3ItN4tCB855hK+gjue+NX68pxtWefFebnj6
         5HaSfYsoIuRut1LZ4egR25fVDuMW19zIGKOMqOvxkAHyx6q8Z/thMPezYWiAZ+IlATkx
         B8eTQghu7iA8ExY+rj9R69/UZYGCjsN9DWXM84MEECOa7vKZ1F22RD7Gve+oJFMlS+EM
         D/YWO7TsKeAnt1DJfDHjMVwmF+mobHbzYojgl/UpXZaOciek1FcEykF6M4KLAb28XXr0
         97Pw==
X-Forwarded-Encrypted: i=1; AJvYcCWNzhzdE7kmOwyGplnoj8cPL3Q0+aKD4u1DSaK6bjmWLOyNyTfhJPplxHjLWNF7vFr1EucACsU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9bk/ROSGBUv6CvdU51VnavZA6ttApvQPWu6zoPQc3YFIMlVxx
	w9IzBL18yaDGWHR2L0JOLewKo28B0yBqu4FQckluf+jqqtum9zClPvs4
X-Gm-Gg: ASbGnctJW4g7ss1tbOe3xmKTr4/XRZnjhTayhWUHpUDuCjST51HacHaR4z6DuVj5fWE
	UTZFtgKYhNY4oLPbSYCgQErOqCWjzxgghBgu9AWqhUBSgfUE2FVL+yVeAqGFfdCZ4fCxLe8+yXC
	m9hSPIwtkIvSiOVxMo7ISzkChFVP9o1O4Zwm4lbn/136bqwqZU8TP4016WtLyeokpEamZW63C1S
	5PVijjhTCPWpQyA3/2tkjFoSTNosnFwxZ5Xz2V6BWz5/9kiux+A/wELEkhgpIn3tZoZ3U2R1FvK
	mLAbIRiTDAPurKg2TBWnVNp6YaY9WF6vmCp5IfQkmXjigjjushW6SOrv/K8U3UzNQ/5K9QZkXTz
	4K+Tu0K0n6fbqYtwgyDLnL2RaoqhRjWuFYbzVOx0OHII2UQxslV7UOquE1WfITbpQpXfBIap4Z3
	D2T2eVYomMovuDBoyKtVhdy7NRBlVh7EDWRlsZ/E6yxaERqSu6yGo=
X-Google-Smtp-Source: AGHT+IEjm2TbA6imlZYLR4rRFYK+5E2vEbsGazWIwtpvxS0FN0S6hlQHmUoABt0/OinEP6U0GNT8yA==
X-Received: by 2002:a05:600c:458d:b0:46e:3d41:6001 with SMTP id 5b1f17b1804b1-4775ce2304dmr77261405e9.34.1762427821871;
        Thu, 06 Nov 2025 03:17:01 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb403854sm4390960f8f.5.2025.11.06.03.17.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 03:17:01 -0800 (PST)
Message-ID: <608ac955-3d26-4a22-8fd3-715aac193dd7@gmail.com>
Date: Thu, 6 Nov 2025 11:17:00 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/7] io_uring/rsrc: refactor io_{un}account_mem() to
 take {user,mm}_struct param
To: David Wei <dw@davidwei.uk>, io-uring@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
References: <20251104224458.1683606-1-dw@davidwei.uk>
 <20251104224458.1683606-4-dw@davidwei.uk>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20251104224458.1683606-4-dw@davidwei.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/4/25 22:44, David Wei wrote:
> Refactor io_{un}account_mem() to take user_struct and mm_struct
> directly, instead of accessing it from the ring ctx.

Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

-- 
Pavel Begunkov


