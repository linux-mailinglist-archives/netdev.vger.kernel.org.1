Return-Path: <netdev+bounces-246712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF82CF0989
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 05:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE8943010A95
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 04:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE1E214228;
	Sun,  4 Jan 2026 04:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZquDOwM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D861FB1
	for <netdev@vger.kernel.org>; Sun,  4 Jan 2026 04:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767499785; cv=none; b=BzZ7YK8zrmMBPARr9CokxuS6bojrrbglFVjAmymnh0kVGNQCDZYqcpUlCowj6C9Kl9IFQSnqzTT0nualgUO5X0L7D4w8H7q+y0sz83jU/53IZltTfPHGqlUCvmENkuRrH50FaSDZL6yfqVCVLrHT1BXh/be3sAcqLlU+eXXn7JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767499785; c=relaxed/simple;
	bh=CWdTCyPiBCq7ICZDyB7LPh718eN9O1lVhdF1761lsS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pDNEkl3RGGxzx5G+wQ9DFTVa+QPQ3x5I13lwhAHoCSFvBDdS+pKDmXGE6WcBO6iObIWS/5bds+amgfqJkYNk2/PbN6PLktgjsPvfp6wsn5uMuquAC1e4tw1zECskaB9tuRt3hFAc3+/IpX0DqFrdGwtIYgq2nKwmPZCkSPhw0LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZquDOwM; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7b22ffa2a88so12256631b3a.1
        for <netdev@vger.kernel.org>; Sat, 03 Jan 2026 20:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767499783; x=1768104583; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HIDYdhgbmLC/n/3dGcuodkdR8j43Koq+KSNf/bsXcSs=;
        b=fZquDOwMmCnKJGGnFUJK1hOxCWB9v4LRpqp7q+tRxUqsIMfV+CoWq+cExewHYKgEGV
         UFzDDdzdslF+eHjyag9Plepw4JwQF9QD1wuv7NuTXPHT+65Ywan5dQ9W3LN/Msy8Iud4
         lz+EQDqPE2L+hlHKVYpv2qF1GVpau4ChLxQidw24ewfsO2aAuWQVajHA47G6es4JHyN9
         M7kX12LG+MdCGqc2BjbkjzX4LMB/Ty5gWkZcru99IdXNoQPs4ZVwFQjtjVwzzCi+8jVG
         nTkmJbiJqf+3u/u2Zq9ne/Rq4b9l2n6MbsemAuNPB/uCMoZexFTuiafZPr71cooLGF7R
         k8MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767499783; x=1768104583;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HIDYdhgbmLC/n/3dGcuodkdR8j43Koq+KSNf/bsXcSs=;
        b=ctIyxN2dUJG0ZH1CuXPeDNTN7jTE2pBDODWQ8o1Y8yzZFN62G1IIR0tsdjGTpst0CG
         CRBmqANIMOuk5HhJaO8uoUYPXP/4gCCaLz8RcY1x5m6s7nkFbbiOP14Z/qU/Wz7eR3yo
         13bhWbXPac6DIjBB4oMxvX5RRTzthlUAFFSjigx1Ia1Nn16xlvLA2F1E50q9OsYATuXg
         SYdvvJdf47wxJ3D4x5lm2DGHdxkbzP8gsZAdKHWi5P2JE/2SVwbxHVPY4oLj+3NKCnNZ
         42r0C98elwEBCMS7sQ4KkMvcNghru75/F2zJIP387KJ21TZAhjQD7zyaf2fONBurMA/6
         zu/g==
X-Gm-Message-State: AOJu0YxqPGCTCCimxlBXL3k+qfi6muDn2MG71tV/+b017FoVjUqQ2o9H
	L8wtyEnrmv1J3u1QEo47lkjM/bEyz7XcIpu7AQla8B0a/A7uNgFYz7Fp
X-Gm-Gg: AY/fxX5ZUr1kcDpwDisNBtnM4trndfNzz6MKdDBP/3LkNkbJkIlCxRO2PxIRCglEx9q
	zAubZKbg96PD1wehA9ZW1wzVOxlMJniwUInLc5porgN1U8sGhO/OavH1WOlwr5r3LF3MnHIIwVv
	zbqLaesd48GyynuKMFcrOam5g2PXlOV5LRYgAcYYReVrwS6oTbNK2EKB4g1LKdr5xuuufSzgDHk
	0PH5H5jtZUD7xz5TWJIFChmeMd79zteBVZJwiPrueYDtSgbk/xUGoo6SyNjPA6KDb2QYnE0RyT2
	L7sfIp/px60poVNRsULaCqiEBn0X+3WTp+0BcEZ0L1azo/qvU/QxKVMK23Rxyd+/HaPdGQTzGL/
	/jR1PTJe4LAYYhvEmtSKjOyLvy1LfBmTn7i0AVphCaCZZcOfOfrln+rEkWyzdSBtYFsypisHsk2
	OeD8NCrfEuTIT5WoyuZQ==
X-Google-Smtp-Source: AGHT+IEtJHLLEK4IA269i9Glg20fwn8Q+NmWxNnkOhWD91BM5BQTjnqlgYygm09/eXhcxlyYmbHhhg==
X-Received: by 2002:a05:6a00:8087:b0:7f7:394e:b3 with SMTP id d2e1a72fcca58-7ff6795a243mr31363468b3a.46.1767499783434;
        Sat, 03 Jan 2026 20:09:43 -0800 (PST)
Received: from localhost ([2601:647:6802:dbc0:cb59:f2a4:2079:8f4c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e48e1d6sm41605345b3a.53.2026.01.03.20.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 20:09:42 -0800 (PST)
Date: Sat, 3 Jan 2026 20:09:41 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Shivani Gupta <shivani07g@gmail.com>
Cc: netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	syzbot+8f1c492ffa4644ff3826@syzkaller.appspotmail.com
Subject: Re: [PATCH] net/sched: act_api: avoid dereferencing ERR_PTR in
 tcf_idrinfo_destroy
Message-ID: <aVnoBRuEMazh2Q1F@pop-os.localdomain>
References: <20260102232116.204796-1-shivani07g@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260102232116.204796-1-shivani07g@gmail.com>

On Fri, Jan 02, 2026 at 11:21:16PM +0000, Shivani Gupta wrote:
> syzbot reported a crash in tc_act_in_hw() during netns teardown where
> tcf_idrinfo_destroy() passed an ERR_PTR(-EBUSY) value as a tc_action
> pointer, leading to an invalid dereference.
> 
> Guard against ERR_PTR entries when iterating the action IDR so teardown
> does not call tc_act_in_hw() on an error pointer.
> 
> Link: https://syzkaller.appspot.com/bug?extid=8f1c492ffa4644ff3826
> Reported-by: syzbot+8f1c492ffa4644ff3826@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=8f1c492ffa4644ff3826
> Signed-off-by: Shivani Gupta <shivani07g@gmail.com>

Thanks for the patch, Shivani.

Could you provide a Fixes tag for this while you are on it?

> ---
>  net/sched/act_api.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/net/sched/act_api.c b/net/sched/act_api.c
> index ff6be5cfe2b0..994f7ffe26a5 100644
> --- a/net/sched/act_api.c
> +++ b/net/sched/act_api.c
> @@ -940,6 +940,10 @@ void tcf_idrinfo_destroy(const struct tc_action_ops *ops,
>  	int ret;
>  
>  	idr_for_each_entry_ul(idr, p, tmp, id) {
> +		if (IS_ERR(p)) {
> +			WARN_ON_ONCE(1);

Hm, I guess we should remove this warning here since ERR_PTR is expected
in some corner case?

Regards,
Cong Wang

