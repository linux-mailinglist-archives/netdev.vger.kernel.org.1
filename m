Return-Path: <netdev+bounces-259363-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aB/kFpozlmktcAIAu9opvQ
	(envelope-from <netdev+bounces-259363-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 22:48:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FE015A63C
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 22:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16852300B44B
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 21:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1C42E1C7C;
	Wed, 18 Feb 2026 21:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZOxVLe5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908522BD01B
	for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 21:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771451191; cv=none; b=IWQfvDztaarwtxVaF8HddVZQC9Y09iwUiItnyjtLleF7BNjoFcPCLCkRB2VJYsqMhrCcq+0txRAEaGH38DI85DT5904aW+1zdxm+ehRWZc5yqVumg4nMAoV0YHh8y+zowG5kLuEz4Ooa0bXt3l09LdHQfZrt4hiPnYexS9Qde04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771451191; c=relaxed/simple;
	bh=P0/Il9npyvwQLn62cxeIoOWKliEAVOZ+7V1C5oo+W9w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NyBj1gHM2VaSXZU64B6XOKAE6AeYotGPFpIq4tzwo41G+HC55dhvkfome/mwLIkOES66+tsRS66kv1KrguYL/NiJ3kwZRww2m02Y6LamU+28puKd6HLEt5wFm/omQ5L+aiPPvlfMub8vXDyNMpFHCtTV+U0v26mVyhABB6aFbkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UZOxVLe5; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7d18d02af68so231475a34.2
        for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 13:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771451189; x=1772055989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5tJCpYu5Aqu3SCTi6Z1y/WvAGJgsYQgmeC76AQDJpV8=;
        b=UZOxVLe5qAelOOlYRA5BSiFRZs2ELqFWJ2xl/quB95TaRSFve2RxiJrhYuWuWr3ocF
         imP/K9tkImvvqacU6ms71wJegGiQ8pqzt8c4VathAOgh0fbAbqbTWNXnqjTDQtQ1sEJt
         b2EgdUA+7wlcV9zxLZuW+d7EZgeD3I8GwnqJWJPfiUq23G7ekeoFKIdMS++xsWBJwjPJ
         CXl2UnenuClaSmSIWZylw2f/Co5j9hWm9Y5oSvhZbpL6FW6uTp6mX4kjobjKGodX+GAT
         +0IxBGTVxvGCUmuWnYi+FY+qM0GqmKRm37xH1jvRbadU26I5g3OdlgUSWzQ2Qnp3gm+F
         MjCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771451189; x=1772055989;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5tJCpYu5Aqu3SCTi6Z1y/WvAGJgsYQgmeC76AQDJpV8=;
        b=j8KPDbvZzC27p7C4E1f6F2hwDNB9hhJu/sAYKTwdqH6dxlqs2XJiyTpRpDMy51WoIK
         oB7MShf+P2LAEO4vEu4cKPKL83kT8YWLx9wjitthgbh1RmBLP3oEHDKjhDG8q59yc88c
         uWs6wXrRnNDHgbc3gB629BdlA26bAX2W5zTnvCy09Rz475hSyB+j2kmAVXxZKoqfCbE/
         N2mGu3HpsboAIcXg5QI53hgMsC2eDP7IamWVE4BiMxNj1hhv4COaRavLJiluRvRh+2o4
         zjH58jPuzef5P/cgGCMU6VFF6e+l+IprgTT3kZVHHKyXlyByFNS8r1h17IZeQ2BP6lX6
         WMWg==
X-Gm-Message-State: AOJu0YyXknDAay/8x6IBjmuXOc9V5hUsWEbY+MiBCgFmLIJaOzGo4S6z
	XZyPEo4TSU/DDnpNETBX+2DveZMWoTpP1gVeP+y1ddkK1b5szPBTXLVADsB71Mc=
X-Gm-Gg: AZuq6aJhbdGnalMn4s8PCgVKqPeWN0+I1zZVFnQ8Y/beldyraWFmtjVtH0Df4vJmI7t
	cKT5U5sqe7xx3LROMX4q7NFOGI8T2Cwdl8A6LU+yehsYNAd6JY4Mvrya6o3K+ZPlQoZEUQKXswV
	tVHoNtkXE6i6Xc4MWYBrlbF0saiD1a9OXdOD3fvCGoBCaD+5/j49pGq4hShF+R3LcBlWAlbIxk1
	TgVIyjETd34IE47sof/WBSQ6ftIuXIjfWhdoTshV4c3lbrrIkPEkVlZyoslYHgzV62PvEdyt6Vy
	cLar1nhQfaKiyVihuTFaoWGnafrQcWfjvO6IJICkcv5oLp/tTiIsyZOMLjFfflRKWrzlyHpUeFs
	tUfx2ux9mkOcu8E8yBszXF1kJdr0EGmXUa3dkUXUNI5v7ZrcCKWYrNrRhsCnNZYA1MAf8QiPzlE
	Kw1DbLVQXM1Odct9hIwkMT
X-Received: by 2002:a05:6830:6419:b0:7d1:586a:32a2 with SMTP id 46e09a7af769-7d4c2c20cd9mr14360263a34.0.1771451189370;
        Wed, 18 Feb 2026 13:46:29 -0800 (PST)
Received: from UASC-Terminal.. ([2600:100c:b0ae:1a2f:5410:d2a6:d250:6d36])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d4da074c15sm10739072a34.15.2026.02.18.13.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 13:46:29 -0800 (PST)
From: Sam Swicegood <samswicegood@gmail.com>
X-Google-Original-From: Sam Swicegood <sam@gib.games>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kuniyu@google.com,
	Sam Swicegood <sam@gib.games>
Subject: [PATCH] nfc: llcp: check skb tailroom before appending TLV
Date: Wed, 18 Feb 2026 16:45:31 -0500
Message-ID: <20260218214550.53342-1-sam@gib.games>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259363-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[samswicegood@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 82FE015A63C
X-Rspamd-Action: no action

llcp_add_tlv() appends TLV data to an skb using skb_put_data()
without first verifying that sufficient tailroom is available.

Add a tailroom check to avoid writing past end of the skb when
building LLCP PDUs.

Signed-off-by: Sam Swicegood <sam@gib.games>
---
 net/nfc/llcp_commands.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/nfc/llcp_commands.c b/net/nfc/llcp_commands.c
index b652323bc2c1..10acc5da954f 100644
--- a/net/nfc/llcp_commands.c
+++ b/net/nfc/llcp_commands.c
@@ -300,9 +300,10 @@ static struct sk_buff *llcp_add_header(struct sk_buff *pdu,
 static struct sk_buff *llcp_add_tlv(struct sk_buff *pdu, const u8 *tlv,
 				    u8 tlv_length)
 {
-	/* XXX Add an skb length check */
+	if (!pdu || !tlv)
+		return NULL;
 
-	if (tlv == NULL)
+	if (skb_tailroom(pdu) < tlv_length)
 		return NULL;
 
 	skb_put_data(pdu, tlv, tlv_length);
-- 
2.43.0


