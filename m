Return-Path: <netdev+bounces-237004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 66248C42F98
	for <lists+netdev@lfdr.de>; Sat, 08 Nov 2025 17:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 551B34E3837
	for <lists+netdev@lfdr.de>; Sat,  8 Nov 2025 16:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6934C26CE2D;
	Sat,  8 Nov 2025 16:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZbUjJAS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457B825A2A7
	for <netdev@vger.kernel.org>; Sat,  8 Nov 2025 16:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762617724; cv=none; b=affNONbh49x2/22iKjU+5XFCLRe7ODcKb9KafyyKVY2EkqtHryVyFgZFIinrCaePsMRLIzFmf5tOFZ6i1cMsYA4WmpfriDhY61zNRajmLqB8TPQdKID2bPArOk2+wS8WqCoWjBKmP00YVsJGKTJxmVfMRM1ehg2dLj5IhO+Z3jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762617724; c=relaxed/simple;
	bh=SP8z1T+qlVVpgOEY39bC1ez51Ud9AdASTxD/jvP34Z8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CUMRL5e6TLwqj6hmVB0ysw4LLbrEeaEhMuONRZx8EKhU6NLJSBtqsCythzat4P6Q6jf99d3ge7bXx9Or8QUSAT2n63RkhLUwQ3ieYLb8EgcGE4Mu/PvkJu2Djg4/e64XQd6WtPV+Lbby+10/sDoKWbauicWQLjW34PYpHlTi4TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MZbUjJAS; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b99bfb451e5so1073227a12.2
        for <netdev@vger.kernel.org>; Sat, 08 Nov 2025 08:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762617721; x=1763222521; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FYpbI2qDd2ToMrlc8dBEHmpGvANrMWIZX9h8c/Keihk=;
        b=MZbUjJASGHq9WCKo4LZ1khD6kB7doIIxixKz+6bZKWnzkA6k6hSFS0wDRqcNBtqFqQ
         9BxDXM7NARwLpEBlQq292/UWZEniqibqq14boMsKTkRyEwI+GcoXhFw9GCR4ZYbIQ+U5
         v9R7zD7iZ9kj8lYsAvLtcErJNy3Rljt6QyKIoD/VpTOGQDv812MVRRKbUqQWndDPZOeX
         Zw7w/5rEUndx9GtucHQCq/eS/l+ZCW2bbVvy5CrfkxxroauCMRXvKzzI2FU8MjmfC7md
         suaGoiVrzYgtZq0K+E4qNI/JAG06iMLj7GBl1xK0u4QVw/safJJS3meESN7B6J/tbEeY
         tAYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762617721; x=1763222521;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FYpbI2qDd2ToMrlc8dBEHmpGvANrMWIZX9h8c/Keihk=;
        b=l9ygLyMJVBeotSvqIUz8Crk25WX7JQkmTisJY1onJ9zkAqUb0fs3iNxlFQhc/6pBjr
         2W5jrkY5M6NlqTzNSFqpDSE5RVig6P6JNSVNTHR39H33/SLQJ6ErOkE2h1MY9PGjXTxS
         gekVvlLfbE6fcoBqKmgcmLhdmFrpEfHIuNrlELITkYaPXc8hd33/PFOGWGZZD6Hk5jgo
         exDR7mSiQiUclSz9f1O+q5RNW/7voHtxouD1a47kGoZTbvSwpX73OH1hTD103YsKnw6r
         anoVU7xQQu3xvuSdAaodn1b/8vt/dXSivb9O5vPPJkZtacURsRMGatYcp42IabCjjTc/
         44bw==
X-Forwarded-Encrypted: i=1; AJvYcCVsDuhJd9qR/yRAN4IOQYKPJOMeqJfKDKcipKINrDwlOXJiXAlGLbsCiK4em8zWR87SHo17CSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhZuFJGBI8vYRO55gOD5BdXRx3W0gvjeGtXe1rX2p6ZCXLcKXv
	5bUE9QqmG54KlCIXChNO2ay95EKZyxCSDkDNr2ToY0u7GzZ0PAHGAcjJX0RqKtBf
X-Gm-Gg: ASbGnctbiyo3hTOtewrpUoMu2gPSc6qLplmyyzMNIPtIC7L40wrX1TjMtIwrTs/1URr
	fEmGNJXdAiAkCO/JAtgr/xVDcXikRZ+FW/m1SL833BKuUVNqagU+7l1rk+3Dat8/aUmBKsB9tyw
	n9/6BnPnZgiX+g0KHTBQl9txmWxXjTlE7W83OhFixTBvw46ILk2fI0AnlIukbBdNh6gk86L+G3C
	4+/Pn26/9M2j9uPhmznZiT+GKJh/+OrU6ojjY8T9L3Wb7svB+F92ziUoB4RafoT/nJQrb/TMy5z
	7hjlPLTOuBhBnK91aMDZzBfTryzUe/i65ypf4qhErSs9N6jpkmzyTMr5tmGojW6Iu0BXwfke+pp
	sgXSR/Zz45jyRezzF1UO84eXR0OdXLeFrxDmD0GEnWvFs6b82t7QypgML5GVhvEU/g4ifA0JXhd
	aL0YiHzFA=
X-Google-Smtp-Source: AGHT+IHCGCSZhbNlxrVbkMXRN4C1nK7xsiQfSpEwGwQVUYt3YG8Lt+frrWDbMAZVEikAd86U4GMidg==
X-Received: by 2002:a17:902:cf4c:b0:297:eca3:cee5 with SMTP id d9443c01a7336-297eca3d0f4mr25654655ad.39.1762617721363;
        Sat, 08 Nov 2025 08:02:01 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:3::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651042c24sm93003605ad.50.2025.11.08.08.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 08:02:01 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Sat, 08 Nov 2025 08:01:02 -0800
Subject: [PATCH net-next v4 11/12] selftests/vsock: add vsock_loopback
 module loading
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251108-vsock-selftests-fixes-and-improvements-v4-11-d5e8d6c87289@meta.com>
References: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
In-Reply-To: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add vsock_loopback module loading to the loopback test so that vmtest.sh
can be used for kernels built with loopback as a module.

This is not technically a fix as kselftest expects loopback to be
built-in already (defined in selftests/vsock/config). This is useful
only for using vmtest.sh outside of kselftest.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index b611172da09e..42e155b45602 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -452,6 +452,8 @@ test_vm_client_host_server() {
 test_vm_loopback() {
 	local port=60000 # non-forwarded local port
 
+	vm_ssh -- modprobe vsock_loopback &> /dev/null || :
+
 	if ! vm_vsock_test "server" 1 "${port}"; then
 		return "${KSFT_FAIL}"
 	fi

-- 
2.47.3


