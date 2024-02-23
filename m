Return-Path: <netdev+bounces-74445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B24F88615B5
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 16:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C73A283574
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 15:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51C982C94;
	Fri, 23 Feb 2024 15:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="GDMhuutx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B4A8484
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 15:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708701866; cv=none; b=a9nPFepFcvZTx31iwZ652kt3vU6HEmBcrgLKE4R++K/0kP3z3BJjyAoGoBYplG/Nex5kpmnDH04pkey1XtD6UKblqoYrVfEdLsYv5Q2kb3tprlbJt0OQOenWbh+H8bfOYPY1FX+lTjHj4K1IxTuzvWeeblQZjgW4oNwJcYBVFIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708701866; c=relaxed/simple;
	bh=AdCxW5WrzFnWjWsaAVzJ1aN7vO3tITaqOTcAE2hA/VU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hY0jjeqIc3CGYB6tDH2BRGFbTDhs7za4y7J3LsHiA6ZVbKfh+lmHuEZpxt99395fyHHxl/xrK7UbhUCHTpcWlbpAwwE+2Aqu4+FHFOIGfT49qzLK8q9YkbL2KQmnWihJOJysZDSMbWRuX8pXq5q94B6YdE1eI3nE8AtYVrR5TYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=GDMhuutx; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4127190ad83so6496395e9.0
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 07:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1708701863; x=1709306663; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1EhImcUCi6d/MVD+/q8UJtZrB5e6Tq1/GScp4+9Zwb0=;
        b=GDMhuutxcqEh8PhRb6q5yfrEihi30j8HyD83MeysjbSmG9atHj/BpGej/WMaHFpFdY
         cQAzZrYghEpYWUGfAzSXjTidjbEP9wTHP9hlmtCMCAmy2ARGw3LUG6fJL57qoBMIF9C+
         KxBJDvfjaUFqan0fLLYQJFsj1EG6LDT5YYCe7p3VUVW58fPJ6+b8MIs2sC3xcpDWtkdG
         A3BwY/Q5BoCypTPOASIqllzHI8zJMuKrYubsb2ITM7tehtbgY/CI9wzQ47UFkfes7DMh
         GdpMuz3D3KP2y77AqFxldnHyOx2/t5D8Nmc0VcAk32PoqqpOhk2pPJBD6bAvSB99BKLj
         8mfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708701863; x=1709306663;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1EhImcUCi6d/MVD+/q8UJtZrB5e6Tq1/GScp4+9Zwb0=;
        b=XSXLWBg0a88qJII3I8ttLYlfmpb2bV5fUtyxkS/KNZRMS8fh45R4hDWC893waRdaOh
         5vOIlFskTqDrvGRzF1zVcFnrjvHh1pfI9TZA2rVMTGngEo6cnXaHcAi4VHQupW72+qix
         8xXVIXWTuK4PW1Ct/QvGc0iGB3H4rHPsFGcZzDMf9E+Xw7MUaMlOjDv4cQteuQEUCMqp
         ITqxtd+UQT5fdtuRjOqBzRI5MPhH51W+ldgKRvUR4J1tF5oJg4+bPRLrIK0x5Pt8FkFV
         dbpfDjaYrx9bv5EftHWtO+EOq2/Nr9fKZwxf41dO/5aKBo66iyMYdta47UfbfrIwaCdC
         ZbLQ==
X-Gm-Message-State: AOJu0Yy+UA2nqXW5C9NuMkk88VOqZbhMIb13roPSYQ0GjZLLkLUlsh5X
	dfYjtL5adgJ7o/BU+cMGvtLyk+tAMQMu1K/Z24qkUHPI366Cg5OM/xzgMXIdcwE=
X-Google-Smtp-Source: AGHT+IGSV79swC8jTODIW9Y3ubDBpGVdJf7Jyt+aY0UmdYl2CLv0sBXet4RqSMWYJAjqjIJZc2YdaA==
X-Received: by 2002:a05:600c:b86:b0:412:8f5c:cd34 with SMTP id fl6-20020a05600c0b8600b004128f5ccd34mr101627wmb.27.1708701863254;
        Fri, 23 Feb 2024 07:24:23 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:25c8:f7d3:953d:aca4? ([2a01:e0a:b41:c160:25c8:f7d3:953d:aca4])
        by smtp.gmail.com with ESMTPSA id k20-20020a05600c0b5400b004129018510esm2679782wmr.22.2024.02.23.07.24.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 07:24:22 -0800 (PST)
Message-ID: <da7bf64c-47b2-476f-8df8-8926e9d55121@6wind.com>
Date: Fri, 23 Feb 2024 16:24:22 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next 07/15] tools: ynl-gen: remove unused parse code
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 jiri@resnulli.us, sdf@google.com, donald.hunter@gmail.com
References: <20240222235614.180876-1-kuba@kernel.org>
 <20240222235614.180876-8-kuba@kernel.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <20240222235614.180876-8-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 23/02/2024 à 00:56, Jakub Kicinski a écrit :
> Commit f2ba1e5e2208 ("tools: ynl-gen: stop generating common notification handlers")
> removed the last caller of the parse_cb_run() helper.
> We no longer need to export ynl_cb_array.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

