Return-Path: <netdev+bounces-225371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A01DFB92F4D
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 21:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E532447A92
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 19:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBEA2E2847;
	Mon, 22 Sep 2025 19:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LN2dcCf2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB062F2617
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 19:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758570010; cv=none; b=F/Xl3HCvlklvbigJ/3YCJdxsUZy/U+ECoTxS5veeGwwkM3zlSVl2t28j6I6AGtU5bQ4/73NM5WXaOKEmMpYOvqj3f8jhWOppksR6nVW0xsOOlrJuNzT1OtDHCZF6dgOHLQ2eaMxJhne8DLY0+jnc8/ThOwiBE3QCI8GRlRX2q4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758570010; c=relaxed/simple;
	bh=JOFNb4TayGW146eeSR/TzL6bQPiJFXPSs3/rt/QcUCQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=S16BnUttLXSJNLgr0ZdK+1ntZswj/LXjChXUWI0+umllhUrBcfZrW53LJZy1zBdiuLXXWGnGVjWukdMVLV3Q5b+/1Sz8Y+Xo4SUFd7SnnXj66ewHjxg61nEx0FSlPgzBkwhF7kZL6nX+Sk67yaCzPIMgY46xHovSMCLbt0dbT68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LN2dcCf2; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b7d5978dd1so35475141cf.1
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 12:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758570007; x=1759174807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AeJfCOIdqssbRzmzOiSYJt0e2DEgh7LHCqhy+a6iUYs=;
        b=LN2dcCf2N2x4n7xNcTVNgNcy+umn83GQAy/mbCbfCUE7QKncu8X64nLOJZQvuoxNQA
         MbF3ZZyBXGTAnsAUSiCWeEN2if00UA8e7/GzdY1QUwf6Bu/KLh8lWXNuFF9s7H+I/8Pb
         J7AJ7iUPJDeNhkGDlA8dk1eRyX503GAhdBNQMjQLKBRXCF707is3FRkDw0MU41kIy/oC
         P0NHWiQPqs4o8OsXf8nAdtRVlg95wTFsqZDcimUnWXJ8wLo6mte4OX2u8tKwZiwYKrTI
         gUQ94RLqJzpAT03yfVVn2ESECdLJPvn7RSEuZWxrb+L0MLQ0IEyxqQzG29EPdZkuZApt
         V6pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758570007; x=1759174807;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AeJfCOIdqssbRzmzOiSYJt0e2DEgh7LHCqhy+a6iUYs=;
        b=ipodEBEWU7y5g+ziO3/HxNG3GHBk1LzSUl/WVMsxFDo7fvHVSkUA5ql94UQ95OIyvm
         FmqRcxtvDYez6NkAeb8myOLOfTjsm2QnB4MSc3uxu1o4DdoolQ4qOPstIPWzEzacXjjT
         wR+/j2o1Y1fpcR2Iq1PxBilTWcr1roy0ULsFd+8OQqkrv8aAoLAr19vOtUj6Brn/M58Y
         Vm7KN+s01Q4DFSN88WbyzOaVfdNxxjZdINuoauhX7vCVQ8J/7UFwgPNX390ZmPOLKoTG
         ujiUG9kK84hSFiQexZ8w9kl4rpYgEQ3gYOhygngLsrD+wOcYlYpVm9uqIZ5jG6Nbz6Mg
         VHbg==
X-Forwarded-Encrypted: i=1; AJvYcCX5KsdfLM+OZyTWXqTqgua4DRa04mwg08n3PSg8x8yLLVkDqm2uX5QMTU6Dw1nYkjdQxaeWBbw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXdlQnH2nC4cIECfrargy9Jqyv+By/jIkmK9e5JYngVhRwIfoy
	25K36HIW/usbSdwPaWGU/EjOV8eaM5RDIezjzI1wdyewqRk3XkfwmTMM
X-Gm-Gg: ASbGnctHe5WxY0O4LqoYWsdyOayewozkiHZKXF5qo6jKJpOs1op0wYTzGMnRgNdDh51
	j+To0ybt0jucBLhVgU900Bjc7z9fRKpgP59j294quXfkKAZUFKbVyeBCoD6WUSZTnhgZP+YqXhT
	IY/w2UMzgFRL2xkqkwn/F6VrIrdyK9QLRfGnJ3PlDESGLWyOv43LnHnST3Hw9UYFOQqyiOWTqXF
	CqELSWGsfEVAFqU740mf6UVZhUrLcit2rlUcdh5LNyOkIGnT/P8DuVFXwdj3lRZuc+jAML4HSz7
	JjXUYVx4JyRbB5HjS7wb9iY/q/r8humbhOiF6/sv4ThStGlF725kxSvZ1feYA1svq8OrrWMUA7V
	jM9uDyd3xPPw4skaKL1rOCjwflkeD5+mxO5lhQ+hu3Cr6xcfc68lVwMzOUO+ygxriaGJjyK5rgc
	XIWa4G
X-Google-Smtp-Source: AGHT+IEWlFIqa7hJ0cVGA+SxXSjuDWSK/kwgQm4BwZ9QHtqSUqheIi443AUHtfztTVXUz9ka07qpCQ==
X-Received: by 2002:ac8:7d0d:0:b0:4b6:373c:f81c with SMTP id d75a77b69052e-4d36aff5c0bmr159961cf.30.1758570007205;
        Mon, 22 Sep 2025 12:40:07 -0700 (PDT)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4cbc4ff4e84sm19850741cf.42.2025.09.22.12.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 12:40:06 -0700 (PDT)
Date: Mon, 22 Sep 2025 15:40:06 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Richard Gobert <richardbgobert@gmail.com>, 
 netdev@vger.kernel.org, 
 pabeni@redhat.com, 
 ecree.xilinx@gmail.com, 
 willemdebruijn.kernel@gmail.com
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 horms@kernel.org, 
 corbet@lwn.net, 
 saeedm@nvidia.com, 
 tariqt@nvidia.com, 
 mbloch@nvidia.com, 
 leon@kernel.org, 
 dsahern@kernel.org, 
 ncardwell@google.com, 
 kuniyu@google.com, 
 shuah@kernel.org, 
 sdf@fomichev.me, 
 aleksander.lobakin@intel.com, 
 florian.fainelli@broadcom.com, 
 alexander.duyck@gmail.com, 
 linux-kernel@vger.kernel.org, 
 linux-net-drivers@amd.com, 
 Richard Gobert <richardbgobert@gmail.com>
Message-ID: <willemdebruijn.kernel.1262069e9a3f5@gmail.com>
In-Reply-To: <20250922084103.4764-5-richardbgobert@gmail.com>
References: <20250922084103.4764-1-richardbgobert@gmail.com>
 <20250922084103.4764-5-richardbgobert@gmail.com>
Subject: Re: [PATCH net-next v7 4/5] net: gro: remove unnecessary df checks
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Richard Gobert wrote:
> Currently, packets with fixed IDs will be merged only if their
> don't-fragment bit is set. This restriction is unnecessary since
> packets without the don't-fragment bit will be forwarded as-is even
> if they were merged together. The merged packets will be segmented
> into their original forms before being forwarded, either by GSO or
> by TSO. The IDs will also remain identical unless NETIF_F_TSO_MANGLEID
> is set, in which case the IDs can become incrementing, which is also fine.
> 
> Clean up the code by removing the unnecessary don't-fragment checks.
> 
> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

