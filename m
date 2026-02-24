Return-Path: <netdev+bounces-260568-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODbpNIPFnWnsRwQAu9opvQ
	(envelope-from <netdev+bounces-260568-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 16:36:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CAAE189185
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 16:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8130730242B8
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 15:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8195286D5E;
	Tue, 24 Feb 2026 15:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WH2FFnyz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E2B27E1DC
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 15:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771947372; cv=none; b=Rb7DMt6qUqP1glXSyfdPnMo0k65V5we1RywrC5HfLkOFa3o3GSQWtoeeHGOhfjoTR7+LunGr9YAElWXNI3rrdQTLJRBefqmmvqg/km6ugvHXc+aahuNATK6S0mQRxa1YgmiOkNdt1h032tzIPUSD5R885jSARNwxT9c7wbN8I4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771947372; c=relaxed/simple;
	bh=NmxLWvbIlebeZn6AKtgHcEK1/JKHs8ZQvP1lC80mkiw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iKgdB34xM48ZEyORK5Rhg3Vgyq086iij2gfgaelIOUJnb49HjGtrUBKijH0/a9Yj+xHzKazpZklLwW/QW6HOMWUs8eDCri/BkGCJkU59gv1jANappSIMdPUoKP5cQFe+BU/yZkcL8MJq8kQcDyFV+XUZgeFQ+vlVhQjuFS0lwzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WH2FFnyz; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-824b32875e7so2718708b3a.3
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 07:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771947371; x=1772552171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J0m5QrjYNnqHXl9e832+w13ILtwNiaT2S5RFUJztWJo=;
        b=WH2FFnyzc7ZgiOb3xmnDcm6qi7tpiinFHSnq2i1q/wvAhARVsTAt5TpSj6ZV2Le8UD
         JOwz2TjsMWE51//RoebWb/5u3VYNDmy72oXk7oAP5YMy+12xQD+R2cWbnD68zW51PCAQ
         fuWnOqiIAKdj70iY5SZ0SdTlK4X+hE7ZpKbJD55HjgD8vx/BJdH5YyyYpJpHMFfEokJB
         vzyDsW8oe6WI3UUBrhIfTbc0VtY1hPn0UXv7l+MOEoZfyDdVm0YOlXDxTQtbypuK6xTN
         KmmWwCEqjXD155oDuOMtveMGpDREv/SXg6oy2jD0iGHf/dY8qfKvpJyDnx1jKtO3JI+m
         wl/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771947371; x=1772552171;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J0m5QrjYNnqHXl9e832+w13ILtwNiaT2S5RFUJztWJo=;
        b=a82b5a1f92GUIVqF6Uoyx2+Eg57cWIj5xF8/1lT2TSXQgUpr4U/L830rQ6Q91clqAC
         26bqxyp//jo9A5SgFiVixYvjVo6rvGyADyDcnWYUWdMGqYFkTQZDrTlpm6AvL5UZ4cP8
         OJ8oORQTIIy1auQL66JY9dxh+NcQpnbIn8hEihk45BEJoh3mKN398sJuvVmTXiuIvnrw
         Ey6vxTquwBpSlo/ro8z0JoFkZxOMdn8Y1OdYLl10KvqO/LwV5qxWQdjtpPXPPf8c5STf
         3NpJXXskfFAT+/TZHuv5so93wXLNEUCjkk8HFB4MWQANogWIjrM2W66Z1Xfpj2NcTc0Y
         adGg==
X-Forwarded-Encrypted: i=1; AJvYcCUoXH1OBLpkWTwa+MvuTU9Db+KX7sOI6Ns1zDj5fe2yTTWpC1ENgYn4VuzU6VzSh3NcyE9nB3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHJ0oeySkUNeyM6/fPASHRK7bHJJCrGfDpbtpJBZ5lJyWlFaaj
	T30+BgU4BvdkQ9w4OsBEhIC4MtZPn8WsqABNjlRg2PhdhU8PHsIRLOMg
X-Gm-Gg: AZuq6aLg1XplozhD+FfUk6Jh0mwhn0ZcDwayidYaiUMF7ws7GJ+Mw5OGmbnb8Kot06w
	zl6myx0YaDfEU+zZYdu7lTP5aIuk9BbK/9GDOEUVxYIpvE1EbWo+Wv2RBQbPNpEGxo7Bl9e2Bq0
	P8B35nZMaxKOweL/1b55qrZdwOxH1ll9vpmQzDosrLezKSxF0mGI+6Ja6P+M8lnxKf0vWFV3UYE
	upZjWT54qSOA4CDswVmynLUR4rskXvAQwkxUWTeSeYf7sXUaWbtrr/FdgKyssHPD9bNmS3jHD6G
	cA2EQaKTQZar02xzsaA6uFQheObKVgc7lPgHZjhkNPttLX6/nfabIBbcmAU6bpL+LIhe+Oa3s8j
	evoutgWY/w5fT7KiEHw80y3CF7+zSZGsgJQFOr/G8wn0KlpdeGEnjnvd+88h9yTTl7L1aNENeYz
	uaMC5ujHj/S9T5fl6L1AF8tbHQY+Hdm2g8Lu9Mh8YmA5zWKVz+enirbnwaptRDpCCZkkM=
X-Received: by 2002:a05:6a21:38e:b0:38d:f745:4d5f with SMTP id adf61e73a8af0-39545ecc333mr11285126637.24.1771947371007;
        Tue, 24 Feb 2026 07:36:11 -0800 (PST)
Received: from Ubuntu-Kernel-2204.local.tld ([49.207.50.26])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd64111csm10698181b3a.6.2026.02.24.07.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 07:36:10 -0800 (PST)
From: Abhilekh Deka <abhindeka@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	nnac123@linux.ibm.com
Cc: maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	linuxppc-dev@lists.ozlabs.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Abhilekh Deka <abhindeka@gmail.com>
Subject: [PATCH v3] net/ibmveth: fix comment typos in ibmveth.c
Date: Tue, 24 Feb 2026 21:06:01 +0530
Message-Id: <20260224153601.17534-1-abhindeka@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linux.ibm.com,ellerman.id.au,lists.ozlabs.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-260568-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abhindeka@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5CAAE189185
X-Rspamd-Action: no action

Correct spelling mistakes in comments:
- Fix misspelling of gro_receive
- Fix misspelling of Partition

Signed-off-by: Abhilekh Deka <abhindeka@gmail.com>
---
 drivers/net/ethernet/ibm/ibmveth.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 3108bf50576f..b2a578e6ff31 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -355,7 +355,7 @@ static void ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
 
 		/*
 		 * If multi rx buffers hcall is no longer supported by FW
-		 * e.g. in the case of Live Parttion Migration
+		 * e.g. in the case of Live Partition Migration
 		 */
 		if (batch > 1 && lpar_rc == H_FUNCTION) {
 			/*
@@ -480,7 +480,7 @@ static int ibmveth_remove_buffer_from_pool(struct ibmveth_adapter *adapter,
 	 */
 	if (!reuse) {
 		/* remove the skb pointer to mark free. actual freeing is done
-		 * by upper level networking after gro_recieve
+		 * by upper level networking after gro_receive
 		 */
 		adapter->rx_buff_pool[pool].skbuff[index] = NULL;
 
-- 
2.34.1


