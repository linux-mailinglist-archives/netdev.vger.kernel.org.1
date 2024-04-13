Return-Path: <netdev+bounces-87626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 957E78A3DF5
	for <lists+netdev@lfdr.de>; Sat, 13 Apr 2024 19:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E741B20F78
	for <lists+netdev@lfdr.de>; Sat, 13 Apr 2024 17:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67494CB2E;
	Sat, 13 Apr 2024 17:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHjThv5z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45394262BD
	for <netdev@vger.kernel.org>; Sat, 13 Apr 2024 17:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713029182; cv=none; b=kTbydTpYt0ckthyQ7LQwdkhqFjhLhhKzXQwFu9av77vhQsZ8P3Q9sBC9s0e/ORj6+pgMwRvkrzGuTRX75PQt07rovtehwV4F+X8g05y0vwR/2Czj0+Jzw1y1Lv7ohKY7DCNtaIjBaGVqxbpLxjr1OA3Nq8BJSQfdaBIMWSulnYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713029182; c=relaxed/simple;
	bh=YJ1dVmK60oRxeK7I3EmHZI9tUH5TNvhCglBYB0+XFtY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=KYPpfWkFf641G5QoJICLWB6Di/sL9j4K/JDqPFU5ptb9e9+vWRtXNrUdm5dewKDLPCulgIqyYW/bxtsBnjhbscTh9icuu7I/IkZedDJMr0sHQ7vCYIA3zfb2kmS9LpuBH4fbB6Jvv2CPLKIUK4wKdMwLjgoMtVoKd8Y3netclBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YHjThv5z; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-69629b4ae2bso16832796d6.3
        for <netdev@vger.kernel.org>; Sat, 13 Apr 2024 10:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713029180; x=1713633980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fRPDT21bx3aMHrXbCB1GjfTOWVpb1sd6iPykZdeolHc=;
        b=YHjThv5zJEjET4ytEh9CnS8vq3cbxdHY2GN4boXEd0ucCNMbOfPhx+M4gACZbnI+cB
         RAjXwqnhUT8J7bkR5hmBSEfUa2impPDwFGlXnvj4idVe6jN3W6OCvSGhVBg4+tyjZZMj
         341wgdW3G+fH6QZbDScfzTHsotTfreH4GYT8GB9U1JY2suXAsRCVcHie069yQbdc8WsH
         n+/JQVV4XtBkXOOoi6j9+f2s+xUAB9R2LKfLrlSIiE73t+31E0yXVp7AtatykX44EgcN
         mZtOG8Ho+2J97jcmu69BuesZWC/7gfbqVibRpGbIP0Krr+0rqgkFErD3BWOskiDmbnys
         yrrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713029180; x=1713633980;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fRPDT21bx3aMHrXbCB1GjfTOWVpb1sd6iPykZdeolHc=;
        b=wGtFLT1Slo2jlgVTukj0b7/9MG8GG2igDnk5LH70IWipfO80IsBfsekWFNH7ttiRWm
         ScgF6HnNBbDrpLF5/MUjw4gGkuvE4HnP+iSm2tTwgorndd5m1pt8LLRO6cZodX+v14DS
         dz+yvcR2GRD1AG/i2PPPQpUn2NscF9nW4Y1QD6uonQcGOqw+nu4CsOEO8ywmEYRDCyLp
         xXnQkuka6QFExA1tcG9uTmywMroJd71CxslKklX3m+ddPasn0U2jXU5apkT/0CseFavF
         odvqYmXWI1k3cFzGyoSCGwkL4cwTDPZi/rpBDYPqP2buRugXesq5ftOfqt+CWt1eSIQE
         ymYg==
X-Forwarded-Encrypted: i=1; AJvYcCWSiW4KmMbhDHrfNrkFZ8okE0TLttaTcFtopqmln0cMWF2e1pKngLaVjBzd/a+qrj7OBFK+yCcBMLdoQ5SX0unN/P4zca95
X-Gm-Message-State: AOJu0YxAPW4FNzRljrNLCCn62qPS/nY+7Gj89PjqpLoio1ci9l/yFnAj
	x8IJRemJpAkHAtayJdBEvgyRIiIbCbhzMBy0+yf9oW5XTh3ljID3
