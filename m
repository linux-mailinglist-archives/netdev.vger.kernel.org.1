Return-Path: <netdev+bounces-227881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27027BB9329
	for <lists+netdev@lfdr.de>; Sun, 05 Oct 2025 02:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C861F3BF605
	for <lists+netdev@lfdr.de>; Sun,  5 Oct 2025 00:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943C52AE68;
	Sun,  5 Oct 2025 00:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gjbglobal.com header.i=@gjbglobal.com header.b="s5dx8Ets";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="JUkcn9vP"
X-Original-To: netdev@vger.kernel.org
Received: from a11-32.smtp-out.amazonses.com (a11-32.smtp-out.amazonses.com [54.240.11.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A391805E
	for <netdev@vger.kernel.org>; Sun,  5 Oct 2025 00:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.11.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759623642; cv=none; b=qRFZysv9Uh+WKBV6CUaeiGJTRBOR8/S0of9O37sEeLkN45m6z0h/7Q7nQYnC2XSfOL806tC5tR0By1gJsmidxiTo3c8fBX0IVZa9p2rJeTKrKn+p4lPQJs85TQtxrx9AmBhUU5UPDzRHBQAdLTgQn2VpSTcQuZOvkCw+y5lpkOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759623642; c=relaxed/simple;
	bh=9yg2SG08B9YWUkjLthHK/NP5KQ3YiYuMDpng3+VPd5s=;
	h=Subject:From:To:Date:Mime-Version:Content-Type:References:
	 Message-ID; b=UzroDdYNS8k99tzqB4huMtMMqxl4hZeVwSnr2pC3B/XJDIHXNONLUX9Kne7Rr0hXebdcdNWncOEHXvpJSd7RkLG8o4K9kBvrZqY9GFZ/uhOViLn0gV+P8V27YbXjUvT+eGP+S/ELHQH4Sr+e/WnIB4IWhgfX+zuzuLuiOWc0lUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gjbglobal.com; spf=pass smtp.mailfrom=amazonses.com; dkim=pass (2048-bit key) header.d=gjbglobal.com header.i=@gjbglobal.com header.b=s5dx8Ets; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=JUkcn9vP; arc=none smtp.client-ip=54.240.11.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gjbglobal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=juotntn2b7iy2xuvnshqwdp4mjgnpu5h; d=gjbglobal.com; t=1759623639;
	h=Subject:From:To:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:References:Message-Id;
	bh=9yg2SG08B9YWUkjLthHK/NP5KQ3YiYuMDpng3+VPd5s=;
	b=s5dx8EtsKeUAcCQJD6WLjrT25+aMNcp4JXW3YhZULl69W8DuZ6yKggH413lXNnWh
	E+knZQ5DSAnshQLiWKqujs6eNcdDhZQbF/4+3QSWJWzp13VvepD34WNiBOEtk2Krf8b
	POUcr0CsBJGRmTtOujk1Nbn3+qRejB7iXtvhXQfm2QJC76xmqmzXAWvpYbdEoiRx2Fm
	tUsU2UxKpEY/cgzXt7eiTLX+dXRgt78FnOBGqFRJ+h0XBukUAToM2Gdt9PVzAZ/InwT
	nEOAgwqxtLtnjOBfGfEU30dUrfTafPB7mHRNhxaoY5/psprgQXi5/nHlZ2d/21oaH8z
	wofQKMwwMA==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1759623639;
	h=Subject:From:To:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:References:Message-Id:Feedback-ID;
	bh=9yg2SG08B9YWUkjLthHK/NP5KQ3YiYuMDpng3+VPd5s=;
	b=JUkcn9vPyVL/rbC5uBJ7YphswE1L0wn09OkeTgz3pCc4Fjok9HBnTzPPyXJNBwzE
	zvODxlrrc2FA9SxVPnTvc42Sm4yvPuJh4Uq1doeB+iFqFUMbRscl/8k6fQ9cKtncLKq
	Q8CF7fn2dq2fj5IarZko975XE0sXYXWl32M7fJ/c=
Subject: Business Partnership Opportunity - Gung Jeon Bang
From: =?UTF-8?Q?GungJeonBang?= <salesteam@gjbglobal.com>
To: =?UTF-8?Q?netdev=40vger=2Ekernel=2Eorg?= <netdev@vger.kernel.org>
Date: Sun, 5 Oct 2025 00:20:39 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <mail.68e1b9d6.2361.026913175d99865e@storage.wm.amazon.com>
X-Mailer: Amazon WorkMail
Thread-Index: AQHcNY3gzAxhHMZrTTmQYG+Vkhnzxg==
Thread-Topic: Business Partnership Opportunity - Gung Jeon Bang
X-Wm-Sent-Timestamp: 1759623638
Message-ID: <01000199b1bdf2d1-bfa69ac8-7354-41a8-b222-855cc2971fe7-000000@email.amazonses.com>
Feedback-ID: ::1.us-east-1.LF00NED762KFuBsfzrtoqw+Brn/qlF9OYdxWukAhsl8=:AmazonSES
X-SES-Outgoing: 2025.10.05-54.240.11.32

Professional business inquiry...

