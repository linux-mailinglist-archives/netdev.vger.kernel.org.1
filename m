Return-Path: <netdev+bounces-257562-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GN1yBqD9hWnUIwQAu9opvQ
	(envelope-from <netdev+bounces-257562-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 15:41:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5894FF1BC
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 15:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72E2B304ADAA
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 14:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0223F3A1CE8;
	Fri,  6 Feb 2026 14:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cI3LZSh5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7970262FEC
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 14:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770388604; cv=none; b=dkctIT3wuyo7iN5O02jLJy4eMNcbJTfwDUnMPzuPzyLuN5wQ7Xy/tAOO7KB9z25QHpvIx9q7OX1tgnBZgvsYC3r0pxFbkHgQly2tis23zEEY9sqn1s9KyuluiLWKR8oM41jBxAStMZcqwD+TsoLC1p3B0PUHztt+85FpK/ISR8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770388604; c=relaxed/simple;
	bh=srqCmfI0lmYnxuLhqYXpEOsgsN6lN+17sPJcJsIlxO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m8eDiETb/kMNIj5PJ5KYMn889TBJGcBmonQ5gT5SCtCPKGK0dNtQh0WW0HLoN+rXiCcXCLbfJYyot9u3pH2vqQlT4B8Xrwe1yEJRbuxcvouYGIhdEyfDq/kFEKZRA4Iv4d/t3zVA/L5EGuvFzriEXkARratgy8zqrnjpzVaYqxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cI3LZSh5; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a93210fcc2so5768025ad.3
        for <netdev@vger.kernel.org>; Fri, 06 Feb 2026 06:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770388604; x=1770993404; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eDdKS/YOo/C446p8JC5nD/R7yYg0MoRxmTkUkoJ9NZI=;
        b=cI3LZSh5CU5CtZVkc988nVny88KG1njdOEx8XKTg2lxnKckSPAd6L0Zckz1HDGHrMy
         A+lvaSdzxzIoGDrGUJUgyEM2nDmPeRlvtNX/k1hggkV4qVz5qjWzH8+/B+tUvnwlSu7H
         71RnhZGzlwFKStQfaPw5eiVsrcj2IxmvyQQhZq0WeHzSbkX2hxrbAcX+p5tAfb9SlOBf
         QvbX8TQ/WZa/eBgs6hDy3sQW86poZfpJlNPDNqsc/5ajw1jHVV6fvUSoUZKHf0LWi8ws
         Mt1UDTB3Goz0jpJWthPNVoV1/x8nQOWabk9Zj/huP5NGO972r0j+7v8HIBilRKgW3YaK
         1Cyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770388604; x=1770993404;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eDdKS/YOo/C446p8JC5nD/R7yYg0MoRxmTkUkoJ9NZI=;
        b=py3mebI/GiJKcXEL8qGh7ymk/x+EdMloZVirpNQMTZiXr/I8OnfYeJi2dxcmJ7zr8m
         sjyHWk+sUyC1IgNTKUZXrD7IK/822+gtLYYfRZKJqZkfLCxiFP0lq8aKWBJU35BfO64K
         VF0UHvwU4DoKlNiCwb8rzY69L7vgKj8OAppl8Wz96FE994mv0vqSGy2fxp2RCXfz9lkn
         upQ9SgXOniOhwUDvlalkT91LxVQcJTbLJmtvRx1OU+ZWLZOB6bUKZYL2yu/rH6edzib7
         p9AksIZQZwNXVHsPKjWY0SZRTEvlyQvLisVryXEBGqnin7C9BrxlJ7WO1BU21xVUokdM
         dclQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwxefFccJ5+aWkBsKnmmOK0AtHrwgeTKwnj+WBbMoO+4ynbDVtq9q9gyoSvZmLGtrUjq/9Pts=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGP2CbVKSFkoEBAZjypKtQDUCUf24XbCt3RFSHB1oNEVDDIUPR
	eT+EGbvXCHeOYX96CWIzyvbmoOWeisqII/Hbab3B4g/bl2GD4ZnfFecU
X-Gm-Gg: AZuq6aKKZeMQ3hQBPDTGWXEmuXsV9RY+olsnJnGTBhOkfWai9P8URhexSQij1u+NIdz
	duGCbjxjpU3T51c2WlpHsWDNmPJ7AarHjrQeODYmlT05Wc2nilxaonCgsU3ALTV+DiHcLpfyHcE
	UnfP8C8UIjX5ORzu2w/LFJN4gFoOC9niqgywrZ75LCKx9Ivq08ZTZ1Hpm3TibD3+4KaiMBX/IAW
	qnQvwf3tbDPzaSrg7MiO//70Bet1JmQjB64kO9uPEVk62jcdithve3xrHX8r9azsEzIlHm5pER+
	I/s9/0BkZmtdzRZolQejEv6fr3p2FUpIaJu0Rxp04rW3p4jW0LgJq80xmwiBAc+we7zOWie3gfl
	NO4BYcj3lmQwSpme5bxtf/y8tq/FxQfqH23klCj6I/YGuTK9yl1E++DK7pjYnXCRDx2CFLi3GZc
	2iiRp8RntVvW1l8Zo=
X-Received: by 2002:a17:902:f788:b0:2a0:d431:930 with SMTP id d9443c01a7336-2a95196c9d4mr33606355ad.47.1770388603985;
        Fri, 06 Feb 2026 06:36:43 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a951c9cdf1sm23622415ad.41.2026.02.06.06.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 06:36:43 -0800 (PST)
Date: Fri, 6 Feb 2026 14:36:38 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Brendan Jackman <jackmanb@google.com>
Cc: linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org
Subject: Re: [PATCH selftests] selftests: Use ktap helpers for runner.sh
Message-ID: <aYX8dot4fTh3FJFI@fedora>
References: <20260206081704.53215-1-liuhangbin@gmail.com>
 <DG7TJFKZNG1J.19BZF87IWD3UG@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DG7TJFKZNG1J.19BZF87IWD3UG@google.com>
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
	TAGGED_FROM(0.00)[bounces-257562-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[run_kselftest.sh:url,runner.sh:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B5894FF1BC
X-Rspamd-Action: no action

Hi Brendan,
On Fri, Feb 06, 2026 at 10:48:59AM +0000, Brendan Jackman wrote:
> On Fri Feb 6, 2026 at 8:17 AM UTC, Hangbin Liu wrote:
> > This has been on my todo list for a long time. We should use ktap
> > helpers in runner.sh. I saw Brendan did some work in d9e6269e3303
> > ("selftests/run_kselftest.sh: exit with error if tests fail") to make
> > run_kselftest.sh exit with the correct return value. But we still use a
> > custom solution in runner.sh. Let's convert all the print messages to use
> > formal ktap helpers. Here’s what I changed:
> >
> >   1. Move TAP header from runner.sh to run_kselftest.sh, since run_kselftest.sh
> >      is the only caller of run_many().
> >   2. In run_kselftest.sh, call run_many() in main process to count the
> >      pass/fail numbers.
> >   3. In run_kselftest.sh, do not generate kselftest_failures_file; just
> >      use ktap_print_totals to report the result.
> >   4. In runner.sh run_one(), get the return value and use ktap helpers for
> >      all pass/fail reporting. This allows counting pass/fail numbers in the
> >      main process.
> >   5. In runner.sh run_in_netns(), also return the correct rc, so we can
> >      count results during wait.
> >
> > After the change, the printed result looks like:
> >
> >   not ok 4 4 selftests: clone3: clone3_cap_checkpoint_restore # exit=1
> >   # Totals: pass:3 fail:1 xfail:0 xpass:0 skip:0 error:0
> >
> >   ]# echo $?
> >   1
> 
> Sorry I'm being a bit lazy by not investigating this myself but the
> current intended behaviour is for runner.sh to output correct KTAP,
> right? Could you describe what behavioural changes this is expected to

For runner.sh, I just want to make it using the formal helper in
ktap_helpers.sh other than manually echo.

> bring - does it fix/change the KTAP output? (Or if it's just a cleanup
> with no intended change then please note that in the commit message).

It changes the run_kselftest.sh's output, with a total result. e.g.

# Totals: pass:3 fail:1 xfail:0 xpass:0 skip:0 error:0

> 
> I have not reviewed the code properly yet (I just read enough to check
> that it still does the thing I care about i.e. return an error code when
> something fails). I can do a proper review next week if you add a bit
> more context re the question above though.

Yes, I also care about the return code. This patch doesn't break it.

> 
> > -	wait
> > +	# Handle the return values when running in netns.
> > +	for pid in "${pids[@]}"; do
> > +		wait "$pid"
> > +		rc=$?
> > +		[ "$rc" -eq "$KSFT_PASS" ] && KTAP_CNT_PASS=$((KTAP_CNT_PASS+1))
> > +		[ "$rc" -eq "$KSFT_FAIL" ] && KTAP_CNT_FAIL=$((KTAP_CNT_FAIL+1))
> > +		[ "$rc" -eq "$KSFT_SKIP" ] && KTAP_CNT_SKIP=$((KTAP_CNT_SKIP+1))
> > +		[ "$rc" -eq "$KSFT_XFAIL" ] && KTAP_CNT_XFAIL=$((KTAP_CNT_XFAIL+1))
> 
> These variables don't seeem to have anything to do with KTAP so I think
> they should have a different name prefix. I guess KSFT_*? Or maybe
> RUNNER_* or something.
> 
> Also I guess we should initialise them to 0 so they are still set if no
> tests actually get run?
> 
> Also I think it's probably time to start documenting the
> interface of runner.sh - sorry I probably should have done this when I
> created kselftest_failures_file. Can you add a comment at the top to
> show that these variables are part of the "API"?

These variables are defined in ktap_helpers.sh and used by the ktap helpers.

Thanks
Hangbin

