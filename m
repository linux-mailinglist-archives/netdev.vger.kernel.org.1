Return-Path: <netdev+bounces-185134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E06AAA98A14
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 14:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 986FA3B0DAF
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 12:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D8E182;
	Wed, 23 Apr 2025 12:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=wizmail.org header.i=@wizmail.org header.b="hgQmai4x";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wizmail.org header.i=@wizmail.org header.b="gXQ5lPCm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.wizmail.org (smtp.wizmail.org [85.158.153.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3ED32701B7
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 12:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.158.153.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745412372; cv=none; b=Sax8iJCk+j5snFDL4BwTAd27uISDAptGMolaNoGyuWIoxuiqpwNNlYXQwDCwjjCYIVPmSMq95VWtbpHGD5p557v/U9dm29JNyL5eCn7PGKnGmRfo64iMpk1q+ckRjCa96fbgSEVd2cXe5qYOj/dpX/SCDUxmnHPSdhmZF/g16Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745412372; c=relaxed/simple;
	bh=/Mn/h0Ca8l2b5o069ZP6Ltn2BL0sfXVt5NX4QlwQaXY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Td35j/MbtRdKdES8Qzo74wNhNBx4NjZvoYD0yBpqyhMEVOrZc6kCN4gtbIngxGN+uz95cbUBgKK1Z0pYpCZUQ3xsNuABl+HWGwx6VhKRy0kLdJ/Jc0qZOt4bd6Yo4hCfuRroPGNlY5ZzXxDQ3/+8rmveUxx2FpzIc+2KLEFHl30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exim.org; spf=fail smtp.mailfrom=exim.org; dkim=permerror (0-bit key) header.d=wizmail.org header.i=@wizmail.org header.b=hgQmai4x; dkim=pass (2048-bit key) header.d=wizmail.org header.i=@wizmail.org header.b=gXQ5lPCm; arc=none smtp.client-ip=85.158.153.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exim.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=exim.org
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
	d=wizmail.org; s=e202001; h=Content-Transfer-Encoding:MIME-Version:Message-ID
	:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive:Autocrypt;
	bh=ggTtID7OSrD3f9oA8rpuyuCprynLcFmlA3JvkCP9WIA=; b=hgQmai4xqsgqS9YCbwmTiVoCa4
	I4z/mvWzcz8Ghab+lI5pzhuAy7wdW+POIlSRfzU5FV6HVRjoelATj1FULJCA==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wizmail.org
	; s=r202001; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
	:Cc:To:From:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive:Autocrypt;
	bh=ggTtID7OSrD3f9oA8rpuyuCprynLcFmlA3JvkCP9WIA=; b=gXQ5lPCmTb5hNiIvqgRV7djm6E
	gE8TjPl7CUFhUEEi76xT55cLLwv1yLGZAjVxytXdHuRuzmXjzNMXdiltu8OkeQLLFZBvC1JNQImjG
	TcIlhxlsNGMJMVw/e10d5xsfXOMUuNy8ll6QC+dUIPpShRln+THS+B+P/f/UYlsGkNvn73+gj+cqN
	KZu7BnoWJasGzsxltNAWK3rGZrS2Ybq16uTX3ZlVGwWJAq69+XI83n2jkZUsA6BVFnJPzeTWDeMFu
	DC1QkJd6mP82EVN1SZpaO22I86Hfl3Txt5pUOS3SrISKWVdF/LyPTyhhu+uTuWJHHH9sekZJwT6Ac
	xSJ8D60w==;
Authentication-Results: wizmail.org;
	iprev=pass (hellmouth.gulag.org.uk) smtp.remote-ip=85.158.153.62;
	auth=pass (PLAIN) smtp.auth=jgh@wizmail.org
Received: from hellmouth.gulag.org.uk ([85.158.153.62] helo=macbook.dom.ain)
	by wizmail.org (Exim 4.98.115)
	(TLS1.3) tls TLS_AES_256_GCM_SHA384
	with esmtpsa
	id 1u7ZUO-00000001iXI-2ePx
	(return-path <jgh@exim.org>);
	Wed, 23 Apr 2025 12:46:08 +0000
From: Jeremy Harris <jgh@exim.org>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	Jeremy Harris <jgh@exim.org>
Subject: [PATCH 0/1] ss: tcp: Provide visibilty of Fast Open child creation
Date: Wed, 23 Apr 2025 13:45:59 +0100
Message-ID: <20250423124600.5038-1-jgh@exim.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Pcms-Received-Sender: hellmouth.gulag.org.uk ([85.158.153.62] helo=macbook.dom.ain) with esmtpsa

ss -oi can output "fastopen_child" attribute if the passive-open
    socket was created as a fastopen child

Note: this is dependent on the acceptance of a kernel patch,
submitted as
  "[PATCH v2 0/2] tcp: fastopen: observability"


Jeremy Harris (1):
  ss: tcp: observability of fastopen child creation

 include/uapi/linux/tcp.h | 1 +
 misc/ss.c                | 4 ++++
 2 files changed, 5 insertions(+)


base-commit: 866e1d107b7de68ca1fcd1d4d5ffecf9d96bff30
-- 
2.49.0


