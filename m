Return-Path: <netdev+bounces-201447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C12AE97C6
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 10:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30B2D3A4704
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 08:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205B825BF08;
	Thu, 26 Jun 2025 08:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2hlSv+9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2DA25A34F;
	Thu, 26 Jun 2025 08:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750925608; cv=none; b=Eg4Qntkac0wdvJiStsRc62/3+x9yvnJ5LfkgVXexkC7bJyudktz2YXq89cMQQkfoNcQggAabXhPsW1WSdjkJ9npk3Ml2KJjxKz/OKkjEITZtfFhu9w8Uy1JZh+Su4yWoDuv+3lzehXjhh35XYLBKxDVZt4qx2INDqde00eaS+zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750925608; c=relaxed/simple;
	bh=v9oPQ++3T/oLHadwElBOCj5ha5V/O+Y96e7j6LLicng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hrVy35HglUZHIZaku9fcThUyJSpHppKzVhbvd9wSwxa4nbgp6i9rsUlu8D39aLXHFvzS76Gfh+xBYjSmJYIeSyKGPXxx/7zKwwUddIfZJ8mBdMVj3VqKLSP+VqBCVj0w6PlelQ2nAOX8F0jBazx057HKLv7+eCoNef1ZvEKK8HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R2hlSv+9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5827C4CEEB;
	Thu, 26 Jun 2025 08:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750925607;
	bh=v9oPQ++3T/oLHadwElBOCj5ha5V/O+Y96e7j6LLicng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R2hlSv+9dfCQPGwlVxYCIGjwbTFcgQ4z6XmcsZ2JPk1WWS5vfPluEOXC6sdTLIh99
	 4frwL4/xpy0tnsMg8E1IwIpCS+rbSEU8NZgf/2b+6P0EXNgSTwf8fPAN9PzqGdFrjn
	 CpxaRE1S/CeCrmtJaARNn/cTscPEv1NHuPIyEyIqNlDdzzTdw7BWIwg0sX0ws1473K
	 jCmR7agEV2tQ8dbd09laT4eOZJmWamYODwqSV7sOlVeXF89H3xpS3RUlVK82Tm0nzR
	 C1/0t54wyMRUIEuIa/1K5r+m4JDCrDjT03l0hUtZMF5Dx+6F0eFk9O1+xuPsJ1Pnrz
	 rOlWWQfBXoeOg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uUhjT-00000004swE-2Qwb;
	Thu, 26 Jun 2025 10:13:19 +0200
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
	"Randy Dunlap" <rdunlap@infradead.org>,
	"Ruben Wauters" <rubenru09@aol.com>,
	"Shuah Khan" <skhan@linuxfoundation.org>,
	joel@joelfernandes.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lkmm@lists.linux.dev,
	netdev@vger.kernel.org,
	peterz@infradead.org,
	stern@rowland.harvard.edu
Subject: [PATCH v8 13/13] docs: parser_yaml.py: fix backward compatibility with old docutils
Date: Thu, 26 Jun 2025 10:13:09 +0200
Message-ID: <d00a73776167e486a1804cf87746fa342294c943.1750925410.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750925410.git.mchehab+huawei@kernel.org>
References: <cover.1750925410.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

As reported by Akira, older docutils versions are not compatible
with the way some Sphinx versions send tab_width. Add a code to
address it.

Closes: https://lore.kernel.org/linux-doc/598b2cb7-2fd7-4388-96ba-2ddf0ab55d2a@gmail.com/
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/sphinx/parser_yaml.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/sphinx/parser_yaml.py b/Documentation/sphinx/parser_yaml.py
index 8288e2ff7c7c..1602b31f448e 100755
--- a/Documentation/sphinx/parser_yaml.py
+++ b/Documentation/sphinx/parser_yaml.py
@@ -77,6 +77,10 @@ class YamlParser(Parser):
 
                 result.append(line, document.current_source, lineoffset)
 
+            # Fix backward compatibility with docutils < 0.17.1
+            if "tab_width" not in vars(document.settings):
+                document.settings.tab_width = 8
+
             rst_parser = RSTParser()
             rst_parser.parse('\n'.join(result), document)
 
-- 
2.49.0


