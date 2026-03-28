Return-Path: <netdev+bounces-272758-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aP/LDeyqx2mAaQUAu9opvQ
	(envelope-from <netdev+bounces-272758-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 11:18:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D6D34E0A4
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 11:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4C98C300B463
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 10:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1543859E3;
	Sat, 28 Mar 2026 10:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c1Y/mbvn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4E23859DB
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 10:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774693093; cv=none; b=mqcvWR8nTRUTjCWq1mcKZePiiihOR2FHV86x2ar2W9AVRAvJaOJ2yY3z59P37XV2vOsNPz/FA9L4/+YmmAuSGukfClOwu3sHPGclR8nRL4gs7zbnIX6NL+W97+0aNpuXhVzeRlRwuSOJF1BjvTBjd5upXgwgH5EAqDKmb18eg9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774693093; c=relaxed/simple;
	bh=yGOwKDe8FApAodSaWtRpINZ/Pf59eGdK50djmfUVcLs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EyYNzKRL6M6DmuC+HSypVF0Fv2zwacRPno2U7QF7WyqmBB2a1gpUfS29NAzMZM07IsH3b1/lYqzyn4o2imV+YSye91Fg/vn6Yp1yUxsNE8iLHrrFqamEISy9NlW74Yx4bWbCA0ifUE/JkLXHOnMlGM4AecQCNL12HFxU9vBbi8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c1Y/mbvn; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-50b29c4e554so36800371cf.0
        for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 03:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774693091; x=1775297891; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p/w2BHpjQT/TnLHn0OH9cw7cV2SlAEzKZqiWqm6HLaI=;
        b=c1Y/mbvnOUaN9RICuUO4Fw60ZbinToYUN6Kn8O763tO1E74XGg1SYsZmDNDGCMF8tJ
         TU4umoQfBhcS9fApi9QmI+v9dGad8ypoLjY4EfsYqKmMokMJnEXxxjn4ptTlW9pE/5OW
         e6ij7ifwdm4LE5iyuKFLA2sAH+JDHNso3SfwsLa1RS/gUan4EQVR5HtTNPwz82PWE0lo
         mJOj18XosmQ1lQYfZBEOzK444fqmQqEv3TdoaJMMaCbsLF8CflRh1IVQW8dNCVzkFMPX
         E9ItgZB2fbQrMNwkvPdMO+vrwilOONsTzKa6XqlYTZOGWfTiRKVdm7Ri02PFPKanMOmP
         s30A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774693091; x=1775297891;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p/w2BHpjQT/TnLHn0OH9cw7cV2SlAEzKZqiWqm6HLaI=;
        b=CBObW8bNGYhvGYCrX7fG3JgUUmWkGKtE807gSzvuz/vXZBFUWZpjVAV6I1NZmaecEc
         72Ulo/n7NCriiuT/p42ADaPNkJohaWZ09rSXzzUIN68GL1F63ywLKqkQjtUXPPsNvY+V
         Ahu0Qfr7mNnqjG6Fwfr0lN0qWGr01UzfRvpcrE716G6yRQeRRRTGhWCh3hnV7i4Eqp+G
         RoW0/aRrcuk5U6QK70vCMoQXVvIc8k0pgq6rhxUdHkeYfrl9fvUcoRBLa9/jtPUMyBsv
         E4VHyWgyYEemCkSbgAesdtOrbtFZhkl58kG6H54+rmIWkt3EodGR2ips/O4RfswLiqe/
         nyYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVk6hZH1pmvcSUjAF9YEWn3FjUppzWE8GDGhS0CcWAtaPGaDg8JWbJvhdVaqrNUVut/f0mJQm8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+/bRKUk/oafR6AmjyM2xx5oLlyleQUEvKVKMCOXVNcgrPUg+7
	Aj7ONL7fMCjFu0kkpGIfPWR35Pql9mjAUUfnC0d3cP3Gwtrb6Jfx5TpGBouUXg==
X-Gm-Gg: ATEYQzysk0qTPqQfiVyDB1+KLVjKoZpthh1XEfb3sK2aVV7xb+gSmc94mShUBbmx6s+
	tzEvZh9WM/lNMZQtaso85OeXmzppxPGin7L6Ve0Zu72xhdG7AwHuC2w0oygJERz31JZPRLEtQ5V
	jCaFmHvmP9tDolsg3LrX+gP5j0ewqgff6nqGfr/9hkoRdTDMCA3TYbZOnGLZI3vEmzf+fpSnjrb
	QWqXKCXfebLj2+MJtWEhWp+FMeYAUSStr+s54HTNltVhnkECowbh5h+Ulpft+ayZ66kXTmVGogQ
	b9lLF9fTd63Q92dpOs4v5gPRmUPCFvIhOWhxE/UXj+AJV1fcsGIRU9LEzhX8k6ukS+k7kevv0Ij
	JFUYlDUEjPHrB73uZdOtmtxLXH4iLNIIctKMD+8LZ2GvC2KuAMxf1hSBsBHBj98SVwYy8lLfA3b
	EbjfE3ZWATOej+25LQPWWDXjOnqjN2y2Ev
X-Received: by 2002:a05:622a:5a92:b0:509:965f:888f with SMTP id d75a77b69052e-50ba3672de7mr71964701cf.0.1774693091161;
        Sat, 28 Mar 2026 03:18:11 -0700 (PDT)
Received: from localhost.localdomain ([128.224.253.2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50bb2e17372sm15490681cf.24.2026.03.28.03.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 03:18:10 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
Subject: [PATCH net-next 0/4] net: macb: Remove dedicated IRQ handler for
 WoL
Date: Sat, 28 Mar 2026 18:17:44 +0800
Message-Id: <20260328-macb-irq-v1-0-7b3e622fb46c@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMiqx2kC/x3MOwqAMBBF0a3I1A7ERAXdilj4eeoURk1EAsG9G
 ywPXG4kDyfw1GaRHB7xctiEIs9o2ga7gmVOJq10rYwueB+mkcVdXFYGUM1oTFNSyk+HRcK/6sj
 iZotwU/++H12ouPhkAAAA
X-Change-ID: 20260321-macb-irq-453ee09b3394
To: Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Kevin Hao <haokexin@gmail.com>, netdev@vger.kernel.org
X-Mailer: b4 0.14.2
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272758-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haokexin@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 33D6D34E0A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

During debugging of a suspend/resume issue, I observed that the macb driver
employs a dedicated IRQ handler for Wake-on-LAN (WoL) support. To my knowledge,
no other Ethernet driver adopts this approach. This implementation unnecessarily
complicates the suspend/resume process without providing any clear benefit.
Instead, we can easily modify the existing IRQ handler to manage WoL events,
avoiding any overhead in the TX/RX hot path.

I am skeptical that the minor optimizations to the IRQ handler proposed in this
patch series would yield any measurable performance improvement. However, it
does appear that the execution time of the macb_interrupt() function is
slightly reduced.

The following data(net throughput and execution time of macb_interrupt) were
collected from my AMD Zynqmp board using the commands:
  taskset -c 1,2,3 iperf3 -c 192.168.3.4 -t 60 -Z -P 3 -R
  cat /sys/kernel/debug/tracing/trace_stat/function0

Before:
-------
  [SUM]   0.00-60.00  sec  5.99 GBytes   857 Mbits/sec    0             sender
  [SUM]   0.00-60.00  sec  5.98 GBytes   856 Mbits/sec                  receiver

  Function                               Hit    Time            Avg             s^2
  --------                               ---    ----            ---             ---
  macb_interrupt                      218538    723327.5 us     3.309 us        1.022 us

After:
------
  [SUM]   0.00-60.00  sec  5.99 GBytes   857 Mbits/sec    0             sender
  [SUM]   0.00-60.00  sec  5.98 GBytes   857 Mbits/sec                  receiver

Function                               Hit    Time            Avg             s^2
  --------                               ---    ----            ---             ---
  macb_interrupt                      218558    646355.1 us     2.957 us        1.290 us

---
Kevin Hao (4):
      net: macb: Replace open-coded implementation with napi_schedule()
      net: macb: Consolidate MACB_CAPS_ISR_CLEAR_ON_WRITE checks in IRQ handler
      net: macb: Factor out the handling of non-hot IRQ events into a separate function
      net: macb: Remove dedicated IRQ handler for WoL

 drivers/net/ethernet/cadence/macb_main.c | 244 +++++++++++++------------------
 1 file changed, 102 insertions(+), 142 deletions(-)
---
base-commit: 3b058d1aeeeff27a7289529c4944291613b364e9
change-id: 20260321-macb-irq-453ee09b3394

Best regards,
-- 
Kevin Hao <haokexin@gmail.com>


