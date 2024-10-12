Return-Path: <netdev+bounces-134788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E51299B2C6
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 12:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0627E1F21016
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 10:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262FC41C6E;
	Sat, 12 Oct 2024 10:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="hlMze5gT"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E2814F9F8;
	Sat, 12 Oct 2024 10:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728727289; cv=none; b=OTkoEh4mJu2uqILbiHDj1k7Bd1i/3hvrhyiKOYcC0+2+wKlID4JfHkeVwbqYN71dGabjRTwXygwvZWZ+WiStzYtj+M/TBYEQwJmxiK8hznIANL23EN9PG9sGcu+CK66CrsjMHcvHIW2yTlokjLHdzFe9H2c7QDQ3Qc4N9whczAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728727289; c=relaxed/simple;
	bh=7TfbiSh7h/FvoSgfkSAdJUsaQDbGBFzhDxW9+YGHlnQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dFlksXQgGFVMCGBwqaT9EXAxMM0dDFKbw/Zk5L7+UavfEprffeQok0IhdoNb2qEJgY3+0FQ9KDt+BvP4Q/DsJCDlZVV34b28LUysVxQvBTkNGd1MGttQqq49mrdnsLBEL22nny7UveJA5Xbq5U5oSDCl4yamg9ai1U2M6PL7uBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=hlMze5gT; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id F117B100003;
	Sat, 12 Oct 2024 12:51:47 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1728726708; bh=V7SirxrsBs4GfKTT3SldwSArpY7B0gckaI0s57IsTCU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=hlMze5gT6xZmYIdjQTdcSG+VzOjK6xKT7hxq+RAbaEVJUYn5JuIhS3OMgbX0sbJF5
	 i6iENO1/+6iD8wWk1afbowx3Mq7ZmXQM09LcNuShlfJsTXQlVlRaLHqEXZnWLDe4qG
	 QMg5+nsKOB0i8hgCV1xNs7dJQ4ASZczhUSNl3x4vMfI3fpC+0HWeoNFlLfTBQT3ncl
	 jhW2BlCA7MPAXFunETbhxYmyi77eDd0QuZGICPmBgguSvqXMoYvfCjNZfo01iTindq
	 JqMsTB43UtCFxbsL1oWQ+cZaRx0anZ6DhPnD2Jin1c/a6v6CG4IbGiIf3U5FHeoCwW
	 sjtBIOGRjuWCw==
Received: from mx1.t-argos.ru.ru (ta-mail-02.ta.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Sat, 12 Oct 2024 12:50:40 +0300 (MSK)
Received: from localhost.localdomain (172.17.210.7) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 12 Oct
 2024 12:50:19 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: Veerasenareddy Burru <vburru@marvell.com>, Abhijit Ayarekar
	<aayarekar@marvell.com>, Satananda Burla <sburla@marvell.com>, Sathesh Edara
	<sedara@marvell.com>
CC: Aleksandr Mishin <amishin@t-argos.ru>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH net v4 0/2] octeon_ep: Add SKB allocation failures handling in __octep_oq_process_rx()
Date: Sat, 12 Oct 2024 12:49:48 +0300
Message-ID: <20241012094950.9438-1-amishin@t-argos.ru>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ta-mail-02.ta.t-argos.ru (172.17.13.212) To ta-mail-02
 (172.17.13.212)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 188393 [Oct 12 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 39 0.3.39 e168d0b3ce73b485ab2648dd465313add1404cce, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, mx1.t-argos.ru.ru:7.1.1;lore.kernel.org:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;t-argos.ru:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/10/12 09:22:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/10/12 08:26:00 #26739312
X-KSMG-AntiVirus-Status: Clean, skipped

__octep_oq_process_rx() is called during NAPI polling by the driver and
calls build_skb() which may return NULL as skb pointer in case of memory
allocation error. This pointer is dereferenced later without checking for
NULL.

In this series, we introduce two helpers to make the fix more readable and
avoid code duplication. Also we handle build_skb() errors inside
__octep_oq_process_rx() to avoid NULL pointer dereference.

A similar situation is present in the __octep_vf_oq_process_rx() of the
Octeon VF driver. First we want to try the fix on __octep_oq_process_rx().

Compile tested only.

Changelog:
v4:
  - Split patch up as suggested by Jakub
    (https://lore.kernel.org/all/20241004073311.223efca4@kernel.org/)
v3: https://lore.kernel.org/all/20240930053328.9618-1-amishin@t-argos.ru/
  - Implement helper which frees current packet resources and increase
    index and descriptor as suggested by Simon
    (https://lore.kernel.org/all/20240919134812.GB1571683@kernel.org/)
  - Optimize helper as suggested by Paolo
    (https://lore.kernel.org/all/b9ae8575-f903-425f-aa42-0c2a7605aa94@redhat.com/)
  - v3 has been reviewed-by Simon Horman
    (https://lore.kernel.org/all/20240930162622.GF1310185@kernel.org/)
v2: https://lore.kernel.org/all/20240916060212.12393-1-amishin@t-argos.ru/
  - Implement helper instead of adding multiple checks for '!skb' and
    remove 'rx_bytes' increasing in case of packet dropping as suggested
    by Paolo
    (https://lore.kernel.org/all/ba514498-3706-413b-a09f-f577861eef28@redhat.com/)
v1: https://lore.kernel.org/all/20240906063907.9591-1-amishin@t-argos.ru/

Aleksandr Mishin (2):
  octeon_ep: Implement helper for iterating packets in Rx queue
  octeon_ep: Add SKB allocation failures handling in
    __octep_oq_process_rx()

 .../net/ethernet/marvell/octeon_ep/octep_rx.c | 82 +++++++++++++------
 1 file changed, 59 insertions(+), 23 deletions(-)

-- 
2.30.2


