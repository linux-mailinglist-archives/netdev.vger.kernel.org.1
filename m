Return-Path: <netdev+bounces-167052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2291DA38905
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 17:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F274168A2B
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 16:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA38422541E;
	Mon, 17 Feb 2025 16:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ED9GdnNQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF5E224B0D
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 16:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739809340; cv=none; b=FlFLbbPV++6jNa5BFy4bmM1IeS5kJ41q7kTlOm0ah7kzkNzKgHOVaDNdAJJO4GjWZ8aCrWg1agjbElH1+q/35DvzWV8nsF5f3xZioeB/XjLDXMxZsrTlT/OwvoeRpztLZ720Sju0RDx3d3AiK0vGTT7O6cwfWturpkuZQyXDuAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739809340; c=relaxed/simple;
	bh=b2g8VOg+9PlKkIDwLGNPDbqTwGG0DWWwLiduaRMkpow=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mlvhBuAIM5/bwkKlbGXFFgCc8E5dpNCu8jZknKJGU/3ASAOhVSAt5DHWgKQIgTbne4YjEIwtEGvfrDbrwcJEKzSCSGyq3xc64ZqIFrKSegkCwxqDIA99ixL0deup1zd1QpgvRpyiuRBwTkEfc331I4NPVRtmXyKLcNCpJkmqF0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ED9GdnNQ; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30a3092a9ebso11537311fa.1
        for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 08:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739809337; x=1740414137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hDtfYAB6AaPmCCQemzqhVfvjKtn0/n4xLUAwYV2gFIQ=;
        b=ED9GdnNQgXrJt+SWBm39xBbld3TvFAoqFljhcWwInQPsr4PzhjAtc3aeG4UTvkZKmc
         zz1+WPXZ7BGvIIEOzDDR7kD2C9QiaymB9QMJO2zhId18nYMcRpsxkmtmvixVv4yCmUGo
         k0Uc1ELU9SrokboBkBV4ttKiGF+Mf/MYfB0BaD31GeoqVq2LV2J6UvnAOx8Xd5QMhuqE
         gcJFFq02Bl8GmKSwLO/yjt2P9M1ARmWmoIARTKWrrqZKRmHsCIMpUMxvGukN/gJcund4
         EDRVUsUArx+2jGSFesXg7mTOoUoYU1oeKXymRiUQqvPgHIoECDkEaybNjSSx+FimHP0q
         mw5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739809337; x=1740414137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hDtfYAB6AaPmCCQemzqhVfvjKtn0/n4xLUAwYV2gFIQ=;
        b=j8sqG8xmwcKxZuHSqXSEL4kkgTgArzpIOfT3QWZaY046++P9AYmSP3QxX5UHwrmBoc
         mD6P30vlU+dTzfALA0XOwsQ6f2JT2HJVcQOqugK8Z/HrBbfpiMS5K7AffNLondihvCwD
         pXBS6n/Zdz//Xz2P/DRFd4pMDxNyQCPYdcpdXWQSA0Pih63qNAArmPXhZsSbx1LxG6wJ
         FKxMdMbdVbDdjqlH+5ufpS8gjngxeEpB0O6QAEK4wS/S4XmB5da16njgihRmlUqIgrxu
         gAvSRZdrCgSHHJurWlqV1xWRpQNzchSRQEpWhCcj/KZAIYw2Jd3ZiQg2rY/ctRaz/rHA
         ozDw==
X-Gm-Message-State: AOJu0Yxe+EZ4e2YEMv3ecMC17BG4nwu2nOEZ2mlCTv+Gp2mNX0ZDAofi
	G9VecrJ4xYeVUHoEVT9xmLkR1/aIT9OR1UhVeHnsiXCN44o1NhSbOj45N2dos6ELcQ==
X-Gm-Gg: ASbGncveG90eM4Eu5klLSob+O38RJssw43NKaO/OBE9d0iKZwVeKFs0LTJMOQd2bnku
	kGK31hy/dnl/2RYld94vW3NhkE4N9G7ne4KFfUrHSAtniSe9FvMVQH7zzuYL6RqhwCyMj0bO5DR
	TXQIvmQv/9Timbyhbm8oCkw6SKq0PAWi0+uIfv+RAJLOdpRD8oP6cFKsLRAB5Or29BmVABCaE4l
	RUBmJmQCHC2VVmqcRveWnvkoWsgAYXWMtkp8ugfVNgKveASPGUOMtlH0TgKi6dcPsJqpkNCykZ/
	xrSpC9oakmDJS7S+rR58uZMdKCe96XLzvfqj5seh6V1Kej5pUY6DOY/tGVEtuPc7FxqRrb4v
X-Google-Smtp-Source: AGHT+IHEe8vjoYIWBcnMs+DX+ohp7bx5+M+4w+laHBtBhMYnWUJM9CXG8Jn3Rx10D5NsL/G86iEE1Q==
X-Received: by 2002:a2e:9890:0:b0:308:f01f:183b with SMTP id 38308e7fff4ca-30927a2e116mr23682361fa.2.1739809336734;
        Mon, 17 Feb 2025 08:22:16 -0800 (PST)
Received: from astra-student.rasu.local (109-252-121-101.nat.spd-mgts.ru. [109.252.121.101])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a2794fcf2sm6817331fa.51.2025.02.17.08.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 08:22:15 -0800 (PST)
From: Anton Moryakov <ant.v.moryakov@gmail.com>
To: netdev@vger.kernel.org
Cc: Anton Moryakov <ant.v.moryakov@gmail.com>
Subject: [PATCH iproute2-next] ip: remove duplicate condition in ila_csum_name2mode in
Date: Mon, 17 Feb 2025 19:21:52 +0300
Message-Id: <20250217162153.838113-3-ant.v.moryakov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250217162153.838113-1-ant.v.moryakov@gmail.com>
References: <20250217162153.838113-1-ant.v.moryakov@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Static analyzer reported:
expression is identical to previous conditio

Corrections explained:
The condition checking for "neutral-map-auto" was duplicated in the
ila_csum_name2mode function. This commit removes the redundant check
to improve code readability and maintainability.

Triggers found by static analyzer Svace.

Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>

---
 ip/ila_common.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/ip/ila_common.h b/ip/ila_common.h
index f99c2672..cd3524d5 100644
--- a/ip/ila_common.h
+++ b/ip/ila_common.h
@@ -31,8 +31,6 @@ static inline int ila_csum_name2mode(char *name)
 		return ILA_CSUM_NEUTRAL_MAP_AUTO;
 	else if (strcmp(name, "no-action") == 0)
 		return ILA_CSUM_NO_ACTION;
-	else if (strcmp(name, "neutral-map-auto") == 0)
-		return ILA_CSUM_NEUTRAL_MAP_AUTO;
 	else
 		return -1;
 }
-- 
2.30.2


