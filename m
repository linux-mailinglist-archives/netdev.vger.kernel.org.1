Return-Path: <netdev+bounces-259858-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id /nMuNQ+XmmnrdAMAu9opvQ
	(envelope-from <netdev+bounces-259858-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 06:41:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 366C216E83C
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 06:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 108BC30104B1
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 05:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133BF1A9B24;
	Sun, 22 Feb 2026 05:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOqMJHA/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFD91684B0
	for <netdev@vger.kernel.org>; Sun, 22 Feb 2026 05:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771738890; cv=none; b=XJsblHer6+edjRnRWJvMY8gd2Mb/u91hmbZ++qDQuvh5MMOkKuUktTMcOFmcBPDuu5ACZML9bepOVnvecxwsM5oTE7hyP1unXZe1jevcm6PyaBK3wbsvQuLIOz4sktYUybevcbsiPJUsSx1Lv5jeZClCVuwPvAZNlWKykJd0Oq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771738890; c=relaxed/simple;
	bh=tiOyMGmhfH8KYNc0B6oJPh/c+AJzQjfIUmd+AauFWTI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EpNxtqtVY9laMvHRjeY0laTBCiQ5CYCatTW7xNn+l15SOIK/jmGqtlyZkbUsaByLiQbcFiksbEwde7+R09SG8SLyXyT0g3Y4WgGkKAnFUb6OFHWyLTtJajHjiQuaMZ7TJx0Ul4JRQiW9sMuOaRfEpJtGcQuY0ID0za3EUBzznQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LOqMJHA/; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-352dda4a34eso1397804a91.1
        for <netdev@vger.kernel.org>; Sat, 21 Feb 2026 21:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771738887; x=1772343687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p3Z/yBJ2hZx3EcKfd+7Xe19sF+zpgD7i7OaZHR1+Q6w=;
        b=LOqMJHA/aOfvtl6O0mBPQNjBQPYBF2OppuZJqmutDILXzaHRgbEyUDS4SQYnXDucxx
         IebelAZLPYeFBKF+w/UH4IikwywPOjvfs6Szsq1dZPPVvh8BZbVLlpbFNtSqvcIqWP68
         IJyWXFibcsWN1oWrbIDM5FEjNQmhxwSGlOqy2tlPkBJ11GzgNI7jR3YSecuh8gsgW0LS
         KkSh3KjXOt8/ei0z5FduMNbQhLtth9gaaqbra3izj6JIVeq8Qv998NeEfQVEJJr9MsJ9
         aNrw9JRhtWMDxSZoFnwTnKAFXJUKyfVsmiZpNFs7UuRaR5IhQOpSoK9S/gIgXxZOERNM
         D3cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771738887; x=1772343687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p3Z/yBJ2hZx3EcKfd+7Xe19sF+zpgD7i7OaZHR1+Q6w=;
        b=EXLBVGv80Zv8EENJXOwRx2uRk3pZHHgqCCKMT1QyI/uZ/gSQCJ38W4TH5KafGuDV2j
         Rz33U0zvheSrKVXsf+0EgBNyc9sdvkuVbcmzTwm7wOzpY3MEXYTkko07liRcltojAiin
         57r51IW1bPAJfhowoZ2RvySVBsn5UIZq73U0q8odGyg0q7EGElwf6CA7vihyVFl7UMCg
         vThfSOGNbN1uO6uMOelRnCFba8XFOh8pwgil4ouEWeF6QJih4hvxMbT73pYqUK70c6Sn
         MxcMI3LBCeBIe4MHaPUZyPdqE+5wN50sza9adLImbpMtRnOI0jPpzptE4k1zLSFwOeUT
         KFVA==
X-Forwarded-Encrypted: i=1; AJvYcCVRTWq7VNGqgh0Tui4iies1CrDDzLnBP1txXlqZEByyIgCczUYA/aypn2fzKrhcjGWSMEuegR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YygR9JJoevOSXbArzB/z2+O6khNn2Wv8c0j1pr3n4WL0O+rgs1d
	VnpBCWDaUP+FC6N5unet++l3qHoEoS9ZiMm01v1V77MaDXKuRNOp2YUQTmPm+g==
X-Gm-Gg: AZuq6aL5LsNC2/EP2XKAKrvugPHb7rFgTdQtukNujdapz3K0yWWwb/yXijd6ykRPYKh
	Fl42eg6I9Pukalg4L0gCi9YPFZIVt9/ehf0XuZbAVdRHY5F0fXktN3b9gdggRNZ8HHIkk9Q/mFm
	ztiVIT+c8sLDFU7+EQlhYrWjHoft/wNniaS3CRIV/X4FdIaTH+cae/LDoqfW441DAXjg1RIHig7
	mvDakSqoVIidLYqyAZpAL+rnAiwxmM4POnndSV5KT31gH20dFX7bA8aYTBmoSAIU4J2VNgBDZ7s
	RhGPms2ad1pkX2TYTZAMVDBMb7UzEoYWmpEhL0UFgS/SK6xBGOBNG4gVNltLhT8hP55hWuoyrlv
	9dQ0RvlKKrW+XJVh+vSRBaW8HHcVkYLN++Yus//SvGfYsaGx/gZRolt370VH4MNWk4XUNghVuHU
	UKLPOcotap7ZkBputzso1VMe1QflVcCfo6qOoRLgFSGPpmbEC1Ln1t56/k
X-Received: by 2002:a17:90b:5646:b0:354:7be4:a241 with SMTP id 98e67ed59e1d1-358ae81e3d4mr3566849a91.15.1771738886764;
        Sat, 21 Feb 2026 21:41:26 -0800 (PST)
Received: from Ubuntu-Kernel-2204.local.tld ([49.207.50.26])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3589d81cdbfsm9728510a91.7.2026.02.21.21.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Feb 2026 21:41:26 -0800 (PST)
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
Subject: [PATCH] net/ibmveth: fix typo in ibmveth_remove_buffer_from_pool()
Date: Sun, 22 Feb 2026 11:11:17 +0530
Message-Id: <20260222054117.14943-1-abhindeka@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[linux.ibm.com,ellerman.id.au,lists.ozlabs.org,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259858-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abhindeka@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 366C216E83C
X-Rspamd-Action: no action

Correct a typo in ibmveth_remove_buffer_from_pool()
where gro_receive is misspelled in a comment.

Signed-off-by: Abhilekh Deka <abhindeka@gmail.com>
---
 drivers/net/ethernet/ibm/ibmveth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 3108bf50576f..3272134611c2 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
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


