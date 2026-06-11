Return-Path: <netdev+bounces-297979-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MqT5GAphKmrMoQMAu9opvQ
	(envelope-from <netdev+bounces-297979-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 09:17:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6DE66F4F2
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 09:17:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=rP2XE2nN;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297979-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297979-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C516C3247130
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 07:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CD93B6C13;
	Thu, 11 Jun 2026 07:13:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A1A3B47E5
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 07:13:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781162004; cv=none; b=MEd7Tv2zVdlpgUwqy2QVmtNF6Y2jycPC4cCVG+jBMkfWuklaPrMuThj+9hrqPC8aX4XPurwYXys8Rt8quuLFHmpRy8QhhDoz/JsY781GM4V1h0BXJTVWr40FNE/+dOk8XBteGibkbOwIYTX79y2/Cam+Xl06813ZSxhNntTVYgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781162004; c=relaxed/simple;
	bh=xIYuk1b0GTpsWcIVIg4zf/5vOm0XAhvVbZrtDZjApvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tA7UwIkAuhLnLl3uBkKuDc6dNtxpPAUkHtmfQ5+Ko0+oR6DL+UeB2BJ+8DAmdX/ptQClGnOnmeCOXsLnKQK7uZ2TdLj71jRE/j4IFJABrDv5NGZykN9FKBdRZxJkiIEjFUmJu7Bh15CYmucUqXHJjtohOKH03+c90/5A9EuhXXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rP2XE2nN; arc=none smtp.client-ip=209.85.128.194
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-7f5eb760240so11383507b3.0
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 00:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781162002; x=1781766802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KuaK5tAXGNz9SIgM947GwEn0x65wr34XvqFUv1VfkTw=;
        b=rP2XE2nNNIpSmnn4vFxfD4LMIHZS0abPdZ0L4g3Tkeke9KscuClA6wAVgFMkFIAIY9
         BBhExw75qxfusLQtX3KHmEbLhlL9O8BN/qrR9hYtE9PDzIQEJDqbCJrPuKYejbraEktr
         kEgMHlcqv1/cIHdKBaO1D11jVkSwkRwB5dt+sZopL/FNAEkOuErXX0Zx6plgHZkR/ozW
         KEAgkaWwf0pJY1JA/Qtyd3p8HoZh2cyUXW5NWiP8aTtYLQwEIpVhkrkghUXcgDyC4Dak
         jlEkAafdzCaPU/Bl97W3ZhxxJ1VQWD5qVBJ8a4jjNFKWpreZN7aoxCwTwJPVDZuHViOv
         4RVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781162002; x=1781766802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KuaK5tAXGNz9SIgM947GwEn0x65wr34XvqFUv1VfkTw=;
        b=qSLfOTd/SAoKcnMPFVoqNMW+Ut9MgN243jY0wriD8zzNzbU3PVQRVUklf3NhCf8W/p
         XiSvGlnyDNi1/LKtFoiUixUWmy9MJQJbqSVr+y7rUSGc0J58edFeol8/CETP+PX7loih
         3iTNCyjOsQDeuZmvaGWRuxGcVBkvEVNKB9iw87jTk2TMkeQTKemeoLLHc+OyMSucNlZR
         I7dZ5uacbICvqGvdvrCkeHVjB7PsDAWuwbYh8sB4Bm8k6vPAHSpwxjxS0McsV86rkHq+
         q2sYNO8yHT4NrSRbs/tTSPrhGI6F2ISzsyeZocZArD59GN/FKQpDbx5w3Bwwuy5BJz6W
         o2dw==
X-Forwarded-Encrypted: i=1; AFNElJ8z0cXuwPSm01QrLpTaXYdUHdiRMhvICflsWeM94ituPjyazCbTkdikTSUZ0sfaNDUWwT4vZxY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf4xo/6CtWAKgLeRlVNNu4HbdPvTcljbntQ7cV8K8ZVXZAlAqg
	OBMfUfz33LjKAfBfZPeWVbG9RU1Nt2Zc7pM+nmkMl02QInilD+zyZ/RN
X-Gm-Gg: Acq92OF8RX24muNVQBJgUrbutZRZ0ZG35nW32/Z4vxA8NDg5I+sQZN7bwNONgy0VhF0
	kd9QefUyqILgDRzC74lZo5GVcAgFe/W/EJF5yd1F2QA/cGVpoRILIgB5CB7LK2vWiFhKMOCv2Wc
	75k/mY4coUAuL0xuGS4XcU2qc+dYY+rCmHjDeqBRG/nr47BBxuhXyqUQ1oJ5pKwb5iLciHlXb90
	3xwVHqUaTUkEe5CHe8pLOVG8EMBdmIH3fS2XkaboVplM/FRRU+JEjbpxmlV5gTasHYl5ByAcWFu
	7oyF6DXHa3kB+eh3S6RETXt9LtXkkFPa4V+wJa4oXnfsXqCiOrr2vG+Ufcp6QPXLib4GTL9fI5Z
	X62JW24tDlZBFj8XXqGy1mKfND7Ohm47tolrvnm6BuSYKukNAzXSIpw6/YKiU+Rf2Uy/cC8BwLd
	qIcL/is0G0+k3wBw0YWAqT/Otjlk8+fuvMfHdiSMMSrrC8ikanm8U=
X-Received: by 2002:a05:690c:6b83:b0:7bf:55b:8f97 with SMTP id 00721157ae682-7f6561dc497mr17405317b3.14.1781162001681;
        Thu, 11 Jun 2026 00:13:21 -0700 (PDT)
Received: from localhost.localdomain ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7f693504701sm2551487b3.15.2026.06.11.00.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 00:13:21 -0700 (PDT)
From: menglong8.dong@gmail.com
X-Google-Original-From: dongml2@chinatelecom.cn
To: jasowang@redhat.com
Cc: mst@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	sdf@fomichev.me,
	horms@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	bjorn@kernel.org,
	kerneljasonxing@gmail.com,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net-next 2/3] virtio_net: initialize napi.tx_napi in virtnet_alloc_queues()
