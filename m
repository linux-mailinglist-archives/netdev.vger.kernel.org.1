Return-Path: <netdev+bounces-123182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E25963FA7
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 11:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5359A28723E
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 09:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0C318CC07;
	Thu, 29 Aug 2024 09:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="f6eT+iev"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB9918C922
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 09:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724922948; cv=none; b=mxPkEgd7H7SoSGZ9PRofg/pmKO4+kfMShMa3Gv1OI0xbJ78WIxs1IYZflRF4oFo4WzrsbCpedg6bJwTr0iRAz5i+/LxmdPcrUjJfG9t71SqyOnBsJy/hQGlEusuTdTMON7E+x6vCaA7InbnTZfMedzhr0n+3edCdIyhvEP49SDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724922948; c=relaxed/simple;
	bh=bEolJSCCdLQnijiAHENGikR4W9YgQCYail9qjfENyV0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kQgbyIy30q9Yhj1HE4gghFMWndlnSq+Wh8DOgyLD/5yYhRbkiRja45rPExiEsUK7Fai6nfU0HUcql6m34ge4UvYGaKCZxwmW/fsyWTO51OKHavPvgmvvFc3anqzkeFch4dO/uHxl9R32kDuXirjQWBexeTjnSl7r0Yu/i9RPkBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=f6eT+iev; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from ubuntu.home (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 6F2AE200A8CE;
	Thu, 29 Aug 2024 11:15:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 6F2AE200A8CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1724922938;
	bh=nJUAxlFWAHHNJToyYWUBw0GVs/2O/iv+y4XtUkvqwKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f6eT+ievrID1O5RqudnqEd0jz4rNjkXCF1UG5UPr1C9dF0vbfKgmkCK+c9biH+dby
	 p63/24DNQD98AuUqYhTVPLGe09g+Zq1m2e8cM+jwYbqC9FXQYlqak+1BgkDfX/GuGi
	 EGaq1dtnpjYDG0wo+Jl25hzehu5OttZr7T8gmUiAK4nsYzZCrzsnK3yIKhzoDu5sOr
	 KWP+mZchayH+jU5IDfGR1oiYgwX+amB8aDVH7bFZcV2VXkW2DdNJ/I7BU4gAvX2b4L
	 nALkAmbtKm7SkiQ1l0PdhrTXE21LYSQas7NtczRgCK5deBmZKqNNAkwXMCYF4LtqXF
	 NPg48JZbAedsQ==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	stephen@networkplumber.org,
	justin.iurman@uliege.be
Subject: [PATCH iproute2-next v3 2/2] man8: ip-route: update documentation
Date: Thu, 29 Aug 2024 11:15:24 +0200
Message-Id: <20240829091524.8466-3-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240829091524.8466-1-justin.iurman@uliege.be>
References: <20240829091524.8466-1-justin.iurman@uliege.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Include "tunsrc" in the man page.

Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
---
 man/man8/ip-route.8.in | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/man/man8/ip-route.8.in b/man/man8/ip-route.8.in
index df49f8b0..676f289a 100644
--- a/man/man8/ip-route.8.in
+++ b/man/man8/ip-route.8.in
@@ -253,6 +253,8 @@ throw " | " unreachable " | " prohibit " | " blackhole " | " nat " ]"
 .IR K "/" N " ] "
 .BR mode " [ "
 .BR inline " | " encap " | " auto " ] ["
+.B tunsrc
+.IR ADDRESS " ] ["
 .B tundst
 .IR ADDRESS " ] "
 .B trace
@@ -1037,6 +1039,12 @@ divisible by 8. This attribute can be used only with NEXT-C-SID flavor.
 packets.
 .sp
 
+.B tunsrc
+.I ADDRESS
+- IPv6 address of the tunnel source (outer header), not used with inline mode.
+It is optional: if not provided, the tunnel source address is chosen
+automatically.
+
 .B tundst
 .I ADDRESS
 - IPv6 address of the tunnel destination (outer header), not used with inline
-- 
2.34.1


