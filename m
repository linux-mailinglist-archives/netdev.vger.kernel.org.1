Return-Path: <netdev+bounces-217026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9855CB371DA
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 19:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC04E189A1A1
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 18:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5937C3AC22;
	Tue, 26 Aug 2025 17:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFbhGPl7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD261246BC6
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 17:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756231185; cv=none; b=KLiea/plZy6E6IzPeUfYWbWMSyFJ3V9t7KLXwyHsPZ7Dk0v4Nns4eJiaFs8U9XMuDrOnz0RJUkDeVP3P2V+vPV5QSop97AB5wEDV9cwfZ6MvtbnwRcxBVDfb0rBR46uaY7kJlM2ukpBlsV5JfPNZOkCObnqk1oB0QdaWppEzh/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756231185; c=relaxed/simple;
	bh=tWfIFnPcp2w4ONzh4iNhvuuWICiytEpahl2SIOqtyUM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Q6wgO4PnlLIScwe4iO8rTwZzAjo/OQoQ25S9K+O1jf3rM8NG1xgLDgSImYl3bZ/EQ8sitCoppQk76bi2C2ffE7B/P0OfE9UBehMJ9cvygwix7SimENYWTwOHFACIvPO3b/Kte9F3PvUwgMT5kbCxobUubToNeJ+5ipB4uweTnPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PFbhGPl7; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-71d60157747so45871917b3.0
        for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 10:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756231182; x=1756835982; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=S0R7Mq0PVbv9BmuH9B9T+QnnHy+OYcD10epCgiUvuXc=;
        b=PFbhGPl7/5QGh8/dCnglp6rq5VipqRB/i/B3yC5mGQ3TQOgJGBL4QDfbxdpKOYjox4
         92TB1YWtC9mSs+IqPuaQjDdMlZ5jins38midqU7GMZxbZ6o1PNg3flKJjbytD3uNe8vE
         h61BdJJLqrz8TQRv4JrDp8O/9dXPuw7EebqSSYCxgQKTL7BLZG1D3+7zTTutgZzGP2ij
         vEWjQhAZKPuCFR3cFvGOgqimEHNlnOJ/DLmWCOkmUhaSFvInx/1uW/XxoLK9ixZowakI
         ogXx8+GyHslsFs6y+H42K2++vViSHLf0oI2bSZBjnRdERqUfYt9DaYFiwkH8ZJh0cHzN
         wyOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756231182; x=1756835982;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S0R7Mq0PVbv9BmuH9B9T+QnnHy+OYcD10epCgiUvuXc=;
        b=O9hstKyuZ7x947zsKPzK2KNjhKI/afsvKoNBAdxiBs9rpRpJlnkMP0SHzuFfSRrxXb
         8a2+EUXttLMbGkBPsRj4K95JYvwX23uXMghIHtXwcsHeEKyNEyOdEwGqZcBz8o9ekyev
         lrFC3/aWosI7K8Ng/5DHucV595OIZTY5j2exWxb7JPE9qO4NvjdSjQYZsKb1bP9LPR48
         0L2Y6phCVmutu8U14tvYlaxY+ItTjmF1xMJpu3BtbE/RwpOEPMjbJYfIzrVTa2/L5tCe
         akmgepO7EIKkteoqHQ9LDvwl1Ny/Wt2nZFXOYzWTbzmNiuFPiddIK4y46i20PE/9g5kk
         +w+g==
X-Gm-Message-State: AOJu0Yx64LPhAZ4xCEhwnc9FN4gf4XaUU+SX9tMxLEhwpyvm7smhc958
	K/rOpOAvqyqdrjzGR2S+lS0klunigsjH/kvEd3INL2py+ghjG7uTojTM3q7+R9ilZN+27f81QCT
	WZoMPHj1hqp+5dSiJDqzynTB8PXxYy6Vh6yBkyYkxUA==
