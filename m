Return-Path: <netdev+bounces-86215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D68689E02C
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 18:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B85931F21F3B
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 16:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7763113D8A3;
	Tue,  9 Apr 2024 16:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KsXVlU5Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85764F883
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 16:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712679476; cv=none; b=G7VW6YF+ygKQqbn2SNYAB1PinjvgbVklI27fOAXfdGF4f7iPupOpt7e0cwTu5xWN3UIjUyxDc7fhPMqm4nvUpD6MAt0WeTwKGumQ6KskNBjpnT8g6Fo7XAcd9JnBG0gS+nugW5ncPx8kSFTAuPd2ucKUv8v9ylamA+iLF9JwY2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712679476; c=relaxed/simple;
	bh=cJq3TaB12y1+3tX/CpoQNDUPIteKzZNWbXEr1MNnXlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qs2GpUxPnsa24we2e4ImevCFBnbxzf8MqmSRo8YfAdvChGAyT6uq5fYE4lcN+Lc1IwE5RTyPHAy5EFCoTU1RSEouVMr+VCY8FSGEszMcbNJ7I/VssYt3g29W9TL0kTOPP6M8ei5JiFT9B7Tk53KiUdBjO3yVfQ7trMlC3R3t5/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KsXVlU5Q; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6ed0938cd1dso3673898b3a.2
        for <netdev@vger.kernel.org>; Tue, 09 Apr 2024 09:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712679474; x=1713284274; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VlcmHNsCwSvCc74TrBcs49hXKJM0udmD4CNSlCrF+Lo=;
        b=KsXVlU5QbFYMDKbO4iO93x3QNISOWDpBERnT0yXNQ0YF5TKpxiOhMBxYHqJ5pl4wVV
         7bcoRugnIXsaVTwkoIUEGXNIZR+CvPeIOZbGPc5oR0zWQ4M1KhDi6i+tDKj+rQ3sJkwq
         j/IEB0lbRPo7V+dp9/nT25nDh0/7DRf+jmsI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712679474; x=1713284274;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VlcmHNsCwSvCc74TrBcs49hXKJM0udmD4CNSlCrF+Lo=;
        b=umjPTZpyP4AW2ke6BiCLLGN7YJPDRE8bEH4CxKlLelEHPn5jwZhyfdymFm9XcDX9vp
         UOVdk09hi/e4FzM8YPVHvAmmHWVP4VGG2fo7ryA+R+QlPuxuzckG8tqcJxZskhJU8aGS
         JbD099ObpLEKpceBhh4b2SHQyEDIcyobI7pAS+0lnr3zrO79fWS0sGFqBTd2nYeWMTJe
         gIZyaG1RPGabteDQeL7AZf0XLD2A4Z+SEu7CGsOMztekasboHZQ0aSXKPZxqD/F/7DMH
         7zOzP2HaRtTXPt1DKG0wlzPOeG+97nFYg8VkDK+OYuALRa7AppAeB8iJ+Q9d97vY8XM7
         Aywg==
X-Forwarded-Encrypted: i=1; AJvYcCVLtGJaOdp64MZ7D75qjkrGokJTSonqu7SpZs5wK6ZHajQPcaROea1rswBAN1tInhzvztwRux9b72TA7Qn0LPvRvsqCsPc+
X-Gm-Message-State: AOJu0YwN0Kdh7GgzTHeM6UTizUDup2LYDJ3wygGBa8edFMZ6qTgMuz6d
	5ink0lDjBMt/VTE4UTdtE6BM522IOThKg7/tIZPCtlQR0KBVTRvydNLAqXhH4A==
X-Google-Smtp-Source: AGHT+IF+HuccTfimdnMNYhgaM6Pzx7wcEOoErnnFz7FQkS1gRTkWP5q8FoX5RgQ6dGyVfovJAJRQEA==
X-Received: by 2002:a05:6a20:244d:b0:1a7:a3ba:2bc1 with SMTP id t13-20020a056a20244d00b001a7a3ba2bc1mr405903pzc.15.1712679474281;
        Tue, 09 Apr 2024 09:17:54 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y16-20020aa78550000000b006ecda086db2sm8483699pfn.110.2024.04.09.09.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 09:17:53 -0700 (PDT)
