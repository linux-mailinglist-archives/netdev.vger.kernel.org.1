Return-Path: <netdev+bounces-209552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13923B0FD3D
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 01:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 180BF96814F
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 23:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE776272E71;
	Wed, 23 Jul 2025 23:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gijaetaj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A69272E5C
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 23:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753312770; cv=none; b=mErhaBS7Mknr0lmV5y4jQ5mhy8XgviM/txSlol6Ek1pUrfemEGR6bx83VtlrOFIZwqwvMvjydnJ874nzjKc2PwNXxMNL2wl3xT5s55lWANIuADgc9ErO94gIQmfXG/W6rIiQ5KmAxerLsph8IlhJBq1/Uy0jMe5ud4MPv15sUf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753312770; c=relaxed/simple;
	bh=TSorPBB5VBIJYHf6yKUy8L+XkzoCMrqiNT1EC/POooI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WDc6wugxgLy6eB9fr+abkCXZbDg8AWIx6Q7FjxByzNz5afxEontpBhiauyJz3/zuvjRtcKwbEg7glCDRlMJgjTsze5BcCQC85byOeUJXfPmr8xX/P09veXsgcSyNCyTYc5ZbWwIbC7pTUyLwWq7UcHYIzz6erDGc9tKonYFpyRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gijaetaj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86C89C4CEF5;
	Wed, 23 Jul 2025 23:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753312770;
	bh=TSorPBB5VBIJYHf6yKUy8L+XkzoCMrqiNT1EC/POooI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GijaetajjDj/tFt/MA58qR3Im2ShFK8L2wx9g/VrQkSUO/HWyHJgTx/ELW5TIxWbE
	 md1+z561yMsdZY4bC3LmC8x+MBQ4zh44mKATYCRaCObFpy2HGFaC+CaQqEgnW1VxS8
	 vXp2vQn4d5G4OzC9neRf12Jg4WloZvLDs2C28JZdMewDc1qaOTaWvQkeiwSrvF9HRJ
	 z8g4h7rSI2jLcQQVs8m3YxsjPEn63jtHzJag2qwZtIX9W1P4Px8E7NUrAmnt1lJW/N
	 k9OWAKeLn/6y2cX/RqjU8ONfRhg+MakpkJiYL4Z/bjKnPB/z4is7YO0KsjwDR09699
	 WmTMhgamElKMw==
From: Kees Cook <kees@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	netdev@vger.kernel.org
Subject: [PATCH 5/6 net-next] net: Remove struct sockaddr from net.h
Date: Wed, 23 Jul 2025 16:19:12 -0700
Message-Id: <20250723231921.2293685-5-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250723230354.work.571-kees@kernel.org>
References: <20250723230354.work.571-kees@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=494; i=kees@kernel.org; h=from:subject; bh=TSorPBB5VBIJYHf6yKUy8L+XkzoCMrqiNT1EC/POooI=; b=owGbwMvMwCVmps19z/KJym7G02pJDBmNuR8UPKxLnr1VdDVb/nxisNuTNZ8XHz7UYXim0cEt6 qSw0f2lHaUsDGJcDLJiiixBdu5xLh5v28Pd5yrCzGFlAhnCwMUpABOJcWf4n37q6bTVnZIH9yh9 d9syd9LS1zdF/5z4v77up56R9zzd6zsYGZqN9gRwiFVVF2uZcRX5lW57Yqx5oHvPvGtV5/z4Zua fYQEA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Now that struct sockaddr is no longer used by net.h, remove it.

Signed-off-by: Kees Cook <kees@kernel.org>
---
 include/linux/net.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/net.h b/include/linux/net.h
index 25a7c37977fd..e804cbda9a42 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -150,7 +150,6 @@ typedef struct {
 
 struct vm_area_struct;
 struct page;
-struct sockaddr;
 struct msghdr;
 struct module;
 struct sk_buff;
-- 
2.34.1


