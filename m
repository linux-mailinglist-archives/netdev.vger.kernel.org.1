Return-Path: <netdev+bounces-280465-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLiKO9vx6GkdRwIAu9opvQ
	(envelope-from <netdev+bounces-280465-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:05:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A04DA4483CC
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 150AE3010B65
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 16:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D3737FF7A;
	Wed, 22 Apr 2026 16:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2GBCcGM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0FB32AAA7
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 16:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776873912; cv=none; b=Ekru+zt1hIqMg3ba2Jbhvx8SoFT8KTQUxkOLD3jrQRbCCsCoL2XosSW0fNQmVZ0tHBbm4IYThduS77pOADnZEx2VDKG7RItS8r8kmd5Os4JNGUArrNmdCfapdvjTdeO2GBw/lJIiyPE3l0z88IoFD/InPOmQnwGOTQd4Kn49gM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776873912; c=relaxed/simple;
	bh=VZEs0jCnFC8H/qkvnT27RK2A5MyzuOg0UJ8UJ0X/Bvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bSRMuO7ccR4M5q27ANnV/DSEE0JfMbLTOWAzW4rhrhflaWcRre1YZ2qA3syubbil/WyOh3jcKyN0b+f5jaaRfHWXFIzuH6YyvGfa1q0z+H7K7v4iPiQt5O2xa1ZfHG4XTZeeSeeEd3fRah99bDiFsSFQ9fdrCdy+K/QtZ+1JVcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e2GBCcGM; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2dee127b3c5so7293921eec.1
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 09:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776873909; x=1777478709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8j25ZLlpELNU+5nioGRIXycqczMeWBKR/3eVX7cdAHw=;
        b=e2GBCcGMHG0QpPUpxaApWMuLj6PXzU2Wr+zxcpsv5Tux9S8rX5y1bZ96/W/DdWuW/2
         t/wpLWZ/zdDBeft8QopKsqxISrZr5VQfy5n0k18dTxQHBLH4ZrBSIGJIwWm7PMgcRaUz
         +ekMujxNpYQKUqYMC+WSh7V9jBvTumc32I1vGHuez79FuPToRabuVOG4TW7WXn7p6A7t
         OPC9IIjTq+3AkUtz+S4/TS151Ia3goSbUBH50xT0vZRJWoSGzmoo29wILktPcm679Dcu
         8IIV5lm5ARgbk4KJgpf3RpMG7fBxU5MA42L/U/8djFh3zNM+FelOynpxoPaEQrXGc9pn
         hYEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776873909; x=1777478709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8j25ZLlpELNU+5nioGRIXycqczMeWBKR/3eVX7cdAHw=;
        b=oLypg2y43pYd44BQdjs59IdgT37LNJ+x1lwKH7D1ujmgqVdUNa8/RyCUOP+ckdrATf
         XMUPihxpP4GzcGJfwqQcxb+tY3SDt2GPAo2yZxeFsCW2PfApqzHoBXezLum2/Lc+ekt8
         S/cY+8sNG+uc1S71Ae3NlFCetzx2cDuHQPRdqmyYuI3Ls5Z9/fObmHbWS86tlX3rvzns
         II9pm6jUKy7OokMcNRTBCA5KglL4RBn9cRLF3oXxg1YedyBMj14MzkcOXt937tOVK4Nn
         3gzyLLWVQUN9mb1OuSAPkBExlP1taXRHn+qfr9PKwaQDvva2u0Hv5gub1grEP2UIB+oQ
         P+OQ==
X-Forwarded-Encrypted: i=1; AFNElJ/aK3NDCPwFBiuq0oKLRsdFeAhnpPVsOF2pgOjAputAy5RXL4v6Emy/hYytoSjWkhjVHJ2kQp4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/GwjH8/QoaX4RyetsD0y/eKG1KVfHVTG8dVN9gcj5nkR01Yr1
	XrMMHJu8kjsvfbfgJMUSsQFlp+7mwwcPyQWE1ihcCb3wcqHAWdeguui+
X-Gm-Gg: AeBDiev04wJPK8Imrtp9qFFHmThy7lMjHgDbEs8haUYv4pe3PWhErgtanr5wzmAJtlX
	TbkaSP34pjKq+z0+ev39zt15JwykrV03cn436c8j4M+819LVn0+U8PHVhF+iv/LB9ap6b7B0O9z
	ARMIRsYCxftfjVNMbDXuBvFwF0nTk4kZr2qxFokxM9QrmZ+87ovunsEuW90M4RVSMEpSua/Blnk
	EwlAoti1hpF3ARWVsUqx4/XMoBhlPhHD7ahL8Xx6d744Rk47ru5z0L18gD4PRsQLnRfnbLSD6sL
	1q2+lsNAD0h/ZP9bxdhYnkyAqTtP8mGR6WD58ebLxBvQ6NszyE+jPRtDV4izmhBCb2aeDoA3gOL
	0CFYi2WfAr4p3ByJqNO6vEcxa2w9bqjHBGjECX+u8ipzmGFdD+CeBrwQYv3Cn3SFBgAvtM+8UEl
	P+0duZnnSA40mb0d/FB/5P8zq0HzbAfzdBIHjXdHpB0AATMGqa8bzxg8sBFRedGKrCsvt6/hX1M
	jjhi6UUrBoSI38psq16Z/c8ayZeh7Y=
X-Received: by 2002:a05:7300:d516:b0:2db:2089:460f with SMTP id 5a478bee46e88-2e478c1ee94mr12945274eec.19.1776873909017;
        Wed, 22 Apr 2026 09:05:09 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ac462d9sm136370786d6.7.2026.04.22.09.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 09:05:08 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Samuel Mendoza-Jonas <sam@mendozajonas.com>,
	Paul Fertser <fercerpav@gmail.com>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	Michael Bommarito <michael.bommarito@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net 3/6] net/ncsi: validate GMCMA address counts against the payload
