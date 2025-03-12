Return-Path: <netdev+bounces-174330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3921A5E4FC
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 21:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36EF83B5622
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 20:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDC71E9B32;
	Wed, 12 Mar 2025 20:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJrj1rk8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE6D1ADC6C;
	Wed, 12 Mar 2025 20:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741810026; cv=none; b=bxSGOvDizI+MWX30Zc8dKco5Oh3KFADCqnpo75WNe4gF3OGcIo4fdwz7qdsBNZsEJOV2BQnoxl1Vsd6du62kCJgR2nuQurq28Q1X5fR/+9soGWh5EiLNodAsl2wQ25u9HZmMwJ5kbTfcUwZwOMoswdo2zY5ghgXHHGas+dF5jjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741810026; c=relaxed/simple;
	bh=GBnlE5zE4WucF8iLnWQgHp7rfMGPZL48Cv0Cjo6JR0c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DgJWcaJaVa2UwmMprOT70/X9BrLWofXhnreH5lh6jQ707y4PiZVS5Uh7PUYJvMvkB51PVqILImD0AfOJ5u0DijYWhfFtA8vgv79yO9c3YvXNGeHQfcf4boi7FWyQpdaj0a8Ph7R3j/+oKVDI7QjO6WOddELjI12pLMQlGSQF/n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJrj1rk8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16638C4CEDD;
	Wed, 12 Mar 2025 20:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741810026;
	bh=GBnlE5zE4WucF8iLnWQgHp7rfMGPZL48Cv0Cjo6JR0c=;
	h=From:To:Cc:Subject:Date:From;
	b=EJrj1rk8SH10JTGrI1rXTuUL0AZet2AcGmgdfUz4zYxcQRrigpGaXMG3dPzqHvSdj
	 +iVJV4TOpRjd8EuF8SBHrg0fF98C81nGZnAwtqfMAYo6XzDHrduRxFPfktT93WXluI
	 c83shzuCKLhvIyyD9gXKjWbPyUkCq0gmIwXrc0pWF+/VhCTJ/Mcc/4N9DkWALb1Ul5
	 Er3Rp3p7ipMBTPkyl6VGIQBNHi0YD3TxrwSfIuEb87i9C6cQ6G8qKSmOUIA6fVbtTc
	 FIsCFx5trgPB0IRjbtsjJl+/SqrILQo27p0WJKbl3wJt9eZMc+ubx2RiXsx8vY/0kS
	 gYNFl66xRo1Jw==
From: Kees Cook <kees@kernel.org>
To: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Kees Cook <kees@kernel.org>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v3] net: macb: Add __nonstring annotations for unterminated strings
Date: Wed, 12 Mar 2025 13:07:01 -0700
Message-Id: <20250312200700.make.521-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3457; i=kees@kernel.org; h=from:subject:message-id; bh=GBnlE5zE4WucF8iLnWQgHp7rfMGPZL48Cv0Cjo6JR0c=; b=owGbwMvMwCVmps19z/KJym7G02pJDOkXX6ZsaBFbd7L4Qff7ee+fLpwzK3JG8+8XETckeOTe/ +SrmreQqaOUhUGMi0FWTJElyM49zsXjbXu4+1xFmDmsTCBDGLg4BWAib2oZ/hkVybR8NbAv685Z Z/EsfZbQu0ccAXM+rnJ9W/z97MzvlxQZGRoVjGVtvJw2zIs261gxr/3OTnUPqwVu8xrNTn5+8FR 9GisA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

When a character array without a terminating NUL character has a static
initializer, GCC 15's -Wunterminated-string-initialization will only
warn if the array lacks the "nonstring" attribute[1]. Mark the arrays
with __nonstring to correctly identify the char array as "not a C string"
and thereby eliminate the warning:

In file included from ../drivers/net/ethernet/cadence/macb_main.c:42:
../drivers/net/ethernet/cadence/macb.h:1070:35: warning: initializer-string for array of 'char' truncates NUL terminator but destination lacks 'nonstring' attribute (33 chars into 32 available) [-Wunterminated-string-initialization]
 1070 |         GEM_STAT_TITLE(TX1519CNT, "tx_greater_than_1518_byte_frames"),
      |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/ethernet/cadence/macb.h:1050:24: note: in definition of macro 'GEM_STAT_TITLE_BITS'
 1050 |         .stat_string = title,                           \
      |                        ^~~~~
../drivers/net/ethernet/cadence/macb.h:1070:9: note: in expansion of macro 'GEM_STAT_TITLE'
 1070 |         GEM_STAT_TITLE(TX1519CNT, "tx_greater_than_1518_byte_frames"),
      |         ^~~~~~~~~~~~~~
../drivers/net/ethernet/cadence/macb.h:1097:35: warning: initializer-string for array of 'char' truncates NUL terminator but destination lacks 'nonstring' attribute (33 chars into 32 available) [-Wunterminated-string-initialization]
 1097 |         GEM_STAT_TITLE(RX1519CNT, "rx_greater_than_1518_byte_frames"),
      |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/ethernet/cadence/macb.h:1050:24: note: in definition of macro 'GEM_STAT_TITLE_BITS'
 1050 |         .stat_string = title,                           \
      |                        ^~~~~
../drivers/net/ethernet/cadence/macb.h:1097:9: note: in expansion of macro 'GEM_STAT_TITLE'
 1097 |         GEM_STAT_TITLE(RX1519CNT, "rx_greater_than_1518_byte_frames"),
      |         ^~~~~~~~~~~~~~

Since these strings are copied with memcpy() they do not need to be
NUL terminated, and can use __nonstring:

                        memcpy(p, gem_statistics[i].stat_string,
                               ETH_GSTRING_LEN);

Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=117178 [1]
Signed-off-by: Kees Cook <kees@kernel.org>
---
 v3: improve commit message (Bill), drop whitespace change (Bill)
 v2: https://lore.kernel.org/lkml/20250311224412.it.153-kees@kernel.org/
 v1: https://lore.kernel.org/lkml/20250310222415.work.815-kees@kernel.org/
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
---
 drivers/net/ethernet/cadence/macb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 2847278d9cd4..d2a4c180d6a6 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -1027,7 +1027,7 @@ struct gem_stats {
  * this register should contribute to.
  */
 struct gem_statistic {
-	char stat_string[ETH_GSTRING_LEN];
+	char stat_string[ETH_GSTRING_LEN] __nonstring;
 	int offset;
 	u32 stat_bits;
 };
-- 
2.34.1


