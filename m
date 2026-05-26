Return-Path: <netdev+bounces-291711-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iN/cKeqtFWpkXwcAu9opvQ
	(envelope-from <netdev+bounces-291711-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 16:27:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9BB5D779A
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 16:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29E58306642B
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 14:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717863FE363;
	Tue, 26 May 2026 14:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="jUCdy8Gi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F55358375
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 14:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779805082; cv=none; b=CmlCXKc/0OiLNEVjp3+BS0vt2eYECwqLgLDGfw0Pu8QPSGowtBJGEWZP78YoMnELnMUHbOo0SHI5v4MNKzp0gneTj9S7w41be9floWXO3hVxjo5VCtIjjSUZB3Q8S1eaF1gTCwVVQcRXTYO75VKTNw6bDFyswGWTuEvKP1iEdXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779805082; c=relaxed/simple;
	bh=Kybdz7vMHfQVHVOh6L5fYiSlCH/4zeDGpuUchAH7Tmw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DZEa7aHelPyMfhIuRlTJZxgMWzwnin25dcyQsoHz6q+6QjbqNnghfytiZGikQzLNLqsbP8VtTaNj6GjKBGNNBIjNt2BOcK9XNO0TY1tmVkMiZ9/Ale92GBhLQP4GYC3kBM6kmyA+YEbhKKoligzeDEnV2N8lngnQm9KhSp8iuwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=jUCdy8Gi; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49042aeeb75so56377415e9.1
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 07:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779805077; x=1780409877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g7+ZEzN34eEHBV2XeA10qliUnFt9aIEOrlvbEy+ooC0=;
        b=jUCdy8Gipkt5y1MdcWslWRDMUj8JgIufk+P9hRE/YWr9GaQcjwOmoEt5qBgAPYQJGm
         fhMyOvwnNEu2gT8q+Lvv/ezwTrgG/MzOvWku/AH/ansOg9CipsEdrlnMwU34y8l1KOBS
         yGCk8FHKq99skBMwZv+iY8FPTRruC2IxSIZkuxVmDp5uxYMpN4MARnAqHIs+sktvOObc
         1pxwsRdd+M+ZTolUYkhoBNwfPxVjPj78KRVjKsOlwraDzdYlRmft0W6ufYl0lF/ZAH12
         Csw9U/m2LL0Qt0h8RSMnL6ZGFWkI2K+NcSD0GZMMl1stByq7jSkFkJqHVHn5f1SOp/o/
         VBxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779805077; x=1780409877;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g7+ZEzN34eEHBV2XeA10qliUnFt9aIEOrlvbEy+ooC0=;
        b=ekUkXxVVy4lZDCyKw6Ezp0jJlSnPpFe/EXKaZHK5cmwJmxmysiml8YEh3aiSuckwz9
         wYO6Ol5+CkrWIJ61tHFTgtkPMvUD2RArkgZN3uZ1TRtnUgkdQ0taCuGdiJ003jutK+of
         XbL/RP/Be+TtdSEKLfbhS+WTS6qE6osNobxK4mi6ZCWyglAyQUHx/s6ZV9gqUksdB3Om
         PMPjoWcbCHLGj1eVia6yXho4ik3v/Ylj00S3ajH2CdFUg2cjnAIqBltCBRfmtF5Yq5lS
         8xoJoVInSM8kvsipViJDBDaEZ+JVQTaxi7R+/vGrsfJ5qXf3Bx0PKb05LX18fsDoFBFA
         Itbg==
X-Forwarded-Encrypted: i=1; AFNElJ9rXisEppj7bSajV0/Y5cww1AFzv80YevLsBp2ssk+uz3vCEnwgmSzaJF3XBRMklm1sEyXLD1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaMadkQKmRuYCZOWhpzBe6Yr6jga7SMI2yZfSTngfzTlWabTVh
	sAzfTv1OtnPlaScDGnTnriB6jE41yCnCv6yAMbxd7xvu9H3TY2rGsspmeNIGmR3aSjU=
X-Gm-Gg: Acq92OH1tswIr7AwRX5kRVSCnmxTBVUQH+aLJ02oasdWdOvHUAlIr15deqKRnfn7aCR
	+IQ5jQLlOrUR/6Fle6f3RYtNXcjIutAW7/Wn5slOOzLzflPWnR9UoRwswPR19p0zTHb9mTMz7nJ
	4Rfnm260FmrAOeSwb9/UDNFxY4OlvMsVcT9dFeShoDPEuu341xAcYmzf2hOu9ooF8jnlJ7+XyaR
	4lz7W5KDzTwf3g8R9tlnh3wIeo4lFZW4qoAgb6M2f549wY/NNgrHp13POfIJkIEdJFKDvwmUoMx
	1k6gVL2FdL92DagWLd3UCoq8bhmRzFjbHi/ONiO5u62ii/xwq+hGrsju6m4RoZo/aSIF/xaviXc
	4bQMoq0dYzAMBSbPjhc0umvKYoWe11vL5UnxxjRcCx8ewbysbOHNl7pH0l3a0sJ16H0vRo33/Uu
	eirJvRjEpGyL8+GWxMXP+x5/qWvEQ11UTQuHC/or8wH0E+UZJXEcmtCbIwanJbU6DiqYGKxWofr
	SQRUF+j/INyoAR7mdw1CivwyQ==
X-Received: by 2002:a05:600c:8484:b0:48a:906b:14ca with SMTP id 5b1f17b1804b1-490426cd8c4mr332344195e9.20.1779805076904;
        Tue, 26 May 2026 07:17:56 -0700 (PDT)
Received: from localhost (p200300f65f47db04a716d2bdeddb4813.dip0.t-ipconnect.de. [2003:f6:5f47:db04:a716:d2bd:eddb:4813])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4904526ca21sm323690885e9.3.2026.05.26.07.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 07:17:56 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Max Staudt <max@enpas.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Helge Deller <deller@gmx.de>
Cc: linux-ide@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	"Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>,
	"Christian A. Ehrhardt" <lk@c--e.de>
Subject: [PATCH v1 0/8] zorro: Improve handling of pointers in zorro_device_id::driver_data
Date: Tue, 26 May 2026 16:17:26 +0200
Message-ID: <cover.1779803053.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2934; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=Kybdz7vMHfQVHVOh6L5fYiSlCH/4zeDGpuUchAH7Tmw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqFat2pwUr5NuB2EXH5DJBMYu0MFsCRZClzwm2T O9dYlR4RvKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCahWrdgAKCRCPgPtYfRL+ TkGXB/437E8f30EKdaE8q56oaJt5WlihQ7/3LiGG3zpapj74Iu08O8/GcyZKo9eVo8NUFaoQUo0 0hif3fK8HhAxSruKgus+1EQhLy4QeBS7zZsfKLyQOA2B83qRv2SA46ZptWCnVfQXneJtq5rnt/p z+XAhB5HNmZ0vPCrnsT8fL9BH8Yuh3zYqxT9eUnhr+pmthPLdEZiphMZPNHOU/10eCiEJb0TQUX jspmFLtmTRiWApFBZdcAJAZ22LyP1Ls51jKz1i9KFNk3U1cVVN3KNX/HmgRm8an2jPEYqs0Aq03 oaSi8UN/pRU/wOeZjcBFx1K5Dq0XXmkIHLJB0BQbJ8js9PWI
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
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[linux-m68k.org,kernel.org,HansenPartnership.com,oracle.com,lunn.ch,davemloft.net,google.com,redhat.com,enpas.org,gmx.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-291711-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[baylibre.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.988];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,baylibre.com:mid,baylibre.com:dkim]
X-Rspamd-Queue-Id: 0B9BB5D779A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

this series is about improving the handling of pointers in struct
zorro_device_id's driver_data.

While it's ok on all current Linux platforms to store a pointer in an
unsigned long variable, it involves casting that loses type information.
This can be nicely seen in patch #7 where after profiting from patch #6
the compiler notices a missing const.

Preparing for that change, all zorro_device_ids are converted to use
named initializers, which is also a nice cleanup that could stand for
itself, as it improves readability for humans. (That is necessary
because an anonymous union can be initialized by name, but not using a
list initializer.)

My motivation for this series is the CHERI hardware extension. With that
pointers are bigger than longs and thus you cannot store pointers in
zorro_device_id::driver_data. So this series is also about getting
support for CHERI into the mainline, but I hope the clean up effects
mentioned above are justification enough to accept this series.

The dependencies in this series are as follows:

 - Patch #5 depends on #1, #2
 - Patches #7 and #8 depend on patch #6.

So if the ata maintainers agreed to merge their patch #1 via scsi, and
Geert agrees to patch #5 and that it's also merged via scsi, patches #1,
#2, #6 and #7 can go in without further coordination.

Patches #3, #4 and #5 are only about using the same initialization style
for all zorro_device_id and can go in without coordination.

Best regards
Uwe

Uwe Kleine-König (The Capable Hub) (8):
  ata: pata_budda: Use named initializer for zorro_device_id
  scsi: Use named initializer for zorro_device_id
  net: Use named initializer for zorro_device_id arrays
  i2c: icy: Use named initializer for zorro_device_id arrays
  video: fm2fb: Use named initializer for zorro_device_id array
  zorro: Simplify storing pointers in device id struct
  scsi: zorro7xx: Make use of struct zorro_device_id::driver_data_ptr
  video: cirrusfb: Make use of struct zorro_device_id::driver_data_ptr

 drivers/ata/pata_buddha.c             |  8 ++++----
 drivers/i2c/busses/i2c-icy.c          |  4 ++--
 drivers/net/ethernet/8390/hydra.c     |  4 ++--
 drivers/net/ethernet/8390/xsurf100.c  |  4 ++--
 drivers/net/ethernet/8390/zorro8390.c |  6 +++---
 drivers/net/ethernet/amd/a2065.c      |  8 ++++----
 drivers/net/ethernet/amd/ariadne.c    |  4 ++--
 drivers/scsi/a2091.c                  |  6 +++---
 drivers/scsi/gvp11.c                  | 17 ++++++++--------
 drivers/scsi/zorro7xx.c               | 16 +++++++--------
 drivers/scsi/zorro_esp.c              |  2 +-
 drivers/video/fbdev/cirrusfb.c        | 28 +++++++++++++--------------
 drivers/video/fbdev/fm2fb.c           |  6 +++---
 include/linux/mod_devicetable.h       |  6 +++++-
 14 files changed, 62 insertions(+), 57 deletions(-)


base-commit: d387b06f7c15b4639244ad66b4b0900c6a02b430
-- 
2.47.3


