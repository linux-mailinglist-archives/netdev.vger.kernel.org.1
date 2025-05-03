Return-Path: <netdev+bounces-187587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B36BDAA7E6C
	for <lists+netdev@lfdr.de>; Sat,  3 May 2025 06:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4106B987104
	for <lists+netdev@lfdr.de>; Sat,  3 May 2025 04:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2178144C77;
	Sat,  3 May 2025 04:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="aI2apliD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C005F46B8
	for <netdev@vger.kernel.org>; Sat,  3 May 2025 04:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746246708; cv=none; b=pifiOEk7K4OQKTH8RLO4wR2ZnEECP9Td9VANDzPTZ+Fp+gGdHNDvX4RMeiV/E32w+W8Hi7ftvBq5R/y4N+kN1H9tYNzbscrnih7wWvWKEnYwCZXF9E0RpkmMr6OAT9QxOjBe6Ey3JNTcqGVTNFDIlHanFNyDONZM1akZbArILCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746246708; c=relaxed/simple;
	bh=vgeOEO4mmRTbNiau2oWiHylBSaTFuLm1/wNsRgxbXB4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ompk4F+rKAlFWwzCOMjNShsodpxwNtVuN4Pau5NkyliPm9tJEEg3XYEYa2GlB+uILmsQEEZCkEWl60sjkEO93qlke8lrrcZsWchvvmEtXs4/4J6KrxrNgprBxaVxR/9afBy+EPbCbNAgPO8kzKmD4Qzy5nSJ2LBggqCoqS+oYac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=aI2apliD; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2255003f4c6so30384295ad.0
        for <netdev@vger.kernel.org>; Fri, 02 May 2025 21:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1746246706; x=1746851506; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CpUkI6245kHsPqlCkZyvAf3355FDSMSSB7t0mD6h4Yc=;
        b=aI2apliDRHCb7UgUKXoEdZ2L4tjtCD0weQ1hmfwWnKm9q+NPVOXlbVA/j2h8tVagu3
         ZrmpSbflLtz4c2eUN8TD7z6x/nYsqCorLUeKIRVHLX10kiMCEyFeYuqPQelw7xkqD1EW
         TiA6fZLLlmRQmr1xwV0zD8ytovUl8ufv5bo7elOPhCLlcoGmpkURjyGC/eE8FBRxP1hG
         6U8UMeks8M16pNph+8Xu5BygYDTO9DfHgcyYKvsvqPb8W996ftCEWhRr17oSt2bCgsQk
         Jn/WFpxFyx4T22fI9yi3BYXvXtS9obq/6ks4TvG++DFbYzXbJXeeoh2x8apwz4GP/s36
         b9Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746246706; x=1746851506;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CpUkI6245kHsPqlCkZyvAf3355FDSMSSB7t0mD6h4Yc=;
        b=lDIQC3yB0Q0jpdbPx7g4/wQ2qc0FGM0ZubeKq36zwx0/JyvSpUqSvJ0kUihnUzsbdJ
         ibGYjy8BMblCdcvmzSMAFcovX0VbzqaNNfleuIi/nwte+nUg7QjaQtNR031ofH86Nk5u
         QWocexojqxwMW44383+JqPdMYrkPYFrilzy/pMgrDw8FEp34cssl1p2w4rw46BzHeBog
         dwefryU6oZIKQxUqpQOjxEkJ5EgJXN0fCTrguS+B4ACPuj1rp+3pmHw0cTMlJlvaHX33
         Ix2wrZo7iKuzbdkSGK3tfXT356XVMggu51xmIQa5EI7dz0lKfHSNEvaedmIK/A/m7Zfi
         81Fw==
X-Gm-Message-State: AOJu0Ywf3f3N6o/7iUOrjid2+btkTPIFsVblW09QQBJeDz/tjaVW4GVt
	Jvw4tzukxhrWN3B/cUwL0TAkYz2+IT+EnxsjY351XX+5cQgTb9KO8/tepEnR+lDeyeXzr/uZ8HU
	vOCE=
X-Gm-Gg: ASbGncvN7hzSBC6262nd0Mve5ZKXJkY8xtFwT1lGcwOklfM0qHEYmdQOy47jUtv6594
	V4r+kwDfiQv9hYzyj6HSkZps83uxXjO6h1E4xjHVVanhR1ojs3Si4HvN/jVG8ZR3NNxdyzkK3qD
	JuTUcTdPcTarNMWUzmjTdWT3BhLskLrK2aKy96oxxaNgxIEAcdVao6Nv0Z+TkG1LsRXYUo59i3u
	+7huDemNBog70Twmf3r9jWCVsZVYKSc/Nu3ES1Cv048uzYZGrJlmVYwWtLleQdqSMvw1X5KjDi5
	YEseKqk2d8To+3CjpfTO+tHKDzD+sfsiah8owW7X1CcThvZeuAz/vzUK+g==
X-Google-Smtp-Source: AGHT+IHUPt79olq/5A1vmuGFPYY1phtnAD/VnJ14B7q0tr8yh9vS00b3kmMRGrJXnmqI5+jYEe0Z5A==
X-Received: by 2002:a17:903:234e:b0:224:26fd:82e5 with SMTP id d9443c01a7336-22e1038ea74mr83401265ad.48.1746246705967;
        Fri, 02 May 2025 21:31:45 -0700 (PDT)
Received: from [192.168.1.21] ([97.126.136.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e1521faf1sm16164895ad.129.2025.05.02.21.31.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 May 2025 21:31:45 -0700 (PDT)
Message-ID: <cc7417ae-113c-495f-9487-b2e42a4ade95@davidwei.uk>
Date: Fri, 2 May 2025 21:31:45 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1] io_uring/zcrx: selftests: fix setting ntuple
 rule into rss
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski
 <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>
References: <20250503043007.857215-1-dw@davidwei.uk>
Content-Language: en-US
In-Reply-To: <20250503043007.857215-1-dw@davidwei.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/2/25 21:30, David Wei wrote:
> Fix ethtool syntax for setting ntuple rule into rss. It should be
> `context' instead of `action'.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>

Sorry I accidentally sent the wrong patch. :(

