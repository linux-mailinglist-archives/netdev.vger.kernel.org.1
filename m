Return-Path: <netdev+bounces-201461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35775AE97EC
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 10:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D35D44A65B8
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 08:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5B728C5AD;
	Thu, 26 Jun 2025 08:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gf4RJEbh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABBD25F78D;
	Thu, 26 Jun 2025 08:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750925637; cv=none; b=EelqM2QuVh2DlpSTj2HQnCbqOaT8q2iL2tXkBq3zPDEDr9901AV5aAAflYNmqtPE4IpuMX1OZg0ezLojGoho9XMdMHf8dsvnuDN4XkXktiE9cv8hdkGUTLq1XmmVRPOCuz/nK3YYQPXZHwfcXkVZaXQQlxYjoUIPmMpzPtEQJjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750925637; c=relaxed/simple;
	bh=RtMlJEGnwJcXwbx5tmVTpg7dpV3ohe25eAqzrcO2vOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KN0/icCD05Xbvukl1vEKGGM6PCoJbeR6e1qxX9CIV8t73Tvlu8xq4cOrCUVhCtdbuCVRq0cp/2vNpt+1rBCtpfsj40Nep4Pi/OVyUjKEMITWf2TJ+zcdWnnjPlXXjQDdGhQDrBZHGVdikvB5Co+LnKtejA5EGfKO1SSAyBfpl6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gf4RJEbh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 517DAC4CEEF;
	Thu, 26 Jun 2025 08:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750925637;
	bh=RtMlJEGnwJcXwbx5tmVTpg7dpV3ohe25eAqzrcO2vOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gf4RJEbh1bU6CjFcqFyfrh1BM6hLKCj/Ki4yBrZXB7u8EsthzzTwr8QM4uHmD0pUG
	 YUvZc0lPp+5xUuUVjq0iQoqlWTbzQ7MP57eK221NHaxFfoW8SReKJn1HLA0E8XQo/N
	 M9KAUnkhjyumg/HK8E6v+6aoIekQTpFC63wyuSQA39Oux9NoO5Vkl/mcOwV7aUEytO
	 xxTenjKFlrj/2k4v0o+NLY76txtDDhhLPCw4O82PC1JIUwgo8XXDw/gZd7h1z5qOzb
	 U26VNPcA/BBM9mVYVPo0g2nZ+Ty5faotVIMZ9guMWFk9kLaw4iQu0x1IacQKYlroBH
	 3GOACjN+j2g7g==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uUhjT-00000004svu-1oUW;
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
	Jakub Kicinski <mchehab+huawei@kernel.org>,
	Simon Horman <mchehab+huawei@kernel.org>,
	joel@joelfernandes.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lkmm@lists.linux.dev,
	netdev@vger.kernel.org,
	peterz@infradead.org,
	stern@rowland.harvard.edu
Subject: [PATCH v8 08/13] tools: ynl_gen_rst.py: drop support for generating index files
Date: Thu, 26 Jun 2025 10:13:04 +0200
Message-ID: <95d1ed00026acbe425f036f860f7bcd1a18ce98b.1750925410.git.mchehab+huawei@kernel.org>
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

As we're now using an index file with a glob, there's no need
to generate index files anymore.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/net/ynl/pyynl/ynl_gen_rst.py | 28 ----------------------------
 1 file changed, 28 deletions(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_rst.py b/tools/net/ynl/pyynl/ynl_gen_rst.py
index 010315fad498..90ae19aac89d 100755
--- a/tools/net/ynl/pyynl/ynl_gen_rst.py
+++ b/tools/net/ynl/pyynl/ynl_gen_rst.py
@@ -31,9 +31,6 @@ def parse_arguments() -> argparse.Namespace:
 
     # Index and input are mutually exclusive
     group = parser.add_mutually_exclusive_group()
-    group.add_argument(
-        "-x", "--index", action="store_true", help="Generate the index page"
-    )
     group.add_argument("-i", "--input", help="YAML file name")
 
     args = parser.parse_args()
@@ -63,27 +60,6 @@ def write_to_rstfile(content: str, filename: str) -> None:
         rst_file.write(content)
 
 
-def generate_main_index_rst(parser: YnlDocGenerator, output: str) -> None:
-    """Generate the `networking_spec/index` content and write to the file"""
-    lines = []
-
-    lines.append(parser.fmt.rst_header())
-    lines.append(parser.fmt.rst_label("specs"))
-    lines.append(parser.fmt.rst_title("Netlink Family Specifications"))
-    lines.append(parser.fmt.rst_toctree(1))
-
-    index_dir = os.path.dirname(output)
-    logging.debug("Looking for .rst files in %s", index_dir)
-    for filename in sorted(os.listdir(index_dir)):
-        base, ext = os.path.splitext(filename)
-        if filename == "index.rst" or ext not in [".rst", ".yaml"]:
-            continue
-        lines.append(f"   {base}\n")
-
-    logging.debug("Writing an index file at %s", output)
-    write_to_rstfile("".join(lines), output)
-
-
 def main() -> None:
     """Main function that reads the YAML files and generates the RST files"""
 
@@ -102,10 +78,6 @@ def main() -> None:
 
         write_to_rstfile(content, args.output)
 
-    if args.index:
-        # Generate the index RST file
-        generate_main_index_rst(parser, args.output)
-
 
 if __name__ == "__main__":
     main()
-- 
2.49.0


