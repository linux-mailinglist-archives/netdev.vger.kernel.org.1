Return-Path: <netdev+bounces-152054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C759F2897
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 04:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA09F165195
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 03:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9476145A11;
	Mon, 16 Dec 2024 03:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="pHWEo56G"
X-Original-To: netdev@vger.kernel.org
Received: from out203-205-221-242.mail.qq.com (out203-205-221-242.mail.qq.com [203.205.221.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551F4847B;
	Mon, 16 Dec 2024 03:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734318709; cv=none; b=RdvGLxsLHB7nmZ9FF/qxOiJWw9vTCxXVKhcW+VjpEDBgwtnGlRYOCLzTPcY1E1+b5sUHzcC9W31U0aOMi1JVIW7+mvAN5t9+JqdiGjdRXh3IjVe3/6MM6rhkns0LHVyf+JTjMYBbu6uq23zIhuZz3UiPA3j9dEF5J7CoDb+vDd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734318709; c=relaxed/simple;
	bh=feZqFl3Z2fXoahyyv8inhP0iVemVBJb+Irhr0KxoyL0=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=ZCYTKMn3IDXPZnQ3BlcGsYzPBzFd31poQ+ixhDYI0nhE7H6J8xBjM0VrURu7/e2hh0rhs5nkCS8K8rajqVQ0LXtzoeA8GPREnIux/YzFVBWteEweeqF39gA0t5656XwlXFELaCGXc8I9HXqD8DQB3+shrSIjUgwYf5b1WXLXUWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=pHWEo56G; arc=none smtp.client-ip=203.205.221.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1734318394;
	bh=Kc3CUwedDdXj45/Mbsftuq+CcH5kq+gS1YhoUSKMdBM=;
	h=From:To:Cc:Subject:Date;
	b=pHWEo56GJg+6nw3W+PmlYkkY8Ui8qw2NViHQ2vjsS995K8mM5almzngj8MNpARBP0
	 x4lKP8icXcqQ0ueDjLhN9VzdiprdgYqcoEaYdAqVFZPz9j+KMeyxIU7LZirUTU0xjK
	 wF80mSWNmc3kMrYtd4aAiB57R4mH5RDdlYMUxJ08=
Received: from q-OptiPlex-7000.QUECTEL.COM ([203.93.254.82])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id 19427482; Mon, 16 Dec 2024 11:06:20 +0800
X-QQ-mid: xmsmtpt1734318380tkxxbae7w
Message-ID: <tencent_17DDD787B48E8A5AB8379ED69E23A0CD9309@qq.com>
X-QQ-XMAILINFO: OATpkVjS499uQq0ifGKy4F7GQl3t+SPov80Pn6eQHF7hnugAjnJ8XcWvLZ2dsw
	 1qLPBOs1OpNvtaD2Yhc7HP0xYIZnv5EyfLVbuPt19Y11q20ZkcxFBa7+9CwIYDZiqKnzp0FpbF9W
	 pwdpRix+RH53j0HwXs9qJ8wFHT2OBHabxuY3hy1yimMoaB58VVdSVI6dFejocs/iNf1GDSCFoZE2
	 mVbDTLIzFdtFaXnDtg95HEqowum1ANVR6vPjkqJ+JCCJu3gv0Rfp4QsWxvg9eGejI+6tnQR+8l7z
	 5TC/MI+I9DowAKhe2YgQxbp+UuXBnHPkgRWamxPY3YlfMh5cVo8B6InBOBe72U0g5ySzgIz5Sr1q
	 f+f+rJkbqIBZcLYajj0B/iQkhPRvRqsEWkgLrgQuyOj/N72yv2OlzUmKO86c2+acW3/Lodd0FqVU
	 cqgLDw6MxPgqF80LpAQmZoU8xRgN33qeq/DGwQ35UctHNJ3xvAhBtAr3XkLy0N384Q1vYs77xwpW
	 7f/cL9/kd5glNDFvUJiRXHZ5llSvKD3AXE3cthYjDJz1ERKTXXcAieHKP9E63JetjLdMkFN77nqw
	 vRwyEhAVTCoIpIhc7I82XK+VqCheoeO0PtUMoCJAZSNmIwlM8YPsK/gq2R4b84c3nKwnaoXcgawp
	 L79GoSm+cqhUedmLpvFHBCDcThWjWtSdvhAesj3V5CLXFLKBmw0vmy60fUQcBOAIo7zMy+sxQ3Hx
	 hDEXD1tcX1jp9tbYgCkJRzXDbFJfFJOXfqsrutqdmyOQc+esb9STp83tMPmi/40X6JmneIZPCgOG
	 fKsaoldFxYSoNVBbV5F3Aut059HzH+InEhOqYwAKDLAy9mmVt1Wa03xXTOrqYaq1fIHytDMMuLeR
	 prBS1kV4jWPtMk3FJCBxHtdqWkcwHMwPTQAsOQZB0/QBeb92h/zLYIWJglvpQiIh20F7jcg8FVPI
	 azmJGnsfUk2ivD9eduNt9Wyhqk7cjDjna54T6hUYRIt8BV1q8KDAIAm74rfR2SH8hlizRhnpjf0i
	 yYt6dzA1SuI1p05bRYdfN8tZXi5elK7RtRG0DVEWbi2MQGsFadf7kuWtzoEL0=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Martin Hou <martin.hou@foxmail.com>
To: bjorn@mork.no,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Martin Hou <martin.hou@foxmail.com>
Subject: [PATCH] net: usb: qmi_wwan: add Quectel RG255C
Date: Mon, 16 Dec 2024 11:06:18 +0800
X-OQ-MSGID: <20241216030618.70729-1-martin.hou@foxmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for Quectel RG255C which is based on Qualcomm SDX35 chip.
The composition is DM / NMEA / AT / QMI.

T:  Bus=01 Lev=01 Prnt=01 Port=04 Cnt=01 Dev#=  2 Spd=480  MxCh= 0
D:  Ver= 2.01 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=2c7c ProdID=0316 Rev= 5.15
S:  Manufacturer=Quectel
S:  Product=RG255C-CN
S:  SerialNumber=c68192c1
C:* #Ifs= 4 Cfg#= 1 Atr=a0 MxPwr=500mA
I:* If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=84(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=50 Driver=qmi_wwan
E:  Ad=86(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms

Signed-off-by: Martin Hou <martin.hou@foxmail.com>
---
 drivers/net/usb/qmi_wwan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index 9fe7f704a2f7..e9208a8d2bfa 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1429,6 +1429,7 @@ static const struct usb_device_id products[] = {
 	{QMI_QUIRK_SET_DTR(0x2c7c, 0x0195, 4)},	/* Quectel EG95 */
 	{QMI_FIXED_INTF(0x2c7c, 0x0296, 4)},	/* Quectel BG96 */
 	{QMI_QUIRK_SET_DTR(0x2c7c, 0x030e, 4)},	/* Quectel EM05GV2 */
+	{QMI_QUIRK_SET_DTR(0x2c7c, 0x0316, 3)},	/* Quectel RG255C */
 	{QMI_QUIRK_SET_DTR(0x2cb7, 0x0104, 4)},	/* Fibocom NL678 series */
 	{QMI_QUIRK_SET_DTR(0x2cb7, 0x0112, 0)},	/* Fibocom FG132 */
 	{QMI_FIXED_INTF(0x0489, 0xe0b4, 0)},	/* Foxconn T77W968 LTE */
-- 
2.25.1


