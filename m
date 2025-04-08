Return-Path: <netdev+bounces-180141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DA8A7FB47
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 12:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEBE417CFAE
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 10:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6CB267F4F;
	Tue,  8 Apr 2025 10:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EoOCA0gj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC891267B97;
	Tue,  8 Apr 2025 10:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744106998; cv=none; b=E6JrzAvjKJYVes/eR4mNer+L3uwI/aFXKD5yglx7zR2/GnAm+FqXmVAPKVLsmfHBBh7IOvBUjLwHkMmN1P/3juxZI2IkEWeKkjSdmxxl2ShU6giilt+IszxQITWve4u9nMgsjrFH0kekkWhWrZXFmFyzY0Rla8mOlEtxAxMr+0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744106998; c=relaxed/simple;
	bh=d/BYHBpOIyDxdhqarTYvBnjLDL46UOVxmUyyk5fM4rs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xyeqwze+rd2fB/T5RPWHRGG5hro2gCcHvISyLuybxKdGty9+XMkJ5mEkeJDcUrRtvqNcjegw+f8vemN/7two6LH4b73F8xtsG51qbNgJvAZ+TDk6bigkJQduza3LRPSAttinJk06ywfLoOJgut0c1xVr4wfmRvM3GsduEa1jzow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EoOCA0gj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A576CC4CEEF;
	Tue,  8 Apr 2025 10:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744106998;
	bh=d/BYHBpOIyDxdhqarTYvBnjLDL46UOVxmUyyk5fM4rs=;
	h=From:To:Cc:Subject:Date:From;
	b=EoOCA0gjpP5kNp7IxMvdfhSXk4LE0e0klVMlet9TnM4SOeEop12AZMGueqoT9ROEC
	 5Q4b9DJrE9QXgKc0BG/zu+wFDm427U8sS+wSJW1cdC/wFDSfRV75A1KUYORhrhl0A3
	 3M5GJ3rJM/+5kxPIjxFi3/T1kd8fSoLASrkAhw1srQmnbGL4OOe1Ll7GnaJIM6hPb6
	 LKVVkGxS6gLZCFoH7VKzUTav1JFp4YcbV2hHQelH+o7yKYXVJ4KZJyIa8YwpP82TeK
	 dnlYeHX5DF0BDSL1nEj+CPlGdXATmwYpo6VVesqUm7UmyheUmo87u/ijGhcHwbbljQ
	 PoRKhXHBRRGNQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab@kernel.org>)
	id 1u25ts-00000008RVF-3oXj;
	Tue, 08 Apr 2025 18:09:48 +0800
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-hardening@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v3 00/33] Implement kernel-doc in Python
Date: Tue,  8 Apr 2025 18:09:03 +0800
Message-ID: <cover.1744106241.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>

Hi Jon,

This changeset contains the kernel-doc.py script to replace the verable
kernel-doc originally written in Perl. It replaces the first version and the
second series I sent on the top of it.

I tried to stay as close as possible of the original Perl implementation
on the first patch introducing kernel-doc.py, as it helps to double check
if each function was  properly translated to Python.  This have been 
helpful debugging troubles that happened during the conversion.

I worked hard to make it bug-compatible with the original one. Still, its
output has a couple of differences from the original one:

- The tab expansion works better with the Python script. With that, some
  outputs that contain tabs at kernel-doc markups are now different;

- The new script  works better stripping blank lines. So, there are a couple
  of empty new lines that are now stripped with this version;

- There is a buggy logic at kernel-doc to strip empty description and
  return sections. I was not able to replicate the exact behavior. So, I ended
  adding an extra logic to strip empty sections with a different algorithm.

Yet, on my tests, the results are compatible with the venerable script
output for all .. kernel-doc tags found in Documentation/. I double-checked
this by adding support to output the kernel-doc commands when V=1, and
then I ran a diff between kernel-doc.pl and kernel-doc.py for the same
command lines.

The only patch that doesn't belong to this series is a patch dropping
kernel-doc.pl. I opted to keep it for now, as it can help to better
test the new tools.

