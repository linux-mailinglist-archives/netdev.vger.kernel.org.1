Return-Path: <netdev+bounces-221429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA08AB507BE
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 23:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC8A2462EB3
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 21:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1233526C38C;
	Tue,  9 Sep 2025 21:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJdcKiIT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF77826B74A;
	Tue,  9 Sep 2025 21:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757452104; cv=none; b=VS1Opdm4KIT2w7wbsjrEfBAWghx3RKUqnWDZYyOLtiwxq+whH3QPEzfQ8CqbkuyFzgzQbQt3qBhkUYTOW5dh4LhGUFKy4ThZNnKxJcn9F37HjwGTU3MuHSbbulniDyR3r0qMU/5ZmhunDrDT3CE0KMRiCm5ybDWs/UrbZkdLVUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757452104; c=relaxed/simple;
	bh=+UF2hEJZlCV3Cmwte4Uwt5PvK9ma8IrlSYMqyWNTRpQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lyUe1lSNSHxM5WPgcvboqukIuuj0+xR/g0CHDTIEhxy5VeuKUjRHXNkFQhyAWBHH5o/FYglz5cD90btCCar1QiZfZV8TbbHiRj16pG1OCmeuPSQyCk4sSLFViiFve8ZMpe1uFNLlsPFBpc5wzZ2wLET+xh7zHqpH+7LvrKCb6WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJdcKiIT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A772C4CEF4;
	Tue,  9 Sep 2025 21:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757452103;
	bh=+UF2hEJZlCV3Cmwte4Uwt5PvK9ma8IrlSYMqyWNTRpQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cJdcKiITFLYq4x8IzV0ZjYQ0m02oZ2V0pho417gTwqRgoXra939ZbGuygc6f0HYP0
	 M1dYGSaCVb6LVypa1W5fDNzSTc5c3tIQvvXbRG91JG482+GJOcnjcIP7h5csznrWU5
	 u/kpozkuT/5Y9/y8VuCS+o25LYlJ44TNhbp0MVqYqYGZlne0j9TVAvsdEvjWF9jh7X
	 1tAPRCGSbywX5vKffJqeb/CkVSNXOnxO3zgfvFJkmFh1FdX7SXxux8kuINja6Ueqxv
	 3tH79rRqkf4NV630u7RfXYq3czOx0N3iXHTd13GalfU2Lj4f4TuZi1FjSThv/a2l4a
	 Utyw0M9C6XFzA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 09 Sep 2025 23:07:54 +0200
Subject: [PATCH net-next 8/8] tools: ynl: check for membership with 'not
 in'
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-net-next-ynl-ruff-v1-8-238c2bccdd99@kernel.org>
References: <20250909-net-next-ynl-ruff-v1-0-238c2bccdd99@kernel.org>
In-Reply-To: <20250909-net-next-ynl-ruff-v1-0-238c2bccdd99@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1084; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=+UF2hEJZlCV3Cmwte4Uwt5PvK9ma8IrlSYMqyWNTRpQ=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDIOTDd9sfND2tsPZyJmHdSZ67Ii9Hi3j0RO8X1376/TO
 088lu9f0lHKwiDGxSArpsgi3RaZP/N5FW+Jl58FzBxWJpAhDFycAjCRqGmMDBc2LfL4HVNZtp/1
 +/ZbMW48k3bvvO7rVlGu8Nw+pvbqa2GG/74qWzfuFxHvadsRfT9uRkdHhMODe7O70vbaW6706d3
 LxQUA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

It is better to use 'not in' instead of 'not {element} in {collection}'
according to Ruff.

This is linked to Ruff error E713 [1]:

  Testing membership with {element} not in {collection} is more readable.

Link: https://docs.astral.sh/ruff/rules/not-in-test/ [1]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index c7fb8abfd65e5d7bdd0ee705aed65f9262431880..101d8ba9626f238a82cddd0bbc10bb4399e2ab22 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -638,7 +638,7 @@ class TypeBitfield32(Type):
         return '.type = YNL_PT_BITFIELD32, '
 
     def _attr_policy(self, policy):
-        if not 'enum' in self.attr:
+        if 'enum' not in self.attr:
             raise Exception('Enum required for bitfield32 attr')
         enum = self.family.consts[self.attr['enum']]
         mask = enum.get_mask(as_flags=True)

-- 
2.51.0


