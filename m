Return-Path: <netdev+bounces-300355-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MowbGVquM2oBFAYAu9opvQ
	(envelope-from <netdev+bounces-300355-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 10:37:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E80CB69E7E9
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 10:37:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=QUUF1kSk;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300355-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300355-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13985302F0C1
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 08:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565093B3C03;
	Thu, 18 Jun 2026 08:37:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2E438F92D
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 08:37:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781771846; cv=none; b=I0UW0kopVsoCNWdCRvfHff44V3pOAL3y1oONTH8vsXDHwiIeFKHCc/xxsXUHfum3jq0QTuM88INrjNpvj5EcnQ4sow02SUjDy+CMUHSYGo+ANmkWqJ5Mp/W+xJV1/29HNPq73gq6a/h5xRnWy9Ar1ZJgCoRCCsNvQy1wJAXJK+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781771846; c=relaxed/simple;
	bh=UplzPm21o1txOIp6An/0DELClqRkTlgQ428lKTxQj6k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UlTDMXQ2vMTmN3NnaY547PnVRMLIvjqrPpMQVuy4Xrd4iaAnXslVVUbWrvjwh/uqoVlIhiFamSMIFTpB3piCAfo6xj/O+p1sdFcrn9y8Spg15AG9xMzJb+koqUSX/5p3cGmd5ammQv9UvX+AZbSC4vbJeUn4/UX/sKeGQCgVMOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QUUF1kSk; arc=none smtp.client-ip=209.85.214.227
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2bf20f6be6bso4318255ad.3
        for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 01:37:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781771844; x=1782376644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VeJxbhN0Ht9jvhVm/ZNGkhtjcsRPRqpGEyUnibfRpak=;
        b=aD/XKLz2Mx94DdHo4ixRQ0R5mU9xoIy+ow7u7LuoaGKscR0Y5H5CVsdOiKUXA/ayjZ
         NnoULfiQ4zuARfJPg5pwDMo+fy1Pq0aNxZ1kjY5n2L9SvMNbIl0gpBmvm2ldAya2NCNB
         6RvN2U0iI49xC7HSvCZHUPWFOCgG2XI7Lp2VmyIja/y/xxEX8+Fp5tGOsYmVtG07iiKK
         K6calJmBIZPFVTHrOM63oPCRZW30k+493yt0PDHDJg4tVQePufyOFUdnL8AHUW8Qxl2P
         +vM8uSZ7Zh4xxA+3vFqzf7iEUSLbp8I8nVqkx4ggogV7AFPv8UlTgVU8QzrLPM/kOkY9
         M0aA==
X-Forwarded-Encrypted: i=1; AFNElJ+MoDtYXBD1QNDFxfus+YKW4X0XjAYx5WpXm46oxwiW2rzYKCC6XZBgVJtwVaPNCzX/x8yauAU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+AhnM5KRoWok955cFSWqBhqa07FJKlNfOpTL5bUZYFhxA+/HD
	UBo/xQkHUxtK2pC+1LiZTP21ZC/TShjrLv6VbdhFxp8eVBTN0HQ/iT0qphAcklB3WWwljE8We4e
	unTZ2dkxPRyNjnybh/inzV/QcGlLPrvZMN5Dnly6SJncf9TqI5CwB2pue9ZNdUqNA7gLmp3cZjA
	cKI5wIJUglo2KC5qYse+p9hJTk1kUX8dqGbsj9r0n7g4loW/RDrcpdckvVLPZ0QYylMLjmfdA7z
	Ra57wfLnZDAErnAPg==
X-Gm-Gg: AfdE7cmvnJ9xXG+9wxvzfu+n3auEzJgqxvH/6Du/6VK8BbxL3B/9ww8cn26JGhdG+a7
	ry8RU1VJpsDFLb09Bw0ikutK88vrerWE8eoVGDhiyr8U7VkGY8VfScCMj6spKL8U4rcafOTJy8n
	IKnc507fQs3KG5qi8UNdiOqISEdjgt7o25HWE+hEoCLWoPglBUk+Pgqcive4aH9uA0kR9NNUVVu
	nlmDhMTYurAbVsg72PYwNWIPa/7afzmEZqCz0OUvPtPEFI2ZtR6Gky8h7e8dOGyx/RAWyzf+KRi
	xcO95S7y+WU5G1RCoYaCU7N0NKDfBdvuZXU9sVlJ9D2bFYkqgMMgyWcdDD9oHkOa7Lp3i1MRdGt
	6Dl+egiDGNM8X3y1HCjckDcJhLFKxgsKsBcIba62iB8sj4xv5CcUKm19bceCFtXDWr1Aq8i1FYo
	TTBn2vmGCmNeZpgNV1x9gvzx20t1e7CZ+ig4qulSEVmYW8vxwspA==
X-Received: by 2002:a17:902:f54a:b0:2c6:5bae:f9ab with SMTP id d9443c01a7336-2c6bc221f27mr81241145ad.22.1781771843635;
        Thu, 18 Jun 2026 01:37:23 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-23.dlp.protect.broadcom.com. [144.49.247.23])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2c4301998ffsm16554375ad.18.2026.06.18.01.37.23
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2026 01:37:23 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-304f23c55b2so677069eec.0
        for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 01:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1781771842; x=1782376642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VeJxbhN0Ht9jvhVm/ZNGkhtjcsRPRqpGEyUnibfRpak=;
        b=QUUF1kSkDoIShavYwmqFOxFaFP8h63puhGhiN5SCzIEDKpJ0sGlwLWQEJOVj+RgJeZ
         qC4bfb0DKwzDdHoC/Mem4er3pahPGi9ufsHG36eRyF23GX46xxH8I9ycY9zL5rH4lVXP
         TCOwB0r0vtmYnQInjxWZbVQ6KVUoVnlaTK64w=
