Return-Path: <netdev+bounces-174619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3EAA5F8D9
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 15:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E46873ACD2C
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 14:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984D9267B96;
	Thu, 13 Mar 2025 14:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=wizmail.org header.i=@wizmail.org header.b="g2jzdc0n";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wizmail.org header.i=@wizmail.org header.b="UtHqblR0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.wizmail.org (smtp.wizmail.org [85.158.153.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057C386337
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 14:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.158.153.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741877201; cv=none; b=gtR2lhCNFKa+cVcKFWHha2i/QtNW9GuSa3C+BXipeDd7tUT9GYrtXgqS/0l2sQMbHtUn5aWa0Z/IZtQqbW0rksb3mI450QvvbbtBmWTI11Pz/pju32N7G10s0xM+uZbhE5EpCsg1e0ac/faiXU4vVRayQ31IjQKIzE2GkJSt/oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741877201; c=relaxed/simple;
	bh=W9ZwI8acb2LJS4sf/nlQFSvCDgxAPCOOjjsUXdFvJVk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c88SIRzeXt0I7/36g1eOIPn9UTGZPy38TzLRL/cAqdr9EwTNBCImEU6FVKMHBJGD2R5xF+fWm0Y6v7Oarq4DiHlp5oHTM4twPH5j9K6yRfywPmHAY5zkrcRy6ZM1EeJRR/E/WNDKZtkrdwocnAj7G3iGGlE2y5ujQkmwL9oYkGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exim.org; spf=fail smtp.mailfrom=exim.org; dkim=permerror (0-bit key) header.d=wizmail.org header.i=@wizmail.org header.b=g2jzdc0n; dkim=pass (2048-bit key) header.d=wizmail.org header.i=@wizmail.org header.b=UtHqblR0; arc=none smtp.client-ip=85.158.153.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exim.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=exim.org
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
	d=wizmail.org; s=e202001; h=Content-Transfer-Encoding:MIME-Version:Message-ID
	:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive:Autocrypt;
	bh=+UtEdaYbefF6+6z8hFcUjFaRuAon2pBY/sp2EL6NMTg=; b=g2jzdc0nnQ2XgfwxDOULj2JZR+
	2HlpAyzgV28Ub1v5jaM8tqHr23hli/kn1hK5GCbT+D8T6atQ005dt7tKFxBA==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wizmail.org
	; s=r202001; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
	:Cc:To:From:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive:Autocrypt;
	bh=+UtEdaYbefF6+6z8hFcUjFaRuAon2pBY/sp2EL6NMTg=; b=UtHqblR0QiFVKitxo7XcmuLCYJ
	ydWJgoRG4fvptOj1oQa86nXJHmephc6sV0HbHjyUZ6vnJe4WlukFHQNp4HTuvzLd7SbgbqxojQP9r
	48VdlRsHNcb4phImmZw8ucrDPdQLtSXx4Xc5E1SaY+wq1EAbNXUcTJaa6Pdljgv0dPd45WnBX6Ex+
	LmWAriq+oVWgWfj7tU/MpOuT9rqGZiU9LSlvNczf9JcYl5Te+/l++tZ6Msm3t2jy6IZA6kzRetz1M
	6LwhHSA0Fjh7YeDyvhJyKFO5Tt+zrl3VDk/HTkqLHKyH/nZJjW3uk/qncdc4wMznXDv+2wpCWtGhG
	ropL/fsw==;
Authentication-Results: wizmail.org;
	iprev=pass (hellmouth.gulag.org.uk) smtp.remote-ip=85.158.153.62;
	auth=pass (PLAIN) smtp.auth=jgh@wizmail.org
Received: from hellmouth.gulag.org.uk ([85.158.153.62] helo=macbook.dom.ain)
	by www.wizmail.org (Exim 4.98.114)
	(TLS1.3) tls TLS_AES_256_GCM_SHA384
	with esmtpsa
	id 1tsjpU-00000002LY6-12Y1
	(return-path <jgh@exim.org>);
	Thu, 13 Mar 2025 14:46:36 +0000
From: Jeremy Harris <jgh@exim.org>
To: netdev@vger.kernel.org
Cc: Jeremy Harris <jgh@exim.org>
Subject: [RFC PATCH net-next 0/2] TCP: Fast-Open observability
Date: Thu, 13 Mar 2025 14:45:49 +0000
Message-ID: <cover.1741877016.git.jgh@exim.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Pcms-Received-Sender: hellmouth.gulag.org.uk ([85.158.153.62] helo=macbook.dom.ain) with esmtpsa

Whether TCP Fast Open was used, or not, for a connection is not reliably
observable by an accepting application.

Fix this by noting during SYN processing that an acceptable Fast Open option
was used, and provide this to userland via getsockopt TCP_INFO.

Jeremy Harris (2):
  TCP: note received valid-cookie Fast Open option
  TCP: pass accepted-TFO indication through getsockopt

 include/linux/tcp.h      | 3 ++-
 include/uapi/linux/tcp.h | 1 +
 net/ipv4/tcp.c           | 2 ++
 net/ipv4/tcp_fastopen.c  | 1 +
 4 files changed, 6 insertions(+), 1 deletion(-)


base-commit: 5a1dddd2944492edb1e61c5db1cc386e5419fcf4
-- 
2.48.1


