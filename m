Return-Path: <netdev+bounces-74070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F39D585FCED
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 16:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77B88B268E7
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 15:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C238E14F9F6;
	Thu, 22 Feb 2024 15:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="QVJzY6jq"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7074114D458
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 15:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708616759; cv=none; b=sUoi83G92tJSBChbltCTKG161jDVVBlZF3gp+hU4Y5JQ+eP753P6DXqH/FTlEyrW87PhfTGn5xXf7jea50bKSQXlIU62FZIr94dsftO2Xmlb2RNAbEmjtroVWaIIu72nTCmhUmfHmDTyIldFVrDunkNhrNhNwbnKGUpQqQA3kkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708616759; c=relaxed/simple;
	bh=Bh0Da3JSfl+ibGt4ySOK0ws8zgivacLlRBz5u07iV/E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f4n1sdBnp6rTK2LuQSZ2N9ZfdS1VnXCkL40do9xhtwG1Ok2BIiqKfTBU83ycxeXvdPwOsaWjYiWQhK7VcrYWDo0YyWp8W+2O7h7uy2UoX4Dhbp+2SRwo7S9t89A1pCGyl5JLesYx86yXnTj32X6zvB+P+TuisL5kLTYT0lmTdFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=QVJzY6jq; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from localhost.localdomain (125.179-65-87.adsl-dyn.isp.belgacom.be [87.65.179.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id BC0E6200E2A2;
	Thu, 22 Feb 2024 16:45:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be BC0E6200E2A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1708616754;
	bh=ZE5uJGagotb993cESqVe8P0I8GrfVvj6Bx/r+ceUVZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QVJzY6jqjmoBwyhl1+F2uL9fuP2cEZnAAlCUsbvi/AzUezmQe1+DAu2D7Y+z7schS
	 AEAoxCSNaUrxd4F55Gl4TTsBakLorXUKpwjYx4mKPThYVoDUGryG6NeUc7KPXCJIPZ
	 ZBS3x9+osglS4TSYB7jbs6gF0bPpw8XesPzrd/DuOQtoQtKXkMo/HJGpvY//WdNHKW
	 Xwh89pP1fxUu7xM18kDpGMvxgsjoTidado0TpX8smsAL8LfqLico+AI9ohNiKQtlw3
	 Y+yOljV5hxcfDcFNeBqK27h+LIBzaNpU0j2Chc+Pqa21PbS1nXsPegCesJoqvxUBsi
	 t+7rH09zeoaSQ==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	justin.iurman@uliege.be
Subject: [PATCH iproute2-next 1/3] uapi: ioam6: update uapi based on net-next
Date: Thu, 22 Feb 2024 16:45:37 +0100
Message-Id: <20240222154539.19904-2-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222154539.19904-1-justin.iurman@uliege.be>
References: <20240222154539.19904-1-justin.iurman@uliege.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the iproute2 uapi for ioam6 based on net-next uapi.

Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
---
 include/uapi/linux/ioam6_genl.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/uapi/linux/ioam6_genl.h b/include/uapi/linux/ioam6_genl.h
index 6043d9f6..3f89b530 100644
--- a/include/uapi/linux/ioam6_genl.h
+++ b/include/uapi/linux/ioam6_genl.h
@@ -49,4 +49,24 @@ enum {
 
 #define IOAM6_CMD_MAX (__IOAM6_CMD_MAX - 1)
 
+#define IOAM6_GENL_EV_GRP_NAME "ioam6_events"
+
+enum ioam6_event_type {
+	IOAM6_EVENT_UNSPEC,
+	IOAM6_EVENT_TRACE,
+};
+
+enum ioam6_event_attr {
+	IOAM6_EVENT_ATTR_UNSPEC,
+
+	IOAM6_EVENT_ATTR_TRACE_NAMESPACE,	/* u16 */
+	IOAM6_EVENT_ATTR_TRACE_NODELEN,		/* u8 */
+	IOAM6_EVENT_ATTR_TRACE_TYPE,		/* u32 */
+	IOAM6_EVENT_ATTR_TRACE_DATA,		/* Binary */
+
+	__IOAM6_EVENT_ATTR_MAX
+};
+
+#define IOAM6_EVENT_ATTR_MAX (__IOAM6_EVENT_ATTR_MAX - 1)
+
 #endif /* _LINUX_IOAM6_GENL_H */
-- 
2.34.1


