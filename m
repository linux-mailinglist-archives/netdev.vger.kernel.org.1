Return-Path: <netdev+bounces-299769-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id L96CA139MGqAaAUAu9opvQ
	(envelope-from <netdev+bounces-299769-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 09:38:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6378468CE33
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 09:38:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=VwV073eR;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299769-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299769-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8F5D3028370
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 07:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26855373BF4;
	Tue, 16 Jun 2026 07:34:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48E130D3FA
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 07:34:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781595298; cv=none; b=lGfvGdePbA/dvaBe/sTwb2JOAK39kUtSpKH2ZOVQWySUjSd5cwgZb6RtKkq/9+o6iUkAdlpZw07ZeIcdUd3sOkJX5So6MrwdkPBxYMBGcaqh3kdEzGUTOgSIey4WtNT62GNgHV2qFtyiVXzXKA5XN5ITefZuumD/48socnnrBlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781595298; c=relaxed/simple;
	bh=Rog+vecIJCOoaRBhO4RUtb8aiERuWh4RE6w1j+WTzCo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=pqUMPeC6ggmnT7FOWH7DMiB2luDeM/ePMONj4OCwDNK6yK4ZQQrfD2YzFJuLs4KuPLIx02oki8TjWIbox16UyCJSj9w+8X1zJTHrM4jp9uJyFvOHTzHGPMOnm30mrECTZKkM59MLZATmDq5YrDumktCir9IOQhZ1gY0MFwNHdTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VwV073eR; arc=none smtp.client-ip=209.85.214.172
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2c0c1e0b0faso26000135ad.0
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 00:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781595296; x=1782200096; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=je9fX3o0/RPXSuKvoC8V4ThqHHI+ZMgmBm1tthpZ5bQ=;
        b=VwV073eR7f+ulqH91jtVi3JUTQjw3PjCx4qcWZ6JpEibCsRnqFRLHrvSFMiZPSSdR3
         OV2vWB+w2kWoBRowkss2TFgBwN4Ms73enrZ0f0W17Bj0JNRTL/XgbaIipbKLJqr6+0bg
         KJ4Uyt/7AgR8gz+QU/pZrce1iaQT7ZIfeajV+xKG7EsfrwBaV/g5z01QqClku57BRKre
         wmTRDNDn1rBdB4vep/ntoNiG5Ti29RUu6KYf/c9537J5TFuQ0zOJC5Ligr4NIIbshbdy
         55HKN1PnG/ekz8Ltgs4CfbuAoYBFw5v95HqlvmG6taIaaLmz9Sj15GE4CNVGF0kbD1a9
         lu1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781595296; x=1782200096;
        h=mime-version:content-transfer-encoding:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=je9fX3o0/RPXSuKvoC8V4ThqHHI+ZMgmBm1tthpZ5bQ=;
        b=fzYmHM3b4tK4+IpjgDLbXPYC3GkMa9XoDAigi5TGchAJXACKg0p+LEwzQopVCQmIXZ
         BM/wtdpRbON31V0DGYKqVqYM5BsKtnFB9Gh+VPZPs3/siPiZ0vTMa2tr3uem/J0Lc5Kv
         aXCQpJjNikEOMCBCP7UpcDXYtSOaJQW5AHbGmvyvaI/wQOBZjAe3qbQuuY0Sv4d5LHF/
         75/3LjOMF9R3oxuob5Vdbkn1+Gn/CHr0riDc6I/SuiVgtWbeo5GcV6DfOwDj8qo0ntw2
         luyyxeA0/4Bj2AcVbXKWQ3a2zFZBvhLshP2MAfquqwbK1imSdOVCV12/Lk+OjlVYaqj2
         uGZA==
X-Forwarded-Encrypted: i=1; AFNElJ+DfE//gVuX3JoBL6DdFgvNR1rVsib3u8CoL95+ncb62J5FTHM2e5fMoO1EkrlciNGkgbasiXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzavarfF0c2n+Vd4/WJdCYM+R4ZzzAXZYgYtw8SnuJTX2m80vyg
	Zl+h9rIR6SwC2bSy5WI14tDngz2XGB9aZSift+8srGYwN63jDIXc32zm
X-Gm-Gg: Acq92OFHg4yVPS5Dj7YHq56gxR8vzpjWPseilCKRCvEDHfqhPq24528lBw0Z0vXo5x+
	hu5YaMqdl0Q4V325b8izFvFoUWo1ldcVoVUp5S01z+Wv1g5rc5PLfy/bM4z4RZYrbdmcSp08JPn
	GNDYaxgXe51V24SgXnQVy3BbHmYqwPVozwI8IsvGRDMu8kokYoqz/bpkSTpqffHzh3NKzY16Fgb
	Fd6i68YEjilmRCFEnC+rRjbHn7MnhNTEtnwEsImrbSIH7LkeBYd4ot0KJAPplTSFPMPdEPUzlml
	SLsPYu79Bg4Gkfsi4vxyRMca7I4ChSd/ehs0XJP8v46V5ruoqQs6wxNP4u674uL5WrfTXOzPvFf
	8szgptZjLHkhLOlnvbkq4a0l4vM6zMITr0EuRKo0jdGGNVrt6Hy0qQ/SrY/I4cMYPEOTThcVIMo
	sFbX1l0vxD4kdaXAQPPdrgSoU1Ztdebi5Er1BuSzYS/W3y7wmE
X-Received: by 2002:a17:903:3887:b0:2b2:4d36:7ba with SMTP id d9443c01a7336-2c40e0350d2mr192684905ad.0.1781595296273;
        Tue, 16 Jun 2026 00:34:56 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c6a3ee1052sm4186635ad.48.2026.06.16.00.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 00:34:55 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To:
 Mika Westerberg <westeri@kernel.org>, Yehezkel Bernat <YehezkelShB@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: net: thunderbolt: tbnet_poll() can overflow skb_shinfo()->frags[]
Date: Tue, 16 Jun 2026 15:34:52 +0800
Message-ID: <178159529251.2170936.1136950368069628844@maoyixie.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299769-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	FORGED_SENDER(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:westeri@kernel.org,m:YehezkelShB@gmail.com,m:andrew+netdev@lunn.ch,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6378468CE33

Hi all,

After the recent skb frags[] overflow fixes (t7xx, cdc-phonet, f_phonet), I
went looking for the same pattern. I think tbnet_poll() in
drivers/net/thunderbolt/main.c has it too. I would appreciate it if you could
take a look.

tbnet_poll() reassembles a ThunderboltIP packet that spans several frames into
one skb. It adds one rx fragment per frame.

	skb =3D net->skb;
	if (!skb) {
		skb =3D build_skb(...);
		...
		net->skb =3D skb;
	} else {
		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
				page, hdr_size, frame_size,
				TBNET_RX_PAGE_SIZE - hdr_size);
	}

Nothing checks skb_shinfo(skb)->nr_frags against MAX_SKB_FRAGS here. The frame
count comes from the peer, in the frame header. tbnet_check_frame() only boun=
ds
it at the start of a packet.

	if (frame_count =3D=3D 0 || frame_count > TBNET_RING_SIZE / 4) {
		net->stats.rx_length_errors++;
		return false;
	}

TBNET_RING_SIZE is 256, so frame_count can be as large as 64. MAX_SKB_FRAGS i=
s 17
by default. Frame 0 builds the skb and every frame after it adds a fragment, =
so
nr_frags can reach 63. Once nr_frags hits MAX_SKB_FRAGS, skb_add_rx_frag() wr=
ites
one entry past skb_shinfo()->frags[]. The frame_size and MTU checks do not st=
op
this. With small frames, 64 fragments stay well under TBNET_MAX_MTU.

So a malicious or buggy peer can send a packet with frame_count between 19 and
64. The frames only need to increment the way tbnet_check_frame() wants. That
drives nr_frags past frags[] and overruns skb_shared_info.

The fix I had in mind mirrors f0813bcd2d9d ("net: wwan: t7xx: fix potential
skb->frags overflow in RX path") and 600dc40554dc ("net: usb: cdc-phonet: fix
skb frags[] overflow in rx_complete()"). Add the fragment only while there is
room, and drop the packet otherwise.

	-	} else {
	+	} else if (skb_shinfo(skb)->nr_frags < MAX_SKB_FRAGS) {
			skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
					page, hdr_size, frame_size,
					TBNET_RX_PAGE_SIZE - hdr_size);
	+	} else {
	+		net->stats.rx_length_errors++;
	+		__free_pages(page, TBNET_RX_PAGE_ORDER);
	+		dev_kfree_skb_any(net->skb);
	+		net->skb =3D NULL;
	+		continue;
		}

I do not have two Thunderbolt hosts, so this is from reading the code. I can =
put
together a focused reproducer if that helps.

Does this look like a real overflow? And is the MAX_SKB_FRAGS guard the right
place, or would you rather tighten the frame_count bound in tbnet_check_frame=
()?
It has been there since the driver was added (e69b6c02b4c3), so it is a stable
candidate. Happy to send a proper patch once you confirm.

Thanks,
Maoyi
https://maoyixie.com/

