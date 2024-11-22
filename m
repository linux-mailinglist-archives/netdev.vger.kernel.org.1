Return-Path: <netdev+bounces-146860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 178919D6564
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 22:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 611F5B230A8
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 21:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6ED54F95;
	Fri, 22 Nov 2024 21:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kW5zBJr6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06AB249E5
	for <netdev@vger.kernel.org>; Fri, 22 Nov 2024 21:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732311160; cv=none; b=gyRpdQWWXhSb1kQE28Wj8mJRG+V/RDSN6y6228irm3LhQgw32R1rd5izNuaht1EM40FqWbYLezvK5ZIsD1f2TDlsu8bM3AWppRWWNp2gvHaEzBvSa9wf/6wkEkTmYs7GZCBLMC6Ge34d8zTyy0FXW/UiTXjzCXXnxkG0qHxHsiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732311160; c=relaxed/simple;
	bh=dXv1PiRGcDXNfWuYIqq3g0A28NGdezSbJEo2MdikXvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ligvbTR5HJ9ka7/sO73jF+jNKOj6B4kn+YgYwRssMMovdrCDqAWHPbe8gqK3aTnmc9Ar7Hc+XA55aVtcT/x6HMA5OuD6XbbFDcZU8Re+usRfHvKR7RyF+xaI5MDmSF3im+jf/uFvUymGsZJssV320gg/DsiPYe1o119VIABWu5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kW5zBJr6; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21262a191a5so24354535ad.0
        for <netdev@vger.kernel.org>; Fri, 22 Nov 2024 13:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732311158; x=1732915958; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mYTcvqfjtrjtpFAU2Uxdj+2oJFgoKrHUAvdti3Xth78=;
        b=kW5zBJr6SXkdFT0oDM47/eUNVpd/ahBtANTI6eBdXByOq/F83zHabv3gZ9zqfWeXfP
         tRrE3wGPP+X/G/FieytASlJW1hzX1fpT/vIkfOatkqeWbd5gSmx+PNO3Fwrqu6paubdH
         VUArO2UVzYsYG7Slr1w20DFsXgeeedZ0i+FffOZzkkb35wJLfgcW+HnBw9lwxzGlrnTc
         LWxvl9VTstl0rvHtQbqQl7sd6BZ1Io68KjF5Z0OoQ2vEilgPcwjMOqTiMisJHYUKLSTx
         wFlMR4MPIEa3K0dbShcswiHEcXRW1hcSJfunYKvBoLSGxVBDF/b0osPp4x/Og9cAGCXA
         eugA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732311158; x=1732915958;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mYTcvqfjtrjtpFAU2Uxdj+2oJFgoKrHUAvdti3Xth78=;
        b=WZlveCZCcihdwd+E733lnPnH/dvC4l72aubYYisN6frkAONVKhfVOWmYfFLsFaQ6TS
         ThrP+3IKFYW3xPJ57UBJFuAw+dqZjwzhDSj9ZtxhGWrsKXKH0i73QVF5nqSF79QjD+jp
         G5a7J/G+CpYzNWhKBew5EUVgaJt2Oczw8e9+di9/W9LtNrlDtKU9qm/gbYDTJQKxYGlz
         fKdKn62LRZcFqzgQfI0vMxcqfxVpQDXDaqQbfYv+jMBKsuYGTHcB1ATVbWOFun7qwlLC
         uGfDlp3arhUPnAd1CTw2YWX7GV/UHKzCLdVrCGRNP/5zaA0sXneC7SWFwcMalRC13tHZ
         kKSA==
X-Forwarded-Encrypted: i=1; AJvYcCUdgHA8qKCnTnk2/l/PbaAw1+XkQhTsz533v+nD7EQLQvdUsRwpkthCziyINrdO7FvEp5mm1u4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4CU+c6RBQpUkIEA3ET3BJUFwZ52SPaID6/5egjCDF6bE4G1+P
	djPq1+LUi8keLXrD1oo0Iw0zNKAqnpnN4pHRDdRCJkcaUP9hnSFM
X-Gm-Gg: ASbGncu8pyAtT4pmF8L85qKD6ewqUXSamjydrCG1fUkKRQDKPHbB94Usablk6CCWrxb
	T8jL3LxnHdpxeH/TmJLkZ3dgi8hIh8H0vfOMmZF70QMPqaWy/o3CMFptHme5JhhOdY9oIjRFubc
	pRanggo3Urnyx8fIguZg6I/PnrfO+5xs9JC9XuSLUwYxhyecc+w3KTB6tQ7sWgG+QLbScc8JEKB
	3V6xLQMmwyHiv8nWK1PlRpbG+3r/F/gEl7Dcdtdxfv+nHYmfkSS45gR
