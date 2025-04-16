Return-Path: <netdev+bounces-183181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB63A8B4D2
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 11:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0A0C3A8A03
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 09:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675F52343AF;
	Wed, 16 Apr 2025 09:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=wizmail.org header.i=@wizmail.org header.b="NvRagKfF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wizmail.org header.i=@wizmail.org header.b="AseK4i1O"
X-Original-To: netdev@vger.kernel.org
Received: from mx.wizmail.org (mx.wizmail.org [85.158.153.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1A723237C
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 09:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.158.153.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744794561; cv=none; b=CR7AsuieWP12WH+Bne0lLMK4wayjas8Ni1OAf4hgtl6MRgiPyaeoqZ+L7M+QAP4YCaG9zoVOR+LcGl7vhycFxyMu/aCBtG10BtAYtNie6B4t4JwKhzZciZZAepYqxMMdwoBJ4a2b88r1qnUvY4aTA4nvu5bbNrycZc+erTdKQuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744794561; c=relaxed/simple;
	bh=jwX8LIB4Z3IXMoBRBL8xUb9in7yFNmYtOrTvigXypRc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GFxcp+INGp3XcbkIoZT3PgsQnPxctluYdm4eD5Ouy4Bcr63OPRwA09RMGfc9jC9ENkC94/7/G3BCfJldNKgyzxpWSghFzewTPGTv85ezuyQC4qJdhF8efOl2zfDOJ+TgUjVxngAfB7rKgOx9elqIlOuYBFHNzA0ffk7Yv+Ox00I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exim.org; spf=fail smtp.mailfrom=exim.org; dkim=permerror (0-bit key) header.d=wizmail.org header.i=@wizmail.org header.b=NvRagKfF; dkim=pass (2048-bit key) header.d=wizmail.org header.i=@wizmail.org header.b=AseK4i1O; arc=none smtp.client-ip=85.158.153.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exim.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=exim.org
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
	d=wizmail.org; s=e202001; h=Content-Transfer-Encoding:MIME-Version:Message-ID
	:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive:Autocrypt;
	bh=9/AB1nX6ZVsPGBcp0s/0kj3XUZRcKBTzVA4Z4rgdkyY=; b=NvRagKfFO3r3K55nFJe0tNoyca
	4h7A3iAFcqKdf2ZmvfDENUtWQ841l0n5XI5gfsOcI74irGIIfUEUoKIYNUDA==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wizmail.org
	; s=r202001; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
	:Cc:To:From:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive:Autocrypt;
	bh=9/AB1nX6ZVsPGBcp0s/0kj3XUZRcKBTzVA4Z4rgdkyY=; b=AseK4i1OwGFtrxkHSN8Kc1uHGP
	U0ycd0Smnd9b7H0rf3JL8Gz53Cs343ICZIMEm6VrsdpjGMcCoj/2YyRubRqXjZUCqxVq1DQFAVDr+
	rSltgKhpgKrJzdl9ekWTiRx8djZZoGBBP8EQJam5hPt4CEQMOEAF/L5Vy14t4J/9XLJUUwjCEtsWR
	2ZXwwI9S+VyhGFAVL7is9nZPS6QUjX/xCHjsUsn++kr9yOSGrNgXIVtNaLI0jCYCB+05U/fetOoRq
	DBuH4CmTeqifKlWagGr94tcQD9UK/m6ZhdccsCqIyC9aRT0Pd1+GHqAIbaGOorliStKje32Y84Wqk
	jYv1imHg==;
Authentication-Results: wizmail.org;
	iprev=pass (hellmouth.gulag.org.uk) smtp.remote-ip=85.158.153.62;
	auth=pass (PLAIN) smtp.auth=jgh@wizmail.org
Received: from hellmouth.gulag.org.uk ([85.158.153.62] helo=macbook.dom.ain)
	by wizmail.org (Exim 4.98.114)
	(TLS1.3) tls TLS_AES_256_GCM_SHA384
	with esmtpsa
	id 1u4yle-00000001gl9-1RP0
	(return-path <jgh@exim.org>);
	Wed, 16 Apr 2025 09:09:14 +0000
From: Jeremy Harris <jgh@exim.org>
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	ncardwell@google.com,
	Jeremy Harris <jgh@exim.org>
Subject: [RESEND PATCH 0/2] TCP: Fast-Open observability
Date: Wed, 16 Apr 2025 10:08:34 +0100
Message-ID: <20250416090836.7656-1-jgh@exim.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Pcms-Received-Sender: hellmouth.gulag.org.uk ([85.158.153.62] helo=macbook.dom.ain) with esmtpsa

Whether TCP Fast Open was used for a connection is not reliably
observable by an accepting application when the SYN passed no data.

Fix this by noting during SYN receive processing that an acceptable Fast Open
option was used, and provide this to userland via getsockopt TCP_INFO.

Jeremy Harris (2):
  TCP: note received valid-cookie Fast Open option
  TCP: pass accepted-TFO indication through getsockopt

 include/linux/tcp.h      | 3 ++-
 include/uapi/linux/tcp.h | 1 +
 net/ipv4/tcp.c           | 2 ++
 net/ipv4/tcp_fastopen.c  | 1 +
 4 files changed, 6 insertions(+), 1 deletion(-)


base-commit: 24e31e4747698dc50d408f0082d7eb9b9520d2f6
-- 
2.49.0