Date: Thu, 11 Jun 2026 15:12:41 +0800
Message-ID: <20260611071242.2485058-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611071242.2485058-1-dongml2@chinatelecom.cn>
References: <20260611071242.2485058-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297979-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,linux.alibaba.com,lunn.ch,davemloft.net,google.com,kernel.org,intel.com,fomichev.me,iogearbox.net,gmail.com,vger.kernel.org,lists.linux.dev];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jasowang@redhat.com,m:mst@redhat.com,m:xuanzhuo@linux.alibaba.com,m:eperezma@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:magnus.karlsson@intel.com,m:maciej.fijalkowski@intel.com,m:sdf@fomichev.me,m:horms@kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:bjorn@kernel.org,m:kerneljasonxing@gmail.com,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[menglong8dong@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_NO_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[menglong8dong@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chinatelecom.cn:mid,chinatelecom.cn:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BC6DE66F4F2

From: Menglong Dong <dongml2@chinatelecom.cn>

Ininialize the tx_napi for the rx queue, which will allow us get the tx
napi from the rx napi.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 drivers/net/virtio_net.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 86b5c1ca568c..d72c124c9760 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -6543,6 +6543,7 @@ static int virtnet_alloc_queues(struct virtnet_info *vi)
 					 virtnet_poll_tx,
 					 napi_tx ? napi_weight : 0);
 
+		vi->rq[i].napi.tx_napi = &vi->sq[i].napi;
 		sg_init_table(vi->rq[i].sg, ARRAY_SIZE(vi->rq[i].sg));
 		ewma_pkt_len_init(&vi->rq[i].mrg_avg_pkt_len);
 		sg_init_table(vi->sq[i].sg, ARRAY_SIZE(vi->sq[i].sg));
-- 
2.54.0


