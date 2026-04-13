Return-Path: <netdev+bounces-278167-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GSOBQo13Wl9agkAu9opvQ
	(envelope-from <netdev+bounces-278167-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 20:25:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D68B3F1F52
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 20:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0D62D3030D48
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 18:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60C836164B;
	Mon, 13 Apr 2026 18:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oerwcTa9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E3B3603F7
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 18:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776104690; cv=none; b=VVnqLB1W2SO6xKxjknWzxtTe9cVSM6TyGKG1Twwp8T/27sOjcZDyracXy6si90SBeeoklAxQFvCNnckGbBEVHdQTvwkUHvFya4V9sHC5QBtV4XDQfYG9l7fsoHn1zPHZlIzfEFnz8/5oUtLa6Vz+NViMAbSUwGbVxEAAZaAhUiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776104690; c=relaxed/simple;
	bh=WX+GbDCQnemIbX75B+YiYyahJQmX7jQXWaQHRJtE22g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JbW/snanW6Qkw9S9qvdB0UwSnpCtpFyYCBxxXJC34Ow6KCdPXwSaeQa0HkVxzeo74ARcOntCDSediylDKKkEUhOGl3aU/58h/5xoWma2oKysCArDU2wHboF9LFTdFT99zh9/1mwIzilh2Bj+lGqPqSPH1vOnTHj1lJWstDmu+AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oerwcTa9; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8a032383008so52919886d6.1
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 11:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776104688; x=1776709488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pwuEhADy0804om/OdHEIRZ/J1D9Tqo21sy7eI3dqC5M=;
        b=oerwcTa9ieG1OFUB7FyjG6puCmp+rUhPWSY2P9RJIR80DQy4olguP0QSFpzGjw3yEW
         4s3l9w6/psQwdzXLeIZNv8On2mSK89g03NK5htrp7tqYPfVYEb6ntBGAsHFJyaJOrCXI
         fSxwSqosGzTs+qbDrTb5MFqgYPNmCdIAz4lB1Va6Jzzrju7g/t5Hu5fCcNkNMGwNApa2
         LsvviMh0nUduvQakttLcIviqYmBjkXwuJMnC+s57pr0qE6y1itXEuk7TPs55iFAyOQqT
         ivKjBXK6eD3KO1pK/tUKiddiTgXsplHTX0iEU4OCDRM6011FkiSLw6kzts3d6XmYwKA8
         hXEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776104688; x=1776709488;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pwuEhADy0804om/OdHEIRZ/J1D9Tqo21sy7eI3dqC5M=;
        b=C83BAixh5l+2KcJ8g4JdfVQEpdXnqvQs6YnPYg8Kj9CQOKg7vZI2P2Opfr5VHQ2md9
         fC9ox1AT6sshyUJ0jVqqy/voNrQXxPGNsGn8eURV77hDcmi4uGSC+tu5x1D/VVxTfKPD
         LKhXL4nmeS6l5IFtretMby5J6//fUQvLuPSF/680Pf9N5ogDOVU0jxuypGJ7un0lBj79
         5+HRx8suxmyd8tcZIxupZZpfNQYMew2fOR6mCqdWNkmk1QsPdteCjcvQ7pJV8qXW8f0X
         z0YZdf64mO8qbApiz+Lc96M7P4ahJqJrG6yzO1cP1OqjidHwdVUKUHs+ExD8HNAQ7yD/
         958Q==
X-Forwarded-Encrypted: i=1; AFNElJ8yQTnEvWDYVedFok8NzUDz9H6YB9wfJ+U+O/iBgwAVxxaRG1dTCqGj76buppixj24msUrvZ4U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7BB+yg6cXrNttIPNDGVsWyDQqbPYaDCp7Q/T0TPl8hjddiJlI
	7CWeplMCPTI8UWSV9JXcxjoJUKuF9EZHsqwpGHGSQcHg6AN3qgXKkuEu
X-Gm-Gg: AeBDievnyJAvT7fHgGjtQHMRgotXUgjXtXzgXzMaB3rSOmYi8sB+sQxniaGTLFZBays
	HQ/epDquDB8uI/1LZ0ZxOZu889x13iyTZSeRfef0c3hyXYkleOfh92oYhnoSMrSiq8lt0r0eNTc
	6S8qavAOaqegjCe2pydRWl5Q3cG/k4HdxJBvAE9pgpaZLNwkroNzwQEzE9QIn37ZfOhVg6fwl1a
	uZ0A4Va7H1GMu7A+EISv78zkCtzgkE1vmZKBhYw5HZg0EFRmKZPps+mkWzwzgTbPM6UWBstDryl
	OdoitJKWgsmKaluYT14rHZwHpTpNMPVLVBvNuEK0kzngLAHZ9eN5IAWmOx1dVa9A7xAO9fE7ytD
	dwl0mzdZtdyiYi67TJTr5aSIL3pJm/vk7oFZ8WteU3QsOnMxpfKRcgxFdcgLms4/A4GjclG5HKy
	gAb/tvPomyZDVEZyQmrV/eY5Ao883kqPn7aMA+3GC1V4h7ED84+OK0WZLsRoqsF8UcnfiHteEYp
	z9QCMT2nZSpp8l0aEje
X-Received: by 2002:a05:6214:4c8f:b0:89c:6451:67ac with SMTP id 6a1803df08f44-8ac8617fc04mr206413246d6.12.1776104687285;
        Mon, 13 Apr 2026 11:24:47 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac84a47a0dsm103210326d6.22.2026.04.13.11.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 11:24:46 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: "Tony Nguyen" <anthony.l.nguyen@intel.com>,
	"Przemek Kitszel" <przemyslaw.kitszel@intel.com>,
	"Andrew Lunn" <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	"Eric Dumazet" <edumazet@google.com>,
	"Jakub Kicinski" <kuba@kernel.org>,
	"Paolo Abeni" <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Bommarito <michael.bommarito@gmail.com>
Subject: [PATCH net] ixgbevf: fix use-after-free in VEPA multicast source pruning
Date: Mon, 13 Apr 2026 14:24:27 -0400
Message-ID: <20260413182427.298513-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-278167-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 7D68B3F1F52
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ixgbevf_clean_rx_irq() prunes frames whose source MAC matches the VF's
own address (VEPA multicast workaround) by freeing the skb and
continuing to the next descriptor:

    dev_kfree_skb_irq(skb);
    continue;

The skb pointer is declared outside the while loop and persists across
iterations.  Because the continue skips the "skb = NULL" reset at the
bottom of the loop, the next iteration enters the "else if (skb)" path
and calls ixgbevf_add_rx_frag() on the freed skb, dereferencing
skb_shinfo(skb)->nr_frags — a use-after-free in NAPI softirq context.

The sibling driver iavf already handles this correctly by nulling the
pointer before continuing.  Apply the same pattern here.

I do not have ixgbevf hardware; the bug was found by static analysis
(scan_drop_continue_loops.py + semgrep drop_continue_in_loop, multi-tool
corroboration with the highest score in the scan).  The UAF was confirmed
under KASAN by loading a test module that reproduces the exact code
pattern (alloc skb, kfree_skb, then read skb_shinfo(skb)->nr_frags):

  BUG: KASAN: slab-use-after-free in ixgbevf_uaf_test_init+0x100/0x1000
  Read of size 8 at addr 000000006163ae78 by task insmod/30
  freed 208-byte region [000000006163adc0, 000000006163ae90)

QEMU emulates igb (82576) but not ixgbe (82599), and the igbvf VF
driver does not include the VEPA source pruning path, so a full
end-to-end reproduction with emulated hardware was not possible.

Fixes: bad17234ba70 ("ixgbevf: Change receive model to use double buffered page based receives")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-6
Assisted-by: Codex:gpt-5-4
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 42f89a179a3f..4ba3be961ab6 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -1221,6 +1221,7 @@ static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
 		    ether_addr_equal(rx_ring->netdev->dev_addr,
 				     eth_hdr(skb)->h_source)) {
 			dev_kfree_skb_irq(skb);
+			skb = NULL;
 			continue;
 		}
 
-- 
2.53.0


