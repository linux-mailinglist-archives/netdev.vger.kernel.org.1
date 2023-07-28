Return-Path: <netdev+bounces-22265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E30766C5B
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 14:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1093D1C218C2
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 12:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CF2134DF;
	Fri, 28 Jul 2023 11:59:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C66C134BA
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 11:59:51 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F6319BF
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 04:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690545588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wkYExyrH0hmK6H5XLA8WFiWWTbpLMfoLOCPaCc3YX2s=;
	b=VH2ocyiB4z4LtE3e2Ge9zTZOB+haQuTg0AOH0+ZLwXmfVP2O2IEVYOcfJ4CZck4TWt283V
	8URsrrTpkyfceucgxRCCF8SxNpwCMP1ZmrgRCWLnRzMjbUIUMLh9HqAbI2XXgw0SlHoKtU
	11kfMCNXnNGvgbkRogcqN0o7kCqY3pg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-230-hv_Mz3zuPv-n4WqRSpntkQ-1; Fri, 28 Jul 2023 07:59:42 -0400
X-MC-Unique: hv_Mz3zuPv-n4WqRSpntkQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 84A781008142;
	Fri, 28 Jul 2023 11:59:41 +0000 (UTC)
Received: from RHTPC1VM0NT.redhat.com (unknown [10.22.8.217])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D70EE207B338;
	Fri, 28 Jul 2023 11:59:40 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: netdev@vger.kernel.org
Cc: dev@openvswitch.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Pravin B Shelar <pshelar@ovn.org>,
	Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH v2 net-next 0/5] selftests: openvswitch: add flow programming cases
Date: Fri, 28 Jul 2023 07:59:35 -0400
Message-Id: <20230728115940.578658-1-aconole@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The openvswitch selftests currently contain a few cases for managing the
datapath, which includes creating datapath instances, adding interfaces,
and doing some basic feature / upcall tests.  This is useful to validate
the control path.

Add the ability to program some of the more common flows with actions. This
can be improved overtime to include regression testing, etc.

Changes from original:

1. Fix issue when parsing ipv6 in the NAT action
2. Fix issue calculating length during ctact parsing
3. Fix error message when invalid bridge is passed
4. Fold in Adrian's patch to support key masks

Aaron Conole (4):
  selftests: openvswitch: add an initial flow programming case
  selftests: openvswitch: add a test for ipv4 forwarding
  selftests: openvswitch: add basic ct test case parsing
  selftests: openvswitch: add ct-nat test case with ipv4

Adrian Moreno (1):
  selftests: openvswitch: support key masks

 .../selftests/net/openvswitch/openvswitch.sh  | 223 +++++++
 .../selftests/net/openvswitch/ovs-dpctl.py    | 601 +++++++++++++++++-
 2 files changed, 800 insertions(+), 24 deletions(-)

-- 
2.40.1


