Return-Path: <netdev+bounces-161876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB79A24593
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 00:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A08B53A63AC
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 23:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944E51B21B9;
	Fri, 31 Jan 2025 23:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E56eFF1n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE404165F1D
	for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 23:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738365184; cv=none; b=n8P51C3fPurWbNbe1cc9ATrH1JWVZyDlsQSDU3rRAVeO+iD8ZwqD/GnIzEiyoeSU3zvgUl31AskRYFBLkCFTRogFZ3sm7R23jbAbt7wj16QmpZFd3h92tIki9xNMCIEHRjCC5K1PYWL22+EGMZTzvg5x6uyO296wyDRO+Fxsmhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738365184; c=relaxed/simple;
	bh=cMITw3dF4OxsL7ZuzfmnDzJTP4O3bgYL84hpwsx1Fp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=enlhlXe5dq+K9ORmmSje+o0VuSvf0VdkdJXe6pd7P9DokNriUQhuP41kiGt4D7PkETe64A0KobISQcaiM3Bp4d2IEHAht0glfKy1SNDiXa6Kn2BKXZxcRuf2frDwSEhZAnScUx9cdkNZRObmntxBMMa5os65BsySSVFOoxg9Vfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E56eFF1n; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2167141dfa1so45490075ad.1
        for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 15:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738365182; x=1738969982; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3zpCRAux+47xfrAV5Yp1f0fD/gT89DpynwaFMwh+EOo=;
        b=E56eFF1nq0Uav2L1esQC6Asv+OLyWfIxkJsDzKiNMHUk8uvN+JS5nW535jYkMp55h2
         LHBe5Q/qSCLFjqZtVwHNkVQ1vIn9FMaJ3epb/eAqRZVMC/rdoIUmUQcymeNDOANe2AaY
         XA8eAg5+1nzRyXKvqbFQ1m+3ISHC51EYYzHYO9WDdd/Ym56U0ZQ6Lzo5e66FW52LbuR9
         C+EKkXIabtTCaRrmzZisKdD6Wg0wGtT3g5b55xTj/wlgVQbACnHsMggb8VE25XQ0UZ9j
         3s7SfJE40F4AB3nJu+HS6MUGt9zw7hW6lxESCwvE7WJyPfdemlC/bvFfiyBQSTRKOGlr
         eikQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738365182; x=1738969982;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3zpCRAux+47xfrAV5Yp1f0fD/gT89DpynwaFMwh+EOo=;
        b=fbzl9rC5fOkKgue/3grSVaryHp5z2owtnqCRk449Yvewe7NU6uDpMIRgn95N6t9tKO
         DdYpp+xpEK7ixP1a2caScS4yOXjUwBJ1DE+K75GTtRgOGTVU9NgXpRDHmUKBSSY1J12J
         c4RTYglhdz8MNIQDE8nKDFfR8uA7sgPu+VNXHlqUup1mXAgqYvF8kEfx25TFLcqz4LwS
         rsgw/0/EhqOGe2aWwQGBNdxsiKMY+dKrDnD1G2oY2hGik5dwxP/cfRK9LnmVm5/Qkr8O
         xxQAQCAGaUrfj1R/VVGsuI/dOBDxujKpq5znT6/lqIrEY0XUUbwCHlIGPPC/f3Ck5afz
         zj8g==
X-Gm-Message-State: AOJu0YxXSvIZ4zi+UuzKI73R3dfmd+5Ttn96ckbh89SDaIyWfwRIxQ77
	jRVLDnHiPyyYyAdjF4mN5mBgWOgcvTpgC1I30Oh0Kqh9Xgp4JplOl994+Q==
X-Gm-Gg: ASbGncuW9MMltHcgJg6kjvGVkSHKxPzQ82R7c6AZEATRJuIL+anKyOdaMeDLAicAS7U
	uKCncvLzB73a0q0T/fL98GrDKDCam0W0rLM/N9KVrqh97joB4m+n5UsgP82W/92VgaLDfX2rPR1
	gtd/heb26G8CFlW60Mar/P/xsmNLQZ2NGQ3CAW4QlMJv7Pc2t65YJ8UMFu11OLO8XiVd5cq5IQ7
	gExfLVM+AT7m5XIvtvqPweK1Peockrjv3aW67tuzBXG9Y6z7LTS6z7MFFda168cu+nJosfzeNtq
	Wl9v9TDgiS18fnMoIZF4
