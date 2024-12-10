Return-Path: <netdev+bounces-150557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEABE9EAA5A
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 09:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C019188A416
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 08:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D46C22CBE9;
	Tue, 10 Dec 2024 08:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PBXRSghl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E886922CBE5
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 08:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733818310; cv=none; b=s6NXZObGkmm3IQ+Xeb0oGJ8JIQX3zbG144Di6zm8WHbl1ONs+fihPMutadmoX1Ogqg2ki1ZBhRJodDvadLHS1M43ifcwnaAXvfOz5Pd+fkFKbCaSMTa36w6htteW38EEPlybOo5vh+fZRxlLDMPrk0tUdifK1o4xjwSjUwUq7u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733818310; c=relaxed/simple;
	bh=LH9m152BvWWu5QIL/ae9S+kHDoTDvyVz3Jt6WE8csWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H5V+8K2UdMGRLE9UonJDlHuKtUBp1mEI89b1VdicYBD2OUruC80JG+qbcVFuk86T7VtDksPhfd8XZgVb7bi720nnA9aDIBZn7QOKXdYwSjJglWz2pHIaHqQ8W+nVVW854AOt4lawXm4NHzjear0xBz4vFDQLhfN+D6tuw7yKZiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PBXRSghl; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5d41848901bso1979385a12.0
        for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 00:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733818307; x=1734423107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LH9m152BvWWu5QIL/ae9S+kHDoTDvyVz3Jt6WE8csWY=;
        b=PBXRSghlcd+aiO2MhmIu9Ox4Z/j9Ws65JhBPy0LU5WO6+Ax5OBBiWdVyZndVV5906r
         PvwA4V8qrm1zV7crzKJ/gG2pCbTZGvVnDShL1hpufihG3mjD+yYN2K0vfA3ZzPTJVnAe
         OC1c2xuh315w+TSg7OcptSBmJLcXfN/qA3Vk3aSeKtViabaylI3+jcGq2+oBHxVAHVnv
         pvNtVZInzxmUb1a4CEz4u6RRTxelEOgozvKG3Ltv2ZrL5rfQdQ6IWLQQ27zHLZhMOfps
         a32sXI0GcjV7eWMyXsZ1CQu2liSEDeIBAwNH3kCeZwvo6XMGWrV826Czc6faqAl9lS9O
         NsyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733818307; x=1734423107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LH9m152BvWWu5QIL/ae9S+kHDoTDvyVz3Jt6WE8csWY=;
        b=VVHTg6BofhhBKWBZDdGTuU1ofnR+KghXY7md2HeGYSfbbTpQEm+3fri1HPoudzVUCs
         EBEvRp5Gt9EDtyH80I+zLA3uLxK35iS17qMMRDbrjUW9F7fknJmPbMbTq3i2iOa/DVwf
         wU0luuokcTjbjWSxaPqSIx2Pif8rcQAGpqmlE6/IWUfmZ4DF0gXtMEnisOfhbGBgAk87
         yGRg8DJntYPQ5rpTDFQbhRzY0HWBSbQ34GC9ENfKfnJpEJagISXFpejKBWQkTKsDnv/E
         uIm0HbKTyeTmXfDYZWyltDP/h8HrIx1RftYzEyuP/sz1z/g6WpiIzFhursVXGLGpmAmn
         FgSQ==
X-Gm-Message-State: AOJu0YzF+3QQo0xO6l8CBS+Ae2R1golusX9jUTeabKvcbQ3m0L3z5SZK
	v3eoEeqyroL1xDOvA5xjpNgbJs1DMRrDv2EBZJb+Nc5KqCt//svV8BJeRmyfExoESTDc5OGLjZT
	lyOMyNAUnSYPxJtO+p5zRATq3tAAkqANyNv9O++Hv0AvVjlsRo00o
X-Gm-Gg: ASbGnctlSWWhfGM9k4gxSA7r7U/IfUKTqat/Snms3RwWS/KJOJrqNSTEzL6LCHxnL8P
	wOxnrFDSYUphIiS77ytQNKYQSps1Z3S4I2Q==
