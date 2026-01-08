Return-Path: <netdev+bounces-248268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D20D064A4
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 22:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5C8DA30C4467
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 21:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6907337B8E;
	Thu,  8 Jan 2026 21:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5/ZjS4w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF6833AD9D
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 21:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767907157; cv=none; b=aZ0k6MPvPpwZAidoLtG5yo76stB+WiJgkCMOFKVTA8FzX/temlu9su/UfxSFFimqSm0ZO67W2tBtnrud/LUl29fkBps3qW8y07WKfoZM7T7K0mbGkySTYMZ+hNKvBNW8YpABRl1zImG2HfturwVBuX0TwvNCUkHUhZlMMy9qoSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767907157; c=relaxed/simple;
	bh=k6NcCumQIYmHLhnier8TovJJC9eePQklBhANrhDv5hc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=pNvQnCZByOIWRjSPm1rbTbOZ5nfHEOoKXydCI06d9T4NuyOfWfZB74C5y5p5R23wzc6eqKHZEozrk1qV5Gj0mzEtG/LDchjdV+OanldgCwIvcM72JADnpy2qrftrPL91FvLeCY/aG0GDuFSFGZ3192eaj7MHTDSNiZR6RFiBDcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K5/ZjS4w; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-6446d7a8eadso3252415d50.0
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 13:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767907147; x=1768511947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qI1VhtNrnA7RTvn7H2k3tlOEJnVIKIkj9Gp5W7JbRSY=;
        b=K5/ZjS4w57wo3sF4MAwUxMLPaXKrPcpXMwm2GERmutKYYSoSnPbr3ByDpB8auQvzd8
         WbhSG5jcQmD7dkruk0HqNs/iILDTGV8SWjilf7+kjSr7A2LdVrEq2FXVn5roERipKeG6
         sNytiZS3PAz0Djfs/aSRG022AU9Y4i9W1VajL3ikkVp8tHO2/ZLlcw+UnXwWGCEx3QHM
         hIerBjVfxYa73cNCqqi2fTAJyBijySW8roCWuUDvgdrS75qX8pKJUaLgmt/NQVfp7CyC
         bMustaFQe8FphZDMcmHlT+fOjYcillShO1Ls4r7F3+/j5wxoOdQSF3UgkActz1/E6Ior
         sRFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767907147; x=1768511947;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qI1VhtNrnA7RTvn7H2k3tlOEJnVIKIkj9Gp5W7JbRSY=;
        b=rF5UEx6OsMuDffCDFMY1GJ8cE/XYJC9zRfOOr5wLlj+bW5/czF/zBnyXLkor5aeQlg
         2Wo0wQHBSoE9WIkro8XG+Lglkdu8Wg/Vdu8D6CifkosbInJ7QQ2hTywDzzXXrzLadBok
         xeWAomdeWiOK7z2xW4+czcpmB7aqn8JuM/Qkt8enRB1VHVtuWpqpPPcE+T5PmFZT9C5t
         cwhAKzYCpZC1bnLkpBT+yIqJ7FsEwO73dASHalbyoiCLgE1IOVt+UDtUE1v0eMSE7z1q
         q9c0JhwJWKt2Euq4hNiGmc1nuAhW4+6lLtREGP0Jm8ZlpGcIvCpnxLI75Dw4G1ZJmIuE
         cX9w==
X-Forwarded-Encrypted: i=1; AJvYcCXANZBqb3mbxeJqhF4tcyXVj9HEDTNYVxlR+pKKHvMWHgkm/WDT0VGjm1mNq44bm8/aqVe0SPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHQmw1+jmAgWLHzuwrdFK4JVLG1vEWroplT9FlhPaGAjCLwj6e
	I5/r/zX6J2LWLbCSBUWYk2DIhAPDLlP4eX+GZqv7O2cyoio01sDTFOw1
X-Gm-Gg: AY/fxX6kGrKh4QW5PxcIHeau7kpnN2LxAzTdCyFgkcyC2K6S1DxlES2pJ8ciJ7b9goX
	lh29EnrIE+l6ZKw9PzFXsRYRgOLo3CBLIivvRLHUdINC49Hsrc5qgfmyNFVHbnf6Dq/dM7al080
	bLTaZkYyiNFoCxuNbV7S6mMW5JS38yozNR28LZphTSlfNZyTkaCPoaqRgvZWspD+zGzl8+f1xRA
	HLjzPJiLng3pNwo7iLW/lyZBt5Jb1ZJ4iHvxXlkr37rmk6CX65WatroVio8Lzo6t4fXf4f6RP0o
	TBuxuTZd6KkuFI0Ule8ODACXcT4sHoFnObpE9rofnG4GsmG05bo7iRgBoNtRI3Qhidi5H5JPgUH
	qwHbmdog+Sfrdjea/3bEbT81ry+Fdpdf85d50t3JAzN9ydIR4u6+DQBs0qgKe7ntm31v9HEtn5G
	ISnCQW/ps2DUqeHhh61WPQm5K15im9b5kGpuhAziYSq8cBorkLCc5rwLEZeak=
