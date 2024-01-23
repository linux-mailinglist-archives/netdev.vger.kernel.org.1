Return-Path: <netdev+bounces-64930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5645E837EB0
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 02:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D97AC1F28F58
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 01:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC11F61667;
	Tue, 23 Jan 2024 00:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G3Lo3qW7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2314B612E0
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 00:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970757; cv=none; b=BxLtWqw/xMcO6XuC8iu8QlL4RAqfcyXLZjjjXWuAs1x9Llm5XJsi4nPCsFEv0HhGXQcvDQb/WJ6t0Ye4XItphHaenylfuH46/HLWOUXAjOLD+ONf+7CDLGPBmBpCk47yLLOQuBt4sNGo2RqKtbH7y2IqRCrV8PkRH/VYWN1Z6y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970757; c=relaxed/simple;
	bh=wEJz6ncP+qRtXKX7k2D+joSrafVF4O5OSdQFr3cojK4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oLBLCXQDu/zxeKe11MnT+LmuI/1qiIHdDRr+z7KqwQ4n3V87KpZ2Y5m1HA48ZIVHiUlAONILUR99LpE9MxeWYDkScDailtBXmOxLiBlrzV2oNbwYTGETN03maGGL00AV2Xar0iXN27FTL3XLieGiQvf1p+QE4uqLtIy5OLfJ1hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=G3Lo3qW7; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5997492d71cso1328147eaf.2
        for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 16:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705970755; x=1706575555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dOtaS8Q/PpRJgiodelWT3IFfX/962bDrzicKtXvnvo8=;
        b=G3Lo3qW7qs+sdo6ikHuS/j4yt/01dQGAj9Ib1ApRTJyVwP3IEiI4DgknpJ89s7oXCh
         aVFUzX2sLjVajlDTA9YmvkTVVJVylqhmBNcZV7VzqZKuSA4tWuWouW9/FkvqsoGjpREQ
         w6k9tubHuLfMzKDj5I3iOuYTQh5vxAE8WY+q0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705970755; x=1706575555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dOtaS8Q/PpRJgiodelWT3IFfX/962bDrzicKtXvnvo8=;
        b=FLY5QvBfmi1k6ynPaFKXLfuZj2QVLLOKnACcJ4+seskAyxdfcRB8TOCUjNwXLfZNHO
         cSt0FVTz2mpW0H8/YBf9PdTpxWtUjKseLaDvzA29uSJLRGRrq26AKNrztBL7R+hVxIaw
         EgnclkQj6e6shzPSRm4I7JQu5F12mOtBnuWI5T8ltloXtmey0S/y33tl/RAEIPeHJHRw
         EdNIiEwMhUQ4qwQOgsrE/OT+Qw5OR/peGwAHPaTuqSFpvFxtmi2K0dHaotGVtBgkWoVS
         XO9XpeuYEeQSnkiF+mlbkYTP0j7QHTtqm4dPr1mhmWDabDywW5ir7B0J9dxT2jZPLPlO
         cZSA==
X-Gm-Message-State: AOJu0Yxo+jXH2uZXX1cLCFVZD/3nXEWqh00Mz/aKhVXwO/KdhVOpIKw0
	VDNIpbgZpmD5jYKlC/CwYajPGdtQFD+deV72wKV1iG+lkI7TcEqeVhOEt4QZQA==
X-Google-Smtp-Source: AGHT+IGQwShADBm43GhljCU0u40cOaLZ1q4WsuoH3YKek1HoSlz9pHA07/Hox4IaetxxaQSRrpFeCQ==
X-Received: by 2002:a05:6358:99a0:b0:176:3e0d:9910 with SMTP id j32-20020a05635899a000b001763e0d9910mr4500624rwb.0.1705970755199;
        Mon, 22 Jan 2024 16:45:55 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g4-20020aa78744000000b006d9bb4400f0sm10234582pfo.88.2024.01.22.16.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:45:54 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 32/82] vringh: Refactor intentional wrap-around calculation
