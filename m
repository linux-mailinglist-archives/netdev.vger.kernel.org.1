Return-Path: <netdev+bounces-164714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE86A2ECC8
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 13:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 593763A4AD6
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 12:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079991E32A2;
	Mon, 10 Feb 2025 12:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="NlVVzcJW"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659FB1F55E0
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 12:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739191403; cv=none; b=PkpoDijT29lyOdnmwNTMN5jmmn1jm0glsUlZTs8wShYWEXl6uCvvTtSKZpVIpoNuH3JGW1xexWCLbWWmktSZFOq1BAiYWyfGrVKwLcgS6KvbR9kKGqQZ4WQlSQ5vjc1nIIAtwwQNrjkvtRpw44oSDpeA6jW3ZJOVmMWMyi/dL+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739191403; c=relaxed/simple;
	bh=n5NCPa8eV6GZBTdSg6vjn8SkLmwFhcZRcjDhInFN09w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=evecA5laEM7gco9BGyQ7IC816NL48B+WTgZP4AO6KtEw5aYjWyim170zcJhVb3bANFuzdMquS10OVIKliMs5kYO2Iv2bPR+SQjFp6tRsmZ75hQOKOq21VZRLI75zAY/Eth8b0Bhv8nDrRvkhEpP4FNYCJFzmTSssbywZdGYlXfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=NlVVzcJW; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1thSh3-00BOd3-Vh; Mon, 10 Feb 2025 13:15:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From; bh=9jYT+Lwe173M220kQ7BSLEATCHvMhe0NHrGue399DfY=
	; b=NlVVzcJWMAd9R60K80s7VKgFlp+ZKy/X9Ql9QmawAhbY0bqejJ5nAFahDvoJrmn6Pk6RvS+Cp
	bq2oSlVdTkqFI7lgzxT0mfxNGujBPwYFnLpTN0Z77v5Hg9kETL2BvuJMS0D052WlcaEVcom6SiCQ9
	nrwEYfqYzyRvRSCfvbhW4J/j5WPdVJoS9hROLx/Ej3cXOgK99zF+LcquYhCmhuH0LNDpHC0A62Fyj
	DvWTSEs5qevT9JObquY3m+YLsgmznv9R48aBocct2cLaAJiKBu7Z/jrB4oXZz2sXG5k7Oww7r99wB
	dSSdnCHNSMVJ+CmgFYSXZJg+9S02H5VQxuZ7Nw==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1thSh3-00088j-44; Mon, 10 Feb 2025 13:15:17 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1thSgx-007tu3-2Y; Mon, 10 Feb 2025 13:15:11 +0100
From: Michal Luczaj <mhal@rbox.co>
Subject: [PATCH net v3 0/2] vsock: null-ptr-deref when SO_LINGER enabled
Date: Mon, 10 Feb 2025 13:14:59 +0100
Message-Id: <20250210-vsock-linger-nullderef-v3-0-ef6244d02b54@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMPtqWcC/3XNTQrCMBAF4KvIrI3kz9i68h7iIk0nNlgSSWqol
 N7dEATddPneY75ZIGF0mOC8WyBidskFX4LY78AM2t+RuL5k4JQfKaeC5BTMg4yuTJH41zj2GNE
 S06GUlOteUAXl+FlKN1f4Ch4nuJVycGkK8V2fZVanryu33MwIJQo7dlLU6lbgJXZhPphQwcz/E
 bWJ8ILYRjPLWiaVbX7Iuq4fN1HS1wQBAAA=
X-Change-ID: 20250203-vsock-linger-nullderef-cbe4402ad306
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Michal Luczaj <mhal@rbox.co>, 
 syzbot+9d55b199192a4be7d02c@syzkaller.appspotmail.com, 
 Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.2

syzbot pointed out that a recent patching of a use-after-free introduced a
null-ptr-deref. This series fixes the problem and adds a test.

Fixes fcdd2242c023 ("vsock: Keep the binding until socket destruction").

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
Changes in v3:
- Don't touch the old comment [Stefano, Luigi]
- Collect tags [Stefano, Luigi]
- Link to v2: https://lore.kernel.org/r/20250206-vsock-linger-nullderef-v2-0-f8a1f19146f8@rbox.co

Changes in v2:
- Collect tags [Luigi]
- Explain the reason for the explicit set_flag(SOCK_DEAD) [Stefano]
- Link to v1: https://lore.kernel.org/r/20250204-vsock-linger-nullderef-v1-0-6eb1760fa93e@rbox.co

---
Michal Luczaj (2):
      vsock: Orphan socket after transport release
      vsock/test: Add test for SO_LINGER null ptr deref

 net/vmw_vsock/af_vsock.c         |  8 +++++++-
 tools/testing/vsock/vsock_test.c | 41 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 1 deletion(-)
---
base-commit: 011b0335903832facca86cd8ed05d7d8d94c9c76
change-id: 20250203-vsock-linger-nullderef-cbe4402ad306

Best regards,
-- 
Michal Luczaj <mhal@rbox.co>


