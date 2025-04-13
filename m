Return-Path: <netdev+bounces-181964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FC5A871B1
	for <lists+netdev@lfdr.de>; Sun, 13 Apr 2025 12:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C02E43BCE57
	for <lists+netdev@lfdr.de>; Sun, 13 Apr 2025 10:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3330199FAF;
	Sun, 13 Apr 2025 10:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MlunAQoJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0742D16A395;
	Sun, 13 Apr 2025 10:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744541783; cv=none; b=IExxu7u6JT9nizTeH+rqaeTkCPtv/+57kVlm3GiItC1I57IxalJ+svuyewqOttQ7zQvUoLW6pMfsOyA99X4G/IA9LARqucRCAk7rLvJUtorOxfkFn7wIv149sXSHjM2Zw5r44b9H6DybmSzamSQvLe4p4reDRor+IsZ3PSnUqnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744541783; c=relaxed/simple;
	bh=+n1kNUp9ctpglIjl+OjOVnEJhfaR3aQXMqdU8q2XJGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cnyOSqZmIjrvGuzYXgh5pOC/ARBbKkOVUFhvDnYMWkINi4RXwM6GccDsIR7rse2/zi4gJ4I8EKnQKzZJd3c8VbiYJhyqaHlfzmmj8Y4bsQo2z8/bfMw/oVY1UiNNUVvcxyIt2OuGoMh2Z3GSp+73U5VrCWLAcpYyAQCWtaWvst0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MlunAQoJ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cef035a3bso23800435e9.1;
        Sun, 13 Apr 2025 03:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744541780; x=1745146580; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=unfA7H7Wh4ud0mT4r/dlHs6FABHRLDpE/p/zG6LT3DU=;
        b=MlunAQoJf0IaMqrkT5NXMsu7cvoJXHnm1xw2DtOqGpRGugyaWPO+EytjAG3gHnlhTh
         zQic3hJOb7wdv6M1rb7QpAsUUwoXGhfvIJL/I0c8DjYJhInyDr5xk11oKcS/57KvrUl5
         eGaa6i/fowBboCUAHgayyjruja6N71Q2Lj2/wgP67+WagOi99OajUgG1HoVOPay5/Ggn
         NfeoUgjGi8ygUtH0v+Lg2zHa5finWazzNmh5tEjCBR6pwiLdANftvs8wXiALsp1jFu66
         V7/pSuXR7oMfZZUIs1CuQ2tHIYleodQDnWVwP1U0XOCy3U2S84Q+lysbOZhvVT9Ep9pV
         mbhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744541780; x=1745146580;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=unfA7H7Wh4ud0mT4r/dlHs6FABHRLDpE/p/zG6LT3DU=;
        b=a8kDhkxLjgsGM6IIhLCLUETKdqAOQAZZvgeje3CVW1+4fW1olzayh/za6T0q5PZSVe
         avIDgJX+lkLlqdJLZV9c6S2ecgRVy3COfJsTOzGHIuV3CCGnmp7S3YHGgVVkStct4Sf9
         zJELhJ247+/glrF21IUoi2EaGZTckzFAYTdnbTNNpdaALMQxG+dT0rqAJ09VsdRFrPUb
         EYVY9IZuzrsI5rVYnHcTf3xmkwhuDwFh6G6p915B7k3il5lH7PYcQ+fFe1zJktnktSlX
         r6F9hTlq42UicR8/dRiUVdPUgLZjB3vSv1xo+H6Gpw13+Fya3mNf/HAlEhm4kmZX+mDb
         MM5w==
X-Forwarded-Encrypted: i=1; AJvYcCUrzqD6ldNNXmGTPkW0TwoVRBUO6C1K3tHifXZUJELJBfVPWwtndhEh4qMJq5SxnXA9xs75elO8gAlXS+Y=@vger.kernel.org, AJvYcCWcmno0Gq8fRqcQA/JOENauSeJ6UFwRP58rYz6WDbl+7WswO7OoW3i7Rv2ZQW3GBIYaIKBTFT2X@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj+PRLHvUojLKegp5KGzFJoeeYbffM6j5hYne0M1nL4ypUc0l0
	o5AnVVZfTRsU+9z4Iy9blEKWLtdl1+ruiPlT3tgjIFQR1hhSdoDkogoxGA==
