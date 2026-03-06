Return-Path: <netdev+bounces-264920-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHlXFIJDq2nJbgEAu9opvQ
	(envelope-from <netdev+bounces-264920-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 22:13:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 322BC227C7B
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 22:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 96AD130387C1
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 21:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1B9481A9C;
	Fri,  6 Mar 2026 21:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdU8y5xv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59922481FBA
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 21:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772831602; cv=none; b=AWESnOEjGezEIW5iyIVgQkuklceFG10zz+cFP7XjksrYubhBmLBtpBMDRbIEEMwKGWbwJUo0nUZdfveNhMFG6F9cYj9tPlzmAJvrTcsNR6HYFYX45dni+vKcpY7g+VCR4xZfGnxK8L1RfFYOm8UxMpOSbHdIdADTR44NZ24ylwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772831602; c=relaxed/simple;
	bh=Eus+ucEHh2KvFjayxMZpsYljo723CWxRdW6bK6DBtKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pj4e3AnxyXabXulnsfX4GO4V5Hl1UI/N0GM+jqDQe2aA/lliS26VZPTeuqgcwYXCTvKlUzadjOF0Y39502zSDB2b0TvXIuIMsNMxXSv3pEo3Qcz6xNjKkw8+BpIklwf5MKvr60Bdkz44lLoumx16eOJBmqFnB6wxQevDsSvSEZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FdU8y5xv; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5a1362c9a3cso2152331e87.2
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 13:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772831600; x=1773436400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kf8fkyYdC+lpqfiu6tiuKMsMUIXPATxKomGIGLejXUY=;
        b=FdU8y5xv0RjkNjll4X9CoOg5Md9+1ctuMARBVQ2IIC6g+WmHW+UuZv6dGwMi6oApcC
         N5gl9Jj5yZDRRNsDa7clC+6gTJ+FRlZ+Cyp3iCxCP9Ev5eYJbSveSySxmb/9eaE2aUMT
         0V1/zo8FRS6znms66+zhoirrpsgJ7Nc173X9kdQ3eiwPcpFePjBnGIFxZlVpsIzQ1ROU
         WdxwSAQ5y7dkOgJZJRbF6Mha5JwffKBdEsrUrIx+MKmrU6AYNZ1s+EoQbb+/AO1T8B7S
         u9Ge8IZ5LvSSqPE1wl6SozxtLJ/8uR2OZK9SqxgZ+eI4TUBzPt/l5+lnw75+iPZPv1l9
         uLtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772831600; x=1773436400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kf8fkyYdC+lpqfiu6tiuKMsMUIXPATxKomGIGLejXUY=;
        b=NIh1L7EO8gfTDdEndQci+djSJ6nr+DZZTtzseVjSkosfwyt54Ry8n8/QIe4V+bhKgO
         bdudfNX5W9X42ttlbRdy8UiVKaFJxvlM6w+B1RQYKeWg0Z5TZYOad4s818e/yeYAnnJe
         2/37cas2wz2O7itGf0ujM/Dfgb8hM5rhDnVbIhkHEfZC3104vUvRd0TVXulci0BB6qY1
         hkV6wKxrCz1W2P9GHDj03jcySTA4jlJBWsZ9PHIFt7/SH8aEO47Wz8rSyRdsHgotGxf6
         OV5qIBjDgs8MJNd7WAMfPZJ6vkK8b9dLarCqgiJZ2TAO8BKAqSAkCzCcgvQxvyucMRhO
         RFXg==
X-Gm-Message-State: AOJu0Yz8tySVFkK2LqetbMDzHcjbbni5NRRZvMqESf1JZ2P5Z070sPiK
	zG0e+tfAK5pKpvm9ku3iSszT7k2swmX1IMBD09by4hLdLK0v8Wy40WfI
X-Gm-Gg: ATEYQzwfVfCUyxjOBuVLzmOPe5COE3xxVChQBtu1ea9uxUF6+tjBhAh6cdQwweSJ0FI
	rS/iWFj3Jtywptv03YUMY3fYqnXARQ3LYYQAei0r6rYTvP12Tt9BT6B5PC4CO5onKymPs9BKnV7
	b7N53HZUVVp39zxFWvyzCA6ddftH4yIzz+M7v2stLMyK13zcL9/E9rfqOxfweITertejny2Y400
	u66d/Djj/iKm9NnJDp6KonD+z7Yi++Gm35G2Wj1OyW90dcw70I6wNggcHKXIPTx/BZUAQLdwns6
	1/EM6vzrHUpuoundk4pAComwEEW069CQgSWmbrIiK8oUcGKPhjX42VSbnbPL7fAtOigmesDDIfz
	r5nbP2WWEI0KQXCL00zRl6H65fhzMbVlOXhwlPvrxy0ZQXj2RHfxxcVGUPdl39eTWezDclf5bk2
	2BWwuE
X-Received: by 2002:a05:6512:3b9d:b0:5a1:2e83:a7f1 with SMTP id 2adb3069b0e04-5a13ccf293emr1267137e87.23.1772831599490;
        Fri, 06 Mar 2026 13:13:19 -0800 (PST)
Received: from router-0001 ([2a01:4f9:3080:2e0f::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a13d07e0f1sm554433e87.58.2026.03.06.13.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 13:13:18 -0800 (PST)
From: Alex Dvoretsky <advoretsky@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	stable@vger.kernel.org,
	kurt@linutronix.de,
	maciej.fijalkowski@intel.com,
	Alex Dvoretsky <advoretsky@gmail.com>
Subject: [PATCH net 2/3] igb: skip reset in igb_tx_timeout() during XDP transition
Date: Fri,  6 Mar 2026 22:13:09 +0100
Message-ID: <20260306211310.1213330-3-advoretsky@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260306211310.1213330-1-advoretsky@gmail.com>
References: <20260306211310.1213330-1-advoretsky@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 322BC227C7B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,linutronix.de,gmail.com];
	TAGGED_FROM(0.00)[bounces-264920-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[advoretsky@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.932];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

When igb_xdp_setup() transitions between XDP and non-XDP mode on a
running device, it calls igb_close() followed by igb_open(). During
this window the adapter is down while trans_start still contains the
timestamp from before igb_close(), so the TX watchdog can fire a
spurious timeout.

The resulting schedule_work(&adapter->reset_task) races with the
igb_open() path: the reset task may run while the device is being
brought back up, or immediately after, causing unexpected ring
reinitialisation and register writes.

Fix this by checking __IGB_DOWN at the top of igb_tx_timeout(). A
reset is unnecessary because the device will be fully reinitialised
by the subsequent igb_open().

Fixes: 9cbc948b5a20 ("igb: add XDP support")
Cc: stable@vger.kernel.org
Signed-off-by: Alex Dvoretsky <advoretsky@gmail.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 223a10cae4a9..ddb7ce9e97bf 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -6651,6 +6651,10 @@ static void igb_tx_timeout(struct net_device *netdev, unsigned int __always_unus
 	struct igb_adapter *adapter = netdev_priv(netdev);
 	struct e1000_hw *hw = &adapter->hw;
 
+	/* Ignore timeout if the adapter is going down. */
+	if (test_bit(__IGB_DOWN, &adapter->state))
+		return;
+
 	/* Do the reset outside of interrupt context */
 	adapter->tx_timeout_count++;
 
-- 
2.51.0


