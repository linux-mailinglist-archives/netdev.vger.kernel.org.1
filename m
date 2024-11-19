Return-Path: <netdev+bounces-146096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 215E59D1EF9
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 04:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C8061F21FF5
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 03:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDED713C8F3;
	Tue, 19 Nov 2024 03:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLwTM96G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622C11863F
	for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 03:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731988310; cv=none; b=jHoGZmpIaoT2fRbPoqdRSSoYrUZsaqAq4zquwHDVH27mC+DMN6x2g47xSsaFEOpSsrkMOiXu1EFjAW3TlnvBW+AVRu+1NO3iHS9yeALsQOTt6ycPkKp9ZXRr21Nx7dddtykj/H1Duy5VH2c7zdetDSLuVCQ+4R2keLXiSWxkVmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731988310; c=relaxed/simple;
	bh=idju4hIdfdA2/T6nF2VyYK/V+XNJ6Tx7Tb00JFcpuvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I5PPApl8vDaTuuS7ehETNUi9KdstpA/Wp9UKRxK4XZXhEtW2w7sgFI8lMcAzX2zkL+cu9j34GVhwpWar3D4otOebLuUNKAUb3vh3C+s4KSaAnLBY1MlaQ8rh/T39R9IKymUa+TlHzA/uww1+DdoMF/aDYMh2V72T2rqR+gaxhhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nLwTM96G; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71e79f73aaeso392448b3a.3
        for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 19:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731988309; x=1732593109; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2+ddabMVIPrPUswTfuwFb5jhSI+TR/Vv+33r1Q0R6Ao=;
        b=nLwTM96Gi4uJt2uMFof3GX77WMVeyQBAilZ1x0N9sjVDfa8voZCulRdi2ZSzNj9Sgk
         5YUaeKdpfs9kwz1Is0cp1Z+EIL5J1ZoLftRm6736WKa3g5A7Un9ZNEYe4q1sIDNCLO5i
         q506Ok7ElMXcWYDLHO0mDWbCKpsh4CqEMYbXUFlE+gQlMYzcf7vZTkx9P5BYGdfg1Owi
         Eicf/hxZ1OfXlrzbyM+0QVOisJOo++DvpD7rcnZJ32s8q+P77uu7bO0rgddL7J8XyG6d
         JxNaFImDcrzCtVbeA0uW53L9AjakT5O7EuYGx6/Ve/IWnSPm0Onzwilfb+cR5j4NMLu1
         E+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731988309; x=1732593109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2+ddabMVIPrPUswTfuwFb5jhSI+TR/Vv+33r1Q0R6Ao=;
        b=fovGDYhC9iUVXSTSgK3pYl/UJEhg2SSSvia9NDcS8FTuMoC0DMgMYrOWSMgxIEuEDZ
         zP3AHPNjF09x4Y+CFqlmwo9p8q5iiSNpeP50msfDwHwAmgdmeNoA801JHWZXJIr4cnNZ
         6CistYuhfQMhJ+nP6m1qObY9ZnCO5+I5ngvGNmeljydSVzPAs26e20ZqYkvdT63VKhco
         LjTNiPFZws5uzrY0g2q8ws+GFnK27KZwoYfVk3wZRfj5Is2DThM24QWaDMm4NR6eW8TF
         i2ijf64k2cnJjp5kObeo2IjHlgWcqfYEF6pTQY997gAV79i03ph1MeeGyZ9kGl0XaeJf
         3B6A==
X-Forwarded-Encrypted: i=1; AJvYcCU7ghGBX6wG0MqM3YKafB8lF8UrY81rzWUMBFSzWoC7clMTvHqmXffQnjeoRe2Jv784PqVUYxw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw67fNxSmUs6V/GBtWnPJJepJ3Ek2Ph2yO1yBPwmp+MCAOyg2Y
	ZY5jGUOz578iSHagP+xZIUatSRqvqErwUOam4eLvpCPetlTqfGbvZx5cng==
X-Google-Smtp-Source: AGHT+IHcK6aQO5dQ+ehmNjncXo/GMzCFCYeTNPiKHDm5ypm1dON0fm77c8w5V/LRMzUo1C1WpHDD7A==
X-Received: by 2002:a17:90b:3952:b0:2ea:98f1:c17b with SMTP id 98e67ed59e1d1-2ea98f1c320mr4154432a91.5.1731988308628;
        Mon, 18 Nov 2024 19:51:48 -0800 (PST)
Received: from localhost ([2601:647:6881:9060:fd49:bc41:343a:fee5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea41550839sm4803309a91.17.2024.11.18.19.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 19:51:48 -0800 (PST)
Date: Mon, 18 Nov 2024 19:51:47 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, edumazet@google.com, jhs@mojatatu.com,
	jiri@resnulli.us, horms@kernel.org, netdev@vger.kernel.org
Subject: Re: RFC: chasing all idr_remove() misses
Message-ID: <ZzwLU6JHOTmZQ4oS@pop-os.localdomain>
References: <20241110172836.331319-1-alexandre.ferrieux@orange.com>
 <173147403002.787328.3694466422358304986.git-patchwork-notify@kernel.org>
 <40bb5d4c-e21d-4eac-aec0-25b2f722be6d@orange.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40bb5d4c-e21d-4eac-aec0-25b2f722be6d@orange.com>

On Thu, Nov 14, 2024 at 07:24:27PM +0100, Alexandre Ferrieux wrote:
> Hi,
> 
> In the recent fix of u32's IDR leaks, one side remark is that the problem went
> unnoticed for 7 years due to the NULL result from idr_remove() being ignored at
> this call site.

I'd blame the lack of self test coverage. :)

> 
> Now, a cursory grep over the whole Linux tree shows 306 out of 386 call sites
> (excluding those hidden in macros, if any) don't bother to extract the value
> returned by idr_remove().
> 
> Indeed, a failed IDR removal is "mostly harmless" since IDs are not pointers so
> the mismatch is detectable (and is detected, returning NULL). However, in racy
> situations you may end up killing an innocent fresh entry, which may really
> break things a bit later. And in all cases, a true bug is the root cause.
> 
> So, unless we have reasons to think cls_u32 was the only place where two ID
> encodings might lend themselves to confusion, I'm wondering if it wouldn't make
> sense to chase the issue more systematically:
> 
>  - either with WARN_ON[_ONCE](idr_remove()==NULL) on each call site individually
> (a year-long endeavor implying tens of maintainers)
> 
>  - or with WARN_ON[_ONCE] just before returning NULL within idr_remove() itself,
> or even radix_tree_delete_item().
> 
> Opinions ?

Yeah, or simply WARN_ON uncleaned IDR in idr_destroy(), which is a more
common pattern.

Thanks.