X-Gm-Gg: ASbGncuo77//WqKxUysgOKh/tn3Hz5nkKtQjgkSzgGZdWlTzO8DOnbJPPIfBbalG9x9
	PHHheesbdH94tVbCgj1Q6ls5Jn0AObGrDznilMIyjznYHhID/fjxjCCQNXZiYYNgpoj2S4On34M
	XVB6aIsQLF05sX77QBQyE2NfEgNZ8q3rJsk78qzLbVazDYx/1DvcvzWoZgJc5nnYYpSjY5ICJeD
	6Bb3Kt5z5t0wJ6RDx5HZ0SvMLMkOxsMDCIW/fCcjE5WkP5hX4nBsQM1IBty4UNB87noYnQBe4DQ
	PxKLtTvgIYFKVIu5U+iA9q2WURMmHZjjG1UNgnYEVFRk
X-Google-Smtp-Source: AGHT+IGoA82m5Y33dJSGa3g4clowsff9mfCHwBq9BWiDnFKC/LW37vHHW3yX7XeJ3OvB5yGCOiVabA==
X-Received: by 2002:a05:600c:3baa:b0:43c:efed:732c with SMTP id 5b1f17b1804b1-43f3a9b0285mr68786485e9.28.1744541779941;
        Sun, 13 Apr 2025 03:56:19 -0700 (PDT)
Received: from qasdev.system ([2a02:c7c:6696:8300:71dd:ba03:ed49:5ad0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae979684sm7661805f8f.55.2025.04.13.03.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Apr 2025 03:56:19 -0700 (PDT)
Date: Sun, 13 Apr 2025 11:56:10 +0100
From: Qasim Ijaz <qasdev00@gmail.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: jlayton@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, nathan@kernel.org
Subject: Re: [PATCH] net: use %ld format specifier for PTR_ERR in pr_warn
Message-ID: <Z_uYSmMDHE_vpFcQ@qasdev.system>
References: <20250412225528.12667-1-qasdev00@gmail.com>
 <20250412232839.66642-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250412232839.66642-1-kuniyu@amazon.com>

On Sat, Apr 12, 2025 at 04:28:38PM -0700, Kuniyuki Iwashima wrote:
> From: Qasim Ijaz <qasdev00@gmail.com>
> Date: Sat, 12 Apr 2025 23:55:28 +0100
> > PTR_ERR yields type long, so use %ld format specifier in pr_warn.
> 
> errno fits in the range of int, so no need to use %ld.
> 
> 
> > 
> > Fixes: 193510c95215 ("net: add debugfs files for showing netns refcount tracking info")
> 
> The series is not yet applied.  It's not necessary this time, but
> in such a case, please reply to the original patch thread.
> 
> Also, please make sure your patch can be applied cleanly on the latest
> remote net-next.git and the Fixes tag points to an existing commit.
> 
Hi Kuniyuki

Thank you for your comments, as Nathan said the current code emits a
compiler warning as per the kernel test robot. 

Given this would you like me to resend patch v2 with the changes you and
Nathan specified?

Regards,
Qasim
> 
> > Signed-off-by: Qasim Ijaz <qasdev00@gmail.com> 
> > ---
> >  net/core/net_namespace.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
> > index f47b9f10af24..a419a3aa57a6 100644
> > --- a/net/core/net_namespace.c
> > +++ b/net/core/net_namespace.c
> > @@ -1652,7 +1652,7 @@ static int __init ns_debug_init(void)
> >  	if (ref_tracker_debug_dir) {
> >  		ns_ref_tracker_dir = debugfs_create_dir("net_ns", ref_tracker_debug_dir);
> >  		if (IS_ERR(ns_ref_tracker_dir)) {
> > -			pr_warn("net: unable to create ref_tracker/net_ns directory: %d\n",
> > +			pr_warn("net: unable to create ref_tracker/net_ns directory: %ld\n",
> >  				PTR_ERR(ns_ref_tracker_dir));
> >  			goto out;
> >  		}
> > -- 
> > 2.39.5

