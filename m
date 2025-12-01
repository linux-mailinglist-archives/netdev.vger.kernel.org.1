Return-Path: <netdev+bounces-243033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 06807C98789
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 18:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A3A07344A45
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 17:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40821D2F42;
	Mon,  1 Dec 2025 17:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="TfE27fxs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C454F35975
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 17:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764609465; cv=none; b=WK1otchJAdshyhc22Bv5XSChjL3/We9uNjUjbQRfIOdQwCmIPkowX4tpfMst4dXahxfb8O+6RyiOoQz4EmV9kSjAPRROge2qMhuJXnR6OTTdDQe5wCT40vlY0EFe/0oKCPuzl0XVsA0av/R3g/2ZN53pC9S1jFH+Bi2+l/YVSC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764609465; c=relaxed/simple;
	bh=FSRGo57moHALBKhfEJ+b6dZN5wpu2x5I3GpTRODOmlQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=QqfMJXTpezdvsrsKiwZ8Ad/txZTBvMYr39PEmYgicy3k2wKKUFHPZze2qIcKkoxXt55EH/8/tY7Avk1XAkfaDZfqFIaramPt6+cIHoo1Rfk3pW3brZ1cE8loXJwtBGU5/yPdlVlKBiAoYMcb5ikoFEqiD00f/aow54GGx0SGNXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=TfE27fxs; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8b28f983333so421073385a.3
        for <netdev@vger.kernel.org>; Mon, 01 Dec 2025 09:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764609462; x=1765214262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V2uD2RiUz2I4VGKg4Jom7KpKnjuxYXVMpNFqul+So0w=;
        b=TfE27fxsbl42Fq9zT6RM8UaY7Dk7v8MqJeXjNrJ8V/94kbLJC7Glvq73o+FbD4HQb+
         N9tvidrJbnXtu/e303i8XFt8KreCzSGF6kQhDp+gt1ReZib9sIC6UcM/vJDfZbdzvGoe
         r8DxNvDBJHlrOrybHHjrsrNo6gZVLLhxhk8Hs0xb7jcpOwBIyqsjYoHwZRjX7HH4goPC
         YUicKwyEFDGFHEylbtZoLlEUs1KyMYkYF+F4oS0cZhCRk6Zq7BuykIWDN8lBq2hhl2rq
         AMUp55qZVteJL8voHqLHaW3VjxeZaSjGoQRMWdkWQkKCgbsxAX4ta+SEHVaGFFHNTuHP
         93qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764609462; x=1765214262;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V2uD2RiUz2I4VGKg4Jom7KpKnjuxYXVMpNFqul+So0w=;
        b=ZMQI6hvtjW5rjRyBKwUIY+Fw28GdZRf9KzJ611CBTNVyPfprdxl92C0c43yZCLxfz6
         t6URUbvkFw8/48hP/z2FOJj3p1mUUbE9w1556D+1YWKcgSYxjFM+054IAPNimABKWrWD
         +SPr9KZDIshruk9XpXIXGKOnNpjWkQ5yuCxeYqO5bHTUhn90rd0ruZAhCwj8sznoiWz6
         JF2KuNxfOv1v0mTBeiks8vNpQYUccytWw+YRBqHSydfeLXKgFbrQMyYoimZb8NrXfYfO
         Q5ouOespK5v5Qpo4lqpzKPKAd2GYucf5CvVZ7AaRpCoZCE+WQbrxiXPSEdjxzHx9c94B
         4npg==
X-Gm-Message-State: AOJu0Yyvz9M0bb+4TIAyvV6cREnYI893O6VgpDfr8XAwlUxbfoReXU6n
	8CGAgtA+vQmVMnH+DhFVNBw4y5/rbNloOYDGwVNO1EZbLOvePHIQanY6s6x6FBbX8WfQtZA9qtZ
	xmPZm