X-Google-Smtp-Source: AGHT+IFMBz7o+Cd9/aFtoGJQtUDPzXWn2ICrMiB9AKxiIqBL9NJctOIjw0nKfrnl2ihrCwhbQSUXyg==
X-Received: by 2002:a17:903:120a:b0:216:3f6e:fabd with SMTP id d9443c01a7336-21edd7eafccmr70785055ad.7.1738365181820;
        Fri, 31 Jan 2025 15:13:01 -0800 (PST)
Received: from localhost ([2601:647:6881:9060:9ca:6511:2ce0:8788])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de31efba5sm35395995ad.6.2025.01.31.15.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 15:13:01 -0800 (PST)
Date: Fri, 31 Jan 2025 15:13:00 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
	quanglex97@gmail.com, mincho@theori.io,
	Cong Wang <cong.wang@bytedance.com>
Subject: Re: [Patch net v2 2/4] selftests/tc-testing: Add a test case for
 pfifo_head_drop qdisc when limit==0
Message-ID: <Z51Y/KlsCyYi5VvB@pop-os.localdomain>
References: <20250126041224.366350-1-xiyou.wangcong@gmail.com>
 <20250126041224.366350-3-xiyou.wangcong@gmail.com>
 <f49814fb-cd69-4c3b-b8d4-c529a99c10e5@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f49814fb-cd69-4c3b-b8d4-c529a99c10e5@mojatatu.com>

