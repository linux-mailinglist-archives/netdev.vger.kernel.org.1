Return-Path: <netdev+bounces-260022-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HBPJL1LnGnYDQQAu9opvQ
	(envelope-from <netdev+bounces-260022-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 13:44:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD911765C9
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 13:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 84A423055ED2
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 12:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A2D3659F1;
	Mon, 23 Feb 2026 12:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MhhFQ5n+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A23A36604D
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 12:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771850407; cv=none; b=H82mElcDH4MbriYLJXEc/Zl49eopbjprApSnK7I7svHt9ByrAjmM//OODiq7IsiXsI2+FqnqvSmIQ42AfagfchgL3vMdKtu/zcd4jkTnSYVWNvvSLpF/42mk1ujOOhsKY7+VKZNTIqDfo4U875ARENcQ0H3lUgIabIhP1GrgOo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771850407; c=relaxed/simple;
	bh=zLP9DBt5ACqyKp8zyP1I6et5L1V4brYDFyjTSlJe5AE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G4jNy6Rire2qPUQR3jWt+R7d2rmyaoPK6OGjxYpcITnzthnDaNwDrIjYW43VTPKu9JFFj7Nw5PlnnjaeSMDe87tu2vdHS3M+YAeb/gwLyB68OSZ+L87RnYKybdwuH3UwoiBwotHCX40UwEiXR0So4UAoIyoCdcYdY2YmZCSl5ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MhhFQ5n+; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-48378df3469so31810935e9.1
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 04:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771850404; x=1772455204; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H9UVo+Ch5cqNfZ/7JsfHkoD1JYgkJQPxukS4MObThec=;
        b=MhhFQ5n+PzDSPKzBRtwe18lbIdpDDdJ8T2UM7Z68MUfaA8vva/U/vYQGy371uSH/xK
         HURYzbBhCJrQsMfIXdbTz5VEHPeBUomjVKvWNTU5g9shcFqZSVcebFhGYPUOihJczlQO
         d9h68IRBguf9E0KRTLjFQ5g/UnBioix9RwFJm9+3Hvsegxp6zNuYN0ostrxzkRVhYoyj
         p+LezSlbU3wuwv/Y6HA90R/ynwaSYcCeNAaGHvsNsbZj+yo22lp5JnoSPRC5emNU9J/j
         23ydVbt9Hj+ZM3D2q04tmC/DtE/NEzD1CZU3nWNQX1YcIp+AcojKNCL2SKRB/Y78wS6W
         O+9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771850404; x=1772455204;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H9UVo+Ch5cqNfZ/7JsfHkoD1JYgkJQPxukS4MObThec=;
        b=vFJWJ2YKuEfN72ADjNvnX8BbMsYKBl3iJXziFj1pkRBjh1FfLOh1KLRJALi9AqlBID
         7lznd6bOeVedghJXnTm9HeOW9MheXRjNWZZ7sl5qFbTyuU4BpS36Rk1Vjs11EK/kcA0P
         EjvRDx16A18YEOEwK9fdSqTxxVf4PUfd9wSHectoA4AuEkI2KM8D0xobPEfMrHyA74X3
         enl18vOXD34euQUaiqchJhbGBLtQOWqLm/mnqlmJOG9njTkQ7mw18clvNpcyeBwFzdJk
         AtRlROns4Zyx/MArf5TpVLpOd0NtiISPii8qqKHC7O2eY68rAFchA46tYwOosmqAK74G
         qEGg==
X-Forwarded-Encrypted: i=1; AJvYcCVK6ANQ6CPo5Pj3DQsieorD1UxC10UQMe4AN+XAwMH6pCqYcp13LoaWHEgZE/jST4QXGmQFCOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMZI6IGcre57nT3IFJWMqy6hMEwsm7LnlfsPZcR4m0bVdNLuYo
	wuFcXQnpoz2M2lxFpIKaoCctJWC85CBiI96dLsXBb5ldhN2bmJC5Dzh7qtj5BB4sUUT6cdc8j5V
	5d/r9bQARej198A==
X-Received: from wmnv12.prod.google.com ([2002:a05:600c:444c:b0:477:a181:1919])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a204:b0:483:fbe:23dd with SMTP id 5b1f17b1804b1-483a00a52bdmr187554465e9.12.1771850403661;
 Mon, 23 Feb 2026 04:40:03 -0800 (PST)
Date: Mon, 23 Feb 2026 12:40:03 +0000
In-Reply-To: <aYX8dot4fTh3FJFI@fedora>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260206081704.53215-1-liuhangbin@gmail.com> <DG7TJFKZNG1J.19BZF87IWD3UG@google.com>
 <aYX8dot4fTh3FJFI@fedora>
X-Mailer: aerc 0.21.0
Message-ID: <DGMCJQ2TKZ1O.Q2C502GV1GSL@google.com>
Subject: Re: [PATCH selftests] selftests: Use ktap helpers for runner.sh
From: Brendan Jackman <jackmanb@google.com>
To: Hangbin Liu <liuhangbin@gmail.com>, Brendan Jackman <jackmanb@google.com>
Cc: <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, 
	<netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260022-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,google.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jackmanb@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,runner.sh:url]
