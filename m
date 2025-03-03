Return-Path: <netdev+bounces-171402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB805A4CD98
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 22:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E53871719E2
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 21:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666E52356B0;
	Mon,  3 Mar 2025 21:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NjTUyC4t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7826230BE0
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 21:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741038056; cv=none; b=nYW/lvRHySaKnpSICVqbGCiKGXqV4wQBx7dINVnWtzzozNdIXE1flJq/PTL+PGxYyPxxYD/SmTGVmdzbOFkFXm5zeivMOUXXucMvCRu2dMdmcDlyOP79qVHhyo5+B9ErqZfoVPTQ3/Td97koFi4n8bbmCR+/DVQQ0QIDL5zbDZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741038056; c=relaxed/simple;
	bh=t48prv4ltqZBgmpiT8R/ZTVb9z8qZJulguu49one7U4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IE4NgKq36k9wfG2UUuLjMPev7mEFwxsT+Prfqs1hbD51p25K1/yUiSt2UJb0hbejrIpPZBXssLsmBvjdYWB8l/4NHJmVY1OCTR87EH+8Vj+DlJO3awrz3cLf+NNEVQM7e06thL8/TOi31Ov8q5XHKmsgvpYmTQjXp5NMnHqheG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NjTUyC4t; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2237a32c03aso15745ad.1
        for <netdev@vger.kernel.org>; Mon, 03 Mar 2025 13:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741038054; x=1741642854; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=//CA4dP1gRO/1RNRixCqJrbqKaw0YXw5wU7J/MVaxKg=;
        b=NjTUyC4tnMMbS2ZkzEQu+tumClDu5ho6F4m5Q+WN1K2Va0/uPSgzO5AEhDDBekPa6L
         Dah8MBZnU/1mxnVqV0WmA7JTbWKPXkxxuMDFW7tVBm/Rv+0nTucILMzPqN4JE2iRI66r
         +QfJWlBg/iWxfeOt9MT/kyRgayw+yR3ksBXyZ42ySyZmAx9NbTgZpxiDDqpcDfJrJBVU
         wRyC6H1r76w+vpTCeIcOHPjg23ND8SxN8dqGGN/A4YGaHlmdZmPvi/BRk5Xk+u3sklBz
         efiGFYH6bQMtDebloPlYoTJbhviL+fdn5Uoet5qVvEjdHuvAGQGiU4Bv74Py3P9tdmK8
         XUmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741038054; x=1741642854;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=//CA4dP1gRO/1RNRixCqJrbqKaw0YXw5wU7J/MVaxKg=;
        b=IGEdsULIvItvpf94XRW37saeEt8sRwRek7vYFMz7GUFXzVp1E3uIsQ0nQErtY5wuW6
         xdEgiE5dPziZJXQu3fm6WLYE+FKaQ+wzWZF5wRWj/9P5TqB0tRmjWc+2LLRwHEqg3P/L
         gvNxbOHhtEdV7ZnYfcAbBx7fDD0RmNNmrjOSsQWmzfteP40eHw9ynN/Knogg/NcccU/a
         zjuiRFEtStzRMRijYcfJdsspUk9ztgeKZzWlMzdIJar9Gww2txZOsag1sXYUSMGbiLyQ
         56yr3YAzQGSRSN7B+nvB528r5yMf2Ty43PYTPDpPqKhgmoIM3zpjcWRQXUy/gYdCuRu1
         Xgwg==
X-Forwarded-Encrypted: i=1; AJvYcCWvjFAAphEXGl0M0xe+D+yzhe/u/ArK1a7UVOqPhrw6vaLGGgUIq/ju3b2cd+jS7rmm3poKRQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF3Zlq0NFjzR9Cko6tXsjBz9ZSIex4/niVX77tERjj8bi9Dw7D
	7CEJyTY6XxWpp/CD8nlenH5b/bujNUyMeF9ja3I32MxA3AnRXVmTBJIxzDUTJg==
