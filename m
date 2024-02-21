Return-Path: <netdev+bounces-73503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8268585CD24
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 01:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BA0B28698D
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 00:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07AC81C33;
	Wed, 21 Feb 2024 00:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nLeHnXDS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F514A2E
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 00:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708476757; cv=none; b=AbpnAnrmP3TwqQfJL9AkzqaIZBp/H0MjxwXjiL3pGuJy/vyRLDN4jjhsHR4Pvgm4oFEwVtiuH//ZvzTzp2GGu2Lx97gBBZyz3uJqE9mJb5ORTIT+Teg0iOtNuZh1p9gDysq4uSCEaCxaaT37vTzSgMkW5t/+ux7vzm7F3HWhCg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708476757; c=relaxed/simple;
	bh=J92N7oppbKokaymoordlHfEGYpccRePizL+hh7TZ1dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Klh/orqqf9OZ0BbwLBzXoUAnEGxcqJlXteF6rpO2K+1qn5QNneJRob6hJzvkcw41v8hghN1ay9+Ep+nerqZEOwMSvalf3JILdV8h1Pa4zcg8yxeq+iEpggIrgEEJ9fZr3rzeIjd8Bz4xh5ynHerGXasrSZEX1Xg7Sz62JH3sYik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nLeHnXDS; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3c15d1bd5b1so1934327b6e.1
        for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 16:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708476755; x=1709081555; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R+X3D1ev8b07YP6AkHk335qZFq2tm6Peno4gQaQD+cI=;
        b=nLeHnXDSkzY9OXSC2jWJtHHRiimsg/sJcZdHgcUYmA5dHoJT586otcHXeGWqXqjr4f
         ijDM2RHzxgZDdjyL7NYFnVKZxnh2cpNsc+n4+VAwelNtbyQbGr8vwfBA33Zz32vCdWix
         rOMbdsDUdXEzGH7XbVr2MlNsFHI4q6p+8geCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708476755; x=1709081555;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+X3D1ev8b07YP6AkHk335qZFq2tm6Peno4gQaQD+cI=;
        b=lnB4mu283cQyArc1uo4viudSptgFlf1Z9LyijbG2xe+Ytbc80xBk1hWyrrKTF2ovvK
         SRZRRH/e8AgG1cJ5YYtHsfc875D1Pd8UuQF0bp+Ykxq0M5gHftrzNicO/DE+Y29D6vIE
         dMbrJpOHijsBdUQkxipY6qHr6pPht3Jnu5UW8QVLSuAMWdy4ZNbsexuGavDStrwuARsP
         TnTFFUCSFIsHu4+B5u3eblstIUjPfTkoFqLdTPJNqibFL2AZUunNv08xSpqFvi44Th3v
         i7FJsy9x39itm7AARVCekkY4U1+x1L8CFR4bFqDV1B1+JdH+knzspOptczf7mJtQCGs7
         DYnw==
X-Forwarded-Encrypted: i=1; AJvYcCVIFPAKJ+ClmnULXu6e7Y6gWNoVbg+WuS+4FeZ9LfC5+ZhZZ3LiwPjvJB3tiHNkr1XV7fWRbTebsefZukOKvRx9yEiIh7k7
X-Gm-Message-State: AOJu0Yw8PofBt3Dsq+951CfaYQC0Ly2AxLeQDSFii2AjxOmWThgF6s7M
	Huv7DvI2uXMjVpji36cNKAcaDsTgUfHi2HxbWjWwWH3gIdqwMtZqXRMmQTeoNA==
X-Google-Smtp-Source: AGHT+IHQovIj/E8PPhTSxpkjPpb9Wj6cTXiVUJOisMr+S4qxc/4l1FXONqKBXYMEfc0hZP57LGgaUg==
X-Received: by 2002:a05:6808:f08:b0:3c1:57a1:bb87 with SMTP id m8-20020a0568080f0800b003c157a1bb87mr7875013oiw.19.1708476755611;
        Tue, 20 Feb 2024 16:52:35 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id du22-20020a056a002b5600b006e45d5f0645sm5211431pfb.101.2024.02.20.16.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 16:52:35 -0800 (PST)
Date: Tue, 20 Feb 2024 16:52:34 -0800
From: Kees Cook <keescook@chromium.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, mic@digikod.net,
	linux-security-module@vger.kernel.org, jakub@cloudflare.com
Subject: Re: [PATCH net-next v3 09/11] selftests: kselftest_harness: let PASS
 / FAIL provide diagnostic
Message-ID: <202402201652.599B4134C@keescook>
References: <20240220192235.2953484-1-kuba@kernel.org>
 <20240220192235.2953484-10-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220192235.2953484-10-kuba@kernel.org>

On Tue, Feb 20, 2024 at 11:22:33AM -0800, Jakub Kicinski wrote:
> Switch to printing KTAP line for PASS / FAIL with ksft_test_result_code(),
> this gives us the ability to report diagnostic messages.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

