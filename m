Return-Path: <netdev+bounces-129352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AF297EFEC
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 19:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E46CEB214D9
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 17:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681AA19E990;
	Mon, 23 Sep 2024 17:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="cCduVVXm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-40130.protonmail.ch (mail-40130.protonmail.ch [185.70.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A25B19DFAC
	for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 17:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727113454; cv=none; b=iO4QJJ+adqElYukXGHUyqu7GUVg+/p43rcxgxtbfzefsQVFLLbUz5lu5SjNkGlpaItxUh6xZuPO1ecJtuTzKlNumCtM1oMazmqCpjVhlgGM25i7Y2Y1kVTDwqyUlAYqQui01RGGGnukK4O5GBML7gWH9hGkXAAbDK10ElOXM4Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727113454; c=relaxed/simple;
	bh=83w5K+sAK7CfGPM5eyRuFFvu051yEw1rPNh+uRBt1UY=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=kEflYLkTTsgHWSt9jaSXbYX7cyEiBKb0yDu/8Mi1e0ZC5PsvHPbZfMw9Vao80Dx9P5rHJY0+lIyU5cvggNR9tOP4sCaqxXskL0mf18SoUg7mjMD3Y4nm9L6Yos5D4Lx93dpmTM7vuglAYcphHoA0JEzw7tWgV2iiX6XM7xA0Dz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=cCduVVXm; arc=none smtp.client-ip=185.70.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1727113444; x=1727372644;
	bh=pOON+/5VA2b9vw5kvDdahqIjsRD3ATUIAJJ1VhFv0fU=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=cCduVVXmEiteQd4W6TFHvD37uSigfjzqjPvOcSfLiMvCp4DER8mcpkcidL0poujDC
	 /XwOjIWhDsLbsHGHW+AhdvUydUaeQXdYlSJVrBEsV65INMnsDTYlz5QC3floh6ReBp
	 MC41OZfq1pp8YBAjIlLGt6zAze+qjUhNIEq/LskdEWVw/DAJHX9HrLgGGvcfn20OkU
	 kYefOgrDe4ptRyVAn2KRQ2FoHW41mBBF5eKE3r9P3uzjV74KwaxxNC0hVmLO7/uOvJ
	 FL1KJlKW3ucP/HK+ZS3xHTBZ8DIfAVvTrQof53DZfPltb64bbWeltVD2LkEWdDDNLV
	 Wllk5g44Y3HRw==
Date: Mon, 23 Sep 2024 17:43:59 +0000
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, SeongJae Park <sjpark@amazon.de>, Joanne Koong <joannelkoong@gmail.com>
From: Tj <tj.iam.tj@proton.me>
Subject: Bug: tools/testing: incorrect usage of setsockopt() option value as ORed flags
Message-ID: <b61LsDehV62SU09O6UYNGcm8RWiA1Nz8ucKVJjafwUPym4B7xNMsUm4ot-xccQsFsD9XfU_46YYPICrJ-9CIq8YhkWkCilg6XG96csNy-1E=@proton.me>
Feedback-ID: 113488376:user:proton
X-Pm-Message-ID: eb8ba042ed8877e4714d496f68df6bf219d13242
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

$ git grep -n 'SO_REUSEADDR | SO_REUSEPORT' tools/testing/selftests/net
tools/testing/selftests/net/bind_bhash.c:78:            sock_fd =3D bind_so=
cket(SO_REUSEADDR | SO_REUSEPORT, setup_addr);
tools/testing/selftests/net/bind_bhash.c:106:   listener_fd =3D bind_socket=
(SO_REUSEADDR | SO_REUSEPORT, setup_addr);
tools/testing/selftests/net/fin_ack_lat.c:125:  if (setsockopt(sock, SOL_SO=
CKET, SO_REUSEADDR | SO_REUSEPORT,

setsockopt() optname is a single option not an ORed combination of flags.

