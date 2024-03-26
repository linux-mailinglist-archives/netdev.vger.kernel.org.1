Return-Path: <netdev+bounces-82060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D44F888C392
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 14:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39FCAB21AC4
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 13:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A870F6EB62;
	Tue, 26 Mar 2024 13:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/hstJ6Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B1B125C9
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 13:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711460239; cv=none; b=gVLrKRwL/KD2uH1UGSfCYXi6I2Bfm7Bz7w8Qdlrt8899BcrRNpIQCD4fyuNxV7gNo5A28A4KmyvdmDyHWOc0+/8SEJKZY1f5Npjf1tovpegw1uZs7LU2jzc2JLc7AxuK4nkdCUIqEhvsVWa8xEHGeOW0rzRuVb+JCnef/z4bcfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711460239; c=relaxed/simple;
	bh=jzjLBA1/3dNQ8pDp+HV6y2wdEy6MvjyrtJS4zlxCY+c=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Pt7Bt5NaNK2eH/8Jh6UST95dA5VeVzMYEwTtFwxE5A/jtUs3haA9OTRjh0TLGecs0GgVie/yarVEo4a07/DFrVgPtxqPkinfXPv6j3yT7SWbcHXcC9r1oy2UA3KtXkiv+Agim9/PAWpU6G78mKvzIj/GQt8jLLYdmW2NqnpKafg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/hstJ6Z; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-69699fecccdso4879336d6.1
        for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 06:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711460237; x=1712065037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YcTKXO+Y9LuhyCrrpw/z6jByz5MjWmlYBpNdiMPI/b0=;
        b=C/hstJ6ZU5hlpsRhtx6U1RXN7juctbCWqwj2fWWt8pcaDNVSwzd+bicfvMR3t2Yco9
         9psDU/e9dkxX/+YYnWd2rmV1UglcOdUBmL0pbKEcGynKxdIZ8pjm2MdDst7UthFTcdpa
         9Lr0SvDvP9gxE5bOGQpKT4CCMjga9rtp2+IU3BV+SG7tnucW6YIrsycb63PQEw0hct3k
         0W5XyAa8WgBdMY3GyPoH59kbsPBB7uncXdVG0HfJIUseWYkorEF/+tlaGnrggSxQ6Qhw
         uFS11if3Em41kkaMX07C5aR4UXswhq2XZs9cb9vWw5VrPtNLGy1JzlCDHXu1o/a+NklF
         E8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711460237; x=1712065037;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YcTKXO+Y9LuhyCrrpw/z6jByz5MjWmlYBpNdiMPI/b0=;
        b=ny6ekS+EjZec+sWX687vYnh/I9m3qWDCLpCraOzXDifPNmONOxE7zzRc6w49JYtoZA
         mMb8umvGOJIOoOY1Q/W1RobU8hD8sKeIUkEWEb5ayusbj+p7cR7uWS3/ZTMbm7PLak04
         g3RFHUCfjc8iXVd6AWsDPFyhdRYrdk6+fMts4Y6RA0KM2g8o4UY12t/fIEkvMxp7P7l7
         O9BtCsFAD0lX54T1cFt58r127Du6QYT9BpAjZZtovRamopWRtR+mpID6PZgU7Gpnul+E
         fihJwNBJM2J6+JkbX+WfhqzA5mqi5hJpi3QPg3twAbf2cXAPu4js/lN/rqPZ3K1LEyy5
         k7mw==
X-Forwarded-Encrypted: i=1; AJvYcCW1rlCXOcVN/o/URU7Ar5vwt+aSIyK00Wq7OwvDE4vdXWjNNb0s6jsHoVNUwqSdgw/UkhI/zlciCYDDJ0mbxKQRrq/CcG0k
X-Gm-Message-State: AOJu0YyICWcB1uH4gnyRa5MVDaSbjH8GEjqSwUEu4UqnEvZowFx5jVYh
	qUl6PecsDe0HZGM8IDFPrZ5X1Y3IZbo8lfI8TeqIQAWe8Nd6zAn7
