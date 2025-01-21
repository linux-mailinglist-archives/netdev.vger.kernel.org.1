Return-Path: <netdev+bounces-159926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F24A1765A
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 04:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2CB67A3D6C
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 03:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C540187848;
	Tue, 21 Jan 2025 03:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="FenAsFdY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBC38F58
	for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 03:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737430859; cv=none; b=Taa24HkuwZ1s+YtyLE34un2dpZBlKysdgmstIxaUkwdDpw3HE7YimXXy30VwlkpX4sC6GtkYUx1stTBHxyrUZW3JyXQm3NTy9pBFYdgI1Psa0B0tjSdrbWGkTzzYUiNcs7F7SnFVH/ub4emRGaCIClorlq1CY6HFDkJLSbowGM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737430859; c=relaxed/simple;
	bh=wF7YGurUs25CSpdYjAVHjRF0Z5PxpYeTzK4lQ1fz2KI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ljBwqvnAh/To7DlpVut2zmyZJ4eUXBuqk70vuytNvRnq2owkoa3J3U8PPidb1ahgLF9VtOOj8BqB2yHC+mozeAqN7quTZuFY+dPjgXV5EdQ0F68fcpvNiJMdRAzaW6Ow2hFPEKd+J/TLdCyh98jFCSl31YhXJsLAC5FFc3z2wHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=FenAsFdY; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2f42992f608so7081639a91.0
        for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 19:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1737430855; x=1738035655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QkMtHsJDx+Wl3Tgdu/WbRMQpKlTovGhv9BAws4wG5Z4=;
        b=FenAsFdYOtTZgK29hIhqio5k81d2pIYFDRcvdDa2/LIlcL2M36ZOLKszFvidumrodS
         4FpGGYr8m2qMMn+tq5gOxjN/QE5pXWBb66385yz21QLTfXkI+jYhceOh5zwRcRNvKE38
         c5wQckSwImuiKwzWChq5HYHPnmYiIhrLFIg/U7KLkREVBOMppUnVK/a+d2adqgrPBVRr
         IyJcWH4CwFy6H4JYcPV5cPbpfj8TihQIaZPlqLcRXaPTy6Y/VDDhhgzyU8Jtf+AfIcI7
         GGbZgndhMyJr7Q8VCgLKhMGZwhaGYebchFmHIqA0iY1uVH3utBmmzu6awsXr43SXrjkB
         ADug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737430855; x=1738035655;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QkMtHsJDx+Wl3Tgdu/WbRMQpKlTovGhv9BAws4wG5Z4=;
        b=t/0bCq5HBuMcq85fZC3u+LrWfhh3EMod10zf2RHarGhUG6/Toy1YEgPxlb1qiDI8pB
         6Fn9yawCd4d0TB3eHsAR1UVIsPM4s1+sL2vKkYDOvOe/n7zVcw6t4GmyvkTUA3oK+5B4
         yr4J3NwVp5GgWc8ykLMWCzs4orclPEGeBJ2ipyPYhYwUKnjrCrfM3FRf/0XAUFkmEjP/
         ejSJu+4BCRo5UJ2apgk8IbMdjr3ux89+dPGkedL8u28vVjiSoG4wANKMdRVsQsS+lASJ
         WYPTaW5UC2LtWHA9hQfilARKz752s4jOTwpA1f7BdbY19+o2mpSQ5OdGD6TaUFAyQw3O
         Sx3g==
X-Gm-Message-State: AOJu0YzA3skB4X3KBUXetIIdX9XW5Phdp+9JV7BMOEjf3mA8hd0YxbpO
	VJQJwKzdniLUR8B2ZCdZlnqAFu6HbZP2NdUJog3FltQlgikDjFdQ1RkHy+3T+vIjg0eC0TZkuhS
	3
