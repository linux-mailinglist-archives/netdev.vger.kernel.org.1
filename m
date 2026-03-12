Return-Path: <netdev+bounces-267077-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sO2bKqDGsmmvPAAAu9opvQ
	(envelope-from <netdev+bounces-267077-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 14:58:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 287B127300B
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 14:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 14B913038D1C
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 13:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E6431E844;
	Thu, 12 Mar 2026 13:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYDlmXdg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0572351C03
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 13:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773323584; cv=none; b=GmdbyksZLbz7lT73eBn/uyR3Rxs07T+kuJVv4ei9Q2zN0pgaHheiiz8mx5KA2wGbC1L5UFzUtcnbAwTn5OHt8AiLPYtkzGkcge3PffyUF1xUmaqDtTU35u9U20kwx2PnF/VSRrJg7axm0+nISqXgHtVkOZMRSbn/oGivud2Up40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773323584; c=relaxed/simple;
	bh=faGQyXQIEexLrthjMYjIHjLk24UDy8P/kcRREOrNBbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JcJCZoGzQdi4WMLy2+f41EXDm/k1bBmI32jYCKvB+7ZFQis75t5ynIbT6SxWyMw0SEJH+vso8+iC8DlCxeouPackkvIThpxq816iMC4c+5Jwix2wF6KuvxdBq+WBTOrJulxB3AA+FifnpJx5WTPG7pYCTpVFf/0h2REeZjsLi+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iYDlmXdg; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-59e4989dacdso1242942e87.1
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 06:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773323579; x=1773928379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cLa3hjm81+l0iihx+Vd/908jpbxZZUZC18PWTXWrhu0=;
        b=iYDlmXdgN8G30SXRuDdtsayoPCU7SCx+mU24f62X+yRkoa8/QlGzs7do3OTHwjuG+7
         Qad7t6Z+vJwH+bOW8E5bnbdGa91HgaRxF3ZFnHuv5/DPug/DX9kf+AG5rAxqcsOC1YNP
         W0Uy0JKVpneoUrf9HDuk21CT487bt1DrrGHRJXwtRalNv4V5fOhm6XOTkiilAx2VF5+b
         2Nur+58cX2giHwK7LqqJBrzCS+DbhN+ws1HoQU3ujG1SFy0m5dM55Lxc7QT+uec16Arr
         qBx8bMabGMbZXlOxqAuCxj7Pnwqkk+QIY9uKahzymSqqxf5xs0qGeG2VwBF4XHksINpw
         IC9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773323579; x=1773928379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cLa3hjm81+l0iihx+Vd/908jpbxZZUZC18PWTXWrhu0=;
        b=nPid5gKyJ5wtsOfONsXxDI08OkPRvvIqbwQ/qbW43pu0RR4TKRLKxo9BFUfCQbRez+
         sFPIqOuc96VCs4o1QPmRPOR/CTtBkUJAzn+SrMe9Kux2mGxhlmVH1rmntzWrxCQFMyj3
         Fm/P0eNQsXOT5ineW14L0NiuOWfHL5NpfCvhAHo8ii1RdSvLG/UEYk1PF3iQophfuwlF
         fqu/9FNxYEbym8z2tZvEaXcs+TUrIcP4vvsWK7uUeDdWk/GaASDnkvfeYjwn4U+YiXGk
         78FbHR544hh5d2odfHP5Ads7Oq3SARDPCSeYO4jsQ0AQVtxDkosT+zG4cnoWRdWw3QSy
         u0bg==
X-Gm-Message-State: AOJu0YyNvtub0EP8zdKgJcsFIc/y54OsHqz2izrmWPN9D/+qMuJMmVHT
	EOAIYRfUkSGVK7Ov6Q8XabIas0lPi1slfVAf3cp/XgL9bxnn23GLsaYy
X-Gm-Gg: ATEYQzxHuairf5pAEIv64VU+dJLJvEVkJB3CA6m8uRsAe6UlDoMtFqVLTOtrwrymstG
	nOFVtDbmKIExMw0As58ask9uYcTh54S74XkyXSzFXJf252GZOkZRDSWqbOycTxTvwwl17SxZAYb
	/90vpPWnMNNohP9B6RfflF9OUyJtXXKuk+Q+1zSRzNyOnSyMYX2Up0dDwIohJjBqDoeX/YgnONb
	wS8JH/5NUAUGX/MMsOZhoNzNshKsP3RiG694NYWl+6VOVSN+2BNBxEkQnVg5yUcOilgEvAFkEw+
	noKq3zrXri5FO0SG94m4Blc4x3Txz4lyVpat52Z2kIoVnzmZG8ZnbU+MvXaWclZVkH25pHl6jbH
	Gf2kaSmQjMHMwK9yAKF7ybGk1BbOANRDp9hJ5VWRrtd4FzTdZ2D65Ca0zUUUHv1XUIR+eKic8EG
	cnZLSK
X-Received: by 2002:a05:6512:1441:10b0:5a1:34d2:b6db with SMTP id 2adb3069b0e04-5a156bb980dmr1557195e87.1.1773323579188;
        Thu, 12 Mar 2026 06:52:59 -0700 (PDT)
Received: from router-0001 ([2a01:4f9:3080:2e0f::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a156033a29sm954117e87.37.2026.03.12.06.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 06:52:58 -0700 (PDT)
From: Alex Dvoretsky <advoretsky@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	maciej.fijalkowski@intel.com,
	aleksandr.loktionov@intel.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	kurt@linutronix.de,
	stable@vger.kernel.org,
	Alex Dvoretsky <advoretsky@gmail.com>
Subject: [PATCH net v3] igb: remove napi_synchronize() in igb_down()
Date: Thu, 12 Mar 2026 14:52:55 +0100
Message-ID: <20260312135257.71610-1-advoretsky@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <DS4PPF7551E65520F55DBD20987BCAE3C6FE544A@DS4PPF7551E6552.namprd11.prod.outlook.com>
References: <DS4PPF7551E65520F55DBD20987BCAE3C6FE544A@DS4PPF7551E6552.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,linutronix.de,gmail.com];
	TAGGED_FROM(0.00)[bounces-267077-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[advoretsky@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 287B127300B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When an AF_XDP zero-copy application terminates abruptly (e.g., kill -9),
the XSK buffer pool is destroyed but NAPI polling continues.
igb_clean_rx_irq_zc() repeatedly returns the full budget, preventing
napi_complete_done() from clearing NAPI_STATE_SCHED.

igb_down() calls napi_synchronize() before napi_disable() for each queue
vector. napi_synchronize() spins waiting for NAPI_STATE_SCHED to clear,
which never happens. igb_down() blocks indefinitely, the TX watchdog
fires, and the TX queue remains permanently stalled.

napi_disable() already handles this correctly: it sets NAPI_STATE_DISABLE.
After a full-budget poll, __napi_poll() checks napi_disable_pending(). If
set, it forces completion and clears NAPI_STATE_SCHED, breaking the loop
that napi_synchronize() cannot.

napi_synchronize() was added in commit 41f149a285da ("igb: Fix possible
panic caused by Rx traffic arrival while interface is down").
napi_disable() provides stronger guarantees: it prevents further
scheduling and waits for any active poll to exit.
Other Intel drivers (ixgbe, ice, i40e) use napi_disable() without a
preceding napi_synchronize() in their down paths.

Remove redundant napi_synchronize() call and reorder napi_disable()
before igb_set_queue_napi() so the queue-to-NAPI mapping is only
cleared after polling has fully stopped.

Fixes: 2c6196013f84 ("igb: Add AF_XDP zero-copy Rx support")
Cc: stable@vger.kernel.org
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Alex Dvoretsky <advoretsky@gmail.com>
---
Agreed, that looks cleaner — no reason to touch the NAPI plumbing while
the poll could still be running.

v3:
  - Reorder napi_disable() before igb_set_queue_napi() per Aleksandr
    Loktionov's suggestion.

v2:
  - Replaced 3-patch series with single napi_synchronize() removal,
    per Maciej Fijalkowski's suggestion. napi_disable() handles the
    stuck NAPI poll via NAPI_STATE_DISABLE, making the __IGB_DOWN
    checks in igb_clean_rx_irq_zc() and igb_tx_timeout(), and the
    transition guards in igb_xdp_setup(), all unnecessary.
  - Tested on Intel I210 (igb) with AF_XDP zero-copy: full E2E
    traffic suite, graceful shutdown, and 5x kill-9 stress cycles.
    Zero tx_timeout events.

 drivers/net/ethernet/intel/igb/igb_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 7c41e32256fa..0793842cb937 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -2203,9 +2203,8 @@ void igb_down(struct igb_adapter *adapter)
 
 	for (i = 0; i < adapter->num_q_vectors; i++) {
 		if (adapter->q_vector[i]) {
-			napi_synchronize(&adapter->q_vector[i]->napi);
-			igb_set_queue_napi(adapter, i, NULL);
 			napi_disable(&adapter->q_vector[i]->napi);
+			igb_set_queue_napi(adapter, i, NULL);
 		}
 	}
 
-- 
2.51.0


