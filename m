Return-Path: <netdev+bounces-260323-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKhBDiQenWm/MwQAu9opvQ
	(envelope-from <netdev+bounces-260323-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 04:42:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D73C218174E
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 04:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96D0B3037EC2
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 03:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15B7289E17;
	Tue, 24 Feb 2026 03:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZhstHCt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804E41367
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 03:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771904544; cv=none; b=ZkjlF6cgyfQWR+twHc1N7SqrykYqgkuFSoo1j0X0f2LlpZN1HTsPzIsfD7mGX5kQQ4SkGr2IAFbBx6SXG5TUS9I6WFidjEEPRDkMD+MbB09xO7mxRhqEaE67FEhLg2grMC+g5v2ntPBRkkE156F/aSlRcBmSRb1m7CZ27zO5htU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771904544; c=relaxed/simple;
	bh=grj7oAq8M05dLBP9Pn8aecJgNHhYgCfmJMPq4xGHvYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S6jA4fxjWmmzBsI+uUvLf2jAwGFosVamHGCAODPL6nLrIWSw+hIWqQQdvq1TuW7kQMFQOcpRqbHrgAPEP1GD/EzsDL2hDBcKhHEL7bxsOW7vVAtcZ/xE20AK9BKgpCVeg+WzG37ZBehMr+Wsj68dFs79//EZXqONUjxDSSCxN9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kZhstHCt; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so43398465ad.2
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 19:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771904543; x=1772509343; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=64EJpKRfWnzFU2K9X8IcO3CvffVFjRlETcroVM/6Pf4=;
        b=kZhstHCtnRU02ldqJ8HdjYN70GpAZ8pFxD80UMdWqyt/u7xI4MiIL3z6CZO49c4crT
         ACVYdcjq0e9/N3UfxzDp41h6HSlwV2qjZkSYPEa/D9TAEdMivE5xGPl7XEulrZyyPlRz
         QpuYbIi4FHaYKbjVI+T4EUQ/fQ6QIWEUMOkqgDMXii6o8ooSJBJH+9arsNpDr4AueT6t
         OwKl/be9D3rTMEqPNJq4IttASC/ZjwJ8zrBwWYtM3PeoZaBaMQ4VFOUMk7q8sKZfQlYl
         /B6Vsf4itOquJ3TU5crUqjr9WX1wAWutFZlzsG9uurBVMVLzPQ98FsMiSOsW2dqKUegS
         Ytlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771904543; x=1772509343;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=64EJpKRfWnzFU2K9X8IcO3CvffVFjRlETcroVM/6Pf4=;
        b=KRcjf0pXXQ7kaY18bHgeatvbPrDD42XOobJyavdWTBG2/3l0ditOQDrXkcGfyuRZfn
         cOUO1MmZS8ngYie+zKQ1jZjAKFWlT7sVIxJWG6DXyVi5u/EgfWum2JiX2KbomK7oQ9Pn
         vOxrq97xVH1ybfJ91614yTXV7KEK0FFu+rb1l/mxtGxDaXckleiVRAH+cr2T0Sli+MF0
         /L1UTvBv3QeWizmuTMlTrgwFieGrw1jWFoH5eklmx+hp5wHW/BkebMddOZ7+DSmFraMS
         dQpbvdpnKFjd/IAUW7BpV9rcju9K3fEYmLMBIqqET/cjR2Rw3Auag9vkWecqYzgJknVw
         FF4w==
X-Forwarded-Encrypted: i=1; AJvYcCUNCkIvwuy1Qov453wFI0scMVZMRfZWfcTEMtZkZUEfzSls+E2+XgcNwJiO8keg4R++uMRlPLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZrBCLL6SqbQ8Mgs+K6WA3OZAHdhHr56annxyTLGTEQqdDr3+c
	ZSS1Ge+4Goqit2HseCU0hly+7zGyDHveSPs5jOslUIEfsqk8INISOWaT
X-Gm-Gg: ATEYQzyoqmisrG2jCOydiNPAH2Ki4hEMp/EhgnJHukLg1sPH6CiwcdIKZO8BnKbB8Kb
	0p/kAyuRlLd7xs0cXw4WLYNIKxKO9G/YlxvHYHhQSWndki2m9dzKwkm1TmR+OCAlpoH3a8P9KtO
	uvc570sUnPs8W6xCpOxjyLT7PLmGGARwYFnEpwde8ksiopWZeNYOMtt//CHX9LJtWLJ987jVDgj
	O/zvM+lpiz/TK1Px9XwJD4K1qkpDxrgwogXMSQCh1AJ1UYN7pYjlcnvkwOsaza+rZVUWBBQg7Gj
	0pOId1nMEu7zf0dUVK1Og4E3rAU/u9aztXR/YaGJxaYpq0xj20TrYKukiQgIt0tsTYf2gF0tLhg
	bJ+z46hqKqWkAuDGLWEdvvlnbSXsXVBAkvbqXtN9swZwMg+32quoAUASHlDp8Yc0fZFU9NOe4Uf
	l5l601ady+q9bkn5NKWaGaaStMVCI=
X-Received: by 2002:a17:903:1a8f:b0:2aa:e6c8:2c73 with SMTP id d9443c01a7336-2ad744ec57amr120059075ad.37.1771904542790;
        Mon, 23 Feb 2026 19:42:22 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adaa3b2b9csm2575145ad.1.2026.02.23.19.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 19:42:21 -0800 (PST)
Date: Tue, 24 Feb 2026 03:42:17 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Brendan Jackman <jackmanb@google.com>
Cc: linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org
Subject: Re: [PATCH selftests] selftests: Use ktap helpers for runner.sh
Message-ID: <aZ0eGa-fj6LKSIXq@fedora>
References: <20260206081704.53215-1-liuhangbin@gmail.com>
 <DG7TJFKZNG1J.19BZF87IWD3UG@google.com>
 <aYX8dot4fTh3FJFI@fedora>
 <DGMCJQ2TKZ1O.Q2C502GV1GSL@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DGMCJQ2TKZ1O.Q2C502GV1GSL@google.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260323-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D73C218174E
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 12:40:03PM +0000, Brendan Jackman wrote:
> On Fri Feb 6, 2026 at 2:36 PM UTC, Hangbin Liu wrote:
> > Hi Brendan,
> > On Fri, Feb 06, 2026 at 10:48:59AM +0000, Brendan Jackman wrote:
> >> On Fri Feb 6, 2026 at 8:17 AM UTC, Hangbin Liu wrote:
> >> > This has been on my todo list for a long time. We should use ktap
> >> > helpers in runner.sh. I saw Brendan did some work in d9e6269e3303
> >> > ("selftests/run_kselftest.sh: exit with error if tests fail") to make
> >> > run_kselftest.sh exit with the correct return value. But we still use a
> >> > custom solution in runner.sh. Let's convert all the print messages to use
> >> > formal ktap helpers. Here’s what I changed:
> >> >
> >> >   1. Move TAP header from runner.sh to run_kselftest.sh, since run_kselftest.sh
> >> >      is the only caller of run_many().
> >> >   2. In run_kselftest.sh, call run_many() in main process to count the
> >> >      pass/fail numbers.
> >> >   3. In run_kselftest.sh, do not generate kselftest_failures_file; just
> >> >      use ktap_print_totals to report the result.
> >> >   4. In runner.sh run_one(), get the return value and use ktap helpers for
> >> >      all pass/fail reporting. This allows counting pass/fail numbers in the
> >> >      main process.
> >> >   5. In runner.sh run_in_netns(), also return the correct rc, so we can
> >> >      count results during wait.
> >> >
> >> > After the change, the printed result looks like:
> >> >
> >> >   not ok 4 4 selftests: clone3: clone3_cap_checkpoint_restore # exit=1
> >> >   # Totals: pass:3 fail:1 xfail:0 xpass:0 skip:0 error:0
> >> >
> >> >   ]# echo $?
> >> >   1
> >> 
> > It changes the run_kselftest.sh's output, with a total result. e.g.
> >
> > # Totals: pass:3 fail:1 xfail:0 xpass:0 skip:0 error:0
> 
> Cool thanks, then please just clarify the commit message to say this.

