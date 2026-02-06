Return-Path: <netdev+bounces-257524-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJoMDirHhWnAGAQAu9opvQ
	(envelope-from <netdev+bounces-257524-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 11:49:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A036CFCCE3
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 11:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 186D6303C818
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 10:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C57E38946E;
	Fri,  6 Feb 2026 10:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rtZWqmqR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1202A376BE4
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 10:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770374942; cv=none; b=QeL3q17LPGZCz/mKFubUKOj/kp5+ceevPR8BVWELzpR05Vgh2dBu/viF4Mw6+ufp1oXixd5ACHPLEzHfdJExxTJO9m4yhw4H83BvsurLyZKhl3CaTnF11eDK6PTqYGtwwD3CPXk6+TSwY4L0fXxjkkvVqDTuMbVyOe31jx5q65M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770374942; c=relaxed/simple;
	bh=wocnho69+8xuXH257OKNIA1dWHd6LbmLrLkg1JkFLWA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rs1Fb+vWTeqCDUWJeSlNyjg/azfnBlBiZyaVF1tteVd7Pbls7g+RCZ0llVqswxpKGX8X1qyMBV1v9Uqi5LdLmdxjpLIqX2ad0YBF+sH2Iersw1Pd6CXk0QuRdKbE7RPvgHm2tAqUBi1K9mA4oDB6CeV9lyy+3BX78u3wuwlFSaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rtZWqmqR; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-48071615686so22671315e9.1
        for <netdev@vger.kernel.org>; Fri, 06 Feb 2026 02:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770374940; x=1770979740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2zmOo5omjcqnuztYn9eehOA9zK7mZfLWvH1J22yg9LQ=;
        b=rtZWqmqRaD68PY071wjROzdd1xDQR7g7FtiVVCGzrLrc4FZ5UsgZ/92JpxbXK368bO
         fqIwGSwEY2IRZff60pbVxF3x807cPDj1XmfQ5weGgs2loKNM9aQhBfFkRG29WH9kwnXu
         56GPKpP4MNezr9Aq0761pyoRSY9PqovaMOkYWXX6JHD+DhU3mkyteoTyFhNoiAJFKbTV
         wlb4P8gqhWBlmTWrlGH4Zjgo9uVhUJrNjvpuGGVBCX6B6Xdl3sEoKxrKBEev6eFbK/3B
         Rv82Wnp40onelRNCY+B9cBIp8a/IF54dIpGPoaiJtlhKdiwfSj5T8wrZ576tyOErzyZH
         jMHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770374940; x=1770979740;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2zmOo5omjcqnuztYn9eehOA9zK7mZfLWvH1J22yg9LQ=;
        b=D3a5K+BEC5SNXD2mFNaF9qBkFqKrg0zSGan7/YtL93vxMHSn3K4NRJ9sOpQERvSqGi
         ZPHo2n50weBGTazqbHPp/HLwtG7ZGttuelenKAHjQHX26+YeCoDC6lPy31BTnF0pMh9V
         /l2p6hShVG8ioJxJFEMaUdJyblIE1Ip8yQAXNF1EgbirEAGFI5VlvLWgQJpUR7nrij6e
         9XJwb5oXLfBZhEjr/bNd84+60u2h5pu3QvJlM/N43//A9tjYsB95pCzquh8vm8UL59kP
         62nlbH/ueI15J5u450RSfO2v+ZsuqEcpn/Io5BCOI6hIOhG8bEczOjV2EoxHuz5FbMNG
         RXWA==
X-Forwarded-Encrypted: i=1; AJvYcCXivpQfP7GEn0lvv76R8hUqu6LLAp8gObSgioM6ng0HZnHVC80YBFD5aVhGIXPYLzeNa/0LjHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlPcdMLzfLUz97zZ0K0AmDzqSFODvAfmdV+e7l/xSJt9TNiit9
	LAb0yw1Y+7TYoZELPiZgKLGJGBKr1ByLPxPp/EnpMFCdd9IPbp2bWcmHWxvsQyjDL2Vc87vqQhi
	q8NGVuj5VPf3bIA==
X-Received: from wmpg38.prod.google.com ([2002:a05:600c:4ca6:b0:47a:7874:d5d])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b23:b0:47f:8c05:786b with SMTP id 5b1f17b1804b1-4832021eae9mr34302145e9.28.1770374940592;
 Fri, 06 Feb 2026 02:49:00 -0800 (PST)
Date: Fri, 06 Feb 2026 10:48:59 +0000
In-Reply-To: <20260206081704.53215-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260206081704.53215-1-liuhangbin@gmail.com>
X-Mailer: aerc 0.21.0
Message-ID: <DG7TJFKZNG1J.19BZF87IWD3UG@google.com>
Subject: Re: [PATCH selftests] selftests: Use ktap helpers for runner.sh
From: Brendan Jackman <jackmanb@google.com>
To: Hangbin Liu <liuhangbin@gmail.com>, <linux-kselftest@vger.kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Brendan Jackman <jackmanb@google.com>, <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257524-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jackmanb@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,run_kselftest.sh:url,runner.sh:url]
X-Rspamd-Queue-Id: A036CFCCE3
X-Rspamd-Action: no action

