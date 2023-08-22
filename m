Return-Path: <netdev+bounces-29613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B6E7840D9
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 14:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41D1D280F65
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 12:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2219443;
	Tue, 22 Aug 2023 12:33:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33657F
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 12:33:14 +0000 (UTC)
Received: from mail.mbosch.me (mail.mbosch.me [65.21.144.185])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C7DCC7
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 05:33:13 -0700 (PDT)
Date: Tue, 22 Aug 2023 14:33:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mbosch.me; s=mail;
	t=1692707588; bh=wv+njF2cyPiR7h3xFk9nBlxEcQfhaivXaQacL7JPmas=;
	h=Date:From:To:Subject:References:In-Reply-To;
	b=OepTy2nHaNoDc71i5RbaaVXG3IDGtryfL8mlN7E5LtQN6ySkhYodY/nUar+tW10y3
	 vGAAxanhqgaqQODXhBBFMbYLSJD2BRvOMtFblA/cvR8atkaeuw5E2fbPUJ9MTbsQX7
	 MCQMlAsnuzElM0CYAQ98T4Xj/Zbe8G5UV3lWN2Jc=
From: Maximilian Bosch <maximilian@mbosch.me>
To: netdev@vger.kernel.org
Subject: [PATCH iproute2-next v2] ip-vrf: recommend using CAP_BPF rather than
 CAP_SYS_ADMIN
Message-ID: <43pipyx5qleyhkai5oitdfwqokuwcevak6n5laz6wshm3n4xnj@rarv5zwhdu27>
References: <20230814134423.46036cdf@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814134423.46036cdf@hermes.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The CAP_SYS_ADMIN capability allows far too much, to quote
`capabilities(7)`:

    Note: this capability is overloaded; see Notes to kernel developers, below.

In the case of `ip-vrf(8)` this is needed to load a BPF program.
According to the same section of the same man-page, using `CAP_BPF` is
preferred if that's the reason for `CAP_SYS_ADMIN`;

    perform  the  same BPF operations as are governed by CAP_BPF (but the latter, weaker capability is preferred for accessing
    that functionality).

Local testing revealed that `ip vrf exec` for an unprivileged user is
sufficient if the `CAP_BPF` capability is given rather than
`CAP_SYS_ADMIN`.

In a previous version of the patch[1] it was mentioned that
CAP_SYS_ADMIN was still required for Linux <5.8, however it was
suggested to not make man-pages dependent on the kernel version. Also,
it was suggested to improve the wording and the formatting of the entire
paragraph mentioning capabilities which was also done.

Signed-off-by: Maximilian Bosch <maximilian@mbosch.me>

[1] https://lore.kernel.org/netdev/e6t4ucjdrcitzneh2imygsaxyb2aasxfn2q2a4zh5yqdx3vold@kutwh5kwixva/T/#m628a1900a7e5012bb87e6cb3c94af6c7281cf2bf
---
 ip/ip.c           |  2 +-
 man/man8/ip-vrf.8 | 40 ++++++++++++++++++++++++++++++++++------
 2 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/ip/ip.c b/ip/ip.c
index 8424736f..8c046ef1 100644
--- a/ip/ip.c
+++ b/ip/ip.c
@@ -175,7 +175,7 @@ int main(int argc, char **argv)
 	 * execv will drop them for the child command.
 	 * vrf exec requires:
 	 * - cap_dac_override to create the cgroup subdir in /sys
-	 * - cap_sys_admin to load the BPF program
+	 * - cap_bpf to load the BPF program
 	 * - cap_net_admin to set the socket into the cgroup
 	 */
 	if (argc < 3 || strcmp(argv[1], "vrf") != 0 ||
diff --git a/man/man8/ip-vrf.8 b/man/man8/ip-vrf.8
index c1c9b958..946e8f8a 100644
--- a/man/man8/ip-vrf.8
+++ b/man/man8/ip-vrf.8
@@ -66,14 +66,42 @@ the current shell is associated with another VRF (e.g, Management VRF).
 This command requires the system to be booted with cgroup v2 (e.g. with systemd,
 add systemd.unified_cgroup_hierarchy=1 to the kernel command line).
 
-This command also requires to be ran as root or with the CAP_SYS_ADMIN,
-CAP_NET_ADMIN and CAP_DAC_OVERRIDE capabilities. If built with libcap and if
-capabilities are added to the ip binary program via setcap, the program will
-drop them as the first thing when invoked, unless the command is vrf exec.
+This command also requires to be run as root. Alternatively it
+can be run by an unprivileged user if the following
+.BR capabilities (7)
+are given:
+
+.RS
+.IP \fBCAP_BPF\fP
+To load the BPF program.
+.IP \fBCAP_NET_ADMIN\fP
+To set the socket into the cgroup.
+.IP \fBCAP_DAC_OVERRIDE\fP
+To create the cgroup subdir in /sys.
+.RE
+
+.IP
+If these capabilities are added and if
+.BR ip (8)
+is built with
+.BR libcap (3)
+then these capabilities will be dropped before
+.BR cmd
+is executed by
+.B ip vrf exec.
+For every other unprivileged invocation of
+.BR ip (8)
+all capabilities will be dropped.
+
 .br
-NOTE: capabilities will NOT be dropped if CAP_NET_ADMIN is set to INHERITABLE
+.B NOTE:
+capabilities will
+.B NOT
+be dropped if
+.B CAP_NET_ADMIN
+is set to
+.B INHERITABLE
 to avoid breaking programs with ambient capabilities that call ip.
-Do not set the INHERITABLE flag on the ip binary itself.
 
 .TP
 .B ip vrf identify [PID] - Report VRF association for process
-- 
2.40.1


