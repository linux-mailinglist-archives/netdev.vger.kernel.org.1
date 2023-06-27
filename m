Return-Path: <netdev+bounces-14230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BF473FACA
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 13:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FA881C209BF
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 11:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285AB174FF;
	Tue, 27 Jun 2023 11:10:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C72C10F9
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 11:10:12 +0000 (UTC)
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 27 Jun 2023 04:10:09 PDT
Received: from h1.cmg1.smtp.forpsi.com (h1.cmg1.smtp.forpsi.com [81.2.195.162])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760B71BE8
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 04:10:08 -0700 (PDT)
Received: from lenoch ([91.218.190.200])
	by cmgsmtp with ESMTPSA
	id E6ZDqDEhkPm6CE6ZEqdxdu; Tue, 27 Jun 2023 13:09:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triops.cz; s=f2019;
	t=1687864144; bh=QJwm9O4eOCKZW+kXrCWmyiHkoLcbfR6b9a4Ww9MQU3s=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	b=vmO4A4CgOQ2M+G8ikEhbJ9wZ6pIQTZ2fBgwohhTkvRYp6BulQP0i/ImBPQs8aUnHI
	 7xxVAoJjI5aiFdkn/3CzdHCD5L5Ygw7vkUvi+EfytTBnTF/dY4Ejd028UrE5uaO0Az
	 8zu4zLwBpL5SdLbAxkvdiISOpp2U3ZVSVNG4Uz21eoYL+hNTJnh4CcDQPEXTNMnNSF
	 AA3p+ejxSY+M3ef3/1tFXN1db+PfcAu2DKYqQZHBUEyd6HnDfQ8REw0SlvXhfGJNBR
	 ZYGWtcJjKntbAg/SX9ml3SYlGQFELSwye+9ikyRPVaSf3LbwIHs9WGsu42hAj4Gr2A
	 48+CP3NokvhVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triops.cz; s=f2019;
	t=1687864144; bh=QJwm9O4eOCKZW+kXrCWmyiHkoLcbfR6b9a4Ww9MQU3s=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	b=vmO4A4CgOQ2M+G8ikEhbJ9wZ6pIQTZ2fBgwohhTkvRYp6BulQP0i/ImBPQs8aUnHI
	 7xxVAoJjI5aiFdkn/3CzdHCD5L5Ygw7vkUvi+EfytTBnTF/dY4Ejd028UrE5uaO0Az
	 8zu4zLwBpL5SdLbAxkvdiISOpp2U3ZVSVNG4Uz21eoYL+hNTJnh4CcDQPEXTNMnNSF
	 AA3p+ejxSY+M3ef3/1tFXN1db+PfcAu2DKYqQZHBUEyd6HnDfQ8REw0SlvXhfGJNBR
	 ZYGWtcJjKntbAg/SX9ml3SYlGQFELSwye+9ikyRPVaSf3LbwIHs9WGsu42hAj4Gr2A
	 48+CP3NokvhVQ==
Date: Tue, 27 Jun 2023 13:09:03 +0200
From: Ladislav Michl <oss-lists@triops.cz>
To: Michal Kubecek <mkubecek@suse.cz>
Cc: netdev@vger.kernel.org
Subject: [PATCH ethtool] netlink: fix duplex setting
Message-ID: <ZJrDT9k52oFTf/vs@lenoch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CMAE-Envelope: MS4wfGwq9r/oxR1sZIvSsx9PlfDQdULTKJuH1ulGO2Icv0IYvJS2UfUwUWldHbiyY5XcLv/spX7Xm+uKmSlXAe59dQn+8AW7nchqmLm8b49HgQOzAxARDVU+
 dC7HL3QMukVNZECQB2Wred5hFacbHV/RDqn2V7nzsHxDgrSCCeLnbCmGuYwvfShwzlzly+OQ3DLwoA==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Ladislav Michl <ladis@linux-mips.org>

nl_parse_lookup_u8 handler is used with duplex_values defined as
lookup_entry_u32. While it still works on little endian machines,
duplex is always 0 (DUPLEX_HALF) on big endian ones...

Fixes: 392b12e38747 ("netlink: add netlink handler for sset (-s)")
Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 netlink/settings.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/netlink/settings.c b/netlink/settings.c
index 4fd75d2..9aad8d9 100644
--- a/netlink/settings.c
+++ b/netlink/settings.c
@@ -1089,7 +1089,7 @@ static const struct bitset_parser_data advertise_parser_data = {
 	.force_hex	= true,
 };
 
-static const struct lookup_entry_u32 duplex_values[] = {
+static const struct lookup_entry_u8 duplex_values[] = {
 	{ .arg = "half",	.val = DUPLEX_HALF },
 	{ .arg = "full",	.val = DUPLEX_FULL },
 	{}
-- 
2.39.2


