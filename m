Return-Path: <netdev+bounces-173604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27523A59E2A
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 18:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 151FB3A7AE9
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 17:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF332356D4;
	Mon, 10 Mar 2025 17:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PnH5bdnO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4F4230D2B
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 17:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741627606; cv=none; b=e8AC2P0BTfFoqjuWb2EVLW4rpjiT2WvYjTabcSAsq9XtCIO5J13orVwCpkh3AUJCzmNC4uSARN6c3WQkoFW13Ce2jiLWxXFLqQZQiZsOKXRKAubEoDiQAUvTnbRIqSASd1JQvbZx4c2sI+v9E/P8uADsFvZGbVIuU+QNs9WzK+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741627606; c=relaxed/simple;
	bh=Ec4E/QJuP431GXmsZlvrj2L4OEgsl7A8yGGvRFhwKHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zo47WnYh3coCaGebBnMPU4CIWJgIWuAf7H7fpSZYpvfMcdD8RbINYAX0ZUWAJrWNKUnuQPcaTkF/bI90++QDCb0fiL+sgSVfv41viRbd3fnPIB8mmk5zithJMkJGPgxPNp8DJxb9QKFmxLdjUQ6r+RrfP3JKphQQqWpBiqolNsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PnH5bdnO; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2fea47bcb51so9512111a91.2
        for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 10:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741627604; x=1742232404; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ec4E/QJuP431GXmsZlvrj2L4OEgsl7A8yGGvRFhwKHo=;
        b=PnH5bdnOL/idqUVRhs/h+yWF63ULjbsaXh0q+tz3x1o1/cJJkABCp4yq+XDQahkeLL
         N++MQiVa3gUX6Rcc/L38RyZDM3oe5E41q5VKllE7x8Wxs8/eEZVQG9hCtLNftL3jza4M
         YLuAq/3EZ/AvvOFXQfuW3XELFDWMlrP/tuCxsZiirLyzgeyjoAjfOsBXCxsA5Zl3gKpk
         hZrR1shXSIEPL5cQMvgUe23uXg2l9fXCTiuvkkd5IqGS7geP2HKlqEowxe6Gskb6nqBN
         GkgX635uPz3R1vXZBNIpmxbn4GuZ9WNiO76VnB0qrd/+hnHXXQH7U5rBR7TV95lElpRo
         4usA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741627604; x=1742232404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ec4E/QJuP431GXmsZlvrj2L4OEgsl7A8yGGvRFhwKHo=;
        b=QpV3aj0m2ruE64aYBt8hS6hG2JOZtrncrMCzxnWEbeW/mAYKPON1HiGT8lNK0/HiLQ
         E1nBub6/5n0IHAbE2pfK6Q40QqXeYX+WQUz+JQbCpNroN1PIrbqVQp5qw74vS5KsAVsL
         Kb2+HHez2ndFTUSeANYwP4byTm0kJwo6iSJNnN4zWcKqjsQzKtJ3jjpzrg5kJWLpkFmr
         hVS4K2WWUN5yBwyMTs8ISNt8Lzps0e+BJUDUSxEC0vstJ/o9Mvxld3ccMa8MAL0IJiEk
         2WbLjkKT05z9aCUYx8vcVtLk9ho3qsEyiqyF5vkMtHgcJypK/TtliQAqLHSisiunkQ7Y
         IXkQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+DfauwSQ6PIdHAQsOFI7joYOLFpOI/7JOrzzpfDXmmFA0WBST6avFCKXxRTtArEW+KpFg0bk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRCLYPaBT5mKFd2qclvaKzeFquz+nXOJ+q7bzNy84CGjckTBn1
	y3Z06LFgDUCrC3PrBz1vnYK3tndRudEnojgwTiRRzO2C11oeiKOYMmEn+UmG
X-Gm-Gg: ASbGncv6fBzzRp+ChU5kuzsHi5M8c217j0x80a9JFIVJ0N/VZC0/AI8uitDdp2SgfUQ
	WliHJE89D9GZf4/T97EA9JBkfcnLgRg9jRZah50Qw5epiHe/DBDb+709hpiAQ0EcVrUJDhFonid
	x2f21wFzYOSewbwv01cLyorXhTFmeivSr6ElDej+D0Zfd7/3mS/ARkTF+ES2e2LB0Eymh+k5BnI
	9Cs23Jv7J6/b5iakdTfGLjlPLrod2CLq+TLyVng87DUdO+1fTfQsSDJb4LnT+daxHu+xrAXnf/b
	kOlgD4xRmwgkcSsxN+D1uU2DgOUXeE4SAfViPdPf+bN/YarxwualEBiqA/3o+39D7ZfBSTH4ked
	pMOi6vgerMg==
X-Google-Smtp-Source: AGHT+IEziMDJVDiQvtqgzEc+KLO4eMrbIFTCpQOcF3ArJZUKi7gj38VxTkGoyYwHCvmhQOF349IBAw==
X-Received: by 2002:a17:90b:2883:b0:2ff:52e1:c4a1 with SMTP id 98e67ed59e1d1-2ff7cf128acmr23054358a91.24.1741627603670;
        Mon, 10 Mar 2025 10:26:43 -0700 (PDT)
Received: from google.com ([2a00:79e0:2e52:7:4eb:6cd2:52ef:6beb])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff72593715sm7627806a91.44.2025.03.10.10.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 10:26:43 -0700 (PDT)
Date: Mon, 10 Mar 2025 10:26:37 -0700
From: Kevin Krakauer <krakauer@google.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	willemb@google.com, shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: net: bump GRO timeout for
 gro/setup_veth
Message-ID: <Z88gzcGu5_WX3je0@google.com>
References: <20250310110821.385621-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310110821.385621-1-kuba@kernel.org>

On Mon, Mar 10, 2025 at 12:08:21PM +0100, Jakub Kicinski wrote:
> Commit 51bef03e1a71 ("selftests/net: deflake GRO tests") recently
> switched to NAPI suspension, and lowered the timeout from 1ms to 100us.
> This started causing flakes in netdev-run CI. Let's bump it to 200us.
> In a quick test of a debug kernel I see failures with 100us, with 200us
> in 5 runs I see 2 completely clean runs and 3 with a single retry
> (GRO test will retry up to 5 times).

Thanks for finding and fixing this. And now I know there's CI that can
be checked!

Reviewed-by: Kevin Krakauer <krakauer@google.com>

