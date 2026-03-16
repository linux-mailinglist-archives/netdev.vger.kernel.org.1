Return-Path: <netdev+bounces-268194-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KA8DB6wluGmNZgEAu9opvQ
	(envelope-from <netdev+bounces-268194-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 16:45:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA5129CB00
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 16:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 14F523038D11
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 15:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDEBE3A1E95;
	Mon, 16 Mar 2026 15:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="eJOM97oj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60223A1D07
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 15:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773675866; cv=none; b=nxS0BekTh8dvgV1ztGO0c/m9TgSygXAKmCMVwWJCgQhjKJc66pSQuvKBAjT/VAaMKPxWsDX1ByR2BH/Bmp+OcDVXGYytjYdu1HGzjDySC5axBn8BmDupgH9TKJhHHbtQ9i/dlZn5DcDn7viLspu/keesrbbdfEwU9a5NAHg2eIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773675866; c=relaxed/simple;
	bh=S1Xo+tzph7cmeFXZMx8ZrHxNJL5gYJKhpTSSAzayEAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JQmXAxfkWiqkVAki6sliWIQ52X/Weua4rjiHq64VWZ+PseeeKXORtDfnKWbipzUTPkD18I4sTbt5xn4BkQA5MfYU2BQX4ATjPI4b6uyWKWJ6GCrcVwPMbBYEmA3/r66F3C9sB/tCM1ahxqjqorvxDkH0pHSCcUlXlitBwVZbatI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=eJOM97oj; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4852f8ac7e9so56689185e9.1
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 08:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1773675862; x=1774280662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ueCGTq4BkQYag4apKBTeSBa3zFihU0X4tpjxx+NYbg=;
        b=eJOM97oj4nV3LIr7cwrcYs3F2gfN/+5IbtYpGfrjM6zqzh4O4WKRYziA+DDiuia2mT
         2srqyBPh+dVfbzQ8qUyb6rZ1ZNwg9/k7n4Q0BjfrOZBhHIN6U3LGuOm9cQwoj6Wlin0D
         sn69ApiBZfQ+S34fl+Owf28IdQDKovb+coxhok2AGRDukmelmW1RHdwSaJYfjc7AGLtX
         NymQ0UsIVSEgehdt0P6+qSWUHKL5zVCbu5/aUdYqnnUdrVSkIYrueFln+IaRV4PenkBK
         /yL46MbuxWDujikpozfOdcLky+htyxN+sYkBxmBm8YeXl/Fb3KJPAbtFym+csKz3uc1j
         vnsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773675862; x=1774280662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9ueCGTq4BkQYag4apKBTeSBa3zFihU0X4tpjxx+NYbg=;
        b=bsNDSyGwdO3vjLdzunGsBPezdOG2PZlJwbYwtYr/Tq8SzSP5ScKjZiMfL+DBqR9d4i
         As9zdL8btjI2FtPyxpsXwUHbI+IOxBUxdnzPR6PY/LLC2jALWLrsywYB7oYXpk6G0qCT
         lr8TxW8xlO6zni8XDeEwk8EO5QQEV3OJ6o/IdzfYuNn0mT++bMxr2FhetkyzsMUlct5k
         Q3YAQII8Pb4Xdj2PkoMockTekseZ7WNzgaAtBq7f6NOGKKHWWTmSICt6gLds8Xk06jHx
         NVGIFlFnlop4TGSoUIyRKrCQyZ6mXKG7JB5BNxGYyy+GxI+OOQOS1WC6E0RGTpi+Tk/p
         rWPA==
X-Gm-Message-State: AOJu0YwUfLcWalpjqL79+rOzC8y5pAii6VJ76QuB1S0A8DIWLMT0xFrY
	EmDr42//E6n2TCiP8jX27uHmj0qQOLKsW+XUY+YS8kwpYMvHgmPPTa/O8346pNpn8xIbMjXGkrF
	OLQ8FjVM=
X-Gm-Gg: ATEYQzzYBLifwuiKt1uqW5sUxFzrH4FlMI91mjTQVsoJdPXERrfdx7qVMn70Op2/btm
	yH9Dz+9Ixixx+IPWGpie+c+vghL5qzVYocojMaAp/a4od4nXYc7rTVuET75bgv6Yr2E4qnJV2vP
	5StALj1wwZXc+VEzKnN+X7WG8yJWhY6GoHSweM5KJcmwuw0uahKjb8OR4t6xE10Uz/2C7I/NAnF
	a8JcsEt1Lq9zZIytUNKVoj6shjQLzPuRL7fWutT73UvpducaT2ZGll6He2TG7jdRdjowYD2N0l2
	5224ZSlsBcHIY0kFSPIlLAEpzXD6I0k72R1OoEVmPHuP0fTg2kjVqmRw5cGVjNgSCecZdB6qbvc
	/A8pMJD9uNLCHeJgSdtgeKF2yZBvL+xKPw5ouEVGy0aFSyGyMqyvH7Gyn/5pEAW6B+cYCWTCgxK
	WHGy2amc4rgQZyaQ/R8g==
X-Received: by 2002:a05:600c:c4ac:b0:485:33ad:3c9f with SMTP id 5b1f17b1804b1-4855670c164mr224792435e9.25.1773675862201;
        Mon, 16 Mar 2026 08:44:22 -0700 (PDT)
Received: from localhost ([213.195.231.106])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485563f8c23sm168373195e9.1.2026.03.16.08.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 08:44:21 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	dsahern@gmail.com
Subject: [PATCH iproute2-next 2/3] mnl: add fallback implementation for mnl_attr_get_uint()
Date: Mon, 16 Mar 2026 16:44:17 +0100
Message-ID: <20260316154418.625026-3-jiri@resnulli.us>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260316154418.625026-1-jiri@resnulli.us>
References: <20260316154418.625026-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268194-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FREEMAIL_CC(0.00)[networkplumber.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli.us:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 8CA5129CB00
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiri Pirko <jiri@nvidia.com>

libmnl introduced mnl_attr_get_uint() to handle NLA_UINT
variable-width attributes. Add a configure check to detect it
and provide a fallback implementation for older libmnl versions.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 configure           | 22 ++++++++++++++++++++++
 include/mnl_utils.h |  4 ++++
 lib/mnl_utils.c     | 17 +++++++++++++++++
 3 files changed, 43 insertions(+)

diff --git a/configure b/configure
index 7437db4f22a8..ebc0d97a6f26 100755
--- a/configure
+++ b/configure
@@ -366,6 +366,24 @@ check_tirpc()
 	fi
 }
 
+have_mnl_attr_get_uint()
+{
+    cat >$TMPDIR/mnl_attr_get_uint_test.c <<EOF
+#include <libmnl/libmnl.h>
+int main(int argc, char **argv)
+{
+	return !!mnl_attr_get_uint(NULL);
+}
+EOF
+
+    $CC -I$INCLUDE $(${PKG_CONFIG} libmnl --cflags --libs 2>/dev/null) \
+	    -o $TMPDIR/mnl_attr_get_uint_test $TMPDIR/mnl_attr_get_uint_test.c >/dev/null 2>&1
+    local ret=$?
+
+    rm -f $TMPDIR/mnl_attr_get_uint_test.c $TMPDIR/mnl_attr_get_uint_test
+    return $ret
+}
+
 check_mnl()
 {
 	if ${PKG_CONFIG} libmnl --exists; then
@@ -374,6 +392,10 @@ check_mnl()
 
 		echo 'CFLAGS += -DHAVE_LIBMNL' "$(${PKG_CONFIG} libmnl --cflags)" >>$CONFIG
 		echo 'LDLIBS +=' "$(${PKG_CONFIG} libmnl --libs)" >> $CONFIG
+
+		if have_mnl_attr_get_uint; then
+			echo "CFLAGS += -DHAVE_MNL_ATTR_GET_UINT" >>$CONFIG
+		fi
 	else
 		echo "no"
 	fi
diff --git a/include/mnl_utils.h b/include/mnl_utils.h
index 0ddf2932db62..4df9e398e591 100644
--- a/include/mnl_utils.h
+++ b/include/mnl_utils.h
@@ -33,4 +33,8 @@ int mnlu_gen_socket_recv_run(struct mnlu_gen_socket *nlg, mnl_cb_t cb,
 			     void *data);
 int mnlu_gen_cmd_dump_policy(struct mnlu_gen_socket *nlg, uint8_t cmd);
 
+#ifndef HAVE_MNL_ATTR_GET_UINT
+uint64_t mnl_attr_get_uint(const struct nlattr *attr);
+#endif
+
 #endif /* __MNL_UTILS_H__ */
diff --git a/lib/mnl_utils.c b/lib/mnl_utils.c
index 5f6671bf94cc..43b4cd1a9e40 100644
--- a/lib/mnl_utils.c
+++ b/lib/mnl_utils.c
@@ -381,3 +381,20 @@ int mnlu_gen_cmd_dump_policy(struct mnlu_gen_socket *nlg, uint8_t cmd)
 
 	return 0;
 }
+
+#ifndef HAVE_MNL_ATTR_GET_UINT
+uint64_t mnl_attr_get_uint(const struct nlattr *attr)
+{
+	switch (mnl_attr_get_payload_len(attr)) {
+	case sizeof(uint8_t):
+		return mnl_attr_get_u8(attr);
+	case sizeof(uint16_t):
+		return mnl_attr_get_u16(attr);
+	case sizeof(uint32_t):
+		return mnl_attr_get_u32(attr);
+	case sizeof(uint64_t):
+		return mnl_attr_get_u64(attr);
+	}
+	return -1ULL;
+}
+#endif
-- 
2.51.1


