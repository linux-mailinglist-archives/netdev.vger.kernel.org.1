Return-Path: <netdev+bounces-300877-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ikZ6B57IN2pcTQcAu9opvQ
	(envelope-from <netdev+bounces-300877-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 13:18:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5B46AAA48
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 13:18:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=bZV7HPke;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300877-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-300877-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E4DC63009B13
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 11:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E41235BE2;
	Sun, 21 Jun 2026 11:18:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E414F5E0
	for <netdev@vger.kernel.org>; Sun, 21 Jun 2026 11:18:47 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782040729; cv=pass; b=njxya4DMjBParP3J7isocP9yJFTY/jotY0B9Kxm+yvAEr7QpF1UdHiCgp2FkkQTpojl+E+nIhnhrxVEDxwcKLbgqm1CvS38OyRUZ2pqRdEjk1nYgOC/3uGAFBuBQUAnx+Q9gK53TTarrtgAojXFDeLQ676YC7vmGIc/Z4t0e5GU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782040729; c=relaxed/simple;
	bh=QRt047TZEZugYid+jMtwjhy/P8FA9MOLdMujFCfeZwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 Cc:Content-Type; b=pJ/NBcckjtw8zeWq/Pn0Wd5kjjHU743HFL90xChwh32KmL3ggHG3QfgeflOFLu0YtZDqWUJeWUMmmsCjpRlOao6+3We243mmRujg87RqoRZO2ihmHAGB7MSqKVG6XuLJFZKCyYSiVl7VCJYQsIf0f3vr4Ny/4EM8mRGkObqB8eM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZV7HPke; arc=pass smtp.client-ip=209.85.160.182
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51758478240so18643001cf.2
        for <netdev@vger.kernel.org>; Sun, 21 Jun 2026 04:18:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782040727; cv=none;
        d=google.com; s=arc-20240605;
        b=FHH2Zbo/KrcKG8qy08p/FGJQxXqU5eiTv/jd4dJpe3O0k44Ws6shW/Wfm6rLxcv/pd
         x6liimgiYiV4bXBcN6moJoA1e9BsyeJv7b0vlgYib+SxoGGqhte0ttOP+xjOVuDX+OS3
         qLrAv+sGBG1RAB6REE0aZq2OfAryujnROxxXqCvmWK8g7El13Liu58M/emyis9g6UQpp
         sl+bpA+t3fCzvSApyof5R32bXXyhSmuaMsWVtSEgMKdbm1eTHemJ0Km1mTELO5uqnIg5
         x3EnGzcwwDHs81v4/IRXEhDr1QSHrEMGE1FyaUaYbT60SwPQlAWrrRzSVJnVQ3MggNoD
         t89Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=QRt047TZEZugYid+jMtwjhy/P8FA9MOLdMujFCfeZwk=;
        fh=FIZuj2SizVDCi9T05UUPdnustzho2tC0IQBUYkkX/XI=;
        b=OA7vGP8f0nUyUn/UViI6/8/vhIJ3wqPCGu1BgreCFAATyH1O2LOosAueEdcbYwWgB4
         AfVle2UEcqJz9r1lUOtt1IxTBVObyuBrTrxEMbAVj2jf4MjdQMTbzEzkULVUZ2EKpHZG
         /one9V/dyLcDvZ3JCZto3KRgdrQwm42XT1zISfGmZY2aUvtTu+pMSlTpXDkl6qMlid2k
         CpdUch/Y0kcC+qTZnHcYQfOJyqQdBxQJn3C3QxfTiUCiKbWj1VA0Agd6ENSZl4Tfu9rr
         PaztgOyUsSM6GtJErDLxNwlPvRKG3BvKNaoJ0r2a+qrgEqSyTlhcZk4CEIlk9pMYsyyO
         W6Ig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782040727; x=1782645527; darn=vger.kernel.org;
        h=cc:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QRt047TZEZugYid+jMtwjhy/P8FA9MOLdMujFCfeZwk=;
        b=bZV7HPkeLNMrPZH2x/JUyvlDz/Ax/CZTR1Y9MgFmWg7Kr67iQAra+qTC5amMNrCOTL
         dlk230GUu2Hl0FaumiQg4opRtqaBhZfEPl6+c72jIP0pMbqE+ZoIPXf4S3dMhOU0ffUY
         TB6rs9FCZl7di29amPP56ORcvhVtpnPnkT7etIYg3m6CgaC7fkbrNBSh4Fd4RA9KV09L
         6K3HALO0fhYOOj37ZJn8/lsBN+FYu+/U3YakWS+fFPU9H8pMJH/EOVZyjR+ZULVFZZWZ
         Hssj96Pv/W/0GGS1KR7XIwEaCnCbH4DFoOvx7QPuNL4FxKJsMfCJEupczILgLPFH9n0j
         987A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782040727; x=1782645527;
        h=cc:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QRt047TZEZugYid+jMtwjhy/P8FA9MOLdMujFCfeZwk=;
        b=j4vQLqFQZ4TceEIcq3WWmK0zwvFV5VvmT4WKMAmq75Gv2XPE26bzsRxi0/+li32RV5
         5Fzas8dTXE5CLrbu5vnKEZxEIHnCJhMjnYCjz1TcrLte9zToXpKrD99bAc4pEcaSnoAj
         lJ7CFx5l1LR9GEWoJhPyPothL2RqYs6ga7Yjn5ku5Hi8uH6lNMTlcl69ZZCESr43o6rJ
         rpMkHtiyqfPiIDoTNSpiEWR5ZE9v3CIndIZzcSLJRzipEoTbBxH150stzr6UZM4p3A/B
         J12mSfC27p9z7nvX+Fz7xiDsJ9AeaC6Ypx1X+nBNmB/eMXIGAF5wnrJEkcKSKIaP9ndv
         X9ag==
X-Gm-Message-State: AOJu0YxOKfduciKfX/X2ArOwghCy8uz/KUldFLASuGa6SoxQWaJYfidD
	T12be1emI4cZChbCZnxSTYgpWaEB6chTxm3CawyBgnBLI8UmOMaVunyioqAU2B1jhRqmnZWhByg
	itDNLbUsPfDqiaUx9q2KAHGFnNlq08qsYaO78
X-Gm-Gg: AfdE7cnUXhwINxqQUmP7kINnf7ySH6DX4Pv3hVBLJ0NyaN9X4xiRxNYcd8Wn+X2X6uU
	2FNs/s1I0Zt6xpEj7on/0befxrGW/UjQ2u9IdxCgbsvjUfaD6NYyGIdr8wWHLMAiCEhrS0pW8mM
	BTdLWvnQjITzKPgBw54vT90vTIZ14M8NR7PVXxDd1hZLzAMFyCFtAEfca7a3hdZI6xeUMGBkuBh
	vhERvlXZpT9Iua4/0L3UKlokFqwBBVip/yRICUhq2FNCvMoaxvn+P7orZHP+ok28U2Oiqw/XHhv
	wVU1euA=
X-Received: by 2002:a05:622a:418f:b0:517:79cd:1a41 with SMTP id
 d75a77b69052e-519e4dc7bdcmr162099751cf.55.1782040726608; Sun, 21 Jun 2026
 04:18:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1782040471-27241-mlmmj-64bd9d5a@vger.kernel.org>
In-Reply-To: <1782040471-27241-mlmmj-64bd9d5a@vger.kernel.org>
From: perceival percy <perceivalpercy@gmail.com>
Date: Sun, 21 Jun 2026 13:18:36 +0200
X-Gm-Features: AVVi8CfWF5mxA-8Vqc2GhfBtHr7R8All3NPfGAVYLoFs7_jGHB4f_mEa-u2KK2w
Message-ID: <CAKXN085BxgRbS79d9JFaWZNwbt-Dxv2fdt-zBh8GjHNX3DdU1g@mail.gmail.com>
Subject: Fwd: HTML message rejected: qcom_ppe: direct (non-DSA) MAC port -
 host-bound RX dropped at EDMA (src_info_type != PORTID)?
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	MISSING_TO(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	SUBJECT_ENDS_QUESTION(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[perceivalpercy@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-300877-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[perceivalpercy@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6B5B46AAA48

Hi Luo Jie, netdev,

I'm porting the GL.iNet GL-BE9300 (IPQ5332) to mainline OpenWrt and have run
into what looks like a gap in qcom_ppe for a direct (non-DSA) MAC port. The
question is at the bottom; I'm happy to provide the full DT, register dumps, or
test patches.

Setup
-----
SoC: IPQ5332, kernel 6.12, drivers/net/ethernet/qualcomm/ppe. Two ports:

- port@1: 10G SerDes, DSA conduit to an external RTL8372N switch (eth0). RX
works fine; the DSA tagger demuxes the switch ports.
- port@2: 2.5G, direct on-board RTL8221B PHY (phy-mode = "2500base-x"), used as
a standalone L3 "WAN" (eth1, no bridge, no DSA). RX is broken.

Symptom (port@2)
----------------
Link comes up at 2.5G/full. The MAC receives - the PPE ingress counters
advance:

PORT_RX_CNT ... 4/1(port=0002)
VPORT_RX_CNT ... 4/0(port=0002)

...but eth1 rx_packets stays 0, and the EDMA RX-ring error stat shows the drop:

/sys/kernel/debug/ppe/edma/stats/rx_ring_stats:
rxdesc[15]:src_port_inval_type = 1

So the frame reaches the EDMA RX descriptor ring, but in edma_rx_get_src_dev()
the source is not tagged as PORTID:

if ((src_info & EDMA_RXDESC_SRCINFO_TYPE_MASK) ==
EDMA_RXDESC_SRCINFO_TYPE_PORTID) {
src_port_num = src_info & EDMA_RXDESC_PORTNUM_BITS;
...
} else {
... ++rxdesc_stats->src_port_inval_type; /* port@2: type == 0 */
return NULL; /* dropped */
}

so the netdev lookup never runs.

What I have checked
-------------------
- netdev_arr[port_id - 1] is populated for port@2 (edma_port_setup), so the
PORTID -> netdev mapping would resolve if the type were PORTID.
- port@2's L2 forwarding is the fallback path: PPE_L2_VP_PORT_TBL with
INVALID_VSI_FWD_EN = 1, DST_INFO = 0 (CPU port0) - set for every physical
port in ppe_config.c. That controls the destination; the RX descriptor
src_info type is still 0.
- Bridging eth1 (to give it a VSI) does not change it.
- port@1 (the DSA conduit) gets SRCINFO_TYPE_PORTID and is delivered correctly,
so the tagging clearly happens for that port's path.

Question
--------
What configures a port so the PPE tags its host-bound frames with
SRCINFO_TYPE_PORTID + src_port? Is there a per-port setup (an EG service code,
a source-port profile, a physical-vs-virtual-port distinction) that the
DSA-conduit path establishes but a standalone direct MAC port does not?

And more generally: is "deliver a direct MAC port's own ingress to the host
CPU" (a plain WAN/L3 port - no DSA, no bridge offload) an intended/supported
configuration today, or does the EDMA RX path assume all host-bound traffic
arrives via the DSA conduit or an offloaded bridge VSI?

Thanks,
Kamil Bienkiewicz (perceival on the OpenWrt forum)