X-Forwarded-Encrypted: i=1; AFNElJ9tICw6lVBgs6LU6NJuSrfpEqhrzdxVs2l6x/CpQX3eKHy3lTRoBPzn3tLdcfkZMYD/w+JC5yU=@vger.kernel.org
X-Received: by 2002:a05:693c:3942:b0:2d8:7302:d3d with SMTP id 5a478bee46e88-30bc998fb73mr4625537eec.8.1781771841484;
        Thu, 18 Jun 2026 01:37:21 -0700 (PDT)
X-Received: by 2002:a05:693c:3942:b0:2d8:7302:d3d with SMTP id 5a478bee46e88-30bc998fb73mr4625503eec.8.1781771840833;
        Thu, 18 Jun 2026 01:37:20 -0700 (PDT)
Received: from shivania.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e48e412sm27475037eec.4.2026.06.18.01.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 01:37:20 -0700 (PDT)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xiaosuo@gmail.com,
	iri@resnulli.us,
	jhs@mojatatu.com,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH v5.10 0/2] Fix CVE-2026-23204
Date: Thu, 18 Jun 2026 01:08:05 -0700
Message-Id: <20260618080807.1269070-1-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[broadcom.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300355-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com,resnulli.us,mojatatu.com,broadcom.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:xiaosuo@gmail.com,m:iri@resnulli.us,m:jhs@mojatatu.com,m:ajay.kaher@broadcom.com,m:alexey.makhalov@broadcom.com,m:vamsi-krishna.brahmajosyula@broadcom.com,m:yin.ding@broadcom.com,m:tapas.kundu@broadcom.com,m:shivani.agarwal@broadcom.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[shivani.agarwal@broadcom.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shivani.agarwal@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E80CB69E7E9

To fix CVE-2026-23204, commit cabd1a976375 is required; however,
it depends on commit 13e00fdc9236. Therefore, both patches
have been backported to v5.10.

Eric Dumazet (2):
  net: add skb_header_pointer_careful() helper
  net/sched: cls_u32: use skb_header_pointer_careful()

 include/linux/skbuff.h | 12 ++++++++++++
 net/sched/cls_u32.c    | 13 ++++++-------
 2 files changed, 18 insertions(+), 7 deletions(-)

-- 
2.53.0


