Return-Path: <netdev+bounces-166499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9A7A362F9
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 17:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26C3B3A5A9C
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 16:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0B82676CE;
	Fri, 14 Feb 2025 16:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EHcTh8yM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033452753FD
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 16:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739550235; cv=none; b=C7OcHL1+8fOKXRY+a6gIRlNupDY2o7J5xzmy0qec2KvbQPXJXFfo/Du2xgfdIxRAsUFWeb+CVSohAzbvjV7KcBzSaeS8ufE9+xBkuR0K2d4hkigLf5ARxuHaHB71tLCvbztaHjZIPhBxMaJegRzzHz+KCBcN8GqEpeuT+mqxJnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739550235; c=relaxed/simple;
	bh=8Mb1gopNuJ3swCluVTerdaKmSaePf6NdOwg7SyWm6eU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=I3dow7NscLEK1pcxyuhYcR1pn8VEOHHjgx/STfh34CuliW7k0gcPSBcP2e39vRPt6O+1dwqN6Nf9dUJ86br6nX1+9F9XZlBEt3z0h79aEqZmRrwg7H53AR1cvsxGrlRjAj3a1k+ql1TFxUhwGh2PN2TENX+iFzG9qHrt+xtXhS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EHcTh8yM; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38dc6d55ebaso2202211f8f.1
        for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 08:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739550232; x=1740155032; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R8b846e0yOvqew9DqyRWHkZ4zUUK8Zjpqn2sr19+fzA=;
        b=EHcTh8yM1dw18YKV13yqtpOu6TdpiJRY9a8jQ8eFjhpMIEX6b9UTp3Av0fv7UE6664
         KJtZ0n9MooYIfdTcNFZpGYz8YutfV3TkW3RUrnhDYokQX3nmodEdrJ81YWYw8j3mnn4O
         4V2oiWI6tpq/GzeLkmdkpCzEdf0+Kjn1ILpEiLWEvcpWSKjrHXcGXEDE37PnAvfzzXG/
         MtndGhUeTuM0S5IdtRgJ9lJAfrs/1ozFLjM+zLWiFXWrgaumzQKZQ1Jlg/6WKN91bZb4
         WfbG9KNzxeSaO3yLEoF7z4ZJe3gczGaM4qKpMuQb55efc1vVplz2Xp22diFAZFD9tdnH
         pDTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739550232; x=1740155032;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R8b846e0yOvqew9DqyRWHkZ4zUUK8Zjpqn2sr19+fzA=;
        b=REUMCvVR/YrkjZNF81Qfno+TJPqzqpyTa4xUmazx0a5xkXvRZvsBrMFgRtZ9Xmshjk
         rOeSeK3p1oEEIQMVsns+Uj2t7hm2BJd+tzqA634MgLiynQvOivGwI3E6Vi8oyCn5A9OB
         dCM1XGlB36IiVqhjcfNfblr8gt3vU9zWm+gHRJLaoVjjPpGuLNICuN8IymZFX+1zpyZc
         3bcaNR/EUGGM2Nxv3TaCXXYDiMO07RDbZVouEnj3pCrEldfR8TGfOnKwEuMCIKmv67Pz
         zJIGz+ZMtvQ/XMLfyHp6L45EtXQ/n7oM5gl7+OBvHN4yQkghTZMjbkhtxz+HDvH2MENT
         A4Kg==
X-Gm-Message-State: AOJu0YyaZOowB9tuQwPhR1G5TTj/dzXjJoJJHluSCzhq1wZZRAZebK4s
	98+sKI7tP5fdnlZ9JfjlESz3Mp/euXpkq9uOfRgy82yQSTXAdcRh
