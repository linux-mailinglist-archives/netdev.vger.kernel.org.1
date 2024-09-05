Return-Path: <netdev+bounces-125722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F8096E5FE
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 00:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44B1F1C22C14
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 22:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71ECE1B3B20;
	Thu,  5 Sep 2024 22:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uscC3UhK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9290C1AD27E
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 22:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725576889; cv=none; b=BfYn0udp9wackEu6dA3BH7nZVeY9cbWd6XeXxQPAnLrYMxhcMk8v4yt9Cppkob2OjAIumO7XTODfMlmgIvA2+yY3/hquiJIXwx8/ki+RTMRz2EzStVj0VvCbafdE1KNwLB5BsQjjpD3hBUo0hJsa30Omvun4HgRQhVCLcPceT1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725576889; c=relaxed/simple;
	bh=66HkfM54qH2Nm2H1gFAcRpEwHxCJvBes7eCPEKmglRc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=H0e4zznyCLgmdg39YeWYdnWm/Bmx808/sLujD6JIzManLf/LR0dq89vt4pF1KCz2ebMtJExNCjr4Y+2U9aGbvYiEHu1xF/L3L5itQYQxWwYAEHbMrK9cKfz2T37xcYa2Ajx264a2NKRJGtdnsRVsW+DPBo4C2EEZOa79B3pTpig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uscC3UhK; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6d3aa5a672dso50733047b3.2
        for <netdev@vger.kernel.org>; Thu, 05 Sep 2024 15:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725576885; x=1726181685; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qe7sMU7CMyVlg4wYJTFuE3k3+t0pyz81i/MJs7LyMxA=;
        b=uscC3UhKNoPmd3MPgjE5fOU3+Hy8QBBMB2yIluMyiiqxTDwzZa0jJQY/BVdTORienQ
         rClVWr9crNx5fuGq5r2OG75vSa8S4tbSFzaBuCyj9OW5gz0/2IYmjLEZf59fRc5toVhw
         yk03bx1ZYJ7eba78hIHFfjc66vqTboAGiBCW5YPgcknvUWDAW8WN460F7/PG2OoJZB+q
         Idmksy5WhVRPk1/IcJxcFtONTFNpBkVA/MMV4JAolLsM1ekhAJtZvxtTREirW/SqBu3B
         02kvhC5qV61UZ9Qd/jSTlu/Ffihv5wsC/ReTwtzTBhLHLfem+HiIuV9G5aSQv3+OfQQ0
         rZXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725576885; x=1726181685;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qe7sMU7CMyVlg4wYJTFuE3k3+t0pyz81i/MJs7LyMxA=;
        b=Wxiy8Wa8PhL/Xa9CJ22Mv3dQM7FA2vzG6nn6W8J665+VrLaP1oqOYoQFKJBbnl5Fgn
         fO2N8gsauK+5ZYszmdfcYdg6c2V+Hm+VKpzwQtYmfB8oKeBjf1LlbNG7Vxku/tFaSml4
         YsCDbRZyZjCM1Wusg7Jh5PBol5qgq6jTrvDi4vlGSDxEbf3PfBNCYRd6Exw0p/P2IszT
         7gNCoatkxuqNJndua4LcjGuSisEtV3Z6FN0QijaIyxjjU+4RGViBrIqH5jHT2NXYgZ2E
         a1I23A4BOdSG6WXoKICH3uD23FPg1WjEfjn9gs8RphEk0Epa5IJDb2Z733rUoaiktUfK
         7DpA==
X-Gm-Message-State: AOJu0Yzqi9d9hLXK+fqRqe9wwMKLRRZyEeV3xlO5F3j/56lUTpdZ4RnC
	WB10LMP5wKp7xiXJM5lQoNGU82h2TOsajUG3tGeRo2cubgK0Y8bOamhTfT3Tspr07VXgbmhNwp1
	/D5rOEVyjPRQY4rf7MdM1Jg==
X-Google-Smtp-Source: AGHT+IHiipRZUHgv/ccItJEywLs+Y6NOEhbv2U3If2FP89J+ZfWB3UgZkzsVQ/3Z/8ti+VzYO35j3OXX0x55cwfimw==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:690c:6711:b0:697:9aae:1490 with
 SMTP id 00721157ae682-6db44d6d24emr479437b3.1.1725576885624; Thu, 05 Sep 2024
 15:54:45 -0700 (PDT)
