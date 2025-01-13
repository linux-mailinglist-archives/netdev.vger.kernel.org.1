Return-Path: <netdev+bounces-157828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7F1A0BED5
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 18:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BF66164980
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 17:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91B11AB6FF;
	Mon, 13 Jan 2025 17:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="atSiwkqL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C34C4D8CE
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 17:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736789293; cv=none; b=JB1MJkzIWioUcXeCsYTWgziXi3BVvMEKV578+zqeQy7D05W4Y2E7wAe18+y27jb3CbaUgVMK0Z6NNORresE43hK/stOhYfOC6U8/WLk8zblgZ2DEigTy/2Oq7m/xBsaSMrG6Tb+pCQT+iDaM/1rmfd922aj9oE46EajTC+eaYvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736789293; c=relaxed/simple;
	bh=4R6OOO//kkfqkVHz3WEENUnudyIxc1CTzdel0y44qHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YOVD/gfD73Aj0Esk26Sw5HY9jBa5c3XolifH932NRjJGAWfDq8tIJv7c8oNpDlq+rSi/T0TO4aBcsIVld7Ym+3mO0RSPr+AoYu0T3JSuXI7KKlywbKNGAA2+RdJSrQqZoGzqezznuCiwar9SDMUtOQfio2WbFgfbnRb9139Iy2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=atSiwkqL; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Type:Cc:To:Subject:Message-ID:Date:
	From:In-Reply-To:References:MIME-Version:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6k1DxuH6hSLLcJ0dw0v09Xr5Gq1ZDfGWeotRSpHG7Gc=; t=1736789292; x=1737653292; 
	b=atSiwkqLbSiKc9z5FUJpZJo2d4opbCWJ2pEnRRrPkGo+S7CwO+IZscsWrsTbPKoZoTD3CWGccGz
	Z1jt8FIKLnFSqRcuiBAcecDrxdf2ODK5VEE5TgQuBO6O6pwIoBg1IpFhn017Gy4hGP15wHwVIY81i
	1A87hor9ZIw/IYeDsvU+1lAsuexeK2aENA1z+HYhtd6utm8EuT0RcmOkgNbvxwlyEYeu/AySAiR2+
	8169myx8nt81fgNVB+ZGNJBFr7Yk5KuTMhvGDGFNv3be6s9nWI/MExPBhEA6uxfpkTGbzELZAgVSz
	1ylM+a2ZQ4VM93rea8TJRrwb5zYv1MXvvdNQ==;
Received: from mail-oa1-f49.google.com ([209.85.160.49]:50558)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tXOEU-00051c-5C
	for netdev@vger.kernel.org; Mon, 13 Jan 2025 09:28:11 -0800
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2adc2b6837eso612208fac.1
        for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 09:28:10 -0800 (PST)
X-Gm-Message-State: AOJu0Ywfy87vNGlF6zK8jDFHwCx978fJmwLkyFAK4EDcik0HG2FpDu4Z
	H/HTMKaipdsPtEk5Yfu4CsCw7wTNl2POWE0ml+lJEzL93flz7pSBIb3EnraiEAh5sEKbNOD/w/t
	sx09f/UULGqwTz4TbFC+btgKS7KM=
X-Google-Smtp-Source: AGHT+IG9FqU5LIu4AnJall3UKfzx+B2cKQuqiI6C0G5QDw6JKenvjKc/YcJptViM162FpmMIkGODfcGCw7Yv8+NfL3E=
X-Received: by 2002:a05:6870:5488:b0:29e:76d1:db4b with SMTP id
 586e51a60fabf-2aa06668ff8mr13815111fac.6.1736789289572; Mon, 13 Jan 2025
 09:28:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106181219.1075-1-ouster@cs.stanford.edu>
In-Reply-To: <20250106181219.1075-1-ouster@cs.stanford.edu>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Mon, 13 Jan 2025 09:27:34 -0800
X-Gmail-Original-Message-ID: <CAGXJAmxyNRfJp9UemEdVpxegf1bnK5eBMYe5etmUoS-kZd98vg@mail.gmail.com>
X-Gm-Features: AbW1kvZ8qpKYS4Ql366sE0k8OqijAWZwa1XxhTnVNXmB0sdPTt8_LPSo2RmoeGM
Message-ID: <CAGXJAmxyNRfJp9UemEdVpxegf1bnK5eBMYe5etmUoS-kZd98vg@mail.gmail.com>
Subject: Re: [PATCH net-next v5 00/12] Begin upstreaming Homa transport protocol
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com, edumazet@google.com, horms@kernel.org, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: 3912120d3a1bcf28d29a6770933a4e79

