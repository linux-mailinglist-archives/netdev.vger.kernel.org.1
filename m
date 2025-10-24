Return-Path: <netdev+bounces-232545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C1BC06630
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 15:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F8E83A8423
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 12:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA5A31328F;
	Fri, 24 Oct 2025 12:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="El1FnBJh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F31A2E091C
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 12:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761310747; cv=none; b=B8p5teN6DGle63cTz9yYHRPNtZTsdZatUFQfrGkEkcquREOL9inmu9b+hUQwLTCkTDajmbRXymDbBGtohgo1dkG3zuTHxvnlugGt1ttJw0d8o5DngiRLKWD6FnnBT/dbWq5zcQjEtIN0v9BeslYO2sRFdmTVx25qBUaPwyoVzQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761310747; c=relaxed/simple;
	bh=dSxX2QvaR+3Ybo1v/2sCvv3TLn40FU3nEbQ+BN18zTI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rUmeszkMlKyxO/BA7GZcyDvB6BrigWSFwiGA0MslqQ0vMdEEHxdrVGOIeL4x0xu8eSJrI8L/H/Bp1QJZTTdfBplreI8+htfjnwZ7BatjoHGow8KYCCufrRYoR9xUvi12Vlo4ewVXECfZ0qE3opz6A1B2uoGry8WHSlPy0E2dCEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=El1FnBJh; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-781997d195aso1497187b3a.3
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 05:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761310745; x=1761915545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gng95qxjjHYWxKeGek3s12/J4A4Iq22fnY2yqE/Oy4E=;
        b=El1FnBJhPJbMHBP7Fhl6Q58FdbSfxUGKlVa4b7VPiDMCTNRjRdRp+p2Zphq6TGjOhb
         wkqkK7KzQwwwI9cB3Mhu2hOx/dSgZCouNOb2bwkb6rEPph479PJ9LEQXqB+COie/x7iC
         t79FsWsz7aqp4LzY0SqkPmua2uYsp+ji9wSEkca5RGDcwJiEAa/K696SBR8uYCclr1TZ
         vBEurdfz0U6ltHW95086IRQHkp35nwJSirdNKBtV1yKsDIoIHeyZQlXssQPlhBECAFxT
         ezZ2XDdT2Um0/pR3UzPk9ZqCPtrUv/gxokJxkLs7fUW1CZwpRDtwA/0jBhDWwgGY+EeP
         DFsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761310745; x=1761915545;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gng95qxjjHYWxKeGek3s12/J4A4Iq22fnY2yqE/Oy4E=;
        b=Nk0jKp5UJekeEBpRXvX5kJV8Mp8DoyQhbCUhLSPG4r8ngYK4k/bApHzjjx65jE/Cko
         lhFtJnCEh181b+jj2slcrI+2sgtZtSOr5cM20YQ5iLcwV5pJYaM2cCKT2AbTtYDtVuh9
         cxCfyabFIAIcpCmiHwnvdzEkyIotdi4ajeIhExr1MlWhZTSzrAy5ALqRzhtW4kyGTtaR
         sEdu8kQU25nFN+Nc/GMStqutt5ydYBy7C+UDyAq7+yy3408a4mIQ+tpMQD2vSFHaNYo0
         8tX8SozfZUpkf3UmpVzn90RJcmAyvOAtdFWzq049hgd2SRofVCaIdhvPlssQ1gtLYBBf
         VxAw==
X-Gm-Message-State: AOJu0YySCZtdEiq48cqKLe/lyzWqwZAo250WL6gLCqGfEgviyxJZblN+
	gegDJyzJGA88yHxlUtULsN8M0R2JRe96Wk/WdojOkCN5fDGC38D8/PDM74tpoeM79P4=
X-Gm-Gg: ASbGncupZK10S0vCf8FUP2KMM5RryqNNpDFkmqF7oNyPEZv1V97x7wae+GCOozu+QS5
	jNDH3BpAd8KIUJ7v4w37DNtLf/PzaGB5oc0V3jjTRKqs+AVq0xcqMc+YxIUc0arOOH+N7PfDKmY
	y9P1glsWhzZzEvPxW2U9PUADjiSTrq0z5HW4duY37kL0t5gq5aOKh1AqHxxpabzmFBwA0vLlqK6
	IZDh0VRb6uOXcFog5nFTqjiajs5VvFdusIKMUWf2zXdssspyzeYNio6t7B6CgWuRj3zF5q+seEl
	AxC5frh5EDZ/OuHcmWbfC4Dei5qEDaZa2Gc6gw8n884j/L3qG3cGRpvlokl+xmV2f7aCn1OR2b1
	Jo6I19uSZ0ct4asNo/gmFV22xzv6f0f+tmrTpMNypl4zMla+DjwQT98o+DHo0WVX8TUvsWXCNrS
	FM9IFPHP3S3zIvb7k=
X-Google-Smtp-Source: AGHT+IEBqoG7pLGaFyPdQWM4p4fRLi46Wu7Nl5ia96/4Hsit9sdLtrhjo2GfDXY1A0YSn3P8F8aGBQ==
X-Received: by 2002:a05:6a20:9147:b0:334:a9af:e9ec with SMTP id adf61e73a8af0-33de9099b36mr3058535637.12.1761310745176;
        Fri, 24 Oct 2025 05:59:05 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e2090eff6sm4939381a91.2.2025.10.24.05.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 05:59:04 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jan Stancek <jstancek@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	=?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net] tools: ynl: avoid print_field when there is no reply
Date: Fri, 24 Oct 2025 12:58:53 +0000
Message-ID: <20251024125853.102916-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When request a none support device operation, there will be no reply.
In this case, the len(desc) check will always be true, causing print_field
to enter an infinite loop and crash the program. Example reproducer:

  # ethtool.py -c veth0

To fix this, return immediately if there is no reply.

Fixes: f3d07b02b2b8 ("tools: ynl: ethtool testing tool")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/net/ynl/pyynl/ethtool.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/net/ynl/pyynl/ethtool.py b/tools/net/ynl/pyynl/ethtool.py
index 9b523cbb3568..fd0f6b8d54d1 100755
--- a/tools/net/ynl/pyynl/ethtool.py
+++ b/tools/net/ynl/pyynl/ethtool.py
@@ -44,6 +44,9 @@ def print_field(reply, *desc):
     Pretty-print a set of fields from the reply. desc specifies the
     fields and the optional type (bool/yn).
     """
+    if not reply:
+        return
+
     if len(desc) == 0:
         return print_field(reply, *zip(reply.keys(), reply.keys()))
 
-- 
2.50.1


