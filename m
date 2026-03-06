Return-Path: <netdev+bounces-264952-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SE/5D6Veq2mmcQEAu9opvQ
	(envelope-from <netdev+bounces-264952-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 00:09:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF45B228855
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 00:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDE5030DE18B
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 23:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E36368284;
	Fri,  6 Mar 2026 23:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="aBpaE88+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D8136164E
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 23:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772838402; cv=none; b=hMpW/tEkU/I0qAsbD/HNRQkxPE9JZAd8TH72pKvgy6LYnqJbeZ8iGqbxJ3cp/kk4ONPUiVdeVLSJSccsu5b++odXomj2LpPMMLf/rqidIavq6qrtcNQaML6ZthK7mVSFMtROv/0H0XN/jSGn3nN1XGn8kqEv9YW2di6n2KTbkM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772838402; c=relaxed/simple;
	bh=G1m2bChyGfFCLRh6E4i97fS7WkOhKhPKA/ZRk/gLdPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ecE6SSU66Fze8iXnHr2NqWLZE90SfewcDKPngB1v5Tue0d4YjUCCneITQRSQukbQS1fy7iWO9u2MXbMiAcH3VwJ/dZ6dG/rvMkpEBQ/rrKx+u/Bh4BJrAJw4g+RUgzi0+FbK6V7Sj0dfJoW9DrEH2y6en8iOPyCCAKdOydhZiZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=aBpaE88+; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-463a0e14b4cso4054570b6e.1
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 15:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1772838395; x=1773443195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=csumzbWHZvx8PA3oyWoX+6soqsMyY5CickRdRinv65Y=;
        b=aBpaE88+ILfrcp/pXPRpS46zO4rEi0NIYGOfEAgPdVHZovFOiOvUgk+qTFWYhqsQHp
         cjmU34OUFXNHZDC9ktFhq5lXM9Ziy+gUf8HxO/G1WJ2ghkOnhhMvO1Ov2H69scUQHflY
         0osQfEMxBgumDqB/1oGgXmqmjC5ZItyX13O72i0ZfjgB2uQsZHcnm9fAynp6iYcfkLwz
         sz9qinXOKoDy+jp4n23EMLrx0B6uJW9NEIHwQVesp7o3jPo0afHLjRuMWuA6/ayg38NM
         PcOxfjKPIOqiCXCe85ghO/NkK2knqjizadNmM9ot5VTLFwWlvsKsQElWnwD/wDlg9+th
         Bzug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772838395; x=1773443195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=csumzbWHZvx8PA3oyWoX+6soqsMyY5CickRdRinv65Y=;
        b=p2p65xV6/zmtx750QUpEECwaFVPAh6vb1H8BjYJtMz4nuvT2MhLqN/gkO4o2PTBf+t
         evxDKp6C4p8+rBsXWTv970UF3/gCuN9m2Ra3qRk6mUYQ+SvMQ95Zjs9qktiWEFKh509l
         paEsnil6Ucevo3sWeWqTX0MFCatgoLkTmNFv0kSrMOHvffQnLmfkpv0k3I1sqTgDg1ZX
         JPavlp3nNRXe359L5NoZ4jB/AxZ2GT9HgQ8PuP6pnabkwiNx7nM/0Ycmdg+FMCDvrtNO
         Gl/ELlCpnMBsnCsctyoR+TsuoJWpVfgnLm14r4M+VYGIza6vpnAEMHc+YS8v//R300TU
         cihA==
X-Forwarded-Encrypted: i=1; AJvYcCXSlzSTZo/pxMYUkykruGwsWdUaxzKBsRXNQYPn0F8AA03BXd+S476FK0JSPdFTWQJqZl/HQSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXcIYKVR8MJdlWEb3pfwUNmoY4fkw/CfH9FBlArCXWs5Vk54hT
	9Smatiwi9rNoKFfmH+fO7WE2ctlcqqArkzmdUQh8VOsJM5k5zIQx9vnh9669bWhQU6g=
X-Gm-Gg: ATEYQzw9OVasUqA6UGSnT3b92ShSqk8EMBA2Pmc+iMAk0UkPzcSu6zF8e8BMdlrElnA
	WaV3fv/2zJZTEQyCqXXsRMJPogXUZSwyX/NoEwfFOurCvBqh0WHMl18d8X/hpzwh9XMQLK0ewPv
	hfMnbyAnVIDdkiDMorNX4TjYb0yGnvNxbZHN3o10LiY/zSPln3oXvTcxz8ALTZf5b5u7QB9i5YJ
	kUJylhna92YWkaZPEyQWcK7Pl/gN2Y389Pw5DS+G6lRAzWYvIthqjfKEp8kU1OdSsME8dKH1kQM
	unvVYuYPWEYNsPgmsM2veRFh2KgwDmMLbscaOCfNvWtM+6fhJ4+W6t3WVO5wvplnhleh2xcxfKK
	w1kR9w6K7+zlNpsLVuRXTZ3I0WJtUQ/NjeDIDMOc7873VByFRHk360D753G2CECPtfLtBNh30tL
	5SkTwvmzZzdCtO/bwB4c8=
X-Received: by 2002:a05:6808:3098:b0:45c:7c9e:854f with SMTP id 5614622812f47-466dcb9c0d7mr2209128b6e.58.1772838394942;
        Fri, 06 Mar 2026 15:06:34 -0800 (PST)
Received: from 20HS2G4.. ([2a09:bac1:76c0:540::3ce:23])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-466dfac17b3sm1532769b6e.14.2026.03.06.15.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 15:06:34 -0800 (PST)
From: Chris J Arges <carges@cloudflare.com>
To: michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	joe@dama.to,
	kuba@kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: kernel-team@cloudflare.com,
	Chris J Arges <carges@cloudflare.com>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 3/5] bnxt_en: Implement XDP RSS hash metadata extraction for V3_CMP
