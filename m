Return-Path: <netdev+bounces-65519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D04E83AE66
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 17:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7713D284F86
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 16:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9821F618;
	Wed, 24 Jan 2024 16:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dx+tgWBT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D254695
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 16:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706114049; cv=none; b=NY2+1g8OImgUo0sXnXON3kxUGxChstyAtmL6i2JITIPRCDmIR59nCtwc84GxYKeGbSRkqt50nlzJYWYvvnbJw2NaijacsZlTpcQ2US3R3GmvVd+hcGlYNEPF+npqGPaJV8qv+sCX5CcRIL5hc959Zav1WhSBWVEItN8cQgTUutk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706114049; c=relaxed/simple;
	bh=lQMAy/f9Udne90iVLSsDeERnIiI8qYgWMPJGa8/iyBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aiYIiQ1mNBAwDiEZtI2Nos4xvUXjW9xBifma7idjGD13KXI/kvDr/v2VUCfpbjQLLtFqrq00JDrnj2airwY6GbEGhtsKLjOzR1Jn2eHEx0djdb9HzI058X1yXw88V102h+TRH6bk9QB2f3B8YBHRcID24MR4u03b7i0LEe1EHU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dx+tgWBT; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-336c8ab0b20so5670109f8f.1
        for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 08:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706114046; x=1706718846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CQ9rTNQWPESh7A+uxAoeOiVeH94tU/eCSXNbM6rQtFo=;
        b=dx+tgWBTnOpAxuKo6XpXrizB9wBT7uDgKNz7ajkYs9yrCUhD1M78aBRMjTJg/xUkui
         bsrwY/Yir4otqueA3tWu19r/Btg3yTuxAs2G9HlYBpRY1rW1KnjHbcsbuD1KKd7KnmyJ
         PFnfB/r/27zhcu5G9LsC67tktWCyRO5n9lkJ9nrYR97/bgUi4cEZ48p532sSVnL83vD8
         wwn9plcPCx9Yne9JINbB0551uF77gvqqKaoc2Tb3mEF5eRgVIn6gW2r5A64uNxxWtAqA
         NWcPWAGAHSVMXYgElxwl7tloIbz3P4HoMF2thwE9eNlLlwpUBuehSd0w0u7UxLIWEk0w
         krYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706114046; x=1706718846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CQ9rTNQWPESh7A+uxAoeOiVeH94tU/eCSXNbM6rQtFo=;
        b=C3oA0Vd1f9hxTTpiw3vNsLGNy4YL3fNwOHtAcXs6AHfAnxKE7Z0/pT8zFz3FSHiPkp
         ajK/giYtTAKH1zNAq4S1LLXoYJMNLEZj0sbeVrfSO+Be1a8zGURKSTCtKMdUJPqUm1/g
         HhBYIO9s+xqBArJLU99fLiJY8oYv7IUllhf0yyx9+w9hCQKiZ6b6mWc33mGkb9Tt1QDl
         bdMoHE+W3Au4V9WEHBiC7TVBmTx3vY/AE9lPBOB134NWybWOqUSliMpbXVo1hU+YWuAh
         dOROdx4fXfhM/vjUy3oEwvwKGzJ+SobVo+7fFeYzxgWnLYhQ/PxkSByCnVD1GCeeVtSi
         P4xQ==
X-Gm-Message-State: AOJu0YzlGhXOT7Ce/qC5DdgP1LnFFiVLLPqRnSaYfeg91zCIDND8fv/s
	REvXDEjbmMBhJAOJPqib4wfsEfWekt1OT8TSw1+Y8RkFxayMwZGO
X-Google-Smtp-Source: AGHT+IGwGgnDSslzWr65giDH2wfSf2JL9mDf4pS6sfzoNzQkoFKgSfmb/wZy+3Ov6IrcQQHODkLH+w==
X-Received: by 2002:adf:fd08:0:b0:337:be3b:dcb with SMTP id e8-20020adffd08000000b00337be3b0dcbmr638506wrr.126.1706114046215;
        Wed, 24 Jan 2024 08:34:06 -0800 (PST)
Received: from fw.. (93-43-161-139.ip92.fastwebnet.it. [93.43.161.139])
        by smtp.gmail.com with ESMTPSA id c11-20020a5d63cb000000b00337aed83aaasm19082866wrw.92.2024.01.24.08.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 08:34:05 -0800 (PST)
From: Alessandro Marcolini <alessandromarcolini99@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	sdf@google.com,
	chuck.lever@oracle.com,
	lorenzo@kernel.org,
	jacob.e.keller@intel.com,
	jiri@resnulli.us
Cc: netdev@vger.kernel.org,
	Alessandro Marcolini <alessandromarcolini99@gmail.com>
Subject: [PATCH net-next 1/3] tools: ynl: correct typo and docstring
Date: Wed, 24 Jan 2024 17:34:36 +0100
Message-ID: <d90ec07a9c72055b0607e259606fc6c2a7366ce7.1706112190.git.alessandromarcolini99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706112189.git.alessandromarcolini99@gmail.com>
References: <cover.1706112189.git.alessandromarcolini99@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct typo in SpecAttr docstring. Changed SpecSubMessageFormat
docstring.

Signed-off-by: Alessandro Marcolini <alessandromarcolini99@gmail.com>
---
 tools/net/ynl/lib/nlspec.py | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/net/ynl/lib/nlspec.py b/tools/net/ynl/lib/nlspec.py
index 5d197a12ab8d..9c205022f8c0 100644
--- a/tools/net/ynl/lib/nlspec.py
+++ b/tools/net/ynl/lib/nlspec.py
@@ -144,7 +144,7 @@ class SpecEnumSet(SpecElement):
 
 
 class SpecAttr(SpecElement):
-    """ Single Netlink atttribute type
+    """ Single Netlink attribute type
 
     Represents a single attribute type within an attr space.
 
@@ -308,10 +308,9 @@ class SpecSubMessage(SpecElement):
 
 
 class SpecSubMessageFormat(SpecElement):
-    """ Netlink sub-message definition
-
-    Represents a set of sub-message formats for polymorphic nlattrs
-    that contain type-specific sub messages.
+    """ Netlink sub-message format definition
+
+    Represents a single format for a sub-message.
 
     Attributes:
         value         attribute value to match against type selector
-- 
2.43.0


