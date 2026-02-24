Return-Path: <netdev+bounces-260481-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SE55E1KOnWkXQgQAu9opvQ
	(envelope-from <netdev+bounces-260481-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 12:41:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C230A1866FF
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 12:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3DFC3145F37
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 11:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318AE37BE76;
	Tue, 24 Feb 2026 11:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fc5t+VDd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB662D6E6F
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 11:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771933118; cv=none; b=AilahN+3zhxJs5jSEWkpclhPRcTri/JeNoEMPapQHKCAveEH3nN/rcyxherVFtopNCZ9/a9yRyDqwnPzc1VkznUYLWJkIZkjQ6IG+yAAWils410FEuWGx+sYhIhp7N0viOuxSc9Z2ac2OVb68sSlAaHeCHlji6LUlBqYgZfg+SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771933118; c=relaxed/simple;
	bh=KBejYjTiAHiCdO0hpFTb5Kqi6f7oBc2X2Hd0hmGDyUs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ntHNqFd+CSAoFgiRCbrzd8tOs2BA6SDXW6/GzjJKjnvQWCFCoMGqaIyDmqB4/55PK3OtDHp716JZn7mC20KMHYQngHI5H/8IcKVsQaBpilPq0Nps4FP2vp5P2Te3Zb2HTyQwJiidqkBJuO5jLh48ySv5hEQCeHFM/0gVTyEVWbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fc5t+VDd; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4832c4621c2so53962745e9.3
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 03:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771933115; x=1772537915; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c7TQGCg6/YHh/FYJGHUrBfOHEG5gJag5sDTI0rUIUrU=;
        b=fc5t+VDdrf9TnjX0baWMDSfj7lx8jdwXPzhKtGqrBnOXY7mikuRG8rl0U7dopzb3HI
         TMmjYqlN/YWFPFKLKAjSZll9AEo6f+E96tuSEVCsK7MgE9Zk/qGN3tmnTU7ruq9GU+0A
         Kj7CmzgBa7bRte5Flkic3zthSo54cetyEEe64G14fV5K6jzg7IQpfHAVTHmj1j5GKnb2
         44+h324Zl++VQ4+xJbnXyVHAapHlekkPAkuAlOM//Hp5I+AIeTAfqaQsrtemALJDM02l
         W18Gh/vhpGy6mz8X05lJu0f/setSaiwNWeCoN3mRxEBsfUIP5Atbjw1aIo7OvtEkkmDM
         JmEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771933115; x=1772537915;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=c7TQGCg6/YHh/FYJGHUrBfOHEG5gJag5sDTI0rUIUrU=;
        b=fygXBRq9rnNPBWax0rVCEaBZwMpxNFD+Ze2+Omj6729QD+2BDXZtvKN/6ppJa27u7T
         L5cng0TUTlm/uOrUpwJriOhoW8bDIE59RQ73xS0gLivcAGkmUVjmrE8WODQpR3IIVGAX
         oSmUHDhpltzqtzY/ejqkKF5tZzQow26C9PnOHI4pgpJek69ViADeLk36MlRbvyDV6F+a
         i2LyoZxsL/1ZVsCeXLghp+3y+8eWu02x28BK7nQgZORa6Ar8HJCzIqXebhK4CH/Yl2Es
         iam/O/oqPWT1/CsQUoiOFxEUse25P0f9gAkP2dpVTsYzNr9vxP2YsHsCQQNDkyHmD4ui
         VK9w==
X-Forwarded-Encrypted: i=1; AJvYcCUdmJvvyC+ACHVclV3VrvYoQAwSeNxhP9Nb5b4riZBgYNUR+smxcPefGWBma57cQpa9HrbgD1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDg6jfmYcfP04L7IUkHUOE6qQ0rgxw5SYHEnGp7tm5yvMkzLWi
	dhvxZuChOVBiSc2w6GAJgcp92X78GYMvuNqKBNr5AgQe5q8sEEVGA/Iy6mt6iEks+RvK2SVt9gH
	QPrvylo6mA2KlKQ==
X-Received: from wmbjj14.prod.google.com ([2002:a05:600c:6a0e:b0:483:80e5:6e03])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3115:b0:483:3380:ca0c with SMTP id 5b1f17b1804b1-483a9611795mr251190535e9.35.1771933114696;
 Tue, 24 Feb 2026 03:38:34 -0800 (PST)
Date: Tue, 24 Feb 2026 11:38:34 +0000
In-Reply-To: <20260224041048.6570-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260224041048.6570-1-liuhangbin@gmail.com>
X-Mailer: aerc 0.21.0
Message-ID: <DGN5V6ZKYQ3A.1F5DK46XY82YB@google.com>
Subject: Re: [PATCHv2] selftests: Use ktap helpers for runner.sh
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260481-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jackmanb@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C230A1866FF
X-Rspamd-Action: no action

On Tue Feb 24, 2026 at 4:10 AM UTC, Hangbin Liu wrote:
> Instead of manually writing ktap messages, we should use the formal
> ktap helpers in runner.sh. Brendan did some work in d9e6269e3303
> ("selftests/run_kselftest.sh: exit with error if tests fail") to make
> run_kselftest.sh exit with the correct return value. However, the output
> does not include the total results, such as how many tests passed or
> failed.
>
> Let=E2=80=99s convert all manually printed messages in runner.sh to use t=
he
> formal ktap helpers. Here are what I changed:
>
>   1. Move TAP header from runner.sh to run_kselftest.sh, since run_kselft=
est.sh
>      is the only caller of run_many().
>   2. In run_kselftest.sh, call run_many() in main process to count the
>      pass/fail numbers.
>   3. In run_kselftest.sh, do not generate kselftest_failures_file. Just
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
>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>
> v2: Update commit description and comments in code. (Brendan Jackman)

Cool thanks sorry I did not really review the code before but now I'm
taking a closer look.

I don't parse KTAP but I did check that this doesn't break my usecase
[0] so:

Tested-By: Brendan Jackman <jackmanb@google.com>

[0]: https://github.com/bjackman/limmat-kernel-nix/blob/master/ktests.nix

> ---
>  tools/testing/selftests/kselftest/runner.sh | 84 ++++++++++++---------
>  tools/testing/selftests/run_kselftest.sh    | 21 ++++--
>  2 files changed, 63 insertions(+), 42 deletions(-)
>
> diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/=
selftests/kselftest/runner.sh
> index 3a62039fa621..dfd6fedf8911 100644
> --- a/tools/testing/selftests/kselftest/runner.sh
> +++ b/tools/testing/selftests/kselftest/runner.sh
> @@ -1,8 +1,8 @@
> -#!/bin/sh
> +#!/bin/bash
>  # SPDX-License-Identifier: GPL-2.0
>  #
>  # Runs a set of tests in a given subdirectory.
> -export skip_rc=3D4
> +. $(dirname "$(readlink -e "${BASH_SOURCE[0]}")")/ktap_helpers.sh
>  export timeout_rc=3D124
>  export logfile=3D/dev/stdout
>  export per_test_logging=3D
> @@ -44,17 +44,11 @@ tap_timeout()
>  	fi
>  }
> =20
> -report_failure()
> -{
> -	echo "not ok $*"
> -	echo "$*" >> "$kselftest_failures_file"
> -}
> -
>  run_one()
>  {
>  	DIR=3D"$1"
>  	TEST=3D"$2"
> -	local test_num=3D"$3"
> +	local rc test_num=3D"$3"
> =20
>  	BASENAME_TEST=3D$(basename $TEST)
> =20
> @@ -102,16 +96,17 @@ run_one()
>  	# Command line timeout overrides the settings file
>  	if [ -n "$kselftest_override_timeout" ]; then
>  		kselftest_timeout=3D"$kselftest_override_timeout"
> -		echo "# overriding timeout to $kselftest_timeout" >> "$logfile"
> +		ktap_print_msg "overriding timeout to $kselftest_timeout" >> "$logfile=
"
>  	else
> -		echo "# timeout set to $kselftest_timeout" >> "$logfile"
> +		ktap_print_msg "timeout set to $kselftest_timeout" >> "$logfile"
>  	fi
> =20
>  	TEST_HDR_MSG=3D"selftests: $DIR: $BASENAME_TEST"
>  	echo "# $TEST_HDR_MSG"
>  	if [ ! -e "$TEST" ]; then
> -		echo "# Warning: file $TEST is missing!"
> -		report_failure "$test_num $TEST_HDR_MSG"
> +		ktap_print_msg "Warning: file $TEST is missing!"
> +		ktap_test_fail "$test_num $TEST_HDR_MSG"
> +		rc=3D$KSFT_FAIL
>  	else
>  		if [ -x /usr/bin/stdbuf ]; then
>  			stdbuf=3D"/usr/bin/stdbuf --output=3DL "
> @@ -122,33 +117,37 @@ run_one()
>  		elif [ -x "./ksft_runner.sh" ]; then
>  			cmd=3D"$stdbuf ./ksft_runner.sh ./$BASENAME_TEST"
>  		else
> -			echo "# Warning: file $TEST is not executable"
> +			ktap_print_msg "Warning: file $TEST is not executable"
> =20
>  			if [ $(head -n 1 "$TEST" | cut -c -2) =3D "#!" ]
>  			then
>  				interpreter=3D$(head -n 1 "$TEST" | cut -c 3-)
>  				cmd=3D"$stdbuf $interpreter ./$BASENAME_TEST"
>  			else
> -				report_failure "$test_num $TEST_HDR_MSG"
> -				return
> +				ktap_test_fail "$test_num $TEST_HDR_MSG"
> +				return $KSFT_FAIL
>  			fi
>  		fi
>  		cd `dirname $TEST` > /dev/null
> -		((((( tap_timeout "$cmd" 2>&1; echo $? >&3) |
> +		(((( tap_timeout "$cmd" 2>&1; echo $? >&3) |
>  			tap_prefix >&4) 3>&1) |
> -			(read xs; exit $xs)) 4>>"$logfile" &&
> -		echo "ok $test_num $TEST_HDR_MSG") ||
> -		(rc=3D$?;	\
> -		if [ $rc -eq $skip_rc ]; then	\
> -			echo "ok $test_num $TEST_HDR_MSG # SKIP"
> -		elif [ $rc -eq $timeout_rc ]; then \
> -			echo "#"
> -			report_failure "$test_num $TEST_HDR_MSG # TIMEOUT $kselftest_timeout =
seconds"
> +			(read xs; exit $xs)) 4>>"$logfile"
> +		rc=3D$?
> +		if [ "$rc" -eq "$KSFT_PASS" ]; then
> +			ktap_test_pass "$test_num $TEST_HDR_MSG"
> +		elif [ "$rc" -eq "$KSFT_SKIP" ]; then
> +			ktap_test_skip "$test_num $TEST_HDR_MSG"
> +		elif [ "$rc" -eq "$KSFT_XFAIL" ]; then
> +			ktap_test_xfail "$test_num $TEST_HDR_MSG"
> +		elif [ "$rc" -eq "$timeout_rc" ]; then
> +			ktap_test_fail "$test_num $TEST_HDR_MSG # TIMEOUT $kselftest_timeout =
seconds"
>  		else
> -			report_failure "$test_num $TEST_HDR_MSG # exit=3D$rc"
> -		fi)
> +			ktap_test_fail "$test_num $TEST_HDR_MSG # exit=3D$rc"
> +		fi
>  		cd - >/dev/null
>  	fi
> +
> +	return $rc
>  }
> =20
>  in_netns()
> @@ -164,27 +163,34 @@ in_netns()
> =20
>  run_in_netns()
>  {
> -	local netns=3D$(mktemp -u ${BASENAME_TEST}-XXXXXX)
>  	local tmplog=3D"/tmp/$(mktemp -u ${BASENAME_TEST}-XXXXXX)"
> +	local netns=3D$(mktemp -u ${BASENAME_TEST}-XXXXXX)

Nit (no need to respin just for this, but if you're already respinning):
Diff noise here.

> +	local rc
> +
>  	ip netns add $netns
>  	if [ $? -ne 0 ]; then
> -		echo "# Warning: Create namespace failed for $BASENAME_TEST"
> -		echo "not ok $test_num selftests: $DIR: $BASENAME_TEST # Create NS fai=
led"
> +		ktap_print_msg "Warning: Create namespace failed for $BASENAME_TEST"
> +		ktap_test_fail "$test_num selftests: $DIR: $BASENAME_TEST # Create NS =
failed"
>  	fi
>  	ip -n $netns link set lo up
> +
>  	in_netns $netns &> $tmplog
> +	rc=3D$?
> +
>  	ip netns del $netns &> /dev/null
> +	# Cat the log at once to avoid parallel netns logs.
>  	cat $tmplog
>  	rm -f $tmplog
> +	return $rc
>  }
> =20
>  run_many()
>  {
> -	echo "TAP version 13"
>  	DIR=3D"${PWD#${BASE_DIR}/}"
>  	test_num=3D0
> -	total=3D$(echo "$@" | wc -w)
> -	echo "1..$total"
> +	local rc
> +	pids=3D()
> +
>  	for TEST in "$@"; do
>  		BASENAME_TEST=3D$(basename $TEST)
>  		test_num=3D$(( test_num + 1 ))
> @@ -194,10 +200,20 @@ run_many()
>  		fi
>  		if [ -n "$RUN_IN_NETNS" ]; then
>  			run_in_netns &
> +			pids+=3D($!)
>  		else
>  			run_one "$DIR" "$TEST" "$test_num"
>  		fi
>  	done
> =20
> -	wait
> +	# These variables are outputs of ktap_helpers.sh but since we've
> +	# run the test in a subprocess we need to update them manually
> +	for pid in "${pids[@]}"; do
> +		wait "$pid"
> +		rc=3D$?
> +		[ "$rc" -eq "$KSFT_PASS" ] && KTAP_CNT_PASS=3D$((KTAP_CNT_PASS+1))
> +		[ "$rc" -eq "$KSFT_FAIL" ] && KTAP_CNT_FAIL=3D$((KTAP_CNT_FAIL+1))
> +		[ "$rc" -eq "$KSFT_SKIP" ] && KTAP_CNT_SKIP=3D$((KTAP_CNT_SKIP+1))
> +		[ "$rc" -eq "$KSFT_XFAIL" ] && KTAP_CNT_XFAIL=3D$((KTAP_CNT_XFAIL+1))
> +	done

Can we please be consistent about how we do these two big conditional
blocks? Also should they use `case`? Also please add something to not
fail silently if $rc has a garbage value (I guess just log a warning).

FWIW I still think this is very yucky but, it seems switching to the
helper library is a worthwhile cleanup (plus, this patch drops a level
of subshell nesting in the tap_timeout pipeline, which seems like a step
in the right direction!) so I think it would be irrational to block that
cleanup just coz of this yuckiness.

>  }
> diff --git a/tools/testing/selftests/run_kselftest.sh b/tools/testing/sel=
ftests/run_kselftest.sh
> index 84d45254675c..3ffd03f1334d 100755
> --- a/tools/testing/selftests/run_kselftest.sh
> +++ b/tools/testing/selftests/run_kselftest.sh
> @@ -121,18 +121,23 @@ if [ -n "$SKIP" ]; then
>  	done
>  fi
> =20
> -kselftest_failures_file=3D"$(mktemp --tmpdir kselftest-failures-XXXXXX)"
> -export kselftest_failures_file
> -
> +curdir=3D$(pwd)
> +total=3D$(echo "$available" | wc -w)
>  collections=3D$(echo "$available" | cut -d: -f1 | sort | uniq)
> +
> +ktap_print_header
> +ktap_set_plan "$total"
>
>  for collection in $collections ; do
>  	[ -w /dev/kmsg ] && echo "kselftest: Running tests in $collection" >> /=
dev/kmsg
>  	tests=3D$(echo "$available" | grep "^$collection:" | cut -d: -f2)
> -	($dryrun cd "$collection" && $dryrun run_many $tests)
> +	$dryrun cd "$collection" && $dryrun run_many $tests
> +	$dryrun cd "$curdir"
>  done
> =20
> -failures=3D"$(cat "$kselftest_failures_file")"
> -rm "$kselftest_failures_file"
> -if "$ERROR_ON_FAIL" && [ "$failures" ]; then
> -	exit 1
> +ktap_print_totals
> +if "$ERROR_ON_FAIL" && [ "$KTAP_CNT_FAIL" -ne 0 ]; then
> +	exit "$KSFT_FAIL"
> +else
> +	exit "$KSFT_PASS"
>  fi


