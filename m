Return-Path: <netdev+bounces-167547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B3EA3AC51
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 00:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A40A7A1F00
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 23:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3488B1B3725;
	Tue, 18 Feb 2025 23:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GWepimhy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101DE28629C
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 23:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739919914; cv=none; b=iWXzL9Aqy+lCvS3QkANHNUYeTECQmlrfkk4X/sD9nP0sIqtE3yMJgPRp2eSJBbw2UAATXEH0sptpjxN4mHAbYFVYzjC8PxvH3kqJlSneekwxb8W3EGMsQAy4+4nEp7Q3RLEzht+vz5lx69UUBol6smS5TX/lzB5UvY/+AidoRJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739919914; c=relaxed/simple;
	bh=adMXZShjP3ju6SFM3TA/M+K71zDr0IQKJjAhd6Gzwio=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qTWCzL5k1GhvXRXkOGqXEHDrjNA/vZbf7PaWrg4z//wtQGm+xYop5dk9KoDzyd9JE3RcfGPq/08PAgpbnUE20BKPFkcE540oXdg4e6XAP0ZcE08Ls9Zu+gNOnn2txg3QIkOaMyzK3sb40ubGPnH56TWl5MXigWc7M6IFz1O8gos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GWepimhy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C14CC4CEE2;
	Tue, 18 Feb 2025 23:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739919913;
	bh=adMXZShjP3ju6SFM3TA/M+K71zDr0IQKJjAhd6Gzwio=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GWepimhyzTmIU9ytkK6TM5HsA4KbxmtMIUUgunVQBwqurRB5orLkCziZrvOdRxU9U
	 85YAcyYa+0p9ZbtsvrUUvBsl6LAUZ7dJQ4gbKUAviKDiT2aSHuZHc1PUShAJHNyjG7
	 zwaou7pHW89HBEHH0llmNZFBIJqn5gdrs5ZWE47YtnLI8EANUFm+g4/dYGksTwG4de
	 1QRNQRyRAH/BAE8CohvK4Iotwj4EQSC9wbJ93wC5Inb9OVtyYdrgb1COSyHewp7TDc
	 VUDFFJ7+KwFn9JweniqSZ/UpFnB7lny7cSNZhkUQxgfKhYWTGqdHx6kjYe2Aqla+RL
	 2QIK2XsOTIiGg==
Date: Tue, 18 Feb 2025 15:05:12 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shuah@kernel.org, hawk@kernel.org, petrm@nvidia.com,
 willemdebruijn.kernel@gmail.com
Subject: Re: [PATCH net-next 2/4] selftests: drv-net: add a way to wait for
 a local process
Message-ID: <20250218150512.282c94eb@kernel.org>
In-Reply-To: <Z7UBJ_CIrvsSdmnt@LQ3V64L9R2>
References: <20250218195048.74692-1-kuba@kernel.org>
	<20250218195048.74692-3-kuba@kernel.org>
	<Z7UBJ_CIrvsSdmnt@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Feb 2025 16:52:39 -0500 Joe Damato wrote:
> Removing this check causes a stack trace on my XDP-disabled kernel,
> whereas with the existing code it caused a skip.
> 
> Maybe that's OK, though?
> 
> The issue is that xdp_helper.c fails and exits with return -1 before
> the call to ksft_ready() which results in the following:
> 
> # Exception| Traceback (most recent call last):
> # Exception|   File "/home/jdamato/code/net-next/tools/testing/selftests/net/lib/py/ksft.py", line 223, in ksft_run
> # Exception|     case(*args)
> # Exception|   File "/home/jdamato/code/net-next/./tools/testing/selftests/drivers/net/queues.py", line 27, in check_xsk
> # Exception|     with bkg(f'{cfg.rpath("xdp_helper")} {cfg.ifindex} {xdp_queue_id}',
> # Exception|          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> # Exception|   File "/home/jdamato/code/net-next/tools/testing/selftests/net/lib/py/utils.py", line 108, in __init__
> # Exception|     super().__init__(comm, background=True,
> # Exception|   File "/home/jdamato/code/net-next/tools/testing/selftests/net/lib/py/utils.py", line 63, in __init__
> # Exception|     raise Exception("Did not receive ready message")
> # Exception| Exception: Did not receive ready message
> not ok 4 queues.check_xsk
> # Totals: pass:3 fail:1 xfail:0 xpass:0 skip:0 error:0
> 
> I had originally modified the test so that if XDP is disabled in the
> kernel it would skip, but I think you mentioned in a previous thread
> that this was a "non-goal", IIRC ?
> 
> No strong opinion on my side as to what the behavior should be when
> XDP is disabled, but wanted to mention this so that the behavior
> change was known.

I thought of doing this:

diff --git a/tools/testing/selftests/drivers/net/xdp_helper.c b/tools/testing/selftests/drivers/net/xdp_helper.c
index 8f77da4f798f..8c34e8915fc4 100644
--- a/tools/testing/selftests/drivers/net/xdp_helper.c
+++ b/tools/testing/selftests/drivers/net/xdp_helper.c
@@ -53,7 +53,7 @@ int main(int argc, char **argv)
        int queue;
        char byte;
 
-       if (argc != 3) {
+       if (argc > 1 && argc != 3) {
                fprintf(stderr, "Usage: %s ifindex queue_id", argv[0]);
                return 1;
        }
@@ -69,6 +69,13 @@ int main(int argc, char **argv)
                return 1;
        }
 
+
+       if (argc == 1) {
+               printf("AF_XDP support detected\n");
+               close(sock_fd);
+               return 0;
+       }
+
        ifindex = atoi(argv[1]);
        queue = atoi(argv[2]);
 

Then we can run the helper with no arguments, just to check if af_xdp
is supported. If that returns 0 we go on, otherwise we print your nice
error.

LMK if that sounds good, assuming a respin is needed I can add that :)

> Separately: I retested this on a machine with XDP enabled, both with
> and without NETIF set and the test seems to hang because the helper
> is blocked on:
> 
> read(STDIN_FILENO, &byte, 1);
> 
> according to strace:
> 
> strace: Process 14198 attached
> 21:50:02 read(0,
> 
> So, I think this patch needs to be tweaked to write a byte to the
> helper so it exits (I assume before the defer was killing it?) or
> the helper needs to be modified in way?

What Python version do you have? 

For me the xdp process doesn't wait at all. Running this under vng 
and Python 3.13 the read returns 0 immediately.

Even if it doesn't we run bkg() with default params, so exit_wait=False
init will set:

	self.terminate = not exit_wait

and then __exit__ will do:

	return self.process(terminate=self.terminate, fail=self.check_fail)

which does:

	if self.terminate:
		self.proc.terminate()

so the helper should get a SIGINT, no?

We shall find out if NIPA agrees with my local system at 4p.

