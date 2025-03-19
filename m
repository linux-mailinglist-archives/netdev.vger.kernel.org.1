Return-Path: <netdev+bounces-176305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05EE6A69AFC
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 22:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5018E7AF68F
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 21:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358E620DD52;
	Wed, 19 Mar 2025 21:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6RVLSpx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC95F20B7E8
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 21:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742420160; cv=none; b=cqZnhG+YUODHdJ3tzRo5Q1ZQRr2WZPGghYegBvfgr9tLODT9lI9vxrPZqDO1aLElppn4Tlv2fFBwFukBAIIbZ/gc58D6q2AHkQ81Q4qfdRM/5uKugRaq2VjPabmlhqt3NEX8iMdeLU9G9uMkiylclWY8ihj8rq0/xhHkzlYnOKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742420160; c=relaxed/simple;
	bh=O72OoX/X213vrZBENhTykJPuzeF8b+pk0H41PMpnHyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W5aHRvPFRm/KM1fDw3JD1iyiQ/iSdEV51VEDhLuZmErhD7TGB1/PVmOUG6SI3WWjBK1xfkOpqYDShcm2W4d+Yez/UvxVOpIdkOCQN0rEC/Oi7mCsHQ605ZAKQ+kxaqWa2GswuFlnWkLgiErL3Y6gEOPnSfp3vjyHlolJv4fbass=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F6RVLSpx; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2260c915749so305335ad.3
        for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 14:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742420158; x=1743024958; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4wO0vC89OtLda/WyEslc1s/VkMn3QTZ6OPonJulZN7g=;
        b=F6RVLSpxWeCWWg083DPzTjb7FqXbp6x3Is6x8FEeVoD96/JlDX5to1DbeEKx6Vzp5+
         dti+0tk6TbxDUAgr7X1Tgddpi/8LZyJ9Q9ZWxFdbtpdzbXInZ0Gl2jAZ9Q30FRaTKqHV
         9bLi55lOsdqgOnl/bHQj8fRbtF/sin2Eo2IvLO8cKcCgjHCTokmfMUGrZRZbTS1kC2hF
         ZHw1qbGuK/iVjhhU1dgBwhB0krk48FYtU6rTQKiudHO/lYDUwRCWuqTyeisMS0RoI545
         vxfUlZJm5MF5UX8w+xtxeZEMMok5XLrudMx1ewCUksid9yHKpsaTU1heuZ29yOHoWBnw
         20OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742420158; x=1743024958;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4wO0vC89OtLda/WyEslc1s/VkMn3QTZ6OPonJulZN7g=;
        b=G9ZEd1v/knRmrfaFqnJXapQY1BeH3VRGBLf+gsjEPR56mdKWhtFRvpt440JC6jpRLc
         GqExh07EnPFQX+T6BfLluQvWL+YUe1Aa2a/HGpCmBEJj5dVYvFNZzLNhcdUai2JQlPsa
         vjYPnRBFjsJbVN78PW3pfR1ZQldd4saZF5OwdMqdPtP4OP7gTNnLI6PnyLT7WhihEj1e
         2GhGqrrS+FL/q94NlKOL9gFY8oIRJfRL+VMioRc/rSr4b+zV8rouI999mFra5b+r4EB/
         IgZjCJlmm1q2Z+xi5CjETCPwc8SAAls0i0wnXe7xJgFfrqWK75dAdw7EpLJCzpO4NXEi
         hz+A==
X-Forwarded-Encrypted: i=1; AJvYcCUto+xDvmyITsW/ZvFLQeEQ4S0LlNoceNdGTrY3bCaK5jV5C9blepglPS/Ysna778jj+utFJlY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy7RmZ2hNcW0PyW11FYukEzmUJotQP/B/eEptUYekb4YYFoaMd
	BNJTyE+Dst/hvBABAIaQe9AMvqDRqg/E4kmVHqxxUZ5a+46JzUM=
X-Gm-Gg: ASbGncuHwlMm9g4TGEQaARwUufsdtdVLFTZ15ldYrlUct48+gE+t5+83ap4mxBltBZP
	M3TJNJCUTKk4ev4x3TkpqAYSGK1ChLcLjmKf8jy9cgR1og2omSAVCKjnCUWEslWteyKFwPHsEAv
	KFe0qF9rwKDXvqE3rapSJmx+Zv8vMOyAyhVrXPZDmhwgYP+5/M4SNAYWBI2Wo21VVfBTHY2pRak
	RsniQD2DVi+UoUzthvhYTd5rtZnPzcy9Yrxrp6dFO+Pqz+cKziTaWlKEYr2QM26juK5edFcXwVs
	YBy6Gm4Ht/7hF0pZSdEZiYd9krC5LkIa7geGha6TYqYR
X-Google-Smtp-Source: AGHT+IH4EtsAGzOWKmD5toPguj5U/08ITTN7WIiH0t3oXac95MwJTPsJ6Msd51EXead+ZS15HZW1RQ==
X-Received: by 2002:a05:6a21:50c:b0:1f5:5ed0:4d75 with SMTP id adf61e73a8af0-1fd116ff2fbmr1683193637.31.1742420157981;
        Wed, 19 Mar 2025 14:35:57 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-af5ed4a0186sm2001182a12.3.2025.03.19.14.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 14:35:57 -0700 (PDT)
Date: Wed, 19 Mar 2025 14:35:56 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Antonio Quartulli <antonio@mandelbit.com>,
	Ido Schimmel <idosch@idosch.org>, Petr Machata <petrm@nvidia.com>
Subject: Re: [PATCH net 0/2] gre: Revert IPv6 link-local address fix.
Message-ID: <Z9s4vBGKJJA42v2F@mini-arch>
References: <cover.1742418408.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1742418408.git.gnault@redhat.com>

On 03/19, Guillaume Nault wrote:
> Following Paolo's suggestion, let's revert the IPv6 link-local address
> generation fix for GRE devices. The patch introduced regressions in the
> upstream CI, which are still under investigation.
> 
> Start by reverting the kselftest that depend on that fix (patch 1), then
> revert the kernel code itself (patch 2).

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

