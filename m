Return-Path: <netdev+bounces-303342-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id V+D5LGEXRGqJoQoAu9opvQ
	(envelope-from <netdev+bounces-303342-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 21:22:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 188A86E7868
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 21:22:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=verdict.gg header.s=sig1 header.b=o4jbawqz;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303342-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303342-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D66031307AE
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 19:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC62C3DA7EE;
	Tue, 30 Jun 2026 19:18:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from outbound.ci.icloud.com (ci-2003f-snip4-11.eps.apple.com [57.103.91.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6FE3BFE42
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 19:18:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782847092; cv=none; b=henUBcZ7utwBc4Fzbs0zACyEAch4lAAh85nCcYzLHpUgKFkZ6jvRlcw5+Zsd1enbDrhprt1nVRxL7zg/LPHZdtNLeQg114mQqPb9QFrXFmIwTOlNCuntkf80C44HPwDHew4f62iefBoIg0wf+68HmmRSTxJMZo0fBT+VaOYjNIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782847092; c=relaxed/simple;
	bh=2ZvrRJMYzqoDbdiGguFMLbI69XZeiNViqzhB7xa0r2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o4Twgyr8/KwtaYPODtLNZrsHgC1hZbegqhE2V55y1J27/Ee38e853mo9de0dHyiltmSaZmtCookq6eTp4B8eFXDNgkB8dvTAiVUTa65hRRhgGnKT3ymo80PuPv+Hin2jWcmR1evOer0PsDjGKfB9F2I6hURW0KoZLPzvDts8GWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verdict.gg; spf=pass smtp.mailfrom=verdict.gg; dkim=pass (2048-bit key) header.d=verdict.gg header.i=@verdict.gg header.b=o4jbawqz; arc=none smtp.client-ip=57.103.91.191
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-central-1k-10-percent-2 (Postfix) with ESMTPS id 7238E18015E1;
	Tue, 30 Jun 2026 19:18:04 +0000 (UTC)
X-ICL-RepId: 019f19f7-9753-76f3-aa8a-1f92b1f0c9f8
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQhICkMGWQJeCEABQwVdEhVdRVcIWwJAEVc4RQhFD1sTTVZUChcNVk1PHUEJXghGXl4fEx9UVgNBGRBWAVhWXQVNGlwYWQ8cE1BWWg5bBEcUFxtcABcbRgIEIwJfAEUCXglWATAXD1ZNTx1BCV4IRl5eHxMAXg8PTAtIAVsHXQFACEECWAZbHEgITANfGl0fFFwUWh9WBXIGXApXBFQfHBdeRhMZThtXTVoNQBlYBm0UVhVSBFk=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verdict.gg; s=sig1; t=1782847087; x=1785439087; bh=5/+TtEKPOaUaiXuZdJqivo0zLlpUW0WbZ48waBCkTQM=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=o4jbawqzFgcrpir9cPxcTW+OQpZePRUH7qnIeg35uEr5ONxA36PoiMMOkLdvJnmCuQkNbv0eLxO1Ys/vG4xEx3HDRCvBv1d+DAkruRIY7pYCQfcEFlHE5JW5Wvz707/Cyn49kd2ZEnnqVT1F9CqYLTUDdIXvjVuhX9jDvtl/QH/QXvg0V73X8bDRPJ3jCwB9+AG147Dih8prcMRlnI+v+ZNSkZZbu0tJMpAX8JcEO7zAxBJ5vZhrWgOTFxFeg0NfnZG55RdlEu5nSeEg3akTw2AKrnLl5WFPX+wFKoxL0R7SHWKkTDdlj36NrmRKzS4p+DdAirdKhD9smyBI8p06Rw==
mail-alias-created-date: 1621344842221
Received: from DelNac.mail.msk (unknown [17.57.156.36])
	by p00-icloudmta-asmtp-us-central-1k-10-percent-2 (Postfix) with ESMTPSA id A6CC618015FE;
	Tue, 30 Jun 2026 19:18:01 +0000 (UTC)
From: Vladimir Vdovin <deliran@verdict.gg>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	sdf@fomichev.me,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	Vladimir Vdovin <deliran@verdict.gg>
Subject: [RFC PATCH bpf-next v1 5/7] ice: support the rx_csum XDP metadata hint
Date: Tue, 30 Jun 2026 22:15:08 +0300
Message-ID: <20260630191510.81402-6-deliran@verdict.gg>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260630191510.81402-1-deliran@verdict.gg>
References: <20260630191510.81402-1-deliran@verdict.gg>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDE4NiBTYWx0ZWRfX5RwKdMRcHhuL
 vbX7zW+nswv8XELMa6tzBIn9UNU/ZLKpXawTG4AmpvENBGoPlNC8M8LXxtSKZwRUviBj1y46psn
 lDmImr6gDmvBdPcmevWGRKYxachIX/uWaKATAml7y4bWnux1eIYIz06jGl56P8sOWIH7C42mC4e
 Cym21jDRcTzR9PsmatWUH7R0bEgVsHrtoGQJVF9eGAmjt/79qOBk2TRMFzLdK+oBq90+hZSVlB4
 vSx8xyxMyGtol4Q8Uclx3esGqqXgCvostlWoCM0BU29ppvjmXZHWNb9w/n4SEQ7UxvZPVaM+0ke
 0XdLpmqclVDk1NvuA15
X-Proofpoint-GUID: qGujUuSUz7QpIpPmMbxfzZPCDj93XPP9
X-Proofpoint-ORIG-GUID: qGujUuSUz7QpIpPmMbxfzZPCDj93XPP9
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[verdict.gg:s=sig1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,fomichev.me,gmail.com,verdict.gg];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-303342-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[deliran@verdict.gg,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:sdf@fomichev.me,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:kuba@kernel.org,m:deliran@verdict.gg,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	DMARC_NA(0.00)[verdict.gg];
	DKIM_TRACE(0.00)[verdict.gg:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[deliran@verdict.gg,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,verdict.gg:dkim,verdict.gg:email,verdict.gg:mid,verdict.gg:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 188A86E7868

Implement xmo_rx_csum from the Rx flex descriptor status0 bits
(L3L4P set and no XSUM_L4E), mirroring ice_rx_csum().  Return -ENODATA
when RX checksum offload (NETIF_F_RXCSUM) is disabled, since the status
bits are not meaningful then.

Signed-off-by: Vladimir Vdovin <deliran@verdict.gg>
---
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
index e695a664e53d..d13c5e76bc13 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
@@ -594,8 +594,40 @@ static int ice_xdp_rx_vlan_tag(const struct xdp_md *ctx, __be16 *vlan_proto,
 	return 0;
 }
 
+/**
+ * ice_xdp_rx_csum - RX checksum XDP hint handler
+ * @ctx: XDP buff pointer
+ * @csum_status: destination for the checksum verdict
+ *
+ * Report whether the hardware validated the packet's L4 checksum, mirroring
+ * the verdict ice_rx_csum() uses for CHECKSUM_UNNECESSARY.  Return -ENODATA
+ * when RX checksum offload is disabled, since the status bits are not
+ * meaningful then.
+ */
+static int ice_xdp_rx_csum(const struct xdp_md *ctx,
+			   enum xdp_csum_status *csum_status)
+{
+	const struct libeth_xdp_buff *xdp_ext = (void *)ctx;
+	struct ice_rx_ring *rx_ring;
+	u16 status0;
+
+	rx_ring = libeth_xdp_buff_to_rq(xdp_ext, typeof(*rx_ring), xdp_rxq);
+	if (!(rx_ring->netdev->features & NETIF_F_RXCSUM))
+		return -ENODATA;
+
+	status0 = le16_to_cpu(xdp_ext->desc->wb.status_error0);
+	if ((status0 & BIT(ICE_RX_FLEX_DESC_STATUS0_L3L4P_S)) &&
+	    !(status0 & BIT(ICE_RX_FLEX_DESC_STATUS0_XSUM_L4E_S)))
+		*csum_status = XDP_CSUM_VERIFIED;
+	else
+		*csum_status = XDP_CSUM_NONE;
+
+	return 0;
+}
+
 const struct xdp_metadata_ops ice_xdp_md_ops = {
 	.xmo_rx_timestamp		= ice_xdp_rx_hw_ts,
 	.xmo_rx_hash			= ice_xdp_rx_hash,
 	.xmo_rx_vlan_tag		= ice_xdp_rx_vlan_tag,
+	.xmo_rx_csum			= ice_xdp_rx_csum,
 };
-- 
2.47.0


