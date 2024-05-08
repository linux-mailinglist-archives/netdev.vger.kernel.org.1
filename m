Return-Path: <netdev+bounces-94363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7CB8BF468
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 04:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 055521F219C2
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 02:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDD59470;
	Wed,  8 May 2024 02:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="koktkBHA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DDA8F6C
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 02:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715134916; cv=none; b=uo6Yl3Gu9jKscIn9YHIn6x11LWhDiuj0n99Ui6fowxhmp3FnR7AxkY5c19BVywyPUhE8h5mNLlcbxNysy16ladkETErzUUtglGTjlc/YGPTc8CYsonZPORDwg7MAjIOjVuJRITEACecR7bLiLXxgrEyjG3L49oltMCUCE8Ubsxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715134916; c=relaxed/simple;
	bh=PspyB4dlzzivcjtSIq2loDE1efMEqBZBNrPmdjn+4jQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R4AAFupWuTt+EIbwvAigzohsqZPZqQO9QEZCIaqSgJZLsGNVKYSdr7lc7g/FKiklkOgV8sO7dXkIfvULx9ma3VtBWEXgxJazfq/ulaYVNDALBlkd7XAGentZHpjJi1+6RLZS8A82rYAWu4VNPWvrYLuPJvJBiNGRQWueup+2RX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=koktkBHA; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6f43ee95078so3420723b3a.1
        for <netdev@vger.kernel.org>; Tue, 07 May 2024 19:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1715134914; x=1715739714; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cmd8djFTFGvc/yW3JH0fwhCCpuaQO1Joz/u114JS/+A=;
        b=koktkBHASORrV4SBK5MyqUwiH/e5ZApRJOHysLE/husw6VpBN8IQ+yiTQEEyx8h4bX
         IbIZ34dwc71yejdjJxNhmhKtaZvRl31joE6WVQzZfzditE4Mm+iJkCNzfgBh9gNYruse
         SwIT/imBdAbgBX3tuokY2naufrLsovVUhEccU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715134914; x=1715739714;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cmd8djFTFGvc/yW3JH0fwhCCpuaQO1Joz/u114JS/+A=;
        b=fXlky4Do2+8XTwIXYBe22P9W2H3JnjHP1W2t3exjtAa2Db3YV/PdmaznWRWLaRMAZH
         4NMHCu2y6xIKz3ncWzD+mDwE8nkLnAasLWSXwExkCDzqsTUO/f15stXoRkoi0q1BZi/Z
         R55jMbQ3jhD1gUJDf5MllT07J/0DHgZ3mAzyASYjpXEv2/thtGRSiprWZIkVaH2u6+fL
         HIGAixZroutFXNKxf0oHf1Qtkk5L/5XK3/gjJr9vaX4Bg9tJcRbISAiQ3tr+iW2WcQZD
         ZIXdJZtSJDUstXowh+naDRjBng/MkTRK89Irki0zGkBs9IztqiMg45nGZIlI4sv0/DfE
         yr8w==
X-Forwarded-Encrypted: i=1; AJvYcCXinIhs2zavYABPeLZtJ5MW0YcMQshVZFshBQApDTgb1GkxeP8c/ipkEq0M5+2+1292z/cUi2f2mrK91tfqEKnHxgFsh4K1
X-Gm-Message-State: AOJu0YzzVJY91nh+c9Wcu8gc7044MVqCLUqcud4hkKp67OqFR+BcH5gq
	0lNYUXjlWZ4mpNeer9QNt31tP95n4j3pNP0q5a/xGdiP+p+MpQrdXmvN2Bi/YSo=
X-Google-Smtp-Source: AGHT+IGh+CKo5e5lxJUe8emJhtCaBCKe1t9psCMM1/OELGicqirij53m8/5UMcOTpgC5k9lUJqB3pA==
X-Received: by 2002:aa7:86cc:0:b0:6f3:f30a:19b with SMTP id d2e1a72fcca58-6f49c22cc4bmr1586647b3a.18.1715134913576;
        Tue, 07 May 2024 19:21:53 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id f24-20020a056a000b1800b006ed0f719a5fsm10093344pfu.81.2024.05.07.19.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 19:21:53 -0700 (PDT)
Date: Tue, 7 May 2024 19:21:50 -0700
From: Joe Damato <jdamato@fastly.com>
To: linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: nalramli@fastly.com, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH net-next v3] selftest: epoll_busy_poll: epoll busy poll
 tests