With such changes, if one wants to build docs with the old script,
all it is needed is to use KERNELDOC parameter, e.g.:

	$ make KERNELDOC=scripts/kernel-doc.pl htmldocs

---

v3:
- rebased on the top of v6.15-rc1;
- Removed patches that weren't touching kernel-doc and its Sphinx extension;
- The "Re" class was renamed to "KernRe"
- It contains one patch from Sean with an additional hunk for the
  python version.

Mauro Carvalho Chehab (32):
  scripts/kernel-doc: rename it to scripts/kernel-doc.pl
  scripts/kernel-doc: add a symlink to the Perl version of kernel-doc
  scripts/kernel-doc.py: add a Python parser
  scripts/kernel-doc.py: output warnings the same way as kerneldoc
  scripts/kernel-doc.py: better handle empty sections
  scripts/kernel-doc.py: properly handle struct_group macros
  scripts/kernel-doc.py: move regex methods to a separate file
  scripts/kernel-doc.py: move KernelDoc class to a separate file
  scripts/kernel-doc.py: move KernelFiles class to a separate file
  scripts/kernel-doc.py: move output classes to a separate file
  scripts/kernel-doc.py: convert message output to an interactor
  scripts/kernel-doc.py: move file lists to the parser function
  scripts/kernel-doc.py: implement support for -no-doc-sections
  scripts/kernel-doc.py: fix line number output
  scripts/kernel-doc.py: fix handling of doc output check
  scripts/kernel-doc.py: properly handle out_section for ReST
  scripts/kernel-doc.py: postpone warnings to the output plugin
  docs: add a .pylintrc file with sys path for docs scripts
  docs: sphinx: kerneldoc: verbose kernel-doc command if V=1
  docs: sphinx: kerneldoc: ignore "\" characters from options
  docs: sphinx: kerneldoc: use kernel-doc.py script
  scripts/kernel-doc.py: Set an output format for --none
  scripts/kernel-doc.py: adjust some coding style issues
  scripts/lib/kdoc/kdoc_parser.py: fix Python compat with < v3.13
  scripts/kernel-doc.py: move modulename to man class
  scripts/kernel-doc.py: properly handle KBUILD_BUILD_TIMESTAMP
  scripts/lib/kdoc/kdoc_parser.py: remove a python 3.9 dependency
  scripts/kernel-doc.py: Properly handle Werror and exit codes
  scripts/kernel-doc: switch to use kernel-doc.py
  scripts/lib/kdoc/kdoc_files.py: allow filtering output per fname
  scripts/kernel_doc.py: better handle exported symbols
  scripts/kernel-doc.py: Rename the kernel doc Re class to KernRe

Sean Anderson (1):
  scripts: kernel-doc: fix parsing function-like typedefs (again)

 .pylintrc                         |    2 +
 Documentation/Makefile            |    2 +-
 Documentation/conf.py             |    2 +-
 Documentation/sphinx/kerneldoc.py |   46 +
 scripts/kernel-doc                | 2440 +----------------------------
 scripts/kernel-doc.pl             | 2439 ++++++++++++++++++++++++++++
 scripts/kernel-doc.py             |  315 ++++
 scripts/lib/kdoc/kdoc_files.py    |  282 ++++
 scripts/lib/kdoc/kdoc_output.py   |  793 ++++++++++
 scripts/lib/kdoc/kdoc_parser.py   | 1715 ++++++++++++++++++++
 scripts/lib/kdoc/kdoc_re.py       |  273 ++++
 11 files changed, 5868 insertions(+), 2441 deletions(-)
 create mode 100644 .pylintrc
 mode change 100755 => 120000 scripts/kernel-doc
 create mode 100755 scripts/kernel-doc.pl
 create mode 100755 scripts/kernel-doc.py
 create mode 100644 scripts/lib/kdoc/kdoc_files.py
 create mode 100755 scripts/lib/kdoc/kdoc_output.py
 create mode 100755 scripts/lib/kdoc/kdoc_parser.py
 create mode 100755 scripts/lib/kdoc/kdoc_re.py

-- 
2.49.0