Date: Wed, 22 Apr 2026 12:03:39 -0400
Message-ID: <20260422160342.1975093-4-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422160342.1975093-1-michael.bommarito@gmail.com>
References: <20260422160342.1975093-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-280465-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FREEMAIL_TO(0.00)[mendozajonas.com,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A04DA4483CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Get MC MAC Address responses carry a flexible array of provisioned
addresses, but the handler currently trusts address_count without first
checking that the advertised payload actually contains that many MAC
entries.

Validate the fixed GMCMA fields plus checksum, then make sure the
address_count fits in the remaining payload before the handler walks
the address array.

Fixes: b8291cf3d118 ("net/ncsi: Add NC-SI 1.2 Get MC MAC Address command")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 net/ncsi/ncsi-rsp.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
index 47ddf2bbb13b..cbddb2012f90 100644
--- a/net/ncsi/ncsi-rsp.c
+++ b/net/ncsi/ncsi-rsp.c
@@ -40,6 +40,14 @@ static bool ncsi_filter_is_enabled(unsigned long enable, unsigned int index,
 	return index < nbits && (enable & BIT(index));
 }
 
+static unsigned int ncsi_rsp_payload(struct sk_buff *skb)
+{
+	struct ncsi_rsp_pkt_hdr *h;
+
+	h = (struct ncsi_rsp_pkt_hdr *)skb_network_header(skb);
+	return ntohs(h->common.length);
+}
+
 static int ncsi_validate_rsp_pkt(struct ncsi_request *nr,
 				 unsigned short payload)
 {
@@ -1127,9 +1135,21 @@ static int ncsi_rsp_handler_gmcma(struct ncsi_request *nr)
 	struct sockaddr_storage *saddr = &ndp->pending_mac;
 	struct net_device *ndev = ndp->ndev.dev;
 	struct ncsi_rsp_gmcma_pkt *rsp;
+	unsigned int addr_bytes;
+	unsigned int payload;
 	int i;
 
 	rsp = (struct ncsi_rsp_gmcma_pkt *)skb_network_header(nr->rsp);
+	payload = ncsi_rsp_payload(nr->rsp);
+	if (payload < sizeof(rsp->address_count) + sizeof(rsp->reserved) +
+		      sizeof(__be32))
+		return -EINVAL;
+
+	addr_bytes = payload - sizeof(rsp->address_count) -
+		     sizeof(rsp->reserved) - sizeof(__be32);
+	if (rsp->address_count > addr_bytes / ETH_ALEN)
+		return -EINVAL;
+
 	ndev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
 
 	netdev_info(ndev, "NCSI: Received %d provisioned MAC addresses\n",
-- 
2.53.0


