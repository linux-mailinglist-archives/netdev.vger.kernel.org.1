Return-Path: <netdev+bounces-259254-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHXpCsSQlWnoSQIAu9opvQ
	(envelope-from <netdev+bounces-259254-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 11:13:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F32155212
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 11:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EBDBC300CC0E
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 10:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853FE33D6DE;
	Wed, 18 Feb 2026 10:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d02Pp71F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C901334C20;
	Wed, 18 Feb 2026 10:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771409598; cv=none; b=WNdtgxIlvl3fmp2ICLLT00Qy9b4c71Lpm/foGpYrmq2X420PNIYw9mWq0bcnFH9rGDC7zf1G7RgwJQbzaKpyoizAFUypyWSRgbmrFXySHSjMf//fuAq1OpfrQ8ENwyfZSbMJ2bmzNN0B59is1fjJCwbi6+pv0xH4qEVjm3DcEM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771409598; c=relaxed/simple;
	bh=hQYWDaTIE85+WOC6CQ6nA1VAXpHb84+B8MfLik8/hPM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PSUqn7ukby7j2B9m7qH76JS+8GC10vDP0+O8cs5avm//RQtnhwq96HXNWovRp9YgzOo5mZO9xO8LlYd6/tHoyu1gAi1+PRAMaDcigySp7Jzy+Eb/ZX8vTzFb2Cw+WBuOrYNYd/HQMWBn/njQAv3cnJnqnmvHfLzSFjnUIPdpm/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d02Pp71F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0DC7C19423;
	Wed, 18 Feb 2026 10:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771409597;
	bh=hQYWDaTIE85+WOC6CQ6nA1VAXpHb84+B8MfLik8/hPM=;
	h=From:To:Cc:Subject:Date:From;
	b=d02Pp71Fm4vMO7efubkTyWYQJv6OqhWDcfH7yDy5f3q/bpJvvParwNqbJnu6fD63z
	 XXD9RwmeBKw6NyttSW1D1sdSfxwcLeYO9ZRCjhsK+c1MlvUhojI+3xhmDh3LLn4byr
	 uEf4t/XgAsbWQXgKwc7Mgotuz0tz4qk8hsLsqkSQrbrYysWJ8It1Dk9g6/MsQN6phC
	 dBcI8WfcmzOPKKhS8J77QRwNhbjQM8FjmA4wmqNAcZBmWhyXMbmQ8IonJtah5jYby7
	 Cl+G8tW4Bsd+rxAUUmIfQws2Qy+3DyAaWEEuyfbMYdoZ6DDl1axycFfQd8/asJm6Eo
	 jBuuXgC8wniDA==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vseYV-00000000LJW-3Io3;
	Wed, 18 Feb 2026 11:13:15 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Kees Cook <kees@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	linux-doc@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH 00/38] docs: several improvements to kernel-doc
Date: Wed, 18 Feb 2026 11:12:30 +0100
Message-ID: <cover.1771408406.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259254-lists,netdev=lfdr.de,huawei];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mchehab@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,huawei];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C9F32155212
X-Rspamd-Action: no action

Hi Jon,

This series contain several improvements for kernel-doc.

Most of the patches came from v4 of this series:
	https://lore.kernel.org/linux-doc/cover.1769867953.git.mchehab+huawei@kernel.org/

But I dropped from this series the unit tests part. I'll
be sumitting it on a separate series.

The rationale is that, when I converted kernel-doc from Perl,
the goal were to produce a bug-compatible version.

As anyone that worked before with kernel-doc are aware, using regex to
handle C input is not great. Instead, we need something closer to how
C statements and declarations are handled.

Yet, to avoid breaking  docs, I avoided touching the regex-based algorithms
inside it with one exception: struct_group logic was using very complex
regexes that are incompatible with Python internal "re" module.

So, I came up with a different approach: NestedMatch. The logic inside
it is meant to properly handle brackets, square brackets and parenthesis,
which is closer to what C lexical parser does. On that time, I added
a TODO about the need to extend that.