X-Google-Smtp-Source: AGHT+IGpD9syIr5v1mOShytgp4nI+qwwerXFScaDJzzQyaDCzQj60SGGb0LsLsRwb5D7qeR4oA927A==
X-Received: by 2002:a17:902:e88c:b0:202:cbf:2d6f with SMTP id d9443c01a7336-2129f290ee9mr52831225ad.57.1732311158030;
        Fri, 22 Nov 2024 13:32:38 -0800 (PST)
Received: from localhost ([2601:647:6881:9060:5940:b3b4:d5bc:a0b7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-212a1c17b02sm17737745ad.103.2024.11.22.13.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 13:32:37 -0800 (PST)
Date: Fri, 22 Nov 2024 13:32:36 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, edumazet@google.com, jhs@mojatatu.com,
	jiri@resnulli.us, horms@kernel.org, netdev@vger.kernel.org
Subject: Re: RFC: chasing all idr_remove() misses
Message-ID: <Z0D4dCaAf4CVJTde@pop-os.localdomain>
References: <20241110172836.331319-1-alexandre.ferrieux@orange.com>
 <173147403002.787328.3694466422358304986.git-patchwork-notify@kernel.org>
 <40bb5d4c-e21d-4eac-aec0-25b2f722be6d@orange.com>
 <ZzwLU6JHOTmZQ4oS@pop-os.localdomain>
 <96ec3de5-76a8-4d72-b8d7-feedff4a3af8@orange.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96ec3de5-76a8-4d72-b8d7-feedff4a3af8@orange.com>

On Tue, Nov 19, 2024 at 07:46:32AM +0100, Alexandre Ferrieux wrote:
> On 19/11/2024 04:51, Cong Wang wrote:
> > On Thu, Nov 14, 2024 at 07:24:27PM +0100, Alexandre Ferrieux wrote:
> >> Hi,
> >> 
> >> In the recent fix of u32's IDR leaks, one side remark is that the problem went
> >> unnoticed for 7 years due to the NULL result from idr_remove() being ignored at
> >> this call site.
> >> [...]
> >> So, unless we have reasons to think cls_u32 was the only place where two ID
> >> encodings might lend themselves to confusion, I'm wondering if it wouldn't make
> >> sense to chase the issue more systematically:
> >> 
> >>  - either with WARN_ON[_ONCE](idr_remove()==NULL) on each call site individually
> >> (a year-long endeavor implying tens of maintainers)
> >> 
> >>  - or with WARN_ON[_ONCE] just before returning NULL within idr_remove() itself,
> >> or even radix_tree_delete_item().
> >> 
> >> Opinions ?
> > 
> > Yeah, or simply WARN_ON uncleaned IDR in idr_destroy(), which is a more
> > common pattern.
> 
> No, in the general case, idr_destroy() only happens at the end of life of an IDR
> set. Some structures in the kernel have a long lifetime, which means possibly
> splipping out of fuzzers' scrutiny.

Sure, move it to where you believe is appropriate.

It is a very common pattern we detect resource leakage when destroying,
for a quick example, in inet_sock_destruct() we detect skb accounting
leaks:

 153         WARN_ON_ONCE(atomic_read(&sk->sk_rmem_alloc));
 154         WARN_ON_ONCE(refcount_read(&sk->sk_wmem_alloc));
 155         WARN_ON_ONCE(sk->sk_wmem_queued);
 156         WARN_ON_ONCE(sk_forward_alloc_get(sk));


Another example of IDR leakage detection can be found in
drivers/gpu/drm/vmwgfx/ttm_object.c:

447 void ttm_object_device_release(struct ttm_object_device **p_tdev)
448 {
449         struct ttm_object_device *tdev = *p_tdev;
450 
451         *p_tdev = NULL;
452 
453         WARN_ON_ONCE(!idr_is_empty(&tdev->idr));
454         idr_destroy(&tdev->idr);
455 
456         kfree(tdev);
457 }


> 
> As an illustration, in cls_u32 itself, in the 2048-delete-add loop I use in the
> tdc test committed with the fix, idr_destroy(&tp_c->handle_idr) is called only
> at the "cleanup" step, when deleting the interface.
> 
> You can only imagine, in the hundreds of other uses of IDR, the "miss rate" that
> would follow from targeting idr_destroy() instead of idr_remove().
> 

I am not saying it is suitable for this specific case, I am just saying it is a
common pattern for you to consier, that's all.

Thanks.

