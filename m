Return-Path: <netdev+bounces-233660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8D6C17178
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 22:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34A9D188624B
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 21:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381832F12CE;
	Tue, 28 Oct 2025 21:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="J5FDAelo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355ED2264C9
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 21:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761688144; cv=none; b=OH4mQ1TR6A+AsIFCaGKVNX/JtNK6PBRjA6yplgeud2PajOyu3FwOjlH3tigLVYuRD57wGGuAhgUg0QPhCB6BIWuUF7BCEcxjoEBXEwYMfT3UA0lX7WXX7ONfpjWhCx0UnIylrY/YNB5QKrueG/T3ru3tZrrtTRY/sLpEv8aakyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761688144; c=relaxed/simple;
	bh=yXWQv5pEWWhGJWD8HuLexSuae2Oi5ITJ50rYOdCPtEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iEoYKxBZwgpiYhtoABz/ZrEH6QDYrlTVVV+Wf3npt8C/oNEw1zvemp0PXaOWzTsEt6Z2KFXRRFB4xZhSnHavRHJxH0gRvpGkuwjDhg0wuXQmrkf3blDvg+eHuCu2c4C/azpZ3BwWE+XoTVExxiVPyABE5Uo2cxiDqk6cX/U+eCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=J5FDAelo; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-475dae5d473so39053705e9.2
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 14:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1761688140; x=1762292940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aH+eIcCh8QSF1xXWTlSKlqYoUpBJQcwSPy1LqPlXAhU=;
        b=J5FDAeloph1ZMiGFKK4xi/fwusEl4942AuY0kvLED8oid3g5H5jsariGRZ3VDZb+a8
         8VVLz71UoWJq0BK3Vgy+9hdvKBTlp4Vm5GW5UoawaQQQmCGK+/6JOUCCokjmkqRoOCgf
         TDUEFs8j1BD7qkMVOvz2PUtANaJsjvNkprXai9hQ+A4vCpW/pMgcdZtIQ15W4Y5WR40e
         SeoIkmQd/dBdHuUJQD9AZ6Kbri0DYt499zt+iq+OGVDO2MmRHvnkyAbDZTYyEcglncNh
         M3SGbJ7NQmALEV+BHqycqQFcNjcyeo6nufUaxH5bBNFJv2mOTNBRU3LXjFznatxPtu4I
         /+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761688140; x=1762292940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aH+eIcCh8QSF1xXWTlSKlqYoUpBJQcwSPy1LqPlXAhU=;
        b=ZgNGJMn89vkXiG71cZCrBHZUZk0qIa96m0RB8i1FPF7p9JLHpjv7kPBKMFHNARdgiI
         F3Ti2Yi+76ffrVu0OQ2idZw+elPRUVNht8ZZjQiowaXbv1jEYtap5wbRPVffXgqD1Nwm
         qRJRmOej/JUuhj5J0b4Myo4x6K1X0o13DS5a+KYY2q1o+IH/mMyUKAlEKy0asmPOh3XF
         6FbkKao2ZZ54SXwtjjKYB7wNcfmmS+uW+FPJIskm/sft3g/nAYPBeEhD+bQCpUn5wYfX
         Up+iQMnMGJaQSvTS9iC2zdIxptP8jlpIUVUHWp0jlgrReNikTFVavSQj9G0ri4rT3sHJ
         3kKw==
X-Forwarded-Encrypted: i=1; AJvYcCXAvWJRE9/hm9heELxEhVIyIQJnziR0pd/m6tWC4vXBmdwP7fwbiJhJTt/X9NUlINArop3BppU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+ggC//kxiXj7MLOXXt5cp6H5Dcu+X3dQtfoUGxNYikrzXHHm5
	NNyv85FNZxBs+t36kbvzj8256ocMMhOYoltzKTnh1FoMKWS9DIlnZZ71lBjjFIRXcr8=
X-Gm-Gg: ASbGncs1mikmAoJNiWBmB/DhPp8Fd4cTPW4O2TRGu8Jc4JKLfX5w3a+l/TCcVI2zRBO
	WZNO8ggA39R1/QoowLLdcRzJk2csLwb5x6ZGi1M3tJBBCrN1E1FuLQUnKO2oJ5aJqrgUPeu5TxS
	gVI4xsf1N2OZIgqpFxCI0EKy/wYVpNLeZkzd39N6J5kZtKTzkRZCj7lfPiVBkQknkOdTyfnbg7P
	G8hMP3fLB58AknfTLk58c/AOJ9s6wHx0bzVqjPE7OhqOLARJ3xmAjQgY8GZAN7ZqlfeoRqd8iYj
	k89g+P9nO8TjitSgWu8WGE34xlRpkO8D87qnzsz9tSKdLXDtXxByU7TT/eV9POVb77+t0eZkJ0g
	sshyVpdq2F/wiFFVIzcC8ci/1677jnGeEn43um9zODxTDH365Lw/7YxXStbYtEnxwJnFbNuZXzI
	zbMGskrNBvve1ffIOcMTetTLTeyA==
X-Google-Smtp-Source: AGHT+IF6hxU9USpXbM0LLFfsCoDfhgqDmuUicDIZW/rOvAhruBbvjA5zvNGzzqOFBcPIxFW6lG+jwA==
X-Received: by 2002:a05:600c:1992:b0:476:929e:d07c with SMTP id 5b1f17b1804b1-4771e34aa72mr6615025e9.14.1761688140565;
        Tue, 28 Oct 2025 14:49:00 -0700 (PDT)
Received: from dev-mattc2.dev.purestorage.com ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4771e202182sm13125455e9.10.2025.10.28.14.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 14:49:00 -0700 (PDT)
From: Matthew W Carlis <mattc@purestorage.com>
To: gal@nvidia.com
Cc: adailey@purestorage.com,
	ashishk@purestorage.com,
	mattc@purestorage.com,
	mbloch@nvidia.com,
	msaggi@purestorage.com,
	netdev@vger.kernel.org,
	saeedm@nvidia.com,
	tariqt@nvidia.com
Subject: Re: [PATCH 1/1] net/mlx5: query_mcia_reg fail logging at debug severity
Date: Tue, 28 Oct 2025 15:48:39 -0600
Message-ID: <20251028214839.5015-1-mattc@purestorage.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <40a43641-adfa-4fbe-902b-a6c436f3ccd6@nvidia.com>
References: <40a43641-adfa-4fbe-902b-a6c436f3ccd6@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tue, 28 Oct 2025 22:27:39, Gal Pressman wrote:
> And if he knows, I would expect him to not run the command again?

Sometimes a user is a script or an inventory automation tool. 

> It is an error, as evident by the fact that you only changed the log
> level, not the error return value.

I don't know of any strict convention in terms of when error return codes
should have associated log messages. I wonder if there is something more targeted
that could be done. For example, if there is a "physical presence" mechanism
& a module is not present simply skip the logging.

Cheers!
- Matt

