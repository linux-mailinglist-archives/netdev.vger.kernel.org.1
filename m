Return-Path: <netdev+bounces-278188-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPx3GkJI3WmmbwkAu9opvQ
	(envelope-from <netdev+bounces-278188-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 21:47:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3A53F2E7C
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 21:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C75F3047048
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 19:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59AA03E3160;
	Mon, 13 Apr 2026 19:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="fY9DRUcW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99383B6C03
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 19:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776109505; cv=none; b=a2z6cnEDMDH8gN/OPRVc/BlYl0OhaFhi/7pqmEDQmBY5AulYeyGLjLKYzGkc7EoH+lk5WadNlpMRNy652jHnW0TjlUo9W/4ooQ4tRVr3rMEe+DeWTtlV/L2SQDhyoIz29d8Zg2TjXs3kERzygqQZjPU7U0s36q4jnCo+MvAR+4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776109505; c=relaxed/simple;
	bh=thqndAWuNWDbtzFbujcgttAGQL0lw9yRIBW2NfbdAVg=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=iDglDNM4q5OAfRqJ6Uch/6VRKSYnEq3QfBqsYI6I09TQPYwtv9pr792K9cnBF3+sdzgADgTY2Z+NKTmKyVXWvajEWLake9K+W6Hg+px/+0bn2EbXE29cPAaGKWhdXKKRdxGxTO+hnc4aypJQjzA6bCODq/aHqViRzCL01hoAv0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=fY9DRUcW; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1273349c56bso6415027c88.0
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 12:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776109503; x=1776714303; darn=vger.kernel.org;
        h=mime-version:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=I9iCaOL7axlmjz//qObwCmkSPEx1IzA+Pab/RGQqX6s=;
        b=fY9DRUcWHUI/nvel7XfJE3vNT58o3Lyb2APLKOHNUrmH4zHCwAJCIaWgrYNEqLrCMp
         eBWcM+soOtdcc0yVwme4qPjElTWjgtPByPfUGAkojs6s13GYh2ur1odPSi4NnDhL+ESg
         mWFG+R0aEaujxmfoFWyHO7pf3DGuYa89GX7HvsDxdsdoPlvnbhMPY7wCCHWO3nRAwmF2
         LlE//m8w63yA+aRIiDQsuBWwJJIlcQ9YR9MB4HZtW+6ak/3FO4Ih77SP1bgBXPG0p+u1
         0MGzJ194+9yEzwanEVWPb+K7/TkrJ+SlEnp4SVheI6iN6q4bTvqxVCrAua7QgXSnNVUm
         BLIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776109503; x=1776714303;
        h=mime-version:message-id:subject:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I9iCaOL7axlmjz//qObwCmkSPEx1IzA+Pab/RGQqX6s=;
        b=bXAMFwJlGU/zKW6F69u/vTFP/aLt2YCeFrsh88TLWdo1oy00ZwxcunhMfA0+uKflZU
         FimLHA3bwq9drI52l1F9+HVtQ4EKN44lLjrdVdao9wGijsF0MMw1sJmEgg+fYSjtZKlb
         z/Ug/SJR6iSiOctqOSYbbwQY9/76jTGQp69OGS3sq83d1f3QKX5GJkm6pftpYLIoYwrk
         81az2wVM1Cj14g71Et/fQimrxaN6Nhp3110f+T1Cn3IFpFWz97rZMfyim9jBnRxXd1dk
         w2Z/hl7gx8EmDrjN1+MDuL75VBSD7C5CJCy98g3H++E2BM2/WkB9tEvZ6e5Y7SuQDOVx
         BISg==
X-Gm-Message-State: AOJu0Yyj5xiAB7BK8cE9Vt6UrHh4Gffa8BF5P5T+3o/+eCIN2KpC3K9o
	As80CvBURJ595olLFMx20V2Y0sFSFj3XKmG9Wl6ndRrloLp35hm/ZvCDlh89VZdjKr/lfj2c8YX
	2aZFq
X-Gm-Gg: AeBDieugYPKNR5oDo205Jh0hQY1RPxSxlfLVEz+GIqX+2Y4LDSz8OGAt5f2/L/pcY5F
	sT4W6pAA70JkUpWoZZN9mtsdJtx5g6ObsNPT5PetWviUrL+GR21jgD3S8zpKxPf4Wms/mtyIWha
	gN2YdKg0blIdg0utvc0bspGoU2ndCQGIoOzTr77p2AdgnHBCj1hOjhfI6OxOzdLVxd5KelviGz3
	m/Ch1arYTyf78klPwyIiq9KIetzq7GCN320VgnPI8kUHEti85H/swx6ZtM+WtGUNERN7+cV9NUR
	k6wIeXhDWQ9jYSWfaUyHDHRkWG6ShjDw2a3AD74da7vkzrGimhvQ0XpyNwJQQSiVdeDIbD1Cz9k
	Uv1NvMltqSrbnomfiuMhe98O8W+sYAygWR910aGrFMrDONW/kZp8z08cZ5YNFhjyoeOt0XcGN46
	SBF1kA7is4bDlxbMRP0iOZy30MhZ8kpVzEZgQQ6J9F63vPQQ==
X-Received: by 2002:a05:693c:3007:b0:2da:a813:a60c with SMTP id 5a478bee46e88-2daa813a7b8mr1120117eec.20.1776109502464;
        Mon, 13 Apr 2026 12:45:02 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d55faa571csm21145406eec.10.2026.04.13.12.45.01
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 12:45:02 -0700 (PDT)
Date: Mon, 13 Apr 2026 12:44:59 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Subject: [ANNOUNCE] iproute2 7.0 release
Message-ID: <20260413124459.1d6f40dd@phoenix.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/3O.dSbIBj8=mSZIhMuoiGhy"
X-Spamd-Result: default: False [-0.16 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	HAS_ATTACHMENT(0.00)[];
	TAGGED_FROM(0.00)[bounces-278188-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,phoenix.local:mid]
X-Rspamd-Queue-Id: AF3A53F2E7C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--MP_/3O.dSbIBj8=mSZIhMuoiGhy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This is the regular release of iproute2 corresponding to the 7.0 kernel.

The main addition is `cake_mq` support for tc-cake, enabling CAKE on
multiqueue devices. The `dpll` command gained mode setting and
fractional frequency offset display in parts-per-trillion.

Devlink now supports displaying and resetting parameters to defaults.

The `ss` tool saw several cleanups: trailing whitespace in non-TTY
output, suppressed netlink errors for unsupported protocols, and
proper command name escaping.

The JSON writer gained control characterescaping.

Eric Biggers replaced the AF_ALG SHA-1 in legacy BPF with a
userspace implementation.

Chen Linxuan eliminated redundant mounts in
`ip netns`, and leftover `/usr/lib/route2` references were removed.

Matthieu Baerts added interface name display and colored output to
MPTCP monitor.

A large batch of man page fixes addressed grammar and
style across `dcb`, `devlink`, `netshaper`, `tipc`, `vdpa`, `rdma`,
and `ss`.

Download:
    https://www.kernel.org/pub/linux/utils/net/iproute2/iproute2-7.0.0.tar.gz

Repository for current release:
    https://github.com/shemminger/iproute2.git
    git://git.kernel.org/pub/scm/network/iproute2/iproute2.git

And future release (net-next):
    git://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git



--MP_/3O.dSbIBj8=mSZIhMuoiGhy
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename=changes-iproute2-7.0.0.txt

Andrea Claudi (1):
      dpll: Fix missing notifications in monitor mode

Chen Linxuan (1):
      ip/netns: avoid redundant mounts

Daniel Schulte (1):
      ss: Remove trailing whitespace when output is not a TTY

Daniel Zahka (2):
      devlink: Pull the value printing logic out of pr_out_param_value()
      devlink: support displaying and resetting to default params

David Ahern (2):
      Update kernel headers
      Update kernel headers

Eric Biggers (1):
      lib/bpf_legacy: Use userspace SHA-1 code instead of AF_ALG

Ivan Vecera (1):
      dpll: add support for fractional frequency offset in ppt

Jonas K=C3=B6ppeler (1):
      tc: cake: add cake_mq support

Matthieu Baerts (NGI0) (2):
      mptcp: monitor: also show iface name
      mptcp: display addr & ifname in color

Petr Oros (2):
      dpll: add mode setting support
      dpll: fix pin id-get type filter parsing

Sergei Trofimovich (1):
      include/json_print.h: add includes for `__u32` and `timeval` declarat=
ions

Stephen Hemminger (17):
      uapi: update mptcp and rdma headers
      utils: do not be restrictive about alternate network device names
      dcb: fix grammar and style issues in man pages
      devlink: fix grammar and style issues in man pages
      fix grammar and style issues in man pages for stat related pages
      netshaper: fix grammar and style issues in man page
      tipc: fix grammar and style issues in man pages
      vdpa: fix grammar, titles, and formatting in man pages
      rdma: fix grammar, formatting, and style in man pages
      ss: fix grammar, articles, and phrasing in man page
      uapi: headers update from 7.0-rc0
      ss: suppress netlink errors for unsupported protocols
      remove leftover references to /usr/lib/route2
      ss: escape characters in command name
      json_writer: support control character escaping
      json_writer: fix builtin test code
      vv7.0.0

Toke H=C3=B8iland-J=C3=B8rgensen (1):
      man: Add cake_mq documentation to the tc-cake man page

Vincent Mailhol (7):
      iplink_can: print_usage: fix the text indentation
      iplink_can: print_usage: change unit for minimum time quanta to mtq
      iplink_can: print_usage: describe the CAN bittiming units
      iplink_can: add RESTRICTED operation mode support
      iplink_can: add initial CAN XL support
      iplink_can: add CAN XL transceiver mode setting (TMS) support
      iplink_can: add CAN XL TMS PWM configuration support


--MP_/3O.dSbIBj8=mSZIhMuoiGhy--

