Return-Path: <netdev+bounces-167839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72181A3C7C8
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 19:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50A01161C5F
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 18:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2071F2B90;
	Wed, 19 Feb 2025 18:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="apSdj2Ru"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F88516A959
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 18:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739990396; cv=none; b=Mkn8UM4CqVzOpwICSR50X8PbCNNfxrntAxoFjyouCDlcc2T7NhnAXvebh9d1QGTsh7lXAw0rGQP5apHr+ixUI/ZS5dDcdjbeMJW2DgrjARwRf4hFmPtQZ/pMVuoSRRpOeMw2UEd1GLTqBPQoz+BGHgHUOmKkUnSjs3T7JI53NFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739990396; c=relaxed/simple;
	bh=A6yAy86FCyAAJXhPD2uzY7aiS5j9pR+0F8rFGYD7ZsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qIjvcA1Sc5ZRus0IoYAFizW+rR7X41FoCTIryOo3+5lggJpz23tDx4n1fGzelu5RHw/Nf2RUhqi2u2QkuASHI8+h8BkbNj53ZMGSnunT1+03j3T5HRhWs61fMiRNiLpmwYjttXkCM9cFYs5k8GkE3k9CplQHC8jfplNrrK+t+Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=apSdj2Ru; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c07b65efeeso6726385a.2
        for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 10:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1739990393; x=1740595193; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=amzgIRg2BkVUCYvpO43bI6Jju0C6l0a8B6xHr6RX9rs=;
        b=apSdj2RuXt1LKya2Yvrm42YttGAEWLFemL3EC/4KVd32ea/Ra9J0Kf/0GFT76czlmV
         MQIQDvcKLavSvS50b8mvMalnqXeo/qsQWmAvdCm7Oz1ur+dJz8QpBjj7pauwc6s6W7dI
         KJjeCTdUKUNGJhAsr1+YPNXzvj6C7LXrtNcPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739990393; x=1740595193;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=amzgIRg2BkVUCYvpO43bI6Jju0C6l0a8B6xHr6RX9rs=;
        b=ZTHzgYKXujEQ61hh1DtO8pFviUEnwEELRI5MTX3Dmle+ROv9EdNNpEFUj+W38gYInQ
         GsAvuY753qk2AmKh9Mz1gSC5mTkwt1BdlZQoRNrJidk2DT854h1IIQDHctXcP0+fdq1m
         SrCjURJXf8VmQ7iCnAchjMSPzJPOnNzHlh86MwbDSlCfeESzsQapXI5Xm6kVIPUabUBV
         ysmthAIqCn8Up3pQjO0q4CfBTtLL+g865sIBuZZlJYWvn3wVc4zKdzbT/69EDr9T/AAg
         013v7R9U/ig1GQhNRq20gMkhl37hqZWvn5Hpqn0glig+OKpTCLMmm+Moe3IKrRf7bPlU
         Fd4g==
X-Forwarded-Encrypted: i=1; AJvYcCXWTSgKejXBsxjpG6rKN1sciNF4aT+r22G6wvVlHiTdS1zgKnt9vOhqldTM0uzCnbGsygWxKA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZcgdq9V/LU0eYuOf8G6IdTMlZxZazWL6tZvIZtEYJOsC2EwXA
	3nr2RbeUQjSO6fBtIdwu8grHvSl8/7FJ3o4YlMwGth9baeSbp+pFWLI9UiDE7oE=
X-Gm-Gg: ASbGncuQDfOcoxR9ExMqjUBiClwSBQRgJaduD2fALco2MWtm0CIyM2V3nEoTkh/pL0g
	koRIvKLrbhLKWxy3bslZ6MlKV2qUnfnCw+SklIeiwo87PpW810bw5tf/KjkqpBX/sjmo6qZK5FW
	zHks50Cn4NfuXRs3ElhW+bSK6yf7buq1rsK+sjms+20o/qtx++KMVtfJeJRRKcEVGq2qB1MSUw9
	ldhJJTZfvVcTt9IT2gWTXdu6CdaFiIIN3uG92o73AyJ3hnja+/d/CVUFq0/a57Mr7W2YoQifq8e
	x1/ehiF3eZMICvvKO0dOFG2STm2v+CpxyD1xIiRneYtxkWdv0Duq+w==
