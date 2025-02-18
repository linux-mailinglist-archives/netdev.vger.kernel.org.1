Return-Path: <netdev+bounces-167534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E015CA3AB60
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 22:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E20F51891F24
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 21:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB2A1BBBD3;
	Tue, 18 Feb 2025 21:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="MSMsPrg1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9C6286297
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 21:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739915567; cv=none; b=s1NcNz2h8SFkHhVClemD2OuehDP2vxJspB70xU/lm51HexluyGzlqi4DnMlwpZmmIekM0n+Jp0zpiFW+S4EY71EiZM4wtkrqSpwLg5yNFzwGelbj3u2Q7vRfbnbaQqhnNqnRNb0Qzs5K6mbL+4kgbVDfBBc8u9076QN/rNDTiIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739915567; c=relaxed/simple;
	bh=AEdx3WHPyj/2Vc2V7Lcl4dd0IlewnGKVo04BJTEbI7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MGlPozGQ4aUsu7V+ZN/CDGwq00YPo3g1gR/9uXT2nrHD2ij6uIbie3cC8YxnG3dh7fIH6XWD4iv1owISSg2lTTdhNO2gNiPXvwrXSTOLHwlHt1DLQQ/kiKeDZb4jcZHFBm5JDmZvnHAidfa6R1LCjFXo8c5Ys15qB4me9DnJw1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=MSMsPrg1; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6dd420f82e2so83306266d6.1
        for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 13:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1739915563; x=1740520363; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oMIev10Z/zO3ietsYSqbArDbMWVVjPghKJSUd6TfP7I=;
        b=MSMsPrg1yvrcz3TIbLPZ8b1ZAcS2jDcpyXoryCRxobnGuo5uxt9Pj5JNl7PaCKdmmY
         ulBawKzaL3hA9Jop2sFQ7owSN5qlYSw3yQNTyomHrbgTmXbxsOlBFzOSm0Ad9VRCYZfr
         K6i6Sc8yTD7WshOmXnkzZGfzOeX09mt6+3H+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739915563; x=1740520363;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oMIev10Z/zO3ietsYSqbArDbMWVVjPghKJSUd6TfP7I=;
        b=MLyvVdKdtd1INEX3/uTTi/oa4tHzVUDtOVeSi4/RjA+QuZtT9HFd1u5PDk+LXkLgLM
         eMrAJUpBlKiYdDa/sGEDZogKPDfW8iB7QQXOzjMe71o2dnHo3q7D/MG0Md4SpPmETwze
         tj0MAC+kKYjESSojnNquphg7GW2PjxyIQDYo7j6KmFKUGf2UxW4dd9/KAkGpsxKCj4WT
         npi06GKHvjT/XIeH9YRdJdtGraaLHCcbdwVY3od1zjs57yuMrb/WyYTHy1aVgupp+IDc
         sWKTNJ57HdU19ASTiZ0OuBcNmG/tqQDInjAsQhyeV3PR/ThHoPIlXzRQSoYjvPZOhuVc
         z4hA==
X-Forwarded-Encrypted: i=1; AJvYcCWdLAtmBHmuBQM9hdipVuUn84IBJIYxeigIuiA+ZumJez7HzKh5Sf4bIqBEsaC8ZkmaXIJHwV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNJNu37GezzORzoRKrJ89Hr2dAPgVGjQYr5Nym5/HYhOA0S0RS
	U4/cb8RkaOH7eDTX403dkEr4FQU4ECDJMfFzvoqHDPh3D4NiMw38T49YxrHvE0s=