The first part of this series do exactly that: it extends it to parse
comma-separated arguments, respecting brackets and parenthesis.

It then adds an "alias" to it at class CFunction. With that, specifying
functions/macros to be handled becomes much easier.

With such infra in place, it moves the transform functions to a separate
file, making it hopefully easier to maintain. As a side effect, it also
makes easier for other projects to use kernel-doc (I tested it on QEMU).

Then, it adds support for newer kref annotations.

The remaining patches on this series improve the man page output, making
them more compatible with other man pages.

-

I wrote several unit tests to check kernel-doc behavior. I intend to
submit them on the top of this series later on.

Regards,
Mauro

Mauro Carvalho Chehab (36):
  docs: kdoc_re: add support for groups()
  docs: kdoc_re: don't go past the end of a line
  docs: kdoc_parser: move var transformers to the beginning
  docs: kdoc_parser: don't mangle with function defines
  docs: kdoc_parser: add functions support for NestedMatch
  docs: kdoc_parser: use NestedMatch to handle __attribute__ on
    functions
  docs: kdoc_parser: fix variable regexes to work with size_t
  docs: kdoc_parser: fix the default_value logic for variables
  docs: kdoc_parser: add some debug for variable parsing
  docs: kdoc_parser: don't exclude defaults from prototype
  docs: kdoc_parser: fix parser to support multi-word types
  docs: kdoc_parser: add support for LIST_HEAD
  docs: kdoc_re: properly handle strings and escape chars on it
  docs: kdoc_re: better show KernRe() at documentation
  docs: kdoc_re: don't recompile NestedMatch regex every time
  docs: kdoc_re: Change NestedMath args replacement to \0
  docs: kdoc_re: make NestedMatch use KernRe
  docs: kdoc_re: add support on NestedMatch for argument replacement
  docs: kdoc_parser: better handle struct_group macros
  docs: kdoc_re: fix a parse bug on struct page_pool_params
  docs: kdoc_re: add a helper class to declare C function matches
  docs: kdoc_parser: use the new CFunction class
  docs: kdoc_parser: minimize differences with struct_group_tagged
  docs: kdoc_parser: move transform lists to a separate file
  docs: kdoc_re: don't remove the trailing ";" with NestedMatch
  docs: kdoc_re: prevent adding whitespaces on sub replacements
  docs: xforms_lists.py: use CFuntion to handle all function macros
  docs: kdoc_files: allows the caller to use a different xforms class
  docs: kdoc_re: Fix NestedMatch.sub() which causes PDF builds to break
  docs: kdoc_files: document KernelFiles() ABI
  docs: kdoc_output: add optional args to ManOutput class
  docs: sphinx-build-wrapper: better handle troff .TH markups
  docs: kdoc_output: use a more standard order for .TH on man pages
  docs: sphinx-build-wrapper: don't allow "/" on file names
  docs: kdoc_output: describe the class init parameters
  docs: kdoc_output: pick a better default for modulename

Randy Dunlap (2):
  docs: kdoc_parser: ignore context analysis and lock attributes
  docs: kdoc_parser: handle struct member macro
    VIRTIO_DECLARE_FEATURES(name)

 Documentation/tools/kdoc_parser.rst   |   8 +
 tools/docs/kernel-doc                 |   1 -
 tools/docs/sphinx-build-wrapper       |   9 +-
 tools/lib/python/kdoc/kdoc_files.py   |  54 +++++-
 tools/lib/python/kdoc/kdoc_output.py  |  73 ++++++--
 tools/lib/python/kdoc/kdoc_parser.py  | 183 ++++---------------
 tools/lib/python/kdoc/kdoc_re.py      | 242 ++++++++++++++++++++------
 tools/lib/python/kdoc/xforms_lists.py | 109 ++++++++++++
 8 files changed, 451 insertions(+), 228 deletions(-)
 create mode 100644 tools/lib/python/kdoc/xforms_lists.py

-- 
2.52.0


