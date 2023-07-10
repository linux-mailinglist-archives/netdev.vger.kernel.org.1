Return-Path: <netdev+bounces-16444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FC674D3D4
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 12:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40BCA1C20A6A
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 10:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1905E566F;
	Mon, 10 Jul 2023 10:45:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A99C53AC
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 10:45:47 +0000 (UTC)
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615DBB2
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 03:45:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1688985944; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=eKugcaTQvQ7movS4ION/i/M1KvjH198qwAYwEv21cbt78WL7dkA1eg+SqwU5RSrLi+Fx9nfTTNC47cIg6dSd0sVZJrS1VXwryQoAvEiGu/lGIvsRk8U6XAUCBvTgjbtYaF6RmDSTcDfYFf1GqRoLg/teE13goOxrXYlzTjF5xXY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1688985944; h=Content-Type:Content-Transfer-Encoding:Date:From:MIME-Version:Message-ID:Subject:To; 
	bh=RTS/TsyC/4Gh1Zssj1tnKs2UBX6NP4jzknFTNWu4MeU=; 
	b=LOk15WdPbIf3kt1oR1XqPwi8HUOTm/gcpa61oqaDSjNT2aNynCOvskxFhWyqPsoreMqYxsLrdnF6480k8x+Mswk4lcTszH80FzH6M8NW4Xs/kdrwm1hLf878Z+wubaslRDob/1l6dYm13U3RCrvQtHWlqHneT1pDTfvQHOnjvaU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=chandergovind.org;
	spf=pass  smtp.mailfrom=mail@chandergovind.org;
	dmarc=pass header.from=<mail@chandergovind.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1688985944;
	s=zoho; d=chandergovind.org; i=mail@chandergovind.org;
	h=Message-ID:Date:Date:MIME-Version:To:To:From:From:Subject:Subject:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=RTS/TsyC/4Gh1Zssj1tnKs2UBX6NP4jzknFTNWu4MeU=;
	b=Yg6aynOVumyLAJDGHJtq22w7xcVFCCS34REPjAngPzjtoXmNYR8UE+0WcIiljNRF
	wlWqtIo/KB4bt7v6Fkb0Rv0Qu2SIRyIRnKvUo065U+QWjpu7tD1wEcU27N1j+8n3DV0
	4Iu48dghTotLplq4nQe3mWcRau+RtsvzL4Ihw06k=
Received: from [192.168.1.43] (101.0.63.112 [101.0.63.112]) by mx.zohomail.com
	with SMTPS id 1688985942103311.409885598654; Mon, 10 Jul 2023 03:45:42 -0700 (PDT)
Message-ID: <2d76c788-4957-b0eb-bd5f-40ea2d497962@chandergovind.org>
Date: Mon, 10 Jul 2023 16:15:22 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To: netdev@vger.kernel.org
From: Chander Govindarajan <mail@chandergovind.org>
Subject: [PATCH iproute2] misc/ifstat: ignore json_output when run using "-d"
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

If ifstat is run with a command like:
ifstat -d 5 -j

subsequent commands (with or without the "-j" flag) fail with:
Aborted (core dumped)

Unsets json_ouput when using the "-d" flag. Also, since the "-d"
daemon behaviour is not immediately obvious, add a 1 line
description in the man page.

Signed-off-by: ChanderG <mail@chandergovind.org>
---
  man/man8/ifstat.8 | 3 +++
  misc/ifstat.c     | 1 +
  2 files changed, 4 insertions(+)

diff --git a/man/man8/ifstat.8 b/man/man8/ifstat.8
index 8cd164dd..2deeb3b5 100644
--- a/man/man8/ifstat.8
+++ b/man/man8/ifstat.8
@@ -16,6 +16,9 @@ by default only shows difference between the last and 
the current call.
  Location of the history files defaults to /tmp/.ifstat.u$UID but may be
  overridden with the IFSTAT_HISTORY environment variable. Similarly, 
the default
  location for xstat (extended stats) is /tmp/.<xstat name>_ifstat.u$UID.
+
+The \-d flag starts a daemon. Subsequent \fBifstat\fP invocations 
connect to
+this daemon to fetch statistics.
  .SH OPTIONS
  .TP
  .B \-h, \-\-help
diff --git a/misc/ifstat.c b/misc/ifstat.c
index f6f9ba50..08f0518b 100644
--- a/misc/ifstat.c
+++ b/misc/ifstat.c
@@ -888,6 +888,7 @@ int main(int argc, char *argv[])
  	sprintf(sun.sun_path+1, "ifstat%d", getuid());

  	if (scan_interval > 0) {
+		json_output = 0;
  		if (time_constant == 0)
  			time_constant = 60;
  		time_constant *= 1000;
-- 
2.36.1.299.gab336e8f1c


