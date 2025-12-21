Return-Path: <netdev+bounces-245648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7641CD437F
	for <lists+netdev@lfdr.de>; Sun, 21 Dec 2025 18:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9584530006EE
	for <lists+netdev@lfdr.de>; Sun, 21 Dec 2025 17:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F632F7ACA;
	Sun, 21 Dec 2025 17:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0dLjUEW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983EF209F5A
	for <netdev@vger.kernel.org>; Sun, 21 Dec 2025 17:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766339460; cv=none; b=NFCy7NQl/Eziy05bMvqeEQgoWNT64ECs9D0NBghapgcpMGkU2sSaSwKkWTI2HGBg5LmltEbRA7ubR2a88G6B/khulJZxMtMn7+WOoQ8HhMAHf9hMfa9I/E6ufs7Ll4cyMEwekbpLfSliPdZZj3ywOV0eZOr97AX/9nLVbvBBDU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766339460; c=relaxed/simple;
	bh=epSW5plZjS8UYWxcHI10OatTECq1epqYBY6IjBHxIwg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=mEcWp6vx6m8FZC72NJYpK9wL8e9RBO33qxS+vP64Aqu9TGMMO97i3Nd7BdlVbphX0SQHE0I+K/rosjewQBFfUbaHdeLZceBk1u6ix7yiM5fq2d9ueKywK8Zt+oDBohMMYiER37czUIG9s9AkaB9/hVgF4zLD5bgkoHzImjWXBok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J0dLjUEW; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-430f9ffd4e8so1951091f8f.0
        for <netdev@vger.kernel.org>; Sun, 21 Dec 2025 09:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766339457; x=1766944257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b40qSYP/L7CB/omuDFXHgbe5i3kgzEE7rep8JC5Ab/s=;
        b=J0dLjUEWEjVf4mRFBd8IotdlIhUrkJOPztsjdClycNnV43zeejcx8L/I2fo6TRhnCv
         0cIRbhU+v8nhQNNAGBHEljRk3PYjqpHqnDnaUJAcfW7OMqNMpmlqgLUk76V9M3gnhiAa
         om3M3YF9BiMJMs4PRl9OSLgGsArXxvAHT3E5yX0lPqcaBXgg7p5P3eFi0FqkUgNT+vFR
         t22mAQgzVK91L6UmWwuWsdZaMjXr8OdpZwWJS8KOjUZQQ45gm+Bb4zg0bAEtx8IoQ2ZS
         +6U4NZksEEBmikHk+KHEW70leplj2DlSX9BYgwVj6/9HLXyJhJf1jdI5VGyFrMQyOTbW
         jtsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766339457; x=1766944257;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b40qSYP/L7CB/omuDFXHgbe5i3kgzEE7rep8JC5Ab/s=;
        b=xRlW4OpjPFRivuHNWkphD96wVly1tKuAp3ECt8dWhWjImLSjRF4RweIKrutindEo/u
         2h1iqRpgp//hUHrz7Trz4pLe8b10Bh4uVkRj/WVA+6EKSb277F/DhuBhaVHaq/XAqxrq
         bMJhUchgI7Orb+Dtp+VgrubO5rt5DCs6AkuwDXM4Yetv9tbQDj8QoH42ULoFKoS0MnSU
         BHGjR117ItBC63LeQQCKq9IzeVC/IOqIcaJZq7TJkJO/bSnMOy9VAxIN979AG6irgAFc
         MYK4BgPIS+FQrd9Pr9OL1Fyou95SpJGVj5PtPcCjK/I9iMHHsjMGxdEQplQFWnKg2mBl
         Vl/Q==
X-Gm-Message-State: AOJu0YxAGkAjyPuHAYIWVeEsxzbyleIRa0MzDivkMOHW8qSkW1yifupI
	VQ5Qa4uAagsgQT/3yiJLBHEkatdzm5NR/eWsDAgl32AB1HpKXjALvsrkH1lGjQ==
X-Gm-Gg: AY/fxX7QZxyGPj+SoFcR36ZE5ryn3MJ+oBgdD2dyPvhg3kA/t0LfvOg7SCNCmCy8dbu
	qTL5lCuX7y4k4SMHqLq4l9YLbv82FzmflwODH10M8yrKC4UocbqIwe34j3ugi9tVy5lGxeujm2q
	yehkqHlO0CzWgZw8Hdy+ngMGdnqCGhNZBosE3ooluQNJUiW2p23NgkvSGgAxqc/HaJtZJTTlyJt
	vcPxgjn22hvVuk7EmXN6gEEqoVNCFVisDFSZLh953bUAi+aDtErxJc1QjCeEW7Tf0HCf3kMysEk
	wqAJ3WmZJ9m7EWNvvYYgBdtXYYtTAz3B0noFXMJwLsFTqRSaofpXw840Orn2q07Ir0eOsZY3PaK
	f3Ap7/tPHz0n5af3xH/U63NJSuYQOURZw7ghlb9YgH6TGPh7cn2BIcfXl2oIjonlgcqB0svDt+i
	Ujf280LyTmJoh2jHUChyey0Gq1KFZNRnRi6D0GgmvudKNV0PggkQM=
