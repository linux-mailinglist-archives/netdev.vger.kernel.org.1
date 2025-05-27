Return-Path: <netdev+bounces-193706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E41AC5262
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 17:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 727DF9E03BB
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 15:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B32627C84C;
	Tue, 27 May 2025 15:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aptwLjIz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B99269833
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 15:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748361326; cv=none; b=KqjIf72Bq0meEcpcWb5yAhKrZ9qXhG6wOrUgFwG3CqXQML3l/Ms+MnWi82jDzBhdfCrU4ufEW7GWT4AKdH3ws2ymJ8+UMiluI5U75f76t4qqClWkoRuFKi4sna04+2crZ5ykIdfk+3ygsl8PC5aSBBr5iJt8kQ7/DSNjs60PbyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748361326; c=relaxed/simple;
	bh=IooNweYioThGUT8ZOiX1XzvjjfrhAJn0Sd6ftIx9E+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=koEl9g2DLrZoL+tJX20mMB/GeCzEHDW55ZmpAuCg/ZeQTJOoz4/5opW2SCYeY3ZI70cIy8uSDGDySLuruGx0UaWEs1GOGdLyX7u8fWHaMhtOq6KiVY8LwqSR1nhLUUhb8E/fKm3uk+rTTqi7X4isuMZQJDBo0DbeyiLyTd8gyXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aptwLjIz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748361322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wb8/uzIi16fAJXtQ9hucGUiGMDmIuuatlVp8gYmB16c=;
	b=aptwLjIzZvVn64JztSEj6Of+hR9D6AE4VDiDHTb+GY/SaD0w9Q+C6OgjKxa3PLVn+oF5QV
	WbEPgH1ePhbJN4WuoLXPlanLu2Gdm8Uu2Gm3OpoiJDPJjmzpSIEZ4G5A4KT3RlYCe+nFaV
	noP8mBlvBjmKYCTr4MdAvratndxbjxc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-MPcfTLKLPAi863BvJ-5dfg-1; Tue, 27 May 2025 11:55:21 -0400
X-MC-Unique: MPcfTLKLPAi863BvJ-5dfg-1
X-Mimecast-MFC-AGG-ID: MPcfTLKLPAi863BvJ-5dfg_1748361320
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-6047edc5cebso2699397a12.1
        for <netdev@vger.kernel.org>; Tue, 27 May 2025 08:55:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748361320; x=1748966120;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wb8/uzIi16fAJXtQ9hucGUiGMDmIuuatlVp8gYmB16c=;
        b=cyy9xXArVyCwuMPsPTxi/j0Fo9jHTop2E7ezPe6EoSdwlgrlUFwDk3KvVZOtw4d7vo
         It9qGjAz+sFFxJjP4Rx2c+GNb1DS+xMamk/FAFEqxIYJQA29ztZ/wLbmXBpiWVGGo8PA
         K5WvVXxdkXYbZC9i59gS6ZPT6pp9VN9gIdhTFqQxooYcnUVMygbjeldlagJLa4f0mqQN
         s+xMykF5kTX/sPRTNltrQsQwqjc4UhRaycjKVuDfVqfDeteseyffzZHGnpeEin02kpzL
         xZd665gw8GwmyG21ky/vQSRACOgHjFSZc2UjK7uiu61RSugUGxIUj5zKqgHrjy0TUpAG
         N/9g==
X-Forwarded-Encrypted: i=1; AJvYcCXu7jKyd4amCM8zSi6p1i5uSQsRXm8/+mtSxYeDyla+y9Df9pMG0LEfuv8tddKRo2OblyNxrX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMl+IMNA1SCRc2ltTwoY3j4TNsHLXBh5xHWx5He4X8Gwa1dvL9
	u0xlkIbEMbZaq4yXXy9/zpEX5JlXZtT+APO73Ul8K39dTjXNiFM9Ghl1FdK3dH4rxKB+pa2UeW6
	NmIlSWFFW2OFAzRrAl28CVibhh7aPxTYDAr2+JlpNMLBmndWx17QFVvj66A==
