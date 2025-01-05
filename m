Return-Path: <netdev+bounces-155221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01402A01796
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 02:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 581041883FB2
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 01:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715691E529;
	Sun,  5 Jan 2025 01:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pen.gy header.i=@pen.gy header.b="KcaVkFNr"
X-Original-To: netdev@vger.kernel.org
Received: from qs51p00im-qukt01080502.me.com (qs51p00im-qukt01080502.me.com [17.57.155.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFEE27447
	for <netdev@vger.kernel.org>; Sun,  5 Jan 2025 01:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.155.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736038918; cv=none; b=oIUeLcALuIXxANs3L/qsrh3tX3lOcem+j9PZdCpSnDDKPiZTGwU3IRg0Xy66+/veTg9975LmvFypu5mSLfR+oEisbdfxPUgU+B5E3T1TrvYYXNW+ZTdA+LY5TbkFQDmpOnc8m1TUPEhc+Y2jTTv/Kj5BRnAEUur4pqI+iVx4mvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736038918; c=relaxed/simple;
	bh=gMiQQvJgPekVSlaz1BFa4ZJVhpaM/h/kvwunukkPDl0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EuPgKEbRTKCtto02Atro1+DTsDVizzVq16ABHGN70ixLxlHv/kxUtiov/idzHOqnsPVlv9mpZ26DgrkW4DZSEm3Z50N9dpAMfBhLpxcXUICh/hW2lepVVfTfj5/RN+Vg9AmgCqBTaWfDwG2svpYWRGzr2Fmc0wy2ROgMQodebMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pen.gy; spf=pass smtp.mailfrom=pen.gy; dkim=pass (2048-bit key) header.d=pen.gy header.i=@pen.gy header.b=KcaVkFNr; arc=none smtp.client-ip=17.57.155.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pen.gy
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pen.gy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pen.gy; s=sig1;
	t=1736038913; bh=gbbbB52Ie41Z3FFW7G5fRmqC4w2BJtjx7AMDtdd3IJE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
	b=KcaVkFNrWX1AMs8E9RmEKIiVCSJ1agMgB7FgPonyr+HN1Zg4tHcs8TzuOH+i+7seh
	 j3hfHN/8Rk1a+5DJlIgyHQ6BYSxgtVPN3oH5vhFTu/DlML5zur3XaIS1qgJ7fax5Be
	 R1dUMu134hRuJgR8NAtZ4rkTlDj07Kr/yyv8qy7fGGF6LWGKj5W5zXk5I0Rt6/z9jy
	 rC4tlPC581mMrxgu13S1LUSBnEV8qiH7OGJDFHx7qqNlSfOIcbCFO4ZvoFWU1U4DEP
	 FtC/ZJNBSlqIXgUM+gt7QquKjRWJxVt2bEPRyKruINLAJy3YaeHiqSWBN5NCNR4Obp
	 2K8Sc5I82nG/w==
Received: from fossa.se1.pen.gy (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
	by qs51p00im-qukt01080502.me.com (Postfix) with ESMTPSA id 3DDC34E40307;
	Sun,  5 Jan 2025 01:01:49 +0000 (UTC)
From: Foster Snowhill <forst@pen.gy>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Georgi Valkov <gvalkov@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Oliver Neukum <oneukum@suse.com>,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH net v4 0/7] usbnet: ipheth: prevent OoB reads of NDP16
Date: Sun,  5 Jan 2025 02:01:14 +0100
Message-ID: <20250105010121.12546-1-forst@pen.gy>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 6l-EHaCIP8Ce8bxE1X6rzChyun-hA15B
X-Proofpoint-ORIG-GUID: 6l-EHaCIP8Ce8bxE1X6rzChyun-hA15B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=624 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 clxscore=1030 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2501050007

iOS devices support two types of tethering over USB: regular, where the
internet connetion is shared from the phone to the attached computer,
and reverse, where the internet connection is shared from the attached
computer to the phone.

The `ipheth` driver is responsible for regular tethering only. With this
tethering type, iOS devices support two encapsulation modes on RX:
legacy and NCM.

In "NCM mode", the iOS device encapsulates RX (phone->computer) traffic
in NCM Transfer Blocks (similarly to CDC NCM). However, unlike reverse
tethering, regular tethering is not compliant with the CDC NCM spec:

* Does not have the required CDC NCM descriptors
* TX (computer->phone) is not NCM-encapsulated at all

Thus `ipheth` implements a very limited subset of the spec with the sole
purpose of parsing RX URBs. This driver does not aim to be
a CDC NCM-compliant implementation and, in fact, can't be one because of
the points above.

For a complete spec-compliant CDC NCM implementation, there is already
the `cdc_ncm` driver. This driver is used for reverse tethering on iOS
devices. This patch series does not in any way change `cdc_ncm`.

In the first iteration of the NCM mode implementation in `ipheth`,
there were a few potential out of bounds reads when processing malformed
URBs received from a connected device:

* Only the start of NDP16 (wNdpIndex) was checked to fit in the URB
  buffer.
* Datagram length check as part of DPEs could overflow.
* DPEs could be read past the end of NDP16 and even end of URB buffer
  if a trailer DPE wasn't encountered.

The above is not expected to happen in normal device operation.

To address the above issues for iOS devices in NCM mode, rely on
and check for a specific fixed format of incoming URBs expected from
an iOS device:

* 12-byte NTH16
* 96-byte NDP16, allowing up to 22 DPEs (up to 21 datagrams + trailer)

On iOS, NDP16 directly follows NTH16, and its length is constant
regardless of the DPE count.

As the regular tethering implementation of iOS devices isn't compliant
with CDC NCM, it's not possible to use the `cdc_ncm` driver to handle
this functionality. Furthermore, while the logic required to properly
parse URBs with NCM-encapsulated frames is already part of said driver,
I haven't found a nice way to reuse the existing code without messing
with the `cdc_ncm` driver itself.

I didn't want to reimplement more of the spec than I absolutely had to,
because that work had already been done in `cdc_ncm`. Instead, to limit
the scope, I chose to rely on the specific URB format of iOS devices
that hasn't changed since the NCM mode was introduced there.

I tested each individual patch in the series with iPhone 15 Pro Max,
iOS 18.2: compiled cleanly, ran iperf3 between phone and computer,
observed no errors in either kernel log or interface statistics.


Foster Snowhill (7):
  usbnet: ipheth: break up NCM header size computation
  usbnet: ipheth: fix possible overflow in DPE length check
  usbnet: ipheth: check that DPE points past NCM header
  usbnet: ipheth: use static NDP16 location in URB
  usbnet: ipheth: refactor NCM datagram loop
  usbnet: ipheth: fix DPE OoB read
  usbnet: ipheth: document scope of NCM implementation

 drivers/net/usb/ipheth.c | 69 ++++++++++++++++++++++++++--------------
 1 file changed, 45 insertions(+), 24 deletions(-)

-- 
2.45.1


