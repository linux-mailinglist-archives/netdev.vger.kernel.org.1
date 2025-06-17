Return-Path: <netdev+bounces-198466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77721ADC412
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 10:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC1C17A278D
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 08:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4210E2949ED;
	Tue, 17 Jun 2025 08:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GN8Pd0ps"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A366428FA93;
	Tue, 17 Jun 2025 08:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750147352; cv=none; b=YuLvVYHbDdfDUCuCg1zCsfatdv5YGWkkvzfTkiw1WuRc7e/Xtp8es1D10/Z2kECgs4+mPXm2TuT0U//YYxIMSBYFyAgE7spDjUxa8ByKZRTi6DfVgU0h/UFq0PxqKHALgFRTDU4a0qsOvqAtd0xZGL9Z3wke8ai/ik6x/GJ060A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750147352; c=relaxed/simple;
	bh=vvV+xmO0j0mWtU1wNfJ75+6hS9+rll7NzjTztVenfl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IqejmpEKq5xvTL52sDRm3gYZngE6wVdMHsElv4b+wlyfErFUCDqePhcxYxxAH1WZ73EPmVNZgQn4aFO6BsAhcnNZC75/jHI3FxPitSIsqNv4aziQ+XemJDscZvU4cz/JyLLzUBcrD4Q4n5YRyhpcqNqWiSoowNS8tew9LXaeDYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GN8Pd0ps; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DDA6C4CEFE;
	Tue, 17 Jun 2025 08:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750147352;
	bh=vvV+xmO0j0mWtU1wNfJ75+6hS9+rll7NzjTztVenfl0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GN8Pd0psWtSir3682S1Fr/Su1JPCZZBYyyEbDq4E1Z25Aqp4fJSFjZiYpLXQ6dkgE
	 PnCze+/MpElqauHOJXCVCrONftL6g3ACk3pZnC1kzDVfJiNc8wLKPuZ4SVfXlSKBdb
	 hifXqbRiF3qN0AZ5/2QWcY73WdDMs3LqxS//MZRHGel7KGZy7aQlekG6c7O6ldJyc6
	 OJy/QpQKOTy0CoF4tOrsolQ72M8PJlGice+wRPALdq5HEi53RTPVQSJ7ECim9i/1Yp
	 dna1/ShBNL9amKKyw26uFAH+dmHnPffQDmGru6WCa6rIJ0k73aRfUb0RvLY7C5Okok
	 4CsRkQGzj1PJw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uRRH4-00000001vdg-196d;
	Tue, 17 Jun 2025 10:02:30 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	"Breno Leitao" <leitao@debian.org>,
	"David S. Miller" <davem@davemloft.net>,
	"Donald Hunter" <donald.hunter@gmail.com>,
	"Eric Dumazet" <edumazet@google.com>,
	"Ignacio Encinas Rubio" <ignacio@iencinas.com>,
	"Jan Stancek" <jstancek@redhat.com>,
	"Marco Elver" <elver@google.com>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	"Paolo Abeni" <pabeni@redhat.com>,
	"Ruben Wauters" <rubenru09@aol.com>,
	"Shuah Khan" <skhan@linuxfoundation.org>,
	Jakub Kicinski <mchehab+huawei@kernel.org>,
	Simon Horman <mchehab+huawei@kernel.org>,
	joel@joelfernandes.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lkmm@lists.linux.dev,
	netdev@vger.kernel.org,
	peterz@infradead.org,
	stern@rowland.harvard.edu
Subject: [PATCH v5 14/15] docs: netlink: remove obsolete .gitignore from unused directory
Date: Tue, 17 Jun 2025 10:02:11 +0200
Message-ID: <073835aa035718b120971b7a53e0f270d146fe87.1750146719.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750146719.git.mchehab+huawei@kernel.org>
References: <cover.1750146719.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

The previous code was generating source rst files
under Documentation/networking/netlink_spec/. With the
Sphinx YAML parser, this is now gone. So, stop ignoring
*.rst files inside netlink specs directory.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/networking/netlink_spec/.gitignore | 1 -
 1 file changed, 1 deletion(-)
 delete mode 100644 Documentation/networking/netlink_spec/.gitignore

diff --git a/Documentation/networking/netlink_spec/.gitignore b/Documentation/networking/netlink_spec/.gitignore
deleted file mode 100644
index 30d85567b592..000000000000
--- a/Documentation/networking/netlink_spec/.gitignore
+++ /dev/null
@@ -1 +0,0 @@
-*.rst
-- 
2.49.0


