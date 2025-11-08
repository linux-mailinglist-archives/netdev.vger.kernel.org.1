Return-Path: <netdev+bounces-237002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB891C42F3B
	for <lists+netdev@lfdr.de>; Sat, 08 Nov 2025 17:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67E5D188CD0B
	for <lists+netdev@lfdr.de>; Sat,  8 Nov 2025 16:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAAAD227EA8;
	Sat,  8 Nov 2025 16:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FbEHNJ87"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667F12475C8
	for <netdev@vger.kernel.org>; Sat,  8 Nov 2025 16:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762617722; cv=none; b=AbYeJ43Iji0h3m5LnMCqZgdxLxmdZwKWUydxIfc4TMl5d+wq3aHIBwJ2epT6ouHjhsk5iMvIxJ5GAxHWrU309fhfklDhRk4lhQuneQSoKGvVsEDR4mpevrC1bhaF+o+XspdFqa2V2qkQwxmwocx/60+de26GChI1DeOstqN3Y9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762617722; c=relaxed/simple;
	bh=rsJoOi2cJHjVoFfWem70mON63FeGD3+bDKAfH1rnKVo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hUwjoA0K/BPxv20OafEYSK4nY6kigKSKDihw7jtNwKC9jAH00+tcGrYQ1hakL03Jq0lU3PtlbSA5rOPrMzIrm1KdoY5j8e3esJ1qTViwJZae98H/TUsDfmV0sppzlZhwrw6fxDpELUX5FELCLu0dqLnZSO2oFcltpNqJDj+fiR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FbEHNJ87; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-297ec50477aso2436865ad.1
        for <netdev@vger.kernel.org>; Sat, 08 Nov 2025 08:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762617719; x=1763222519; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zCZpbzlgXNaHUfpJgg5bp7RfyHhboSaGeDqGPcpEBV4=;
        b=FbEHNJ872s4MpsK3sUgApvMq9Fl7KA5ribPexY6YEakaXYugX+SxvySyj+WgJ5PGLr
         trcMHQkT4TBI2ezTRgl6GQ+YzoZnO8VGPGQ3osNDe4iZ4E9jkZ5oLZZIGcw9ixO4KZMg
         1PTDh5jPZhjX2wjUfNGb2+1moqTVp41rIC+PZYReBUxZcRrTn5NCIdtplun36V+Xpbok
         KlLpgo0Xil5rGQW3b4dQmrnKC4I+ib207dXJMjzyQ6bf9y2gjHFTTYpQWfjIHlBsXlnu
         1NYZ9AMuZfRDlnFKn+tP4GI2285o5K8AnJHNcfc2hAy45ZvsBnn3q5BZFYbwhDHoaWN3
         RwFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762617719; x=1763222519;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zCZpbzlgXNaHUfpJgg5bp7RfyHhboSaGeDqGPcpEBV4=;
        b=OsyR08ZpjqaIJpXuDn99WI9X9rVRzT4zqgPVm4Wc/Cas270b3488RMnwis/8gvoUu5
         7K49olfrW4Y+2YAKmqUbFwU0fZSDxqucjMX4lx0HJIr7hwJLoAM8FYZ5tdBnIUZnmENL
         NdEev0NQ7D4SrkNohEVJruem7ZB0huobkbh3cpiDw6g0tjNZ1SlhNUQ92vNpoxlQXwCk
         v/KAhJ8rkMqN5DR8HYsO7y38fjt+8Vg1x+FsemPrAEO2KIZTfaWNQn5aAUWNAR4ewlzA
         jB0jVdVO+vfsHRg1RHeptQwYxWbmgWayZypXSIkS8MQxUIRlzuXx6yrtHhAI44K3ZJW+
         RUpg==
X-Forwarded-Encrypted: i=1; AJvYcCVMsTJS6rgMri0AsxHXq/KBavYmSnzwOsTB0RLzCBYluDrWpDnD8Q4pbQ36m9zObpyujR6/EhE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb6EcstRqp6+vLK0Y4c3XvfjPgIIzZ5mvmNWEt7TkIR7spA1+k
	EcOkbQhKhsf7mWE5OPHzQNUDmE9TTDDKe+IXMJIjRUO/S9o1iUckNWqB
X-Gm-Gg: ASbGncuqy4kvmmPf4iloNp7LzmJEkkadQ2WInpQV6aL2pdn0T0MGeplMVw3F1sw4OZ5
	WIU8WCptFu0WS+Wny/Ympvv3tAIYDEfvta8iBXmxEC1ZcwjWXRa8ATJN3b4lQ6KajKqUz71PPJJ
	rhr2HToSt6sqKNsPKlpdipcurIhnuehpn+1PFTSNCYuJaqj2ZHyolLr8RHOVxfGWo/1D+tmy3d0
	+gtJxEcTECItMms0yNoG1bVl0omqBleDadmYCwp63r/Y91xQybfT3wziO7CHhY8Zaqd+rDJCZcy
	TYvLllMsEXIVFSk2IbBOmwNLVk2fnEv3ul9rtufyaHFc0q5l2KT0pOzV2/GAJ5I/1hy2kjQMzvK
	hQIIfWL+UYNI9ffhfBNzVH+M10ypeytJSsa3pdJ6avJenxjZgTD+k6d5n0akJTM213NYqvHx/
X-Google-Smtp-Source: AGHT+IE4yGWFg0aIBwiA4LPoKZBjaoo7gZDrHFJPuzyKYWyf6FZGig58eJBXmK4vcD8oY5wVdHAoBA==
X-Received: by 2002:a17:902:f707:b0:295:6850:a38d with SMTP id d9443c01a7336-297c95b383emr64698465ad.19.1762617719452;
        Sat, 08 Nov 2025 08:01:59 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:3::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba90138f614sm8137032a12.27.2025.11.08.08.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 08:01:59 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Sat, 08 Nov 2025 08:01:00 -0800
Subject: [PATCH net-next v4 09/12] selftests/vsock: add BUILD=0 definition
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251108-vsock-selftests-fixes-and-improvements-v4-9-d5e8d6c87289@meta.com>
References: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
In-Reply-To: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add the definition for BUILD and initialize it to zero. This avoids
'bash -u vmtest.sh` from throwing 'unbound variable' when BUILD is not
set to 1 and is later checked for its value.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v2:
- remove fixes tag because it doesn't fix breakage of kselftest, and
  just supports otherwise invoking with bash -u
---
 tools/testing/selftests/vsock/vmtest.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index a1c2969c44b6..e961b65b4c6e 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -548,6 +548,7 @@ run_shared_vm_test() {
 	return "${rc}"
 }
 
+BUILD=0
 QEMU="qemu-system-$(uname -m)"
 
 while getopts :hvsq:b o

-- 
2.47.3


