Return-Path: <netdev+bounces-289504-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FVcHzOLDGo1iwUAu9opvQ
	(envelope-from <netdev+bounces-289504-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 18:09:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D971C581FFC
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 18:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1AE9312EAD7
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 15:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83DEE23C4F3;
	Tue, 19 May 2026 15:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="IY+8Hyi5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2761A6801
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 15:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779204984; cv=none; b=CzzC1uvdEg2sVscsunq2yLOTgDVv/G8gAQKeRFu2OQ9MSBKdYiUsdHH0kZLLMjJUIp8xL4sPQdv2fVKrKuncTdWTkQIkRsynD1mejSB7fJYXjp0PPzhxbzhc/qluoMxS8Wxbxk2w+4vpNCWfKX1xd5Vw+w4bG+Idbjwaf9Jirn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779204984; c=relaxed/simple;
	bh=EBBUE7qShvyfN14gNjO3prhA882aTyRYnLBM3i1q2Kc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t6rVuv4DWfrImAs7ZdoAwjImDlvESm+UiJg0D5XlN7I75p/cGq/fjsJoJRXJLwtjpQvUuGA0x0PiiGRwOVjMzMlllS12gaYiYBI1j6kicdTP3seyXmv+fk8bmQ4FNOo3Gz1bx6Kvc5ltoHeBRY5x4Jxm9p7mwgqyu/gOJsgtzz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=IY+8Hyi5; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-44e1860558fso2320530f8f.0
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 08:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779204981; x=1779809781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EHgQsdjh/tw+KP8Pe+oR8xvrCMFKlF9bJwtDE420eOs=;
        b=IY+8Hyi5jskyD6PmLe2shU3Qc+owPSRj87Isn7BPZ90D53m0Qpq4FLusH+4wM8UYHh
         0Ky5eDRsLV+rTlRTo8aABsAjnW6GICZklNrtcvJEn3uWEORNdB8aA22JkAorSu3htCBo
         y4xVbevVSsobYJk1X4sO3AWEIWgmi74dbub3aowZB+jzythlgv6loiF+XNWcLZ3vrCJL
         iTeX6m2K3NlELng6ThPSVj3nMNEjHuZ3sHxpPXBkcpQLA6hdyNSz6i26Jn49EomY2dvv
         DbpXT4VDRtSiJV8QpbGJbpfh3FXy/oL7UNp7LV+ifXe2aOHudRJ08CfXoa7SJaz7zd5s
         xKMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779204981; x=1779809781;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EHgQsdjh/tw+KP8Pe+oR8xvrCMFKlF9bJwtDE420eOs=;
        b=oTWo8jA4UKigIwmqExuRfrxT/VRtNSW+yzCn97ArFDEJ8+eSM9SQoDoxvuPncHvni0
         iKGkfoNOcaLZmkj3vgxRkmEFF2HUS0C6EOIYmGiCZhNtO4aj/6+jmS+Eu7nH+oC2hY5U
         duS3tA8VCQV1E5FtWhxIH+F+cIkzExBmU4DmkrH6pyHJrULF0eKTrMazGAusBWPjVNhF
         kJ8p0H5ABoNuniz8KF5+qnPaz/Wwgy6MjmIb0rtcBLfxihYShmrWb+ouOrS3NC69xHfq
         0IOliYRjy5VLIijMnTtRmO8ocOh2pupMatIMiMzyle8RpZ8n5wGjlLhUw7m8j+AqSpeh
         LtyQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Pe02YZ7IFc5VCdngDNeCjy6K5ikWdy/wrFlOi8EyBzTZ5Qr83sjb08ktYpBSQxB0DpiP74tM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ2vu61DrbwHxDEMfMxBSPJq9VyAOiVHNjuwcmGX5qVufgTkbu
	upqk+P4NNQh27UVmj+T5GFSa2OUdKYFIeivC7LU+/aQD1iltlYd/i+ohkPAbUEWUC+0=
X-Gm-Gg: Acq92OHvD5O4yUOOK2ze2qDb1mw8tgssRnO1j2wCZLgl73VjX0x2bHp5M92p61uLkh2
	rcwn9KP9ogwiXQLvZ3Iee6/1Go2gomDXoBXVBRQ6BvFhbJCirDivuNAJRYznxKVermHWc+Gt1kj
	Qo90qVgFwYfXFloYdMAvWt3T6B1sDtRpnS59XM5PitXFj5ZxSPgR9lcGb2ZcYRtFCE/ebavu5Um
	SDf6CtvpdAjptky5bBZo7Bxxl3afXBfqjOQbIF+TQfPNWLVId5IRPKbYYVt2X6ikqpGiDoT/3Lo
	jely6aTeSh6fQq+jb3XCCjlfy2RcEpaSZ52lXF1kmuYYYGvZxO6IvZ84xq/GQMossVeCfceaczO
	FP5aI1KIhFCpyEZ2RbSJjkJgj5xMIYYEdFGWvd2m6nxLk0Ex2wC3GuKrKZMXO/+IUn/buWNcImZ
	GhTzmagS8z8cfr9fc8birtRUeKvs+3bKb4SoSpF4ryUkNbbr2IdmULJbvZeI1MYKwTDkfxZ5lIm
	okAGf58YItvxdfjZMCqTmoBDQ==
X-Received: by 2002:a05:6000:2401:b0:43d:7275:c1eb with SMTP id ffacd0b85a97d-45e5c5dadeamr32728157f8f.39.1779204978760;
        Tue, 19 May 2026 08:36:18 -0700 (PDT)
Received: from localhost (p200300f65f47db048a8dfcf61053817f.dip0.t-ipconnect.de. [2003:f6:5f47:db04:8a8d:fcf6:1053:817f])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-45da0a1aeafsm48913050f8f.23.2026.05.19.08.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 08:36:18 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] mctp: i2c: Use named initializers for struct i2c_device_id
Date: Tue, 19 May 2026 17:36:13 +0200
Message-ID: <20260519153613.1594429-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1877; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=EBBUE7qShvyfN14gNjO3prhA882aTyRYnLBM3i1q2Kc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqDINtflqiqSRYEphRyq90IVkncL7xfJMx+eoGW coz61bkkv+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCagyDbQAKCRCPgPtYfRL+ TvUpB/4+chmXVG0nW2ZLc93NaMyQNheUmBELFw8n0geXGI5TM3tQYFJkw/hCw1PyIQ4kRENfZcO bdogjf80grxAtzJp1U84szXzhuOzxEWthU6p/ANPqF/ZGL2asWYqNkutz3uBAu5QXowTS4CK4zI 3EbluqRqIjmLdcPgcr5GwgwXgs4NOMLvmJJC8KIRkdXsj5h+ylsZJlccAUVNkvn20dfuU/XEeBB KA/XfTMm+nhnbrJ/1pfxGquDmIlc4juoIda/R3ziO23Boeg/J3VRsO7E/gIxrOkwWtYTS37MOkR TSjVnMz/ma1kvK2buPTJLjiKC3lC8XnhD89uUn9Ve1TD2JJX
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[baylibre.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289504-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[baylibre.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,baylibre.com:email,baylibre.com:mid,baylibre.com:dkim]
X-Rspamd-Queue-Id: D971C581FFC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

While being less compact, using named initializers allows to more easily
see which members of the structs are assigned which value without having
to lookup the declaration of the struct. And it's also more robust
against changes to the struct definition.

This patch doesn't modify the compiled arrays, only their representation
in source form benefits. The former was confirmed with x86 and arm64
builds.

While touching this array, unify usage of whitespace in the list
terminator to what most other arrays are using.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
Hello,

this patch is part of a bigger quest to use named initializers for
mainly struct i2c_device_id::driver_data to be able to modify
i2c_device_id. See e.g.
https://lore.kernel.org/all/20260518111203.639603-2-u.kleine-koenig@baylibre.com/
for the details.

This patch here isn't critical for this quest, as no driver makes use of
.driver_data, so apart from the better readability this is only about
consistency with other subsystems.

This is the only i2c driver under drivers/net/mctp, so this is the only
patch needed to adapt the whole subsystem to the new style for
initializing i2c_device_id arrays.

Best regards
Uwe

 drivers/net/mctp/mctp-i2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/mctp/mctp-i2c.c b/drivers/net/mctp/mctp-i2c.c
index 15fe4d1163c1..24e0dd01f180 100644
--- a/drivers/net/mctp/mctp-i2c.c
+++ b/drivers/net/mctp/mctp-i2c.c
@@ -1101,8 +1101,8 @@ static struct notifier_block mctp_i2c_notifier = {
 };
 
 static const struct i2c_device_id mctp_i2c_id[] = {
-	{ "mctp-i2c-interface" },
-	{}
+	{ .name = "mctp-i2c-interface" },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, mctp_i2c_id);
 

base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.47.3