X-Gm-Gg: ASbGncvbgvR5t2euv8VWJzcIE77/qzXPn0ytorPcs4s4YXmQTOzYslSYr2HJevAqsFD
	SckjntfgOlKpJkDxWGzWjU/tkFXmegeDTqd3f5FKmwi+ivnLKueyiWLKxF8W0LQ7T41WlxXaDty
	ARoiLKpowIi+rrW7wCNP2y863LDzCrtuXQKWwq2ciMG29bKFKokfd3Ru1/G6WtGrOMTLjWrIAiz
	Og3i9Jl6YeRqQLhKrqYKrGG9X8quBRVfvDOGocKu699jGUhQWwSz8ccZVH7/FDnS2uI/8NmdpHD
	fMvfKU1pP/kZEoucRdu8t6Np4lE2RXOgRJk52ZdiNJ0uRVHTJXWaANTid1j7xKi5tTG9BkATzrg
	LkAs=
X-Google-Smtp-Source: AGHT+IGdLO1vOkrWwTLzshn6PmD83mUYlM/8U3lvhCad+Lbpanql70lebcpQJrO+PzQvU7wBZaIrGA==
X-Received: by 2002:a5d:6603:0:b0:38a:4184:14ec with SMTP id ffacd0b85a97d-38f24f06c50mr8580775f8f.1.1739550232100;
        Fri, 14 Feb 2025 08:23:52 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258b434fsm5109055f8f.16.2025.02.14.08.23.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 08:23:51 -0800 (PST)
Subject: Re: [PATCH net-next 6/7] sfc: add debugfs entries for filter table
 status
To: "Nelson, Shannon" <shannon.nelson@amd.com>, edward.cree@amd.com,
 linux-net-drivers@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
Cc: netdev@vger.kernel.org, habetsm.xilinx@gmail.com,
 Jonathan Cooper <jonathan.s.cooper@amd.com>
References: <cover.1702314694.git.ecree.xilinx@gmail.com>
 <fc28d967fbffd53f61a1d42332ee7bc64435df7c.1702314695.git.ecree.xilinx@gmail.com>
 <ed7a2ffa-bfc9-4276-8776-89cafa546ef8@amd.com>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <235217f3-97fc-9925-cf9d-7ebbb77f0487@gmail.com>
Date: Fri, 14 Feb 2025 16:23:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ed7a2ffa-bfc9-4276-8776-89cafa546ef8@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

On 15/12/2023 00:05, Nelson, Shannon wrote:
> On 12/11/2023 9:18 AM, edward.cree@amd.com wrote:
>> +#ifdef CONFIG_DEBUG_FS
>> +       table->debug_dir = debugfs_create_dir("filters", efx->debug_dir);
>> +       debugfs_create_bool("uc_promisc", 0444, table->debug_dir,
>> +                           &table->uc_promisc);
>> +       debugfs_create_bool("mc_promisc", 0444, table->debug_dir,
>> +                           &table->mc_promisc);
>> +       debugfs_create_bool("mc_promisc_last", 0444, table->debug_dir,
>> +                           &table->mc_promisc_last);
>> +       debugfs_create_bool("mc_overflow", 0444, table->debug_dir,
>> +                           &table->mc_overflow);
>> +       debugfs_create_bool("mc_chaining", 0444, table->debug_dir,
>> +                           &table->mc_chaining);
>> +#endif
> 
> It would be good to continue the practice of using the debugfs_* primitives in your debugfs.c and just make a single call here that doesn't need the ifdef

I'm still in two minds about this.  While it makes sense in isolation
 to do it that way here, in the following patch we add a more complex
 dumper, and I think it makes more sense to put that in mcdi_filters.c
 and have filters code know a bit about debugfs, than put it in
 debugfs.c and have debug code know *everything* about filters — and
 every other part of the driver that subsequently gets its own debug
 nodes.
I already have some follow-up patches that add EF100 MAE debugfs nodes
 which also have custom dumpers, but those are in a separate file
 (tc_debugfs.c) because there are a lot of them and tc/mae code is
 already split into several pieces, whereas I'm not sure whether
 adding a separate file for filter-table debugfs code really makes
 sense, or whether it's sufficient just to refactor this code into
 a(n unconditionally-called) function that continues to live in
 mcdi_filters.c and has the ifdef within it.

