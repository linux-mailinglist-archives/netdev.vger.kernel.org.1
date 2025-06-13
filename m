Return-Path: <netdev+bounces-197458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C991FAD8B1A
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 13:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FEDF3B04D6
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 11:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF792EA49B;
	Fri, 13 Jun 2025 11:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sOWEBoJZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568A72E7F14;
	Fri, 13 Jun 2025 11:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749814967; cv=none; b=fO3nZWvGSq5HIX95sL4CyzaCKJzH9bBowMnXrkD133D3GswI3ukNXfalAwKXpIIAk8hbDXVe4D2Nqbsq6i1fa4W/Mc2QwREPK+2TxKHB14Mk1FtcXkKomiUlZIbC5sWVDrwAeBTIXb25BS5lfg/5uENlskpFBJyzjdJcTkSsqYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749814967; c=relaxed/simple;
	bh=FsS6lOMAqt6O4kSiWFDk/a19S4XMRpll04UTzLeJcwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m1Ri9Er824UnFP8PwBSBWv/wCVJ6JGw66OyJtDZ4EwuHz+IO5crhHGLqiyCBDGigSyAhBCuzchGX7xw9WGYSf3Hq9/xj81J7EUX7TNJQUCMNFMdWIqnCYpnkxN025z8LOlm0Sa4Xd6coK3WMMCayzyfWv9RZ6azSgV3/z2n5Uos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sOWEBoJZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F05C7C4CEF4;
	Fri, 13 Jun 2025 11:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749814967;
	bh=FsS6lOMAqt6O4kSiWFDk/a19S4XMRpll04UTzLeJcwU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sOWEBoJZ4vIFTsylM2WbefCfKVG/jZ9zBR7K4NKzUvNInZxR4/2AQ6bRJMbqrITo8
	 bcSDxDthQft49+QvovfnkDU4DbL0DKwBzoo06vee/WU60tAqCB8OZK2xWgze6nOAzo
	 RkguEgrgh1CBZKcr9zVVt1Tb6ewbQ+Xups5Q7+ihBapQNEo/pyICfppBZ5Rjv73xsH
	 6KCCbsLQIi9B5XeAJqPsJ4JEDtjXoge/CmB+O7m2lifCkUsLNf0c+mIb3BfXuy9/rF
	 E8ztchjxy1pEf5jgIknUm/jYth6oBu43XmterWANGYoA8u+sfCH3aWml0b0+D5TEpY
	 T9GUN4lwR6Lpw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uQ2o1-00000005dFS-0n5d;
	Fri, 13 Jun 2025 13:42:45 +0200
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
	joel@joelfernandes.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lkmm@lists.linux.dev,
	netdev@vger.kernel.org,
	peterz@infradead.org,
	stern@rowland.harvard.edu
Subject: [PATCH v3 12/16] docs: conf.py: don't handle yaml files outside Netlink specs
Date: Fri, 13 Jun 2025 13:42:33 +0200
Message-ID: <d4b8d090ce728fce9ff06557565409539a8b936b.1749812870.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1749812870.git.mchehab+huawei@kernel.org>
References: <cover.1749812870.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

The parser_yaml extension already has a logic to prevent
handing all yaml documents. However, if we don't also exclude
the patterns at conf.py, the build time would increase a lot,
and warnings like those would be generated:

    Documentation/netlink/genetlink.yaml: WARNING: o documento não está incluído em nenhum toctree
    Documentation/netlink/genetlink-c.yaml: WARNING: o documento não está incluído em nenhum toctree
    Documentation/netlink/genetlink-legacy.yaml: WARNING: o documento não está incluído em nenhum toctree
    Documentation/netlink/index.rst: WARNING: o documento não está incluído em nenhum toctree
    Documentation/netlink/netlink-raw.yaml: WARNING: o documento não está incluído em nenhum toctree

Add some exclusion rules to prevent that.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/conf.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index add6ce78dd80..b8668bcaf090 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -222,7 +222,11 @@ language = 'en'
 
 # List of patterns, relative to source directory, that match files and
 # directories to ignore when looking for source files.
-exclude_patterns = ['output']
+exclude_patterns = [
+	'output',
+	'devicetree/bindings/**.yaml',
+	'netlink/*.yaml',
+]
 
 # The reST default role (used for this markup: `text`) to use for all
 # documents.
-- 
2.49.0


