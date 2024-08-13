Return-Path: <netdev+bounces-118093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7669507B1
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 16:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC2CC284A97
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 14:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0501D19D09D;
	Tue, 13 Aug 2024 14:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HmByuc3E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C6E19D086
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 14:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723559581; cv=none; b=Nt6YNGVYrmcMy7xgKHwG9cpG4cEGwjavclQLBh3ecHznJWPQXJ9nuYLAoN3mVYeWuAlvX/vSxwoQd1Y6A5jaEIy414qZc++e02EsvN4ymDzYLt4R3Czkvsa4q5EPujYdqXmYJKK6Uh/8xQfP9PlHwDd+qnOG4yZMXiTT5vly/z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723559581; c=relaxed/simple;
	bh=SASPVryu3QfzrPw/SslZZw8S3rRs3fI25rqzmRvIKBA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OrAZm7KNT9PZ/99Xkfus9XcmNXjiV0joPG5Hr0SqMW3niXcuN+33dk/NOj3g4o09GZAvkrTdKgml1xWDObQ8DvIFk8zOLlBm0MIarLUF9X4dQiawB/CWrA0hQ8dTy66FduX2zIRWH7PY9uULA+y0esTUB8he5OHrqwFjSUh0MqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HmByuc3E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A79A9C4AF0B;
	Tue, 13 Aug 2024 14:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723559581;
	bh=SASPVryu3QfzrPw/SslZZw8S3rRs3fI25rqzmRvIKBA=;
	h=From:Subject:Date:To:Cc:From;
	b=HmByuc3EXo/LtIWM7dk45tqwpnsfPy5s2yVVHAf6jVpVLPiK9ywiO3y6+Wo8wlEEg
	 FJdhd0f1tQray/laRAuYIrtrUDXPAnVMoR7E7MRnO4AI7V8DQXBkg/GGH29QKOLvcs
	 I60M+4LCtYmDT+t0GS6qqfhpM3Iz3yvXwKlfiGg1xgQ6cqmFoE2Wabdx8//Fg3rZeY
	 eQw6+7jKWDTQ1Kut4894X0/uLt4wp6TiQu6RJQvS1ySH90tT1s0LbJHdXjI+nR2SmH
	 IoEHbz1HtixvBBjJxUHKpToINJox7mtZCjNS5Sd5EFFfZ+7fbp7zhv1O1SvVc8Olz/
	 rK/ozYJktmWyg==
From: Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v2 0/2] bnxt_en: address string truncation
Date: Tue, 13 Aug 2024 15:32:54 +0100
Message-Id: <20240813-bnxt-str-v2-0-872050a157e7@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJZuu2YC/2WNQQqDMBBFryKz7pQktUa76j2Ki6ijDi2JTIJYx
 Ls3uO3y8T7v7xBJmCI8ih2EVo4cfAZzKaCfnZ8IecgMRplSWXXHzm8JYxI0tbZOW12VtwHyfBE
 aeTtTL/CU0NOWoM1m5piCfM+PVZ/+P7dqVNi5sbdVQ0Pd0PNN4ulzDTJBexzHD6jMM3GrAAAA
To: Michael Chan <michael.chan@broadcom.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, netdev@vger.kernel.org
X-Mailer: b4 0.14.0

Hi,

This series addresses several string truncation issues that are flagged
by gcc-14. I do not have any reason to believe these are bugs, so I am
targeting this at net-next and have not provided Fixes tags.

---
Changes in v2:
- Added patch:
  + bnxt_en: Extend maximum length of version string by 1 byte
- Dropped the following patches.
  - bnxt_en: check for irq name truncation
  - bnxt_en: check for fw_ver_str truncation
  + The approach I had taken was to return error on truncation, but the
    feedback I received was that it would be better to replace the last
    three bytes with "..." or some other similar scheme.  While simple
    enough to implement, it does add some complexity, and I have so far
    been unable to convince myself that it is warranted. So I have
    decided to drop these patches for now.
- Link to v1: https://lore.kernel.org/r/20240705-bnxt-str-v1-0-bafc769ed89e@kernel.org

---
Simon Horman (2):
      bnxt_en: Extend maximum length of version string by 1 byte
      bnxt_en: avoid truncation of per rx run debugfs filename

 drivers/net/ethernet/broadcom/bnxt/bnxt_debugfs.c | 4 ++--
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

base-commit: dd1bf9f9df156b43e5122f90d97ac3f59a1a5621


