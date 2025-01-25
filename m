Return-Path: <netdev+bounces-160933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56CF5A1C5DE
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 00:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABAFA164A56
	for <lists+netdev@lfdr.de>; Sat, 25 Jan 2025 23:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FC220A5DA;
	Sat, 25 Jan 2025 23:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pen.gy header.i=@pen.gy header.b="PMMxP+TY"
X-Original-To: netdev@vger.kernel.org
Received: from ci74p00im-qukt09081901.me.com (ci74p00im-qukt09081901.me.com [17.57.156.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BD620A5CD
	for <netdev@vger.kernel.org>; Sat, 25 Jan 2025 23:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.156.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737849281; cv=none; b=FcvlrFVGBu3GtBlbU9uYXehSY6hxZUAITUWcsMl7Sa/Xa4LgF+vp7zxF/pKjgYdfjgyMMzMjmfRP7fgZe7hM4/j53teWOik2RmZfM985kVdwuu5ptQPCUq3HFEkhqHvpvI75fUdeqI3DW31waUUF2Pr4DopfTmzqRtnFHWcGe8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737849281; c=relaxed/simple;
	bh=/3P5sFdl42PCXPdLvV175/UlyddKR4OVl50EoTcyQpI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eIQHG96MJsktBkxTn9La+S3BmBcwt1zVEvlJB5JRpkeMsS3PxnqnPbFtrhC3dWzAF0csr6pLsv3c4YU9/gb7J053SbbaRn8jiW0rzDXX38lxpbyMcE6DY/JEZfUodHAjCsB73j7PqBDg2HVbrjV4mEW64WohypNrrX86HkIfdCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pen.gy; spf=pass smtp.mailfrom=pen.gy; dkim=pass (2048-bit key) header.d=pen.gy header.i=@pen.gy header.b=PMMxP+TY; arc=none smtp.client-ip=17.57.156.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pen.gy
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pen.gy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pen.gy; s=sig1;
	bh=3mvVsp53JPTfjcVGQNQTBmtX58ErjoxBE3VQAwyiHz8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
	b=PMMxP+TYEiG7i9HvAYC9scJpCL5zZaIh2CvBR3rzQMzKQ5EDXhsYFcYaOOEz+iPIb
	 0GMZzB9cyDzv7L+3EYG8DQBhxftW90/zvTcB6QNznWAdM1slZ2VBUpXs5Cl6IPJQJk
	 LjXJJCU7SP5FOZGlGneQH8mGdJZgaVfvakEuhL7ojmLNLSN5KIhy+nfd5S3utAGDfM
	 nCJQBZGWnAOmVMhSX79eNJVML8+Y2C3np4BGrdlID5k/drlNUQSwQ93cvUWBAIla3A
	 H0+e4wK7UzCzbe4H3RRQCD7sIix/pVsklGWjVgwh+XXY/8vbVDuGDQdvBChr1s+2mi
	 3dYTzVISW4i+A==
Received: from fossa.se1.pen.gy (ci77p00im-dlb-asmtp-mailmevip.me.com [17.57.156.26])
	by ci74p00im-qukt09081901.me.com (Postfix) with ESMTPSA id B93A25AC00A8;
	Sat, 25 Jan 2025 23:54:33 +0000 (UTC)
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
Subject: [PATCH net v5 0/7] usbnet: ipheth: prevent OoB reads of NDP16
Date: Sun, 26 Jan 2025 00:54:02 +0100
Message-ID: <20250125235409.3106594-1-forst@pen.gy>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: GwpecXrgp-rUIGzOP4tci3K9jVYieNmd
X-Proofpoint-GUID: GwpecXrgp-rUIGzOP4tci3K9jVYieNmd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-25_11,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=811 spamscore=0
 suspectscore=0 malwarescore=0 phishscore=0 mlxscore=0 clxscore=1030
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2501250183

iOS devices support two types of tethering over USB: regular, where the
internet connection is shared from the phone to the attached computer,
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

I tested each individual patch in the v5 series with iPhone 15 Pro Max,
iOS 18.2.1: compiled cleanly, ran iperf3 between phone and computer,
observed no errors in either kernel log or interface statistics.

v4 was Reviewed-by Jakub Kicinski <kuba@kernel.org>. Compared to v4,
v5 has no code changes. The two differences are:

* Patch "usbnet: ipheth: break up NCM header size computation"
  moved later in the series, closer to a subsequent commit that makes
  use of the change.
* In patch "usbnet: ipheth: refactor NCM datagram loop", removed
  a stray paragraph in commit msg.

Above items are also noted in the changelogs of respective patches.


Foster Snowhill (7):
  usbnet: ipheth: fix possible overflow in DPE length check
  usbnet: ipheth: check that DPE points past NCM header
  usbnet: ipheth: use static NDP16 location in URB
  usbnet: ipheth: refactor NCM datagram loop
  usbnet: ipheth: break up NCM header size computation
  usbnet: ipheth: fix DPE OoB read
  usbnet: ipheth: document scope of NCM implementation

 drivers/net/usb/ipheth.c | 69 ++++++++++++++++++++++++++--------------
 1 file changed, 45 insertions(+), 24 deletions(-)

-- 
2.45.1


