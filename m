Return-Path: <netdev+bounces-166737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBABCA37205
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 05:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC2F23A9DD4
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 04:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC5B42A92;
	Sun, 16 Feb 2025 04:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="bcCcO38R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD9B17BBF
	for <netdev@vger.kernel.org>; Sun, 16 Feb 2025 04:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739680908; cv=none; b=Gug+CORunm0+wiJASI8FooiPOpDI0exbO+gjlx+9jedbdKLA7XKnoq5RCmKpxLelxlmNMfrPZ1/IxvzOd9q/wPONdYqBuGPHHUQmoifNOreBu2355ebH5gROhpl5jXO0urG6noT4XPZeGUFl8yzlB6OtWS9EBIuD9weywXAGgsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739680908; c=relaxed/simple;
	bh=ka7DjWi5u8d7UKlea9WeJ5ehFm5Vqv68iCj2896Zig8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cuGRvAH7HLHuPD0zC47J8P0JNqQmB3iUs7aEd4qgb0ZsAWk/VaFrjNkqxhg+1uQjnmKTDd4d1wmngZF8b5z1DHSFOESC+DNYfBAuN1hLYhyQzFkLi0KghXr00c8L7QFZgG8BI58uAZM0WKVzrrwxm8erQeB8D/x7qoNEDTuw3Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=bcCcO38R; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-221206dbd7eso2625255ad.2
        for <netdev@vger.kernel.org>; Sat, 15 Feb 2025 20:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739680906; x=1740285706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kE87YW205zQNnYEC1i62hj2LenRd+r/VDrmVONH7nZs=;
        b=bcCcO38R180YU0P6VA8zTnK9g/MNSh8bKLG8wOsSUnCKeEKNLO7wYtajT0w5YKwvEm
         u0zDyCR4tGQiy6kbnIQMnAulxTTp25DnqQLdV3vL15dF3Om6p5RJog8tud+SNEnYFOMo
         Z64J1QNGIDM4ybIY8xm4RmLczBk/tBo9yIaHq4tJsZffM8VLtqRyPCy2/En1NG/TGywx
         FY1MciphNwqlmcVlNLv589+IwywpZrf+iadCdON0ZYa5U5VWQk9b0LrV66mHMjnqCHss
         Tj/kb1Kjf1dUQqBY822FS5w015E2uwb+8oE2PzExL5B33D9lIbvIqsOA5sCwk4svJhqM
         KNRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739680906; x=1740285706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kE87YW205zQNnYEC1i62hj2LenRd+r/VDrmVONH7nZs=;
        b=u5JqatNiJAZkQeZsVx//p40jiP4Gd2necLOXsIWwO3VgtpzPkiLaXc5wWvXGC8Q6xN
         5xm97v0cuKkokQ3F3fr1Af6pttgCFpM8HLuCWC2NmNSf2oCi9uwOSzLf6kVSSvH1XBBT
         gYF7yX5NqhQQJCPPQlAExwbvnK4FEuqKSirwahLoCW6MX0BBwY2oW/7e6Go08NHeWi+e
         g00XX01gUInsoI6v8+N8JF/oROd+4sC43tfGMRiorBujv9DemO0CFsJogdoPGUeDR2V0
         7YUZZNlPjpHD/Gfi/EB30Chq8Ufh0t5lPlnrg0fdymJArU05+ihMEXPtvIqHwpjfc/Ri
         ndRQ==
X-Gm-Message-State: AOJu0YxOvHsLtnAotAr3Qs1KP3P64gJNADN9rYKhxKOgjYiYdEQTmqwf
	w5oHf+l5RmXKcAX2T7ihKeAryCMV14uuc05rF7gtA6vWHxSXeiVxVfUV+P3DlSg=
X-Gm-Gg: ASbGnctljzHiIL/2k5XiKXGmaJfa8Lc+j7nO/OqYy6Ut5OYewViBHMelJDuaVE+rUF0
	7RgRQJn9AnGj4I6nL2M7mo1w9r4cY9YaahVZnp9W5rHbwr4M9whcbUggHvWqTxL1a/w71PbTIVX
	YxUPKbJbK+ngkhttxB2Gk+RKObCVUjC/fFFylt3En2/j+VZDBGjD7WrlOnIykx95NEYVfp5Vaso
	PIYPKxMoa0XxXanfBX574bIs/UVxFBShie27E6aw0SpLVnq9Qaqn7Ye2r/mYWlb5VidEdsQ8D0c
	8P7SZpd73WEOKXWpmy3mJacyUKqYkWg99oTsxfw3jFfJuEOmg3GYt8zVPIICZ4QQCLIg
X-Google-Smtp-Source: AGHT+IHDHNd2l1JieD+pine3di4BtFE5HtckNHl/+WjiHYcphTztmnQ4+y7wuIua1CULLTRWC+2bZQ==
X-Received: by 2002:a17:903:986:b0:216:6fb5:fd83 with SMTP id d9443c01a7336-22104030d06mr77035345ad.29.1739680905902;
        Sat, 15 Feb 2025 20:41:45 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fbf98cff80sm7657993a91.16.2025.02.15.20.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 20:41:45 -0800 (PST)
Date: Sat, 15 Feb 2025 20:41:43 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Anton Moryakov <ant.v.moryakov@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH] ip: handle NULL return from localtime in strxf_time in
Message-ID: <20250215204143.0ae30525@hermes.local>
In-Reply-To: <20250216022523.647342-1-ant.v.moryakov@gmail.com>
References: <20250216022523.647342-1-ant.v.moryakov@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 16 Feb 2025 05:25:23 +0300
Anton Moryakov <ant.v.moryakov@gmail.com> wrote:

> Static analyzer reported:
> Pointer 'tp', returned from function 'localtime' at ipxfrm.c:352, may be NULL 
> and is dereferenced at ipxfrm.c:354 by calling function 'strftime'.
> 
> Corrections explained:
> The function localtime() may return NULL if the provided time value is
> invalid. This commit adds a check for NULL and handles the error case
> by copying "invalid-time" into the output buffer.
> Unlikely, but may return an error
> 
> Triggers found by static analyzer Svace.
> 
> Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>

Seems like you are creating dead code. Unless glibc is broken
this can never happen.