X-Gm-Gg: ASbGncswigC2gx/JzgathsOM8mdhCPfwpPiB+f+p4a7Jzd6PIXGtLneoZ0T3MSV7eEf
	4sNewsuVqd5P53EiwLGkdOsdNmg7nuykk7D08DQAlNtrqgJyc71MbNvwR4QFEVsWVdHYAcAFoAn
	gZnhVgXJoCzJgclWlgDzEtxipEwfSGGMG86BPyRObQIb92vDG4CRChjbl3a3uQ8OyZNROgRq+DP
	L1jUauCANo0XR499Jcft5bOrcAbx/99qSO4SbUe/JJZMdisCmYJBq8xYYp/bm9bQWCMU/AWYegI
	vru1SZGb8ju8nklbj/IIyUsY9Jw83YKvOxezG9tWr//IUSQSjNluEg==
X-Google-Smtp-Source: AGHT+IGEyCmrL+Kd9rJc7mE3xFhjSfptwI8k5baKJiC4JO3pQZarc4KQQukvu3qspkZ4ZcchYvvdHw==
X-Received: by 2002:a05:6214:ac7:b0:6d8:9062:6616 with SMTP id 6a1803df08f44-6e66cc8b65emr269423426d6.7.1739915563250;
        Tue, 18 Feb 2025 13:52:43 -0800 (PST)
Received: from LQ3V64L9R2 (ool-44c5a22e.dyn.optonline.net. [68.197.162.46])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d9f3f9dsm68051166d6.81.2025.02.18.13.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 13:52:42 -0800 (PST)
Date: Tue, 18 Feb 2025 16:52:39 -0500
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shuah@kernel.org, hawk@kernel.org, petrm@nvidia.com,
	willemdebruijn.kernel@gmail.com
Subject: Re: [PATCH net-next 2/4] selftests: drv-net: add a way to wait for a
 local process
Message-ID: <Z7UBJ_CIrvsSdmnt@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
	hawk@kernel.org, petrm@nvidia.com, willemdebruijn.kernel@gmail.com
References: <20250218195048.74692-1-kuba@kernel.org>
 <20250218195048.74692-3-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218195048.74692-3-kuba@kernel.org>

