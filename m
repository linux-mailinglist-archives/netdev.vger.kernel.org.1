Return-Path: <netdev+bounces-75847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 710BC86B54A
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 17:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A4052872AB
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 16:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1BE6EF1D;
	Wed, 28 Feb 2024 16:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CwZMiiJb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0540F1E480
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 16:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709138990; cv=none; b=LsPqhezU6EYFNsudQzZ2ivPROn/twsE64mLgTm6S1j5NJlxKGcX+D0Zt7VNA5ceb8FugnBBKG1gM5VUhqB+9HSDDj4te9/AQ6F+USqrT5jfBhSGMlCOwtKWk0M4vEHzILWjCDJnyOHKP8drq5qesMV6K4M3tms2CPEeTbLizoXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709138990; c=relaxed/simple;
	bh=RC2/C7dIFLKqzmn+THpHN0wWBIwYLE0s6HUW+850doE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WH1BzSpmjeEEr77Ueu0xZg3dJbi1WmPUyZiZYikmpJeEEhG/iEb3Kpspe9I6xwzDHxdrSiPI+mJOhN5c7zCtxnXK7XJjjiUvij7MfPEpGBckDJy0dm2QhuqfnLxSC3e3epi2o+YpNHNFQuUwsXBI/9BMcnl95BuAE/+IobP8fh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CwZMiiJb; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e571666829so369910b3a.3
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 08:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709138987; x=1709743787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GB8dmEHBlPEV7dcCibRNA3/X5BQxldRotOhF5pkuA1M=;
        b=CwZMiiJbx1IJkdRMtyIvSkqP+D9LFSMgq97DsU/+2lA5FOzHwqFTSIURSMzZzMPWx0
         fYNKl6XLhiEiARz3viCKUsxrdDppuRgwMZou7+Fwq2wb7MPp044w6u0Cpx8D3ZGsuHiO
         YQm5wej1llTZr3Z4hzxdiNVMiV/HfVfA1b/IZ3v7ifd06xZy0fAuv192/CpDx3i9kMwR
         Wmjscp17PH3r8UU2YbftOohPSGmnXXJnO9mVIPoN014J7VbQd1IHXJpBSZ9dJkCYnZ9N
         TyGJxTn5vYaub5ek2ILYbXCgE4RoMmj9uJt/OTZ4WzD3vAeMLsx7RE+2lpIFBOaDyfu+
         cw/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709138987; x=1709743787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GB8dmEHBlPEV7dcCibRNA3/X5BQxldRotOhF5pkuA1M=;
        b=Z347Kz63OfSv36LSG2K1XpLN4tCbvpjqv1xBuvXs3Q9P/HIznUYGJx3e2UDBwO+KKi
         umAFDFZKyD+YCU5IUZZi+5QHzoxhy/YTT2cZSNVDEdZJaZJzcs+novjRxcBQBCvehfsz
         atplRfDLlv75os+w9TXq8mVxdc6X6KD2a6HsSFW9/iH01GttzH+lcpYtLeKLeeU1ZMiE
         JYLzsQY4BalS/BJQPYzv1ijn7gbd3n8rRipV0YYyTvM/0zRdItKJq1NdarXWSX/XvcFL
         fFHdojR+yRWIpC4CpaC54cF8BsaolAQMOnQGicVmhHkgYuUSOu9D5+JqeVVxqZr66Ey5
         UxTg==
X-Forwarded-Encrypted: i=1; AJvYcCXChTNLVcZpIMnp/19KH0AY0sG+iPMHyqzBIABb8siRYp2dMAaXyD1jY+DOzo98ZdX3Vfu2Vx+1/I0qD4fUB8S6Ypca+tOI
X-Gm-Message-State: AOJu0YxbhWlkNsKtexsk/L389yhgvgcotl0lMIJfYURh5byveoTNUPd2
	2pJ3QGV1lWqzVumUz7My8JxsTXK8aRYT6+C/0TJBHb30/f/H7OSdOjYhjYMzWVE=
X-Google-Smtp-Source: AGHT+IEMhsGY1corUuIEvrk6CUGDyqNnRUFtnKSIYJRr2qhYVgdGwxCKbkvGGVjglTc8e+MD0fHRsQ==
X-Received: by 2002:a17:902:e98b:b0:1dc:2f63:dfc6 with SMTP id f11-20020a170902e98b00b001dc2f63dfc6mr11941963plb.53.1709138987248;
        Wed, 28 Feb 2024 08:49:47 -0800 (PST)
Received: from localhost.localdomain ([124.123.186.80])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902728500b001da34166cd2sm3518567pll.180.2024.02.28.08.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 08:49:46 -0800 (PST)
From: Naresh Kamboju <naresh.kamboju@linaro.org>
To: kuba@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	jhs@mojatatu.com,
	kernel@mojatatu.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	pctammela@mojatatu.com,
	victor@mojatatu.com,
	xiyou.wangcong@gmail.com,
	lkft-triage@lists.linaro.org,
	anders.roxell@linaro.org,
	Linux Kernel Functional Testing <lkft@linaro.org>
