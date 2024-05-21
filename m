Return-Path: <netdev+bounces-97312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E298CAB72
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 12:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57DD81C206A5
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 10:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79466A8D2;
	Tue, 21 May 2024 10:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="nPt26ylC"
X-Original-To: netdev@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A62D56475
	for <netdev@vger.kernel.org>; Tue, 21 May 2024 10:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716285910; cv=none; b=uaHlyTAuQ3xYaiYVJSznyjORqGnPpJTjH004mp5PmElEzCCIGPk8FC4DxoTbsbWDZIw5tNBHLOm2k8j6W/lSb9BGeMFdo9CHnmVGDKafioK6irWd6zusVeS6SfLx9Cmbezjd+xKF+XCypV7p81Q3TDHckG9bKGDMUaoQoNbCchI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716285910; c=relaxed/simple;
	bh=/5xlKBCktCbNLWhL5lIZlNKc9ed0DGsQ67xMbirCESw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CqcBnTmpLEw+9KlwkJwnvWOMVqkT7YNS/tiacYX8T6bhGgoZwtKtuQ1m1X7lg98hyVViDoT4YUzoDOTCZ++4AM3RFUTHu9U6MBMftl1IvSNvBcHdII22JzY+rYfZ6hh2K+7AMasCrsQEnPGnFdQf7rpNWbXQ+zWxrD0p6zKCRHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=nPt26ylC; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1716285899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FDgQKMSEfS09bUp+y+9EhIpZHnmJFeb1Z2VydKFXoLg=;
	b=nPt26ylCqRRrfwcvlsEtfsqv69lUT7G1IiDVg5w3ShQ0zBeGPdgL4pwOc0XzVWCVYWtNGa
	5oOVOR8ax01jad8J501YglJpZFlK+h2u2wbV11vroTWvqNqQNhGLHpEMZH0S/et859P1eq
	3qK1qD81yzMY0N6c9q7wrXD7JMeGjPQ/Dn6hk8LYijodDe+/96CYDaQlfptzB/46uQ+jXB
	TLrhG8XPPxaJejJ04f49BH96jRQpW1dCT/VZTqgZucS12+99KyWgHWzRPDdQb4nFrkvRRk
	tGxlM1It1oMZ9kKz6j+o79+5P5ZUx62V2a4+6JvtZUcBwC3+X2Pn6e7GYjjTDw==
To: netdev@vger.kernel.org
Cc: dsahern@gmail.com
Subject: [PATCH iproute2-next] ss: use COLUMNS from the environment, if TIOCGWINSZ fails
Date: Tue, 21 May 2024 12:04:52 +0200
Message-Id: <021ce0ff240d23c1feca857cfd2338e525d9345f.1716285674.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Use the COLUMNS environment variable [1] when determining the screen width,
if using TIOCGWINSZ isn't possible or if it fails.  This allows better use
of the available horizontal screen space in certain scenarios, and makes
the produced outputs more readable, as described further below.

All major shells can maintain the COLUMNS variable according to the current
screen size, [2][3][4] but this shell variable isn't actually an environment
variable, i.e. it doesn't get exported to the shell subprocesses by default.
For example, no COLUMNS environment variable reaches ss(8) when it's executed
as part of a shell pipeline or inside a shell script.

Though, users can opt to export the COLUMNS variable by hand, or they can
rely on some other utilities to do that for them.  A good example of such
utilities is watch(1) that exports COLUMNS as an environment variable to
the processes it executes. [5]  Using ss(8) together with watch(1) is rather
useful, and honoring the exported COLUMNS variable makes the outputs produced
by ss(8) in this scenario more readable.

The behavior of shells, which don't export the COLUMNS variable by default,
makes this change safe in the sense of not affecting the usual shell pipeline
workflows or various shell scripts that use ss(8).

[1] https://pubs.opengroup.org/onlinepubs/9699919799.2016edition/basedefs/V1_chap08.html
[2] https://man.archlinux.org/man/bash.1.en#COLUMNS
[3] https://man.archlinux.org/man/tcsh.1.en#Terminal_management_(+)
[4] https://man.archlinux.org/man/zshall.1.en#Configuration
[5] https://gitlab.com/procps-ng/procps/-/blob/master/NEWS?ref_type=heads#L623

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 misc/ss.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/misc/ss.c b/misc/ss.c
index 8ff6e1002060..54f36b39c6bd 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -1175,20 +1175,33 @@ static void buf_free_all(void)
 	buffer.chunks = 0;
 }
 
-/* Get current screen width, returns -1 if TIOCGWINSZ fails */
+/* Get current screen width. Returns -1 if TIOCGWINSZ fails and there's
+ * no COLUMNS variable in the environment.
+ */
 static int render_screen_width(void)
 {
 	int width = -1;
 
 	if (isatty(STDOUT_FILENO)) {
 		struct winsize w;
 
 		if (ioctl(STDOUT_FILENO, TIOCGWINSZ, &w) != -1) {
 			if (w.ws_col > 0)
 				width = w.ws_col;
 		}
 	}
 
+	if (width == -1) {
+		const char *p = getenv("COLUMNS");
+		int c;
+
+		if (p) {
+			c = atoi(p);
+			if (c > 0)
+				width = c;
+		}
+	}
+
 	return width;
 }
 