X-Gm-Gg: ASbGnctVAJ25c63T50g9aza+FwFhrtDsniGAcAWdTRAgWBlY/kwoJavPm25FM+1mC0P
	fGyQfXkT9ysrH0tYsYY6YmY0BLu2Z4CL44hdLnf509Cd/Jb9N0OhED/MfxYR8YwTyWuO/d07Fnz
	0r7zaD7x7GI3G5DaJhovDK7nA2EyAC7xNrkoJ5eDG3ej3+Z0YkBwEdHhgoF+uIGC78Nii79a4sh
	E52vQ==
X-Google-Smtp-Source: AGHT+IEfoX8SxShODlnLSXhETaYxxlQxLkzaKC8aK51ShdRx0T8FczoxngiE0sPNnu5j0hadX012TVMyYmKNQdH7Hsc=
X-Received: by 2002:a05:690c:a87:b0:720:378:bed6 with SMTP id
 00721157ae682-7200378d942mr136564747b3.41.1756231182321; Tue, 26 Aug 2025
 10:59:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Luis Alberto <albersc2@gmail.com>
Date: Tue, 26 Aug 2025 19:59:29 +0200
X-Gm-Features: Ac12FXyf54L74Q68wUXw0mdmVb3jE_2eDE7tgg4p2kbqmww65DARgwWXUHmgwFs
Message-ID: <CAF4aUuukN6wde=NrLcPfZPkLiudUYjSvb5NvoY55EhP3ssLx4Q@mail.gmail.com>
Subject: [BUG] Network regression on Linux 6.16.1 -> 6.16.2 (persists in
 6.16.3): intermittent IPv4 traffic on Wi-Fi and Ethernet
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi everyone, I=E2=80=99m new to this mailing list.

I am reporting a network regression observed on my system when
upgrading from Linux kernel 6.16.1 to 6.16.2 (and persisting in
6.16.3). The issue affects both Wi-Fi and Ethernet interfaces and
seems to originate in the kernel networking stack rather than any
specific driver.

For reference, I initially reported this issue on Bugzilla, ID 220484,
thinking it was exclusively a Wi-Fi problem.
Subsequent testing with a wired Ethernet connection confirmed that the
issue affects both interfaces.

System / hardware information:
- Motherboard: Asus TUF GAMING B460M-PLUS (WI-FI)
- CPU: Intel i5-10400
- 16GB RAM
- GPU: NVIDIA 4060 (proprietary open module drivers installed v580)
- Wi-Fi: Intel AX200, driver: iwlwifi + mac80211
- Ethernet: Intel I219-V, driver: e1000e
- Connections use IPv4

Kernel versions tested:
  6.15.7, 6.15.8 and 6.16.1 (works fine)
  6.16.2 and 6.16.3 (regression present)
  LTS 6.12.43 from Aug 20 (regression present)

Symptoms:
- Internet connectivity is intermittent: when opening multiple
websites simultaneously (e.g., 10 pages), roughly 1/4 fail to load.
- Failed pages either remain completely blank with a connection error
or load partially; both situations occur frequently.
- The issue also occurs occasionally with a single webpage, or when
downloading system updates, not limited to the browser.
- Occurs on both Wi-Fi and wired Ethernet.
- No connection drops; the interface remains "up".
- Tested in more than one distro: EndeavourOS and Nobara, vanilla installat=
ions.
- Ping comparison:
  6.16.2+: Running ping google.com while opening 10 webpages
successively results in >10% packet loss and several pages failing to
load.
  6.16.1: 0% packet loss and all pages load correctly on first
attempt, consistently.

Actions taken:
- Opened a Bugzilla report, ID 220484, including dmesg, journal, and
tcpdump logs.
- Tested with both Wi-Fi and Ethernet; issue persists on both.
- Verified IPv4 usage; IPv6 is link-local only.
- Tested repeatedly on kernel 6.16.1 and earlier: everything works perfectl=
y.

Reproduction steps:
1. Boot kernel 6.16.2 or 6.16.3
2. Connect via Wi-Fi or Ethernet
3. Attempt to load multiple websites
4. Observe inconsistent traffic and intermittent failures

Any help is much appreciated.

Could anyone advise which commits between 6.16.1 and 6.16.2 might have
introduced this behavior, or suggest any testing and further steps?

Thank you very much.

Best regards,
Luis Alberto

