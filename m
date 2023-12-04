Return-Path: <netdev+bounces-53639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFD3803FF8
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 21:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC0E81C20C43
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 20:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE68B35EE9;
	Mon,  4 Dec 2023 20:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="giuZdwZp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7AC2E62C;
	Mon,  4 Dec 2023 20:37:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADC51C433C7;
	Mon,  4 Dec 2023 20:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701722229;
	bh=pp8Z0ECkAh4aGEddlUYiYkyA1y99/QIm+0eQy7iwlDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=giuZdwZpCHAjrOEAyTJXE4NW3ZvfwsCHeedDloX2QNIKDdBw3rnBx5/F5wBHkU+Op
	 wuW61nMLeIdAP+ZBkfTRmCT+i5Qc1T/xYqC490z+4zLSjGyG2N+PIrgbIKUZcIDPB0
	 wwLnisE3HR2WWeEX/gZSkGIQu10Mf/02buHem59MwcDkxM3fLpMnl7Yin/WtH80iWw
	 wmJJZ1GB7lDi0u1fSEWDv8zAKfKaN8rml923zJRkvf5WK573JDgFem5/YjJDmq3S1o
	 J9nurA0IyneJpdfB1Pq51f3GLp5KopuDnZlcXwoSG/QY8yjW8oyXs6Zxpy6QdKyobI
	 yQEqtZnmCEZKg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Edward Adam Davis <eadavis@qq.com>,
	syzbot+b834a6b2decad004cfa1@syzkaller.appspotmail.com,
	Paolo Abeni <pabeni@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	matttbe@kernel.org,
	martineau@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev
Subject: [PATCH AUTOSEL 5.10 3/7] mptcp: fix uninit-value in mptcp_incoming_options
Date: Mon,  4 Dec 2023 15:36:46 -0500
Message-ID: <20231204203656.2094777-3-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231204203656.2094777-1-sashal@kernel.org>
References: <20231204203656.2094777-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.202
Content-Transfer-Encoding: 8bit

From: Edward Adam Davis <eadavis@qq.com>

[ Upstream commit 237ff253f2d4f6307b7b20434d7cbcc67693298b ]

Added initialization use_ack to mptcp_parse_option().

Reported-by: syzbot+b834a6b2decad004cfa1@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/options.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 64afe71e2129a..c389d7e47135d 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -92,6 +92,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 			mp_opt->dss = 1;
 			mp_opt->use_map = 1;
 			mp_opt->mpc_map = 1;
+			mp_opt->use_ack = 0;
 			mp_opt->data_len = get_unaligned_be16(ptr);
 			ptr += 2;
 		}
-- 
2.42.0