Date: Mon, 22 Jan 2024 16:27:07 -0800
Message-Id: <20240123002814.1396804-32-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2682; i=keescook@chromium.org;
 h=from:subject; bh=wEJz6ncP+qRtXKX7k2D+joSrafVF4O5OSdQFr3cojK4=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgHD0u3YhpYy/8Dc5chh0+01JehokeF1vpzI
 BT65uKVfgWJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8IBwAKCRCJcvTf3G3A
 JpFyEACdChSCT4Y0X47ea6T+PsrgS42Vou9eXn9FDMWCPIbD1kW1gHAFP1FAqkYnEij+0625LYZ
 2RtZVv0zZFrtRaGdtFZFQFDJTSr6QNj3uxivVtsmwb1pLXXDnFTFWikADuH5v60qkgSrb2bTZMY
 knyNpBo6L+ItzkaxgMhFX1rtdBM2iTj2HOYKmNkYIwvxCNExT4h+7TKnDNipWpdd5EwB3nV3F2p
 1pExl5eEqmY2Ma6oIf7cypf/bIKRIjUW1Ilre5bbCngLzeYZMqOG35bUlr3WC3w88nu6tYBXolx
 Erl0eGsiamN+wyuoxNKoT/h+WyXer3JpoxEq/sl38I39B23XaYVff/d+6Suvc+F3tV6jNdbyaem
 JxwjjNG4ksbLc5PdSetTuaRGyP3xwIiVRJmS3tlng0ghnRbKVS/FFw+qU64g1HMXFJ/qj6Ldypv
 ORamulyXPJU2FWA/g8/Ld+OnSQn41XCT6619haypc24tpwo9TMSlKhckwkeIgqTxMWBfiha0co8
 ANuXzPXBosDOYCZNhGhwsT9JNpMKS9otU4fcb4uoJ2RtASuAmGm82JgroIBM/MhrLeYmlZOwIk4
 jIzar8S+YFZz03aIUIiOxVH9cIhd+DZLz1UZb5Pc9SBnZc4u8HlyhSQOPf8eOZtvyR3Q+n8534w TxS3x9dEXm4+h9g==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In an effort to separate intentional arithmetic wrap-around from
unexpected wrap-around, we need to refactor places that depend on this
kind of math. One of the most common code patterns of this is:

	VAR + value < VAR

Notably, this is considered "undefined behavior" for signed and pointer
types, which the kernel works around by using the -fno-strict-overflow
option in the build[1] (which used to just be -fwrapv). Regardless, we
want to get the kernel source to the position where we can meaningfully
instrument arithmetic wrap-around conditions and catch them when they
are unexpected, regardless of whether they are signed[2], unsigned[3],
or pointer[4] types.

Refactor open-coded unsigned wrap-around addition test to use
check_add_overflow(), retaining the result for later usage (which removes
the redundant open-coded addition). This paves the way to enabling the
unsigned wrap-around sanitizer[2] in the future.

Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
Link: https://github.com/KSPP/linux/issues/26 [2]
Link: https://github.com/KSPP/linux/issues/27 [3]
Link: https://github.com/KSPP/linux/issues/344 [4]
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: kvm@vger.kernel.org
Cc: virtualization@lists.linux.dev
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/vhost/vringh.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
index 7b8fd977f71c..07442f0a52bd 100644
--- a/drivers/vhost/vringh.c
+++ b/drivers/vhost/vringh.c
@@ -145,6 +145,8 @@ static inline bool range_check(struct vringh *vrh, u64 addr, size_t *len,
 			       bool (*getrange)(struct vringh *,
 						u64, struct vringh_range *))
 {
+	u64 sum;
+
 	if (addr < range->start || addr > range->end_incl) {
 		if (!getrange(vrh, addr, range))
 			return false;
@@ -152,20 +154,20 @@ static inline bool range_check(struct vringh *vrh, u64 addr, size_t *len,
 	BUG_ON(addr < range->start || addr > range->end_incl);
 
 	/* To end of memory? */
-	if (unlikely(addr + *len == 0)) {
+	if (unlikely(U64_MAX - addr == *len)) {
 		if (range->end_incl == -1ULL)
 			return true;
 		goto truncate;
 	}
 
 	/* Otherwise, don't wrap. */
-	if (addr + *len < addr) {
+	if (check_add_overflow(addr, *len, &sum)) {
 		vringh_bad("Wrapping descriptor %zu@0x%llx",
 			   *len, (unsigned long long)addr);
 		return false;
 	}
 
-	if (unlikely(addr + *len - 1 > range->end_incl))
+	if (unlikely(sum - 1 > range->end_incl))
 		goto truncate;
 	return true;
 
-- 
2.34.1


