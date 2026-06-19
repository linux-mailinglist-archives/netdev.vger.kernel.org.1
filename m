Return-Path: <netdev+bounces-300585-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vyoUKfqxNGoqfAYAu9opvQ
	(envelope-from <netdev+bounces-300585-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 05:05:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE596A3A7D
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 05:05:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Y0lZyk87;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300585-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-300585-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF6E93019830
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 03:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BE432B137;
	Fri, 19 Jun 2026 03:05:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E490A1E5B9A
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 03:05:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781838326; cv=none; b=m1i3d0GSiK2TT6g+P5ayRl27ARAeqMPojQqa2aTEorLALdiCcqH04hIPWh2VXo7YuPr8adpr9tRYWTktL/F8z0qIrDKcu3ZUIuNGPtam4cqAabLQF5IJ8i8x6tHxiJdAbqpa9LnWGYFlv5RwH17kCkChDCGr3G7aRNgjbm7cEts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781838326; c=relaxed/simple;
	bh=nGWpFvxNMJlx9fwyaFMCICQhrpMOg/Oa9cKNTW65JeA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=sa1mAU6Hk0zbyBkSseaP19+2LKVKVRTHbmS9NajHEXwDpIHfcIxyZ+WyA8GDocJgGd9j908JwIxGlljBL8amLtf9ittvvHYYHLy8p739xeHJgMku38df37JZjdIazDHFGXzNny3F4ZKc67RJaWPReiGDVzC1SzBkWYl96jBidM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y0lZyk87; arc=none smtp.client-ip=209.85.216.47
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-36d98c9b596so933173a91.3
        for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 20:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781838324; x=1782443124; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JSjAvuhVd3eY7q/22pXlFwiMV4RA0QP3dDmVY4jffek=;
        b=Y0lZyk874ymY2c4j5ADULPvcktikOPuUirOU8wcpPA70JxoPHaKVhutEfGftnRiKzx
         NpjWLl8AatyrxIga3XW1U9nVYSR9aaxFdafGDOO+Uw5lOCo5HENsA/+TZe0saNQsGMAv
         Mn9EPRxgT8H2/rWbrvUhuRc3LPwtmYXpMT2VHVDnSFRtoFIkmcvaIs86PQ3plVFutEX0
         BtzUhJqctO0Vu2r1GNcxaKKdzZ0j4bUJGR0iuBvt3jbOcoOOs871M411JAna5yvBi7k3
         /pOA2cctaSIlbfL+90A9mZ8zWTCzkmP/FoaXcGdmrUYBM+O6a4TfFOVL2cJjsNS8I+oK
         wuug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781838324; x=1782443124;
        h=mime-version:content-transfer-encoding:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JSjAvuhVd3eY7q/22pXlFwiMV4RA0QP3dDmVY4jffek=;
        b=TT4fhZ9JdCe36WW58jAlDXJX1FrFWDx98sOKVnRqidZms61tVBCMSk22InDfv5+enE
         aRcIKKH0Ez3IJwni7izohhZTmG7uFRI43SoR+u1qBchj6fzDizL2FYEIl1bjFOBxNNQQ
         gdVx39+u0wwZXPQlnCAUNE53az1MKcXk2A/+3BxhRclkvvVjKAY49sixsGzo5nm9Smxp
         gyoDIE+k0t6ZZqBNT2uBsryxoh/irVya6+CX5PwOhxBH+M9FEfeMU12FZzTCiKLTHOY3
         PoIarU0GaSBNJF3huAc6MRhCnikiMbB2UzTJWFKkTmEJZ8wT22LsV4DdAEBoOchoprB4
         abpQ==
X-Gm-Message-State: AOJu0Yx49TwVCwgIZDVlWMbRfQlhDn2OQjYv7LefF+IGhG1iYBgJzMeD
	wVdKsoMuDWsWvw88wsAfgmbCHQanENHISib5phhz+2bgu0ymNIdityzG
X-Gm-Gg: AfdE7cl41B+vxsAWDdBnEKXftnhBHNOM8l4h8VyOkoBKt/njiGfrTMqK4wvT+s89XBM
	RBPuh4gNSdqo621myD6gojv9L9olOUJa6iIT1/Pie0ElcuXNrNrtTzFwV+zgleUCy9CcHOYjmAG
	SVclp4AB0kJFTOLIFnZfMeSkjL8pw6ZhPXL9V5oGD2H87llQGepbr0zlI32JIAuhhNZhy2qYPDe
	YmNGC/3tDgZU+N7+8IsnQQUygXZSR+H2owySkJL6BB7JFnafRVleLGFQwWra3mut06WfXSO43zM
	9bSUt3pxIa9DD3M9P41voTxmFzh67CP11ND83j20ndlv9MTFgZkrND5YF9DoOmIeGKyJnkrXogd
	fE/Qk3K65EQeFdH6oy8/j8LxH8g5tyQxzQkat654K/2hlaWnkF0KFRvntKd0N6ZOX7FWE34U5j4
	d+T5UN5dTyH+ag34OClEpTzRzhCwSPUYvC6qlI9Q==
X-Received: by 2002:a17:90b:28c3:b0:36b:93f7:a903 with SMTP id 98e67ed59e1d1-37d160d8863mr1983145a91.18.1781838324163;
        Thu, 18 Jun 2026 20:05:24 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37d15de5ee3sm1086767a91.9.2026.06.18.20.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 20:05:23 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>,
 Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 net: wwan: iosm: possible out of bounds read in the MUX downlink decoder
Date: Fri, 19 Jun 2026 11:05:20 +0800
Message-ID: <178183832043.3878023.3610072137230679925@maoyixie.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:loic.poulain@oss.qualcomm.com,m:ryazanov.s.a@gmail.com,m:johannes@sipsolutions.net,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ryazanovsa@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300585-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,gmail.com,sipsolutions.net];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,maoyixie.com:url,maoyixie.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1AE596A3A7D

