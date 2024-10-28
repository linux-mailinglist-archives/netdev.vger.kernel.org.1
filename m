Return-Path: <netdev+bounces-139730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D56E39B3E97
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 00:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9E541C21730
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 23:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E0E1FAC47;
	Mon, 28 Oct 2024 23:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=armitage.org.uk header.i=@armitage.org.uk header.b="g40IPb+K"
X-Original-To: netdev@vger.kernel.org
Received: from nabal.armitage.org.uk (unknown [92.27.6.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5FA1F4286
	for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 23:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.27.6.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730159084; cv=none; b=DKOY5Ic183b2S57xQ+aCeeQ+Fmy0fBFblcdXUCYW+3dcPkf+kVW9VylEF9ZCv6b/DesNUEJDJxSZItXmXddUYEpKNAndJfuvOzNf6AmpdEE9SnlMXgmsySgiAr42AZ0zsgWBQ/2eFbl0+WvzqofCjQj1HnXgKq8YDwprWm8UW7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730159084; c=relaxed/simple;
	bh=ekgy1+B9Vl5Qh1ylxJz5UNSE1A35Yjf55NXQ5vKh5mM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mLpmYfKzo7e8xXMwz7PmVy2PwvC39n0xytzwt9KYXQvWBX5x0SxgYDl2TcolYKCRuY3sVmeAQAKyFYHobfj95FpCw3mRt4e5/bqNmR/3GRxD9rAkHicdVJxSU2I9g0v2vxerCjNRiC5UGYDEBe5MIGRuToD9SgyMQHt+8cJ/k6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=armitage.org.uk; spf=pass smtp.mailfrom=armitage.org.uk; dkim=pass (1024-bit key) header.d=armitage.org.uk header.i=@armitage.org.uk header.b=g40IPb+K; arc=none smtp.client-ip=92.27.6.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=armitage.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=armitage.org.uk
Received: from localhost (nabal.armitage.org.uk [127.0.0.1])
	by nabal.armitage.org.uk (Postfix) with ESMTP id 4027A2E53B6;
	Mon, 28 Oct 2024 23:44:35 +0000 (GMT)
Authentication-Results: nabal.armitage.org.uk (amavisd-new);
	dkim=pass (1024-bit key) reason="pass (just generated, assumed good)"
	header.d=armitage.org.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=armitage.org.uk;
	 h=content-transfer-encoding:mime-version:x-mailer:message-id
	:date:date:subject:subject:from:from:received; s=20200110; t=
	1730159059; x=1731023060; bh=ekgy1+B9Vl5Qh1ylxJz5UNSE1A35Yjf55NX
	Q5vKh5mM=; b=g40IPb+KN+7S9qrz38VQMoydk1v3O1zMrNPVaHt6NgsnGYGwgt0
	XKKxU68g4LTxd/yc0jUvADZuLSUImBsRjTfHU0mNMa8XM2T9eWo5FmpysM8YJewD
	8qhOpV0oyy2hocx1BtdK2lHClxso7iWkVQUR180Z9PUul+2r+Y0J7iZE=
X-Virus-Scanned: amavisd-new at armitage.org.uk
Received: from samson.armitage.org.uk (samson.armitage.org.uk [IPv6:2001:470:69dd:35::210])
	by nabal.armitage.org.uk (Postfix) with ESMTPSA id C1F1D2E53BE;
	Mon, 28 Oct 2024 23:44:19 +0000 (GMT)
From: Quentin Armitage <quentin@armitage.org.uk>
To: netdev@vger.kernel.org
Cc: Quentin Armitage <quentin@armitage.org.uk>
Subject: [PATCH v2 0/1] rt_names: add rt_addrprotos with an identifier for keepalived
Date: Mon, 28 Oct 2024 23:44:13 +0000
Message-Id: <20241028234413.321779-1-quentin@armitage.org.uk>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2: Add entry to rt_addrprotos rather than rt_addrprotos.d/keepalived.conf

The patch adds an address protocol identifier for keepalived, which now
sets the protocol field when adding IP addresses.

The value of 18 was chosen simply because that is the value of
RTPROT_KEEPALIVED, whick keepalived sets for ip routes and rules. The
value can happily be changed if another value would be better.

