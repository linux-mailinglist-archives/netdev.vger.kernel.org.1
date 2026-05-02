Return-Path: <netdev+bounces-283477-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMYNBsNZ9mn2UAIAu9opvQ
	(envelope-from <netdev+bounces-283477-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 22:08:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A8FC94B3642
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 22:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2E37D300D73C
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 20:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5773A38945D;
	Sat,  2 May 2026 20:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQhrHqc4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C622238BF97
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 20:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777752466; cv=none; b=dj+VNsSvvzC2O8cPV6l8pFxq1OICEUmKWCYv9meeedJ8QrXMXYv0bFlaw5IT1SokP1YK6ORZLUGB+UMAVt5p9AS52ple10PEtoQEZtbIq61qCqwMRb+JC4CdAm4gymon1VeECFlCwkqUb8tUo8E24fwZlXiz6hX5SG0vlcAIL+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777752466; c=relaxed/simple;
	bh=gf40XLR59hzjQDMnEBJgr3TwYidVgoYLeOXjiZN9IKI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RiKIk8+N2lwfL26x1OvVe+P9BL8YiwVgLx1oQizsaSFNgWoA2yZ9IefqArwWXfT1cg58iesBFxAoCNnN+fDG4fmBqLwP44NkQOh+zF6MJbX8MmfRp1xQ4eHeXw2BATLRqjZMloEKXnpf/4+8yNQcoS+uAmID9Dc610NpG7xrwe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VQhrHqc4; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ba7fd666666so354725966b.3
        for <netdev@vger.kernel.org>; Sat, 02 May 2026 13:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777752463; x=1778357263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EXc8LtZ/Yq563oWOKcuS4yN5q506xKFEqEMGtau1Z+M=;
        b=VQhrHqc4SlzQJvUUPssF77QhowXt7fWOY8BdU2rRAIcSl0UaEFWHN9ZuiMUh3EeXH1
         5Af9jN6h9Vv145GiI4epe10hVA6xdiTkKK8ZlwKuDTFH/Cnfx/jvDpqGWDwBrv3cVwce
         Wx/70kAGj4GIhLLcE1YFknVOv8TbudgSaiZHZHOofh+GTsWMeqUshMe6medI42vuANlz
         TOvq7vvBzhtVNoae5dJXcE+zAkCz4XbC+cZ/usbuKXSYq11vEkTOvJViHqy2rInFbFyw
         plsCbDPTIm7B7ltgN6QviCXzpzCtgu7PQSKcuvejiGB1QCPwbfJfxuz+4QBPMVnbxlnc
         93LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777752463; x=1778357263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EXc8LtZ/Yq563oWOKcuS4yN5q506xKFEqEMGtau1Z+M=;
        b=tF6PhnWJovFoHrYLfUIxnsYkzewzlRXHUqrBLldotDWLkfD6o1QPFGhH6DWSR4B7Zd
         2Na9LcXXB9Cj9uFCa35Bg0jfqY8e4es91uqJEaCLWF4OfKd6Fph0Yead3uU7ki71/Yov
         Wo7OmIgYXLns2EOI3jLrGQ4EbOC8r/eXSc37YwfzDUzs/qBm3JKcBQ2b8YYgxM++GMz1
         h6f7BaMKD89HBZePqO2BS8hTf9zj34GRLS7Q+3Qtp24vLloNmG5AwfkB1LBwcWzfSkGx
         lk7KbZDBtBCt1QLHh3uF2MdymLFEkKLwPfFe4aMLfvfFaqH2RBx7Jiyee+1tCuNntjsF
         Z9uw==
X-Forwarded-Encrypted: i=1; AFNElJ/bmEr7K708iCFKtju6XM1OOp0zG47v32O2jUuXHdrOgiBrlLRs2W4YXuCzXYDCMkyY9qOi0zI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhCaJhK8X48u6oYF54tWefUD+3X+S/AcsO60TzJ4X3V1nOqMmg
	67O92HGwYvflQMp2wOHq9GAymHmDSbkJNvMSIDYp3xIgNfniwN+BDkys
X-Gm-Gg: AeBDieu1Z0kXduFiEoKLAR5KFaHuVo3R86AQ0pGiqX+2sHTGfjSWyySX4gT/DXjICgr
	p6U6NJxDQSRp3FV4lsekKtsfkiU148ZC8s/2QzKwlA35JE8BwwxplLCv5Az1s5K25doGLx0sOC/
	jaVHZxMq/lstqTQ/7+Syx41tlBFlFeJnqiqt4Iva/KC6zqL4WnNl74bi1oki55dFME9kogQ0h2C
	bAWyDurBahvlzB394EJM1soPWbgnhYZF4En0ijeCoX0z2OsTKWJ/38jmnWRkGAuTPQ1lXaW1Im3
	K40Rqb/Ly/XLgza3zSvAR0ueckgPn4awLDxbLL+PNQ33k4x/WVVyFnzNCBdK9tk7GtbYOxvgXKJ
	AgMdutbPG9lT62zYwKJp0hni8H0xlvji4VIhbsY+ThIbZi0/TtltNyGoF8sTkW1dXKb5+6vOUL/
	xcPzAe3zRL9yBtmXDyLP647w8NiaT3RJmleKBlmDV102NGQVhxZW4RTOiiOXSE5nlhap3Xu02Ex
	9cHtTliq0t5TTM8YuW0DaGqgeEC
X-Received: by 2002:a17:907:c02:b0:bab:29d9:babf with SMTP id a640c23a62f3a-bbffc47eabcmr176214066b.27.1777752462940;
        Sat, 02 May 2026 13:07:42 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([41.128.91.35])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67b88094aa4sm1902528a12.24.2026.05.02.13.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 13:07:42 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net v5 5/8] xsk: prevent CQ desync when freeing half-built skbs in xsk_build_skb()
