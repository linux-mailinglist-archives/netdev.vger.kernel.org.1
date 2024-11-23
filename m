Return-Path: <netdev+bounces-146916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 023509D6BD6
	for <lists+netdev@lfdr.de>; Sat, 23 Nov 2024 23:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD1D0281E25
	for <lists+netdev@lfdr.de>; Sat, 23 Nov 2024 22:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01FB19F110;
	Sat, 23 Nov 2024 22:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUzeczc0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3290C19B3ED
	for <netdev@vger.kernel.org>; Sat, 23 Nov 2024 22:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732401313; cv=none; b=cBtbC5pvKWIC+3Q94dSHzEhCxzn68klmaVCaBOV9cB1rvB9mm98kS9Emn/KA4dS1Lx2uCLhEAtDxWkOY+PAd3N7my4nLlWu2SrVw8bdQRmrpiCuZat0xEveWIFW0+DD5odl6Uxy8DEVymfdm0GeVHNXHYNa2nwwpH2H2HR/2/BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732401313; c=relaxed/simple;
	bh=EOfAwo3e0tJmmqNyB1nmL84icEMHvGDY/E/12axuji0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=gn/MC+tzC6kG+KZcmf1/iGyFa7WHDYLTC6f11eIMzkSDw+fSnQnjf8fnqgr2WJRKWP35547Mr63XpJ+BSdinxaJhqzhlrBQDmm/Hw+nJRyIWwe6nGWEHa31LFT1WLyZUC7zGhp48EXytBOu2wxx3SsIvTyjv7N+H1QmzELLaRD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FUzeczc0; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e9c1e7268eso417878a91.1
        for <netdev@vger.kernel.org>; Sat, 23 Nov 2024 14:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732401311; x=1733006111; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yO4KKtxYwmA9aHLmEERtVmL2S4SSMXOTnaTx91q3Ev8=;
        b=FUzeczc0y+3kORDZt9S8m+jFALcBeDp63VZfaA+3XQregDK/mkvXdij/SaYNzu763H
         dRiiuPVmXtqbDDtf0weJgWSZkWZ2777ZRrB31+OdZRH6u/FdmLdaAg0M+u7tBoKF9WrQ
         ZyqqzDIlhY/Q7I/Jbqj27J3eBw1xXnT1UCmx9MIoQ0dh9YWPdJyNlAPTD1OBLcESW1xV
         ayDTkxk0uWfWYgHUrpowKQuxoPz8ozzMRZtb7iCFXSjtJiDMFWH7uHtb8jtTa17I8vgB
         5uNYZ9GlZhdRleP5gLIfaMmWw1X6ehWKPkXCH0Dc92j4mZSlam8F5gNz1CfrMnMgwWqr
         EwGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732401311; x=1733006111;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yO4KKtxYwmA9aHLmEERtVmL2S4SSMXOTnaTx91q3Ev8=;
        b=Vi68pwL1q5Di13Yul6lZ8zod01RIIWmaOcAgw3KC7G0aYJdj/YZsrysPcD2cHbOEgE
         TsmOuBnckyJ1ehHGL22PSDo5b7S3n2xdszbihiDHy7ITvYlO2+jsq+v4nLE9jLK4e8VM
         aopT99tH7eTTyI0mU60XV4Rl5cnLWiNoZ69oQflZICQpR0IlBRlQFXwXh1rsylmk3P/X
         kehtavM8SXlu0CHO3QtubnF/9vzd7MRYjqQOYHUjr9qDGOdaU99o/OuhdSm+JdE5s2T5
         mVxHm0BEMuCJpYHLVSVcwZkxLPChI+VQxemgh+Bv9h5MOFwZkyF7tkmG3zVPj5tFegV3
         GsLQ==
X-Gm-Message-State: AOJu0Yz5LjizHOoNrZx9xES51cM44wNsZqHfuBZZ6cuTagBVGAbVue+g
	prgWd/0XbwWmyLdrGnNfbFojrahme8DOFoR8QzJx/ErLoWuVInW4fRjYOwj2tWCwnVyUOti4AJs
	nhSIOb5J1o9jMcnXxmyD09VpjU11h8j3NZiU=
X-Gm-Gg: ASbGncvO5ClTNze0IpS58yHFk2HXYpckXEbRVUQQM7qV1aj/txATQcuJyD+47Wl+uha
	ZMa2JMh72dEArLMHM5Lfirw7TUTyDALA=
X-Google-Smtp-Source: AGHT+IEIcmZKCz1hdXZ9uit9OSgAzzWGm0X6qasst2IjmgzUd7V0bcR2pCuuakY/KcnFIYQF5WVg91Ig3BDawEW8KBs=
X-Received: by 2002:a17:90b:1a8b:b0:2ea:3ab5:cb83 with SMTP id
 98e67ed59e1d1-2eb0e88cb0dmr3971397a91.9.1732401310834; Sat, 23 Nov 2024
 14:35:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Connor Abbott <cwabbott0@gmail.com>
Date: Sat, 23 Nov 2024 17:35:00 -0500
Message-ID: <CACu1E7GJttr8EDjLxYMBkfkKSK2=ZS7hb4bsYAhqO00bt07QtQ@mail.gmail.com>
Subject: RTL8125D intermittent disconnects
To: netdev@vger.kernel.org
Cc: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com
Content-Type: text/plain; charset="UTF-8"

Hello,

I recently bought a motherboard with a builtin RTL8125D Ethernet chip
(XID 688). I updated linux-firmware to get
/lib/firmware/rtl_nic/rtl8125d-1.fw and tried out the patches enabling
it, and while it mostly works the link intermittently disconnects and
reconnects. It seems to be caused by high bandwidth, since doing a
speed test in the browser seems to be a reliable trigger. There's
nothing interesting in dmesg other than "r8169 0000:06:00.0 enp6s0:
Link is Down":

[   36.133656] r8169 0000:06:00.0 enp6s0: Link is Up - 100Mbps/Full -
flow control rx/tx
[   36.476108] r8169 0000:06:00.0 enp6s0: Link is Down
[   48.507244] r8169 0000:06:00.0 enp6s0: Link is Up - 100Mbps/Full -
flow control rx/tx
[   48.821220] r8169 0000:06:00.0 enp6s0: Link is Down
[   60.947170] r8169 0000:06:00.0 enp6s0: Link is Up - 100Mbps/Full -
flow control rx/tx
...

These are the messages at boot:

[    9.512877] r8169 0000:06:00.0 eth0: RTL8125D, cc:28:aa:a7:bd:85,
XID 688, IRQ 100
[    9.512880] r8169 0000:06:00.0 eth0: jumbo features [frames: 9194
bytes, tx checksumming: ko]
[    9.534565] r8169 0000:06:00.0 enp6s0: renamed from eth0
[   10.716346] Realtek Internal NBASE-T PHY r8169-0-600:00: attached
PHY driver (mii_bus:phy_addr=r8169-0-600:00, irq=MAC)

I tried this both on a branch based on 6.11 with enablement patches
and some dependent patches backported, and on recent (today)
netdev/main. This doesn't happen with a USB ethernet dongle I have
laying around, so I don't think it's due to the network or something
else in the stack. Is there anything I can do to help debug?

Best regards,

Connor Abbott

