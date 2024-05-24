Return-Path: <netdev+bounces-97976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 607B28CE6A7
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 16:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 837E31C20D9E
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 14:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D3612C468;
	Fri, 24 May 2024 14:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ferroamp-se.20230601.gappssmtp.com header.i=@ferroamp-se.20230601.gappssmtp.com header.b="odr2+K57"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3118638DC8
	for <netdev@vger.kernel.org>; Fri, 24 May 2024 14:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716559699; cv=none; b=mgJuaBvpACeAknDBazR3VAGwUW1TFq+IKLVH3vsQEId0awIcyrASenEA+uTYTRUX3CGm6kjytGXnjg0CcAUCNYxVjg9MBz6FYhoEkhAN2zaXv3zSaoJ63Erg0VBG4eHM+6+P1Ub3AY5QqKt1/ly8qOgFANgQsYrg9FkfP1YXZME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716559699; c=relaxed/simple;
	bh=KmSHqkLEACdJA5JkR30IvcQRznw1fQacuNaMNWW7CGo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qfm8FkaxU7RP8GPUHgfauRMH2WrEreIJOgpR8RX9yB4crogSpMRkuho4msksmgayc2ZCj1HPdxDVRBDGQwAe1otZ3JzNCqKKByLbGuGoosSrvDTM0cUHAdCB6FTAQTqouAbgZGe0lyqLQtkvE2aa+wATzBDuagyZtyUTLlUz0wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ferroamp.se; spf=fail smtp.mailfrom=ferroamp.se; dkim=pass (2048-bit key) header.d=ferroamp-se.20230601.gappssmtp.com header.i=@ferroamp-se.20230601.gappssmtp.com header.b=odr2+K57; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ferroamp.se
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=ferroamp.se
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52962423ed8so993709e87.2
        for <netdev@vger.kernel.org>; Fri, 24 May 2024 07:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ferroamp-se.20230601.gappssmtp.com; s=20230601; t=1716559695; x=1717164495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Uw+x2I02cfRHY66/tRD0BbH08xb2ysdRK1VqCkSSMhk=;
        b=odr2+K5794KfAlnHQfv3jmJprvLU5Ldl2F9XkrNTBKpUXH1kX/S1IYvICFpuvUc5ww
         qNF0hJXVdV+DArSgY0DJK17bMPzkjZxqP0TR0k3Vgi4RnQ8KC/47trDn3HlTv9DOfWDR
         WK70Yd1chGEX6XoS+5jxleiE2Nn3r0pW+ry/HHHkdsG8wqtkmtNaqnkHkWadvTGFLrq+
         6xqruHT/1h3nA6pB70+34tV/LrxaPImm5+k2PFUSujN3gA9TghcDB34thG5tiWM2+3l/
         ugawdQLHMBUYSpf+emCoSuocm0nSgI6lNwUZo7DwrxjSQSnc//YV4Y9xF8cxcrCAjwyi
         ed6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716559695; x=1717164495;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uw+x2I02cfRHY66/tRD0BbH08xb2ysdRK1VqCkSSMhk=;
        b=bhNfRNsTOAS53zD6O3wiXfOhKtuAAKGd7j6+rKZ5OP/BpKH4xNCzfKeDqxTakWqzyY
         OTR/yh54EB+Qo+8IfRWvY1r0IhlzoheIKuza11oY6BoJo2OEFm/INqxr3uo9BjukHp/A
         enea1W80qepS9wN0ZpDfuGbI66lG9a090eRmjoLR16bbs4lhPc7aC+C9pwVIxwSHe6c6
         DbKYYIdD8VdAn0ZiQ0H4FH8yltjAxFK/uLleouZ3LEzyX/MGaNEKsZ4qzDZY6pH+OCDd
         +5p0YAND2cIIJP6q6j4yPmR4kWBGqxt9WZ705Aj7Y0jmOrVY0hoBrkSsUy6CwiiM3/d3
         f00g==
