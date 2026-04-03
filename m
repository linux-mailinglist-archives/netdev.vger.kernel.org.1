Return-Path: <netdev+bounces-274982-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DavCrqXz2nmxQYAu9opvQ
	(envelope-from <netdev+bounces-274982-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 12:34:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD7239354F
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 12:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96B043066882
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 10:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11B33A9631;
	Fri,  3 Apr 2026 10:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZaLIbfP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7DC3A9D9B
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 10:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775211997; cv=none; b=AwmUDFE1mP/D+YN/wZ287NVDwrSmqnxVlBERUhSxTE564RI3ERe6HVYROeNrr5lzpdR3bI/ILr3Nrak1FpyimIhH+HbnzHpDVMP620CHPKmrJ6+H/LCPbgROlsRqFgkMdd5pTW//Wo3zzu2ItlX0I8E9mWB5q/120yhUxq69n5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775211997; c=relaxed/simple;
	bh=WgSZ53KMk1LgHbNj3HcqjcZVOIYBwlbGXgQqWVdrnvQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qHQ0Sv7oQbhzfUEG6xguQZzDbaWVyhzOeBfZHxX6Jsn8UV9E0hqkNTwPqJzColD7fQGgJYZ7YZEMmxLKKekQXHjMGJpbU8W7gU7DzcopLzS/74eWZAoB6gS+xW6dS19HVa0KKbobHRhkxj2iPY56YyXr3x7Xb+//c6hwZijIXT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZaLIbfP; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-65032e9cf01so1772143d50.3
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 03:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775211993; x=1775816793; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hvUbDBFuXX1XgCD7/hyGIByPDe2/tLwoyl594t1n7f4=;
        b=QZaLIbfPx3MBz6ia4f5BKb02OKxbLf5xtCMRgQh6MdMHkX+Vm8QwiEy+0K/o8LaSVI
         EBti8Dd2Dtn+W6NlbanURUFQRBf1ALLmWXL6t22cXt08FY/Tw9E32MeOmLoRTV7SGkxE
         3ZZAbP3cdwFZgBiI5a+i5laa29Ti5zkKL0NKBW1YsN+L5AQrAmJX1UnDlVTaeTDPP4Sf
         UpGZ6vvVMxvmN4DtUxbSAp76pXj8JnJtOKM1sATVVFJPdoITvgZiLQplt9Evgeru9IUk
         JmN0rmy/wp1n7e1tMFkZ3mQYm+ZR/g8fnqvGYqQuxrgaqIumMTiW/q+QJgbyX6U53v/F
         GBDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775211993; x=1775816793;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hvUbDBFuXX1XgCD7/hyGIByPDe2/tLwoyl594t1n7f4=;
        b=CN7RhKXutY2MSQPPEotD6kYbp9udayRZgdnEW/yo1AAhWkVIcmMLDEHBGfCzgSjbdT
         rLmqgRenHlMWfZjsffpuZo7fL5yNPAVJRtypWjK4kUrlHGtK5HfKOJ2zrJDhzIXZwCOD
         7eedTMKB2DoG8UW+FpaYrhcFVKNC0fAWE5VuBGNQschOQa7tiG1miBCfrLnTjBoc5n1v
         X8EUSO19DnKZt7v9JXp6wDbJeyo2i1mGExojjPZvnZNd76NSr8oHo2jtCn1MKSJ7Tw3I
         AOs/fzhzBLCejQDVmHF41oEtsY+aILfeR7OJkGoG6pcSdXMypCxpGJPzqqKcJa72AzYp
         Vegw==
X-Gm-Message-State: AOJu0Yy5+QzMtc+P0g5DpIPhcoQ/Mtmbd9rddTgvGT0G8bsPh6z7HYb1
	6TfAsqMccQxFOJhoTZKGvNShpPK6eKKFbtWxiFEC/oqbICsGntUb3X7LR/IVXw==
X-Gm-Gg: AeBDieueIlXL/cA0m+xFPuqw9LlYY9TcPr2yamG43N3Zmhth46FwKGvHsERyGZ240wg
	ZIwEX9sLSjfqV7YijTbMFnxSFFt709E+TWtANp7WTujO+i5p0jh6yush4jShdgG0FTdtmFdSvoC
	XZ5IHGHWF+VbE+Hs9MqcNdIkUWcWsNQfqoCcosJJV5+objvY8RX9sW0xqdYWAWw3cpZ6ASq6Ty1
	ZhDxJ2R5ZkLO1Udgw5dKkuPKm5C7dAZpuBkjKfHlgjR5QbqXcsnh2Ra7L2yu7+GNkcaaa4jAaYN
	Ns9bqYpUefWoBYMhc4KHef7ZvhsBUQPLCBXU7NM7A4CS7yNHhhhyYkzHcHcqHKfIN9MjIqE0wZS
	Soyyzw3LWjrgOYTcdd1zoD89PwUJhbTo0P6cmJK5hMdK12YbsbMJ8WHMGtxvNp3wn/B2wZfj1A9
	0ZxtAdx7b/8l2vvmzNmG3ER7n5n3X89d59oUtL+oYRrauQa8Mz+HJ4jyOBxrMtM6A=
X-Received: by 2002:a53:b702:0:b0:650:1d21:d6af with SMTP id 956f58d0204a3-6504880fe6dmr1560961d50.40.1775211993649;
        Fri, 03 Apr 2026 03:26:33 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:53::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6503a9a9271sm2240183d50.15.2026.04.03.03.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 03:26:32 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Fri, 03 Apr 2026 03:26:31 -0700
Subject: [PATCH net-next] psp: add missing device stats to get-stats reply
 attributes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260403-psp-yaml-fix-v1-1-dacee0663903@gmail.com>
X-B4-Tracking: v=1; b=H4sIANaVz2kC/x2MQQqAIBAAvxJ7bmGVkugr0UFqrYUy0YhC+nvSc
 QZmMiSOwgn6KkPkS5IcvoCqK5hW6xdGmQuDJm2oIY0hBXzsvqGTGzUZoxxZ15kWShIiF/3vBvB
 8ouf7hPF9P7A5sWJoAAAA
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-274982-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,davemloft.net,google.com,redhat.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielzahka@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7DD7239354F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit f05d26198cf2 ("psp: add stats from psp spec to driver facing
api") added device statistics (rx-packets, rx-bytes, rx-auth-fail,
rx-error, rx-bad, tx-packets, tx-bytes, tx-error) to the stats
attribute-set but did not add them to the get-stats operation reply
attributes. The kernel reports these attributes in the reply, so
list them in the spec to match.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
This is a small fix to add the rest of the PSP hw stats from Commit
f05d26198cf2 ("psp: add stats from psp spec to driver facing api") to
the get-stats reply attributes.

The pyynl cli tool does not use these attributes for parsing
responses, but other tools, like the ynl-cpp tool, do.
---
 Documentation/netlink/specs/psp.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/netlink/specs/psp.yaml b/Documentation/netlink/specs/psp.yaml
index f3a57782d2cf..100c36cda8e5 100644
--- a/Documentation/netlink/specs/psp.yaml
+++ b/Documentation/netlink/specs/psp.yaml
@@ -267,6 +267,14 @@ operations:
             - dev-id
             - key-rotations
             - stale-events
+            - rx-packets
+            - rx-bytes
+            - rx-auth-fail
+            - rx-error
+            - rx-bad
+            - tx-packets
+            - tx-bytes
+            - tx-error
         pre: psp-device-get-locked
         post: psp-device-unlock
       dump:

---
base-commit: 269389ba539834ec80e4d55583fca2cd70e4dc9c
change-id: 20260402-psp-yaml-fix-20661f0af865

Best regards,
-- 
Daniel Zahka <daniel.zahka@gmail.com>


