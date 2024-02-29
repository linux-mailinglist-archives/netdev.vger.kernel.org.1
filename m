Return-Path: <netdev+bounces-76155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 614BB86C931
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 13:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E957728DCC1
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 12:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121037D07F;
	Thu, 29 Feb 2024 12:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TIy42kfG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5003B7D08A
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 12:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709209609; cv=none; b=G0rJhYylLaTBq9j+gCtFENbQq6SjTbYb3yWbM0uTT0USxCtsmkqiWOLKsmH82ihuOzU4qGj4zDlmgqSYNXeQtkYYXO2JaKDPu2fe13mND0NaFHgLCjpFDqGlwqgC1S+UPLzxb064k7uNRIdq+LX+Cb2rDKVj5iq3IYq0nzb+LsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709209609; c=relaxed/simple;
	bh=2YXkbtPo3L5nslEvAbULkYqZxKIcgfcsWY1KWrVJdpM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lC7aeC6HyjEaBfn3BUkHLTHcd7PRx4SW12sDgDP2mhBdOpp+R7b0BGiq9MDU09Hkuw0r3Mw9nflWuLKnATmLC8TzvpgwN7mEjz1q+eqYsqav1DtQklmeauJwnynI/Xi1uJ8WW8Ojx970+Xe081tn2uDXCdl8i4bJsfm9lcWonsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TIy42kfG; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-51313743f1bso239504e87.0
        for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 04:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709209605; x=1709814405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IJZbyrIm1wOloYDCmRmj+dLzXjEBcsc7RqD8FjkicSU=;
        b=TIy42kfGxCIV99KdAdyDbId4/MpwWt7aPc59Q4d6m7yA+OgE4v2hYeMkUdenuVescR
         cuG6T0zkRqwvXgGIJ21aTqxZH+4yiL5EkujJExhYlJxmecuVQl7CAqWuDlWQ0ggyJjK9
         x2GKyhCgJri1dbjwIdCxOpiE1/j3Ad4p6JluZWt1rQHoNVPgEFYhQvzoPzevRjh7YOn0
         hMyNgQjEopvOKEVBq/b3dsOlzR9GIz5h/hGNzBQ6CmVtedo5xEWjY5VI+08ZZ7B4dbzc
         +udZ/wkghwgucQ7YYVLw8CU7233eXzZQtfdcb94wtBqMijkWETe75UzEgskBWIJs9yPW
         wpwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709209605; x=1709814405;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IJZbyrIm1wOloYDCmRmj+dLzXjEBcsc7RqD8FjkicSU=;
        b=fuil8+SGUOADRpwdf5MZIGPUrPWE96RTf/1gpl9+MRbIf1y5aYKsimaKWkL5cIvqt5
         oABeX4/0YfnVV1oDDEXnnqFIIktoxlsZO7v4tHyje3ATZEEZsZRpBlj8BSZ8MI3Q8rfH
         8XkNlI6DHX+bE+IXjXr6EDxEX2/eI2UEBuvQVppXMM7cs2dkSBZ6Eq6xoIJQrh5nWAsC
         PxgjVqeY20GO+f98IE4n0KkBcz2Hl3MkPUFbwsCrNbgdkbyvPe5rvdcpfdf2PNAkvltR
         5WMecg/NRiBMWBo8bE4uFWyYpPU/bCJiTkUYEUerMZBUfZR2Y02idaU+RQ/aFX6iuQ3n
         s6Hw==
X-Gm-Message-State: AOJu0YzzpGRy7RjVK+/kl+hUjLNLpV1xSVtNUJuPudWde70E2Fo4S0o0
	Cv21zoxzb1z2XTN90PqNP+OxO4SC8/Y3cHcdAP6G03VTIdHrZbXR
X-Google-Smtp-Source: AGHT+IG2bqaWjxGayUpy3RcfkxeHIebsyqtrWv2fqk/uvcShOaJU33/ouH38heIB0PK6OBbFapoZug==
X-Received: by 2002:a2e:781a:0:b0:2d2:2b2b:ee3c with SMTP id t26-20020a2e781a000000b002d22b2bee3cmr1241879ljc.1.1709209605159;
        Thu, 29 Feb 2024 04:26:45 -0800 (PST)
Received: from localhost.localdomain ([83.217.200.104])
        by smtp.gmail.com with ESMTPSA id y4-20020a05651c020400b002d292045211sm205492ljn.132.2024.02.29.04.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 04:26:44 -0800 (PST)
From: Denis Kirjanov <kirjanov@gmail.com>
X-Google-Original-From: Denis Kirjanov <dkirjanov@suse.de>
To: stephen@networkplumber.org
Cc: netdev@vger.kernel.org,
	Denis Kirjanov <dkirjanov@suse.de>
Subject: [PATCH iproute2 v3] ifstat: handle unlink return value
Date: Thu, 29 Feb 2024 07:26:34 -0500
Message-Id: <20240229122634.2619-1-dkirjanov@suse.de>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Print an error message if we can't remove the history file

v2: exit if unlink failed
v3: restore the changelog

Signed-off-by: Denis Kirjanov <dkirjanov@suse.de>
---
 misc/ifstat.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/misc/ifstat.c b/misc/ifstat.c
index 767cedd4..72901097 100644
--- a/misc/ifstat.c
+++ b/misc/ifstat.c
@@ -937,8 +937,10 @@ int main(int argc, char *argv[])
 				 "%s/.%s_ifstat.u%d", P_tmpdir, stats_type,
 				 getuid());
 
-	if (reset_history)
-		unlink(hist_name);
+	if (reset_history && unlink(hist_name) < 0) {
+		perror("ifstat: unlink history file");
+		exit(-1);
+	}
 
 	if (!ignore_history || !no_update) {
 		struct stat stb;
-- 
2.30.2


