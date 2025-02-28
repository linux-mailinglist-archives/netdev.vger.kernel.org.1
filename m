Return-Path: <netdev+bounces-170867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 157A6A4A566
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 22:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2547D17093D
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 21:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC131DDA36;
	Fri, 28 Feb 2025 21:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATVixQhy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5E61D9A50
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 21:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740779505; cv=none; b=pZFV7k3loMBaiMQy7JN3gFzpQXSzF9+9My3iJQMzYl4NWvmfx0SOJ76XCSkYLYMifjB6+FbGvbqASR98xjsbibbchMDwexYPGq+X4IdinZyVIZ9jTji4R6pHP1uNzV2T0nT4kjvEAyz+sDhHgzXCFSoFdrNTCOeJCMO0j9fhwQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740779505; c=relaxed/simple;
	bh=rDpXr3LWdZ9ywdc21pF8v9KnrIrY/QQe6LJjl4LkXoM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=NxAtpzLJKhAYEytnXfIsrBdrxiVfyv7cMUO/goTP3uWb1EOc1vhLQFhNYi5O7hN4s1R/VvJbgA+Of6cr6Ol1AJ3+mzSBXvbIhsbv2TiufG9DFg0SRVEbryeeKllWkdRth5gqq+Bx1C0uVO8ZcuzXGAmEzPogCKY7NBP7jd7qnY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ATVixQhy; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-52096b4e163so1150323e0c.1
        for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 13:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740779503; x=1741384303; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rDpXr3LWdZ9ywdc21pF8v9KnrIrY/QQe6LJjl4LkXoM=;
        b=ATVixQhyOOp8VCMUM15RX/DcNMCjcb2YymbWMaCFGcucYsj8xt1xAz1HT5bTw4MId2
         j6OVY9zyne+OBDk8lJttZk0WjsJhWR2B5NMpKu1Nb1hv5zdtaXO3wna23UNu7dZpFlN2
         QiRYnQ1jVMfIUCzAHIA5nZwPw+DsoDC74aIvtqJ2qvySp7ilpvV33OIL6wS3Sb7M1Xx2
         ya/4Emb3EjzUhazhTfU9ZujcJhBsP6GwKIWRRAYN7HQy79lVpu3LuyD1uvnsssQwhLBN
         Dyxn5uu7o4K5l1+8VCn5ZTbGeHEEBcu3qm3awpNTjnbRq8chHGQLuHWByzYJmB/cjSbq
         aypA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740779503; x=1741384303;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rDpXr3LWdZ9ywdc21pF8v9KnrIrY/QQe6LJjl4LkXoM=;
        b=S8rgea7JiD2LGfzibq20HKSiggrXUE1ZmJVuiC44InK3zUTMpz2brdCO70AxjeTOQV
         PVI/WFHoN37rMdRLTwK3NAjpb7OiCdLQKLvQ9N0LMru2FCRhLJn6HvsbDHk/gPsjMf7a
         +fCiF+vJfbj1IgswBdEHXBNLXHaYqExA1OJiRrz+1LYvYasUyvYm4hoRGCP1bEm9G8+J
         /cEL4uFH+GeRsPgEHGHjo7rkiSjH6hT7RKrbOmhToBGqjjTpui7lLMVV00v9Iz1cDPKN
         v8XlzpYj/PZdNcixoHbiuqP8Zynlr12yH2cgCUtfRjBSgFddymJkP9mTqAre+nwKZHbb
         IcKg==
X-Gm-Message-State: AOJu0YwG9LQC/jlePgHnJbk158W3WO2l6GPpovVEq9B5kxoebdpynsQF
	G9AOhtmeAlljXeKuAxU77D0DYmYxLhdekhJXqyohsSGneMXDgo4ppLGDWjULXFmpu0GhuPlIWIC
	/SnJ8yxO0qgpMLpsebMdOhaUdhIt9SwpG1zc=
X-Gm-Gg: ASbGnctHT3dVMfB33xuQwhFB3hTpVriz8RdXQkfvfs0BZc8pR8GJ+OiFv8XuVr2rg4a
	lal4UqEy06K6NEdjxONYKG2wdFKnb8E3K6pCjZ94JuOn6Cx2yrsVETHfWsAPKnh7KAF9vZPAcB+
	kjq6pIWAX6i3PFPpNkZW2vzILURKI+LIdac2VZfFI=
X-Google-Smtp-Source: AGHT+IFCqrPEPTSu7TssO7W9mXeuA0IvFpO9Xq/OV2gqd9h26O17iD1B8d7CR4dRYjiJyH50mrIErD7ekP+9rzhbLJ4=
X-Received: by 2002:a05:6122:4f96:b0:520:51a4:b84f with SMTP id
 71dfb90a1353d-5235b747640mr4401131e0c.4.1740779502921; Fri, 28 Feb 2025
 13:51:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Fri, 28 Feb 2025 21:51:15 +0000
X-Gm-Features: AQ5f1Jpi4BUP-VGiX-sio213C5xB42fEf44grsR2roywF652JSvb8CddDj-SGnY
Message-ID: <CA+V-a8u04AskomiOqBKLkTzq3uJnFas6sitF6wbNi=md6DtZbw@mail.gmail.com>
Subject: [QUERY] : STMMAC Clocks
To: Russell King <linux@armlinux.org.uk>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, Jose Abreu <joabreu@synopsys.com>
Cc: netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi All,

I am bit confused related clocks naming in with respect to STMMAC driver,

We have the below clocks in the binding doc:
- stmmaceth
- pclk
- ptp_ref

But there isn't any description for this. Based on this patch [0]
which isn't in mainline we have,
- stmmaceth - system clock
- pclk - CSR clock
- ptp_ref - PTP reference clock.

[0] https://patches.linaro.org/project/netdev/patch/20210208135609.7685-23-Sergey.Semin@baikalelectronics.ru/

Can somebody please clarify on the above as I am planning to add a
platform which supports the below clocks:
- CSR clock
- AXI system clock
- Tx & Tx-180
- Rx & Rx-180

Cheers,
Prabhakar

