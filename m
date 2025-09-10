Return-Path: <netdev+bounces-221495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FF4B50A4F
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 03:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 243463BC9C7
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 01:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17EC4202F9C;
	Wed, 10 Sep 2025 01:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="mYvJY3/u"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C3B1F936
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 01:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757468214; cv=none; b=HPH5z4aoTJ0otz6HXQSLNBFc9ttULi3iyIqNa6bWVgvZsHb+gJ+QD5hWHT6DaBKtH7naEWMuKva7+EuM/63qWUCoyjt8X49yBCBX5MzQu9fTbPDi+W/IzuNa9x6HiEltf360+BNN4ZQ/fAVCrTWjM9ksMGvQ2k7DxapFl2j8GqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757468214; c=relaxed/simple;
	bh=aWndzOMezNcWiMPOCg+KppblYvG/MrFgTgcjyC8+sH8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UnbAYyE6AEPyhBKORb5hM6TfERIsqpanEli4JfNKL9J3Lcd0yrVXfPv/CeSg8iCddv4exbhS9keukacTmTasezDRhwOgN4QEakocVRDROia/bCnnOueMG1eBjxwRRXUSNqOvwgI1/adqn8Wpya5YTX3nFrJGLN5xGf+JRpatpWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=mYvJY3/u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 234C2C4CEF4;
	Wed, 10 Sep 2025 01:36:53 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="mYvJY3/u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1757468211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gVTGzHMiSkP1TWu+5lTafWTltez8/D+hdCBHkpWEnys=;
	b=mYvJY3/uAQF5JLj0GXIWreBISmlhHDNRCMSfL9UKlOQguvcPsHHdtMwvo7EmSeLH0ceajI
	ddQX6NSvsQ/62u22uVA3fAg6+NB+l2mopGIrlVbvJfZpwtDgC7kcrIoXoGx2/Wr77/f5CS
	FVfrD9V4csPx7SoC/1mk4NlR+zce2TA=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 48da6aa5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 10 Sep 2025 01:36:50 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH net 0/4] wireguard fixes for 6.17-rc6
Date: Wed, 10 Sep 2025 03:36:40 +0200
Message-ID: <20250910013644.4153708-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jakub,

Please find three small fixes to wireguard:

1) A general simplification to the way wireguard chooses the next
   available cpu, by making use of cpumask_nth(), and covering an edge
   case.

2) A cleanup to the selftests kconfig.

3) A fix to the selftests kconfig so that it actually runs again.

Thanks,
Jason

David Hildenbrand (1):
  wireguard: selftests: remove CONFIG_SPARSEMEM_VMEMMAP=y from qemu
    kernel config

Jason A. Donenfeld (1):
  wireguard: selftests: select CONFIG_IP_NF_IPTABLES_LEGACY

Yury Norov (NVIDIA) (1):
  wireguard: queueing: always return valid online CPU in
    wg_cpumask_choose_online()

Yury Norov [NVIDIA] (1):
  wireguard: queueing: simplify wg_cpumask_next_online()

 drivers/net/wireguard/queueing.h                    | 13 ++++---------
 .../testing/selftests/wireguard/qemu/kernel.config  |  8 ++++----
 2 files changed, 8 insertions(+), 13 deletions(-)

-- 
2.51.0