X-Gm-Gg: ASbGncuQT9eeqPjy0p2Uj4lSD7nLof8w9+lgItYa52rhcgXEFxEnttzqpNX8jllsN8M
	SvaISSjUJ/+ozpWmmWZsQGOWp6bJkiHVTR96egLBreCQvA74/DEONdhcQUpknc1eMaCmvCWZDKZ
	7/ui1Q5PM7hjyyvo7izf6JIAWzKLAwT9J9DEnd4lGuTHeTJIuSJ8/mo1dr8J3HiuDV825k3y/N+
	/zKPWupCBm23c9kzZ/0ZMI+e3V4pzivf2hZzZb+YXP71k3IICUJajnATJIRvoF18i/ZJ5Ykh1fB
	hs71EDpRtqTK5tlIL1n16b3Nv3vzPsBLDrR+H0Rca24g3LBf4Bb1r5uzv1fS
X-Received: by 2002:a17:907:2ce4:b0:ad5:7234:e4a9 with SMTP id a640c23a62f3a-ad85b1300d0mr1255524766b.28.1748361319387;
        Tue, 27 May 2025 08:55:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENGDDVZ4asqZqtXTsQ2gw0NrLKQ1ZAzCAtVfopIjbSKMMjc6DGQBSFxH6caBgoySG+L0hShQ==
X-Received: by 2002:a17:907:2ce4:b0:ad5:7234:e4a9 with SMTP id a640c23a62f3a-ad85b1300d0mr1255520566b.28.1748361318653;
        Tue, 27 May 2025 08:55:18 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-35.retail.telecomitalia.it. [82.53.134.35])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad8977b36a9sm53081366b.70.2025.05.27.08.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 08:55:18 -0700 (PDT)
Date: Tue, 27 May 2025 17:55:13 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	kvm@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v8] selftests/vsock: add initial vmtest.sh for
 vsock
Message-ID: <tabqpll3r76jhx2ujayry25a7ujfsikm7tejv5sviayyojlmwz@amcchbc5xiqp>
References: <20250522-vsock-vmtest-v8-1-367619bef134@gmail.com>
 <ta2ub5v7txhobccgvpnwsz7cyzcnx6aw74cjlcviosjetuwfhh@7gdahptdpbnd>
 <aDXMhbqhhUAMe0Oz@devbig793.prn5.facebook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aDXMhbqhhUAMe0Oz@devbig793.prn5.facebook.com>

