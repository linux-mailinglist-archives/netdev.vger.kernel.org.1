Return-Path: <netdev+bounces-111897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 517F4934023
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 18:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BFA22835C4
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 16:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE5E17E914;
	Wed, 17 Jul 2024 16:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="tkI1eoqo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6E61EA8F
	for <netdev@vger.kernel.org>; Wed, 17 Jul 2024 16:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721232366; cv=none; b=SG0skWPb4lNv1J3mUf288vpesWT86nJYxtpYjFPqdez0IMbAfInucFvtosTT9osCvSweMj/sawXVLLA0iO+TfA0kYoksMlwq8myuAYCOk8V5uxw8aWvjTqlqAYVtVdvnF+Pl57LVTYAc6I8oVzko2AxVboZ1tY/0mg7go6IuoN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721232366; c=relaxed/simple;
	bh=5WNVAqNMFxM/zy4rkculYcl8ohjxqtfGGOqIQd0dr6w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=D+DfbdIO2qbtXTAAQT7P4JTsqxcmzL5IT1y/NrN/uTUMeZe69902B0xIz+52OIcqsrJot3Dlhw/195YF7oNNKJxN9x4zVmd6rvMUxZICbN/CzW0TCkBH1b/6q4wv2qmJdaw6irdGnD0op5tnC6gjdNaoABQx/oaljEcite6LEzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=tkI1eoqo; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fc569440e1so3725935ad.3
        for <netdev@vger.kernel.org>; Wed, 17 Jul 2024 09:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1721232363; x=1721837163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vU/1F6PCjN5SAnAX7DJSp4+AmuY2sHdq1Zhto+CAjnw=;
        b=tkI1eoqoUr9CowjQosBwHwOaYF8Vt87Wv7u4LxUS5UCEQ9RISFzzyM482opaWsZ8Bs
         498vzItQHMsbNhLemIcqkX7x/1YFxZPqLGUOxAaLzOV+fobAX09lEM0r5k0gXANaeJcq
         k2DyejOjiBPPicNYIuCfTHih6dK5QfDJ0HwdZQhEeyk+0psOZjLM9N3SJmYGJyu5Rb7S
         Bcrvh5/D4xaUGPYQq5vGyaDxdTtjC9POl3MCXLJGR+whtFnP+lilSJDM/dM/5+pdEG5+
         ZytuvauiEdq7B7UmgHOohCkA9qRBXEmEnsrQFExWsE1dojM6r3TEdlMiolZMs1L10Q7Q
         uyDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721232363; x=1721837163;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vU/1F6PCjN5SAnAX7DJSp4+AmuY2sHdq1Zhto+CAjnw=;
        b=g0kSL5DvrbGdBbdQoEOf4tSKjL5XVYS6L88ViTGF4ZZvG66wtrfc1GjvHM8IcvJfC6
         soszeJiXZ2C6cl44u/U1lJjHmsXoZD4aJ1FI7fMjng0WSYGbZpKaW6A9wuVEnhpo75KU
         ORyGmbZZGgUlDVUM2bhlFThM4gW2wc8Wc2YeUbdYqYsjMNJKz29GioggCi3hqZ3YhWan
         NJ/pO1P32D7q0upEsLzrOm3FzRwYH+CpPSGBWEbJLz0+VEGAC/9Kx7wQP3EUkzuZ8bsX
         ZTikEHIfid7SM2Jr5+oR9GS0O++dIyAxx8zofafSxXNRbfJGd/+sLO66bk+6rLBr0D4i
         0L+w==
X-Gm-Message-State: AOJu0Yy4rGwOSsY5dXltulIeis37ki4hbPT4tmujLLDN8/5bf0oBfnNt
	bEKl8CWv3C21GedvVqeSuaAFVNWQQ1eku3PTZ/94qxyyf5XsaWi304Vy3wJDHUy1S87yTWyKeom
	t/ZQ=
X-Google-Smtp-Source: AGHT+IHqYYXB/YOGnwEYHW9FtNt3TvkHTRNKbz9LTCb9Jdm4o5KOLLESyBrbr/WBKQtL7KLH8XXtIQ==
X-Received: by 2002:a17:902:d507:b0:1fc:568d:5ecb with SMTP id d9443c01a7336-1fc568d6554mr9535065ad.55.1721232363491;
        Wed, 17 Jul 2024 09:06:03 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc509d2sm76961025ad.281.2024.07.17.09.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 09:06:03 -0700 (PDT)
Date: Wed, 17 Jul 2024 09:06:01 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: lwn@lwn.net
Subject: [ANNOUNCE] iproute 6.10.0 release
Message-ID: <20240717090601.20b2871f@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

This is regular release of iproute2 corresponding to the 6.10 kernel.
Release is smaller than usual due to less activity in kernel development.

Download:
    https://www.kernel.org/pub/linux/utils/net/iproute2/iproute2-6.10.0.tar.gz

Repository for current release
    https://github.com/shemminger/iproute2.git
    git://git.kernel.org/pub/scm/network/iproute2/iproute2.git

And future release (net-next):
    git://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git

Contributions:

Chiara Meiohas (2):
      rdma: update uapi header
      rdma: Add an option to display driver-specific QPs in the rdma tool

David Ahern (3):
      Update kernel headers
      Update kernel headers
      Update kernel headers

Gabi Falk (1):
      bridge/vlan.c: bridge/vlan.c: fix build with gcc 14 on musl systems

Geliang Tang (1):
      ss: mptcp: print out last time counters

Ismael Luceno (1):
      Fix usage of poll.h header

Lukasz Majewski (1):
      ip link: hsr: Add support for passing information about INTERLINK device

Michal Swiatkowski (1):
      f_flower: implement pfcp opts

Parav Pandit (2):
      devlink: Support setting max_io_eqs
      devlink: Fix setting max_io_eqs as the sole attribute

Petr Machata (4):
      libnetlink: Add rta_getattr_uint()
      ip: ipnexthop: Support dumping next hop group stats
      ip: ipnexthop: Support dumping next hop group HW stats
      ip: ipnexthop: Allow toggling collection of nexthop group HW statistics

Przemek Kitszel (1):
      man: devlink-resource: add missing words in the example

Stephen Hemminger (9):
      tc/u32: remove FILE argument
      tc/util: remove unused argument from print_tm
      tc/util: remove unused argument from print_action_control
      tc/police: remove unused argument to tc_print_police
      tc/util: remove unused argument from print_tcstats2_attr
      uapi: update to pre 6.10-rc1 headers
      ss: fix format string warnings
      route: filter by interface on multipath routes
      v6.10.0

William Tu (1):
      devlink: trivial: fix err format on max_io_eqs

Wojciech Drewek (1):
      ip: PFCP device support

Yedaya Katsman (1):
      rtmon: Align usage with ip help

renmingshuai (1):
      ip: Support filter links with no VF info