X-Google-Smtp-Source: AGHT+IHrpo0YR6Xspr4VdBd+E/fZC7c1U3Yf17POOdEZTlM3quDaGrNtyvhTG1fQfHoQmA1jM13Vyw==
X-Received: by 2002:a05:6214:529c:b0:696:29f8:936f with SMTP id kj28-20020a056214529c00b0069629f8936fmr11254240qvb.5.1711460236992;
        Tue, 26 Mar 2024 06:37:16 -0700 (PDT)
Received: from localhost (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id s3-20020a0562140ca300b006969b7a2234sm820373qvs.88.2024.03.26.06.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 06:37:16 -0700 (PDT)
Date: Tue, 26 Mar 2024 09:37:16 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Antoine Tenart <atenart@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com
Cc: steffen.klassert@secunet.com, 
 willemdebruijn.kernel@gmail.com, 
 netdev@vger.kernel.org
Message-ID: <6602cf8c2c62b_13d9ab29440@willemb.c.googlers.com.notmuch>
In-Reply-To: <171144629575.5526.17151762059541054429@kwain>
References: <20240322114624.160306-1-atenart@kernel.org>
 <20240322114624.160306-4-atenart@kernel.org>
 <65fdc00454e16_2bd0fb2948c@willemb.c.googlers.com.notmuch>
 <171136303579.5526.5377651702776757800@kwain>
 <6601c4f27529_11bc25294b@willemb.c.googlers.com.notmuch>
 <171144629575.5526.17151762059541054429@kwain>
Subject: Re: [PATCH net v3 3/4] udp: do not transition UDP GRO fraglist
 partial checksums to unnecessary
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Antoine Tenart wrote:
> Quoting Willem de Bruijn (2024-03-25 19:39:46)
> > Antoine Tenart wrote:
> > > Quoting Willem de Bruijn (2024-03-22 18:29:40)
> > > > 
> > > > Should fraglist UDP GRO and non-fraglist (udp_gro_complete_segment)
> > > > have the same checksumming behavior?
> > > 
> > > They can't as non-fraglist GRO packets can be aggregated, csum can't
> > > just be converted there.
> > 
> > I suppose this could be done. But it is just simpler to convert to
> > CHECKSUM_UNNECESSARY.
> 
> Oh, do you mean using the non-fraglist behavior in fraglist?
> udp_gro_complete_segment converts all packets to CHECKSUM_PARTIAL (as
> packets could have been aggregated) but that's not required in fraglist.
> 
> To say it another way: my understanding is packets in the non-fraglist
> case have to be converted to CHECKSUM_PARTIAL, while the fraglist case
> can keep the checksum info as-is (and have the conversion to unnecessary
> as an optimization when applicable).

That makes sense. Thanks.
 
> > You mean that on segmentation, the segments are restored and thus
> > skb->csum of each segment is again correct, right?
> 
> In the fraglist case, yes.
> 
> > I suppose this could be converted to CHECKSUM_UNNECESSARY if just
> > for equivalence between the two UDP_GRO methods and simplicity.
> > 
> > But also fine to leave as is.
> 
> I'm not sure I got your suggestion as I don't see how non-fraglist
> packets could be converted to CHECKSUM_UNNECESSARY when being aggregated
> (uh->len can change there).
> 
> This series is aiming at fixing known issues and unifying the behavior
> would be net-next material IMO. I'll send a v4 for those fixes, but then
> I'm happy to discuss the above suggestion and investigate; so let's
> continue the discussion here in parallel.

The above explains why the solutions are distinct. No need to try to
unify more in a follow-up, then.

> > Can you at least summarize this in the commit message? Currently
> > CHECKSUM_COMPLETE is not mentioned, but the behavior is not trivial.
> > It may be helpful next time we again stumble on this code and do a
> > git blame.
> 
> Sure, I'll try to improve the commit log.
> 
> Thanks!
> Antoine