The Patchwork Web page for this patch set
(https://patchwork.kernel.org/project/netdevbpf/list/?series=922654&state=*)
is showing errors for the "netdev/contest" context for each of the
patches in the series. The errors are the same for each patch, and
they seem to be coming from places other than Homa. For example, I am
including below the error output for the bpf-offload-py test; I can't
find anything related to Homa in the test output. Is there something I
need to worry about here? BTW, one of the tests (coccicheck) did
produce a warning about Homa unnecessarily casting the output of a
kmalloc call; I have fixed that one.

make -C tools/testing/selftests TARGETS="net"
TEST_PROGS=bpf_offload.py TEEST_GEN_PROGS="" run_tests
make: Entering directory '/home/virtme/testing-3/tools/testing/selftests'
make[1]: Entering directory '/home/virtme/testing-3/tools/testing/selftests/net'
make[1]: Nothing to be done for 'all'.
make[1]: Leaving directory '/home/virtme/testing-3/tools/testing/selftests/net'
make[1]: Entering directory '/home/virtme/testing-3/tools/testing/selftests/net'
TAP version 13
1..1
# overriding timeout to 7200
# selftests: net: bpf_offload.py
# 12.84 [+12.84] Test destruction of generic XDP...
# 12.84 [+0.00] Traceback (most recent call last):
# 12.85 [+0.00]   File
"/home/virtme/testing-3/tools/testing/selftests/net/./bpf_offload.py",
line 749, in <module>
# 12.85 [+0.00]     simdev = BpfNetdevSimDev()
# 12.85 [+0.00]   File
"/home/virtme/testing-3/tools/testing/selftests/net/./bpf_offload.py",
line 347, in __init__
# 12.86 [+0.01]     super().__init__(port_count, ns=ns)
# 12.86 [+0.00]   File
"/home/virtme/testing-3/tools/testing/selftests/net/lib/py/nsim.py",
line 87, in __init__
# 12.86 [+0.00]     self.nsims.append(self._make_port(port_index,
ifnames[port_index]))
# 12.87 [+0.00]   File
"/home/virtme/testing-3/tools/testing/selftests/net/./bpf_offload.py",
line 351, in _make_port
# 12.87 [+0.00]     return BpfNetdevSim(self, port_index, ifname, self.ns)
# 12.87 [+0.00]   File
"/home/virtme/testing-3/tools/testing/selftests/net/./bpf_offload.py",
line 380, in __init__
# 12.88 [+0.00]     self.dfs_refresh()
# 12.88 [+0.00]   File
"/home/virtme/testing-3/tools/testing/selftests/net/./bpf_offload.py",
line 389, in dfs_refresh
# 12.88 [+0.00]     self.dfs = DebugfsDir(self.dfs_dir)
# 12.88 [+0.00]   File
"/home/virtme/testing-3/tools/testing/selftests/net/./bpf_offload.py",
line 290, in __init__
# 12.89 [+0.00]     self._dict = self._debugfs_dir_read(path)
# 12.89 [+0.00]   File
"/home/virtme/testing-3/tools/testing/selftests/net/./bpf_offload.py",
line 329, in _debugfs_dir_read
# 12.89 [+0.00]     _, out = cmd('cat %s/%s' % (path, f))
# 12.89 [+0.00]   File
"/home/virtme/testing-3/tools/testing/selftests/net/./bpf_offload.py",
line 112, in cmd
# 12.89 [+0.00]     return cmd_result(proc,
include_stderr=include_stderr, fail=fail)
# 12.90 [+0.00]   File
"/home/virtme/testing-3/tools/testing/selftests/net/./bpf_offload.py",
line 134, in cmd_result
# 12.90 [+0.00]     raise Exception("Command failed: %s\n%s" %
(proc.args, stderr))
# 12.90 [+0.00] Exception: Command failed: cat
/sys/kernel/debug/netdevsim/netdevsim22122//ports/0//queue_reset
# 12.90 [+0.00]
# 12.90 [+0.00] cat:
/sys/kernel/debug/netdevsim/netdevsim22122//ports/0//queue_reset:
Invalid argument
not ok 1 selftests: net: bpf_offload.py # exit=1
make[1]: Leaving directory '/home/virtme/testing-3/tools/testing/selftests/net'
make: Leaving directory '/home/virtme/testing-3/tools/testing/selftests'
xx__-> echo $?
0
xx__-> echo scan > /sys/kernel/debug/kmemleak && cat /sys/kernel/debug/kmemleak
xx__->

