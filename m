Return-Path: <netdev+bounces-267579-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WL6yBGlwtGm2oAAAu9opvQ
	(envelope-from <netdev+bounces-267579-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 21:15:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7477D2899FD
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 21:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34F243120F2A
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 20:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975C03D3485;
	Fri, 13 Mar 2026 20:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="defl6/N+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="g/hVCAxr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36863E3161
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 20:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773432911; cv=none; b=AZRisMAZT2ReU+pGWWcVkOSIlpsOa4Sc/xTDhARyKo/oJdAiQe08JrSZ9WiN02cmZXTG37Ku9XZj4baPu2vNtlEsf2VzaLTs73twjaxy2aOjhqgH+ijqYgrke3cUjuQWvEWquU4PXcroinZuXrg62sh8xhgGcnnMIwPXXQhFwG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773432911; c=relaxed/simple;
	bh=VisBDSxI6R7Uo75gwWEuhW5WeLux7PGV4AIuuTKUpsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dwSJ9USNz/lz7/DmE6G9qDfswRd6rzo16z+AiXIHXDtCQF7/KSjjDeEcKeqmOCTB43zEDX6WXzizWk6vqzudzI744BS+P+pJZfBcDuQQ1NavzZkDbrQQhPNS4r5mnK49lYjnkgxtYcfLrJ8hxzHuyEFD1LjilPCq3CQrSHcrgxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=defl6/N+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=g/hVCAxr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773432906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FAH+n+cpde2sNWjKDteggvHBFolK+ke+7OWz1TChBwE=;
	b=defl6/N+v7kbrew92Yh1FBC3Qczv7xYdol24QrL+gl79jAk39DuPMOCn+xqp6ujSt602af
	1X4FeZPHLeWJXynXDgWRHl/JDwlOqWgtarBqA8JZxizR/L9r3nwT43fdQqbOL60nULN5uV
	oKTAQhJ7XMfKzcIDS5k+c7dZRk2ItRk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-LjCXddwuPt2OPHrKFmA0BQ-1; Fri, 13 Mar 2026 16:15:04 -0400
X-MC-Unique: LjCXddwuPt2OPHrKFmA0BQ-1
X-Mimecast-MFC-AGG-ID: LjCXddwuPt2OPHrKFmA0BQ_1773432903
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-439fbfd93e8so1761068f8f.0
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 13:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773432902; x=1774037702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FAH+n+cpde2sNWjKDteggvHBFolK+ke+7OWz1TChBwE=;
        b=g/hVCAxr82VFuWGayDiyIH6pothJxLdR8gyLxxVPEAUMf3TuWT3FEBgqWpkY2Blcvq
         Qcmpl1RpTa4FY5uPs6RBozjliVAktRnAhuYecr2x8q1qmb1O+fKcyNOWTq99XH34HnS1
         dtqfYdHmg8ubbORBeDb/uTUNsCo3w9LdjHBNjlSZxuo8thrJGM5wO97M0Ib8MTO5MdYl
         q1U6DbtCwbAjJbgd70ucH+BrB+ZHoIJMqUOvGW8i3xf5kl+ROE4Offv9o8V92hHDA25t
         Goxg2u/GLBo5NSdYg74r1Wy8M7ttJH5OLabmNw6SPvscPKOr86jV8YVhyTx5qtXiq5zc
         drLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773432902; x=1774037702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FAH+n+cpde2sNWjKDteggvHBFolK+ke+7OWz1TChBwE=;
        b=Uj/YRfo5tdi4h1yDwf0a1QqsqSuSD9QdUdD0Vzol403cz26tIqYH09o2SFtQRN4gF6
         GGGMJet0Uw83alAfRA8z673iZ6x0ksCWhe/kUdwfOs1JGjptOZM9MvE4q0XIcKMpPZ0M
         jBZTP7XqbWjnnA4zgc9QOLGrbaNiL0+IhJDdT+GLunF2eF8MP3POhEpO/jDkTf6QAQG1
         XafMmuKKhHGD1sOexLhkbKrl1xePVmaJMGZIJDVtXBkh5+nMkPQnhtfDWnEg5qqED0Ac
         O9peE3fa/RrAU4kS6d3DeJDXjgO8Yr94yHW5P0vMqaKcmIMLUtNq45Gm0sFMho4kgIW9
         BPZg==
X-Gm-Message-State: AOJu0Yx8izGS+3wWSmzpb5sO8csVg7PsRhX1TXJ8Hhpjl3ytEnhVozVR
	yfqrTG/sCP+IEYcsRiQcLqa/Uf+GNHQwDdydR9MfBGjnnecwb3ZtWA7AWWlRjJVNXW4LkLU72uA
	FsQ5eElVAu+29oYHdAB6iQgq09ZT37xg4JSwcH5wi4eJXhX902ZPipb567xZyh0pxXJGk7Eh/o6
	6t9yRQIqE2ryVxntOuXqMEfwuGck0rRvIrmJyXltWQ1Q==
X-Gm-Gg: ATEYQzwYOPMkiamJaGg2fBRBPTEw3yMlINmB/wroONBDazWmMxyKOQ2P686/SC3maLC
	AeCmge/3vz3ks4LG3ojq3ghHhRvb6rOA5dnGZFMLRhqH02wBkiJsACE1lbzYQ5fAoI8c/LZQ7Ba
	Esa2qdcspvmIOsHQzSQkws5EbWZTC/yNhYSC41GGbQxyJQzKBA6CxP0WWQiZf/eK9BcZr8I5vkY
	G5f9NrA4/fuUKT9HUJgWI/hnO70AVIGD8D/dUCkfo9D7ZcY9c8Xk6Z6Patt4A92smecLDf5IKhE
	sqE2zpGDmIAjR5+joeIbI1E1mS/6vfsC+5v6ijcFL4g7QiDarYXgCAfhfGo2lkUOwIRHHVHtTNV
	w+YPTbbstsKohL99v/FDwrJxkVRMpRbkiBoTGpMUNT7jqCYNQ976pfsmXmKY=
X-Received: by 2002:a05:600c:3b14:b0:485:410c:119b with SMTP id 5b1f17b1804b1-485566d6f93mr76923635e9.13.1773432902398;
        Fri, 13 Mar 2026 13:15:02 -0700 (PDT)
X-Received: by 2002:a05:600c:3b14:b0:485:410c:119b with SMTP id 5b1f17b1804b1-485566d6f93mr76922965e9.13.1773432901900;
        Fri, 13 Mar 2026 13:15:01 -0700 (PDT)
Received: from localhost (net-93-146-155-42.cust.vodafonedsl.it. [93.146.155.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48557a738easm35431515e9.16.2026.03.13.13.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 13:15:01 -0700 (PDT)
From: Paolo Valerio <pvalerio@redhat.com>
To: netdev@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net-next v5 4/8] net: macb: use the current queue number for stats
Date: Fri, 13 Mar 2026 21:14:29 +0100
Message-ID: <20260313201433.2346119-5-pvalerio@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313201433.2346119-1-pvalerio@redhat.com>
References: <20260313201433.2346119-1-pvalerio@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267579-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pvalerio@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7477D2899FD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

gem_get_ethtool_stats calculates the size of the statistics
data to copy always considering maximum number of queues.

The patch makes sure the statistics are copied only for the
active queues as returned in the string set count op.

Signed-off-by: Paolo Valerio <pvalerio@redhat.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 06ad8c8ec036..fbeaa85b4a9c 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -3528,7 +3528,7 @@ static void gem_get_ethtool_stats(struct net_device *dev,
 	spin_lock_irq(&bp->stats_lock);
 	gem_update_stats(bp);
 	memcpy(data, &bp->ethtool_stats, sizeof(u64)
-			* (GEM_STATS_LEN + QUEUE_STATS_LEN * MACB_MAX_QUEUES));
+			* (GEM_STATS_LEN + QUEUE_STATS_LEN * bp->num_queues));
 	spin_unlock_irq(&bp->stats_lock);
 }
 
-- 
2.53.0