X-Google-Smtp-Source: AGHT+IGdQagF4rSmxElzkps1mr/+6Zcc0ApYJxlRTDoxw8SdOd4c6yg5mEzn5mIkdczfxvnD+9zDxA==
X-Received: by 2002:a0c:fa4b:0:b0:69b:1dd3:3610 with SMTP id k11-20020a0cfa4b000000b0069b1dd33610mr5701997qvo.49.1713029180058;
        Sat, 13 Apr 2024 10:26:20 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id jy16-20020a0562142b5000b0069b50ce8c1asm3316039qvb.71.2024.04.13.10.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 10:26:19 -0700 (PDT)
Date: Sat, 13 Apr 2024 13:26:19 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, 
 krisman@suse.de
Cc: davem@davemloft.net, 
 kuniyu@amazon.com, 
 lmb@isovalent.com, 
 martin.lau@kernel.org, 
 netdev@vger.kernel.org, 
 willemdebruijn.kernel@gmail.com
Message-ID: <661ac03b65993_3be9a729488@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240413012539.16180-1-kuniyu@amazon.com>
References: <20240412212004.17181-1-krisman@suse.de>
 <20240413012539.16180-1-kuniyu@amazon.com>
Subject: Re: [PATCH v3] udp: Avoid call to compute_score on multiple sites
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Kuniyuki Iwashima wrote:
> From: Gabriel Krisman Bertazi <krisman@suse.de>
> Date: Fri, 12 Apr 2024 17:20:04 -0400
> > We've observed a 7-12% performance regression in iperf3 UDP ipv4 and
> > ipv6 tests with multiple sockets on Zen3 cpus, which we traced back to
> > commit f0ea27e7bfe1 ("udp: re-score reuseport groups when connected
> > sockets are present").  The failing tests were those that would spawn
> > UDP sockets per-cpu on systems that have a high number of cpus.
> > 
> > Unsurprisingly, it is not caused by the extra re-scoring of the reused
> > socket, but due to the compiler no longer inlining compute_score, once
> > it has the extra call site in udp4_lib_lookup2.  This is augmented by
> > the "Safe RET" mitigation for SRSO, needed in our Zen3 cpus.
> > 
> > We could just explicitly inline it, but compute_score() is quite a large
> > function, around 300b.  Inlining in two sites would almost double
> > udp4_lib_lookup2, which is a silly thing to do just to workaround a
> > mitigation.  Instead, this patch shuffles the code a bit to avoid the
> > multiple calls to compute_score.  Since it is a static function used in
> > one spot, the compiler can safely fold it in, as it did before, without
> > increasing the text size.
> > 
> > With this patch applied I ran my original iperf3 testcases.  The failing
> > cases all looked like this (ipv4):
> > 	iperf3 -c 127.0.0.1 --udp -4 -f K -b $R -l 8920 -t 30 -i 5 -P 64 -O 2
> > 
> > where $R is either 1G/10G/0 (max, unlimited).  I ran 3 times each.
> > baseline is v6.9-rc3. harmean == harmonic mean; CV == coefficient of
> > variation.
> > 
> > ipv4:
> >                  1G                10G                  MAX
> > 	    HARMEAN  (CV)      HARMEAN  (CV)    HARMEAN     (CV)
> > baseline 1743852.66(0.0208) 1725933.02(0.0167) 1705203.78(0.0386)
> > patched  1968727.61(0.0035) 1962283.22(0.0195) 1923853.50(0.0256)
> > 
> > ipv6:
> >                  1G                10G                  MAX
> > 	    HARMEAN  (CV)      HARMEAN  (CV)    HARMEAN     (CV)
> > baseline 1729020.03(0.0028) 1691704.49(0.0243) 1692251.34(0.0083)
> > patched  1900422.19(0.0067) 1900968.01(0.0067) 1568532.72(0.1519)
> > 
> > This restores the performance we had before the change above with this
> > benchmark.  We obviously don't expect any real impact when mitigations
> > are disabled, but just to be sure it also doesn't regresses:
> > 
> > mitigations=off ipv4:
> >                  1G                10G                  MAX
> > 	    HARMEAN  (CV)      HARMEAN  (CV)    HARMEAN     (CV)
> > baseline 3230279.97(0.0066) 3229320.91(0.0060) 2605693.19(0.0697)
> > patched  3242802.36(0.0073) 3239310.71(0.0035) 2502427.19(0.0882)
> > 
> > Cc: Lorenz Bauer <lmb@isovalent.com>
> > Fixes: f0ea27e7bfe1 ("udp: re-score reuseport groups when connected sockets are present")
> > Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
> 
> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

