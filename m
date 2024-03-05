Return-Path: <netdev+bounces-77285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC858711FC
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 01:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C0091F2402C
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 00:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837D563C1;
	Tue,  5 Mar 2024 00:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NpFoVN9t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09084C15D
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 00:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709599784; cv=none; b=EJ5lrO+VvgOMLORzr2cs7eH5fhio6ozkv0TkKbI77tz7mnij1zrogdYpC1m5Izxp7X6m/Bh744U0KJBHhYIDxSkDim1QUcbGVzp8oGO0Ovx79r57dODW0zUpeQDzk++QJAbdLATC9w6/2TMt8fSwC4ExglfcsCA7C1MDU8L5UG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709599784; c=relaxed/simple;
	bh=9WVlQmVptvNA8tbdEilwPjrt2ycYLORzWedBHBofGSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zi5RaPgf3/7phyutB+6Gj1hTpNheh8QOlUmGqDMX5aYkStxx3hHkHsqm7wK5ulHHwHwOB8vMXMmDYNRb0GKwpLxe90l7AGe0UIev5L24iToM8TqJWO2yozErGo3Wq23byDKAZJQ1tDcMACCfBlYQfE54Eys+rDUOFxF9DkYfG18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NpFoVN9t; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5dbd519bde6so4468432a12.1
        for <netdev@vger.kernel.org>; Mon, 04 Mar 2024 16:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709599782; x=1710204582; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pLTHWOpwORAA/6xhkm7gAcsqrhyIQwakuqBmkuchlIE=;
        b=NpFoVN9teorfGU/KF65QcgFEwmqsC/EiY5De8VN5YHYgB2oCt/jk6DGJzjEAtvHtP6
         JOoIwGoIdzTx9G3OKy5tuXpzZg+BEYtixuhixuE91x6nvC+jxRUwwxvwbaiXjDmV+1fh
         YmoJa0vgId/sw/tT8vw5ynV7WleqtWRDRQHOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709599782; x=1710204582;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pLTHWOpwORAA/6xhkm7gAcsqrhyIQwakuqBmkuchlIE=;
        b=SRm3L4m/uk5e66ULnCQrUnSFejRAoXUxbNPsSn47VFqYBJmQq6zBIe3uVgsU2+aD++
         n3bh10gQnFOI+NKYC2unhrR8Kwa371yPfZkYToWbzlBUjxn4A6DePPKlsGuMerGUJ2fm
         AVqloNDPI7tYtz8avwdDJD2biWARLSxwbbojdCPO0zlmZwlUSgLVNqZcM2qamseF2Rf4
         O1m9RMpjvsjlck4L3vVj9aqx3fOJ6CSOHtFyPU1WmpspTYk+ZSqHxwpQk+cnoyGz7Zr5
         MEPlTRHdMzSCUw+NWNOzrSzQGkNCMYgZ5cN7inFbNNwtD23qowPAVKlQRJhIm7hRUj7Z
         kSeg==
X-Forwarded-Encrypted: i=1; AJvYcCVi9EILwwVPQaclE/z5iDCR36/9cqbFk8c5R7s1DCTnclkG6IxaYPzV8uBJJhqlGCdX5y/53DH7LMV4eFgViNJ+PClWbErF
X-Gm-Message-State: AOJu0YwpAxJRBsLhUTjH0Fwy/aGfBnKQCFUKP9rhe65rrTw2q/b4lseH
	SnjKCKvMVQWJhhMBtwrl9guXE5fLEZxZHQfp7KIoLRtv+huH+LEy8gd0hFvnhw==
X-Google-Smtp-Source: AGHT+IG+PWHRb3lwWh5ITo9aPOQFlQpXHSOSLQf9cGB4/pQxqAA6tAd8JXNzvJhOfi9TgaJTI+9rJw==
X-Received: by 2002:a17:902:6544:b0:1dc:7890:72d6 with SMTP id d4-20020a170902654400b001dc789072d6mr369728pln.22.1709599782309;
        Mon, 04 Mar 2024 16:49:42 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q17-20020a170902e31100b001dbcf653017sm9156081plc.289.2024.03.04.16.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 16:49:41 -0800 (PST)
Date: Mon, 4 Mar 2024 16:49:41 -0800
From: Kees Cook <keescook@chromium.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, Mark Brown <broonie@kernel.org>,
	ivan.orlov0322@gmail.com, perex@perex.cz, tiwai@suse.com,
	shuah@kernel.org, jglisse@redhat.com, akpm@linux-foundation.org,
	linux-sound@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH net-next] selftests: avoid using SKIP(exit()) in harness
 fixure setup
Message-ID: <202403041649.51EDC22DD@keescook>
References: <20240304233621.646054-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304233621.646054-1-kuba@kernel.org>

On Mon, Mar 04, 2024 at 03:36:20PM -0800, Jakub Kicinski wrote:
> selftest harness uses various exit codes to signal test
> results. Avoid calling exit() directly, otherwise tests
> may get broken by harness refactoring (like the commit
> under Fixes). SKIP() will instruct the harness that the
> test shouldn't run, it used to not be the case, but that
> has been fixed. So just return, no need to exit.
> 
> Note that for hmm-tests this actually changes the result
> from pass to skip. Which seems fair, the test is skipped,
> after all.
> 
> Reported-by: Mark Brown <broonie@kernel.org>
> Link: https://lore.kernel.org/all/05f7bf89-04a5-4b65-bf59-c19456aeb1f0@sirena.org.uk
> Fixes: a724707976b0 ("selftests: kselftest_harness: use KSFT_* exit codes")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