On Tue, Jan 28, 2025 at 08:19:54PM -0300, Pedro Tammela wrote:
> On 26/01/2025 01:12, Cong Wang wrote:
> > From: Quang Le <quanglex97@gmail.com>
> > 
> > When limit == 0, pfifo_tail_enqueue() must drop new packet and
> > increase dropped packets count of the qdisc.
> > 
> > All test results:
> > 
> > 1..16
> > ok 1 a519 - Add bfifo qdisc with system default parameters on egress
> > ok 2 585c - Add pfifo qdisc with system default parameters on egress
> > ok 3 a86e - Add bfifo qdisc with system default parameters on egress with handle of maximum value
> > ok 4 9ac8 - Add bfifo qdisc on egress with queue size of 3000 bytes
> > ok 5 f4e6 - Add pfifo qdisc on egress with queue size of 3000 packets
> > ok 6 b1b1 - Add bfifo qdisc with system default parameters on egress with invalid handle exceeding maximum value
> > ok 7 8d5e - Add bfifo qdisc on egress with unsupported argument
> > ok 8 7787 - Add pfifo qdisc on egress with unsupported argument
> > ok 9 c4b6 - Replace bfifo qdisc on egress with new queue size
> > ok 10 3df6 - Replace pfifo qdisc on egress with new queue size
> > ok 11 7a67 - Add bfifo qdisc on egress with queue size in invalid format
> > ok 12 1298 - Add duplicate bfifo qdisc on egress
> > ok 13 45a0 - Delete nonexistent bfifo qdisc
> > ok 14 972b - Add prio qdisc on egress with invalid format for handles
> > ok 15 4d39 - Delete bfifo qdisc twice
> > ok 16 d774 - Check pfifo_head_drop qdisc enqueue behaviour when limit == 0
> > 
> > Signed-off-by: Quang Le <quanglex97@gmail.com>
> > Signed-off-by: Cong Wang <cong.wang@bytedance.com>
> > ---
> >   .../tc-testing/tc-tests/qdiscs/fifo.json      | 25 +++++++++++++++++++
> >   1 file changed, 25 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fifo.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fifo.json
> > index ae3d286a32b2..94f6456ab460 100644
> > --- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fifo.json
> > +++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fifo.json
> > @@ -313,6 +313,31 @@
> >           "matchPattern": "qdisc bfifo 1: root",
> >           "matchCount": "0",
> >           "teardown": [
> > +	]
> > +    },
> > +    {
> > +        "id": "d774",
> > +        "name": "Check pfifo_head_drop qdisc enqueue behaviour when limit == 0",
> > +        "category": [
> > +            "qdisc",
> > +            "pfifo_head_drop"
> > +        ],
> > +        "plugins": {
> > +            "requires": "nsPlugin"
> > +        },
> > +        "setup": [
> > +            "$IP link add dev $DUMMY mtu 1279 type dummy || true",
> 
> You don't need to manually add or remove a dummy device for tdc anymore.
> The nsPlugin is responsible for it.

Thanks for the hint!

> 
> I ran the suite with both of the tests without the link add/del and it's
> working!
> 
> Can you try it?

I tried it, but I saw the following error. I am not sure whether this
error is related to these patches.

multiprocessing.pool.RemoteTraceback:
# """
# Traceback (most recent call last):
#   File "/usr/lib64/python3.12/multiprocessing/pool.py", line 125, in worker
#     result = (True, func(*args, **kwds))
#                     ^^^^^^^^^^^^^^^^^^^
#   File "/usr/lib64/python3.12/multiprocessing/pool.py", line 48, in mapstar
#     return list(map(*args))
#            ^^^^^^^^^^^^^^^^
#   File "/host/tools/testing/selftests/tc-testing/./tdc.py", line 601, in __mp_runner
#     (_, tsr) = test_runner(mp_pm, mp_args, tests)
#                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#   File "/host/tools/testing/selftests/tc-testing/./tdc.py", line 535, in test_runner
#     res = run_one_test(pm, args, index, tidx)
#           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#   File "/host/tools/testing/selftests/tc-testing/./tdc.py", line 418, in run_one_test
#     pm.call_pre_case(tidx)
#   File "/host/tools/testing/selftests/tc-testing/./tdc.py", line 142, in call_pre_case
#     pgn_inst.pre_case(caseinfo, test_skip)
#   File "/host/tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py", line 63, in pre_case
#     self.prepare_test(test)
#   File "/host/tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py", line 36, in prepare_test
#     self._nl_ns_create()
#   File "/host/tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py", line 130, in _nl_ns_create
#     ip.link('add', ifname=dev1, kind='veth', peer={'ifname': dev0, 'net_ns_fd':'/proc/1/ns/net'})
#   File "/usr/local/lib/python3.12/site-packages/pyroute2/iproute/linux.py", line 1730, in link
#     ret = self.nlm_request(msg, msg_type=msg_type, msg_flags=msg_flags)
#           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#   File "/usr/local/lib/python3.12/site-packages/pyroute2/netlink/nlsocket.py", line 875, in nlm_request
#     return tuple(self._genlm_request(*argv, **kwarg))
#            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#   File "/usr/local/lib/python3.12/site-packages/pyroute2/netlink/nlsocket.py", line 1248, in nlm_request
#     for msg in self.get(
#                ^^^^^^^^^
#   File "/usr/local/lib/python3.12/site-packages/pyroute2/netlink/nlsocket.py", line 878, in get
#     return tuple(self._genlm_get(*argv, **kwarg))
#            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#   File "/usr/local/lib/python3.12/site-packages/pyroute2/netlink/nlsocket.py", line 555, in get
#     raise msg['header']['error']
# pyroute2.netlink.exceptions.NetlinkError: (17, 'File exists')
# """
#
# The above exception was the direct cause of the following exception:
#
# Traceback (most recent call last):
#   File "/host/tools/testing/selftests/tc-testing/./tdc.py", line 1027, in <module>
#     main()
#   File "/host/tools/testing/selftests/tc-testing/./tdc.py", line 1021, in main
#     set_operation_mode(pm, parser, args, remaining)
#   File "/host/tools/testing/selftests/tc-testing/./tdc.py", line 963, in set_operation_mode
#     catresults = test_runner_mp(pm, args, alltests)
#                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#   File "/host/tools/testing/selftests/tc-testing/./tdc.py", line 623, in test_runner_mp
#     pres = p.map(__mp_runner, batches)
#            ^^^^^^^^^^^^^^^^^^^^^^^^^^^
#   File "/usr/lib64/python3.12/multiprocessing/pool.py", line 367, in map
#     return self._map_async(func, iterable, mapstar, chunksize).get()
#            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#   File "/usr/lib64/python3.12/multiprocessing/pool.py", line 774, in get
#     raise self._value
# pyroute2.netlink.exceptions.NetlinkError: (17, 'File exists')