Date: Sat,  2 May 2026 23:07:19 +0300
Message-Id: <20260502200722.53960-6-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260502200722.53960-1-kerneljasonxing@gmail.com>
References: <20260502200722.53960-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A8FC94B3642
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-283477-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net,lunn.ch];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,fomichev.me:email]

From: Jason Xing <kernelxing@tencent.com>

Once xsk_skb_init_misc() has been called on an skb, its destructor is
set to xsk_destruct_skb(), which submits the descriptor address(es) to
the completion queue and advances the CQ producer. If such an skb is
subsequently freed via kfree_skb() along an error path - before the
skb has ever been handed to the driver - the destructor still runs and
submits a bogus, half-initialized address to the CQ.

Postpone the init phase when we believe the allocation of first frag is
successfully completed. Before this init, skb can be safely freed by
kfree_skb().

Closes: https://lore.kernel.org/all/20260419045822.843BFC2BCAF@smtp.kernel.org/
Fixes: c30d084960cf ("xsk: avoid overwriting skb fields for multi-buffer traffic")
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index ae59d1c1d2f8..13bacc11fa9d 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -739,8 +739,6 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 			return ERR_PTR(err);
 
 		skb_reserve(skb, hr);
-
-		xsk_skb_init_misc(skb, xs, desc->addr);
 		if (desc->options & XDP_TX_METADATA) {
 			err = xsk_skb_metadata(skb, buffer, desc, pool, hr);
 			if (unlikely(err))
@@ -837,7 +835,6 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 			if (unlikely(err))
 				goto free_err;
 
-			xsk_skb_init_misc(skb, xs, desc->addr);
 			if (desc->options & XDP_TX_METADATA) {
 				err = xsk_skb_metadata(skb, buffer, desc,
 						       xs->pool, hr);
@@ -887,6 +884,8 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 		}
 	}
 
+	if (!xs->skb)
+		xsk_skb_init_misc(skb, xs, desc->addr);
 	xsk_inc_num_desc(skb);
 
 	return skb;
-- 
2.41.3


