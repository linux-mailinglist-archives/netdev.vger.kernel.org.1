Return-Path: <netdev+bounces-75567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A88B086A92B
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 08:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BBB51C223E1
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 07:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262E924B41;
	Wed, 28 Feb 2024 07:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ekf6E5pb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE802561A
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 07:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709106320; cv=none; b=knyy6nHgH1uAZ0iKqR84X3iCzuGX8SlGy5pobM/+3kliX+EsgjGED5y9qF0nC65WVAPSMIqYpzwmKzWUQuamD/oFAwQ9uxFzPt6NN992IynOiC0eTEyt1ve/H3+q4sqwRm42luMAM3sgP7D6tfo0L1b2n/jbS7yXuh4Mg9NcLQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709106320; c=relaxed/simple;
	bh=PDGWZYI7XTytYoNfnH4OuJtD/apsYF0M6/Szp6Lzk4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fWwiEnuAI7slZO/uUXNijNf072nsegT6btEMQB7cTdU1tbX+iSvkKeQvK9QP5MpYAiZoPSe0Ow7p0qGqTn5s1D0aT8d7yxxTzp3MVsJBpCX22CU+6G4eLS64bNUd57VFPi9rMA/mcO2zOToKvZ3+hohNHAC/0tXojWBU6KtB7fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ekf6E5pb; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-412b40e023dso2338855e9.1
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 23:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709106311; x=1709711111; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PDGWZYI7XTytYoNfnH4OuJtD/apsYF0M6/Szp6Lzk4M=;
        b=ekf6E5pbVrzde10ZpiEvsjQm4WJ/9RkPUTisOcwCdlq0MLM3xxl+e46o8iNks1DUgq
         zFgHoS8VPzqFyHct+dtnjp+p5aK7dbnxAql+BEj2oXBs/POW+Mrc9jEV8bA/3KaddATU
         tLJKhejn2exaa2nriSMiW0U3B5bxVYYc1AgnsVumO546iaMGJ1Ouzf4lyBMdl1+TLRZU
         kCNQPK2EOHU6vwp5E0IrzsqiWE4wXKW+ZnH0Hfv7vXGggSFRmgNWY3DsuOuRgglAFg8o
         csXzHxxTxtd7XeOga4peZsgN9XJWtFx5IKT34tqT1nUK3Ou985kQ8U9oa1I8l+Tet1Ja
         6B+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709106311; x=1709711111;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PDGWZYI7XTytYoNfnH4OuJtD/apsYF0M6/Szp6Lzk4M=;
        b=umd8Edgts8e98KqoNN41DFNbf/ZnEvoSIf+brVDlBke9M6UnSgyXOMfyr3+Gkevy8Z
         MMkPtKfaqnIN1Vyv23Umk4mH3n8M+lsCQj18P4JN+YeVlBoVxDjc3LMsP0J1/fIOHGVi
         xx2VAsgbfLUw62zRMweek3/WXIapP0RfSE2JV4b8IRCRdzG0XaECoRy/AAiW9LEG3xJm
         jrjCi9WQSqOYX7sfmPL/zq3RPeOlYN8TPcndYt2doDYYRYKpDsbmgzVb9TJCym1lgZmb
         c649uCQzgXtI1EvduVNoE86ya+LV5bj6aTfMFq/Pjc2Ba10GUQMEu0zUL16WBoyWj14C
         IDdA==
X-Gm-Message-State: AOJu0YyU/D97ALlPmqikNlmccjL0GOLVJAuBHclj9FzKcY4dfFS9l/la
	P3m8v+BjoqblavIiKMcTVQg7PZ/DKKrlI+xOTQLFMrdh3+lz+0E1LWRWQ1Kp23w=
X-Google-Smtp-Source: AGHT+IE4vuVdBhIbBVJoul1wWlm3G4G4KVTAIg4t/bS77QrjKUYh4ThatUElxNfZPlxOr4dlU8esKQ==
X-Received: by 2002:a05:600c:548e:b0:412:a109:5005 with SMTP id iv14-20020a05600c548e00b00412a1095005mr7133470wmb.0.1709106311255;
        Tue, 27 Feb 2024 23:45:11 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id v10-20020a05600c470a00b00412704a0e4asm1205125wmo.2.2024.02.27.23.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 23:45:10 -0800 (PST)
Date: Wed, 28 Feb 2024 08:45:07 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Zhengchao Shao <shaozhengchao@huawei.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	weiyongjun1@huawei.com, yuehaibing@huawei.com
Subject: Re: [PATCH net-next] ipv4: raw: remove useless input parameter in
 do_raw_set/getsockopt
Message-ID: <Zd7kg8QurFt0HmWz@nanopsycho>
References: <20240228072505.640550-1-shaozhengchao@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228072505.640550-1-shaozhengchao@huawei.com>

Wed, Feb 28, 2024 at 08:25:05AM CET, shaozhengchao@huawei.com wrote:
>The input parameter 'level' in do_raw_set/getsockopt() is not used.
>Therefore, remove it.
>
>Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

