Return-Path: <netdev+bounces-77341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C015087152E
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 06:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F24051C20B34
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 05:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79EA245005;
	Tue,  5 Mar 2024 05:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SSQMB3q4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5437044C87
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 05:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709615616; cv=none; b=DjIhXTuU6++Orwe/wRK3YaM78CZNzvokr4Lwc2LTEu7xc4zoNbfJ85M6e7DrwAMrl2XH33EcgHAqiINUq4U3WSsOAtJjngpmFpA7D0MAcBlVZeiZDLQtJTIlWfm25mhQNX31nn74lTXKrSltrFdpFO9lUfWlVM/6UJeX3B8yL28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709615616; c=relaxed/simple;
	bh=/3h4o42hOv114V99Qal8W1pbkIQRF1dqWQWU8Bt3E2s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o9aYVg1iHrt5kdLFrV45Q6N7Ryql+VAKaCnBpvWP7nrDBj3hIF4QLom7vWoHVdInxp9OXRSXs8HYB+ymuO3AZErA7RodtUlIKlRXt2dZKpwKO+fLVBqqD/s+UOT3ypGmfWFt13DX8T/Z9jI3m1CjIDQhlRxblrxXZueDVpyi9SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SSQMB3q4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C688C433F1;
	Tue,  5 Mar 2024 05:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709615615;
	bh=/3h4o42hOv114V99Qal8W1pbkIQRF1dqWQWU8Bt3E2s=;
	h=From:To:Cc:Subject:Date:From;
	b=SSQMB3q4MC/g2EWzu9/ol4fT/kfaPoI9tO+KaRF+aIPm01un5LQMsVI4/n8TNZDTI
	 OsIAFz2qQLokWwh8AodLv5ngtr2S7iCLpPG8hrDPDSa7ebtZRJj8UaJq/ABu+GplFv
	 XiCS5ARGBvRLiV+qDwZfvHtQB0XG8g7kUxXzKpO8aqKS7qmCa0fJx/MTaSrwucWXuR
	 ZHe7aK1gaUB5D7ivuDaeenA3l58wh2y3UZSciVmiFMMh/ceHZ7B+BzckEVKWK4+/RN
	 HSKit4cbY6MOi4qsA9ESvl4C9mxMpAi2kRcvRyHwnZpXBECby84zkcG/yvMO7CRGPS
	 l3XDErhkeGcmw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 0/3] tools: ynl: clean up make clean
Date: Mon,  4 Mar 2024 21:13:25 -0800
Message-ID: <20240305051328.806892-1-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

First change renames the clean target which removes build results,
to a more common name. Second one add missing .PHONY targets.
Third one ensures that clean deletes __pycache__. 

v2: add patch 2
v1: https://lore.kernel.org/all/20240301235609.147572-1-kuba@kernel.org/

Jakub Kicinski (3):
  tools: ynl: rename make hardclean -> distclean
  tools: ynl: add distclean to .PHONY in all makefiles
  tools: ynl: remove __pycache__ during clean

 tools/net/ynl/Makefile           | 4 ++--
 tools/net/ynl/generated/Makefile | 4 ++--
 tools/net/ynl/lib/Makefile       | 5 +++--
 tools/net/ynl/samples/Makefile   | 4 ++--
 4 files changed, 9 insertions(+), 8 deletions(-)

-- 
2.44.0


