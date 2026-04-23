Return-Path: <netdev+bounces-280683-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IrDLrjp6Wm2nAIAu9opvQ
	(envelope-from <netdev+bounces-280683-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 11:43:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 312BF44FEA3
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 11:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48F963021714
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 09:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C07C3E3DAD;
	Thu, 23 Apr 2026 09:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="DvmmPLuU"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B3E30E0FC;
	Thu, 23 Apr 2026 09:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776937314; cv=none; b=PrhEXDyQgkZOxQZqrGVzSeD0NySBGtBFuIpg9FrarcEOkBo4xdb+uWyb4sQ4tDO6TYSYxiUtLRT7uaTJYg38TaLTaocfgVKz/am23Bs3ETa6DyMS8hgZDg7k5FRKTIkncrQjTPhNZD3Ir6j4Q5x51SrVZVwwPrsZk864RiIIWow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776937314; c=relaxed/simple;
	bh=yPQzRlotaICidFf4b3L3Ohyn7dtDX0gqvtrmn35l5IY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=d+bbOFva80dVIa0RtGw1Y3Ru7TKL7IMRMw3avOWpZ9mZkJboMmol+Tl7XxjMQFtn2DJqL1wJfWA9E8JApRm6rMgmhci90OgGHvIP07BCSpkmV/cOp1lJQyTU7n0tmP4Tn+oYzm4SvWFt7nEhlYyeTao2HAlcgm3o4+vQ1Z9p0y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=DvmmPLuU; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=NJeeDF5ovZcr7LJof0hitJHWjcITAQzayd1qTKh4yT0=; b=DvmmPLuUn8mxdi8K3D9tm/wNGW
	AL52tBSjGpUW8GgpO+uGIpYhv246B0GGjEH8UMuaA9h4sbLK6/0oP67LhaI+Uk1kw0ugi1t4BYYtt
	DKzNztoPIHjxs/RYC6SlC6mv2da35ixE/4CS+Hbt6YG126eDqUiMU5NHDBhVFdJG1FMw5RIrDgLXv
	uI2uIShdWfPQShL4tUZ6FG35Yj/oXGlNvt5mmhMO5bAkC7XiZPNu7AJI0uekD4oUy9Ieh2tfzVbMc
	oAO0CU7Tc4zcB+5o+P+dIKiXjLE5eZU1GzqCgFS/FkMKV4hPfVHk6rxxWQn5aVRfDpFEJhXUQXvPg
	/+TLNVgg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wFqZ7-002J31-2m;
	Thu, 23 Apr 2026 09:41:46 +0000
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net 0/3] netconsole: configfs store callback fixes
Date: Thu, 23 Apr 2026 02:41:14 -0700
Message-Id: <20260423-netconsole_ai_fixes-v1-0-92b8b7de9a2c@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADrp6WkC/yXMUQrCMBBF0a0M77uBmlZLshUpJaajjkgimShC6
 d6l9vceuAuUi7DC04LCH1HJCZ4ODSHeQ7qxkRmeYFt7antrTeIac9L85CnIdJUvq7H90bmuG8L
 gZjSEV+E/wNMZiSvGPer78uBYtx/W9QdXO7osfAAAAA==
X-Change-ID: 20260422-netconsole_ai_fixes-24599337a79d
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Keiichi Kii <k-keiichi@bx.jp.nec.com>, Satyam Sharma <satyam@infradead.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Matthew Wood <thepacketgeek@gmail.com>, asantostc@gmail.com, 
 gustavold@gmail.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.16-dev-453a6
X-Developer-Signature: v=1; a=openpgp-sha256; l=1193; i=leitao@debian.org;
 h=from:subject:message-id; bh=yPQzRlotaICidFf4b3L3Ohyn7dtDX0gqvtrmn35l5IY=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBp6elUUU6DgtPkIAq2QtF7tiA+Bmn0xFoMIBF3s
 QCk5Z4NjhaJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaenpVAAKCRA1o5Of/Hh3
 bfTvD/sFOAsVm7yTgkfKlwGjfkImkOcjGLSttyI3eC6PAfUtT+9lf6smdOnbKcfAF83K2Fbf7tC
 pUSt5DsCb31aZWmEZi9voKbl/KPxunRh9Z0xDXjQ4TJdmwojdI2JXpfOcf0PrN2AOdPQmz89IvM
 CtxIYhqZ5FW6YFe1Xw6BuzULcivBiw63fusH2tmhu/5Cr06PhZTQq93hy5JNenbQT4G+glhlG0p
 1oI8c22KM1pqEzGWM6a3/pDWZM0I02DsgogHKI9z+qaeV+GP420o6zl8k7gFvnUk1F+/eh7xm86
 YX1mLtm+ozUkT4MJWXsTO8z4JLK9W4r+mfqF7Wwo+C2QrS/0RhXi5saxlbY6WvMc3F0NTcrMq9B
 3LHHDHikjayI2oWuNwE58Uuf2WRDuqdvdCwpTjUqxzaR5DHryeuAGJWv1w1rVm21CWb/Bjmu1TO
 4S+WzulgvgCuXiTXdG2wk54G4MCPsHjc7wsNt+26SsOTMtyQJcFcSNvv7E9Cq/7hQOiv2dUQQwR
 4c9Kc0/joRfbFry8sGq4CjJXjjnFa0rmlpQBmvH4iLeJIAU/y/yXW6ilBiduvX3/cKh0Ssh+4B5
 vo3KpMM8DP4aHlJoYLLmNnpANZg4BQSklydBDoXMHRE2+zkXRa9/1oDNX8vhUT15zquy01JI4B0
 bQc3H2GqBmtQfKg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,bx.jp.nec.com,infradead.org,linux-foundation.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[debian.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-280683-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 312BF44FEA3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series fixes a small cluster of related issues in netconsole's
configfs store callbacks.

They showed up in sashiko and brought to my attention by Simon:

https://lore.kernel.org/all/20260421162219.GF651125@horms.kernel.org/

None are crashes or security problems, but each is a real correctness
bug that surfaces at boundary conditions and was easy to clean up while
the code was already under the microscope.

All three changes narrow the accepted write size by exactly one byte
at the boundary that was previously buggy, so no well-behaved
userspace should notice the tightening.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Breno Leitao (3):
      netconsole: return count instead of strnlen(buf, count) from store callbacks
      netconsole: avoid clobbering userdatum value on truncated write
      netconsole: propagate device name truncation in dev_name_store()

 drivers/net/netconsole.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)
---
base-commit: 70c8a7ec6715b5fb14e501731b5b9210a16684f7
change-id: 20260422-netconsole_ai_fixes-24599337a79d

Best regards,
--  
Breno Leitao <leitao@debian.org>