X-Google-Smtp-Source: AGHT+IEzj5CIK2jsWDkt1xqTjHM7wG3zRIB1yT2MjDDjpxLhDAFVE61F6FrXmSQPyPXBQdLR0IvlDA==
X-Received: by 2002:a05:620a:2b99:b0:7c0:b76a:51e0 with SMTP id af79cd13be357-7c0b76a53ddmr505276585a.37.1739990393457;
        Wed, 19 Feb 2025 10:39:53 -0800 (PST)
Received: from LQ3V64L9R2 (ool-44c5a22e.dyn.optonline.net. [68.197.162.46])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c096c10bf2sm429397885a.20.2025.02.19.10.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 10:39:53 -0800 (PST)
Date: Wed, 19 Feb 2025 13:39:51 -0500
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shuah@kernel.org, hawk@kernel.org, petrm@nvidia.com,
	willemdebruijn.kernel@gmail.com
Subject: Re: [PATCH net-next 2/4] selftests: drv-net: add a way to wait for a
 local process
Message-ID: <Z7Yld21sv_Ip3gQx@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
	hawk@kernel.org, petrm@nvidia.com, willemdebruijn.kernel@gmail.com
References: <20250218195048.74692-1-kuba@kernel.org>
 <20250218195048.74692-3-kuba@kernel.org>
 <Z7UBJ_CIrvsSdmnt@LQ3V64L9R2>
 <20250218150512.282c94eb@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218150512.282c94eb@kernel.org>

On Tue, Feb 18, 2025 at 03:05:12PM -0800, Jakub Kicinski wrote:
> On Tue, 18 Feb 2025 16:52:39 -0500 Joe Damato wrote:
> > Removing this check causes a stack trace on my XDP-disabled kernel,
> > whereas with the existing code it caused a skip.
> > 
> > Maybe that's OK, though?
> > 
> > The issue is that xdp_helper.c fails and exits with return -1 before
> > the call to ksft_ready() which results in the following:
> > 
> > # Exception| Traceback (most recent call last):
> > # Exception|   File "/home/jdamato/code/net-next/tools/testing/selftests/net/lib/py/ksft.py", line 223, in ksft_run
> > # Exception|     case(*args)
> > # Exception|   File "/home/jdamato/code/net-next/./tools/testing/selftests/drivers/net/queues.py", line 27, in check_xsk
> > # Exception|     with bkg(f'{cfg.rpath("xdp_helper")} {cfg.ifindex} {xdp_queue_id}',
> > # Exception|          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > # Exception|   File "/home/jdamato/code/net-next/tools/testing/selftests/net/lib/py/utils.py", line 108, in __init__
> > # Exception|     super().__init__(comm, background=True,
> > # Exception|   File "/home/jdamato/code/net-next/tools/testing/selftests/net/lib/py/utils.py", line 63, in __init__
> > # Exception|     raise Exception("Did not receive ready message")
> > # Exception| Exception: Did not receive ready message
> > not ok 4 queues.check_xsk
> > # Totals: pass:3 fail:1 xfail:0 xpass:0 skip:0 error:0
> > 
> > I had originally modified the test so that if XDP is disabled in the
> > kernel it would skip, but I think you mentioned in a previous thread
> > that this was a "non-goal", IIRC ?
> > 
> > No strong opinion on my side as to what the behavior should be when
> > XDP is disabled, but wanted to mention this so that the behavior
> > change was known.
> 
> I thought of doing this:
> 
> diff --git a/tools/testing/selftests/drivers/net/xdp_helper.c b/tools/testing/selftests/drivers/net/xdp_helper.c
> index 8f77da4f798f..8c34e8915fc4 100644
> --- a/tools/testing/selftests/drivers/net/xdp_helper.c
> +++ b/tools/testing/selftests/drivers/net/xdp_helper.c
> @@ -53,7 +53,7 @@ int main(int argc, char **argv)
>         int queue;
>         char byte;
>  
> -       if (argc != 3) {
> +       if (argc > 1 && argc != 3) {
>                 fprintf(stderr, "Usage: %s ifindex queue_id", argv[0]);
>                 return 1;
>         }
> @@ -69,6 +69,13 @@ int main(int argc, char **argv)
>                 return 1;
>         }
>  
> +
> +       if (argc == 1) {
> +               printf("AF_XDP support detected\n");
> +               close(sock_fd);
> +               return 0;
> +       }
> +
>         ifindex = atoi(argv[1]);
>         queue = atoi(argv[2]);
>  
> 
> Then we can run the helper with no arguments, just to check if af_xdp
> is supported. If that returns 0 we go on, otherwise we print your nice
> error.
> 
> LMK if that sounds good, assuming a respin is needed I can add that :)

