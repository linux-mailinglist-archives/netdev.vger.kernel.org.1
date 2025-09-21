Return-Path: <netdev+bounces-225024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81612B8D6AE
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 09:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9E04442B99
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 07:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC702D46B7;
	Sun, 21 Sep 2025 07:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ML/YSRdL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F7B2D3ED9;
	Sun, 21 Sep 2025 07:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758439992; cv=none; b=a05OZeBm9dh3VqDFeDx49hCDfWfnLexZPRq7ml2GCtLNJbR9J/99yFI1BOwxvNqKDG2BDZJb2sSIBo7joCqjRmCia0MyZQ90+wuX+MMBR5AvMCOl9wMc7WKhlUeChFEXxyf/Fv/WAoM/94b6QtoIqeJQODiohWUH43Rx9MMPvuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758439992; c=relaxed/simple;
	bh=Nqudqrf3D+5OMMoK0N9TzqYnz2Lpyj+QgiQ/X8KM1WE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R6uSDnzj0Ohlgb8FDA7xlRAvts8Zg9IP/etE4zSBL0NblUiuFo3U+tbc9gmz/AzPaG4s4410088JqvY+FFwk0W4lcvhRDvNAKSRe3rR2rMpYBFHH4fzpCP1oAl1uMAcFpaVk60E7f+RUmEsk3sM4ywgkpsxmvRz/hQrjmeQHFCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ML/YSRdL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C6DC4CEE7;
	Sun, 21 Sep 2025 07:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758439992;
	bh=Nqudqrf3D+5OMMoK0N9TzqYnz2Lpyj+QgiQ/X8KM1WE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ML/YSRdLydC35KtaNa/kuFNEI9zeDZIHR06zAh2Ns2zQy/ZlFeheOdE9DPEe3F5Ef
	 gBuyucEUbLp46feEVuXFkLVKnq1+LzyxLXxbgmdv7fq+KZ0LZuTjKpi6KoWQwWEHHI
	 PYaICDQil/l6p0PMIjVj9KhP5lXdVXt1JMAkorFU3gB5454g/t0VEITBcBdxpCXMVG
	 sZjoxoUmbtTPJ+IoSWtXyfdpI61z1vu4j8X/R8LV8WmhUvLbuo+H11W1neA9NIsZTr
	 L25jKR1KHqdHNa0mQaJRRJICmI1tjUerfpBjxJVYMYPnNY17cnnHxxiPxkyxvpsIEY
	 HENM3JUNmKaMw==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Sun, 21 Sep 2025 16:32:32 +0900
Subject: [PATCH iproute2-next 3/3] iplink_can: factorise the calls to
 usage()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250921-iplink_can-checkpatch-fixes-v1-3-1ddab98560cd@kernel.org>
References: <20250921-iplink_can-checkpatch-fixes-v1-0-1ddab98560cd@kernel.org>
In-Reply-To: <20250921-iplink_can-checkpatch-fixes-v1-0-1ddab98560cd@kernel.org>
To: netdev@vger.kernel.org, Stephen Hemminger <stephen@networkplumber.org>, 
 David Ahern <dsahern@gmail.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>, linux-kernel@vger.kernel.org, 
 linux-can@vger.kernel.org, Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1162; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=Nqudqrf3D+5OMMoK0N9TzqYnz2Lpyj+QgiQ/X8KM1WE=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBnnVxl4ZfNemS8Q5rux7/zysh/si3ItbgvOzN7clfntP
 Hv3LNsrHaUsDGJcDLJiiizLyjm5FToKvcMO/bWEmcPKBDKEgYtTACYiyMbIsIWdzz1Mu6P9QfTB
 z/mGK/+qHg8L8be5m6STbl1ygCvKj5Fh/tTzmovUfaIbXdeGNVlw609o09S68LPunVH/nGt7gxk
 4AA==
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

usage() is called either if the user passes the "help" argument or passes
an invalid argument.

Factorise those two cases together.

This silences below checkpatch.pl warning:

  WARNING: else is not generally useful after a break or return
  #274: FILE: ip/iplink_can.c:274:
  +			return -1;
  +		} else {

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
 ip/iplink_can.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/ip/iplink_can.c b/ip/iplink_can.c
index 56c258b023ef57e37574f44981b76086a0a140db..2a13df7bcf6d404e17cf747f29c682fa80e4f6fc 100644
--- a/ip/iplink_can.c
+++ b/ip/iplink_can.c
@@ -268,11 +268,9 @@ static int can_parse_opt(struct link_util *lu, int argc, char **argv,
 				invarg("invalid \"termination\" value",
 				       *argv);
 			addattr16(n, 1024, IFLA_CAN_TERMINATION, val);
-		} else if (matches(*argv, "help") == 0) {
-			usage();
-			return -1;
 		} else {
-			fprintf(stderr, "can: unknown option \"%s\"\n", *argv);
+			if (matches(*argv, "help") != 0)
+				fprintf(stderr, "can: unknown option \"%s\"\n", *argv);
 			usage();
 			return -1;
 		}

-- 
2.49.1