X-Gm-Gg: ASbGncs/6YpiSuK5hLswNTJLuPsOXYDW2PiMFTRMsnO3iZUb+N933VniMDWlCZeKsjq
	QHnUKFoU97RtR6rmnReWqJCpV4eeeoqCh5WTmTCmGrfFdmBlwviky5Vn+w3k1I89UKUeTP+iLG3
	pvKEl9VjXz8UGLHilccZb4pC5VzmGAYCHgTq0JmJPRQAGBov0bbxxi1ZxES+eg0QV0wVenXzJaD
	qeMJYWZsCqBWJM+e67ZW9LclfWx685hlO4ctLPDcbIeACO3bbQpL8yH8XPkXu5VM2WJcgru3+E2
	0QcFNiZnVSkXyeZzZ6hRLDFi3+hoC1q1K2PCr8I4kSUocNkmnTsrBpRQvrHyScnhXAi2dR5FdmD
	oXUEzmFaNsBaZFPI=
X-Google-Smtp-Source: AGHT+IEwj6zn3l1n1mEvrRIOd0S1KGWs/bgL/3cFaL+tQsr/6cABYrLinWLfgT7M2GWCtuDNAUdgLA==
X-Received: by 2002:a17:903:2592:b0:223:2630:6b86 with SMTP id d9443c01a7336-223db3fdecdmr77895ad.7.1741038053846;
        Mon, 03 Mar 2025 13:40:53 -0800 (PST)
Received: from google.com (227.180.227.35.bc.googleusercontent.com. [35.227.180.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7349fe514besm9424721b3a.71.2025.03.03.13.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 13:40:53 -0800 (PST)
Date: Mon, 3 Mar 2025 21:40:48 +0000
From: Sami Tolvanen <samitolvanen@google.com>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: peterz@infradead.org, rostedt@goodmis.org, mark.rutland@arm.com,
	alexei.starovoitov@gmail.com, catalin.marinas@arm.com,
	will@kernel.org, mhiramat@kernel.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, jolsa@kernel.org,
	davem@davemloft.net, dsahern@kernel.org,
	mathieu.desnoyers@efficios.com, nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com, morbo@google.com, kees@kernel.org,
	dongml2@chinatelecom.cn, akpm@linux-foundation.org,
	riel@surriel.com, rppt@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	netdev@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v4 4/4] arm64: implement per-function metadata storage
 for arm64
Message-ID: <20250303214048.GA570570@google.com>
References: <20250303132837.498938-1-dongml2@chinatelecom.cn>
 <20250303132837.498938-5-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303132837.498938-5-dongml2@chinatelecom.cn>

On Mon, Mar 03, 2025 at 09:28:37PM +0800, Menglong Dong wrote:
> The per-function metadata storage is already used by ftrace if
> CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS is enabled, and it store the pointer
> of the callback directly to the function padding, which consume 8-bytes,
> in the commit
> baaf553d3bc3 ("arm64: Implement HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS").
> So we can directly store the index to the function padding too, without
> a prepending. With CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS enabled, the
> function is 8-bytes aligned, and we will compile the kernel with extra
> 8-bytes (2 NOPS) padding space. Otherwise, the function is 4-bytes
> aligned, and only extra 4-bytes (1 NOPS) is needed.
> 
> However, we have the same problem with Mark in the commit above: we can't
> use the function padding together with CFI_CLANG, which can make the clang
> compiles a wrong offset to the pre-function type hash. He said that he was
> working with others on this problem 2 years ago. Hi Mark, is there any
> progress on this problem?

I don't think there's been much progress since the previous
discussion a couple of years ago. The conclusion seemed to be
that adding a section parameter to -fpatchable-function-entry
would allow us to identify notrace functions while keeping a
consistent layout for functions:

https://lore.kernel.org/lkml/Y1QEzk%2FA41PKLEPe@hirez.programming.kicks-ass.net/

Sami