Hi all,

I think mux_dl_adb_decode() in drivers/net/wwan/iosm/iosm_ipc_mux_codec.c can
read past the downlink buffer when the modem reports a large table index. I
would appreciate it if you could take a look.

The decoder takes the table offset straight from the device ADB header.

	block = skb->data;
	adbh = (struct mux_adbh *)block;
	adth_index = le32_to_cpu(adbh->first_table_index);
	if (adth_index < 1)
		goto adb_decode_err;
	...
	adth = (struct mux_adth *)(block + adth_index);

first_table_index is a device le32 and the only check is that it is not
zero. After that adth points at block + adth_index with no upper bound and
the code reads adth->table_length and the datagram table from there. The
downlink buffer is IPC_MEM_MAX_DL_MUX_LITE_BUF_SIZE, 2048 bytes, so an index
past 2048 reads past the slab object.

mux_dl_process_dg() has the same issue further down. It reads
dg->datagram_index and dg->datagram_length per entry, bounded only by the
device block_length, which is itself never checked against skb->len.

The protocol layer below only caps the total transfer at the pipe buffer
size and skb_put()s it, so skb->len is at most 2048, but none of these
in band offsets and lengths are checked against it.

The data here comes from the modem, so it is device input we should not
trust, especially with an external or compromised PCIe baseband. It fires on
a normal downlink receive once the iosm net device is up.

I reproduced the adth_index read under KASAN on 7.1-rc7. With an index that
fits the buffer the read stays inside. With an index past the buffer KASAN
reports a slab out of bounds read past the downlink buffer.

The fix I have in mind validates every device offset and length against
skb->len before use, rejecting an adth_index that leaves no room for a
struct mux_adth and a datagram that runs past the buffer.

Does this look like a real bug to you? The aggregation decoder has moved
around over the years, so I am not certain of the exact introducing commit.
1f52d7b62285 ("net: wwan: iosm: Enable M.2 7360 WWAN card support") is the
broadly cited landing point. I am happy to send a proper patch.

Thanks,
Maoyi
https://maoyixie.com/

