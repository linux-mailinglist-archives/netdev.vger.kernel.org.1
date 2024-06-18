Return-Path: <netdev+bounces-104622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD8690D997
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 18:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C903328722D
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 16:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8A613D8AE;
	Tue, 18 Jun 2024 16:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HJOZ2H78"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579FD13D528;
	Tue, 18 Jun 2024 16:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718728967; cv=none; b=HTiajBDM99U1oyPpyz7rUzYdsb0hC19TmGRYSnQfbx8N3OwzP6QbDWB1aD1tVKg54nckLnuI/hRebYC1tQ7fK1s8fb7+3CBknaE4Ah99SP94UtW9XBIx/giobTYH5yyf9eZTzx6GdHDnacgoNt/BtyBhAyfVJlRHabtW+EVjt9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718728967; c=relaxed/simple;
	bh=Qr/Piol41SyDTr0ibCoDbeFx9GblHGb2xJj6m9SypJo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BpqlxJVvIjw+61F3GNej6XsYoIbgjjJB5tNbGCUnLdFvnI2gREx9Fat/M7dxNS2j1sfa0oQv4E2k/h3eRYt9UxW3EY+vwud/MAE1tsZHlxowKigzqbe0MhP8nXeCM84FxmKeLI5GzBJhBr3PUCxZJZ2D86fB1BBi5opSBS6RgKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HJOZ2H78; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE7C8C4DDE7;
	Tue, 18 Jun 2024 16:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718728965;
	bh=Qr/Piol41SyDTr0ibCoDbeFx9GblHGb2xJj6m9SypJo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HJOZ2H78loN1oCPNhjQ3rv6Z/1C2T6mJRimTHteA71viaVYDGJAlfu6zVmKbablxX
	 XdN4SBUnoHPmB9lZ+v2I7gR+ebHTW8ca3NAQxWTsUG8tj1ZfTfaYwoxDjidhpKu5CF
	 zW1DO6XuglEPCIU042f8paHopGZfS1VR8f52IKpM=
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Date: Tue, 18 Jun 2024 12:42:11 -0400
Subject: [PATCH 2/2] Documentation: best practices for using Link trailers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240618-docs-patch-msgid-link-v1-2-30555f3f5ad4@linuxfoundation.org>
References: <20240618-docs-patch-msgid-link-v1-0-30555f3f5ad4@linuxfoundation.org>
In-Reply-To: <20240618-docs-patch-msgid-link-v1-0-30555f3f5ad4@linuxfoundation.org>
To: Jonathan Corbet <corbet@lwn.net>, 
 Carlos Bilbao <carlos.bilbao.osdev@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Konstantin Ryabitsev <konstantin@linuxfoundation.org>, 
 ksummit@lists.linux.dev
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2555;
 i=konstantin@linuxfoundation.org; h=from:subject:message-id;
 bh=Qr/Piol41SyDTr0ibCoDbeFx9GblHGb2xJj6m9SypJo=;
 b=owGbwMvMwCW27YjM47CUmTmMp9WSGNIKdzLy9s2UiDidO3P1zA7pTPMak7/7hbbahe97WDKRf
 /s/gbnvOkpZGMS4GGTFFFnK9sVuCip86CGX3mMKM4eVCWQIAxenAEzkUBUjw8Gza065vd9hF+dp
 NfOxyNPQdf9nTtDO8twWceyw+enXOysZ/hmyikw+qF98YMUFvU0OS8w+pohWbD+5Met1vM6tjRM
 2X+UGAA==
X-Developer-Key: i=konstantin@linuxfoundation.org; a=openpgp;
 fpr=DE0E66E32F1FDD0902666B96E63EDCA9329DD07E

Based on multiple conversations, most recently on the ksummit mailing
list [1], add some best practices for using the Link trailer, such as:

- how to use markdown-like bracketed numbers in the commit message to
indicate the corresponding link
- when to use lore.kernel.org vs patch.msgid.link domains

Cc: ksummit@lists.linux.dev
Link: https://lore.kernel.org/20240617-arboreal-industrious-hedgehog-5b84ae@meerkat # [1]
Signed-off-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
---
 Documentation/process/maintainer-tip.rst | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/Documentation/process/maintainer-tip.rst b/Documentation/process/maintainer-tip.rst
index 64739968afa6..57ffa553c21e 100644
--- a/Documentation/process/maintainer-tip.rst
+++ b/Documentation/process/maintainer-tip.rst
@@ -375,14 +375,26 @@ following tag ordering scheme:
    For referring to an email on LKML or other kernel mailing lists,
    please use the lore.kernel.org redirector URL::
 
-     https://lore.kernel.org/r/email-message@id
+     Link: https://lore.kernel.org/email-message@id
 
-   The kernel.org redirector is considered a stable URL, unlike other email
-   archives.
+   This URL should be used when referring to relevant mailing list
+   resources, related patch sets, or other notable discussion threads.
+   A convenient way to associate Link trailers with the accompanying
+   message is to use markdown-like bracketed notation, for example::
 
-   Maintainers will add a Link tag referencing the email of the patch
-   submission when they apply a patch to the tip tree. This tag is useful
-   for later reference and is also used for commit notifications.
+     A similar approach was attempted before as part of a different
+     effort [1], but the initial implementation caused too many
+     regressions [2], so it was backed out and reimplemented.
+
+     Link: https://lore.kernel.org/some-msgid@here # [1]
+     Link: https://bugzilla.example.org/bug/12345  # [2]
+
+   When using the ``Link:`` trailer to indicate the provenance of the
+   patch, you should use the dedicated ``patch.msgid.link`` domain. This
+   makes it possible for automated tooling to establish which link leads
+   to the original patch submission. For example::
+
+     Link: https://patch.msgid.link/patch-source-msgid@here
 
 Please do not use combined tags, e.g. ``Reported-and-tested-by``, as
 they just complicate automated extraction of tags.

-- 
2.45.2


