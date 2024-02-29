Return-Path: <netdev+bounces-76154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB46186C91D
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 13:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50A56B27BE5
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 12:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7E37D06B;
	Thu, 29 Feb 2024 12:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6j6jiJG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAF54B5DA
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 12:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709209348; cv=none; b=GoyksdMZwCZmF1nHpdykMLAHsNgmftvG42e6XGvQbey3cncata1ZYXOWpH8wLkbL3xAvv46K+fv4HMGdT1q1oDVrmU8NZGCUDJtPwdNzig4ZjPXVGOC//TUL/ntbQExVOK2tp2EfNTg+Hl1kJaKuoAvp031ONtzafULxIJg/40E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709209348; c=relaxed/simple;
	bh=vvaKBmkbqvZitwlnThjeHwWH5jkrFv+vfi1j7UBUs0M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tWwghD4nkXh7eCWDWS50UNB1OhNGarydWsAKbexQAOFLEzJ5A1Cw4bJgnqAnfDxUC++4Pe1aZoOgrqL0D4Fa0kEc38Z7T5VtIAHac1TYyB4UdCP6U/JyXtFbMepuH6rMTjinkNEUJjbPPmOPR+ZylWSPQamHmlqiPaN7Yj7lu8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6j6jiJG; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d262086f0eso1126341fa.1
        for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 04:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709209345; x=1709814145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nlSj74VGtf2vRteSzMknE8uLH47BtRIm6o2UfgiRu/o=;
        b=C6j6jiJG5MigyuIJkQ/Eu+VtEKholXdgjvQKS7SILqCUTnthJiZwPevqKrME5yUqA3
         Wc7x3oLjXWC+03He9pIeWnEAVpHSeJd5348CLhkWahNXdjynjs4lTalw0fh9mck3w7Uy
         X4qP8rNv8rpV8npatKNIj32VhVQ6Z+FEuGiUqc62qbDQev/mKTl7YdpocjznbJFrUQpE
         Mt4okaGoHdfy9UrbrVdTF6w9V/61iSGts+YnuqB+MJaKdHZymEl9Pa1WraPQPgWlhPEY
         XzugNjQ4N4t6JVNW/HKMPvdUrN7rKz19+R+YqTIOIKsJZWbQJHSEpfwpMZtVz9UoId8M
         htQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709209345; x=1709814145;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nlSj74VGtf2vRteSzMknE8uLH47BtRIm6o2UfgiRu/o=;
        b=SZDfY0cVJwDkB2SOgDd2rVCrhZXSEJPcy1c6xs+8Tuztpxt3Am5a2I19emtP8yio/2
         RzjjmGQVc1pvoWzMR4mBTMiKS+jgNrJOOx7YsS9k4KIUxwEze8Iw+NpD6Pe+O4rQk2Tr
         rXpkIa6SUWTBzLP3vYJSdMR7ODuEtZffJkYmTADiRMcjQ2F7lvk4LyIVSUJ5yGVINqBV
         pLl7nsjotOOgebESc/UIOwrFqHTfkbskjBkZXfkxc4hmkXb9KPneYz4+XmZU2G3twmqC
         80wnXu27kZLtfXBfRogVr+qTNUaQaaYUJzPJ8qIY2KfHjusA7AkZCcPFcIP3tgnF3qVU
         UagQ==
X-Gm-Message-State: AOJu0YzzcsXxJTLqePWlhoxopZzuSOqwvLbS8jcKnJNQD3DiicuEQEdC
	8gOEfWNEnXYD0VNBPGdvJmjPMB+H+z9iPgjg1mnRGlDMW3gJxZnxG4FmKQ+b9OQzyA==
X-Google-Smtp-Source: AGHT+IF7gVGJ2Ov1wskMi0x2go5vf1u73YOTU764VC1HkzftNGhOrzuHYgc8CPduv4VQZ/ONzkP2sg==
X-Received: by 2002:a2e:3010:0:b0:2d2:4b57:1c03 with SMTP id w16-20020a2e3010000000b002d24b571c03mr1202889ljw.5.1709209344597;
        Thu, 29 Feb 2024 04:22:24 -0800 (PST)
Received: from localhost.localdomain ([83.217.200.104])
        by smtp.gmail.com with ESMTPSA id o25-20020a2e9b59000000b002d0f0f5e395sm203196ljj.47.2024.02.29.04.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 04:22:24 -0800 (PST)
From: Denis Kirjanov <kirjanov@gmail.com>
X-Google-Original-From: Denis Kirjanov <dkirjanov@suse.de>
To: stephen@networkplumber.org
Cc: netdev@vger.kernel.org,
	Denis Kirjanov <dkirjanov@suse.de>
Subject: [PATCH iproute2 v2] ifstat: handle unlink return value
Date: Thu, 29 Feb 2024 07:22:09 -0500
Message-Id: <20240229122210.2478-1-dkirjanov@suse.de>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2: exit if unlink failed
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


