Return-Path: <netdev+bounces-246025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBC9CDCE68
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 17:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBF753023784
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 16:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7C230C616;
	Wed, 24 Dec 2025 16:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mh4ysnGZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C82327205
	for <netdev@vger.kernel.org>; Wed, 24 Dec 2025 16:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766595187; cv=none; b=g4umfzVt4Io8ZBBKcNvhmlkLWIuDZlPsdGgu2FuYakqNPn1Y/X7ZRi1+Ke++JrQ/2yx5DsSfcUsIu+CYWAYo4nrM+sy1bxgYszAMVsmWfpwZUBLqjt+FOfE4c/gt7iz3qurwvf80dI7u1fLaGQ8IGZlw5bfXvRA8UCkvCHRONEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766595187; c=relaxed/simple;
	bh=Zlyiz29ztFkTY3fwzYZbKNetxy6G4O9TFMXn8qeIViY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bK9L8uRYrM/i3vbIy/s9Y7U2wyxnfwEqfMmLTsSTGF5+Geo3AjE0Pns1sH1kBtREhi9ui7Xg0LY5wLUWX3g6Z/Kl+1HNF4mNiclbsxzS+xrNh0t9FvxzF9GyVNMi0qgBDSR8BzEV4d9kEDyMKI88kb5g+NNODBWdwtKjQpTD5t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mh4ysnGZ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47795f6f5c0so33761765e9.1
        for <netdev@vger.kernel.org>; Wed, 24 Dec 2025 08:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766595184; x=1767199984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4RZ2hsPcgIKGhVb38CaAYiaLlx/2d9pEX5qXtrrGncM=;
        b=Mh4ysnGZZc0Y6dvrOLJw0hCxuT3sd6022dkPvY1oxTPNVUVxGVBLE+2FvRMAAEIlLT
         LwTSxM5Hq76xWi7ZIl/29vHgkGHTxBh11QSdWewNA4IIhs7lCpAGXJb+/x9YkVADqJF/
         1lC0/pcw7czvVYRtb0vFzhRCZOQabOYxwRGcdhEHJbtIcZIK7d5rx8DCIafrahLSi52K
         O2qqQvViWKUdmpxEPlLFSPwKm8KCMiTs6SnnZa383r9Sg2AGxV7T+psZ4nyERd+e8eEs
         LxykfUznJ2ejDP64EiK8z3ruV/8EKOy+xB2YDJfse7rE7D8xdtNU/rAv83GAPjOljH9U
         2tBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766595184; x=1767199984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4RZ2hsPcgIKGhVb38CaAYiaLlx/2d9pEX5qXtrrGncM=;
        b=ObpuhhkzRquEV0Fg8igInFnsRJZko1GcJIXhzLMnHmuJ/KQTVMaMM+pS8wkjF7jD3G
         RwJGp2pv0n/rstj/PkxwIn6YFQvCg1uiuGjuHuSpiMQF6TfXdoK9DJcukmQSK6dubby/
         drDfwM4yjEV1yFUojT3bd3xhk8U3LlHjuguGNmMkouQjHgfPw9gAuOQt6thC8YO7dX1X
         vwJmzcWwLYHNFMHrkSJRihOZpwTp1kn7OfRRak/Jsd27plGw6ZjLRy8oBQ2gKRH5Dx4D
         tOxL387O1suzMbcjtinyMSstQSiqTW3R+RO1ZBcJz57BpaLwlDjf/yqmPwps5mILj7eP
         M7oA==
X-Forwarded-Encrypted: i=1; AJvYcCUS+Bk6mG8ScBdLZJHsrQKW9HAesi0q4dB4PB7RV/r+bSYOsk+rDqqcfv21iU9g4zhBZEYk06s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjuBycIeaKWTEv7XTfiGpq4hVUbM6ePB8iXYYeKT/OAjIiEFQp
	Rn8vzH/bpL0Nmd83HwE4MnZiF3zGv6Xsk3GU02v8p9iq7aAelX9ZCjkK
X-Gm-Gg: AY/fxX6hkBz0uzB5f0h1p18mfCp5kyNpYxAUJlHFFe8iNatEiXWyW/DAnyiK6bVE9S8
	zNSQ8bvcAiHwvxaegUOu90It2tuC91wrShU3Y4DK0jbpFylnc9oqkgVB4VQR6GrVBmjRFyWsjto
	PwjGqnpwhvZLAlCCMfWIaHuM4kD0MrJx4hsfZNj2usqri5bsDGB0aXYjqlt97u2h5l8Mj7OA2kd
	ZXAvMUtcQLoZBn4IZTruGfM/pdSsSIWiqBp+ansygESDLSOXFvOfLsL0DnOAmNEUbl2TQdy7MEP
	BE7M32cCfbmN4xO0peXDNmNlzFZIAZHiCt5vM1kFcCpUEnieZBBYsSUkyuWYmgYZMZwegHYcONN
	WkqcYFSpa2JJ8RvPC6FuPvs7WiRz7Xan/ZScOFQtlFGTsmSehqpkacY5UR1Tb7N1AGsH0r+9FiE
	M26JM3MDyDw8Dt2K9dQhBqgrrKCTTNL/kyEFnG7mNQwdeVKm0o9w==
