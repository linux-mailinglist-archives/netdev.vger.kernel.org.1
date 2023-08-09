Return-Path: <netdev+bounces-25768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E938775687
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 11:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D17B9281AB9
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 09:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA63113ADA;
	Wed,  9 Aug 2023 09:36:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2AA100B6
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 09:36:16 +0000 (UTC)
X-Greylist: delayed 574 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Aug 2023 02:36:15 PDT
Received: from mail.mbosch.me (mail.mbosch.me [65.21.144.185])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A42310D4
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 02:36:15 -0700 (PDT)
Date: Wed, 9 Aug 2023 11:26:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mbosch.me; s=mail;
	t=1691573197; bh=qwcPZ9dbO7nm6nuXSszeNXB7Z13VCwneg4GF2GbX6IE=;
	h=Date:From:To:Subject;
	b=QKXd4RoM4gcZ2E/KDP36ae8daQHAISJ60fnqDBB0VY8053UDmkLURhDrf6cLBTTcb
	 izvedmzXbNHzxb1tMmpteZpvOKxcxwytMPhKlcL3LGOUYBdkshmcnv2mmX6R6F9hZZ
	 gIkbwPu3C/NRFbphAEcVFF71nN+JKkRHRYWyDBwY=
From: Maximilian Bosch <maximilian@mbosch.me>
To: netdev@vger.kernel.org
Subject: [PATCH iproute2-next] ip-vrf: recommend using CAP_BPF rather than
 CAP_SYS_ADMIN
Message-ID: <e6t4ucjdrcitzneh2imygsaxyb2aasxfn2q2a4zh5yqdx3vold@kutwh5kwixva>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Since this was introduced in Linux 5.8, a note is left that on older
kernels `CAP_SYS_ADMIN` must be used instead.

Signed-off-by: Maximilian Bosch <maximilian@mbosch.me>
---
 ip/ip.c           | 2 +-
 man/man8/ip-vrf.8 | 9 +++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

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
index c1c9b958..798a6808 100644
--- a/man/man8/ip-vrf.8
+++ b/man/man8/ip-vrf.8
@@ -66,10 +66,11 @@ the current shell is associated with another VRF (e.g, Management VRF).
 This command requires the system to be booted with cgroup v2 (e.g. with systemd,
 add systemd.unified_cgroup_hierarchy=1 to the kernel command line).
 
-This command also requires to be ran as root or with the CAP_SYS_ADMIN,
-CAP_NET_ADMIN and CAP_DAC_OVERRIDE capabilities. If built with libcap and if
-capabilities are added to the ip binary program via setcap, the program will
-drop them as the first thing when invoked, unless the command is vrf exec.
+This command also requires to be ran as root or with the CAP_BPF (or
+CAP_SYS_ADMIN on Linux <5.8), CAP_NET_ADMIN and CAP_DAC_OVERRIDE capabilities.
+If built with libcap and if capabilities are added to the ip binary program
+via setcap, the program will drop them as the first thing when invoked,
+unless the command is vrf exec.
 .br
 NOTE: capabilities will NOT be dropped if CAP_NET_ADMIN is set to INHERITABLE
 to avoid breaking programs with ambient capabilities that call ip.
-- 
2.40.1


