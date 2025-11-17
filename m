Return-Path: <netdev+bounces-239154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 35255C64A60
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 15:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 93C09356C0B
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 14:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F6B24291E;
	Mon, 17 Nov 2025 14:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tk5cbp1H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795D42AD3D
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 14:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763389929; cv=none; b=saPz+OAOaqQ1Aa9jfwVrOJ6V2WyujBUrCtWjfCu7bXxpenNS89C38uXm6yhrR4jmcWPpPfuUhi6smvYnqW1wjGgKtfbzBc3/ayoqgta7UkQpX2Gusa7WtVp40ur3Ib4QcnBtFNE5FsZ9btGsPgR0wrY8h+fLp0eIKEFfotpMCew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763389929; c=relaxed/simple;
	bh=9QkvkNsRfTO7uPvt2QaTDDWkiOWNoptdjivCjqRBEkk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ap/PErMxSIf7IpNNdcfiafX29BJc86HhymJchuY7u98xsZ5WEzCVOQiXFjdNl4sWym/YkDCzoKY0r09Y+ZpGqqi8dtE1+j/AgD+ZchCNVcW5tdVyrRZ/lTdvl0sbvaG/+lzrUbgxyfBIwkKto/d70i4qKAqthNlTFYEfmSBSj1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tk5cbp1H; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-477549b3082so36033085e9.0
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 06:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763389925; x=1763994725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+414Te4lWuii/oyblNUfXBFjuWOAf9Cb54hq9uupIMw=;
        b=Tk5cbp1HsxfNqA5gu8BnxGSqEsRGx7cIxX96rLx4WWY9Qch39AxeEOL7144oMT39Bz
         nfTlMCjAZ63S6m/HJI5ovmU2m6ozgxGsrN9sa0JnPrQo1aQPnbMmUrQF7gMXvuXG55sH
         4Z/VPLjm9YvlhGfWQV2ksFtmpOzuEuYFKXyGPUXddF2M8o+eesrpciZzseH0GOUn0Ek0
         irbc19rIwt0/wuI/NCETlEmrMznIoxSbFl0b6ZV1J0eyCRYs+V/4F44/0/b9Rcr+ZC+9
         7sOmCz5HXG4Q/Hg7i5lpMhrW3DnOSB/vbowQXuufQKMzL/iMbhQkpej2jsTWguML8t7S
         Rt3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763389925; x=1763994725;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+414Te4lWuii/oyblNUfXBFjuWOAf9Cb54hq9uupIMw=;
        b=rCl/PGa0G3cqi/eFQqigLATsOmP+db0Spff7EQ8W/iQuUmk9aah9/VESDgm92Dne9V
         zLDK0ptmwioiOPnr6gZ+wBnTOZgH3kCtpxmQ6w3JKpgnz0Ng2uZ2gCrJpYujkVnqxxYA
         DT1QZaj5adopbzSJ7+IssLcQHMQCzAeOpFc4YkZenYhd4z2vXUn17QhjuRoAu3VlSFI5
         VDrdB9k9h0U0MHoPkgQi0ljx4vfviOlN0xbjUFfKG5VK9vnXLXs+0H4iauCyxhQsDYoE
         /0uQk653qU01yGkvJeL1J8AdjsWDcIXJ/iiU9bKCmjauTK7/q0K5Nb7qrdER9/8PMrxB
         gEHg==
X-Gm-Message-State: AOJu0YzB+YrhhFC4CV0IXmzaj++yvjvk4npxsbwquHA/FFQ7bTJJFLmd
	nbNp8w7o8rGYwFSKUUkasYfnUj8UkGpkRoHPVINL0HjuQzhP2JWnd0QVyRGjuw==
X-Gm-Gg: ASbGncslTZGY1PfCLSWqALI9KzoEKKsIOcQ4y3+GzukUaYBHD+ktEwKa1hyUNCapKb6
	PA42ATeuLUOkCbtWdqmFWfS/UPO84upFohNJ56xH4bdYE9nSHUkAXC77PTwdnr1FCTkmIwRZrZ9
	D8hbF/hpMI70CLo27JB8um48NLO+s8OHdI6u4S/QwqHDPy8Unot/SD9Nvj9fdtwfx8mdoIXR3O3
	9DBR6o3uQ2DxtAGTl6PnFFYhQjvFqoVVx1lq3WlRvLKGuzt8ciCptiKcajcnqBDkhrryq+uZWVi
	h2JAmnc1FdnJlxPBAg1+1txtm9oH4ooM8fNkx8ytYCqNtGBDt4I4eO0YS0L4BECkR/xxHLrdC1d
	BkPpEd41XLMJUlzGMsdbIccW1BDSprHBRD4VAkheFsCdmiQqHp4hU+GaR+qa9FAvhPkfcflyne0
	sfYgWv5qWYknqhBek0ryyGdktMqKf3
X-Google-Smtp-Source: AGHT+IEe14TCKYEVJCWNXMdAvxJduMt5sMqz0kPlZvrbqYi3qbHhiLAlNWuFk5HeRT5eEyCNrRZ4yQ==
X-Received: by 2002:a05:600c:4f51:b0:46e:37fe:f0e6 with SMTP id 5b1f17b1804b1-4778fea749fmr137481145e9.30.1763389925252;
        Mon, 17 Nov 2025 06:32:05 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:7408:290d:f7fc:41bd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787e2bcf9sm311955265e9.3.2025.11.17.06.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 06:32:04 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v1] tools: ynltool: ignore *.d deps files
Date: Mon, 17 Nov 2025 14:31:54 +0000
Message-ID: <20251117143155.44806-1-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add *.d to gitignore for ynltool

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/ynltool/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/net/ynl/ynltool/.gitignore b/tools/net/ynl/ynltool/.gitignore
index f38848dbb0d3..690d399c921a 100644
--- a/tools/net/ynl/ynltool/.gitignore
+++ b/tools/net/ynl/ynltool/.gitignore
@@ -1 +1,2 @@
 ynltool
+*.d
-- 
2.51.1


