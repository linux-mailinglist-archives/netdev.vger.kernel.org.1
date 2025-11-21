Return-Path: <netdev+bounces-240819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C64D5C7AE67
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 17:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0B103A3504
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 16:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CFD2E1EF4;
	Fri, 21 Nov 2025 16:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3LKzp2W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A842EA730
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 16:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763743242; cv=none; b=V5JQB/3wPCldXz9O1XICccV+jAp1W47zVAecql8LdKkUwUMoDAGv3z9S6xoBaGFSnoFD79TmZxztNDxa0wiRxYNDgGXIU+HqVqXK9q/zLDUzVY6hhdyrBhELlWHZEyOhcKxOo446IuFwNs8NP7XbWv3mbEFvRGwz+mMahyzjXck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763743242; c=relaxed/simple;
	bh=JQBiAS8Oiy2ETMS9knkrkYzWr8DFrG5BoGwYUuIo+yI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qy5Msnq0lXDSe+fGfa36TEbkUpgRpAO45pc5qQJBmH2PtLyJrLIG3RU+tPcPb0F6MXR7g98Y92cmahNV+fIGSMZS3u7Je8mH0ooK9lMFX3fyo/KIIGSGGdMFPUvWjPKz0RtjpfHZg3liC14sl3CZLUxrZ+KJpMlke3t1N+FxrBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i3LKzp2W; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7aab7623f42so2283316b3a.2
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 08:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763743240; x=1764348040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=c5lEMrRjtMO794rwMVdWN1JFJlz6NEBb8+rfy3j7KjA=;
        b=i3LKzp2WIFuWrcJ6qInFAV22ckWv+Rtyfbhvb4tSI88fxjeJhRAZbWysJjF1wsabSI
         kc+5JYBlOhAVc97Lh4AP60VEhFuWK6dojLcd5by/Eo4eWFMJREcFuO40gWA+QJm0X0iy
         cf2zHoFWm4U4F0kC3SrMwtChGbIz+AQ57VGPdKLNKfHFE0MVcWj6NX3marHT021zObeG
         WiuvsrJkYD7TpcaIQ8Um1S5zlhcWNyxakV9vhex3jTYACyn+YC+nA6S1PuoN95gwDu8g
         y5iv/SaknH+bpVHQGvU09YtBLo0zQR+xZ4Z64fgIOyU4D9rlv75kTHLLRv4VUUjqP4CL
         1sFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763743240; x=1764348040;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c5lEMrRjtMO794rwMVdWN1JFJlz6NEBb8+rfy3j7KjA=;
        b=VyLsaHdrEhx8SgRUEaVivfjrKU1ZrUikPAYt1GMOAb7sv1UAXq0/g+/NJQVt13JgF9
         eyeaAspSB8fqBg4/PsWFmoKPCcOZ/h5J3s5uRJ27AcLP5UNPXckDMKTsnFxPtMH8nipS
         h8cqvKz/CZN7+QJlggo4qu5yNjsTOzPQ2qnYcdplFNqrtjZy43VMNAr/Cn6QNZGnjq/0
         27YqBhXOalXdgubWW2NUmTm69/buyLrmVzzpuxfHYsaxawyCHpQ/78g8UY505LLme+Ke
         SaBFlxoJ8n4Rn4cqDsQEEIXccKvvYM1hDsPgUqQRduWMRS0JKG8/P7DYBDboseAMKDRS
         GHnA==
X-Gm-Message-State: AOJu0YxaRM3SKM6MxCIOWDtne0Vf9Pntoc5ZEqk64Iqp4KJmDWNLePHZ
	iVQMkwwQ0/1MLarC6CEdgWh8KSVhiH7jo2JU9Esrsk5ACZ65VueCVc6N
X-Gm-Gg: ASbGncsX7jiked5clsIi/6pEm+lPyq/nsETdzqVXMHLTgn3vh3gxLJ+A/RkFHL5YpRB
	Yixystt7hPEqK88/DCDzjqPP3dsNouWsfNE35fbKWHBPGiUfD3/LbOoCXlzQMAO7bbLvrqsX+ET
	ojICNGpXIR8YQt3+KY8YhT2GterlWeEJlFdqBOui1mThyt2e2d9v53V1s3wWab/YfjZIywAELeN
	OYu1ZxuoUHBfFdgQ1dDiqP/FTRz/SYqDTLnOhslVafjDNVbKye/zs+pZv8mLGb+6OPYoTbKs7sI
	vOyj2Yxl6E48gvDqkfMYArXl3kd7VubXmzeY0xR/cX41I6w2lWJDq/DMA+mRNmHozQ27FPfoVSB
	VfXcRbHwHn4XflnNh9pFEfI9bZFPdHsyKiPEuHO9N74DnXHc+Rlgj9vr3J8qms5RfMH/GV++ez1
	LmxX15cs89am7yfwXZ9KvbL3dnKvDsTRLfkXS5fA17ycbi
X-Google-Smtp-Source: AGHT+IGQKFAl8l+xccXuLCwX4hBA6oyNKDolTiMBeSOYJR69Zf+5DTo7yQeflb8czN/jKHFzi2j9Vw==
X-Received: by 2002:a05:6a20:7284:b0:35f:5fc4:d885 with SMTP id adf61e73a8af0-3614eb27707mr3623055637.9.1763743240141;
        Fri, 21 Nov 2025 08:40:40 -0800 (PST)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f023f968sm6631038b3a.38.2025.11.21.08.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 08:40:39 -0800 (PST)
Subject: [net-next PATCH v5 7/9] fbnic: Add handler for reporting link down
 event statistics
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, kernel-team@meta.com, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, pabeni@redhat.com,
 davem@davemloft.net
Date: Fri, 21 Nov 2025 08:40:38 -0800
Message-ID: 
 <176374323824.959489.6915296616773178954.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <176374310349.959489.838154632023183753.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <176374310349.959489.838154632023183753.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Alexander Duyck <alexanderduyck@fb.com>

We were previously not displaying the number of link_down_events tracked by
the device. With this change we should now be able to display the value.
The value itself tracks the calls from the phylink interface to the
mac_link_down call.

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
index 95fac020eb93..693ebdf38705 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -1863,6 +1863,14 @@ fbnic_get_rmon_stats(struct net_device *netdev,
 	*ranges = fbnic_rmon_ranges;
 }
 
+static void fbnic_get_link_ext_stats(struct net_device *netdev,
+				     struct ethtool_link_ext_stats *stats)
+{
+	struct fbnic_net *fbn = netdev_priv(netdev);
+
+	stats->link_down_events = fbn->link_down_events;
+}
+
 static const struct ethtool_ops fbnic_ethtool_ops = {
 	.cap_link_lanes_supported	= true,
 	.supported_coalesce_params	= ETHTOOL_COALESCE_USECS |
@@ -1874,6 +1882,7 @@ static const struct ethtool_ops fbnic_ethtool_ops = {
 	.get_regs_len			= fbnic_get_regs_len,
 	.get_regs			= fbnic_get_regs,
 	.get_link			= ethtool_op_get_link,
+	.get_link_ext_stats		= fbnic_get_link_ext_stats,
 	.get_coalesce			= fbnic_get_coalesce,
 	.set_coalesce			= fbnic_set_coalesce,
 	.get_ringparam			= fbnic_get_ringparam,