Yes, I have added this with 3. use ktap_print_totals to report the result.

> 
> >> I have not reviewed the code properly yet (I just read enough to check
> >> that it still does the thing I care about i.e. return an error code when
> >> something fails). I can do a proper review next week if you add a bit
> >> more context re the question above though.
> >
> > Yes, I also care about the return code. This patch doesn't break it.
> >
> >> 
> >> > -	wait
> >> > +	# Handle the return values when running in netns.
> >> > +	for pid in "${pids[@]}"; do
> >> > +		wait "$pid"
> >> > +		rc=$?
> >> > +		[ "$rc" -eq "$KSFT_PASS" ] && KTAP_CNT_PASS=$((KTAP_CNT_PASS+1))
> >> > +		[ "$rc" -eq "$KSFT_FAIL" ] && KTAP_CNT_FAIL=$((KTAP_CNT_FAIL+1))
> >> > +		[ "$rc" -eq "$KSFT_SKIP" ] && KTAP_CNT_SKIP=$((KTAP_CNT_SKIP+1))
> >> > +		[ "$rc" -eq "$KSFT_XFAIL" ] && KTAP_CNT_XFAIL=$((KTAP_CNT_XFAIL+1))
> >> 
> > These variables are defined in ktap_helpers.sh and used by the ktap helpers.
> 
> Hm, I see. Then it seems pretty hacky to mutate them directly here, and
> is it correct to always increment them by 1?
> 
> I think the "correct" thing to do here is to parse the KTAP from the
> child process's stdout, but I assume that's not actually practical with
> the current tools we have available. (I could be wrong though, let me
> know if that's the case).
> 
> Or maybe we can dump the values of the variables at the end of the child
> and then add them into the parent process' values... 

Based on code

        for TEST in "$@"; do
                if [ -n "$RUN_IN_NETNS" ]; then
                        run_in_netns &
                        pids+=($!)
                else
                        run_one "$DIR" "$TEST" "$test_num"
                fi
        done

        # Handle the return values when running in netns.
        for pid in "${pids[@]}"; do
		...
	done

This hack only affects when we run tests in netns.

If we dump the values for each child process. It do make the result more
accurate. But the process is complex (maybe force dump the result to a file and
analyse it? But some tests doesn't have ktap helper and only return $rc), and
some tests may also have sub-process that use KTAP numbers but not count in
main process.

Since the purpose is to count the test pass/failed number. I think it's enough
to only count the return value when run tests in netns.

> 
> Or, if we just keep the current approach I think just having some
> commentary to explain why we are doing this would help. I.e. "these
> variables are outputs of ktap_helpers.sh but since we've run the test in
> a subprocess we need to update them manually" (the current comment talks
> about the netns which I think is confusing, I don't think the netns is
> relevant at all).

Thanks, I will update the commit description.

Regards
Hangbin

