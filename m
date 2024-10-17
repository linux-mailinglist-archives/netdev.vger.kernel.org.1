Return-Path: <netdev+bounces-136360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D86329A1800
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 03:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15AF41C2364C
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 01:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FFA1F942;
	Thu, 17 Oct 2024 01:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="PGhHvPdS"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAD618EB1
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 01:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729129603; cv=none; b=Fp9PULeXKZpgBc4ptKYTvlAymhjC1eslHjNXDkdVHcVOAIrPS810wA0ydci92Qg/sMYvZQbMKnoouVGG5A8TdNrhVB70hSr0soys1D0xPQNehLmnoRmTP8kaZrXzjJxv0lTrd5aA8t2VeMFlDCTvhJiqsRFSQvJBYmmqmXaY6as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729129603; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oZ5buTJl76gLdUAMRPxThI1kEMPw9yzQqx32gMX8GFnHlK9ENfKPCp4t5xB6VDNYd8hmvU6oTf4GXp0VyNNgeXeUpYh3mWdWE3nKTXKZz7gcsOSxAU5ZDJDlY9xRVmDUtvjksJl6E4wghIV+k0Wa8/IAEQeERhHE8MILTg5190w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=PGhHvPdS; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 17E102C0372;
	Thu, 17 Oct 2024 14:46:38 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1729129598;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=From:To:Cc:Subject:Date:From;
	b=PGhHvPdSWAdRuYts7C4L775KMEsiC5ns/xKot+5ZUbzjhxtlrbKeMGduwUiX3VMTx
	 RPcVMJLd0/UjE8Tiu3M9/B3MmHwORJCdlGGOOceE4bNqUuG0SvjOZ3hHPJLmIOvS3U
	 JaLqIt9g0TwAmrBsK2oDMVyfqBT5jxa/bFEceI9+Fb/0e5TXQBsMsTqs5Ipirrt+hl
	 wkyoUgpcJHRSPkJDhBHdwbJmAkQlqyDZf6W8NiwQpuMIPmquSGSIAQ0X0Aud+h1J0a
	 pjfdRQkkuT9u3Z6p0LiVIUGXUvOxl+WfQ37J+FSAncQlje9AoVCGosOLY0B8HOpY3G
	 TDjgqzXh0W8CA==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B67106c7d0000>; Thu, 17 Oct 2024 14:46:37 +1300
Received: from pauld2-dl.ws.atlnz.lc (pauld-dl.ws.atlnz.lc [10.33.23.30])
	by pat.atlnz.lc (Postfix) with ESMTP id E75AD13EE32;
	Thu, 17 Oct 2024 14:46:37 +1300 (NZDT)
Received: by pauld2-dl.ws.atlnz.lc (Postfix, from userid 1684)
	id DF3A040759; Thu, 17 Oct 2024 14:46:37 +1300 (NZDT)
From: Paul Davey <paul.davey@alliedtelesis.co.nz>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: 
Date: Thu, 17 Oct 2024 14:45:42 +1300
Message-ID: <20241017014541.252670-2-paul.davey@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=ca1xrWDM c=1 sm=1 tr=0 ts=67106c7d a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=DAUX931o1VcA:10 a=rVnDm9A_-c-k2ki-JAcA:9 a=3ZKOabzyN94A:10 a=xo5jKAKm-U-Zyk2_beg_:22
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat


