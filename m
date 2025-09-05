Return-Path: <netdev+bounces-220201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A23B44B94
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 04:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6E4D487099
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 02:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C008520B1F5;
	Fri,  5 Sep 2025 02:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="irt9XxFF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-106103.protonmail.ch (mail-106103.protonmail.ch [79.135.106.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E8A1FECB0
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 02:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757038867; cv=none; b=DBdHzsxsMTLOUWoDXSzyImIAD3IPcd9umyI33vNPmH+pJVX7g9kbk6Debxn/oGtuFKH8Bie1r35FTEn142mk+aNfLJsSzD1qw1rCia18RvN871gRFgoY3DQPhbsw4DZzr4qFZvcYBwyv9YN9ogCEXHt3gAXnveg0eXKXUkKvgk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757038867; c=relaxed/simple;
	bh=dNlvqJpLT0tt4Xb3yht/THJRTNEhTx28a/97adw00xc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V7Y9iH9NSQ16Kw0DGC3kBjXMG8ElaE8cdXcH0hmWF+iebgXQM8IV8eQZajxWBK2GPX25MU9hXqXmQ+BSRf4/jLj/cXq0AFuYV2UgMZCG1B3dUAZYLMcijFH9WjZZctqrDRp4stvNEPWgGZWTEX+y5Uo/fTa1EkJ1lI6BWVkOBn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=irt9XxFF; arc=none smtp.client-ip=79.135.106.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1757038856; x=1757298056;
	bh=dNlvqJpLT0tt4Xb3yht/THJRTNEhTx28a/97adw00xc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=irt9XxFF4OT4GwUlKTB3NlL77QvLX6JZvhkGQoJbcmwzA7c1TsCIcTeuO43NrgObz
	 KUglmfl2DzY0J7v263OhCnryI57sfngOIQhhMCv2b6ITycxVtYkCPP5DSRZPn9TOp2
	 fARJTv4fvb64dVBsiu5Ieia375lWa2D2/f+6WqpxWwuvcqMMcImt+wwt3PG9Czr1DC
	 zRuTeLDBJw4xWPUQZnsfbFE0g3vK+zRnvf3meNDiQqvuM6oZDz+NBh6iOH2pwMsMzA
	 2ZGOvWMGamNH7zUBAy2/CduTqPA9Um82jtuXYHP+anpsXgU4rAnGA30LtqMV2M6AJV
	 oUhZ8/+Tml4Cw==
Date: Fri, 05 Sep 2025 02:20:52 +0000
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Preindl <preindl@protonmail.com>
Cc: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
Subject: Re: [BUG] igc: ASPM causes I226-V NIC to drop after idle
Message-ID: <odmZKRDZji6TR3elLw5LCOtSjE9Rz3-lHt0d3MZyoGurOniENhlrc7s08W9HN3VgOJG4lSPyAYAnwc4rt5NyZyS0PHO9kCrCjk2GlYxGHDo=@protonmail.com>
In-Reply-To: <re7_7zYnqyVPXjEEGmJepF9vbNV8u8ul2Cspq1ZrUmrc3gXuEgwm9Wi8Jk6kY63HpRYK3hJzyt0N0f-430xyADYxkeyaR3vAb-YVhsE0u6k=@protonmail.com>
References: <re7_7zYnqyVPXjEEGmJepF9vbNV8u8ul2Cspq1ZrUmrc3gXuEgwm9Wi8Jk6kY63HpRYK3hJzyt0N0f-430xyADYxkeyaR3vAb-YVhsE0u6k=@protonmail.com>
Feedback-ID: 18974102:user:proton
X-Pm-Message-ID: c9347241893b4efe84c0169ef4587e7a2f310ea6
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,
I'd like to add the following information/correction.

The issue can be traced to the following error that appears typically after=
 a period of inactivity
igc: Failed to read reg 0xc030!


The kernel parameter=C2=A0pcie_aspm=3Doff does not solve the issue.
I am now testing the parameters=C2=A0pcie_port_pm=3Doff and pcie_aspm.polic=
y=3Dperformance that mitigates the above error for some users.

This issue seems to be more common with Asus motherboards and may be reprod=
ucible with Intel I225-V NICs, see also
https://bbs.archlinux.org/viewtopic.php?id=3D288371https://forum.proxmox.co=
m/threads/network-card-drop-igc-0000-09-00-0-eno1-pcie-link-lost.121295/
https://www.reddit.com/r/buildapc/comments/xypn1m/network_card_intel_ethern=
et_controller_i225v_igc/
On Monday, September 1st, 2025 at 4:45 PM, Preindl <preindl@protonmail.com>=
 wrote:


> Hello,
>=20
> I am seeing an issue with the Intel I226-V Ethernet controller on an ASUS=
 ProArt X870E motherboard. When PCIe Active State Power Management (ASPM) i=
s enabled, the NIC becomes unavailable after a period of inactivity. Disabl=
ing ASPM avoids the problem.
>=20
> This looks like a hardware/firmware issue, but since it is easily reprodu=
cible (there are several forum discussions), it may warrant a kernel quirk =
in the igc driver to disable ASPM for this firmware (or device?).
>=20
> ---
>=20
> Hardware:
> - Motherboard: ASUS ProArt X870E
> - NIC: Intel I226-V [8086:125c] (rev 06)
> - Subsystem: [1043:8867]
> - Firmware version (from ethtool -i): 2023:889d
>=20
> Software:
> - OS: Debian GNU/Linux 13 (trixie)
> - Kernel: Linux 6.12.41+deb13-amd64
> - Driver: igc
>=20
> ---
>=20
> Steps to reproduce (logs attached)
> 1. Boot system with default PCIe ASPM enabled.
> 2. Leave the box/NIC idle for some time.
> 3. NIC disappears (reappears after reboot)
>=20
> Workaround:
> - Booting with pcie_aspm=3Doff (or disabling ASPM in BIOS) keeps the NIC =
stable.
>=20
> Expected:
> - NIC should remain functional with ASPM enabled.
>=20
> Actual:
> - NIC crashes at/after idle when ASPM is enabled.
>=20
> ---
>=20
> Please let me know if additional information or testing would help.