Date: Fri,  6 Mar 2026 17:00:18 -0600
Message-ID: <20260306230600.1628196-4-carges@cloudflare.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306230600.1628196-1-carges@cloudflare.com>
References: <20260306230600.1628196-1-carges@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DF45B228855
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264952-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[broadcom.com,dama.to,kernel.org,iogearbox.net,davemloft.net,gmail.com,fomichev.me,lunn.ch,google.com,redhat.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carges@cloudflare.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.996];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,cloudflare.com:dkim,cloudflare.com:email,cloudflare.com:mid]
X-Rspamd-Action: no action

This adds another conditional for if cmp_type is CMP_TYPE_RX_L2_V3_CMP for
drivers that support this completion format.

It uses a similar approach as found in other parts of the driver.

Signed-off-by: Chris J Arges <carges@cloudflare.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index 1f920464b426..25ecef1eb96e 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -514,6 +514,26 @@ int bnxt_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash,
 		default:
 			break;
 		}
+	} else if (xdp->cmp_type == CMP_TYPE_RX_L2_V3_CMP) {
+		struct bnxt *bp = netdev_priv(xdp->xdp.rxq->dev);
+		u8 ext_op;
+
+		if (rxcmp1->rx_cmp_flags2 & cpu_to_le32(RX_CMP_FLAGS2_IP_TYPE))
+			hash_type |= XDP_RSS_TYPE_L3_IPV6;
+		else
+			hash_type |= XDP_RSS_TYPE_L3_IPV4;
+
+		ext_op = RX_CMP_V3_HASH_TYPE(bp, rxcmp);
+		switch (ext_op) {
+		case EXT_OP_INNER_4:
+		case EXT_OP_OUTER_4:
+		case EXT_OP_INNFL_3:
+		case EXT_OP_OUTFL_3:
+			hash_type |= XDP_RSS_L4;
+			break;
+		default:
+			break;
+		}
 	}
 
 	*rss_type = hash_type;
-- 
2.43.0


