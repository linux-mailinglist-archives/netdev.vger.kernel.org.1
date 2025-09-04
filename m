Return-Path: <netdev+bounces-219854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC88B43805
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 12:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAEA9587FDD
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 10:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E022FC02C;
	Thu,  4 Sep 2025 10:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="XZnhCnSO"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B1A2FB997
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 10:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756980571; cv=none; b=tIVjNpwFELg35ivia9Hlk9TOp17EOh1ou6aAF3lW4L+TVP+9crxfatI6tM18mIRyNQSXHJElMN2lH+Ay4AzAlLsFN9sHqXye2y7Zp1a+9o3Ituyx01r12V2A44/rZQjbjxd1UWW3DXj0qR4I+mAwUzdqYCsBMDkqJr3QHGIhqRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756980571; c=relaxed/simple;
	bh=CeWVO0TFOjJEEFyLXOT+E4YUI0U1MVhPolCpAKxibMI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TguDGZUhOeZdhHbGRATFj771szniEfDY2tXDlzJ0hsPmMVsEUjjGJ9Av7/KG7/7GUEQaQLbel5XBl4826qxWpEf1L+9wk7LgZCUijiMw6ec9hgfba/t7E2uG8DTxjgYzAGEoV70G1a4lu5+HC9nKLKb9QSzs/Yvl/RphydzYcIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=XZnhCnSO; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1756980559; x=1757585359; i=wahrenst@gmx.net;
	bh=0PZWvAEZB/Sj71JKgUtVNCElAcy8ci3FdFhaxW4YlyE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=XZnhCnSOaAWJdoP+F4XXxSSqlOvtX56T0Lur3WJYbOtn7zAwwwQ6uvJETHKninFA
	 kK61RwGOcc5n/dT039YLQAqhHfKwJNQP8MXHN/Vcmfndls0MFuw9JNA3dfuRZ83TO
	 2zKVInEbD9gVYhI0xZno4d6ZotQJA7WM46HjuIwFoFkm9leh2watRClVn8Qf+nfV0
	 xePSWdrVFFlqQ4cn9SrEg39mYNaCymiZ9ep3yehisggQb14JUuGktB5wno4ipSG5C
	 eYbcHF9ZiL2n7iESDoMKajPdRgRCXdxcU2v9plTa4pU234+XuoqvGdWc/GKyJdTcG
	 4sVMtbRWyLkjZrA5ng==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([79.235.128.112]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M6lpM-1upBUP1Ui6-00GJK7; Thu, 04
 Sep 2025 12:09:19 +0200
From: Stefan Wahren <wahrenst@gmx.net>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH 0/2 next] microchip: lan865x: Minor improvements
Date: Thu,  4 Sep 2025 12:09:14 +0200
Message-Id: <20250904100916.126571-1-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:27d2rZCsYFCJhpiqgis/hcgeybACfc/4ujE5JR96QlmB4l+l1YG
 tczvA89ZNfUKjj91fzRR7tnDLr2lJfzWe3RfPUR2vhk0G9avZwysTrFeFKfFEeF4ajM5bgr
 EWPpaN7Utw/WNeclmH2WGFkTg/TUxZKyNdyHCCyC0npGKCCJer0ar2FZn5bpywykOKHXhA1
 fr8tNIx/IntF9G2izWjVA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IeHXyrxA94c=;4jbk+FM8XYn420s0kZ5PxjKfIRH
 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
 l0lr/i7franISqLeXsIIZpiwQXUK

Recently I setup a customer i.MX93 board which contains a LAN8651 chip.
These minor improvements were considered as helpful.

Stefan Wahren (2):
  microchip: lan865x: Enable MAC address validation
  microchip: lan865x: Allow to fetch MAC from NVMEM

 drivers/net/ethernet/microchip/lan865x/lan865x.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

=2D-=20
2.34.1


