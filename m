Return-Path: <netdev+bounces-13397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D14E073B6FD
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 14:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 076AD1C21221
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 12:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0351D23118;
	Fri, 23 Jun 2023 12:20:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3A4211F
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 12:20:23 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90A31BE4
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 05:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687522821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=g+YLjgQG+mnsMl5jt1EwmR0auNXs/ucKGgshILNvFCM=;
	b=NQoF7H5WU4A78vMw1P4JDzIcXzhKamkS8j+b7saDmuS/k/1g2m8d7P5e/qWQ2gWD9c9g1h
	QHAtv5/9M59fzMgXbwv0sGrFpWuVLSIapmvwp7FDEEzHuUsBbOhvPnxZ2bfowNqST86FRA
	xtlyWY69Vo8CfRxNpR+j11HFvcSlZKw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-184-15FJr4JFOou1mthlFi653Q-1; Fri, 23 Jun 2023 08:20:16 -0400
X-MC-Unique: 15FJr4JFOou1mthlFi653Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 475341C06EE8;
	Fri, 23 Jun 2023 12:20:16 +0000 (UTC)
Received: from renaissance-vector.redhat.com (unknown [10.39.194.186])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2D5A0422B0;
	Fri, 23 Jun 2023 12:20:14 +0000 (UTC)
From: Andrea Claudi <aclaudi@redhat.com>
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: mptcp@lists.linux.dev,
	matthieu.baerts@tessares.net,
	martineau@kernel.org,
	geliang.tang@suse.com
Subject: [PATCH net 0/2] selftests: fix mptcp_join test
Date: Fri, 23 Jun 2023 14:19:50 +0200
Message-ID: <cover.1687522138.git.aclaudi@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This series fixes two mptcp_join testcases.
- '001 implicit EP' fails because of:
  - missing iproute support for mptcp 'implicit' flag, fixed with
    iproute2-next commit 3a2535a41854 ("mptcp: add support for implicit
    flag")
  - pm_nl_check_endpoint expecting two ip addresses, while only one is
    present in the iproute output;
- '002 delete and re-add' fails because the endpoint delete command
  provide both id and ip address, while address should be provided only
  if id is 0.

Andrea Claudi (2):
  selftests: mptcp: join: fix 'delete and re-add' test
  selftests: mptcp: join: fix 'implicit EP' test

 tools/testing/selftests/net/mptcp/mptcp_join.sh | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

-- 
2.41.0


