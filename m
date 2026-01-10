Return-Path: <netdev+bounces-248740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B10D0DDC7
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 22:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB2CA30550E6
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 21:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2FB2C0F95;
	Sat, 10 Jan 2026 21:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="HdnkxtTu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13562BEFEB
	for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 21:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768079132; cv=none; b=hRwxekVof7b0+alJBcjPqFde/Q3LQVd9PhZq58FUoWFTZhcyik6TExaaMzcSBn/o1i85w3nrjEGmvKuuZFHcz0dt54Xe+tOX7VY78/3scqI0KvNlAL3CV2Kn3M/OpAfgvtR3l5juVC8HqMpOnT3nmaoUGrfVIORBXXhShvREjeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768079132; c=relaxed/simple;
	bh=9NH2qhopx9N1V2kd7MywYZ1ResFz5o6ZKuUu7RYAzsM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uvNIp6/8eFCAS2tLGdXE4teEKyxKyUiDLaW+ELLR2MuqeHYdOxCgp0sPhuRk91pfxSrhAeofb1gaq/nQIvEdREoI16GwDxbvETDwUJCoKI/ai4xDH4YJZZvCOr0Enm42pmkmYs14BB+dk/3ycd15U5g2FaBkyeAhj2IN822R6a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=HdnkxtTu; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b86ef1e864cso78786266b.1
        for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 13:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1768079128; x=1768683928; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0TnUC/TQ0eRLnTNM/gOpI3DULP5gf/J95rnk3NBvNrg=;
        b=HdnkxtTuucxceJpCwGqAgAfr3lY4lNeMipJM9LHngDwCNYlvVOplyQvPkvNZJOYMP0
         FyP7ObWYpPIVSVFFNzBDJGfN9wRP7kPbvajM8+M+R2LvRh0EIs6XZvalDEpJVTccTbwN
         YExHMtkAkuoOg7ljBbNIYcPFhooCPcJ8cpxIJDSq8T5F0ZbHQItyuL1pQWs8krCSJWpk
         ofd7LZaGkmtbBhXxFxG8t/2i1Zuvvc3+izuXj9l1PLx9Fgm6DX8FDzWXpepH0hmHz8ll
         oAoMnXdlWO1nwlc1SJnLgASRHr5/+yY/OmKjD17jtThvVpsCvk4P4zayaFdSHSI6GWUd
         cqwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768079128; x=1768683928;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0TnUC/TQ0eRLnTNM/gOpI3DULP5gf/J95rnk3NBvNrg=;
        b=MG56Xxm/Iun+ActHc3gk7KhnhM/fDiyd7oaQyeXTrxmfUGFUIA2LlRCLO7yi8TC4+9
         khfljfV0N64sYnVUoJGm4IwJQSDITpvqgjyLguMOf/fjGaoOyzyzzhk+8iZR8f9U/3AS
         W0sljyDcDgq/utVhe8QeIaSDLUGkx+48uxVrrmsBBEBxoA///d6m5Q7PT6rfPheB1Ol+
         9WSD7PnNC++Vl57O9yTDNkC1OlPIq1nqQzKdeq5RTr2rGsC6s04F/m7S4sMocJuHqdE/
         ZfDUw2eswRHX6uePMz9jgNEHa2qI4zP70wfsg/2uH0SJehIx/ry8FQkoEWxv4MMXxrER
         6J9w==
X-Gm-Message-State: AOJu0Yx8j2hQQjaE2ZP9Ogi4qBD9cmNOLVMK+xK7XjkO4K/YCnl+vVTL
	Nk5ct+nvP+jOekB0cKfI5rxJ2zZpSzAGWmunYeel2Bbyp+Hzly4YsJjOq37jw5rjrMo=
X-Gm-Gg: AY/fxX4A1LyC8cBk4gK1KCFDcCAptu1PM/6Rwr3zPS9aAJV4QTFR8wGFMuFnmznE6Va
	eJpz75oERSCfW7YWB7XwUeCRbUdyweHpLzC6S5plsOaJWfcRPSjdgkVXzvEIszwTUmOPFRpY2pQ
	JtfOPvQonBrXr8V8sbhKYN/jhNRYhEGxLroDqNfvxBSR0zKV8Hm9D35+KiVBq/skCtEA25bd8qk
	gayI4Alp0tIr9wXm1zksjEHeOF8xWLpFQeXO8JGGeNPDDClLOeM50/rFl8aoC9eEq0cmA4z1kHQ
	I3K5C7vq7OfC6zqsbjJvYvVErWmdcjxjkNZn+v6J+Q8W+MzCaNcbKEhqA+gxWQ5Lt4hpMLT7lCI
	x+8QyNNZThrcqzfWl9FZkom/Dys3/IW/qpfItHiuWWwadbE7P2PTHLhoR32C21KkNQccNxhhSCN
	vm4OFiICLJY3b+qLkALy9IIzE9MyPcceiWXypmfTwcJI0KDDPLDGicmj6LA/I=
X-Google-Smtp-Source: AGHT+IHFpJUTXLFWUnnv3h2YytegrKQCwISqD8mtMirbPzcSGIv/sObbMsW2/ceFAmzo69tIkpwihQ==
X-Received: by 2002:a17:907:2da6:b0:b72:134a:48c8 with SMTP id a640c23a62f3a-b8445232b14mr1313892266b.14.1768079128172;
        Sat, 10 Jan 2026 13:05:28 -0800 (PST)
Received: from cloudflare.com (79.184.207.118.ipv4.supernova.orange.pl. [79.184.207.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b86f61d2774sm243607866b.41.2026.01.10.13.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 13:05:27 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Sat, 10 Jan 2026 22:05:18 +0100
Subject: [PATCH net-next 04/10] igb: Call skb_metadata_set when skb->data
 points past metadata
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-4-1047878ed1b0@cloudflare.com>
References: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-0-1047878ed1b0@cloudflare.com>
In-Reply-To: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-0-1047878ed1b0@cloudflare.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Michael Chan <michael.chan@broadcom.com>, 
 Pavan Chebbi <pavan.chebbi@broadcom.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, intel-wired-lan@lists.osuosl.org, 
 bpf@vger.kernel.org, kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

Prepare to copy the XDP metadata into an skb extension in skb_metadata_set.

Adjust the driver to pull from skb->data before calling skb_metadata_set.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 drivers/net/ethernet/intel/igb/igb_xsk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_xsk.c b/drivers/net/ethernet/intel/igb/igb_xsk.c
index 30ce5fbb5b77..9202da66e32c 100644
--- a/drivers/net/ethernet/intel/igb/igb_xsk.c
+++ b/drivers/net/ethernet/intel/igb/igb_xsk.c
@@ -284,8 +284,8 @@ static struct sk_buff *igb_construct_skb_zc(struct igb_ring *rx_ring,
 	       ALIGN(totalsize, sizeof(long)));
 
 	if (metasize) {
-		skb_metadata_set(skb, metasize);
 		__skb_pull(skb, metasize);
+		skb_metadata_set(skb, metasize);
 	}
 
 	return skb;

-- 
2.43.0