Date: Tue, 9 Apr 2024 09:17:53 -0700
From: Kees Cook <keescook@chromium.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Christoph Lameter <cl@linux.com>, Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v9 7/9] libeth: add Rx buffer management
Message-ID: <202404090909.51BAC81A6@keescook>
References: <20240404154402.3581254-1-aleksander.lobakin@intel.com>
 <20240404154402.3581254-8-aleksander.lobakin@intel.com>
 <20240405212513.0d189968@kernel.org>
 <1dda8fd5-233b-4b26-95cc-f4eb339a7f88@intel.com>
 <755c17b2-0ec2-49dd-9352-63e5d2f1ba4c@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <755c17b2-0ec2-49dd-9352-63e5d2f1ba4c@intel.com>

On Mon, Apr 08, 2024 at 11:45:32AM +0200, Alexander Lobakin wrote:
> From: Alexander Lobakin <aleksander.lobakin@intel.com>
> Date: Mon, 8 Apr 2024 11:11:12 +0200
> 
> > From: Jakub Kicinski <kuba@kernel.org>
> > Date: Fri, 5 Apr 2024 21:25:13 -0700
> > 
> >> On Thu,  4 Apr 2024 17:44:00 +0200 Alexander Lobakin wrote:
> >>> +/**
> >>> + * struct libeth_fq - structure representing a buffer queue
> >>> + * @fp: hotpath part of the structure
> >>
> >> Second time this happens this week, so maybe some tooling change in 6.9
> >> but apparently kdoc does not want to know about the tagged struct:
> >>
> >> include/net/libeth/rx.h:69: warning: Excess struct member 'fp' description in 'libeth_fq'
> > 
> > Oh no, maybe we should teach kdoc to parse struct_group*()?
> 
> scripts/kernel-doc apparently can handle them...
> 
> + Kees
> 

Ah, hm, scripts/kernel-doc throws away the early arguments of
struct_group_tagged, but I suspect it needs to create a synthetic member
for the tag. i.e. instead of:

	struct_group_tagged(tag, name, members...)

becoming

	members...

it needs to become

	struct tag name;
	members...

It seems this is the first place anyone has tried to document the tagged
struct name! :)

Does this work? I haven't tested it...

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 967f1abb0edb..64a19228d5dd 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -1151,7 +1151,8 @@ sub dump_struct($$) {
         # - first eat non-declaration parameters and rewrite for final match
         # - then remove macro, outer parens, and trailing semicolon
         $members =~ s/\bstruct_group\s*\(([^,]*,)/STRUCT_GROUP(/gos;
-        $members =~ s/\bstruct_group_(attr|tagged)\s*\(([^,]*,){2}/STRUCT_GROUP(/gos;
+        $members =~ s/\bstruct_group_attr\s*\(([^,]*,){2}/STRUCT_GROUP(/gos;
+        $members =~ s/\bstruct_group_tagged\s*\(([^,]*,)([^,]*,)/struct $1 $2; STRUCT_GROUP(/gos;
         $members =~ s/\b__struct_group\s*\(([^,]*,){3}/STRUCT_GROUP(/gos;
         $members =~ s/\bSTRUCT_GROUP(\(((?:(?>[^)(]+)|(?1))*)\))[^;]*;/$2/gos;
 

> > 
> >>
> >>> + * @pp: &page_pool for buffer management
> >>> + * @fqes: array of Rx buffers
> >>> + * @truesize: size to allocate per buffer, w/overhead
> >>> + * @count: number of descriptors/buffers the queue has
> >>> + * @buf_len: HW-writeable length per each buffer
> >>> + * @nid: ID of the closest NUMA node with memory
> >>> + */
> >>> +struct libeth_fq {
> >>> +	struct_group_tagged(libeth_fq_fp, fp,
> >>> +		struct page_pool	*pp;
> >>> +		struct libeth_fqe	*fqes;
> >>> +
> >>> +		u32			truesize;
> >>> +		u32			count;
> >>> +	);
> >>> +
> >>> +	/* Cold fields */
> >>> +	u32			buf_len;
> >>> +	int			nid;
> >>> +};
> 
> Thanks,
> Olek

-- 
Kees Cook

