Return-Path: <netdev+bounces-235613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9063DC33485
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 23:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3A02E4EEE43
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 22:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31C534A3CC;
	Tue,  4 Nov 2025 22:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejuBuseI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48B8348475
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 22:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762295961; cv=none; b=cvXeW2gSBSC1lnu30HoOHC12VwNkpyk+YzD0llAi7vONPr+EDN2+x5LMTzXDx14pSaMSMrffxZGkwrUs4ENLB6+m2BUKwZvgdwgYo82+uf41J65+UVkOomfRvN8OvwSV8DktwZFNuNA6TxkIeBXFUodMacWsdzJcNNm5g27Dq3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762295961; c=relaxed/simple;
	bh=u5DCKGRI4IXZokQzlkyrjLd6GRAOJx9KYjbavhXUqwk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AY7EBYIGfZCnaGnkOCWPNAYINfoz5JvNrZY7o0Rl65ZvQMoWWGqZOh4IjLIZYTyyfokJHY8df3ghYAhgbWVclOigXVagQ9SXhS7qEuu/q5mvO3n4qrNmC5SqR2lelt4Ltgbd/KKx/sOkTnuDl00wOe9Nz8egoYf31ujdp8qSs6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ejuBuseI; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b593def09e3so4363834a12.2
        for <netdev@vger.kernel.org>; Tue, 04 Nov 2025 14:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762295959; x=1762900759; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cnQ+dtcwjsJ29cwDu8qPf9gVDNI9igpgmiF2m60jenM=;
        b=ejuBuseI87JgAOzxRxrvLReQMp0JqqTJuPhOkvguFpn5nVDSO7/KW3d2+gTEIvk/Oc
         AOpa9KH6TvDYhKlesIMiiLBYkMxZtMPHTwRAwRCUCkiBuKKDQF3dFntCgupiT2YJI5pF
         gGd8AaCHIiE/qjqhsZNMMIpgxWZmt2OUSMACWpEVymnRkQZF56QYfBYLL+lm0cx1g9j9
         zuiGhe83Vv55T0wkVszwmb0WqD0CS9KYJ5eiGlBxBtgcCcDzO7eR37ES22neTVCf+Dx0
         ZENQLGCNuYhnuQnecfWarMcK6EzySMaiCnjkZ4C59HODLcdv5jNKo3fxBQHa/mKw68EV
         q/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762295959; x=1762900759;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cnQ+dtcwjsJ29cwDu8qPf9gVDNI9igpgmiF2m60jenM=;
        b=vQ/+zKZcVxv3/WDjhOAh3AbOh7ryFIbN5LnzcS5FcfhTc66E4sMe+UnU///Hu/yff9
         FmfjSp3fqfEz9mb9/Rc1HogaIu2JjmTrvGeW64KtMFopTplSM1HH7fl+XEm5OpJZ/hXx
         tKWAjN0y8vzbNwF4oa3o0cdA2N/j+DQLMWwyYKkA1c+NF3M4MFvIprnIdw5u0uo44otq
         qktzPt5/3dbhp3GbVYdTg/JWhPLqQR8FEBV52QdM201hMQUxusTbV2SRRC9uIYrWd1M/
         8Zql7/mqzGOUnSZo3GwNRonBpKWkcJ6ih/zBFxurAAxQybBXAmJU4MMO/WanevMYPXDr
         hGlA==
X-Forwarded-Encrypted: i=1; AJvYcCXXfUENE3bh0oVjdbrRbF6c1fVTNhgejbSrVMhuIdSkOXNb5QDRTe+JJyuIk4iqD8RCErJ/jbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeGWoa4X8/9lRBpd0aEhe/m9zyS3/a0B6VOAko2UjqDmuJzUDq
	NAYKc7FE7e5rY51C9B2nGphaO4dvJabZJSFro5njH7vhiAA2TECDpFWU
X-Gm-Gg: ASbGncuTcob/0Ab9fFJMTx0PCT919y8doOsA8U2kqUPOCwp0ntXf+QeaWR7gqfG9XKN
	Ocwa6AyEmR7MjmJBnUyiTnZpDTB0xejGrCmFDxD189s6gLsjOjPsZcG3eXj34JtWe/jtHaJoZVW
	8jEF6WGeAQ3SiDNrix6Cg7xZSpIm0WR7liTEQ498oVEZO7acC4/uApwaBuREVgtu98ro/ANAPD4
	//zoDaKclHllrXZS3ha2i2t9bPoJSy5nFlSIBeMNcDb3+49JozOMyGdC9L2tw1BxBHc6EZf0SUo
	D+dnHNJkbG4rwh8NITKU+6cPmEVCqziIZQTTJY+ZSFvEsq+EWF/6LFMNrD0vS5YqyZmwhqKQWIS
	5DbTo0a3Q66ONm4/oHM5lOd4UmGce7V6jzOZ9A5m64Pw+86N6KADd0YgBZatemNVLpOZXcw==
X-Google-Smtp-Source: AGHT+IESw972+NQugcgnm78ZKTviYmRok4BWA0JCtmd+JQgIjTPldLbnjKbimXu6x1kSemHZnD8cAQ==
X-Received: by 2002:a05:6300:218c:b0:34e:63bd:81b6 with SMTP id adf61e73a8af0-34f865ff9f0mr1241428637.57.1762295959215;
        Tue, 04 Nov 2025 14:39:19 -0800 (PST)
Received: from localhost ([2a03:2880:2ff::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd682163csm4050602b3a.61.2025.11.04.14.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 14:39:18 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 04 Nov 2025 14:39:01 -0800
Subject: [PATCH net-next v2 11/12] selftests/vsock: add vsock_loopback
 module loading
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-vsock-selftests-fixes-and-improvements-v2-11-ca2070fd1601@meta.com>
References: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
In-Reply-To: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add vsock_loopback module loading to the loopback test so that vmtest.sh
can be used for kernels built with loopback as a module.

This is not technically a fix as kselftest expects loopback to be
built-in already (defined in selftests/vsock/config). This is useful
only for using vmtest.sh outside of kselftest.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 0657973b5067..cfb6b589bcba 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -434,6 +434,8 @@ test_vm_client_host_server() {
 test_vm_loopback() {
 	local port=60000 # non-forwarded local port
 
+	vm_ssh -- modprobe vsock_loopback &> /dev/null || :
+
 	if ! vm_vsock_test "server" 1 "${port}"; then
 		return "${KSFT_FAIL}"
 	fi

-- 
2.47.3


