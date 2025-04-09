Return-Path: <netdev+bounces-180882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67701A82CC7
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 18:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09A3E19E6FEF
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 16:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D0526B2DB;
	Wed,  9 Apr 2025 16:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6tKEDAD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0811C5D7D;
	Wed,  9 Apr 2025 16:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744217217; cv=none; b=O911Ln8WroSNPdHmK6L1m+i8RhT4kbBGzYCG90sc6x71Lr0ndLOumZOGjDAaNIv9233qbPJtaHx91T7uK57Uc7RA7NNDxZzX0dkeaX/k/q0b56e86SVxYTie8Xr0PJoZzVgLnZ0xQXT4BCObGgJ+fnh5Z0dfy6I1Vj3mGdjdziI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744217217; c=relaxed/simple;
	bh=8cf3wta4eJQd0oywROztBsxQ2YhvACMWbn3g2x9H86o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J7+ExoXThRpz8Q2gEduIa8x9AUA53J4SLJhBfbr7GrmGC+Ln5lD9QZo6aVgGNYi8ff3x8vITmlz4IgWfeuLJjF5iwlQV307FUHoPxaF5R6EmbmPW1km2stWfB8HM6+KZzPGxqyXi9PjdHHij9HHiep3nsTaymwpYD82wJ21/c2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M6tKEDAD; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-739525d4e12so6469972b3a.3;
        Wed, 09 Apr 2025 09:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744217216; x=1744822016; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MWUuYJlowKuARjA78SN+1d2xQZAtMVqnsBoirkfvWLE=;
        b=M6tKEDADzRhCUyvFpYLdCUp12A5Tyj7KmFdWn98ycU9mVreEbsCMCD5wb93FzqNnyO
         huwg96JxDAx5tGPaacrrV/P3H7TpoI1GrZV+hL2/9vFJSqNQOUHb5rSD+Ey6dngNUTFo
         +AcJUV6sUiFELyv/gEx1YfVWe8nNPZDNKtpQQTiE3i1RuxdXS94aXYyRmAMpi3VY8X8A
         4b5smtDdcL3mOH6SZDRj9YLO5+GwWq0svDyodjjtCgjKc024OXY9qm1IvfgRAWxzYaaV
         uSnIbIV+WWaEmd760bINUVlFY9NtgxpjoGDm6rQpO5x7akOjNSKU2eTA2+hxu5UC42jZ
         VgEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744217216; x=1744822016;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MWUuYJlowKuARjA78SN+1d2xQZAtMVqnsBoirkfvWLE=;
        b=xEdzAGskbLjluiJhD/TNGpko+BfltDshegUfMK8sdsakRNt2QkgAYCbJnZK2vx2nRD
         RHzHWZE0NhqVNbt3Q2sZHSzymPYUPkDwnCkBvAu3e1CnXpMMTmK7+gBDjohXZKO1/EKu
         E/gD5mWqKdSJD3ESbI4N9x0pDvOR/FECl3q03qE029oqIEKcetTjxQeKSyy0Du4xACqQ
         O3LwdP8RJoMtRqp9xSxeJKkuh+YT/gJYabxQzKv9sH7HLymn/em4Aooi2DGJmUoRq7vI
         UC5+WnQg8Zhc6++KyCP3IZmialnnhTLcy6aMEciZgXwh2P+LE++ovVRyfXJhKRXrpS++
         K9Tw==
X-Forwarded-Encrypted: i=1; AJvYcCUadbdqrqgOpEkLcVD8gQ8sGCGzbmNH9kva5/6f3sPMqD6nFSydYdpeUDHA1t/pzvrj15OySPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIejO38X8/t3VNvxDINqJb3HQ5NmFRT7fJ3vWxR5IG/nf/Klpn
	GAMrPnuC07r9YPb1sn9MepGeJV2dE+1ldKn8EE50lZVxWrCcyYbZ
X-Gm-Gg: ASbGncunvHHWYq+usGtob0i6zlZt4K1joxIPPVl9FUOjvof+czIDsSbMtqDA3e2gDGR
	gcix5E5zcwSyIYE9EoxLP0x4UbUWJXSdA9k864MTnqw73VKsZCXa6w9eql2qiJNVctnhbrJuZUX
	nxOFnMf/PnrLbEkANDtpc2v6HyX097b6E7scUvbffkWf637LJ4dO0Zo0hpKJKV553UCjkbVVIS4
	4quh8ao0w1gJvotSSZ0MzwpCySsAfq40rO13N69nKTZzQlXU6bm4C/6IFm8MacJ7rskYKSQqzmy
	+itTMV/rgbzitymcK+TgWTMh0Ve5+1z18Q4BMS+0Mivl
X-Google-Smtp-Source: AGHT+IGZ3CYsyOSo4CRpgTuPUNsXu15jYOlpr4/yuRtzb4H19Ro3qbnlp9/02da+uTbUhwWnFAeB9A==
X-Received: by 2002:a05:6a00:2da6:b0:736:7270:4d18 with SMTP id d2e1a72fcca58-73bae4d85a3mr4116320b3a.14.1744217215711;
        Wed, 09 Apr 2025 09:46:55 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bb1d4945asm1616636b3a.68.2025.04.09.09.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 09:46:55 -0700 (PDT)
Date: Wed, 9 Apr 2025 09:46:53 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc: linux-kernel@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] selftests/tc-testing: Add test for echo of big TC
 filters
Message-ID: <Z/akfbJxhHqys7f/@pop-os.localdomain>
References: <20250409145123.163446-1-toke@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250409145123.163446-1-toke@redhat.com>

On Wed, Apr 09, 2025 at 04:51:22PM +0200, Toke Høiland-Jørgensen wrote:
> Add a selftest that checks whether the kernel can successfully echo a
> big tc filter, to test the fix introduced in commit:
> 
> 369609fc6272 ("tc: Ensure we have enough buffer space when sending filter netlink notifications")
> 
> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
> ---
>  .../tc-testing/tc-tests/filters/u32.json      | 22 +++++++++++++++++++

I think tools/testing/selftests/tc-testing/tc-tests/infra/actions.json
is a better place since this is not specific to u32 filter (although you
use it for testing).

Thanks!

