Return-Path: <netdev+bounces-114969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE187944D19
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 15:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CB901C21061
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 13:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B1F1A2C00;
	Thu,  1 Aug 2024 13:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="b5RUIv8F"
X-Original-To: netdev@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603AC1A0AFF
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 13:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722518630; cv=none; b=uTHWDrF9t2tbcrbZAnnC6gWun5835I//3CAGeK+4yH/Wnntk4JHiPtANdRpfOEWzVqBRupSGQMfGDobFRT7e6eGxC3VBtirIJb/tXmps8h5Az4gIo8jtuDrI8ZhnPBMl/qxFfu/7SGY9qOreRTN3dnM2KhhlLUiyTfNR+sknmQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722518630; c=relaxed/simple;
	bh=baSf0ApEkJLU4yU0V/9pjG7I3EYzzoz2NJ6F5P9JpXg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=g8LhCvqL50khxqBeAdbA4Zaun/tbQ1ouAF/2811WB0lHxPTqwcbvzE7pYVhn+vL8DauBT5NbnaketftR7tKCHD5UCWkFWL+5N0ufbAUkDjAE+2LQQTzZaaDUQD5UJfsXMBY6JGKJeCtE/eaaMBEvlRbHHYJ5A+frkKH7/KlChoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=b5RUIv8F; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722518620; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=pR9tahnZPm/aH4HSeZRrhjYKF1LRdwxtw3I6Z8roiFo=;
	b=b5RUIv8FdZb8M/Ut5P9Vh3RZx16OttiOGoW0QzOp6q1Jex4ss/W1Zb/RWtgpnrG1c42UEG7dvkd6l3XoHqz2LHHxq1+aHxS6vzDH5itPLXXL0BpQ149bSSOslGaiYzy9//q7XO0Y770e2KVbiW/3znEwO07nCgMyqw5q2TXouPg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0WBtmJgk_1722518618;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0WBtmJgk_1722518618)
          by smtp.aliyun-inc.com;
          Thu, 01 Aug 2024 21:23:39 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH net v4 0/2] virtio-net: unbreak vq resizing if vq coalescing is not supported
Date: Thu,  1 Aug 2024 21:23:36 +0800
Message-Id: <20240801132338.107025-1-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently, if the driver does not negotiate the vq coalescing feature
but supports vq resize, the vq resize action, which could have been
successfully executed, is interrupted due to the failure in configuring
the vq coalescing parameters. This issue needs to be fixed.

Changelog
=========
v3->v4:
  - Add a comment for patch[2/2].

v2->v3:
  - Break out the feature check and the fix into separate patches.

v1->v2:
  - Rephrase the subject.
  - Put the feature check inside the virtnet_send_{r,t}x_ctrl_coal_vq_cmd.

Heng Qi (2):
  virtio-net: check feature before configuring the vq coalescing command
  virtio-net: unbreak vq resizing when coalescing is not negotiated

 drivers/net/virtio_net.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

-- 
2.32.0.3.g01195cf9f