Subject: Re: [PATCH net-next] selftests: tc-testing: add mirred to block tdc tests
Date: Wed, 28 Feb 2024 22:19:39 +0530
Message-Id: <20240228164939.150403-1-naresh.kamboju@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240206075950.47d0bdc7@kernel.org>
References: <20240206075950.47d0bdc7@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LKFT tests running kselftests tc-testing noticing following run time errors
on Linux next master branch.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

This is started from Linux next-20240212 with following commit,

f51470c5c4a0 selftests: tc-testing: add mirred to block tdc tests

Run log errors:
----------
# Test e684: Delete batch of 32 mirred mirror ingress actions
# multiprocessing.pool.RemoteTraceback: 
# """
# Traceback (most recent call last):
#   File "/opt/kselftests/default-in-kernel/tc-testing/./tdc.py", line 142, in call_pre_case
#     pgn_inst.pre_case(caseinfo, test_skip)
#   File "/opt/kselftests/default-in-kernel/tc-testing/plugin-lib/nsPlugin.py", line 63, in pre_case
#     self.prepare_test(test)
#   File "/opt/kselftests/default-in-kernel/tc-testing/plugin-lib/nsPlugin.py", line 36, in prepare_test
#     self._nl_ns_create()
#   File "/opt/kselftests/default-in-kernel/tc-testing/plugin-lib/nsPlugin.py", line 130, in _nl_ns_create
#     ip.link('add', ifname=dev1, kind='veth', peer={'ifname': dev0, 'net_ns_fd':'/proc/1/ns/net'})
#   File "/usr/lib/python3/dist-packages/pyroute2/iproute/linux.py", line 1593, in link
#     ret = self.nlm_request(msg, msg_type=msg_type, msg_flags=msg_flags)
#           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#   File "/usr/lib/python3/dist-packages/pyroute2/netlink/nlsocket.py", line 403, in nlm_request
#     return tuple(self._genlm_request(*argv, **kwarg))
#            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#   File "/usr/lib/python3/dist-packages/pyroute2/netlink/nlsocket.py", line 985, in nlm_request
#     for msg in self.get(
#                ^^^^^^^^^
#   File "/usr/lib/python3/dist-packages/pyroute2/netlink/nlsocket.py", line 406, in get
#     return tuple(self._genlm_get(*argv, **kwarg))
#            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#   File "/usr/lib/python3/dist-packages/pyroute2/netlink/nlsocket.py", line 770, in get
#     raise msg['header']['error']
# pyroute2.netlink.exceptions.NetlinkError: (34, 'Numerical result out of range')
# 
# During handling of the above exception, another exception occurred:
# 
# Traceback (most recent call last):
#   File "/usr/lib/python3.11/multiprocessing/pool.py", line 125, in worker
#     result = (True, func(*args, **kwds))
#                     ^^^^^^^^^^^^^^^^^^^
#   File "/usr/lib/python3.11/multiprocessing/pool.py", line 48, in mapstar
#     return list(map(*args))
#            ^^^^^^^^^^^^^^^^
#   File "/opt/kselftests/default-in-kernel/tc-testing/./tdc.py", line 602, in __mp_runner
#     (_, tsr) = test_runner(mp_pm, mp_args, tests)
#                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#   File "/opt/kselftests/default-in-kernel/tc-testing/./tdc.py", line 536, in test_runner
#     res = run_one_test(pm, args, index, tidx)
#           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#   File "/opt/kselftests/default-in-kernel/tc-testing/./tdc.py", line 419, in run_one_test
#     pm.call_pre_case(tidx)
#   File "/opt/kselftests/default-in-kernel/tc-testing/./tdc.py", line 146, in call_pre_case
#     print('test_ordinal is {}'.format(test_ordinal))
#                                       ^^^^^^^^^^^^
# NameError: name 'test_ordinal' is not defined
# """
# 
# The above exception was the direct cause of the following exception:
# 
# Traceback (most recent call last):
#   File "/opt/kselftests/default-in-kernel/tc-testing/./tdc.py", line 1028, in <module>
#     main()
#   File "/opt/kselftests/default-in-kernel/tc-testing/./tdc.py", line 1022, in main
#     set_operation_mode(pm, parser, args, remaining)
#   File "/opt/kselftests/default-in-kernel/tc-testing/./tdc.py", line 964, in set_operation_mode
#     catresults = test_runner_mp(pm, args, alltests)
#                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#   File "/opt/kselftests/default-in-kernel/tc-testing/./tdc.py", line 624, in test_runner_mp
#     pres = p.map(__mp_runner, batches)
#            ^^^^^^^^^^^^^^^^^^^^^^^^^^^
#   File "/usr/lib/python3.11/multiprocessing/pool.py", line 367, in map
#     return self._map_async(func, iterable, mapstar, chunksize).get()
#            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#   File "/usr/lib/python3.11/multiprocessing/pool.py", line 774, in get
#     raise self._value
# NameError: name 'test_ordinal' is not defined
not ok 1 selftests: tc-testing: tdc.sh # exit=1


--
Linaro LKFT
https://lkft.linaro.org



