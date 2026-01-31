Return-Path: <netdev+bounces-255503-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HYqHGtmfmkzYQIAu9opvQ
	(envelope-from <netdev+bounces-255503-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 21:30:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9651C3E3A
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 21:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CFE6330193BB
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 20:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE8236827A;
	Sat, 31 Jan 2026 20:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T5K9lXfi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD2E2F7478
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 20:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769891431; cv=none; b=Cpf3DdK4J2ntgOzQs8D7kHt5WFUHSa43Bd6Kz7E7SFjQOa9QK5Qm18YagRsW8q65LD5P/NkFp57LTuie+J1QicIFIHE+C8cM3WmUvvBW/1Gm8hIHHUlSyBXw74EbiyLGr+apBjrUFnPBsDKojImS9hk6yddzxTrhkiHIWR24VYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769891431; c=relaxed/simple;
	bh=YrLARkMIUubX1RMXUb206ecBLrRdcpgg5pAUbAAH9+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kwG2tSv6MTHLVqDmlN+B3RbjL3Sj52d0ExfSvPHwsV92ijigH92Ls83RRqtjmwpNc2lhQqs2jYfIwVVgCae5IBk0PiYba34mpYk9tcSh8Ui0pCRQpdJ4BJrkxNZBTE6qgXuQzk/mtnlJh81dwDKbFimGoqLSCPsvw5FIQUxsF4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T5K9lXfi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D224AC4CEF1;
	Sat, 31 Jan 2026 20:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769891431;
	bh=YrLARkMIUubX1RMXUb206ecBLrRdcpgg5pAUbAAH9+Q=;
	h=From:To:Cc:Subject:Date:From;
	b=T5K9lXfiuAVrVLOR9EiLXAZzvzIFcSPEu9ePejLmyAEXSOJjGBgvVMkGbvEmuuOwi
	 1nGeUnb4P8JvGJqeWFuJrq35jMJVm7woTi3A+MkFtDpaYgMqsKmqIj4IQqyNwSo/jo
	 Pii44hHeXT2UhcYL8xDPhXcZitW3IFYt6ZU2PRzD3xdFUxTl1CQkqP3w11TTJOJXoa
	 bbJv0h51R6Tsye6W55+1gI07/HZdcIpnN2wvcsjk2LtKXKgMyo6b7WXlz+tPTKXznr
	 SU5OA3yUw3nlh6ieue4p5vDHtKjstkceS5XRLYMPwLRis7zzlFj2zSwuIWm2RPanWU
	 nb9GmV2FeQKEQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	donald.hunter@gmail.com,
	sdf@fomichev.me,
	gal@nvidia.com
Subject: [PATCH net-next] tools: ynl: cli: make the output compact
Date: Sat, 31 Jan 2026 12:30:29 -0800
Message-ID: <20260131203029.1173492-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com,fomichev.me,nvidia.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255503-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,fomichev.me:email]
X-Rspamd-Queue-Id: D9651C3E3A
X-Rspamd-Action: no action

Make the default (non-JSON) output more compact. Looking at RSS
context dumps is pretty much impossible without this, because
default print shows the indirection table with line per entry:

  'indir': [0,
            1,
            2,
	    ...

And indirection tables have 100-200 entries each.

The compact output is far more readable:

    'indir': [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15,
              16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29,

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: donald.hunter@gmail.com
CC: sdf@fomichev.me
CC: gal@nvidia.com
---
 tools/net/ynl/pyynl/cli.py | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/net/ynl/pyynl/cli.py b/tools/net/ynl/pyynl/cli.py
index fdac1ab10a40..94a5ba348b69 100755
--- a/tools/net/ynl/pyynl/cli.py
+++ b/tools/net/ynl/pyynl/cli.py
@@ -44,6 +44,10 @@ RELATIVE_SCHEMA_DIR='../../../../Documentation/netlink'
         return f"{modifiers}{text}{Colors.RESET}"
     return text
 
+def term_width():
+    """ Get terminal width in columns (80 if stdout is not a terminal) """
+    return shutil.get_terminal_size().columns
+
 def schema_dir():
     """
     Return the effective schema directory, preferring in-tree before
@@ -103,8 +107,7 @@ RELATIVE_SCHEMA_DIR='../../../../Documentation/netlink'
 
             if attr.yaml.get('doc'):
                 doc_prefix = prefix + ' ' * 4
-                term_width = shutil.get_terminal_size().columns
-                doc_text = textwrap.fill(attr.yaml['doc'], width=term_width,
+                doc_text = textwrap.fill(attr.yaml['doc'], width=term_width(),
                                          initial_indent=doc_prefix,
                                          subsequent_indent=doc_prefix)
                 attr_info += f"\n{doc_text}"
@@ -264,7 +267,7 @@ RELATIVE_SCHEMA_DIR='../../../../Documentation/netlink'
         if args.output_json:
             print(json.dumps(msg, cls=YnlEncoder))
         else:
-            pprint.PrettyPrinter().pprint(msg)
+            pprint.pprint(msg, width=term_width(), compact=True)
 
     if args.list_families:
         for filename in sorted(os.listdir(spec_dir())):
-- 
2.52.0


