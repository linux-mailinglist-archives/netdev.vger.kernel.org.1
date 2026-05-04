Return-Path: <netdev+bounces-284084-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cI5xF90l+Wmz5wIAu9opvQ
	(envelope-from <netdev+bounces-284084-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 01:03:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 002E64C4BA8
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 01:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 817D3301FA85
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 23:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF1A384242;
	Mon,  4 May 2026 23:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="cA/tj015"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D4138D687
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 23:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777935820; cv=none; b=j3cAnE/UNj1DvL0LgjyDypkFM++Zdqknz0YHSeRhP9zI2Wy40KFc3k2o0iQU3UsLR+5bIB9zZYNwC9o6hJPUg3j09WIgAi889sYMEVvXzr9CFygEUdamOOhQogcOo6h73BaL8OKxJkbGxF0ocT6kLB92aSfsSXZJs4YLq1UWnX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777935820; c=relaxed/simple;
	bh=xyrL5T8AsJk/ToMETXqbbDtwu6ZnVcGeKFJ6x1z4nEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QvyDzRY4fKFJzf3WmhpS8kl/UaS6QlusyS00SwjbpAsKqPzoVF/KzbnrxsLp5lYPIgrh4sWKBcnvMuAw812V53EWXoA8BFOi7U/63yW0Js1sxAjAHtX3ulZ3U8Eeaa2ZIglwgCbFpqHB8Q+lr4TMsL8iIo9mCjiE2fQxRcdjhMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=cA/tj015; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488b8bc6bc9so28594665e9.3
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 16:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1777935817; x=1778540617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MBM0OlrQmuYd36e8vhU/lMffJDXcg8ey9ENppibtuC8=;
        b=cA/tj015Zq1vXe+kmQKTH9V83vpjBFuwHVIDZCTFMvP5UYiY/mEXptRj7xduU16Q1P
         rm0TkqRnitPmSvTBDh6NI2rR4c9/wCyf4ErH05iG8GM0TBClyfXRg5ofSJrpE4jQ1UON
         6hwJOMEDKbG+YbhaJ6dLVHj6SHkvCB2V1o4yZ9286sgMNqKoqhbCdGRFfqAKCLIUEbYQ
         I05kdRRyZmpk3OsXguCczOSOzVxMFfnAHZQUMQQY2RROw1NH1Ab5LsZi/jFm0TgdX2UX
         /H41/02naX2AOLaOYRV4y7fsPPYTps37gPTgDLC/c0Ds3vMiM1+WhE+DZ58ZkMaHbN4V
         Xd/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777935817; x=1778540617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MBM0OlrQmuYd36e8vhU/lMffJDXcg8ey9ENppibtuC8=;
        b=jZAtsPrt4vhYSUwv0ZKcaxiQE5Roe/hfKZyfmokADSpQ0xQXH9YYxeMQ/IF0E0PmLo
         vwiFffd1jVWIF6m5JVPPP164tzFgqOtq7WhUv7w6SQpsEkDAi/ojbWpv7GFfdUmUrjRv
         wVlH3A9vhRVRuNlBNsKGEgELKwzAMkToaITbx18cvGIVXKXG/sihnqIpn7TRKXQS0EhH
         KW973qHfkMBnFPrhp4qjqrTrFdIQQxtVk3zyxPagy3ok9HWREu+sjzJ5G1GCwXSSnhng
         2KXdZGqz2Ji96cDEr7P4cwn2b+1Up2pj4a/WVIvthIQv/AIzBz0WkJUiZ9SXbCM0wAEd
         rHJg==
X-Gm-Message-State: AOJu0YweCkzP3bnfW7aepP3YS4WuNO9fPsujFLKFXGgwtgcDlpY8YTIn
	dOvMPPgARLvdr4dCs9BOEMwyFF72oZdtrqUyu4rODGH+8ByEDdpOtgXLqZBtVpi5IXbeavk6vSI
	02GdK8jEKEO2ywKlYOc2YmBKz+goskjNEu76hP96n6ykVD5SDIIvAGRWLo9oxFCRo++U=
X-Gm-Gg: AeBDiesGRhocX5In8p8kMTY5ryXI6KjBVm8PsaWPxI5bCzjWneDOw77SzO18Ttttzbe
	SOfvwAv4paY4ToKafI0VWzBWs+EnMPiNHpup5jFQlsMhvJ9Po5/7oHv8ZpcDDUt07GmR2JXW8P4
	NgVJxRt4XevH9kBEV2lrMIbmaiqWfFAzR2ma2vFRGULEjTOWlWIZ7jehu2Ab+a+ayWD4m42k7XT
	Sv3+qXdQjw5t8rVxxKcLJ+SzEYQoPOWw2OJVXChmOwFlFkG2W2OYjy4/V2Clz3BdpmsO60hPoP/
	84TDjdTK0tUqtGoltkzATtd4Sn2EZxa/UYNS0MOeoTzNyngesKnWQnSNqh52HU794cJUjGNwZlK
	5CEWTdkDnQNHMMOHDj4+bVG0lD1Ep0HcGEEpicnEPY+DOKEYy9pprOndZif3PWPp+7ZUtmB2UGX
	UNgY8pIVbJw4V7kmcErJX0oWB5vrSODmS3jWXkVNRoC9sNPxldz1WVmdiD1A==
X-Received: by 2002:a05:600c:628c:b0:485:9a50:3370 with SMTP id 5b1f17b1804b1-48d187d9124mr6431575e9.8.1777935817471;
        Mon, 04 May 2026 16:03:37 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:1d7d:7ce5:717a:133e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a81ed6bafsm636149165e9.2.2026.05.04.16.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 16:03:37 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	sd@queasysnail.net,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	ralf@mandelbit.com,
	Qingfang Deng <qingfang.deng@linux.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Minqiang Chen <ptpt52@gmail.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net 1/3] ovpn: reset MAC header before passing skb up
Date: Tue,  5 May 2026 01:03:03 +0200
Message-ID: <20260504230305.2681646-2-antonio@openvpn.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260504230305.2681646-1-antonio@openvpn.net>
References: <20260504230305.2681646-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 002E64C4BA8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,queasysnail.net,davemloft.net,kernel.org,redhat.com,mandelbit.com,linux.dev,lunn.ch,gmail.com,openvpn.net];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_FROM(0.00)[bounces-284084-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[openvpn.net:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,openvpn.net:email,openvpn.net:dkim,openvpn.net:mid]

From: Qingfang Deng <qingfang.deng@linux.dev>

After decapsulating a packet, the skb->mac_header still points to the
outer transport header.

Fix this by calling skb_reset_mac_header() in ovpn_netdev_write() to
ensure the MAC header points to the beginning of
the inner IP/network packet, as expected by the rest of the stack.

Reported-by: Minqiang Chen <ptpt52@gmail.com>
Fixes: 8534731dbf2d ("ovpn: implement packet processing")
Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/io.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index db43a1f8a07a..d92bb87be2b2 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -85,6 +85,7 @@ static void ovpn_netdev_write(struct ovpn_peer *peer, struct sk_buff *skb)
 	skb_scrub_packet(skb, true);
 
 	/* network header reset in ovpn_decrypt_post() */
+	skb_reset_mac_header(skb);
 	skb_reset_transport_header(skb);
 	skb_reset_inner_headers(skb);
 
-- 
2.53.0