X-Rspamd-Queue-Id: 3FD911765C9
X-Rspamd-Action: no action

On Fri Feb 6, 2026 at 2:36 PM UTC, Hangbin Liu wrote:
> Hi Brendan,
> On Fri, Feb 06, 2026 at 10:48:59AM +0000, Brendan Jackman wrote:
>> On Fri Feb 6, 2026 at 8:17 AM UTC, Hangbin Liu wrote:
>> > This has been on my todo list for a long time. We should use ktap
>> > helpers in runner.sh. I saw Brendan did some work in d9e6269e3303
>> > ("selftests/run_kselftest.sh: exit with error if tests fail") to make
>> > run_kselftest.sh exit with the correct return value. But we still use =
a
>> > custom solution in runner.sh. Let's convert all the print messages to =
use
>> > formal ktap helpers. Here=E2=80=99s what I changed:
>> >
>> >   1. Move TAP header from runner.sh to run_kselftest.sh, since run_kse=
lftest.sh
>> >      is the only caller of run_many().
>> >   2. In run_kselftest.sh, call run_many() in main process to count the
>> >      pass/fail numbers.
>> >   3. In run_kselftest.sh, do not generate kselftest_failures_file; jus=
t
>> >      use ktap_print_totals to report the result.
>> >   4. In runner.sh run_one(), get the return value and use ktap helpers=
 for
>> >      all pass/fail reporting. This allows counting pass/fail numbers i=
n the
>> >      main process.
>> >   5. In runner.sh run_in_netns(), also return the correct rc, so we ca=
n
>> >      count results during wait.
>> >
>> > After the change, the printed result looks like:
>> >
>> >   not ok 4 4 selftests: clone3: clone3_cap_checkpoint_restore # exit=
=3D1
>> >   # Totals: pass:3 fail:1 xfail:0 xpass:0 skip:0 error:0
>> >
>> >   ]# echo $?
>> >   1
>>=20
>> Sorry I'm being a bit lazy by not investigating this myself but the
>> current intended behaviour is for runner.sh to output correct KTAP,
>> right? Could you describe what behavioural changes this is expected to
>
> For runner.sh, I just want to make it using the formal helper in
> ktap_helpers.sh other than manually echo.
>
>> bring - does it fix/change the KTAP output? (Or if it's just a cleanup
>> with no intended change then please note that in the commit message).
>
> It changes the run_kselftest.sh's output, with a total result. e.g.
>
> # Totals: pass:3 fail:1 xfail:0 xpass:0 skip:0 error:0

Cool thanks, then please just clarify the commit message to say this.

>> I have not reviewed the code properly yet (I just read enough to check
>> that it still does the thing I care about i.e. return an error code when
>> something fails). I can do a proper review next week if you add a bit
>> more context re the question above though.
>
> Yes, I also care about the return code. This patch doesn't break it.
>
>>=20
>> > -	wait
>> > +	# Handle the return values when running in netns.
>> > +	for pid in "${pids[@]}"; do
>> > +		wait "$pid"
>> > +		rc=3D$?
>> > +		[ "$rc" -eq "$KSFT_PASS" ] && KTAP_CNT_PASS=3D$((KTAP_CNT_PASS+1))
>> > +		[ "$rc" -eq "$KSFT_FAIL" ] && KTAP_CNT_FAIL=3D$((KTAP_CNT_FAIL+1))
>> > +		[ "$rc" -eq "$KSFT_SKIP" ] && KTAP_CNT_SKIP=3D$((KTAP_CNT_SKIP+1))
>> > +		[ "$rc" -eq "$KSFT_XFAIL" ] && KTAP_CNT_XFAIL=3D$((KTAP_CNT_XFAIL+1=
))
>>=20
>> These variables don't seeem to have anything to do with KTAP so I think
>> they should have a different name prefix. I guess KSFT_*? Or maybe
>> RUNNER_* or something.
>>=20
>> Also I guess we should initialise them to 0 so they are still set if no
>> tests actually get run?
>>=20
>> Also I think it's probably time to start documenting the
>> interface of runner.sh - sorry I probably should have done this when I
>> created kselftest_failures_file. Can you add a comment at the top to
>> show that these variables are part of the "API"?
>
> These variables are defined in ktap_helpers.sh and used by the ktap helpe=
rs.

Hm, I see. Then it seems pretty hacky to mutate them directly here, and
is it correct to always increment them by 1?

I think the "correct" thing to do here is to parse the KTAP from the
child process's stdout, but I assume that's not actually practical with
the current tools we have available. (I could be wrong though, let me
know if that's the case).

Or maybe we can dump the values of the variables at the end of the child
and then add them into the parent process' values...=20

Or, if we just keep the current approach I think just having some
commentary to explain why we are doing this would help. I.e. "these
variables are outputs of ktap_helpers.sh but since we've run the test in
a subprocess we need to update them manually" (the current comment talks
about the netns which I think is confusing, I don't think the netns is
relevant at all).