X-Google-Smtp-Source: AGHT+IH7UD35QW4lgUsFaITiEyiFxguR5hhMhmv/pY1+GMMAQREUogRSqcZeWJ8s6M/OjEGc8Af7Xw==
X-Received: by 2002:a05:690e:1286:b0:644:1c42:37a3 with SMTP id 956f58d0204a3-64716c4ff8emr6294238d50.65.1767907147355;
        Thu, 08 Jan 2026 13:19:07 -0800 (PST)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-790aa670b16sm33617767b3.35.2026.01.08.13.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 13:19:06 -0800 (PST)
Date: Thu, 08 Jan 2026 16:19:06 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Willem de Bruijn <willemb@google.com>, 
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Message-ID: <willemdebruijn.kernel.13946c10e0d90@gmail.com>
In-Reply-To: <20260108123845.7868cec4@kernel.org>
References: <20260107110521.1aab55e9@kernel.org>
 <willemdebruijn.kernel.276cd2b2b0063@gmail.com>
 <20260107192511.23d8e404@kernel.org>
 <20260108080646.14fb7d95@kernel.org>
 <willemdebruijn.kernel.58a32e438c@gmail.com>
 <20260108123845.7868cec4@kernel.org>
Subject: Re: [TEST] txtimestamp.sh pains after netdev foundation migration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> On Thu, 08 Jan 2026 14:02:15 -0500 Willem de Bruijn wrote:
> > Increasing tolerance should work.
> > 
> > The current values are pragmatic choices to be so low as to minimize
> > total test runtime, but high enough to avoid flakes. Well..
> > 
> > If increasing tolerance, we also need to increase the time the test
> > waits for all notifications to arrive, cfg_sleep_usec.
> 
> To be clear the theory is that we got scheduled out between taking the
> USR timestamp and sending the packet. But once the packet is in the
> kernel it seems to flow, so AFAIU cfg_sleep_usec can remain untouched.
> 
> Thinking about it more - maybe what blocks us is the print? Maybe under
> vng there's a non-trivial chance that a print to stderr ends up
> blocking on serial and schedules us out? I mean maybe we should:
> 
> diff --git a/tools/testing/selftests/net/txtimestamp.c b/tools/testing/selftests/net/txtimestamp.c
> index abcec47ec2e6..e2273fdff495 100644
> --- a/tools/testing/selftests/net/txtimestamp.c
> +++ b/tools/testing/selftests/net/txtimestamp.c
> @@ -207,12 +207,10 @@ static void __print_timestamp(const char *name, struct timespec *cur,
>         fprintf(stderr, "\n");
>  }
>  
> -static void print_timestamp_usr(void)
> +static void record_timestamp_usr(void)
>  {
>         if (clock_gettime(CLOCK_REALTIME, &ts_usr))
>                 error(1, errno, "clock_gettime");
> -
> -       __print_timestamp("  USR", &ts_usr, 0, 0);
>  }
>  
>  static void check_timestamp_usr(void)
> @@ -636,8 +634,6 @@ static void do_test(int family, unsigned int report_opt)
>                         fill_header_udp(buf + off, family == PF_INET);
>                 }
>  
> -               print_timestamp_usr();
> -
>                 iov.iov_base = buf;
>                 iov.iov_len = total_len;
>  
> @@ -692,10 +688,14 @@ static void do_test(int family, unsigned int report_opt)
>  
>                 }
>  
> +               record_timestamp_usr();
>                 val = sendmsg(fd, &msg, 0);
>                 if (val != total_len)
>                         error(1, errno, "send");
>  
> +               /* Avoid I/O between taking ts_usr and sendmsg() */
> +               __print_timestamp("  USR", &ts_usr, 0, 0);
> +
>                 check_timestamp_usr();
>  
>                 /* wait for all errors to be queued, else ACKs arrive OOO */

Definitely worth including.

Could it be helpful to schedule at RR or FIFO prio. Depends on the
reason for descheduling. And it only affects priority within the VM.

I'm having trouble reproducing it in vng both locally and on 
netdev-virt.

At this point, an initial obviously correct patch and observe how
much that mitigates the issue is likely the fastest way forward.

