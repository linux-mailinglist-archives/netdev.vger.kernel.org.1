Return-Path: <netdev+bounces-52222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0467FDE8C
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 18:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06FB9282615
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 17:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8755E4F1F7;
	Wed, 29 Nov 2023 17:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WAEgde2w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6583B34CF7;
	Wed, 29 Nov 2023 17:39:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43073C433C8;
	Wed, 29 Nov 2023 17:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701279592;
	bh=3J4iQaKQJl07LgfKQzir6Zof3M/XrEMBbmsjffBPgYY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WAEgde2wk9nC92RYQyrxsBe6hLqet/k4QjCU4bAKmrJX9KaZI2kLiGd6P+lb9eInl
	 FOkeyU38MPheNp+l5PDn1w5L84iPSbyXo3rHUZal1levE+PmtFXBH32Xh5KchymOQU
	 gAnz6PFUgYuHVcUetb7aj56mjnpE0hRAjB4CDroZKnPVTBZ9ji51mNbx+2Y54ZF0j7
	 +zv51gQOFmteTeahubKKCY3ZVI+pJ7AZvPr3aSXFJsX94tBX0u91/OS1AWFgIgUCRo
	 AIJwYf7JfR6Q424+3Rm8le5ETf7TF9OyjkeagRnjcgJkTwPT/f+aqv1R3DZ+AUmaxw
	 fzhC/adMdSt6A==
Date: Wed, 29 Nov 2023 09:39:51 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Michal Michalik <michal.michalik@intel.com>
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, jonathan.lemon@gmail.com,
 pabeni@redhat.com, poros@redhat.com, milena.olech@intel.com,
 mschmidt@redhat.com, linux-clk@vger.kernel.org, bvanassche@acm.org,
 davem@davemloft.net, edumazet@google.com
Subject: Re: [PATCH RFC net-next v4 2/2] selftests/dpll: add DPLL system
 integration selftests
Message-ID: <20231129093951.3be1bd8b@kernel.org>
In-Reply-To: <20231123105243.7992-3-michal.michalik@intel.com>
References: <20231123105243.7992-1-michal.michalik@intel.com>
	<20231123105243.7992-3-michal.michalik@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Nov 2023 05:52:43 -0500 Michal Michalik wrote:
> The tests are written in Python3 (3.7+) and pytest testing framework.
> Framework is basing on the ynl library available in the kernel tree
> at: tools/net/ynl

LGTM!

Somewhat tangential question, a nit, and a comment..
 
> The DPLL system integration tests are meant to be part of selftests, so
> they can be build and run using command:
>   make -C tools/testing/selftests
> 
> Alternatively, they can be run using single command [1]:
>   make kselftest
> 
> If we want to run only DPLL tests, we should set the TARGETS variable:
>   make -C tools/testing/selftests TARGETS=drivers/net/netdevsim/dpll
> 
> They can also be run standalone using starter script:
>   ./run_dpll_tests.sh
> 
> There is a possibliy to set optional PYTEST_PARAMS environment variable
> to set the pytest options, like tests filtering ("-k <filter>") or
> verbose output ("-v").
> 
> [1] https://www.kernel.org/doc/html/v5.0/dev-tools/kselftest.html

nit: s/v5.0/v6.6/ ? Or /v5.0/latest/

Did you try to run it in vmtest or virtme-ng?
https://www.youtube.com/watch?v=NT-325hgXjY
https://lpc.events/event/17/contributions/1506/attachments/1143/2441/virtme-ng.pdf

I'm thinking of using those for continuous testing, curious all 
the Python setup works okay with them.

> +@pytest.fixture(scope="class", params=((0,), (1, 0), (0, 1)))

We have both uses of pytest and unittest in the kernel:

$ git grep --files-with-matches '^import .*unittest'
scripts/rust_is_available_test.py
tools/crypto/ccp/test_dbc.py
tools/perf/pmu-events/metric_test.py
tools/testing/kunit/kunit_tool_test.py
tools/testing/selftests/bpf/test_bpftool.py
tools/testing/selftests/tpm2/tpm2.py
tools/testing/selftests/tpm2/tpm2_tests.py

$ git grep --files-with-matches '^import .*pytest'
scripts/kconfig/tests/conftest.py
tools/testing/selftests/drivers/sdsi/sdsi.sh
tools/testing/selftests/drivers/sdsi/sdsi_test.py
tools/testing/selftests/hid/tests/base.py
tools/testing/selftests/hid/tests/conftest.py
tools/testing/selftests/hid/tests/test_gamepad.py
tools/testing/selftests/hid/tests/test_mouse.py
tools/testing/selftests/hid/tests/test_multitouch.py
tools/testing/selftests/hid/tests/test_sony.py
tools/testing/selftests/hid/tests/test_tablet.py
tools/testing/selftests/hid/tests/test_usb_crash.py
tools/testing/selftests/hid/tests/test_wacom_generic.py

unittest seems a bit more popular but pytest does seem like
a better fit indeed.

Did you see what the sdsi test does? It seems to assume everything 
is installed locally, without the venv. I wonder if that may be simpler
to get going with vmtest?

