Return-Path: <netdev+bounces-181338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94970A84850
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 17:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C688A3AB2BB
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 15:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DDB1E9B1C;
	Thu, 10 Apr 2025 15:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7v9YElM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7AE15855C
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 15:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744299930; cv=none; b=erKskWMyatmQsFvvHaYnQBHGJPV++LJUjlXhr6JtAftHpyPPm9H3ISZKKNEoUiIaPF+wgfzd5DdvTlQaFbE2JzY2jV6n9OtT8Brff+jOP3jxqPidh6pesTWTsMbYm71es5Xw3yHStS3IcMRBuQEdMgTzAwiN6HGoqliG6JsGeSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744299930; c=relaxed/simple;
	bh=oE+TvVUj1YD1eZzIbQEiX6P3FfoaFbGNk8ioLMLFKM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fUv2Gb/l0hVmYNLN/cpnkPXxNaDH4qkKyVUaZWcz0VTD+htnJselUWpHsRSz+PaJ6ex0ALF3i/vTcQEheQcvGceRVvhDsWzOAWksDscGvqQGGxQ2qTovQWnc24wIetf6k+GgthGE0lCHySSZKyutqvhPf1w4OuJfZYSsp9wvrIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G7v9YElM; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-224191d92e4so10584345ad.3
        for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 08:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744299929; x=1744904729; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2jVi5g0wJy+DitLQtqoM2yAwQoaBQUERtgmXB/n4JzY=;
        b=G7v9YElMAofvB/5ML+Out1idvQcwDQ0wkcm7zRocskAC0GKe5SovsfEMFG6YPkFZeU
         hUkq1hFroLLFSMxm11AShnuqxa6QVX1IEyu0Ac5jNlxPbVGD+m5enGC9nuEO53Scunki
         G6eoj1BmxEhNQ2adC0k4WTrk/Uu0/ps2LLwH9CC7lV6D7b8mG9GEu0E5E9MsE9Yt7rXG
         2LLBDMpwOA++HloT7bnBB/wUnwNuKu5JjIRSFOsSgH9/grAg6HZmsYqpls5Hj5kwI8YC
         duYZKz9v51y0AxmE/7IpbrigNfwrX5/X7VPaMhPvjuH5FIOCZ7PlHSFQNyJ1wOVAMDy/
         I7og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744299929; x=1744904729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2jVi5g0wJy+DitLQtqoM2yAwQoaBQUERtgmXB/n4JzY=;
        b=WmyNpDp71cwMPH2wF/vM4/YbXGpRgAIlq3Pa1Y3PLDyyWBnqMbSUtlPAKvnUMIPppU
         MaLmRF1GkzCC3vyKCW1OybszOLq46Ypr2e/GHMciiZsMX/SFTRH9OevesjCfnxKxgDnl
         NC0Gimlv5nYJ8LUp46IK4cWbaMoklCMJ5D/4kKvACs/O+lgdrfenY69/6AIf90BdsAqu
         fjwDGi7qp2DIxmLTG+XBFdrcgpGN24hoZd2zIBc6Rou4eGLwSbo8sH7GNZRvQXDUQcK1
         NpALbAkm5xBrdJm0bPmvVpMnS8j/FuzPCy4kb4T2xlkJlg+tBeW8T//zAJbEJ8ofgWVW
         vTHA==
X-Forwarded-Encrypted: i=1; AJvYcCUQ17GDhI74JHK2JIOHN97LR1IqdEfVH9DVPMcH4yIPcCzZr1Hd02ExKtyWafO0pFFatJxEc+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsiOkNWu/ORstcc/6VvTc8cpu9pxs7q0NhUejkqt0yt5N1TFWv
	dF4t5ZwbjwabxXj1RT+h5hnaZzSB7yL2lpmSzSgzrscNm//EG9E=
X-Gm-Gg: ASbGncseLIGLNeT3UmAuNnyLVpkKOZwMkOZl82yeNnDZQlnVB09nTixeJbVQxAYTife
	cjAPk5I8dujCawwdtn9snzy0MFBeFf/Csha727e6aiOqCaTykgnEt/WJ2mns2ZJu+JpzfY6qHa/
	Nx0awZaBh80/hu99o5urkXDV5VZsOgpXGsElRlyrnoj90HzjtqDkRNSHLfjs7YZey8NXhzl3pue
	9nIXosBMRL1fkqPDx74Mciaekjllqn2By5hwUydGS3qCyH51LGRNrBX2g0LLvLDvYMY6rlyWtvI
	Xrs6T7lSxzhPeb8UIoOGlmqwqZ5Z25zrj5tiRLCR
X-Google-Smtp-Source: AGHT+IEh/BHY65eS4DHO0D7DWK6dZ7dnBZmSDf2MbuLcY5GchWsCCv22CFmyIQ8mgMomEjV+GsISnw==
X-Received: by 2002:a17:902:dacc:b0:224:d72:920d with SMTP id d9443c01a7336-22b42c14e58mr46362275ad.37.1744299928621;
        Thu, 10 Apr 2025 08:45:28 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22ac7c9929csm32088215ad.112.2025.04.10.08.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 08:45:28 -0700 (PDT)
Date: Thu, 10 Apr 2025 08:45:27 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	sdf@fomichev.me, kuniyu@amazon.com
Subject: Re: [PATCH net-next] net: convert dev->rtnl_link_state to a bool
Message-ID: <Z_fnlxK0Ohj-Ky_1@mini-arch>
References: <20250410014246.780885-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250410014246.780885-1-kuba@kernel.org>

On 04/09, Jakub Kicinski wrote:
> netdevice reg_state was split into two 16 bit enums back in 2010
> in commit a2835763e130 ("rtnetlink: handle rtnl_link netlink
> notifications manually"). Since the split the fields have been
> moved apart, and last year we converted reg_state to a normal
> u8 in commit 4d42b37def70 ("net: convert dev->reg_state to u8").
> 
> rtnl_link_state being a 16 bitfield makes no sense. Convert it
> to a single bool, it seems very unlikely after 15 years that
> we'll need more values in it.
> 
> We could drop dev->rtnl_link_ops from the conditions but feels
> like having it there more clearly points at the reason for this
> hack.

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

But for me having rtnl_link_ops in the mix is still hard to read.
Might be more clear to rename rtnl_link_initializing to
suppress_rtnl_notify, make it false by default, and set to true 
from rtnl_create_link. Then reading conditions like the one below
will make more sense (imo):

	if (!dev->suppress_rtnl_notify)
  		rtmsg_ifinfo(RTM_NEWLINK, dev, ~0U, GFP_KERNEL, 0, NULL);

(iow, reverse the conditional so false works for most non-ops devices)