X-Forwarded-Encrypted: i=1; AJvYcCXVtcPUPePKysI1l19PDdIz3GD4XXhIf9VznrFVl9ZPRnI1E+KFmqm+bzKoFbu7jG3kY8N8/PBtVTciZhLRTaiiPw6G4HtG
X-Gm-Message-State: AOJu0Ywjc2fzXVb7aXupkRm+Tx/8LD201GKtpQNgRLZOGObgPbN/iG3l
	FaaKHT5MKhET77fQfo7iIJMvkV1xXjAleYNgC7hjlmOxengyRBuW0+nnIyJ07p2IRulQb0HYZkr
	B
X-Google-Smtp-Source: AGHT+IHikd5bcFxVugcTWkXTYj6tWsPERSNIKCxhLOzj5DEmZPLVfbyUeeIG0OEv6qkAYQxT9EkvLg==
X-Received: by 2002:a05:6512:238d:b0:51e:7fa6:d59f with SMTP id 2adb3069b0e04-52966bb200fmr2244010e87.53.1716559695152;
        Fri, 24 May 2024 07:08:15 -0700 (PDT)
Received: from localhost.localdomain ([185.117.107.42])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-5296ee4a9cfsm185474e87.75.2024.05.24.07.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 07:08:14 -0700 (PDT)
From: =?UTF-8?q?Ram=C3=B3n=20Nordin=20Rodriguez?= <ramon.nordin.rodriguez@ferroamp.se>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: parthiban.veerasooran@microchip.com,
	=?UTF-8?q?Ram=C3=B3n=20Nordin=20Rodriguez?= <ramon.nordin.rodriguez@ferroamp.se>
Subject: [PATCH net 0/1] phy: microchip_t1s: lan865x rev.b1 support
Date: Fri, 24 May 2024 16:07:05 +0200
Message-ID: <20240524140706.359537-1-ramon.nordin.rodriguez@ferroamp.se>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,
Let me first prepend this submission with 4 points:

* this is not in a merge-ready state
* some code has been copied from the ongoing oa_tc6 work by Parthiban
* this has to interop with code not yet merged (oa_tc6)
* Microchip is looking into if rev.b0 can use the rev.b1 init procedure

The ongoing work by Parthiban Veerasooran is probably gonna get at least
one more revision
(https://lore.kernel.org/netdev/20240418125648.372526-1-Parthiban.Veerasooran@microchip.com/)

I'm publishing this early as it could benefit some of the discussions in
the oa_tc6 threads, as well as giving other devs the possibility
massaging things to a state where they can use the rev.b1 chip (rev.b0
is eol).
And I need feedback on how to wrap this up.

Far as I can tell the phy-driver cannot access some of the regs necessary
for probing the hardware and performing the init/fixup without going
over the spi interface.
The MMDCTRL register (used with indirect access) can address

* PMA - mms 3
* PCS - mms 2
* Vendor specific / PLCA - mms 4

This driver needs to access mms (memory map seleector)
* mac registers - mms 1,
* vendor specific / PLCA - mms 4
* vencor specific - mms 10

Far as I can tell, mms 1 and 10 are only accessible via spi. In the
oa_tc6 patches this is enabled by the oa_tc6 framework by populating the
mdiobus->read/write_c45 funcs.

In order to access any mms I needed I added the following change in the
oa_tc6.c module

static int oa_tc6_get_phy_c45_mms(int devnum)
 {
+       if(devnum & BIT(31))
+               return devnum & GENMASK(30, 0);

Which corresponds to the 'mms | BIT(31)' snippets in this commit, this
is really not how things should be handled, and I need input on how to
proceed here.

Here we get into a weird spot, this driver will need changes in the
oa_tc6 submission, but it's weird to submit support for yet another phy
with that patchset (in my opinion).

This has been tested with a lan8650 rev.b1 chip on one end and a lan8670
usb eval board on the other end. Performance is rather lacking, the
rev.b0 reaches close to the 10Mbit/s limit, but b.1 only gets about
~4Mbit/s, with the same results when PLCA enabled or disabled.

I suggest that this patch is left to brew until the oa_tc6 changes are
accepted, at which time this is fixed up.

Ramón Nordin Rodriguez (1):
  net: phy: microchip_t1s: enable lan865x revb1

 drivers/net/phy/microchip_t1s.c | 189 ++++++++++++++++++++++++++++----
 1 file changed, 166 insertions(+), 23 deletions(-)

-- 
2.43.0


