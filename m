Return-Path: <netdev+bounces-119964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A32E2957AEE
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 03:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30365B2129D
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 01:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC18B175A6;
	Tue, 20 Aug 2024 01:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FOznpWzf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD47EDDA0;
	Tue, 20 Aug 2024 01:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724117234; cv=none; b=i0XWDKpt2h3B6BqqxV6P52QkWrLXAtK4mAUIuqmSmqemWDSG/LH0KJJX47QJFLhMGsvIRDpsg6JXrhaE7PGtBeG98Gc8IsbiCbZG7Z0Phabp5kEuEkIe9veUSWSsD0BC8qRPdGzFhj0vqjjiLPEa37iN3fGDZaEaI5Bo2dLMn+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724117234; c=relaxed/simple;
	bh=Dt3gSjpLIDlQE4sOXzo2Q3H5AK4SrUymVUhkLCf/wNY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TdyHKk8HascyFJASWhpJwILaKF8MmiWw6dgu/ABjOanLxx29vQvY/4Pu8tYBtFSGUUU1UO1UlfMi027hpFCXadgnyNp/60BS1doC5FY8qCVDgIroaFDsrGjV5MG+NeCw45ER9GSTeIuwv+Fn58Qz8RMoNqmXEI5tpgDlDzfJLtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FOznpWzf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF5BCC32782;
	Tue, 20 Aug 2024 01:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724117234;
	bh=Dt3gSjpLIDlQE4sOXzo2Q3H5AK4SrUymVUhkLCf/wNY=;
	h=Date:From:To:Cc:Subject:From;
	b=FOznpWzf2wwFT8Drw0B87UVD6FByxQ/AlOt1cS34+WmhgV2wY11ztoWQkrGF1T4hz
	 97RQEXqkm0p5osWl3Oyz9bm0lYyUyAQHedr1KdStQtX44vtWtvO1Vj7xrR0IoBuXcp
	 w1YTN2IvegD6HEM9D2bqgT1Ra6lcClRykNzyRm77sOpbVISrW2Hm5eFpJOvVLzI4OE
	 Z4G+4Mx4WcLki0zwxOGTJWMgrcpBPstfw5plWJpeWa6x5+R/R2B+sizVzXbGza1y4i
	 gxCjfHiVBNP7IFcpXSw8IFpQopnGYaXEc+WcPOnpSyWucsCpdH7E52/RsMXFyHt+BV
	 YUINFuEADwS3w==
Date: Mon, 19 Aug 2024 19:27:11 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] nfc: pn533: Avoid -Wflex-array-member-not-at-end
 warnings
Message-ID: <ZsPw7+6vNoS651Cb@elsanto>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

Remove unnecessary flex-array member `data[]`, and with this fix
the following warnings:

drivers/nfc/pn533/usb.c:268:38: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/nfc/pn533/usb.c:275:38: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/nfc/pn533/usb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nfc/pn533/usb.c b/drivers/nfc/pn533/usb.c
index a187f0e0b0f7..ffd7367ce119 100644
--- a/drivers/nfc/pn533/usb.c
+++ b/drivers/nfc/pn533/usb.c
@@ -254,7 +254,6 @@ struct pn533_acr122_ccid_hdr {
 	 * byte for reposnse msg
 	 */
 	u8 params[3];
-	u8 data[]; /* payload */
 } __packed;
 
 struct pn533_acr122_apdu_hdr {
-- 
2.34.1