Message-ID: <ZjrhvnpRIhPI3mal@LQ3V64L9R2>
References: <20240508004328.33970-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508004328.33970-1-jdamato@fastly.com>

On Wed, May 08, 2024 at 12:43:26AM +0000, Joe Damato wrote:
> Add a simple test for the epoll busy poll ioctls, using the kernel
> selftest harness.
> 
> This test ensures that the ioctls have the expected return codes and
> that the kernel properly gets and sets epoll busy poll parameters.
> 
> The test can be expanded in the future to do real busy polling (provided
> another machine to act as the client is available).

Ah, built and worked for me, but of course fails remotely:

epoll_busy_poll.c:20:10: fatal error: sys/capability.h: No such file or directory
   20 | #include <sys/capability.h>
      |          ^~~~~~~~~~~~~~~~~~

Looks like selftests/bpf/cap_helpers.c avoids a similar-ish issue? Not sure if
there's a better way or if I should do something like that?

I assume it is not possible to add deps like libcap-dev to the test harness somehow?

> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---
> v2 -> v3:
>   - Added this changelog :)
>   - Add libcap to LDLIBS.
>   - Most other changes are in test_set_invalid:
>     - Check if CAP_NET_ADMIN is set in the effective set before setting
>       busy_poll_budget over NAPI_POLL_WEIGHT. The test which follows
>       assumes CAP_NET_ADMIN.
>     - Drop CAP_NET_ADMIN from effective set in order to ensure the ioctl
>       fails when busy_poll_budget exceeds NAPI_POLL_WEIGHT.
>     - Put CAP_NET_ADMIN back into the effective set afterwards.
>     - Changed self->params.busy_poll_budget from 65535 to UINT16_MAX.
>     - Changed the cast for params.busy_poll_usecs from unsigned int to
>       uint32_t in the test_set_invalid case.
> 
> v1 -> v2:
>   - Rewrote completely to use kernel self test harness.
> 
>  tools/testing/selftests/net/.gitignore        |   1 +
>  tools/testing/selftests/net/Makefile          |   3 +-
>  tools/testing/selftests/net/epoll_busy_poll.c | 320 ++++++++++++++++++
>  3 files changed, 323 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/net/epoll_busy_poll.c
> 
> diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selftests/net/.gitignore
> index d996a0ab0765..777cfd027076 100644
> --- a/tools/testing/selftests/net/.gitignore
> +++ b/tools/testing/selftests/net/.gitignore
> @@ -5,6 +5,7 @@ bind_wildcard
>  csum
>  cmsg_sender
>  diag_uid
> +epoll_busy_poll
>  fin_ack_lat
>  gro
>  hwtstamp_config
> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
> index 5befca249452..c6112d08b233 100644
> --- a/tools/testing/selftests/net/Makefile
> +++ b/tools/testing/selftests/net/Makefile
> @@ -67,7 +67,7 @@ TEST_GEN_FILES += ipsec
>  TEST_GEN_FILES += ioam6_parser
>  TEST_GEN_FILES += gro
>  TEST_GEN_PROGS = reuseport_bpf reuseport_bpf_cpu reuseport_bpf_numa
> -TEST_GEN_PROGS += reuseport_dualstack reuseaddr_conflict tls tun tap
> +TEST_GEN_PROGS += reuseport_dualstack reuseaddr_conflict tls tun tap epoll_busy_poll
>  TEST_GEN_FILES += toeplitz
>  TEST_GEN_FILES += cmsg_sender
>  TEST_GEN_FILES += stress_reuseport_listen
> @@ -102,6 +102,7 @@ TEST_INCLUDES := forwarding/lib.sh
>  
>  include ../lib.mk
>  
> +$(OUTPUT)/epoll_busy_poll: LDLIBS += -lcap
>  $(OUTPUT)/reuseport_bpf_numa: LDLIBS += -lnuma
>  $(OUTPUT)/tcp_mmap: LDLIBS += -lpthread -lcrypto
>  $(OUTPUT)/tcp_inq: LDLIBS += -lpthread
> diff --git a/tools/testing/selftests/net/epoll_busy_poll.c b/tools/testing/selftests/net/epoll_busy_poll.c
> new file mode 100644
> index 000000000000..9dd2830fd67c
> --- /dev/null
> +++ b/tools/testing/selftests/net/epoll_busy_poll.c
> @@ -0,0 +1,320 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +/* Basic per-epoll context busy poll test.
> + *
> + * Only tests the ioctls, but should be expanded to test two connected hosts in
> + * the future
> + */
> +
> +#define _GNU_SOURCE
> +
> +#include <error.h>
> +#include <errno.h>
> +#include <inttypes.h>
> +#include <limits.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +
> +#include <sys/capability.h>
> +
> +#include <sys/epoll.h>
> +#include <sys/ioctl.h>
> +#include <sys/socket.h>
> +
> +#include "../kselftest_harness.h"
> +
> +/* if the headers haven't been updated, we need to define some things */
> +#if !defined(EPOLL_IOC_TYPE)
> +struct epoll_params {
> +	uint32_t busy_poll_usecs;
> +	uint16_t busy_poll_budget;
> +	uint8_t prefer_busy_poll;
> +
> +	/* pad the struct to a multiple of 64bits */
> +	uint8_t __pad;
> +};
> +
> +#define EPOLL_IOC_TYPE 0x8A
> +#define EPIOCSPARAMS _IOW(EPOLL_IOC_TYPE, 0x01, struct epoll_params)
> +#define EPIOCGPARAMS _IOR(EPOLL_IOC_TYPE, 0x02, struct epoll_params)
> +#endif
> +
> +FIXTURE(invalid_fd)
> +{
> +	int invalid_fd;
> +	struct epoll_params params;
> +};
> +
> +FIXTURE_SETUP(invalid_fd)
> +{
> +	int ret;
> +
> +	ret = socket(AF_UNIX, SOCK_DGRAM, 0);
> +	EXPECT_NE(-1, ret)
> +		TH_LOG("error creating unix socket");
> +
> +	self->invalid_fd = ret;
> +}
> +
> +FIXTURE_TEARDOWN(invalid_fd)
> +{
> +	int ret;
> +
> +	ret = close(self->invalid_fd);
> +	EXPECT_EQ(0, ret);
> +}
> +
> +TEST_F(invalid_fd, test_invalid_fd)
> +{
> +	int ret;
> +
> +	ret = ioctl(self->invalid_fd, EPIOCGPARAMS, &self->params);
> +
> +	EXPECT_EQ(-1, ret)
> +		TH_LOG("EPIOCGPARAMS on invalid epoll FD should error");
> +
> +	EXPECT_EQ(ENOTTY, errno)
> +		TH_LOG("EPIOCGPARAMS on invalid epoll FD should set errno to ENOTTY");
> +
> +	memset(&self->params, 0, sizeof(struct epoll_params));
> +
> +	ret = ioctl(self->invalid_fd, EPIOCSPARAMS, &self->params);
> +
> +	EXPECT_EQ(-1, ret)
> +		TH_LOG("EPIOCSPARAMS on invalid epoll FD should error");
> +
> +	EXPECT_EQ(ENOTTY, errno)
> +		TH_LOG("EPIOCSPARAMS on invalid epoll FD should set errno to ENOTTY");
> +}
> +
> +FIXTURE(epoll_busy_poll)
> +{
> +	int fd;
> +	struct epoll_params params;
> +	struct epoll_params *invalid_params;
> +	cap_t caps;
> +};
> +
> +FIXTURE_SETUP(epoll_busy_poll)
> +{
> +	int ret;
> +
> +	ret = epoll_create1(0);
> +	EXPECT_NE(-1, ret)
> +		TH_LOG("epoll_create1 failed?");
> +
> +	self->fd = ret;
> +
> +	self->caps = cap_get_proc();
> +	EXPECT_NE(NULL, self->caps);
> +}
> +
> +FIXTURE_TEARDOWN(epoll_busy_poll)
> +{
> +	int ret;
> +
> +	ret = close(self->fd);
> +	EXPECT_EQ(0, ret);
> +
> +	ret = cap_free(self->caps);
> +	EXPECT_NE(-1, ret)
> +		TH_LOG("unable to free capabilities");
> +}
> +
> +TEST_F(epoll_busy_poll, test_get_params)
> +{
> +	/* begin by getting the epoll params from the kernel
> +	 *
> +	 * the default should be default and all fields should be zero'd by the
> +	 * kernel, so set params fields to garbage to test this.
> +	 */
> +	int ret = 0;
> +
> +	self->params.busy_poll_usecs = 0xff;
> +	self->params.busy_poll_budget = 0xff;
> +	self->params.prefer_busy_poll = 1;
> +	self->params.__pad = 0xf;
> +
> +	ret = ioctl(self->fd, EPIOCGPARAMS, &self->params);
> +	EXPECT_EQ(0, ret)
> +		TH_LOG("ioctl EPIOCGPARAMS should succeed");
> +
> +	EXPECT_EQ(0, self->params.busy_poll_usecs)
> +		TH_LOG("EPIOCGPARAMS busy_poll_usecs should have been 0");
> +
> +	EXPECT_EQ(0, self->params.busy_poll_budget)
> +		TH_LOG("EPIOCGPARAMS busy_poll_budget should have been 0");
> +
> +	EXPECT_EQ(0, self->params.prefer_busy_poll)
> +		TH_LOG("EPIOCGPARAMS prefer_busy_poll should have been 0");
> +
> +	EXPECT_EQ(0, self->params.__pad)
> +		TH_LOG("EPIOCGPARAMS __pad should have been 0");
> +
> +	self->invalid_params = (struct epoll_params *)0xdeadbeef;
> +	ret = ioctl(self->fd, EPIOCGPARAMS, self->invalid_params);
> +
> +	EXPECT_EQ(-1, ret)
> +		TH_LOG("EPIOCGPARAMS should error with invalid params");
> +
> +	EXPECT_EQ(EFAULT, errno)
> +		TH_LOG("EPIOCGPARAMS with invalid params should set errno to EFAULT");
> +}
> +
> +TEST_F(epoll_busy_poll, test_set_invalid)
> +{
> +	int ret;
> +
> +	memset(&self->params, 0, sizeof(struct epoll_params));
> +
> +	self->params.__pad = 1;
> +
> +	ret = ioctl(self->fd, EPIOCSPARAMS, &self->params);
> +
> +	EXPECT_EQ(-1, ret)
> +		TH_LOG("EPIOCSPARAMS non-zero __pad should error");
> +
> +	EXPECT_EQ(EINVAL, errno)
> +		TH_LOG("EPIOCSPARAMS non-zero __pad errno should be EINVAL");
> +
> +	self->params.__pad = 0;
> +	self->params.busy_poll_usecs = (uint32_t)INT_MAX + 1;
> +
> +	ret = ioctl(self->fd, EPIOCSPARAMS, &self->params);
> +
> +	EXPECT_EQ(-1, ret)
> +		TH_LOG("EPIOCSPARAMS should error busy_poll_usecs > S32_MAX");
> +
> +	EXPECT_EQ(EINVAL, errno)
> +		TH_LOG("EPIOCSPARAMS busy_poll_usecs > S32_MAX errno should be EINVAL");
> +
> +	self->params.__pad = 0;
> +	self->params.busy_poll_usecs = 32;
> +	self->params.prefer_busy_poll = 2;
> +
> +	ret = ioctl(self->fd, EPIOCSPARAMS, &self->params);
> +
> +	EXPECT_EQ(-1, ret)
> +		TH_LOG("EPIOCSPARAMS should error prefer_busy_poll > 1");
> +
> +	EXPECT_EQ(EINVAL, errno)
> +		TH_LOG("EPIOCSPARAMS prefer_busy_poll > 1 errno should be EINVAL");
> +
> +	self->params.__pad = 0;
> +	self->params.busy_poll_usecs = 32;
> +	self->params.prefer_busy_poll = 1;
> +
> +	/* set budget well above kernel's NAPI_POLL_WEIGHT of 64 */
> +	self->params.busy_poll_budget = UINT16_MAX;
> +
> +	/* test harness should run with CAP_NET_ADMIN, but let's make sure */
> +	cap_flag_value_t tmp;
> +
> +	ret = cap_get_flag(self->caps, CAP_NET_ADMIN, CAP_EFFECTIVE, &tmp);
> +	EXPECT_EQ(0, ret)
> +		TH_LOG("unable to get CAP_NET_ADMIN cap flag");
> +
> +	EXPECT_EQ(CAP_SET, tmp)
> +		TH_LOG("expecting CAP_NET_ADMIN to be set for the test harness");
> +
> +	/* at this point we know CAP_NET_ADMIN is available, so setting the
> +	 * params with a busy_poll_budget > NAPI_POLL_WEIGHT should succeed
> +	 */
> +	ret = ioctl(self->fd, EPIOCSPARAMS, &self->params);
> +
> +	EXPECT_EQ(0, ret)
> +		TH_LOG("EPIOCSPARAMS should allow busy_poll_budget > NAPI_POLL_WEIGHT");
> +
> +	/* remove CAP_NET_ADMIN from our effective set */
> +	cap_value_t net_admin[] = { CAP_NET_ADMIN };
> +
> +	ret = cap_set_flag(self->caps, CAP_EFFECTIVE, 1, net_admin, CAP_CLEAR);
> +	EXPECT_EQ(0, ret)
> +		TH_LOG("couldnt clear CAP_NET_ADMIN");
> +
> +	ret = cap_set_proc(self->caps);
> +	EXPECT_EQ(0, ret)
> +		TH_LOG("cap_set_proc should drop CAP_NET_ADMIN");
> +
> +	/* this is now expected to fail */
> +	ret = ioctl(self->fd, EPIOCSPARAMS, &self->params);
> +
> +	EXPECT_EQ(-1, ret)
> +		TH_LOG("EPIOCSPARAMS should error busy_poll_budget > NAPI_POLL_WEIGHT");
> +
> +	EXPECT_EQ(EPERM, errno)
> +		TH_LOG("EPIOCSPARAMS errno should be EPERM busy_poll_budget > NAPI_POLL_WEIGHT");
> +
> +	/* restore CAP_NET_ADMIN to our effective set */
> +	ret = cap_set_flag(self->caps, CAP_EFFECTIVE, 1, net_admin, CAP_SET);
> +	EXPECT_EQ(0, ret)
> +		TH_LOG("couldn't restore CAP_NET_ADMIN");
> +
> +	ret = cap_set_proc(self->caps);
> +	EXPECT_EQ(0, ret)
> +		TH_LOG("cap_set_proc should set  CAP_NET_ADMIN");
> +
> +	self->invalid_params = (struct epoll_params *)0xdeadbeef;
> +	ret = ioctl(self->fd, EPIOCSPARAMS, self->invalid_params);
> +
> +	EXPECT_EQ(-1, ret)
> +		TH_LOG("EPIOCSPARAMS should error when epoll_params is invalid");
> +
> +	EXPECT_EQ(EFAULT, errno)
> +		TH_LOG("EPIOCSPARAMS should set errno to EFAULT when epoll_params is invalid");
> +}
> +
> +TEST_F(epoll_busy_poll, test_set_and_get_valid)
> +{
> +	int ret;
> +
> +	memset(&self->params, 0, sizeof(struct epoll_params));
> +
> +	self->params.busy_poll_usecs = 25;
> +	self->params.busy_poll_budget = 16;
> +	self->params.prefer_busy_poll = 1;
> +
> +	ret = ioctl(self->fd, EPIOCSPARAMS, &self->params);
> +
> +	EXPECT_EQ(0, ret)
> +		TH_LOG("EPIOCSPARAMS with valid params should not error");
> +
> +	/* check that the kernel returns the same values back */
> +
> +	memset(&self->params, 0, sizeof(struct epoll_params));
> +
> +	ret = ioctl(self->fd, EPIOCGPARAMS, &self->params);
> +
> +	EXPECT_EQ(0, ret)
> +		TH_LOG("EPIOCGPARAMS should not error");
> +
> +	EXPECT_EQ(25, self->params.busy_poll_usecs)
> +		TH_LOG("params.busy_poll_usecs incorrect");
> +
> +	EXPECT_EQ(16, self->params.busy_poll_budget)
> +		TH_LOG("params.busy_poll_budget incorrect");
> +
> +	EXPECT_EQ(1, self->params.prefer_busy_poll)
> +		TH_LOG("params.prefer_busy_poll incorrect");
> +
> +	EXPECT_EQ(0, self->params.__pad)
> +		TH_LOG("params.__pad was not 0");
> +}
> +
> +TEST_F(epoll_busy_poll, test_invalid_ioctl)
> +{
> +	int invalid_ioctl = EPIOCGPARAMS + 10;
> +	int ret;
> +
> +	ret = ioctl(self->fd, invalid_ioctl, &self->params);
> +
> +	EXPECT_EQ(-1, ret)
> +		TH_LOG("invalid ioctl should return error");
> +
> +	EXPECT_EQ(EINVAL, errno)
> +		TH_LOG("invalid ioctl should set errno to EINVAL");
> +}
> +
> +TEST_HARNESS_MAIN
> -- 
> 2.25.1
> 

