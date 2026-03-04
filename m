Return-Path: <netdev+bounces-263831-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MVkLRJBqGl6rQAAu9opvQ
	(envelope-from <netdev+bounces-263831-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 15:26:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B10D7201679
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 15:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7031630AFDFA
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 14:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB493B894E;
	Wed,  4 Mar 2026 14:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="XkjrmNsO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124E93B7B8E
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 14:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772633476; cv=none; b=HpPKvslCRyKpMHd8Xnfd3CGGO6SdVAT69vkX8rCvRPti7be73WzpFdTMUamG2V/U8xj9rBAU7GciqGSrDcHy/dkZ+5ZwoWaGpD9T5qJVsECWPVDav49GkRuIk99TK6lv9xFckCUvAq3sZqmYHejIenxGEzbU6seBuuBWT60X1Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772633476; c=relaxed/simple;
	bh=L6onSgeP0i/CR/T0fs6TwoZRPLWFnP0hb1v4XNEpz5M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HxG2PTNJUhy20uP5f0GXgwe2A/Or4jeI/a/wVGC9XB+qIahvgeCo0nr9X050GMU1NjSTACxo516zGG1RiZTd8dED3S446mAEdYFznxGi6+5i2GS5x2gCufhBVt3AOWFvw30jZNTjxIusW94SxlY2WLUfqIjH8FSjB8yctOF43MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=XkjrmNsO; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48371bb515eso103250375e9.1
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 06:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1772633473; x=1773238273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nIAuE1JjZqpVBKIwRnJy2A1v5jBydrvnuR9w0BJYAr8=;
        b=XkjrmNsO3D4ArrVUwfUS3Q8DuOse4RzDzO/+T+KFaqzZAkIQ58iH+5FMIYbppeDIX3
         +OYtnPURDk+GdL1qFaGxAVwYVoGwqwAPNnRIK0D6NCxu1S17mI0AWz9jb800D/u1B938
         EFeJm58IGhbJc4KH9a6Aya8bLzdMQBeTJLEBtp6ADLbFrhjQJEWv4AdVeUOts29NCn79
         3b3m6RqnSkGC/ySqkLqOCn7MgGeh8n9TBM466WOPJVGVN4bPK/L9NsSFe9RlfMJYDNeu
         1w6aDXmjT3PWmByVwepinND9ImuJ5x4iee8C1I5sVbcPj3XJBpo39VPRLMZ9TyJOGNGn
         WYiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772633473; x=1773238273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nIAuE1JjZqpVBKIwRnJy2A1v5jBydrvnuR9w0BJYAr8=;
        b=mDreDbZeTj14wXXNVZf580AmjFzIOOVMxnjX7uYirL1Xr5K6R3wbPOg5tW3SFnqZ0Q
         1RHeILG8+XLRHaFOLTyseDqcDBgCthG+MlOO3bR956sRSTgFb0hZ0upKkM5hssmS5In0
         NlYf+aFJHUpOB39F1JAU3UJAHGa2Sd4PankJRGwHXZsQ7hVbJFowuqkPesP4zA5gSRD6
         qMARHOIQTbDgvCPNQ7+uhr5s5+3wiKauuW9W+1bqklvzPtqLldZRAbB253S0752qcIs4
         QwJUofZp+97Xe9dnCix+bjgVIZ2N5ovT+ANfyuvaw6D/Az1WZnFWfTjgsiPVrzA6LO7A
         twoA==
X-Gm-Message-State: AOJu0Yz5cM4JPVq1dd5rnZ9yL1I+IkSlWqPG25xOQy33x4Slcg8bx0BB
	tCcGxrGy3cOrG4xA81HNwuPzf6uC8P/MbYcyszUvX/LxosfLQl45hRJV3nJqbVGrLE56Euwa4jg
	BJutgvWZQg5X5XfDSsu76s1Eux813WCB/edmwuqkLIuC/JsOPj3WQnEBrJgFchA7p
X-Gm-Gg: ATEYQzyvRErtz2VdUjOCACy39TPjWfexKQF7F8dgn9H+m5GcodI5fMU+PPbErRRtbwi
	RGzjgIY3fSnJbxqJYe0F6+d5DfaYzN/RimnNbLdGaQEvuOykN3X/cRDphU8Y4FHOmbrOZcMz9ON
	7+eaHDp55YlbfNJDp1L2Zpf8z+D7aT3uVB3BEro7BZFNBJWrnEVJ0Uhi22hJwcwryFq1WCG6yuW
	99VYIIhkuo9f3ZrlwS86/vK60uUT3oXG+fT7xuKykoHxOlGxPy6WeZt3VPUyD7f0BlbA5K8qt5S
	Pa8Kgk9+Cy/VZ9mKppShcMX3tId2Fz9UDvOvt1oq0ZG7y+s1GA2S4V+Hhlenyh0GQVL9u0XZ22c
	N1aFuXELT226c3fbLGgyFEapt6EUMFy/l+p0MG+qZi9IMJyuCsKrrINy7nNoZhCIi3MH5A+54Am
	MLARvW9hKLJ9n9Ix3/TWmpkC1//jmiIxCl9OKl
X-Received: by 2002:a05:600c:1986:b0:480:f27c:6335 with SMTP id 5b1f17b1804b1-4851988f93fmr33187455e9.25.1772633472906;
        Wed, 04 Mar 2026 06:11:12 -0800 (PST)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:a0bf:2e2c:7b05:bce6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b55df68dsm24159305f8f.26.2026.03.04.06.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 06:11:12 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Antonio Quartulli <antonio@openvpn.net>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Ralf Lici <ralf@mandelbit.com>
Subject: [PATCH net-next] tools: ynl: add uns-admin-perm to genetlink
Date: Wed,  4 Mar 2026 15:10:09 +0100
Message-ID: <20260304141020.23270-1-antonio@openvpn.net>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B10D7201679
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[openvpn.net,kernel.org,gmail.com,mandelbit.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263831-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[openvpn.net:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mandelbit.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,openvpn.net:dkim,openvpn.net:email,openvpn.net:mid]
X-Rspamd-Action: no action

GENL_UNS_ADMIN_PERM may be required by protocols using
the `genetlink` family, however, this flag is currently
only allowed in `genetlink-legacy`.

Add it to the list of possible values in genetlink.yaml too.

Cc: Simon Horman <horms@kernel.org>
Cc: Donald Hunter <donald.hunter@gmail.com>
Link: https://github.com/OpenVPN/ovpn-net-next/issues/33
Suggested-by: Ralf Lici <ralf@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---

As described in the linked GH issue, we hit an issue with OpenVPN
running in a user namespace that was unable to send netlink
messages to the ovpn kernel module.

After checking how other modules handles this, we saw that we
required the uns-admin-perm cmd-flag. However, this flag is allowed
only for genetlink-legacy protocols, which ovpn is not.

I don't see a clear reason why genetlink shouldn't have this flag too,
hence I am proposing this patch.


 Documentation/netlink/genetlink.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/netlink/genetlink.yaml b/Documentation/netlink/genetlink.yaml
index b020a537d8ac..a1194d5d93fc 100644
--- a/Documentation/netlink/genetlink.yaml
+++ b/Documentation/netlink/genetlink.yaml
@@ -262,7 +262,7 @@ properties:
               description: Command flags.
               type: array
               items:
-                enum: [ admin-perm ]
+                enum: [ admin-perm, uns-admin-perm ]
             dont-validate:
               description: Kernel attribute validation flags.
               type: array
-- 
2.52.0