That seems to fine; if you do decide to go this route in a re-spin,
would you mind also adding a "\n" in the fprintf after "ifindex
queue_id" ? Sorry I missed that on my initial implementation.

That missing \n was mentioned by Kurt in another thread:

https://lore.kernel.org/netdev/878qq22xk3.fsf@kurt.kurt.home/T/#m4d0778b9e849bc72064074105182f4c84ba55eb2
 
> > Separately: I retested this on a machine with XDP enabled, both with
> > and without NETIF set and the test seems to hang because the helper
> > is blocked on:
> > 
> > read(STDIN_FILENO, &byte, 1);
> > 
> > according to strace:
> > 
> > strace: Process 14198 attached
> > 21:50:02 read(0,
> > 
> > So, I think this patch needs to be tweaked to write a byte to the
> > helper so it exits (I assume before the defer was killing it?) or
> > the helper needs to be modified in way?
> 
> What Python version do you have? 

Python 3.12.3 (via Ubuntu 24.04.1 LTS).

I can re-test with a different version using pyenv if you'd like?

Are there docs which mention which python version tests should be
compatible with? If so, could you pass along a link? Sorry if I
missed that.

> 
> For me the xdp process doesn't wait at all. Running this under vng 
> and Python 3.13 the read returns 0 immediately.

Interesting, so something changed between 3.12.3 and 3.13, I
suppose.
 
> Even if it doesn't we run bkg() with default params, so exit_wait=False
> init will set:
> 
> 	self.terminate = not exit_wait
> 
> and then __exit__ will do:
> 
> 	return self.process(terminate=self.terminate, fail=self.check_fail)
> 
> which does:
> 
> 	if self.terminate:
> 		self.proc.terminate()
> 
> so the helper should get a SIGINT, no?

(Minor nit, the python docs say terminate delivers a SIGTERM, but
please continue reading)

I'm not a python programmer but did try a bit to debug this. Looking
at strace on my system, it seems that the script forks twice and the
SIGTERM is sent to the wrong pid?

I suppose it forks twice because the helper is invoked via /bin/sh:

18:27:15 vfork(strace: Process 448303 attached
 <unfinished ...>

So, pid 448303 is the first forked process, which does an execve:

[pid 448303] 18:27:15 execve("/bin/sh", ["/bin/sh", "-c", "/home/jdamato/code/net-next/tools/testing/selftests/drivers/net/xdp_helper 5 0"], 0x7f661511fad0 /* 26 vars */ <unfinished ...>

So /bin/sh runs and that then forks again to run the helper:

[pid 448278] 18:27:15 <... vfork resumed>) = 448303

[pid 448303] 18:27:15 vfork(strace: Process 448304 attached
 <unfinished ...>

[pid 448304] 18:27:15 execve("/home/jdamato/code/net-next/tools/testing/selftests/drivers/net/xdp_helper", ["/home/jdamato/code/net-next/tools/testing/selftests/drivers/net/xdp_helper", "5", "0"], 0x55faf4f81918 /* 26 vars */ <unfinished ...>

So pid 448304 is the process doing the execve to run xdp_helper and
would need to be the one getting the SIGTERM/SIGINT

We can see it does the read:

[pid 448304] 18:27:15 read(0,  <unfinished ...>

However, later the python script does the terminate flow you've
described in your message but sends the signal to the /bin/sh that
was forked off:

[pid 448278] 18:27:15 kill(448303, SIGTERM) = 0
[...]
[pid 448303] 18:27:15 +++ killed by SIGTERM +++

But pid 448304 is xdp_helper, which is still running and should be
the one to get the TERM.

I have no idea why this would be different on your system vs mine.
Maybe something changed with Python between Python versions?

> We shall find out if NIPA agrees with my local system at 4p.

Sorry for the noob question, but is there a NIPA url or something I
can look at to see if this worked / if future tests I submit work?

