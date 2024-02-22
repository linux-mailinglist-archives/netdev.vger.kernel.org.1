Return-Path: <netdev+bounces-74068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F9385FCEC
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 16:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53F73B2728C
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 15:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999FC14F9E2;
	Thu, 22 Feb 2024 15:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="u+FDWkH4"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEB614F9DC
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 15:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708616759; cv=none; b=hduXYjuH9g15/FqBQntEySAhzi/qE/GlYPycbp/tWDl3jjQE01ghVG1oFjcBijdRxUMinjfxWsHZnc8iHDHb4JVcm8/wOdIzcfkqf24gwT8RyHSksUnBzSsPoj3NNKrz1dF0nn1wTJDAkk57Ld2IMfM/IyA1ihBSsuF+Za4iutk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708616759; c=relaxed/simple;
	bh=7patFTKNV/7uyDpOpe4KMiJrOxVPL+u+02+8TcXNMAE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RKhQm0woORYSFfPCgnHZuz6nEwBTSdxsgRtaSr4bhAUXenTAuQeBP5wPBWNhmI+ohiLUA9gWXi9Vz9FTSgdbLtPdwXpd0uXPWSXcFNnBH3EaL0Otuqei0LDPEpbxCDZceoIzKTYq+gHr/pbQkjZqxr16DTaxevDp9tvg6O73aMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=u+FDWkH4; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from localhost.localdomain (125.179-65-87.adsl-dyn.isp.belgacom.be [87.65.179.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 0A11E200E2A5;
	Thu, 22 Feb 2024 16:45:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 0A11E200E2A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1708616755;
	bh=pRvOIxm5FmOWahIqwWTN1BXlEy6Lhco1Pr1IB3s2B0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u+FDWkH4OnmUIKRBGpOAzIqCcatTs3zfYrhd2FqdbAkizy8g2gWq1It49kZ2MVv0M
	 FQiiqmVB1YURTxQhyvqObaF5aqU85RtG4XwplavnHZGWOUXFMf3v6/597H3I6DYq4v
	 6KYdab6hujYZ/XuZIilLK4FHCxIHJRg9A0yVknwG+p/ru9cZcMDfJIZ2m2RBPCqNMB
	 D01t+9fb3LmhFbWXZ4hhMvcXvPYfhM5TNKXO6XWBgdqlzcHRru50cDLpbWzMpDaTbU
	 flSzs2oZ8jKm+f1D/JgGnx0Cm0zUMSu+NS7yLWLfrVfxExtFt6hlhvZExgCfwOKjtP
	 mBqXL7SCyowoQ==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	justin.iurman@uliege.be
Subject: [PATCH iproute2-next 3/3] man8: ioam: add doc for monitor command
Date: Thu, 22 Feb 2024 16:45:39 +0100
Message-Id: <20240222154539.19904-4-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222154539.19904-1-justin.iurman@uliege.be>
References: <20240222154539.19904-1-justin.iurman@uliege.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a sentence in the doc to describe what the new "monitor" command
does.

Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
---
 man/man8/ip-ioam.8 | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/man/man8/ip-ioam.8 b/man/man8/ip-ioam.8
index 1bdc0ece..c723d782 100644
--- a/man/man8/ip-ioam.8
+++ b/man/man8/ip-ioam.8
@@ -49,12 +49,17 @@ ip-ioam \- IPv6 In-situ OAM (IOAM)
 .RI " { " ID " | "
 .BR none " }"
 
+.ti -8
+.B ip ioam monitor
+
 .SH DESCRIPTION
 The \fBip ioam\fR command is used to configure IPv6 In-situ OAM (IOAM6)
 internal parameters, namely IOAM namespaces and schemas.
 .PP
 Those parameters also include the mapping between an IOAM namespace and an IOAM
 schema.
+.PP
+The \fBip ioam monitor\fR command displays IOAM data received.
 
 .SH EXAMPLES
 .PP
-- 
2.34.1


