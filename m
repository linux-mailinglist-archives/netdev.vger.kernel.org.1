Return-Path: <netdev+bounces-239101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D24CC63D9E
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 12:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5257F4EF756
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 11:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8485329E75;
	Mon, 17 Nov 2025 11:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fA0QIt+Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B16329E7B
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 11:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763379321; cv=none; b=mGagM/moMHHNTbrb54VPFbv1gQ1nDbLlQmcOpPL5B4r9ya2fb/2mC0mpXqsXDzAdr+3T/air5evwrUto2mEYZn8GLQWwqIkp3eK1aSM/QUkTW4+fZSJLkTlm8GEfyBdiwHYdU4qrlmz8JWYIRwYY86J4GgqeE1EcPMW2XWTjO8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763379321; c=relaxed/simple;
	bh=I6qn8T9OloH2SwY804Ywtu0Iwvuz0lJ2cwzXMa1S7cM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YAIN1iC6Kc/rIP6p8OJklwSI7hKdLQ6rw27CKwvO3GRIzthufw2QFRXCd4jCybZcRJ1AbrmH66offLFLxAZHaNyLcT+579Pan7xrHSGduh/FKMwuj0CmBgowVrTGJJxR/4M5bwi+exwi6aM1c181Dnep9VcnWNRPVR/CrqyGbCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fA0QIt+Y; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-29568d93e87so37382505ad.2
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 03:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763379320; x=1763984120; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0w2CBv3xt6XYZVJpsYHadNIaQcj5i+N3tQ1qd3caqOg=;
        b=fA0QIt+YfKV9voD4cWwg1ZL8mFHpwZUyLy2NVy7RgU6eH2e/zSbGuJ7J+FqOTcoOHF
         PS2DZudDraiuDYg6ImGgGxZKhIhxApJef9Oyr7CXaYM3y5nyYfB9vAJeMvR5w9K3BWUn
         YiUuv/W3FFL066xaws6+MqfgGd+by+GcNsCvEirR9pkoSYuKmiGLlaTnDRY+eIK7SiVU
         SSbSMqnQ4esVE6c8Jxf6tI16ILjea4P01iYzyVlwqt6GAqT5gQN06RN4eOQ2eUNFKG4T
         pEHeW4WqCV52lhxU+vp2RuKv6o6Fu3o3Lc8d0lHHb77gMn5KzonXMxMxbODshpSO2MLW
         HuWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763379320; x=1763984120;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0w2CBv3xt6XYZVJpsYHadNIaQcj5i+N3tQ1qd3caqOg=;
        b=Na2gGH3pGkvsCNErEIb5ejVuCYuU/pWFSaiYnWROUsAfRLWFxdscmIyM1tNDUaaJsP
         APXQCg2riOUy5GfLh4+rRVRHmu5a43UKHVA2qxjev8wAGJhgWFoEIniGaAbsorgARblO
         Jy2SN5EI60IZJcTp3bXkjDht9Npb8xbek2MeS4DxT3VW9z+ezfHwl8A2/7GnhPqW5GGQ
         lNHDr+JppO4R837Oy0ajv0Qz3upjxqVIr7B+lG67PXaW9f/vnVnB2Xtrqne1r8zwHtHz
         arpPiGJh0e8oHRBjdnerNRzlHLCaJOdQTHIPZrUQIbXs1Dwknt2VRVQaYrZiy1x5EPiw
         POYw==
X-Forwarded-Encrypted: i=1; AJvYcCUVyq251M/fuXrnIFdb1byjl7P3AruMlJ/b6KugpZjdWGjCrNw2tZqvVcXo74gfmLUKAK93Dbw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhfH/ZZxomSH5MnZvriCQFjl3tAHm5lKTF4eRriv4l1XF/fsLA
	CTdd6vk9x1iBVYaNhN0lp8fzpAsPIfPjOmvHAykQC2JMwD6CSpmclCJX
