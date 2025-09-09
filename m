Return-Path: <netdev+bounces-221423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 055A1B507B3
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 23:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6FA54629F8
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 21:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305E6257AEC;
	Tue,  9 Sep 2025 21:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YHKBZZ2L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DE324C692;
	Tue,  9 Sep 2025 21:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757452093; cv=none; b=ktMRSHnbCaF5j++QjLgfkPsmjv1TK0uutaaJZwgjZa8BKlJUUBuNz6sbvUeszcSxreZMitvXP+jqJYQ/ugw0L8uUJ5YiyyYgCqQiZ9+6bXMjU9JPl+krlPJ6GEn82i7iB36kYt3NpNZRY5YsMSKDp30ZAimiBM5DcC+fF4tfx+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757452093; c=relaxed/simple;
	bh=hySgMDSj7EmJZ8nhTa5VYkOzwmN7VsefMu15/SIBkLg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AKudVZcX1xbFlfs6uXmvsRBOuRfgJetVcQVpYn6f6jZspL1z206TuZne1P3EWro4ei37KOnqNHXhM2mzWk51K8Q/LlsIIoJam0pzLbSwIb1KSfMl5PK8daluksql52adX1egh6ZV1Nm7bX0qzqf2BCWGRLpK1NtVc0eQxHYiD94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YHKBZZ2L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0216CC4CEF8;
	Tue,  9 Sep 2025 21:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757452091;
	bh=hySgMDSj7EmJZ8nhTa5VYkOzwmN7VsefMu15/SIBkLg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YHKBZZ2LqmDnGY+t7vmcIeuMxy8YkusbY4Ge/yLex4Kr4HQNzE5GRPco31fTKc+a5
	 ZsrcI9QM4inb5zoWP0i1ks1LqemgQCPmjswBdz/u2HGYI5Yn8hxDETGT5PIZeDPy9k
	 IzBwKSAsGlniU2C54x8LqvnBuE6DKNXkIvYTiGpvYmRHd9lKCN3X+QSp/jeYkajsxP
	 aAx3LsqbeUDxIBjEF/chMWRDg6wBML2LWHVjHFomhdIY9Jko+m3h+S5MvSAA9uyDGz
	 OnJ5EWhG8qVtJ/qmt0ZFRQ1SJzp8zD0OCsFicZTvj748dIUlCbJ8VbrJECrZM5+Uja
	 YIgekJv8f8Tpg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 09 Sep 2025 23:07:48 +0200
Subject: [PATCH net-next 2/8] tools: ynl: avoid bare except
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-net-next-ynl-ruff-v1-2-238c2bccdd99@kernel.org>
References: <20250909-net-next-ynl-ruff-v1-0-238c2bccdd99@kernel.org>
In-Reply-To: <20250909-net-next-ynl-ruff-v1-0-238c2bccdd99@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1134; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=hySgMDSj7EmJZ8nhTa5VYkOzwmN7VsefMu15/SIBkLg=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDIOTNe33fxm+Z9/9VoZDFEvL13zNXlw5/6pB41BkYtNP
 k3qniEo3FHKwiDGxSArpsgi3RaZP/N5FW+Jl58FzBxWJpAhDFycAjCRzt+MDOtdWXYZVqu++Ft8
 o4xx0Z9txfeN5S/tSRNLDrhzo/jWvC+MDC1T8mNMDk7o7HpbJ7+8+q/2bVOuSo93qca9HlePvJx
 2kR8A
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This 'except' was used without specifying the exception class according
to Ruff. Here, only the ValueError class is expected and handled.

This is linked to Ruff error E722 [1]:

  A bare except catches BaseException which includes KeyboardInterrupt,
  SystemExit, Exception, and others. Catching BaseException can make it
  hard to interrupt the program (e.g., with Ctrl-C) and can disguise
  other problems.

Link: https://docs.astral.sh/ruff/rules/bare-except/ [1]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/net/ynl/pyynl/ethtool.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/net/ynl/pyynl/ethtool.py b/tools/net/ynl/pyynl/ethtool.py
index cab6b576c8762e0bb4e6ff730c7cf21cd9e1fa56..44440beab62f52f240e10f0678a6564f449d26d4 100755
--- a/tools/net/ynl/pyynl/ethtool.py
+++ b/tools/net/ynl/pyynl/ethtool.py
@@ -51,7 +51,7 @@ def print_field(reply, *desc):
     for spec in desc:
         try:
             field, name, tp = spec
-        except:
+        except ValueError:
             field, name = spec
             tp = 'int'
 

-- 
2.51.0