Date: Thu, 05 Sep 2024 15:54:40 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAK822mYC/x3NQQqDMBBA0avIrDsQo1L1KsWFjmMdaJOQTIsi3
 t3g8m3+PyBxFE7QFwdE/ksS7zLKRwG0ju7NKHM2WGNr05kGk0ZHYUfHitPnx+q9rkhfDUhjECR sm8lWc1sZ++wgd0LkRbb78RrO8wJ4mmU1cwAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725576884; l=3321;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=66HkfM54qH2Nm2H1gFAcRpEwHxCJvBes7eCPEKmglRc=; b=3sARxrIPU3ZnudqZCM032OTV/zeA5NEOV9x8KnT2EwXxEkwIH8WeKVME5iPDE6+d9BOosRs+c
 KbiE6RRz0r9BFT+VUJ+dvhdSIogU0jRN2o0Qb14zPIZ6kHgcEZ6giM2
X-Mailer: b4 0.12.3
Message-ID: <20240905-strncpy-net-bluetooth-cmtp-capi-c-v1-1-c2d49caa2d36@google.com>
Subject: [PATCH] Bluetooth: replace deprecated strncpy with strscpy_pad
From: Justin Stitt <justinstitt@google.com>
To: Karsten Keil <isdn@linux-pingi.de>, Marcel Holtmann <marcel@holtmann.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: netdev@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

strncpy() is deprecated for use on NUL-terminated destination strings [0]
and as such we should prefer more robust and less ambiguous string interfaces.

The CAPI (part II) [1] states that the manufacturer id should be a
"zero-terminated ASCII string" and should "always [be] zero-terminated."

Much the same for the serial number: "The serial number, a seven-digit
number coded as a zero-terminated ASCII string".

Along with this, its clear the original author intended for these
buffers to be NUL-padded as well. To meet the specification as well as
properly NUL-pad, use strscpy_pad().

In doing this, an opportunity to simplify this code is also present.
Remove the min_t() and combine the length check into the main if.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [0]
Link: https://capi.org/downloads.html [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

For future travelers: skb->data + CAPI_MSG_BASELN + 14 is a byte that
specifies the length of the message to follow, and of course "... + 15"
is the offset of the message itself.

Due to this, we cannot use the more appropriate memtostr_pad() because
we don't know all the sizes at compile time.
---
 net/bluetooth/cmtp/capi.c | 32 ++++++++------------------------
 1 file changed, 8 insertions(+), 24 deletions(-)

diff --git a/net/bluetooth/cmtp/capi.c b/net/bluetooth/cmtp/capi.c
index f3bedc3b613a..884703fda979 100644
--- a/net/bluetooth/cmtp/capi.c
+++ b/net/bluetooth/cmtp/capi.c
@@ -248,18 +248,10 @@ static void cmtp_recv_interopmsg(struct cmtp_session *session, struct sk_buff *s
 			break;
 
 		case CAPI_FUNCTION_GET_MANUFACTURER:
-			if (skb->len < CAPI_MSG_BASELEN + 15)
-				break;
-
-			if (!info && ctrl) {
-				int len = min_t(uint, CAPI_MANUFACTURER_LEN,
-						skb->data[CAPI_MSG_BASELEN + 14]);
-
-				memset(ctrl->manu, 0, CAPI_MANUFACTURER_LEN);
-				strncpy(ctrl->manu,
-					skb->data + CAPI_MSG_BASELEN + 15, len);
-			}
-
+			if (!info && ctrl && skb->len > CAPI_MSG_BASELEN + 14)
+				strscpy_pad(ctrl->manu,
+					    skb->data + CAPI_MSG_BASELEN + 15,
+					    skb->data[CAPI_MSG_BASELEN + 14]);
 			break;
 
 		case CAPI_FUNCTION_GET_VERSION:
@@ -276,18 +268,10 @@ static void cmtp_recv_interopmsg(struct cmtp_session *session, struct sk_buff *s
 			break;
 
 		case CAPI_FUNCTION_GET_SERIAL_NUMBER:
-			if (skb->len < CAPI_MSG_BASELEN + 17)
-				break;
-
-			if (!info && ctrl) {
-				int len = min_t(uint, CAPI_SERIAL_LEN,
-						skb->data[CAPI_MSG_BASELEN + 16]);
-
-				memset(ctrl->serial, 0, CAPI_SERIAL_LEN);
-				strncpy(ctrl->serial,
-					skb->data + CAPI_MSG_BASELEN + 17, len);
-			}
-
+			if (!info && ctrl && skb->len > CAPI_MSG_BASELEN + 16)
+				strscpy_pad(ctrl->serial,
+					    skb->data + CAPI_MSG_BASELEN + 17,
+					    skb->data[CAPI_MSG_BASELEN + 16]);
 			break;
 		}
 

---
base-commit: 521b1e7f4cf0b05a47995b103596978224b380a8
change-id: 20240905-strncpy-net-bluetooth-cmtp-capi-c-85b23d830279

Best regards,
--
Justin Stitt <justinstitt@google.com>


