Return-Path: <netdev+bounces-127941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A25977271
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 21:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB67A1F2194F
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 19:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E97D1C2424;
	Thu, 12 Sep 2024 19:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QIx8+hkC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C841C1738
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 19:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726170483; cv=none; b=I/BRGlkzvENwChy62jPJ/8z9fe5F/k5fvfNLvS7KeyzSQY5l6Af76zGtV21fCuFJzqavJFNCa+NT8rKUsP4SuOyLlwTt2duIYBaB6CTvLfn5vNxNq0+xCUP3X7t3oQxqxjNNXPrsf/FsOGR8zWOzzf64kIHB6Pc5cUIg8qMYxcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726170483; c=relaxed/simple;
	bh=LnrvXWKrC9QGjfugBY+n6qrVtH8QQlrr1uu+Tt/JMB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u05Gfgy7p0ZiyQ9z3lWlirUzj4VpUWsQcwdVZ83juUznq6fdrT3M9KX0w707/i5uiYoXWDLfS8u+KrUedYQ1z09fXc4dQEtFyL1E4ADl37FXVsGZP9gpvQqJTGY92KU+AJvt7ZlUJLXI0mxNfHTYDQbhzo6RkZPtsqRJkJL9jvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QIx8+hkC; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2055136b612so18681995ad.0
        for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 12:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726170481; x=1726775281; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ud/GaXMvk3fvvB9U5ntq6CliEJrWEsNmVHHdWNX8rRA=;
        b=QIx8+hkCNqAyqUMgVxPfE4BvwPgCdgzu+fhicPx62grst7SrjMf232OVdTpnesHlRx
         8FBRCxrW7M3/slmp3NfM9EKu/enisHH4ZtVunG9VbjHWENsv8aYbMwqu1EDNz/oIjJsy
         Om0ZITx9/Y2b7tjEgG77EZgmTykovFnjctxtHA7EOn62I5SwEJzTPwdcJR3b8IQAezUV
         BqE3VSv3lnPdZgSnd71Dlu0UFzsjpXuw2UqRpLH8PilKM+9EnF4pjU9fGE5xBjWf8WkX
         I5jjot4UvPEPKlgb0gFXOoQ9NA0KAtWBD6OcYbe7UPbwsjbgZQbW6Lnpx3tYndB++1qF
         sUkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726170481; x=1726775281;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ud/GaXMvk3fvvB9U5ntq6CliEJrWEsNmVHHdWNX8rRA=;
        b=W1ZUDxhc02nOYkBL6uPlpsHanGJrgUtnQynZbUKHhsgaj9gfLCxbZMKl+I5cTwwNrp
         I8UiTHEHO3We4NCqAZyH2fsTItaI5jru+I3NoVh2ywxZsthm63bpk7lQvfxM1GOlAdFe
         ryq66O072sd5ojPVRbeApy/03Dx1PU34KakI/x5uOsve7cUA7EJGpmaw4h2lbEeJD/HT
         m0OKlXuYPE2UAGE+BKWBgDUknLMJr7hV+jbz4K46pkLjTPoBfJNv7AWOfexT+nDFaFZg
         /QwZylvLxN+Sqt4z8OpgP67awxL+l/tdJ9fyg24b7yvgOJX7OW6fqzf5Lz7DjE1TNC/k
         l+6A==
X-Gm-Message-State: AOJu0Yyr5QjEXMNUfLQ6pBjKJaJKivl4gwiWnosijpSA5Bc9QuYkmY/j
	Pcl68UR0tFWtlpAJ+t6Q/gBod7pfy6F750GFWJDnv1EHm3O9ZLpRb0a6
X-Google-Smtp-Source: AGHT+IEqM27rFTR6YNiauoMZ010CIUhp/CShYElFrGHT+m8VK9LrhziOc45KNiE70HEDNJz59JAV6w==
X-Received: by 2002:a17:902:ccc8:b0:207:1709:dbe with SMTP id d9443c01a7336-2076e421fddmr71723665ad.50.1726170481334;
        Thu, 12 Sep 2024 12:48:01 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076af47171sm17750415ad.81.2024.09.12.12.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 12:48:00 -0700 (PDT)
Date: Thu, 12 Sep 2024 12:48:00 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net-next 00/13] selftests: ncdevmem: Add ncdevmem to ksft
Message-ID: <ZuNFcP6UM4e5EdUX@mini-arch>
References: <20240912171251.937743-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240912171251.937743-1-sdf@fomichev.me>

On 09/12, Stanislav Fomichev wrote:
> The goal of the series is to simplify and make it possible to use
> ncdevmem in an automated way from the ksft python wrapper.
> 
> ncdevmem is slowly mutated into a state where it uses stdout
> to print the payload and the python wrapper is added to
> make sure the arrived payload matches the expected one.

Mina, what's your plan/progress on the upstreamable TX side? I hope
you're still gonna finish it up?

I have a PoC based on your old RFC over here (plus all the selftests to
verify it). I also have a 'loopback' mode to test/verify UAPI parts on qemu
without real HW.

Should I post it as an RFC once the merge window closes? Or maybe send
it off list? I don't intent to push those patches further. If you already
have the implementation on your side, maybe at least the selftests will be
helpful to reuse? 

