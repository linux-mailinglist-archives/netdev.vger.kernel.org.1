Return-Path: <netdev+bounces-252884-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCtuEnSic2lqxgAAu9opvQ
	(envelope-from <netdev+bounces-252884-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 17:31:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B6178880
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 17:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D08193038615
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 16:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ECC4328243;
	Fri, 23 Jan 2026 16:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/AliVKM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F889315783
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 16:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769185373; cv=none; b=n0Gy08Rxh1zoHoFfaH/N3uu4JB/hYBA0MfSyMzZCau4RDNL1wJCaWt4agx0rX/tbpG59V0QSH/jqp0uf/y2MLjq/Gb442uIL7LfBDom+7DayIk7gt1GfjAKSk21BE++pnXrltQ/jbbiFBNXKwJkbPTTednXcHcrRrv2BVgul+as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769185373; c=relaxed/simple;
	bh=VrAPEl39e9anIsEe4zCu0gxxfqGtmKVF9Grnf8Bfcdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CaH9/KM5UW1svhQLdEMe1coTDilpFJZq5gSqBfjKde7ogm0jy1RRpo/gteGDGKutji125OmAxSk1Ly8TbicgKNWJ69IK+quLvAxgzB7rpZvWXNwmABjVUU4E+P4L0jFPbVGcNiYgnUj+s30SebrT/YY0m3KPXqVsOQguHV0IaGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/AliVKM; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c5e051a47ddso1575357a12.1
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 08:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769185371; x=1769790171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7TW7msSZ+2wc4dxwFxb0UJCP9LbS8qQBJKa9dBUSTc=;
        b=T/AliVKMImlRWcVBrgVMRaF55p4gs82eul1yEUE21APtiXJTAFsvCt2DtDtDaZnuQI
         F33Oz5/zUrFS4CdYXS5r8zwK0SdDNu7c1U2qQyZ+GtwwLoUm3W6sY1Sve6w1A9XHvFrX
         pysIUjfHhoetNdCmzsvRRr1FJ7z7B9S8HnFz1MlugzH4Rvj2hiaX9uP7NPD3tvk+Vm+a
         /w19kH4ysDmH/qm2COuLK+0+R0uV5XV68y5FHU5Cmrv5WajjquJFb4ULRNDX3y7O3710
         1Zp8fqSRtvMkjFtM1anoZ+4DY/QumFqLbXN42yO7OuFcNwUyDJkrXhlkbuCQ+Ds2ipVd
         0RCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769185371; x=1769790171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y7TW7msSZ+2wc4dxwFxb0UJCP9LbS8qQBJKa9dBUSTc=;
        b=fp7CYZ30m1IFs8xSzdsJnlK0Gxyv9LXJADnG9HFnlJa5kkEQg1M2MS8QvjM1t6/e7m
         zspCnVlWex7DBUpkusW9X+2uwUM/9bVxaUmEhJtXDGD/TwevPQlUjv1VtCPK1VM4+6He
         lRqtYsLiziCTkVp8gtG16/7zQnYIW4Y26HUEtZ9rIBIUtixbFofyIE9flRb5jxR86j+8
         hr2TMkiA/R+yVrvtlsQ9kZBCmlJJv1OCUL2YruUm8BZ15xLqGMY3bJ27CZmjnovtQrlx
         uFXWzywz1SixtIrIMT9p3pDTvpnTTn+R2AN7dL31PLKHxd1RdaUwm5SRg29dg+LD29PL
         ybPw==
X-Gm-Message-State: AOJu0Yx0/QM8dlDthbfj1CwngP1ArvGi/po6mrbuZsE76TvDYrrdjfk2
	kfQ0KDXeWVEjmHftHgP3rd/JD/pC6x9YEVC2KSmxN80QD4pivkGJCm/L6QtYjQ==
X-Gm-Gg: AZuq6aIMIk/aOCcPanoDe7NGMbjzoKwtA+nw82PzxcpWdkj1dCa6ZhBYqxI6EYsDNya
	NEaQdB0kTtSWcUDhsi13kBaVQfv/w0NMLCXWNao5+5lfU3U98u/B2RLqj/CezoANuxUUhkLW1im
	WBk56PqyKGeqAnv5XcIviQalFQ5+YG2hHjWJabTvAjuWqjcBeEAmNwYX1ycYqx5USJUIRAalw0i
	dq+FyEBOCnkfcpGjR4tB64DcjlZ3y/bS1STAopATTASZQPcN082OmlBghFrsUX5Ovo7CS/4Obcz
	8RH3AloPsvG6VU/g3euB21EbFv9AmxaBIpOVROeAKrHEV4KhyUu85Nr/a2bFkZssU8L0Dnh/F47
	ziAcVlgmEQjvjU/QFpLddTTZq7Vvehu4XcmxjO2zxj5Q9Lyn6e5bKHrsFFggcWAzHZ53H5m8rVP
	s4CrudwyBLRuDutUUntiIK068X3VdPJ4lOd7hHTLnEOVO9hlIErHg0xA==
X-Received: by 2002:a17:90b:57e3:b0:352:c410:35ca with SMTP id 98e67ed59e1d1-3536700c58dmr3245949a91.7.1769185371223;
        Fri, 23 Jan 2026 08:22:51 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2001:19f0:8001:1644:5400:5ff:fe3e:12b1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3536dc50882sm2496967a91.16.2026.01.23.08.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 08:22:50 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Breno Leitao <leitao@debian.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Shigeru Yoshida <syoshida@redhat.com>,
	Carolina Jubran <cjubran@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 7/7] vxlan: vnifilter: fix memcpy with u64_stats
Date: Sat, 24 Jan 2026 00:21:39 +0800
Message-ID: <20260123162159.2877941-8-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260123162159.2877941-1-mmyangfl@gmail.com>
References: <20260123162159.2877941-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,nvidia.com,blackwall.org,debian.org,fomichev.me,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-252884-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E0B6178880
X-Rspamd-Action: no action

On 64bit arches, struct u64_stats_sync is empty and provides no help
against load/store tearing. memcpy() should not be considered tear-free.
Use u64_stats_reads() instead.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/vxlan/vxlan_vnifilter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
index adc89e651e27..afd5df154376 100644
--- a/drivers/net/vxlan/vxlan_vnifilter.c
+++ b/drivers/net/vxlan/vxlan_vnifilter.c
@@ -126,7 +126,7 @@ static void vxlan_vnifilter_stats_get(const struct vxlan_vni_node *vninode,
 		pstats = per_cpu_ptr(vninode->stats, i);
 		do {
 			start = u64_stats_fetch_begin(&pstats->syncp);
-			memcpy(&temp, &pstats->stats, sizeof(temp));
+			u64_stats_reads(&temp, &pstats->stats, sizeof(temp));
 		} while (u64_stats_fetch_retry(&pstats->syncp, start));
 
 		dest->rx_packets += temp.rx_packets;
-- 
2.51.0