X-Google-Smtp-Source: AGHT+IGC4tyrSSSiNWrFknibNJb45iv8slMp8hRMHGKn8RBXvIkB4adLnMpJjAuBUouLd0MD6WEy2rsQEqfnk7SHAFE=
X-Received: by 2002:a05:6402:5194:b0:5d3:f617:a003 with SMTP id
 4fb4d7f45d1cf-5d41e14c2camr2328222a12.4.1733818307131; Tue, 10 Dec 2024
 00:11:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209-jakub-krn-909-poc-msec-tw-tstamp-v2-0-66aca0eed03e@cloudflare.com>
 <20241209-jakub-krn-909-poc-msec-tw-tstamp-v2-1-66aca0eed03e@cloudflare.com>
In-Reply-To: <20241209-jakub-krn-909-poc-msec-tw-tstamp-v2-1-66aca0eed03e@cloudflare.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 10 Dec 2024 09:11:36 +0100
Message-ID: <CANn89i+W5zxhNNQbtbopk4KtZZvOHSQ8MYC3-u-xdvyh7uTmQA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/2] tcp: Measure TIME-WAIT reuse delay with
 millisecond precision
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jason Xing <kerneljasonxing@gmail.com>, Adrien Vasseur <avasseur@cloudflare.com>, 
	Lee Valentine <lvalentine@cloudflare.com>, kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 8:38=E2=80=AFPM Jakub Sitnicki <jakub@cloudflare.com=
> wrote:
>
> Prepare ground for TIME-WAIT socket reuse with subsecond delay.
>
> Today the last TS.Recent update timestamp, recorded in seconds and stored
> tp->ts_recent_stamp and tw->tw_ts_recent_stamp fields, has two purposes.
>
> Firstly, it is used to track the age of the last recorded TS.Recent value
> to detect when that value becomes outdated due to potential wrap-around o=
f
> the other TCP timestamp clock (RFC 7323, section 5.5).
>
> For this purpose a second-based timestamp is completely sufficient as eve=
n
> in the worst case scenario of a peer using a high resolution microsecond
> timestamp, the wrap-around interval is ~36 minutes long.
>
> Secondly, it serves as a threshold value for allowing TIME-WAIT socket
> reuse. A TIME-WAIT socket can be reused only once the virtual 1 Hz clock,
> ktime_get_seconds, is past the TS.Recent update timestamp.
>
> The purpose behind delaying the TIME-WAIT socket reuse is to wait for the
> other TCP timestamp clock to tick at least once before reusing the
> connection. It is only then that the PAWS mechanism for the reopened
> connection can detect old duplicate segments from the previous connection
> incarnation (RFC 7323, appendix B.2).
>
> In this case using a timestamp with second resolution not only blocks the
> way toward allowing faster TIME-WAIT reuse after shorter subsecond delay,
> but also makes it impossible to reliably delay TW reuse by one second.
>
> As Eric Dumazet has pointed out [1], due to timestamp rounding, the TW
> reuse delay will actually be between (0, 1] seconds, and 0.5 seconds on
> average. We delay TW reuse for one full second only when last TS.Recent
> update coincides with our virtual 1 Hz clock tick.
>
> Considering the above, introduce a dedicated field to store a millisecond
> timestamp of transition into the TIME-WAIT state. Place it in an existing
> 4-byte hole inside inet_timewait_sock structure to avoid an additional
> memory cost.
>
> Use the new timestamp to (i) reliably delay TIME-WAIT reuse by one second=
,
> and (ii) prepare for configurable subsecond reuse delay in the subsequent
> change.
>
> We assume here that a full one second delay was the original intention in
> [2] because it accounts for the worst case scenario of the other TCP usin=
g
> the slowest recommended 1 Hz timestamp clock.
>
> A more involved alternative would be to change the resolution of the last
> TS.Recent update timestamp, tw->tw_ts_recent_stamp, to milliseconds.
>
> [1] https://lore.kernel.org/netdev/CANn89iKB4GFd8sVzCbRttqw_96o3i2wDhX-3D=
raQtsceNGYwug@mail.gmail.com/
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3Db8439924316d5bcb266d165b93d632a4b4b859af
>
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

