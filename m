Return-Path: <netdev+bounces-73498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB36F85CD10
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 01:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 215F51C21FC1
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 00:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D928566A;
	Wed, 21 Feb 2024 00:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ereX/gIX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B335553AC
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 00:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708476657; cv=none; b=SasUOyjmOc5MuyKW7jMR8sm6UKT81WoB+ACVD6GxZJ0dF7mnmKQptaPoD4zHRfT0UW7v/Zs0G3pXdmBVDDkEoiA0L47Sl8dYwEoPMhEAxbqUM12s/vSObQNDUxLZbesNppCCnYH9LzmTdFe/C7rv86FN9y39tPSNc/sJhcyHDfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708476657; c=relaxed/simple;
	bh=KtI8YpdPtPNZvgfGsG2RYyLLgUPuNNI+HpwhqX0FHro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LOSPExY6WkWbOEdchBmDG1vs6+Noq0cyFko7lQ7rSd0LHfWYT/cqy2qOc6e85cT5tuXPnsh5LSDEwEVJd2hFMRnZtL/F09OSlDvX4ILltdDSm6koyZnTqCA1TdNbI8Z/5fAXduXc9MXnQuD976N9nH8Nvf4Z7B/TRfXsTCFyl8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ereX/gIX; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6d9f94b9186so85729b3a.0
        for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 16:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708476655; x=1709081455; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IElk/Iax1+PcU/0IwqEjxw3cTNa/0DdIWNZolixvAtE=;
        b=ereX/gIXiESq449pw9N9E7dYOvH5YqaodkVWsbN0B+dVilQCcZoR7fz1KLpA681/B+
         7oOuVWvQXEueUqKzUyKgXVKMzqvnk8iDtyrIqZt5mBXNTVQF3H4qpqn+DoDsTHf+IW0t
         ddWoX68kH4k83fp8UhfbSDkeiGIzRqNHI9hlA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708476655; x=1709081455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IElk/Iax1+PcU/0IwqEjxw3cTNa/0DdIWNZolixvAtE=;
        b=oS6JKqjrJOUmnJWqZko/uq9gFQMtlZDKrxhGwR8zMsSOQfyrGuTC5ZrJ8R0YPSFdnM
         orNctJ595UyBl6n9aDBgg2NVxDPLt93NcWfxGwUwMh9Gef9VIZVeqIIY62+beCsD9c2h
         YnETLauC1abaC/hee1AV1PkJg6y+RUwW3BBh/xJsOUwjtjokQpfZU4OO0Mo55CQjaezN
         KDru1qjO81SC/6Y6eZnOo+s+cSRwQDsf/MB9aKoRGsbFLgroHCRU7s3/M4E4TbU8LHFp
         CZi5VvT/mWvOoYNKHjOtiynYcwHWOMyKJjMkjBZRpitQrxQ8hFoYQYUoCcUrBtXTXeUv
         PJwg==
X-Forwarded-Encrypted: i=1; AJvYcCXNPpJB6jF0nJTLIr9v1WxYX0xcpBzkNHQMWSkGc82f4Jk7QYgdnVTLKI+RYEFyoHFQLkFv1oECHgi9/s0AVddcH+WNzF6W
X-Gm-Message-State: AOJu0YwtkZrgU/7ASoaMn5nDxwF+I1oWPQCQQgoMD+lJg8aDTOw+6FDg
	E2H5rSKvCpq/52wKPcXfdMqRC2zZxR9xMISrbMeWLGHyYcmfQchwkG389GVUIA==
X-Google-Smtp-Source: AGHT+IFydLljI0+1fERqTi4GrSUTYDSiGotRT/MZd2H3qgqkAeKhRO7bajUjsc33vF1/TfIByoUI4A==
X-Received: by 2002:a05:6a00:a8a:b0:6e0:92c2:c3ee with SMTP id b10-20020a056a000a8a00b006e092c2c3eemr19648727pfl.18.1708476655117;
        Tue, 20 Feb 2024 16:50:55 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id le8-20020a056a004fc800b006e47e57d976sm1924898pfb.166.2024.02.20.16.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 16:50:54 -0800 (PST)
Date: Tue, 20 Feb 2024 16:50:53 -0800
From: Kees Cook <keescook@chromium.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, mic@digikod.net,
	linux-security-module@vger.kernel.org, jakub@cloudflare.com
Subject: Re: [PATCH net-next v3 08/11] selftests: kselftest_harness: separate
 diagnostic message with # in ksft_test_result_code()
Message-ID: <202402201650.37FA9A4@keescook>
References: <20240220192235.2953484-1-kuba@kernel.org>
 <20240220192235.2953484-9-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220192235.2953484-9-kuba@kernel.org>

On Tue, Feb 20, 2024 at 11:22:32AM -0800, Jakub Kicinski wrote:
> According to the spec we should always print a # if we add
> a diagnostic message. Having the caller pass in the new line
> as part of diagnostic message makes handling this a bit
> counter-intuitive, so append the new line in the helper.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