X-Gm-Gg: ASbGncu2VWGlsEDfM+RWYvp0CyErX2GtnlQ8sCpRWCoLsrFFUz25jd3XhtrMB+tQ3kM
	FOeSlpYEhlgPnkkhN00ark9c0EByInvcF0nI7dMLLpW9JTXfQ00lx/Ui6rrC/CrUk1fsALTLenl
	r5TzMMOXxrrC1hgZg3YIrn20usqGQZRXrhCyxgyx9sQlIM4DTEGa9WTpCixKFe7iGItpmjGIAY8
	12mDu39mv1N3VZH/i/nQM60Yn5YG9bns65/OkyFH2b6REgTvLbtSyw+0gMgB/fndoyJYVTgiW+P
	wKOPhes4atC4qlLTtXpioxDFzGsZ8qqkm8yKtkJdhZIl6oFFex3Il2TpC6s6/qdPnOkNDo8wGY7
	i+qHalCjX0mFrJUsVaE+G48YI9AlZGj+P0CBllnXdzWpLtGSR9qd+dA/Gw6Y8vxfJAeuJAntUI/
	Zg3LA3OVijXVMsEw3jVHqA
X-Google-Smtp-Source: AGHT+IG635YafGXUVd7DvvphcfIU5ppiIl0oaJrECq0Sb7Uh7C8Et6uGZUlvvd1XsYkn+5XV8TwdKA==
X-Received: by 2002:a17:902:cf41:b0:27d:69cc:9a6 with SMTP id d9443c01a7336-2986a768205mr143606335ad.53.1763379319619;
        Mon, 17 Nov 2025 03:35:19 -0800 (PST)
Received: from google.com ([2401:fa00:95:201:43f6:9b48:f7fa:a8c9])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc36db25bfbsm12515724a12.1.2025.11.17.03.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 03:35:19 -0800 (PST)
Date: Mon, 17 Nov 2025 19:35:15 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Eric Dumazet <eric.dumazet@gmail.com>
Subject: Re: [PATCH 0/2] rbree: inline rb_first() and rb_last()
Message-ID: <aRsIc-7VImwUb58q@google.com>
References: <20251114140646.3817319-1-edumazet@google.com>
 <aRoRKp4yDGOsZ4o0@google.com>
 <CANn89iKYLf1AWi_YvK47NvQXb0B31NHxF736dXYg=2E5Xxg0Ew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iKYLf1AWi_YvK47NvQXb0B31NHxF736dXYg=2E5Xxg0Ew@mail.gmail.com>

On Sun, Nov 16, 2025 at 10:41:31AM -0800, Eric Dumazet wrote:
> On Sun, Nov 16, 2025 at 10:00 AM Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> >
> > Hi Eric,
> >
> > On Fri, Nov 14, 2025 at 02:06:44PM +0000, Eric Dumazet wrote:
> > > Inline these two small helpers, heavily used in TCP and FQ packet scheduler,
> > > and in many other places.
> > >
> > > This reduces kernel text size, and brings an 1.5 % improvement on network
> > > TCP stress test.
> >
> > Thanks for the patch!
> >
> > Just out of curiosity, do you think rb_first() and rb_last() would be
> > worth marking with __always_inline?
> 
> I have not seen any difference, what compilers are you using that
> would not inline this ?

I haven't specifically measured the difference. I was curious if using
__always_inline would be better to guarantee the compiler inlines the
function, given that the inline keyword is only a suggestion, and this
optimization is important for performance in a hot path.

Also, FWIW, I tried building an arm64 defconfig with LLVM both with and
without __always_inline. I got the same results from size vmlinux, but
scripts/bloat-o-meter output is as follows:

add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-8 (-8)
Function                                     old     new   delta
__aarch32_sigret_code_end                     24      16      -8
Total: Before=129127208516005098430, After=129127208516005098422, chg -0.00%

Regards,
Kuan-Wei

