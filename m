Return-Path: <netdev+bounces-30072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A78F2785E90
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 19:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6178D28124E
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 17:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7AE41F17F;
	Wed, 23 Aug 2023 17:30:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFDA1ED56
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 17:30:54 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3613E79
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 10:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692811852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+aElGprIV/yQ1y55QHlBORqdYhFmE9HNGN2qq4wZWTE=;
	b=W/MFJQFbBN31T4j0GZWgovHBi82omMv1rBRgs8VoOJxls3MxWzYqs6UZAVcUU8VtDB6Ut5
	bnJJgE9FvQpKU/eaAdLsT2KyJiPgOs7R6hzp4Bn1HdlZYAS7MRpqYCxGk6X9R+47TjxdBa
	kNgp8qcZBYIGHjvwRjuHo4DxS7KJnRM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-144-UkpPuqXIMh-TEcY4_BXCRg-1; Wed, 23 Aug 2023 13:30:49 -0400
X-MC-Unique: UkpPuqXIMh-TEcY4_BXCRg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C270F856F67;
	Wed, 23 Aug 2023 17:30:48 +0000 (UTC)
Received: from renaissance-vector.redhat.com (unknown [10.39.194.152])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BC3C2492C13;
	Wed, 23 Aug 2023 17:30:47 +0000 (UTC)
From: Andrea Claudi <aclaudi@redhat.com>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@gmail.com>
Subject: [PATCH iproute2-next 0/4] make ip vrf exec SELinux-aware
Date: Wed, 23 Aug 2023 19:29:58 +0200
Message-ID: <cover.1692804730.git.aclaudi@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In order to execute a service with VRF, a user should start it using
"ip vrf exec". For example, using systemd, the user can encapsulate the
ExecStart command in ip vrf exec as shown below:

ExecStart=/usr/sbin/ip vrf exec vrf1 /usr/sbin/httpd $OPTIONS -DFOREGROUND 

Assuming SELinux is in permissive mode, starting the service with the
current ip vrf implementation results in:

# systemctl start httpd
# ps -eafZ | grep httpd
system_u:system_r:ifconfig_t:s0 root      597448       1  1 19:22 ?        00:00:00 /usr/sbin/httpd -DFOREGROUND
system_u:system_r:ifconfig_t:s0 apache    597452  597448  0 19:22 ?        00:00:00 /usr/sbin/httpd -DFOREGROUND
[snip]

This is incorrect, as the context for httpd should be httpd_t, not
ifconfig_t.

This happens because ipvrf_exec invokes cmd_exec without setting the
correct SELinux context before. Without the correct setting, the process
is executed using ip's SELinux context.

This patch series makes "ip vrf exec" SELinux-aware using the
setexecfilecon functions, which retrieves the correct context to be used
on the next execvp() call.

After this series:
# systemctl start httpd
# ps -eafZ | grep httpd
system_u:system_r:httpd_t:s0    root      595805       1  0 19:01 ?        00:00:00 /usr/sbin/httpd -DFOREGROUND
system_u:system_r:httpd_t:s0    apache    595809  595805  0 19:01 ?        00:00:00 /usr/sbin/httpd -DFOREGROUND


Patch series description:
- 1/4 and 2/4 are preliminary changes to make SELinux helper functions
  used in ss conformant to the SELinux API definitions;
- 3/4 makes SELinux helper functions into a library, so they can be used
  in other iproute tools - such as ip - when iproute is compiled without
  SELinux support; 
- 4/4, finally, add setexecfilecon to the SELinux stubs, and uses it to
  actually set the correct file context for the command to be executed.

Andrea Claudi (4):
  ss: make is_selinux_enabled stub work like in SELinux
  ss: make SELinux stub functions conformant to API definitions
  lib: add SELinux include and stub functions
  ip vrf: make ipvrf_exec SELinux-aware

 include/selinux.h | 10 ++++++++++
 ip/ipvrf.c        |  6 ++++++
 lib/Makefile      |  4 ++++
 lib/selinux.c     | 37 +++++++++++++++++++++++++++++++++++++
 misc/ss.c         | 36 ++----------------------------------
 5 files changed, 59 insertions(+), 34 deletions(-)
 create mode 100644 include/selinux.h
 create mode 100644 lib/selinux.c

-- 
2.41.0