X-Gm-Gg: ASbGnct9Jy5vwRBhox1ziH8dz5BFty91hLaluRfhTbX8j50pCDa1xvC6viOLKXiNf0l
	ef5a7rdVLJ3MR0MtLo2KxFo31dA0S8xCy6IZ490c8zix6eruSywWZHc+FupQH3b90sdbHnCx3/L
	EoRqayPmfMvGEtKAknJfQtz7rYISphGAqjN4Za9RUw+YcfnAMiSrkjI/Q3Ac3RqkS1gVXJF1UjD
	rQvO4+xTE3aKM9oagBa2LDPw/lx+0PogN1prt2KHsASj4fcap8iLCHQjbepST4GIxHbmLCD2NCV
	r18YCp2S63QI1MRiExVGCC0OBiSiT4+t6MhVzRIwza8VvfntP0W7aFOfvk3NpTt9P0tiMc8eQHI
	6fOQ596WGaQ58MpToUsWxje6AtcehU0H4N/fDcikhxxrsr2eTiwWnEFxR/666WnRtV+w2VBMfT+
	0YXxiKpdc9ngytbh8sHPkOn/Eah+5EL5013HschrcnANTlanq4u+o6
X-Google-Smtp-Source: AGHT+IG8O54+EW6DOK51U8CUPE+UcWw5b3ZHb/UQHYQgR+gb2beJzlctv9Hmyn26Dcr8GE3FpAKSuQ==
X-Received: by 2002:a05:620a:7103:b0:8b1:ac18:acc8 with SMTP id af79cd13be357-8b4ebd4ea76mr3412589485a.26.1764609462334;
        Mon, 01 Dec 2025 09:17:42 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b52a1dabb7sm885911785a.48.2025.12.01.09.17.41
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 09:17:42 -0800 (PST)
Date: Mon, 1 Dec 2025 09:17:38 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Subject: [ANNOUNCE] iproute2 6.18
Message-ID: <20251201091738.3a8b4303@phoenix.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

This is the regular release of iproute2 corresponding to the 6.18 kernel.
The only big new item in this release is the addition of the netshaper
command to control hardware shaping (implemented in Azure). It also includes
support for DualPi2 scheduler and a couple of small changes to bonding.

Download:
    https://www.kernel.org/pub/linux/utils/net/iproute2/iproute2-6.18.0.tar.gz

Repository for current release
    https://github.com/shemminger/iproute2.git
    git://git.kernel.org/pub/scm/network/iproute2/iproute2.git

And future release (net-next):
    git://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git

Contributions:

Andrea Claudi (3):
      tc: gred: fix debug print
      mptcp: add implicit flag to the 'ip mptcp' inline help
      netshaper: fix build failure

Chia-Yu Chang (2):
      Add get_float_min_max() in lib/utils.c
      tc: add dualpi2 scheduler module

David Ahern (2):
      Update kernel headers
      Update kernel headers

Eric Biggers (1):
      man8: ip-sr: Document that passphrase must be high-entropy

Erni Sri Satya Vennela (1):
      netshaper: Add netshaper command

Hangbin Liu (1):
      iplink: bond_slave: add support for actor_port_prio

Ivan Vecera (1):
      devlink: fix devlink flash error reporting

Jay Vosburgh (4):
      lib: Update backend of print_size to accept 64 bit size
      tc: Add get_size64 and get_size64_and_cell
      tc: Expand tc_calc_xmittime, tc_calc_xmitsize to u64
      tc/police: enable use of 64 bit burst parameter

Kory Maincent (1):
      scripts: Add uapi header import script

Petr Machata (1):
      ip: iplink_bridge: Support fdb_local_vlan_0

Stephen Hemminger (8):
      uapi: update headers to 6.18-rc1
      netshaper: update include files
      Revert "mptcp: add implicit flag to the 'ip mptcp' inline help"
      uapi: update to virtio_net.h
      netshaper: remove unused variable
      netshaper: ignore build result
      tuntap: add missing brackets to json output
      v6.18.0

Tonghao Zhang (1):
      ip/bond: add broadcast_neighbor support

Yijing Zeng (1):
      dcb: fix tc-maxrate unit conversions

Yureka (1):
      lib: bridge: avoid redefinition of in6_addr