On Fri Feb 6, 2026 at 8:17 AM UTC, Hangbin Liu wrote:
> This has been on my todo list for a long time. We should use ktap
> helpers in runner.sh. I saw Brendan did some work in d9e6269e3303
> ("selftests/run_kselftest.sh: exit with error if tests fail") to make
> run_kselftest.sh exit with the correct return value. But we still use a
> custom solution in runner.sh. Let's convert all the print messages to use
> formal ktap helpers. Here=E2=80=99s what I changed:
>
>   1. Move TAP header from runner.sh to run_kselftest.sh, since run_kselft=
est.sh
>      is the only caller of run_many().
>   2. In run_kselftest.sh, call run_many() in main process to count the
>      pass/fail numbers.
>   3. In run_kselftest.sh, do not generate kselftest_failures_file; just
>      use ktap_print_totals to report the result.
>   4. In runner.sh run_one(), get the return value and use ktap helpers fo=
r
>      all pass/fail reporting. This allows counting pass/fail numbers in t=
he
>      main process.
>   5. In runner.sh run_in_netns(), also return the correct rc, so we can
>      count results during wait.
>
> After the change, the printed result looks like:
>
>   not ok 4 4 selftests: clone3: clone3_cap_checkpoint_restore # exit=3D1
>   # Totals: pass:3 fail:1 xfail:0 xpass:0 skip:0 error:0
>
>   ]# echo $?
>   1

Sorry I'm being a bit lazy by not investigating this myself but the
current intended behaviour is for runner.sh to output correct KTAP,
right? Could you describe what behavioural changes this is expected to
bring - does it fix/change the KTAP output? (Or if it's just a cleanup
with no intended change then please note that in the commit message).

I have not reviewed the code properly yet (I just read enough to check
that it still does the thing I care about i.e. return an error code when
something fails). I can do a proper review next week if you add a bit
more context re the question above though.

> -	wait
> +	# Handle the return values when running in netns.
> +	for pid in "${pids[@]}"; do
> +		wait "$pid"
> +		rc=3D$?
> +		[ "$rc" -eq "$KSFT_PASS" ] && KTAP_CNT_PASS=3D$((KTAP_CNT_PASS+1))
> +		[ "$rc" -eq "$KSFT_FAIL" ] && KTAP_CNT_FAIL=3D$((KTAP_CNT_FAIL+1))
> +		[ "$rc" -eq "$KSFT_SKIP" ] && KTAP_CNT_SKIP=3D$((KTAP_CNT_SKIP+1))
> +		[ "$rc" -eq "$KSFT_XFAIL" ] && KTAP_CNT_XFAIL=3D$((KTAP_CNT_XFAIL+1))

These variables don't seeem to have anything to do with KTAP so I think
they should have a different name prefix. I guess KSFT_*? Or maybe
RUNNER_* or something.

Also I guess we should initialise them to 0 so they are still set if no
tests actually get run?

Also I think it's probably time to start documenting the
interface of runner.sh - sorry I probably should have done this when I
created kselftest_failures_file. Can you add a comment at the top to
show that these variables are part of the "API"?

