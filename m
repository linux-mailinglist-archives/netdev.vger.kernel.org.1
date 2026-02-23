Return-Path: <netdev+bounces-260229-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEstDAjRnGllKQQAu9opvQ
	(envelope-from <netdev+bounces-260229-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 23:13:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C148817E141
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 23:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 49DA4306DFCA
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 22:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B5F37C118;
	Mon, 23 Feb 2026 22:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFs7CI6c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870E237BE65
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 22:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771884309; cv=none; b=elec/YacmjrZ+mcYBFVj9fkecLIIk16GbVEar1gR35/LMsaHReFD1+bj0RdFLjN+gzziCbayHAUa/fivmdRnyQwBad/EgEDhYBO2pth3DU7NKftnJ6MAqmvi4SdGNx4HeoiMR5ttAKAzpX0//h8Us8O/IvBxY23Hl379aRk07X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771884309; c=relaxed/simple;
	bh=6rrKwA7t2xdnfxQdEHWUilDFPRm0gP2abwyKcFsi1z4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qq+BZ4RHV/dvXyaP3wnc9mOO7jZ8RsI23d7f7Nq6lBy1MBijnk9mS9aHe5M0bgx+IOl6HxodY2Jbd1T/kqVaC+GXfh9yAqIIrTwAfPaRXvESoDuo1QjxNwuIjh27epFbtKG/OCWeovUVLmTZMB3edpAPBPxR+J/JX4ga2EZ0Gjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fFs7CI6c; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b883c8dfb00so832595766b.1
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 14:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771884306; x=1772489106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Em4vcQtlpeRbVR/RxCYxW/F57zyFMmk1V0YQNclS9kA=;
        b=fFs7CI6c4y6EvfLMVIy2PVMDG4ceE5hvJ2vAUJwosNx6Fj0XNY3F9ScvF3QiXFIj+q
         STUYwq0ALicMOeocRtdt48KFZjO+bWIXx7WGqW3reTu5Zl35Vpj4KkBpGIKVpVtm0LhQ
         GBRioi8mT2DMEkzJlW6qeBe7bZ4fhT/xk/xb3iRoK1AzVhDXnAf5Nzyt13QABjjfpYFv
         bwkYZZ6B5OBpXftnWVdy6C6UIVje5iX2daEskUDZg+yMAQ2QBq7hthibmf5C/Kk8DMu7
         o+rYg4K5nuR7y+9yCuXANgOntMCfHSqGiRXQxoxwhVNT02gZsqcNEOb+mHCo19HOiO9D
         u28A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771884306; x=1772489106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Em4vcQtlpeRbVR/RxCYxW/F57zyFMmk1V0YQNclS9kA=;
        b=t6sWWK3f7i8kj2M42jzd5WEjZu6Nx/CM/FiSC0huSGVI6gHYvb5FtnB7pFvWSiXCg3
         jFtp4Ir4hUpeUQTjEazUYSLuCbqERRMIqJtJ5qRd2I1N8IHXaWXITbiyvzZS/uQV3Yt9
         fHM7pC12Q93lxplZLTDaBqxWIHxMeKP/PZCtMZxVGyQrS8vyLYiIIP9VRzZrYDp8TLJJ
         ClLY3uE95QxRSH3S5euEiSqNJDi1vNsjqBv92gY5BOqPvktBZKrNOJnKd0WeXZnTMcgX
         DdbF+lDUBzr9bjuowaGzSRFwOp3Xjr2tN/4hJGmp9zKBjm6jKdia0adRjJ0BLwfOxHli
         vsdA==
X-Forwarded-Encrypted: i=1; AJvYcCX+WGRJvc/Lbl8ttWpJh6FVwwaXJ4kwISF/sB5vtLy/RaWB9/xpTXzV2iOlOLk3+c7uif1ziJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB20x/QyvDCKzLOtBWVDj0upTy28OnYx7i9nllPnH1QfcATTUC
	s2mBgqiUvetvB9agqgXeWwmpJ+ZwXqTKMbZo/1hDYKoLj/Lj6Uuhqfm1
X-Gm-Gg: AZuq6aJlTgcwyQJ/+teN63FkY2oerduA99yXzihA9rixCBnKIpDedv/OQe2bkVxjtl9
	Ldr3kz5SMROlMsuzvVyB/aYdf3YvWbhjbpM1PaytJi67Pn/jnaXOlNIpuLAhTcNxE4qCGDa9udF
	9r5gMJo0iqR5o+ZziIahkjYGtmvQmFTqw0rGMXR6Q8HUJG4TLhO+bzpfOhKJ8B+ttvKLCKavY1q
	8gekVbUixFDpb89eheDD6tzQ5iKtEaJ1Yh8wsRkTpjzApWagR3E0Fk1my2Nh+YpjRp1lBMZw7zf
	8ZMAkeIIa8qpawEA2thRQWWSN7fLKg++QG1XX7Xr3ekVSTQIveRmoN8m+wLjcBrFKldHcRwaPQu
	1oz6vrMTqdbX7y4HpVkF+QTivuk/IHEsbQdpdhpchruCfgRnVIIqrzM4YEUQNFSy3fRop+Hl4y6
	0ZTnjERKyYw5isYTZCIrECBkPYdyFbjV8IFCSt8pxvGu1J2zLGuDxAKsr46tp6XUj2xQa1Rn+NC
	RNcjGt1mgxJym1A2lktZGw9aiVefhFweomhfQD2bOTwo5vT4lhuOagA4PjmES/96+j6Hng=
X-Received: by 2002:a17:906:9f85:b0:b8e:36ec:88db with SMTP id a640c23a62f3a-b9081a40e99mr609037966b.22.1771884305881;
        Mon, 23 Feb 2026 14:05:05 -0800 (PST)
Received: from cs-874966990260-default.europe-west4-a.c.i2f7e30109524dc12-tp.internal (230.86.12.34.bc.googleusercontent.com. [34.12.86.230])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9084f191b9sm359394666b.67.2026.02.23.14.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 14:05:05 -0800 (PST)
From: Artem Lytkin <iprintercanon@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Trevor Gross <tmgross@umich.edu>,
	Russell King <linux@armlinux.org.uk>,
	Miguel Ojeda <ojeda@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Artem Lytkin <iprintercanon@gmail.com>
Subject: [PATCH v2 1/3] staging: most: dim2: replace IS_ERR_OR_NULL with IS_ERR for devm_clk_get
Date: Mon, 23 Feb 2026 22:05:01 +0000
Message-ID: <20260223220504.2102-3-iprintercanon@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223220504.2102-1-iprintercanon@gmail.com>
References: <20260223220504.2102-1-iprintercanon@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[umich.edu,armlinux.org.uk,kernel.org,davemloft.net,redhat.com,google.com,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-260229-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[iprintercanon@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C148817E141
X-Rspamd-Action: no action

devm_clk_get() never returns NULL, so IS_ERR_OR_NULL() checks are
unnecessary. Replace them with IS_ERR() for both the "mlb" and
"pll8_mlb" clock lookups in fsl_mx6_enable().

Signed-off-by: Artem Lytkin <iprintercanon@gmail.com>
---
 drivers/staging/most/dim2/dim2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/most/dim2/dim2.c b/drivers/staging/most/dim2/dim2.c
index 92c7a7d8fe7e..cea1ba99caf7 100644
--- a/drivers/staging/most/dim2/dim2.c
+++ b/drivers/staging/most/dim2/dim2.c
@@ -921,7 +921,7 @@ static int fsl_mx6_enable(struct platform_device *pdev)
 	int ret;
 
 	dev->clk = devm_clk_get(&pdev->dev, "mlb");
-	if (IS_ERR_OR_NULL(dev->clk)) {
+	if (IS_ERR(dev->clk)) {
 		dev_err(&pdev->dev, "unable to get mlb clock\n");
 		return -EFAULT;
 	}
@@ -935,7 +935,7 @@ static int fsl_mx6_enable(struct platform_device *pdev)
 	if (dev->clk_speed >= CLK_2048FS) {
 		/* enable pll */
 		dev->clk_pll = devm_clk_get(&pdev->dev, "pll8_mlb");
-		if (IS_ERR_OR_NULL(dev->clk_pll)) {
+		if (IS_ERR(dev->clk_pll)) {
 			dev_err(&pdev->dev, "unable to get mlb pll clock\n");
 			clk_disable_unprepare(dev->clk);
 			return -EFAULT;
-- 
2.43.0


