Return-Path: <netdev+bounces-168611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C59AA3F980
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 16:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AE631670C2
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 15:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F161DBB0C;
	Fri, 21 Feb 2025 15:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPjcOssX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B721DC075;
	Fri, 21 Feb 2025 15:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740152986; cv=none; b=nRBfb5ZYpS2f7/OI7DxdZAIOl7ds82CRJlYxGNeOhqvN8HqjMKogz4ouLlGrGaLvlPL5FFXQrzaUbQ57KRsk5NK7HUa+pUGw2OsCOTbknmEloa2m5Hk5TOk/Amhumy5BQC9bmmxCGe50bO/YR90NSaBg6KaCkfF/wM7BK3DtM6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740152986; c=relaxed/simple;
	bh=1fvhA8V0g/vtY2mcylWXQXy8upiIo6youGRqM1lFRmE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Or0EbaKK/bvDAScqF+kHR/lt/KR2gmNd7cZWiePeVfFGR5SVDjS+Lqr2ESOIWhs7j9yRW/HBQ7APsTdVTKiYU9PnYjCy1aeJqzQ+xEqCdXgswSNmnZpjIS6zbpbMBUPwoR4WGmcRfKZUjjMJiSDCG/2T4BKqj/41FrRZU8kUTCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fPjcOssX; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6f666c94285so20425027b3.3;
        Fri, 21 Feb 2025 07:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740152984; x=1740757784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MKWPUDJyTigYpO/lDMrucISTaNX7hl65i0Al0sTxzuI=;
        b=fPjcOssX1gkhvRGafZq4OmX/yjwo7rPmUb2T24B5I3qOUQCJURPDNz7CxIK4x01qX7
         3Gk5ExBIzZUAyTH0b+OJNQYoPB6rYYFeOMb3EQNKvD1PfgpVGFhz4aijyRJimdztQ81a
         l7+//IdegTFTUB4SdGv8gTxd7jvaEDQqPdj4FHbs8DW67dh+Eq+qFIR4FapuvRYiKgxZ
         MArcecoer1OK8COpgrxtoBm36vlBhjiRRWReCvIDXnLgXFbaV8tIvSJ1Wy/qDVI1ieoO
         wu4UoBMp/A7Vhd+3mItuWNn+ULj55LKW9fJrGCFuNLfgLfUNP5gMVjpTVAzmehi6ycxI
         U8ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740152984; x=1740757784;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MKWPUDJyTigYpO/lDMrucISTaNX7hl65i0Al0sTxzuI=;
        b=nurGlEV6DCxh/Ep9gj9xQrzxV/r0usroIgp18XUJmRdJON9/f292TLdk+O150cFqCV
         ZDCSDEXHpeACwqPLUtegpqQ+WCnUiLHZLefQC9JbMtdN2bSXJ1zBoJZA8jpbnacu7aoj
         RxmpJBsjtKB3MranUxpcyzzowlRC5QFmyxeA5lc8ajFxznQHCxnqjNAIq0ohK+LIbXQR
         f/3I8l8t3XANmWr7l6E4c9LCb5nVTDJ5f+Yi6tyYpWBzQeWT3NmXQO2Y+gIjV36u0VdM
         w+uQtuhNs6TG0MCzEz9N3jyU9uBSGMxJQr2nXiwS+ON9k1VfkDEWD83FubwllT8Lja/O
         PUOg==
X-Forwarded-Encrypted: i=1; AJvYcCWTHz8qfs7q5k3rWG20kxDdi2cZn69/Wx1IOvACXF7QtlU0ukPBYvDFNEjcUE+iarE3wYIFJXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhWyeyFNuPvyk9hjEl4gluKbebx15JogU3vnC8S1/ptFvtrHgo
	aj9ecryeHK0z1Zeet8cjDBBgzJSGPFLpJUeYf3z0dAyg2IYniNNd
X-Gm-Gg: ASbGnctOeOP36G3OLTyRXCOezJ03R3oAadz80vkqz2qtthi+byXNDhyZdIt44iSYx7v
	vAufuRhNB4p1+TCq340Y2qNxsvCye9Tqzgy9hN7dok5LXQ9GjB9sNsW/o//hARCIHXkaWtFXgkx
	zKb8ebCbACq1vo4WWfxeYI43hC3e8zOANWtVMLpGssusL1aQ9Zk/V6LL0NSeRdfpQmq1OAv4Le3
	4Mkyre13Mn+Nnxt6nH04viaaxzjobecVQd0wbVr5Vbw5/K9nqzfjL3p+SXTlUsN/0BsKRImP8pP
	FKqboOTyO/khS8Pua9w+U0DgRa/19RZnj5HtNsv2WIySvDVDdtYVj7PBp3V22Sv/ZGlEp1uCkg=
	=
X-Google-Smtp-Source: AGHT+IH0070/1+amarEXhfBwE99xp6dPZjIGqV0cdKiEdMf3DYfggBUyl9h8TS2yf1QdpUC2qH4tvg==
X-Received: by 2002:a05:690c:c18:b0:6f9:9d40:35cb with SMTP id 00721157ae682-6fbcc73d9f0mr37626637b3.6.1740152983585;
        Fri, 21 Feb 2025 07:49:43 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6fb35f669fbsm41864487b3.31.2025.02.21.07.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 07:49:42 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2025-02-21
Date: Fri, 21 Feb 2025 10:49:41 -0500
Message-ID: <20250221154941.2139043-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit dd3188ddc4c49cb234b82439693121d2c1c69c38:

  Merge branch 'net-remove-the-single-page-frag-cache-for-good' (2025-02-20 10:53:32 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-02-21

for you to fetch changes up to b25120e1d5f2ebb3db00af557709041f47f7f3d0:

  Bluetooth: L2CAP: Fix L2CAP_ECRED_CONN_RSP response (2025-02-20 13:25:11 -0500)

----------------------------------------------------------------
bluetooth pull request for net:

 - btusb: Always allow SCO packets for user channel
 - L2CAP: Fix L2CAP_ECRED_CONN_RSP response

----------------------------------------------------------------
Hsin-chen Chuang (1):
      Bluetooth: Always allow SCO packets for user channel

Luiz Augusto von Dentz (1):
      Bluetooth: L2CAP: Fix L2CAP_ECRED_CONN_RSP response

 drivers/bluetooth/btusb.c  | 6 ++++--
 net/bluetooth/l2cap_core.c | 9 +++++++--
 2 files changed, 11 insertions(+), 4 deletions(-)

