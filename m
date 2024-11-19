Return-Path: <netdev+bounces-146098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9E39D1EFD
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 04:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B8E928237F
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 03:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B438E146018;
	Tue, 19 Nov 2024 03:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llieVSCN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CC12AF0A
	for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 03:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731988659; cv=none; b=U+aNO8jnd7PsyLKAZZmUDxrrP0NNdhL86uTXlz7uwhCmPaUedqYDGQEmmgCIVhPQKHYIoqLv4PAQYcYDD6aNDMuhbhLsv8eo6capl7zu77WmhEYSYvzYEGBZeYveuMhvVcVcOoQ1nwsr3gEFIPwwYhIQkPfjrl6sg40HglLo6uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731988659; c=relaxed/simple;
	bh=DoRXovwm/IoJAi/Zf+uGa8B0NCJAo5rejCZ0VB5rKnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFoXI0OLMttk2vFVJMebnY/zDE3GnwZxyDsnS6tfuBrVo3Fq+RkC0X/bOqmFkExOjLW6ztYj+sfYEsJdxxT1NduVAo0wBsTaJOn6lDswpvwGuV6saNHg3IQTGg4qqSlH4IM1em43K72QCGXLBGTvENYKNqIR6KBm+w6TrjtR07E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=llieVSCN; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7ee51d9ae30so2017638a12.1
        for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 19:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731988657; x=1732593457; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OPS5dTzCmaGrZinmeU4FT0BqXy6RnX8Tg2d2csGK6H0=;
        b=llieVSCNEqk2Pew2AwTI89FVDZrdFYA+yDj02Z6Sa0VjeV00oxOwavAJXGk9Yfvh65
         0xT6hSletz5MZsoR1iwQBTB2EnUdXZh9FjIE6NZ/YSVBy4Vw2F2BFl50HftBvq+E7mEB
         tIabr5X9QtuMyCfP/irQYOaALFE31MLvN05ks78YmeSu81VAXZU0WATIDHrI8Onu3UGo
         PufHVzvsbQGbSp/FfB0VjLQMXWgQRAlEkGAloz8mWG/XNmI7dY8P8K1M8hX9H+S4+m+5
         AjfI97F9ccfi3phCL5fmFQFrCOAVRXBM+RbxKAOrZ4hmB9Wzcz/v94e0es5QcxEiDDRO
         Dg1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731988657; x=1732593457;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OPS5dTzCmaGrZinmeU4FT0BqXy6RnX8Tg2d2csGK6H0=;
        b=kGI4/FAtcRTOw0sfGy6fAiSVpdKb2wPvetsh4dwTLnRrNM/FvHlmfW2Vnb79wlMP2C
         At0y0bxiRaOUNdWS2T96+YiSQNc52R7VWqO2d6iI/m8FoAQ0GoRFXZRIEXrBFNEbR1GS
         w3q5gaVFXfGCARyEZ7Wjk0vOl27wyZRhIY1cmCYBVXGII3vLStmvhYvRmRTe8NQh5wKZ
         zk5URlKmmwhD6FIkCBR9qXzcPpaK9lXl2e+C6ceF8/DnG/qI18DufkA5rstkFVwWlhkB
         ULzSjOgBi0W+QXv8Jl1kL3lIUCcE8ap5MCADLqHK3Gl9V+e7gYYN2Ai70ilMWF4bYMMM
         iBqw==
X-Forwarded-Encrypted: i=1; AJvYcCXDvXTKYFXcTbLMD0cAc499nldugMQ5Y1ejKbvtQ9dYeabdjgP6zuHnDl6p0lqTM525C0bVpSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaAKhbK0mExBgxCvb+9dVonCAf9idNO/BcR0VwI7fuqgPJ7biU
	EqPlTwtXefwwY3h8zRvajcwrTCPuyfFsIxEhTjMN0xwh6gd9Yk5A
X-Google-Smtp-Source: AGHT+IHSnnS11iY9ZXn5Pjb6QvgShCen131pwrDKMGGwv6e4UAHDTfr9hr8cFD6iArV5Y90lLYCyTg==
X-Received: by 2002:a05:6a21:7897:b0:1db:c20f:2c4d with SMTP id adf61e73a8af0-1dc90afc58cmr19365925637.2.1731988657585;
        Mon, 18 Nov 2024 19:57:37 -0800 (PST)
Received: from localhost ([2601:647:6881:9060:fd49:bc41:343a:fee5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211fad544c4sm43995325ad.282.2024.11.18.19.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 19:57:37 -0800 (PST)
Date: Mon, 18 Nov 2024 19:57:36 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, edumazet@google.com, jhs@mojatatu.com,
	jiri@resnulli.us, horms@kernel.org, netdev@vger.kernel.org
Subject: Re: RFC: chasing all idr_remove() misses
Message-ID: <ZzwMsJAVbGJZD5Az@pop-os.localdomain>
References: <20241110172836.331319-1-alexandre.ferrieux@orange.com>
 <173147403002.787328.3694466422358304986.git-patchwork-notify@kernel.org>
 <40bb5d4c-e21d-4eac-aec0-25b2f722be6d@orange.com>
 <ZzwLU6JHOTmZQ4oS@pop-os.localdomain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzwLU6JHOTmZQ4oS@pop-os.localdomain>

On Mon, Nov 18, 2024 at 07:51:47PM -0800, Cong Wang wrote:
> On Thu, Nov 14, 2024 at 07:24:27PM +0100, Alexandre Ferrieux wrote:
> > Hi,
> > 
> > In the recent fix of u32's IDR leaks, one side remark is that the problem went
> > unnoticed for 7 years due to the NULL result from idr_remove() being ignored at
> > this call site.
> 
> I'd blame the lack of self test coverage. :)
> 
> > 
> > Now, a cursory grep over the whole Linux tree shows 306 out of 386 call sites
> > (excluding those hidden in macros, if any) don't bother to extract the value
> > returned by idr_remove().
> > 
> > Indeed, a failed IDR removal is "mostly harmless" since IDs are not pointers so
> > the mismatch is detectable (and is detected, returning NULL). However, in racy
> > situations you may end up killing an innocent fresh entry, which may really
> > break things a bit later. And in all cases, a true bug is the root cause.
> > 
> > So, unless we have reasons to think cls_u32 was the only place where two ID
> > encodings might lend themselves to confusion, I'm wondering if it wouldn't make
> > sense to chase the issue more systematically:
> > 
> >  - either with WARN_ON[_ONCE](idr_remove()==NULL) on each call site individually
> > (a year-long endeavor implying tens of maintainers)
> > 
> >  - or with WARN_ON[_ONCE] just before returning NULL within idr_remove() itself,
> > or even radix_tree_delete_item().
> > 
> > Opinions ?
> 
> Yeah, or simply WARN_ON uncleaned IDR in idr_destroy(), which is a more
> common pattern.

Something like this (or, of course, move it to caller to reduce the noise):

diff --git a/lib/radix-tree.c b/lib/radix-tree.c
index 976b9bd02a1b..20cc690ffb32 100644
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -1559,6 +1559,8 @@ void __rcu **idr_get_free(struct radix_tree_root *root,
 void idr_destroy(struct idr *idr)
 {
        struct radix_tree_node *node = rcu_dereference_raw(idr->idr_rt.xa_head);
+
+       WARN_ON(!idr_is_empty(idr));
        if (radix_tree_is_internal_node(node))
                radix_tree_free_nodes(node);
        idr->idr_rt.xa_head = NULL;