On Tue, May 27, 2025 at 07:30:29AM -0700, Bobby Eshleman wrote:
>On Mon, May 26, 2025 at 01:18:18PM +0200, Stefano Garzarella wrote:
>> On Thu, May 22, 2025 at 09:59:07PM -0700, Bobby Eshleman wrote:
>> > This commit introduces a new vmtest.sh runner for vsock.
>> >
>> > It uses virtme-ng/qemu to run tests in a VM. The tests validate G2H,
>> > H2G, and loopback. The testing tools from tools/testing/vsock/ are
>> > reused. Currently, only vsock_test is used.
>> >
>> > VMCI and hyperv support is included in the config file to be built with
>> > the -b option, though not used in the tests.
>> >
>> > Only tested on x86.
>> >
>> > To run:
>> >
>> >  $ make -C tools/testing/selftests TARGETS=vsock
>> >  $ tools/testing/selftests/vsock/vmtest.sh
>> >
>> > or
>> >
>> >  $ make -C tools/testing/selftests TARGETS=vsock run_tests
>> >
>> > Example runs (after make -C tools/testing/selftests TARGETS=vsock):
>> >
>> > $ ./tools/testing/selftests/vsock/vmtest.sh
>> > 1..3
>> > ok 0 vm_server_host_client
>> > ok 1 vm_client_host_server
>> > ok 2 vm_loopback
>> > SUMMARY: PASS=3 SKIP=0 FAIL=0
>> > Log: /tmp/vsock_vmtest_m7DI.log
>> >
>> > $ ./tools/testing/selftests/vsock/vmtest.sh vm_loopback
>> > 1..1
>> > ok 0 vm_loopback
>> > SUMMARY: PASS=1 SKIP=0 FAIL=0
>> > Log: /tmp/vsock_vmtest_a1IO.log
>> >
>> > $ mkdir -p ~/scratch
>> > $ make -C tools/testing/selftests install TARGETS=vsock INSTALL_PATH=~/scratch
>> > [... omitted ...]
>> > $ cd ~/scratch
>> > $ ./run_kselftest.sh
>> > TAP version 13
>> > 1..1
>> > # timeout set to 300
>> > # selftests: vsock: vmtest.sh
>> > # 1..3
>> > # ok 0 vm_server_host_client
>> > # ok 1 vm_client_host_server
>> > # ok 2 vm_loopback
>> > # SUMMARY: PASS=3 SKIP=0 FAIL=0
>> > # Log: /tmp/vsock_vmtest_svEl.log
>> > ok 1 selftests: vsock: vmtest.sh
>> >
>> > Future work can include vsock_diag_test.
>> >
>> > Because vsock requires a VM to test anything other than loopback, this
>> > patch adds vmtest.sh as a kselftest itself. This is different than other
>> > systems that have a "vmtest.sh", where it is used as a utility script to
>> > spin up a VM to run the selftests as a guest (but isn't hooked into
>> > kselftest).
>> >
>> > Signed-off-by: Bobby Eshleman <bobbyeshleman@gmail.com>
>> > ---
>> > Changes in v8:
>> > - remove NIPA comment from commit msg
>> > - remove tap_* functions and TAP_PREFIX
>> > - add -b for building kernel
>> > - Link to v7: https://lore.kernel.org/r/20250515-vsock-vmtest-v7-1-ba6fa86d6c2c@gmail.com
>> >
>> > Changes in v7:
>> > - fix exit code bug when ran is kselftest: use cnt_total instead of KSFT_NUM_TESTS
>> > - updated commit message with updated output
>> > - updated commit message with commands for installing/running as
>> >  kselftest
>> > - Link to v6: https://lore.kernel.org/r/20250515-vsock-vmtest-v6-1-9af1cc023900@gmail.com
>> >
>> > Changes in v6:
>> > - add make cmd in commit message in vmtest.sh example (Stefano)
>> > - check nonzero size of QEMU_PIDFILE using -s conditional (Stefano)
>> > - display log file path after tests so it is easier to find amongst other random names
>> > - cleanup qemu pidfile if qemu is unable to remove it
>> > - make oops/warning failures more obvious with 'FAIL' prefix in log
>> >  (simply saying 'detected' wasn't clear enough to identify failing
>> >  condition)
>> > - Link to v5: https://lore.kernel.org/r/20250513-vsock-vmtest-v5-1-4e75c4a45ceb@gmail.com
>> >
>> > Changes in v5:
>> > - make log file a tmpfile (Paolo)
>> > - make sure both default and user defined QEMU gets handled by the dependency check (Paolo)
>> > - increased VM boot up timeout from 1m to 3m for slow hosts (Paolo)
>> > - rename vm_setup -> vm_start (Paolo)
>> > - derive wait_for_listener from selftests/net/net_helper.sh to removes ss usage
>> > - Remove unused 'unset IFS' line (Paolo)
>> > - leave space after variable declarations (Paolo)
>> > - make QEMU_PIDFILE a tmp file (Paolo)
>> > - make everything readonly that is only read (Paolo)
>> > - source ktap_helpers.sh for KSFT_PASS and friends (Paolo)
>> > - don't check for timeout util (Paolo)
>> > - add missing usage string for -q qemu arg
>> > - add tap prefix to SUMMARY line since it isn't part of TAP protocol
>> > - exit with the correct status code based on failure/pass counts
>> > - Link to v4: https://lore.kernel.org/r/20250507-vsock-vmtest-v4-1-6e2a97262cd6@gmail.com
>> >
>> > Changes in v4:
>> > - do not use special tab delimiter for help string parsing (Stefano + Paolo)
>> > - fix paths for when installing kselftest and running out-of-tree (Paolo)
>> > - change vng to using running kernel instead of compiled kernel (Paolo)
>> > - use multi-line string for QEMU_OPTS (Stefano)
>> > - change timeout to 300s (Paolo)
>> > - skip if tools are not found and use kselftests status codes (Paolo)
>> > - remove build from vmtest.sh (Paolo)
>> > - change 2222 -> SSH_HOST_PORT (Stefano)
>> > - add tap-format output
>> > - add vmtest.log to gitignore
>> > - check for vsock_test binary and remind user to build it if missing
>> > - create a proper build in makefile
>> > - style fixes
>> > - add ssh, timeout, and pkill to dependency check, just in case
>> > - fix numerical comparison in conditionals
>> > - check qemu pidfile exists before proceeding (avoid wasting time waiting for ssh)
>> > - fix tracking of pass/fail bug
>> > - fix stderr redirection bug
>> > - Link to v3: https://lore.kernel.org/r/20250428-vsock-vmtest-v3-1-181af6163f3e@gmail.com
>> >
>> > Changes in v3:
>> > - use common conditional syntax for checking variables
>> > - use return value instead of global rc
>> > - fix typo TEST_HOST_LISTENER_PORT -> TEST_HOST_PORT_LISTENER
>> > - use SIGTERM instead of SIGKILL on cleanup
>> > - use peer-cid=1 for loopback
>> > - change sleep delay times into globals
>> > - fix test_vm_loopback logging
>> > - add test selection in arguments
>> > - make QEMU an argument
>> > - check that vng binary is on path
>> > - use QEMU variable
>> > - change <tab><backslash> to <space><backslash>
>> > - fix hardcoded file paths
>> > - add comment in commit msg about script that vmtest.sh was based off of
>> > - Add tools/testing/selftest/vsock/Makefile for kselftest
>> > - Link to v2: https://lore.kernel.org/r/20250417-vsock-vmtest-v2-1-3901a27331e8@gmail.com
>> >
>> > Changes in v2:
>> > - add kernel oops and warnings checker
>> > - change testname variable to use FUNCNAME
>> > - fix spacing in test_vm_server_host_client
>> > - add -s skip build option to vmtest.sh
>> > - add test_vm_loopback
>> > - pass port to vm_wait_for_listener
>> > - fix indentation in vmtest.sh
>> > - add vmci and hyperv to config
>> > - changed whitespace from tabs to spaces in help string
>> > - Link to v1: https://lore.kernel.org/r/20250410-vsock-vmtest-v1-1-f35a81dab98c@gmail.com
>> > ---
>> > MAINTAINERS                              |   1 +
>> > tools/testing/selftests/vsock/.gitignore |   2 +
>> > tools/testing/selftests/vsock/Makefile   |  16 ++
>> > tools/testing/selftests/vsock/config     | 114 ++++++++
>> > tools/testing/selftests/vsock/settings   |   1 +
>> > tools/testing/selftests/vsock/vmtest.sh  | 460 +++++++++++++++++++++++++++++++
>> > 6 files changed, 594 insertions(+)
>> >
>> > diff --git a/MAINTAINERS b/MAINTAINERS
>> > index 657a67f9031ef7798c19ac63e6383d4cb18a9e1f..3fbdd7bbfce7196a3cc7db70203317c6bd0e51fd 100644
>> > --- a/MAINTAINERS
>> > +++ b/MAINTAINERS
>> > @@ -25751,6 +25751,7 @@ F:	include/uapi/linux/vm_sockets.h
>> > F:	include/uapi/linux/vm_sockets_diag.h
>> > F:	include/uapi/linux/vsockmon.h
>> > F:	net/vmw_vsock/
>> > +F:	tools/testing/selftests/vsock/
>> > F:	tools/testing/vsock/
>> >
>> > VMALLOC
>> > diff --git a/tools/testing/selftests/vsock/.gitignore b/tools/testing/selftests/vsock/.gitignore
>> > new file mode 100644
>> > index 0000000000000000000000000000000000000000..9c5bf379480f829a14713d5f5dc7d525bc272e84
>> > --- /dev/null
>> > +++ b/tools/testing/selftests/vsock/.gitignore
>> > @@ -0,0 +1,2 @@
>> > +vmtest.log
>> > +vsock_test
>> > diff --git a/tools/testing/selftests/vsock/Makefile b/tools/testing/selftests/vsock/Makefile
>> > new file mode 100644
>> > index 0000000000000000000000000000000000000000..7ab4970e5e8a019be33f96a36f95c00573d7bfcf
>> > --- /dev/null
>> > +++ b/tools/testing/selftests/vsock/Makefile
>> > @@ -0,0 +1,16 @@
>> > +# SPDX-License-Identifier: GPL-2.0
>> > +
>> > +CURDIR := $(abspath .)
>> > +TOOLSDIR := $(abspath ../../..)
>> > +
>> > +$(OUTPUT)/vsock_test: $(TOOLSDIR)/testing/vsock/vsock_test
>> > +	install -m 755 $< $@
>> > +
>> > +$(TOOLSDIR)/testing/vsock/vsock_test:
>> > +	$(MAKE) -C $(TOOLSDIR)/testing/vsock vsock_test
>> > +
>> > +TEST_PROGS += vmtest.sh
>> > +TEST_GEN_FILES := vsock_test
>> > +
>> > +include ../lib.mk
>> > +
>>
>> I had modified the tests, but I noticed that they were not copied,
>> in fact we have no dependencies on the test sources.
>>
>> This may not be a problem in the selftest environment, but locally I
>> think it is.
>>
>> We can either use .PHONY and call `$(MAKE) -C ...` each time, or do
>> something like this (which solved my problem):
>>
>> diff --git a/tools/testing/selftests/vsock/Makefile b/tools/testing/selftests/vsock/Makefile
>> index 7ab4970e5e8a..d1bb1f63a9d1 100644
>> --- a/tools/testing/selftests/vsock/Makefile
>> +++ b/tools/testing/selftests/vsock/Makefile
>> @@ -3,11 +3,14 @@
>>  CURDIR := $(abspath .)
>>  TOOLSDIR := $(abspath ../../..)
>> -$(OUTPUT)/vsock_test: $(TOOLSDIR)/testing/vsock/vsock_test
>> +VSOCK_TEST_DIR := $(TOOLSDIR)/testing/vsock
>> +VSOCK_TEST_SRCS := $(wildcard $(VSOCK_TEST_DIR)/*.c $(VSOCK_TEST_DIR)/*.h)
>> +
>> +$(OUTPUT)/vsock_test: $(VSOCK_TEST_DIR)/vsock_test
>>         install -m 755 $< $@
>> -$(TOOLSDIR)/testing/vsock/vsock_test:
>> -       $(MAKE) -C $(TOOLSDIR)/testing/vsock vsock_test
>> +$(VSOCK_TEST_DIR)/vsock_test: $(VSOCK_TEST_SRCS)
>> +       $(MAKE) -C $(VSOCK_TEST_DIR) vsock_test
>>  TEST_PROGS += vmtest.sh
>>  TEST_GEN_FILES := vsock_test
>>
>>
>
>Makes sense!
>
>> > +
>> > +# virtme-ng offers a netdev for ssh when using "--ssh", but we also need a
>> > +# control port forwarded for vsock_test.  Because virtme-ng doesn't support
>> > +# adding an additional port to forward to the device created from "--ssh" and
>> > +# virtme-init mistakenly sets identical IPs to the ssh device and additional
>> > +# devices, we instead opt out of using --ssh, add the device manually, and also
>> > +# add the kernel cmdline options that virtme-init uses to setup the interface.
>>
>> This version of the script doesn't work for me, the VM starts, but I
>> can't connect in ssh. After spending some time debugging, I saw that
>> `sshd` was not being launched inside the VM.
>>
>> I think it depends on the version of vng (maybe recently updated on my
>> Fedora 41); here I have:
>> $ vng --version
>> virtme-ng 1.36
>>
>> Playing around with `vng`, I found that it now also supports ssh on
>> vsock (I think it is now default). By forcing it to use tcp
>> (`vng ... --ssh --ssh-tcp`), it adds another parameter to my cmdline:
>> `virtme_ssh_channel=tcp`.
>>
>> And indeed this change fixed my issues:
>> --- a/tools/testing/selftests/vsock/vmtest.sh
>> +++ b/tools/testing/selftests/vsock/vmtest.sh
>> @@ -39,7 +39,7 @@ readonly QEMU_OPTS="\
>>          -device vhost-vsock-pci,guest-cid=${VSOCK_CID} \
>>          --pidfile ${QEMU_PIDFILE} \
>>  "
>> -readonly KERNEL_CMDLINE="virtme.dhcp net.ifnames=0 biosdevname=0 virtme.ssh virtme_ssh_user=$USER"
>> +readonly KERNEL_CMDLINE="virtme.dhcp net.ifnames=0 biosdevname=0 virtme.ssh virtme_ssh_channel=tcp virtme_ssh_user=$USER"
>>  readonly LOG=$(mktemp /tmp/vsock_vmtest_XXXX.log)
>>  readonly TEST_NAMES=(vm_server_host_client vm_client_host_server vm_loopback)
>>  readonly TEST_DESCS=(
>>
>> That said, I'm concerned about the weakness of assuming the cmdlines
>> supported by vng (which do not seem stable to me at this point).
>>
>> Should we check the version of vng and at least print a warning to say
>> that this script is not tested on that version?
>>
>> Thanks,
>> Stefano
>>
>
>I'm also not a big fan of assuming cmdlines and I think adding the
>version warning sounds good. I have been using 1.33. One thought I'm
>having is that I should probably submit a PR to vng to either fix the
>multi-NIC setup in virtme-ng or add a hostfwd option... then restrict
>our assumptions here to only prior versions.

Yes, that would be great, but anyway for now I would say let's go with 
this since we're supposed to support these current versions I guess, and 
this hack at the end I think is doable.

BTW, thanks again for this useful work!
Stefano


