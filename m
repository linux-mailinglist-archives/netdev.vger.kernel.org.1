Return-Path: <netdev+bounces-198465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA53ADC413
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 10:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19D3A7A820E
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 08:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40CFE2949E5;
	Tue, 17 Jun 2025 08:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FMBM/Oze"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE5C28F523;
	Tue, 17 Jun 2025 08:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750147352; cv=none; b=LKX9J5rqMmZ17iYuOXPNRfx+YsriOtwki1IaDbq83+k6UOSVKSYid4kvhhmw3LHsn38hMz6ddrqg9GqDyTjRCMHsOJ+uoVn25pdMMRIR2DOoL8PCiv2SuAUm0dbjtI1E6/OVsODIVjINvTnnhHiDNr5daG+tXVetG4fTV51i3q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750147352; c=relaxed/simple;
	bh=C7lqrDjzDa02WPrVr/CYc29SDHPtcet6G1AKkNphAuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FUTtvOgYCeuBi7qZKqmK40t/cvSRzrBNx6uHx/S4V1dWWYLaD5U3OLtkORlfhmFZHSMQ7eT1c8SXF1GzNovdaFBa7iOSiQi7jcOmRTEUNhI8BCx5+lEms/m3mrQExLSMgdlXY861sGsqKJodovKUGgJovWqKX8kmxiWO7kCBvD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FMBM/Oze; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02ED8C4CEF8;
	Tue, 17 Jun 2025 08:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750147352;
	bh=C7lqrDjzDa02WPrVr/CYc29SDHPtcet6G1AKkNphAuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FMBM/OzeZpbZ6Um9QokRlMfbRtVUJ16O25+5MicNyI/Nd+r+QW6IDIeFM2CH0BDW5
	 a7Faw+3aLEDR1Tc8mRQ45U+tasXtppQjzmkxvLeAtcWWRSQDy9K2q+JWXUWiEAV/si
	 ZWz+Tm0EYnZYEVA20taQLW4BotFu1NHR8bc8KHdCIlDhxqRELnK2Mc/5Vdonka9QaB
	 ppFAggD1EnxI1MFrmfed3bxakVgTXaMW42TtaNkCarx3G0X5+Dpqnu2kZ+kLTcGWd2
	 +iEVI4Z5a+u8GYWy4qs+8J6oK1/EfIpdQHDw9AVlV3i9tQxGPteX7XrPDbvTcSgiYr
	 HyH/uD78Yd2nw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uRRH4-00000001vdc-11Nz;
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
Subject: [PATCH v5 13/15] tools: ynl_gen_rst.py: drop support for generating index files
Date: Tue, 17 Jun 2025 10:02:10 +0200
Message-ID: <4cf209151b11701a0dbf53aa4da95784d2927b63.1750146719.git.mchehab+huawei@kernel.org>
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

As we're now using an index file with a glob, there's no need
to generate index files anymore.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/net/ynl/pyynl/netlink_yml_parser.py | 26 -----------------------
 tools/net/ynl/pyynl/ynl_gen_rst.py        | 17 ---------------
 2 files changed, 43 deletions(-)

diff --git a/tools/net/ynl/pyynl/netlink_yml_parser.py b/tools/net/ynl/pyynl/netlink_yml_parser.py
index f71360f0ceb7..866551726723 100755
--- a/tools/net/ynl/pyynl/netlink_yml_parser.py
+++ b/tools/net/ynl/pyynl/netlink_yml_parser.py
@@ -358,29 +358,3 @@ class YnlDocGenerator:
             content = self.parse_yaml(yaml_data)
 
         return content
-
-    def generate_main_index_rst(self, output: str, index_dir: str) -> None:
-        """Generate the `networking_spec/index` content and write to the file"""
-        lines = []
-
-        lines.append(self.fmt.rst_header())
-        lines.append(self.fmt.rst_label("specs"))
-        lines.append(self.fmt.rst_title("Netlink Family Specifications"))
-        lines.append(self.fmt.rst_toctree(1))
-
-        index_fname = os.path.basename(output)
-        base, ext = os.path.splitext(index_fname)
-
-        if not index_dir:
-            index_dir = os.path.dirname(output)
-
-        logging.debug(f"Looking for {ext} files in %s", index_dir)
-        for filename in sorted(os.listdir(index_dir)):
-            if not filename.endswith(ext) or filename == index_fname:
-                continue
-            base, ext = os.path.splitext(filename)
-            lines.append(f"   {base}\n")
-
-        logging.debug("Writing an index file at %s", output)
-
-        return "".join(lines)
diff --git a/tools/net/ynl/pyynl/ynl_gen_rst.py b/tools/net/ynl/pyynl/ynl_gen_rst.py
index 5d29ce01c60c..9e756d3c403d 100755
--- a/tools/net/ynl/pyynl/ynl_gen_rst.py
+++ b/tools/net/ynl/pyynl/ynl_gen_rst.py
@@ -32,13 +32,9 @@ def parse_arguments() -> argparse.Namespace:
 
     parser.add_argument("-v", "--verbose", action="store_true")
     parser.add_argument("-o", "--output", help="Output file name")
-    parser.add_argument("-d", "--input_dir", help="YAML input directory")
 
     # Index and input are mutually exclusive
     group = parser.add_mutually_exclusive_group()
-    group.add_argument(
-        "-x", "--index", action="store_true", help="Generate the index page"
-    )
     group.add_argument("-i", "--input", help="YAML file name")
 
     args = parser.parse_args()
@@ -71,15 +67,6 @@ def write_to_rstfile(content: str, filename: str) -> None:
         rst_file.write(content)
 
 
-def write_index_rst(parser: YnlDocGenerator, output: str, index_dir: str) -> None:
-    """Generate the `networking_spec/index` content and write to the file"""
-
-    msg = parser.generate_main_index_rst(output, index_dir)
-
-    logging.debug("Writing an index file at %s", output)
-    write_to_rstfile(msg, output)
-
-
 def main() -> None:
     """Main function that reads the YAML files and generates the RST files"""
 
@@ -98,10 +85,6 @@ def main() -> None:
 
         write_to_rstfile(content, args.output)
 
-    if args.index:
-        # Generate the index RST file
-        write_index_rst(parser, args.output, args.input_dir)
-
 
 if __name__ == "__main__":
     main()
-- 
2.49.0


