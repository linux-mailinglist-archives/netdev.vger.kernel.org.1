Return-Path: <netdev+bounces-235916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C109CC37108
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 18:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 50055506EE9
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 17:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C18341648;
	Wed,  5 Nov 2025 17:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FzW3I0El"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF01335554
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 17:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762362435; cv=none; b=GUy6ZM+JCx2vNCLNUdYsRsY8A2NfwneIH9NHOqyiq458r/3D6ST//c3bYm+MXWykRfwj3P3bRL6mM2F7SF5BjVbm/DsAQ6UVeHy01JEKkkEmKfWb5HOTO/BwxUq7NRTl5JGQaNCJcS2a7rD2q18lpYiirI31e+PVLtoIR0L4dn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762362435; c=relaxed/simple;
	bh=SHevSYfAflYvIOjcPM2PiuslQ8TTF9Z0OzcTTNZ+A3o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E3MdqmlOe+jnV+6K1MfTIr++NiPsmp8CSTE9hifj0OLbqs2crFByJvUJ7eS5dHRuCGRD8JAuuJ+3WC+v6c0uAW/10bM+rSqcGgeZ8cKZVnGxMzucVPfGeaTn5LOinbFqtqHp7njWasNMSzl3TQU1t3wXMiwa5VYsLCJpH++zqzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FzW3I0El; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-429c1b68cd3so12073f8f.1
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 09:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762362432; x=1762967232; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zDPGEALHiJj9n97uz8lWTxmttupO8bbW3KYaPlpx77g=;
        b=FzW3I0ElRS1rVF1u6ENGSVlsZrvReJOydBvhHHJOsr3/0m3WtZ1VpQ7sC19qDCEkHN
         FsWiRug6SUBYNjVMpzdrzy7qZjTVlYstiOl2q36+degyAcXX6FcqCp2xo/r9qjZsUNBr
         05JSvJgOMn3yYjqFJlBtsG5+fheEh/xtoiy+JTotfcNvkcSay6Kp4LuWjXxQ/SkTT/ID
         SeHqdzUPjgrGL/4GCsKnWMxKNwQ5atiDPC71ISR6Ipa8yOsi/6ZV/cIGr25wZcWrSaLH
         OFir/51nrK+f1xbNl0055mZDoRyFUQ3+tYjQOwuzQimQuq2kAOai11SyqOrrmaNhR4kU
         B2fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762362432; x=1762967232;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zDPGEALHiJj9n97uz8lWTxmttupO8bbW3KYaPlpx77g=;
        b=E+50MM5YZQVeGbwUbqGYHtfXZC3Ll53aEm/cIwurVNHk4+URAkXJLaq6RAD/0wxDyL
         tw+s3LXKVeVJFxICw8hOT+BJQbSF/6i0DqTm/V5jXK34bRqX2+nWdhfXBPsVVjGZTC3O
         Ytrr+cHt5JDnkWckAWOXlj6mEsVhmbcSwLYL8MXVI0oxKW4PcY0c5mOolreu5NNq12LO
         TuM+jVdVuh0v4Px7pxrpKN0+RYiB0R+vV2yFs+TNbfNBMNteC3EcUVuKXSu6jKGGsHkL
         erVoY0L6QEF0rq5clbyiVSp4kanCFHReA28H4gHsQNGY6kHuap+TZH3Xd6PFCSgXyhTD
         mxTA==
X-Gm-Message-State: AOJu0YxhkCcXuoHngDDf5AjApzzU/z62iLwBLbU4uFQfw82VleM3PhEO
	8PO7W++1LkDtWRf2I2YKJ02GX5Hyi53GyE2r62X+ZT8m/Vw6GVxSLca8