X-Google-Smtp-Source: AGHT+IGWoyRr3tQbin4r2oRpD/Ez8P8OhpeJJf2EhPilp9xbWQ5v4lYSoVrUZucnQz7RuAvYeEEHSA==
X-Received: by 2002:a05:6000:2c10:b0:431:397:4c4f with SMTP id ffacd0b85a97d-4324e3f5beamr10634604f8f.7.1766339456376;
        Sun, 21 Dec 2025 09:50:56 -0800 (PST)
Received: from pve.home (bzq-79-181-180-225.red.bezeqint.net. [79.181.180.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea2253csm17733076f8f.14.2025.12.21.09.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 09:50:55 -0800 (PST)
From: "Noam D. Eliyahu" <noam.d.eliyahu@gmail.com>
To: netdev@vger.kernel.org
Cc: pavan.chebbi@broadcom.com,
	mchan@broadcom.com
Subject: [DISCUSS] tg3 reboot handling on Dell T440 (BCM5720)
Date: Sun, 21 Dec 2025 19:50:50 +0200
Message-Id: <20251221175050.14089-1-noam.d.eliyahu@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

I have not contributed to the Linux kernel before, but after following and learning from the work here for several years, I am now trying to make my first contribution.

I would like to discuss a reboot-related issue I am seeing on a Dell PowerEdge T440 with a BCM5720 NIC. With recent stable kernels (6.17+) and up-to-date Dell firmware, the system hits AER fatal errors during ACPI _PTS. On older kernels (starting around 6.6.2), the behavior is different and appears related to the conditional tg3_power_down flow introduced by commit 9931c9d04f4d.

Below is a short summary of how the driver logic evolved.

### Relevant driver evolution

* **9931c9d04f4d – tg3: power down device only on SYSTEM_POWER_OFF**
  Added to avoid reboot hangs when the NIC was initialized via SNP (PXE):

```
- tg3_power_down(tp);
+ if (system_state == SYSTEM_POWER_OFF)
+     tg3_power_down(tp);
```

* **2ca1c94ce0b6 – tg3: Disable tg3 device on system reboot to avoid triggering AER**
  Addressed a separate issue and partially reverted earlier behavior:

```
+ tg3_reset_task_cancel(tp);
+
  rtnl_lock();
+
  netif_device_detach(dev);

  if (netif_running(dev))
      dev_close(dev);

- if (system_state == SYSTEM_POWER_OFF)
-     tg3_power_down(tp);
+ tg3_power_down(tp);  /* unconditional again */

  rtnl_unlock();
+
+ pci_disable_device(pdev);
```

* **e0efe83ed3252 – tg3: Disable tg3 PCIe AER on system reboot**
  Combined both approaches, resulting in:

  * Conditional tg3_power_down based on SYSTEM_STATE
  * A DMI-based whitelist for AER handling

```
static const struct dmi_system_id tg3_restart_aer_quirk_table[] = {
    {
        .matches = {
            DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
            DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge R440"),
        },
    },
    /* other R-series entries omitted */
    {}
};
```

```
else if (system_state == SYSTEM_RESTART &&
         dmi_first_match(tg3_restart_aer_quirk_table) &&
         pdev->current_state != PCI_D3cold &&
         pdev->current_state != PCI_UNKNOWN) {
    pcie_capability_clear_word(pdev, PCI_EXP_DEVCTL,
                               PCI_EXP_DEVCTL_CERE |
                               PCI_EXP_DEVCTL_NFERE |
                               PCI_EXP_DEVCTL_FERE |
                               PCI_EXP_DEVCTL_URRE);
}
```

On my T440, this combined design is what causes problems. Simply removing the DMI table does not help, since the conditional tg3_power_down logic itself also causes issues on this hardware. Adding “PowerEdge T440” to the DMI list avoids the AER error, but this does not scale well and requires constant maintenance.

I also could not reproduce the original reboot hang that motivated 9931c9d04f4d when running current firmware, even when initializing the NICs via SNP (PXE). This makes it look like the original problem has been resolved in firmware, while the workaround logic now causes trouble on up to date systems.

### Possible ways forward (from cleanest to minimal)

1. **Cleanest (recent firmware only)**
   Remove both the conditional tg3_power_down and the AER disablement, and always call tg3_power_down. This restores the pre-workaround behavior and works reliably on my system.

2. **Flip the conditioning**
   Keep the DMI list, but use it to guard the conditional tg3_power_down instead (only for models where the original issue was observed, e.g. R650xs). Drop the AER handling entirely. This limits risk to known systems while simplifying the flow.

3. **Minimal change**
   Add “T” variants (e.g. T440) to the existing DMI table. This fixes my system but keeps the current complexity and maintenance burden.

I wanted to start with a discussion and a detailed report before sending any patches, to get guidance on what approach makes sense upstream. I can provide logs, kernel versions, and test results if useful. My testing (down to 6.6.1) was done on my own hardware. I could not reproduce either the original SNP reboot hang (9931c9d04f4d) or the AER ACPI _PTS failure (e0efe83ed3252) on current firmware so currently only (2ca1c94ce0b6) seems required, which suggests both issues may now be firmware-resolved.

Thanks for taking the time to read this.

Best regards,
Noam D. Eliyahu


