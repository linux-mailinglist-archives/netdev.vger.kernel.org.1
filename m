Return-Path: <netdev+bounces-299330-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9R4EDc6XL2rxCwUAu9opvQ
	(envelope-from <netdev+bounces-299330-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 08:12:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D968683ADF
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 08:12:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=IVEK69Sx;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299330-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-299330-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F2EDE3006F1C
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 06:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180FD3AEF53;
	Mon, 15 Jun 2026 06:12:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D148B388393
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 06:12:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781503946; cv=none; b=g7Yvs9cGrBWM70kptmA/dc5/i5qsasPwwvS8p4XYwYO+1PP+WwGYTP0ka9ENagcGAzntVNojraB6uy2A9tLMb0szXAO6bWWatzOrIVxZ4T8tfQf8bCMq1wnlGprdW0WQ9w6ShLItoMr1D2A0qCdpOYlfwaoWMcMksdKYOtmfZkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781503946; c=relaxed/simple;
	bh=fiaEpLMoSTTLWN5RAB+e2V+zrRn9C1pdqE1a/4H/dHk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=r8i3SbAFbdk5EwHrk9DaAYW5/A2xSxDqZrMDNreJAZDXNvECp6JtVWU3QuiqTQnk61h7u1cWmRP5gNHvKChmHEsbsV8a8mmyAy3JL2Jb7t+VCv1FJUDpWDkD0tyy5cq4MJLHwdFVKExV0P+/zBD31PIMj4MdV4TrLTC9cXetit8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IVEK69Sx; arc=none smtp.client-ip=209.85.216.54
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-36da151a152so2034915a91.1
        for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 23:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781503944; x=1782108744; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H4MY35j38zKZqHIBGfhBPpLsbB1y1+JPTM2zRf9KQbY=;
        b=IVEK69SxWw2eFctsxg2h330SIjbxxLnFQU7LXVHXDFZmGiiGkn5YZAICbL9rkA8ysl
         LWbPsfpLT0L/dBXeD6JcTAStf9U+4jdygPNu6tvUyMj8imjOF1PPcu8c/npuRRRceCCS
         uRIPC6yNFzSLPrtoULX80zR/GZS/CfoynYYG4aiddNL3TiA+ScVxa7tQMzK8vnrjzR00
         chyHI7YF8hI4jQikks52gQJUvvI4bc5qwzlIMCRdhL5na8prNAEbbT+0bwFSyYs1GxJb
         d+fp+gmtdH4x+vo8iDBrD9HtZO33pGsZvqe+yg/gSBBBL4bDBQnWLqLBNMHhtRzu4Oyb
         mWTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781503944; x=1782108744;
        h=mime-version:content-transfer-encoding:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H4MY35j38zKZqHIBGfhBPpLsbB1y1+JPTM2zRf9KQbY=;
        b=DKAkEgjsSzi+Y2r9DoLyUtiDsL4cQrr6yR1kycaktnyF0WSRbd6rqXsgxkJdi5UZw1
         Ikr5LHDthEtjeT0DT+W3gXYpLQKtqmBLjyKEHoUiAs2WucqfnAFlrwp4+bc9bCqH3n0B
         e41xtT1xKOaJSebRsb5qXdFK7vv6kkT1zARVkA0VdIPjZIiTLX090xbOdMCRw3EE+8Gd
         6zdRoY2Q195VvyqhW7EXhfQKFm1fOq4pg7ogvOK0NicJwsQZEvMmie95SZZlSrLYbDen
         iMll5ZbfXvPpFpHY6+OiwaRYD/X14cU4iQZwSIQHJ0VFuQI2i2927CrUcyPZutKhvXSF
         44CQ==
X-Forwarded-Encrypted: i=1; AFNElJ+14I2deFzhJ63/3kI1xlzImdse6g4H6IWwJDSEeoWbBX6ZFZD/ZlkkD851C3UyjwgYlhFjeu0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk5F2qh48EnpzxwTQyPGhqr3E89hzlm0v4w5E+C2fmGc+pox4J
	yWvN8BF53a9iR18WWFr8Y/xtuU7iG5gqUzP3lAZoMf0n10mQDkCfdxq4
X-Gm-Gg: Acq92OFN1huc+hg1B+Vw0HlKAJjkmtS2u2zfC9SfyK9bpTtFfZ+2ktqfDYMOqItgdC/
	9yhg40xwZ7Yj0g9PhBjUbAudV5zXlVYvfq88t1hl8uf7eq6d+mq7BhspT+FfdseIM68fptUF9ve
	oCXuXDYrXcwkxiywLG0wxRisAXv88VaBoTLY9kU3CPnC0rf+F5i38M8wRfLox+Xo1sMCOYy4VOj
	jIlh73Jwa0rsxHJq4G+bytPLeRwmhY/rAPHpBWF00QNQMu0A3QpdShNH5tGUnEptpgcHbgOU0F0
	wm+c0KI9VHSWmMAxd2kKvqnprSQXfcNnauPoPpFra/Um59KqwNCNykMMed3X88Wqg71kGJXJY/K
	NOit7BNahBWp5eZuCRujBdheqmN83ApWizL2DO+TV4HGBs8QARgddcTUsHLtLM0DIZFWS4ZkaGk
	m0MR+fD8vOSeiV3zPtWzgWZfpdFM5yBd74wJn9KNjp3dddX2uB
X-Received: by 2002:a17:90b:2dca:b0:36a:6ac2:8bc8 with SMTP id 98e67ed59e1d1-37c2bcef7dfmr9190949a91.14.1781503944011;
        Sun, 14 Jun 2026 23:12:24 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37a233f4531sm9327814a91.2.2026.06.14.23.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 23:12:23 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Oliver Neukum <oneukum@suse.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: kalmia_rx_fixup(): possible out of bounds read on a short RX frame
Date: Mon, 15 Jun 2026 14:12:20 +0800
Message-ID: <178150394040.1087339.3314243829968462233@maoyixie.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299330-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:oneukum@suse.com,m:gregkh@linuxfoundation.org,m:linux-usb@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,maoyixie.com:url,maoyixie.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9D968683ADF

Hi all,

I was reading the usbnet rx_fixup helpers after the recent endpoint validation
fixes. I think kalmia_rx_fixup() in drivers/net/usb/kalmia.c can read past the
receive buffer when a device sends a short frame. I am not sure about it, so I
would appreciate it if you could let me know whether you see this as a real
problem.

This is the relevant part of the loop:

	if (skb->len < KALMIA_HEADER_LENGTH)        /* 6 */
		return 0;
	...
	usb_packet_length   = skb->len - (2 * KALMIA_HEADER_LENGTH);  /* u16 */
	ether_packet_length = get_unaligned_le16(&header_start[2]);   /* from device */
	skb_pull(skb, KALMIA_HEADER_LENGTH);

	if (usb_packet_length < ether_packet_length) {
		ether_packet_length = usb_packet_length + KALMIA_HEADER_LENGTH;
		is_last = true;
	} else {
		is_last = (memcmp(skb->data + ether_packet_length,
				  HEADER_END_OF_USB_PACKET, ...) == 0);
		...
	}

The only length check is skb->len < KALMIA_HEADER_LENGTH, which is 6. Say a
device sends a frame with skb->len between 6 and 11. Then usb_packet_length is
skb->len minus 12. It is a u16, so it wraps to a large value. Now the check
usb_packet_length < ether_packet_length is false. So ether_packet_length is used
as is. It comes straight from the frame. It can be as large as 65535. It is then
used to index the memcmp() above. That memcmp reads past the end of the receive
buffer. The skb_trim() and skb_pull() after it use the same value. The buffer is
rx_urb_size, which is hard_mtu * 10, so 14000 bytes. CVE-2026-23365 added
endpoint checks to kalmia_bind(), but it does not cover this path.

I do not have the hardware. So I called the function directly with a crafted skb
on 7.1-rc7 with KASAN. The frame was skb->len 8, header 0x57 0x44, and
ether_packet_length 210. The read goes past the buffer and faults. The address
is the frame start plus 6 plus 210:

  BUG: unable to handle page fault for address: ffffc900001a40d0
  #PF: supervisor read access in kernel mode
  RIP: 0010:kalmia_rx_fixup+0x9a/0x310
  RAX: ffffc900001a40d0  R12: 00000000fffffffc  R14: 00000000000000d2
  CR2: ffffc900001a40d0

R14 is 0xd2, which is 210. That is the ether_packet_length from the frame. R12
is 0xfffffffc, which is skb->len minus 12 after it wrapped. So the short frame
made the length wrap. Then the value 210 from the device was used as the offset.

The smallest fix I could think of is to require both framing headers before the
subtraction, on every iteration:

	if (skb->len < 2 * KALMIA_HEADER_LENGTH)
		return 0;

I tried it. With that check the same frame is dropped and the fault is gone. I
am not sure how it fits with the "Some small packets misses end marker" case
just below, so I did not want to assume. I would appreciate it if you could let
me know whether this is a real issue, and whether that is the right place to fix
it. I am happy to send a proper patch with the reproducer once you confirm.

Thanks,
Maoyi
https://maoyixie.com/