X-Gm-Gg: ASbGncvMm5xLNX7MH8t0Rold7rn2ty/A/5C7EHFZvSSQtL/JyCcuPJGOYIL/BcpzMZJ
	EU358rFn3blz5Ox5+P/oB3gplKz/KpN+59nEzgFENvOHxG+lKe1s+SyHI1be8LydCxFjYZhzIrr
	j6ltwoxZMHgTbjM9L4By5JYq69VH4OMSXffkuMl1NS+wZmS5zeZ7qTFEdpyVpDghSbKPIt+ORdZ
	gHUheeIr515e5HMY4DWGUewdx0fsBhxiKH8mNLkdnNonlo4b+Rs1bcTmjOudj9b76RKpa25no4E
	sdyg9BdhD0mwVGLHCqTVQlocq4fiApitJtinHx4Kw6Ub5Qi1rXCEkKQLbokHgVeGEjn3+UhFpp2
	XGcP0aXr/MPqB7XTq6spombpVrS2InjUnS+ATP2rxfxwv1VxJzS8402DUqjs6Z6t/6ux0AWk/Xn
	UTvFI=
X-Google-Smtp-Source: AGHT+IFGFX9DslUYNk9iBEXMdGr7oaOJipOJWDtvY1Tg3EGRYJjFwA8CB5hzyW6XylUnko4CikmxTg==
X-Received: by 2002:a05:6000:2f81:b0:426:f590:3cab with SMTP id ffacd0b85a97d-429e3275af0mr1981253f8f.0.1762362431350;
        Wed, 05 Nov 2025 09:07:11 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:8::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1f9d33sm11871563f8f.36.2025.11.05.09.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 09:07:10 -0800 (PST)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Wed, 05 Nov 2025 09:06:46 -0800
Subject: [PATCH net-next 4/4] netconsole: Increase MAX_USERDATA_ITEMS
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-netconsole_dynamic_extradata-v1-4-142890bf4936@meta.com>
References: <20251105-netconsole_dynamic_extradata-v1-0-142890bf4936@meta.com>
In-Reply-To: <20251105-netconsole_dynamic_extradata-v1-0-142890bf4936@meta.com>
To: Breno Leitao <leitao@debian.org>, Andre Carvalho <asantostc@gmail.com>, 
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Gustavo Luiz Duarte <gustavold@gmail.com>
X-Mailer: b4 0.13.0

Increase MAX_USERDATA_ITEMS from 16 to 256 entries now that the userdata
buffer is allocated dynamically.

The previous limit of 16 was necessary because the buffer was statically
allocated for all targets. With dynamic allocation, we can support more
entries without wasting memory on targets that don't use userdata.

This allows users to attach more metadata to their netconsole messages,
which is useful for complex debugging and logging scenarios.

Also update the testcase accordingly.

Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
---
 drivers/net/netconsole.c                                | 2 +-
 tools/testing/selftests/drivers/net/netcons_overflow.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 8a11b3ca2763..040bae29d485 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -50,7 +50,7 @@ MODULE_LICENSE("GPL");
 /* The number 3 comes from userdata entry format characters (' ', '=', '\n') */
 #define MAX_EXTRADATA_NAME_LEN		(MAX_EXTRADATA_ENTRY_LEN - \
 					MAX_EXTRADATA_VALUE_LEN - 3)
-#define MAX_USERDATA_ITEMS		16
+#define MAX_USERDATA_ITEMS		256
 #define MAX_SYSDATA_ITEMS		4
 #define MAX_PRINT_CHUNK			1000
 
diff --git a/tools/testing/selftests/drivers/net/netcons_overflow.sh b/tools/testing/selftests/drivers/net/netcons_overflow.sh
index 29bad56448a2..06089643b771 100755
--- a/tools/testing/selftests/drivers/net/netcons_overflow.sh
+++ b/tools/testing/selftests/drivers/net/netcons_overflow.sh
@@ -15,7 +15,7 @@ SCRIPTDIR=$(dirname "$(readlink -e "${BASH_SOURCE[0]}")")
 
 source "${SCRIPTDIR}"/lib/sh/lib_netcons.sh
 # This is coming from netconsole code. Check for it in drivers/net/netconsole.c
-MAX_USERDATA_ITEMS=16
+MAX_USERDATA_ITEMS=256
 
 # Function to create userdata entries
 function create_userdata_max_entries() {

-- 
2.47.3