X-Gm-Gg: ASbGncvZSVCQQB9N8AMH8XPnNzitibEBwMHLANXzRfslk6oKwErBHom3sNYgHj/8/uQ
	AL5p7foYgA2UrFBTOAtxex1BNpK4QmgyDcAO3/AfSNlqcU329qvLgNR7l/oeTIMsTJvaLgA+Fh+
	CsvFHSVJK9Msh5rHcX0pOBGb/ThmOaofszst07IJncfrdTMMRp+5i3z2wCFR0oI6nREM01D8YeN
	DXHqNfepmqXKmmYlktCV4EjlK6W0mE2YBGBHg8rALSUW98aoLrA5LCNF8/iMMcIT/9QqJlhmsjR
	IMj0EJC+qrlbKExWt0yYA0f7JtUKnzPWAi1eyyNDrd4MccM=
X-Google-Smtp-Source: AGHT+IGs762hX4ez/VuWwtSeQT835lGaxlPEETqDj/hIHAoVgIUqnu9T+/gEerc56xGAiFI2xdobMg==
X-Received: by 2002:aa7:9a83:0:b0:725:e325:ab3a with SMTP id d2e1a72fcca58-72daf97a541mr22452460b3a.14.1737430855175;
        Mon, 20 Jan 2025 19:40:55 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab9c94d0sm7915928b3a.116.2025.01.20.19.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 19:40:54 -0800 (PST)
Date: Mon, 20 Jan 2025 19:40:53 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] iproute2 6.13 release
Message-ID: <20250120194053.3744d96b@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

This is regular release of iproute2 corresponding to the 6.13 kernel.
Lots of little stuff, no big changes here.
Happy new year.

Download:
    https://www.kernel.org/pub/linux/utils/net/iproute2/iproute2-6.13.0.tar=
.gz

Repository for current release
    https://github.com/shemminger/iproute2.git
    git://git.kernel.org/pub/scm/network/iproute2/iproute2.git

And future release (net-next):
    git://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git

Contributions for this release:

Alexis Lothor=C3=A9 (1):
      man: fix two small typos on xdp manipulations

Chiara Meiohas (5):
      rdma: Add support for rdma monitor
      rdma: Expose whether RDMA monitoring is supported
      rdma: Fix typo in rdma-link man page
      rdma: update uapi headers
      rdma: Add IB device and net device rename events

Choong Yong Liang (1):
      tc: Add support for Hold/Release mechanism in TSN as per IEEE 802.1Q-=
2018

Cindy Lu (1):
      vdpa: Add support for setting the MAC address in vDPA tool.

David Lamparter (2):
      lib: utils: move over `print_num` from ip/
      rt_names: read `rt_addrprotos.d` directory

Denis Kirjanov (1):
      lib: utils: close file handle on error

Fabian Pfitzner (1):
      bridge: dump mcast querier state

Ido Schimmel (2):
      man: Add ip-rule(8) as generation target
      iprule: Add DSCP support

Jiri Pirko (1):
      devlink: do dry parse for extended handle with selector

Minhong He (3):
      ip: fix memory leak in do_show()
      devlink: fix memory leak in ifname_map_rtnl_init()
      bridge: fix memory leak in error path

Neil Svedberg (1):
      iproute2: Fix grammar in duplicate argument error message

Nikolay Aleksandrov (1):
      bridge: add ip/iplink_bridge files to MAINTAINERS

Saeed Mahameed (1):
      devlink: use the correct handle flag for port param show

Stephen Hemminger (9):
      uapi: update headers to 6.13-rc1
      libnetlink: add missing endian.h
      rdma: add missing header for basename
      ip: rearrange and prune header files
      cg_map: use limits.h
      flower: replace XATTR_SIZE_MAX
      uapi: remove no longer used linux/limits.h
      uapi: update kernel headers
      v6.13.0

Vincent Mailhol (7):
      iplink_can: remove unused FILE *f parameter in three functions
      iplink_can: reduce the visibility of tdc in can_parse_opt()
      iplink_can: remove newline at the end of invarg()'s messages
      iplink_can: use invarg() instead of fprintf()
      iplink_can: add struct can_tdc
      iplink_can: rename dbt into fd_dbt in can_parse_opt()
      add .editorconfig file for basic formatting

Yedaya Katsman (1):
      ip: Add "down" filter for "ip addr/link show"