On Tue, Feb 18, 2025 at 11:50:46AM -0800, Jakub Kicinski wrote:
> We use wait_port_listen() extensively to wait for a process
> we spawned to be ready. Not all processes will open listening
> sockets. Add a method of explicitly waiting for a child to
> be ready. Pass a FD to the spawned process and wait for it
> to write a message to us. FD number is passed via KSFT_READY_FD
> env variable.
> 
> Make use of this method in the queues test to make it less flaky.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  .../selftests/drivers/net/xdp_helper.c        | 22 ++++++-
>  tools/testing/selftests/drivers/net/queues.py | 46 ++++++---------
>  tools/testing/selftests/net/lib/py/utils.py   | 58 +++++++++++++++++--
>  3 files changed, 93 insertions(+), 33 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/xdp_helper.c b/tools/testing/selftests/drivers/net/xdp_helper.c
> index cf06a88b830b..8f77da4f798f 100644
> --- a/tools/testing/selftests/drivers/net/xdp_helper.c
> +++ b/tools/testing/selftests/drivers/net/xdp_helper.c
> @@ -14,6 +14,25 @@
>  #define UMEM_SZ (1U << 16)
>  #define NUM_DESC (UMEM_SZ / 2048)
>  
> +/* Move this to a common header when reused! */
> +static void ksft_ready(void)
> +{
> +	const char msg[7] = "ready\n";
> +	char *env_str;
> +	int fd;
> +
> +	env_str = getenv("KSFT_READY_FD");
> +	if (!env_str)
> +		return;
> +
> +	fd = atoi(env_str);
> +	if (!fd)
> +		return;
> +
> +	write(fd, msg, sizeof(msg));
> +	close(fd);
> +}
> +
>  /* this is a simple helper program that creates an XDP socket and does the
>   * minimum necessary to get bind() to succeed.
>   *
> @@ -85,8 +104,7 @@ int main(int argc, char **argv)
>  		return 1;
>  	}
>  
> -	/* give the parent program some data when the socket is ready*/
> -	fprintf(stdout, "%d\n", sock_fd);
> +	ksft_ready();
>  
>  	/* parent program will write a byte to stdin when its ready for this
>  	 * helper to exit
> diff --git a/tools/testing/selftests/drivers/net/queues.py b/tools/testing/selftests/drivers/net/queues.py
> index b6896a57a5fd..91e344d108ee 100755
> --- a/tools/testing/selftests/drivers/net/queues.py
> +++ b/tools/testing/selftests/drivers/net/queues.py
> @@ -5,13 +5,12 @@ from lib.py import ksft_disruptive, ksft_exit, ksft_run
>  from lib.py import ksft_eq, ksft_raises, KsftSkipEx, KsftFailEx
>  from lib.py import EthtoolFamily, NetdevFamily, NlError
>  from lib.py import NetDrvEnv
> -from lib.py import cmd, defer, ip
> +from lib.py import bkg, cmd, defer, ip
>  import errno
>  import glob
>  import os
>  import socket
>  import struct
> -import subprocess
>  
>  def sys_get_queues(ifname, qtype='rx') -> int:
>      folders = glob.glob(f'/sys/class/net/{ifname}/queues/{qtype}-*')
> @@ -25,37 +24,30 @@ import subprocess
>      return None
>  
>  def check_xdp(cfg, nl, xdp_queue_id=0) -> None:
> -    xdp = subprocess.Popen([cfg.rpath("xdp_helper"), f"{cfg.ifindex}", f"{xdp_queue_id}"],
> -                           stdin=subprocess.PIPE, stdout=subprocess.PIPE, bufsize=1,
> -                           text=True)
> -    defer(xdp.kill)
> +    with bkg(f'{cfg.rpath("xdp_helper")} {cfg.ifindex} {xdp_queue_id}',
> +             wait_init=3):
>  
> -    stdout, stderr = xdp.communicate(timeout=10)
> -    rx = tx = False
> +        rx = tx = False
>  
> -    if xdp.returncode == 255:
> -        raise KsftSkipEx('AF_XDP unsupported')
> -    elif xdp.returncode > 0:

Removing this check causes a stack trace on my XDP-disabled kernel,
whereas with the existing code it caused a skip.

Maybe that's OK, though?

The issue is that xdp_helper.c fails and exits with return -1 before
the call to ksft_ready() which results in the following:

# Exception| Traceback (most recent call last):
# Exception|   File "/home/jdamato/code/net-next/tools/testing/selftests/net/lib/py/ksft.py", line 223, in ksft_run
# Exception|     case(*args)
# Exception|   File "/home/jdamato/code/net-next/./tools/testing/selftests/drivers/net/queues.py", line 27, in check_xsk
# Exception|     with bkg(f'{cfg.rpath("xdp_helper")} {cfg.ifindex} {xdp_queue_id}',
# Exception|          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# Exception|   File "/home/jdamato/code/net-next/tools/testing/selftests/net/lib/py/utils.py", line 108, in __init__
# Exception|     super().__init__(comm, background=True,
# Exception|   File "/home/jdamato/code/net-next/tools/testing/selftests/net/lib/py/utils.py", line 63, in __init__
# Exception|     raise Exception("Did not receive ready message")
# Exception| Exception: Did not receive ready message
not ok 4 queues.check_xsk
# Totals: pass:3 fail:1 xfail:0 xpass:0 skip:0 error:0

I had originally modified the test so that if XDP is disabled in the
kernel it would skip, but I think you mentioned in a previous thread
that this was a "non-goal", IIRC ?

No strong opinion on my side as to what the behavior should be when
XDP is disabled, but wanted to mention this so that the behavior
change was known.

Separately: I retested this on a machine with XDP enabled, both with
and without NETIF set and the test seems to hang because the helper
is blocked on:

read(STDIN_FILENO, &byte, 1);

according to strace:

strace: Process 14198 attached
21:50:02 read(0,

So, I think this patch needs to be tweaked to write a byte to the
helper so it exits (I assume before the defer was killing it?) or
the helper needs to be modified in way?