X-Google-Smtp-Source: AGHT+IGW8GWXhUmn+dTMjfkTURqaoZblmSnMmGvjVbuG4EIUwwWZvmN6nxDOvQshezdHBAUjXoy2lw==
X-Received: by 2002:a05:600c:83c8:b0:477:7b9a:bb0a with SMTP id 5b1f17b1804b1-47d404f8adfmr18948755e9.21.1766595183979;
        Wed, 24 Dec 2025 08:53:03 -0800 (PST)
Received: from pve.home (bzq-79-181-178-61.red.bezeqint.net. [79.181.178.61])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d1936d220sm327075195e9.8.2025.12.24.08.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 08:53:03 -0800 (PST)
From: "Noam D. Eliyahu" <noam.d.eliyahu@gmail.com>
To: pavan.chebbi@broadcom.com
Cc: mchan@broadcom.com,
	netdev@vger.kernel.org
Subject: Re: [DISCUSS] tg3 reboot handling on Dell T440 (BCM5720)
Date: Wed, 24 Dec 2025 18:53:01 +0200
Message-Id: <20251224165301.2794-1-noam.d.eliyahu@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <CALs4sv0EYR=bMSW6pF6W=W_mZHhQBpkeg=ugwTtpBc7_FyPDug@mail.gmail.com>
References: <CALs4sv0EYR=bMSW6pF6W=W_mZHhQBpkeg=ugwTtpBc7_FyPDug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Thanks for the quick reply!

On Mon, Dec 22, 2025 at 11:23 AM Pavan Chebbi <pavan.chebbi@broadcom.com> wrote:
>
> On Sun, Dec 21, 2025 at 11:20 PM Noam D. Eliyahu
> <noam.d.eliyahu@gmail.com> wrote:
> >
> > ### Relevant driver evolution
> >
> > * **9931c9d04f4d – tg3: power down device only on SYSTEM_POWER_OFF**
>
> I think this commit id is wrong. Anyway, I know the commit.

My apologies, I likely copied a local hash; the upstream commit ID is 9fc3bc764334.

> This is going to be a problem, please follow the discussion here:
> https://lore.kernel.org/netdev/CALs4sv1-6mgQ2JfF9MYiRADxumJD7m7OGWhCB5aWj1tGP0OPJg@mail.gmail.com/
> where regression risk is flagged and it came true in
> https://lore.kernel.org/netdev/CALs4sv2_JZd5K-ZgBkjL=QpXVEXnoJrjuqwwKg0+jo2-4taHJw@mail.gmail.com/

Thank you for the links.
I understand the need to prevent regressions, especially in an area where it happened before.
That said, I still think the design of the first and second fixes is problematic and needs adjusting.

The original bug (Fixed in: 9fc3bc764334) was triggered by SNP initialization on specific models (R650xs with BCM5720).
The fix, the conditional tg3_power_down call, *was applied globally regardless of models*.

The second bug I mentioned (Fixed in: e0efe83ed3252) was triggered mainly due to the conditional tg3_power_down call.
Look again at the changes made in the commit referenced by e0efe83ed3252 (2ca1c94ce0b6 as the original fix):
```
+	tg3_reset_task_cancel(tp);
+
 	rtnl_lock();
+
 	netif_device_detach(dev);
 
 	if (netif_running(dev))
 		dev_close(dev);
 
-	if (system_state == SYSTEM_POWER_OFF)
-		tg3_power_down(tp);
+	tg3_power_down(tp); /* NOTE: the conditional system state based tg3_power_down call was problematic */
 
 	rtnl_unlock();
+
+	pci_disable_device(pdev);
 }
```

The changes in 2ca1c94ce0b6 caused the regression which later led to the AER disablement in e0efe83ed3252.
The problem is that it was decided to apply the change to a specific set of models, even though it originated from 9fc3bc764334 which was applied globally.

If we apply the conditional tg3_power_down specifically for the R650xs, we can guarantee no regression, as the logic for the models with the first bug stays the same, just now limited to their set of models.
By applying the conditional tg3_power_down this way, we won't need the AER disablement at all.

> >
> > 2. **Flip the conditioning**
> >    Keep the DMI list, but use it to guard the conditional tg3_power_down instead (only for models where the original issue was observed, e.g. R650xs). Drop the AER handling entirely. This limits risk to known systems while simplifying the flow.

> But I am not sure how systems affected in the commit e0efe83ed3252 will react. Can't tell 100pc without testing.

Regarding your concern about systems affected in e0efe83ed3252: my hardware (Dell PowerEdge T440) is one of the models affected in e0efe83ed3252 but not listed in the initial DMI match list.
I tested all of the solutions I suggested, others have reported the same regarding my first suggestion (to remove both the conditional tg3_power_down and the AER disablement) online, and most importantly, the e0efe83ed3252 commit itself references the original fix (2ca1c94ce0b6) which didn't include a specific set of models and was considered a viable fix.

If we restrict the system_state check (from 9fc3bc764334) to a DMI table for the R650xs, all other systems would revert to the 'unconditional' tg3_power_down which was the standard for years. This would naturally prevent the AER errors (as I and others had seen on our machines) without needing to touch the AER registers at all.

For reference:
- https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=e0efe83ed3252
- https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=2ca1c94ce0b6
- https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=9fc3bc764334

Best regards,
Noam D. Eliyahu

